$PBExportHeader$kuf_data_base.sru
$PBExportComments$operazioni generiche sul DB (connect, commit ...)
forward
global type kuf_data_base from transaction
end type
end forward

global type kuf_data_base from transaction
end type
global kuf_data_base kuf_data_base

type prototypes

end prototypes

type variables

//--- file di configurazione 
constant string KKi_NOME_PROFILE_BASE = "confdb.ini"
constant string KKi_NOME_PROFILE_BASE_PRN = "confSta.ini"
constant string KKi_NOME_PROFILE_BASE_WIN = "confWin.ini"
constant string KKi_NOME_PROFILE_BASE_TOOLBAR = "confTool.ini"
constant string KKi_NOME_PROFILE_BASE_TREEVIEW = "confTrVw.ini"

//
public constant string ki_profilestring_operazione_leggi = "1"
public constant string ki_profilestring_operazione_scrivi = "2"
public constant string ki_profilestring_operazione_inizializza = "3"


//--- per gestire il rientro in window da funzione esterna 
private string ki_window_funzione_open
private boolean ki_window_funzione_aggiornata

//--- Trace ATTIVA
public boolean ki_trace_attiva=false

//--- Variabili Globali
public string KI_barcode_modulo="A" //form di stampa del barcode (etichette del lotto/riferimento)
public boolean kI_toolbar_2_settata=false  //dopo il primo set e' messa a TRUE

//public w_super kiw_attiva //contiene la window 'attiva' in modo da fare ad esempio funzionare il toobar 


end variables

forward prototypes
public function string db_commit ()
public function string db_rollback ()
public function window prendi_win_prec ()
public function string errorlog_riempi_dw (ref datawindow kdw_1, integer k_riga, integer k_col)
public function window prendi_win_x_uguale_titolo (string k_titolo)
public function object u_getfocus_typeof ()
public function string prendi_path_corrente ()
public function window prendi_win_la_prima ()
public function window prendi_win_la_ultima ()
public function string u_getfocus_nome ()
public function integer dw_importfile (string k_argomenti, ref datawindow k_dw_import)
public function window prendi_win_next ()
public function string crea_file (string k_nome_file)
public function window prendi_win_attiva ()
public function integer prendi_num_win_uguale (string k_nome_win)
public function datetime prendi_x_datins ()
public function datetime prendi_dataora ()
public function string prendi_path_corrente_da_registro ()
public function integer suona_motivo (string k_file_motivo, unsignedinteger k_flag)
public function string setta_path_default ()
public function string prendi_x_utente ()
public function string profilestring_leggi_scrivi (integer k_key, string k_key_1, string k_key_2)
public function st_esito db_commit_1 ()
public function st_esito db_rollback_1 ()
public function window prendi_win_uguale_handle (long k_handle)
public function string errori_gestione (st_errori_gestione kst_errori_gestione)
public function boolean u_listview_scroll (listview klv_1, integer k_riga)
public function integer dw_saveas (string k_argomenti, readonly datawindow k_dw_save)
public function string prendi_win_attiva_titolo ()
public function string errori_scrivi_esito (string k_operazione, st_esito kst_esito)
public function integer dw_importfile_set_row (string k_argomenti, ref datawindow k_dw_import)
public subroutine mostra_windows_attiva ()
public function string dw_copia_attributi_generici (ref datastore k_ds_source, datawindow k_dw_target)
public function boolean if_is_running ()
public function integer dw_salva_righe (string k_argomenti, readonly datawindow k_dw_save)
public function integer dw_ripri_righe (string k_argomenti, ref datawindow k_dw_import)
public function integer dw_ripri_righe (string k_argomenti, ref datastore k_ds_import, string k_titolo)
public function integer dw_salva_righe (string k_argomenti, readonly datastore k_ds_save, string k_titolo)
public function uo_d_std_1 u_getfocus_dw ()
public function integer errori_conta_righe (string k_path_nome_file)
public function string errori_scrivi_esito (st_esito kst_esito)
public function long dw_setta_riga (string k_argomenti, ref datawindow k_dw)
public function integer dw_importfile (st_open_w kst_open_w, ref datawindow kdw_import)
public function string profilestring_leggi_scrivi (string k_key, string k_key_1, string k_key_2)
public function window prendi_win_x_id_programma (string a_id_programma)
public subroutine u_toolbar_nascondi ()
public subroutine u_toolbar_mostra ()
public subroutine u_toolbar_programmi_avviso_allarme (boolean a_avviso_allarme)
private function string errori_scrivi_esito (string k_operazione, st_esito kst_esito, string k_path_nome_file)
private function string errori_scrivi_esito_server (string a_operazione, st_esito ast_esito)
private function integer dw_salva_arg (string k_argomenti, readonly datawindow k_dw_save)
private function integer dw_salva_arg (string k_argomenti, readonly datastore k_ds_save, string k_titolo, long k_riga_posizione)
private function integer u_toolbar_programmi (st_toolbar_programmi kst_toolbar_programmi, window k_window)
public function integer u_toolbar_programmi_aggiungi (window k_window)
public function integer u_toolbar_programmi_cancella (window k_window)
public function integer u_toolbar_programmi_attiva (window k_window)
public function integer u_dbg_trace_open (boolean a_attiva)
private function string errori_scrivi_esito_xml (string k_operazione, st_esito kst_esito, string k_path_nome_file)
public function string get_e1_dateformat (date a_date)
public function string get_e1_timeformat (time a_time)
public function string get_e1_dateformat (datetime a_date)
public function string get_e1_timeformat (datetime a_time)
public subroutine set_focus (longlong a_handle)
public subroutine setfocus_handle (longlong k_handle)
public function boolean u_dw_if_col_exist (ref datawindow adw_1, string a_name)
public function boolean u_dw_if_col_exist (ref datastore adw_1, string a_name)
public function date u_get_datefromjuliandate (string a_datajuliana)
public function boolean u_if_chiudi_procedura ()
public function string profilestring_ini (ref st_profilestring_ini kst_profilestring_ini)
public function integer stampa_dw (st_stampe kst_stampe)
public subroutine u_if_profile_base_exists () throws uo_exception
public function st_esito u_open_confdb_ini (integer k_tipo)
public function string get_nome_profile_base ()
public function boolean u_if_run_dev_mode ()
end prototypes

public function string db_commit ();//---
//--- Obsoleta:
//---	x compatibilità e riamasta questa funzione meglio chiamare direttamente la db_commit come sotto
//---
//---
//---	Ritorna 1 char : 0=OK; 1=errore non confermate operazioni sul DB
//---     da 2 char in poi descrizione errore 
//---
string k_return = "0"
st_esito kst_esito

kst_esito = kguo_sqlca_db_magazzino.db_commit( )

if kst_esito.esito <> kkg_esito.ok then
	k_return = "1" + kst_esito.esito + " " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext)
end if

return k_return


end function

public function string db_rollback ();//---
//--- Obsoleta:
//---	x compatibilità e riamasta questa funzione meglio chiamare direttamente la db_commit come sotto
//---
//---
//---	Ritorna 1 char : 0=OK; 1=errore non confermate operazioni sul DB
//---     da 2 char in poi descrizione errore 
//---
string k_return = "0"
st_esito kst_esito

kst_esito = kguo_sqlca_db_magazzino.db_rollback( )

if kst_esito.esito <> kkg_esito.ok then
	k_return = "1" + kst_esito.esito + " " + string(kst_esito.sqlcode) + " " + trim(kst_esito.sqlerrtext)
end if

return k_return


end function

public function window prendi_win_prec ();//
//=== Torna oggetto window, la window precedente a quella attiva
window k_return, k_window


	setnull(k_return)

	k_window = w_main.getfirstsheet()

	if isvalid(k_window) then
		
		k_return = k_window

		k_window = w_main.getnextsheet(k_window)
		
		if isvalid(k_window) then
			
			k_return = k_window
			
		end if
	end if


return k_return

end function

public function string errorlog_riempi_dw (ref datawindow kdw_1, integer k_riga, integer k_col);//===
//=== Legge ERRORLOG scritto da Infomrmix-4gl
//===
int k_file, k_rc 
int k_bytes, k_ctr, k_ctr_1, k_bytes_f, k_righe
string k_record, k_return = "1"
string k_path


//=== Clessidra di attesa
setpointer(hourglass!)

	k_path = profilestring_leggi_scrivi (1, "arch_4gi", " ")

	k_file = fileopen( trim(k_path) + "\errorlog", linemode!, read!, lockreadwrite!)

	if k_file > 0 then
		
//=== Conto il nr. di Errori presenti		
		k_bytes = fileread(k_file, k_record) // legge una riga
		k_righe = 0
		k_ctr = 0
		do while k_bytes <> -100 
			k_bytes = fileread(k_file, k_record) // legge una riga
			
			k_righe++     //conta le righe 
		loop
		fileclose(k_file)


		if k_righe > 0 then 
			k_ctr_1=0
			k_file = fileopen( trim(k_path) + "\errorlog", linemode!, read!, lockreadwrite!)

			k_bytes = fileread(k_file, k_record) // legge una riga

//=== Se piu' di 1000 righe sono troppe
			if k_righe > 5000 then 

				k_ctr_1 = 5000
	
				k_ctr = k_righe
				do while k_ctr_1 < k_ctr // Posizionamento sull'ultimo errore (ultimi 4 rek?) 
					k_bytes = fileread(k_file, k_record) // legge una riga
					k_ctr = k_ctr - 1
				loop
			
			end if
		
			k_record = LeftA(k_record, k_bytes)
			k_rc = kdw_1.setitem (k_riga, k_col, trim(k_record) + "~n~r")

			do while k_bytes > 0 // Leggo le righe dell'errore 
					
				k_bytes = fileread(k_file, k_record) // legge una riga
				if k_bytes <= 0 then
					k_record = " "
				end if

				if LenA(trim(k_record)) > 0 then
					k_rc = kdw_1.setitem (k_riga, k_col, kdw_1.getitemstring (k_riga, k_col) + trim(k_record) + "~n~r")
				end if
				
			loop
			
			fileclose(k_file)

		end if

		k_return = "0"
	else
		k_return = "1"
		
		
	end if

							
return k_return


end function

public function window prendi_win_x_uguale_titolo (string k_titolo);//
//--- Torna oggetto Window uguale x TITOLO (obsolesto) o x ID_PROGRAMMA (consigliato!)
//---
//--- inpu: stringa con il ID_PROGRAMMA   o  il    TITOLO della Window (obsoleto!) 
//
w_super k_return, k_window
string k_sn = "X"


	setnull(k_return)

	k_window = w_main.getfirstsheet()

	if isvalid(k_window) <> false then
		
		if trim(k_window.title) = trim(k_titolo) then

			k_sn = "S"		
		else
			
			do while k_sn = "X"
	
				k_window = w_main.getnextsheet(k_window)
		
				if isvalid(k_window) <> false then
					if trim(k_window.title) = trim(k_titolo) then
						k_sn = "S"		
					end if
				else
					k_sn = "N"		
				end if
			loop
			
		end if
	else
		k_sn = "N"		
	end if

	if k_sn = "S" then		
		k_return = k_window
	else
		
//--- cerca X ID_PROGRAMMA		
		k_return = prendi_win_x_id_programma(trim(k_titolo))
	end if

return k_return

end function

public function object u_getfocus_typeof ();//
//=== Torna il tipo oggetto attivo
object k_typeof
//window kw_1
//
//
//kw_1 = prendi_win_attiva( )
//kw_1.event activate( )

GraphicObject k_which_control

k_which_control = GetFocus()

if isvalid(k_which_control) then

	k_typeof = TypeOf(k_which_control)
else
	setnull(k_typeof)

end if 

return k_typeof



end function

public function string prendi_path_corrente ();//
string k_return 

	
	k_return = trim(GetCurrentDirectory( ) )

  

return k_return




end function

public function window prendi_win_la_prima ();//
//=== Torna oggetto window, la prima window dopo la MDI
//w_g_tab k_window
window k_window

	k_window = w_main.GetFirstSheet()
	if isvalid(k_window) = false then
		setnull(k_window)
//	else
//		if k_window.title = "w_toolbar_programmi" then
//			setnull(k_window)
//		end if
	end if

return k_window

end function

public function window prendi_win_la_ultima ();//
//=== Torna oggetto window, l'ultima window aperta nella MDI
//w_g_tab k_window, k_window1
window k_window, k_window1

	setnull(k_window)

	k_window1 = w_main.GetFirstSheet()
	do while isvalid(k_window1)
		k_window = k_window1
		k_window1 = w_main.GetNextSheet(k_window) 
	loop 

return k_window

end function

public function string u_getfocus_nome ();//
//=== Torna nome oggetto attivo
string k_nome
//window kw_1
//
//
//kw_1 = prendi_win_attiva( )
//kw_1.event activate( )

GraphicObject k_which_control

k_which_control = GetFocus()

if isvalid(k_which_control) then

	k_nome = k_which_control.classname()
else
	k_nome = " "

end if 

return k_nome


end function

public function integer dw_importfile (string k_argomenti, ref datawindow k_dw_import);//
//--- FUNZIONE SOSPESA: PENSARE DI FARLA CON LE NUOVE FUNZIONI DEL DW


//=== Importa righe nel DW se gli argomenti passati nella dw_saveas sono rimasti uguali
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_dw_import  data window su cui fare l'importa righe 
//=== Ritorna: 0 o < 0=Errore, >0=OK
long k_return=0
pointer kp



//---- Se in archivio BASE e' abilitato il flag SPEED_LISTE....
if kGuo_g.get_salva_liste()  then

//	kp=setpointer(hourglass!)

//	k_return = dw_ripri_righe(k_argomenti, k_dw_import)	
	
//	setpointer(kp)
	
end if


return k_return

end function

public function window prendi_win_next ();//
//=== Torna oggetto window, la window successiva a quella attiva
window k_return, k_window


	setnull(k_return)

	k_window = w_main.getnextsheet(k_window)
		
	if isvalid(k_window) then
			
		k_return = k_window
			
	end if


return k_return

end function

public function string crea_file (string k_nome_file);//===
//=== Crea Nuovo File Vuoto
//=== Input: 
//===   Nome file comprensivo del path
//===              I=Aggiungi messaggio Informativo
//=== 
//===
//===   Ritorna: 1 = Operazione non riuscita
//===
int k_file 
int k_bytes, k_ctr, k_ctr_1, k_bytes_f, k_righe
string k_record, k_return = "1"
string k_path
pointer koldpointer

//=== Clessidra di attesa
	koldpointer=setpointer(hourglass!)


	k_path = profilestring_leggi_scrivi (1, "arch_base", " ")

	if not (FileExists (k_nome_file)) then
	
		k_file = fileopen( k_nome_file, linemode!, Write! , LockWrite! )
	
		if k_file > 0 then
			
			k_bytes = filewrite(k_file, "//file creato in automatico il "+string(now(), "dd mmm yyyy hh:mm:ss"))
			
			k_bytes = filewrite(k_file, " ") //Una riga vuota

			k_return = "0"

			fileclose(k_file)
	
		end if
	end if	

	setpointer(koldpointer)

return k_return

end function

public function window prendi_win_attiva ();//
//=== Torna oggetto window, la window attiva
//w_g_tab k_window
window kwindow

	
	//k_window = w_main.getactivesheet()
	kwindow = kGuo_g.kgw_attiva
	if isvalid(kwindow) = false then
		setnull(kwindow)
	end if

return kwindow

end function

public function integer prendi_num_win_uguale (string k_nome_win);//
//=== Torna il numero di window trovatr aperte con lo stesso nome
string k_sn=" "
long k_handle=0
int k_ctr = 0
window kw_window



	kw_window = w_main.getfirstsheet()

	
	do while isvalid(kw_window)

		if upper(kw_window.ClassName( )) = upper(trim(k_nome_win)) then
			k_ctr ++
		end if
		kw_window = w_main.getnextsheet(kw_window)
		
	loop 


return k_ctr

end function

public function datetime prendi_x_datins ();//
//=== Torna data x campo standard x_datins
//



return prendi_dataora()

end function

public function datetime prendi_dataora ();//
//--- Torna data ora
//
datetime k_return
int k_anno, k_anno_procedura
kuf_base kuf1_base


k_return = kguo_g.get_datetime_current( )   // get la data corrente dal DB SERVER

//--- Controllo se data congruente!!!!
k_anno_procedura = kguo_g.kg_anno_procedura

if k_anno_procedura > 0 then
	//k_anno_procedura = kguo_g.get_anno( )
	k_anno = year(date(k_return)) // integer(string(k_return, "yyyy"))
	if k_anno = k_anno_procedura then
	else
		if k_anno < k_anno_procedura then
			kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ko)
			kguo_exception.setmessage("Data Errata" , "Attenzione la data rilevata dal tuo PC " + string(k_return) + " non è congruente con l'anno " + string(k_anno_procedura) &
			 				+ " indicato in Proprietà. USCIRE IMMEDIATAMENTE dalla Procedura! ")
			kguo_exception.messaggio_utente( )
		else
			if (k_anno + 1) = k_anno_procedura then
			else
				kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_ko)
				kguo_exception.setmessage("Data Errata" , "Attenzione la data rilevata dal tuo PC " + string(k_return) + " maggiore dell'anno di esercizio (" + string(k_anno_procedura) + ") indicato in Proprietà Azienda. NON COMPIERE OPERAZIONI Di AGGIORNAMENTO! ")
				kguo_exception.messaggio_utente( )
			end if
		end if
	end if
end if

return k_return

end function

public function string prendi_path_corrente_da_registro ();//
string k_return, k_file, k_ext 
int k_nrc



//--- Leggo dal registro di sistema il valore della PATH del CONFDB.INI
	k_nrc = RegistryGet( "HKEY_LOCAL_MACHINE" +  kkg.path_sep + "Software" + kkg.path_sep + "ATREBBI" +  kkg.path_sep + "M2000.Settings" + kkg.path_sep + "Confdb", &
	             "Path", RegString!, k_return)

	
	if LenA(trim(k_return)) > 0 then
//--- Verifico l'esisenza del file INI
		if not FileExists ( k_return ) then
			k_nrc = -1
		end if
	end if

//--- Chiave non trovata
	if k_nrc < 0 or LenA(trim(k_return)) > 0 then
		
		k_nrc = Pos(kki_nome_profile_base,  kkg.path_sep, 1)
		k_file = Replace (kki_nome_profile_base, k_nrc, 1, " ")
		k_file = trim(k_file)
		
		do 
		
			k_nrc = GetFileOpenName("Selezionare la cartella con il file di Configurazione", &
											k_return, k_file, "ini", &
											 k_file &
											+ "," + k_file + ",") 
								
			if k_nrc <= 0 then
				k_return = " "
			else
				
				k_file =  kkg.path_sep + trim(k_file)
				if upper(trim(k_file)) <> upper(trim(kki_nome_profile_base)) then
					k_return = " "
					k_nrc = -1
				else

//--- Scrivo sul registro di sistema il valore della PATH
					RegistrySet( "HKEY_LOCAL_MACHINE" + kkg.path_sep + "Software" + kkg.path_sep + "ATREBBI" + kkg.path_sep + "M2000.Settings" + kkg.path_sep + "Confdb", &
                            "Path", RegString!, k_return)
					
				end if
	
			end if
			
		loop while k_nrc < 0

	end if
  

return k_return




end function

public function integer suona_motivo (string k_file_motivo, unsignedinteger k_flag);////
////=== Suona il motivo richiesto
////
// 
////=== valori del flags (K_FLAG) possono essere (mmsystem.h) 
////#define SND_SYNC			0x0000  /* suona in modo sincrono (DEFAULT)
////#define SND_ASYNC			0x0001  /* suona in modo asincrono
////#define SND_NODEFAULT		0x0002  /* non usa il suono di default 
////#define SND_MEMORY			0x0004  /* lpszsound punta a memory file
////#define SND_LOOP			0x0008  /* in loop fino al prossimo sndplaysound
////#define SND_NOSTOP			0x0010  /* non si ferma mai
//
//string k_path_risorse
uint k_numdevs
int k_return=0

if kGuo_g.get_attiva_suoni() then
	
	k_numdevs = waveOutGetNumDevs()
	 
	if k_numdevs > 0 then
		if isnull(k_flag) then
			k_flag = 0
		end if
		
	//	k_path_risorse = trim(kGuf_data_base.profilestring_leggi_scrivi(1, "arch_graf", " "))
		
		sndPlaySoundA(trim(kGuo_path.get_risorse()) + "\" + trim(k_file_motivo), 0)
		
		k_return = 0
	else
		k_return = 1
	end if
end if

return k_return			

end function

public function string setta_path_default ();//


	if LenA(trim(kGuo_path.get_procedura())) > 0 then
		
		if DirectoryExists ( trim(kGuo_path.get_procedura()) ) then
			
			ChangeDirectory(trim(kGuo_path.get_procedura())) 
			
		else
			messagebox("Cartella della Proceura non Trovata",&
			           "Non è stato trovato il percorso dove risiedono i file di configurazione~n~r" &
						  + "Cartella cercata:" + trim(kGuo_path.get_procedura()), &
						  information!)
		end if
	else
		messagebox("Cartella della Proceura non Trovata",&
			        "Nessun percorso di risidenza dei file di configurazione impostato~n~r" &
						  + "Possono verificarsi anomalie inaspettate, chidere la Procedura", &
						  stopsign!)
	end if

  

return kGuo_path.get_procedura()




end function

public function string prendi_x_utente ();//
//=== Torna Codice Utente x campo standard x_utente
//



return trim(string(kGuo_utente.get_pwd()))  

end function

public function string profilestring_leggi_scrivi (integer k_key, string k_key_1, string k_key_2);//
//=== Parametri passati :  k_key = 1 x lettura, 2 x scrittura
//=== 							k_key_1 = nome dato da leggere/scrivere
//=== 							k_key_2 = valore eventualmente da scrivere
//
string k_return = ""   
string k_key_3, k_file
int k_leggi=1, k_scrivi=2, k_rc

	
	k_file = kGuo_path.get_procedura() + KKG.PATH_SEP + KKI_NOME_PROFILE_BASE
	
	if LeftA(k_key_1, 9) = "generico." then
		k_key_3 = MidA(k_key_1, 10) 
		k_key_1 = "generico." 
	end if
	
	
//--- se sto personalizzando un campo del 'navigatore' ovvero inizia per tv_larg_campo_
	if LeftA(k_key_1, 14) = "tv_larg_campo_" then

		if fileexists(k_file) then
//--- salvo le dimensioni delle colonne della treeview
			if k_key = k_leggi then 
				k_RETURN = trim(profilestring ( k_file, "autogestiti", trim(k_key_1), "nullo"))
				if k_return = "nullo" then
					k_return = "0"
					k_rc = SetProfileString(k_file, "autogestiti", trim(k_key_1), trim(k_return))
				end if
			else
				k_return = trim(string(SetProfileString(k_file, "autogestiti", trim(k_key_1), trim(k_key_2))))
			end if
		else
			k_return = "NF"
		end if
	
	else
		choose case k_key_1

		
			case "arch_base"
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, "ambiente", "arch_base", "nullo"))
						if k_return = "nullo" then
							k_return = trim(GetCurrentDirectory ( )) + "\db"
							k_rc = SetProfileString(k_file, "ambiente", "arch_base", trim(k_return))
						end if
					else
						k_return = string(SetProfileString(k_file, "ambiente", "arch_base", trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if
	
			case "arch_saveas"
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, "ambiente", "arch_saveas", "nullo"))
						if k_return = "nullo" then
							k_return = trim(GetCurrentDirectory ( )) + "\save_dw"
							k_rc = SetProfileString(k_file, "ambiente", "arch_saveas", trim(k_return))
						end if
					else
						k_return = string(SetProfileString(k_file, "ambiente", "arch_saveas", trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if
	
			case "path_db"
				if fileexists(k_file) then
					k_return = profilestring ( k_file, "ambiente", "arch_base", ".")
				else
					k_return = "NF"
				end if
	
			case "path_help"
				if fileexists(k_file) then
					k_return = profilestring ( k_file, "ambiente", "pathHelp", "nullo")
					if k_return = "nullo" then
						k_return = trim(GetCurrentDirectory ( )) + "\help"
//						k_return = trim(profilestring ( k_file, "ambiente", "path_centrale", "nullo")) 
//						k_rc = SetProfileString(k_file, "ambiente", "pathHelp", trim(k_return))
					end if
				else
					k_return = "NF"
				end if
				
			case "arch_riba"
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, "ambiente", "arch_riba", "nullo"))
						if k_return = "nullo" then
							k_return = trim(GetCurrentDirectory ( )) + "\riba.txt"
							k_rc = SetProfileString(k_file, "ambiente", "arch_riba", trim(k_return))
						end if
					else
						k_return = string(SetProfileString(k_file, "ambiente", "arch_riba", trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if
	
			case "arch_pilota"
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, "ambiente", "arch_pilota", "nullo"))
						if k_return = "nullo" then
							k_return = trim(GetCurrentDirectory ( )) + "\fpilota"
							k_rc = SetProfileString(k_file, "ambiente", "arch_pilota", trim(k_return))
						end if
					else
						k_return = string(SetProfileString(k_file, "ambiente", "arch_pilota", trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if
	
			case "arch_graf"
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, "ambiente", "arch_graf", "nullo"))
						if k_return = "nullo" then
							k_return = trim(GetCurrentDirectory ( )) + "\ICONE"
							k_rc = SetProfileString(k_file, "ambiente", "arch_graf", trim(k_return))
						end if
					else
						k_return = string(SetProfileString(k_file, "ambiente", "arch_graf", trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if
	
			case "arch_4gi"
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, "ambiente", "arch_4gi", "nullo"))
						if k_return = "nullo" then
							k_return = trim(GetCurrentDirectory ( ))
							k_rc = SetProfileString(k_file, "ambiente", "arch_4gi", trim(k_return))
						end if
					else
						k_return = string(SetProfileString(k_file, "ambiente", "arch_4gi", trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if
	
			case "temp" //temporaneo 
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, "ambiente", "temp", "nullo"))
						if k_return = "nullo" then
							k_return = trim(GetCurrentDirectory ( )) + "\temp"
							k_rc = SetProfileString(k_file, "ambiente", "temp", trim(k_return))
						end if
					else
						k_return = string(SetProfileString(k_file, "ambiente", "temp", trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if
	
			case "temp_server" //temporaneo sul server
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, "ambiente", "temp_server", "nullo"))
						if k_return = "nullo" then
							k_return = kGuo_path.get_procedura() + "\temp"
							k_rc = SetProfileString(k_file, "ambiente", "temp_server", trim(k_return))
						end if
					else
						k_return = string(SetProfileString(k_file, "ambiente", "temp_server", trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if
	
			case "nascondi_treeview"
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, "autogestiti", "nascondi_treeview", "nullo"))
						if k_return = "nullo" then
							k_return = "1"
							k_rc = SetProfileString(k_file, "autogestiti", "nascondi_treeview", trim(k_return))
						end if
					else
						k_return = string(SetProfileString(k_file, "autogestiti", "nascondi_treeview", trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if
	
			case "listview_view"
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, "autogestiti", "listview_view", "nullo"))
						if k_return = "nullo" then
							k_return = "0"
							k_rc = SetProfileString(k_file, "autogestiti", "listview_view", trim(k_return))
						end if
					else
						k_return = string(SetProfileString(k_file, "autogestiti", "listview_view", trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if

			case "treeview_listview_dim"
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, "autogestiti", "treeview_listview_dim", "nullo"))
						if k_return = "nullo" then
							k_return = "0"
							k_rc = SetProfileString(k_file, "autogestiti", "treeview_listview_dim", trim(k_return))
						end if
					else
						k_return = string(SetProfileString(k_file, "autogestiti", "treeview_listview_dim", trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if
	
			case "moduli" //dimensione stampa 
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, "moduli", "tabulato", "nullo"))
						if k_return = "nullo" then
							k_return = "1"
							k_rc = SetProfileString(k_file, "moduli", "tabulato", trim(k_return))
						end if
					else
						k_return = string(SetProfileString(k_file, "moduli", "tabulato", trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if

			case "generico."
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, LeftA(k_key_3, 8), MidA(k_key_3, 9), "nullo"))
						if k_return = "nullo" then
							k_return = trim(k_key_2)
							k_rc = SetProfileString(k_file, LeftA(k_key_3, 8), MidA(k_key_3, 9), trim(k_key_2))
						end if
					else
						k_return = string(SetProfileString(k_file, LeftA(k_key_3, 8), MidA(k_key_3, 9), trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if

//--- generico, ovvero il nome passato (k_key_1) diventa anche il tag nel config nella sezione AMBIENTE
//			case "arch_esolver_anag"
			case else
				if fileexists(k_file) then
					if k_key = k_leggi then 
						k_RETURN = trim(profilestring ( k_file, "ambiente", k_key_1, "nullo"))
						if k_return = "nullo" then
							k_return = ""
							if len(trim(k_key_2)) > 0 and trim(k_key_2) <> "nullo" then 
								k_rc = SetProfileString(k_file, "ambiente",  k_key_1, k_key_2)
							else
								k_rc = SetProfileString(k_file, "ambiente",  k_key_1, "")
							end if
						end if
					else
						k_return = string(SetProfileString(k_file, "ambiente", k_key_1, trim(k_key_2)))
					end if
				else
					k_return = "NF"
				end if
				
		end choose
	
	end if
	
	if k_return = "NF" then
		k_return = " "
		messagebox ( "Fallito Accesso in Archivio Base", &
		             "Archivio: " + trim(k_file) + "~n~r" &
						 + "non trovato. ~n~rPrego, Uscire dalla Procedura.", &
						 stopsign!)
	end if


return k_return



end function

public function st_esito db_commit_1 ();//---
//--- Obsoleta:
//---	x compatibilità e riamasta questa funzione meglio chiamare direttamente la db_commit come sotto
//---

return kguo_sqlca_db_magazzino.db_commit( )




end function

public function st_esito db_rollback_1 ();//---
//--- Obsoleta:
//---	x compatibilità e riamasta questa funzione meglio chiamare direttamente la db_commit come sotto
//---

return kguo_sqlca_db_magazzino.db_rollback( )


end function

public function window prendi_win_uguale_handle (long k_handle);//
//=== Torna oggetto window, la window precedente a quella attiva
window k_return, k_window
string k_sn = "X"


	setnull(k_return)

	k_window = w_main.getfirstsheet()

	if isvalid(k_window) <> false then
		
		if handle(k_window) = k_handle then

			k_sn = "S"		
		else
			
			do while k_sn = "X"
	
				k_window = w_main.getnextsheet(k_window)
		
				if isvalid(k_window) <> false then
					if handle(k_window) = k_handle then
						k_sn = "S"		
					end if
				else
					k_sn = "N"		
				end if
			loop
			
		end if
	else
		k_sn = "N"		
	end if

	if k_sn = "S" then		
		k_return = k_window
	else
		setnull(k_return)
	end if

return k_return

end function

public function string errori_gestione (st_errori_gestione kst_errori_gestione);//
//---- gestione centralizzata degli errori della procedura
//
//
st_esito kst_esito
 

if kst_errori_gestione.esito > " " then 
else
	kst_errori_gestione.esito = "1"
end if
if isnull(kst_errori_gestione.nome_oggetto) then kst_errori_gestione.nome_oggetto = ""
if isnull(kst_errori_gestione.SQLdbcode) then kst_errori_gestione.SQLdbcode = 0
if isnull(kst_errori_gestione.SQLErrText) then kst_errori_gestione.SQLErrText = ""
if isnull(kst_errori_gestione.SQLsyntax) then kst_errori_gestione.SQLsyntax = ""
choose case kst_errori_gestione.esito
	case kkg_esito.ok 
		kst_esito.sqlerrtext = "Informa: "
	case kkg_esito.db_wrn	
		kst_esito.sqlerrtext = "Warning: "
	case else
		kst_esito.sqlerrtext = "Errore: "
end choose
kst_esito.sqlerrtext += &
						+ "oggetto= " + trim(kst_errori_gestione.nome_oggetto) &
						+ "; dbcode= " + string(kst_errori_gestione.SQLdbcode) &
                  + " - " + trim(kst_errori_gestione.SQLErrText) &
						+ "; Query= " + trim(kst_errori_gestione.SQLsyntax) &
						+ "; Utente= " + kGuo_utente.get_codice()
if kst_errori_gestione.sqlca.sqlcode <> 0 then 
	kst_esito.sqlcode = kst_errori_gestione.sqlca.sqlcode
else
	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
	else
		if kst_errori_gestione.SQLdbcode <> 0 then
			kst_esito.sqlcode = kst_errori_gestione.SQLdbcode
		else
			kst_esito.sqlcode = 0
		end if
	end if
end if
errori_scrivi_esito("W", kst_esito) 



CHOOSE CASE kst_errori_gestione.SQLdbcode

//	CASE -01,-02 
//		MessageBox("Problemi sul DataBase",  &
//			"Collegamento con il DataBase fallito.~n~r" &
//			+ "Prego, provare a riconnettersi")


//informix	case -1811, -349, -1803, -25580 //--- manca connessione 
	case 	-4060, -40197, -40501, -40613, -49918, -49919, -49920, -4221
		
		try 
			kst_esito.sqlerrtext = "Tentativo di Ri-connessione al DB... " 
			errori_scrivi_esito("W", kst_esito) 
			sleep (5) // un attimo di attesa....
//--- tentativo di connessione al db.....
			if not kguo_sqlca_db_magazzino.db_riconnetti( ) then
				MessageBox("Programma non operativo", "Persa la Connessione dati al DB, il programma verrà chiuso.", information!)
				halt close
			end if
		catch (uo_exception kuo_exception)
			if MessageBox("Programma non operativo", "Persa la Connessione al DB, vuoi ritentare? Altrimenti il programma verrà chiuso.", question!, yesno!, 2) = 1 then
				kguo_sqlca_db_magazzino.db_disconnetti( )
				kguo_sqlca_db_magazzino.db_connetti( )
			else
				halt close
			end if
		finally

		end try
		
		
	CASE -04  // errore strano interno
		MessageBox("Codice programma errato",  &
			"Probabile errore interno di programmazione. " &
			+ "Non è possibile proseguire correttamente l'operazione!!" + "~n~r" &
			+ trim(kst_errori_gestione.SQLErrText) + "~n~r" &
			+ "oggetto: " + trim(kst_errori_gestione.nome_oggetto)  + "~n~r" &
			+ "syntax: " + trim(kst_errori_gestione.sqlsyntax)  + "~n~r"  &
			+ "dbcode: " + string(kst_errori_gestione.sqldbcode) + "~n~r" &
			+ "sqlcode: " + string(kst_errori_gestione.sqlca))


END CHOOSE



return "0"


end function

public function boolean u_listview_scroll (listview klv_1, integer k_riga);//---
//--- Scroll di una Listview fino alla riga indicata
//--- ritorno: TRUE = ok; FALSE =KO
//---
long k_rc
boolean k_return
CONSTANT int k_LVM_FIRST = 4096
CONSTANT int k_LVM_ENSUREVISIBLE = k_LVM_FIRST  + 19

	if k_riga < 0 then k_riga = 1		
	if k_riga > klv_1.totalitems() then
		k_riga = klv_1.totalitems()
	end if
	if k_riga > 1 then k_riga -= 1      //--- posizionamento piu' in alto rispetto alla riga trovata
	k_rc = Send(Handle(klv_1), k_LVM_ENSUREVISIBLE ,k_riga,0)
	if k_rc < 0 or isnull(k_rc) then
		k_return = false
	else
		k_return = true
	end if

return k_return
end function

public function integer dw_saveas (string k_argomenti, readonly datawindow k_dw_save);//
//=== Salva i dati del DW e gli argomenti passati
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_dw_save  data window
//=== Ritorna: 1=Errore, 0=OK
long k_return=0
pointer kp



kp = setpointer(hourglass!)


	k_return = dw_salva_arg (k_argomenti, k_dw_save)
	

setpointer(kp)


return k_return

end function

public function string prendi_win_attiva_titolo ();//
//=== Torna oggetto window, la window attiva
//w_g_tab k_window
window k_window
string titolo = " "

	
//	k_window = w_main.getactivesheet()
	k_window = kGuo_g.kgw_attiva
	if isvalid(k_window)  then
		titolo = k_window.title
	end if

return titolo

end function

public function string errori_scrivi_esito (string k_operazione, st_esito kst_esito);//---
//---
//--- Gestione scrittura/lettura Errori su file LOG
//--- Input: 
//---   		Operazione W=Aggiungi errore; R=Leggi ultimo Errore; "D" Azzera file; I=Aggiungi messaggio Informativo
//---   		struttura  ST_ESITO
//--- Ritorna: "D" o "W" se operazioni rispettive o OK
//---          se era "R" allora torna con l'ultimo errore verificato
//---          "1"  nessuna operazione riuscita 
//---
//--- ESEMPIO:
//---			kst_esito.nome_oggetto = this.classname()
//---			kst_esito_err.esito = kkg_esito.DB_KO
//---			kst_esito_err.sqlcode = sqlca.sqlcode
//---			kst_esito_err.sqlerrtext = trim(sqlca.sqlerrtext)
//---			kGuf_data_base.errori_scrivi_esito("W", kst_esito_err) 
//---			
string k_return = "1"
boolean k_path_ok=true


//--- Clessidra di attesa
setpointer(kkg.pointer_attesa)

	
if k_path_ok then	
	k_return = errori_scrivi_esito (k_operazione, kst_esito,  kGuo_path.get_nome_file_errori_txt())
end if

//--- scrive errore sul Server in XML 
errori_scrivi_esito_server(k_operazione, kst_esito)


setpointer(kkg.pointer_default)
						
return k_return



end function

public function integer dw_importfile_set_row (string k_argomenti, ref datawindow k_dw_import);//
//=== SETTA la RIGA 
//=== nel DW se gli argomenti passati nella dw_saveas sono rimasti uguali
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_dw_import  data window su cui fare l'importa righe 
//=== Ritorna: 0 o < 0=Errore, >0=OK
//
pointer kpointer
int k_file 
int k_bytes //, k_ctr
long k_return=0, k_riga_scroll
string k_path, k_nome_file, k_argomenti_sav,  k_argomenti_sav_chiave, k_sort
long k_argomenti_sav_setrow
string k_flag



kpointer = setpointer(hourglass!)


k_path = trim(profilestring_leggi_scrivi(ki_profilestring_operazione_leggi, "arch_saveas", ""))
//k_path = profilestring ( kGuo_path.get_procedura() + KK_NOME_PROFILE_BASE, "ambiente", "arch_saveas", "\at_com\saveas")

if isnull(k_dw_import.title) or LenA(trim(k_dw_import.title)) = 0 or trim(k_dw_import.title) = "none" then
	k_nome_file = trim(k_dw_import.dataobject) + "_1"
else
	k_nome_file = trim(k_dw_import.dataobject)+trim(k_dw_import.title)
end if

k_file = fileopen( trim(k_path) + "\" + k_nome_file + ".arg", linemode!, read!, lockreadwrite!)
if k_file < 1 then
	k_return = 0

else
	
	if isnull(k_argomenti) or k_argomenti = "" then
		k_argomenti = " "
	else
		k_argomenti = trim(k_argomenti)
	end if

	k_bytes = fileread(k_file, k_sort) //leggo SORT del dw salvati in prec

//=== Cerco il rek con gli argomenti uguali 
	k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti del numero riga x setrow
	k_argomenti_sav_setrow = long(k_argomenti_sav)
		
	k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti circa la CHIAVE di lettura
	k_argomenti_sav_chiave = (k_argomenti_sav)
	
	if isnull(k_argomenti_sav_chiave) or k_argomenti_sav_chiave = "" then
		k_argomenti_sav_chiave = " "
	end if
	
	do  while k_argomenti <> k_argomenti_sav_chiave and k_bytes > 0 
		k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti del dw salvati in prec
		if k_bytes > 0 then
			k_argomenti_sav_chiave += "~h0D" +"~h0A" + k_argomenti_sav  //dovrebbe 0A=newLine; 0D=ret.Carr.
		end if
	loop
	k_argomenti_sav_chiave += "~h0D" +"~h0A" 

	if k_argomenti = k_argomenti_sav_chiave or k_argomenti = " " then
		if k_argomenti_sav_setrow > 1 and k_dw_import.rowcount() >= k_argomenti_sav_setrow then
			
			k_return = k_argomenti_sav_setrow
			
			k_dw_import.selectrow(0, false)
			k_dw_import.selectrow(k_argomenti_sav_setrow, true)
			if k_argomenti_sav_setrow > 5 then
				k_riga_scroll = k_argomenti_sav_setrow - 5
			else
				k_riga_scroll = 1
			end if
			k_dw_import.scrolltorow(k_riga_scroll)
			k_dw_import.setrow(k_argomenti_sav_setrow)
			
		end if

	else
		k_return = 0
	end if

	k_file = fileclose(k_file)
	
end if

setpointer(kpointer)


return k_return


end function

public subroutine mostra_windows_attiva ();//---
//--- Mostra la Windows Attiva
//---
w_g_tab w1_g_tab

w1_g_tab = this.prendi_win_attiva( )

if isvalid(w1_g_tab) then 
	w1_g_tab.show( )
	w1_g_tab.setfocus( )
	w1_g_tab.bringtotop = true
end if

	

end subroutine

public function string dw_copia_attributi_generici (ref datastore k_ds_source, datawindow k_dw_target);//---
//--- Copia da DS a DW gli attributi come il VISIBLE
//--- 
//---
//--- parametri di input:
//--- 
//---    k_ds_source  la ds sorgente
//---    k_dw_target  la dw in cui copiare
//---
//--- parametro di out: true=ok
//---
string k_return
string  k_rcx, k_string, k_nome 
int k_ciclo_ctr



//--- copia Proprieta' PRINT ORIENTATIONE della dw
	k_rcx=k_dw_target.modify("DataWindow.Print.Orientation= '" + trim(k_ds_source.describe("DataWindow.Print.Orientation")) + "'")

	k_string = k_string + k_rcx 		

//--- 
	k_ciclo_ctr = 1
	k_nome=k_dw_target.describe("#"+trim(string(k_ciclo_ctr))+".name")
	do while k_nome<>"!" // len(trim(ki_tab_nome_oggetto[k_ciclo_ctr, 1])) > 0  

		
//--- copia Proprieta' VISIBLE
		k_rcx=k_dw_target.modify(k_nome + ".Visible = " + k_ds_source.Describe(k_nome + ".Visible") + " " )

		k_string = k_string + k_rcx 		
		
		k_ciclo_ctr++
		k_nome=k_dw_target.describe("#"+trim(string(k_ciclo_ctr))+".name")

	loop


return  trim(k_string) 

end function

public function boolean if_is_running ();
//
//String ls_name
//If Handle(GetApplication()) > 0 Then
//	ls_name = GetApplication().AppName + Char(0)
//	CreateMutex(0, True, ls_name)
//	If GetLastError() = 183 Then Return True
//End If

//OleObject locator,service,props
//String ls_query = &
// 'select name , description from Win32_Process where name = "' + ls_name  + '" '  //"textpad.exe"'
//int num, ret, i
//locator = CREATE OleObject
//ret = locator.ConnectToNewObject("WbemScripting.SWbemLocator");
//service = locator.ConnectServer();
//props = service.ExecQuery(ls_query);
//num = props.count()
//
//if num> 0 then return true

Return False

end function

public function integer dw_salva_righe (string k_argomenti, readonly datawindow k_dw_save);//
//=== Salva i dati del DW e gli argomenti passati
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_dw_save  data window
//=== Ritorna: 1=Errore, 0=OK
int k_file 
int k_bytes, k_pos_start
long k_return=0
string k_path, k_nome_file, k_riga, k_sort
kuf_utility kuf1_utility
pointer kp


kp=setpointer(hourglass!)




	if k_dw_save.rowcount() > 0  then
	
		k_path = trim(profilestring_leggi_scrivi(ki_profilestring_operazione_leggi, "arch_saveas", ""))
		//k_path = profilestring ( kGuo_path.get_procedura() + KK_NOME_PROFILE_BASE, "ambiente", "arch_saveas", "\at_m2000\saveas")
	
		if isnull(k_dw_save.title) or LenA(trim(k_dw_save.title)) = 0 or trim(k_dw_save.title) = "none" then
			k_nome_file = trim(k_dw_save.dataobject) + "_1"
		else
			k_nome_file = trim(k_dw_save.dataobject)+trim(k_dw_save.title)
		end if
	
		kuf1_utility = create kuf_utility
		k_nome_file = kuf1_utility.u_stringa_cmpnovocali(k_nome_file)   // cmpatta il nome file 

		k_file = fileopen( trim(k_path) + "\" + k_nome_file + ".arg", linemode!, write!, lockreadwrite!,replace!)
	
		if k_file < 1 then
	
			k_return = 1
	
		else
		
	//=== Acchiappo il SORT
			k_sort = trim(k_dw_save.Object.DataWindow.Table.Sort)
			if LenA(k_sort) = 0 or k_sort = "?" then
				k_sort = " "
			end if
			k_bytes = filewrite(k_file, k_sort) //scrivo i parametri di sort
			
			if k_bytes < 1 then
				k_return = 1
			else
	
	//=== Aggiungo agli argomenti la riga su cui sono posizionato 			
				k_riga = string(k_dw_save.getrow(), "0000000000")
				if isnull(k_riga) then
					k_riga = "0000000000"
				end if
				k_bytes = filewrite(k_file, k_riga) //Scrive il nr riga di getrow
		
				if k_bytes < 1 then
					k_return = 1
				else
	
					if LenA(trim(k_argomenti)) = 0 then
						k_bytes = filewrite(k_file, " ") //Riscrivo il vecchio fle
					else
						k_bytes = filewrite(k_file, trim(k_argomenti)) //Riscrivo il vecchio fle
					end if
					if k_bytes < 1 then
						k_return = 1
					else
		
	//
	//--- FUNZIONE SOSPESA: PENSARE DI FARLA CON LE NUOVE FUNZIONI DEL DW
						if k_dw_save.saveas( (trim(k_path) + "\" + k_nome_file + ".txt"), text!, false) < 0 then
							k_return = 1
						end if
						
					end if
			
					k_file = fileclose(k_file)
					
				end if
			end if
		end if
	end if	 

setpointer(kp)

return k_return

end function

public function integer dw_ripri_righe (string k_argomenti, ref datawindow k_dw_import);//
//=== Importa righe nel DW se gli argomenti passati nella dw_saveas sono rimasti uguali
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_dw_import  data window su cui fare l'importa righe 
//=== Ritorna: 0 o < 0=Errore, >0=OK
int k_return
datastore kds_1
pointer kp



	kp=setpointer(hourglass!)
	
	kds_1 = create datastore
	kds_1.dataobject = k_dw_import.dataobject
	
	//k_dw_import.rowscopy ( 1, k_dw_import.rowcount() , primary!, kds_1, 1, primary! )
	
	k_return=dw_ripri_righe(k_argomenti, kds_1,k_dw_import.title)

	if kds_1.rowcount() > 0 then
		kds_1.rowscopy ( 1, kds_1.rowcount() , primary!, k_dw_import, 1, primary! )
	end if
	
	destroy kds_1
	
	setpointer(kp)
	


return k_return

end function

public function integer dw_ripri_righe (string k_argomenti, ref datastore k_ds_import, string k_titolo);//
//=== Importa righe nel DW se gli argomenti passati nella dw_saveas sono rimasti uguali
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_ds_import  data window su cui fare l'importa righe 
//=== Ritorna: 0 o < 0=Errore, >0=OK
//
int k_file 
int k_bytes //, k_ctr
long k_return=0
string k_path, k_nome_file, k_argomenti_sav,  k_argomenti_sav_chiave, k_sort
long k_argomenti_sav_setrow
kuf_utility kuf1_utility
pointer kp



	kp=setpointer(hourglass!)
	
	k_path = trim(profilestring_leggi_scrivi(ki_profilestring_operazione_leggi, "arch_saveas", "")) 
	//k_path = profilestring ( kGuo_path.get_procedura() + KK_NOME_PROFILE_BASE, "ambiente", "arch_saveas", "save_dw\")
	
	//k_len_name = len(dw_save.DataObject)
	//	k_nome_file = mid(k_ds_import.DataObject,4,7) + right(k_ds_import.DataObject,1)
	//	k_nome_file = trim(k_ds_import.DataObject)
	
	if isnull(k_titolo) or LenA(trim(k_titolo)) = 0 or trim(k_titolo) = "none" then
		k_nome_file = trim(k_ds_import.dataobject) + "_1"
	else
		k_nome_file = trim(k_ds_import.dataobject)+trim(k_titolo)
	end if
	
	kuf1_utility = create kuf_utility
	k_nome_file = kuf1_utility.u_stringa_cmpnovocali(k_nome_file)   // cmpatta il nome file 
	
	k_file = fileopen( trim(k_path) + kkg.path_sep + k_nome_file + ".arg", linemode!, read!, lockreadwrite!)
	
	if k_file < 1 then
	
		k_return = 0
	
	else
	
		if isnull(k_argomenti) or k_argomenti = "" then
			k_argomenti = " "
		else
			k_argomenti = trim(k_argomenti)
		end if
	
		k_bytes = fileread(k_file, k_sort) //leggo SORT del dw salvati in prec
	
	//=== Cerco il rek con gli argomenti uguali 
		k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti del numero riga x setrow
		k_argomenti_sav_setrow = long(trim(k_argomenti_sav))
			
		k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti circa la CHIAVE di lettura
		k_argomenti_sav_chiave = (k_argomenti_sav)
		
		if isnull(k_argomenti_sav_chiave) or k_argomenti_sav_chiave = "" then
			k_argomenti_sav_chiave = " "
		end if
		
		do  while trim(k_argomenti) <> trim(k_argomenti_sav_chiave) and k_bytes > 0 
	
			k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti del dw salvati in prec
			if k_bytes > 0 then
				k_argomenti_sav_chiave += "~h0D" +"~h0A" + k_argomenti_sav  //dovrebbe 0A=newLine; 0D=ret.Carr.
			end if
		loop
		if trim(k_argomenti) <> trim(k_argomenti_sav_chiave) then
			k_argomenti_sav_chiave += "~h0D" +"~h0A" 
		end if
	
		if k_argomenti = k_argomenti_sav_chiave or k_argomenti = " " then
	
			k_return = k_ds_import.importfile( (trim(k_path) + kkg.path_sep + k_nome_file + ".txt")) //" + string(k_ctr, "000"))) 
	
			if k_return < 1 then
				k_return = 0
			else
				if k_argomenti_sav_setrow > 0 then
					k_return = k_argomenti_sav_setrow   // nr riga su cui era posizionato (setrow())
				else
					k_return = 1
				end if
	
				if LenA(trim(k_sort)) > 0 then
					k_ds_import.setsort (k_sort)
					k_ds_import.sort ()
				end if
	
				k_ds_import.triggerevent(retrieveend!)
				
				k_ds_import.resetupdate()
			end if	
				
		else
			
			k_return = 0
			
		end if

	
		k_file = fileclose(k_file)
	end if	 
	
	setpointer(kp)
	


return k_return

end function

public function integer dw_salva_righe (string k_argomenti, readonly datastore k_ds_save, string k_titolo);//
//=== Salva i dati del DW e gli argomenti passati
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_ds_save  data window
//===   k_titolo  titolo x comporre il nome-file
//=== Ritorna: 1=Errore, 0=OK
int k_file 
int k_bytes, k_pos_start
long k_return=0
string k_path, k_nome_file, k_riga, k_sort
kuf_utility kuf1_utility
pointer kp


kp=setpointer(hourglass!)




	if k_ds_save.rowcount() > 0  then
	
		k_path = trim(profilestring_leggi_scrivi(ki_profilestring_operazione_leggi, "arch_saveas", "")) 
		//k_path = profilestring ( kGuo_path.get_procedura() + KK_NOME_PROFILE_BASE, "ambiente", "arch_saveas", "\at_m2000\saveas")
	
		if isnull(k_titolo) or LenA(trim(k_titolo)) = 0 or trim(k_titolo) = "none" then
			k_nome_file = trim(k_ds_save.dataobject) + "_1"
		else
			k_nome_file = trim(k_ds_save.dataobject)+trim(k_titolo)
		end if
	
		kuf1_utility = create kuf_utility
		k_nome_file = kuf1_utility.u_stringa_cmpnovocali(k_nome_file)   // cmpatta il nome file 
		
		k_file = fileopen( trim(k_path) + "\" + k_nome_file + ".arg", linemode!, write!, lockreadwrite!,replace!)
	
		if k_file < 1 then
	
			k_return = 1
	
		else
		
	//=== Acchiappo il SORT
			k_sort = trim(k_ds_save.Object.DataWindow.Table.Sort)
			if LenA(k_sort) = 0 or k_sort = "?" then
				k_sort = " "
			end if
			k_bytes = filewrite(k_file, k_sort) //scrivo i parametri di sort
			
			if k_bytes < 1 then
				k_return = 1
			else
	
	//=== Aggiungo agli argomenti la riga su cui sono posizionato 			
				k_riga = string(k_ds_save.getrow(), "0000000000")
				if isnull(k_riga) then
					k_riga = "0000000000"
				end if
				k_bytes = filewrite(k_file, k_riga) //Scrive il nr riga di getrow
		
				if k_bytes < 1 then
					k_return = 1
				else
	
					if LenA(trim(k_argomenti)) = 0 then
						k_bytes = filewrite(k_file, " ") //Riscrivo il vecchio fle
					else
						k_bytes = filewrite(k_file, trim(k_argomenti)) //Riscrivo il vecchio fle
					end if
					if k_bytes < 1 then
						k_return = 1
					else
		
	//
	//--- FUNZIONE SOSPESA: PENSARE DI FARLA CON LE NUOVE FUNZIONI DEL DW
						if k_ds_save.saveas( (trim(k_path) + "\" + k_nome_file + ".txt"), text!, false) < 0 then
							k_return = 1
						end if
						
					end if
			
					k_file = fileclose(k_file)
					
				end if
			end if
		end if
	end if	 

setpointer(kp)

return k_return

end function

public function uo_d_std_1 u_getfocus_dw ();//
//=== Torna il tipo oggetto attivo
uo_d_std_1 k_typeof
//window kw_1
//
//
//kw_1 = prendi_win_attiva( )
//kw_1.event activate( )

GraphicObject k_which_control

k_which_control = GetFocus()

if isvalid(k_which_control) then

	if k_which_control.typeof( ) = DataWindow! then
		k_typeof = k_which_control
	else
		setnull(k_typeof)
	end if
else
	setnull(k_typeof)

end if 

return k_typeof



end function

public function integer errori_conta_righe (string k_path_nome_file);//=======================================================================================
//===
//=== Conta le righe su File di LOG
//===
//=== Input: 
//===   File			nome file (compreso di path) 
//===
//=== Ritorna: 	il numero di righe trovate
//===
//=== ESEMPIO:
//===			kst_esito_err.esito = kkg_esito.DB_KO
//===			kst_esito_err.sqlcode = sqlca.sqlcode
//===			kst_esito_err.sqlerrtext = trim(sqlca.sqlerrtext)
//===			kGuf_data_base.errori_conta_righe(k_nome_file) 
//===			
//=======================================================================================
//===			
int k_file 
int k_bytes, k_ctr, k_righe
string k_record



//=== Clessidra di attesa
setpointer(hourglass!)


	k_righe = 0

	k_file = fileopen( trim(k_path_nome_file), linemode!, read!, lockreadwrite!)

	if k_file > 0 then
		
//=== Conto il nr. di Errori presenti		
		k_bytes = fileread(k_file, k_record) // legge una riga
		k_ctr = 0
		do while k_bytes <> -100 

			k_righe++     //conta le righe 
			k_bytes = fileread(k_file, k_record) // legge una riga
			
		loop

		fileclose(k_file)
		
	end if

							
return k_righe



end function

public function string errori_scrivi_esito (st_esito kst_esito);//===
//=== Scrive Errori su LOG
//===
//=== Input: ST_ESITO
//=== Ritorna: "D" o "W" se operazioni rispettive o OK
//===          se era "R" allora torna con l'ultimo errore verificato
//===          "1"  nessuna operazione riuscita 
//===
//=== ESEMPIO:
//===			kst_esito_err.esito = kkg_esito.DB_KO
//===			kst_esito_err.sqlcode = sqlca.sqlcode
//===			kst_esito_err.sqlerrtext = trim(sqlca.sqlerrtext)
//===			kGuf_data_base.errori_scrivi_esito(kst_esito_err) 
//===			
string k_return = "1"
boolean k_path_ok=true


//--- Clessidra di attesa
setpointer(kkg.pointer_attesa)

//kguo_path.u_drectory_create(kGuo_path.get_base())

if k_path_ok then
	k_return = errori_scrivi_esito ("W", kst_esito,  kGuo_path.get_nome_file_errori_txt_all())
end if

setpointer(kkg.pointer_default)
						
return k_return

end function

public function long dw_setta_riga (string k_argomenti, ref datawindow k_dw);//
//=== Cerca la riga nel DW su cui ero settato nell'ultimo SAVE_DW se 
//=== gli argomenti passati nella dw_saveas sono rimasti uguali
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_ds_import  data window su cui fare l'importa righe 
//===
//===
//=== Ritorna: la riga da SETTARE sul DW se c'è
//
int k_file 
int k_bytes //, k_ctr
long k_return=0
string k_path, k_nome_file, k_argomenti_sav,  k_argomenti_sav_chiave, k_sort, k_titolo
long k_argomenti_sav_setrow
kuf_utility kuf1_utility
pointer kp



	kp=setpointer(hourglass!)
	
	k_path = trim(profilestring_leggi_scrivi(ki_profilestring_operazione_leggi, "arch_saveas", "")) 
//	k_path = profilestring ( kGuo_path.get_procedura() + KK_NOME_PROFILE_BASE, "ambiente", "arch_saveas", "save_dw\")
	
	//k_len_name = len(dw_save.DataObject)
	//	k_nome_file = mid(k_ds_import.DataObject,4,7) + right(k_ds_import.DataObject,1)
	//	k_nome_file = trim(k_ds_import.DataObject)
	
	k_titolo = k_dw.title
	if isnull(k_titolo) or LenA(trim(k_titolo)) = 0 or trim(k_titolo) = "none" then
		k_nome_file = trim(k_dw.dataobject) + "_1"
	else
		k_nome_file = trim(k_dw.dataobject)+trim(k_titolo)
	end if

	kuf1_utility = create kuf_utility
	k_nome_file = kuf1_utility.u_stringa_cmpnovocali(k_nome_file)   // cmpatta il nome file 

	k_file = fileopen( trim(k_path) + "\" + k_nome_file + ".arg", linemode!, read!, lockreadwrite!)
	
	if k_file < 1 then
	
		k_return = 0
	
	else
	
		if isnull(k_argomenti) or k_argomenti = "" then
			k_argomenti = " "
		else
			k_argomenti = trim(k_argomenti)
		end if
	
		k_bytes = fileread(k_file, k_sort) //leggo SORT del dw salvati in prec
	
	//=== Cerco il rek con gli argomenti uguali 
		k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti del numero riga x setrow
		k_argomenti_sav_setrow = long(trim(k_argomenti_sav))
			
		k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti circa la CHIAVE di lettura
		k_argomenti_sav_chiave = (k_argomenti_sav)
		
		if isnull(k_argomenti_sav_chiave) or k_argomenti_sav_chiave = "" then
			k_argomenti_sav_chiave = " "
		end if
		
		do  while trim(k_argomenti) <> trim(k_argomenti_sav_chiave) and k_bytes > 0 
	
			k_bytes = fileread(k_file, k_argomenti_sav) //leggo argomenti del dw salvati in prec
			if k_bytes > 0 then
//				k_argomenti_sav_chiave += "~h0D" +"~h0A" + k_argomenti_sav  //dovrebbe 0A=newLine; 0D=ret.Carr.
				k_argomenti_sav_chiave += "~h0D" + k_argomenti_sav  //dovrebbe 0A=newLine; 0D=ret.Carr.
			end if
		loop
		if trim(k_argomenti) <> trim(k_argomenti_sav_chiave) then
			k_argomenti_sav_chiave += "~h0D" //+"~h0A" 
		end if
	
		if k_argomenti = k_argomenti_sav_chiave or k_argomenti = " " then

			if k_argomenti_sav_setrow > 0 then
				k_return = k_argomenti_sav_setrow   // nr riga su cui era posizionato (setrow())
			else
				k_return = 0
			end if
	
		else
			
			k_return = 0
			
		end if

	
		k_file = fileclose(k_file)
	end if	 
	
	setpointer(kp)
	


return k_return

end function

public function integer dw_importfile (st_open_w kst_open_w, ref datawindow kdw_import);//
//=== Importa righe nel DW se gli argomenti passati nella dw_saveas sono rimasti uguali
//=== Input: st_open_w  con keyN valorizzato 
//===  		 k_dw_import  data window su cui fare l'importa righe 
//=== Ritorna: 0 o < 0=Errore, >0=OK
long k_return=0
string k_key=""



//---- Se in archivio BASE e' abilitato il flag SPEED_LISTE....
if kGuo_g.get_salva_liste()  then

		k_key = trim(kst_open_w.key1)+trim(kst_open_w.key2)+trim(kst_open_w.key3) &
	      		  +trim(kst_open_w.key4)+trim(kst_open_w.key5)+trim(kst_open_w.key6) &
		  		  +trim(kst_open_w.key7)+trim(kst_open_w.key8)+trim(kst_open_w.key9)
		
		k_return = kGuf_data_base.dw_importfile(trim(k_key), kdw_import)
	
end if


return k_return

end function

public function string profilestring_leggi_scrivi (string k_key, string k_key_1, string k_key_2);//---
//--- Scrive sul file CONFDB.INI  
//---
//--- inp: 	k_key = '1' x lettura, '2' x scrittura o meglio:
//---				ki_profilestring_operazione_leggi
//---				ki_profilestring_operazione_scrivi
//--- 			k_key_1 = nome dato da leggere/scrivere
//--- 			k_key_2 = valore eventualmente da scrivere
//--- out: valore estratto (se lettura)

return profilestring_leggi_scrivi( integer(k_key),k_key_1,k_key_2)



end function

public function window prendi_win_x_id_programma (string a_id_programma);//
//--- Torna oggetto Window uguale x ID_PROGRAMMA (consigliato!) quella x TITOLO è OBSOLETA!!!!!!!!!!!
//---
//--- inpu: stringa con il ID_PROGRAMMA  
//
w_super k_return, k_window
string k_sn = "X"


	setnull(k_return)

	k_window = w_main.getfirstsheet()

	if isvalid(k_window) <> false then
		
		if k_window.get_id_programma() = trim(a_id_programma)then

			k_sn = "S"		
		else
			
			do while k_sn = "X"
	
				k_window = w_main.getnextsheet(k_window)
		
				if isvalid(k_window) <> false then
					if trim(k_window.get_id_programma( ) ) = trim(a_id_programma) then
						k_sn = "S"		
					end if
				else
					k_sn = "N"		
				end if
			loop
			
		end if
	else
		k_sn = "N"		
	end if

	if k_sn = "S" then		
		k_return = k_window
	else
		setnull(k_return)
	end if

return k_return

end function

public subroutine u_toolbar_nascondi ();//---
//--- chiama la funzione per nascondere la toolbar dei programmi aperti
//---
//---

#if defined PBNATIVE then
if kguo_g.if_w_toolbar_programmi( ) then  //la gestione della vecchia toolbar finta è attiva?
	w_toolbar_programmi.visible = false
end if
#end if




end subroutine

public subroutine u_toolbar_mostra ();//---
//--- chiama la funzione per nascondere la toolbar dei programmi aperti
//---

#if defined PBNATIVE then
if kguo_g.if_w_toolbar_programmi( ) then  //la gestione della vecchia toolbar finta è attiva?
	w_toolbar_programmi.visible = true
end if
#end if



end subroutine

public subroutine u_toolbar_programmi_avviso_allarme (boolean a_avviso_allarme);//---
//--- Imposta l'avviso di ALLERT sulla toolbar dei programmi 
//---
w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.posizione_tab = 0

if kguo_g.if_w_toolbar_programmi( ) then

	if isvalid(w_toolbar_programmi) then
		w_toolbar_programmi.set_p_memo(a_avviso_allarme)
	end if

end if



end subroutine

private function string errori_scrivi_esito (string k_operazione, st_esito kst_esito, string k_path_nome_file);//-------------------------------------------------------------------------------------------------
//---
//--- Scrive su File di LOG
//---
//--- Input: 
//---   Operazione 	W=Aggiungi errore (+X per formato XML); R=Leggi ultimo Errore; "D" Azzera file
//---              		     I=Aggiungi messaggio Informativo (+X per formato XML)
//---   St_esito  		con le indicazioni dell'errore
//---   File				con il nome file (compreso di path) sul quale scrivere
//---
//--- Ritorna: 		"D" o "W" se operazioni rispettive o OK
//---          		se era "R" allora torna con l'ultimo errore verificato
//---         			"1"  nessuna operazione riuscita 
//---
//--- ESEMPIO:
//---			kst_esito.nome_oggetto = this.classname()
//---			kst_esito_err.esito = kkg_esito.DB_KO
//---			kst_esito_err.sqlcode = sqlca.sqlcode
//---			kst_esito_err.sqlerrtext = trim(sqlca.sqlerrtext)
//---			kGuf_data_base.errori_scrivi_esito("W", kst_esito_err) 
//---			
//-------------------------------------------------------------------------------------------------
//---			
int k_file 
int k_bytes, k_ctr, k_ctr_1, k_bytes_f, k_righe
string k_record, k_return = "1", k_errore



//--- Clessidra di attesa 
setpointer(hourglass!)

if isnull(Kst_esito.sqlcode) then Kst_esito.sqlcode = 0
if isnull(Kst_esito.SQLErrText) then Kst_esito.SQLErrText = ""
if isnull(Kst_esito.descrizione) then Kst_esito.descrizione = ""
if isnull(Kst_esito.nome_oggetto) then Kst_esito.nome_oggetto = "non segnalato"
kst_esito.esito = trim(kst_esito.esito)
kst_esito.descrizione = trim(kst_esito.descrizione) 

if Kst_esito.sqlcode = 0 then
	k_errore = trim(kst_esito.SQLErrText) + " - oggetto: " + trim(kst_esito.nome_oggetto)
else
	k_errore = "Esito cod. (sqlcode)= " + string(Kst_esito.sqlcode) + " - " + trim(kst_esito.SQLErrText) + " - oggetto: " + trim(kst_esito.nome_oggetto)
end if	


if k_operazione = "R" then  // Leggo l'ultimo errore

	k_file = fileopen( trim(k_path_nome_file), linemode!, read!, lockreadwrite!)

	if k_file > 0 then
		
//--- Conto il nr. di Errori presenti		
		k_bytes = fileread(k_file, k_record) // legge una riga
		k_righe = 0
		k_ctr = 0
		do while k_bytes <> -100 
			if LeftA(k_record, 10) = "Errore del" then
				k_ctr++
			end if
			k_bytes = fileread(k_file, k_record) // legge una riga
			
			k_righe++     //conta le righe 
		loop


//--- Se piu' di 3000 righe AZZERO FILE
		if k_righe > 3000 then 
			k_operazione = "D"
		end if

		if k_ctr > 0 then // Se ho trovato errori
			fileclose(k_file)
			k_file = fileopen( trim(k_path_nome_file), linemode!, read!, lockreadwrite!)
			k_ctr_1=0

			k_bytes = fileread(k_file, k_record) // legge una riga
			if LeftA(k_record, 10) = "Errore del" then
				k_ctr_1++
			end if

			do while k_ctr_1 < k_ctr // Posizionamento sull'ultimo errore (ultimi 4 rek?) 
				k_bytes = fileread(k_file, k_record) // legge una riga
				if LeftA(k_record, 10) = "Errore del" then
					k_ctr_1++
				end if
			loop
					
			k_return = LeftA(k_record, k_bytes)
			k_return = k_return + "~n~r" //space(50)// - k_bytes )
			do while k_bytes > 0 // Leggo le righe dell'errore 
				
				k_bytes = fileread(k_file, k_record) // legge una riga
				if k_bytes <= 0 then
					k_record = " "
				end if
				k_return = k_return + "~n~r" + k_record 
			loop
			

		end if
		
	end if
else
	
	if k_operazione = "W" or k_operazione = "I" then // Scrivo messaggio formato lineare
	
//--- Conto le righe Se piu' di 3000 AZZERO FILE
		k_righe = errori_conta_righe(k_path_nome_file)
		if k_righe > 3000 or k_righe = 0 then 
			k_file = fileopen( trim(k_path_nome_file), linemode!, write!, lockreadwrite!, Replace!)
			if k_file > 0 then
				if LenA(trim(k_return)) = 0 then
					k_return = " "
				end if
				k_bytes = filewrite(k_file, "File LOG creato il: " + string(today()) +"  ore: " +  string(now()) ) //La prima riga!!!
				fileClose(k_file)
			end if
		end if

//--- Scrive record di LOG 
		k_file = fileopen( trim(k_path_nome_file), linemode!, write!, lockreadwrite!, Append!)
		if k_file > 0 then
			
			k_bytes = filewrite(k_file, " ") //Una riga vuota
			
			if k_operazione = "W"  then // Scrivo l'errore
				k_record = "Errore del " + string(today(),"dd/mm/yyyy") + " ore " + String(Now( ), "hh:mm:ss") + " - Versione Programma " + string(KKG.VERSIONE) + " - Nome device di rete: " + kguo_g.get_nome_computer()
			else								// Scrivo msg informativo					
				k_record = "Messaggio del " + string(today(),"dd/mm/yyyy") + " ore " + String(Now( ), "hh:mm:ss") + " - Versione Programma " + string(KKG.VERSIONE) + " - Nome device di rete: " + kguo_g.get_nome_computer()
			end if
			k_bytes = filewrite(k_file, k_record) //scrivo la data dell'errore
			if kst_esito.esito <> kkg_esito.ok then
				k_bytes = filewrite(k_file, "Codice Esito (st_esito.esito) = " +  trim(kst_esito.esito)) //scrivo l'errore
			end if
			k_bytes = filewrite(k_file, k_errore) //scrivo l'errore
			k_bytes = filewrite(k_file, " ") //Una riga vuota

			k_return = "W"

		end if
	else

// Scrive messaggio XML se errore GRAVE no Warning
		if (k_operazione = "WX" or k_operazione = "IX")  &
		       	and (kst_esito.esito <> kkg_esito.db_wrn and kst_esito.esito <> kkg_esito.DATI_WRN &
			  		and kst_esito.esito <> kkg_esito.NOT_FND and kst_esito.esito <> kkg_esito.no_aut &
			  		and kst_esito.esito <> kkg_esito.dati_insuff and kst_esito.esito <> kkg_esito.no_esecuzione &
			  		and kst_esito.esito <> kkg_esito.ERR_LOGICO ) then 
	
			errori_scrivi_esito_xml(k_operazione, kst_esito, k_path_nome_file)

////--- Conto le righe Se piu' di 10000 AZZERO FILE
//			k_righe = errori_conta_righe(k_path_nome_file)
//			if k_righe > 10000 or k_righe = 0 then 
//				k_file = fileopen( trim(k_path_nome_file), linemode!, write!, lockreadwrite!, Replace!)
//				if k_file > 0 then
//					if LenA(trim(k_return)) = 0 then
//						k_return = " "
//					end if
//					k_bytes = filewrite(k_file, "<FileLOGcreato>" + string(today()) + "  " +  string(now()) + "</FileLOGcreato>") //La prima riga!!!
//					fileClose(k_file)
//				end if
//			end if
//		
////--- Scrive record di LOG		
//			k_file = fileopen( trim(k_path_nome_file), linemode!, write!, lockreadwrite!, Append!)
//			if k_file > 0 then
//				
//				k_record = "<Istanza id='" + string(kguo_g.get_idprocedura()) + "'>" 
//				if k_operazione = "WX"  then // Scrivo l'errore
//					k_record += "<Errore data='" + string(today(),"dd/mm/yyyy") + " " + String(Now( ), "hh:mm:ss") + "'>" 
//				else								// Scrivo msg informativo					
//					k_record += "<Messaggio data='" + string(today(),"dd/mm/yyyy") + " " + String(Now( ), "hh:mm:ss") + "'>" 
//				end if
//				k_record += "<NomePC>" + kguo_g.get_nome_computer()+ "</NomePC>" 
//				k_record += "<Utente id='" + string(kguo_utente.get_id_utente( ) ) + "'>" + trim(kguo_utente.get_codice()) + " " + trim(kguo_utente.get_nome( )) + "</Utente>"
//				k_record += "<VerProgramma>" + string(KKG.VERSIONE) + "</VerProgramma>"
//				if kst_esito.esito <> kkg_esito.ok then
//					k_record += "<CodiceEsito>" +  kst_esito.esito + "-" +  kst_esito.descrizione + "</CodiceEsito>" 
//				end if
//				k_record += "<Segnalazione>" + trim(k_errore) + "</Segnalazione>"
//				if k_operazione = "WX"  then 
//					k_record += "</Errore>"
//				else								
//					k_record += "</Messaggio>" 
//				end if
//				k_record += "</Istanza>" 
//				k_bytes = filewrite(k_file, k_record) //scrivo la data dell'errore
//				k_return = "W"
//
//			end if
		end if
	end if

	
end if	


if k_operazione = "D" then //Azzero il file 
	fileclose(k_file)
	k_file = fileopen( trim(k_path_nome_file), linemode!, write!, lockreadwrite!, Replace!)
	if k_file > 0 then
		if LenA(trim(k_return)) = 0 then
			k_return = " "
		end if
		k_bytes = filewrite(k_file, "File LOG creato il: " + string(today()) + "  ore: " + string(now()) ) //La prima riga!!!
	end if
end if

if k_file > 0 then
	fileclose(k_file)
end if

							
return k_return



end function

private function string errori_scrivi_esito_server (string a_operazione, st_esito ast_esito);//===
//=== Scrive Errori su LOG del SERVER CENTRALE
//===
//--- Input: 
//---   		Operazione W=Aggiungi errore; R=Leggi ultimo Errore; "D" Azzera file; I=Aggiungi messaggio Informativo
//---   		struttura  ST_ESITO
//=== Ritorna: "D" o "W" se operazioni rispettive o OK
//===          se era "R" allora torna con l'ultimo errore verificato
//===          "1"  nessuna operazione riuscita 
//===
//=== ESEMPIO:
//===			kst_esito_err.esito = kkg_esito.DB_KO
//===			kst_esito_err.sqlcode = sqlca.sqlcode
//===			kst_esito_err.sqlerrtext = trim(sqlca.sqlerrtext)
//===			kGuf_data_base.errori_scrivi_esito(kst_esito_err) 
//===			
string k_return = "1"
string k_nome_file_errori = ""


//--- Clessidra di attesa
setpointer(kkg.pointer_attesa)

//--- se diverso da errore di RETE che altrimenti blocca la scrittura dell'errore allora agiorna il file XML sul server
if ast_esito.sqlcode < -25583 or ast_esito.sqlcode > -25572 then

	k_nome_file_errori = kguo_path.get_nome_path_file_errori_xml( )

//	k_pos1 = pos(ki_nome_file_errori, ".txt", 1)
//	if k_pos1 > 0 then
//		k_nome_file_errori = replace(ki_nome_file_errori, k_pos1 , 4, ".xml")
//	else
//		k_nome_file_errori = trim(k_nome_file_errori) + ".xml"
//	end if
	
	a_operazione = trim(a_operazione) + "X"  // formato XML
	k_return = errori_scrivi_esito (a_operazione, ast_esito, k_nome_file_errori)

end if

setpointer(kkg.pointer_attesa)
						
return k_return



end function

private function integer dw_salva_arg (string k_argomenti, readonly datawindow k_dw_save);//
//=== Salva  'argomenti' passati con il DW
//=== Input: 
//===   k_argomenti  argomenti della dw
//===   k_dw_save  data window
//=== Ritorna: 1=Errore, 0=OK
long k_return=0, k_riga
int k_rc
datastore kds_1
pointer kp


kp=setpointer(hourglass!)

	if k_dw_save.rowcount() > 0 then
		kds_1 = create datastore
		kds_1.dataobject = k_dw_save.dataobject

//---- salva le righe del dw
	//	k_rc = k_dw_save.rowscopy ( 1, k_dw_save.rowcount() , primary!, kds_1, 1, primary! )
		k_rc = k_dw_save.rowscopy ( 1, 1 , primary!, kds_1, 1, primary! )
		
	//	if k_dw_save.getselectedrow(0) > 0 then
	//		kds_1.setrow(k_dw_save.getselectedrow(0) )
	//	end if
		k_riga = k_dw_save.getrow()
		if k_riga > 0 then
		else
			k_riga = 1
		end if
		
		if k_rc > 0 then
			k_return=dw_salva_arg(k_argomenti, kds_1, k_dw_save.title, k_riga) 
		end if
		destroy kds_1 
	end if

setpointer(kp)

return k_return

end function

private function integer dw_salva_arg (string k_argomenti, readonly datastore k_ds_save, string k_titolo, long k_riga_posizione);//
//---	Salva  'argomenti' passati con il DW
//---	Input: 
//---	k_argomenti  argomenti della dw
//---	k_ds_save  datastore
//---	Titolo usato x comporre il nome-file
//---	Ritorna: 1=Errore, 0=OK
//
int k_file 
int k_bytes, k_pos_start
long k_return=0
string k_path, k_nome_file, k_riga, k_sort
kuf_utility kuf1_utility
pointer kp


kp=setpointer(hourglass!)




	if k_ds_save.rowcount() > 0  then
	
		k_path = trim(profilestring_leggi_scrivi(ki_profilestring_operazione_leggi, "arch_saveas", "")) 
		//k_path = profilestring ( kGuo_path.get_procedura() + KK_NOME_PROFILE_BASE, "ambiente", "arch_saveas", kkg.path_sep + "at_m2000" + kkg.path_sep + "saveas")
	
		if isnull(k_titolo) or LenA(trim(k_titolo)) = 0 or trim(k_titolo) = "none" then
			k_nome_file = trim(k_ds_save.dataobject) + "_1"
		else
			k_nome_file = trim(k_ds_save.dataobject)+trim(k_titolo)
		end if
	
		kuf1_utility = create kuf_utility
		k_nome_file = kuf1_utility.u_stringa_cmpnovocali(k_nome_file)   // cmpatta il nome file 
		k_file = fileopen( trim(k_path) +  kkg.path_sep + k_nome_file + ".arg", linemode!, write!, lockreadwrite!,replace!)
	
		if k_file < 1 then
	
			k_return = 1
	
		else
		
	//=== Acchiappo il SORT
			k_sort = trim(k_ds_save.Object.DataWindow.Table.Sort)
			if LenA(k_sort) = 0 or k_sort = "?" then
				k_sort = " "
			end if
			k_bytes = filewrite(k_file, k_sort) //scrivo i parametri di sort
			
			if k_bytes < 1 then
				k_return = 1
			else
	
	//=== Aggiungo agli argomenti la riga su cui sono posizionato 			
//				k_riga = string(k_ds_save.getrow(), "0000000000")
				k_riga = string(k_riga_posizione, "0000000000")
				if isnull(k_riga) then
					k_riga = "0000000000"
				end if
				k_bytes = filewrite(k_file, k_riga) //Scrive il nr riga di getrow
		
				if k_bytes < 1 then
					k_return = 1
				else
	
					if LenA(trim(k_argomenti)) = 0 then
						k_bytes = filewrite(k_file, " ") //Riscrivo il vecchio fle
					else
						k_bytes = filewrite(k_file, trim(k_argomenti)) //Riscrivo il vecchio fle
					end if
					if k_bytes < 1 then
						k_return = 1
					end if
			
					k_file = fileclose(k_file)
					
				end if
			end if
		end if
	end if	 

setpointer(kp)

return k_return

end function

private function integer u_toolbar_programmi (st_toolbar_programmi kst_toolbar_programmi, window k_window);//---
//--- chiama la funzione per aggiungere una voce alla toolbar dei programmi aperti
//---
//--- torna la Posizione della Voce nei tabulatori (0=not ok)
//---


	w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.posizione_tab = 0

	if isvalid(k_window) then
	else
		k_window = prendi_win_attiva()  //altrimenti piglia la prima attiva
	end if
	if isnull(k_window) then
		w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.titolo = "APP.NON RICONOSCIUTA"
		w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.handle = 0
	else
		w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.titolo = k_window.title
		w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.handle = handle(k_window)
	end if
	if w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.handle > 0 then
		choose case true
			case kst_toolbar_programmi.metodo_aggiungi_voce		
				w_toolbar_programmi.toolbar_programmi.aggiungi_voce()
			case kst_toolbar_programmi.metodo_cancella_voce		
				w_toolbar_programmi.toolbar_programmi.cancella_voce()
			case kst_toolbar_programmi.metodo_attiva_voce		
				w_toolbar_programmi.toolbar_programmi.attiva_voce()
		end choose
	end if



return w_toolbar_programmi.toolbar_programmi.kist_toolbar_programmi.posizione_tab



end function

public function integer u_toolbar_programmi_aggiungi (window k_window);//---
//--- chiama la funzione per aggiungere una voce alla toolbar dei programmi aperti
//---
//--- torna la Posizione della Voce nei tabulatori (0=not ok)
//---
int k_return=1

#if defined PBNATIVE then

if kguo_g.if_w_toolbar_programmi( ) then
	st_toolbar_programmi kst_toolbar_programmi
	
	kst_toolbar_programmi.metodo_aggiungi_voce = true
	
	k_return = u_toolbar_programmi(kst_toolbar_programmi, k_window)
end if
#end if

return k_return



end function

public function integer u_toolbar_programmi_cancella (window k_window);//---
//--- chiama la funzione per Cancellare una voce alla toolbar dei programmi aperti
//---
//--- torna la Posizione della Voce cancellata nei tabulatori (0=not ok)
//---
int k_return=1

#if defined PBNATIVE then

if kguo_g.if_w_toolbar_programmi( ) then
	st_toolbar_programmi kst_toolbar_programmi
	
	kst_toolbar_programmi.metodo_cancella_voce = true
	
	k_return = u_toolbar_programmi(kst_toolbar_programmi, k_window)
end if
#end if

return k_return



end function

public function integer u_toolbar_programmi_attiva (window k_window);//---
//--- chiama la funzione per ATTIVARE una voce nella toolbar dei programmi aperti
//---
//--- torna la Posizione della Voce cancellata nei tabulatori (0=not ok)
//---
int k_return

#if defined PBNATIVE then

if kguo_g.if_w_toolbar_programmi( ) then
	st_toolbar_programmi kst_toolbar_programmi
	
	kst_toolbar_programmi.metodo_attiva_voce = true
	
	k_return = u_toolbar_programmi(kst_toolbar_programmi, k_window)
end if
#end if

return k_return



end function

public function integer u_dbg_trace_open (boolean a_attiva);//
int k_return = 0
errorreturn k_rcx
TimerKind ltk_kind
//CHOOSE 	CASE text
//	CASE "None"    
//		ltk_kind = TimerNone!
//	CASE "Clock" 
ltk_kind = Clock!
//	CASE "Process"   
//ltk_kind = Process!
//	CASE "Thread"      ltk_kind = Thread!
//END CHOOSE

if a_attiva = ki_trace_attiva then
else
	
	if ki_trace_attiva then
		TraceEnd()
		TraceClose()
		k_return = 2 // CHIUSA
	else
	
		k_rcx = TraceOpen(kguo_path.get_base( ) + "\m2000.trace.pbp",ltk_kind)
		
		if k_rcx = Success!  then 
			// Enable trace activities. Enabling ActLine!
			// enables ActRoutine! implicitly
			TraceEnableActivity(ActESQL!)
			TraceEnableActivity(ActUser!)
			TraceEnableActivity(ActError!)
			TraceEnableActivity(ActLine!)
			TraceEnableActivity(ActObjectCreate!)
			TraceEnableActivity(ActObjectDestroy!)
			TraceEnableActivity(ActGarbageCollect!)
			
			k_rcx = TraceBegin("Trace_M2000")
			
			if k_rcx <> FileNotOpenError! then 
				ki_trace_attiva=true
				k_return = 1 // APERTA
			end if
		end if		
	end if		
end if

return k_return

end function

private function string errori_scrivi_esito_xml (string k_operazione, st_esito kst_esito, string k_path_nome_file);//-------------------------------------------------------------------------------------------------
//---
//--- Scrive su File di LOG
//---
//--- Input: 
//---   Operazione 	W=Aggiungi errore (+X per formato XML); R=Leggi ultimo Errore; "D" Azzera file
//---              		     I=Aggiungi messaggio Informativo (+X per formato XML)
//---   St_esito  		con le indicazioni dell'errore
//---   File				con il nome file (compreso di path) sul quale scrivere
//---
//--- Ritorna: 		"D" o "W" se operazioni rispettive o OK
//---          		se era "R" allora torna con l'ultimo errore verificato
//---         			"1"  nessuna operazione riuscita 
//---
//--- ESEMPIO:
//---			kst_esito.nome_oggetto = this.classname()
//---			kst_esito_err.esito = kkg_esito.DB_KO
//---			kst_esito_err.sqlcode = sqlca.sqlcode
//---			kst_esito_err.sqlerrtext = trim(sqlca.sqlerrtext)
//---			kGuf_data_base.errori_scrivi_esito("W", kst_esito_err) 
//---			
//-------------------------------------------------------------------------------------------------
//---			
int k_file 
int k_bytes, k_ctr, k_ctr_1, k_bytes_f, k_righe
string k_record, k_return = "1", k_errore

PBDOM_Document kpbdom_doc
PBDOM_Element kpbdom_el_root, kpbdom_el_node1, kpbdom_el_node11, kpbdom_el_node111 //, kpbdom_el_node1111, kpbdom_el_node11111
PBDOM_PROCESSINGINSTRUCTION kpbdom_proc


//--- Clessidra di attesa
setpointer(kkg.pointer_attesa)

try
				
	kpbdom_doc = CREATE PBDOM_Document
	kpbdom_proc = create PBDOM_PROCESSINGINSTRUCTION
	kpbdom_el_node1 = create PBDOM_Element
	kpbdom_el_node11 = create PBDOM_Element
	kpbdom_el_node111 = create PBDOM_Element
//	kpbdom_el_node1111 = create PBDOM_Element
//	kpbdom_el_node11111 = create PBDOM_Element

//--- Conto le righe Se piu' di 10000 Salvo e AZZERO il FILE
	k_righe = errori_conta_righe(k_path_nome_file)
	if k_righe > 10000 or k_righe = 0 then 
		filecopy(trim(k_path_nome_file), trim(k_path_nome_file) + ".save", true)   
		k_file = fileopen( trim(k_path_nome_file), linemode!, write!, lockreadwrite!, Replace!, EncodingUTF8!)
		if k_file > 0 then
			if LenA(trim(k_return)) = 0 then
				k_return = " "
			end if
			k_bytes = filewrite(k_file, "<FileLOGcreato>" + string(today()) + "  " +  string(now()) + "</FileLOGcreato>") //La prima riga!!!
			fileClose(k_file)
		end if
	end if
	
	kpbdom_doc.newdocument("x")
	
//--- Scrive record di LOG		TextMode!
	k_file = fileopen( trim(k_path_nome_file), linemode!, write!, Shared!, Append!, EncodingUTF8!)
	if k_file > 0 then
		kpbdom_el_root = kpbdom_doc.getrootelement( )
		
		kpbdom_el_node1.setname("Istanza")
		kpbdom_el_node1.setattribute("id", string(kguo_g.get_idprocedura()))
		kpbdom_el_node1.setattribute("data", string(today(),"dd/mm/yyyy") + " " + String(Now( ))) //, "hh:mm:ss "))
		kpbdom_el_node1.setattribute("M2000", string(KKG.VERSIONE))
		kpbdom_el_root.addcontent(kpbdom_el_node1)

		kpbdom_el_node11.setname("Messaggio")
//--- Scrivo tipo errore grave o meno
		if kst_esito.esito = kkg_esito.ko &
		      or kst_esito.esito = kkg_esito.db_ko &
		      or kst_esito.esito = kkg_esito.NO_AUT &
		      or kst_esito.esito = kkg_esito.blok then
//		if k_operazione = "WX"  then // Scrivo l'errore
			kpbdom_el_node11.setattribute("tipo", "A")
		else								// Scrivo msg informativo					
			kpbdom_el_node11.setattribute("tipo", "W")
		end if
		kpbdom_el_node1.addcontent(kpbdom_el_node11)
		
		kpbdom_el_node111.setname("NomePC")
		kpbdom_el_node111.addcontent(trim(kguo_g.get_nome_computer()))
		kpbdom_el_node11.addcontent(kpbdom_el_node111)
		
		if isvalid(kpbdom_el_node111) then destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
		kpbdom_el_node111.setname("Utente")
		kpbdom_el_node111.setattribute("id", string(kguo_utente.get_id_utente( )))
		kpbdom_el_node111.addcontent(trim(kguo_utente.get_codice()) + " " + trim(kguo_utente.get_nome( )))
		kpbdom_el_node11.addcontent(kpbdom_el_node111)
		
		if isvalid(kpbdom_el_node111) then destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
		kpbdom_el_node111.setname("Esito")
		if kst_esito.esito <> kkg_esito.ok then
		else
			kst_esito.esito = ""
		end if
		if trim(kst_esito.descrizione) > " " then
		else
			kst_esito.descrizione = ""
		end if
		kpbdom_el_node111.setattribute("cod", trim(kst_esito.esito))
		kpbdom_el_node111.addcontent(trim(kst_esito.descrizione))
		kpbdom_el_node11.addcontent(kpbdom_el_node111)
		
		if trim(kst_esito.SQLErrText) > " " then
			k_errore = trim(kst_esito.SQLErrText) 
		else
			k_errore = "nessuna" 
		end if	
		if isvalid(kpbdom_el_node111) then destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
		kpbdom_el_node111.setname("Segnalazione")
		if Kst_esito.sqlcode <> 0 then
		else
			Kst_esito.sqlcode = 0
		end if	
		kpbdom_el_node111.setattribute("sqlcode", string(Kst_esito.sqlcode))
		kpbdom_el_node111.addcontent(trim(k_errore))
		kpbdom_el_node11.addcontent(kpbdom_el_node111)

		if trim(kst_esito.nome_oggetto) > " " then
		else
			kst_esito.nome_oggetto = ""
		end if
		if isvalid(kpbdom_el_node111) then destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
		kpbdom_el_node111.setname("Oggetto")
		kpbdom_el_node111.addcontent(trim(kst_esito.nome_oggetto))
		kpbdom_el_node11.addcontent(kpbdom_el_node111)

//--- Salva l'intero documento su stringa x fare il file TXT			
		k_record = kpbdom_doc.SaveDocumentIntoString() 
		k_record = mid(k_record, 4, len(k_record) - 8)  // salta il tag iniziale <x> e finale </x>

		k_bytes = filewrite(k_file, k_record) //scrivo la data dell'errore
		k_return = "W"

	end if

CATCH ( PBDOM_Exception pbde )
//	kguo_exception.inizializza( )
//	kguo_exception.setmessage( "Errore durante Generazione XML", pbde.getmessage() )
//	throw kguo_exception
	
catch (uo_exception kuo_exception) 
//	throw kuo_exception
	
finally
	if k_file > 0 then
		fileclose(k_file)
	end if
	if isvalid(kpbdom_doc) then destroy kpbdom_doc
	if isvalid(kpbdom_el_node1) then destroy kpbdom_el_node1
	if isvalid(kpbdom_el_node11) then destroy kpbdom_el_node11
	if isvalid(kpbdom_el_node111) then destroy kpbdom_el_node111
//	if isvalid(kpbdom_el_node1111) then destroy kpbdom_el_node1111
//	if isvalid(kpbdom_el_node11111) then destroy kpbdom_el_node11111

	setpointer(kkg.pointer_default)

end try


							
return k_return



end function

public function string get_e1_dateformat (date a_date);//
//=== Torna data nel formato richiesto da E1
//


return string(a_date, "mmddyyyy")

end function

public function string get_e1_timeformat (time a_time);//
//=== Torna time nel formato richiesto da E1
//


return string(a_time, "hhmmss")

end function

public function string get_e1_dateformat (datetime a_date);//
//=== Torna data nel formato richiesto da E1
//


return string(a_date, "mmddyyyy")

end function

public function string get_e1_timeformat (datetime a_time);//
//=== Torna time nel formato richiesto da E1
//


return string(a_time, "hhmmss")

end function

public subroutine set_focus (longlong a_handle);//
//=== Setta il Focus, utile per dare il fuoco da Windows a un oggetto PB
//

//SetFocus(a_handle)  // This function gets the handle from PB. 


end subroutine

public subroutine setfocus_handle (longlong k_handle);//
//=== Attiva Window conoscendo l'handle
//
window kw_window


	kw_window = w_main.getfirstsheet()

	if isvalid(kw_window) then
		
		do while k_handle <> handle(kw_window)  

			kw_window = w_main.getnextsheet(kw_window)
			if not isvalid(kw_window) then
				exit
			end if

		loop 

		if k_handle = handle(kw_window) and isvalid(kw_window) then
			kw_window.setfocus()
		end if
	end if



end subroutine

public function boolean u_dw_if_col_exist (ref datawindow adw_1, string a_name);//
boolean k_return = true


if adw_1.Describe(trim(a_name) + ".Name") = "!" then
	k_return = false
end if

Return k_return

end function

public function boolean u_dw_if_col_exist (ref datastore adw_1, string a_name);//
boolean k_return = true


if adw_1.Describe(trim(a_name) + ".Name") = "!" then
	k_return = false
end if

Return k_return

end function

public function date u_get_datefromjuliandate (string a_datajuliana);//
//=== Torna date dal formato data Juliano:  1 secolo + anno + nr giorno dell'anno
//
date k_return = date(0)
string k_datajx
int k_secolo
int k_anno
int k_gg

k_datajx = trim(a_datajuliana)
if len(k_datajx) = 6 and isnumber(k_datajx)then
	k_secolo = integer(left(k_datajx,1)) - 1  // secolo 1 = 2000, 2=2100, 3=2200 ....
	k_anno = 2000 + 100 * k_secolo + integer(mid(k_datajx,2,2))
	k_gg = integer(mid(k_datajx,4,3)) - 1

	k_return = relativedate(date(k_anno, 01, 01), k_gg)
end if

return k_return

end function

public function boolean u_if_chiudi_procedura ();//
boolean k_return = true


if not isnull(prendi_win_la_ultima( )) then
	if not isnull(prendi_win_la_prima( )) then
		if prendi_win_la_ultima( ) <> prendi_win_la_prima( ) then
			k_return = false
		end if
	end if
end if

return k_return 
end function

public function string profilestring_ini (ref st_profilestring_ini kst_profilestring_ini);//---
//---
//--- Legge e Scrive archivio .ini 
//---
//--- Inp/Out: st_profilestring_ini
//---					utente     	= utente di login (x defautl è il codice_utente di lavoro)
//---					file    		= nome logico del file (indicare solo se non è standard) 
//---					titolo   	= label nel file ini (x default imposta = "ambiente")
//---					nome    		= nome del campo che contiene il valore
//---					valore     	= valore di lettura/scrittura 
//---             operazione 	= 	ki_profilestring_operazione_leggi (1)  		x leggere il valore è il default se valore non indicato
//---										ki_profilestring_operazione_scrivi (2)			x scrivere il valore è il default se valore Indicato (aggiunge a quello vecchio)
//---										ki_profilestring_operazione_inizializza (3)	x inizializzare a " " 
//---             esito   	 	= torna 0 = OK, W=ok ma nessun valore, 1=ERRORE GRAVE, 2=non autorizzato all'accesso al file 
//---
//---  Ret: Torna descrizione dell'errore
//---
string k_return = ""   
string k_key_3
int k_rc
st_esito kst_esito

	
try
	kst_profilestring_ini.esito = "0"
	
//--- Imposta i valori di default come se manca il nome file allora lo sostituisco con il nome titolo 	
	if trim(kst_profilestring_ini.titolo) > " " then
	else
		kst_profilestring_ini.titolo = "ambiente"
	end if
	if trim(kst_profilestring_ini.utente ) > " " then
	else
		kst_profilestring_ini.utente = kGuo_utente.get_codice()
	end if
	if trim(kst_profilestring_ini.operazione) > " " then
	else
		if trim(kst_profilestring_ini.valore) > " " then
			kst_profilestring_ini.operazione = ki_profilestring_operazione_scrivi 
		else
			kst_profilestring_ini.operazione = ki_profilestring_operazione_leggi 
		end if
	end if
	if trim(kst_profilestring_ini.file) > " " then
	else
		kst_profilestring_ini.file = kst_profilestring_ini.titolo
	end if


	choose case lower(trim(kst_profilestring_ini.file))
			
		case "ambiente"
			kst_profilestring_ini.path = trim(kGuo_path.get_procedura()) 	
			kst_profilestring_ini.nome_file = trim(KKG.PATH_SEP + KKI_NOME_PROFILE_BASE) 	
			
		case "base_personale"
			kst_profilestring_ini.path = trim(kGuo_path.get_procedura()) 	
			kst_profilestring_ini.nome_file = trim(KKG.PATH_SEP + KKI_NOME_PROFILE_BASE) 	
	
		case "treeview"
			kst_profilestring_ini.path = trim(kGuo_path.get_procedura()) 	
			kst_profilestring_ini.nome_file = trim(KKG.PATH_SEP + KKi_NOME_PROFILE_BASE_TREEVIEW) 	
	
		case "window"
			kst_profilestring_ini.path = trim(kGuo_path.get_procedura()) 	
			kst_profilestring_ini.nome_file = trim(KKG.PATH_SEP + KKi_NOME_PROFILE_BASE_WIN) 	
	
		case "toolbar"
			kst_profilestring_ini.path = trim(kGuo_path.get_procedura()) 	
			kst_profilestring_ini.nome_file = trim(KKG.PATH_SEP + KKi_NOME_PROFILE_BASE_TOOLBAR) 	
	
		case "stampe"
			kst_profilestring_ini.path = trim(kGuo_path.get_procedura()) 	
			kst_profilestring_ini.nome_file = trim(KKG.PATH_SEP + KKi_NOME_PROFILE_BASE_PRN) 	
	
		case "risorse_grafiche"
			kst_profilestring_ini.titolo = "ambiente"
			kst_profilestring_ini.path = trim(kGuo_path.get_procedura()) 	
			kst_profilestring_ini.nome_file = trim(KKG.PATH_SEP + KKI_NOME_PROFILE_BASE) 	
			
		case else
			kst_profilestring_ini.path = trim(kGuo_path.get_procedura()) 	
			kst_profilestring_ini.nome_file = trim(KKG.PATH_SEP + KKI_NOME_PROFILE_BASE) 	
	
	end choose

//--- esiste la cartella?
	if not DirectoryExists ( kst_profilestring_ini.path ) then
		kst_profilestring_ini.esito = "1"
		k_return = "Cartella Centrale della Procedura Non Trovata, percorso cercato:~n~r" &
		           + kst_profilestring_ini.path 
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = k_return
		kst_esito.esito = kkg_esito.ko
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
	
//--- esiste il file?
	if kst_profilestring_ini.esito = "0" then
		if not FileExists ( kst_profilestring_ini.path+kst_profilestring_ini.nome_file ) then
			kst_profilestring_ini.esito = "1"
			k_return = "Creo Archivio di Configurazione Programma perche' non trovato, percorso:~n~r" &
						  + kst_profilestring_ini.path+kst_profilestring_ini.nome_file 

//---- crea nuovo file vuoto
			crea_file( kst_profilestring_ini.path+kst_profilestring_ini.nome_file )
			
		end if
	end if

//--- se tutto ok
	if kst_profilestring_ini.esito = "0" then

		if kst_profilestring_ini.operazione = ki_profilestring_operazione_leggi then 
			k_RETURN = trim(profilestring &
													( kst_profilestring_ini.path &
													  + kst_profilestring_ini.nome_file, &
													  trim(kst_profilestring_ini.titolo), & 
													  trim(kst_profilestring_ini.nome), &
													  "nullo"))
			if k_return = "" or k_return = "nullo" then
				kst_profilestring_ini.esito = "W"
				kst_profilestring_ini.valore = " "
				k_return = "Nessun Valore trovato in lettura archivio di Configurazione:~n~r" &
					  + kst_profilestring_ini.path+kst_profilestring_ini.nome_file 
//				kst_esito.sqlcode = 0
//				kst_esito.sqlerrtext = k_return
//				kst_esito.esito = kkg_esito.ko
//				kguo_exception.inizializza( )
//				kguo_exception.set_esito(kst_esito)
//				throw kguo_exception
			else
//				if lower(k_return) <> "nullo" then
					kst_profilestring_ini.valore = k_return
//				end if
			end if
		end if											  

		if kst_profilestring_ini.operazione = ki_profilestring_operazione_scrivi & 
			or lower(k_return) = "nullo" then
			k_rc = SetProfileString &
													( kst_profilestring_ini.path &
													  + kst_profilestring_ini.nome_file, &
													  trim(kst_profilestring_ini.titolo), & 
													  trim(kst_profilestring_ini.nome), &
													  trim(kst_profilestring_ini.valore) ) 
			if k_rc = -1 then
				kst_profilestring_ini.esito = "2"
				k_return = "Accesso in scrittura in archivio di Configurazione FALLITO:~n~r" &
					  + kst_profilestring_ini.path+kst_profilestring_ini.nome_file 
				kst_esito.sqlcode = 0
				kst_esito.sqlerrtext = k_return
				kst_esito.esito = kkg_esito.ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
													  
		end if

		if kst_profilestring_ini.operazione = ki_profilestring_operazione_inizializza then 
			k_rc = SetProfileString &
													( kst_profilestring_ini.path &
													  + kst_profilestring_ini.nome_file, &
													  trim(kst_profilestring_ini.titolo), & 
													  trim(kst_profilestring_ini.nome), &
													  " " ) 
			if k_rc = -1 then
				kst_profilestring_ini.esito = "2"
				k_return = "Accesso archivio di Configurazione per inizializzazione FALLITO:~n~r" &
					  + kst_profilestring_ini.path+kst_profilestring_ini.nome_file 
				kst_esito.sqlcode = 0
				kst_esito.sqlerrtext = k_return
				kst_esito.esito = kkg_esito.ko
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if											  


	end if	

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	
end try

return k_return



end function

public function integer stampa_dw (st_stampe kst_stampe);//
//--- Inp: la struttura st_stampe
//--- Rit: 0 = OK,  1 = ERRORE
//
int k_return = 0
int k_file, k_rcn=0 
int k_bytes, k_pos_start
string k_path, k_nome_file, k_riga, k_argomenti
st_open_w kst_open_w
st_esito kst_esito
pointer oldpointer  // Declares a pointer variable
kuf_menu_window kuf1_menu_window
kuf_utility kuf1_utility


//=== Puntatore Cursore da attesa.....
//oldpointer = SetPointer(HourGlass!)

	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kuf1_utility = create kuf_utility

//--- SALVO I DATI DEL DW (o DS) CON I PARAMETRI DI ENTRATA --------------------------------------------------------------------------------------------------
	k_path = trim(profilestring_leggi_scrivi(ki_profilestring_operazione_leggi, "arch_saveas", "")) 
	//k_path = trim(profilestring ( kGuo_path.get_procedura() + kkg.path_sep + "confdb.ini", "ambiente", "arch_saveas", "save_dw"))

	if right(k_path, 1) <> "\" and right(k_path, 1) <> "/" then k_path += kkg.path_sep
		
//--- Crea il path, se non esiste
	if len(k_path) > 0 then
		kguo_path.u_drectory_create(k_path)
	end if
		 
	k_nome_file = trim(kst_stampe.DataObject)
	k_nome_file = kuf1_utility.u_stringa_cmpnovocali(k_nome_file)   // cmpatta il nome file 

	k_file = fileopen( trim(k_path) + k_nome_file + ".arg", linemode!, write!, lockreadwrite!,replace!)

	if k_file < 1 then
		
		kst_esito.sqlerrtext ="Errore in lettura file ~n~r" + trim(k_path) + k_nome_file + ".arg"
		kst_esito.sqlcode = k_file
		kGuo_exception.set_esito (kst_esito)

		k_return = 1

	else

//--- se tipo non indicato, imposto il default....
		if kst_stampe.tipo > " " then
		else
			kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datawindow
		end if
		
//--- Aggiungo agli argomenti la riga su cui ero posizionato 			
		if kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_dw_diretta or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datawindow &
		                        or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_dw_rtf then
			if isvalid(kst_stampe.dw_print) then
				k_riga = string(kst_stampe.dw_print.getrow(), "0000000000")
			else
				k_riga = "0000000000"
			end if
		else
			if kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore &
			                 or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta_BATCH or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_pdf_BATCH then
				if isvalid(kst_stampe.ds_print) then
					k_riga = string(kst_stampe.ds_print.getrow(), "0000000000")
				else
					k_riga = "0000000000"
				end if
			end if
		end if
		if isnull(k_riga) then
			k_riga = "0000000000"
		end if
		k_argomenti = k_riga + "stampa" 

		k_bytes = filewrite(k_file, trim(k_argomenti)) //Riscrivo il vecchio fle

		if k_bytes < 1 then
			k_return = 1
			
			kst_esito.sqlerrtext ="Errore in scrittura file (argomenti)~n~r" + trim(k_path) + k_nome_file + ".arg"
			kst_esito.sqlcode = k_bytes
			kGuo_exception.set_esito (kst_esito)

		else
			if kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore and kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore_diretta &
			           and kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore_diretta_BATCH and kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore_pdf_BATCH then
				
				if isvalid(kst_stampe.dw_print) then
					k_rcn = kst_stampe.dw_print.saveas( (trim(k_path)  + k_nome_file + ".txt"), text!, false) 
					if k_rcn < 0 then
						k_return = 1
					end if
				end if
			else
				if isvalid(kst_stampe.ds_print) then
					k_rcn = kst_stampe.ds_print.saveas( (trim(k_path) + k_nome_file + ".txt"), text!, false)
					if k_rcn < 0 then
						k_return = 1
					end if
				end if
			end if
				
			if k_return = 1 then
				kst_esito.sqlerrtext ="Errore in scrittura file ~n~r" + trim(k_path) + k_nome_file + ".txt"
				kst_esito.sqlcode = k_rcn
				kGuo_exception.set_esito (kst_esito)
			end if
			
		end if

		k_file = fileclose(k_file)

	end if
//--- FINE: SALVO I DATI DEL DW (o DS) CON I PARAMETRI DI ENTRATA --------------------------------------------------------------------------------------------------



//--- S=possibilità di scegliere da pag. a pag.
	if trim(kst_stampe.scegli_pagina) > " " then
	else
		kst_stampe.scegli_pagina = "S"
	end if
//--- titolo stampa
	if trim(kst_stampe.titolo) > " " then
		kst_stampe.titolo = trim(kst_stampe.titolo) //+ ",    u: " + lower(trim (kGuo_utente.get_nome()))
	else
		kst_stampe.titolo = "" //"Stampa per l'utente: " + lower(trim (kGuo_utente.get_nome())) + " "
	end if
//--- Nome del DW
	if trim(kst_stampe.dataobject) > " " then
	else
		if kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore &
				and kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore_diretta &
				and kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore_diretta_BATCH &
				and kst_stampe.tipo <> kuf_stampe.ki_stampa_tipo_datastore_pdf_BATCH then
			kst_stampe.dataobject = kst_stampe.dw_print.dataobject
		else
			kst_stampe.dataobject = kst_stampe.ds_print.dataobject
		end if
	end if
//--- Stampante predefinita
	if trim(kst_stampe.stampante_predefinita) > " " then
	else
		kst_stampe.stampante_predefinita = ""
	end if

	if isvalid(kuf1_utility) then destroy kuf1_utility

	if kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta_BATCH or kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_pdf_BATCH then
		kst_stampe.ds_print.modify("Print.documentname = '"+kst_stampe.titolo+"'")
		if kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta_BATCH then
			if kst_stampe.ds_print.print() < 0 then
				k_return = 1			
			end if
		else
			if kst_stampe.pathfile > " " then
				kst_stampe.ds_print.object.DataWindow.Export.PDF.Method = NativePDF!
				if kst_stampe.ds_print.saveas(kst_stampe.pathfile, PDF!, false) < 0 then
					k_return = 1			
				end if
			end if
		end if
	else

//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
		Kst_open_w.id_programma = kkg_id_programma.stampa
		Kst_open_w.flag_primo_giro = "S"
		Kst_open_w.flag_modalita = kkg_flag_modalita.stampa
		Kst_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
		Kst_open_w.flag_leggi_dw = "N"
		kst_open_w.key12_any = kst_stampe   // dati da stampare
		kst_open_w.flag_where = " "
		
			
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window
	end if
	
				
				
return k_return


end function

public subroutine u_if_profile_base_exists () throws uo_exception;//---
//--- Verifica l'esistenza del file di configurazione di base (confdb.ini)
//---
//--- se assente lancia un uo_exception
//---
string k_file 


k_file = kGuo_path.get_PROCEDURA() + KKG.PATH_SEP + KKi_NOME_PROFILE_BASE
if not FileExists (k_file) then
	kguo_exception.inizializza( )
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_not_fnd )
	kguo_exception.setmessage( "Configurazione Assente", "Non è stato trovato il file di configurazione del programma: " + k_file)
end if


end subroutine

public function st_esito u_open_confdb_ini (integer k_tipo);//===
//=== Legge Errori di M2000
//===
//
string k_file 
st_esito kst_esito
kuf_ole kuf1_ole


//=== Clessidra di attesa
	setpointer(kkg.pointer_attesa)

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""


	k_file = trim(kguo_path.get_procedura( ) + kkg.path_sep + KKI_NOME_PROFILE_BASE)

	if len(trim(k_file)) > 0 then 
	
		kuf1_ole = create kuf_ole
		kst_esito = kuf1_ole.open_txt( k_file )
		if kst_esito.esito <> "0" then
			kst_esito = kuf1_ole.open_doc( k_file )
		end if
		destroy kuf1_ole
			
	end if		
	
	if kst_esito.esito <> kkg_esito.ok then

		kst_esito.sqlerrtext = trim(kst_esito.sqlerrtext) + "~n~r" + "File:" + trim(k_file)
		
	end if		
	
	setpointer(kkg.pointer_default)
							
return kst_esito


end function

public function string get_nome_profile_base ();//---
//--- Verifica l'esistenza del file di configurazione di base (confdb.ini)
//---
//--- out: path + nome file base 
//---
string k_return 


k_return = kGuo_path.get_PROCEDURA() + KKG.PATH_SEP + KKi_NOME_PROFILE_BASE
if isnull(k_return) then 
	k_return = ""
end if

return k_return

end function

public function boolean u_if_run_dev_mode ();//---
//--- Verifica se sta girando in dev mode (da IDE) o nomale
//---
if Handle(GetApplication()) = 0 then
	return true
else
	return false
end if


end function

on kuf_data_base.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_data_base.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
if ki_trace_attiva then
	TraceEnd()
	TraceClose()
end if

end event

