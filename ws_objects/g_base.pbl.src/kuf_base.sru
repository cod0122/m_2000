$PBExportHeader$kuf_base.sru
forward
global type kuf_base from nonvisualobject
end type
end forward

global type kuf_base from nonvisualobject
end type
global kuf_base kuf_base

type variables
//
//--- costanti x il valore di ritorno statistici_stato_elab
constant string kci_statistici_stato_ok="0"
constant string kci_statistici_stato_in_esec="1"
constant string kci_statistici_stato_ko="2"
//
////--- Root dei Documenti Elettronici 
//public constant string kki_doc_root_uso_interno = KKG.PATH_SEP + "interno"    //-- x uso interno 
//public constant string kki_doc_root_uso_esterno = KKG.PATH_SEP + "esterno"   //--- x usco esterno tipo WEB
// 
//
//--- costanti spedizione lotto parzialmente Trattato
constant string ddt_blk_lotti_senza_attestato_SI="1"  //permette sped lotti parz.trattati ssolo se in  quarantena
constant string ddt_blk_lotti_senza_attestato_NO="1"  //consente spedizioni anche di lotti parzialmente trattati (quindi senza attestato)

//--- costanti CODICI per la tabella BASE_UTENTI
constant string kki_base_utenti_codice_stcert1 = "stcert1"   // x stampante ATTESTATI pagina 1
constant string kki_base_utenti_codice_stcert2 = "stcert2"   // x stampante ATTESTATI pagine di dettaglio
constant string kki_base_utenti_startfunz = "startfunz"   // window di start della Procedura
constant string kki_base_utenti_flagsuoni = "flag_suoni"   // emissione suoni SI/NO
constant string kki_base_utenti_tel = "tel"   // telefono 
constant string kki_base_utenti_email = "e_mail"   // e_mail 
constant string kki_base_utenti_nome = "nome"   // nome o pseudonimo utente 
constant string kki_base_utenti_titolo_main = "titolo_main"   // titolo 
constant string kki_base_utenti_flagZOOMctrl = "flagzoomctrl"  // S=attiva ZOOM con il CLICK+CTRL


end variables

forward prototypes
public function string check_pwd (string k_pwd)
public function long dammi_rec (ref st_tab_base k_st_tab_base)
public function st_esito scrivi_base (ref st_tab_base kst_tab_base)
public function st_esito leggi_base (ref st_tab_base kst_tab_base)
public function st_esito metti_dato_base (st_tab_base kst_tab_base)
public function string prendi_dato_base (string k_key)
public function st_esito statistici_stato_elab ()
public function string get_titolo_procedura () throws uo_exception
public function boolean if_update_proced_disponibile () throws uo_exception
public function st_esito tb_update_base_smtp (st_tab_base kst_tab_base)
public function st_esito tb_update_base_dir (st_tab_base kst_tab_base)
public function double get_occupazione_pedana (st_tab_base kst_tab_base) throws uo_exception
public function st_esito tb_update_base_fatt (st_tab_base ast_tab_base)
public function string get_version () throws uo_exception
public function boolean if_e1_enabled () throws uo_exception
public function boolean if_e1_enabled (st_tab_base kst_tab_base) throws uo_exception
public function string get_dato_personale (string a_key) throws uo_exception
public function boolean u_open (ref st_open_w ast_open_w)
public function st_esito tb_update_base_gmt (st_tab_base ast_tab_base)
public function boolean get_oralegale (ref st_tab_base kst_tab_base) throws uo_exception
public function integer get_utc_fuso (st_tab_base kst_tab_base) throws uo_exception
public subroutine set_oralegale_utc () throws uo_exception
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
         base.p_iva,   
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
         base.stamp_pdf,   
         base.num_scarico,   
         base.mis_x,   
         base.mis_y,   
         base.mis_z,   
         base.peso_max,   
         base.ult_id_armo,
         base.fgrp_out_path,
         base.fpilota_out_dt_dal,
			base.barcode_dt_no_lav
    INTO :k_st_tab_base.rag_soc_1,   
         :k_st_tab_base.rag_soc_2,   
         :k_st_tab_base.p_iva,   
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
         :k_st_tab_base.stamp_cert2,   
         :k_st_tab_base.stamp_pdf,   
         :k_st_tab_base.num_scarico,   
         :k_st_tab_base.mis_x,   
         :k_st_tab_base.mis_y,   
         :k_st_tab_base.mis_z,   
         :k_st_tab_base.peso_max,   
         :k_st_tab_base.ult_id_armo,   
         :k_st_tab_base.fgrp_out_path,   
         :k_st_tab_base.fpilota_out_dt_dal,   
			:k_st_tab_base.barcode_dt_no_lav
    FROM base  
	 using sqlca;

//	if sqlca.sqlcode >= 0 then
//		k_st_tab_base.p_iva = "IT" + trim(k_st_tab_base.p_iva)
//	end if


return sqlca.sqlcode

end function

public function st_esito scrivi_base (ref st_tab_base kst_tab_base);//
//=== Salvo i Dati Base Personalizzati nel archivio di Configurazione
//
//
string k_rcx
st_profilestring_ini kst_profilestring_ini
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kst_esito.st_tab_g_0 = kst_tab_base.st_tab_g_0 

	kst_tab_base.key = kki_base_utenti_startfunz
	kst_tab_base.key1 = kst_tab_base.st_tab_base_personale.finestra_inizio
	metti_dato_base(kst_tab_base)
	
	kst_tab_base.key = kki_base_utenti_nome
	kst_tab_base.key1 = kst_tab_base.st_tab_base_personale.nome
	metti_dato_base(kst_tab_base)
	
	kst_tab_base.key = kki_base_utenti_flagsuoni
	kst_tab_base.key1 = kst_tab_base.st_tab_base_personale.flag_suoni
	metti_dato_base(kst_tab_base)
	
	kst_tab_base.key = kki_base_utenti_tel
	kst_tab_base.key1 = kst_tab_base.st_tab_base_personale.tel
	metti_dato_base(kst_tab_base)
	
	kst_tab_base.key = kki_base_utenti_email
	kst_tab_base.key1 = kst_tab_base.st_tab_base_personale.e_mail
	metti_dato_base(kst_tab_base)
	
	kst_tab_base.key = kki_base_utenti_titolo_main
	kst_tab_base.key1 = kst_tab_base.st_tab_base_personale.titolo_main
	metti_dato_base(kst_tab_base)
	
			
//	if kst_esito.esito = "0" then
//		kst_profilestring_ini.utente = ""
//		kst_profilestring_ini.file = "base_personale"
//		kst_profilestring_ini.titolo = "conf_personale"
//		kst_profilestring_ini.nome = "finestra_inizio"
//		kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.finestra_inizio)
//		kst_profilestring_ini.operazione = "2"
//		k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//		if kst_profilestring_ini.esito <> "0" then
//			kst_esito.esito = "1" 
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Dato 'Finestra di Inizio' non registrato. Errore: " &
//										  + trim(kst_profilestring_ini.esito)
//		end if
//	end if
//
//	if kst_esito.esito = "0" then
//		kst_profilestring_ini.file = "base_personale"
//		kst_profilestring_ini.titolo = "conf_personale"
//		kst_profilestring_ini.nome = "nome"
//		kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.nome)
//		kst_profilestring_ini.operazione = "2"
//		k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//		if kst_profilestring_ini.esito <> "0" then
//			kst_esito.esito = "1" 
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Dato 'Nome Utente' non registrato. Errore: " &
//										  + trim(kst_profilestring_ini.esito)
//		end if
//	end if
//
////	if kst_esito.esito = "0" then
////		kst_profilestring_ini.file = "base_personale"
////		kst_profilestring_ini.titolo = "conf_personale"
////		kst_profilestring_ini.nome = "font_alt"
////		kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.font_alt)
////		kst_profilestring_ini.operazione = "2"
////		k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
////		if kst_profilestring_ini.esito <> "0" then
////			kst_esito.esito = "1" 
////			kst_esito.sqlcode = 0
////			kst_esito.SQLErrText = "Dato 'Dimensioni Font' non registrato. Errore: " &
////										  + trim(kst_profilestring_ini.esito)
////		end if
////	end if
//
//	if kst_esito.esito = "0" then
//		kst_profilestring_ini.file = "base_personale"
//		kst_profilestring_ini.titolo = "conf_personale"
//		kst_profilestring_ini.nome = "flag_salva_liste"
//		kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.flag_salva_liste)
//		kst_profilestring_ini.operazione = "2"
//		k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//		if kst_profilestring_ini.esito <> "0" then
//			kst_esito.esito = "1" 
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Dato 'Speed Elenco' non registrato. Errore: " &
//										  + trim(kst_profilestring_ini.esito)
//		end if
//	end if
//
//	if kst_esito.esito = "0" then
//		kst_profilestring_ini.file = "base_personale"
//		kst_profilestring_ini.titolo = "conf_personale"
//		kst_profilestring_ini.nome = "flag_suoni"
//		kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.flag_suoni)
//		kst_profilestring_ini.operazione = "2"
//		k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//		if kst_profilestring_ini.esito <> "0" then
//			kst_esito.esito = "1" 
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Dato 'flag_suoni' non registrato. Errore: " &
//										  + trim(kst_profilestring_ini.esito)
//		end if
//	end if
//
//	if kst_esito.esito = "0" then
//		kst_profilestring_ini.file = "base_personale"
//		kst_profilestring_ini.titolo = "conf_personale"
//		kst_profilestring_ini.nome = "tel"
//		kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.tel)
//		kst_profilestring_ini.operazione = "2"
//		k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//		if kst_profilestring_ini.esito <> "0" then
//			kst_esito.esito = "1" 
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Dato 'Telefono Interno' non registrato. Errore: " &
//										  + trim(kst_profilestring_ini.esito)
//		end if
//	end if
//
//	if kst_esito.esito = "0" then
//		kst_profilestring_ini.file = "base_personale"
//		kst_profilestring_ini.titolo = "conf_personale"
//		kst_profilestring_ini.nome = "e_mail"
//		kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.e_mail)
//		kst_profilestring_ini.operazione = "2"
//		k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//		if kst_profilestring_ini.esito <> "0" then
//			kst_esito.esito = "1" 
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Dato 'E-mail' non registrato. Errore: " &
//										  + trim(kst_profilestring_ini.esito)
//		end if
//	end if
//
//	if kst_esito.esito = "0" then
//		kst_profilestring_ini.file = "base_personale"
//		kst_profilestring_ini.titolo = "conf_personale"
//		kst_profilestring_ini.nome = "titolo_main"
//		kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.titolo_main)
//		kst_profilestring_ini.operazione = "2"
//		k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//		if kst_profilestring_ini.esito <> "0" then
//			kst_esito.esito = "1" 
//			kst_esito.sqlcode = 0
//			kst_esito.SQLErrText = "Dato 'Titolo Procedura' non registrato. Errore: " &
//										  + trim(kst_profilestring_ini.esito)
//		end if
//	end if
			
		
return kst_esito

end function

public function st_esito leggi_base (ref st_tab_base kst_tab_base);//
//=== Leggi i Dati Base Personalizzati dall'archivio di Configurazione
//
string k_rcx
st_profilestring_ini kst_profilestring_ini
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kst_esito.st_tab_g_0 = kst_tab_base.st_tab_g_0 

	kst_tab_base.st_tab_base_personale.finestra_inizio = get_dato_personale(kki_base_utenti_startfunz)
	kst_tab_base.st_tab_base_personale.nome = get_dato_personale(kki_base_utenti_nome )
//	kst_tab_base.st_tab_base_personale.flag_salva_liste = get_dato_personale(kki_base_utenti_flag_salvaliste )
	kst_tab_base.st_tab_base_personale.flag_suoni = get_dato_personale(kki_base_utenti_flagsuoni )
	kst_tab_base.st_tab_base_personale.tel = get_dato_personale(kki_base_utenti_tel )
	kst_tab_base.st_tab_base_personale.e_mail = get_dato_personale(kki_base_utenti_email )
	kst_tab_base.st_tab_base_personale.titolo_main = get_dato_personale(kki_base_utenti_titolo_main )

	kst_tab_base.st_tab_base_personale.stcert1 = get_dato_personale(kki_base_utenti_codice_stcert1)
	kst_tab_base.st_tab_base_personale.stcert2 = get_dato_personale(kki_base_utenti_codice_stcert2)
	
	kst_tab_base.st_tab_base_personale.flag_ZOOM_ctrl = get_dato_personale(kki_base_utenti_flagZOOMctrl)

//--- per i campi vuoti prova nel confdb.ini
if kst_tab_base.st_tab_base_personale.finestra_inizio > " " then
else
	kst_profilestring_ini.utente = ""
	kst_profilestring_ini.file = "base_personale"
	kst_profilestring_ini.titolo = "conf_personale"
	kst_profilestring_ini.nome = "finestra_inizio"
	kst_profilestring_ini.operazione = "1"
	k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
	if kst_profilestring_ini.esito <> "0" then
		kst_esito.esito = "1" 
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Dato 'Finestra di Inizio' non registrato. Errore: " &
									  + trim(kst_profilestring_ini.esito)
	end if
	kst_tab_base.st_tab_base_personale.finestra_inizio = trim(kst_profilestring_ini.valore)
end if

if kst_tab_base.st_tab_base_personale.nome > " " then
else
	kst_profilestring_ini.file = "base_personale"
	kst_profilestring_ini.titolo = "conf_personale"
	kst_profilestring_ini.nome = "nome"
	kst_profilestring_ini.operazione = "1"
	k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
	if kst_profilestring_ini.esito <> "0" then
		kst_esito.esito = "1" 
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Dato 'Nome Utente' non registrato. Errore: " &
									  + trim(kst_profilestring_ini.esito)
	end if
	kst_tab_base.st_tab_base_personale.nome = trim(kst_profilestring_ini.valore)
end if
	

if kst_tab_base.st_tab_base_personale.flag_suoni > " " then
else
	kst_profilestring_ini.file = "base_personale"
	kst_profilestring_ini.titolo = "conf_personale"
	kst_profilestring_ini.nome = "flag_suoni"
	kst_profilestring_ini.operazione = "1"
	k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
	if kst_profilestring_ini.esito <> "0" then
		kst_esito.esito = "1" 
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Dato 'Attiva Suoni' non registrato. Errore: " &
									  + trim(kst_profilestring_ini.esito)
	end if
	if len(trim(kst_profilestring_ini.valore)) = 0 then
		kst_tab_base.st_tab_base_personale.flag_suoni = "N"
	else
		kst_tab_base.st_tab_base_personale.flag_suoni = trim(kst_profilestring_ini.valore)
	end if
end if
	
if kst_tab_base.st_tab_base_personale.tel > " " then
else
	kst_profilestring_ini.file = "base_personale"
	kst_profilestring_ini.titolo = "conf_personale"
	kst_profilestring_ini.nome = "tel"
	kst_profilestring_ini.operazione = "1"
	k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
	if kst_profilestring_ini.esito <> "0" then
		kst_esito.esito = "1" 
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Dato 'Telefono Interno' non registrato. Errore: " &
									  + trim(kst_profilestring_ini.esito)
	end if
	kst_tab_base.st_tab_base_personale.tel = trim(kst_profilestring_ini.valore)
end if

if kst_tab_base.st_tab_base_personale.e_mail > " " then
else
	kst_profilestring_ini.file = "base_personale"
	kst_profilestring_ini.titolo = "conf_personale"
	kst_profilestring_ini.nome = "e_mail"
	kst_profilestring_ini.operazione = "1"
	k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
	if kst_profilestring_ini.esito <> "0" then
		kst_esito.esito = "1" 
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Dato 'E-mail' non registrato. Errore: " &
									  + trim(kst_profilestring_ini.esito)
	end if
	kst_tab_base.st_tab_base_personale.e_mail = trim(kst_profilestring_ini.valore)
end if

if kst_tab_base.st_tab_base_personale.titolo_main > " " then
else
	kst_profilestring_ini.file = "base_personale"
	kst_profilestring_ini.titolo = "conf_personale"
	kst_profilestring_ini.nome = "titolo_main"
	kst_profilestring_ini.operazione = "1"
	k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
	if kst_profilestring_ini.esito <> "0" then
		kst_esito.esito = "1" 
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Dato 'Titolo Procedura' non registrato. Errore: " &
									  + trim(kst_profilestring_ini.esito)
	end if
	kst_tab_base.st_tab_base_personale.titolo_main = trim(kst_profilestring_ini.valore)
end if

catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

end try
		
return kst_esito

end function

public function st_esito metti_dato_base (st_tab_base kst_tab_base);//
//=== Scrivo Dato su archivio AZIENDA
//
//=== parametri : key = nome del campo; key1 = il dato
//
//--- ritorna: 0=ok; 1=KO
//
//--- ESEMPIO:
//		kuf1_base = create kuf_base 
//		kst_tab_base.st_tab_g_0.esegui_commit = "S"
//		kst_tab_base.key = "barcode_progr_man"
//		kst_tab_base.key1 = string(k_barcode_progr)
//		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
//		destroy kuf1_base 
//
//
//---------------------------------------------------------------------------------------------------------------------------------
int k_file
string k_record, k_key, k_key_1
int k_bytes, k_pos_ini = 0, k_lungo = 0
date k_data
long k_long
string k_path
double k_double
boolean k_riga_su_db = true
st_profilestring_ini kst_profilestring_ini
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kst_esito.st_tab_g_0 = kst_tab_base.st_tab_g_0 
	
//--- x default fa la commit se SQLCODE ok	
	if isnull(kst_esito.st_tab_g_0.esegui_commit) &
	   or len(trim(kst_esito.st_tab_g_0.esegui_commit)) = 0 then
	   kst_esito.st_tab_g_0.esegui_commit = "S"
	end if

	k_key = trim(kst_tab_base.key)
	if isnull(kst_tab_base.key1) then
		k_key_1 = ""
	else
		k_key_1 = trim(kst_tab_base.key1)
	end if


	choose case k_key 
			
//		case "base_personale", "personale_finestra_inizio" 
//			k_riga_su_db = false
//			kst_profilestring_ini.utente = ""
//			kst_profilestring_ini.file = "base_personale"
//			kst_profilestring_ini.titolo = "conf_personale"
//			kst_profilestring_ini.nome = "finestra_inizio"
//			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.finestra_inizio)
//			kst_profilestring_ini.operazione = "2"
//			kst_profilestring_ini.esito = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//			if kst_profilestring_ini.esito <> "0" then
//				kst_esito.esito = kkg_esito.db_ko 
//				kst_esito.sqlcode = 0
//				kst_esito.SQLErrText = "Dato 'Finestra di Inizio' non registrato. Errore: " &
//				                       + trim(kst_profilestring_ini.esito)
//			end if
//
//		case "base_personale", "personale_nome" 
//			k_riga_su_db = false
//			kst_profilestring_ini.file = "base_personale"
//			kst_profilestring_ini.titolo = "conf_personale"
//			kst_profilestring_ini.nome = "nome"
//			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.nome)
//			kst_profilestring_ini.operazione = "2"
//			kst_profilestring_ini.esito = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//			if kst_profilestring_ini.esito <> "0" then
//				kst_esito.esito = kkg_esito.db_ko 
//				kst_esito.sqlcode = 0
//				kst_esito.SQLErrText = "Dato 'Nome Utente' non registrato. Errore: " &
//				                       + trim(kst_profilestring_ini.esito)
//			end if

		case "base_personale", "ultimo_utente_login_nome" 
			k_riga_su_db = false
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "ultimo_utente_login_nome"
			kst_profilestring_ini.valore = trim(k_key_1)
			kst_profilestring_ini.operazione = "2"
			if kst_profilestring_ini.valore <> "MASTER" then   //ECCEZIONE evito di udp se utente speciale
				kst_profilestring_ini.esito = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
				if kst_profilestring_ini.esito <> "0" then
					kst_esito.esito = kkg_esito.db_ko 
					kst_esito.sqlcode = 0
					kst_esito.SQLErrText = "Dato 'Nome Ultimo Utente Acceduto' non registrato. Errore: " &
												  + trim(kst_profilestring_ini.esito)
				end if
			end if

		case "base_personale", "ultimo_utente_login_data" 
			k_riga_su_db = false
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "ultimo_utente_login_data"
			kst_profilestring_ini.valore = trim(k_key_1)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Data Ultimo Accesso' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

		case "base_personale", "personale_font_alt" 
			k_riga_su_db = false
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "font_alt"
			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.font_alt)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato 'Dimensioni Font' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if

//		case "base_personale", "personale_flag_salva_liste" 
//			k_riga_su_db = false
//			kst_profilestring_ini.file = "base_personale"
//			kst_profilestring_ini.titolo = "conf_personale"
//			kst_profilestring_ini.nome = "flag_salva_liste"
//			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.font_alt)
//			kst_profilestring_ini.operazione = "2"
//			kst_profilestring_ini.esito = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//			if kst_profilestring_ini.esito <> "0" then
//				kst_esito.esito = kkg_esito.db_ko 
//				kst_esito.sqlcode = 0
//				kst_esito.SQLErrText = "Dato 'Speed Elenco' non registrato. Errore: " &
//				                       + trim(kst_profilestring_ini.esito)
//			end if
//
//		case "base_personale", "personale_tel" 
//			k_riga_su_db = false
//			kst_profilestring_ini.file = "base_personale"
//			kst_profilestring_ini.titolo = "conf_personale"
//			kst_profilestring_ini.nome = "tel"
//			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.tel)
//			kst_profilestring_ini.operazione = "2"
//			kst_profilestring_ini.esito = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//			if kst_profilestring_ini.esito <> "0" then
//				kst_esito.esito = kkg_esito.db_ko 
//				kst_esito.sqlcode = 0
//				kst_esito.SQLErrText = "Dato 'Telefono Interno' non registrato. Errore: " &
//				                       + trim(kst_profilestring_ini.esito)
//			end if
//
//		case "base_personale", "personale_e_mail" 
//			k_riga_su_db = false
//			kst_profilestring_ini.file = "base_personale"
//			kst_profilestring_ini.titolo = "conf_personale"
//			kst_profilestring_ini.nome = "e_mail"
//			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.e_mail)
//			kst_profilestring_ini.operazione = "2"
//			kst_profilestring_ini.esito = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//			if kst_profilestring_ini.esito <> "0" then
//				kst_esito.esito = kkg_esito.db_ko 
//				kst_esito.sqlcode = 0
//				kst_esito.SQLErrText = "Dato 'E-mail' non registrato. Errore: " &
//				                       + trim(kst_profilestring_ini.esito)
//			end if
//
//		case "base_personale", "personale_titolo_main" 
//			k_riga_su_db = false
//			kst_profilestring_ini.file = "base_personale"
//			kst_profilestring_ini.titolo = "conf_personale"
//			kst_profilestring_ini.nome = "titolo_main"
//			kst_profilestring_ini.valore = trim(kst_tab_base.st_tab_base_personale.titolo_main)
//			kst_profilestring_ini.operazione = "2"
//			kst_profilestring_ini.esito = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//			if kst_profilestring_ini.esito <> "0" then
//				kst_esito.esito = kkg_esito.db_ko 
//				kst_esito.sqlcode = 0
//				kst_esito.SQLErrText = "Dato 'Titolo Procedura' non registrato. Errore: " &
//				                       + trim(kst_profilestring_ini.esito)
//			end if
//			
//		case "finestra_inizio" // programma da lanciare in fase di open della procedura
//			k_riga_su_db = false
//			kst_profilestring_ini.utente = ""
//			kst_profilestring_ini.file = "base_personale"
//			kst_profilestring_ini.titolo = "conf_personale"
//			kst_profilestring_ini.nome = "finestra_inizio"
//			kst_profilestring_ini.valore = trim(k_key_1)
//			kst_profilestring_ini.operazione = "2"
//			kst_profilestring_ini.esito = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//			if kst_profilestring_ini.esito <> "0" then
//				kst_esito.esito = kkg_esito.db_ko 
//				kst_esito.sqlcode = 0
//				kst_esito.SQLErrText = "Dato 'Finestra di Inizio' non registrato. Errore: " &
//				                       + trim(kst_profilestring_ini.esito)
//			end if

// ultimo Lotto caricato
		case "num_int" 
			k_long = long(trim(k_key_1))
			update base set 
				num_int = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
		case "data_int" 
			k_data = date(k_key_1)
			update base set 
				data_int = :k_data
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "ult_num_pl_barcode" // 
			k_long = long(trim(k_key_1))
			update base set 
				ult_num_pl_barcode = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "barcode_pref" // 
			k_key_1 = trim(k_key_1)
			update base set 
				barcode_pref = :k_key_1
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
		case "barcode_progr" // 
			k_long = long(trim(k_key_1))
			update base set 
				barcode_progr = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "barcode_progr_man" // 
			k_long = long(trim(k_key_1))
			update base set 
				barcode_progr_man = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "path_file_groupage"
			k_record = trim(k_key_1)
			update base set 
				fgrp_out_path = :k_record
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "data_ultima_estrazione_pilota_out"
			if isdate(k_key_1) then
				k_data = date(k_key_1)
				update base set 
					fpilota_out_dt_dal = :k_data
					using kguo_sqlca_db_magazzino;
				if kguo_sqlca_db_magazzino.sqlcode = 0 then
				else
					kst_esito.esito = kkg_esito.db_ko 
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
				end if
			end if
			
		case "ora_ultima_estrazione_pilota_out"
			if istime(k_key_1) then
				update base set 
					fpilota_out_ora_dal = :k_key_1
					using kguo_sqlca_db_magazzino;
				if kguo_sqlca_db_magazzino.sqlcode = 0 then
				else
					kst_esito.esito = kkg_esito.db_ko 
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
				end if
			end if
			
		case "num_certif" // 
			k_long = long(trim(k_key_1))
			update base set 
				num_certif = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "barcode_dt_no_lav" // 
			k_data = date(k_key_1)
			update base set 
				barcode_dt_no_lav = :k_data
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
//--- Ultima fattura
		case "num_fatt" 
			k_long = long(k_key_1)
			update base set 
				num_fatt = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
		case "data_fatt" 
			k_data = date(k_key_1)
			update base set 
				data_fatt = :k_data
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if

//--- Ultimo DDT uscito
		case "num_bolla_out" // ultimo numero di DDT
			k_long = long(k_key_1)
			update base set 
				num_bolla = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
		case "data_bolla_out" 
			k_data = date(k_key_1)
			update base set 
				data_bolla = :k_data
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "num_fatt_stamp" // ultimo numero di fattura Stampata
			k_long = long(k_key_1)
			update base set 
				num_fatt_stamp = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "data_fatt_stamp" // ultima data fattura di Stampa
			k_data = date(k_key_1)
			update base set 
				data_fatt_stamp = :k_data
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "fatt_bolli_lim_stampa" // limite importo fattura oltre il quale esporre le norme dei bolli
			k_double = double(k_key_1)
			update base_fatt set 
				bolli_lim_stampa = :k_double
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "fatt_bolli_note" //norme Bolli da esporre in fattura
			k_record = trim(k_key_1)
			update base_fatt set 
				bolli_note = :k_record
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "fatt_banca" //Banca da esporre in fattura
			k_record = trim(k_key_1)
			update base_fatt set 
				banca = :k_record
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "impon_minimo" // limite imponibile di fatturazione
			k_double = double(k_key_1)
			update base_fatt set 
				impon_minimo = :k_double
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "num_ddt_stamp" // ultimo numero di ddt Stampato
			k_long = long(k_key_1)
			update base set 
				NUM_BOLLA_STAMP = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
			
		case "data_ddt_stamp" // ultima data ddt di Stampa
			k_data = date(k_key_1)
			update base set 
				DATA_BOLLA_STAMP = :k_data
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if

//--- Dosimetro
		case "dosimetro_barcode_mask" // i primi 3 char del barcode dosimetro
			k_record = trim(k_key_1)
			update base set 
				dosimetro_barcode_mask = :k_record
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
		case "dosimetro_ult_barcode" // suffisso (2 char + 3 num) barcode dosimetro
			k_record = trim(k_key_1)
			update base set 
				dosimetro_ult_barcode = :k_record
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
		case "dosimetro_id_armo" // id della riga lotto da 'scaricare'
			k_long = long(k_key_1)
			update base set 
				dosimetro_id_armo = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if

//--- Registro Articolo 50			
		case "art50_anno" // dati Registro Art.50
			k_long = long(k_key_1)
			update base_fatt set 
				art50_anno = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
		case "art50_mese" // dati Registro Art.50
			k_long = long(k_key_1)
			update base_fatt set 
				art50_mese = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
		case "art50_ult_nrpagina" // dati Registro Art.50
			k_long = long(k_key_1)
			update base_fatt set 
				art50_ult_nrpagina = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
		case "art50_ult_nrprot" // dati Registro Art.50
			k_long = long(k_key_1)
			update base_fatt set 
				art50_ult_nrprot = :k_long
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
		case "art50_nazioni_gruppo" // dati Registro Art.50
			k_record = trim(k_key_1)
			update base_fatt set 
				art50_nazioni_gruppo = :k_record
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if
		case "art50_id_nazione_esclusa" // dati Registro Art.50
			k_record = trim(k_key_1)
			update base_fatt set 
				art50_id_nazione_esclusa = :k_record
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if

//--- dati in tab BASE_UTENTI
		case kki_base_utenti_codice_stcert1  & 
				,kki_base_utenti_codice_stcert2 &
				,kki_base_utenti_startfunz &
				,kki_base_utenti_flagsuoni & 
				,kki_base_utenti_tel &
				,kki_base_utenti_email &
				,kki_base_utenti_nome &
				,kki_base_utenti_flagZOOMctrl
				
			k_long = kguo_utente.get_id_utente( )
			//--- update o insert?
			k_record = ""
			select valore
			   into :k_record
				from base_utenti
				where id_base = :kguo_g.id_base
				    and id_utente = :k_long
					 and codice = :k_key
				using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				update base_utenti set 
					valore = :k_key_1
					where id_base = :kguo_g.id_base
						 and id_utente = :k_long
						 and codice = :k_key
					using kguo_sqlca_db_magazzino;
			else
				insert into base_utenti  
					(
					id_base
					,id_utente
					,codice
					,valore 
					)
					values
					(
					:kguo_g.id_base
					,:k_long
					,:k_key
					,:k_key_1
					)
					using kguo_sqlca_db_magazzino;
			end if
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
			else
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore aggiornamento proprietà Utente: " + k_key + " con il valore " + trim(k_key_1) + trim(kguo_sqlca_db_magazzino.SQLErrText)
			end if

			
		case else
//--- altrimenti lo salvo come parametro INI			
			k_riga_su_db = false
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = kst_tab_base.key
			kst_profilestring_ini.valore = trim(kst_tab_base.key1)
			kst_profilestring_ini.operazione = "2"
			kst_profilestring_ini.esito = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_esito.esito = kkg_esito.db_ko 
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Dato " + kst_tab_base.key + " con valore '" + trim(kst_tab_base.key1) + "' non registrato. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if
			
	end choose

//--- se aggiornato il DB devo fare la COMMIT
	if k_riga_su_db then
		
		if kst_tab_base.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_base.st_tab_g_0.esegui_commit) then
			if kguo_sqlca_db_magazzino.sqlcode >= 0 then
				kguo_sqlca_db_magazzino.db_commit( )
			else
				kguo_sqlca_db_magazzino.db_rollback( )
			end if
		end if
	
	end if
	
		
return kst_esito

end function

public function string prendi_dato_base (string k_key);//
//----------------------------------------------------------------------------------------------------------------------------------
//--- Legge archivio sequenziale BASE restituendo un valore 
//---
//--- ritorna char 1 : 0=ok; 1=errore
//---             2-...: valore  
//---
//---  ESEMPIO DI CHIAMATA:
//---
//			string k_esito=""
//			kuf1_base = create kuf_base
//			k_esito = kuf1_base.prendi_dato_base( "num_int")
//			if left(k_esito,1) <> "0" then
//				kst_esito.nome_oggetto = this.classname()
//				kst_esito.esito = kkg_esito.db_ko  
//				kst_esito.sqlcode = 0
//				kst_esito.SQLErrText = mid(k_esito,2)
//			else
//				kst_tab_meca.num_int	= long(mid(k_esito,2))
//			end if
//			destroy kuf1_base
//---
//----------------------------------------------------------------------------------------------------------------------------------
//
int k_file
string k_record, k_record1, k_return = " ", k_stato, k_errore = ""
int k_bytes, k_pos_ini = 0, k_lungo = 0, k_anno, k_rcn
string k_path, k_descr, k_rcx, k_flag=""
date k_data, k_dataoggi
long k_long
double k_num1, k_num2, k_num3, k_double
ulong k_ulong 
boolean k_boolean, k_dati_no_da_db, k_trim_no
string k_Version, k_Level, k_MajorVersion, k_MinorVersion, k_ProductBuild, k_Edition, k_EngineEdition, k_name, k_server_id, k_provider
datastore kds
st_tab_base_utenti kst_tab_base_utenti
st_profilestring_ini kst_profilestring_ini
st_stampante kst_stampante 
st_esito kst_esito
kuf_stampe kuf1_stampe 

//	if not isvalid(kguo_sqlca_db_magazzino) then
//		kguo_sqlca_db_magazzino = sqlca
//	end if
	
	kguo_sqlca_db_magazzino.sqlcode = 0
	k_stato = "0" 
	
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
			k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				k_stato = "1"
				k_errore = "Dato 'Nome Utente' non disponibile. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if
			k_record = trim(kst_profilestring_ini.valore)
			k_pos_ini = 1
			k_lungo = len(k_record)


//--- prendo il nome utente windows
		case "utente_login"
			k_ulong = 255
			k_record = space(k_ulong)
			k_boolean = GetUserNameA ( k_record, k_ulong )
			if k_boolean then
				k_record = trim(k_record)
			else
				k_stato = "1" 
				k_record = " "
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)

			
		case "ultimo_utente_login_nome" 
			kst_profilestring_ini.utente = ""
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "ultimo_utente_login_nome"
//			kst_profilestring_ini.valore = trim(k_key_1)
			kst_profilestring_ini.operazione = "1"
			k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_profilestring_ini.valore = " "
//				kst_esito.esito = "1" 
//				kst_esito.sqlcode = 0
//				kst_esito.SQLErrText = 
				k_stato = "1"
	         	k_errore = "Dato 'Nome Ultimo Utente di Accesso' non disponibile. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if
			k_record = trim(kst_profilestring_ini.valore)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
			
		case "ultimo_utente_login_data" 
			kst_profilestring_ini.utente = ""
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "ultimo_utente_login_data"
//			kst_profilestring_ini.valore = trim(k_key_1)
			kst_profilestring_ini.operazione = "1"
			k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_profilestring_ini.valore = string(date(0))
				k_stato = "1"
				k_errore = "Dato 'Data Ultimo Accesso' non disponibile. Errore: " &
												  + trim(kst_profilestring_ini.esito)
			end if
			k_record = trim(kst_profilestring_ini.valore)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
//--- 26052016: attivazione E-ONE 			
		case "e1_enabled"
			select e1_enabled
				 into :k_record
				 from base;
			if trim(k_record) > " " then
			else
				k_record = ""
			end if
			k_pos_ini = 1
			k_lungo = len(trim(k_record))
			
		case "num_int"
			select num_int
				 into :k_long
				 from base;
			if isnull(k_long) then
				k_long = 0
			end if
			k_record = string(k_long)
			k_pos_ini = 1
			k_lungo = len(trim(k_record))
		case "data_int"
			select data_int
				 into :k_data
				 from base;
			k_record = string(k_data)
			if isnull(k_record) or k_data <= date(0) then
				k_dataoggi = kguo_g.get_dataoggi( )
				k_record = string(k_dataoggi)
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "titolo" 
			select titolo_procedura
				 into :k_record
				 from base using kguo_sqlca_db_magazzino;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then	 
				k_record = trim(k_record)
				if isnull(k_record) then
					k_record = "Nessun Titolo"
				end if
			else
				k_stato = "1"
				k_record = "Errore:" + kguo_sqlca_db_magazzino.sqlerrtext
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
				k_anno = kguo_g.get_anno( )
			end if
			k_record = string(k_anno, "0000")
			k_pos_ini = 1
			k_lungo = 4

//--- stampante codice a barre			
		case "stamp_cbarre"
			select stamp_cbarre
				 into :k_record
				 from base;
			if isnull(k_record) then
				k_record = " "
			else
				kuf1_stampe = create kuf_stampe
				kst_stampante.trova = trim(k_record)
				k_boolean = kuf1_stampe.u_dammi_stampante(kst_stampante)
				destroy kuf1_stampe
				if k_boolean then
					k_record = trim(kst_stampante.nome)
//				else
//					k_record = " "
				end if
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)

//--- stampante Attestati pagina 1	
		case "stamp_attestato"
			select stamp_cert
				 into :k_record
				 from base;
			if isnull(k_record) then
				k_record = " "
				k_stato = "1"
			else
				kuf1_stampe = create kuf_stampe
				kst_stampante.trova = trim(k_record)
				k_boolean = kuf1_stampe.u_dammi_stampante(kst_stampante)
				destroy kuf1_stampe
				if k_boolean then
					k_record = trim(kst_stampante.nome)
//				else
//					k_record = " "
				end if
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
//--- stampante Attestato pagine allegati			
		case "stamp_attestato2"
			select stamp_ft
				 into :k_record
				 from base;
			if isnull(k_record) then
				k_record = " "
				k_stato = "1"
			else
				kuf1_stampe = create kuf_stampe
				kst_stampante.trova = trim(k_record)
				k_boolean = kuf1_stampe.u_dammi_stampante(kst_stampante)
				destroy kuf1_stampe
				if k_boolean then
					k_record = trim(kst_stampante.nome)
//				else
//					k_record = " "
				end if
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)

//--- stampante DDT
		case "stamp_ddt"
			select stamp_bo
				 into :k_record
				 from base;
			if isnull(k_record) then
				k_record = " "
				k_stato = "1"
			else
				kuf1_stampe = create kuf_stampe
				kst_stampante.trova = trim(k_record)
				k_boolean = kuf1_stampe.u_dammi_stampante(kst_stampante)
				destroy kuf1_stampe
				if k_boolean then
					k_record = trim(kst_stampante.nome)
//				else
//					k_record = " "
				end if
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
//--- Ultimo Numero+Data DDT registrato		
		case "numdata_ddt"
			k_record = "0"
			select num_bolla
			          ,data_bolla
				into :k_long
				       , :k_data
				 from base
				 using kguo_sqlca_db_magazzino ;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				k_record = string(k_long, "000000000000") + "/" + string(k_data)
				if isnull(k_record) then
					k_record = "/"
				end if
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
//--- Ultimo Numero DDT	+ data registrato		
		case "num_bolla_out"
			k_record = "0"
			select num_bolla
				into :k_long
				 from base
				 using kguo_sqlca_db_magazzino ;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				k_record = string(k_long, "000000000000")
				if isnull(k_record) then
					k_record = "0"
				end if
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
//--- Ultimo data DDT	registrato		
		case "data_bolla_out"
			select data_bolla
				 into :k_data
				 from base;
			k_record = string(k_data)
			if isnull(k_record) then
				k_record = string(kguo_g.get_dataoggi())
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
//--- Ultimo Numero Fatture	registrato		
		case "num_fatt"
			select num_fatt
				 into :k_long
				 from base;
			k_record = string(k_long, "000000000000")
			if isnull(k_record) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
//--- Ultimo data DDT	registrato		
		case "data_fatt"
			select data_fatt
				 into :k_data
				 from base;
			k_record = string(k_data)
			if isnull(k_record) then
				k_record = string(kguo_g.get_dataoggi())
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)

//--- stampante Fatture			
		case "stamp_fattura"
			k_record = " "
//			select stamp_ft
//				 into :k_record
//				 from base;
//			if isnull(k_record) then
//				k_record = " "
//				k_stato = "1"
//			else
//				kuf1_stampe = create kuf_stampe
//				kst_stampante.trova = trim(k_record)
//				k_boolean = kuf1_stampe.u_dammi_stampante(kst_stampante)
//				destroy kuf1_stampe
//				if k_boolean then
//					k_record = trim(kst_stampante.nome)
//				else
//					k_record = " "
//				end if
//			end if
//			k_record = trim(k_record)
//			k_pos_ini = 1
//			k_lungo = len(k_record)

//--- stampante PDF			
		case "stamp_pdf"
			select stamp_pdf
				 into :k_record
				 from base;
			if isnull(k_record) then
				k_record = " "
				k_stato = "1"
//			else
//				kuf1_stampe = create kuf_stampe
//				kst_stampante.trova = trim(k_record)
//				k_boolean = kuf1_stampe.u_dammi_stampante(kst_stampante)
//				destroy kuf1_stampe
//				if k_boolean then
//					k_record = trim(kst_stampante.nome)
//				else
//					k_record = " "
//				end if
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
			k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				k_stato = "1"
				k_errore = "Dato 'Dimensione Font' non disponibile. Errore: " &
				                       + trim(kst_profilestring_ini.esito)
			end if
			k_record = trim(kst_profilestring_ini.valore)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
//		case "catfi"
//			k_dati_no_da_db = false
//			k_pos_ini = 159
//			k_lungo = 5
			
		case "flag_salva_liste" 
			kst_profilestring_ini.utente = ""
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = "flag_salva_liste"
//			kst_profilestring_ini.valore = trim(k_key_1)
			kst_profilestring_ini.operazione = "1"
			k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <> "0" then
				kst_profilestring_ini.valore = "S"
//				kst_esito.esito = "1" 
//				kst_esito.sqlcode = 0
//				kst_esito.SQLErrText = 
				k_stato = "1"
				k_errore = "Dato 'Indicatore di Speed Elenco' non disponibile. Errore: " &
												  + trim(kst_profilestring_ini.esito)
			end if
			k_record = trim(kst_profilestring_ini.valore)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "dataoggi"
			k_record = string(kguo_g.get_dataoggi( ))
			k_pos_ini = 1
			k_lungo = len(trim(k_record))
			
		case "ora"
			k_record = string(kguo_g.get_ora())
			k_pos_ini = 1
			k_lungo = len(trim(k_record))
			
		case "descr_ultima_estrazione_statistici"
			select data_stat, ora_stat
				 into :k_data, :k_descr
				 from base;
			if isnull(k_data) or isnull(k_descr) or len(trim(k_descr)) = 0 then
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
			
		case "barcode_progr"
			select barcode_progr
				 into :k_long
				 from base;
			k_record = string(k_long, "00000")
			if isnull(k_record) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "barcode_pref"
			select barcode_pref
				 into :k_record
				 from base;
			if isnull(k_record) or len(k_record) = 0 then
				k_record = ""
			else
				k_record = trim(k_record)
			end if
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
			
		case "path_file_groupage"
			select fgrp_out_path
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
			
		case "ora_ultima_estrazione_pilota_out"
			select fpilota_out_ora_dal
				 into :k_record
				 from base;
			k_record = trim(k_record)
			if isnull(k_record) or len(k_record) = 0 then
				k_record = " "
			end if
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
				 into :k_num1
				 from base;
			k_record = string(k_num1)
			if isnull(k_record) or len(k_record) = 0 then
				k_record = "0"
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

		case "barcode_dt_no_lav"
			select barcode_dt_no_lav
				 into :k_data
				 from base;
			if isnull(k_data) then
				k_record = string(date(0))
			else
				k_record = string(k_data, "dd/mm/yyyy")
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "valid_tolleranza_dose_min"
			select valid_t_dose_min
				 into :k_record
				 from base;
			k_record = trim(k_record)
			if isnull(k_record) or len(k_record) = 0 then
				k_record = " "
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "barcode_modulo"
			select barcode_modulo
				 into :k_record
				 from base;
			k_record = trim(k_record)
			if isnull(k_record) or len(k_record) = 0 then
				k_record = "A"
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)
			
//		case "iva_inc"
//			select iva_inc
//				 into :k_long
//				 from base;
//			k_record = string(k_long, "00000")
//			if isnull(k_record) then
//				k_record = "0"
//			end if
//			k_record = trim(k_record)
//			k_pos_ini = 1
//			k_lungo = len(k_record)
//			
//		case "clie_gru"
//			select CLIE_GRU
//				 into :k_long
//				 from base;
//			k_record = string(k_long, "00000")
//			if isnull(k_record) then
//				k_record = "0"
//			end if
//			k_record = trim(k_record)
//			k_pos_ini = 1
//			k_lungo = len(k_record)
			
//		case "inc_gru"
//			select INC_GRU
//				 into :k_long
//				 from base;
//			k_record = string(k_long, "00000")
//			if isnull(k_record) then
//				k_record = "0"
//			end if
//			k_record = trim(k_record)
//			k_pos_ini = 1
//			k_lungo = len(k_record)
			
//		case "bolli_gru"
//			select bolli_gru
//				 into :k_long
//				 from base;
//			k_record = string(k_long, "00000")
//			if isnull(k_record) then
//				k_record = "0"
//			end if
//			k_record = trim(k_record)
//			k_pos_ini = 1
//			k_lungo = len(k_record)
//			
//		case "art_vari_gru"
//			select art_vari_gru
//				 into :k_long
//				 from base;
//			k_record = string(k_long, "00000")
//			if isnull(k_record) then
//				k_record = "0"
//			end if
//			k_record = trim(k_record)
//			k_pos_ini = 1
//			k_lungo = len(k_record)

//--- Dati	 dell'azienda 
		case "rag_soc_1"
			select rag_soc_1
				 into :k_record
				 from base;
			if k_record > " " then
				k_record = trim(k_record)
			else
				k_record = ""
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "rag_soc_2"
			select rag_soc_2
				 into :k_record
				 from base;
			if k_record > " " then
				k_record = trim(k_record)
			else
				k_record = ""
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "e_mail"
			select e_mail
				 into :k_record
				 from base;
			if k_record > " " then
				k_record = trim(k_record)
			else
				k_record = ""
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)

// Dosimetro
		case "dosimetro_barcode_mask" // i primi 3 char del barcode al posto del codice Cliente
			select dosimetro_barcode_mask
				 into :k_record
				 from base;
			k_record = trim(k_record)
			if k_record > " " then
			else
				k_record = "DSM"
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "dosimetro_ult_barcode" // suffisso del barcode Dosimetro
			select dosimetro_ult_barcode
				 into :k_record
				 from base;
			k_record = trim(k_record)
			if k_record > " " then
			else
				k_record = ""
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "dosimetro_id_armo" // id della riga lotto da 'scaricare'
			select dosimetro_id_armo 
				 into :k_long
				 from base;
			k_record = string(k_long)
			if isnull(k_long) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)


//--- Tabella BASE_FATT			
		case "fatt_bolli_lim_stampa" // limite importo fattura oltre il quale esporre le norme dei bolli
			select bolli_lim_stampa
				 into :k_double
				 from base_fatt;
			k_record = string(k_double)
			if isnull(k_record) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "fatt_bolli_note" //norme Bolli da esporre in fattura
			select bolli_note
				 into :k_record
				 from base_fatt;
			k_record = trim(k_record)
			if isnull(k_record) or len(k_record) = 0 then
				k_record = " "
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "fatt_banca" //Banca bonifici da esporre in fattura
			select banca
				 into :k_record
				 from base_fatt;
			k_record = trim(k_record)
			if isnull(k_record) or len(k_record) = 0 then
				k_record = " "
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)

		case "fatt_impon_minimo" // limite imponibile di fatturazione 
			select impon_minimo
				 into :k_double
				 from base_fatt;
			k_record = string(k_double)
			if isnull(k_record) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)

		case "fatt_comunicazione" //comunicazione a piede fattura
			select comunicazione, comunicazione_attiva
				 into :k_record, :k_flag
				 from base_fatt;
			k_record = trim(k_record)
			if isnull(k_record) or len(k_record) = 0 or trim(k_flag) <> "1" or isnull(k_flag)  then
				k_record = " "
			end if
			k_pos_ini = 1
			k_lungo = len(k_record)

		case "esolver_fidi_id_meca_causale" //id_meca_causale x tutte le entrate x i clienti fuori fido
			select esolver_fidi_id_meca_causale
				 into :k_long
				 from base_fatt;
			k_record = string(k_long)
			if isnull(k_long) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "ddt_qtna_note" // Note ddt spedizione quarantena
			select ddt_qtna_note
				 into :k_record
				 from base_fatt;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "ddt_blk_lotti_senza_attestato" //'1' = i lotti da trattare senza attestato non possono essere spediti
			select ddt_blk_lotti_senza_attestato
				 into :k_long
				 from base_fatt;
			k_record = string(k_long)
			if isnull(k_long) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			

//--- Dati Registro Articolo 50			
		case "art50_anno" // dati Registro Art.50
			select art50_anno
				 into :k_ulong
				 from base_fatt;
			k_record = string(k_ulong)
			if isnull(k_ulong) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "art50_mese" // dati Registro Art.50
			select art50_mese
				 into :k_ulong
				 from base_fatt;
			k_record = string(k_ulong)
			if isnull(k_ulong) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "art50_ult_nrpagina" // dati Registro Art.50
			select art50_ult_nrpagina
				 into :k_ulong
				 from base_fatt;
			k_record = string(k_ulong)
			if isnull(k_ulong) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "art50_ult_nrprot" // dati Registro Art.50
			select art50_ult_nrprot
				 into :k_ulong
				 from base_fatt;
			k_record = string(k_ulong)
			if isnull(k_ulong) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "art50_nazioni_gruppo" // dati Registro Art.50
			select art50_nazioni_gruppo
				 into :k_record
				 from base_fatt;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "art50_id_nazione_esclusa" // dati Registro Art.50
			select art50_id_nazione_esclusa
				 into :k_record
				 from base_fatt;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
//--- id del Listino utile a fatturare il Costo Chiamata vettore 
		case "sv_call_vettore_id_listino" 
			select sv_call_vettore_id_listino
				 into :k_ulong
				 from base_fatt;
			k_record = string(k_ulong)
			if isnull(k_ulong) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
//		case "id_email_lettera_fattura" // quando la Fattura è inviata come allegato al Cliente quale e-mail?
//			select id_email_lettera_fattura
//				 into :k_record
//				 from base_fatt;
//			k_record = trim(k_record)
//			if isnull(k_record) then
//				k_record = ""
//			end if
//			k_record = trim(k_record)
//			k_pos_ini = 1
//			k_lungo = len(k_record)
//		case "id_email_lettera_avviso" // quando invio solo avviso di Fattura al Cliente quale e-mail?
//			select id_email_lettera_avviso
//				 into :k_record
//				 from base_fatt;
//			k_record = trim(k_record)
//			if isnull(k_record) then
//				k_record = ""
//			end if
//			k_record = trim(k_record)
//			k_pos_ini = 1
//			k_lungo = len(k_record)
			
//--- BASE_DIR ---------------------------------------------------------------------------------------------------------------------------------------------			
		case "dir_fatt" // Cartella radice dove risiedono le fatture elettroniche (pdf) da inviare
			select dir_fatt
				 into :k_record
				 from base_dir;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "doc_root" // Cartella radice dove risiedono tutti i documenti elettronici (pdf) della Procedura
			select doc_root
				 into :k_record
				 from base_dir;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "path_report_pilota" // Cartella radice dove risiedono i report prodotti dal Pilota (pdf)
			select dir_report_pilota
				 into :k_record
				 from base_dir;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "report_export_dir" // Cartella di esportazione dei REPORT (es. pilota_coda.html)
			select report_export_dir
				 into :k_record
				 from base_dir;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "aco_exp_regcdp_dir" // Cartella di esportazione dei dati x ACO (registro conto deposito)
			select aco_exp_regcdp_dir
				 into :k_record
				 from base_dir;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
		case "e1_certif_saved_dir" // Cartella ATTESTATI E1
			select e1_certif_saved_dir
				 into :k_record
				 from base_dir;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)

			
//		case "arch_esolver_anag"  // Cartella + nome file x esportare verso Contabilità versione da Utente
//			k_record = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "arch_esolver_anag", "")) // prima controlla confdb dell'utente
//			if len(k_record) = 0 then // se non trovato piglia dai dati BASE
//				select esolver_expanag_dir
//					 into :k_record
//					 from base_dir;
//				k_record = trim(k_record)
//				if isnull(k_record) then
//					k_record = ""
//				end if
//				select esolver_expanag_nome
//					 into :k_record1
//					 from base_dir;
//				k_record1 = trim(k_record1)
//				if isnull(k_record1) then
//					k_record1 = ""
//				end if
//				k_record = k_record + KKG.PATH_SEP + k_record1
//			end if
//			k_pos_ini = 1
//			k_lungo = len(k_record)
//			
//		case "arch_esolver_expfidi"  // Cartella + nome file x esportare verso Contabilità i dati FIDI versione da Utente
//			k_record = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "arch_esolver_fidi", "")) // prima controlla confdb dell'utente
//			if len(k_record) = 0 then // se non trovato piglia dai dati BASE
//				select esolver_fidi_dir
//					 into :k_record
//					 from base_dir;
//				k_record = trim(k_record)
//				if isnull(k_record) then
//					k_record = ""
//				end if
//				select esolver_expfidi_nome
//					 into :k_record1
//					 from base_dir;
//				k_record1 = trim(k_record1)
//				if isnull(k_record1) then
//					k_record1 = ""
//				end if
//				k_record = k_record + KKG.PATH_SEP + k_record1
//			end if
//			k_pos_ini = 1
//			k_lungo = len(k_record)
//		case "arch_esolver_inpfidi"  // Cartella + nome file x importare da Contabilità i dati FIDI versione da Utente
//			k_record = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "arch_esolver_fidi", "")) // prima controlla confdb dell'utente
//			if len(k_record) = 0 then // se non trovato piglia dai dati BASE
//				select esolver_fidi_dir
//					 into :k_record
//					 from base_dir;
//				k_record = trim(k_record)
//				if isnull(k_record) then
//					k_record = ""
//				end if
//				select esolver_inpfidi_nome
//					 into :k_record1
//					 from base_dir;
//				k_record1 = trim(k_record1)
//				if isnull(k_record1) then
//					k_record1 = ""
//				end if
//				k_record = k_record + KKG.PATH_SEP + k_record1
//			end if
//			k_pos_ini = 1
//			k_lungo = len(k_record)
//			
//		case "arch_esolver_anag_batch" // Cartella + nome file di dove esportare le Anag x la contabilità
//			select esolver_expanag_dir
//					 into :k_record
//					 from base_dir;
//			k_record = trim(k_record)
//			if isnull(k_record) then
//				k_record = ""
//			end if
//			select esolver_expanag_nome
//					 into :k_record1
//					 from base_dir;
//			k_record1 = trim(k_record1)
//			if isnull(k_record1) or len(k_record1) = 0 then
//				k_record1 = "esolver_anag.csv"
//			end if
//			k_record = k_record + KKG.PATH_SEP + k_record1
//			k_pos_ini = 1
//			k_lungo = len(k_record)
//		case "arch_esolver_expfidi_batch" // Cartella + nome file di dove esportare i dati x FIDI x la contabilità
//			select esolver_fidi_dir
//					 into :k_record
//					 from base_dir;
//			k_record = trim(k_record)
//			if isnull(k_record) then
//				k_record = ""
//			end if
//			select esolver_expfidi_nome
//					 into :k_record1
//					 from base_dir;
//			k_record1 = trim(k_record1)
//			if isnull(k_record1) or len(k_record1) = 0 then
//				k_record1 = "esolver_fidi_out.csv"
//			end if
//			k_record = k_record + KKG.PATH_SEP + k_record1
//			k_pos_ini = 1
//			k_lungo = len(k_record)
//			
//		case "arch_esolver_inpfidi_batch" // Cartella + nome file di dove importare i dati x clienti fuori FIDO dalla contabilità
//			select esolver_fidi_dir
//					 into :k_record
//					 from base_dir;
//			k_record = trim(k_record)
//			if isnull(k_record) then
//				k_record = ""
//			end if
//			select esolver_inpfidi_nome
//					 into :k_record1
//					 from base_dir;
//			k_record1 = trim(k_record1)
//			if isnull(k_record1) or len(k_record1) = 0 then
//				k_record1 = "esolver_fidi_inp.csv"
//			end if
//			k_record = k_record + KKG.PATH_SEP + k_record1
//			k_pos_ini = 1
//			k_lungo = len(k_record)
//--- E-ONE: numero giorni da risalire per fare l'allineamento tra le tabelle M2000 e E1 sui dati di lavorazione (F5548014)
		case "e1dtlav_allineagg" 
			select e1dtlav_allineagg
				 into :k_ulong
				 from base_dir;
			k_record = string(k_ulong)
			if isnull(k_ulong) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)

//--- base SMTP -----------------------------------------------------------------------------------------------------------------------------------------------			
		case "smtp_logfile" // SMTP dati 
			select smtp_logfile
				 into :k_record
				 from base_smtp;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "smtp_port" // SMTP dati 
			select smtp_port
				 into :k_record
				 from base_smtp;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "smtp_server" // SMTP dati 
			select smtp_server
				 into :k_record
				 from base_smtp;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "smtp_user" // SMTP dati 
			select smtp_user
				 into :k_record
				 from base_smtp;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "smtp_pwd" // SMTP dati 
			select smtp_pwd
				 into :k_record
				 from base_smtp;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "smtp_autorizz_rich" // SMTP dati 
			select smtp_autorizz_rich
				 into :k_record
				 from base_smtp;
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)

//--- systable
		case "nome_server" // nome del server db 
			//SELECT FIRST 1 DBINFO('dbhostname') 
				// into :k_record
				// FROM systables;
			//SELECT CONVERT(sysname, SERVERPROPERTY('servername'))
			//	 into :k_record;
			SELECT name, server_id, provider  
			    into :k_name, :k_server_id, :k_provider
				FROM sys.servers ; 
			k_record = k_name + " id " + k_server_id + " provider " + k_provider
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
		case "versione_db" // versione installata del db 
//			SELECT FIRST 1  DBINFO('version','full') 
//				 into :k_record
//				FROM systables;
          	kds = create datastore
			kds.dataobject = "ds_sql_version"
			kds.settransobject(kguo_sqlca_db_magazzino)
			k_rcn = kds.retrieve()
			if k_rcn < 1 then
				k_record = "NON RILEVATO !!"
			else
				k_Version = kds.getitemstring(1, "ProductVersion")
				k_Level = kds.getitemstring(1, "ProductLevel")
				k_MajorVersion = kds.getitemstring(1, "ProductMajorVersion")
				k_MinorVersion = kds.getitemstring(1, "ProductMinorVersion")
				k_ProductBuild = kds.getitemstring(1, "ProductVersion")
				k_Edition = kds.getitemstring(1, "Edition")
				k_EngineEdition =  kds.getitemstring(1, "EngineEdition")
				k_record = "Ver." + k_Version + "." +  k_Level + " " + k_MajorVersion + "." + k_MinorVersion &
							+ " " + k_ProductBuild + " Edition " + k_Edition + " " + k_EngineEdition
			end if
			k_record = trim(k_record)
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)
			
			
//		case "finestra_inizio" 
//			kst_profilestring_ini.utente = ""
//			kst_profilestring_ini.file = "base_personale"
//			kst_profilestring_ini.titolo = "conf_personale"
//			kst_profilestring_ini.nome = "finestra_inizio"
//			kst_profilestring_ini.operazione = "1"
//			k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
//			if kst_profilestring_ini.esito <> "0" then
//				k_stato = "1"
//	       	 	k_errore = "Dato 'Finestra di Partenza' non disponibile. Errore: " &
//				                       + trim(kst_profilestring_ini.esito)
//			end if
//			k_record = trim(kst_profilestring_ini.valore)
//			k_pos_ini = 1
//			k_lungo = len(k_record)

//--- codice azienda E1
		case "e1mcu"
			select e1mcu
				 into :k_record
				 from base;
			if isnull(k_record) then
				k_record = ""
			end if
			k_record = k_record
			k_pos_ini = 1
			k_lungo = len(k_record)
			k_trim_no = true

//--- codice listino per Prodotto E1 su cui caricare il numero dosimetri lotto nel ASN
		case "e1_id_listino_dsm_tof554701"
			select e1_id_listino_dsm_tof554701
				 into :k_long
				 from base_fatt
				 where e1_id_listino_dsm_tof554701_f = "S";
			k_record = string(k_long)
			if isnull(k_long) then
				k_record = "0"
			end if
			k_record = trim(k_record)
			k_pos_ini = 1
			k_lungo = len(k_record)

//---- Ultima spiaggia cerco dentro ai dati personali
		case else
			try
				kst_profilestring_ini.valore = get_dato_personale(k_key)
			catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()
				k_stato = "1" 
				k_errore = kst_esito.sqlerrtext 
			end try
			k_record = trim(kst_profilestring_ini.valore)
			k_pos_ini = 1
			k_lungo = len(k_record)
				
	end choose

//--- Se errore grave
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		k_stato = "1"
		k_errore = "Fallita lettura Proprietà Procedura (prendi_dato_base chiave=" + lower(k_key)  + "; errore=" + string(kguo_sqlca_db_magazzino.sqlcode) + ")!! "
		kguo_exception.inizializza( )
		kguo_exception.kist_esito.esito = kkg_esito.db_ko
		kguo_exception.kist_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kguo_exception.kist_esito.sqlerrtext = k_errore
		kguo_exception.kist_esito.nome_oggetto = this.classname()
		kguo_exception.scrivi_log( )
	end if
	
////--- se il dato e' da estrarre dall'archivio di testo su disco...
//	if k_dati_no_da_db = false then
//
//		k_path = trim(kGuf_data_base.profilestring_leggi_scrivi(1, "arch_base", " "))
//		
//		if len(trim(k_path)) = 0 then
//			k_pos_ini = 0
//			k_errore = "1Archivio Base Non Trovato!!. Uscire dalla Procedura."
//			
//		else			
//	
//			k_file = fileopen( trim(k_path) + "\base.dat", linemode!, read!, lockwrite!)
//	
////=== Errore
//			if k_file < 1 then
//		
//				k_pos_ini = 0
//				k_errore = "1Archivio Base Occupato!!. Ripeti l'operazione."
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
//					k_errore = "0" + " "
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
		if len(trim(k_errore)) > 0 then 
			k_return = k_stato + k_errore  + " "
		else
			if isnull(k_record) then k_record = " "
			if k_trim_no then
				k_return = k_stato + mid(k_record, k_pos_ini, k_lungo)
			else
				k_return = k_stato + trim(mid(k_record, k_pos_ini, k_lungo)) + " "
			end if
		end if
	else
		k_return = k_stato + k_errore + " "
	end if
		
		
		
return k_return

end function

public function st_esito statistici_stato_elab ();//
//=== Torna lo stato dell'elaborazione "statistici" ovvero in pgm M_ESTR10
//=== RETURN: testare l'esito con le costanti kci_statistici_.....
//
string k_rcx
st_profilestring_ini kst_profilestring_ini
st_esito kst_esito
st_tab_base k_st_tab_base


	kst_esito.esito = kci_statistici_stato_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""


  SELECT distinct
         base.data_stat,
         base.ora_stat
    INTO :k_st_tab_base.data_stat,   
         :k_st_tab_base.ora_stat
    FROM base  
	 using sqlca;

	if sqlca.sqlcode >= 0 then
		if upper(k_st_tab_base.ora_stat) = "*ERRORE*" then
			kst_esito.esito = kci_statistici_stato_ko
			kst_esito.SQLErrText = "Si sono verificati degli errori durante l'ultima estrazione,~n~rprego, verificare il LOG di Magazzino."
		else
			if upper(k_st_tab_base.ora_stat) = "IN ESEC." or trim(k_st_tab_base.ora_stat) = "" then
				kst_esito.esito = kci_statistici_stato_in_esec
				kst_esito.SQLErrText = "Attenzione, l'estrazione e' ancora in esecuzione,~n~rprego, provare piu' tardi."
			end if
		end if
	else
		kst_esito.esito = kci_statistici_stato_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Attenzione, l'archivio BASE non e' disponibile, riprovare.~n~rErrore: " + trim(sqlca.sqlerrtext)
	end if

		
	
return kst_esito

end function

public function string get_titolo_procedura () throws uo_exception;//---
//---  Recupera il Titolo della Procedura da esporre sulla Finestra Principale
//---
uo_exception kuo_exception 
string k_titolo=""
kuf_utility kuf1_utility


	kuf1_utility = create kuf_utility
	k_titolo = trim(mid(prendi_dato_base("titolo"), 2)) + " (" + string(kkG.versione, "00.0000") + ")" //prendo il titolo della procedura
	k_titolo = k_titolo + " Utente " + string(kguo_utente.get_id_utente( ) ) + " " + trim(kguo_utente.get_nome()) //UTENTE di accesso
	k_titolo = k_titolo + " su " + trim(kuf1_utility.u_nome_computer()) //prendo nome del Computer
	destroy kuf1_utility

	if isnull(k_titolo) then
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_not_fnd )
		kuo_exception.setmessage( "Impossibile reperire il titolo della Procedura")
		throw kuo_exception
	end if

return k_titolo
end function

public function boolean if_update_proced_disponibile () throws uo_exception;//---
//---  Controlla se Procedura da aggiornare con una nuova Versione 
//---
//---  Out: torna TRUE solo se Procedura da aggiornare
//---
uo_exception kuo_exception 
boolean k_return=false
st_tab_base kst_tab_base
kuf_utility kuf1_utility


	kst_tab_base.update_last_vers = trim(Mid(prendi_dato_base("update_last_vers"), 2)) 

	if kst_tab_base.update_last_vers = "S" then

		kst_tab_base.last_version = trim(Mid(prendi_dato_base("last_version"), 2))
		if isnull(kst_tab_base.last_version) then
			kst_tab_base.last_version = "0"
		end if
		
		if isnull(kkG.versione) or not isnumber(kst_tab_base.last_version) then
			kuo_exception = create uo_exception
			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int)
			kuo_exception.setmessage( "Impossibile reperire il numero di Versione della Procedura")
			throw kuo_exception
		end if


//	k_last_version_pgm = kk_versione
		if kst_tab_base.update_last_vers = "S" and double(kst_tab_base.last_version) > kkG.versione then
			k_return=true
		end if
	end if


return k_return

end function

public function st_esito tb_update_base_smtp (st_tab_base kst_tab_base);//
//====================================================================
//=== Aggiorna rek nella tabella BASE per dati di FATTURAZIONE
//=== 
//=== Input: st_tab_base 
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if len(trim(kst_tab_base.id_base)) > 0 then
	
	kst_tab_base.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_base.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(kst_tab_base.smtp_autorizz_rich ) then
		kst_tab_base.smtp_autorizz_rich = "N"
	end if
	if isnull(kst_tab_base.smtp_logfile) then
		kst_tab_base.smtp_logfile = "N"
	end if
	
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.id_programma = "az"
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	
	if not k_rc then
	
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Modifica Proprietà Procedura non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = "1"
	
	else
		
		k_rcn = 0
		select count(*)
			into :k_rcn
			from base_smtp
			WHERE base_smtp.id_base = :kst_tab_base.id_base 
			using sqlca;
			
				
	//--- tento l'insert se manca in arch.
		if sqlca.sqlcode  >= 0 then
			
			if k_rcn > 0 then
				UPDATE base_smtp
				  SET smtp_autorizz_rich = :kst_tab_base.smtp_autorizz_rich,   
						smtp_logfile = :kst_tab_base.smtp_logfile,   
						smtp_port = :kst_tab_base.smtp_port,   
						smtp_pwd = :kst_tab_base.smtp_pwd,   
						smtp_server = :kst_tab_base.smtp_server,   
						smtp_user = :kst_tab_base.smtp_user,   
						x_datins = :kst_tab_base.x_datins,  
						x_utente = :kst_tab_base.x_utente  
					WHERE id_base = :kst_tab_base.id_base 
					using sqlca;
					
			else
				
				INSERT INTO base_smtp
							( id_base,   
							  smtp_autorizz_rich,   
							  smtp_logfile,   
							  smtp_port,  
							  smtp_pwd, 
							  smtp_server, 
							  smtp_user, 
							  x_datins,   
							  x_utente )  
					  VALUES ( :kst_tab_base.id_base,   
							  :kst_tab_base.smtp_autorizz_rich,   
							  :kst_tab_base.smtp_logfile,   
							  :kst_tab_base.smtp_port,  
							  :kst_tab_base.smtp_pwd, 
							  :kst_tab_base.smtp_server, 
							  :kst_tab_base.smtp_user, 
							  :kst_tab_base.x_datins,   
							  :kst_tab_base.x_utente )  
					using sqlca;
			end if
			
		end if	
	
	
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.dati 'Proprietà Procedura' (base_SMTP):" + trim(sqlca.SQLErrText)
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
			if kst_tab_base.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_base.st_tab_g_0.esegui_commit) then
				kst_esito = kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati 'Proprietà Procedura': nessun dato smtp inserito (codice Procedura non impostato) "
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function st_esito tb_update_base_dir (st_tab_base kst_tab_base);//
//====================================================================
//=== Aggiorna rek nella tabella BASE per dati di FATTURAZIONE
//=== 
//=== Input: st_tab_base 
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if len(trim(kst_tab_base.id_base)) > 0 then
	
	kst_tab_base.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_base.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(kst_tab_base.dir_fatt ) then
		kst_tab_base.dir_fatt = ""
	end if
	if isnull(kst_tab_base.dir_ddt) then
		kst_tab_base.dir_ddt = ""
	end if
	if isnull(kst_tab_base.esolver_expanag_dir) then
		kst_tab_base.esolver_expanag_dir = ""
	end if
	if isnull(kst_tab_base.esolver_expanag_nome) then
		kst_tab_base.esolver_expanag_nome = ""
	end if
	if isnull(kst_tab_base.e1dtlav_allineagg) then
		kst_tab_base.e1dtlav_allineagg = 0
	end if	
	if isnull(kst_tab_base.dir_report_pilota) then
		kst_tab_base.dir_report_pilota = ""
	end if
	if isnull(kst_tab_base.report_export_dir) then
		kst_tab_base.report_export_dir = ""
	end if
	if isnull(kst_tab_base.aco_exp_regcdp_dir) then
		kst_tab_base.aco_exp_regcdp_dir = ""
	end if
	if isnull(kst_tab_base.e1_certif_saved_dir) then
		kst_tab_base.e1_certif_saved_dir = ""
	end if
	
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.id_programma = "az"
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	
	if not k_rc then
	
	
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Modifica Proprietà Procedura non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = "1"
	
	else
		
		k_rcn = 0
		select count(*)
			into :k_rcn
			from base_dir
			WHERE base_dir.id_base = :kst_tab_base.id_base
			using kguo_sqlca_db_magazzino;
			
				
	//--- tento l'insert se manca in arch.
		if kguo_sqlca_db_magazzino.sqlcode  >= 0 then
			
			if k_rcn > 0 then
				UPDATE base_dir
				  SET dir_fatt = :kst_tab_base.dir_fatt,   
						dir_ddt = :kst_tab_base.dir_ddt,   
						doc_root = :kst_tab_base.doc_root,   
						esolver_expanag_dir = :kst_tab_base.esolver_expanag_dir,
						esolver_expanag_nome = :kst_tab_base.esolver_expanag_nome,
						esolver_fidi_dir = :kst_tab_base.esolver_fidi_dir,
						esolver_expfidi_nome = :kst_tab_base.esolver_expfidi_nome,
						esolver_inpfidi_nome = :kst_tab_base.esolver_inpfidi_nome,
						e1dtlav_allineagg = :kst_tab_base.e1dtlav_allineagg,
						dir_report_pilota = :kst_tab_base.dir_report_pilota,
						report_export_dir = :kst_tab_base.report_export_dir,
						aco_exp_regcdp_dir = :kst_tab_base.aco_exp_regcdp_dir,
						e1_certif_saved_dir = :kst_tab_base.e1_certif_saved_dir,
						x_datins = :kst_tab_base.x_datins,  
						x_utente = :kst_tab_base.x_utente  
					WHERE id_base = :kst_tab_base.id_base 
					using kguo_sqlca_db_magazzino;
					
			else
				
				INSERT INTO base_dir
							( id_base,   
							  dir_fatt,   
							  dir_ddt,   
							  doc_root,
							  esolver_expanag_dir,
							  esolver_expanag_nome,
							  esolver_fidi_dir,
							  esolver_expfidi_nome,
							  esolver_inpfidi_nome,
							  dir_report_pilota,
							  report_export_dir,
							  aco_exp_regcdp_dir,
							  e1_certif_saved_dir,
							  x_datins,   
							  x_utente )  
					  VALUES ( :kst_tab_base.id_base,   
							  :kst_tab_base.dir_fatt,   
							  :kst_tab_base.dir_ddt,   
							  :kst_tab_base.doc_root,
							  :kst_tab_base.esolver_expanag_dir,
							  :kst_tab_base.esolver_expanag_nome,
							  :kst_tab_base.esolver_fidi_dir,
							  :kst_tab_base.esolver_expfidi_nome,
							  :kst_tab_base.esolver_inpfidi_nome,
							  :kst_tab_base.dir_report_pilota,
							  :kst_tab_base.report_export_dir,
							  :kst_tab_base.aco_exp_regcdp_dir,
							  :kst_tab_base.e1_certif_saved_dir,
							  :kst_tab_base.x_datins,   
							  :kst_tab_base.x_utente )  
					using kguo_sqlca_db_magazzino;
			end if
			
		end if	
	
	
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Tab.dati 'Proprietà Procedura' (base_dir):" + trim(kguo_sqlca_db_magazzino.SQLErrText)
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
			if kst_tab_base.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_base.st_tab_g_0.esegui_commit) then
				kst_esito = kGuf_data_base.db_commit_1( )
			end if
		end if
	
	
	
	end if
	
else
	kst_esito.SQLErrText = "Tab.dati 'Proprietà Procedura': nessuna Cartella caricata (codice Procedura non impostato) "
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function double get_occupazione_pedana (st_tab_base kst_tab_base) throws uo_exception;//
//====================================================================
//=== Torna l'occupazione della Pedana in base alle misure caricate nella tabella BASE
//=== 
//=== Input: st_tab_base le misure mis_x, mis_y, mis_z da calcolare
//=== Rit.: int= % Occupazione Pedana
//=== Lancia EXCEPTION
//=== 
//====================================================================
int k_return=0
double k_dimensioni_tot=0.0, k_dimensioni_passate=0.0, k_dimensioni_occup=0.0
st_tab_base kst_tab_base_orig
st_esito kst_esito
st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	if len(trim(kst_tab_base.id_base)) = 0 or isnull(kst_tab_base.id_base) then
		kst_tab_base.id_base = "A"	
	end if

	select mis_x
				,mis_y
				,mis_z
			into 	:kst_tab_base_orig.mis_x
					,:kst_tab_base_orig.mis_y
					,:kst_tab_base_orig.mis_z
			from base
			WHERE base.id = :kst_tab_base.id_base 
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		
		if kguo_sqlca_db_magazzino.sqlcode = 100 or kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Tab.dati 'Proprietà Procedura' (base):" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
			else
				if kguo_sqlca_db_magazzino.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				end if
			end if
			
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
			
		end if
	else

		if kst_tab_base_orig.mis_x > 0 then
			k_dimensioni_tot = (kst_tab_base_orig.mis_x/1000) * (kst_tab_base_orig.mis_y/1000) * (kst_tab_base_orig.mis_z/1000)
			if k_dimensioni_tot > 0 then
				k_dimensioni_passate = (kst_tab_base.mis_x/1000) * (kst_tab_base.mis_y/1000) * (kst_tab_base.mis_z/1000)
				if k_dimensioni_passate > 0 then
					k_dimensioni_occup = k_dimensioni_passate / k_dimensioni_tot * 100
					k_return = k_dimensioni_occup
					if k_return = 0 then k_return = 1
				end if
			end if
		end if
			
	
	
	end if
	


return k_return

end function

public function st_esito tb_update_base_fatt (st_tab_base ast_tab_base);//
//====================================================================
//=== Aggiorna rek nella tabella BASE per dati di FATTURAZIONE
//=== 
//=== Input: st_tab_base 
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w
datastore kds_1


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf_sicurezza kuf1_sicurezza

if len(trim(ast_tab_base.id_base)) > 0 then
	
	ast_tab_base.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_base.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(ast_tab_base.fatt_bolli_lim_stampa) then
		ast_tab_base.fatt_bolli_lim_stampa = 0
	end if
	if isnull(ast_tab_base.fatt_bolli_note) then
		ast_tab_base.fatt_bolli_note = " "
	end if
	
	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
	kst_open_w.id_programma = "az"
	
	//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_rc = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	
	if not k_rc then
	
	
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Modifica Proprietà Procedura non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = "1"
	
	else

		kds_1 = create datastore
		kds_1.dataobject = "ds_base_fatt_rid"
		kds_1.settransobject( kguo_sqlca_db_magazzino)
		
		
		k_rcn = kds_1.retrieve(ast_tab_base.id_base)
//		select count(*)
//			into :k_rcn
//			from base_fatt
//			WHERE base_fatt.id_base = :ast_tab_base.id_base 
//			using kguo_sqlca_db_magazzino;
			
				
	//--- tento l'insert se manca in arch.
		if k_rcn  >= 0 then
			
			if k_rcn = 0 then
				kds_1.insertrow(0)
			end if
			
			kds_1.setitem(1, "bolli_lim_stampa", ast_tab_base.fatt_bolli_lim_stampa)
			kds_1.setitem(1, "bolli_note", ast_tab_base.fatt_bolli_note)
			kds_1.setitem(1, "banca", ast_tab_base.fatt_banca)
			kds_1.setitem(1, "impon_minimo", ast_tab_base.fatt_impon_minimo)
			kds_1.setitem(1, "id_email_lettera_fattura", ast_tab_base.id_email_lettera_fattura)
			kds_1.setitem(1, "id_email_lettera_avviso", ast_tab_base.id_email_lettera_avviso)
			kds_1.setitem(1, "comunicazione", ast_tab_base.fatt_comunicazione)
			kds_1.setitem(1, "comunicazione_attiva", ast_tab_base.fatt_comunicazione_attiva)
			kds_1.setitem(1, "esolver_fidi_id_meca_causale", ast_tab_base.esolver_fidi_id_meca_causale)
			kds_1.setitem(1, "ddt_qtna_note", ast_tab_base.ddt_qtna_note)
			kds_1.setitem(1, "ddt_blk_lotti_senza_attestato", ast_tab_base.ddt_blk_lotti_senza_attestato)
			kds_1.setitem(1, "sv_call_vettore_id_listino", ast_tab_base.sv_call_vettore_id_listino)
			kds_1.setitem(1, "e1_id_listino_dsm_tof554701_f", ast_tab_base.e1_id_listino_dsm_tof554701_f)
			kds_1.setitem(1, "e1_id_listino_dsm_tof554701", ast_tab_base.e1_id_listino_dsm_tof554701)

			kds_1.setitem(1, "x_datins", ast_tab_base.x_datins)
			kds_1.setitem(1, "x_utente", ast_tab_base.x_utente)

			k_rcn = kds_1.update( )
			
//				UPDATE base_fatt  
//				  SET bolli_lim_stampa = :ast_tab_base.fatt_bolli_lim_stampa,   
//						bolli_note = :ast_tab_base.fatt_bolli_note,   
//						banca = :ast_tab_base.fatt_banca,   
//						impon_minimo = :ast_tab_base.fatt_impon_minimo,   
//						id_email_lettera_fattura = :ast_tab_base.id_email_lettera_fattura,   
//						id_email_lettera_avviso = :ast_tab_base.id_email_lettera_avviso,   
//						comunicazione =  :ast_tab_base.fatt_comunicazione,
//						comunicazione_attiva =  :ast_tab_base.fatt_comunicazione_attiva,
//						esolver_fidi_id_meca_causale =  :ast_tab_base.esolver_fidi_id_meca_causale ,
//						ddt_qtna_note = :ast_tab_base.ddt_qtna_note ,
//						ddt_blk_lotti_senza_attestato = :ast_tab_base.ddt_blk_lotti_senza_attestato ,
//						sv_call_vettore_id_listino = :ast_tab_base.sv_call_vettore_id_listino ,
//						x_datins = convert(datetime, :ast_tab_base.x_datins),  
//						x_utente = :ast_tab_base.x_utente  
//					WHERE id_base = :ast_tab_base.id_base 
//					using kguo_sqlca_db_magazzino; 
					
//			else
//				
//				INSERT INTO base_fatt  
//							( id_base,   
//							  bolli_lim_stampa,   
//							  bolli_note,   
//							  banca,  
//							  impon_minimo, 
//							  id_email_lettera_fattura, 
//							  id_email_lettera_avviso, 
//							  comunicazione,
//							  comunicazione_attiva,
//							  esolver_fidi_id_meca_causale,
//							  ddt_qtna_note,  
//							  ddt_blk_lotti_senza_attestato ,
//							  sv_call_vettore_id_listino ,
//							  x_datins,   
//							  x_utente )  
//					  VALUES ( :ast_tab_base.id_base,   
//							  :ast_tab_base.fatt_bolli_lim_stampa,   
//							  :ast_tab_base.fatt_bolli_note,   
//							  :ast_tab_base.fatt_banca,   
//							  :ast_tab_base.fatt_impon_minimo,
//							  :ast_tab_base.id_email_lettera_fattura,   
//							  :ast_tab_base.id_email_lettera_avviso,   
//							  :ast_tab_base.fatt_comunicazione,
//							  :ast_tab_base.fatt_comunicazione_attiva,
//							  :ast_tab_base.esolver_fidi_id_meca_causale ,
//							  :ast_tab_base.ddt_qtna_note,  
//							  :ast_tab_base.ddt_blk_lotti_senza_attestato ,
//							  :ast_tab_base.sv_call_vettore_id_listino ,
//							  :ast_tab_base.x_datins,   
//							  :ast_tab_base.x_utente )  
//					using kguo_sqlca_db_magazzino;
//			end if
			
		end if	
	
	
		if k_rcn < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in aggiornamento 'Proprietà Procedura' (fatt): " + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		else
			if ast_tab_base.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_base.st_tab_g_0.esegui_commit) then
				kst_esito = kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
	
		if isvalid(kds_1) then destroy kds_1
	
	end if
	
else
	kst_esito.SQLErrText = "Archivio 'Proprietà Procedura' (fatt): nessun dato inserito (codice Azienda non impostato) "
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function string get_version () throws uo_exception;//---
//--- Get numero della Versione 'ufficiale' della Procedura M2000 dal DB
//---
//---  Out: torna TRUE solo se Procedura da aggiornare
//---
uo_exception kuo_exception 
string k_return=""
st_tab_base kst_tab_base


		kst_tab_base.last_version = trim(Mid(prendi_dato_base("last_version"), 2))
		if isnull(kst_tab_base.last_version) then
			kst_tab_base.last_version = "0"
		end if
		
		if isnull(kkG.versione) or not isnumber(kst_tab_base.last_version) then
			kuo_exception = create uo_exception
			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int)
			kuo_exception.setmessage( "Impossibile reperire il numero di Versione della Procedura")
			throw kuo_exception
		end if

		k_return = kst_tab_base.last_version

return k_return

end function

public function boolean if_e1_enabled () throws uo_exception;//---
//---  Verifica se interfaccia con E-ONE attiva (ovvero non più WMF/BARCODE/DDT/FATTURE... )
//---
//---  Out: TRUE = E-ONE attivo
//---
boolean k_return=false
st_tab_base kst_tab_base


	kst_tab_base.e1_enabled = trim(Mid(prendi_dato_base("e1_enabled"), 2)) 

	k_return = if_e1_enabled(kst_tab_base)

return k_return

end function

public function boolean if_e1_enabled (st_tab_base kst_tab_base) throws uo_exception;//---
//---  Verifica se interfaccia con E-ONE attiva (ovvero non più WMF/BARCODE/DDT/FATTURE... )
//---
//---  Out: TRUE = E-ONE attivo
//---
boolean k_return=false


	if kst_tab_base.e1_enabled = "S" then
		k_return = true
	end if


return k_return

end function

public function string get_dato_personale (string a_key) throws uo_exception;//
//--- Legge archivio sequenziale BASE PERSONALE restituendo un valore 
//
//--- Input: chiave di ricerca del valore
//--- ritorna il valore 
//--- lancia exception
//
string k_key, k_return="", k_rcx, k_record
long k_id_utente
st_profilestring_ini kst_profilestring_ini


	k_key = lower(a_key) 

	choose case k_key
			
//---- Dati da BASE_UTENTI: paramtro personalizzato su utente
		case kki_base_utenti_codice_stcert1  & 
				,kki_base_utenti_codice_stcert2 &
				,kki_base_utenti_startfunz &
				,kki_base_utenti_flagsuoni & 
				,kki_base_utenti_tel &
				,kki_base_utenti_email &
				,kki_base_utenti_nome &
				,kki_base_utenti_flagZOOMctrl
				
			k_id_utente = kguo_utente.get_id_utente( )

			SELECT valore 
				 into :k_record
				FROM base_utenti
				where id_base = :kguo_g.id_base
				    and id_utente = :k_id_utente
					 and codice = :k_key
			  using kguo_sqlca_db_magazzino
				;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				if k_record > " " then
					k_return = trim(k_record)
				else
					k_return = ""
				end if
				
			else
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					kguo_exception.inizializza( )
					kguo_exception.kist_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kguo_exception.kist_esito.esito = kkg_esito.db_ko
					kguo_exception.kist_esito.sqlerrtext = "Errore in lettura dati Utente: " + string(k_id_utente) + "~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText)
					kguo_exception.kist_esito.nome_oggetto = this.classname()
					throw kguo_exception
				end if
			end if
		
		case else
		
			kst_profilestring_ini.utente = ""
			kst_profilestring_ini.file = "base_personale"
			kst_profilestring_ini.titolo = "conf_personale"
			kst_profilestring_ini.nome = k_key
			kst_profilestring_ini.operazione = "1"
			k_rcx = kGuf_data_base.profilestring_ini(kst_profilestring_ini)
			if kst_profilestring_ini.esito <>  "0" then
				if kst_profilestring_ini.esito =  "1" then
					kguo_exception.inizializza( )
					kguo_exception.kist_esito.esito = kkg_esito.ko
					kguo_exception.kist_esito.sqlerrtext = "Dato '" + k_key+ "' non disponibile. Errore: " + trim(kst_profilestring_ini.esito) + "~n~r" + k_rcx
					kguo_exception.kist_esito.nome_oggetto = this.classname()
					throw kguo_exception
				else
					kst_profilestring_ini.valore = ""
				end if
			end if
			k_return = trim(kst_profilestring_ini.valore)
				
	end choose	
	
return k_return

end function

public function boolean u_open (ref st_open_w ast_open_w);//---
//--- Apre la Window delle Proprietà Azienda
//---
//--- Input: st_open_w
//--- Out: TRUE = finestra aperta; FASE=operazione non eseguita
//---
boolean k_return = false
string k_rc = ""
st_esito kst_esito 
//kuf_menu_window kuf1_menu_window

	if trim(ast_open_w.flag_modalita) > " " then
	else
		ast_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	end if
	ast_open_w.id_programma = "azp" //get_id_programma( ast_open_w.flag_modalita )
	ast_open_w.flag_primo_giro = "S"
	if trim(ast_open_w.flag_adatta_win) > " " then 
	else
		ast_open_w.flag_adatta_win = KKG.ADATTA_WIN
	end if
	if not isvalid(ast_open_w.key12_any) then ast_open_w.key12_any = this			// questo oggetto di gestione del trova

	//kuf1_menu_window = create kuf_menu_window 
	kGuf_menu_window.open_w_tabelle(ast_open_w)
	//destroy kuf1_menu_window
	//if k_rc = "1" then	
	k_return = true


return k_return


end function

public function st_esito tb_update_base_gmt (st_tab_base ast_tab_base);//
//====================================================================
//=== Aggiorna rek nella tabella BASE per dati di GMT (UTC e ora legale)
//=== 
//=== Input: st_tab_base 
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
long k_rcn
boolean k_rc
st_esito kst_esito
//st_open_w kst_open_w


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//kuf_sicurezza kuf1_sicurezza

if len(trim(ast_tab_base.id_base)) > 0 then
	
	ast_tab_base.x_datins = kGuf_data_base.prendi_x_datins()
	ast_tab_base.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(ast_tab_base.utc_fuso) then
		ast_tab_base.utc_fuso = 0
	end if
	if isnull(ast_tab_base.oralegale_on) then
		ast_tab_base.oralegale_on = "N"
	end if
	if isnull(ast_tab_base.oralegale_start) then
		ast_tab_base.oralegale_start = date(0)
	end if
	if isnull(ast_tab_base.oralegale_end) then
		ast_tab_base.oralegale_end = date(0)
	end if
	
//	kst_open_w.flag_modalita = kkg_flag_modalita.modifica
//	kst_open_w.id_programma = "az"
	
	k_rcn = 0
	select count(*)
		into :k_rcn
		from base_gmt
		WHERE base_gmt.id_base = :ast_tab_base.id_base 
		using kguo_sqlca_db_magazzino;
			
				
	//--- tento l'insert se manca in arch.
	if kguo_sqlca_db_magazzino.sqlcode  >= 0 then
			
		if k_rcn > 0 then
				
			UPDATE base_gmt
				  SET utc_fuso = :ast_tab_base.utc_fuso,   
						oralegale_on = :ast_tab_base.oralegale_on,   
						oralegale_start = :ast_tab_base.oralegale_start,   
						oralegale_end = :ast_tab_base.oralegale_end,   
						x_datins = :ast_tab_base.x_datins,  
						x_utente = :ast_tab_base.x_utente  
					WHERE id_base = :ast_tab_base.id_base 
					using kguo_sqlca_db_magazzino; 
					
		else
				
			INSERT INTO base_gmt  
							( id_base,   
							  utc_fuso,   
							  oralegale_on,   
							  oralegale_start,  
							  oralegale_end, 
							  x_datins,   
							  x_utente )  
					  VALUES ( :ast_tab_base.id_base,   
							  :ast_tab_base.utc_fuso,   
							  :ast_tab_base.oralegale_on,   
							  :ast_tab_base.oralegale_start,   
							  :ast_tab_base.oralegale_end,
							  :ast_tab_base.x_datins,   
							  :ast_tab_base.x_utente )  
					using kguo_sqlca_db_magazzino;
		end if
	
		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in aggiornamento dati 'Proprietà Procedura' (base_gmt):" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			if kguo_sqlca_db_magazzino.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		else
			if ast_tab_base.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_base.st_tab_g_0.esegui_commit) then
				kst_esito = kguo_sqlca_db_magazzino.db_commit( )
			end if
		end if
	
	
	
	end if
	
else
	kst_esito.SQLErrText = "Aggiornamento dati 'Proprietà Procedura' tab base_gmt non eseguito (codice Proprietà non impostato)"
	kst_esito.esito = kkg_esito.no_esecuzione
end if


return kst_esito

end function

public function boolean get_oralegale (ref st_tab_base kst_tab_base) throws uo_exception;//
//====================================================================
//=== Torna l'ora legale di inizio e fine
//=== 
//=== Inp.: st_tab_base 
//=== Out.: oralegale_on, oralegale_start, oralegale_end
//=== Rit.: FALSE = ora legale non ATTIVA
//=== Lancia EXCEPTION
//=== 
//====================================================================
boolean k_return=false
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	if len(trim(kst_tab_base.id_base)) = 0 or isnull(kst_tab_base.id_base) then
		kst_tab_base.id_base = "A"	
	end if

	select oralegale_on
			,oralegale_start
			,oralegale_end
		into :kst_tab_base.oralegale_on
			 ,:kst_tab_base.oralegale_start
			 ,:kst_tab_base.oralegale_end
		from base_gmt
		WHERE base_gmt.id_base = :kst_tab_base.id_base 
		using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura dati Ora Legale dalle 'Proprietà Procedura' (base_gmt):" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	else
		if kst_tab_base.oralegale_on = "S" then
			k_return = true
		end if
	end if
	


return k_return

end function

public function integer get_utc_fuso (st_tab_base kst_tab_base) throws uo_exception;//
//====================================================================
//=== Torna il fuso orario rispetto al GMT (UTC) ad es. x l'Italia è 1
//=== 
//=== Input: st_tab_base 
//=== Rit.: il fuso orario (1 = VALORE DI DEFAULT)
//=== Lancia EXCEPTION
//=== 
//====================================================================
int k_return=1
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


	if len(trim(kst_tab_base.id_base)) = 0 or isnull(kst_tab_base.id_base) then
		kst_tab_base.id_base = "A"	
	end if

	select utc_fuso
		into :kst_tab_base.utc_fuso
		from base_gmt
		WHERE base_gmt.id_base = :kst_tab_base.id_base 
		using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura dati Ora Legale dalle 'Proprietà Procedura' (base_gmt):" + trim(kguo_sqlca_db_magazzino.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito )
			throw kguo_exception
		end if
	else
		if isnull(kst_tab_base.utc_fuso) then
		else
			k_return = kst_tab_base.utc_fuso 
		end if
	end if
	


return k_return

end function

public subroutine set_oralegale_utc () throws uo_exception;//---
//--- Imposta dati Ora Legale e UTC su variabili globali
//---
//---
datetime k_dataora_oggi
st_tab_base kst_tab_base


//--- Imposta le Variabli Globali dei Dati di Ora legale e UTC 				
	kguo_g.kG_UTC_fusoBase = get_utc_fuso(kst_tab_base)
	
	kguo_g.kG_OraLegale_ON = get_oralegale(kst_tab_base)
	kguo_g.kG_OraLegale_Start = kst_tab_base.oralegale_start
	kguo_g.kG_OraLegale_End = kst_tab_base.oralegale_end

	if kguo_g.kG_OraLegale_ON and kguo_g.kG_OraLegale_Start > kkg.data_zero and kguo_g.kG_OraLegale_end > kguo_g.kG_OraLegale_Start then
		k_dataora_oggi = kGuf_data_base.prendi_dataora( )
//--- Imposta eventuale ora legale se incluso nel periodo indicato
		kguo_g.set_oralegale_utc(k_dataora_oggi)		
	else
		kguo_g.kG_UTC_fuso = kguo_g.kG_UTC_fusoBase
	end if
				
	
end subroutine

on kuf_base.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_base.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

