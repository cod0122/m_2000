$PBExportHeader$kuf_certif.sru
forward
global type kuf_certif from kuf_parent
end type
end forward

global type kuf_certif from kuf_parent
end type
global kuf_certif kuf_certif

type variables
//
private kds_certif_stampa kids_certif_stampa
public st_tab_certif kist_tab_certif
//public boolean ki_flag_ristampa = false
public boolean ki_flag_stampa_di_test = true
public string ki_stampante[2] 
end variables
forward prototypes
public subroutine if_isnull (ref st_tab_certif kst_tab_certif)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_certif kst_tab_certif)
public function st_esito leggi (integer k_tipo, ref st_tab_certif kst_tab_certif)
public function st_esito tb_delete_x_rif (st_tab_certif kst_tab_certif)
public function st_esito tb_aggiorna (st_tab_certif kst_tab_certif)
public function st_esito tb_add (st_tab_certif kst_tab_certif)
public function st_esito consenti_modifica (st_tab_certif kst_tab_certif)
public function st_esito crea_certif (ref st_tab_certif kst_tab_certif)
public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_armo kst_tab_armo)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_certif kst_tab_certif)
public function st_esito get_num_certif (ref st_tab_certif kst_tab_certif)
public function st_esito get_ultimo_doc_ins (ref st_tab_certif kst_tab_certif)
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function st_esito aggiorna_dati_stampa (ref st_tab_certif kst_tab_certif)
public function boolean get_form_di_stampa (ref st_tab_certif kst_tab_certif) throws uo_exception
public function boolean stampa (ref st_tab_certif ast_tab_certif[]) throws uo_exception
public function boolean set_id_docprod (st_tab_certif kst_tab_certif) throws uo_exception
public function st_esito get_id (ref st_tab_certif kst_tab_certif)
public function st_esito get_clie (ref st_tab_certif kst_tab_certif)
public function long stampa_esporta_digitale (ref st_docprod_esporta kst_docprod_esporta) throws uo_exception
public function long aggiorna_docprod (ref st_tab_certif kst_tab_certif[]) throws uo_exception
public function boolean if_esiste (readonly st_tab_certif kst_tab_certif) throws uo_exception
public function st_esito get_data (ref st_tab_certif kst_tab_certif)
public function boolean if_crea_certif (st_tab_certif kst_tab_certif) throws uo_exception
private function st_esito stampa_attestato_registra () throws uo_exception
public function boolean get_id_meca (ref st_tab_certif kst_tab_certif) throws uo_exception
public function boolean if_stampato (readonly st_tab_certif kst_tab_certif) throws uo_exception
public function st_esito get_id_da_id_meca (ref st_tab_certif kst_tab_certif)
public function st_esito tb_delete (st_tab_certif kst_tab_certif) throws uo_exception
private function boolean stampa_attestato_prepara (ref datastore kds_attestato) throws uo_exception
private subroutine stampa_attestato_set_img (ref datastore kds_attestato) throws uo_exception
private subroutine stampa_attestato_set_img (ref datawindowchild kds_attestato) throws uo_exception
private function integer stampa_attestato (ref datastore kds_attestato) throws uo_exception
private function boolean stampa_attestato_set_printer () throws uo_exception
end prototypes

public subroutine if_isnull (ref st_tab_certif kst_tab_certif);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_certif.id) then kst_tab_certif.id = 0
if isnull(kst_tab_certif.num_certif) then kst_tab_certif.num_certif = 0
if isnull(kst_tab_certif.data) then kst_tab_certif.data = date(0)
if isnull(kst_tab_certif.id_meca) then kst_tab_certif.id_meca = 0
if isnull(kst_tab_certif.data_stampa) then kst_tab_certif.data_stampa = date(0)
if isnull(kst_tab_certif.lav_data_ini) then	kst_tab_certif.lav_data_ini = date(0)
if isnull(kst_tab_certif.lav_data_fin) then	kst_tab_certif.lav_data_fin = date(0)
if isnull(kst_tab_certif.colli) then kst_tab_certif.colli = 0
if isnull(kst_tab_certif.dose) then kst_tab_certif.dose = 0
if isnull(kst_tab_certif.dose_max) then kst_tab_certif.dose_max = 0
if isnull(kst_tab_certif.dose_min) then kst_tab_certif.dose_min = 0
if isnull(kst_tab_certif.note) then kst_tab_certif.note = " "
if isnull(kst_tab_certif.note_1) then kst_tab_certif.note_1 = " "
if isnull(kst_tab_certif.note_2) then kst_tab_certif.note_2 = " "
if isnull(kst_tab_certif.st_dose_min) then kst_tab_certif.st_dose_min = "N"
if isnull(kst_tab_certif.st_dose_max) then kst_tab_certif.st_dose_max = "N"
if isnull(kst_tab_certif.st_data_ini) then kst_tab_certif.st_data_ini = "N"
if isnull(kst_tab_certif.st_data_fin) then kst_tab_certif.st_data_fin = "N"
if isnull(kst_tab_certif.id_docprod) then kst_tab_certif.id_docprod = 0



end subroutine

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_certif kst_tab_certif);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_tab_certif kst_tab_certif_da
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_anteprima
kst_open_w.id_programma = kkg_id_programma_attestati

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = KKG_ESITO_no_aut

else

	try
		if kst_tab_certif.num_certif > 0 then
	
			get_form_di_stampa(kst_tab_certif)
			if len(trim(kst_tab_certif.form_di_stampa)) > 0 then
				kdw_anteprima.dataobject = trim(kst_tab_certif.form_di_stampa)		
				kst_tab_certif_da.num_certif = kst_tab_certif.num_certif 
			else
				kdw_anteprima.dataobject = "d_certif"		
				kst_tab_certif_da.num_certif = 0
			end if
	
			kdw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_certif_da.num_certif ,  kst_tab_certif.num_certif )
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Attestato da visualizzare: ~n~r" + "nessun numero attestato indicato"
			kst_esito.esito = KKG_ESITO_db_ko
			
		end if
		
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	end try
	
end if


return kst_esito

end function

public function st_esito leggi (integer k_tipo, ref st_tab_certif kst_tab_certif);//
//====================================================================
//=== 
//=== Legge Tabella Certificati
//=== 
//=== 
//--- Input: tipo 1=attestato
//=== Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//====================================================================
//
string k_return = "0 "
st_esito kst_esito



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	choose case k_tipo

//--- x numero certificato			
//--- o x id meca			
		case 1

			SELECT certif.id,   
					certif.num_certif,   
					certif.id_meca,   
					certif.data,   
					certif.data_stampa,   
					certif.clie_2,   
					certif.colli,   
					certif.dose,   
					certif.dose_min,   
					certif.dose_max,   
					certif.lav_data_ini,   
					certif.lav_data_fin,   
					certif.note,   
					certif.note_1,   
					certif.note_2,   
					certif.x_datins,   
					certif.x_utente  
				into
               :kst_tab_certif.id,   
		         :kst_tab_certif.num_certif,   
		         :kst_tab_certif.id_meca,   
		         :kst_tab_certif.data,   
		         :kst_tab_certif.data_stampa,   
		         :kst_tab_certif.clie_2,   
		         :kst_tab_certif.colli,   
		         :kst_tab_certif.dose,   
		         :kst_tab_certif.dose_min,   
		         :kst_tab_certif.dose_max,   
		         :kst_tab_certif.lav_data_ini,   
		         :kst_tab_certif.lav_data_fin,   
		         :kst_tab_certif.note,   
		         :kst_tab_certif.note_1,   
		         :kst_tab_certif.note_2,   
		         :kst_tab_certif.x_datins,   
		         :kst_tab_certif.x_utente  
			 FROM certif  
			 where 
						(:kst_tab_certif.num_certif > 0 
						 and certif.num_certif = :kst_tab_certif.num_certif)					     
						or (:kst_tab_certif.id_meca > 0 
						 and certif.id_meca = :kst_tab_certif.id_meca)
				 using sqlca;
		
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Attestati CERTIF (Numero=" &
								 + string(kst_tab_certif.num_certif) + " " &
								 + "): " + trim(SQLCA.SQLErrText)
											 
				if sqlca.sqlcode = 100 then
					kst_esito.esito = KKG_ESITO_not_fnd
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = KKG_ESITO_db_wrn
					else	
						kst_esito.esito = KKG_ESITO_db_ko
					end if
				end if
			end if

//--- Tipo????
		case else
			kst_esito.esito = KKG_ESITO_blok
			kst_esito.sqlcode = 999
			kst_esito.SQLErrText = &
			    "Tab.Attestati CERTIF tipo ricarca non riconosciuto ("&
			    + string(k_tipo) + ") "

	end choose


return kst_esito


end function

public function st_esito tb_delete_x_rif (st_tab_certif kst_tab_certif);//
//====================================================================
//=== Cancella il rek dalla tabella ATTESTATI
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Vedi standard 
//=== 
//====================================================================
boolean k_autorizza
integer k_sn=0
int k_rek_ok=0
long k_id
st_tab_artr kst_tab_artr
st_esito kst_esito, kst_esito_1
st_open_w kst_open_w
kuf_artr kuf1_artr
kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
kst_open_w.id_programma = kkg_id_programma_attestati

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione Attestato non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = KKG_ESITO_no_aut

else

	select distinct num_certif
	   into :kst_tab_certif.num_certif
		from certif
		where id_meca = :kst_tab_certif.id_meca  
		using sqlca;
		
	if sqlca.sqlcode = 0 then

		delete from certif
			where id_meca = :kst_tab_certif.id_meca  
			using sqlca;
	
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione Attestato (certif) " &
						 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
			if sqlca.sqlcode > 0 then
				kst_esito.esito = KKG_ESITO_db_wrn
			else
				kst_esito.esito = KKG_ESITO_db_ko
			end if
		else
			
			kst_tab_artr.num_certif = kst_tab_certif.num_certif
			kst_tab_artr.data_st = date(0)
			kuf1_artr = create kuf_artr
			kst_tab_artr.st_tab_g_0.esegui_commit = "N"
			kst_esito_1=kuf1_artr.aggiorna_data_stampa_attestato(kst_tab_artr)
			destroy kuf1_artr 
			
			if kst_esito_1.sqlcode < 0 then
				kst_esito = kst_esito_1
			else
				kst_esito.esito = KKG_ESITO_ok
			end if
				
		end if
		
//--- Commit
		if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then
	
			if kst_esito.esito = KKG_ESITO_ok or kst_esito.esito = KKG_ESITO_db_wrn then
				kst_esito = kuf1_data_base.db_commit_1()
			else
				kuf1_data_base.db_rollback_1( )
			end if
			
		end if
		
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Ricerca e Cancellazione Attestato (certif):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = KKG_ESITO_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = KKG_ESITO_db_wrn
			else
				kst_esito.esito = KKG_ESITO_db_ko
			end if
		end if
	end if

end if

return kst_esito

end function

public function st_esito tb_aggiorna (st_tab_certif kst_tab_certif);//
//====================================================================
//=== Aggiorna il rek nella tabella ATTESTATI
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:     Vedi standard 
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	kst_tab_certif.x_datins = kuf1_data_base.prendi_x_datins()
	kst_tab_certif.x_utente = kuf1_data_base.prendi_x_utente()

	update certif  
			  set id_meca = :kst_tab_certif.id_meca
			  ,data = :kst_tab_certif.DATA
			  ,clie_2 = :kst_tab_certif.CLIE_2
			  ,colli = :kst_tab_certif.colli   
			  ,dose = :kst_tab_certif.DOSE
			  ,lav_data_ini = :kst_tab_certif.lav_data_ini   
			  ,lav_data_fin = :kst_tab_certif.lav_data_fin   
			  ,note = :kst_tab_certif.note 
			  ,note_1 = :kst_tab_certif.note_1   
			  ,note_2 = :kst_tab_certif.note_2
			  ,st_dose_min = :kst_tab_certif.st_dose_min
			  ,st_dose_max = :kst_tab_certif.st_dose_max
			  ,st_data_ini = :kst_tab_certif.st_data_ini
			  ,st_data_fin = :kst_tab_certif.st_data_fin
			  ,st_dati_bolla_in = :kst_tab_certif.st_dati_bolla_in
			  ,x_datins = :kst_tab_certif.x_datins
			  ,x_utente = :kst_tab_certif.x_utente
			where id = :kst_tab_certif.id
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Aggiornamento Attestato (kuf_certif.tb_aggiorna):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		else
			kst_esito.esito = kkg_esito.db_ko
		end if

	else
		kst_esito.esito = kkg_esito.ok

	end if


	if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then

		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
			kst_esito = kuf1_data_base.db_commit_1()
		else
			kuf1_data_base.db_rollback_1( )
		end if
		
	end if


return kst_esito

end function

public function st_esito tb_add (st_tab_certif kst_tab_certif);//
//====================================================================
//=== Aggiunge il rek alla tabella ATTESTATI
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:     Vedi standard 
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	kst_tab_certif.x_datins = kuf1_data_base.prendi_x_datins()
	kst_tab_certif.x_utente = kuf1_data_base.prendi_x_utente()

	
	INSERT INTO certif  
			( id   
			  ,num_certif
			  ,data   
			  ,id_meca
			  ,clie_2   
			  ,colli   
			  ,dose
			  ,dose_min   
			  ,dose_max   
			  ,lav_data_ini   
			  ,lav_data_fin   
			  ,note 
			  ,note_1   
			  ,note_2
			  ,st_dose_min
			  ,st_dose_max
			  ,st_data_ini
			  ,st_data_fin
			  ,st_dati_bolla_in
			  ,form_di_stampa
			  ,x_datins
			  ,x_utente
			  )   
	VALUES ( 0   
			  ,:kst_tab_certif.NUM_CERTIF
			  ,:kst_tab_certif.DATA
			  ,:kst_tab_certif.id_meca
			  ,:kst_tab_certif.CLIE_2
			  ,:kst_tab_certif.colli
			  ,:kst_tab_certif.DOSE
			  ,:kst_tab_certif.DOSE_MIN
			  ,:kst_tab_certif.DOSE_MAX
			  ,:kst_tab_certif.lav_data_ini
			  ,:kst_tab_certif.lav_data_fin
			  ,:kst_tab_certif.note
			  ,:kst_tab_certif.note_1
			  ,:kst_tab_certif.note_2 
			  ,:kst_tab_certif.st_dose_min
			  ,:kst_tab_certif.st_dose_max
			  ,:kst_tab_certif.st_data_ini
			  ,:kst_tab_certif.st_data_fin
			  ,:kst_tab_certif.st_dati_bolla_in
			  ,:kst_tab_certif.form_di_stampa
			  ,:kst_tab_certif.x_datins 
			  ,:kst_tab_certif.x_utente
			  )   
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Produzione Nuovo Attestato (kuf_certif.tb_add):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		else
			kst_esito.esito = kkg_esito.db_ko
		end if

	else
		kst_esito.esito = kkg_esito.ok

	end if


	if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then

		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
			kst_esito = kuf1_data_base.db_commit_1()
		else
			kuf1_data_base.db_rollback_1( )
		end if
		
	end if

return kst_esito

end function

public function st_esito consenti_modifica (st_tab_certif kst_tab_certif);//---
//--- Funzione: Richiesta se Attestato e' possibile fare Modifica
//--- 
//--- Argomenti: st_certif   riempire il Numero dell'Attestato
//---
//--- Ritorno: Esito (st_esito)   Vedi standard
//---
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_esito kst_esito //, kst_esito_ARMO
kuf_armo kuf1_armo


try
	
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_armo = create kuf_armo

//--- se attestato gia' trattato e NON stampato allora posso modificarlo
	SELECT    min(meca.err_lav_ok)
	         , min(meca.data_lav_fin)
	         , min(certif.data_stampa)
	         , max(armo.magazzino)
		into
                 :kst_tab_meca.err_lav_ok
               , :kst_tab_meca.data_lav_fin
               , :kst_tab_certif.data_stampa
               , :kst_tab_armo.magazzino
		 FROM ((artr inner join armo on
			           artr.id_armo = armo.id_armo)
						  left outer join certif on
						  artr.num_certif = certif.num_certif)
						  inner join meca on
						  armo.id_meca = meca.id
			 where artr.num_certif = :kst_tab_certif.num_certif 
				 using sqlca;
		
	if sqlca.sqlcode = 0 then
		
		kst_esito.esito = KKG_ESITO_no_aut   // per Default NON autorizzo
		
      	if (kst_tab_certif.data_stampa > kkg_data_zero and not isnull(kst_tab_certif.data_stampa)) then // stampa già fatta!
		else
         	if kst_tab_armo.magazzino <> 1 then  // puo' essere solo diverso da Magazzino 1
             		if kst_tab_meca.err_lav_ok = '0' or isnull(kst_tab_meca.err_lav_ok) then			// Verifica Dosimetrica non effettuata
				else
					if kst_tab_meca.data_lav_fin <= kkg_data_zero or isnull(kst_tab_meca.data_lav_fin) then // Lavorazione NON completata

//--- Controllo se effettivamente non e' chiuso poiche' potrebbero aver messo solo ora i barcode da NON TRATTARE							
						if get_id_meca(kst_tab_certif) then  // piglia ID_MECA
							kst_tab_armo.id_meca = kst_tab_certif.id_meca
							if kuf1_armo.if_lotto_completo( kst_tab_armo ) then // Lotto Chiuso????
								kst_esito.esito = KKG_ESITO_OK   
							end if
						end if
					else
						kst_esito.esito = KKG_ESITO_OK
					end if
				end if
			end if
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Attestati CERTIF (num.attestato=" &
						 + string(kst_tab_certif.num_certif) + " " &
						 + "): " + trim(SQLCA.SQLErrText)
									 
		if sqlca.sqlcode = 100 then
			kst_esito.esito = KKG_ESITO_no_aut
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = KKG_ESITO_db_wrn
			else	
				kst_esito.esito = KKG_ESITO_db_ko
			end if
		end if
	end if

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	if isvalid(kuf1_armo)  then destroy kuf1_armo
	
end try
	

return kst_esito
end function

public function st_esito crea_certif (ref st_tab_certif kst_tab_certif);//
//=== 
//====================================================================
//=== Crea / Aggiorna Attestato di Trattamento
//===
//=== Par. Inut: Numero di certificato
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
string k_return = "0 ", k_rc
int k_ctr, k_ctr1, k_len, k_ctr_note
string K_NOTE_appo[15]
string K_NOTE[100,15] // [righe note; campi note 1-13]
string k_dataoggi
boolean k_trovate_note
st_esito kst_esito, kst1_esito
st_tab_base kst_tab_base
st_tab_meca kst_tab_meca 
st_tab_armo kst_tab_armo
st_tab_certif kst_tab_certif_1
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_sl_pt kst_tab_sl_pt_MIN, kst_tab_sl_pt_MAX
kuf_meca_dosim kuf1_meca_dosim
kuf_sl_pt kuf1_sl_pt


try

//--- inizializza aree
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kst_esito.st_tab_g_0 = kst_tab_certif.st_tab_g_0 

	kuf1_meca_dosim = create kuf_meca_dosim
	kuf1_sl_pt = create kuf_sl_pt
	
//--- conta il numero di Riferimento con lo stesso certificato
	select  meca.id, count(distinct meca.id)
		into :kst_tab_meca.id, :k_ctr
		from artr inner join armo on
			  artr.id_armo = armo.id_armo
					  inner join MECA on
				ARMO.id_meca = MECA.id  
		 where
				ARTR.num_certif = :kst_tab_certif.num_certif 
		group by meca.id
		using sqlca; 

	if sqlca.sqlcode <> 0 then 
		if sqlca.sqlcode = 100 then						 
			kst_esito.esito = kkg_esito.OK
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Attestato non trovato (kuf_certif.crea_certif)~n~r" &
									+ "(" + trim(SQLCA.SQLErrText) + ")"
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura dell'Attestato (kuf_certif.crea_certif)~n~r" &
									+ "(" + trim(SQLCA.SQLErrText) + ")"
		end if					
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- VINCOLO = 1 riferimento 1 certificato
	if k_ctr > 1 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Produzione Attestato non permessa. ~n~r" &
							  +"Attestato presente su piu' Riferimenti.  (kuf_certif.crea_certif)~n~r" &
							  + "(nr." + string(kst_tab_certif.num_certif) + ")"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		

//--- se tutto ok, proseguo
	declare CURS_CERT_1_1 cursor for
			 select  ARTR.NUM_CERTIF,
						MECA.NUM_INT,
						MECA.DATA_INT,
						min(ARTR.DATA_IN),
						max(ARTR.DATA_FIN),
						sum(ARTR.COLLI),
						MECA.ID,
						MECA.NUM_BOLLA_IN,
						MECA.DATA_BOLLA_IN,
						MECA.CLIE_1,
						MECA.CLIE_2,
						MECA.CLIE_3,
						MECA.CONTRATTO, 
					  cert_forza_stampa
				from artr inner join armo on
					  artr.id_armo = armo.id_armo
							  inner join MECA on
						ARMO.id_meca = MECA.id  
				 where
						ARTR.num_certif = :kst_tab_certif.num_certif 
				group by
						ARTR.NUM_CERTIF,
						MECA.NUM_INT,
						MECA.DATA_INT,
						MECA.ID,
						MECA.NUM_BOLLA_IN,
						MECA.DATA_BOLLA_IN,
						MECA.CLIE_1,
						MECA.CLIE_2,
						MECA.CLIE_3,
						MECA.CONTRATTO, 
						cert_forza_stampa
				using sqlca; 
	
//18042016	  left outer join MECA_dosim on
//18042016		ARMO.id_meca = MECA_dosim.id_meca  
//							meca_dosim.dosim_dose,
//						meca_dosim.dosim_dose,

	open CURS_CERT_1_1;
	
	if sqlca.sqlcode <> 0 then 
		if sqlca.sqlcode = 100 then						 
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Attestato non trovato (kuf_certif.crea_certif)~n~r" &
										+ "(" + trim(SQLCA.SQLErrText) + ")"
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura dell'Attestato (kuf_certif.crea_certif)~n~r" &
										+ "(" + trim(SQLCA.SQLErrText) + ")"
		end if					
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- leggo dati caratteristici del certificato
	fetch CURS_CERT_1_1  into :kst_tab_certif.NUM_CERTIF,
												 :kst_tab_meca.NUM_INT,
												 :kst_tab_meca.DATA_INT,
												 :kst_tab_certif.lav_data_ini,
												 :kst_tab_certif.lav_data_fin,
												 :kst_tab_certif.colli,
												 :kst_tab_certif.id_meca,
												 :kst_tab_meca.NUM_BOLLA_IN,
												 :kst_tab_meca.DATA_BOLLA_IN,
												 :kst_tab_meca.CLIE_1,
												 :kst_tab_certif.CLIE_2,
												 :kst_tab_meca.CLIE_3,
												 :kst_tab_meca.CONTRATTO,
												 :kst_tab_meca.cert_forza_stampa;

//												 :kst_tab_meca.st_tab_meca_dosim.dosim_dose,
	
	
	if sqlca.sqlcode <> 0 then						 
				
		if sqlca.sqlcode = 100 then						 
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Attestato non trovato (kuf_certif.crea_certif)~n~r" &
									+ "(" + trim(SQLCA.SQLErrText) + ")"
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura dell'Attestato (kuf_certif.crea_certif)~n~r" &
									+ "(" + trim(SQLCA.SQLErrText) + ")"
		end if					
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
			
//--- controllo +dosi presenti per lo stesso certificato				
	declare crea_certif_amo cursor for
			select distinct armo.dose
					from artr inner join armo on
							  artr.id_armo = armo.id_armo
					where 
							ARTR.num_certif    = :kst_tab_certif.num_certif   
					using sqlca; 
						
	open crea_certif_amo;
	if sqlca.sqlcode <> 0 then						 
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Apertura archivio Atestati-Lotti (Riferimenti)~n~r" &
										+ "(" + trim(SQLCA.SQLErrText) + ")"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if		
	fetch crea_certif_amo into :kst_tab_certif.dose;
	if sqlca.sqlcode = 0 then						 
		if kst_tab_meca.cert_forza_stampa <> '1' then 
			fetch crea_certif_amo into :kst_tab_armo.dose;
//--- situazione ambigua, +dosi presenti, non so quale dose pigliare						
			if sqlca.sqlcode = 0 then						 
				kst_esito.esito = kkg_esito.blok
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = &
					"Attenzione: Attestato nr. " + string(kst_tab_certif.num_certif) &
					+ " contiene Dosi differenti,~n~r" &
					+ "per stamparlo fare la funzione di 'Forza Stampa Attestato'.~n~r" &
					+ "(kuf_certif.crea_certif)~n~r" &
					+ "(" + trim(SQLCA.SQLErrText) + ")"

				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if
	close CURS_CERT_1_1;

	if kst_tab_certif.NUM_CERTIF > 0 then

		declare CURS_CERT_1_2 cursor for
			select   distinct
						armo.id_armo,
						ARMO.NOTE_1,
						ARMO.NOTE_2,
						ARMO.NOTE_3,
						ARMO_NT.NOTE_1,
						ARMO_NT.NOTE_2,
						ARMO_NT.NOTE_3,
						ARMO_NT.NOTE_4,
						ARMO_NT.NOTE_5,
						ARMO_NT.NOTE_6,
						ARMO_NT.NOTE_7,
						ARMO_NT.NOTE_8,
						ARMO_NT.NOTE_9,
						ARMO_NT.NOTE_10
				from artr inner join armo on
					  artr.id_armo = armo.id_armo
							 left outer join armo_nt on
					  armo.id_armo = armo_nt.id_armo
				 where
						ARTR.num_certif    = :kst_tab_certif.num_certif 
				 order by armo.ID_ARMO
				 using kguo_sqlca_db_magazzino;

//--- Inizializza tabella: campi  DI NOTE
		for k_ctr = 1 to UpperBound (K_NOTE, 1)
			for k_ctr1 = 1 to UpperBound (K_NOTE, 2)
				K_NOTE[k_ctr, k_ctr1] = " "
			end for
		end for
	
		open CURS_CERT_1_2;
					
		k_ctr = 1
		fetch CURS_CERT_1_2 into :kst_tab_armo.id_armo,
											 :K_NOTE_appo[1],
											 :K_NOTE_appo[2],
											 :K_NOTE_appo[3],
											 :K_NOTE_appo[4],
											 :K_NOTE_appo[5],
											 :K_NOTE_appo[6],
											 :K_NOTE_appo[7],
											 :K_NOTE_appo[8],
											 :K_NOTE_appo[9],
											 :K_NOTE_appo[10],
											 :K_NOTE_appo[11],
											 :K_NOTE_appo[12],
											 :K_NOTE_appo[13];
	
		do while kguo_sqlca_db_magazzino.sqlcode = 0 and k_ctr < 11
						
//--- valorizza tabella bidimensionale delle NOTE
			k_trovate_note = false
			for k_ctr1 = 1 to UpperBound (K_NOTE_appo)
				if not isnull(K_NOTE_appo[k_ctr1]) then
					k_trovate_note = true
					if k_ctr > 1 then
						if RightTrim(K_NOTE_appo[k_ctr1]) <> K_NOTE[k_ctr - 1, k_ctr1] then
							K_NOTE[k_ctr, k_ctr1] = RightTrim(K_NOTE_appo[k_ctr1])
						else
							K_NOTE[k_ctr, k_ctr1] = " "
						end if
					else
						K_NOTE[k_ctr, k_ctr1] = RightTrim(K_NOTE_appo[k_ctr1])
					end if
				end if
				
			next
			if k_trovate_note then
				k_ctr++
			end if
						
			fetch CURS_CERT_1_2 into :kst_tab_armo.id_armo, 
													 :K_NOTE_appo[1],
													 :K_NOTE_appo[2],
													 :K_NOTE_appo[3],
													 :K_NOTE_appo[4],
													 :K_NOTE_appo[5],
													 :K_NOTE_appo[6],
													 :K_NOTE_appo[7],
													 :K_NOTE_appo[8],
													 :K_NOTE_appo[9],
													 :K_NOTE_appo[10],
													 :K_NOTE_appo[11],
													 :K_NOTE_appo[12],
													 :K_NOTE_appo[13];
	
	
		loop 
		k_ctr_note = k_ctr - 1
					
		close CURS_CERT_1_2;

//--- get del codice PT
		select MAX(armo.cod_sl_pt)
				into :kst_tab_armo.cod_sl_pt
				 from artr inner join armo on
									artr.id_armo = armo.id_armo 
				 where
						ARTR.num_certif    = :kst_tab_certif.num_certif 
				using kguo_sqlca_db_magazzino;	
		if sqlca.sqlcode <> 0 then						 
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = &
				"Errore durante la ricerca del codice PT per l'Attestato nr. " + string(kst_tab_certif.num_certif) &
				+ "~n~r" &
				+ "(" + trim(SQLCA.SQLErrText) + ")"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	
//--- Leggo Dati Contratto Capitolato Fornitura
		if isnull(kst_tab_meca.CONTRATTO) or kst_tab_meca.CONTRATTO = 0 then
			kst_tab_meca.CONTRATTO = 0
		end if
		kst_tab_certif.ST_DOSE_MIN = "N"
		kst_tab_certif.ST_DOSE_MAX = "N"
		kst_tab_certif.ST_DATA_INI = "N"
		kst_tab_certif.ST_DATA_FIN = "N"
		kst_tab_certif.ST_DATI_BOLLA_IN = "N"
		kst_tab_certif.DOSE_MIN = 0.00
		kst_tab_certif.DOSE_MAX = 0.00
	
		if trim(kst_tab_armo.cod_sl_pt) > " " then
			select  distinct
							  sl_pt.CERT_ST_DOSE_MIN
							 ,sl_pt.CERT_ST_DOSE_MAX
							 ,sl_pt.CERT_ST_DATA_INI
							 ,sl_pt.CERT_ST_DATA_FIN
							 into
								:kst_tab_certif.ST_DOSE_MIN 
								,:kst_tab_certif.ST_DOSE_MAX 
								,:kst_tab_certif.ST_DATA_INI 
								,:kst_tab_certif.ST_DATA_FIN 
							from sl_pt
							 where
								sl_pt.cod_sl_pt = :kst_tab_armo.cod_sl_pt 
							using kguo_sqlca_db_magazzino;
		end if
		if kst_tab_meca.CONTRATTO > 0 then
			select  distinct
							 CONTRATTI.CERT_ST_DATI_BOLLA_IN
							 into
								:kst_tab_certif.ST_DATI_BOLLA_IN 
							from CONTRATTI
							 where
								CONTRATTI.CODICE = :kst_tab_meca.CONTRATTO 
							using kguo_sqlca_db_magazzino;
		end if
		if sqlca.sqlcode <> 0 then						 
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = &
				"Errore durante la lettura esposizione dati per l'Attestato nr. " + string(kst_tab_certif.num_certif) &
				+ "~n~r" &
				+ "(" + trim(SQLCA.SQLErrText) + ")"
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	
//							  CONTRATTI.CERT_ST_DOSE_MIN
//							 ,CONTRATTI.CERT_ST_DOSE_MAX
//							 ,CONTRATTI.CERT_ST_DATA_INI
//							 ,CONTRATTI.CERT_ST_DATA_FIN
//								:kst_tab_certif.ST_DOSE_MIN 
//								,:kst_tab_certif.ST_DOSE_MAX 
//								,:kst_tab_certif.ST_DATA_INI 
//								,:kst_tab_certif.ST_DATA_FIN 

//--- Valorizzo i campi note, ogni campo note è max lungo 254 char
		kst_tab_certif.note = ""
		kst_tab_certif.note_1 = ""
		kst_tab_certif.note_2 = ""
		k_len = 0
					 
		for k_ctr = 1 to k_ctr_note  // contatore righe note trovate 
			for k_ctr1 = 1 to UpperBound (K_NOTE, 2)  // contatore note della riga
				if len(trim(k_note[k_ctr, k_ctr1])) > 0 then
					
					k_len = k_len + len(RightTrim (k_note[k_ctr, k_ctr1]))
					if k_len < 248 then
						if len(kst_tab_certif.note) = 0 then 
							kst_tab_certif.note = trim(k_note[k_ctr, k_ctr1])
						else
							kst_tab_certif.note = trim(kst_tab_certif.note) + " " + trim(k_note[k_ctr, k_ctr1])
							k_len += 5
						end if
					else
						if k_len < 450 then
							if len(trim(kst_tab_certif.note_1)) = 0 then 
								kst_tab_certif.note_1 = trim(k_note[k_ctr, k_ctr1])
							else
								kst_tab_certif.note_1 = trim(kst_tab_certif.note_1) + " " +  trim(k_note[k_ctr, k_ctr1])
	//											 trim(kst_tab_certif.note_1) + "  -  " + trim(k_note[k_ctr, k_ctr1])
								k_len += 5
							end if
						else
							if len(trim(kst_tab_certif.note_2)) = 0 then 
								kst_tab_certif.note_2 = trim(k_note[k_ctr, k_ctr1])
							else
								kst_tab_certif.note_2 = trim(kst_tab_certif.note_2) + " " + trim(k_note[k_ctr, k_ctr1])
	//											 trim(kst_tab_certif.note_2) + "  -  " + trim(k_note[k_ctr, k_ctr1])
								k_len += 5
							end if
						end if
					end if
				end if
			end for
		end for
	end if
	if isnull(kst_tab_certif.note) then kst_tab_certif.note = " " 
	if isnull(kst_tab_certif.note_1) then kst_tab_certif.note_1 = " " 
	if isnull(kst_tab_certif.note_2) then kst_tab_certif.note_2 = " " 

//--- Dose MINIMA letta (corretto con eventuale fattore di correlazione)
	kst_tab_sl_pt_MIN.cod_sl_pt = kst_tab_armo.cod_sl_pt
	kuf1_sl_pt.get_dosetgminfattcorr_ifattivo(kst_tab_sl_pt_MIN)    // get fattore correzione
	kst_tab_meca_dosim.id_meca = kst_tab_certif.id_meca
	kuf1_meca_dosim.get_dosim_dose_min(kst_tab_meca_dosim) // get dose minima del lotto
	kst_tab_certif.DOSE_MIN = kst_tab_meca_dosim.dosim_dose * kst_tab_sl_pt_MIN.dosetgminfattcorr 
	kst_tab_certif.DOSE_MIN = Round(kst_tab_certif.DOSE_MIN, 1) // arrotonda a 1 decimale come standard E1
	
//--- Dose MASSIMA letta (corretto con eventuale fattore di correlazione)
	kst_tab_sl_pt_MAX.cod_sl_pt = kst_tab_armo.cod_sl_pt
	kuf1_sl_pt.get_dosetgmaxfattcorr_ifattivo(kst_tab_sl_pt_MAX)  // get fattore correzione
//19-07-2016 su richiesta di REZIO set DOSE MINIMA al posto della MASSIMA se il FATTORE di CORRELAZIONE MAX è > zero!!!!!!!
	kst_tab_meca_dosim.id_meca = kst_tab_certif.id_meca
	if kst_tab_sl_pt_MAX.dosetgmaxfattcorr = 1 or kst_tab_sl_pt_MAX.dosetgmaxfattcorr = 0 then
		kuf1_meca_dosim.get_dosim_dose_max(kst_tab_meca_dosim)  // get dose max del lotto
		kst_tab_certif.DOSE_MAX = kst_tab_meca_dosim.dosim_dose
	else
		kuf1_meca_dosim.get_dosim_dose_min(kst_tab_meca_dosim) // get dose minima del lotto  19-07-2016
		kst_tab_certif.DOSE_MAX = kst_tab_meca_dosim.dosim_dose * kst_tab_sl_pt_MAX.dosetgmaxfattcorr 
	end if
	kst_tab_certif.DOSE_MAX = Round(kst_tab_certif.DOSE_MAX, 1) // arrotonda a 1 decimale come standard E1
										
//--- Acchiappo dose minima e max dal SL-PT se necessario
	if kst_tab_certif.DOSE_MIN > 0 and kst_tab_certif.DOSE_MAX > 0 then
	else
		select MIN(SL_PT.DOSE_MIN), MAX(SL_PT.DOSE_MAX)
				into :kst_tab_sl_pt_MIN.dose, :kst_tab_sl_pt_MAX.dose	
				 from sl_pt
				 where sl_pt .cod_sl_pt = :kst_tab_armo.cod_sl_pt
				using kguo_sqlca_db_magazzino;	

//				 artr 
//				    inner join armo on
//									artr.id_armo = armo.id_armo 
//					  left outer join sl_pt on
//									armo.cod_sl_pt = sl_pt.cod_sl_pt
//				 where
//						ARTR.num_certif    = :kst_tab_certif.num_certif 
////							 into :kst_tab_certif.DOSE_MIN, :kst_tab_certif.DOSE_MAX
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_tab_sl_pt_MIN.DOSE = 0.00
			kst_tab_sl_pt_MAX.DOSE = 0.00
		end if
		if kst_tab_sl_pt_MIN.DOSE > 0 and kst_tab_certif.DOSE_MIN = 0.00 then
			kst_tab_certif.DOSE_MIN = kst_tab_sl_pt_MIN.DOSE 
		end if
		if kst_tab_sl_pt_MAX.DOSE > 0 and kst_tab_certif.DOSE_MAX = 0.00 then
			kst_tab_certif.DOSE_MAX = kst_tab_sl_pt_MAX.DOSE 
		end if
	end if
	
	if kst_tab_certif.num_certif > 0 then

//--- registra la data di stampa in attestato
//				kuf1_base = create kuf_base
//				k_dataoggi = kuf1_base.prendi_dato_base("dataoggi") 
//				if left(k_dataoggi, 1) = "0" then
//					kst_tab_certif.data = date(mid(k_dataoggi, 2))
//				else
//					kst_tab_certif.data = today()
//				end if
//				destroy kuf1_base
//--- Get della data del CERTIFICATO da stampare
		kst_tab_meca_dosim.id_meca = kst_tab_certif.id_meca
		kst_tab_certif.data = kuf1_meca_dosim.get_data_x_certif(kst_tab_meca_dosim)
		if isnull(kst_tab_certif.data) then
			kst_tab_certif.data = kg_dataoggi //se proprio non trova la DATA allora ci mette la data-oggi
		end if

//--- piglia dati da stampare
		select  id
					 ,ST_DOSE_MIN
					 ,ST_DOSE_MAX
					 ,ST_DATA_INI
					 ,ST_DATA_FIN
					 ,DATA
					 ,dose_min
					 ,dose_max
				into 		:kst_tab_certif.id
							,:kst_tab_certif_1.ST_DOSE_MIN 
							,:kst_tab_certif_1.ST_DOSE_MAX 
							,:kst_tab_certif_1.ST_DATA_INI 
							,:kst_tab_certif_1.ST_DATA_FIN 
							,:kst_tab_certif_1.DATA 
							,:kst_tab_certif_1.dose_min
							,:kst_tab_certif_1.dose_max
				from certif
				 where num_certif = :kst_tab_certif.num_certif 
				using sqlca; 

	
		if sqlca.sqlcode = 100 then   // se ATTESTATO non resgitrato lo carica in tabella

//--- Decide quale form dell'Attesto utilizzare (Gold/Silver/...)
			if not kids_certif_stampa.set_attestato(kst_tab_certif) then
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Fallita associazione form di stampa per l'Attestato: "+ string(kst_tab_certif.num_certif) //+ "~n~r"&
				kst_esito.esito = kkg_esito.ko
			end if
			if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then

				kst_tab_certif.form_di_stampa = trim(kids_certif_stampa.dataobject	)
			
//--- INSERT dell'attestato in tabella
				kst_tab_certif.st_tab_g_0.esegui_commit = "S"
				kst_esito = tb_add(kst_tab_certif)
				
			end if
		else
//--- AGGIORNA attestato in tabella
			if sqlca.sqlcode = 0 then 
//--- erano stati modificati i default dei flag nella pre-stampa del certificato?					
				if len(kst_tab_certif_1.ST_DOSE_MIN) > 0 then
					kst_tab_certif.ST_DOSE_MIN = kst_tab_certif_1.ST_DOSE_MIN	
				end if
				if len(kst_tab_certif_1.ST_DOSE_MAX) > 0 then
					kst_tab_certif.ST_DOSE_MAX = kst_tab_certif_1.ST_DOSE_MAX	
				end if
				if len(kst_tab_certif_1.ST_DATA_INI) > 0 then
					kst_tab_certif.ST_DATA_INI = kst_tab_certif_1.ST_DATA_INI	
				end if
				if len(kst_tab_certif_1.ST_DATA_FIN) > 0 then
					kst_tab_certif.ST_DATA_FIN = kst_tab_certif_1.ST_DATA_FIN	
				end if
				kst_tab_certif.dose_min = kst_tab_certif_1.dose_min	
				kst_tab_certif.dose_max = kst_tab_certif_1.dose_max	
//22122015						if isnull(kst_tab_certif_1.DATA) and kst_tab_certif_1.DATA > date(0) then
//							kst_tab_certif.DATA = kst_tab_certif_1.DATA	
//						end if
				kst_tab_certif.st_tab_g_0.esegui_commit = "S"
				kst_esito = tb_aggiorna(kst_tab_certif)
			else
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore in Lettura archivio Attestati (kuf_certif.crea_certif)~n~r" + "(" + trim(SQLCA.SQLErrText) + ")"
			end if
		end if
	end if


catch (uo_exception kuo_exception)
	kst_esito = kguo_exception.get_st_esito( )
	//kuo_exception.messaggio_utente()

finally
//--- scrivo l'errore su file LOG
	if kst_esito.esito <> kkg_esito.ok then
		kuf1_data_base.errori_scrivi_esito("W", kst_esito) 
	end if
	if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim

end try 

return kst_esito


end function

public function st_esito anteprima_elenco (datastore kdw_anteprima, st_tab_armo kst_tab_armo);//
//=== 
//====================================================================
//=== Operazione di Anteprima (elenco CERTIF  x id_meca)
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
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_anteprima
kst_open_w.id_programma = kkg_id_programma_dosimetria

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_not_fnd

else

	if kst_tab_armo.id_meca > 0 then

		kdw_anteprima.dataobject = "d_certif_l_1"		
		kdw_anteprima.settransobject(sqlca)

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_armo.id_meca)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Riga Lotto da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Listview
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_rit
integer k_ctr, k_pictureindex
string k_label, k_oggetto_corrente, k_oggetto_padre
int k_ind
string k_campo[15]
alignment k_align[15]
alignment k_align_1
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_tab_treeview kst_tab_treeview
st_treeview_data_any kst_treeview_data_any
st_profilestring_ini kst_profilestring_ini


	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_corrente = kst_treeview_data.handle
	
	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then
//--- item di ritorno di default
		k_handle_item_corrente = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if
		
//--- prendo il item padre per settare il ritorno di default
	k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
	if k_handle_item_padre > 0 then
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	else
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
	end if
	kst_treeview_data = ktvi_treeviewitem.data  
	k_oggetto_padre = trim(kst_treeview_data.oggetto)

//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 
	klvi_listviewitem.data = kst_treeview_data
	klvi_listviewitem.label = ".."
	klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
	k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
		
	if k_handle_item_corrente > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)

//--- leggo il primo item dalla treeview per esporlo nella list
		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  

		kuf1_treeview.kilv_lv1.DeleteColumns ( )
		
//--- 
		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
		if k_label <> "Attestato" then 

//=== Costruisce e Dimensiona le colonne all'interno della listview
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
			k_ind=1
			k_campo[k_ind] = "Attestato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Riferimento"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "W.O. / S.O."
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Stampato"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Colli/Dose"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Ricev./Cliente"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "CO"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "CF"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Contr.(id)"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Dose min-max; Data inizio-fine trattamento "
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Note"
			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Ulteriori Informazioni"
//			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "FINE"
			k_align[k_ind] = left!
			
			k_ind=1
			do while trim(k_campo[k_ind]) <> "FINE"

				kst_profilestring_ini.operazione = kuf1_data_base.ki_profilestring_operazione_leggi 
				kst_profilestring_ini.file = "treeview"
				kst_profilestring_ini.titolo = "treeview"
				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
				kst_profilestring_ini.valore = "0"
				k_rc = integer(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
 
				if kst_profilestring_ini.esito = "0" then
					k_ctr = integer(kst_profilestring_ini.valore)
				end if
				if k_ctr = 0 then
					k_ctr = (kuf1_treeview.kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
				end if
				kuf1_treeview.kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
				k_ind++
			loop

		end if
//---

		do while k_handle_item > 0

				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data
			kst_treeview_data_any = kst_treeview_data.struttura
			kst_tab_treeview = kst_treeview_data_any.st_tab_treeview

//--- imposto il pic corretto
			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
	
			klvi_listviewitem.label = kst_treeview_data.label
			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.selected = false

			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
			k_ind = 0
			
			kst_tab_treeview.voce =  &
									  string(kst_treeview_data_any.st_tab_certif.num_certif, "##,##0") + " " 
			if kst_treeview_data_any.st_tab_certif.data > date(0) then
				kst_tab_treeview.voce =  trim(kst_tab_treeview.voce) + "  " &
									  + string(kst_treeview_data_any.st_tab_certif.data, "dd.mm.yy") + "  "
			end if
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )


			kst_tab_treeview.voce =  &
										  + string(kst_treeview_data_any.st_tab_meca.num_int, "####0") &
										  + "  " + string(kst_treeview_data_any.st_tab_meca.data_int, "dd.mm.yy") 
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_meca.e1doco > 0 then
				kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.e1doco, "#") + " / "
			else
				kst_tab_treeview.voce = "- / "
			end if
			if kst_treeview_data_any.st_tab_meca.e1rorn > 0 then
				kst_tab_treeview.voce += string(kst_treeview_data_any.st_tab_meca.e1rorn, "#") 
			else
				kst_tab_treeview.voce += "-"
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, kst_tab_treeview.voce)

			if kst_treeview_data_any.st_tab_certif.data_stampa > date(0) then
				kst_tab_treeview.voce = &
									  + string(kst_treeview_data_any.st_tab_certif.data_stampa, "dd.mm.yy") + "  "
			else
				kst_tab_treeview.voce =  "Non stampato"
			end if
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  &
										  string(kst_treeview_data_any.st_tab_certif.colli, "####0") &
										  + " / " + string(kst_treeview_data_any.st_tab_certif.dose, "####0.00")  
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  &
											  + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_11) &
											  + "  (" + string(kst_treeview_data_any.st_tab_certif.clie_2, "####0") &
											  + ")   / " + + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_20) &
											  + "  (" + string(kst_treeview_data_any.st_tab_meca.clie_3, "####0") &
											  + ") " 
//											  + " / " + string(kst_treeview_data_any.st_tab_meca.clie_1, "####0") &
//											  + " " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_10) &
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  trim(kst_treeview_data_any.st_tab_contratti.mc_co) 
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  trim(kst_treeview_data_any.st_tab_contratti.sc_cf) 
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  string(kst_treeview_data_any.st_tab_meca.contratto, "#") 
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_certif.st_dose_min = "S" then
				kst_tab_treeview.voce =  string(kst_treeview_data_any.st_tab_certif.dose_min, "####0.00")  
			else
				kst_tab_treeview.voce = "No"
			end if
			if kst_treeview_data_any.st_tab_certif.st_dose_max = "S" then
				kst_tab_treeview.voce = kst_tab_treeview.voce &
									  + " - " + string(kst_treeview_data_any.st_tab_certif.dose_max, "####0.00")  
			else
				kst_tab_treeview.voce = kst_tab_treeview.voce + " - No " 
			end if
			if kst_treeview_data_any.st_tab_certif.st_data_ini = "S" then
				kst_tab_treeview.voce = kst_tab_treeview.voce &
								+ " / " &
								 + string(kst_treeview_data_any.st_tab_certif.lav_data_ini, "dd.mm.yy")  
			else
				kst_tab_treeview.voce = kst_tab_treeview.voce + " / No " 
			end if
			if kst_treeview_data_any.st_tab_certif.st_data_fin = "S" then
				kst_tab_treeview.voce = kst_tab_treeview.voce &
								 + " - " &
								 + string(kst_treeview_data_any.st_tab_certif.lav_data_fin, "dd.mm.yy")  
			else
				kst_tab_treeview.voce = kst_tab_treeview.voce + " - No " 
			end if
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if len(trim(kst_treeview_data_any.st_tab_certif.note)) > 0 then
				kst_tab_treeview.voce =  &
									  trim(kst_treeview_data_any.st_tab_certif.note) &
									  +" "
			end if
			if len(trim(kst_treeview_data_any.st_tab_certif.note_1)) > 0 then
				kst_tab_treeview.voce =  kst_tab_treeview.voce &
									  + trim(kst_treeview_data_any.st_tab_certif.note_1) &
									  +" "
			end if
			if len(trim(kst_treeview_data_any.st_tab_certif.note_2)) > 0 then
				kst_tab_treeview.voce =  kst_tab_treeview.voce &
									  + trim(kst_treeview_data_any.st_tab_certif.note_2) &
									  +" "
			end if
			k_ind ++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )
				
				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)
			
		loop
		
	end if


	if k_handle_item_rit > 0 then
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto = k_oggetto_padre
		kst_treeview_data.oggetto_listview = k_tipo_oggetto
		ktvi_treeviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		kuf1_treeview.kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
	end if

return k_return

end function

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_pic_list, k_mese, k_anno, k_conta_rec
string k_tipo_oggetto_padre, k_dataoggix, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order
date k_save_data_int, k_data_da, k_data_a, k_data_0
boolean k_da_elaborare = false
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_armo kst_tab_armo
st_tab_contratti kst_tab_contratti
st_tab_certif kst_tab_certif
kuf_base kuf1_base
kuf_certif kuf1_certif




	k_data_0 = date(0)		 

		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
	
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
	end if

	k_data_0 = date(0)
	k_data_a = date(0)
	k_data_da = date(0)
	
//--- Periodo di estrazione, se la data e' a zero allora calcolo in automatico -3 mesi
	kst_treeview_data_any = kst_treeview_data.struttura
	if (kst_treeview_data_any.st_tab_certif.data = date (0) &
	    or isnull(kst_treeview_data_any.st_tab_certif.data)) &
		 then

//--- Ricavo la data da dataoggi e vado indietro per sicurezza di alcuni mesi
		kuf1_base = create kuf_base
		k_dataoggix = mid(kuf1_base.prendi_dato_base("dataoggi"),2)
		destroy kuf1_base
		if isdate(k_dataoggix) then
			k_data_a = date(k_dataoggix)
		else
			k_data_a = today()
		end if
		k_data_da = date(year(relativedate(k_data_da,-90)), month(relativedate(k_data_da,-90)),01)

	else
//--- prelevo il periodo da a 
		k_data_da = kst_treeview_data_any.st_tab_certif.data 
		k_data_a = kst_treeview_data_any.st_tab_certif.data_stampa 
	
	end if
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list 
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)

		k_query_select = &
		"  	SELECT " &
		+ "	      certif.id, " &
		+ "	      certif.num_certif, " &
		+ "	      certif.data, " &
		+ "	      certif.id_meca, " &
		+ "	      certif.data_stampa, " &
		+ "	      certif.lav_data_ini, " &
		+ "	      certif.lav_data_fin, " &
		+ "	      certif.colli, " &
		+ "	      certif.dose, " &
		+ "	      certif.dose_min, " &
		+ "	      certif.dose_max, " &
		+ "	      certif.note, " &
		+ "	      certif.note_1, " &
		+ "	      certif.note_2, " &
		+ "	      certif.dose_max, " &
		+ "		meca.num_int, " &
		+ "		meca.data_int, " &
		+ "         meca.clie_1,  " &
		+ "         certif.clie_2,  " &
		+ "         meca.clie_3,  " &
		+ "		meca.num_bolla_in, " &
		+ "		meca.data_bolla_in, " &
		+ "		meca.contratto, " &
		+ "		contratti.mc_co, " &
		+ "		contratti.sc_cf, " &
		+ "  (select  c1.rag_soc_10 from  clienti c1 where meca.clie_1 = c1.codice) as c1_rag_soc_10, " &
		+ "  (select  c2.rag_soc_10 from  clienti c2 where certif.clie_2 = c2.codice) as c2_rag_soc_10, " &
		+ "  (select  c3.rag_soc_10 from  clienti c3 where meca.clie_3 = c3.codice) as c3_rag_soc_10 " &
		+ "	,meca.e1doco " &
		+ "	,meca.e1rorn " &
		+ "    FROM  (certif " &
		+ "	        INNER JOIN meca ON  " &
		+ "	     certif.id_meca = meca.id) " &
		+ "	        left outer JOIN contratti ON  " &
		+ "	     meca.contratto = contratti.codice " &

		
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.certif_st_dett
				k_query_where = " where " 
				if k_data_da  <> k_data_a then
					k_query_where = k_query_where &
					+ " (certif.data >= ? and certif.data < ?) " &
					+ "  "
				else
					k_query_where = k_query_where &
					+ " (certif.data = ?) " 
				end if
					
			case kuf1_treeview.kist_treeview_oggetto.meca_car_cert_dett
				k_query_where = " where " 
				k_query_where = k_query_where &
				+ " certif.num_certif = ? " 
				
			case else
					k_query_where = " "
	
		end choose
	
			
		k_query_order = &
		+ "	 order by " &
		+ "		 certif.data desc, certif.num_certif desc "

	
//--- Composizione della Query	
		if len(trim(k_query_where)) > 0 then
			declare kc_treeview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using sqlca;
		end if		
		
		choose case k_tipo_oggetto
				
			case kuf1_treeview.kist_treeview_oggetto.certif_st_dett
				if k_data_a  <> k_data_0 then
					open dynamic kc_treeview using :k_data_da, :k_data_a;
				else
					open dynamic kc_treeview using :k_data_da;
				end if
					
			case kuf1_treeview.kist_treeview_oggetto.meca_car_cert_dett
				open dynamic kc_treeview using :kst_treeview_data_any.st_tab_certif.num_certif;
					
			case else
				sqlca.sqlcode = 100
	
		end choose
		
		k_conta_rec=0
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					:kst_tab_certif.id
			      ,:kst_tab_certif.num_certif
			      ,:kst_tab_certif.data
			      ,:kst_tab_certif.id_meca
			      ,:kst_tab_certif.data_stampa
			      ,:kst_tab_certif.lav_data_ini
			      ,:kst_tab_certif.lav_data_fin
			      ,:kst_tab_certif.colli
			      ,:kst_tab_certif.dose
			      ,:kst_tab_certif.dose_min
			      ,:kst_tab_certif.dose_max
			      ,:kst_tab_certif.note
			      ,:kst_tab_certif.note_1
			      ,:kst_tab_certif.note_2
			      ,:kst_tab_certif.dose_max
					,:kst_tab_meca.num_int
					,:kst_tab_meca.data_int
					,:kst_tab_meca.clie_1
					,:kst_tab_certif.clie_2
					,:kst_tab_meca.clie_3
					,:kst_tab_meca.num_bolla_in
					,:kst_tab_meca.data_bolla_in
					,:kst_tab_meca.contratto
					,:kst_tab_contratti.mc_co
					,:kst_tab_contratti.sc_cf
					,:kst_tab_clienti.rag_soc_10 
					,:kst_tab_clienti.rag_soc_11 
					,:kst_tab_clienti.rag_soc_20 
					,:kst_tab_meca.e1doco
					,:kst_tab_meca.e1rorn
					;



			kuf1_certif = create kuf_certif
			
			do while sqlca.sqlcode = 0

//---toglie i NULL dai campi
				kuf1_certif.if_isnull(kst_tab_certif)
				if isnull(kst_tab_meca.contratto) then kst_tab_meca.contratto = 0
				if isnull(kst_tab_contratti.mc_co) then kst_tab_contratti.mc_co = ""
				if isnull(kst_tab_contratti.sc_cf) then kst_tab_contratti.sc_cf = ""
	
				kst_tab_meca.id = kst_tab_certif.id_meca
				kst_tab_armo.id_meca = kst_tab_certif.id_meca
				kst_tab_armo.num_int = kst_tab_meca.num_int
				kst_tab_armo.data_int = kst_tab_meca.data_int
				
				kst_treeview_data_any.st_tab_certif = kst_tab_certif
				kst_treeview_data_any.st_tab_meca = kst_tab_meca
				kst_treeview_data_any.st_tab_armo = kst_tab_armo
				kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
				kst_treeview_data_any.st_tab_contratti = kst_tab_contratti
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
				
//--- dati esposti nell'item	
				kst_treeview_data.label = &
											 string(kst_tab_certif.num_certif, "##,##0") &
										  + "  " + string(kst_tab_certif.data, "dd.mmm") &
										  + "    (" + string(kst_tab_meca.num_int, "####0") &
										  + "/" + string(kst_tab_meca.data_int, "mmm.yy") &
										  + "   " &
										  + string(kst_tab_clienti.rag_soc_11, "@@@@@@@@@@") + ")"


//--- riempo dati tabella dell'item
				kst_treeview_data.struttura = kst_treeview_data_any
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data.handle = k_handle_item_padre
				ktvi_treeviewitem.label = kst_treeview_data.label
				ktvi_treeviewitem.data = kst_treeview_data

//--- Nuovo Item
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)

				kst_treeview_data.pic_list = k_pic_list
				
//--- salvo handle del item appena inserito nella stessa struttura
				kst_treeview_data.handle = k_handle_item

//--- inserisco il handle di questa riga tra i dati del item
				ktvi_treeviewitem.data = kst_treeview_data

				kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)

	
				
				fetch kc_treeview 
				into
					:kst_tab_certif.id
			      ,:kst_tab_certif.num_certif
			      ,:kst_tab_certif.data
			      ,:kst_tab_certif.id_meca
			      ,:kst_tab_certif.data_stampa
			      ,:kst_tab_certif.lav_data_ini
			      ,:kst_tab_certif.lav_data_fin
			      ,:kst_tab_certif.colli
			      ,:kst_tab_certif.dose
			      ,:kst_tab_certif.dose_min
			      ,:kst_tab_certif.dose_max
			      ,:kst_tab_certif.note
			      ,:kst_tab_certif.note_1
			      ,:kst_tab_certif.note_2
			      ,:kst_tab_certif.dose_max
					,:kst_tab_meca.num_int
					,:kst_tab_meca.data_int
					,:kst_tab_meca.clie_1
					,:kst_tab_certif.clie_2
					,:kst_tab_meca.clie_3
					,:kst_tab_meca.num_bolla_in
					,:kst_tab_meca.data_bolla_in
					,:kst_tab_meca.contratto
					,:kst_tab_contratti.mc_co
					,:kst_tab_contratti.sc_cf
					,:kst_tab_clienti.rag_soc_10 
					,:kst_tab_clienti.rag_soc_11 
					,:kst_tab_clienti.rag_soc_20 
					,:kst_tab_meca.e1doco
					,:kst_tab_meca.e1rorn
					;


//--- troppi record lista interrotta
				k_conta_rec++
				if k_conta_rec > 2000 then
//--- dati esposti nell'item	
					kst_treeview_data.label = "Troppi record elenco interrotto "
//--- riempo dati tabella dell'item
					kst_treeview_data.struttura = kst_treeview_data_any
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data.handle = k_handle_item_padre
					ktvi_treeviewitem.label = kst_treeview_data.label
					ktvi_treeviewitem.data = kst_treeview_data
//--- Nuovo Item
					ktvi_treeviewitem.selected = false
					k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
					kst_treeview_data.pic_list = k_pic_list
//--- salvo handle del item appena inserito nella stessa struttura
					kst_treeview_data.handle = k_handle_item
//--- inserisco il handle di questa riga tra i dati del item
					ktvi_treeviewitem.data = kst_treeview_data
					kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
					sqlca.sqlcode = 100 // forza USCITA CICLO
				end if
		
	
			loop
			
			close kc_treeview;

			destroy kuf1_certif

		end if

	end if 
 
return k_return


end function

public function integer u_tree_riempi_treeview_x_mese (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Treeview
//
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0, k_handle_primo=0
long k_totale
integer k_ctr, k_pic_close, k_pic_open, k_pic_list
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
date k_save_data_int
int k_mese, k_anno, k_anno_old
string k_mese_desc [0 to 13]
treeviewitem ktvi_treeviewitem
st_esito kst_esito
st_tab_certif kst_tab_certif
st_tab_treeview kst_tab_treeview
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any



declare kc_treeview cursor for
	SELECT 
         count (*), 
         month(certif.data) as mese,   
         year(certif.data) as anno   
     FROM certif
    WHERE 
			 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.certif_st_mese
			 )
			 and (
			 	 (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.certif_st_mese
				  and certif.data > '01.01.2003'
			    )
			 )
		 group by  3, 2
		 order by  3 desc, 2 desc;

//			    or
//			    (:k_tipo_oggetto_padre = :kuf1_treeview.kist_treeview_oggetto.meca_lav_mese_ok
//			     and dosim_assorb > 0 and (meca.err_lav_ok <> "1" or meca.err_lav_ok is null)
//				)
		 
		 
//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
	
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
	end if
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto_padre)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)
		
			 
		open kc_treeview;
		
		if sqlca.sqlcode = 0 then
			fetch kc_treeview 
				into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
			k_mese_desc[0] = "[Completa]"
			k_mese_desc[1] = "Gennaio"
			k_mese_desc[2] = "Febbraio"
			k_mese_desc[3] = "Marzo"
			k_mese_desc[4] = "Aprile"
			k_mese_desc[5] = "Maggio"
			k_mese_desc[6] = "Giugno"
			k_mese_desc[7] = "Luglio"
			k_mese_desc[8] = "Agosto"
			k_mese_desc[9] = "Settembre"
			k_mese_desc[10] = "Ottobre"
			k_mese_desc[11] = "Novembre"
			k_mese_desc[12] = "Dicembre"
			k_mese_desc[13] = "NON RILEVATO"

			k_totale = 0
			k_anno_old = 0
			
//--- estrazione carichi vera e propria			
			do while sqlca.sqlcode = 0
	
	
//--- a rottura di anno presenta la riga totale a inizio
				if k_anno <> k_anno_old then
			
					if k_totale > 0 then
				
//--- Estrazione del primo Item, quello dei totali
						ktvi_treeviewitem.selected = false
						k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
						kst_treeview_data = ktvi_treeviewitem.data
						kst_treeview_data_any = kst_treeview_data.struttura
						kst_tab_treeview = kst_treeview_data_any.st_tab_treeview

//--- Aggiorno il primo Item con i totali
						kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Attestati presenti"
						k_totale = 0
			
						kst_tab_certif.data = date(k_anno_old,01,01)
						kst_tab_certif.data_stampa = date(k_anno_old+1,01,01)
						
						kst_treeview_data_any.st_tab_certif = kst_tab_certif
						kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
						kst_treeview_data.struttura = kst_treeview_data_any
						ktvi_treeviewitem.data = kst_treeview_data
						
						k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
					end if
					
					k_anno_old = k_anno // memorizzo l'anno x la rottura
					
					kst_treeview_data.label = k_mese_desc[0] &
													  + "  " &
													  + string(k_anno) 
					kst_tab_treeview.voce = kst_treeview_data.label
					kst_tab_treeview.id = "0"
					kst_tab_treeview.descrizione = "  ...conteggio in esecuzione..."
					kst_tab_treeview.descrizione_tipo = "Attestati " 
					kst_treeview_data.pic_list = k_pic_list
					kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
					kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
					kst_treeview_data_any.st_tab_certif = kst_tab_certif
					kst_treeview_data_any.st_tab_certif.data_stampa = date(0)
					kst_treeview_data.struttura = kst_treeview_data_any
					kst_treeview_data.handle = k_handle_item_padre
					ktvi_treeviewitem.label = kst_treeview_data.label
					ktvi_treeviewitem.data = kst_treeview_data
	//--- Nuovo Item
					ktvi_treeviewitem.selected = false
					k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
	//--- salvo handle del item appena inserito nella stessa struttura
					kst_treeview_data.handle = k_handle_item
					k_handle_primo = k_handle_item
	//--- inserisco il handle di questa riga tra i dati del item
					ktvi_treeviewitem.data = kst_treeview_data
					kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
				end if
	
				k_totale = k_totale + kst_treeview_data_any.contati
	
				
				kst_treeview_data.label = &
										  k_mese_desc[k_mese]  &
										  + "  " &
										  + string(k_anno) 
	
				if k_mese = 0 or k_mese > 12 or isnull(k_mese) then
					k_mese = 13
					kst_tab_certif.data = date(k_anno,01,01)
					kst_tab_certif.data_stampa = date(k_anno+1,01,01)
				else			
					kst_tab_certif.data = date(k_anno,k_mese,01)
					k_mese++
					if k_mese > 12 then
						k_mese = 1
						k_anno++
					end if
					kst_tab_certif.data_stampa = date(k_anno, k_mese, 01)
				end if

				kst_tab_treeview.voce = kst_treeview_data.label
				kst_tab_treeview.id = string(k_anno, "0000")  + string(k_mese, "00") 
				if kst_treeview_data_any.contati = 1 then
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Attestato presente"
				else
					kst_tab_treeview.descrizione = string(kst_treeview_data_any.contati, "###,##0") + "  Attestati presenti"
				end if

				kst_tab_treeview.descrizione_tipo = "Attestati " 
				kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data_any.st_tab_certif = kst_tab_certif
				kst_treeview_data.struttura = kst_treeview_data_any

				kst_treeview_data.handle = k_handle_item_padre
	
				ktvi_treeviewitem.label = kst_treeview_data.label
				ktvi_treeviewitem.data = kst_treeview_data
										  
//--- Nuovo Item
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
				
//--- salvo handle del item appena inserito nella stessa struttura
				kst_treeview_data.handle = k_handle_item

//--- inserisco il handle di questa riga tra i dati del item
				ktvi_treeviewitem.data = kst_treeview_data

				kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)

//	
//k_rc = kuf1_treeview.kitv_tv1.CollapseItem ( k_handle_item )			

				fetch kc_treeview 
					into
					  :kst_treeview_data_any.contati
					 ,:k_mese
					 ,:k_anno
					  ;
	
			loop

//--- giro finale per totale anno
			if k_totale > 0 then
		
//--- Estrazione del primo Item, quello dei totali
				ktvi_treeviewitem.selected = false
				k_handle_item = kuf1_treeview.kitv_tv1.getitem(k_handle_primo, ktvi_treeviewitem)
				kst_treeview_data = ktvi_treeviewitem.data
				kst_treeview_data_any = kst_treeview_data.struttura
				kst_tab_treeview = kst_treeview_data_any.st_tab_treeview
//--- Aggiorno il primo Item con i totali
				kst_tab_treeview.descrizione = string(k_totale, "###,###,##0") + "  Attestati presenti"
				k_totale = 0
				kst_treeview_data_any.st_tab_treeview = kst_tab_treeview
				kst_treeview_data.struttura = kst_treeview_data_any
				ktvi_treeviewitem.data = kst_treeview_data
				k_handle_item = kuf1_treeview.kitv_tv1.setitem(k_handle_primo, ktvi_treeviewitem)
			end if
			
			close kc_treeview;
			
		end if

	end if 
 
return k_return


end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_certif kst_tab_certif);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_tab_certif kst_tab_certif_da
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_anteprima
kst_open_w.id_programma = kkg_id_programma_attestati

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = KKG_ESITO_no_aut

else

	try
		
		if kst_tab_certif.num_certif > 0 then
	
			get_form_di_stampa(kst_tab_certif)
			if len(trim(kst_tab_certif.form_di_stampa)) > 0 then
				kdw_anteprima.dataobject = trim(kst_tab_certif.form_di_stampa)		
				kst_tab_certif_da.num_certif = kst_tab_certif.num_certif 
			else
				kdw_anteprima.dataobject = "d_certif"		
				kst_tab_certif_da.num_certif = 0
			end if
	
			kdw_anteprima.settransobject(sqlca)
	
			kdw_anteprima.reset()	
	
//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_certif_da.num_certif,  kst_tab_certif.num_certif )
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Attestato da visualizzare: ~n~r" + "nessun numero attestato indicato"
			kst_esito.esito = KKG_ESITO_db_ko
			
		end if
		
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	end try
	
end if


return kst_esito

end function

public function st_esito get_num_certif (ref st_tab_certif kst_tab_certif);//
//====================================================================
//=== 
//=== Torna il Numero del Certificato da ID_MECA
//=== 
//=== 
//--- Input: st_tab_certif.id_meca
//---
//--- Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//---
//====================================================================
//
string k_return = "0 "
st_esito kst_esito



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


//--- x numero certificato			
	SELECT
				certif.num_certif
				into
		         :kst_tab_certif.num_certif  
			 FROM certif  
			 where 
						(id_meca  = :kst_tab_certif.id_meca)					     
				 using sqlca;
		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Attestati CERTIF (id lotto=" &
						 + string(kst_tab_certif.id_meca) + " " &
						 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
									 
		if sqlca.sqlcode = 100 then
			kst_esito.esito = KKG_ESITO_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = KKG_ESITO_db_wrn
			else	
				kst_esito.esito = KKG_ESITO_db_ko
			end if
		end if
	end if
	

return kst_esito


end function

public function st_esito get_ultimo_doc_ins (ref st_tab_certif kst_tab_certif);//
//====================================================================
//=== Torna l'ultimo ATTESTATO caricato (Numero e Data) della Anagrafica impostata
//=== 
//=== Input : st_tab_certif.clie_2
//=== Out: st_tab_certif.num_certif + data + id
//=== Ritorna: ST_ESITO					
//===   
//====================================================================
st_esito kst_esito


	kst_esito.esito = kkg_esito_ok  
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	select id	
			,num_certif
	        ,data
		into :kst_tab_certif.id
			,:kst_tab_certif.num_certif
			,:kst_tab_certif.data
		from certif  
		where id in 
		(select max(id) from certif 
			where clie_2 = :kst_tab_certif.clie_2 )
		using sqlca;
	
	if sqlca.sqlcode <> 0 then
		kst_tab_certif.num_certif = 0
		kst_tab_certif.id = 0
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito_db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = sqlca.sqlerrtext
		end if
	end if
	
return kst_esito	

end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datawindow su cui è stato attivato il LINK
//===               nome campo di LINK
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return=true
st_tab_certif kst_tab_certif
st_esito kst_esito
uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
//kuf_menu_window kuf1_menu_window
//kuf_web kuf1_web
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "num_certif"
		kst_tab_certif.num_certif = adw_link.getitemnumber(adw_link.getrow(), a_campo_link)
		if kst_tab_certif.num_certif > 0 then
			kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_certif )
			if kst_esito.esito <> kkg_esito_ok then
				kuo_exception = create uo_exception
				kuo_exception.set_esito( kst_esito)
				throw kuo_exception
			end if
			kst_open_w.key1 = "Attestato di Trattamento  (nr.=" + trim(string(kst_tab_certif.num_certif)) + ") " 
		else
			k_return = false
		end if


	case "b_certif_lotto"
		kst_tab_certif.id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
		if kst_tab_certif.id_meca > 0 then
			get_num_certif (kst_tab_certif)   //  piglia il NUMERO CERTIFICATO
			if kst_tab_certif.num_certif > 0 then
				kst_esito = this.anteprima( kdsi_elenco_output, kst_tab_certif )
				if kst_esito.esito <> kkg_esito_ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito)
					throw kuo_exception
				end if
				kst_open_w.key1 = "Attestato di Trattamento  (nr.=" + trim(string(kst_tab_certif.num_certif)) + ") " 
			end if
		else
			k_return = false
		end if

end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita_elenco
		kst_open_w.id_programma = kkg_id_programma_elenco //get_id_programma( kst_open_w.flag_modalita ) //kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_adatta_win = KK_ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kuf1_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
//		kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(kst_open_w)
//		destroy kuf1_menu_window


	else
		
		kuo_exception = create uo_exception
		kuo_exception.setmessage(u_get_errmsg_nontrovato(kst_open_w.flag_modalita))
		throw kuo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public function st_esito aggiorna_dati_stampa (ref st_tab_certif kst_tab_certif);//
//====================================================================
//=== Aggiorna Data di stampa nella tabella ATTESTATI
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   vedi standard 
//===                               
//=== 
//====================================================================
boolean k_autorizza
int k_sn=0
int k_rek_ok=0
long k_id
st_tab_artr kst_tab_artr
st_esito kst_esito, kst_esito_1
st_open_w kst_open_w
kuf_artr kuf1_artr
kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_modifica
kst_open_w.id_programma = kkg_id_programma_attestati

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Aggiornamento Attestato non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = KKG_ESITO_no_aut

else


	kst_tab_certif.x_datins = kuf1_data_base.prendi_x_datins()
	kst_tab_certif.x_utente = kuf1_data_base.prendi_x_utente()



	kst_tab_certif.id = 0
	if kst_tab_certif.num_certif > 0 then
		kst_esito = get_id(kst_tab_certif )   			// recupera il ID dell'attestato
	end if
		
	if kst_esito.esito = kkg_esito_ok and kst_tab_certif.id > 0 then

		if isnull(kst_tab_certif.id_docprod) then kst_tab_certif.id_docprod = 0

		update certif
		   set form_di_stampa =  :kst_tab_certif.form_di_stampa,
			   data_stampa = :kst_tab_certif.data_stampa,
				id_docprod = :kst_tab_certif.id_docprod, 
			    x_datins = :kst_tab_certif.x_datins,
			    x_utente = :kst_tab_certif.x_utente
			where id = :kst_tab_certif.id  
			using sqlca;
	
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Aggiornamento Attestato (certif):" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode > 0 then
				kst_esito.esito = KKG_ESITO_db_wrn
			else
				kst_esito.esito = KKG_ESITO_db_ko
			end if
		else
			
//--- la data su ARTR è meglio quella di emissione		
			get_data(kst_tab_certif)
			kst_tab_artr.num_certif = kst_tab_certif.num_certif
			kst_tab_artr.data_st = kst_tab_certif.data
			kuf1_artr = create kuf_artr
			kst_tab_artr.st_tab_g_0.esegui_commit = "N"
			kst_esito_1=kuf1_artr.aggiorna_data_stampa_attestato(kst_tab_artr)
			destroy kuf1_artr 
			
			if kst_esito_1.sqlcode < 0 then
				kst_esito = kst_esito_1

			else
	
				kst_esito.esito = KKG_ESITO_OK
				
			end if
				
		end if
		
		
//--- Commit
		if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then
	
			if kst_esito.esito = KKG_ESITO_ok or kst_esito.esito = KKG_ESITO_db_wrn or kst_esito.esito = kkg_esito_not_fnd then
				kst_esito = kuf1_data_base.db_commit_1()
			else
				kuf1_data_base.db_rollback_1( )
			end if
			
		end if
		
	end if

end if

return kst_esito

end function

public function boolean get_form_di_stampa (ref st_tab_certif kst_tab_certif) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Legge il nome del Dataobject (datawindow) del certificato ad esempio: "d_certif_stampa_2006"
//--- 
//--- 
//--- Input: st_tab_certif.num_certif
//--- Out: id, data_stampa, form_di_stampa
//---
//--- Ritorna true = ok
//---
//--- Lancia EXCEPTION x errore
//---
//----------------------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



	SELECT
				certif.id
			     ,certif.form_di_stampa   
				 ,data_stampa
				into
		         :kst_tab_certif.id,   
		         :kst_tab_certif.form_di_stampa,  
		         :kst_tab_certif.data_stampa  
			 FROM certif  
			 where num_certif  = :kst_tab_certif.num_certif
				 using sqlca;
		
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Recupero nome Form di stampa Attestato (tab. certif Numero=" + string(kst_tab_certif.num_certif) + " " &
						 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
									 
		kst_esito.esito = KKG_ESITO_db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)		
		throw kguo_exception
		
	end if
	
	if len(trim(kst_tab_certif.form_di_stampa)) > 0 then
	else
		kst_tab_certif.form_di_stampa = ""
	end if
	if isnull(kst_tab_certif.data_stampa) then
		kst_tab_certif.data_stampa = kkg_data_zero
	end if
	
	k_return = true 

return k_return


end function

public function boolean stampa (ref st_tab_certif ast_tab_certif[]) throws uo_exception;//---
//---  Stampa ATTESTATO
//---
boolean k_return=false
int k_item_attestato=0
st_esito kst_esito
boolean k_sicurezza=false
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
//datastore kds_attestato


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kst_open_w = kst_open_w
	kst_open_w.flag_modalita = kkg_flag_modalita_stampa
	kst_open_w.id_programma = kkg_id_programma_attestati
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)

	if not k_sicurezza then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Stampa Attestato non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	
	kist_tab_certif = ast_tab_certif[1]

		
	if kist_tab_certif.num_certif > 0 then		
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Attestato da stampare: ~n~r" + "nessun numero attestato indicato"
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- OK finalmente inizio a lavorare -----------------------------------------------------------------------------

//--- se oggetto dw attestato NON ancora definito	
//	if not isvalid(kds_attestato) then
//		kds_attestato = create datastore
//	end if
	if not isvalid(kids_certif_stampa) then
//--- CREA oggetto stampa-attestato GOLD/SILVER...
		kids_certif_stampa = create kds_certif_stampa 
	end if

	for k_item_attestato = 1 to upperbound(ast_tab_certif[])

		if ast_tab_certif[k_item_attestato].num_certif  > 0 then
			
			kist_tab_certif = ast_tab_certif[k_item_attestato] // attestato sul quale sto lavorando

//--- Decide quale form dell'Attesto utilizzare (Gold/Silver/...) o RISTAMPA
			if not kids_certif_stampa.set_attestato(kist_tab_certif) then
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Fallita associazione form di stampa per l'Attestato: "+ string(kist_tab_certif.num_certif) //+ "~n~r"&
				kst_esito.esito = kkg_esito.ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
		
//			kds_attestato.dataobject = kids_certif_stampa.dataobject			
//			kds_attestato.settransobject(sqlca)
		
			if NOT stampa_attestato_prepara (kids_certif_stampa) then
				
				kguo_exception.inizializza( )
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ko)
				kguo_exception.setmessage("Operazioni di preparzione per 'Stampa Attestato' " + string( kist_tab_certif.num_certif ) + " non riuscite! ")
//				kguo_exception.messaggio_utente( )
				throw kguo_exception
			end if
			
	
			if kids_certif_stampa.rowcount( ) = 0 then
				kguo_exception.inizializza( )
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_not_fnd )
				kguo_exception.setmessage ("Selezionare un documento dall'elenco (" + string(kist_tab_certif.num_certif ) + ") ") 
//					kguo_exception.messaggio_utente("Stampa Attestato non eseguita", "Selezionare un documento dall'elenco (" + string(kist_tab_certif.num_certif ) + 	") ")
				throw kguo_exception
			end if
					

			ki_flag_stampa_di_test = false
			
			stampa_attestato (kids_certif_stampa)  // STAMPA ATTESTATO !!
			
//			if kst_esito.esito <> kkg_esito.ok then
//				k_return = false
//				kguo_exception.inizializza( )
//				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ko)
//				kguo_exception.setmessage ("Si è verificato un errore durante la Stampa dell'Attestato " + string( kist_tab_certif.num_certif ) + 	"~n~r" + trim(kst_esito.sqlerrtext))
////						kguo_exception.messaggio_utente("Stampa Attestato non eseguita", "Si è verificato un errore durante la Stampa dell'Attestato " + string( kist_tab_certif.num_certif ) + 	"~n~r" + trim(kst_esito.sqlerrtext))
//				throw kguo_exception
//				
//			end if
		
		//--- se NON sono in ristampa registro definitivamente l'attestato in archivio 								
			if kids_certif_stampa.ki_flag_ristampa then
				k_return = true
			else

				kst_esito = stampa_attestato_registra ()
				if kst_esito.esito <> kkg_esito.ok then
					k_return = false
					kguo_exception.inizializza( )
					kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ko)
					kguo_exception.setmessage("Operazione di 'Registrazione Attestato'  Fallita! .~n~r" 	+ trim(kst_esito.sqlerrtext))
//								kguo_exception.messaggio_utente( )
					throw kguo_exception
				else
					k_return = true
				end if
				
			end if
		end if
	end for

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_sicurezza) then destroy kuf1_sicurezza 
	
	
end try
		
return k_return		

end function

public function boolean set_id_docprod (st_tab_certif kst_tab_certif) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Imposta a ID del Documento Esportato in Tabella certif
//--- 
//--- 
//--- Inp: st_tab_certif.id  e  id_docprod
//--- Out:        
//--- Ritorna: TRUE = OK
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//---------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito

	

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_certif.id > 0 then

	kst_tab_certif.x_datins = kuf1_data_base.prendi_x_datins()
	kst_tab_certif.x_utente = kuf1_data_base.prendi_x_utente()

	UPDATE certif  
		  SET id_docprod = :kst_tab_certif.id_docprod
			,x_datins = :kst_tab_certif.x_datins
			,x_utente = :kst_tab_certif.x_utente
		WHERE certif.id = :kst_tab_certif.id
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. 'id Documento Esportato' sul Attestato. ~n~r" &
					+ "Id: " + string(kst_tab_certif.id, "####0") + "  " &
					+ " ~n~rErrore-tab.certif:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito_db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito_ok or kst_esito.esito = kkg_esito_db_wrn  then
		if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then
			kuf1_data_base.db_commit_1( )
		end if
	else
		if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then
			kuf1_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. Attestati, Manca Identificativo (id) !" 
	kst_esito.esito = kkg_esito_err_logico
			
end if	

if kst_esito.esito = kkg_esito_err_logico or 	kst_esito.esito = kkg_esito_db_ko then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

k_return = true

return k_return

end function

public function st_esito get_id (ref st_tab_certif kst_tab_certif);//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il ID dal Numero Certificato
//--- 
//--- 
//--- Input: st_tab_certif.num_certif
//--- Out: st_tab_certif.id
//---
//--- Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//---
//----------------------------------------------------------------------------------------------------------------
//
string k_return = "0 "
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


//--- x numero certificato			
	SELECT
				certif.id
			into
		         :kst_tab_certif.id  
			 FROM certif  
			 where 
						(num_certif  = :kst_tab_certif.num_certif)					     
				 using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante Lettura Attestato (certif) numero = " + string(kst_tab_certif.num_certif) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
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
	

return kst_esito


end function

public function st_esito get_clie (ref st_tab_certif kst_tab_certif);//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il Codice Cliente dal ID Certificato
//--- 
//--- 
//--- Input: st_tab_certif.id
//--- Out: st_tab_certif.clie_2
//---
//--- Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//---
//----------------------------------------------------------------------------------------------------------------
//
string k_return = "0 "
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


//--- x numero certificato			
	SELECT
				certif.clie_2
			into
		         :kst_tab_certif.clie_2  
			 FROM certif  
			 where 
						(id  = :kst_tab_certif.id)					     
				 using sqlca;
		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Attestato non Trovato (certif) id = " + string(kst_tab_certif.id) + " " &
						 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
									 
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

public function long stampa_esporta_digitale (ref st_docprod_esporta kst_docprod_esporta) throws uo_exception;//---
//---  Esporta in digitale (pdf) gli ATTESTATI
//---
long k_return=0
int k_n_documenti_stampati=0, k_id_stampa
string k_stampante_pdf="", k_esito=""
int k_item_attestato=0
st_esito kst_esito
boolean k_sicurezza=false
st_tab_certif kst_tab_certif
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
kuf_base kuf1_base
uo_exception kuo1_exception
//datastore kdw_attestato


try
	
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kst_open_w = kst_open_w
	kst_open_w.flag_modalita = kkg_flag_modalita_stampa
	kst_open_w.id_programma = kkg_id_programma_attestati
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)

	if not k_sicurezza then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Emissione Attestato non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = KKG_ESITO_no_aut
		kuo1_exception = create uo_exception
		kuo1_exception.set_esito(kst_esito)
		throw kuo1_exception
	end if
	
	
	kist_tab_certif.id = kst_docprod_esporta.kst_tab_docprod[1].id_doc

		
	if kist_tab_certif.id = 0 or isnull(kist_tab_certif.id) then		

		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Attestato da emettere: ~n~r" + "nessun numero attestato indicato"
		kst_esito.esito = KKG_ESITO_blok
		kuo1_exception = create uo_exception
		kuo1_exception.set_esito(kst_esito)
		throw kuo1_exception
		
	end if

//--- Piglio il nome della stampante PDF
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "stamp_pdf")
	if left(k_esito,1) <> "0" then
		k_stampante_pdf = ""
	else
		k_stampante_pdf	= trim(mid(k_esito,2))
	end if
	destroy kuf1_base

//--- OK finalmente inizio a lavorare -----------------------------------------------------------------------------

//--- se oggetto dw attestato NON ancora definito	
//	if not isvalid(kdw_attestato) then
//		kdw_attestato = create datastore
//	end if
	if not isvalid(kids_certif_stampa) then
//--- CREA oggetto stampa-attestato GOLD/SILVER...
		kids_certif_stampa = create kds_certif_stampa 
	end if


	for k_item_attestato = 1 to upperbound(kst_docprod_esporta.kst_tab_docprod[])

		kist_tab_certif.id = kst_docprod_esporta.kst_tab_docprod[k_item_attestato].id_doc
		if kist_tab_certif.id > 0 then
			
//--- Popola area dell'attestato sul quale sto lavorando
			kist_tab_certif.num_certif = kst_docprod_esporta.kst_tab_docprod[k_item_attestato].doc_num
			kist_tab_certif.data = kst_docprod_esporta.kst_tab_docprod[k_item_attestato].doc_data

//--- piglia il Ricevente			
			kst_esito = get_clie(kist_tab_certif)
			if kst_esito.esito = kkg_esito_db_ko then
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
//			kist_tab_certif.clie_2 = kst_docprod_esporta.kst_tab_docprod[k_item_attestato].id_cliente

//--- Decide quale form dell'Attesto utilizzare (Gold/Silver/...) o RISTAMPA
			if not kids_certif_stampa.set_attestato(kist_tab_certif) then
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Fallita associazione form di stampa per l'Attestato: "+ string(kist_tab_certif.num_certif) //+ "~n~r"&
				kst_esito.esito = KKG_ESITO_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
		
//			kdw_attestato.dataobject = kids_certif_stampa.dataobject			
//			kdw_attestato.settransobject(sqlca)

		
			if NOT stampa_attestato_prepara (kids_certif_stampa) then // prepara Attestato in base all'area KIST_TAB_CERTIF
				kguo_exception.inizializza( )
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ko)
				kguo_exception.setmessage("Operazione di preparzione per 'Emissione Attestato' " + string( kist_tab_certif.num_certif ) + " fallita! ")
//				kguo_exception.messaggio_utente( )
				throw kguo_exception
			end if
			
	
			if kids_certif_stampa.rowcount( ) > 0 then

//---- Sono sulla copia da fare in Bianco e nero?
				if kst_docprod_esporta.flg_img_bn[k_item_attestato] then
					kids_certif_stampa.setitem(1, "k_flg_img_bn", "1")

//--- Reimposta immagini e risorse grafiche della stampa 
					stampa_attestato_set_img(kids_certif_stampa)
					
				end if

				kids_certif_stampa.object.k_test[1] = '0' // evita la banda TEST
			
//--- Controllo se manca il percorso
				if len(trim( kst_docprod_esporta.path[k_item_attestato])) > 0 then 

					k_n_documenti_stampati ++

//=== Crea il PDF
					kids_certif_stampa.Object.DataWindow.Export.PDF.Method = Distill!
					kids_certif_stampa.Object.DataWindow.Printer = k_stampante_pdf   
					kids_certif_stampa.Object.DataWindow.Export.PDF.Distill.CustomPostScript="1"
					k_id_stampa = kids_certif_stampa.saveas(trim( kst_docprod_esporta.path[k_item_attestato]),PDF!, false)   //
				
					if k_id_stampa < 1 then
						
						kst_esito.sqlcode = 0
						kst_esito.SQLErrText = "Attestato digitale su: '" + k_stampante_pdf + "' non generato: ~n~r"  &
																	 + "Documento: " + trim(kst_docprod_esporta.path[k_item_attestato]) + " ~n~r" &
																	 + "Funzione fallita per errore: " + string(k_id_stampa)
						kst_esito.esito = kkg_esito_no_esecuzione
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception

					end if

//--- Aggiorna tab Attestato		
					kst_tab_certif.id = kst_docprod_esporta.kst_tab_docprod[k_item_attestato].id_doc
					kst_tab_certif.id_docprod = kst_docprod_esporta.kst_tab_docprod[k_item_attestato].id_docprod
					set_id_docprod(kst_tab_certif)
				
				end if
			end if
			
			k_return = k_n_documenti_stampati
			
		end if
	end for

catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	if isvalid(kuf1_sicurezza) then destroy kuf1_sicurezza 
	
	
end try
		
return k_return		

end function

public function long aggiorna_docprod (ref st_tab_certif kst_tab_certif[]) throws uo_exception;//
//--- Aggiorna righe tabelle DOCPROD
//---
//--- input:  array st_tab_certif con l'elenco dei documenti da aggiornare
//--- out: Numero documenti caricati
//---
//--- Lancia EXCEPTION
//---
long k_return = 0
long k_riga_certif=0, k_nr_certif=0, k_nr_doc=0
st_esito kst_esito
st_tab_docprod kst_tab_docprod
st_tab_meca kst_tab_meca
kuf_docprod kuf1_docprod
kuf_armo kuf1_armo


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	k_nr_certif = upperbound(kst_tab_certif[])

	if k_nr_certif > 0 then
		
		
//--- Crea Documenti da Esportare (DOCPROD)
		kuf1_docprod = create kuf_docprod

		kuf1_armo = create kuf_armo

		for k_riga_certif = 1 to k_nr_certif

			try

				if kst_tab_certif[k_riga_certif].id > 0 then
	
					kst_tab_docprod.doc_num = kst_tab_certif[k_riga_certif].num_certif
					kst_tab_docprod.doc_data = kst_tab_certif[k_riga_certif].data
					kst_tab_docprod.id_doc = kst_tab_certif[k_riga_certif].id
					
//--- Recupera il ID del Lotto di entrata
					get_id_meca(kst_tab_certif[k_riga_certif]) 
					
//--- Recupera il codice CLIENTE fatturato
					kst_tab_meca.id = kst_tab_certif[k_riga_certif].id_meca
					kuf1_armo.get_clie_listino(kst_tab_meca)
					kst_tab_docprod.id_cliente = kst_tab_meca.clie_3

					
//					kst_esito = get_clie(kst_tab_certif[k_riga_certif])
//					if kst_esito.esito = kkg_esito_db_ko then
//						if isvalid(kuf1_docprod) then destroy kuf1_docprod
//						kguo_exception.inizializza( )
//						kguo_exception.set_esito(kst_esito)
//						throw kguo_exception
//					end if
//					kst_tab_docprod.id_cliente = kst_tab_certif[k_riga_certif].clie_2
					
					kst_tab_docprod.st_tab_g_0.esegui_commit = kst_tab_certif[1].st_tab_g_0.esegui_commit 
	
					kuf1_docprod.tb_add_certif ( kst_tab_docprod ) // AGGIUNGE IN DOCPROD
					k_nr_doc++
					
				end if		

			catch (uo_exception kuo1_exception)
				throw kuo1_exception
				
			end try
			
		next
	
		if isvalid(kuf1_docprod) then destroy kuf1_docprod
		if isvalid(kuf1_armo) then destroy kuf1_armo
				
	
		if k_nr_doc > 0 then
			k_return = k_nr_doc
		end if
	
	end if


return k_return

end function

public function boolean if_esiste (readonly st_tab_certif kst_tab_certif) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla esistenza Attestato da id
//--- 
//--- 
//--- Inp: st_tab_certif.id
//--- Out: TRUE = esiste
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
long k_trovato=0
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


//--- x numero certificato			
	SELECT count(*)
			into :k_trovato
			 FROM certif  
			 where  id  = :kst_tab_certif.id
			 using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura Attestato (certif) id = " + string(kst_tab_certif.id) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
		kst_esito.esito = kkg_esito.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if k_trovato > 0 then k_return = true
	end if
	

return k_return



end function

public function st_esito get_data (ref st_tab_certif kst_tab_certif);//
//====================================================================
//=== 
//=== Torna il Data del Certificato 
//=== 
//=== 
//--- Input: st_tab_certif.id
//---
//--- Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//---
//====================================================================
//
string k_return = "0 "
st_esito kst_esito



kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


	SELECT
				certif.data
				into
		         :kst_tab_certif.data
			 FROM certif  
			 where id  = :kst_tab_certif.id
				 using sqlca;
		
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Attestati CERTIF nr. =" &
						 + string(kst_tab_certif.num_certif) + " " &
						 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
									 
		if sqlca.sqlcode = 100 then
			kst_esito.esito = KKG_ESITO_not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = KKG_ESITO_db_wrn
			else	
				kst_esito.esito = KKG_ESITO_db_ko
			end if
		end if
	end if
	

return kst_esito


end function

public function boolean if_crea_certif (st_tab_certif kst_tab_certif) throws uo_exception;//
//--- Verifica se Attestato gia' da fare/stampare o ancora lotto incompleto ecc...
//--- Inp: st_tab_cerif. num_certif o id_meca
//--- Rit.: TRUE = Ok attestato /  FALSE = attestato non pronto
//--- Lancia EXCEPTION se errore grave
//---
boolean k_return = false
kuf_armo kuf1_armo
kuf_artr kuf1_artr 
st_tab_armo kst_tab_armo
st_tab_meca kst_tab_meca
st_tab_artr kst_tab_artr
st_esito kst_esito



try 

	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = " "
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_armo = create kuf_armo
	kuf1_artr = create kuf_artr

//--- recupera id lotto
	if kst_tab_certif.id_meca = 0 or isnull(kst_tab_certif.id_meca) then
		get_id_meca(kst_tab_certif)
	end if

//--- se id_meca non trovato vado su archivio trattati a prendere il id_meca
	if kst_tab_certif.id_meca = 0 or isnull(kst_tab_certif.id_meca) then
		kst_tab_artr.num_certif = kst_tab_certif.num_certif
		kst_tab_armo.id_armo = kuf1_artr.get_id_armo_da_num_certif(kst_tab_artr)
		if kst_tab_armo.id_armo > 0 then
			kst_esito = kuf1_armo.get_id_meca_da_id_armo(kst_tab_armo)
			if kst_esito.esito = kkg_esito_db_ko then
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			kst_tab_certif.id_meca = kst_tab_armo.id_meca  
		end if
	end if

//--- spero proprio ci sia altrimenti KO		
	if kst_tab_certif.id_meca > 0 then

//--- lotto Trattato completamente? 
		kst_tab_armo.id_meca = kst_tab_certif.id_meca
		if kuf1_armo.if_lotto_completo( kst_tab_armo ) then 
		
//--- e lotto gia' Convalidato?
			kst_tab_meca.id = kst_tab_certif.id_meca
			if kuf1_armo.if_convalidato( kst_tab_meca ) then 
				k_return = true
			end if
		end if
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception

finally 
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_artr) then destroy kuf1_artr

end try


return k_return

end function

private function st_esito stampa_attestato_registra () throws uo_exception;//
//---------------------------------------------------------------------------------
//--- Registra definitivamente in archivio la Stampa Attestato di Trattamento
//--- da lanciare dopo la routine "stampa_attestato"
//---
//--- Par. Input: kist_tab_certif   
//--- 
//--- Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//--- 
//---------------------------------------------------------------------------------
//
//--- 
string k_dataoggi, ki_path_risorse, k_rcx
long k_rc, k_riga, k_riga_ds
boolean k_rc_sr
long k_durata_lav_secondi
date k_datainizioanno
int k_giorniafter, k_anno, k_anno_rid
st_tab_certif kst_tab_certif[]
st_open_w kst_open_w
st_esito kst_esito, kst_esito_1 
st_profilestring_ini kst_profilestring_ini
st_tab_meca kst_tab_meca
st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
kuf_armo kuf1_armo
kuf_armo_inout kuf1_armo_inout
kuf_sicurezza kuf1_sicurezza
kuf_e1_wo_f5548014 kuf1_e1_wo_f5548014


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_stampa
kst_open_w.id_programma = kkg_id_programma.attestati

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_rc_sr = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_rc_sr then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Attestato non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = KKG_ESITO_no_aut

else

//--- registra la data di stampa in attestato rendendolo definitivo
	kist_tab_certif.data_stampa = kg_dataoggi

//--- il form di stampa definitivo	
	kist_tab_certif.form_di_stampa = trim(kids_certif_stampa.dataobject	)

	kst_tab_certif[1] = kist_tab_certif

	kst_tab_certif[1].st_tab_g_0.esegui_commit = "S"
	kst_esito_1 = aggiorna_dati_stampa(kst_tab_certif[1])
	
	if kst_esito_1.esito <> kkg_esito_ok and kst_esito_1.esito <> kkg_esito_db_wrn then
		kst_esito.esito = KKG_ESITO_blok
		kst_esito.sqlcode = kst_esito_1.sqlcode 
		kst_esito.SQLErrText = "Registrazione attestato Fallita.~n~r" + kst_esito_1.SQLErrText
	else
		
		try  

//--- Recupera il ID del Lotto di entrata
			if get_id_meca(kst_tab_certif[1]) then
				if kst_tab_certif[1].id_meca > 0 then

//--- alimenta tabella dati trattamento da Inviare a E1
					kuf1_e1_wo_f5548014 = create kuf_e1_wo_f5548014
					if kguo_g.if_e1_enabled( ) then
						kuf1_barcode = create kuf_barcode
						kuf1_armo = create kuf_armo
						kst_tab_meca.id = kst_tab_certif[1].id_meca
						kst_tab_e1_wo_f5548014.wo_osdoco = kuf1_armo.get_e1doco(kst_tab_meca)
						if kst_tab_e1_wo_f5548014.wo_osdoco > 0 then
							kst_tab_e1_wo_f5548014.flag_osev01 = kuf1_e1_wo_f5548014.kki_stato_ev01_qtdata
							kst_tab_e1_wo_f5548014.dosemin_os55gs25a = string(kst_tab_certif[1].dose_min, "#0.00")
							kst_tab_e1_wo_f5548014.dosemax_os55gs25b = string(kst_tab_certif[1].dose_max, "#0.00")
							
							kst_tab_barcode.id_meca = kst_tab_meca.id
							k_durata_lav_secondi = kuf1_barcode.get_durata_lav(kst_tab_barcode)
							kst_tab_e1_wo_f5548014.ciclo_os55gs25c = string(k_durata_lav_secondi) //kst_tab_certif[1].dose, "#0.00")
							
							//kst_tab_e1_wo_f5548014.data_osa801 = kuf1_data_base.get_e1_dateformat(kst_tab_certif[1].data)
							kst_tab_e1_wo_f5548014.data_osa801 = string(kst_tab_certif[1].data, "dd/mm/yy")
							k_anno = integer(string(kst_tab_certif[1].data, "yyyy"))
							k_anno_rid = integer(string(kst_tab_certif[1].data, "yy"))
							k_datainizioanno = date(k_anno,01,01)
							k_giorniafter = DaysAfter(k_datainizioanno, date(kst_tab_certif[1].data)) + 1
							kst_tab_e1_wo_f5548014.data_osdee = 100000 + k_anno_rid * 1000 + k_giorniafter
							kst_tab_e1_wo_f5548014.ora_oswwaet = long(kuf1_data_base.get_e1_timeformat(time(kuf1_data_base.prendi_dataora( ))))
							kuf1_e1_wo_f5548014.set_datilav_f5548014(kst_tab_e1_wo_f5548014)
						end if
					end if

					
//--- Esegue diverse operazioni post stampa Attestato ----------------------------------------------------------------------------------------------
					kuf1_armo_inout = create kuf_armo_inout
					kst_tab_meca.id = kist_tab_certif.id_meca

					kuf1_armo_inout.update_post_stampa_attestato(kst_tab_meca) // chiude Quarantena, set Voci da Fatturare ecc....
					
				end if
			end if

//--- Aggiunge la riga in DOCPROD x l'esportazione digitale ----------------------------------------------------------------------------------------
			kst_tab_certif[1].st_tab_g_0.esegui_commit = "S"
			aggiorna_docprod(kst_tab_certif[])
			
			
		catch (uo_exception kuo_exception1)
			kst_esito = kuo_exception1.get_st_esito( )
			kst_esito.sqlerrtext = "Archivi Attestato Aggiornati Correttamente !  Ma si sono verificate le seguenti anonalie: ~n~r" + trim(kst_esito.sqlerrtext)

			
		finally
			if isvalid(kuf1_e1_wo_f5548014) then destroy kuf1_e1_wo_f5548014
			if isvalid(kuf1_armo_inout) then destroy kuf1_armo_inout
			if isvalid(kuf1_armo) then destroy kuf1_armo
			if isvalid(kuf1_barcode) then destroy kuf1_barcode
			
		
		end try
				
		
		
	end if
	
	
	
end if


return kst_esito

end function

public function boolean get_id_meca (ref st_tab_certif kst_tab_certif) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il ID_MECA del Certificato
//--- 
//--- 
//--- Input: st_tab_certif.num_certif
//--- Out: st_tab_certif.id_meca
//--- Ritorna: TRUE = trovato
//---
//--- Lancia EXCEPTION
//---
//---------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


//--- x numero certificato			
	SELECT
				certif.id_meca
			into
		         :kst_tab_certif.id_meca  
			FROM certif  
			where 
			    num_certif  = :kst_tab_certif.num_certif
				 using  kguo_sqlca_db_magazzino ;
		
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_certif.id_meca > 0 then
			k_return = true  
		end if

	else
		kst_tab_certif.id_meca = 0
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in ricerca ID Lotto nella Tab. Attestati (CERTIF ) numero = " &
						 + string(kst_tab_certif.num_certif) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = KKG_ESITO.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	end if
	

return k_return


end function

public function boolean if_stampato (readonly st_tab_certif kst_tab_certif) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla se Attestato stampato da id
//--- 
//--- 
//--- Inp: st_tab_certif.id
//--- Out: TRUE = stampato definitivamente
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
long k_trovato=0
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


//--- x ID certificato			
	SELECT count(*)
			into :k_trovato
			 FROM certif  
			 where  id  = :kst_tab_certif.id and data_stampa > '01.01.1990'
			 using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura Attestato (certif) id = " + string(kst_tab_certif.id) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
		kst_esito.esito = KKG_ESITO.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if k_trovato > 0 then k_return = true
	end if
	

return k_return



end function

public function st_esito get_id_da_id_meca (ref st_tab_certif kst_tab_certif);//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Torna il ID dal ID lotto
//--- 
//--- 
//--- Input: st_tab_certif.id_meca
//--- Out: st_tab_certif.id
//---
//--- Ritorna tab. ST_ESITO, Esiti:   Vedi standard
//---
//----------------------------------------------------------------------------------------------------------------
//
string k_return = "0 "
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


//--- x numero certificato			
	SELECT
				certif.id
			into
		         :kst_tab_certif.id  
			 FROM certif  
			 where 
						(id_meca  = :kst_tab_certif.id_meca)					     
				 using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante Lettura Attestato (certif) da ID Lotto = " + string(kst_tab_certif.id_meca) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
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
	

return kst_esito


end function

public function st_esito tb_delete (st_tab_certif kst_tab_certif) throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella ATTESTATI
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:     vedi standard
//=== 
//====================================================================
boolean k_autorizza
integer k_sn=0
int k_rek_ok=0
long k_id
st_tab_docprod kst_tab_docprod
st_tab_artr kst_tab_artr
st_tab_meca kst_tab_meca		
st_esito kst_esito, kst_esito1
st_open_w kst_open_w
kuf_artr kuf1_artr
kuf_docprod kuf1_docprod
kuf_doctipo kuf1_doctipo
kuf_sicurezza kuf1_sicurezza
kuf_armo_inout kuf1_armo_inout


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try 
	
	select distinct num_certif, data_stampa
		into :kst_tab_certif.num_certif, :kst_tab_certif.data_stampa
		from certif
		where id = :kst_tab_certif.id  
		using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
	
		kst_open_w = kst_open_w
	
		if kst_tab_certif.data_stampa > kkg_data_zero then
			kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
		else
			kst_open_w.flag_modalita = kkg_flag_modalita.stampa
		end if
		
		kst_open_w.id_programma = kkg_id_programma_attestati
		
		//--- controlla se utente autorizzato alla funzione in atto
		kuf1_sicurezza = create kuf_sicurezza
		k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
		destroy kuf1_sicurezza
		
		if not k_autorizza then
		
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Cancellazione Attestato non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
			kst_esito.esito = KKG_esito.no_aut
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	
		delete from certif
			where id = :kst_tab_certif.id  
			using kguo_sqlca_db_magazzino;
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Cancellazione Attestato (certif) " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = KKG_esito.db_ko
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

//--- inizializza su ARTR data stampa 			
		kst_tab_artr.num_certif = kst_tab_certif.num_certif
		kst_tab_artr.data_st = kkg_data_zero
		kuf1_artr = create kuf_artr
		kst_tab_artr.st_tab_g_0.esegui_commit = "N"
		kst_esito1=kuf1_artr.aggiorna_data_stampa_attestato(kst_tab_artr)
		if kst_esito1.sqlcode < 0 then
			kguo_exception.inizializza()
			kguo_exception.set_esito(kst_esito1)
			throw kguo_exception
		end if
			
		try
//--- cancella da docprod	 tutti i riferimenti
			kst_tab_docprod.id_doc = kst_tab_certif.id
			kuf1_docprod = create kuf_docprod
			kuf1_doctipo = create kuf_doctipo
			kst_tab_docprod.st_tab_g_0.esegui_commit = "N"
			kuf1_docprod.tb_delete(kst_tab_docprod, kuf1_doctipo.kki_tipo_attestati )
		catch (uo_exception kuo_exception)
			
		end try
		
		try
//--- Altre operazioni tipo il reset x eventuale Quarantena, reset dello Stato dei Prezzi riga Lotto ec.......
//--- Recupera il ID del Lotto di entrata
			if get_id_meca(kst_tab_certif) then
				if kist_tab_certif.id_meca > 0 then
					kuf1_armo_inout = create kuf_armo_inout
					kst_tab_meca.id = kist_tab_certif.id_meca
					kst_tab_meca.st_tab_g_0.esegui_commit = "N"
					kuf1_armo_inout.update_post_delete_attestato(kst_tab_meca)
				end if
			end if
		catch (uo_exception kuo1_exception)
			
		end try

	else
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Ricerca e Cancellazione Attestato (certif):" + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = KKG_esito.not_fnd
		else
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = KKG_esito.db_wrn
			else
				kst_esito.esito = KKG_esito.db_ko
				kguo_exception.inizializza()
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if

catch (uo_exception kuo2_exception)
	kst_esito = kuo2_exception.get_st_esito()
	throw kuo2_exception

finally
	if isvalid(kuf1_artr) then destroy kuf1_artr 
	if isvalid(kuf1_docprod) then destroy kuf1_docprod 
	if isvalid(kuf1_doctipo) then destroy kuf1_doctipo 
	if isvalid(kuf1_armo_inout) then destroy kuf1_armo_inout 
//--- Commit
	if kst_tab_certif.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_certif.st_tab_g_0.esegui_commit) then

		if kst_esito.esito = KKG_esito.ok or kst_esito.esito = KKG_esito.db_wrn then
			kst_esito = kuf1_data_base.db_commit_1()
		else
			kuf1_data_base.db_rollback_1( )
		end if
		
	end if
			
	
end try

return kst_esito

end function

private function boolean stampa_attestato_prepara (ref datastore kds_attestato) throws uo_exception;//
//====================================================================
//=== Preparazione alla Stampa Attestato di Trattamento
//=== per eseguire la stampa lanciare la routine "stampa"
//===
//=== Par. Inut: datawindow da popolare 
//===                variabile intero oggetto: kist_tab_certif (valorizzare il num. certificato)
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard
//=== 
//====================================================================
//
//=== 
boolean k_return = false
string k_dataoggi, k_path_risorse, k_rcx, k_path_risorse_OLD
string k_file, k_flg_img_bn
long k_rc, k_riga, k_riga_ds
datastore kds_appo
st_open_w kst_open_w
st_esito kst_esito, kst_esito_armo
st_profilestring_ini kst_profilestring_ini
st_tab_meca kst_tab_meca
kuf_armo kuf1_armo



try

	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	

//--- piglia l'ID
//, :kist_tab_certif.form_di_stampa, :kist_tab_certif.data_stampa
		kist_tab_certif.data_stampa = kkg_data_zero 
		 select id
			  into  :kist_tab_certif.id 
			  from certif 
			  where num_certif = :kist_tab_certif.num_certif  
			  using sqlca;

//--- se mai stampato lo rigenero
		if sqlca.sqlcode = 100 then
			kist_tab_certif.id = 0
			
		else
			if kst_esito.sqlcode < 0 then
				
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Fallita lettura per stampa Attestato: "+ string(kist_tab_certif.num_certif) + "~n~r"&
							 + "Errore: " + trim(sqlca.sqlerrtext)
				kst_esito.esito = KKG_ESITO_db_ko
				
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	
				
	//--- Attestato pronto?	
		if not if_crea_certif(kist_tab_certif) then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Attestato "+ string(kist_tab_certif.num_certif) + " non pronto (Lotto non trattato / Dosimetria non rilevata). ~n~r"
			kst_esito.esito = KKG_ESITO_no_esecuzione
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	//--- crea attestato
		kst_esito = crea_certif(kist_tab_certif)
		if kst_esito.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Fallita generazione Attestato: "+ string(kist_tab_certif.num_certif) + "~n~r"&
						 + "Errore: " + trim(sqlca.sqlerrtext)
			kst_esito.esito = KKG_ESITO_db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
						
		
		kst_esito.esito = KKG_ESITO_ok

		kds_appo = create datastore
		kds_appo.dataobject = kds_attestato.dataobject	
		k_rc=kds_appo.settransobject(sqlca)
		
		kds_appo.reset()	
//--- retrive dell'attestato 
		k_rc=kds_appo.retrieve(  &
										kist_tab_certif.num_certif &
										,kist_tab_certif.num_certif )

		if kds_appo.rowcount() > 0 then
	
//--- copia il ds nel ds passato come argomento
			k_riga_ds = kds_appo.RowCount()
			k_riga = kds_attestato.RowCount() + 1
			k_rc = kds_appo.RowsCopy(kds_appo.GetRow(), kds_appo.RowCount(), Primary!, kds_attestato, k_riga, Primary!)
			k_rc = kds_attestato.rowcount()


//031016//--- controllo se materiale farmaceutico
//			kuf1_armo = create kuf_armo
//			kst_tab_meca.id = kist_tab_certif.id_meca
//			if kuf1_armo.if_lotto_farmaceutico(kst_tab_meca) then //se mat farmaceutico 
//				kds_attestato.setitem(kds_attestato.getrow(), "k_mat_farmaceutico", "1")
//			else
//				kds_attestato.setitem(kds_attestato.getrow(), "k_mat_farmaceutico", "0")
//			end if

//--- Imposta immagini e risorse grafiche della stampa 
//			stampa_attestato_set_img(kds_attestato)
			
		end if
		
		k_return= true
		

catch(uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kds_appo) then destroy kds_appo
	
end try



return k_return

end function

private subroutine stampa_attestato_set_img (ref datastore kds_attestato) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------
//--- Preparazione alla Stampa Attestato di Trattamento
//--- 
//--- Inut: datastore gia' popolato
//--- out: imposta i nomi delle immagini da stampare
//--- Rit: nulla
//--- 
//------------------------------------------------------------------------------------------------------------------
//
//--- 
string k_path_risorse, k_rcx, k_path_risorse_OLD
string k_file 
string k_flg_img_bn, k_flg_mat_farmaceutico
long k_rc, k_riga, k_riga_ds
st_esito kst_esito
uo_exception kuo1_exception



try

	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	k_rcx=kds_attestato.Describe("k_flg_img_bn.tag")
	if k_rcx <> "!" then
		k_flg_img_bn = trim(kds_attestato.getitemstring(1, "k_flg_img_bn"))   // becco se i logo devono essere fatti in biano e nero
	else
		k_flg_img_bn = "0"
	end if
	if trim(kds_attestato.Describe("txt_p_img.text")) <> "!" and len(trim(kds_attestato.Describe("txt_p_img.text"))) > 0 then
		k_file = trim(kds_attestato.Describe("txt_p_img.text")) 
		if k_flg_img_bn = "1" then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
	else
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep + "logo_orig_bn.bmp"  //solo x mantenere vecchia compatibilità
	end if
	k_rcx=kds_attestato.Modify("p_img.Filename='" + k_path_risorse + "'")

	if len(trim(kds_attestato.Describe("txt_p_img_0.text"))) > 0 then
		k_file = trim(kds_attestato.Describe("txt_p_img_0.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=kds_attestato.Modify("p_img_0.Filename='" + k_path_risorse + "'")
	end if
	if len(trim(kds_attestato.Describe("txt_p_img_1.text"))) > 0 then
		k_file = trim(kds_attestato.Describe("txt_p_img_1.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=kds_attestato.Modify("p_img_1.Filename='" + k_path_risorse + "'")
	end if
	if len(trim(kds_attestato.Describe("txt_p_img_2.text"))) > 0 then
		k_file = trim(kds_attestato.Describe("txt_p_img_2.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=kds_attestato.Modify("p_img_2.Filename='" + k_path_risorse + "'")
	end if
	if len(trim(kds_attestato.Describe("txt_p_img_4.text"))) > 0 then
		k_file = trim(kds_attestato.Describe("txt_p_img_4.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=kds_attestato.Modify("p_img_4.Filename='" + k_path_risorse + "'")
	end if
	if len(trim(kds_attestato.Describe("txt_p_img_5.text"))) > 0 then
		k_file = trim(kds_attestato.Describe("txt_p_img_5.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=kds_attestato.Modify("p_img_5.Filename='" + k_path_risorse + "'")
	end if

//---- gestione particolare per la firma 'meccanografica' e Materiale Farmaceutico -----------------------------------------------------------------
	k_flg_mat_farmaceutico = trim(kds_attestato.getitemstring(1, "k_mat_farmaceutico"))   // becco il tipo di materiale
	if trim(kds_attestato.Describe("txt_p_img_3.text")) <> "!" and len(trim(kds_attestato.Describe("txt_p_img_3.text"))) > 0 then  // FIRMA!!
		k_rcx=kds_attestato.Modify("p_img_3.visible='0'") 
//--- controllo se materiale farmaceutico
		if k_flg_mat_farmaceutico = "1" then //se mat farmaceutico 
			kds_attestato.modify("txt_p_img_3.text = 'firma_direttore_tecnico.gif' ")   
//--- in questo caso lascia quella inserita nel campo
//		else 
//			kds_attestato.modify("txt_p_img_3.text = 'firma_operation_manager_a.bmp' ")  
		end if
		if len(trim(kds_attestato.Describe("txt_p_img_3.text"))) > 0 then
			k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep + trim(kds_attestato.Describe("txt_p_img_3.text"))   
			k_rcx=kds_attestato.Modify("p_img_3.Filename='" + k_path_risorse + "'")
		end if
		if k_flg_img_bn = "1" then
			k_rcx=kds_attestato.Modify("p_img_3.visible='0'") 
		else
			k_rcx=kds_attestato.Modify("p_img_3.visible='1'") 
		end if
		
	else
		
//--- solo x mantenere vecchia compatibilità -----------------------------------------------------------------------------------------------------------
			
//--- controllo se materiale farmaceutico
		if k_flg_mat_farmaceutico = "1" then //se mat farmaceutico 
			k_path_risorse_OLD = kguo_path.get_risorse( ) + kkg.path_sep + "firma_direttore_tecnico.gif"   //solo x mantenere vecchia compatibilità
		else
			k_path_risorse_OLD = kguo_path.get_risorse( ) + kkg.path_sep + "firma_direttore_stabilimento.bmp"   //solo x mantenere vecchia compatibilità
		end if
		k_rcx=kds_attestato.Modify("p_firma.visible='0'")  //solo x mantenere vecchia compatibilità
		k_rcx=kds_attestato.Modify("p_firma.Filename='" + k_path_risorse_OLD + "'") //solo x mantenere vecchia compatibilità
		k_rcx=kds_attestato.Modify("p_firma.visible='1'") //solo x mantenere vecchia compatibilità
		
	end if



catch(uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try




end subroutine

private subroutine stampa_attestato_set_img (ref datawindowchild kds_attestato) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------
//--- Preparazione alla Stampa Attestato di Trattamento
//--- 
//--- Inut: datastore gia' popolato
//--- out: imposta i nomi delle immagini da stampare
//--- Rit: nulla
//--- 
//------------------------------------------------------------------------------------------------------------------
//
//--- 
string k_path_risorse, k_rcx, k_path_risorse_OLD
string k_file 
string k_flg_img_bn, k_flg_mat_farmaceutico
long k_rc, k_riga, k_riga_ds
st_esito kst_esito
uo_exception kuo1_exception



try

	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	k_rcx=kds_attestato.Describe("k_flg_img_bn.tag")
	if k_rcx <> "!" then
		k_flg_img_bn = trim(kds_attestato.getitemstring(1, "k_flg_img_bn"))   // becco se i logo devono essere fatti in biano e nero
	else
		k_flg_img_bn = "0"
	end if
	if trim(kds_attestato.Describe("txt_p_img.text")) <> "!" and len(trim(kds_attestato.Describe("txt_p_img.text"))) > 0 then
		k_file = trim(kds_attestato.Describe("txt_p_img.text")) 
		if k_flg_img_bn = "1" then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
	else
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep + "logo_orig_bn.bmp"  //solo x mantenere vecchia compatibilità
	end if
	k_rcx=kds_attestato.Modify("p_img.Filename='" + k_path_risorse + "'")

	if len(trim(kds_attestato.Describe("txt_p_img_0.text"))) > 0 then
		k_file = trim(kds_attestato.Describe("txt_p_img_0.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=kds_attestato.Modify("p_img_0.Filename='" + k_path_risorse + "'")
	end if
	if len(trim(kds_attestato.Describe("txt_p_img_1.text"))) > 0 then
		k_file = trim(kds_attestato.Describe("txt_p_img_1.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=kds_attestato.Modify("p_img_1.Filename='" + k_path_risorse + "'")
	end if
	if len(trim(kds_attestato.Describe("txt_p_img_2.text"))) > 0 then
		k_file = trim(kds_attestato.Describe("txt_p_img_2.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=kds_attestato.Modify("p_img_2.Filename='" + k_path_risorse + "'")
	end if
	if len(trim(kds_attestato.Describe("txt_p_img_4.text"))) > 0 then
		k_file = trim(kds_attestato.Describe("txt_p_img_4.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=kds_attestato.Modify("p_img_4.Filename='" + k_path_risorse + "'")
	end if
	if len(trim(kds_attestato.Describe("txt_p_img_5.text"))) > 0 then
		k_file = trim(kds_attestato.Describe("txt_p_img_5.text")) 
		if k_flg_img_bn = '1' then
			k_file = mid(k_file, 1, len(k_file) - 4) + "_bn" + right(k_file, 4)
		end if
		k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep +  k_file 
		k_rcx=kds_attestato.Modify("p_img_5.Filename='" + k_path_risorse + "'")
	end if

//---- gestione particolare per la firma 'meccanografica' e Materiale Farmaceutico -----------------------------------------------------------------
	k_flg_mat_farmaceutico = trim(kds_attestato.getitemstring(1, "k_mat_farmaceutico"))   // becco il tipo di materiale
	if trim(kds_attestato.Describe("txt_p_img_3.text")) <> "!" and len(trim(kds_attestato.Describe("txt_p_img_3.text"))) > 0 then  // FIRMA!!
		k_rcx=kds_attestato.Modify("p_img_3.visible='0'") 
//--- controllo se materiale farmaceutico
		if k_flg_mat_farmaceutico = "1" then //se mat farmaceutico 
			kds_attestato.modify("txt_p_img_3.text = 'firma_direttore_tecnico.gif' ")   
//--- in questo caso lascia quella inserita nel campo
//		else 
//			kds_attestato.modify("txt_p_img_3.text = 'firma_operation_manager_a.bmp' ")  
		end if
		if len(trim(kds_attestato.Describe("txt_p_img_3.text"))) > 0 then
			k_path_risorse = kguo_path.get_risorse( ) + kkg.path_sep + trim(kds_attestato.Describe("txt_p_img_3.text"))   
			k_rcx=kds_attestato.Modify("p_img_3.Filename='" + k_path_risorse + "'")
		end if
		if k_flg_img_bn = "1" then
			k_rcx=kds_attestato.Modify("p_img_3.visible='0'") 
		else
			k_rcx=kds_attestato.Modify("p_img_3.visible='1'") 
		end if
		
	else
		
//--- solo x mantenere vecchia compatibilità -----------------------------------------------------------------------------------------------------------
			
//--- controllo se materiale farmaceutico
		if k_flg_mat_farmaceutico = "1" then //se mat farmaceutico 
			k_path_risorse_OLD = kguo_path.get_risorse( ) + kkg.path_sep + "firma_direttore_tecnico.gif"   //solo x mantenere vecchia compatibilità
		else
			k_path_risorse_OLD = kguo_path.get_risorse( ) + kkg.path_sep + "firma_direttore_stabilimento.bmp"   //solo x mantenere vecchia compatibilità
		end if
		k_rcx=kds_attestato.Modify("p_firma.visible='0'")  //solo x mantenere vecchia compatibilità
		k_rcx=kds_attestato.Modify("p_firma.Filename='" + k_path_risorse_OLD + "'") //solo x mantenere vecchia compatibilità
		k_rcx=kds_attestato.Modify("p_firma.visible='1'") //solo x mantenere vecchia compatibilità
		
	end if



catch(uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try




end subroutine

private function integer stampa_attestato (ref datastore kds_attestato) throws uo_exception;//
//=== 
//====================================================================
//=== Stampa Attestato di Trattamento
//=== per eseguire la stampa lanciare prima la routine "stampa_attestato_prepara"
//===
//=== Par. Input:    
//===               datawindow da popolare
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:    Vedi standard 
//=== 
//====================================================================
//
int k_return=0
int k_errore  
string k_old_str, k_new_str, k_rag_soc=""
int k_start_pos
long k_rc
boolean k_sicurezza
st_open_w kst_open_w
st_esito kst_esito
//st_stampe kst_stampe
kuf_sicurezza kuf1_sicurezza
kuf_base kuf1_base
kuf_utility kuf1_utility
//kds_att_stampa kds1_att_stampa
datawindowchild kdwc_nested


try
	
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kst_open_w = kst_open_w
	kst_open_w.flag_modalita = kkg_flag_modalita_stampa
	kst_open_w.id_programma = kkg_id_programma_attestati
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_sicurezza then
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Stampa Attestato non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = KKG_ESITO_no_aut
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	
	else
		
		if kds_attestato.rowcount() <= 0 then
				
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun Attestato da stampare ~n~r" 
			kst_esito.esito = KKG_ESITO_blok
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
	
		else
//			kds1_att_stampa = create kds_att_stampa
			
//			kds_attestato.Object.DataWindow.Print.Margin.Top = '400'
//			kds_attestato.Object.DataWindow.Print.Margin.Bottom = '300'
//			kds_attestato.Object.DataWindow.Print.Margin.Left = '500'
//			kds_attestato.Object.DataWindow.Print.Margin.Right = '500'
		
	//--- setta attestato di test			
			if ki_flag_stampa_di_test then
				kds_attestato.object.k_test[1] = '1'
			else
				kds_attestato.object.k_test[1] = '0'
			end if 
	
//	//--- prepara il datastore composite di stampa
//			kds1_att_stampa.u_set_attestato_dw(kds_attestato.dataobject)
//			kds1_att_stampa.retrieve(1, kds_attestato.getitemnumber(1, "id_meca")) // retrieve delle pagine allegate con le info del Lotto
//			kds1_att_stampa.getchild( "dw_1", kdwc_nested)
//			if kdwc_nested.rowcount( ) > 0 then
//				kdwc_nested.deleterow(1)
//			end if
//			kds_attestato.rowscopy(1,1,primary!,kdwc_nested,1,primary!) // copia l'attestato sul datastore composite da stampare
//	
//--- Imposta immagini e risorse grafiche della stampa 
//			stampa_attestato_set_img(kdwc_nested)
			stampa_attestato_set_img(kds_attestato)
	
			k_rag_soc = mid(trim(kds_attestato.getitemstring(1, "rag_soc_10_2")),1,8)
			kuf1_utility = create kuf_utility
			k_rag_soc = kuf1_utility.u_stringa_compatta(k_rag_soc)
			destroy kuf1_utility
			
			kds_attestato.Object.DataWindow.Print.DocumentName= "attestato_" + trim(string(kds_attestato.object.certif_num_certif[1])) + "_" + trim(k_rag_soc) 
//			kds1_att_stampa.Object.DataWindow.Print.DocumentName= "attestato_" + trim(string(kds_attestato.object.certif_num_certif[1])) + "_" + trim(k_rag_soc) 
	
	//--- ricava la stampante-certificato solo se Stampa vera e stampante non impostata
//			if not kiuo1_d_certif_stampa.ki_flag_ristampa and (len(trim(ki_stampante)) = 0 or isnull(ki_stampante)) then
			if ki_stampante[1] > " " then
			else
				stampa_attestato_set_printer( )   // imposta le stampanti ki_stampante[]
				
//				kuf1_base = create kuf_base
//				ki_stampante = trim(mid(kuf1_base.prendi_dato_base( "stamp_attestato"),2))
//				destroy kuf1_base
			end if
		
//			if kiuo1_d_certif_stampa.ki_flag_ristampa or len(trim(ki_stampante)) = 0 or isnull(ki_stampante) then
//				if printsetup() > 0 then
//					ki_stampante = PrintGetPrinter ( )
//	//=== Puntatore Cursore da attesa.....
//					SetPointer(kkg.pointer_attesa)
//					//if kds_attestato.print() > 0 then
//					if kds1_att_stampa.print( ) > 0 then
//						kst_esito.esito = KKG_ESITO_OK
//						k_return ++
//					else
//						kst_esito.sqlcode = 0
//						kst_esito.SQLErrText = "Errore durante la stampa dell'Attestato ~n~r" 
//						kst_esito.esito = KKG_ESITO_blok
//						kguo_exception.inizializza( )
//						kguo_exception.set_esito(kst_esito)
//						throw kguo_exception
//					end if
//				else	
//					kst_esito.sqlcode = 0
//					kst_esito.SQLErrText = "Nessun Attestato stampato ~n~r" 
//					kst_esito.esito = KKG_ESITO_blok
//					kguo_exception.inizializza( )
//					kguo_exception.set_esito(kst_esito)
//					throw kguo_exception
//				end if
//	
//			else		
			if ki_stampante[1] > " " then
				if PrintSetPrinter (ki_stampante[1]) > 0 then
					SetPointer(kkg.pointer_attesa)
	//--- stampa dw direttamente sulla stampante indicata				
					if kds_attestato.print() > 0 then
//					if kds1_att_stampa.print() > 0 then
						kst_esito.esito = KKG_ESITO_OK
						k_return ++
					else
						kst_esito.sqlcode = 0
						kst_esito.SQLErrText = "Errore durante la stampa dell'Attestato ~n~r" 
						kst_esito.esito = KKG_ESITO_blok
						kguo_exception.inizializza( )
						kguo_exception.set_esito(kst_esito)
						throw kguo_exception
					end if
				else	
					kst_esito.sqlcode = 0
					kst_esito.SQLErrText = "Nessun Attestato stampato ~n~r" 
					kst_esito.esito = KKG_ESITO_blok
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			end if
			
		end if
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally	
//	if isvalid(kds1_att_stampa) then destroy kds1_att_stampa
	SetPointer(kkg.pointer_default)
	
end try


return k_return 

end function

private function boolean stampa_attestato_set_printer () throws uo_exception;//
//=== 
//====================================================================
//=== Stampa Attestato di Trattamento
//=== imposta le stampanti su cui fare il documento e gli allegati
//===
//=== Inp:     
//=== Out: ki_stampanti[] [1]=il documento, [2]=gli allegati
//=== Rit: TRUE stampanti impostate
//=== 
//=== 
//====================================================================
//
boolean k_return=false
//string k_printerdefault
//string ls_name
int k_pos, k_rc
st_esito kst_esito
kuf_base kuf1_base


try
	
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	
//--- ricava la stampante-certificato solo se Stampa vera e stampante non impostata
//			if not kiuo1_d_certif_stampa.ki_flag_ristampa and (len(trim(ki_stampante)) = 0 or isnull(ki_stampante)) then
		if ki_stampante[1] > " " then
		else
			kuf1_base = create kuf_base

//--- get della stampante principale			
			ki_stampante[1] = trim(mid(kuf1_base.prendi_dato_base(kuf1_base.kki_base_utenti_codice_stcert1),2)) // controlla prima la stampante personale
			if ki_stampante[1] > " " then
			else
				ki_stampante[1] = trim(mid(kuf1_base.prendi_dato_base("stamp_attestato"),2)) // get stampante da proprietà generale
			end if
			if ki_stampante[1] > " " then
			else
				//k_printerdefault=PrintGetPrinter()
				//k_pos=pos (k_printerdefault, "~t")
				//k_name=left(k_printerdefault, k_pos -1)
				kguo_exception.inizializza( )
				kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_insufficienti)
				k_rc = kguo_exception.messaggio_utente( "Attenzione Stampanti non indicate", &
									"Mancano in 'Proprietà' i nomi delle stampanti. Puoi proseguire scegliendo temporaneamente un'unica stampante dal prossimo elenco")
				if printsetup() > 0 then
					ki_stampante[1] = PrintGetPrinter ( )
				end if
			end if
			if ki_stampante[1] > " " then
//--- get della stampante principale			
				ki_stampante[2] = trim(mid(kuf1_base.prendi_dato_base(kuf1_base.kki_base_utenti_codice_stcert2),2)) // controlla prima la stampante personale
				if ki_stampante[2] > " " then
				else
					ki_stampante[2] = trim(mid(kuf1_base.prendi_dato_base("stamp_attestato2"),2)) // get stampante da proprietà generale
				end if
				if ki_stampante[2] > " " then
				else
					ki_stampante[2] = ki_stampante[1]
				end if
				
			end if			
			destroy kuf1_base
		end if
		
	//--- Lancia la window di Stampa 
	//		kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta
	//		kst_stampe.ds_print = kds_attestato
	//		kst_stampe.titolo = trim(kiuo1_d_certif_stampa.title)
	//		kst_stampe.stampante_predefinita = ki_stampante
	//		kst_stampe.modificafont = kuf_stampe.ki_stampa_modificafont_no
	//		k_errore = kuf1_data_base.stampa_dw(kst_stampe)
	//		if k_errore <> 0 then
	//			kguo_exception.setmessage( "Si è verificato un problema durante l'apertura della Window di stampa. Controlla il tuo 'log' da menu M2000->Proprieta. Grazie. ")
	//			kguo_exception.messaggio_utente( )		
	//		end if
	//			kst_stampe.dw_print = kds_attestato
	//			kst_stampe.titolo = trim(kiuo1_d_certif_stampa.title)
		
//			if kiuo1_d_certif_stampa.ki_flag_ristampa or len(trim(ki_stampante)) = 0 or isnull(ki_stampante) then
//	
//				if printsetup() > 0 then
//					ki_stampante = PrintGetPrinter ( )
//	//=== Puntatore Cursore da attesa.....
//					SetPointer(kkg.pointer_attesa)
//					//if kds_attestato.print() > 0 then
//					if kds1_att_stampa.print( ) > 0 then
//						kst_esito.esito = KKG_ESITO_OK
//						k_return ++
//					else
//						kst_esito.sqlcode = 0
//						kst_esito.SQLErrText = "Errore durante la stampa dell'Attestato ~n~r" 
//						kst_esito.esito = KKG_ESITO_blok
//						kguo_exception.inizializza( )
//						kguo_exception.set_esito(kst_esito)
//						throw kguo_exception
//					end if
//				else	
//					kst_esito.sqlcode = 0
//					kst_esito.SQLErrText = "Nessun Attestato stampato ~n~r" 
//					kst_esito.esito = KKG_ESITO_blok
//					kguo_exception.inizializza( )
//					kguo_exception.set_esito(kst_esito)
//					throw kguo_exception
//				end if
//	
//			else		
				 

catch (uo_exception kuo_exception)
	throw kuo_exception

finally	
//	SetPointer(kkg.pointer_default)
	
end try


return k_return 

end function

on kuf_certif.create
call super::create
end on

on kuf_certif.destroy
call super::destroy
end on

event destructor;
if isvalid(kids_certif_stampa) then destroy kids_certif_stampa

end event

event constructor;//
//kids_certif_stampa = create kds_certif_stampa
ki_msgerroggetto = "Attestato"

end event

