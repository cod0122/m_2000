$PBExportHeader$kuf_ausiliari.sru
forward
global type kuf_ausiliari from kuf_parent
end type
end forward

global type kuf_ausiliari from kuf_parent
end type
global kuf_ausiliari kuf_ausiliari

type variables
//
//--- pagamento: TIPO
constant string  ki_tab_pagam_tipo_rim_diretta = "0"
constant string  ki_tab_pagam_tipo_ric_bancaria = "1"
constant string  ki_tab_pagam_tipo_riba = "2"
constant string  ki_tab_pagam_tipo_bonifico = "3"
constant string  ki_tab_pagam_tipo_mav = "4"
constant string  ki_tab_pagam_tipo_altro = "5"

//--- pagamento:
constant string  ki_tab_pagam_scade_FM = "0"
constant string  ki_tab_pagam_scade_FT = "1"

//--- nazioni: GRUPPO
constant string ki_tab_nazioni_gruppo_nessuno = " "
constant string ki_tab_nazioni_gruppo_unione_europea = "E"

//---- nomi dw dell'elenco
constant string kki_clie_settori_l = "d_clie_settori_l" 
constant string kki_clie_classi_l = "d_clie_classi_l" 
constant string kki_nazioni_l = "d_nazioni_l" 
constant string kki_cap_l = "d_cap_l_1" 
constant string kki_gruppo = "d_gruppo" 
constant string kki_clie_settore = "d_clie_settore"
constant string kki_meca_causali = "d_meca_causali_l"

 //--- IVA
constant string kki_fatt_norme_bolli_SI = "S"  //IVA che richiama NOTE  sulle norme espresso nel BASE
 
 //--- Lotto Dosimetrico
public constant string kki_dosimetrie_attivo = "S" 
public constant string kki_dosimetrie_disattivo = "N" 
 
//--- Causale di Spedizione 
public constant string kki_ddt_st_num_data_in_NO = "N"   //non stampare num e data bolla di entrata
 
//--- Causale di Entrata 
public constant string kki_meca_causale_FLAG_DDT_SI = "S"   //Lotto da spedire NON trattato (se un barcode è stato trattato non vale)

//--- Gruppo in STAT o meno
public constant string kki_gru_escludi_da_stat_glob = "S"   //Esclude il gruppo dal conteggio insieme agli altri negli statistici

//--- Posizione DOSIMETRI
public constant string kki_dosimpos_codice_disabilitato00 = "00"   //il codice 99 e 00 sono considerati 'DISABILITATI'
public constant string kki_dosimpos_codice_disabilitato99 = "99"   //il codice 99 e 00 sono considerati 'DISABILITATI'

end variables

forward prototypes
public function string tb_banche_select (ref st_tab_banche k_st_tab_banche)
public function st_esito tb_delete_dosimetrie (st_tab_dosimetrie kst_tab_dosimetrie)
public function st_esito tb_delete_banche (string k_id)
public function st_esito tb_delete_gruppi (integer k_id)
public function st_esito tb_delete_iva (integer k_id)
public function st_esito tb_delete_pagam (integer k_id)
public function st_esito tb_delete_misure (integer k_larg, integer k_lung, integer k_alt)
public function st_esito tb_delete_treeview (string k_id)
public function st_esito tb_dosimetrie_ultimo (ref st_tab_dosimetrie kst_tab_dosimetrie)
public function st_esito tb_dosimetrie_select (ref st_tab_dosimetrie kst_tab_dosimetrie)
public function st_esito tb_dosimetrie_select_lotto (ref st_tab_dosimetrie kst_tab_dosimetrie)
public function st_esito tb_dosimetrie_add (st_tab_dosimetrie kst_tab_dosimetrie)
public function st_esito tb_dosimetrie_importa_nuovo_csv (boolean k_elaborazione_di_test)
public function st_esito tb_dosimetrie_select_lotto_1 (ref st_tab_dosimetrie kst_tab_dosimetrie)
public function st_esito tb_delete_causali (string k_id)
public function st_esito tb_delete_meca_causali (long k_id)
public function st_esito tb_delete_nazioni (st_tab_nazioni kst_tab_nazioni)
public function st_esito tb_delete_cap (st_tab_cap kst_tab_cap)
public function st_esito tb_select (ref st_tab_nazioni k_st_tab_nazioni)
public function st_esito tb_select (ref st_tab_cap k_st_tab_cap)
public function st_esito tb_select_cap_provincia (ref st_tab_cap k_st_tab_cap)
public function st_esito tb_select (ref st_tab_pagam k_st_tab_pagam)
public function st_esito tb_select (ref st_tab_iva k_st_tab_iva)
public function st_esito tb_select (ref st_tab_gru kst_tab_gru)
public function boolean link_call (ref datawindow kdw_1, string k_campo_link) throws uo_exception
public function st_esito tb_delete (st_tab_clie_settori kst_tab_clie_settori)
public function st_esito tb_delete (st_tab_clie_classi kst_tab_clie_classi)
public function st_esito tb_select (ref st_tab_clie_settori kst_tab_clie_settori)
public function st_esito tb_select (ref st_tab_clie_classi kst_tab_clie_classi)
public function st_esito tb_select (ref st_tab_province k_st_tab_province)
public function st_esito tb_delete (st_tab_province kst_tab_province)
public function boolean if_gia_esiste (ref st_tab_cap k_st_tab_cap) throws uo_exception
public function boolean if_gia_esiste (ref st_tab_nazioni k_st_tab_nazioni) throws uo_exception
public function st_esito tb_dosimetrie_attivadisattiva (ref st_tab_dosimetrie kst_tab_dosimetrie)
public function st_esito tb_dosimetrie_get_attivo (ref st_tab_dosimetrie kst_tab_dosimetrie)
public subroutine if_isnull_tb (ref st_tab_pagam kst_tab_pagam)
public subroutine if_isnull_tb (ref st_tab_clie_classi kst_tab_clie_classi)
public subroutine if_isnull_tb (ref st_tab_gru kst_tab_gru)
public subroutine if_isnull_tb (ref st_tab_clie_settori kst_tab_clie_settori)
public subroutine if_isnull_tb (ref st_tab_nazioni kst_tab_nazioni)
public subroutine if_isnull_tb (ref st_tab_province kst_tab_province)
public function st_esito tb_gru_get_id_clie_settore (ref st_tab_gru kst_tab_gru)
public function st_esito tb_delete (st_tab_listino_voci_categ ast_tab_listino_voci_categ)
public function st_esito tb_select (ref st_tab_caus ast_tab_caus)
public function st_esito tb_select (ref st_tab_meca_causali ast_tab_meca_causali)
public subroutine if_isnull_tb (ref st_tab_meca_causali ast_tab_meca_causali)
public function st_esito tb_delete (st_tab_sr_settori ast_tab_sr_settori)
public function string tb_get_descr (st_tab_sr_settori ast_tab_sr_settori) throws uo_exception
public subroutine if_isnull_tb (ref st_tab_imptime kst_tab_imptime)
public function st_esito tb_delete (st_tab_imptime kst_tab_imptime)
public function boolean tb_imptime_get (ref st_tab_imptime kst_tab_imptime) throws uo_exception
public function boolean tb_select (ref st_tab_imptime kst_tab_imptime) throws uo_exception
public subroutine if_isnull_tb (ref st_tab_dosimpos kst_tab_dosimpos)
public function st_esito tb_delete (st_tab_dosimpos kst_tab_dosimpos)
public function boolean tb_select (ref st_tab_dosimpos kst_tab_dosimpos) throws uo_exception
end prototypes

public function string tb_banche_select (ref st_tab_banche k_st_tab_banche);//
//--- restituisce riga letta da tab Banche
//--- ritorna: oltre alla struttura della tab Banche
//---          "0"=ok 
//---          "1"=non trovato
//---          "2######xxxxxxxxxx"=errore #=sqlcode; x=descrione
//---          "3"=nessun codice richiesto
string k_return="0"
string k_codice


k_codice = trim(k_st_tab_banche.codice)

if LenA(trim(k_codice)) > 0 then
	select descrizione, abi, cab, conto, esito, divisa
	   into :k_st_tab_banche.descrizione,
		     :k_st_tab_banche.abi,
			  :k_st_tab_banche.cab,
			  :k_st_tab_banche.conto,
			  :k_st_tab_banche.esito,
			  :k_st_tab_banche.divisa
	   from banche
		where codice = trim(:k_codice);
	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode = 100 then
			k_return = "1"
		else
			k_return = "1" + string(sqlca.sqlcode, "------") + trim(sqlca.sqlerrtext)
		end if
	end if
else
	k_return = "3"
end if

return k_return
end function

public function st_esito tb_delete_dosimetrie (st_tab_dosimetrie kst_tab_dosimetrie);//
//====================================================================
//=== Cancella il rek dalla tabella DOSIMETRIE
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_dosimetrie.id > 0 then

		delete from dosimetrie
			where id = :kst_tab_dosimetrie.id 
			using kguo_sqlca_db_magazzino;
	else
		if len(trim(kst_tab_dosimetrie.lotto_dosim)) > 0 then
			
			delete from dosimetrie
				where lotto_dosim = :kst_tab_dosimetrie.lotto_dosim 
				using kguo_sqlca_db_magazzino;
				
		end if
	end if

	if kst_tab_dosimetrie.id > 0 or len(trim(kst_tab_dosimetrie.lotto_dosim)) > 0 then
	
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Tab.LOTTI DOSIMETRICI:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			if kguo_sqlca_db_magazzino.sqlcode = 100 then
				kst_esito.esito = "100"
			else
				if kguo_sqlca_db_magazzino.sqlcode > 0 then
					kst_esito.esito = "2"
				else
					kst_esito.esito = "1"
				end if
			end if
		else
			kst_esito.esito = "0"
		end if
		
		if kst_esito.esito = kkg_esito.db_ko  then
			if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		else
			
			if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
	end if
	


return kst_esito

end function

public function st_esito tb_delete_banche (string k_id);//
//====================================================================
//=== Cancella il rek dalla tabella BANCHE
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
string k_des
string k_rag_soc
long k_id_cliente, k_num
date k_data, k_scad
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

declare ric cursor for
	select num_fatt, data_fatt, scad,
			 clienti.codice, rag_soc_10, banche.descrizione
		from (ric left outer join clienti on
		     ric.clie = clienti.codice)
			  left outer join banche on
			  ric.tipo = banche.codice
		where ric.tipo = :k_id 
		      and (ric.flag_st is null or ric.flag_st = ' ');

		
open ric;
if sqlca.sqlcode = 0 then
	fetch ric into :k_num, :k_data, :k_scad, :k_id_cliente, :k_rag_soc, :k_des;
	if sqlca.sqlcode = 0 then
		k_rek_ok = 1
	end if
	close ric;
end if
	
if k_rek_ok = 1 then
	messagebox("Cancellazione Banca :" + trim(k_id) + "~n~r" + trim(k_des) + "~n~r" + &
	      "non consentita. ~n~r",&
			"Codice Banca risulta abbinato a Scadenze non ancora esitate~n~r" + &
			"Ad esempio alla fattura: " + string (k_num, "#####") + "-" + &
			string(k_data, "dd-mm-yy") + " scadenza il" + string(k_scad, "dd-mm-yy") + "~n~r" + &
			"di " + string(k_id_cliente, "#####") + "-" + trim(k_rag_soc), &
			stopsign!, ok!) 
	kst_esito.esito = "2"
	kst_esito.SQLErrText = "Tab.Banche, elaborazione non Consentita : Cod. Banca ancora in Scadenzario" 
else

	delete from ric
		where id = :k_id 
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.LOTTI DOSIMETRICI:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else
				kst_esito.esito = "1"
			end if
		end if
	else
		kst_esito.esito = "0"
	end if

	
	if kst_esito.esito = kkg_esito.db_ko  then
//		if kst_tab_province.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_province.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
//		end if
	else
		
//		if kst_tab_province.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_province.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
//		end if
	end if


end if



return kst_esito

end function

public function st_esito tb_delete_gruppi (integer k_id);//
//====================================================================
//=== Cancella il rek dalla tabella GRUPPI (GRU)
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
string k_id_art, k_des
st_esito kst_esito



	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

	declare prodotti cursor for
		select codice, 
				 des
			from prodotti
			where gruppo = :k_id ;

	open prodotti;
	if sqlca.sqlcode = 0 then
		fetch prodotti into :k_id_art, :k_des;
		if sqlca.sqlcode = 0 then
			k_rek_ok = 1
		end if
		close prodotti;
	end if
		
	if k_rek_ok = 1 then
		messagebox("Elimina cod. Gruppo Articolo :" + string(k_id) + " non consentita",&
				"Codice Gruppo risulta gia' associato ~n~r" + &
				"Ad esempio all'articolo : " + string (k_id_art, "#####") + "-" + &
				trim(k_des),&
				stopsign!, ok!) 
		kst_esito.esito = "2"
		kst_esito.SQLErrText = "Tab.Gruppi, elaborazione non Consentita : Cod.Gruppo censito nella tab.Articoli" 
	else
	
		delete from gru
			where codice = :k_id 
			using sqlca;

		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Gruppi Articoli:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = "100"
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = "2"
				else
					kst_esito.esito = "1"
				end if
			end if
		else
			kst_esito.esito = "0"
		end if
		
		
		if kst_esito.esito = kkg_esito.db_ko  then
//			if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
//			end if
		else
			
//			if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
//			end if
		end if
		
	end if

return kst_esito

end function

public function st_esito tb_delete_iva (integer k_id);//
//====================================================================
//=== Cancella il rek dalla tabella IVA
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
string k_id_art, k_des
string k_rag_soc, k_localita
long k_id_cliente, k_num
date k_data
st_esito kst_esito


	setpointer(kkg.pointer_attesa)
	
	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

declare clienti cursor for
	select codice, 
			 rag_soc_10,
			 loc_1
		from clienti
		where iva = :k_id ;

declare prodotti cursor for
	select codice, 
			 des
		from prodotti
		where iva = :k_id ;

declare arfa cursor for
	select   num_fatt, 
			 data_fatt
		from arfa
		where id_fattura in (
	select max(id_fattura)
		from arfa
		where iva = :k_id and data_fatt > '01.01.2000');

open arfa;
if sqlca.sqlcode = 0 then
	fetch arfa into :k_num, :k_data;
	if sqlca.sqlcode = 0 and k_num > 0 then
		k_rek_ok = 1
	end if
	close arfa;
end if
	
if k_rek_ok = 1 then
	messagebox("Elimina cod. IVA :" + string(k_id) + " non consentita",&
			"Codice IVA risulta gia' in Fattura~n~r" + &
			"Ad esempio al numero : " + string (k_num, "#") + " del " + &
			string(k_data, "dd/mm/yyyy"),&
			stopsign!, ok!) 
	kst_esito.esito = "2"
	kst_esito.SQLErrText = "Tab.Aliquote IVA, codice gia' utilizzato in Fattura" 
else
		
	open prodotti;
	if sqlca.sqlcode = 0 then
		fetch prodotti into :k_id_art, :k_des;
		if sqlca.sqlcode = 0 then
			k_rek_ok = 1
		end if
		close prodotti;
	end if
		
	if k_rek_ok = 1 then
		messagebox("Elimina cod. IVA :" + string(k_id) + " non consentita",&
				"Codice IVA risulta gia' abbinato ad Articoli~n~r" + &
				"Ad esempio al: " + string (k_id_art, "#####") + "-" + &
				trim(k_des),&
				stopsign!, ok!) 
		kst_esito.esito = "2"
		kst_esito.SQLErrText = "Tab.Aliquote IVA, codice gia' censito in tab Anag.Articoli"
	else
	
		open clienti;
		if sqlca.sqlcode = 0 then
			fetch clienti into :k_id_cliente, :k_rag_soc, :k_localita;
			if sqlca.sqlcode = 0 then
				k_rek_ok = 1
			end if
			close clienti;
		end if
		if k_rek_ok = 1 then
			messagebox("Elimina cod. IVA :" + string(k_id) + " non consentita",&
				"Codice IVA risulta gia' abbinato ai Clienti in Anagrafe~n~r" + &
				"Ad esempio al codice: " + string(k_id_cliente) + " " + trim (k_rag_soc) + "~n~rdi " + &
				trim(k_localita),&
				stopsign!, ok!) 
			kst_esito.esito = "2"
			kst_esito.SQLErrText = "Tab.Aliquote IVA, codice gia' censito in tab Anag.Clienti"
		else
	
	
			delete from iva
				where codice = :k_id 
				using sqlca;
	
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Aliquote IVA:" + trim(sqlca.SQLErrText)
				if sqlca.sqlcode = 100 then
					kst_esito.esito = "100"
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = "2"
					else
						kst_esito.esito = "1"
					end if
				end if
			else
				kst_esito.esito = "0"
			end if
			
		
			if kst_esito.esito = kkg_esito.db_ko  then
//				if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_rollback_1( )
//				end if
			else
				
//				if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
					kGuf_data_base.db_commit_1( )
//				end if
			end if
				
		end if
	end if
end if

setpointer(kkg.pointer_default)


return kst_esito

end function

public function st_esito tb_delete_pagam (integer k_id);//
//====================================================================
//=== Cancella il rek dalla tabella PAGAM
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   come standard 
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
string k_id_art, k_des
string k_rag_soc, k_localita
long k_id_cliente, k_num
date k_data
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

declare clienti cursor for
	select codice, 
			 rag_soc_10,
			 loc_1
		from clienti
		where cod_pag = :k_id ;

declare arfa cursor for
	select num_fatt, 
			 data_fatt
		from arfa
		where cod_pag = :k_id ;
		
open arfa;
if sqlca.sqlcode = 0 then
	fetch arfa into :k_num, :k_data;
	if sqlca.sqlcode = 0 then
		k_rek_ok = 1
	end if
	close arfa;
end if
	
if k_rek_ok = 1 then
	messagebox("Elimina cod. Pagamento :" + string(k_id) + " non consentita",&
			"Codice Pagamento risulta gia' abbinato a Fatture~n~r" + &
			"Ad esempio alla : " + string (k_num, "#####") + "-" + &
			string(k_data, "dd-mm-yy"),&
			stopsign!, ok!) 
	kst_esito.esito = kkg_esito.db_wrn
	kst_esito.SQLErrText = "Tab.Tipi Pagamento, codice gia' caricato nelle Fatture" 
else

	open clienti;
	if sqlca.sqlcode = 0 then
		fetch clienti into :k_id_cliente, :k_rag_soc, :k_localita;
		if sqlca.sqlcode = 0 then
			k_rek_ok = 1
		end if
		close clienti;
	end if
	if k_rek_ok = 1 then
		messagebox("Elimina cod. IVA :" + string(k_id) + " non consentita",&
			"Codice IVA risulta gia' abbinato ad Anagrafiche Clienti~n~r" + &
			"Ad esempio a : " + string(k_id_cliente) + " " + trim (k_rag_soc) + "~n~rdi " + &
			trim(k_localita),&
			stopsign!, ok!) 
		kst_esito.esito = kkg_esito.db_wrn
		kst_esito.SQLErrText = "Tab.Tipi Pagamento, codice gia' censito in tab. Anag. Cienti" 
	else


		delete from pagam
			where codice = :k_id 
			using sqlca;

		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Tipi Pagamento:" + trim(sqlca.SQLErrText)
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
			kst_esito.esito = kkg_esito.ok
		end if
		
		if kst_esito.esito = kkg_esito.db_ko  then
//			if kst_tab_nazioni.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_nazioni.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
//			end if
		else
			
//			if kst_tab_nazioni.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_nazioni.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
//			end if
		end if
		
	end if
end if



return kst_esito


end function

public function st_esito tb_delete_misure (integer k_larg, integer k_lung, integer k_alt);//
//====================================================================
//=== Cancella il rek dalla tabella MISURE
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
st_esito kst_esito


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 
	
	delete from misure
		where larg = :k_larg and
				lung = :k_lung and
				alt = :k_alt 
		using sqlca;
	

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Misure:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else
				kst_esito.esito = "1"
			end if
		end if
	else
		kst_esito.esito = "0"
	end if

		
	if kst_esito.esito = kkg_esito.db_ko  then
//		if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
//		end if
	else
		
//		if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
//		end if
	end if


return kst_esito


end function

public function st_esito tb_delete_treeview (string k_id);//
//====================================================================
//=== Cancella il rek dalla tabella TREEVIEW (Navigatore)
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
st_esito kst_esito


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""


//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

	delete from treeview
		where id = :k_id
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Navigatore (treeview):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else
				kst_esito.esito = "1"
			end if
		end if
	else
		kst_esito.esito = "0"
	end if
	
		
	if kst_esito.esito = kkg_esito.db_ko  then
//		if kst_tab_nazioni.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_nazioni.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
//		end if
	else
		
//		if kst_tab_nazioni.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_nazioni.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
//		end if
	end if


return kst_esito

end function

public function st_esito tb_dosimetrie_ultimo (ref st_tab_dosimetrie kst_tab_dosimetrie);//
//====================================================================
//=== Torna l'ultimo rec attivo dosimetrico inserito
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	declare c_tb_dosim_last cursor for 
	  SELECT dosimetrie.id,   
				dosimetrie.attivo,   
				dosimetrie.dose,   
				dosimetrie.coeff_a_s,   
				dosimetrie.lotto_dosim,   
				dosimetrie.data,   
				dosimetrie.note,   
				dosimetrie.x_datins,   
				dosimetrie.x_utente  
		 FROM dosimetrie  
			where attivo = 'S' 
			order by id desc 
			using sqlca;

	open c_tb_dosim_last;
	
	if sqlca.sqlcode <> 0 then
		
		kst_esito.esito = "100"
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Lotti Dosimetrici:" + trim(sqlca.SQLErrText)
		
	else
		
		fetch c_tb_dosim_last 		
		 INTO :kst_tab_dosimetrie.id,   
				:kst_tab_dosimetrie.attivo,   
				:kst_tab_dosimetrie.dose,   
				:kst_tab_dosimetrie.coeff_a_s,   
				:kst_tab_dosimetrie.lotto_dosim,   
				:kst_tab_dosimetrie.data,   
				:kst_tab_dosimetrie.note,   
				:kst_tab_dosimetrie.x_datins,   
				:kst_tab_dosimetrie.x_utente ; 

		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Lotti Dosimetrici:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = "100"
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = "2"
				else
					kst_esito.esito = "1"
				end if
			end if
		else
			kst_esito.esito = "0"
		end if
				
		close c_tb_dosim_last;
	end if


return kst_esito

end function

public function st_esito tb_dosimetrie_select (ref st_tab_dosimetrie kst_tab_dosimetrie);//
//====================================================================
//=== get dati dosimetrici
//=== 
//=== Inp: st_tab_dosimetrie lotto_dosim / coeff_a_s / dose
//===
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_dosimetrie.coeff_a_s = round(kst_tab_dosimetrie.coeff_a_s, 3)

	declare c_tb_dosim_last cursor for 
	  SELECT dosimetrie.id,   
				dosimetrie.attivo,   
				dosimetrie.dose,   
				dosimetrie.coeff_a_s,   
				dosimetrie.lotto_dosim,   
				dosimetrie.data,   
				dosimetrie.note,   
				dosimetrie.x_datins,   
				dosimetrie.x_utente  
		 FROM dosimetrie  
			where attivo = 'S' 
			    and lotto_dosim = :kst_tab_dosimetrie.lotto_dosim 
				 and (
				      (:kst_tab_dosimetrie.coeff_a_s > 0 and coeff_a_s = :kst_tab_dosimetrie.coeff_a_s)
				       or
						(:kst_tab_dosimetrie.dose > 0 and dose <= :kst_tab_dosimetrie.dose)
					)	
			order by dose desc 
			using sqlca;

	open c_tb_dosim_last;
	
	if sqlca.sqlcode <> 0 then
		
		kst_esito.esito = "100"
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Lotti Dosimetrici:" + trim(sqlca.SQLErrText)
		
	else
		
		fetch c_tb_dosim_last 		
		 INTO :kst_tab_dosimetrie.id,   
				:kst_tab_dosimetrie.attivo,   
				:kst_tab_dosimetrie.dose,   
				:kst_tab_dosimetrie.coeff_a_s,   
				:kst_tab_dosimetrie.lotto_dosim,   
				:kst_tab_dosimetrie.data,   
				:kst_tab_dosimetrie.note,   
				:kst_tab_dosimetrie.x_datins,   
				:kst_tab_dosimetrie.x_utente ; 

		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Lotti Dosimetrici:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = "100"
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = "2"
				else
					kst_esito.esito = "1"
				end if
			end if
		else
			kst_esito.esito = "0"
		end if
				
		close c_tb_dosim_last;
	end if


return kst_esito

end function

public function st_esito tb_dosimetrie_select_lotto (ref st_tab_dosimetrie kst_tab_dosimetrie);//
//====================================================================
//=== Torna nome lotto se esistente
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

  SELECT count(*)   
       into :kst_tab_dosimetrie.id
		 FROM dosimetrie  
			where lotto_dosim = :kst_tab_dosimetrie.lotto_dosim 
			using sqlca;

	if sqlca.sqlcode <> 0 then
		
		kst_tab_dosimetrie.id = 0
		
		kst_esito.esito = "100"
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Lotti Dosimetrici:" + trim(sqlca.SQLErrText)
		
	end if


return kst_esito

end function

public function st_esito tb_dosimetrie_add (st_tab_dosimetrie kst_tab_dosimetrie);//
//====================================================================
//=== Aggiunge il rek alla tabella DOSIMETRIE
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


	kst_tab_dosimetrie.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_dosimetrie.x_utente = kGuf_data_base.prendi_x_utente()

	kst_tab_dosimetrie.id = 0
//id,
	INSERT INTO dosimetrie  
         (    
           dose,   
           lotto_dosim,   
           note,   
           data,   
           attivo,   
           coeff_a_s,   
           x_datins,   
           x_utente )  
  VALUES (  
           :kst_tab_dosimetrie.dose,   
           :kst_tab_dosimetrie.lotto_dosim,   
           :kst_tab_dosimetrie.note,   
           :kst_tab_dosimetrie.data,   
           :kst_tab_dosimetrie.attivo,   
           :kst_tab_dosimetrie.coeff_a_s,   
           :kst_tab_dosimetrie.x_datins,   
           :kst_tab_dosimetrie.x_utente 
			  )   
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Inserimento Nuovo valore Dosimetrico (kuf_ausiliari.tb_dosimetrie_add):" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		else
			kst_esito.esito = kkg_esito.db_ko
		end if

	else
		kst_esito.esito = kkg_esito.ok

		if	kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then

			kGuf_data_base.db_commit()
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Inserimento Nuovo valore Dosimetrico ('commit' in kuf_ausiliari.tb_dosimetrie_add):" + trim(sqlca.SQLErrText)
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		
		end if

	end if

		
	if kst_esito.esito = kkg_esito.db_ko  then
		if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		
		if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if


return kst_esito

end function

public function st_esito tb_dosimetrie_importa_nuovo_csv (boolean k_elaborazione_di_test);//===
//=== Importa i record del file CSV selezionato formato:
//=== prima riga con nome-lotto + ; + data-lotto (yyyy-mm-dd)
//=== seguono tutte le righe con:  coefficiente + ; + dose 
//===
int k_file=0, k_rc 
int k_bytes, k_ctr, k_ctr_1, k_bytes_f, k_righe, k_righe_insert=0
string k_rcx
string k_record
string k_path, k_nome_file, k_ext

st_esito kst_esito, kst_esito_insert
st_tab_dosimetrie kst_tab_dosimetrie
st_profilestring_ini kst_profilestring_ini
kuf_utility kuf1_utility



//=== Clessidra di attesa
setpointer(hourglass!)

	
	kst_esito.esito = kkg_esito.OK
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi
	kst_profilestring_ini.file = "ambiente" 
	kst_profilestring_ini.titolo = "ambiente" 
	kst_profilestring_ini.nome = "arch_dosimetrie_csv"
	kst_profilestring_ini.valore = " " 
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

	k_path = trim(kst_profilestring_ini.valore)

	if LenA(k_path) > 0 then
		k_rcx = k_path
		k_rc = LenA(k_rcx)
		do while MidA(k_rcx, k_rc, 1) <> "\" and k_rc > 1
			k_rcx = ReplaceA(k_rcx, k_rc, 1, " ")  
			k_rc= k_rc - 1
		loop
		if DirectoryExists ( trim(k_rcx) ) then 
			ChangeDirectory(trim(k_rcx)) 
		end if
		k_nome_file	= k_path
	end if

	if k_elaborazione_di_test or LenA(k_nome_file) = 0 then 
		k_rc = GetFileOpenName("Scegli Archivio 'Dosimetrie'", &
									k_path, k_nome_file, k_ext, "CSV File (*.csv),*.csv") 
	else
		k_rc = 1
	end if
	

if k_rc <= 0 or LenA(trim(k_nome_file)) = 0 then
	k_path = " "
	kst_esito.esito = kkg_esito.NO_ESECUZIONE
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Elaborazione interrotta dall'utente" 
	
else
	k_file = fileopen( trim(k_path), linemode!, read!, lockreadwrite!)
	
	if k_file > 0 then

		kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_scrivi
		kst_profilestring_ini.file = "ambiente" 
		kst_profilestring_ini.titolo = "ambiente" 
		kst_profilestring_ini.nome = "arch_dosimetrie_csv"
		kst_profilestring_ini.valore = trim(k_path) 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

//=== Conto il nr. di record presenti		
		k_bytes = fileread(k_file, k_record) // legge una riga
		k_righe = 0
		k_ctr = 0
		do while k_bytes <> -100 
			k_bytes = fileread(k_file, k_record) // legge una riga
			
			k_righe++     //conta le righe 
		loop
		fileclose(k_file)

		if k_righe > 1 then 
			
			kuf1_utility = create kuf_utility
	
			k_righe = 0
			k_ctr_1=0
			k_file = fileopen( trim(k_path), linemode!, read!, lockreadwrite!)

			k_bytes = fileread(k_file, k_record) // legge una riga
			k_righe++

			do while k_bytes > 0 and LenA(trim(k_record)) < 4 // Leggo le righe fino a che non trovo qualcosa
				k_bytes = fileread(k_file, k_record) // legge una riga
				k_righe++
				if k_bytes <= 0 then
					k_record = " "
				end if
			loop
	
			k_record = LeftA(k_record, k_bytes)
			if isnull(k_record) then
				k_record = " "
			end if
			
//--- primo record piglio il nome
			k_ctr = PosA (k_record, ';')
			if k_ctr > 0 then
				kst_tab_dosimetrie.lotto_dosim = LeftA(k_record, k_ctr - 1)

//--- controllo se lotto dosimetrico gia' inserito				
				tb_dosimetrie_select_lotto (kst_tab_dosimetrie)
				if kst_tab_dosimetrie.id > 0 then
					kst_esito.esito = kkg_esito.blok
					kst_esito.sqlcode = 0
					kst_esito.SQLErrText = "Nome Lotto già esistente in archivio! nessuna importazione eseguita, Lotto: " + trim(kst_tab_dosimetrie.lotto_dosim)
				else
//--- primo record piglio la data
					if (k_ctr + 1) < k_bytes then
						
//--- ricopre il punto con il trattino
						k_rcx = MidA(k_record, k_ctr + 1, 10)
						k_rcx = kuf1_utility.u_replace(k_rcx, ".", "-")
//--- ricopre la barra con il trattino
						k_rcx = kuf1_utility.u_replace(k_rcx, "/", "-")
						k_rcx = ReplaceA(k_record, k_ctr + 1, 10, k_rcx)
						
						if isdate (MidA(k_record, k_ctr + 1, 10)) then
							kst_tab_dosimetrie.data = date(MidA(k_record,k_ctr + 1, 10))
							
							k_ctr_1 = PosA (k_record, ';', k_ctr + 1)
							if k_ctr_1 > 0 then
//--- get delle Note del Lotto da stampare su Attestato								
								kst_tab_dosimetrie.note = trim(mid(k_record, k_ctr_1 + 1, len(k_record) - k_ctr_1 ))
//--- toglie dalle Note del Lotto eventuali ';'
								k_rcx = kuf1_utility.u_replace(kst_tab_dosimetrie.note, ";", " ")
								kst_tab_dosimetrie.note = trim(kst_tab_dosimetrie.note)
								
							else
								kst_esito.esito = kkg_esito.blok
								kst_esito.sqlcode = 0
								kst_esito.SQLErrText = "Mancano le Note Lotto (in stampa su Attestato) sulla prima riga del file, letto: " + trim(k_record)
							end if
							
						else
							kst_esito.esito = kkg_esito.blok
							kst_esito.sqlcode = 0
							kst_esito.SQLErrText = "Formato Data Errato deve essere es 2010-08-25, letto: " + trim(MidA(k_record,k_ctr + 1, 10))
						end if
					else
						kst_esito.esito = kkg_esito.blok
						kst_esito.sqlcode = 0
						kst_esito.SQLErrText = "Manca la Data Lotto sulla prima riga del file, letto: " + trim(k_record)
					end if
				end if
			else
				kst_esito.esito = kkg_esito.blok
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Manca il Nome Lotto sulla prima riga del file, letto: " + trim(k_record)
			end if

//--- piglio il primo record di dettaglio
			k_bytes = fileread(k_file, k_record) // legge una riga
			k_righe++
			if k_bytes <= 0 then
				k_record = " "
			end if

			do while k_bytes > 0 and kst_esito.esito = kkg_esito.OK

//--- ricopre la virgola con il punto
				k_record = kuf1_utility.u_replace(k_record, ".", ",")
						
//--- record di dettaglio piglio il coefficiente
				k_ctr = PosA (k_record, ';')
				if k_ctr > 0 then
					if isnumber(trim(MidA(k_record,1, k_ctr - 1))) then
						kst_tab_dosimetrie.coeff_a_s = double(trim(MidA(k_record,1, k_ctr - 1)))
						if (k_ctr + 1) < k_bytes then
//--- record di dettaglio piglio la Dose
							k_ctr_1 = PosA (k_record, ';', k_ctr + 1)
							if k_ctr_1 > 0 then
								if isnumber(trim(MidA(k_record,k_ctr+1, k_ctr_1 - k_ctr - 1))) then
									kst_tab_dosimetrie.dose = double(trim(MidA(k_record,k_ctr+1, k_ctr_1 - k_ctr - 1)))
								else
									kst_esito.esito = kkg_esito.blok
									kst_esito.sqlcode = 0
									kst_esito.SQLErrText = "Dose non numerico vedi riga " + string(k_righe) + ", valore: " + trim(MidA(k_record,k_ctr+1, k_ctr_1 - k_ctr - 1))
								end if
							else
								if isnumber(trim(MidA(k_record, k_bytes - k_ctr))) then
									kst_tab_dosimetrie.dose = double(trim(MidA(k_record, k_ctr + 1, k_bytes - k_ctr )))
								else
									kst_esito.esito = kkg_esito.blok
									kst_esito.sqlcode = 0
									kst_esito.SQLErrText = "Dose non numerico vedi riga " + string(k_righe) + ", valore: " + trim(MidA(k_record, k_ctr+1, k_bytes - k_ctr))
								end if
							end if
							
							if kst_esito.esito = kkg_esito.OK then
								kst_tab_dosimetrie.attivo = "S"
								
//--- inserisci nuovo record								
								if not k_elaborazione_di_test then 
									
									kst_esito_insert = tb_dosimetrie_add(kst_tab_dosimetrie)
									if kst_esito_insert.esito = kkg_esito.ok then
										k_righe_insert++
									else
										kst_esito.esito = kst_esito_insert.esito
										kst_esito.sqlcode = kst_esito_insert.sqlcode
										kst_esito.SQLErrText = "Inserimento valore in archivio fallito (" +trim(kst_esito_insert.SQLErrText)+")"
									end if
									
								end if
								
							end if
							
						end if
					else
						kst_esito.esito = kkg_esito.blok
						kst_esito.sqlcode = 0
						kst_esito.SQLErrText = "Coefficiente non numerico vedi riga " + string(k_righe) + ", valore: " + trim(MidA(k_record, 1, k_ctr - 1))
					end if
				end if
				
				k_bytes = fileread(k_file, k_record) // legge una riga
				k_righe++
				if k_bytes <= 0 then
					k_record = " "
				end if

			loop
			
			fileclose(k_file)
			
			destroy kuf1_utility
			
		else
			kst_esito.esito = kkg_esito.blok
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "File inconistente numero righe insufficiente: " + string(k_righe)
		end if
	else
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "File non trovato o occupato, cercato: " + trim(k_path) 
	end if

	if kst_esito.esito <> kkg_esito.ok then
			
		if k_elaborazione_di_test then 
			kst_esito.SQLErrText = "Riscontrati errori nel File~n~r" + "Errore rilevato~n~r" &
			                     + trim(kst_esito.SQLErrText) + "~n~r" &
			                     + string(k_righe, "##,##0") + " righe elaborate~n~r" &
			                     + "dal file " + trim(k_path) + "~n~r" 
		else
			
			kst_esito.SQLErrText = "Elaborazione terminata con Errore~n~r" + "controllare i valori inseriti.~n~r" &
										+ "Errore rilevato~n~r" &
			                     + trim(kst_esito.SQLErrText) + "~n~r" &
			                     + string(k_righe, "##,##0") + " righe elaborate~n~r" &
			                     + "dal file " + trim(k_path) + "~n~r" 
			
		end if	
	else
		if k_elaborazione_di_test then 
			kst_esito.SQLErrText = "File Corretto~n~r" + "~n~r" &
			                     + string(k_righe, "##,##0") + " righe da elaborare~n~r" &
			                     + "dal file " + trim(k_path) + "~n~r" 
		else
			
			kst_esito.SQLErrText = "Elaborazione terminata Correttamente~n~r" + "controllare i valori inseriti.~n~r" &
			                     + string(k_righe, "##,##0") + " righe lette dal file~n~r" &
			                     + string(k_righe_insert, "##,##0") + " righe inserite in archivio~n~r" &
			                     + "dal file " + trim(k_path) + "~n~r" 
			
		end if	
	end if

end if

//--- ripristina la path di lavoro
kGuf_data_base.setta_path_default()
							
							
return kst_esito


end function

public function st_esito tb_dosimetrie_select_lotto_1 (ref st_tab_dosimetrie kst_tab_dosimetrie);//
//====================================================================
//=== Torna se attivo o meno
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kst_tab_dosimetrie.attivo = " "
	kst_tab_dosimetrie.id=0

	declare c_tb_dosimetrie_1 cursor  for
   SELECT distinct attivo   
		 FROM  dosimetrie  
			where dosimetrie.lotto_dosim = :kst_tab_dosimetrie.lotto_dosim 
			      and dosimetrie.attivo = 'S' ;
			

	open c_tb_dosimetrie_1;
	
	fetch c_tb_dosimetrie_1 into :kst_tab_dosimetrie.attivo;
	if sqlca.sqlcode = 100 then
			
		declare c_tb_dosimetrie_2 cursor  for
		   SELECT distinct attivo   
			 FROM  dosimetrie  
				where dosimetrie.lotto_dosim = :kst_tab_dosimetrie.lotto_dosim 
			      and dosimetrie.attivo = 'N';
			
		open c_tb_dosimetrie_2;
		
		fetch c_tb_dosimetrie_2 into :kst_tab_dosimetrie.attivo;

		if sqlca.sqlcode <> 0 then
		
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
			
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Lotti Dosimetrici:" + trim(sqlca.SQLErrText)
			
		end if
		close c_tb_dosimetrie_2;
	else
		if sqlca.sqlcode <> 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Lotti Dosimetrici:" + trim(sqlca.SQLErrText)
		end if
	end if
			
	close c_tb_dosimetrie_1;


return kst_esito

end function

public function st_esito tb_delete_causali (string k_id);//
//====================================================================
//=== Cancella il rek dalla tabella CAUSALI (CAUS)
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
st_esito kst_esito


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 
	
	delete from caus
		where codice = :k_id
		using sqlca;
	

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Causali di Spedizione:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else
				kst_esito.esito = "1"
			end if
		end if
	else
		kst_esito.esito = "0"
	end if


	if kst_esito.esito = kkg_esito.db_ko  then
//		if kst_tab_cap.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_cap.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
//		end if
	else
		
//		if kst_tab_cap.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_cap.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
//		end if
	end if


return kst_esito

end function

public function st_esito tb_delete_meca_causali (long k_id);//
//====================================================================
//=== Cancella il rek dalla tabella CAUSALI DI ENTRATA (MECA_CAUSALI)
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Come da Standard 
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
st_esito kst_esito
st_tab_meca kst_tab_meca


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

	
	declare meca_blk cursor for
		select id_meca
			from meca_blk
			where id_meca_causale = :k_id ;

	open meca_blk;
	if sqlca.sqlcode = 0 then
		fetch meca_blk into :kst_tab_meca.id;
		if sqlca.sqlcode = 0 then
			k_rek_ok = 1
			select num_int, data_int
			    into :kst_tab_meca.num_int, :kst_tab_meca.data_int
			    from meca
				 where id = :kst_tab_meca.id
				 using sqlca;
		end if
		close meca_blk;
	end if
		
	if k_rek_ok = 1 then
		messagebox("Cancellazione Causale di Entrata " + string(k_id) + " non consentita",&
				"Codice Causale risulta gia' abbinato ai Riferimenti~n~r" + &
				"ad esempio al: " + string (kst_tab_meca.num_int, "#####") + " del " + &
				string(kst_tab_meca.data_int),&
				stopsign!, ok!) 
		kst_esito.esito = "2"
		kst_esito.SQLErrText = "Tab.Causali di Entrata, elaborazione non Consentita : Cod.Causale gia' nella tab.Riferimenti" 
	else
	
		delete from meca_causali
			where id_meca_causale = :k_id
			using sqlca;
		
	
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Causali di Entrata:" + trim(sqlca.SQLErrText)
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
			kst_esito.esito = kkg_esito.ok
		end if
		
		
		if kst_esito.esito = kkg_esito.db_ko  then
//			if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
//			end if
		else
			
//			if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
//			end if
		end if
		
	end if


return kst_esito

end function

public function st_esito tb_delete_nazioni (st_tab_nazioni kst_tab_nazioni);//
//====================================================================
//=== Cancella il rek dalla tabella NAZIONI
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	delete from nazioni
		where id_nazione = :kst_tab_nazioni.id_nazione 
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. Nazioni:" + trim(sqlca.SQLErrText)
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
		kst_esito.esito = kkg_esito.ok
	end if

		
	if kst_esito.esito = kkg_esito.db_ko  then
		if kst_tab_nazioni.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_nazioni.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		
		if kst_tab_nazioni.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_nazioni.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if



return kst_esito

end function

public function st_esito tb_delete_cap (st_tab_cap kst_tab_cap);//
//====================================================================
//=== Cancella il rek dalla tabella CAP
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	delete from CAP
		where cap = :kst_tab_cap.cap 
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. CAP:" + trim(sqlca.SQLErrText)
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
		kst_esito.esito = kkg_esito.ok
	end if

	
	if kst_esito.esito = kkg_esito.db_ko  then
		if kst_tab_cap.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_cap.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		
		if kst_tab_cap.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_cap.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if


return kst_esito

end function

public function st_esito tb_select (ref st_tab_nazioni k_st_tab_nazioni);//
//--- restituisce riga letta da tab NAZIONI
//--- ritorna: oltre alla struttura della tab Nazioni
//---          st_esito standard
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if LenA(trim(k_st_tab_nazioni.id_nazione)) > 0 then
	select id_nazione, nome, area, gruppo
	   into :k_st_tab_nazioni.id_nazione,
		     :k_st_tab_nazioni.nome,
			  :k_st_tab_nazioni.area,
			  :k_st_tab_nazioni.gruppo
	   from nazioni
		where id_nazione = trim(:k_st_tab_nazioni.id_nazione)
				using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.SQLErrText = "Tab.Nazioni: " + trim(sqlca.SQLErrText)
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = kkg_esito.db_ko
			else
				kst_esito.esito = kkg_esito.db_wrn
			end if
		end if
	end if
end if

return kst_esito

end function

public function st_esito tb_select (ref st_tab_cap k_st_tab_cap);//
//--- restituisce riga letta da tab CAP
//--- ritorna: oltre alla struttura della tab CAP
//---          st_esito standard
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if LenA(trim(k_st_tab_cap.cap)) > 0 then
	select cap, prov, localita
	   into :k_st_tab_cap.cap,
		     :k_st_tab_cap.prov,
			  :k_st_tab_cap.localita
	   from cap
		where cap = trim(:k_st_tab_cap.cap)
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.SQLErrText = "Tab.CAP: " + trim(sqlca.SQLErrText)
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = kkg_esito.db_ko
			else
				kst_esito.esito = kkg_esito.db_wrn
			end if
		end if
	end if
end if

return kst_esito

end function

public function st_esito tb_select_cap_provincia (ref st_tab_cap k_st_tab_cap);//
//--- restituisce riga letta da tab CAP con il dato PROVINCIA
//--- ritorna: oltre alla struttura della tab CAP con il CAP minore Impostato
//---          st_esito standard
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if LenA(trim(k_st_tab_cap.prov)) > 0 then
	select min(cap) 
	   into :k_st_tab_cap.cap
	   from cap
		where prov = trim(:k_st_tab_cap.prov)
		using sqlca;
		
	if sqlca.sqlcode <> 0 or LenA(trim(k_st_tab_cap.cap)) = 0 then
		kst_esito.SQLErrText = "Tab.CAP: " + trim(sqlca.SQLErrText)
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 or LenA(trim(k_st_tab_cap.cap)) = 0 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = kkg_esito.db_ko
			else
				kst_esito.esito = kkg_esito.db_wrn
			end if
		end if
	end if
end if

return kst_esito

end function

public function st_esito tb_select (ref st_tab_pagam k_st_tab_pagam);//
//--- restituisce riga letta da tab TIPO PAGAMENTI
//--- ritorna: oltre alla struttura della tab Pagamenti
//---          st_esito standard
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if k_st_tab_pagam.codice > 0 then

            select
                  PAGAM.DES,
                  PAGAM.TIPO,
                  PAGAM.SCAD,
                  PAGAM.RATE,
                  PAGAM.GG_1_RATA,
                  PAGAM.GG_INT,
                  PAGAM.GG_ULTERIORI
              into 
                   :k_st_tab_pagam.des,
                   :k_st_tab_pagam.TIPO,
                   :k_st_tab_pagam.SCAD,
                   :k_st_tab_pagam.RATE,
                   :k_st_tab_pagam.GG_1_RATA,
                   :k_st_tab_pagam.GG_INT,
                   :k_st_tab_pagam.GG_ULTERIORI
              from PAGAM
              where
                    PAGAM.CODICE     = :k_st_tab_pagam.codice
				using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.SQLErrText = "Tab.Tipi di Pagamento: " + trim(sqlca.SQLErrText)
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = kkg_esito.db_ko
			else
				kst_esito.esito = kkg_esito.db_wrn
			end if
		end if
	else
		if_isnull_tb(k_st_tab_pagam)
	end if
end if

return kst_esito

end function

public function st_esito tb_select (ref st_tab_iva k_st_tab_iva);//
//--- restituisce riga letta da tab IVA
//--- ritorna: oltre alla struttura della tab IVA
//---          st_esito standard
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if k_st_tab_iva.codice > 0 then

                  select 
                       DES
                       ,ALIQ
					,fatt_norme_bolli
					,f_splitpayment
                     into
                         	:k_st_tab_iva.DES 
                         	,:k_st_tab_iva.ALIQ 
						,:k_st_tab_iva.fatt_norme_bolli
						,:k_st_tab_iva.f_splitpayment
                     from IVA
                     where IVA.CODICE  = :k_st_tab_iva.CODICE
				using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.SQLErrText = "Tab.Aliq. IVA: " + trim(sqlca.SQLErrText)
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = kkg_esito.db_ko
			else
				kst_esito.esito = kkg_esito.db_wrn
			end if
		end if
	end if
end if

return kst_esito

end function

public function st_esito tb_select (ref st_tab_gru kst_tab_gru);//
//--- restituisce riga letta da tab TIPO PAGAMENTI
//--- ritorna: oltre alla struttura della tab Pagamenti
//---          st_esito standard
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_gru.codice > 0 then


  SELECT gru.des,   
         gru.des_eng,   
         gru.conto,   
         gru.s_conto,   
         gru.conto_m_1,   
         gru.s_conto_m_1,   
         gru.conto_m_2,   
         gru.s_conto_m_2, 
         gru.escludi_da_stat_glob  
			
    INTO :kst_tab_gru.des,   
         :kst_tab_gru.des_eng,   
         :kst_tab_gru.conto,   
         :kst_tab_gru.s_conto,   
         :kst_tab_gru.conto_m_1,   
         :kst_tab_gru.s_conto_m_1,   
         :kst_tab_gru.conto_m_2,   
         :kst_tab_gru.s_conto_m_2,  
         :kst_tab_gru.escludi_da_stat_glob  
    FROM gru 
	 where
            CODICE     = :kst_tab_gru.codice
	 using sqlca;


	if_isnull_tb(kst_tab_gru)

	if sqlca.sqlcode <> 0 then
		kst_esito.SQLErrText = "Tab.Gruppi (cod.:"+string(kst_tab_gru.codice)+"): " + trim(sqlca.SQLErrText)
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = kkg_esito.db_ko
			else
				kst_esito.esito = kkg_esito.db_wrn
			end if
		end if
	end if
end if

return kst_esito

end function

public function boolean link_call (ref datawindow kdw_1, string k_campo_link) throws uo_exception;//
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
string k_dataobject, k_id_programma
st_tab_clie_settori kst_tab_clie_settori
st_tab_gru kst_tab_gru
st_esito kst_esito
//uo_exception kuo_exception
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_menu_window kuf1_menu_window
//kuf_sicurezza kuf1_sicurezza


try
	SetPointer(kkg.pointer_attesa)

	kdsi_elenco_output = create datastore
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	
	
	choose case k_campo_link
	
		case "b_cap_l" 
			k_dataobject = kki_cap_l
			kst_open_w.key1 = "elenco CAP "
			k_id_programma = this.get_id_programma(kkg_flag_modalita.elenco)
	
		case "b_clie_settori" 
			k_dataobject = kki_clie_settori_l
			kst_open_w.key1 = "elenco Settori Merceologici "
			k_id_programma = this.get_id_programma(kkg_flag_modalita.elenco)
	
		case "b_clie_classi" 
			k_dataobject = kki_clie_classi_l
			kst_open_w.key1 = "elenco Classi di Valenza "
			k_id_programma = this.get_id_programma(kkg_flag_modalita.elenco)
	
		case "b_nazioni_l" 
			k_dataobject = kki_nazioni_l
			kst_open_w.key1 = "elenco Nazioni "
			k_id_programma = this.get_id_programma(kkg_flag_modalita.elenco)
			
		case "gruppo" 
			k_dataobject = kki_gruppo
			kst_tab_gru.codice = kdw_1.getitemnumber(kdw_1.getrow(), k_campo_link)
			if kst_tab_gru.codice > 0 then
				kst_open_w.key1 = "Gruppo " + trim(string(kst_tab_gru.codice))
				k_id_programma = this.get_id_programma(kkg_flag_modalita.elenco)
			else
				k_return = false	
			end if
			
		case "id_clie_settore" 
			k_dataobject = kki_clie_settore
			kst_tab_clie_settori.id_clie_settore = kdw_1.getitemstring(kdw_1.getrow(), k_campo_link)
			if len(trim(string(kst_tab_clie_settori.id_clie_settore))) > 0 then
				kst_open_w.key1 = "Settore clienti " + trim(string(kst_tab_clie_settori.id_clie_settore))
				k_id_programma = this.get_id_programma(kkg_flag_modalita.elenco)
			else
				k_return = false	
			end if
	
		case "b_meca_causali_l" 
			k_dataobject = kki_meca_causali
			kst_open_w.key1 = "Elenco Causali Lotto di Entrata"
			k_id_programma = this.get_id_programma(kkg_flag_modalita.elenco)
	
		case "b_lotto_dosim" &
		  ,"b_dosim_lotto_dosim_l"
			k_dataobject = "d_dosimetrie_lotto_l"
			kst_open_w.key1 = "Elenco lotti dati Dosimetrici " 
			k_id_programma = this.get_id_programma(kkg_flag_modalita.elenco)

end choose
	
	
	if k_return then
	
		kst_open_w = kst_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.id_programma = k_id_programma 
		
		//--- controlla se utente autorizzato alla funzione in atto
		k_return = if_sicurezza(kst_open_w)
		
		if not k_return then
			throw kguo_exception
		
		else
		
			kdsi_elenco_output.dataobject = k_dataobject		
			kdsi_elenco_output.settransobject(sqlca)
				
	//--- retrive 
			choose case k_campo_link
	
				case "gruppo" 
					k_rc=kdsi_elenco_output.retrieve(kst_tab_gru.codice)
					
				case "id_clie_settore" 
					k_rc=kdsi_elenco_output.retrieve(kst_tab_clie_settori.id_clie_settore)
					
				case else
					k_rc=kdsi_elenco_output.retrieve()
					
			end choose
			
			if kdsi_elenco_output.rowcount() > 0 then
			
				
			//--- chiamare la window di elenco
			//
			//=== Parametri : 
			//=== struttura st_open_w
				kst_open_w.id_programma =kkg_id_programma.elenco
				kst_open_w.flag_primo_giro = "S"
				kst_open_w.flag_modalita = kkg_flag_modalita.elenco
				kst_open_w.flag_adatta_win = KKg.ADATTA_WIN
				kst_open_w.flag_leggi_dw = " "
				kst_open_w.flag_cerca_in_lista = " "
				kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
				kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
				kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
				kst_open_w.key12_any = kdsi_elenco_output
				kst_open_w.flag_where = " "
				kuf1_menu_window = create kuf_menu_window 
				kuf1_menu_window.open_w_tabelle(kst_open_w)
				destroy kuf1_menu_window
		
		
			else
				kguo_exception.inizializza( )
				kguo_exception.setmessage( "Nessun valore disponibile. " )
				throw kguo_exception
				
				
			end if
		end if
	
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.pointer_default)
end try


return k_return

end function

public function st_esito tb_delete (st_tab_clie_settori kst_tab_clie_settori);//
//====================================================================
//=== Cancella il rek dalla tabella SETTORI MERCEOLOGICI
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_tab_clienti kst_tab_clienti
st_esito kst_esito
kuf_clienti kuf1_clienti


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kuf1_clienti = create kuf_clienti
	
	try
		
		kst_tab_clienti.id_clie_settore = kst_tab_clie_settori.id_clie_settore 
		if kuf1_clienti.if_presente_id_clie_settore(kst_tab_clienti) > 0 then
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Settorie non elminato perchè associato ai Clienti "
			kst_esito.esito = kkg_esito.err_logico
			
		else
			
			delete from clie_settori
				where id_clie_settore = :kst_tab_clie_settori.id_clie_settore 
				using sqlca;
		
		
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab. Settori Merceologici:" + trim(sqlca.SQLErrText)
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
				if kst_esito.esito = kkg_esito.db_ko  then
					if kst_tab_clie_settori.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clie_settori.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_rollback_1( )
					end if
				else
					
					if kst_tab_clie_settori.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clie_settori.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_commit_1( )
					end if
				end if
			end if
		end if	

	catch (uo_exception kuo_exception)
		
		kst_esito = kuo_exception.get_st_esito( )

	finally
		destroy kuf1_clienti

	end try

	
return kst_esito


end function

public function st_esito tb_delete (st_tab_clie_classi kst_tab_clie_classi);//
//====================================================================
//=== Cancella il rek dalla tabella CLASSI di VALENZA
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================
st_tab_clienti kst_tab_clienti
st_esito kst_esito
kuf_clienti kuf1_clienti


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kuf1_clienti = create kuf_clienti
	
	try
		
		kst_tab_clienti.id_clie_classe = kst_tab_clie_classi.id_clie_classe 
		if kuf1_clienti.if_presente_id_clie_settore(kst_tab_clienti) > 0 then
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Classe non elminata perchè associata ai Clienti "
			kst_esito.esito = kkg_esito.err_logico
			
		else
	
			delete from clie_classi
				where id_clie_classe = :kst_tab_clie_classi.id_clie_classe 
				using sqlca;
		
		
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab. Classi:" + trim(sqlca.SQLErrText)
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
				
				if kst_esito.esito = kkg_esito.db_ko  then
					if kst_tab_clie_classi.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clie_classi.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_rollback_1( )
					end if
				else
					
					if kst_tab_clie_classi.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_clie_classi.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_commit_1( )
					end if
			
				end if
					
			end if
		end if	

	catch (uo_exception kuo_exception)
		
		kst_esito = kuo_exception.get_st_esito( )

	finally
		destroy kuf1_clienti

	end try

	
return kst_esito

end function

public function st_esito tb_select (ref st_tab_clie_settori kst_tab_clie_settori);//
//--- restituisce riga letta da tab SETTORI MERCEOLOGICI
//--- ritorna: oltre alla struttura della tab Settori
//---          st_esito standard
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if len(trim(kst_tab_clie_settori.id_clie_settore)) > 0 then

            select
                  DESCR
                  ,DESCR_eng
              into 
                   :kst_tab_clie_settori.descr
                   ,:kst_tab_clie_settori.descr_eng
              from clie_settori
              where
                    clie_settori.id_clie_settore     = :kst_tab_clie_settori.id_clie_settore
				using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.SQLErrText = "Tab.Tipi Settori: " + trim(sqlca.SQLErrText)
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = kkg_esito.db_ko
			else
				kst_esito.esito = kkg_esito.db_wrn
			end if
		end if
	else
		if_isnull_tb(kst_tab_clie_settori)
	end if
end if

return kst_esito

end function

public function st_esito tb_select (ref st_tab_clie_classi kst_tab_clie_classi);//
//--- restituisce riga letta da tab Classi di Valenza
//--- ritorna: oltre alla struttura della tab Classi
//---          st_esito standard
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if len(trim(kst_tab_clie_classi.id_clie_classe)) > 0 then

            select
                  DESCR
              into 
                   :kst_tab_clie_classi.descr
              from clie_classi
              where
                    clie_classi.id_clie_classe     = :kst_tab_clie_classi.id_clie_classe
				using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.SQLErrText = "Tab.Tipi Settori: " + trim(sqlca.SQLErrText)
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = kkg_esito.db_ko
			else
				kst_esito.esito = kkg_esito.db_wrn
			end if
		end if
	else
		if_isnull_tb(kst_tab_clie_classi)
	end if
end if

return kst_esito

end function

public function st_esito tb_select (ref st_tab_province k_st_tab_province);//
//--- restituisce riga letta da tab PROVINCE
//--- ritorna: oltre alla struttura della tab province
//---          st_esito standard
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if LenA(trim(k_st_tab_province.sigla)) > 0 then
	select sigla, prov, regione
	   into :k_st_tab_province.sigla,
		     :k_st_tab_province.prov,
			  :k_st_tab_province.regione
	   from province
		where sigla = trim(:k_st_tab_province.sigla)
				using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.SQLErrText = "Tab.province: " + trim(sqlca.SQLErrText)
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = kkg_esito.db_ko
			else
				kst_esito.esito = kkg_esito.db_wrn
			end if
		end if
	end if
end if

return kst_esito

end function

public function st_esito tb_delete (st_tab_province kst_tab_province);//
//====================================================================
//=== Cancella il rek dalla tabella PROVINCE
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	delete from province
		where sigla = :kst_tab_province.sigla
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab. Province:" + trim(sqlca.SQLErrText)
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
		kst_esito.esito = kkg_esito.ok
	end if
	
	if kst_esito.esito = kkg_esito.db_ko  then
		if kst_tab_province.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_province.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		
		if kst_tab_province.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_province.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if


return kst_esito

end function

public function boolean if_gia_esiste (ref st_tab_cap k_st_tab_cap) throws uo_exception;//
//--- Controlla se riga già esiste per evitare Duplicati
//--- ritorna: TRUE=già esiste su DB; FALSE=non esiste
//---
//--- lancia exception standard
//---
//
boolean k_return=false
int k_contati=0
st_esito kst_esito
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if LenA(trim(k_st_tab_cap.cap)) > 0 then
	select count(*) 
	   into :k_contati
	   from cap
		where cap = trim(:k_st_tab_cap.cap)
		using sqlca;

	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode = 0 and k_contati = 0 then
			k_return=FALSE
		else
			k_return=TRUE // Esiste un record!!!!
		end if
	else
		kst_esito.SQLErrText = "Tab.CAP: " + trim(sqlca.SQLErrText)
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.esito = kkg_esito.db_ko
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
	end if
end if

return k_return

end function

public function boolean if_gia_esiste (ref st_tab_nazioni k_st_tab_nazioni) throws uo_exception;//
//--- Controlla se riga già esiste per evitare Duplicati
//--- ritorna: TRUE=già esiste su DB; FALSE=non esiste
//---
//--- lancia exception standard
//---
//
boolean k_return=false
int k_contati=0
st_esito kst_esito
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if LenA(trim(k_st_tab_nazioni.id_nazione)) > 0 then
	select count(*) 
	   into :k_contati
	   from nazioni
		where id_nazione = trim(:k_st_tab_nazioni.id_nazione)
		using sqlca;

	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode = 0 and k_contati = 0 then
			k_return=FALSE
		else
			k_return=TRUE // Esiste un record!!!!
		end if
	else
		kst_esito.SQLErrText = "Tab.id_nazione: " + trim(sqlca.SQLErrText)
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.esito = kkg_esito.db_ko
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
	end if
end if

return k_return

end function

public function st_esito tb_dosimetrie_attivadisattiva (ref st_tab_dosimetrie kst_tab_dosimetrie);//
//====================================================================
//=== Cambia lo stato di tutto il Lotto Dosimetrico (attivo/disattivo)
//=== 
//=== input: valorizzare kst_tab_dosimetrie.attivo e lotto_dosim
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


	kst_tab_dosimetrie.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_dosimetrie.x_utente = kGuf_data_base.prendi_x_utente()


	  update dosimetrie  
	  	set attivo = :kst_tab_dosimetrie.attivo
		  ,x_datins = :kst_tab_dosimetrie.x_datins
		  ,x_utente = :kst_tab_dosimetrie.x_utente
		where   lotto_dosim = :kst_tab_dosimetrie.lotto_dosim 
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Cambio stato alle Dosimetrie:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		else
			kst_esito.esito = kkg_esito.db_ko
		end if

	else
		kst_esito.esito = kkg_esito.ok

		if	kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then

			kGuf_data_base.db_commit()
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Cambio stato alle Dosimetrie ('commit'):" + trim(sqlca.SQLErrText)
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		
		end if

	end if

	if kst_esito.esito = kkg_esito.db_ko  then
		if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		
		if kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if



return kst_esito

end function

public function st_esito tb_dosimetrie_get_attivo (ref st_tab_dosimetrie kst_tab_dosimetrie);//
//====================================================================
//=== Torna lo stato del Lotto Dosimetrico (attivo/disattivo)
//=== 
//=== input: valorizzare e kst_tab_dosimetrie.lotto_dosim
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


	select max(attivo) 
			  	into :kst_tab_dosimetrie.attivo
			  	from dosimetrie  
				where  lotto_dosim = :kst_tab_dosimetrie.lotto_dosim 
				using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura stato Dosimetrie:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode > 0 then
			kst_esito.esito = kkg_esito.db_wrn
		else
			kst_esito.esito = kkg_esito.db_ko
		end if

	else
		kst_esito.esito = kkg_esito.ok

		if	kst_tab_dosimetrie.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimetrie.st_tab_g_0.esegui_commit) then

			kGuf_data_base.db_commit()
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Lettura stato Dosimetrie ('commit'):" + trim(sqlca.SQLErrText)
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		
		end if

	end if


return kst_esito

end function

public subroutine if_isnull_tb (ref st_tab_pagam kst_tab_pagam);//---
//--- toglie i NULL ai campi della tabella 
//---
if isnull(kst_tab_pagam.codice) then	kst_tab_pagam.codice = 0
if isnull(kst_tab_pagam.des) then	kst_tab_pagam.des = " "
if isnull(kst_tab_pagam.scad) then	kst_tab_pagam.scad = " "
if isnull(kst_tab_pagam.tipo) then	kst_tab_pagam.tipo = " "
if isnull(kst_tab_pagam.rate) then	kst_tab_pagam.rate = 0
if isnull(kst_tab_pagam.gg_1_rata) then	kst_tab_pagam.gg_1_rata = 0
if isnull(kst_tab_pagam.gg_int) then	kst_tab_pagam.gg_int = 0
   
end subroutine

public subroutine if_isnull_tb (ref st_tab_clie_classi kst_tab_clie_classi);//---
//--- toglie i NULL ai campi della tabella 
//---
if isnull(kst_tab_clie_classi.id_clie_classe) then	kst_tab_clie_classi.id_clie_classe = ""
if isnull(kst_tab_clie_classi.descr) then	kst_tab_clie_classi.descr = " "
if isnull(kst_tab_clie_classi.punteggio) then	kst_tab_clie_classi.punteggio = " "
   
end subroutine

public subroutine if_isnull_tb (ref st_tab_gru kst_tab_gru);//---
//--- toglie i NULL ai campi della tabella 
//---
if isnull(kst_tab_gru.codice) then	kst_tab_gru.codice = 0
if isnull(kst_tab_gru.des) then	kst_tab_gru.des = " "
if isnull(kst_tab_gru.des_eng) then	kst_tab_gru.des_eng = " "
if isnull(kst_tab_gru.conto) then kst_tab_gru.conto = 0
if isnull(kst_tab_gru.s_conto) then kst_tab_gru.s_conto = 0
if isnull(kst_tab_gru.conto_m_1) then kst_tab_gru.conto_m_1 = 0
if isnull(kst_tab_gru.s_conto_m_1) then kst_tab_gru.s_conto_m_1 = 0
if isnull(kst_tab_gru.conto_m_2) then kst_tab_gru.conto_m_2 = 0
if isnull(kst_tab_gru.s_conto_m_2) then kst_tab_gru.s_conto_m_2 = 0
if isnull(kst_tab_gru.escludi_da_stat_glob) then kst_tab_gru.escludi_da_stat_glob = "N"
   
end subroutine

public subroutine if_isnull_tb (ref st_tab_clie_settori kst_tab_clie_settori);//---
//--- toglie i NULL ai campi della tabella 
//---
if isnull(kst_tab_clie_settori.id_clie_settore) then	kst_tab_clie_settori.id_clie_settore = ""
if isnull(kst_tab_clie_settori.descr) then	kst_tab_clie_settori.descr = " "
if isnull(kst_tab_clie_settori.descr_eng) then	kst_tab_clie_settori.descr_eng = " "
   
end subroutine

public subroutine if_isnull_tb (ref st_tab_nazioni kst_tab_nazioni);//---
//--- toglie i NULL ai campi della tabella 
//---
if isnull(kst_tab_nazioni.id_nazione) then	kst_tab_nazioni.id_nazione = " "
if isnull(kst_tab_nazioni.nome) then	kst_tab_nazioni.nome = " "
if isnull(kst_tab_nazioni.area) then	kst_tab_nazioni.area = " "
if isnull(kst_tab_nazioni.gruppo) then	kst_tab_nazioni.gruppo = " "
   
end subroutine

public subroutine if_isnull_tb (ref st_tab_province kst_tab_province);//---
//--- toglie i NULL ai campi della tabella 
//---
if isnull(kst_tab_province.sigla) then	kst_tab_province.sigla = " "
if isnull(kst_tab_province.prov) then	kst_tab_province.prov = " "
if isnull(kst_tab_province.regione) then	kst_tab_province.regione = " "
   
end subroutine

public function st_esito tb_gru_get_id_clie_settore (ref st_tab_gru kst_tab_gru);//
//--- Leggo id_clie_settore dal Gruppo specifico
//
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	
	select id_clie_settore 
	 into 
			:kst_tab_gru.id_clie_settore
		from gru
		where codice = :kst_tab_gru.codice 
		using sqlca;
	
	if sqlca.sqlcode <> 0 then

		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Lettura tab. Gruppi (Settore) codice " + string(kst_tab_gru.codice) + " ~n~rErrore: " + trim(sqlca.SQLErrText)
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

public function st_esito tb_delete (st_tab_listino_voci_categ ast_tab_listino_voci_categ);//
//-------------------------------------------------------------------------------------------------------------------------
//--- Cancella il rek dalla tabella CATEGORIA VOCI LISTINO 
//--- 
//--- 
//--- Ritorna tab. st_esito
//---
//-------------------------------------------------------------------------------------------------------------------------
//
st_tab_listino_voci kst_tab_listino_voci
st_esito kst_esito
kuf_listino_voci kuf1_listino_voci


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_listino_voci = create kuf_listino_voci
		
	kst_tab_listino_voci.id_listino_voci_categ = ast_tab_listino_voci_categ.id_listino_voci_categ 
	if kuf1_listino_voci.if_presente_id_listino_voci_categ(kst_tab_listino_voci) then
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Categoria già associato almeno ad una Voce Listino. Rimozione non consentita. "
		kst_esito.esito = kkg_esito.err_logico
			
	else
		
		delete from listino_voci_categ
			where id_listino_voci_categ = :ast_tab_listino_voci_categ.id_listino_voci_categ 
			using sqlca;
		
		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab. Categoria Voce Listino:" + trim(sqlca.SQLErrText)
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
		
		if kst_esito.esito = kkg_esito.db_ko  then
			if ast_tab_listino_voci_categ.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_voci_categ.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if

		else
			
			if ast_tab_listino_voci_categ.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_listino_voci_categ.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if
	end if

catch (uo_exception kuo_exception)
	
	kst_esito = kuo_exception.get_st_esito()

finally

end try

	
return kst_esito 


end function

public function st_esito tb_select (ref st_tab_caus ast_tab_caus);//
//--- restituisce riga letta da tab CAUS
//--- ritorna: oltre alla struttura della tab CAUS
//---          st_esito standard
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


select codice
        ,ddt_st_num_data_in
	   into :ast_tab_caus.des
		     ,:ast_tab_caus.ddt_st_num_data_in
	   from caus
		where codice = :ast_tab_caus.codice
		using  kguo_sqlca_db_magazzino;

if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	kst_esito.SQLErrText = "Errore durante lettura tab. Causale di Spedizione " + string(ast_tab_caus.codice) + ": " + trim(kguo_sqlca_db_magazzino.SQLErrText)
	kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
	if kguo_sqlca_db_magazzino.sqlcode = 100 then
		kst_esito.esito = kkg_esito.not_fnd
	else
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_esito.esito = kkg_esito.db_ko
		else
			kst_esito.esito = kkg_esito.db_wrn
		end if
	end if
end if

return kst_esito

end function

public function st_esito tb_select (ref st_tab_meca_causali ast_tab_meca_causali);//
//--- restituisce riga letta da tab CAUSALI DI ENTRATA MERCE
//--- ritorna: oltre alla struttura della tab st_tab_meca_causali
//---          st_esito standard
//
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if ast_tab_meca_causali.id_meca_causale > 0 then

            select
                  cod_blk
                  ,descrizione
                ,MECA_CAUSALI.CLIE_1
                ,MECA_CAUSALI.ART
					,rich_autorizz
					,flag_ddt_si
              into 
                   :ast_tab_meca_causali.cod_blk
                   ,:ast_tab_meca_causali.descrizione
                   ,:ast_tab_meca_causali.CLIE_1
                   ,:ast_tab_meca_causali.ART
                   ,:ast_tab_meca_causali.rich_autorizz
                   ,:ast_tab_meca_causali.flag_ddt_si
              from meca_causali
              where
                    meca_causali.id_meca_causale     = :ast_tab_meca_causali.id_meca_causale
				using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.SQLErrText = "Tab.Causali di Entrata Merce: " + trim(sqlca.SQLErrText)
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = kkg_esito.db_ko
			else
				kst_esito.esito = kkg_esito.db_wrn
			end if
		end if
	else
		if_isnull_tb(ast_tab_meca_causali)
	end if
end if

return kst_esito

end function

public subroutine if_isnull_tb (ref st_tab_meca_causali ast_tab_meca_causali);//---
//--- toglie i NULL ai campi della tabella 
//---
if isnull(ast_tab_meca_causali.cod_blk) then ast_tab_meca_causali.cod_blk = 0
if isnull(ast_tab_meca_causali.descrizione) then ast_tab_meca_causali.descrizione = ""
if isnull(ast_tab_meca_causali.rich_autorizz) then ast_tab_meca_causali.rich_autorizz = ""
if isnull(ast_tab_meca_causali.flag_ddt_si) then ast_tab_meca_causali.flag_ddt_si = ""
   
end subroutine

public function st_esito tb_delete (st_tab_sr_settori ast_tab_sr_settori);//
//====================================================================
//=== Cancella il rek dalla tabella SETTORI DIPARTIMENTALI
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_tab_sr_settori_profili kst_tab_sr_settori_profili
st_esito kst_esito
kuf_sr_sicurezza kuf1_sr_sicurezza


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kuf1_sr_sicurezza = create kuf_sr_sicurezza
	
	try
		
		kst_tab_sr_settori_profili.sr_settore = ast_tab_sr_settori.sr_settore 
		if kuf1_sr_sicurezza.if_presente_sr_settore(kst_tab_sr_settori_profili) > 0 then
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Settore non elminato perchè associato ai Profili in Sicurezza "
			kst_esito.esito = kkg_esito.err_logico
			
		else
			
			delete from sr_settori
				where sr_settore = :ast_tab_sr_settori.sr_settore 
				using sqlca;
		
		
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab. Settori Dipartimentali:" + trim(sqlca.SQLErrText)
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
				if kst_esito.esito = kkg_esito.db_ko  then
					if ast_tab_sr_settori.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sr_settori.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_rollback_1( )
					end if
				else
					
					if ast_tab_sr_settori.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sr_settori.st_tab_g_0.esegui_commit) then
						kGuf_data_base.db_commit_1( )
					end if
				end if
			end if
		end if	

	catch (uo_exception kuo_exception)
		
		kst_esito = kuo_exception.get_st_esito( )

	finally
		destroy kuf1_sr_sicurezza

	end try

	
return kst_esito


end function

public function string tb_get_descr (st_tab_sr_settori ast_tab_sr_settori) throws uo_exception;//====================================================================
//=== Legge tabella sr_settori x get della descrizione
//=== 
//=== Inp: st_tab_sr_settori.se_settore
//=== Out: st_tab_sr_settori.descr
//=== Lancia Exception 
//=== 
//====================================================================
string k_sr_settore_up, k_sr_settore_lo, k_return
kuf_base kuf1_base
st_esito kst_esito


	kst_esito.esito =kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT 
	      sr_settori.descr
    INTO 
	      :ast_tab_sr_settori.descr
    FROM sr_settori  
	 where sr_settore = :ast_tab_sr_settori.sr_settore
	 using sqlca;

	if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			ast_tab_sr_settori.descr = ""
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Ricerca descrizione Settore " + trim(ast_tab_sr_settori.sr_settore) + " in Tab. Settori " + " ~n~r:" + trim(sqlca.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	
	if isnull(ast_tab_sr_settori.descr) then ast_tab_sr_settori.descr = ""

return ast_tab_sr_settori.descr

end function

public subroutine if_isnull_tb (ref st_tab_imptime kst_tab_imptime);//---
//--- toglie i NULL ai campi della tabella 
//---
if isnull(kst_tab_imptime.id_imptime) then kst_tab_imptime.id_imptime = 0
if isnull(kst_tab_imptime.attivo) then kst_tab_imptime.attivo = "N"
if isnull(kst_tab_imptime.impianto) then kst_tab_imptime.impianto = "2"
if isnull(kst_tab_imptime.tminute) then kst_tab_imptime.tminute = 0
if isnull(kst_tab_imptime.tsecond) then kst_tab_imptime.tsecond = 0
if isnull(kst_tab_imptime.fila_1_tcoeff) then kst_tab_imptime.fila_1_tcoeff = 0
if isnull(kst_tab_imptime.fila_2_tcoeff) then kst_tab_imptime.fila_2_tcoeff = 0
if isnull(kst_tab_imptime.data_ini) then kst_tab_imptime.data_ini = kkg.data_no
if isnull(kst_tab_imptime.data_fin) then kst_tab_imptime.data_fin = kkg.data_no

end subroutine

public function st_esito tb_delete (st_tab_imptime kst_tab_imptime);//
//====================================================================
//=== Cancella il rek dalla tabella IMPTIME (tempi impianto)
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_imptime.id_imptime > 0 then

		delete from imptime
			where id_imptime = :kst_tab_imptime.id_imptime
			using kguo_sqlca_db_magazzino;

	end if

	if kst_tab_imptime.id_imptime > 0 then
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Tab.Tempi Impianto:" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
		
		if kst_esito.esito = kkg_esito.db_ko  then
			if kst_tab_imptime.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_imptime.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		else
			
			if kst_tab_imptime.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_imptime.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
	end if
	
return kst_esito

end function

public function boolean tb_imptime_get (ref st_tab_imptime kst_tab_imptime) throws uo_exception;//
//---------------------------------------------------------------------
//--- Torna lo il record IMPTIME attivo in questo momento
//--- 
//--- input: data_ini=data di riferimento x l'estrazione
//---        (se non indicata allora piglia la data del giorno)
//---        impianto (se non indicato è il '2')
//--- Out: record st_tab_imptime valido per la data richiesta
//--- Rit: TRUE = record trovato
//--- Lancia Exception per Errori DB
//---------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito

try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_imptime.data_ini > kkg.data_zero then
		kst_tab_imptime.data_ini = kguo_g.get_dataoggi( )
	end if
	if trim(kst_tab_imptime.impianto) > " " then
	else
		kst_tab_imptime.impianto = "2" 
	end if
//--- piglia il record valido nella data indicata (vedi FIRST 1)
	kst_tab_imptime.attivo = "S"
	select TOP 1 id_imptime 
			  	into :kst_tab_imptime.id_imptime
			  	from imptime   
				where imptime.attivo = :kst_tab_imptime.attivo
				      and imptime.impianto = :kst_tab_imptime.impianto
				      and imptime.data_ini <= :kst_tab_imptime.data_ini 
     		         order by imptime.data_ini desc
				using kguo_sqlca_db_magazzino;
				      //and :kst_tab_imptime.data_ini between imptime.data_ini and imptime.data_fin

	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_imptime.id_imptime > 0 then
			if tb_select(kst_tab_imptime) then  // LEGGE I DATI IMPTIME!!
				if kst_tab_imptime.attivo = "S" then
					k_return = true
				end if
			end if
		else
			if_isnull_tb(kst_tab_imptime)
		end if
	end if
		
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.SQLErrText = "Errore in ricerca record valido in tab. Tempi Impianto.~n~r" + trim(kst_esito.SQLErrText)
	kguo_exception.set_esito(kst_esito)
	throw kuo_exception

finally
		
end try

return k_return

end function

public function boolean tb_select (ref st_tab_imptime kst_tab_imptime) throws uo_exception;//
//--- restituisce riga letta da tab TEMPI IMPIANTO
//--- out: la struttura della tab Imptime
//--- rit: true=dati trovati
//
boolean k_return = false
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_imptime.id_imptime > 0 then
	
		select
					 attivo
					, impianto 
					, tminute 
					, tsecond 
					, fila_1_tcoeff 
					, fila_2_tcoeff 
					, data_ini 
					, data_fin
					, x_datins
					, x_utente
				  into 
					 :kst_tab_imptime.attivo
					, :kst_tab_imptime.impianto 
					, :kst_tab_imptime.tminute 
					, :kst_tab_imptime.tsecond 
					, :kst_tab_imptime.fila_1_tcoeff 
					, :kst_tab_imptime.fila_2_tcoeff 
					, :kst_tab_imptime.data_ini 
					, :kst_tab_imptime.data_fin
					, :kst_tab_imptime.x_datins
					, :kst_tab_imptime.x_utente
              from imptime
              where
                    imptime.id_imptime = :kst_tab_imptime.id_imptime
				using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.SQLErrText = "Errore in lettura tab. Tempi Impianto (id=" + string(kst_tab_imptime.id_imptime)+ "): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		if kst_tab_imptime.tminute > 0 then
			k_return = true
		end if
	else
		kst_esito.SQLErrText = "Operazione non eseguita di lettura tab. Tempi Impianto, nessun ID passato per la ricerca"
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

return k_return

end function

public subroutine if_isnull_tb (ref st_tab_dosimpos kst_tab_dosimpos);//---
//--- toglie i NULL ai campi della tabella 
//---
if isnull(kst_tab_dosimpos.codice) then kst_tab_dosimpos.codice = ""
if isnull(kst_tab_dosimpos.descr) then kst_tab_dosimpos.descr = ""
if isnull(kst_tab_dosimpos.descr1) then kst_tab_dosimpos.descr1 = ""
if isnull(kst_tab_dosimpos.posxcm) then kst_tab_dosimpos.posxcm = 0
if isnull(kst_tab_dosimpos.posycm) then kst_tab_dosimpos.posycm = 0
if isnull(kst_tab_dosimpos.poszcm) then kst_tab_dosimpos.poszcm = 0

end subroutine

public function st_esito tb_delete (st_tab_dosimpos kst_tab_dosimpos);//
//====================================================================
//=== Cancella il rek dalla tabella DOSIMPOS (posizione dosimetro sul barcode)
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_dosimpos.id_dosimpos > 0 then

		delete from dosimpos
			where id_dosimpos = :kst_tab_dosimpos.id_dosimpos
			using kguo_sqlca_db_magazzino;

	end if

	if kst_tab_dosimpos.id_dosimpos > 0 then
	
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in cancellazione Tab. Posizioni dosimetri id: " + string(kst_tab_dosimpos.id_dosimpos) + " " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
		
		if kst_esito.esito = kkg_esito.db_ko  then
			if kst_tab_dosimpos.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimpos.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		else
			
			if kst_tab_dosimpos.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_dosimpos.st_tab_g_0.esegui_commit) then
				kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
	end if
	
return kst_esito


end function

public function boolean tb_select (ref st_tab_dosimpos kst_tab_dosimpos) throws uo_exception;//
//--- restituisce riga letta da tab DOSIMPOS (Posizione dosimetro sul pallet)
//--- out: la struttura della tab dosimpos
//--- rit: true=dati trovati
//
boolean k_return = false
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_dosimpos.codice > " " then
	
		select
					 descr
					, descr1 
					, posxcm 
					, posycm 
					, poszcm 
					, x_datins 
					, x_utente
			into
					 :kst_tab_dosimpos.descr 
					, :kst_tab_dosimpos.descr1
					, :kst_tab_dosimpos.posxcm 
					, :kst_tab_dosimpos.posycm 
					, :kst_tab_dosimpos.poszcm 
					, :kst_tab_dosimpos.x_datins 
					, :kst_tab_dosimpos.x_utente
              from dosimpos
              where
                    dosimpos.codice = :kst_tab_dosimpos.codice
				using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.SQLErrText = "Errore in lettura tab. Posizione Dosimetro sul pallet (" + string(kst_tab_dosimpos.codice)+ "): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		if kst_tab_dosimpos.codice > " " then
			k_return = true
		end if
	else
		kst_esito.SQLErrText = "Operazione non eseguita di lettura tab. Posizione Dosimetro sul pallet, nessun codice passato per la ricerca"
		kst_esito.esito = kkg_esito.no_esecuzione
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

return k_return

end function

on kuf_ausiliari.create
call super::create
end on

on kuf_ausiliari.destroy
call super::destroy
end on

