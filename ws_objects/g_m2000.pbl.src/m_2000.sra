$PBExportHeader$m_2000.sra
$PBExportComments$Gestione Magazzino Gammarad
forward
global type m_2000 from application
end type
global kuo_sqlca_db_magazzino sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
//--- Oggetti Globali ----------------------------------------------------------------------------------------------

//--- Oggetto x gestire le ECCEZIONI
uo_exception kGuo_exception

//--- Definizione applicazione
application KG_application

//--- Definizione oggetti gestione DB (function user object)
kuf_data_base kGuf_data_base

//--- Definizione Oggetto connessione al DB PRINCIPALE (INFORMIX)
Kuo_sqlca_db_magazzino KGuo_sqlca_db_magazzino

//--- Definizione Oggetto connessione al DB PILOTA (MySql)
kuo_sqlca_db_pilota KGuo_sqlca_db_pilota

//--- Definizione Oggetto connessione al DB MAGAZZINO (sql Server)
kuo_sqlca_db_wm kGuo_sqlca_db_wm

//--- Definizione Oggetto connessione al DB E-ONE (ORACLE)
kuo_sqlca_db_e1 kGuo_sqlca_db_e1

//--- Definizione oggetto x la Gestione degli ALLERT
Kuf_memo_allarme KGuf_memo_allarme

//--- Definizione oggetto x la Gestione delle Docking-Window
Kuf_base_docking KGuf_base_docking

//--- Definizione Oggetto connessione al DB X IL WEB (MySql)
//kuo_sqlca_db_xweb KGuo_sqlca_db_xweb

//--- Definizione Oggetto connessione al DB X IL CRM (MySql)
//kuo_sqlca_db_crm KGuo_sqlca_db_crm

//--- Menu della Procedura 
//m_main ki_menu_0  //ki_menuMDI

//--- Tabella e Oggetto contenente le voci di menu e la Gestione, per velocizzare la chiamata
kuf_menu_window kGuf_menu_window
st_tab_menu_window kGst_tab_menu_window[]
st_tab_menu_window_anteprima kgst_tab_menu_window_anteprima[100]   // tab pilota x fare dallo zoom alla Visualizz/Modifica/ecc....


//--- oggetti contenenti le ex-VARIABILI Globali
uo_g kguo_g
uo_path kguo_path
uo_utente kguo_utente


//--------------------------- OBSOLETO --------------------------------------------------------------------------------------------------------------------------------------------
//--- Costanti Globali rimpiazzate dagli oggetti globali "KKG."  

constant string KKG_PATH_SEP= "\" //separatore di cartelle su Windows e' '\'
constant string KKG_ADATTA_WIN="s" //flag se adattare le win al risoluz.vidio (s=si)
constant string KKG_ADATTA_WIN_NO="n" //flag se adattare le win al risoluz.vidio (n=no)
//constant string kkg_key_funzione_aggiorna = "F11"

constant date KKG_DATA_ZERO=date(0) //data a zero
constant date KKG_DATA_NO=date("01.01.1990") //data praticamente da considerare nulla

////--- 'sicurezza' vive solo x mantenere la compatibilita' con il passato
//constant int KK_PWD_MAX=1 // privilegio massimo
//constant int KK_PWD_LIV_2=2  // privilegio da operatore massimo
//constant int KK_PWD_LIV_3=3  // privilegio magazzino con PL
//constant int KK_PWD_LIV_4=4  // privilegio magazzino entrate-uscite
//constant int KK_PWD_QUERY=5  //privilegio operat consultativo

//--- Tipo Modalita operativa su cui opera la windows
constant string KKG_FLAG_MODALITA_ELENCO="el"          //menu funz.=e
constant string KKG_FLAG_MODALITA_INSERIMENTO="in"     //menu funz.=i
constant string KKG_FLAG_MODALITA_MODIFICA="mo"        //menu funz.=m
constant string KKG_FLAG_MODALITA_CANCELLAZIONE="ca"   //menu funz.=c
constant string KKG_FLAG_MODALITA_VISUALIZZAZIONE="vi" //menu funz.=v
constant string KKG_FLAG_MODALITA_STAMPA="st"       	 //menu funz.=s
constant string KKG_FLAG_MODALITA_INTERROGAZIONE="qy"  //menu funz.=q
constant string KKG_FLAG_MODALITA_CHIUDI_PL="cp"       //menu funz.=p
constant string KKG_FLAG_MODALITA_NAVIGATORE="nv"      //menu funz.=n
constant string KKG_FLAG_MODALITA_ANTEPRIMA="an"       //menu funz.=v //t
constant string KKG_FLAG_MODALITA_BATCH="bt"       	 //menu funz.=b

//--- Tipo richiesta operativa MAX 2 caratteri (utile nei metodi SMISTA_FUNZ() )
constant string KKG_FLAG_RICHIESTA_INSERIMENTO="in"  
constant string KKG_FLAG_RICHIESTA_MODIFICA="mo"  
constant string KKG_FLAG_RICHIESTA_CANCELLAZIONE="ca"  
constant string KKG_FLAG_RICHIESTA_VISUALIZZAZIONE="vi" 
constant string KKG_FLAG_RICHIESTA_STAMPA="st"  
constant string KKG_FLAG_RICHIESTA_CONFERMA="co" 
constant string KKG_FLAG_RICHIESTA_REFRESH="ag"  
constant string KKG_FLAG_RICHIESTA_REFRESH_ROW="rr"  
constant string KKG_FLAG_RICHIESTA_ESCI="ri"  
constant string KKG_FLAG_RICHIESTA_FILTRO="fl" 
constant string KKG_FLAG_RICHIESTA_SORT="or" 
constant string KKG_FLAG_RICHIESTA_TROVA="f1" 
constant string KKG_FLAG_RICHIESTA_TROVA_ANCORA="f2" 
constant string KKG_FLAG_RICHIESTA_VISUALIZZ_PREDEFINITA="vp" 
constant string KKG_FLAG_RICHIESTA_MOSTRA_NASCONDI_RIGHE="rg" 
constant string KKG_FLAG_RICHIESTA_MOSTRA_NASCONDI_DW_DETT="dd"
constant string KKG_FLAG_RICHIESTA_LIBERO1="l1" 
constant string KKG_FLAG_RICHIESTA_LIBERO2="l2" 
constant string KKG_FLAG_RICHIESTA_LIBERO3="l3" 
constant string KKG_FLAG_RICHIESTA_LIBERO4="l4" 
constant string KKG_FLAG_RICHIESTA_LIBERO5="l5" 
constant string KKG_FLAG_RICHIESTA_LIBERO6="l6" 
constant string KKG_FLAG_RICHIESTA_LIBERO71="l71" 
constant string KKG_FLAG_RICHIESTA_LIBERO72="l72" 
constant string KKG_FLAG_RICHIESTA_LIBERO73="l73" 
constant string KKG_FLAG_RICHIESTA_LIBERO74="l74" 
constant string KKG_FLAG_RICHIESTA_LIBERO75="l75" 
constant string KKG_FLAG_RICHIESTA_LIBERO8="l8" 
constant string KKG_FLAG_RICHIESTA_LIBERO9="l9" 

//constant long KKG_COLORE_NERO=65536 * (0) + 256 * (0) + (0) //colore (blu),(verde),(rosso)
//constant long KKG_COLORE_BIANCO=65536 * (255) + 256 * (255) + (255) //colore (blu),(verde),(rosso)
//constant long KKG_COLORE_GRIGIO=65536 * (223) + 256 * (223) + 223 //(192) //colore (blu),(verde),(rosso)
//constant long KKG_COLORE_ROSSO=65536 * (0) + 256 * (0) + (255) //colore (blu),(verde),(rosso)
//constant long KKG_COLORE_ROSSO_CHIARO=65536 * (136) + 256 * (136) + (255) //colore (blu),(verde),(rosso)
//constant long KKG_COLORE_GRANATA=65536 * (62) + 256 * (0) + (132) //colore (blu),(verde),(rosso)
//constant long KKG_COLORE_ERR_DATO=65536 * (217) + 256 * (217) + (255) //colore (blu),(verde),(rosso)
//constant long KKG_COLORE_BLU_SCURO=65536 * (113) + 256 * (0) + (0) //colore (blu),(verde),(rosso)
//constant long KKG_COLORE_BLU=65536 * (255) + 256 * (0) + (0) //colore (blu),(verde),(rosso)
//constant long KKG_COLORE_BLU_CHIARO=65536 * (255) + 256 * (211) + (168) //colore (blu),(verde),(rosso)
//constant string KKG_COLORE_REC_UPDx =string(65536 * (230) + 256 * (230) + (255)) //colore (blu),(verde),(rosso)
//constant string KKG_COLORE_CAMPO_DISATTIVO=string(65536 * (223) + 256 * (223) + 223) //colore (blu),(verde),(rosso)


//--- ognuna di queste voci deve essere lo stesso id presente nella tabella MENU_WINDOWS 
constant string kkg_id_programma_elenco = "elenco"
constant string kkg_id_programma_barcode = "barcode"
constant string kkg_id_programma_pl_barcode = "pl_barcode"
constant string kkg_id_programma_dosimetria = "convalida"    
constant string kkg_id_programma_dosimetria_da_autorizzare = "convalidaut"
constant string kkg_id_programma_dosimetria_da_sbloccare = "convalidablk"
constant string kkg_id_programma_sblocca_non_conforme = "nonconfsblk"
constant string kkg_id_programma_anag = "cl"
constant string kkg_id_programma_anag_rid = "cl_rid"
constant string kkg_id_programma_anag_memo = "cl_memo"
constant string kkg_id_programma_attestati = "attestati"
//constant string kkg_id_programma_riferimenti = "riferim_e"
constant string kkg_id_programma_contratti = "ct"
//constant string kkg_id_programma_contratti_rd = "ct_rd"
constant string kkg_id_programma_contratti_rd_l = "ct_rd_l"
constant string kkg_id_programma_contratti_generali_l = "ct_gen_l"
constant string kkg_id_programma_sc_cf = "sc_cf" //capitolati
//constant string kkg_id_programma_spedizioni = "sped"
constant string kkg_id_programma_fatture_elenco = "fatture_l"
constant string kkg_id_programma_fatture = "fatture"
constant string kkg_id_programma_fatture_stampa = "fatt_new_st"
constant string kkg_id_programma_sl_pt = "pt"
constant string kkg_id_programma_artr = "artr"
constant string kkg_id_programma_ricevute = "ricevute"
constant string kkg_id_programma_stampa = "st1"
constant string kkg_id_programma_pt_giri = "ptcicli"
constant string kkg_id_programma_sv_sked_oper_g = "svsked_g"
constant string kkg_id_programma_sv_sked_oper_v = "svsked_v"
constant string kkg_id_programma_sv_sked_oper_log = "svsked_log"
constant string kkg_id_programma_meca_aut_st_certif_farma = "meca_farma"
constant string kkg_id_programma_stat_fatt = "skc"
constant string kkg_id_programma_stat_produz = "stat_produz"
constant string kkg_id_programma_stat_produz_no_importi = "st_prod_nimp"
constant string kkg_id_programma_sped_vettori = "sped_vettori"
constant string kkg_id_programma_meca_aut_st_certif_aliment = "meca_aliment"
constant string kkg_id_programma_listini = "listino"
constant string kkg_id_programma_listini2 = "listino2"
constant string kkg_id_programma_listini_l = "listino_l"
constant string kkg_id_programma_pilota_proprieta = "pilota_p"
constant string kkg_id_programma_pilota_esporta_pl = "pilota_exp_p"
constant string kkg_id_programma_pilota_importa_esiti = "pilota_imp_p"
constant string kkg_id_programma_pilota_programmazione = "pilota_prg"
constant string kkg_id_programma_profis_l = "profis_l"
constant string kkg_id_programma_sr_change_pwd = "srpassword_c"
constant string kkg_id_programma_sr_change_pwd_u = "srpassword"
constant string kkg_id_programma_treeview_tabella = "treeview_tab"
constant string kkg_id_programma_ausiliari = "au"
constant string kkg_id_programma_ausiliari1 = "au1"
constant string kkg_id_programma_nt_licenza = "nt_licenza"
constant string kkg_id_programma_mtk = "mkt"
constant string kkg_id_programma_contatti = "contatti"
//constant string kkg_id_programma_EXIT = "exit"

//--- Ritorno ESITO
constant string KKG_ESITO_OK="0" // nessun errore
constant string KKG_ESITO_DB_KO="1" // errore grave DB sqlcode < 0
constant string KKG_ESITO_KO="A" // errore grave ma non da DB, ma de sempio da WINSOCKET
constant string KKG_ESITO_NOT_FND="100" // errore record non trovato sqlcode = 100
constant string KKG_ESITO_DB_WRN="3" // errore di avvertimento (warning)
constant string KKG_ESITO_NO_AUT="2" // errore Utente non Autorizzato
constant string KKG_ESITO_blok="5" // errore Bloccante
constant string KKG_ESITO_NO_ESECUZIONE="6" // operazione chiusa in modo gestito dal pgm o dall'Utente 
constant string KKG_ESITO_ERR_FORMALE="7" // errore formale dei dati (es. not numeric) 
constant string KKG_ESITO_ERR_LOGICO="8" // errore congruenza dei dati  


//--- Variabili Globali ------------------------------------------------------------------------------------------

//--- generali
string KG_PATH_PROCEDURA = "."  // path di lavoro delle procedura dove sta il confdb.ini
string KG_PATH_BASE_DEL_SERVER = "" //path dove risiede il server, di solito la CONSOLE
string KG_PATH_BASE_DEL_SERVER_JOB = "" //path dove risiedono i batch da lanciare dal Server (di solito li lancia la CONSOLE)
string KG_PATH_BASE = ""   //pakGuo_path.get_risorse()
string kG_path_risorse = ""  //path dei grafici
string kG_path_help = ""  //path file di HELP 
date KG_DATAOGGI = today()   //data oggi
//int KG_ANNO=year(KG_DATAOGGI) //Anno ESERCIZIO in tabella base
//boolean KG_ATTIVA_SUONI = false  //x attivare i suoni di open ecc... nelle windows
//boolean KG_SALVA_LISTE = false  //x attivare lo speed-list ovvero il salvatagio su HD delle DW x visualizz + in fretta
//pointer KG_POINTER_DEFAULT = Arrow!
//boolean kG_toolbar_window_stato=true //toolbar visibile o meno

//--- icone risorse grafiche
constant string kkg_risorsa_elenco = KKG.PATH_SEP + "folder.gif" 


//--- sicurezza
////int    KG_PWD=0 //Livello di Privilegio OBSOLETO solo x compatibilita' con il passato
//string KG_UTENTE="SCONOSCIUTO " //utente attivo
//string KG_UTENTE_CODICE="MASTER" //User dell'utente
//string KG_UTENTE_COMP="MAST" //User compatto, prendo solo 4 lettere senza char strani

end variables

global type m_2000 from application
string appname = "m_2000"
boolean toolbartext = true
string toolbarframetitle = "M2000 menu"
string toolbarsheettitle = "menu contestuale"
string displayname = "M2000"
string themepath = "C:\Program Files (x86)\Appeon\Shared\PowerBuilder\theme190"
string themename = "Do Not Use Themes"
long richtextedittype = 0
long richtexteditversion = 0
string richtexteditkey = ""
end type
global m_2000 m_2000

type prototypes
//
//function uint GetMenu( uInt hWnd) library "user32.dll"

//=== Ritorna l'Utente collegato
function boolean GetUserNameA (ref string userID, ref ulong len) library "ADVAPI32.DLL" alias for "GetUserNameA;Ansi" 

//=== API per suono
function boolean sndPlaySoundA(string SoundName, uint Flags) Library "WINMM.DLL" alias for "sndPlaySoundA;Ansi" 
function uint waveOutGetNumDevs () LIBRARY "WINMM.DLL"

//--- piglia il nome del computer
FUNCTION long GetComputerNameA(ref string compname,ref ulong slength) LIBRARY "kernel32" alias for "GetComputerNameA;Ansi"

//--- porta al TOP questa finestra
//FUNCTION boolean SetWindowPos(ulong hWnd, int hwinpos, int x, int y, int cx, int cy, int swp) LIBRARY "user32.dll" 

//--- Setta il fuoco da Windows a un oggetto PB  
//SUBROUTINE SetFocus(long objhandle) LIBRARY "User32.dll"
end prototypes

type variables

end variables

forward prototypes
public subroutine u_allarme_utente ()
public subroutine a_license ()
end prototypes

public subroutine u_allarme_utente ();//
st_memo_allarme kst_memo_allarme


try
	
	if isvalid(kguf_memo_allarme) then
		if kguf_memo_allarme.set_allarme_utente(kst_memo_allarme) then
			
			kguf_memo_allarme.u_attiva_memo_allarme_on()
			
			if kguf_memo_allarme.if_notifica_memo_a_video( ) then
				kguf_memo_allarme.set_visualizza_allarme( )
			end if
		else
//			kguf_memo_allarme.u_attiva_memo_allarme_hide()
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception
	

finally
	
	
end try



end subroutine

public subroutine a_license ();//
//<one line to give the program's name and a brief idea of what it does.>
//    Copyright (C) 2018  TREBBI ALBERTO
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.
//
end subroutine

event open;//
string k_esito="", k_rcx=""
application app
ulong k_handle=0
st_tab_base_personale kst_tab_base_personale
st_open_w kst_open_w
pointer oldpointer  // Declares a pointer variable
kuf_utility kuf1_utility
//kuf_base kuf1_base
 

//--- Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)
//--- Se volessi riprist. il vecchio puntatore : SetPointer(oldpointer)

//--- Oggetti da variabile globale
kguo_g = create uo_g
kguo_path = create uo_path
kguo_utente = create uo_utente

//--- puntatore all'oggetto APPLICAZIONE
KG_application = this

//--- Creo oggetto userobject GLOBALE x gestione ECCEZIONI
kGuo_exception = create uo_exception 
//--- Creo oggetto TRANSACTION  GLOBALE x gestione DB-MAGAZZINO
KGuo_sqlca_db_magazzino = SQLCA

//--- Creo oggetto MENU
//ki_menu_0 = create m_main

//--- Creo oggetto userobject GLOBALE funzioni generali della procedura
kGuf_data_base = create kuf_data_base
//--- Creo oggetto TRANSACTION  GLOBALE x gestione DB-PILOTA
KGuo_sqlca_db_pilota = create kuo_sqlca_db_pilota
//--- Creo oggetto TRANSACTION  GLOBALE x gestione DB-WM (WarehoseManagement)
KGuo_sqlca_db_wm = create kuo_sqlca_db_wm
//--- Creo oggetto TRANSACTION  GLOBALE x gestione DB-E1 (in remoto gruppo STERIGENICS)
KGuo_sqlca_db_e1 = create kuo_sqlca_db_e1
//--- Creo oggetto TRANSACTION  GLOBALE x gestione DB-X-WEB (dati da inviare a SMART)
//KGuo_sqlca_db_xweb = create kuo_sqlca_db_xweb
//--- Creo oggetto TRANSACTION  GLOBALE x gestione DB-X-CRM (dati da inviare a SEDOC)
//KGuo_sqlca_db_crm = create kuo_sqlca_db_crm
//--- Creo oggetto  x la Gestione della chiamata della funzione giusta
KGuf_menu_window = create Kuf_menu_window
//--- Creo oggetto  x la Gestione degli ALLERT 
KGuf_memo_allarme = create Kuf_memo_allarme
//--- Creo oggetto  x la Gestione delle Docking Window
KGuf_base_docking = create Kuf_base_docking

kuf1_utility = create kuf_utility
//kuf1_base = create kuf_base

////--- Controllo se procedura gia' lanciata se si .....
//if kGuf_data_base.if_is_running( )  then
//	halt close 
//end if

//kuf1_utility.u_toolbar_set_toolbartext()

//--- Imposta PATH del programma
kGuo_path.set_path()
//KG_PATH_PROCEDURA = kGukGuo_path.get_risorse()edura()
KG_path_risorse = kGuo_path.get_risorse()
KG_path_help = kGuo_path.get_help()


kguo_g.set_idprocedura(long(string(now(),"yymmddhhss")))
kguo_g.set_nome_computer(kuf1_utility.u_nome_computer())

//k_esito = kuf1_base.prendi_dato_base( "anno")
//if left(k_esito,1) <> kkg_esito.ok then
//	KG_ANNO = year(kg_dataoggi)
//else
//	k_rcx	= trim(mid(k_esito,2))
//	if isnumber(k_rcx) then
//		KG_ANNO = integer(k_rcx)
//	end if
//end if 

//--- verifica l'esistenza del file iniziale di configurazione  (confdb.ini)
try
	
	kGuf_data_base.u_if_profile_base_exists( )

catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )

end try

//--- cartella delle RISORSE (icone..) non accessibile??
if trim(kGuo_path.get_risorse()) > " " then
	if not DirectoryExists (kGuo_path.get_risorse()) then
		kGuo_exception.setmessage("Cartella del programma M2000", "Cartella delle 'risorse' non esistente o inaccessibile~n~r" + trim(kGuo_path.get_risorse()) &
		          + "~n~rL'anomalia potrebbe causare il rallentamento di aclune operazioni.") 
		kGuo_exception.messaggio_utente( )
	end if
end if
 

//---- nome toolbar unica x tutti 
this.ToolBarFrameTitle = "Toolbar"
this.ToolBarSheetTitle = "Toolbar"

//--- ripristino Puntatore
SetPointer(oldpointer)

if len(trim( kGuo_path.get_procedura())) > 0 then
	
//--- Lancia il Logo iniziale x Connessione Autorizzazione Utente
	kst_open_w.flag_modalita = kkg_flag_modalita.inserimento
	OpenWithParm(w_about_start, kst_open_w)
//	open (w_about_start)
	
	
end if

if isvalid(kuf1_utility) then destroy kuf1_utility
//if isvalid(kuf1_base) then destroy kuf1_base

//--- se utente inattivo x + di 40' (2400 sec) allora lancia idle()
idle(2400)
//test idle(10)


end event

event close;//
st_tab_base_personale kst_tab_base_personale
st_tab_base kst_tab_base
st_esito kst_esito
kuf_base kuf1_base
//kuf_utility kuf1_utility
//kuf_db kuf1_db


//
//=== Se DB-PILOTA connesso 
if isvalid(kguo_sqlca_db_pilota) then
	if kguo_sqlca_db_pilota.DBHandle ( ) > 0 then
		try
			KGuo_sqlca_db_pilota.db_disconnetti()
		catch (uo_exception kuo_exception)
		end try
	end if
end if
//
//=== Se DB-WM connesso 
if isvalid(kguo_sqlca_db_wm) then
	if kguo_sqlca_db_wm.DBHandle ( ) > 0 then
		try
			kguo_sqlca_db_wm.db_disconnetti()
		catch (uo_exception kuo1_exception)
		end try
	end if
end if
//=== Se DB-E1 connesso 
if isvalid(kguo_sqlca_db_e1) then
	if kguo_sqlca_db_e1.DBHandle ( ) > 0 then
		try
			kguo_sqlca_db_e1.db_disconnetti()
		catch (uo_exception kuo2_exception)
		end try
	end if
end if
////=== Se DB-X-WEB connesso 
//if isvalid(kguo_sqlca_db_xweb)  then
//	if kguo_sqlca_db_xweb.DBHandle ( ) > 0 then
//		try
//			kguo_sqlca_db_xweb.db_disconnetti()
//		catch (uo_exception kuo3_exception)
//		end try
//	end if
//end if


//kuf1_utility = create kuf_utility

//--- Se DB connesso 
if isvalid(sqlca) then
	if sqlca.DBHandle ( ) > 0 then
//--- NON scarica dalla memoria le librerie, per velocizzare il rilancio della Procedura
		this.FreeDBLibraries = FALSE
		try
			if isvalid(KGuo_sqlca_db_magazzino) then
				KGuo_sqlca_db_magazzino.db_disconnetti()
			end if

		catch (uo_exception kuo_exception1)
			kst_esito = kuo_exception1.get_st_esito()
			messagebox("Problemi durante chiusura della Procedura~n~r", trim(kst_esito.sqlerrtext ))
			
		finally
//			destroy kuf1_db

		end try

	end if
end if	

//--- set toolbattext
//kuf1_utility.u_toolbar_save_toolbartext()

//destroy kuf1_utility

	
//--- Segnala il tentativo di Start dell'applicazione (I=messaggio Informativo)
kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = KGuo_sqlca_db_magazzino.sqlcode
kst_esito.sqlerrtext = "Chiusura della Procedura M2000 - "  &
							+ ", Parametri DB Dbms.: " + trim(KGuo_sqlca_db_magazzino.dbparm) + ", "  &
							+ " Server: " + KGuo_sqlca_db_magazzino.servername + ", " &
							 + " Utente: " + kguo_utente.get_codice()
kGuf_data_base.errori_scrivi_esito("I", kst_esito) 

//
//--- Operazioni Finali dopo che DB e' chiuso
//
// Salvo in INI il nome utente collegato e la data-ora
kuf1_base = create kuf_base
kst_tab_base.key = "ultimo_utente_login_nome" 
kst_tab_base.key1 = kguo_utente.get_codice()
kuf1_base.metti_dato_base(kst_tab_base)
kst_tab_base.key = "ultimo_utente_login_data" 
kst_tab_base.key1 = string(now(), "dd/mm/yy  hh:mm")
kuf1_base.metti_dato_base(kst_tab_base)

destroy kuf1_base


//=== Distruggo oggetti Globali 
if isvalid(kguf_memo_allarme) then destroy kguf_memo_allarme 
if isvalid(KGuo_sqlca_db_pilota) then destroy KGuo_sqlca_db_pilota 
if isvalid(KGuo_sqlca_db_wm) then destroy KGuo_sqlca_db_wm
if isvalid(KGuo_sqlca_db_e1) then destroy KGuo_sqlca_db_e1
//if isvalid(kguo_sqlca_db_xweb ) then destroy KGuo_sqlca_db_xweb
if isvalid(sqlca) then destroy sqlca
if isvalid(kGuf_data_base) then destroy kGuf_data_base 
if isvalid(KGuf_base_docking) then destroy KGuf_base_docking 
if isvalid(kGuo_exception) then destroy kGuo_exception 


end event

on m_2000.create
appname="m_2000"
message=create message
sqlca=create kuo_sqlca_db_magazzino
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on m_2000.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event systemerror;//
st_esito kst_esito


try
	//~n~r
	kst_esito.esito = kkg_esito_ko
	kst_esito.sqlcode = Error.number
	kst_esito.sqlerrtext = "La procedura non riesce a catturare in automatico il tipo di errore interno pertanto il sistema potrebbe diventare instabile " &
			  + " Errore: " + string (Error.number) + " " + trim(error.Text) & 
			  + " Window o Menu: " + trim (Error.WindowMenu) & 
			  + " Oggetto: " + trim (Error.Object ) & 
			  + " Evento: " + trim (Error.ObjectEvent  ) & 
			  + " Alla linea: " + string (Error.Line ) & 
	
	if not isvalid(kguo_exception) then kguo_exception = create uo_exception
	kguo_exception.inizializza( )
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
	kguo_exception.set_esito(kst_esito)
	kguo_exception.messaggio_utente()

//	if isvalid(kguo_sqlca_db_magazzino) then
//		kguo_sqlca_db_magazzino.db_connetti( )
//	end if
	
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

end try


//-------------------------------------------------------------------------------------------------------------------------------------------------------
//--- LISTA ERRORI
//-------------------------------------------------------------------------------------------------------------------------------------------------------
//
//Number Meaning
//
//1 Divide by zero 2 Null object reference 
//3 Array boundary exceeded 
//4 Enumerated value is out of range for function 
//5 Negative value encountered in function 
//6 Invalid DataWindow row/column specified 
//7 Unresolvable external when linking reference 
//8 Reference of array with null subscript 
//9 DLL function not found in current application 
//10 Unsupported argument type in DLL function 
//11 Object file is out of date and must be converted to current version 
//12 DataWindow column type does not match GetItem type 
//13 Unresolved property reference 
//14 Error opening DLL library for external function 
//15 Error calling external function name 
//16 Maximum string size exceeded 
//17 DataWindow referenced in DataWindow object does not exist 
//18 Function does not return value 
//19 Cannot convert name in Any variable to name 
//20 Database command not successfully prepared 
//21 Bad runtime function reference 
//22 Unknown object type 
//23 Cannot assign object of type name to variable of type name 
//24 Function call does not match its definition 
//25 Double or Real expression has overflowed 
//26 Field name assignment not supported 
//27 Cannot take a negative to a noninteger power 
//28 VBX Error: name 
//29 Nonarray expected in ANY variable 
//30 External object does not support data type name 
//31 External object data type name not supported 
//32 Name not found calling external object function name 
//33 Invalid parameter type calling external object function name 
//34 Incorrect number of parameters calling external object function name 
//35 Error calling external object function name 
//36 Name not found accessing external object property name 
//37 Type mismatch accessing external object property name 
//38 Incorrect number of subscripts accessing external object property name 
//39 Error accessing external object property name 
//40 Mismatched ANY datatypes in expression 
//41 Illegal ANY data type in expression 
//42 Specified argument type differs from required argument type at runtime in DLL function name 
//43 Parent object does not exist 
//44 Function has conflicting argument or return type in ancestor 
//45 Internal table overflow; maximum number of objects exceeded 
//46 Null object reference cannot be assigned or passed to a variable of this type 
//47 Array expected in ANY variable 
//48 Size mismatch in array-to-object conversion 
//49 Type mismatch in array-to-object conversion 
//50 Distributed Service Error: name 
//51 Bad argument list for function/event: name 
//52 Distributed Communications Error: name 
//53 The server name could not be located. It was probably not started 
//54 The server name is rejecting new messages. It is in the process of shutting down 
//55 The request caused an abnormal termination. The connection has been closed 
//56 A message was not fully transmitted 
//57 This connection object is not connected to a server 
//58 Object instance does not exist 
//59 Invalid column range 
//60 Invalid row range 
//61 Invalid conversion of number dimensional array to object 
//62 The server name is busy and not accepting new connections 
//63 Function/event with no return value used in expression 
//64 Object array expected on left side of assignment 
//65 Dynamic function not found. Possible causes include: pass by value/reference mismatch 
//66 Invalid subscript for array index operation 
//67 Null object reference cannot be assigned or passed to an autoinstantiate 
//68 Null object reference cannot be passed to external DLL function name 
//69 Function name cannot be called from a secured runtime session 
//70 External DLL function name cannot be called from a secured runtime session 
//71 General protection fault occurred 
//72 name failed with an operating system error code of number 
//73 Reference parameters cannot be passed to an asynchronous shared/remote object method 
//74 Reference parameters cannot be passed to a shared object method 
//75 The server has forced the client to disconnect 
//76 Passing null as a parameter to external function name 
//77 Object passed to shared/remote object method is not a nonvisual user object 
//78 Listening works only in the Enterprise version of PowerBuilder 
//79 The argument to name must be an array 
//80 The server has timed out the client connection 
//81 Function argument file creator must be a four-character string 
//82 Function argument file type must be a four-character string 
//83 Attempt to invoke a function or event that is not accessible 
//84 Wrong number of arguments passed to function/event call 
//85 Error in reference argument passed in function/event call 
//86 Ambiguous function/event reference 
//87 The connection to the server has been lost 
//88 Cannot ask for ClassDefinition Information on open painter: name 
//89 5.0 style proxy objects are not supported. Copy the new style proxy that was generated at migration time 
//90 Cannot assign array of type name to variable of type array of name 
//91 Cannot convert name in Any variable to name. Possible cause: uninitialized value 
//92 Required property name is missing 
//93 CORBA User Exception: exceptionname 
//94 CORBA System Exception: exceptionname 
//95 CORBA Objects cannot be created locally 
//96 Exception Thrown has not been handled 
//97 Cannot save name because of a circular reference problem. Possible causes:
//    This object references another class, which in turn references this object 
//    Some other circular reference is pointing back to this object, causing a deadlock condition 
//Suggested actions:
//    Temporarily remove the circular reference from the referenced object 
//    Make your required changes to this object to refer to that object 
//    Add back the circular reference you removed in step 1 
//    Perform a full rebuild (recommended) 
//98 Obsolete object reference 
//99 Error calling method of a PBNI object 
//100 Error loading library containing a PBNI object 
//101 Error unloading library containing a PBNI object 
//102 Error creating a PBNI object 
//103 Error destroying a PBNI object 
//104 Error calling PowerBuilder system function functionname 
//105 Executing a HALT statement in a server component is strictly forbidden 
//106 Function is reserved or not yet implemented 
//107 Argument is out of range 
//108 Not enough memory to execute the operation 
//109 Cannot assign a null value to array variables 
//Some errors terminate the application immediately. They do not trigger the SystemError event 
end event

event idle;//
//--- get e visualizza eventuali allarmi MEMO
		u_allarme_utente( )

end event

