$PBExportHeader$kuf_base.sru
forward
global type kuf_base from nonvisualobject
end type
end forward

global type kuf_base from nonvisualobject
end type
global kuf_base kuf_base

forward prototypes
public function string check_pwd (string k_pwd)
public function long dammi_rec (ref st_tab_base k_st_tab_base)
public function string metti_dato_base_old (integer k_tipo, string k_key, string k_key_1)
public function string prendi_dato_base (string k_key)
public function st_esito metti_dato_base (st_tab_base kst_tab_base)
public function string leggi_base_old ()
public function string scrivi_base_old (string k_record_orig, string k_record_new)
public function st_esito scrivi_base (st_tab_base kst_tab_base)
public function st_esito leggi_base (ref st_tab_base kst_tab_base)
end prototypes

public function string check_pwd (string k_pwd);//
//=== Controlla la password digitata dall'utente
//=== restituisce il privilegio
//
string k_return='0'
string k_pass[10]
int k_ctr, k_priv[10]


	  SELECT word_1,   
            word_2,   
            word_3,   
            word_4,   
            word_5,   
            word_6,   
            word_7,   
            priv_1,   
            priv_2,   
            priv_3,   
            priv_4,   
            priv_5,   
            priv_6,   
            priv_7  
    INTO :k_pass[1],   
         :k_pass[2],   
         :k_pass[3],   
         :k_pass[4],   
         :k_pass[5],   
         :k_pass[6],   
         :k_pass[7],   
         :k_priv[1],   
         :k_priv[2],   
         :k_priv[3],   
         :k_priv[4],   
         :k_priv[5],   
         :k_priv[6],   
         :k_priv[7]  
    FROM pass  ;

	for k_ctr = 1 to 7
		if (upper(trim(k_pass[k_ctr]))) = (upper(k_pwd)) then
			exit  // se trova esce dal ciclo
		end if
	next
	if k_ctr < 8 then
		k_return = string(k_priv[k_ctr]) 
	end if
	
return k_return


end function

public function long dammi_rec (ref st_tab_base k_st_tab_base);//
//--- Restituisce la struttura coi dati tab BASE
//
//--- Ritorna: sqlcode
//
long k_return



  SELECT distinct
         base.rag_soc_1,   
         base.rag_soc_2,   
         base.indi,   
         base.loc,   
         base.cap,   
         base.prov,   
         base.num_int,   
         base.data_int,   
         base.num_bolla,   
         base.data_bolla,   
         base.num_certif,   
         base.num_bolla_stamp,   
         base.data_bolla_stamp,   
         base.num_fatt,   
         base.data_fatt,   
         base.num_fatt_stamp,   
         base.data_fatt_stamp,   
         base.stamp_bo,   
         base.stamp_cert,   
         base.stamp_ft,   
         base.num_scarico,   
         base.mis_x,   
         base.mis_y,   
         base.mis_z,   
         base.peso_max,   
         base.ult_id_armo,
         base.fpilota_out_path,
         base.fpilota_out_dt_dal
    INTO :k_st_tab_base.rag_soc_1,   
         :k_st_tab_base.rag_soc_2,   
         :k_st_tab_base.indi,   
         :k_st_tab_base.loc,   
         :k_st_tab_base.cap,   
         :k_st_tab_base.prov,   
         :k_st_tab_base.num_int,   
         :k_st_tab_base.data_int,   
         :k_st_tab_base.num_bolla,   
         :k_st_tab_base.data_bolla,   
         :k_st_tab_base.num_certif,   
         :k_st_tab_base.num_bolla_stamp,   
         :k_st_tab_base.data_bolla_stamp,   
         :k_st_tab_base.num_fatt,   
         :k_st_tab_base.data_fatt,   
         :k_st_tab_base.num_fatt_stamp,   
         :k_st_tab_base.data_fatt_stamp,   
         :k_st_tab_base.stamp_bo,   
         :k_st_tab_base.stamp_cert,   
         :k_st_tab_base.stamp_ft,   
         :k_st_tab_base.num_scarico,   
         :k_st_tab_base.mis_x,   
         :k_st_tab_base.mis_y,   
         :k_st_tab_base.mis_z,   
         :k_st_tab_base.peso_max,   
         :k_st_tab_base.ult_id_armo,   
         :k_st_tab_base.fpilota_out_path,   
         :k_st_tab_base.fpilota_out_dt_dal   
    FROM base  
	 using sqlca;

return sqlca.sqlcode

end function

public function string metti_dato_base_old (integer k_tipo, string k_key, string k_key_1);//
//=== Scrivo Dato su archivio AZIENDA
//
//=== parametri : tipo = non usato ; key = nome del campo; key1 = il dato
int k_file, k_base_pers=0
string k_record, k_return="0"
int k_bytes, k_pos_ini = 0, k_lungo = 0
date k_data
long k_long
string k_path


		k_return = "0" 
		choose case k_key 
			case "finestra_inizio" // programma da lanciare in fase di open della procedura
				k_base_pers = 1
				k_pos_ini = 143
				k_lungo = 25
			case "ult_num_pl_barcode" // 
				k_base_pers = 0
				k_long = long(trim(k_key_1))
				update base set 
				   ult_num_pl_barcode = :k_long
					using sqlca;
				if sqlca.sqlcode = 0 then
					commit using sqlca;
				else
					k_return = "1" + string(sqlca.sqlcode, "000") + trim(SQLCA.SQLErrText)  
				end if
			case "barcode_progr_man" // 
				k_base_pers = 0
				k_long = long(trim(k_key_1))
				update base set 
				   barcode_progr_man = :k_long
					using sqlca;
				if sqlca.sqlcode = 0 then
					commit using sqlca;
				else
					k_return = "1" + string(sqlca.sqlcode, "000") + trim(SQLCA.SQLErrText)  
				end if
			case "arch_pilota_out"
				k_base_pers = 0
				k_record = trim(k_key_1)
				update base set 
				   fpilota_out_path = :k_record
					using sqlca;
				if sqlca.sqlcode = 0 then
					commit using sqlca;
				else
					k_return = "1" + string(sqlca.sqlcode, "000") + trim(SQLCA.SQLErrText)  
				end if
			case "data_ultima_estrazione_pilota_out"
				k_base_pers = 0
				if isdate(k_key_1) then
					k_data = date(k_key_1)
					update base set 
					   fpilota_out_dt_dal = :k_data
						using sqlca;
					if sqlca.sqlcode = 0 then
						commit using sqlca;
					else
						k_return = "1" + string(sqlca.sqlcode, "000") + trim(SQLCA.SQLErrText)  
					end if
				end if
			case "num_certif" // 
				k_base_pers = 0
				k_long = long(trim(k_key_1))
				update base set 
				   num_certif = :k_long
					using sqlca;
				if sqlca.sqlcode = 0 then
					commit using sqlca;
				else
					k_return = "1" + string(sqlca.sqlcode, "000") + trim(SQLCA.SQLErrText)  
				end if
				
		end choose

		
		if k_base_pers > 0 then	

			
			k_path = profilestring ( KG_PATH_PROCEDURA + "\confdb.ini", "ambiente", "arch_base", "\.")
			k_file = fileopen( trim(k_path) + "\base.dat", linemode!, read!, lockwrite!)
			
			//=== Errore
			if k_file < 1 then
				
				k_return = "1Dati Azienda Occupati !!. Ripeti l'operazione."
			
			else
			
			//=== legge il file e lo mette in record
				k_bytes = fileread(k_file, k_record)
				if k_bytes = 0 then
			//=== file da creare lungo 1024 
					k_bytes = fileclose(k_file)
					k_file = fileopen(trim(k_path) + "\base.dat", linemode!, write!, lockwrite!, replace!)
					k_record = space(1024) 
					k_return = "0" + " "
					k_bytes = filewrite(k_file, k_record)
				else
						
					k_key_1 = k_key_1 + space(k_lungo)
					k_key_1 = left(k_key_1, k_lungo)
					
					k_bytes = fileclose(k_file)
					k_file = fileopen(trim(k_path) + "\base.dat", linemode!, write!, lockwrite!, replace!)
					k_record = replace(k_record, k_pos_ini, k_lungo, k_key_1) + space(1024)
					k_bytes = filewrite(k_file, (left(k_record, 1024)))
					if k_bytes < 1 then
						k_return = "1Errore durante l'aggiornamento del Base"
					end if	
				end if

				k_bytes = fileclose(k_file)
			end if
		end if



		
return k_return

end function

public function string prendi_dato_base (string k_key);//
//=== Legge archivio sequenziale BASE restituendo un valore 
//
//=== ritorna char 1 : 0=ok; 1=errore
//===              2-...: valore  
//
int k_file
string k_record, k_return="0"
int k_bytes, k_pos_ini = 0, k_lungo = 0, k_anno
string k_path, k_descr
date k_data
long k_long
double k_num1, k_num2, k_num3
ulong k_ulong 
boolean k_boolean, k_dati_no_da_db
st_profilestring_ini kst_profilestring_ini


	k_return = "0" 
//	k_dati_no_da_db = true
	
	choose case lower(k_key) 
			
		case "utente" 
//			k_dati_no_da_db = false
//			k_pos_ini = 115
//			k_lungo = 24
			kst_profilestring_ini.utente = ""
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "nome"
//			kst_profilestring_ini.valore = trim(k_key_1)
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				k_return = "1" + "Dato 'Nome Utente' non disponibile. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

//--- prendo il nome utente windows
		case "utente_login"
			k_ulong = 255
			k_record = space(k_ulong)
			k_boolean = GetUserNameA ( k_record, k_ulong )
			if k_boolean then
				k_record = trim(k_record)
			else
				k_return = "1" 
				k_record = " "
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "titolo" 
			select titolo_procedura
				 into :k_record
				 from base using sqlca;
			if sqlca.sqlcode = 0 then	 
				k_record = trim(k_record)
				if isnull(k_record) then
					k_record = "Nessun Titolo"
				end if
			else
				k_return = "1"
				k_record = "Errore:" + sqlca.sqlerrtext
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "mis_ped" 
			select mis_x, mis_y, mis_z
				 into :k_num1, :k_num2, :k_num3
				 from base;
			k_record = string(k_num1, "00000")+string(k_num2, "00000")+string(k_num3, "00000")
			k_pos_ini = 1
			k_lungo = 50
			
		case "anno"
			select anno
				 into :k_anno
				 from base;
			if isnull(k_anno) then
				k_anno = integer(string(today(), "yyyy"))
			end if
			k_record = string(k_anno, "0000")
			k_pos_ini = 1
			k_lungo = 4
			
		case "stamp_cbarre"
			select stamp_cbarre
				 into :k_record
				 from base;
			if isnull(k_record) then
				k_record = " "
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "font_alt"
//			k_dati_no_da_db = false
//			k_pos_ini = 156
//			k_lungo = 3
			kst_profilestring_ini.utente = ""
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "font_alt"
//			kst_profilestring_ini.valore = trim(k_key_1)
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				k_return = "1" + "Dato 'Dimensione Font' non disponibile. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if
			
//		case "catfi"
//			k_dati_no_da_db = false
//			k_pos_ini = 159
//			k_lungo = 5
			
		case "flag_salva_liste" 
//			k_dati_no_da_db = false
//			k_pos_ini = 180
//			k_lungo = 1
			kst_profilestring_ini.utente = ""
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "flag_salva_liste"
//			kst_profilestring_ini.valore = trim(k_key_1)
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_profilestring_ini.valore = "S"
//				kst_esito.esito = "1" 
//				kst_esito.sqlcode = 0
//				kst_esito.SQLErrText = 
	         k_return = "1" + "Dato 'Indicatore di Speed Elenco' non disponibile. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if
			
		case "finestra_inizio" 
//			k_dati_no_da_db = false
//			k_pos_ini = 143
//			k_lungo = 13
			kst_profilestring_ini.utente = ""
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "finestra_inizio"
//			kst_profilestring_ini.valore = trim(k_key_1)
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
	         k_return = "1" + "Dato 'Finestra di Partenza' non disponibile. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if
			
		case "dataoggi"
			k_record = string(today(), "dd.mm.yyyy")
			k_pos_ini = 1
			k_lungo = len(trim(k_record))
			
		case "descr_ultima_estrazione_statistici"
			select data_stat, ora_stat
				 into :k_data, :k_descr
				 from base;
			if isnull(k_data) or isnull(k_descr) then
				k_record = "Estrazione in Errore - Dati NON attendibili"
			else
				k_record = "Estrazione conclusa il " + string(k_data, "dd/mm/yyyy") + " alle " + trim(k_descr)
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "ult_num_pl_barcode"
			select ult_num_pl_barcode
				 into :k_long
				 from base;
			k_record = string(k_long, "000000000000")
			if isnull(k_record) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "num_certif"
			select num_certif
				 into :k_long
				 from base;
			k_record = string(k_long, "000000000000")
			if isnull(k_record) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "barcode_progr_man"
			select barcode_progr_man
				 into :k_long
				 from base;
			k_record = string(k_long, "000000000000")
			if isnull(k_record) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "arch_pilota_out"
			select fpilota_out_path
				 into :k_record
				 from base;
			k_record = trim(k_record)
			if isnull(k_record) or len(k_record) = 0 then
				k_record = " "
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "data_ultima_estrazione_pilota_out"
			select fpilota_out_dt_dal
				 into :k_data
				 from base;
			if isnull(k_data) or isnull(k_descr) then
				k_record = string(date(0))
			else
				k_record = string(k_data, "dd/mm/yyyy")
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)

		case "update_last_vers"
			select update_last_vers
				 into :k_record
				 from base;
			k_record = trim(k_record)
			if isnull(k_record) or len(k_record) = 0 then
				k_record = " "
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)

		case "last_version"
			select last_version
				 into :k_record
				 from base;
			k_record = trim(k_record)
			if isnull(k_record) or len(k_record) = 0 then
				k_record = " "
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)

		case "path_centrale"
			select path_centrale
				 into :k_record
				 from base;
			k_record = trim(k_record)
			if isnull(k_record) or len(k_record) = 0 then
				k_record = " "
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)

		case "path_pgm_upd"
			select path_pgm_upd
				 into :k_record
				 from base;
			k_record = trim(k_record)
			if isnull(k_record) or len(k_record) = 0 then
				k_record = " "
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)


//			case "path_ordo" 
//				select path_ordo
//				    into :k_record
//				    from base;
//				k_pos_ini = 1
//				k_lungo = 50
	end choose

////--- se il dato e' da estrarre dall'archivio di testo su disco...
//	if k_dati_no_da_db = false then
//
//		k_path = trim(kuf1_data_base.profilestring_leggi_scrivi(1, "arch_base", " "))
//		
//		if len(trim(k_path)) = 0 then
//			k_pos_ini = 0
//			k_return = "1Archivio Base Non Trovato!!. Uscire dalla Procedura."
//			
//		else			
//	
//			k_file = fileopen( trim(k_path) + "\base.dat", linemode!, read!, lockwrite!)
//	
////=== Errore
//			if k_file < 1 then
//		
//				k_pos_ini = 0
//				k_return = "1Archivio Base Occupato!!. Ripeti l'operazione."
//	
//			else
//	
////=== legge il file e lo mette in record
//				k_bytes = fileread(k_file, k_record)
//				if k_bytes = 0 then
////=== file da creare lungo 1024 
//					k_bytes = fileclose(k_file)
//					k_file = fileopen(trim(k_path) + "\base.dat", linemode!, write!, lockwrite!, replace!)
//					k_record = space(1024) 
//					k_return = "0" + " "
//					k_bytes = filewrite(k_file, k_record)
//					k_pos_ini = 0
//				end if
//			end if
//		end if
//	
//		k_bytes = fileclose(k_file)
//	end if

//--- se ok restituisco il dato salvato nella stringa K_RECORD			
	if k_pos_ini > 0 then	
		k_return = k_return + mid(k_record, k_pos_ini, k_lungo)
	else
		k_return = k_return + " "
	end if
		
		
return k_return

end function

public function st_esito metti_dato_base (st_tab_base kst_tab_base);//
//=== Scrivo Dato su archivio AZIENDA
//
//=== parametri : key = nome del campo; key1 = il dato
//
//--- ritorna: 0=ok; 1=KO
//
int k_file
string k_record, k_key, k_key_1
int k_bytes, k_pos_ini = 0, k_lungo = 0
date k_data
long k_long
string k_path
st_profilestring_ini kst_profilestring_ini
st_esito kst_esito


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.st_tab_g_0 = kst_tab_base.st_tab_g_0 
	
//--- x default fa la commit se SQLCODE ok	
	if isnull(kst_esito.st_tab_g_0.esegui_commit) &
	   or len(trim(kst_esito.st_tab_g_0.esegui_commit)) = 0 then
	   kst_esito.st_tab_g_0.esegui_commit = "S"
	end if

	k_key = trim(kst_tab_base.key)
	k_key_1 = trim(kst_tab_base.key1)


	choose case k_key 
			
		case "base_personale", "personale_finestra_inizio" 
			kst_profilestring_ini.utente = ""
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "finestra_inizio"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.finestra_inizio)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Finestra di Inizio' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_nome" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "nome"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.nome)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Nome Utente' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_finestra_inizio" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "finestra_inizio"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.finestra_inizio)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Finestra Iniziale' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_font_alt" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "font_alt"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.font_alt)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Dimensioni Font' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_flag_salva_liste" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "flag_salva_liste"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.font_alt)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Speed Elenco' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_tel" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "tel"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.tel)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Telefono Interno' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_e_mail" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "e_mail"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.e_mail)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'E-mail' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_titolo_main" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "titolo_main"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.titolo_main)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Titolo Procedura' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if
			
		case "finestra_inizio" // programma da lanciare in fase di open della procedura
			kst_profilestring_ini.utente = ""
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "finestra_inizio"
			kst_profilestring_ini.valore = trim(k_key_1)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Finestra di Inizio' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if
//			k_base_pers = 1
//			k_pos_ini = 143
//			k_lungo = 25
			
		case "ult_num_pl_barcode" // 
			k_long = long(trim(k_key_1))
			update base set 
				ult_num_pl_barcode = :k_long
				using sqlca;
			if sqlca.sqlcode = 0 then
				if kst_esito.st_tab_g_0.esegui_commit <> "N" then
					commit using sqlca;
				end if
			else
				kst_esito.esito = "1" 
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = trim(SQLCA.SQLErrText)
			end if
			
		case "barcode_progr_man" // 
			k_long = long(trim(k_key_1))
			update base set 
				barcode_progr_man = :k_long
				using sqlca;
			if sqlca.sqlcode = 0 then
				if kst_esito.st_tab_g_0.esegui_commit <> "N" then
					commit using sqlca;
				end if
			else
				kst_esito.esito = "1" 
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = trim(SQLCA.SQLErrText)
			end if
			
		case "arch_pilota_out"
			k_record = trim(k_key_1)
			update base set 
				fpilota_out_path = :k_record
				using sqlca;
			if sqlca.sqlcode = 0 then
				if kst_esito.st_tab_g_0.esegui_commit <> "N" then
					commit using sqlca;
				end if
			else
				kst_esito.esito = "1" 
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = trim(SQLCA.SQLErrText)
			end if
			
		case "data_ultima_estrazione_pilota_out"
			if isdate(k_key_1) then
				k_data = date(k_key_1)
				update base set 
					fpilota_out_dt_dal = :k_data
					using sqlca;
				if sqlca.sqlcode = 0 then
					if kst_esito.st_tab_g_0.esegui_commit <> "N" then
						commit using sqlca;
					end if
				else
					kst_esito.esito = "1" 
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.SQLErrText = trim(SQLCA.SQLErrText)
				end if
			end if
			
		case "num_certif" // 
			k_long = long(trim(k_key_1))
			update base set 
				num_certif = :k_long
				using sqlca;
			if sqlca.sqlcode = 0 then
				if kst_esito.st_tab_g_0.esegui_commit <> "N" then
					commit using sqlca;
				end if
			else
				kst_esito.esito = "1" 
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = trim(SQLCA.SQLErrText)
			end if
			
	end choose

	
//	if k_base_pers > 0 then	
//
//		
////		k_path = profilestring ( KG_PATH_PROCEDURA + "\confdb.ini", "ambiente", "arch_base", "\.")
//		k_path = trim(kuf1_data_base.profilestring_leggi_scrivi(1, "arch_base", " "))
//		
//		if len(trim(k_path)) = 0 then
//			kst_esito.esito = "1" 
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Archivio Base Non Trovato!!. Uscire dalla Procedura."
//		else			
//		
//			
//			k_file = fileopen( trim(k_path) + "\base.dat", linemode!, read!, lockwrite!)
//			
//			//=== Errore
//			if k_file < 1 then
//				
//				kst_esito.esito = "1" 
//				kst_esito.sqlcode = 0
//				kst_esito.SQLErrText = "Archivio Base Occupato !!. Ripeti l'operazione."
//			
//			else
//			
//			//=== legge il file e lo mette in record
//				k_bytes = fileread(k_file, k_record)
//				if k_bytes = 0 then
//			//=== file da creare lungo 1024 
//					k_bytes = fileclose(k_file)
//					k_file = fileopen(trim(k_path) + "\base.dat", linemode!, write!, lockwrite!, replace!)
//					k_record = space(1024) 
//					k_bytes = filewrite(k_file, k_record)
//				else
//						
//					k_key_1 = k_key_1 + space(k_lungo)
//					k_key_1 = left(k_key_1, k_lungo)
//					
//					k_bytes = fileclose(k_file)
//					k_file = fileopen(trim(k_path) + "\base.dat", linemode!, write!, lockwrite!, replace!)
//					k_record = replace(k_record, k_pos_ini, k_lungo, k_key_1) + space(1024)
//					k_bytes = filewrite(k_file, (left(k_record, 1024)))
//					if k_bytes < 1 then
//						kst_esito.esito = "1" 
//						kst_esito.sqlcode = 0
//						kst_esito.SQLErrText = "Errore durante l'aggiornamento del Base"
//					end if	
//				end if
//	
//				k_bytes = fileclose(k_file)
//			end if
//		end if
//	end if

		
return kst_esito

end function

public function string leggi_base_old ();//
//=== Legge archivio sequenziale BASE
//
int k_file
string k_record, k_return="0"
int k_bytes
string k_path


//k_path = profilestring ( KG_PATH_PROCEDURA + "\confdb.ini", "ambiente", "arch_base", "\at_eco")

k_path = trim(kuf1_data_base.profilestring_leggi_scrivi(1, "arch_base", " "))

if len(trim(k_path)) > 0 then

	k_file = fileopen( trim(k_path) + "\base.dat", linemode!, read!, lockwrite!)
	
	//=== Errore
	if k_file < 1 then
		
		k_return = "1Dati Azienda Occupati !!. Ripeti l'operazione."
	
	else
	
	//=== legge il file e lo mette in record
		k_bytes = fileread(k_file, k_record)
		if k_bytes = 0 then
	//=== file da creare lungo 1024 
			k_bytes = fileclose(k_file)
			k_file = fileopen(trim(k_path) + "\base.dat", linemode!, write!, lockwrite!, replace!)
			k_record = space(1024) 
			k_return = "0" + k_record
			k_bytes = filewrite(k_file, k_record)
		else
			k_return = "0" + k_record
		end if
	
		k_bytes = fileclose(k_file)
	end if

else
	
	k_return = "1Archivio di Configurazione Non Trovato !! - Prego, chiudere la Procedura. ~n~r" &
	           + "Paragrafo cercato: [arch_base]"

end if	
		
return k_return

end function
public function string scrivi_base_old (string k_record_orig, string k_record_new);//
//=== Aggiorna il contatore che contiene i codici disponibili
//=== Input: k_record_orig = dati prima delle modifiche
//===        k_record_new  = dati effettivamente da scrivere sul file
//=== Ritorna: "0"=OK, "1"+spieg errore=ERRORE
//=== Il file contiene nel rek nr. 1 i dati Base della Procedura
//=== 
int k_file 
int k_bytes
string k_return="0 "
string k_record_letto
string k_path


k_path = trim(kuf1_data_base.profilestring_leggi_scrivi(1, "arch_base", " "))

//k_path = profilestring ( "confdb.ini", "ambiente", "arch_base", "\.")

if len(trim(k_path)) > 0 then
	
	k_file = fileopen(trim(k_path) + "\base.dat", linemode!, read!, lockreadwrite!)
	
	if k_file < 1 then
	
		k_return = "1Archivio Non Trovato !! - Rivolgersi al Tecnico. ~n~r" &
						+ "Nome archivio: " + string(k_file) + " - " + trim(k_path) + "\base.dat"
	
	else
	
		k_bytes = fileread(k_file, k_record_letto)
	
		if k_bytes > 0 then
	
			k_file = fileclose(k_file)
	
			if k_file < 1 then
			
				k_return = "1Problemi durante chiusura archivio !! ~n~r" + &
							  "DEVI aggiornare i dati AZIENDA manualmente."
			else				
			
				if trim(k_record_orig) <> trim(k_record_letto) then
					k_return = "1I dati originali sono gia' stati modificati da altro utente!! ~n~r" + &
								  "Operazione di Aggiornamento annullata." + &
								  "Uscire e ripetere l'immissione dei dati."
	
				else
					k_file = fileopen(trim(k_path) + "\base.dat", linemode!, write!, lockreadwrite!, replace!)
					if k_file < 1 then
						k_return = "1Problemi durante apertura archivio !! ~n~r" + &
								  "DEVI aggiornare i dati AZIENDA manualmente."
					else
						k_bytes = filewrite(k_file, k_record_new)
						if k_bytes < 1 then
							k_return = "1Problemi durante Aggiornamento Dati !! ~n~r" + &
									  "DEVI aggiornare i dati AZIENDA manualmente."
						end if
				
						k_file = fileclose(k_file)
					end if	
				end if
			end if
		else
			k_return = "1Problemi durante la Lettura !! ~n~r" + &
							  "DEVI aggiornare i dati AZIENDA manualmente."
	
			k_file = fileclose(k_file)
	
		end if
	
	end if
else
	
	k_return = "1Archivio di Configurazione Non Trovato !! - Prego, chiudere la Procedura. ~n~r" &
	           + "Paragrafo cercato: [arch_base]"

end if	 

return k_return
end function
public function st_esito scrivi_base (st_tab_base kst_tab_base);//
//=== Salvo i Dati Base Personalizzati nel archivio di Configurazione
//
//
st_profilestring_ini kst_profilestring_ini
st_esito kst_esito


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.st_tab_g_0 = kst_tab_base.st_tab_g_0 

	
	choose case trim(kst_tab_base.key) 
			
		case "base_personale", "personale_finestra_inizio" 
			kst_profilestring_ini.utente = ""
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "finestra_inizio"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.finestra_inizio)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Finestra di Inizio' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_nome" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "nome"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.nome)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Nome Utente' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_finestra_inizio" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "finestra_inizio"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.finestra_inizio)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Finestra Iniziale' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_font_alt" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "font_alt"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.font_alt)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Dimensioni Font' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_flag_salva_liste" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "flag_salva_liste"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.font_alt)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Speed Elenco' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_tel" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "tel"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.tel)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Telefono Interno' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_e_mail" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "e_mail"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.e_mail)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'E-mail' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_titolo_main" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "titolo_main"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.titolo_main)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Titolo Procedura' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if
			
			
	end choose

		
return kst_esito

end function
public function st_esito leggi_base (ref st_tab_base kst_tab_base);//
//=== Leggi i Dati Base Personalizzati dall'archivio di Configurazione
//
st_profilestring_ini kst_profilestring_ini
st_esito kst_esito


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.st_tab_g_0 = kst_tab_base.st_tab_g_0 

	
	choose case trim(kst_tab_base.key)
			
		case "base_personale", "personale_finestra_inizio" 
			kst_profilestring_ini.utente = ""
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "finestra_inizio"
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Finestra di Inizio' non registrato. Errore: " &
											  + trim(kst_profilestring_ini.esito)
			end if
			kst_tab_base.st_tab_base_personale.finestra_inizio = trim(kst_profilestring_ini.valore)
			
		case "base_personale", "personale_nome" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "nome"
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Nome Utente' non registrato. Errore: " &
											  + trim(kst_profilestring_ini.esito)
			end if
			kst_tab_base.st_tab_base_personale.nome = trim(kst_profilestring_ini.valore)
	
		case "base_personale", "personale_finestra_inizio" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "finestra_inizio"
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Finestra Iniziale' non registrato. Errore: " &
											  + trim(kst_profilestring_ini.esito)
			end if
			kst_tab_base.st_tab_base_personale.finestra_inizio = trim(kst_profilestring_ini.valore)
	
		case "base_personale", "personale_font_alt" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "font_alt"
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Dimensioni Font' non registrato. Errore: " &
											  + trim(kst_profilestring_ini.esito)
			end if
			kst_tab_base.st_tab_base_personale.font_alt = trim(kst_profilestring_ini.valore)
	
		case "base_personale", "personale_flag_salva_liste" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "flag_salva_liste"
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Speed Elenco' non registrato. Errore: " &
											  + trim(kst_profilestring_ini.esito)
			end if
			kst_tab_base.st_tab_base_personale.flag_salva_liste = trim(kst_profilestring_ini.valore)
	
		case "base_personale", "personale_tel" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "tel"
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Telefono Interno' non registrato. Errore: " &
											  + trim(kst_profilestring_ini.esito)
			end if
			kst_tab_base.st_tab_base_personale.tel = trim(kst_profilestring_ini.valore)
	
		case "base_personale", "personale_e_mail" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "e_mail"
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'E-mail' non registrato. Errore: " &
											  + trim(kst_profilestring_ini.esito)
			end if
			kst_tab_base.st_tab_base_personale.e_mail = trim(kst_profilestring_ini.valore)
	
		case "base_personale", "personale_titolo_main" 
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "titolo_main"
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.esito = kuf1_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = "1" 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Titolo Procedura' non registrato. Errore: " &
											  + trim(kst_profilestring_ini.esito)
			end if
			kst_tab_base.st_tab_base_personale.titolo_main = trim(kst_profilestring_ini.valore)
	
	end choose
	
	
		
return kst_esito

end function
on kuf_base.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_base.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

