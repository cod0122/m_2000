$PBExportHeader$w_import_cvs_crm_anag.srw
forward
global type w_import_cvs_crm_anag from w_g_tab
end type
type dw_1 from uo_d_std_1 within w_import_cvs_crm_anag
end type
type cb_4 from commandbutton within w_import_cvs_crm_anag
end type
type cb_3 from commandbutton within w_import_cvs_crm_anag
end type
type cb_2 from commandbutton within w_import_cvs_crm_anag
end type
type cb_1 from commandbutton within w_import_cvs_crm_anag
end type
end forward

global type w_import_cvs_crm_anag from w_g_tab
integer width = 2834
integer height = 1700
string title = "Dati Anagrafiche CRM da file CSV"
boolean ki_personalizza_pos_controlli = true
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_import_cvs_crm_anag w_import_cvs_crm_anag

forward prototypes
private subroutine aggiorna_db ()
private function st_esito importa_csv ()
private function st_esito importa_csv_rid ()
private subroutine aggiorna_db_rid ()
end prototypes

private subroutine aggiorna_db ();//---
//--- Popola archivi da DW 
//---
int k_riga, k_ctr
string k_tel_r, k_tel
st_tab_clienti kst_tab_clienti, kst_tab_contatto1, kst_tab_contatto2, kst_tab_contatto3,kst_tab_contatto4, kst_tab_clienti_r 
st_tab_clienti_mkt kst_tab_clienti_mkt, kst_tab_contatto1_mkt, kst_tab_contatto2_mkt, kst_tab_contatto3_mkt, kst_tab_contatto4_mkt, kst_tab_clienti_mkt_r
st_tab_clienti_web kst_tab_clienti_web, kst_tab_clienti_web_r
st_tab_clie_settori kst_tab_clie_settori
st_tab_clie_classi kst_tab_clie_classi
kuf_clienti kuf1_clienti
kuf_utility kuf1_utility
pointer kp



try 
	
	kp = setpointer(hourglass!)
	
	kst_tab_clienti.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_clienti.x_utente = kGuf_data_base.prendi_x_utente()
	kst_tab_clienti_web.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_clienti_web.x_utente = kGuf_data_base.prendi_x_utente()
	kst_tab_clienti_mkt.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_clienti_mkt.x_utente = kGuf_data_base.prendi_x_utente()
	
	kuf1_utility = create kuf_utility
	
	for k_riga = 1 to dw_1.rowcount()
	
		kst_tab_clienti.codice = dw_1.getitemnumber( k_riga, "id_cliente")
	
		
	//--- dati MKT cliente 	
		if len(trim(dw_1.getitemstring( k_riga, "cod_atecori"))) > 0 then 
			kst_tab_clienti_mkt.cod_atecori = trim(dw_1.getitemstring( k_riga, "cod_atecori"))
		else
			kst_tab_clienti_mkt.cod_atecori = ""
		end if
		
		if len(trim(dw_1.getitemstring( k_riga, "altra_sede"))) > 0 then 
			kst_tab_clienti_mkt.altra_sede = trim(dw_1.getitemstring( k_riga, "altra_sede"))
		else
			kst_tab_clienti_mkt.altra_sede = ""
		end if
		
		kst_tab_clienti_mkt.tipo_rapporto = trim(dw_1.getitemstring( k_riga, "tipo_rapporto"))
		if len(trim(dw_1.getitemstring( k_riga, "note_prodotto"))) > 0 then 
			kst_tab_clienti_mkt.note_prodotti = trim(dw_1.getitemstring( k_riga, "note_prodotto"))
		end if
		if len(trim(dw_1.getitemstring( k_riga, "note_prodotto_est"))) > 0 then 
			if len(trim(kst_tab_clienti_mkt.note_prodotti)) > 0 then
				kst_tab_clienti_mkt.note_prodotti += ": " +  trim(dw_1.getitemstring( k_riga, "note_prodotto_est")) + "; " 
			else
				kst_tab_clienti_mkt.note_prodotti = trim(dw_1.getitemstring( k_riga, "note_prodotto_est"))
			end if
		end if
		if len(trim(dw_1.getitemstring( k_riga, "valore_prodotto"))	) > 0 then
			kst_tab_clienti_mkt.note_prodotti += "  (Valore=" + trim(dw_1.getitemstring( k_riga, "valore_prodotto")) + ")"
		end if
		if len(trim(kst_tab_clienti_mkt.note_prodotti)) > 0 then
			kst_tab_clienti_mkt.note_prodotti += "; "
		else
			kst_tab_clienti_mkt.note_prodotti = ""
		end if
	
		if len(trim(dw_1.getitemstring( k_riga, "aziende_collegate"))) > 0 then
			kst_tab_clienti.rag_soc_10 = upper(trim(dw_1.getitemstring( k_riga, "aziende_collegate")))
			
			select max(codice)
				into :kst_tab_clienti_mkt.id_cliente_link 
				from clienti
				where rag_soc_10 = :kst_tab_clienti.rag_soc_10
				using sqlca;
			if sqlca.sqlcode <> 0 then kst_tab_clienti_mkt.id_cliente_link  = 0
		else
			kst_tab_clienti_mkt.id_cliente_link = 0
		end if
		
	
	//--- divido le e-mail se ce ne sono + di una	
		kst_tab_clienti_web.email = trim(dw_1.getitemstring( k_riga, "e_mail"))
		kst_tab_clienti_web.email2 = ""
		kst_tab_clienti_web.email1 = ""
		k_ctr = pos(kst_tab_clienti_web.email,  " ", 1)
		if k_ctr > 0 and k_ctr < len(kst_tab_clienti_web.email) then
			kst_tab_clienti_web.email1 = mid(kst_tab_clienti_web.email, k_ctr+1)	
			kst_tab_clienti_web.email = left(kst_tab_clienti_web.email, k_ctr - 1)	
			k_ctr = pos(kst_tab_clienti_web.email1,  " ", 1)
			if k_ctr > 0 and k_ctr < len(kst_tab_clienti_web.email1) then
				kst_tab_clienti_web.email2 = mid(kst_tab_clienti_web.email1, k_ctr+1)	
				kst_tab_clienti_web.email1 = left(kst_tab_clienti_web.email1, k_ctr - 1)	
			end if
		end if
	
	//--- dati Contatti
		kst_tab_contatto1.rag_soc_10 = trim(dw_1.getitemstring( k_riga, "contatto_1"))
	//	kst_tab_contatto1_mkt.qualifica = trim(dw_1.getitemstring( k_riga, "contatto_1_qualifica"))
		kst_tab_clienti_mkt.contatto_1_qualif = trim(dw_1.getitemstring( k_riga, "contatto_1_qualifica"))
		kst_tab_contatto2.rag_soc_10 = trim(dw_1.getitemstring( k_riga, "contatto_2"))
		kst_tab_contatto3.rag_soc_10 = trim(dw_1.getitemstring( k_riga, "contatto_3"))
		kst_tab_contatto4.rag_soc_10 = trim(dw_1.getitemstring( k_riga, "contatto_4"))
		
	//--- tabelle Settori e Classi	
		kst_tab_clie_settori.descr = trim(dw_1.getitemstring( k_riga, "settore"))
		kst_tab_clie_classi.id_clie_classe = trim(dw_1.getitemstring( k_riga, "tipo_cliene"))
		if len(kst_tab_clie_classi.id_clie_classe) > 0 then
			kst_tab_clienti.id_clie_classe = kst_tab_clie_classi.id_clie_classe
			choose case kst_tab_clie_classi.id_clie_classe
				case "C1"
					kst_tab_clie_classi.descr = "Cliente storico importanza elevata"
				case "C2"
					kst_tab_clie_classi.descr = "Cliente storico importanza media"
				case "C3"
					kst_tab_clie_classi.descr = "Cliente storico non importante/saltuario"
				case "C4"
					kst_tab_clie_classi.descr = "Cliente nuovo buona potenzialità"
				case "C5"
					kst_tab_clie_classi.descr = "Cliente nuovo scarsa potenzialità"
				case else
					kst_tab_clie_classi.descr = " "
			end choose
		else
			kst_tab_clie_classi.id_clie_classe = ""
			kst_tab_clienti.id_clie_classe = ""
			kst_tab_clie_classi.descr = " "
		end if
		
	//--- dati base cliente 	
		kst_tab_clienti.fono = trim(dw_1.getitemstring( k_riga, "fono"))
		kst_tab_clienti.fax = trim(dw_1.getitemstring( k_riga, "fax"))
		choose case  trim(dw_1.getitemstring( k_riga, "stato_cliente"))
			case "A"
				kst_tab_clienti.stato = kuf1_clienti.kki_cliente_stato_attivo
			case "A/P"
				kst_tab_clienti.stato = kuf1_clienti.kki_cliente_stato_attivo_parziale
			case "P"
				kst_tab_clienti.stato = kuf1_clienti.kki_cliente_stato_potenziale_in_contatto
			case else
				kst_tab_clienti.stato = " "
		end choose
		if isnumber(trim(dw_1.getitemstring( k_riga, "stato_cliente"))) then
			kst_tab_clienti.data_attivazione = date(integer(trim(dw_1.getitemstring( k_riga, "stato_cliente"))), 01, 01)
		else
			setnull(kst_tab_clienti.data_attivazione)
		end if
		
	//--- UPDATE DB--------------------------------------------------------------------------------------
	//--- CONATTI:
		kst_tab_contatto1.codice = 0
		if  len(trim(kst_tab_contatto1.rag_soc_10)) > 0 then
			if len(trim(kst_tab_contatto1.rag_soc_10)) > 30 then
				kst_tab_contatto1.rag_soc_11 = mid(trim(kst_tab_contatto1.rag_soc_10),31)
				kst_tab_contatto1.rag_soc_10 = mid(trim(kst_tab_contatto1.rag_soc_10),1, 30)
			end if
	
			kst_tab_contatto1.rag_soc_10 = upper(kst_tab_contatto1.rag_soc_10)
			kst_tab_contatto1.rag_soc_11 = upper(kst_tab_contatto1.rag_soc_11)
			
			select 
				codice 
				into
				:kst_tab_contatto1.codice
			from clienti
			where  rag_soc_10 = :kst_tab_contatto1.rag_soc_10
			using sqlca;
			if sqlca.sqlcode <> 0 then 
	
				kst_tab_contatto1.tipo = kuf1_clienti.kki_tipo_contatto			
				kst_tab_contatto1.stato = kuf1_clienti.kki_cliente_stato_attivo
				//codice
				insert into clienti 
					(
					tipo
					,stato
					,rag_soc_10
					,rag_soc_11
					,data_attivazione
					,indi_1
					,cap_1
					,loc_1
					,prov_1
					,id_nazione_1
					,cf
					,p_iva
					,x_utente
					,x_datins
					)
					values (
					:kst_tab_contatto1.tipo
					,:kst_tab_contatto1.stato 
					,:kst_tab_contatto1.rag_soc_10
					,:kst_tab_contatto1.rag_soc_11
					,:kg_dataoggi
					,""
					,""
					,""
					,""
					,""
					,""
					,""
					,:kst_tab_clienti.x_utente
					,:kst_tab_clienti.x_datins
					)
				using sqlca;
				if sqlca.sqlcode = 0 then
					kst_tab_contatto1.codice = kuf1_clienti.get_codice_max()
					//kst_tab_contatto1.codice = long(sqlca.SQLReturnData) // Finalmente il codice !!!!
				end if
			end if
		end if
	
		kst_tab_contatto2.codice = 0
		kst_tab_contatto2_mkt.qualifica = ""
		if  len(trim(kst_tab_contatto2.rag_soc_10)) > 0 then
			if len(trim(kst_tab_contatto2.rag_soc_10)) > 30 then
				kst_tab_contatto2.rag_soc_11 = mid(trim(kst_tab_contatto2.rag_soc_10),31)
				kst_tab_contatto2.rag_soc_10 = mid(trim(kst_tab_contatto2.rag_soc_10),1, 30)
			end if
			select 
				codice 
				,qualifica
				into
				:kst_tab_contatto2.codice
				,:kst_tab_contatto2_mkt.qualifica
			from clienti left outer join clienti_mkt on
					  clienti.codice = clienti_mkt.id_cliente
			using sqlca;
			if sqlca.sqlcode <> 0 then 
	
				kst_tab_contatto2.tipo = kuf1_clienti.kki_tipo_contatto			
				kst_tab_contatto2.stato = kuf1_clienti.kki_cliente_stato_attivo
				kst_tab_contatto2.rag_soc_10 = upper(kst_tab_contatto2.rag_soc_10)
				kst_tab_contatto2.rag_soc_11 = upper(kst_tab_contatto2.rag_soc_11)
				//codice
				insert into clienti 
					(
					tipo
					,stato
					,rag_soc_10
					,rag_soc_11
					,data_attivazione
					,indi_1
					,cap_1
					,loc_1
					,prov_1
					,id_nazione_1
					,cf
					,p_iva
					,x_utente
					,x_datins
					)
					values (
					:kst_tab_contatto2.tipo
					,:kst_tab_contatto2.stato 
					,:kst_tab_contatto2.rag_soc_10
					,:kst_tab_contatto2.rag_soc_11
					,:kg_dataoggi
					,""
					,""
					,""
					,""
					,""
					,""
					,""
					,:kst_tab_clienti.x_utente
					,:kst_tab_clienti.x_datins
					)
				using sqlca;
				if sqlca.sqlcode = 0 then
					kst_tab_contatto2.codice = kuf1_clienti.get_codice_max()
					//kst_tab_contatto2.codice = long(sqlca.SQLReturnData) // Finalmente il codice !!!!
				end if
			end if
		end if
	
		kst_tab_contatto3.codice = 0
		kst_tab_contatto3_mkt.qualifica = ""
		if  len(trim(kst_tab_contatto3.rag_soc_10)) > 0 then
			if len(trim(kst_tab_contatto3.rag_soc_10)) > 30 then
				kst_tab_contatto3.rag_soc_11 = mid(trim(kst_tab_contatto3.rag_soc_10),31)
				kst_tab_contatto3.rag_soc_10 = mid(trim(kst_tab_contatto3.rag_soc_10),1, 30)
			end if
			select 
				codice 
				,qualifica
				into
				:kst_tab_contatto3.codice
				,:kst_tab_contatto3_mkt.qualifica
			from clienti left outer join clienti_mkt on
					  clienti.codice = clienti_mkt.id_cliente
			where  rag_soc_10 = :kst_tab_contatto3.rag_soc_10
			using sqlca;
			if sqlca.sqlcode <> 0 then 
	
				kst_tab_contatto3.tipo = kuf1_clienti.kki_tipo_contatto			
				kst_tab_contatto3.stato = kuf1_clienti.kki_cliente_stato_attivo
				kst_tab_contatto3.rag_soc_10 = upper(kst_tab_contatto3.rag_soc_10)
				kst_tab_contatto3.rag_soc_11 = upper(kst_tab_contatto3.rag_soc_11)
				//codice
				insert into clienti 
					(
					tipo
					,stato
					,rag_soc_10
					,rag_soc_11
					,data_attivazione
					,indi_1
					,cap_1
					,loc_1
					,prov_1
					,id_nazione_1
					,cf
					,p_iva
					,x_utente
					,x_datins
					)
					values (
					:kst_tab_contatto3.tipo
					,:kst_tab_contatto3.stato 
					,:kst_tab_contatto3.rag_soc_10
					,:kst_tab_contatto3.rag_soc_11
					,:kg_dataoggi
					,""
					,""
					,""
					,""
					,""
					,""
					,""
					,:kst_tab_clienti.x_utente
					,:kst_tab_clienti.x_datins
					)
				using sqlca;
				if sqlca.sqlcode = 0 then
					kst_tab_contatto3.codice = kuf1_clienti.get_codice_max()
					//kst_tab_contatto3.codice = long(sqlca.SQLReturnData) // Finalmente il codice !!!!
				end if
			end if
		end if
	
	
		kst_tab_contatto4.codice = 0
		kst_tab_contatto4_mkt.qualifica = ""
		if  len(trim(kst_tab_contatto4.rag_soc_10)) > 0 then
			if len(trim(kst_tab_contatto4.rag_soc_10)) > 30 then
				kst_tab_contatto4.rag_soc_11 = mid(trim(kst_tab_contatto4.rag_soc_10),31)
				kst_tab_contatto4.rag_soc_10 = mid(trim(kst_tab_contatto4.rag_soc_10),1, 30)
			end if
			select 
				codice 
				,qualifica
				into
				:kst_tab_contatto4.codice
				,:kst_tab_contatto4_mkt.qualifica
			from clienti left outer join clienti_mkt on
					  clienti.codice = clienti_mkt.id_cliente
			where  rag_soc_10 = :kst_tab_contatto4.rag_soc_10
			using sqlca;
			if sqlca.sqlcode <> 0 then 
	
				kst_tab_contatto4.tipo = kuf1_clienti.kki_tipo_contatto			
				kst_tab_contatto4.stato = kuf1_clienti.kki_cliente_stato_attivo
				kst_tab_contatto4.rag_soc_10 = upper(kst_tab_contatto4.rag_soc_10)
				kst_tab_contatto4.rag_soc_11 = upper(kst_tab_contatto4.rag_soc_11)
				//codice
				insert into clienti 
					(
					tipo
					,stato
					,rag_soc_10
					,rag_soc_11
					,data_attivazione
					,indi_1
					,cap_1
					,loc_1
					,prov_1
					,id_nazione_1
					,cf
					,p_iva
					,x_utente
					,x_datins
					)
					values (
					:kst_tab_contatto4.tipo
					,:kst_tab_contatto4.stato 
					,:kst_tab_contatto4.rag_soc_10
					,:kst_tab_contatto4.rag_soc_11
					,:kg_dataoggi
					,""
					,""
					,""
					,""
					,""
					,""
					,""
					,:kst_tab_clienti.x_utente
					,:kst_tab_clienti.x_datins
					)
				using sqlca;
				if sqlca.sqlcode = 0 then
					kst_tab_contatto4.codice = kuf1_clienti.get_codice_max()
					//kst_tab_contatto4.codice = long(sqlca.SQLReturnData) // Finalmente il codice !!!!
				end if
			end if
		end if
	
	
	//--- tab SETTORI CLIENTI
		kst_tab_clie_settori.id_clie_settore=""
		if  len(trim(kst_tab_clie_settori.descr)) > 0 then
			select 
				id_clie_settore 
				into
				:kst_tab_clie_settori.id_clie_settore
			from clie_settori
			where  descr = :kst_tab_clie_settori.descr
			using sqlca;
			if sqlca.sqlcode = 0 then 
				kst_tab_clienti.id_clie_settore = kst_tab_clie_settori.id_clie_settore
			else
				kst_tab_clienti.id_clie_settore = ""
			end if
		end if
	
	//--- CLIENTI:
		select 
			fono 
			,fax
			,stato
			,data_attivazione
			,id_clie_classe
			,id_clie_settore
			into
			:kst_tab_clienti_r.fono 
			,:kst_tab_clienti_r.fax
			,:kst_tab_clienti_r.stato
			,:kst_tab_clienti_r.data_attivazione
			,:kst_tab_clienti_r.id_clie_classe
			,:kst_tab_clienti.id_clie_settore
		from clienti
		where codice = :kst_tab_clienti.codice 
		using sqlca;
		
		if sqlca.sqlcode = 0 then 
	
			if len(trim(kst_tab_clienti_r.fono)) > 0 and len(trim(kst_tab_clienti.fono)) > 0 then 
	//--- controllo se numero TELEFONO già caricato
				k_ctr = pos(trim(kst_tab_clienti_r.fono),  kst_tab_clienti.fono, 1)
				if k_ctr = 0 then
					k_tel_r = kuf1_utility.u_stringa_numeri(kst_tab_clienti_r.fono)
					k_tel = kuf1_utility.u_stringa_numeri(kst_tab_clienti.fono)
					if k_tel_r <> k_tel then 
						kst_tab_clienti.fono = trim(kst_tab_clienti_r.fono) + "  " + kst_tab_clienti.fono
					else
						kst_tab_clienti.fono = trim(kst_tab_clienti_r.fono)
					end if
				else
					kst_tab_clienti.fono = trim(kst_tab_clienti_r.fono)
				end if
			else
				if len(trim(kst_tab_clienti_r.fono)) > 0 then
					kst_tab_clienti.fono = trim(kst_tab_clienti_r.fono)
				end if
			end if
			
			if len(trim(kst_tab_clienti_r.fax)) > 0 and len(trim(kst_tab_clienti.fax)) > 0 then 
	//--- controllo se numero FAX già caricato
				k_ctr = pos(trim(kst_tab_clienti_r.fax),  kst_tab_clienti.fax, 1)
				if k_ctr = 0 then
					k_tel_r = kuf1_utility.u_stringa_numeri(kst_tab_clienti_r.fax)
					k_tel = kuf1_utility.u_stringa_numeri(kst_tab_clienti.fax)
					if k_tel_r <> k_tel then 
						kst_tab_clienti.fax = trim(kst_tab_clienti_r.fax) + "  " + kst_tab_clienti.fax
					else
						kst_tab_clienti.fax = trim(kst_tab_clienti_r.fax)
					end if
				else
					kst_tab_clienti.fax = trim(kst_tab_clienti_r.fax)
				end if
			else
				if len(trim(kst_tab_clienti_r.fax)) > 0 then
					kst_tab_clienti.fax = trim(kst_tab_clienti_r.fax)
				end if
			end if
	
			if len(trim(kst_tab_clienti_r.stato)) > 0 then
				kst_tab_clienti.stato = kst_tab_clienti_r.stato
			end if
			if kst_tab_clienti_r.data_attivazione > date(0) then
				kst_tab_clienti.data_attivazione = kst_tab_clienti_r.data_attivazione
			end if
			if len(trim( kst_tab_clienti_r.id_clie_classe)) > 0  then
				kst_tab_clienti.id_clie_classe = kst_tab_clienti_r.id_clie_classe
			end if
	
			update clienti 
				set fono = :kst_tab_clienti.fono 
				,fax = :kst_tab_clienti.fax
				,stato = :kst_tab_clienti.stato
				,data_attivazione = :kst_tab_clienti.data_attivazione
				,id_clie_classe = :kst_tab_clienti.id_clie_classe
				,x_utente = :kst_tab_clienti.x_utente
				,x_datins = :kst_tab_clienti.x_datins
			where codice = :kst_tab_clienti.codice 
			using sqlca;
	
	
	//--- MKT:
			kst_tab_clienti_mkt.id_contatto_1 =  kst_tab_contatto1.codice
	//		kst_tab_clienti_mkt.contatto_1_qualif = upper(kst_tab_contatto1_mkt.qualifica)
			kst_tab_clienti_mkt.id_contatto_2 = kst_tab_contatto2.codice
			kst_tab_clienti_mkt.id_contatto_3 = kst_tab_contatto3.codice
			kst_tab_clienti_mkt.id_contatto_4 = kst_tab_contatto4.codice
	
			select 
				cod_atecori 
				,altra_sede
				,tipo_rapporto
				,note_prodotti
				,id_cliente_link
				,id_contatto_1
				,contatto_1_qualif
				,id_contatto_2
				,id_contatto_3
				,id_contatto_4
				into
				:kst_tab_clienti_mkt_r.cod_atecori 
				,:kst_tab_clienti_mkt_r.altra_sede
				,:kst_tab_clienti_mkt_r.tipo_rapporto
				,:kst_tab_clienti_mkt_r.note_prodotti
				,:kst_tab_clienti_mkt_r.id_cliente_link
				,:kst_tab_clienti_mkt_r.id_contatto_1
				,:kst_tab_clienti_mkt_r.contatto_1_qualif
				,:kst_tab_clienti_mkt_r.id_contatto_2
				,:kst_tab_clienti_mkt_r.id_contatto_3
				,:kst_tab_clienti_mkt_r.id_contatto_4
			from clienti_mkt
			where id_cliente = :kst_tab_clienti.codice 
			using sqlca;
			if sqlca.sqlcode = 0 then 
			
				if len(trim(kst_tab_clienti_mkt_r.cod_atecori)) > 0 then
					kst_tab_clienti_mkt.cod_atecori = kst_tab_clienti_mkt_r.cod_atecori
				end if
				if len(trim(kst_tab_clienti_mkt_r.altra_sede)) > 0 then
					kst_tab_clienti_mkt.altra_sede = kst_tab_clienti_mkt_r.altra_sede
				end if
				if len(trim(kst_tab_clienti_mkt_r.tipo_rapporto)) > 0 then
					kst_tab_clienti_mkt.tipo_rapporto = kst_tab_clienti_mkt_r.tipo_rapporto
				end if
				if len(trim(kst_tab_clienti_mkt_r.note_prodotti)) > 0 then
					if kst_tab_clienti_mkt.note_prodotti <> kst_tab_clienti_mkt_r.note_prodotti then
						kst_tab_clienti_mkt.note_prodotti += kst_tab_clienti_mkt_r.note_prodotti
					end if
				end if
				if kst_tab_clienti_mkt_r.id_cliente_link > 0 then
					kst_tab_clienti_mkt.id_cliente_link = kst_tab_clienti_mkt_r.id_cliente_link
				end if
				if kst_tab_clienti_mkt_r.id_contatto_1 > 0 then
					kst_tab_clienti_mkt.id_contatto_1 = kst_tab_clienti_mkt_r.id_contatto_1
				end if
				if len(trim(kst_tab_clienti_mkt_r.contatto_1_qualif)) > 0 then
					kst_tab_clienti_mkt.contatto_1_qualif = kst_tab_clienti_mkt_r.contatto_1_qualif
				end if
				if kst_tab_clienti_mkt_r.id_contatto_2 > 0 then
					kst_tab_clienti_mkt.id_contatto_2 = kst_tab_clienti_mkt_r.id_contatto_2
				end if
				if kst_tab_clienti_mkt_r.id_contatto_3 > 0 then
					kst_tab_clienti_mkt.id_contatto_3 = kst_tab_clienti_mkt_r.id_contatto_3
				end if
				if kst_tab_clienti_mkt_r.id_contatto_4 > 0 then
					kst_tab_clienti_mkt.id_contatto_4 = kst_tab_clienti_mkt_r.id_contatto_4
				end if
			
				if len(trim(kst_tab_clienti_mkt.cod_atecori)) > 0 or len(trim(kst_tab_clienti_mkt.altra_sede)) > 0 &
						or len(trim(kst_tab_clienti_mkt.tipo_rapporto)) > 0 or len(trim(kst_tab_clienti_mkt.note_prodotti)) > 0 &
						or kst_tab_clienti_mkt.id_cliente_link > 0 &
						or kst_tab_clienti_mkt.id_contatto_1 > 0 &
						or len(trim(kst_tab_clienti_mkt_r.contatto_1_qualif)) > 0 &
						or kst_tab_clienti_mkt.id_contatto_2 > 0 &
						or kst_tab_clienti_mkt.id_contatto_3 > 0 &
						or kst_tab_clienti_mkt.id_contatto_4 > 0 then
						
					kst_tab_clienti_mkt.cod_atecori = upper(kst_tab_clienti_mkt.cod_atecori)
	//				kst_tab_clienti_mkt.note_prodotti = upper(kst_tab_clienti_mkt.note_prodotti)
					kst_tab_clienti_mkt.altra_sede = kst_tab_clienti_mkt.altra_sede
					kst_tab_clienti_mkt.tipo_rapporto = upper(kst_tab_clienti_mkt.tipo_rapporto)
	//				kst_tab_clienti_mkt.contatto_1_qualif = upper(kst_tab_clienti_mkt.contatto_1_qualif)
						
					update clienti_mkt 
						set cod_atecori = :kst_tab_clienti_mkt.cod_atecori 
						,altra_sede = :kst_tab_clienti_mkt.altra_sede
						,tipo_rapporto = :kst_tab_clienti_mkt.tipo_rapporto
						,note_prodotti = :kst_tab_clienti_mkt.note_prodotti
						,id_cliente_link = :kst_tab_clienti_mkt.id_cliente_link
						,id_contatto_1 = :kst_tab_clienti_mkt.id_contatto_1
						,contatto_1_qualif = :kst_tab_clienti_mkt.contatto_1_qualif
						,id_contatto_2 = :kst_tab_clienti_mkt.id_contatto_2
						,id_contatto_3 = :kst_tab_clienti_mkt.id_contatto_3
						,id_contatto_4 = :kst_tab_clienti_mkt.id_contatto_4
						,x_datins = :kst_tab_clienti_mkt.x_datins
						,x_utente = :kst_tab_clienti_mkt.x_utente
					where id_cliente = :kst_tab_clienti.codice 
					using sqlca;
					
				end if			
			else
				if len(trim(kst_tab_clienti_mkt.cod_atecori)) > 0 or len(trim(kst_tab_clienti_mkt.altra_sede)) > 0 &
						or len(trim(kst_tab_clienti_mkt_r.tipo_rapporto)) > 0 or len(trim(kst_tab_clienti_mkt.note_prodotti)) > 0 &
						or kst_tab_clienti_mkt.id_cliente_link > 0 &
						or kst_tab_clienti_mkt.id_contatto_1 > 0 &
						or len(trim(kst_tab_clienti_mkt_r.contatto_1_qualif)) > 0 &
						or kst_tab_clienti_mkt.id_contatto_2 > 0 &
						or kst_tab_clienti_mkt.id_contatto_3 > 0 &
						or kst_tab_clienti_mkt.id_contatto_4 > 0 then
						
					kst_tab_clienti_mkt.cod_atecori = upper(kst_tab_clienti_mkt.cod_atecori)
					kst_tab_clienti_mkt.note_prodotti = upper(kst_tab_clienti_mkt.note_prodotti)
					kst_tab_clienti_mkt.altra_sede = upper(kst_tab_clienti_mkt.altra_sede)
					kst_tab_clienti_mkt.tipo_rapporto = upper(kst_tab_clienti_mkt.tipo_rapporto)
	//				kst_tab_clienti_mkt.contatto_1_qualif = upper(kst_tab_clienti_mkt.contatto_1_qualif)
						
					insert into clienti_mkt 
						(id_cliente
						,qualifica
						,cod_atecori 
						,altra_sede
						,tipo_rapporto
						,note_prodotti
						,id_cliente_link
						,id_contatto_1
						,contatto_1_qualif
						,id_contatto_2
						,contatto_2_qualif
						,id_contatto_3
						,contatto_3_qualif
						,id_contatto_4
						,contatto_4_qualif
						,id_contatto_5
						,contatto_5_qualif
						,note_attivita
						,x_utente
						,x_datins)
						values 
						(:kst_tab_clienti.codice 
						," "
						,:kst_tab_clienti_mkt.cod_atecori 
						,:kst_tab_clienti_mkt.altra_sede
						,:kst_tab_clienti_mkt.tipo_rapporto
						,:kst_tab_clienti_mkt.note_prodotti
						,:kst_tab_clienti_mkt.id_cliente_link
						,:kst_tab_clienti_mkt.id_contatto_1
						,:kst_tab_clienti_mkt.contatto_1_qualif
						,:kst_tab_clienti_mkt.id_contatto_2
						,""
						,:kst_tab_clienti_mkt.id_contatto_3
						,""
						,:kst_tab_clienti_mkt.id_contatto_4
						,""
						,0
						,""
						," "
						,:kst_tab_clienti_mkt.x_utente
						,:kst_tab_clienti_mkt.x_datins)
					using sqlca;
				end if	
			end if	
	
	
	//--- WEB:
			select 
				email 
				,email1
				,email2
				into
				:kst_tab_clienti_web_r.email 
				,:kst_tab_clienti_web_r.email1
				,:kst_tab_clienti_web_r.email2
			from clienti_web
			where id_cliente = :kst_tab_clienti.codice 
			using sqlca;
			if sqlca.sqlcode = 0 then 
			
				if len(trim(kst_tab_clienti_web_r.email)) > 0 then
					kst_tab_clienti_web.email = kst_tab_clienti_web_r.email
				end if
				if len(trim(kst_tab_clienti_web_r.email1)) > 0 then
					kst_tab_clienti_web.email1 = kst_tab_clienti_web_r.email1
				end if
				if len(trim(kst_tab_clienti_web_r.email2)) > 0 then
					kst_tab_clienti_web.email2 = kst_tab_clienti_web_r.email2
				end if
	
				if len(trim(kst_tab_clienti_web.email)) > 0  or len(trim(kst_tab_clienti_web.email1)) > 0 & 
						or len(trim(kst_tab_clienti_web.email2)) > 0 then
	
					kst_tab_clienti_web.email = lower(kst_tab_clienti_web.email)
					kst_tab_clienti_web.email1 = lower(kst_tab_clienti_web.email1)
					kst_tab_clienti_web.email2 = lower(kst_tab_clienti_web.email2)
	
					update clienti_web 
						set email = :kst_tab_clienti_web.email 
						,email1 = :kst_tab_clienti_web.email1
						,email2 = :kst_tab_clienti_web.email2
						,x_datins = :kst_tab_clienti_web.x_datins
						,x_utente = :kst_tab_clienti_web.x_utente
					where id_cliente = :kst_tab_clienti.codice 
					using sqlca;
				end if				
			else
				if len(trim(kst_tab_clienti_web.email)) > 0  or len(trim(kst_tab_clienti_web.email1)) > 0 & 
						or len(trim(kst_tab_clienti_web.email2)) > 0 then
	
					kst_tab_clienti_web.email = lower(kst_tab_clienti_web.email)
					kst_tab_clienti_web.email1 = lower(kst_tab_clienti_web.email1)
					kst_tab_clienti_web.email2 = lower(kst_tab_clienti_web.email2)
						
					insert into clienti_web 
						(id_cliente
						,email 
						,email1
						,email2
						,note
						,sito_web
						,sito_web1
						,blog_web
						,blog_web1
						,x_utente
						,x_datins)
						values 
						(:kst_tab_clienti.codice 
						,:kst_tab_clienti_web.email 
						,:kst_tab_clienti_web.email1
						,:kst_tab_clienti_web.email2
						," "
						," "
						," "
						," "
						," "
						,:kst_tab_clienti_web.x_utente
						,:kst_tab_clienti_web.x_datins)
					using sqlca;
				end if
			end if
	
	
		end if
		
	next
	
	COMMIT;
	
	
	setpointer(kp)

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	if isvalid(kuf1_utility) then destroy kuf1_utility

	
end try

	
end subroutine

private function st_esito importa_csv ();//===
//=== Importa i record del file CSV selezionato formato:
//=== prima riga con nome-lotto + ; + data-lotto (yyyy-mm-dd)
//=== seguono tutte le righe con:  coefficiente + ; + dose 
//===
int k_file=0, k_rc 
int k_bytes, k_ctr, k_ctr_1, k_bytes_f, k_righe, k_righe_insert=0, k_bytes_appo
long k_colonna, k_riga
string k_rcx
string k_record, k_record_appo
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
	
//	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi
//	kst_profilestring_ini.file = "ambiente" 
//	kst_profilestring_ini.titolo = "ambiente" 
//	kst_profilestring_ini.nome = "arch_dosimetrie_csv"
//	kst_profilestring_ini.valore = " " 
//	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//
//	k_path = trim(kst_profilestring_ini.valore)
//
//	if LenA(k_path) > 0 then
//		k_rcx = k_path
//		k_rc = LenA(k_rcx)
//		do while MidA(k_rcx, k_rc, 1) <> "\" and k_rc > 1
//			k_rcx = ReplaceA(k_rcx, k_rc, 1, " ")  
//			k_rc= k_rc - 1
//		loop
//		if DirectoryExists ( trim(k_rcx) ) then 
//			ChangeDirectory(trim(k_rcx)) 
//		end if
//		k_nome_file	= k_path
//	end if

k_rc = GetFileOpenName("Scegli Archivio 'Anagrafiche'", &
									k_path, k_nome_file, k_ext, "Anagrafiche in CSV (*.csv),*.csv") 

if k_rc <= 0 or LenA(trim(k_nome_file)) = 0 then
	k_path = " "
	kst_esito.esito = kkg_esito.NO_ESECUZIONE
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Elaborazione interrotta dall'utente" 
	
else
	k_file = fileopen( trim(k_path), linemode!, read!, lockreadwrite!)
	
	if k_file > 0 then

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
			

//--- piglio il primo record di dettaglio
			k_bytes = fileread(k_file, k_record) // legge una riga
			k_righe++
			if k_bytes <= 0 then
				k_record = " "
			end if

			dw_1.reset( )

			do while k_bytes > 0 and kst_esito.esito = kkg_esito.OK

//--- pulizia delle strnghe
//				k_record = kuf1_utility.u_replace(k_record, ".", ",")
				k_record = kuf1_utility.u_replace(k_record,"~"", " ")
				kuf1_utility.u_stringa_pulisci_x_msg(k_record)
				
//--- record di dettaglio piglio i campi a mettere nel DW
				k_ctr = PosA (k_record, ';')
				if k_ctr > 0 then
					
//--- inserisci nuovo record								
					k_riga = dw_1.insertrow(0)
					k_righe_insert++
					dw_1.setitem(k_riga, 1, k_riga)
					
//--- legge fino a che trova ';' e riempie tutte le colonne 		
					k_colonna = 3
					k_ctr_1 = 1
					do while k_ctr > 0 and k_colonna < 32 and k_bytes > 0

						if k_colonna = 3 then //id_cliente unico numerico
							if k_ctr = k_ctr_1 then
								dw_1.setitem(k_riga, k_colonna,0)
								dw_1.setitem(k_riga, 2, "S")
							else
								dw_1.setitem(k_riga, k_colonna,long(trim(MidA(k_record,k_ctr_1, k_ctr - k_ctr_1))))
							end if
						else
							if k_ctr = k_ctr_1 then
								dw_1.setitem(k_riga, k_colonna," ")
							else
								dw_1.setitem(k_riga, k_colonna,trim(MidA(k_record,k_ctr_1, k_ctr - k_ctr_1)))
							end if
						end if
//--- se ho superato la len el record legg altro record
						if (k_ctr + 1) < k_bytes  then
							k_ctr_1 = k_ctr + 1
							k_ctr = PosA (k_record, ';', k_ctr + 1)
//--- se non trovo il ';' ma non ho ancora letto tutte le colonne pobabile che il continuo sia nella riga successiva							
							if k_ctr = 0 then
								if k_colonna < 30 then
									do while k_ctr = 0 and k_bytes >= 0
										k_bytes_appo = k_bytes - k_ctr_1
										k_record_appo = trim(MidA(k_record,k_ctr_1, k_bytes - k_ctr_1))
										k_bytes = fileread(k_file, k_record) // legge una riga
										k_ctr_1=1
										if k_bytes > 0 then
											k_righe++
//											k_record = kuf1_utility.u_replace(k_record, ".", ",")
											k_record = kuf1_utility.u_replace(k_record,"~"", " ")
											kuf1_utility.u_stringa_pulisci_x_msg(k_record)
											k_record = k_record_appo + k_record
											k_bytes = k_bytes + k_bytes_appo
											k_ctr = PosA (k_record, ';', 1)
										end if
									loop
									dw_1.setitem(k_riga, 2, "S")
									
									k_ctr_1 = 1
								else
									k_ctr = k_bytes
								end if
							end if
						else
							k_ctr = 0 //forzo uscita 
						end if
						k_colonna ++
					loop
				end if
				
				if k_bytes >= 0 then
					k_bytes = fileread(k_file, k_record) // legge una riga
					k_righe++
					if k_bytes <= 0 then
						k_record = " "
					end if
				end if

			loop
			
			fileclose(k_file)
			
			destroy kuf1_utility
			
		else
			kst_esito.esito = kkg_esito.blok
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "File inconsistente numero righe insufficiente: " + string(k_righe)
		end if
	else
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "File non trovato o occupato, cercato: " + trim(k_path) 
	end if

	if kst_esito.esito <> kkg_esito.ok then
			
		kst_esito.SQLErrText = "Elaborazione terminata con Errore~n~r" + "controllare i valori inseriti.~n~r" &
										+ "Errore rilevato~n~r" &
			                     + trim(kst_esito.SQLErrText) + "~n~r" &
			                     + string(k_righe, "##,##0") + " righe elaborate~n~r" &
			                     + "dal file " + trim(k_path) + "~n~r" 
			
	else
		kst_esito.SQLErrText = "Elaborazione terminata Correttamente~n~r" + "controllare i valori inseriti.~n~r" &
			                     + string(k_righe, "##,##0") + " righe lette dal file~n~r" &
			                     + string(k_righe_insert, "##,##0") + " righe inserite in archivio~n~r" &
			                     + "dal file " + trim(k_path) + "~n~r" 
			
	end if

end if

//--- ripristina la path di lavoro
kGuf_data_base.setta_path_default()
							
							
return kst_esito


end function

private function st_esito importa_csv_rid ();//===
//=== Importa i record del file CSV selezionato.
//=== prima riga con la testata 
//=== seguono tutte le righe con i campi separati dal char ';'
//===
int k_file=0, k_rc 
int k_bytes, k_ctr, k_ctr_1, k_bytes_f, k_righe, k_righe_insert=0, k_bytes_appo
long k_colonna, k_riga
string k_rcx, k_valore_col
string k_record, k_record_appo
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
	
//	kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi
//	kst_profilestring_ini.file = "ambiente" 
//	kst_profilestring_ini.titolo = "ambiente" 
//	kst_profilestring_ini.nome = "arch_dosimetrie_csv"
//	kst_profilestring_ini.valore = " " 
//	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//
//	k_path = trim(kst_profilestring_ini.valore)
//
//	if LenA(k_path) > 0 then
//		k_rcx = k_path
//		k_rc = LenA(k_rcx)
//		do while MidA(k_rcx, k_rc, 1) <> "\" and k_rc > 1
//			k_rcx = ReplaceA(k_rcx, k_rc, 1, " ")  
//			k_rc= k_rc - 1
//		loop
//		if DirectoryExists ( trim(k_rcx) ) then 
//			ChangeDirectory(trim(k_rcx)) 
//		end if
//		k_nome_file	= k_path
//	end if

k_rc = GetFileOpenName("Scegli Archivio 'Anagrafiche' RIDOTTO", &
									k_path, k_nome_file, k_ext, "Anagrafiche in CSV (*.csv),*.csv") 

if k_rc <= 0 or LenA(trim(k_nome_file)) = 0 then
	k_path = " "
	kst_esito.esito = kkg_esito.NO_ESECUZIONE
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Elaborazione interrotta dall'utente" 
	
else
	k_file = fileopen( trim(k_path), linemode!, read!, lockreadwrite!)
	
	if k_file > 0 then

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
			

//--- piglio il primo record di dettaglio
			k_bytes = fileread(k_file, k_record) // legge una riga
			k_righe++
			if k_bytes <= 0 then
				k_record = " "
			end if

			dw_1.reset( )

			do while k_bytes > 0 and kst_esito.esito = kkg_esito.OK

//--- pulizia delle strnghe
//				k_record = kuf1_utility.u_replace(k_record, ".", ",")
				k_record = kuf1_utility.u_replace(k_record,"~"", " ")
				kuf1_utility.u_stringa_pulisci_x_msg(k_record)
				
//--- record di dettaglio piglio i campi a mettere nel DW
				k_ctr = PosA (k_record, ';')
				if k_ctr > 0 then
					
//--- inserisci nuovo record								
					k_riga = dw_1.insertrow(0)
					k_righe_insert++
					dw_1.setitem(k_riga, 1, k_riga)
					
//--- legge fino a che trova ';' e riempie tutte le colonne 		
					k_colonna = 3
					k_ctr_1 = 1
					k_valore_col = trim(MidA(k_record,k_ctr_1, k_ctr - k_ctr_1))
					
					do while k_ctr > 0 and k_colonna < 11 and k_bytes > 0 

						
						if k_colonna = 3 then //id_cliente unico numerico
							if k_ctr = k_ctr_1 then
								dw_1.setitem(k_riga, k_colonna,0)
								dw_1.setitem(k_riga, 2, "S")
							else
								dw_1.setitem(k_riga, k_colonna,long(k_valore_col))
							end if
						else
							if k_ctr = k_ctr_1 then
								dw_1.setitem(k_riga, k_colonna," ")
							else
								dw_1.setitem(k_riga, k_colonna,trim(k_valore_col))
							end if
						end if
						
						k_colonna ++
						k_ctr_1 = k_ctr + 1
						k_ctr = PosA (k_record, ';', k_ctr + 1)
						if k_ctr > 0 then
							k_valore_col = trim(MidA(k_record,k_ctr_1, k_ctr - k_ctr_1))
						end if
						
					loop
					
					
				end if
				
				if k_bytes >= 0 then
					k_bytes = fileread(k_file, k_record) // legge una riga
					k_righe++
					if k_bytes <= 0 then
						k_record = " "
					end if
				end if

			loop
			
			fileclose(k_file)
			
			destroy kuf1_utility
			
		else
			kst_esito.esito = kkg_esito.blok
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "File inconsistente numero righe insufficiente: " + string(k_righe)
		end if
	else
		kst_esito.esito = kkg_esito.blok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "File non trovato o occupato, cercato: " + trim(k_path) 
	end if

	if kst_esito.esito <> kkg_esito.ok then
			
		kst_esito.SQLErrText = "Elaborazione terminata con Errore~n~r" + "controllare i valori inseriti.~n~r" &
										+ "Errore rilevato~n~r" &
			                     + trim(kst_esito.SQLErrText) + "~n~r" &
			                     + string(k_righe, "##,##0") + " righe elaborate~n~r" &
			                     + "dal file " + trim(k_path) + "~n~r" 
			
	else
		kst_esito.SQLErrText = "Elaborazione terminata Correttamente~n~r" + "controllare i valori inseriti.~n~r" &
			                     + string(k_righe, "##,##0") + " righe lette dal file~n~r" &
			                     + string(k_righe_insert, "##,##0") + " righe inserite in archivio~n~r" &
			                     + "dal file " + trim(k_path) + "~n~r" 
			
	end if

end if

//--- ripristina la path di lavoro
kGuf_data_base.setta_path_default()
							
							
return kst_esito


end function

private subroutine aggiorna_db_rid ();//---
//--- Popola archivi da DW 
//---
int k_riga, k_ctr
string k_tel_r, k_tel
st_tab_clienti kst_tab_clienti, kst_tab_contatto1, kst_tab_contatto2, kst_tab_contatto3,kst_tab_contatto4, kst_tab_clienti_r 
st_tab_clienti_mkt kst_tab_clienti_mkt, kst_tab_contatto1_mkt, kst_tab_contatto2_mkt, kst_tab_contatto3_mkt, kst_tab_contatto4_mkt, kst_tab_clienti_mkt_r
st_tab_clienti_web kst_tab_clienti_web, kst_tab_clienti_web_r
st_tab_clie_settori kst_tab_clie_settori
st_tab_clie_classi kst_tab_clie_classi
kuf_clienti kuf1_clienti
kuf_utility kuf1_utility
pointer kp




kp = setpointer(hourglass!)


kst_tab_clienti.x_datins = kGuf_data_base.prendi_x_datins()
kst_tab_clienti.x_utente = kGuf_data_base.prendi_x_utente()
kst_tab_clienti_web.x_datins = kGuf_data_base.prendi_x_datins()
kst_tab_clienti_web.x_utente = kGuf_data_base.prendi_x_utente()
kst_tab_clienti_mkt.x_datins = kGuf_data_base.prendi_x_datins()
kst_tab_clienti_mkt.x_utente = kGuf_data_base.prendi_x_utente()

kuf1_utility = create kuf_utility


//--- Pulizia dei Campi					
update clienti_mkt 
		set note_prodotti = ""
	using sqlca;
	

for k_riga = 1 to dw_1.rowcount()

	kst_tab_clienti.codice = dw_1.getitemnumber( k_riga, "id_cliente")

	
	kst_tab_clienti_mkt.note_prodotti = ""
	if len(trim(dw_1.getitemstring( k_riga, "note_prodotto"))) > 0 then 
		kst_tab_clienti_mkt.note_prodotti = trim(dw_1.getitemstring( k_riga, "note_prodotto"))
	end if
	if len(trim(dw_1.getitemstring( k_riga, "note_prodotto_est"))) > 0 then 
		if len(trim(kst_tab_clienti_mkt.note_prodotti)) > 0 then
			kst_tab_clienti_mkt.note_prodotti += ": " +  trim(dw_1.getitemstring( k_riga, "note_prodotto_est")) + "; " 
		else
			kst_tab_clienti_mkt.note_prodotti = trim(dw_1.getitemstring( k_riga, "note_prodotto_est"))
		end if
	end if
	if len(trim(dw_1.getitemstring( k_riga, "valore_prodotto"))	) > 0 then
		kst_tab_clienti_mkt.note_prodotti += "  (Valore=" + trim(dw_1.getitemstring( k_riga, "valore_prodotto")) + ")"
	end if
	if len(trim(kst_tab_clienti_mkt.note_prodotti)) > 0 then
		kst_tab_clienti_mkt.note_prodotti += "; "
	else
		kst_tab_clienti_mkt.note_prodotti = ""
	end if

	if len(trim(dw_1.getitemstring( k_riga, "cod_gru"))) > 0 and isnumber(trim(dw_1.getitemstring( k_riga, "cod_gru"))) then 
		kst_tab_clienti_mkt.gruppo = long(trim(dw_1.getitemstring( k_riga, "cod_gru")) ) 
	else
		kst_tab_clienti_mkt.gruppo = 0  
	end if

	

	
//--- tabelle Settori	
	kst_tab_clie_settori.descr = upper(trim(dw_1.getitemstring( k_riga, "settore")))
	
//--- UPDATE DB--------------------------------------------------------------------------------------


//--- tab SETTORI CLIENTI
	kst_tab_clie_settori.id_clie_settore=""
	if  len(trim(kst_tab_clie_settori.descr)) > 0 then
		select 
			id_clie_settore 
			into
			:kst_tab_clie_settori.id_clie_settore
		from clie_settori
		where  descr = :kst_tab_clie_settori.descr
		using sqlca;
		if sqlca.sqlcode = 0 then 
//			kst_tab_clienti.id_clie_settore = kst_tab_clie_settori.id_clie_settore
		else
			kst_tab_clienti.id_clie_settore = ""
		end if
	end if

//--- CLIENTI:
	select 
		id_clie_settore
		into
		:kst_tab_clienti.id_clie_settore
	from clienti
	where codice = :kst_tab_clienti.codice 
	using sqlca;
	
	if sqlca.sqlcode = 0 then 

//--- settore
		if isnull(kst_tab_clienti.id_clie_settore) or  len(trim(kst_tab_clienti.id_clie_settore)) = 0 then 
			kst_tab_clienti.id_clie_settore = kst_tab_clie_settori.id_clie_settore 
					
			update clienti 
					set id_clie_settore = :kst_tab_clienti.id_clie_settore
					,x_datins = :kst_tab_clienti_mkt.x_datins
					,x_utente = :kst_tab_clienti_mkt.x_utente
				where codice = :kst_tab_clienti.codice 
				using sqlca;

		end if


//--- MKT:
		select 
			note_prodotti
			,gruppo
			into
			:kst_tab_clienti_mkt_r.note_prodotti
			,:kst_tab_clienti_mkt_r.gruppo
		from clienti_mkt
		where id_cliente = :kst_tab_clienti.codice 
		using sqlca;
		if sqlca.sqlcode = 0 then 
		
			if len(trim(kst_tab_clienti_mkt_r.note_prodotti)) > 0 then
				if kst_tab_clienti_mkt.note_prodotti <> kst_tab_clienti_mkt_r.note_prodotti then
					kst_tab_clienti_mkt.note_prodotti += kst_tab_clienti_mkt_r.note_prodotti
				end if
			end if
		
			if kst_tab_clienti_mkt_r.gruppo > 0 then
				kst_tab_clienti_mkt.gruppo = kst_tab_clienti_mkt_r.gruppo
			end if
		
			update clienti_mkt 
					set note_prodotti = :kst_tab_clienti_mkt.note_prodotti
					,gruppo = :kst_tab_clienti_mkt.gruppo
					,x_datins = :kst_tab_clienti_mkt.x_datins
					,x_utente = :kst_tab_clienti_mkt.x_utente
				where id_cliente = :kst_tab_clienti.codice 
				using sqlca;
				
		else
					
//			kst_tab_clienti_mkt.note_prodotti = upper(kst_tab_clienti_mkt.note_prodotti)
//				(
//				id_cliente
//				,note_prodotti
//				,gruppo
//				,x_utente
//				,x_datins)
//				values 
//				(:kst_tab_clienti.codice 
//				,:kst_tab_clienti_mkt.note_prodotti
//				,:kst_tab_clienti_mkt.gruppo
//				,:kst_tab_clienti_mkt.x_utente
//				,:kst_tab_clienti_mkt.x_datins)
//			using sqlca;
//
//					
			insert into clienti_mkt 
					(id_cliente
					,qualifica
					,cod_atecori 
					,altra_sede
					,tipo_rapporto
					,note_prodotti
					,gruppo
					,id_cliente_link
					,id_contatto_1
					,contatto_1_qualif
					,id_contatto_2
					,contatto_2_qualif
					,id_contatto_3
					,contatto_3_qualif
					,id_contatto_4
					,contatto_4_qualif
					,id_contatto_5
					,contatto_5_qualif
					,note_attivita
					,x_utente
					,x_datins)
					values 
					(:kst_tab_clienti.codice 
					," "
					,"" 
					,""
					,""
					,:kst_tab_clienti_mkt.note_prodotti
					,:kst_tab_clienti_mkt.gruppo
					,0
					,0
					,""
					,0
					,""
					,0
					,""
					,0
					,""
					,0
					,""
					," "
					,:kst_tab_clienti_mkt.x_utente
					,:kst_tab_clienti_mkt.x_datins)
				using sqlca;



		end if	



	end if
	
next

COMMIT;

destroy kuf1_utility

setpointer(kp)


	
end subroutine

on w_import_cvs_crm_anag.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_4
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
end on

on w_import_cvs_crm_anag.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event resize;call super::resize;dw_1.y = 5

dw_1.width = newwidth - 30

cb_1.y = newheight - cb_1.height - 20
cb_2.y = cb_1.y
cb_3.y = cb_1.y
cb_4.y = cb_1.y
cb_ritorna.y = cb_1.y

dw_1.height = cb_1.y - dw_1.y - 30 


end event

type st_ritorna from w_g_tab`st_ritorna within w_import_cvs_crm_anag
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_import_cvs_crm_anag
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_import_cvs_crm_anag
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_import_cvs_crm_anag
boolean visible = true
integer x = 3474
integer y = 1440
end type

type st_stampa from w_g_tab`st_stampa within w_import_cvs_crm_anag
end type

type dw_1 from uo_d_std_1 within w_import_cvs_crm_anag
boolean visible = true
integer x = 23
integer y = 24
integer width = 3904
integer height = 1320
integer taborder = 10
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string dataobject = "d_import_csv_crm_anag_rid"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
end type

type cb_4 from commandbutton within w_import_cvs_crm_anag
integer x = 1504
integer y = 1412
integer width = 613
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recupera ultimo import"
end type

event clicked;//
	dw_1.reset()
	kGuf_data_base.dw_ripri_righe( "*", dw_1)


end event

type cb_3 from commandbutton within w_import_cvs_crm_anag
integer x = 1029
integer y = 1412
integer width = 471
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva import"
end type

event clicked;//
kGuf_data_base.dw_salva_righe( "*", dw_1)

end event

type cb_2 from commandbutton within w_import_cvs_crm_anag
integer x = 2409
integer y = 1412
integer width = 827
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string text = "Aggiorna Archivi M2000"
end type

event clicked;//
if messagebox("Importa Dati in M2000","Sei sicuro di voler procedere",question!, yesno!,2) = 1 then

	aggiorna_db_rid()
	
end if
end event

type cb_1 from commandbutton within w_import_cvs_crm_anag
integer x = 151
integer y = 1412
integer width = 741
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importa CSV Anagrafiche"
end type

event clicked;//
string k_file, k_file_1
int   li_fileid
st_esito kst_esito
//uo_csv_import kuo_cvs_import

 

//li_fileid = GetFileOpenName ("Open", k_file, k_file_1,  "cvs", "Anagrafiche da importare (*.cvs),*.csv ",   "", 512) 
//
//
//if li_fileid > 0 then 
	
	kst_esito = importa_csv_rid()
	messagebox("Fine Elaborazione", kst_esito.sqlerrtext)
//	dw_1.importfile(CSV!, k_file, 2)
	
//	kuo_cvs_import = create uo_csv_import
//	
//	kuo_cvs_import.of_importfile( k_file, dw_1)
//	
//	destroy kuo_cvs_import
	
//end if
end event

