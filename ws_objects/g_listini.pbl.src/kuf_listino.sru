$PBExportHeader$kuf_listino.sru
forward
global type kuf_listino from kuf_parent
end type
end forward

global type kuf_listino from kuf_parent
end type
global kuf_listino kuf_listino

type variables
//
//--- note sulle MISURE:   MIS_x =ARMO.LUNG_; MIS_Y=ARMO.ALT_; MIS_Z=ARMO.LARG_  
//

public constant string kki_anteprima_cond_fatt_dw = "d_cond_fatt_l_x_clie"

//--- Tipo Prezzo
public constant string kki_tipo_prezzo_a_peso = "P"
public constant string kki_tipo_prezzo_a_metro_cubo = "M"
public constant string kki_tipo_prezzo_a_collo = "C"
public constant string kki_tipo_prezzo_a_pedana = "B"
public constant string kki_tipo_prezzo_a_corpo = "I"

//--- Tipo Magazzino
public constant int kki_tipo_magazzino_standard = 2 // genera sempre i barcode di trattamento
public constant int kki_tipo_magazzino_speciale = 1 // ex magazzino 1, ora buono x il materiale senza barcode 
public constant int kki_tipo_magazzino_altro = 3
public constant int kki_tipo_magazzino_nessuno = 9

//--- Prezzi Condizioni: Ipotesi tipo Condizioni
public constant string kki_cond_fatt_Qta_colli_lotto = "C"
public constant string kki_cond_fatt_Qta_colli_anno = "A"
public constant string kki_cond_fatt_mand = "M"
public constant string kki_cond_fatt_fatt_tot = "F"
//--- Prezzi Condizioni: segno del confronto
public constant string kki_cond_fatt_segno_eq = "="  
public constant string kki_cond_fatt_segno_ls = "<"  
public constant string kki_cond_fatt_segno_gt = ">"
public constant string kki_cond_fatt_segno_ne = "!"  //diverso

public constant string kki_trattamenti_speciali_no = "N"
//--- flag 'CAMPIONE' 
public constant string kki_campione_si = "S"
public constant string kki_campione_no = "N"

//--- flag 'ATTIVO' e altri STATI
public constant string kki_attivo_si = "S"
public constant string kki_attivo_no = "N"
public constant string kki_attivo_da_fare = "D"   //stato impostato ad esempio dopo carico da cntr Commerciale

//--- flag 'ATTIVO' e altri STATI
public constant string kki_attiva_listino_pregruppi_si = "S"   //consente di gestire il listino con i sottocapitoli (tab listino_link_pregruppi)

//--- dw di caricamento del Listino
private constant string kki_dw_listino = "d_listino"


end variables

forward prototypes
public function integer autorizza_campi (ref datawindow kdw_listino)
public function st_esito tb_delete (st_tab_cond_fatt kst_tab_cond_fatt)
public function st_esito select_x_key_lotto (ref st_tab_listino kst_tab_listino)
public function boolean tb_cond_fatt_gia_associato (ref st_tab_cond_fatt kst_tab_cond_fatt) throws uo_exception
public function st_esito anteprima_cond_fatt (ref datastore kdw_anteprima, st_tab_cond_fatt kst_tab_cond_fatt)
public function st_esito anteprima_cond_fatt (ref datawindow kdw_anteprima, st_tab_cond_fatt kst_tab_cond_fatt)
public subroutine if_isnull (st_tab_listino kst_tab_listino)
public function st_esito get_ultimo_id (ref st_tab_listino kst_tab_listino)
public function boolean if_listino_gia_in_rif (ref st_tab_listino kst_tab_listino)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_listino kst_tab_listino)
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_listino kst_tab_listino)
public subroutine get_prezzi (ref st_tab_listino kst_tab_listino, ref st_tab_cond_fatt kst_tab_cond_fatt[3]) throws uo_exception
public function st_esito get_tipo_listino (ref st_tab_listino kst_tab_listino)
public function st_esito get_id_listino (ref st_tab_listino kst_tab_listino)
private function boolean get_prezzo_1 (ref st_tab_listino kst_tab_listino, ref st_tab_armo kst_tab_armo, ref st_tab_cond_fatt kst_tab_cond_fatt, ref kuf_armo kuf1_armo, ref kuf_fatt kuf1_fatt) throws uo_exception
private function boolean get_prezzo_2 (ref st_tab_listino kst_tab_listino, ref st_tab_armo kst_tab_armo, ref st_tab_cond_fatt kst_tab_cond_fatt, ref kuf_armo kuf1_armo, ref kuf_fatt kuf1_fatt) throws uo_exception
public function boolean get_prezzo (ref st_tab_listino kst_tab_listino, ref st_tab_armo kst_tab_armo) throws uo_exception
public function long tb_add (st_tab_listino kst_tab_listino) throws uo_exception
public function boolean link_call_imvc (ref st_tab_listino kst_tab_listino, st_open_w kst_open_w_arg) throws uo_exception
public function boolean set_stato_annullato_massivo (st_tab_listino kast_tab_listino, st_tab_contratti kast_tab_contratti) throws uo_exception
public function boolean set_stato_attivo_massivo (st_tab_listino kast_tab_listino, st_tab_contratti kast_tab_contratti) throws uo_exception
public function boolean if_listino_x_cod_clie (ref st_tab_listino kst_tab_listino) throws uo_exception
public function string tb_gia_fatturato (ref st_tab_listino kst_tab_listino) throws uo_exception
public function string tb_delete (st_tab_listino kst_tab_listino) throws uo_exception
public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception
public function st_esito u_check_dati_cond_fatt (datastore ads_inp)
public function boolean if_id_cond_fatt_ok (ref st_tab_listino ast_tab_listino, ref st_tab_armo ast_tab_armo) throws uo_exception
public function boolean if_attiva_listino_pregruppi (ref st_tab_listino ast_tab_listino) throws uo_exception
public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception
public function string get_attivo (st_tab_listino ast_tab_listino) throws uo_exception
public function string get_cod_art (st_tab_listino ast_tab_listino) throws uo_exception
public function long get_contratto (st_tab_listino ast_tab_listino) throws uo_exception
public function long get_cod_cli (ref st_tab_listino ast_tab_listino) throws uo_exception
public subroutine get_dati_x_armo (ref st_tab_listino ast_tab_listino) throws uo_exception
public function integer get_occup_ped (st_tab_listino ast_tab_listino) throws uo_exception
public function double get_peso_kg (st_tab_listino ast_tab_listino) throws uo_exception
public function double get_m_cubi_f (st_tab_listino ast_tab_listino) throws uo_exception
public subroutine get_prezzi123 (ref st_tab_listino kst_tab_listino) throws uo_exception
public function boolean select_riga (ref st_tab_listino kst_tab_listino) throws uo_exception
public function long tb_duplica (ref st_tab_listino ast_tab_listino) throws uo_exception
public function boolean set_stato_non_attivo (st_tab_listino ast_tab_listino) throws uo_exception
public function string get_cod_art_x_contratto (st_tab_listino ast_tab_listino) throws uo_exception
public function string get_e1litm (st_tab_listino ast_tab_listino) throws uo_exception
public function integer if_e1litm_x_contratto (st_tab_listino ast_tab_listino) throws uo_exception
public function long tb_gia_spedito (st_tab_listino kst_tab_listino) throws uo_exception
public function long get_id_max () throws uo_exception
public function long get_id_listini (ref st_tab_listino kst_tab_listino[]) throws uo_exception
end prototypes

public function integer autorizza_campi (ref datawindow kdw_listino);//---
//--- Controllo dei campi se autorizzati alla visulaizzazione
//---
uint k_ctr=0


//if kGuo_utente.get_pwd() > kk_pwd_liv_2 then
	k_ctr++
	kdw_listino.modify("prezzo.visible='1'")
//end if


return k_ctr

end function

public function st_esito tb_delete (st_tab_cond_fatt kst_tab_cond_fatt);//
//====================================================================
//=== Cancella il rek dalla tabella CONDIZIONI PREZZI LISTINO (COND_FATT)
//=== 
//===
//=== Input: st_tab_cond_fatt    con id valorizzato 
//=== Ritorna ST_ESITO  come da standard
//===
//====================================================================
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	try 
//--- controllo se CONDIZIONE gia' associata a Listino
		if tb_cond_fatt_gia_associato(kst_tab_cond_fatt) then
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Cancellazione Condizione non possibile perche' gia associato a Prezzo in Listino~n~rPrego togliere prima la Condizione dai Prezzi." 
			
		else
			delete from cond_fatt
						where id = :kst_tab_cond_fatt.id ;
			
			if sqlca.sqlcode <> 0 then
				if sqlca.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = "Errore in Cancellaz.Condizione Prezzo (ID=" + string(kst_tab_cond_fatt.id)+")~n~r" + trim(sqlca.SQLErrText) 
		
				end if
			end if
		
			if sqlca.sqlcode < 0 then
				if kst_tab_cond_fatt.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_cond_fatt.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_cond_fatt.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_cond_fatt.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
				end if
			end if
		end if
		
	catch (uo_exception kuo_exception )
		kst_esito = kuo_exception.get_st_esito( )

	end try

return kst_esito




end function

public function st_esito select_x_key_lotto (ref st_tab_listino kst_tab_listino);//
//====================================================================
//=== Select dei campi che servono per associazione al RIFERIMENTO di entrata 
//=== 
//=== Input: st_tab_listino.id     Output: st_tab_listino  con diversi campi valorizzati                
//=== Ritorna ST_ESITO
//===           		  
//====================================================================
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=
	  SELECT listino.cod_cli
	  			,listino.cod_art 
	  			,listino.dose 
	  			,listino.mis_z 
	  			,listino.mis_x 
	  			,listino.mis_y 
	  into
	  			:kst_tab_listino.cod_cli
	  			,:kst_tab_listino.cod_art 
	  			,:kst_tab_listino.dose 
	  			,:kst_tab_listino.mis_z 
	  			,:kst_tab_listino.mis_x 
	  			,:kst_tab_listino.mis_y 
   	 FROM listino
   WHERE  listino.id = :kst_tab_listino.id 
			  using sqlca
		;		

   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino (ID=" +string(kst_tab_listino.id)+" )~n~r" + trim(sqlca.SQLErrText) 

		end if
	end if


return kst_esito


end function

public function boolean tb_cond_fatt_gia_associato (ref st_tab_cond_fatt kst_tab_cond_fatt) throws uo_exception;//
//====================================================================
//=== Controlla se Listino contiene associazioni alla Condizione
//=== 
//=== Input: st_tab_cond_fatt.id     
//=== Ritorna boolean: TRUE=gia' associato; 
//===       
//====================================================================

boolean k_return = false
long k_ctr = 0
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


if  kst_tab_cond_fatt.id = 0 or isnull (kst_tab_cond_fatt.id) then
	
	kst_esito.esito = kkg_esito.err_formale
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.sqlerrtext = sqlca.sqlerrtext
	kguo_exception.set_esito(kst_esito) 
	kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_err_int)
	throw kguo_exception

else

	select count(*)
	     into :k_ctr
			FROM listino
			WHERE
				id_cond_fatt_1 = :kst_tab_cond_fatt.id
				or id_cond_fatt_2 = :kst_tab_cond_fatt.id
				or id_cond_fatt_3 = :kst_tab_cond_fatt.id
              using sqlca				;		
		
	if sqlca.sqlCode < 0 then
		
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = sqlca.sqlerrtext
		kguo_exception.set_esito(kst_esito) 
		kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_db_ko)
		throw kguo_exception
	else
		if k_ctr > 0 then
			k_return = true
		end if
		
	end if
end if


return k_return

end function

public function st_esito anteprima_cond_fatt (ref datastore kdw_anteprima, st_tab_cond_fatt kst_tab_cond_fatt);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore su cui fare l'anteprima
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
kst_open_w.id_programma = kkg_id_programma_listini

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
		if kdw_anteprima.dataobject =  kki_anteprima_cond_fatt_dw  then
			if kdw_anteprima.object.cod_cli[1] = kst_tab_cond_fatt.cod_cli  then
				kst_tab_cond_fatt.cod_cli = 0 
			end if
		end if
	end if

	if kst_tab_cond_fatt.cod_cli > 0 then
	
			kdw_anteprima.dataobject =  kki_anteprima_cond_fatt_dw
			kdw_anteprima.settransobject(sqlca)
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_cond_fatt.cod_cli)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna Condizione da visualizzare: ~n~r" + "nessun Codice Cliente indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

end function

public function st_esito anteprima_cond_fatt (ref datawindow kdw_anteprima, st_tab_cond_fatt kst_tab_cond_fatt);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datastore su cui fare l'anteprima
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
kst_open_w.id_programma = kkg_id_programma_listini

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
		if kdw_anteprima.dataobject = kki_anteprima_cond_fatt_dw  then
			if kdw_anteprima.object.cod_cli[1] = kst_tab_cond_fatt.cod_cli  then
				kst_tab_cond_fatt.cod_cli = 0 
			end if
		end if
	end if

	if kst_tab_cond_fatt.cod_cli > 0 then
	
			kdw_anteprima.dataobject = kki_anteprima_cond_fatt_dw
			kdw_anteprima.settransobject(sqlca)
	
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
			destroy kuf1_utility
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_cond_fatt.cod_cli)
	
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessuna Condizione da visualizzare: ~n~r" + "nessun Codice Cliente indicato"
			kst_esito.esito = kkg_esito.blok
			
		end if
end if


return kst_esito

end function

public subroutine if_isnull (st_tab_listino kst_tab_listino);//---
//--- toglie i NULL ai campi della tabella 
//---
  
if isnull(kst_tab_listino.attivo ) then kst_tab_listino.attivo = kki_attivo_NO
if isnull(kst_tab_listino.campione ) then kst_tab_listino.campione = kki_campione_no
if isnull(kst_tab_listino.cod_art ) then kst_tab_listino.cod_art = " "
if isnull(kst_tab_listino.cod_cli ) then kst_tab_listino.cod_cli = 0
if isnull(kst_tab_listino.contratto ) then kst_tab_listino.contratto = 0
if isnull(kst_tab_listino.dose ) then kst_tab_listino.dose = 0
if isnull(kst_tab_listino.id ) then kst_tab_listino.id = 0
if isnull(kst_tab_listino.id_parent ) then kst_tab_listino.id_parent = 0
if isnull(kst_tab_listino.id_cond_fatt_1 ) then kst_tab_listino.id_cond_fatt_1 = 0
if isnull(kst_tab_listino.id_cond_fatt_2 ) then kst_tab_listino.id_cond_fatt_2 = 0
if isnull(kst_tab_listino.id_cond_fatt_3 ) then kst_tab_listino.id_cond_fatt_3 = 0
if isnull(kst_tab_listino.m_cubi_f ) then kst_tab_listino.m_cubi_f = 0
if isnull(kst_tab_listino.magazzino ) then kst_tab_listino.magazzino = 0
if isnull(kst_tab_listino.mis_x ) then kst_tab_listino.mis_x = 0
if isnull(kst_tab_listino.mis_y ) then kst_tab_listino.mis_y = 0
if isnull(kst_tab_listino.mis_z ) then kst_tab_listino.mis_z = 0
if isnull(kst_tab_listino.occup_ped ) then kst_tab_listino.occup_ped = 0
if isnull(kst_tab_listino.peso_kg ) then kst_tab_listino.peso_kg = 0
if isnull(kst_tab_listino.prezzo ) then kst_tab_listino.prezzo = 0
if isnull(kst_tab_listino.prezzo_2 ) then kst_tab_listino.prezzo_2 = 0
if isnull(kst_tab_listino.prezzo_3 ) then kst_tab_listino.prezzo_3 = 0
if isnull(kst_tab_listino.tipo ) then kst_tab_listino.tipo = kki_tipo_prezzo_a_collo
if isnull(kst_tab_listino.travaso ) then kst_tab_listino.travaso = "N"
if isnull(kst_tab_listino.attiva_listino_pregruppi ) then kst_tab_listino.attiva_listino_pregruppi = "N"
if isnull(kst_tab_listino.e1litm) then kst_tab_listino.e1litm = ""



end subroutine

public function st_esito get_ultimo_id (ref st_tab_listino kst_tab_listino);//
//====================================================================
//=== Torna l'ultimo ID caricato 
//=== 
//=== Input: st_tab_listino non valorizzata     Output: st_tab_listino.id                  
//=== Ritorna ST_ESITO
//===           		  
//====================================================================
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=
	  SELECT max(listino.id)
	  into
	  			:kst_tab_listino.id
   	 FROM listino
			  using sqlca;		

   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino (cercato MAX ID) ~n~r" + trim(sqlca.SQLErrText) 

		end if
	end if


return kst_esito


end function

public function boolean if_listino_gia_in_rif (ref st_tab_listino kst_tab_listino);//
//====================================================================
//=== Cerca se nei Riferimenti c'e' il listino indicato
//=== 
//=== Input: st_tab_listino.id     Output: boolean :  TRUE listino trovato
//=== Ritorna ST_ESITO
//===           		  
//====================================================================
boolean k_trovato = false
long k_ctr=0
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=
//	 SELECT  count(*)
//		into :k_ctr
//		 FROM ((
//					listino left outer JOIN armo on
//								 listino.cod_art = armo.art
//						 and listino.dose = armo.dose
//						 and listino.mis_z = armo.larg_2
//						 and listino.mis_x = armo.lung_2
//						 and listino.mis_y = armo.alt_2)
//						left OUTER JOIN meca
//				ON armo.id_meca = meca.id)
//		WHERE 
//				( listino.id = :kst_tab_listino.id ) and
//				( meca.data_int >= '01.01.2000' ) and 
//				( meca.clie_3 = listino.cod_cli ) and 
//				( listino.contratto = 0 or meca.contratto = listino.contratto )
//		 using sqlca
	 SELECT  count(*)
		into :k_ctr
		 FROM armo
		 WHERE 
				( armo.id_listino = :kst_tab_listino.id ) 
		 using sqlca
			;		

   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino (ID=" +string(kst_tab_listino.id)+" )~n~r" + trim(sqlca.SQLErrText) 

		end if
	else
		if k_ctr > 0 then
			k_trovato = true
		end if
	end if


return k_trovato


end function

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_listino kst_tab_listino);//
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
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_listino.id > 0 then

		kdw_anteprima.dataobject = "d_listino"		
		kdw_anteprima.settransobject(sqlca)

		kuf1_utility = create kuf_utility
		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_listino.id)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Listino da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_listino kst_tab_listino);//====================================================================
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
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_listino.id > 0 then

		kdw_anteprima.dataobject = "d_listino"		
		kdw_anteprima.settransobject(sqlca)

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_listino.id)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Listino da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public subroutine get_prezzi (ref st_tab_listino kst_tab_listino, ref st_tab_cond_fatt kst_tab_cond_fatt[3]) throws uo_exception;//---
//--- Torna i Prezzi e le Condizioni
//--- Inp: st_tab_listino.id_listino
//--- Out: st_tab_listino con i prezzi 
//---        array st_tab_cond_fatt con i valori delle condizioni
//---
st_esito kst_esito
uo_exception kuo_exception

 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

this.if_isnull(kst_tab_listino)

if kst_tab_listino.id > 0 then
	
	select 
		listino.cod_cli
         ,listino.tipo 
         ,listino.prezzo 
		,listino.prezzo_2	
		,listino.prezzo_3	
		,listino.id_cond_fatt_1    	
		,listino.id_cond_fatt_2	   	
		,listino.id_cond_fatt_3	   	
         ,cf1.ipotesi_1   
         ,cf1.segno_1 
         ,cf1.valore_1   
         ,cf1.ipotesi_2   
         ,cf1.segno_2   
         ,cf1.valore_2   
         ,cf1.ipotesi_3   
         ,cf1.segno_3   
         ,cf1.valore_3   
         ,cf2.ipotesi_1   
         ,cf2.segno_1   
         ,cf2.valore_1   
         ,cf2.ipotesi_2   
         ,cf2.segno_2   
         ,cf2.valore_2   
         ,cf2.ipotesi_3   
         ,cf2.segno_3   
         ,cf2.valore_3   
         ,cf3.ipotesi_1   
         ,cf3.segno_1   
         ,cf3.valore_1   
         ,cf3.ipotesi_2   
         ,cf3.segno_2   
         ,cf3.valore_2   
         ,cf3.ipotesi_3   
         ,cf3.segno_3   
         ,cf3.valore_3   
	into
         :kst_tab_listino.cod_cli 
         ,:kst_tab_listino.tipo 
         ,:kst_tab_listino.prezzo 
		,:kst_tab_listino.prezzo_2	
		,:kst_tab_listino.prezzo_3	
		,:kst_tab_listino.id_cond_fatt_1    	
		,:kst_tab_listino.id_cond_fatt_2	   	
		,:kst_tab_listino.id_cond_fatt_3	   	
         ,:kst_tab_cond_fatt[1].ipotesi_1   
         ,:kst_tab_cond_fatt[1].segno_1 
         ,:kst_tab_cond_fatt[1].valore_1   
         ,:kst_tab_cond_fatt[1].ipotesi_2   
         ,:kst_tab_cond_fatt[1].segno_2   
         ,:kst_tab_cond_fatt[1].valore_2   
         ,:kst_tab_cond_fatt[2].ipotesi_3   
         ,:kst_tab_cond_fatt[2].segno_3   
         ,:kst_tab_cond_fatt[2].valore_3   
         ,:kst_tab_cond_fatt[2].ipotesi_1   
         ,:kst_tab_cond_fatt[2].segno_1   
         ,:kst_tab_cond_fatt[2].valore_1   
         ,:kst_tab_cond_fatt[2].ipotesi_2   
         ,:kst_tab_cond_fatt[2].segno_2   
         ,:kst_tab_cond_fatt[2].valore_2   
         ,:kst_tab_cond_fatt[2].ipotesi_3   
         ,:kst_tab_cond_fatt[2].segno_3   
         ,:kst_tab_cond_fatt[2].valore_3   
         ,:kst_tab_cond_fatt[3].ipotesi_1   
         ,:kst_tab_cond_fatt[3].segno_1   
         ,:kst_tab_cond_fatt[3].valore_1   
         ,:kst_tab_cond_fatt[3].ipotesi_2   
         ,:kst_tab_cond_fatt[3].segno_2   
         ,:kst_tab_cond_fatt[3].valore_2   
         ,:kst_tab_cond_fatt[3].ipotesi_3   
         ,:kst_tab_cond_fatt[3].segno_3   
         ,:kst_tab_cond_fatt[3].valore_3   
    FROM ((listino 
	     left outer join cond_fatt as cf1 on listino.id_cond_fatt_1 = cf1.id )
         left outer join cond_fatt as cf2 on listino.id_cond_fatt_2 = cf2.id )
         left outer join cond_fatt as cf3 on listino.id_cond_fatt_3 = cf3.id
	WHERE ( listino.id = :kst_tab_listino.id ) 
	using sqlca;	


	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode < 0 then
			kuo_exception = create uo_exception
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = sqlca.sqlerrtext
			kuo_exception.set_esito( kst_esito )
			throw  kuo_exception
		end if
	end if
	
end if


end subroutine

public function st_esito get_tipo_listino (ref st_tab_listino kst_tab_listino);//
//====================================================================
//=== Torna il Tipo Listino 
//=== 
//=== Input: st_tab_listino non valorizzata     Output: st_tab_listino.id              
//=== Ritorna ST_ESITO;  st_tab_listino.tipo
//===           		  
//====================================================================
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=
	  SELECT listino.tipo
	 	 into
	  			:kst_tab_listino.tipo
   	 FROM listino
		 where id = :kst_tab_listino.id
			  using sqlca;		

	if sqlca.sqlcode <> 0 then
		kst_tab_listino.tipo = " "
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino ~n~r" + trim(sqlca.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)

		end if
	end if


return kst_esito


end function

public function st_esito get_id_listino (ref st_tab_listino kst_tab_listino);//
//====================================================================
//=== Torna  ID_ del LISTINO del Movimento di entrata
//=== 
//=== Input: st_tab_listino  COD_CLI/COD_ART/DOSE/MIS_Z/MIS_X/MIS_Y   
//===           il ritorno valorizza st_tab_listino.id                 
//=== Ritorna ST_ESITO
//===           		  
//====================================================================
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//=
	if isnull(kst_tab_listino.COD_CLI) then kst_tab_listino.COD_CLI = 0
	if isnull(kst_tab_listino.COD_ART) then kst_tab_listino.COD_ART = ""
	if isnull(kst_tab_listino.DOSE) then kst_tab_listino.DOSE = 0
	if isnull(kst_tab_listino.MIS_Z) then kst_tab_listino.MIS_Z = 0
	if isnull(kst_tab_listino.MIS_X) then kst_tab_listino.MIS_X = 0
	if isnull(kst_tab_listino.MIS_Y) then kst_tab_listino.MIS_Y = 0

	if kst_tab_listino.DOSE = 0  then

//---- legge listino di servizio ATTIVO
		SELECT max(listino.id)
				  into :kst_tab_listino.id
				 FROM listino
				 where
								LISTINO.COD_CLI   = :kst_tab_listino.COD_CLI    and
								LISTINO.COD_ART = :kst_tab_listino.COD_ART    and
								(LISTINO.DOSE  = 0  or dose is null)
								 and attivo = 'S'
				  using sqlca;		
		
//--- se non trovato cerca x 'tutti i clienti'
		if sqlca.sqlcode <> 0 then
			
			SELECT max(listino.id)
				  into :kst_tab_listino.id
				 FROM listino
				 where
								(LISTINO.COD_CLI   = 0 or cod_cli is null)   and
								LISTINO.COD_ART = :kst_tab_listino.COD_ART    and
								(LISTINO.DOSE  = 0  or dose is null)
								 and attivo = 'S'
				  using sqlca;		
				  
			if sqlca.sqlcode <> 0 then
//---- Se Listino NON trovato AZZERA ID
				kst_tab_listino.id = 0
			end if				
		end if	
	else
				  
	//---- legge listino di produzione		
		SELECT max(listino.id)
					  into :kst_tab_listino.id
					 FROM listino
				 where
								LISTINO.COD_CLI   = :kst_tab_listino.COD_CLI    and
								LISTINO.COD_ART = :kst_tab_listino.COD_ART    and
								LISTINO.DOSE       = :kst_tab_listino.DOSE       and
								(LISTINO.MIS_Z    = :kst_tab_listino.MIS_Z  or
								 LISTINO.MIS_Z     = 0) and
								(LISTINO.MIS_X     = :kst_tab_listino.MIS_X  or
								 LISTINO.MIS_X     = 0) and
								(LISTINO.MIS_y     = :kst_tab_listino.MIS_y  or
								 LISTINO.MIS_y = 0)
					 and attivo = 'S'
				  using sqlca;		
	end if
	
   	if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino (cercato ID Listino) ~n~r" + trim(sqlca.SQLErrText) 

		end if
	end if


return kst_esito


end function

private function boolean get_prezzo_1 (ref st_tab_listino kst_tab_listino, ref st_tab_armo kst_tab_armo, ref st_tab_cond_fatt kst_tab_cond_fatt, ref kuf_armo kuf1_armo, ref kuf_fatt kuf1_fatt) throws uo_exception;//---
//--- Chiamata dal  "get_prezzo"  per Verificare le Condizioni Ipotesi 1, 2 e 3
//--- Input: st_tab_arfa con valorizzati:  id_listino, id_armo; kst_tab_armo.id_meca, kst_tab_cond_fatt tutto val, 
//---           e i rifer. alle funzioni (x non crearle tutte le volte): kuf_armo,  kuf_fatt
//--- Out: TRUE tutte le Ipotesi Verificate/ FALSE = prezzo da non valutare condizioni false
//---
boolean k_ipotesi = true 
boolean k_return = false
st_tab_cond_fatt kst_tab_cond_fatt_x


try 
	
	if len(trim(kst_tab_cond_fatt.ipotesi_1)) > 0 then
		kst_tab_cond_fatt_x.ipotesi_1 = trim(kst_tab_cond_fatt.ipotesi_1)
		kst_tab_cond_fatt_x.valore_1 = trim(kst_tab_cond_fatt.valore_1)
		kst_tab_cond_fatt_x.segno_1 = trim(kst_tab_cond_fatt.segno_1)
	
		k_ipotesi = this.get_prezzo_2( kst_tab_listino, kst_tab_armo, kst_tab_cond_fatt_x, kuf1_armo,  kuf1_fatt )
	end if

	if k_ipotesi and len(trim(kst_tab_cond_fatt.ipotesi_2)) > 0 and len(trim(kst_tab_cond_fatt.valore_2)) > 0 then
		kst_tab_cond_fatt_x.ipotesi_1 = trim(kst_tab_cond_fatt.ipotesi_2)
		kst_tab_cond_fatt_x.valore_1 = trim(kst_tab_cond_fatt.valore_2)
		kst_tab_cond_fatt_x.segno_1 = trim(kst_tab_cond_fatt.segno_2)
		
		k_ipotesi = this.get_prezzo_2( kst_tab_listino, kst_tab_armo, kst_tab_cond_fatt_x, kuf1_armo,  kuf1_fatt )
	end if

	if k_ipotesi and len(trim(kst_tab_cond_fatt.ipotesi_3)) > 0 and len(trim(kst_tab_cond_fatt.valore_3)) > 0 then
		kst_tab_cond_fatt_x.ipotesi_1 = trim(kst_tab_cond_fatt.ipotesi_3)
		kst_tab_cond_fatt_x.valore_1 = trim(kst_tab_cond_fatt.valore_3)
		kst_tab_cond_fatt_x.segno_1 = trim(kst_tab_cond_fatt.segno_3)

		k_ipotesi = this.get_prezzo_2( kst_tab_listino, kst_tab_armo, kst_tab_cond_fatt_x, kuf1_armo,  kuf1_fatt )

	end if
	
	k_return = k_ipotesi 


catch (uo_exception kuo_exception)
	throw kguo_exception

finally
	
end try

return k_return


end function

private function boolean get_prezzo_2 (ref st_tab_listino kst_tab_listino, ref st_tab_armo kst_tab_armo, ref st_tab_cond_fatt kst_tab_cond_fatt, ref kuf_armo kuf1_armo, ref kuf_fatt kuf1_fatt) throws uo_exception;//---
//--- Chiamata dal  "get_prezzo_1"  qui è il "motorino" di verifica delle singole codizioni
//--- Input: st_tab_listino con valorizzati:  cod_clie; kst_tab_armo.id_meca, st_tab_cod_fatt, 
//---           e i rifer. alle funzioni (x non crearle tutte le volte): kuf_armo,  kuf_fatt
//--- Out: TRUE = Ipotesi Verificata/ FALSE = non Verificata
//---
boolean k_return = false
int k_idx=0
st_tab_arfa kst_tab_arfa_1, kst_tab_arfa_cli
st_tab_meca kst_tab_meca, kst_tab_meca_1
st_tab_cond_fatt  kst_tab_cond_fatt_1 
st_esito kst_esito




try 
	
	
//---- legge colli del lotto
		choose case trim(kst_tab_cond_fatt.ipotesi_1)
				
			case this.kki_cond_fatt_Qta_colli_lotto
				
				if isnumber(trim(kst_tab_cond_fatt.valore_1)) then
					kst_tab_arfa_1.colli = long(trim(kst_tab_cond_fatt.valore_1))
				else
					kst_tab_arfa_1.colli = 0
				end if
				
				if kst_tab_arfa_1.colli = 0 then
					k_return=true
				else
					if kst_tab_arfa_1.colli > 0 then
						kst_tab_armo.colli_2 = kuf1_armo.get_colli_lotto(kst_tab_armo) //giugno.2016 get_colli_entrati_xbcode(kst_tab_armo)  // get dei colli entrati no dose zero
						choose case kst_tab_cond_fatt.segno_1 
							case this.kki_cond_fatt_segno_eq
								if kst_tab_armo.colli_2 = kst_tab_arfa_1.colli then
									k_return=true
								end if
							case this.kki_cond_fatt_segno_ls
								if kst_tab_armo.colli_2 < kst_tab_arfa_1.colli then
									k_return=true
								end if
							case this.kki_cond_fatt_segno_gt
								if kst_tab_armo.colli_2 > kst_tab_arfa_1.colli then
									k_return=true
								end if
							case this.kki_cond_fatt_segno_ne
								if kst_tab_armo.colli_2 <> kst_tab_arfa_1.colli then
									k_return=true
								end if
						end choose
					end if
				end if
				
//---- legge colli annuali x cliente 		
			case this.kki_cond_fatt_Qta_colli_anno
				if isnumber(trim(kst_tab_cond_fatt.valore_1)) then
					kst_tab_arfa_1.colli = long(trim(kst_tab_cond_fatt.valore_1))
				else
					kst_tab_arfa_1.colli = 0
				end if
				
				if kst_tab_arfa_1.colli = 0 then
					k_return=true
				else
					if kst_tab_arfa_1.colli > 0 then
					
						kst_tab_meca.clie_3 = kst_tab_listino.cod_cli 
						kst_tab_armo.colli_2 = kuf1_armo.get_colli_anno_x_clie_3( kst_tab_meca )
						if kst_esito.esito = kkg_esito.db_ko then
							kguo_exception.set_esito( kst_esito )
							throw kguo_exception
						else
							choose case  kst_tab_cond_fatt.segno_1 
								case this.kki_cond_fatt_segno_eq
									if kst_tab_armo.colli_2 = kst_tab_arfa_1.colli then
										k_return=true
									end if
								case this.kki_cond_fatt_segno_ls
									if kst_tab_armo.colli_2 < kst_tab_arfa_1.colli then
										k_return=true
									end if
								case this.kki_cond_fatt_segno_gt
									if kst_tab_armo.colli_2 > kst_tab_arfa_1.colli then
										k_return=true
									end if
								case this.kki_cond_fatt_segno_ne
									if kst_tab_armo.colli_2 <> kst_tab_arfa_1.colli then
										k_return=true
									end if
							end choose
						end if
					end if
				end if
				
//--- legge Mandante						
			case this.kki_cond_fatt_mand
				if isnumber(trim(kst_tab_cond_fatt.valore_1)) then
					kst_tab_meca_1.clie_1 = long(trim(kst_tab_cond_fatt.valore_1))
				else
					kst_tab_meca_1.clie_1 = 0
				end if
				
				if kst_tab_arfa_1.colli = 0 then
					k_return=true
				else
					if kst_tab_meca_1.clie_1 > 0 then
						kst_tab_meca.id = kst_tab_armo.id_meca
						kuf1_armo.get_clie( kst_tab_meca )
	
						choose case  kst_tab_cond_fatt.segno_1 
							case this.kki_cond_fatt_segno_eq
								if kst_tab_meca.clie_1 =  kst_tab_meca_1.clie_1 then
									k_return=true
								end if
							case this.kki_cond_fatt_segno_ls
								if kst_tab_meca_1.clie_1 < kst_tab_meca_1.clie_1 then
									k_return=true
								end if
							case this.kki_cond_fatt_segno_gt
								if kst_tab_meca_1.clie_1 > kst_tab_meca_1.clie_1 then
									k_return=true
								end if
							case this.kki_cond_fatt_segno_ne
								if kst_tab_meca_1.clie_1 <> kst_tab_meca_1.clie_1 then
									k_return=true
								end if
						end choose
	
					end if
				end if				

//--- legge Fatturato Annuale						
			case this.kki_cond_fatt_fatt_tot
				if isnumber(trim(kst_tab_cond_fatt.valore_1)) then
					kst_tab_arfa_1.prezzo_t = long(trim(kst_tab_cond_fatt.valore_1))
				else
					kst_tab_arfa_1.prezzo_t = 0
				end if
				
				if kst_tab_arfa_1.prezzo_t = 0 then
					k_return=true
				else
					if kst_tab_arfa_1.prezzo_t <> 0 and not isnull(kst_tab_arfa_1.prezzo_t) then
						
						kst_tab_arfa_cli.clie_3 = kst_tab_listino.cod_cli
						kst_tab_arfa_cli.prezzo_t = kuf1_fatt.get_importo_t_anno_x_clie_3( kst_tab_arfa_cli) 
	
						choose case  kst_tab_cond_fatt.segno_1 
							case this.kki_cond_fatt_segno_eq
								if kst_tab_arfa_cli.prezzo_t =  kst_tab_arfa_1.prezzo_t then
									k_return=true
								end if
							case this.kki_cond_fatt_segno_ls
								if kst_tab_arfa_cli.prezzo_t < kst_tab_arfa_1.prezzo_t then
									k_return=true
								end if
							case this.kki_cond_fatt_segno_gt
								if kst_tab_arfa_cli.prezzo_t > kst_tab_arfa_1.prezzo_t then
									k_return=true
								end if
							case this.kki_cond_fatt_segno_ne
								if kst_tab_arfa_cli.prezzo_t <> kst_tab_arfa_1.prezzo_t then
									k_return=true
								end if
						end choose
	
					end if
				end if				
		
		end choose
		

		
catch (uo_exception kuo_exception)
	throw kguo_exception

	
end try



return k_return

end function

public function boolean get_prezzo (ref st_tab_listino kst_tab_listino, ref st_tab_armo kst_tab_armo) throws uo_exception;//---
//--- Trova il giusto prezzo per l'articolo di magazzino movimentato: chiama GET_PREZZO_1 --> GET_PREZZO_2
//--- Input: st_tab_listino.ID, COD_CLI,  st_tab_armo.ID_ARMO, ID_MECA (opzionale)  
//---         In uscita: st_tab_listino.prezzo (se rit=TRUE)
//--- Out: TRUE=prezzo trovato, FALSE=nessun prezzo valido Trovato
//--- Errore Lancia EXCEPTION: uo_exception
//---
boolean k_return = false
st_tab_meca kst_tab_meca 
st_tab_cond_fatt kst_tab_cond_fatt[3], kst_tab_cond_fatt_1 
st_esito kst_esito
kuf_armo kuf1_armo
kuf_fatt kuf1_fatt



try 
	
	if kst_tab_listino.id > 0 then
		
//---- legge i prezzi di listino possibili x il cliente-articolo 	Torna l'ARRAY con le condizioni	
		this.get_prezzi( kst_tab_listino, kst_tab_cond_fatt[] )

		kuf1_armo = create kuf_armo
		kuf1_fatt = create kuf_fatt

		if kst_tab_armo.id_armo > 0 then
			if kst_tab_armo.id_meca = 0 or isnull(kst_tab_armo.id_meca) then 
//---- piglia id del lotto 		
				kst_esito = kuf1_armo.get_id_meca_da_id_armo(kst_tab_armo)
				if kst_esito.esito = kkg_esito.db_ko then
					kguo_exception.set_esito( kst_esito )
					throw kguo_exception
				end if
			end if
		else
			kst_tab_armo.id_meca = 0
			kst_tab_armo.id_armo = 0
		end if
		
//		kst_tab_listino.prezzo = 0

//--- controllo se OK il primo prezzo
		if kst_tab_listino.prezzo > 0 then

			kst_tab_cond_fatt_1 = kst_tab_cond_fatt[1]
				
			if this.get_prezzo_1( kst_tab_listino, kst_tab_armo, kst_tab_cond_fatt_1, kuf1_armo,  kuf1_fatt ) then
				 k_return = true
			else

//--- Se no il primo prezzo controllo se OK il secondo prezzo
				if kst_tab_listino.prezzo_2 > 0 then
		
					kst_tab_cond_fatt_1 = kst_tab_cond_fatt[2]
						
					if this.get_prezzo_1( kst_tab_listino, kst_tab_armo, kst_tab_cond_fatt_1, kuf1_armo,  kuf1_fatt ) then
						
						k_return = true
						kst_tab_listino.prezzo = kst_tab_listino.prezzo_2
					else

//--- Se no il secondo prezzo controllo se OK il terzo prezzo
						if kst_tab_listino.prezzo_3 > 0 then
				
							kst_tab_cond_fatt_1 = kst_tab_cond_fatt[3]
								
							if this.get_prezzo_1( kst_tab_listino, kst_tab_armo, kst_tab_cond_fatt_1, kuf1_armo, kuf1_fatt ) then
								
								k_return = true
								kst_tab_listino.prezzo = kst_tab_listino.prezzo_3
							end if
						end if
					end if
				end if
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kguo_exception

finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_fatt) then destroy kuf1_fatt
	
end try

return k_return

end function

public function long tb_add (st_tab_listino kst_tab_listino) throws uo_exception;//
//====================================================================
//=== Aggiunge il rek nella tabella LISTINO
//=== 
//=== Inp: st_tab_listino - valorizzata
//=== Ritorna: ID caricato
//=== Lancia EXCEPTION//=== Ritorna: TRUE=OK; FALSE=errore grave non eliminato; 
//===  
//====================================================================
//
long k_return = 0
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza




kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
kst_open_w.id_programma = kkg_id_programma.listini

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Inserimento 'Listino' non Autorizzato: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	kst_tab_listino.id = 0 
	
//--- imposto dati utente e data aggiornamento
	kst_tab_listino.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_listino.x_utente = kGuf_data_base.prendi_x_utente()
	
//--- toglie valori NULL
	if_isnull(kst_tab_listino)
// id,
		INSERT INTO listino  
					(   
					  cod_cli,   
					  cod_art,   
					  dose,   
					  prezzo,   
					  id_cond_fatt_1,   
					  prezzo_2,   
					  id_cond_fatt_2,   
					  prezzo_3,   
					  id_cond_fatt_3,   
					  tipo,   
					  campione,   
					  mis_x,   
					  mis_y,   
					  mis_z,   
					  occup_ped,   
					  travaso,   
					  peso_kg,   
					  magazzino,   
					  m_cubi_f,   
					  attivo,   
					  contratto,   
					  contratto_co_data_ins,   
					  id_contratto_co,   
					  attiva_listino_pregruppi,
					  e1litm,
					  x_datins,   
					  x_utente )  
		  VALUES (    
					  :kst_tab_listino.cod_cli,   
					  :kst_tab_listino.cod_art,   
					  :kst_tab_listino.dose,   
					  :kst_tab_listino.prezzo,   
					  :kst_tab_listino.id_cond_fatt_1,   
					  :kst_tab_listino.prezzo_2,   
					  :kst_tab_listino.id_cond_fatt_2,   
					  :kst_tab_listino.prezzo_3,   
					  :kst_tab_listino.id_cond_fatt_3,   
					  :kst_tab_listino.tipo,   
					  :kst_tab_listino.campione,   
					  :kst_tab_listino.mis_x,   
					  :kst_tab_listino.mis_y,   
					  :kst_tab_listino.mis_z,   
					  :kst_tab_listino.occup_ped,   
					  :kst_tab_listino.travaso,   
					  :kst_tab_listino.peso_kg,   
					  :kst_tab_listino.magazzino,   
					  :kst_tab_listino.m_cubi_f,   
					  :kst_tab_listino.attivo,   
					  :kst_tab_listino.contratto,   
					  :kst_tab_listino.contratto_co_data_ins,   
					  :kst_tab_listino.id_contratto_co,   
					  :kst_tab_listino.attiva_listino_pregruppi,
					  :kst_tab_listino.e1litm,
					  :kst_tab_listino.x_datins,   
					  :kst_tab_listino.x_utente )  
			using kguo_sqlca_db_magazzino ;
		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Inserimento 'Listino', errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
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
		k_return = get_id_max()
		//k_return = long(kguo_sqlca_db_magazzino.SQLReturnData)
//		k_return = long(kguo_sqlca_db_magazzino.sqlerrd[1]

//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			if kst_tab_listino.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_listino.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		else
			if kst_tab_listino.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_listino.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
	end if

	
end if


return k_return

end function

public function boolean link_call_imvc (ref st_tab_listino kst_tab_listino, st_open_w kst_open_w_arg) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------------
//--- Chiama pgm giusto a seconda della modalita  Inserim./Modifica/Visualizzaz./Cancellaz.
//---
//--- Inp: st_tab_listino  cod_cli e/o cod_art e/o contratto 
//---		 st_open_w.flag_modalita (come da standard kg_flag_modalita_....)
//--- Out: TRUE = tutto OK
//--- 
//--- Lancia EXCEPTION con ST_ESITO, standard 
//--- 
//--------------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



	if isnull(kst_tab_listino.cod_cli) then kst_tab_listino.cod_cli = 0
	if isnull(kst_tab_listino.cod_art) or len(trim(kst_tab_listino.cod_art))= 0 then kst_tab_listino.cod_art = "*"
	if isnull(kst_tab_listino.contratto) then kst_tab_listino.contratto = 0

//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=vedi sotto
		K_st_open_w.id_programma = get_id_programma(kst_open_w_arg.flag_modalita) //kkg_id_programma_listini_l
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kst_open_w_arg.flag_modalita
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(kst_tab_listino.cod_cli) // cod cliente
		K_st_open_w.key2 = trim(kst_tab_listino.cod_art)  // cod articolo 
		K_st_open_w.key3 = " " // 
		K_st_open_w.key4 = string(kst_tab_listino.contratto)  // cod contratto
		K_st_open_w.key5 = " " //
		K_st_open_w.key6 = " " //
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
		
		k_return = true
		
//		kuo_exception = create uo_exception
//		kuo_exception.setmessage( "Nessun valore disponibile. " )
//		throw kuo_exception
		
		

SetPointer(kp_oldpointer)



return k_return

end function

public function boolean set_stato_annullato_massivo (st_tab_listino kast_tab_listino, st_tab_contratti kast_tab_contratti) throws uo_exception;//
//-----------------------------------------------------------------------------------------------------
//--- Annulla rek nella tabella LISTINO fino alla data scadenza contratti CO
//--- 
//--- Inp: kast_tab_contratti - data_scad 
//---        kast_tab_listino - esegui_commit
//--- Ritorna: TRUE=OK; FALSE=errore grave 
//--- Lancia EXCEPTION
//---  
//-----------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_tab_listino kst_tab_listino, kst_tab_listino_orig
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza



kst_tab_listino = kast_tab_listino

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica 'Listini' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

//--- imposto dati utente e data aggiornamento
	kst_tab_listino.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_listino.x_utente = kGuf_data_base.prendi_x_utente()
	kst_tab_listino.attivo = kki_attivo_no
 	kst_tab_listino_orig.attivo = kki_attivo_si
	
	update listino 
			set attivo = :kst_tab_listino.attivo
				 ,x_datins = :kst_tab_listino.x_datins 
				 ,x_utente = :kst_tab_listino.x_utente 
		 where 
		     attivo = :kst_tab_listino_orig.attivo
		    and contratto in 
		   		(
					select codice from contratti
					  where data_scad <= :kast_tab_contratti.data_scad
				)	  
		 using sqlca;
		

	if sqlca.sqlcode < 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Annulla 'Listini', errore: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	
	else

		if sqlca.sqlcode = 0 then

//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_listino.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_listino.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_listino.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_listino.st_tab_g_0.esegui_commit) then
					kst_esito = kGuf_data_base.db_commit_1( )
				end if
			end if
		end if
	end if

	if kst_esito.esito = kkg_esito.ok then
		k_return = true
	else	
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
end if


return k_return

end function

public function boolean set_stato_attivo_massivo (st_tab_listino kast_tab_listino, st_tab_contratti kast_tab_contratti) throws uo_exception;//
//-----------------------------------------------------------------------------------------------------
//--- ATTIVA rek nella tabella LISTINO fino dalla data di scadenza contratti CO
//--- 
//--- Inp: kast_tab_contratti - data_scad 
//---        kast_tab_listino - esegui_commit
//--- Ritorna: TRUE=OK; FALSE=errore grave 
//--- Lancia EXCEPTION
//---  
//-----------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_tab_listino kst_tab_listino, kst_tab_listino_orig
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza


kst_tab_listino = kast_tab_listino

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w.flag_modalita = kkg_flag_modalita.modifica
kst_open_w.id_programma = get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_autorizza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_autorizza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Modifica 'Listini' non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

//--- imposto dati utente e data aggiornamento
	kst_tab_listino.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_listino.x_utente = kGuf_data_base.prendi_x_utente()
	kst_tab_listino.attivo = kki_attivo_si
	kst_tab_listino_orig.attivo = kki_attivo_no 
	
	update listino 
			set attivo = :kst_tab_listino.attivo
				 ,x_datins = :kst_tab_listino.x_datins 
				 ,x_utente = :kst_tab_listino.x_utente 
		 where 
		     attivo = :kst_tab_listino_orig.attivo
		     and contratto in 
		   		(
					select codice from contratti
					  where data_scad >= :kast_tab_contratti.data_scad
				)	  
		 using sqlca;
		

	if sqlca.sqlcode < 0 then
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Attivazione 'Listini', errore: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	
	else

		if sqlca.sqlcode = 0 then
//---- COMMIT....	
			if kst_esito.esito = kkg_esito.db_ko then
				if kst_tab_listino.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_listino.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
				end if
			else
				if kst_tab_listino.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_listino.st_tab_g_0.esegui_commit) then
					kst_esito = kGuf_data_base.db_commit_1( )
				end if
			end if
		end if
	end if

	if kst_esito.esito = kkg_esito.ok then
		k_return = true
	else	
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
end if


return k_return

end function

public function boolean if_listino_x_cod_clie (ref st_tab_listino kst_tab_listino) throws uo_exception;//
//---------------------------------------------------------------------------------
//--- Verifica presenza Listino x cod.cliente e stato
//--- 
//--- Inp: st_tab_listino  cod_cli / attivo (se non indicato torna tutti) 
//--- Out:               
//--- Ritorna TRUE=listino presente (almeno UNO)
//---           		  
//---------------------------------------------------------------------------------
boolean k_return=false
int k_ctr=0
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if isnull(kst_tab_listino.attivo) or len(trim(kst_tab_listino.attivo)) = 0 then kst_tab_listino.attivo = ""

	SELECT distinct 1
	 	 into :k_ctr
			 FROM listino
			 where cod_cli = :kst_tab_listino.cod_cli
					 and (:kst_tab_listino.attivo = "" or listino.attivo = :kst_tab_listino.attivo)
				  using sqlca;		

	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Verifica presenza Listino per l'anagrafica " + string(kst_tab_listino.cod_cli) +  "~n~r" + trim(sqlca.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if k_ctr > 0 then k_return = true

return k_return


end function

public function string tb_gia_fatturato (ref st_tab_listino kst_tab_listino) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Controlla se Listino ha movimenti ancora da fatturare
//--- 
//--- Ritorna I' char: 0=Nessuna movim da fatturare; 1=Movimenti ancora da fatturare
//---                 	 : dal 2' char in poi descrizione dell'errore
//---           		  
//--------------------------------------------------------------------------------------------------------------

string k_return = "0"
long k_num
date k_data
boolean k_open = false
st_esito kst_esito


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if  kst_tab_listino.id = 0 or isnull (kst_tab_listino.id) then
	
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Id del Listino non indicato. "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if

//--- Controllo se nelle ENTRATE ci sono rec da fatturare
	DECLARE entrate CURSOR FOR  
			  SELECT armo.num_int,
						armo.data_int
				 FROM armo
				WHERE id_listino = :kst_tab_listino.id 
							and (colli_2 <> colli_fatt 
									 or colli_fatt is null) 
				using kguo_sqlca_db_magazzino;		
//			  SELECT meca.num_int,
//						meca.data_int
//				 FROM meca inner join armo on
//						meca.num_int = armo.num_int and meca.data_int = armo.data_int
//				WHERE
//				meca.clie_3 = :kst_tab_listino.cod_cli
//				and meca.contratto > 0
//				and (colli_2 <> colli_fatt 
//				 or colli_fatt is null) 
//				and art = :kst_tab_listino.cod_art 
//				and dose = :kst_tab_listino.dose
//				and larg_2 = :kst_tab_listino.mis_z
//				and lung_2 = :kst_tab_listino.mis_x
//				and alt_2 = :kst_tab_listino.mis_y
//				;		
		
		
	open entrate;
	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlerrtext = "Errore durante verifica Colli fatturati  ~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
		kst_esito.sqlcode = sqlca.sqlcode
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if
	k_open = true

	fetch entrate INTO 	:k_num, :k_data ;
	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlerrtext = "Errore durante verifica Colli fatturati ~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlCode = 0 then
		if k_num > 0 then
			
			k_return = "1" + "Listino gia' presente e non ancora fatturato, come nel Riferimento:  ~n~r" + &
				"numero " + string(k_num, "#####") + " del " + &
				string(k_data, "dd/mmm/yy") + "~n~r" 	

		end if
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception


finally 
	if k_open then
		close entrate;
	end if

end try 


return k_return

end function

public function string tb_delete (st_tab_listino kst_tab_listino) throws uo_exception;//
//====================================================================
//=== Cancella il rek dalla tabella LISTINO
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
long k_num
date k_data
long k_if_estinto_no = 1
string k_return_1 = ""
st_esito kst_esito
datastore kds_1
kuf_listino_link_pregruppi kuf1_listino_link_pregruppi
st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi 
 

try 
	if  kst_tab_listino.id = 0 or isnull (kst_tab_listino.id) then
		
		k_return = "1" + "Id del Listino non indicato. "
	
	else
	
		kds_1 = create datastore
		kds_1.dataobject = "d_if_listino_cliente_estinto_no"
		kds_1.settransobject( kguo_sqlca_db_magazzino )
		k_if_estinto_no = kds_1.retrieve(kst_tab_listino.id )  
		
//--- Se è ESTINTO (o inesistente) allora posso cancellare
		if k_if_estinto_no > 0 then

			k_return = "1" + "Cliente " + string(kds_1.getitemnumber(1,"clienti_codice")) + " non Estinto - Eliminazione non consentita "
			
		else
//--- Se è ESTINTO (o inesistente) allora posso proseguire

//--- controllo se c'e' un movimento ancora da fatturare
			k_return_1 = tb_gia_fatturato(kst_tab_listino)
			
			if left(k_return_1,1) = "0" then
			
//--- elimina il Associazione gruppo-voci 
				kuf1_listino_link_pregruppi = create kuf_listino_link_pregruppi
				kst_tab_listino_link_pregruppi.id_listino = kst_tab_listino.id
				kst_tab_listino_link_pregruppi.st_tab_g_0.esegui_commit = "N"
				kuf1_listino_link_pregruppi.tb_delete_x_id_listino(kst_tab_listino_link_pregruppi)

//--- elimina Listino
				delete from listino
					where id = :kst_tab_listino.id
					using sqlca;
		//					where cod_cli = :kst_tab_listino.cod_cli
		//							and cod_art = :kst_tab_listino.cod_art
		//							and dose = :kst_tab_listino.dose
		//							and mis_x = :kst_tab_listino.mis_x
		//							and mis_y = :kst_tab_listino.mis_y
		//							and mis_z = :kst_tab_listino.mis_z
		//							;
				
				if sqlca.sqlCode <> 0 then
			
					k_return = "1" + SQLCA.SQLErrText
				else
		
					if kst_tab_listino.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_listino.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_commit_1( )
					end if
		
			
				end if
			else
				k_return = k_return_1
			end if
		end if
	end if


catch (uo_exception kuo1_exception)
	throw kuo1_exception
	

finally
	

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

st_tab_listino_voci kst_tab_listino_voci
st_tab_listino kst_tab_listino
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
pointer kp_oldpointer
kuf_listino_voci kuf1_listino_voci


kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "id_listino", "listino_id_parent", "id_parent"
		kst_tab_listino.id = adw_1.getitemnumber(adw_1.getrow(), a_campo_link )
		if kst_tab_listino.id > 0 then
	
			kst_esito = this.anteprima ( kdsi_elenco_output, kst_tab_listino )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "id Listino: " + string(kst_tab_listino.id)
		else
			k_return = false
		end if

	case else
		if left(a_campo_link,15)  = "id_listino_voce" then
			kst_tab_listino_voci.id_listino_voce = adw_1.getitemnumber(adw_1.getrow(), a_campo_link )
			if kst_tab_listino_voci.id_listino_voce > 0 then
		
				kuf1_listino_voci = create kuf_listino_voci
				kst_esito = kuf1_listino_voci.anteprima ( kdsi_elenco_output, kst_tab_listino_voci )
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza( )
					kguo_exception.set_esito( kst_esito)
					throw kguo_exception
				end if
				kst_open_w.key1 = "Voce: " + string(kst_tab_listino_voci.id_listino_voce)
			else
				k_return = false
			end if
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

public function st_esito u_check_dati_cond_fatt (datastore ads_inp);//------------------------------------------------------------------------------------------------------
//---  Controllo dati utente
//---  inp: datastore con i dati da controllare
//---  out: datastore con  	ads_inp.object.<nome campo>.tag che può valere:
//												0=tutto OK (kkg_esito.ok); 
//												1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//												2=errore forma  (bloccante) (kkg_esito.err_formale);
//												3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//												4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---							               	5=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//---  CONSIGLIO DI COPIARE DA QUESTO ESTENDENDO I CONTROLLI
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe
int k_riga
string k_tipo_errore="0"
st_esito kst_esito



try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
// ESEMPIO
//	if trim(ads_inp.object.descr) > " "  then
//	else
//		k_errori ++
//		k_tipo_errore="3"      // errore in questo campo: dati insuff.
//		ads_inp.object.descr.tag = k_tipo_errore 
//		kst_esito.esito = kkg_esito.err_formale
//		kst_esito.sqlerrtext = "Manca descrizione nel campo " + trim(ads_inp.object.descr_t.text) +  "~n~r"  
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if
	
	k_nr_righe =ads_inp.rowcount()
	k_errori = 0
	k_riga =ads_inp.getnextmodified(0, primary!)

	do while k_riga > 0  and k_errori < 10

		if ads_inp.getitemstring ( k_riga, "descr") > " " then  // presuppone ci sia la descrizione
		else
			k_errori ++
			k_tipo_errore="3"      // errore in questo campo: dati insuff.
			ads_inp.modify("descr.tag = '" + k_tipo_errore + "' ")
			kst_esito.esito = kkg_esito.DATI_INSUFF
			kst_esito.sqlerrtext = "Manca valore nel campo " + trim(ads_inp.describe(ads_inp.describe("descr.name") + "_t.text")) +  "~n~r"  
		end if

		if k_tipo_errore <> "0" and k_tipo_errore <> "4" and k_tipo_errore <> "5"  then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		k_riga++
		k_riga = ads_inp.getnextmodified(k_riga, primary!)

	loop

	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito
 
 
 
end function

public function boolean if_id_cond_fatt_ok (ref st_tab_listino ast_tab_listino, ref st_tab_armo ast_tab_armo) throws uo_exception;//---
//--- Verifica la CONDIZIONE se soddisfatta: chiama GET_PREZZO_1 --> GET_PREZZO_2
//---
//--- Input: 	st_tab_listino.ID, COD_CLI, st_tab_listino.ID_COND_FATT_1
//---  			st_tab_armo.ID_ARMO, ID_MECA (opzionale)  
//---         In uscita: st_tab_listino.prezzo (se rit=TRUE)
//---
//--- Out: TRUE=condizione prezzi soddisfatta, FALSE=condiz. non soddisfatta
//--- Errore Lancia EXCEPTION: uo_exception
//---
boolean k_return = false
st_tab_meca kst_tab_meca 
st_tab_cond_fatt kst_tab_cond_fatt
st_esito kst_esito
kuf_armo kuf1_armo
kuf_fatt kuf1_fatt



try 
	
	if ast_tab_listino.id > 0 then
		
		kuf1_armo = create kuf_armo
		kuf1_fatt = create kuf_fatt

		if ast_tab_armo.id_armo > 0 then
			if ast_tab_armo.id_meca = 0 or isnull(ast_tab_armo.id_meca) then 
//---- piglia id del lotto 		
				kst_esito = kuf1_armo.get_id_meca_da_id_armo(ast_tab_armo)
				if kst_esito.esito = kkg_esito.db_ko then
					kguo_exception.set_esito( kst_esito )
					throw kguo_exception
				end if
			end if
		else
			ast_tab_armo.id_meca = 0
			ast_tab_armo.id_armo = 0
		end if
		
//--- controllo se condizione valida
		kst_tab_cond_fatt.id = ast_tab_listino.id_cond_fatt_1
			
		k_return = this.get_prezzo_1( ast_tab_listino, ast_tab_armo, kst_tab_cond_fatt, kuf1_armo,  kuf1_fatt ) 

	end if
	
catch (uo_exception kuo_exception)
	throw kguo_exception

finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf1_fatt) then destroy kuf1_fatt
	
end try

return k_return

end function

public function boolean if_attiva_listino_pregruppi (ref st_tab_listino ast_tab_listino) throws uo_exception;//
//====================================================================
//=== Verifica se ho attivato il Listino con le Voci Prezzi  
//=== 
//=== Input: st_tab_listino id     
//=== Output: 
//=== Ritorna:  TRUE = lsino voci attivo;  FALSE=prezzi direttamente sul listino 
//===           		  
//====================================================================
boolean k_return = false 
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	  SELECT listino.attiva_listino_pregruppi
	 	 into
	  			:ast_tab_listino.attiva_listino_pregruppi
   	 FROM listino
		 where id = :ast_tab_listino.id
			  using sqlca;		

	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino per leggere modalità Prezzi, id= " + string(ast_tab_listino.id) +  "~n~r" + trim(sqlca.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)		
			throw kguo_exception
		end if
	end if

	if ast_tab_listino.attiva_listino_pregruppi = kki_attiva_listino_pregruppi_si then
		k_return = true
	end if
	
return k_return 


end function

public function st_esito u_check_dati (ref datastore ads_inp) throws uo_exception;//------------------------------------------------------------------------------------------------------
//---  Controllo dati utente
//---  inp: datastore con i dati da controllare
//---  out: datastore con  	ads_inp.object.<nome campo>.tag che può valere:
//												0=tutto OK (kkg_esito.ok); 
//												1=errore logico (bloccante) (kkg_esito.ERR_LOGICO); 
//												2=errore forma  (bloccante) (kkg_esito.err_formale);
//												3=dati insufficienti  (bloccante) (kkg_esito.DATI_INSUFF);
//												4=KO ma errore non grave  (NON bloccante) (kkg_esito.DB_WRN);
//---							               	5=OK con degli avvertimenti (NON bloccante) (kkg_esito.DATI_WRN);
//---  rit: 
//---
//---  per errore lancia EXCEPTION anche x i warning
//---
//---  CONSIGLIO DI COPIARE DA QUESTO ESTENDENDO I CONTROLLI
//---
//------------------------------------------------------------------------------------------------------
//
int k_errori = 0
long k_nr_righe
int k_riga
string k_tipo_errore="0"
st_esito kst_esito
kuf_contratti kiuf_contratti


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
// ESEMPIO
//	if trim(ads_inp.object.descr) > " "  then
//	else
//		k_errori ++
//		k_tipo_errore="3"      // errore in questo campo: dati insuff.
//		ads_inp.object.descr.tag = k_tipo_errore 
//		kst_esito.esito = kkg_esito.err_formale
//		kst_esito.sqlerrtext = "Manca descrizione nel campo " + trim(ads_inp.object.descr_t.text) +  "~n~r"  
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if
	
	k_nr_righe =ads_inp.rowcount()
	k_errori = 0
	k_riga =ads_inp.getnextmodified(0, primary!)


	do while k_riga > 0  and k_errori < 10

		if ads_inp.getitemnumber ( k_riga, "magazzino") > 0 then  // presuppone ci sia il MAGAZZINO
		else
			k_errori ++
			k_tipo_errore="3"      // errore in questo campo: dati insuff.
			ads_inp.modify("magazzino.tag = '" + k_tipo_errore + "' ")
			kst_esito.esito = kkg_esito.DATI_INSUFF
			kst_esito.sqlerrtext = "Manca valore nel campo '" + trim(ads_inp.describe(ads_inp.describe("magazzino.name") + "_t.text")) +  "'~n~r"  
		end if

//--- codice E1LITM preferibile se tipo=STANDARD
		if trim(ads_inp.getitemstring ( k_riga, "e1litm"))  > " " then
		else
			if ads_inp.getitemstring ( k_riga, "tipo") = kiuf_contratti.kki_tipo_deposito then  // tipo deposito non interessa?
			else
				ads_inp.setitem(k_riga, "e1litm", "")
				k_errori ++
				k_tipo_errore = kkg_esito.DATI_WRN //"3"
				ads_inp.modify("e1litm.tag = '" + k_tipo_errore + "' ")
				kst_esito.esito = kkg_esito.DATI_WRN
				kst_esito.sqlerrtext += "Manca il dato '" +   trim(ads_inp.describe("gb_e1litm.text")) + "'~n~r" 
			end if
		end if

		if k_tipo_errore <> "0" and k_tipo_errore <> "4" and k_tipo_errore <> "5"  then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		k_riga++
		k_riga = ads_inp.getnextmodified(k_riga, primary!)

	loop

	
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if k_errori > 0 then
		
	end if
	
end try


return kst_esito
 
 
 
end function

public function string get_attivo (st_tab_listino ast_tab_listino) throws uo_exception;//
//---------------------------------------------------------------------
//--- Torna il campo ATTIVO 
//--- 
//--- Input: st_tab_listino id     
//--- Output:        
//--- Ritorna: st_tab_listino.attivo      
//---           		  
//---------------------------------------------------------------------
string k_return = ""
st_esito kst_esito

 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	  SELECT listino.attivo
	 	 into
	  			:ast_tab_listino.attivo
   	 FROM listino
		 where id = :ast_tab_listino.id
			  using kguo_sqlca_db_magazzino;		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino (attivo), id= " + string(ast_tab_listino.id) +  "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)		
			throw kguo_exception
		end if
	else
		if trim(ast_tab_listino.attivo) > " " then
			k_return = ast_tab_listino.attivo
		else
			k_return = kki_attivo_da_fare
		end if
	end if


return k_return


end function

public function string get_cod_art (st_tab_listino ast_tab_listino) throws uo_exception;//
//====================================================================
//=== Torna il Codice Articolo 
//=== 
//=== Input: st_tab_listino id     
//=== Output: 
//=== Ritorna: cod_art 
//===           		  
//====================================================================
string k_return = ""
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	  SELECT listino.cod_art
	 	 into
	  			:ast_tab_listino.cod_art
   	 FROM listino
		 where id = :ast_tab_listino.id
			  using kguo_sqlca_db_magazzino;		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino per leggere l'Articolo, id= " + string(ast_tab_listino.id) +  "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)		
			throw kguo_exception
		end if
	end if

	if trim(ast_tab_listino.cod_art) > " " then
		k_return = trim(ast_tab_listino.cod_art)
	end if

return k_return 

end function

public function long get_contratto (st_tab_listino ast_tab_listino) throws uo_exception;//
//====================================================================
//=== Torna il Codice Contratto (CO) 
//=== 
//=== Input: st_tab_listino id     
//=== Output:            
//=== Ritorna: cod. contratto 
//===           		  
//====================================================================
long k_return = 0
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	  SELECT listino.contratto
	 	 into
	  			:ast_tab_listino.contratto
   	 FROM listino
		 where id = :ast_tab_listino.id
			  using kguo_sqlca_db_magazzino;		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino per leggere il codice Contratto (CO), id= " + string(ast_tab_listino.id) +  "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)		
			throw kguo_exception
		end if
	end if

	if ast_tab_listino.contratto > 0 then
		k_return = ast_tab_listino.contratto
	end if

return k_return 

end function

public function long get_cod_cli (ref st_tab_listino ast_tab_listino) throws uo_exception;//
//====================================================================
//=== Torna il Codice Cliente 
//=== 
//=== Input: st_tab_listino id     
//=== Output: st_tab_listino.cod_cli            
//=== Ritorna: cod_cli 
//===           		  
//====================================================================
long k_return = 0
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	  SELECT listino.cod_cli
	 	 into
	  			:ast_tab_listino.cod_cli
   	 FROM listino
		 where id = :ast_tab_listino.id
			  using kguo_sqlca_db_magazzino;		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino per leggere il Cliente, id= " + string(ast_tab_listino.id) +  "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)		
			throw kguo_exception
		end if
	end if

	if ast_tab_listino.cod_cli > 0 then
		k_return = ast_tab_listino.cod_cli
	end if

return k_return



end function

public subroutine get_dati_x_armo (ref st_tab_listino ast_tab_listino) throws uo_exception;//
//====================================================================
//=== Torna il Codice Contratto (CO) 
//=== 
//=== Input: st_tab_listino id     
//=== Output: diversi dati per caricare in ARMO            
//=== Ritorna: 
//===           		  
//====================================================================
long k_return = 0
st_esito kst_esito

 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	  SELECT listino.cod_art
	         ,listino.magazzino
	         ,listino.campione
	         ,listino.dose
	         ,listino.mis_x
	         ,listino.mis_y
	         ,listino.mis_z
	         ,listino.peso_kg
	         ,listino.contratto
	         ,listino.occup_ped
	         ,listino.m_cubi_f
	 	 into
	  		:ast_tab_listino.cod_art
	         ,:ast_tab_listino.magazzino
	         ,:ast_tab_listino.campione
	         ,:ast_tab_listino.dose
	         ,:ast_tab_listino.mis_x
	         ,:ast_tab_listino.mis_y
	         ,:ast_tab_listino.mis_z
	         ,:ast_tab_listino.peso_kg
	         ,:ast_tab_listino.contratto
	         ,:ast_tab_listino.occup_ped
	         ,:ast_tab_listino.m_cubi_f
   	 FROM listino
		 where id = :ast_tab_listino.id
			  using kguo_sqlca_db_magazzino;		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Listino per dati carico riga Lotto, id= " + string(ast_tab_listino.id) +  "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)		
			throw kguo_exception
		end if
	end if

	if_isnull(ast_tab_listino)
	



end subroutine

public function integer get_occup_ped (st_tab_listino ast_tab_listino) throws uo_exception;//
//====================================================================
//=== Torna il Codice Cliente 
//=== 
//=== Input: st_tab_listino id     
//=== Output:           
//=== Ritorna: occup_ped 
//===           		  
//====================================================================
integer k_return = 0
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	  SELECT listino.occup_ped
	 	 into
	  			:ast_tab_listino.occup_ped
   	 FROM listino
		 where id = :ast_tab_listino.id
			  using kguo_sqlca_db_magazzino;		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino per leggere il dato di Occupazione Pedana, id= " + string(ast_tab_listino.id) +  "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)		
			throw kguo_exception
		end if
	end if

	if ast_tab_listino.occup_ped > 0 then
		k_return = ast_tab_listino.occup_ped
	end if

return k_return



end function

public function double get_peso_kg (st_tab_listino ast_tab_listino) throws uo_exception;//
//====================================================================
//=== Torna il peso_kg 
//=== 
//=== Input: st_tab_listino id     
//=== Output:            
//=== Ritorna: cod. peso_kg 
//===           		  
//====================================================================
double k_return = 0.00
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	  SELECT listino.peso_kg
	 	 into
	  			:ast_tab_listino.peso_kg
   	 FROM listino
		 where id = :ast_tab_listino.id
			  using kguo_sqlca_db_magazzino;		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino per leggere il peso kg per collo, id= " + string(ast_tab_listino.id) +  "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)		
			throw kguo_exception
		end if
	end if

	if ast_tab_listino.peso_kg > 0 then
		k_return = ast_tab_listino.peso_kg
	end if

return k_return 

end function

public function double get_m_cubi_f (st_tab_listino ast_tab_listino) throws uo_exception;//
//====================================================================
//=== Torna il m_cubi_f 
//=== 
//=== Input: st_tab_listino id     
//=== Output:            
//=== Ritorna: cod. m_cubi_f 
//===           		  
//====================================================================
double k_return = 0.00
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	  SELECT listino.m_cubi_f
	 	 into
	  			:ast_tab_listino.m_cubi_f
   	 FROM listino
		 where id = :ast_tab_listino.id
			  using kguo_sqlca_db_magazzino;		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino per leggere occup. mt cubi per collo, id= " + string(ast_tab_listino.id) +  "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)		
			throw kguo_exception
		end if
	end if

	if ast_tab_listino.m_cubi_f > 0 then
		k_return = ast_tab_listino.m_cubi_f
	end if

return k_return 

end function

public subroutine get_prezzi123 (ref st_tab_listino kst_tab_listino) throws uo_exception;//---
//--- Torna i Prezzi 1 2 3 
//--- Inp: st_tab_listino.id_listino
//--- Out: st_tab_listino con i prezzi 1-2-3
//---
st_esito kst_esito

 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

this.if_isnull(kst_tab_listino)

if kst_tab_listino.id > 0 then
	
	select 
       listino.prezzo 
		,listino.prezzo_2	
		,listino.prezzo_3	
	into
       :kst_tab_listino.prezzo 
		,:kst_tab_listino.prezzo_2	
		,:kst_tab_listino.prezzo_3	
    FROM listino 
	WHERE ( listino.id = :kst_tab_listino.id ) 
	using sqlca;	


	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = sqlca.sqlerrtext
			kGuo_exception.inizializza( )
			kGuo_exception.set_esito( kst_esito )
			throw kGuo_exception
		end if
	end if
	
end if


end subroutine

public function boolean select_riga (ref st_tab_listino kst_tab_listino) throws uo_exception;//
//====================================================================
//=== Legge rek da tabella LISTINO
//=== 
//=== Inp: st_tab_listino - id
//=== Out: st_tab_listino caricata
//=== Ritorna: TRUE ok, FALSE non trovato
//=== Lancia EXCEPTION
//===  
//====================================================================
//
boolean k_return = false
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w
boolean k_autorizza




kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



//--- controlla se utente autorizzato alla funzione in atto
	if_sicurezza(kkg_flag_modalita.visualizzazione)

if kst_tab_listino.id > 0 then
	
	
//--- toglie valori NULL
	select
					  cod_cli,   
					  cod_art,   
					  dose,   
					  prezzo,   
					  id_cond_fatt_1,   
					  prezzo_2,   
					  id_cond_fatt_2,   
					  prezzo_3,   
					  id_cond_fatt_3,   
					  tipo,   
					  campione,   
					  mis_x,   
					  mis_y,   
					  mis_z,   
					  occup_ped,   
					  travaso,   
					  peso_kg,   
					  magazzino,   
					  m_cubi_f,   
					  attivo,   
					  contratto,   
					  contratto_co_data_ins,   
					  id_contratto_co,   
					  attiva_listino_pregruppi,
					  x_datins,   
					  x_utente 
		  into 
					  :kst_tab_listino.cod_cli,   
					  :kst_tab_listino.cod_art,   
					  :kst_tab_listino.dose,   
					  :kst_tab_listino.prezzo,   
					  :kst_tab_listino.id_cond_fatt_1,   
					  :kst_tab_listino.prezzo_2,   
					  :kst_tab_listino.id_cond_fatt_2,   
					  :kst_tab_listino.prezzo_3,   
					  :kst_tab_listino.id_cond_fatt_3,   
					  :kst_tab_listino.tipo,   
					  :kst_tab_listino.campione,   
					  :kst_tab_listino.mis_x,   
					  :kst_tab_listino.mis_y,   
					  :kst_tab_listino.mis_z,   
					  :kst_tab_listino.occup_ped,   
					  :kst_tab_listino.travaso,   
					  :kst_tab_listino.peso_kg,   
					  :kst_tab_listino.magazzino,   
					  :kst_tab_listino.m_cubi_f,   
					  :kst_tab_listino.attivo,   
					  :kst_tab_listino.contratto,   
					  :kst_tab_listino.contratto_co_data_ins,   
					  :kst_tab_listino.id_contratto_co,   
					  :kst_tab_listino.attiva_listino_pregruppi,
					  :kst_tab_listino.x_datins,   
					  :kst_tab_listino.x_utente 
			from  listino  
			where id = :kst_tab_listino.id  
			using kguo_sqlca_db_magazzino ;
		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura dati 'Listino', errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		if kguo_sqlca_db_magazzino.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	
	else

		k_return = TRUE
		if_isnull(kst_tab_listino)

	end if

else
	
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Manca codice Listino, selezione dei dati di Listino non eseguita! " 
		kst_esito.esito = KKG_ESITO.no_esecuzione
	
end if


return k_return

end function

public function long tb_duplica (ref st_tab_listino ast_tab_listino) throws uo_exception;//
//====================================================================
//=== Duplica il rek nella tabella LISTINO
//=== 
//=== Inp: st_tab_listino - id_listino da cui duplicare + i valori x i campi che si vogliono cambiare 
//=== Ritorna: ID caricato
//=== Lancia EXCEPTION
//===  
//====================================================================
//
long k_return = 0
long k_ctr=0, k_rc
st_esito kst_esito
datastore kds_listino



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if_sicurezza(kkg_flag_modalita.inserimento)
	
if ast_tab_listino.id > 0 then 
	
	kds_listino = create datastore
	kds_listino.dataobject = "ds_listino"
	kds_listino.settransobject(kguo_sqlca_db_magazzino)
	k_ctr = kds_listino.retrieve(ast_tab_listino.id)			// legge il listino da DUPLICARE
	
	if k_ctr = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Duplica 'Listino', errore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = KKG_ESITO.no_esecuzione
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- Forza lo STATO a NUOVO così fa il carico	
	k_rc = kds_listino.SetItemStatus(1, 0, Primary!, New!)
	
	kds_listino.setitem(1, "id", 0)  // AZZERO IL ID campo SERIAL
	
//--- imposto dati utente e data aggiornamento
	kds_listino.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
	kds_listino.setitem(1, "x_utente",  kGuf_data_base.prendi_x_utente())
	
//--- toglie valori NULL
	if_isnull(ast_tab_listino)

	if ast_tab_listino.id_parent > 0 then 
		kds_listino.setitem(1, "id_parent", ast_tab_listino.id_parent)
	else
		kds_listino.setitem(1, "id_parent", ast_tab_listino.id)  // x DEFAULT mette il ID del listino da duplicare
	end if
	if ast_tab_listino.cod_cli  > 0 then 
		kds_listino.setitem(1, "cod_cli", ast_tab_listino.cod_cli)
	end if
	if ast_tab_listino.cod_art > " " then 
		kds_listino.setitem(1, "cod_art", ast_tab_listino.cod_art)
	end if
	if ast_tab_listino.dose  > 0 then 
		kds_listino.setitem(1, "dose", ast_tab_listino.dose)
	end if
	if ast_tab_listino.prezzo > 0 then 
		kds_listino.setitem(1, "prezzo", ast_tab_listino.prezzo)
	end if
	if ast_tab_listino.prezzo_2 > 0 then 
		kds_listino.setitem(1, "prezzo_2", ast_tab_listino.prezzo_2)
	end if
	if ast_tab_listino.prezzo_3 > 0 then 
		kds_listino.setitem(1, "prezzo_3", ast_tab_listino.prezzo_3)
	end if
	if ast_tab_listino.attiva_listino_pregruppi > " " then 
		kds_listino.setitem(1, "attiva_listino_pregruppi", ast_tab_listino.attiva_listino_pregruppi)
	end if
	if ast_tab_listino.id_cond_fatt_1 > 0 then 
		kds_listino.setitem(1, "id_cond_fatt_1", ast_tab_listino.id_cond_fatt_1)
	end if
	if ast_tab_listino.id_cond_fatt_2 > 0 then 
		kds_listino.setitem(1, "id_cond_fatt_2", ast_tab_listino.id_cond_fatt_2)
	end if
	if ast_tab_listino.id_cond_fatt_3 > 0 then 
		kds_listino.setitem(1, "id_cond_fatt_3", ast_tab_listino.id_cond_fatt_3)
	end if
	if ast_tab_listino.tipo > " " then 
		kds_listino.setitem(1, "tipo", ast_tab_listino.tipo)
	end if
	if ast_tab_listino.campione > " " then 
		kds_listino.setitem(1, "campione", ast_tab_listino.campione)
	end if
	if ast_tab_listino.mis_x > 0 then 
		kds_listino.setitem(1, "mis_x", ast_tab_listino.mis_x)
	end if
	if ast_tab_listino.mis_y > 0 then 
		kds_listino.setitem(1, "mis_y", ast_tab_listino.mis_y)
	end if
	if ast_tab_listino.mis_z > 0 then 
		kds_listino.setitem(1, "id_parent", ast_tab_listino.id_parent)
	end if
	if ast_tab_listino.occup_ped > 0 then 
		kds_listino.setitem(1, "mis_z", ast_tab_listino.mis_z)
	end if
	if ast_tab_listino.travaso > " " then 
		kds_listino.setitem(1, "travaso", ast_tab_listino.travaso)
	end if
	if ast_tab_listino.peso_kg > 0 then 
		kds_listino.setitem(1, "peso_kg", ast_tab_listino.peso_kg)
	end if
	if ast_tab_listino.magazzino > 0 then 
		kds_listino.setitem(1, "magazzino", ast_tab_listino.magazzino)
	end if
	if ast_tab_listino.m_cubi_f > 0 then 
		kds_listino.setitem(1, "m_cubi_f", ast_tab_listino.m_cubi_f)
	end if
	if ast_tab_listino.attivo > " " then 
		kds_listino.setitem(1, "attivo", ast_tab_listino.attivo)
	else
		kds_listino.setitem(1, "attivo", kki_attivo_da_fare)  // x DEFAULT non e' ATTIVO
	end if
	if ast_tab_listino.contratto > 0 then 
		kds_listino.setitem(1, "contratto", ast_tab_listino.contratto)
	end if
	if ast_tab_listino.contratto_co_data_ins > datetime(date(0)) then 
		kds_listino.setitem(1, "contratto_co_data_ins", ast_tab_listino.contratto_co_data_ins)
	end if
	if ast_tab_listino.id_contratto_co	 > 0 then 
		kds_listino.setitem(1, "id_contratto_co", ast_tab_listino.id_contratto_co)
	end if
	if trim(ast_tab_listino.e1litm) > " " then 
		kds_listino.setitem(1, "e1litm", ast_tab_listino.e1litm)
	end if
	
	k_rc = kds_listino.update( )
		
	if k_rc = 1 then
		
		if ast_tab_listino.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_commit( )
		end if

//--- Se nuova riga Imposto il campo Contatore ID (SERIAL)				
		get_ultimo_id(ast_tab_listino)
		k_return = ast_tab_listino.id   // ritorna il ID appena caricato (o almeno lo spero)

	else
		
		kst_esito.sqlcode = -1
		kst_esito.SQLErrText = "Duplica 'Listino' in errore durante l'inserimento " 
		kst_esito.esito = KKG_ESITO.db_ko
	
		if ast_tab_listino.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino.st_tab_g_0.esegui_commit) then
			kguo_sqlca_db_magazzino.db_rollback( )
		end if
		
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	
end if


return k_return

end function

public function boolean set_stato_non_attivo (st_tab_listino ast_tab_listino) throws uo_exception;//
//-----------------------------------------------------------------------------------------------------
//--- Disattiva rek nella tabella LISTINO x id
//--- 
//--- Inp:  kast_tab_listino.id
//--- Ritorna: TRUE=OK; FALSE=errore grave 
//--- Lancia EXCEPTION
//---  
//-----------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if if_sicurezza(kkg_flag_modalita.modifica) then

	if ast_tab_listino.id > 0 then
	//--- imposto dati utente e data aggiornamento
		ast_tab_listino.x_datins = kGuf_data_base.prendi_x_datins()
		ast_tab_listino.x_utente = kGuf_data_base.prendi_x_utente()
		ast_tab_listino.attivo = kki_attivo_no
		
		update listino 
				set attivo = :ast_tab_listino.attivo
					 ,x_datins = :ast_tab_listino.x_datins 
					 ,x_utente = :ast_tab_listino.x_utente 
			 where 
					 id = :ast_tab_listino.id
			 using sqlca;
			
	
		if sqlca.sqlcode < 0 then
			
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Disattivazione 'Listino' " + string(ast_tab_listino.id) + " in errore: " + trim(sqlca.SQLErrText)
			kst_esito.esito = KKG_ESITO.db_ko
		
		else
	
			if sqlca.sqlcode = 0 then
	//---- COMMIT....	
				if kst_esito.esito = kkg_esito.db_ko then
					if ast_tab_listino.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_rollback_1( )
					end if
				else
					if ast_tab_listino.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino.st_tab_g_0.esegui_commit) then
						kst_esito = kGuf_data_base.db_commit_1( )
					end if
				end if
			end if
		end if
	
		if kst_esito.esito = kkg_esito.ok then
			k_return = true
		else	
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
	end if
else
	kst_esito.SQLErrText = "Disattivazione 'Listino', manca il codice Listino"
	kst_esito.esito = KKG_ESITO.no_esecuzione
end if


return k_return

end function

public function string get_cod_art_x_contratto (st_tab_listino ast_tab_listino) throws uo_exception;//
//====================================================================
//=== Torna il Codice ART
//=== 
//=== Input: st_tab_listino.Contratto (CO) 
//=== Output:            
//=== Ritorna: cod. articolo
//===           		  
//====================================================================
string k_return = ""
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	  SELECT max(listino.cod_art)
	 	 into
	  			:ast_tab_listino.cod_art
   	 FROM listino
		 where contratto = :ast_tab_listino.contratto
			  using kguo_sqlca_db_magazzino;		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Lettura Listino per leggere il codice Articolo per il Contratto (CO)  " + string(ast_tab_listino.Contratto) +  "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)		
			throw kguo_exception
		end if
	end if

	if trim(ast_tab_listino.cod_art) > " " then
		k_return = ast_tab_listino.cod_art
	end if

return k_return 

end function

public function string get_e1litm (st_tab_listino ast_tab_listino) throws uo_exception;//
//====================================================================
//=== Torna il Codice Contratto  per E1  (e1litm)  
//=== 
//=== Input: st_tab_listino id     
//=== Output:            
//=== Ritorna: cod. contratto E1
//===           		  
//====================================================================
string k_return = ""
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT listino.e1litm
		 	 into
	  			:ast_tab_listino.e1litm
      	 FROM listino
		 where id = :ast_tab_listino.id
			  using kguo_sqlca_db_magazzino;		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Contratto per E1 su Listino (e1litm), id= " + string(ast_tab_listino.id) +  "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)		
			throw kguo_exception
		end if
	end if

	if trim(ast_tab_listino.e1litm) > " " then
		k_return = ast_tab_listino.e1litm
	end if

return k_return 

end function

public function integer if_e1litm_x_contratto (st_tab_listino ast_tab_listino) throws uo_exception;//
//=======================================================================
//=== Verifica presenza di almeno un Codice Contratto E1 (e1litm) attivo  
//=== x codice Contratto CO
//=== 
//=== Input: st_tab_listino contratto     
//=== Output:            
//=== Ritorna: numero contratti E1 attivi
//===           		  
//=======================================================================
int k_return
int k_ctr
st_esito kst_esito


 
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT count(listino.e1litm)
		 	 into
	  			:k_ctr
      	 FROM listino
		 where contratto = :ast_tab_listino.contratto
		      and attivo = 'S'
			  using kguo_sqlca_db_magazzino;		

	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in verifica presenza Contratti-E1 (e1litm) attivi su Listino, id Contratto= " + string(ast_tab_listino.contratto) +  "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) + " - " + trim(kst_esito.nome_oggetto)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)		
			throw kguo_exception
		end if
	end if

	if k_ctr > 0 then
		k_return = k_ctr
	end if

return k_return 

end function

public function long tb_gia_spedito (st_tab_listino kst_tab_listino) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Controlla se Listino ha movimenti ancora da Spedire
//--- 
//--- Ritorna: ultimo ID Lotto trovato ancora da spedire 
//---          0 = tutti spediti o nessun lotto caricato per questo listino
//---           		  
//--------------------------------------------------------------------------------------------------------------

long k_return 
long k_num
date k_data
boolean k_open = false
st_esito kst_esito


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if  kst_tab_listino.id = 0 or isnull (kst_tab_listino.id) then
	
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Id del Listino non indicato. "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if

//--- Controllo se nelle ENTRATE ci sono rec da fatturare
//	DECLARE entrate CURSOR FOR  
  SELECT max(armo.id_meca)
       into :k_num
			FROM armo
			where 
				 armo.id_listino = :kst_tab_listino.id
				 and  not exists ( 
			      SELECT arsp.id_arsp
				     FROM arsp
				     where armo.id_armo = arsp.id_armo)
				using kguo_sqlca_db_magazzino;		
		
		
//	open entrate;
	if kguo_sqlca_db_magazzino.sqlCode < 0 then
		
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlerrtext = "Errore in verifica Colli spediti per Listino  ~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
		kst_esito.sqlcode = sqlca.sqlcode
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	end if
//	k_open = true
//
//	fetch entrate INTO 	:k_num, :k_data ;
//	if kguo_sqlca_db_magazzino.sqlCode < 0 then
//		kst_esito.esito = kkg_esito.db_ko
//		kst_esito.sqlerrtext = "Errore durante verifica Colli fatturati ~n~r" + kguo_sqlca_db_magazzino.sqlerrtext
//		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//		kguo_exception.inizializza( )
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if
//
	if kguo_sqlca_db_magazzino.sqlCode = 0 then
		if k_num > 0 then
			
			k_return = k_num 

		end if
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception


finally 
//	if k_open then
//		close entrate;
//	end if

end try 


return k_return

end function

public function long get_id_max () throws uo_exception;//
//------------------------------------------------------------------
//--- Torna l'ultimo ID  inserito 
//--- 
//---  input: 
//---  ret: max ID
//---                                     
//------------------------------------------------------------------
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	SELECT max(id)
		 INTO 
				:k_return
		 FROM LISTINO  
		 using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore in lettura ultimo ID Listino in tabella (LISTINO)" &
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

public function long get_id_listini (ref st_tab_listino kst_tab_listino[]) throws uo_exception;//
//====================================================================
//=== Torna  ID_ LISTINI x Cliente e altro
//=== 
//=== Input: st_tab_listino[1]  COD_CLI, CONTRATTO ordinata x  MIS_Y da grande a piccola   
//=== Out: st_tab_listino[].id,  st_tab_listino[1].st_tab_g_0.contati il numero listini trovati                 
//=== Ritorna id del listino (occurs 1)
//===           		  
//====================================================================
long k_return 
int k_ctr
string k_attivo_si
boolean k_open=false


try

	if isnull(kst_tab_listino[1].COD_CLI) then kst_tab_listino[1].COD_CLI = 0
	if isnull(kst_tab_listino[1].CONTRATTO) then kst_tab_listino[1].CONTRATTO = 0

	kst_tab_listino[1].st_tab_g_0.contati = 0  
	k_attivo_si = kki_attivo_si

//---- declare x leggere i listini	
	declare c_get_id_listini cursor for 
		SELECT listino.id
				 FROM listino
				 where
						LISTINO.COD_CLI   = :kst_tab_listino[1].COD_CLI    and
						(:kst_tab_listino[1].CONTRATTO = 0 or LISTINO.CONTRATTO = :kst_tab_listino[1].CONTRATTO)
						and listino.attivo = :k_attivo_si
					order by LISTINO.MIS_Y desc
				  using kguo_sqlca_db_magazzino;		
		
	open c_get_id_listini;
	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		k_open = true
		
		fetch c_get_id_listini into :kst_tab_listino[1].id;
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				
				k_ctr++
				fetch c_get_id_listini into :kst_tab_listino[k_ctr].id;
				
			loop
		end if

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kguo_exception.inizializza( )
			kguo_exception.kist_esito.nome_oggetto = this.classname()
			kguo_exception.kist_esito.esito = kkg_esito.db_ko
			kguo_exception.kist_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kguo_exception.kist_esito.SQLErrText = "Errore in Lettura Listini (cercato ID Listino) ~n~rCliente: " &
								+ string(kst_tab_listino[1].COD_CLI) + "- Contratto: " +  string(kst_tab_listino[1].contratto) + "~n~r" &
								+ trim(kguo_sqlca_db_magazzino.SQLErrText) 
			throw kguo_exception

		end if
	end if

	kst_tab_listino[1].st_tab_g_0.contati = k_ctr
	k_return = kst_tab_listino[1].id


catch (uo_exception kuo_execption)
	throw kuo_execption
	

finally
	if k_open then 
		close c_get_id_listini;
	end if
	
end try

return k_return


end function

on kuf_listino.create
call super::create
end on

on kuf_listino.destroy
call super::destroy
end on

