$PBExportHeader$kuf_menu_window.sru
forward
global type kuf_menu_window from nonvisualobject
end type
end forward

global type kuf_menu_window from nonvisualobject
end type
global kuf_menu_window kuf_menu_window

type variables
//
//public constant string kki_primo_giro_si="S"

//--- valore flag tabella st_tab_menu_window.msg_se_gia_open
public string kki_msg_se_gia_open_esponi = "S"  // Espone il msg 
public string kki_msg_se_gia_open_nessuno = "N"  // non espone nulla 
public string kki_msg_se_gia_open_riOpen = "R" // non espone msg e lancia evento U_RIOPEN  se già aperta

private kuf_sicurezza kiuf_sicurezza

//
//private st_tab_menu_window_oggetti kist_tab_menu_window_oggetti[]

//--- suoni open window
constant string kki_suona_motivo_open_w = "Open_w.wav"
constant string kki_suona_motivo_open_w_x_agg = "Open_w_x_agg.wav"
constant string kki_suona_motivo_open_w_x_canc = "Open_w_x_canc.wav"
constant string kki_suona_motivo_fine = "Fine_funz.wav"

end variables

forward prototypes
private subroutine open_run_batch (st_open_w kst_open_w) throws uo_exception
public subroutine if_isnull (st_open_w ast_open_w)
private function boolean connetti () throws uo_exception
public subroutine open_trova (st_open_w ast_open_w)
public subroutine open_filtra (st_open_w ast_open_w)
public subroutine open_conv_calc (st_open_w ast_open_w)
private function boolean autorizza_funzione (st_open_w kst_open_w)
public function boolean get_st_tab_menu_window_anteprima (ref st_tab_menu_window_anteprima ast_tab_menu_window_anteprima)
public function boolean get_id_menu_window (ref st_tab_menu_window_oggetti kst_tab_menu_window_oggetti)
public function boolean open_w_tabelle_da_ds (datastore ads_dati_window, string a_modalita) throws uo_exception
public subroutine open_w_tabelle (st_open_w kst_open_w)
public function string get_nome_oggetto (string a_menu_id)
end prototypes

private subroutine open_run_batch (st_open_w kst_open_w) throws uo_exception;//---
//--- Lancio operazioni Batch
//---

kuf_sv_skedula kuf1_sv_skedula




		try
			
			
			kuf1_sv_skedula = create kuf_sv_skedula 
			
//--- lancia eventi da schedulatore			
			kuf1_sv_skedula.run_eventi_sched(kst_open_w)
			
			
			destroy kuf1_sv_skedula
			

		catch (uo_exception kuo_exception)
		
		
		finally
			
			if isvalid(	kuf1_sv_skedula) then destroy kuf1_sv_skedula
			
		
		end try
		

end subroutine

public subroutine if_isnull (st_open_w ast_open_w);//---
//--- Toglie i valori a NULL

if isnull(ast_open_w.campo_where) then ast_open_w.campo_where = "" 
if isnull(ast_open_w.flag_adatta_win ) then ast_open_w.flag_adatta_win = "" 
if isnull(ast_open_w.flag_cerca_in_lista ) then ast_open_w.flag_cerca_in_lista = "" 
if isnull(ast_open_w.flag_leggi_dw ) then ast_open_w.flag_leggi_dw = "" 
if isnull(ast_open_w.flag_modalita ) then ast_open_w.flag_modalita = "" 
if isnull(ast_open_w.flag_primo_giro ) then ast_open_w.flag_primo_giro = "" 
//if isnull(ast_open_w.flag_utente_autorizzato ) then ast_open_w.flag_utente_autorizzato = "" 
if isnull(ast_open_w.flag_where ) then ast_open_w.flag_where = "" 
if isnull(ast_open_w.id_programma ) then ast_open_w.id_programma = "" 
if isnull(ast_open_w.id_programma_chiamante ) then ast_open_w.id_programma_chiamante = "" 
if isnull(ast_open_w.key1 ) then ast_open_w.key1 = "" 
//if isnull(ast_open_w.key10_window_chiamante ) then ast_open_w. = "" 
//f isnull(ast_open_w.key11_dw ) then ast_open_w. = "" 
//if isnull(ast_open_w.key12_any ) then ast_open_w. = "" 
if isnull(ast_open_w.key2 ) then ast_open_w.key2 = "" 
if isnull(ast_open_w.key3 ) then ast_open_w.key3 = "" 
if isnull(ast_open_w.key4 ) then ast_open_w.key4 = "" 
if isnull(ast_open_w.key5 ) then ast_open_w.key5 = "" 
if isnull(ast_open_w.key6 ) then ast_open_w.key6 = "" 
if isnull(ast_open_w.key7 ) then ast_open_w.key7 = "" 
if isnull(ast_open_w.key8 ) then ast_open_w.key8 = "" 
if isnull(ast_open_w.key9 ) then ast_open_w.key9 = "" 
if isnull(ast_open_w.window_title ) then ast_open_w.window_title = "" 

end subroutine

private function boolean connetti () throws uo_exception;//
boolean k_return = false

if isvalid(kguo_sqlca_db_magazzino) then
	k_return = kguo_sqlca_db_magazzino.db_connetti( )
else
	kguo_exception.messaggio_utente("Programma instabile", "Prego uscire e rilanciare il Programma per continuare la sessione di lavoro")
end if

return k_return

end function

public subroutine open_trova (st_open_w ast_open_w);//
//--- Apre la funzione speciale di TROVA
//
if not isvalid(w_g_trova) then
	OpenWithParm(w_g_trova, ast_open_w)
end if

end subroutine

public subroutine open_filtra (st_open_w ast_open_w);//
//--- Apre la funzione speciale di FILTRA DATI
//
if not isvalid(w_g_filtra) then
	OpenWithParm(w_g_filtra, ast_open_w)
end if

end subroutine

public subroutine open_conv_calc (st_open_w ast_open_w);//
//--- Apre la funzione speciale di TROVA
//
if not isvalid(w_convalida_calc) then
	OpenWithParm(w_convalida_calc, ast_open_w)
end if

end subroutine

private function boolean autorizza_funzione (st_open_w kst_open_w);//
//=== Controlla se funzione Autorizzata o meno 
//
boolean k_return
//kuf_sicurezza kuf1_sicurezza


//kuf1_sicurezza = create kuf_sicurezza
k_return = kiuf_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza


return k_return
  
end function

public function boolean get_st_tab_menu_window_anteprima (ref st_tab_menu_window_anteprima ast_tab_menu_window_anteprima);//
//--- Trova i dati della tabella st_tab_menu_window_anteprima 
//--- inp: st_tab_menu_window_anteprima anteprima
//--- Out: st_tab_menu_window_anteprima.*
//--- Rit: true=anteprima trovata
//
boolean k_return = false
int k_ctr=1
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

ast_tab_menu_window_anteprima.anteprima = trim(ast_tab_menu_window_anteprima.anteprima)

do while kgst_tab_menu_window_anteprima[k_ctr].anteprima <> ast_tab_menu_window_anteprima.anteprima  and  kgst_tab_menu_window_anteprima[k_ctr].anteprima < ast_tab_menu_window_anteprima.anteprima &
			and kgst_tab_menu_window_anteprima[k_ctr].anteprima <> "FINE" and k_ctr < 100
	k_ctr ++
loop

if k_ctr = 99 then
	kst_esito.esito = kkg_esito.ko  
	kst_esito.sqlcode = 0
	kst_esito.sqlerrtext = "Errore array 'Anteprime' superato il limite massimo = " + string(k_ctr)
	kguo_exception.inizializza()
	kguo_exception.set_esito(kst_esito)
	kguo_exception.messaggio_utente( )
else
	if kgst_tab_menu_window_anteprima[k_ctr].anteprima = ast_tab_menu_window_anteprima.anteprima  then
		k_return = true
		ast_tab_menu_window_anteprima = kgst_tab_menu_window_anteprima[k_ctr]  // OK TROVATO!!!!
	end if
end if


//  SELECT menu_window_anteprima.id,   
//         menu_window_anteprima.anteprima,   
//         menu_window_anteprima.nome_id_tabella,   
//         menu_window_anteprima.id_menu_window  
//    INTO :ast_tab_menu_window_anteprima.id,   
//         :ast_tab_menu_window_anteprima.anteprima,   
//         :ast_tab_menu_window_anteprima.nome_id_tabella,   
//         :ast_tab_menu_window_anteprima.id_menu_window  
//    FROM menu_window_anteprima  
//   WHERE menu_window_anteprima.anteprima = :ast_tab_menu_window_anteprima.anteprima   
//				using kguo_sqlca_db_magazzino;
//	
//	if kguo_sqlca_db_magazzino.sqlcode < 0 then
//		kst_esito.esito = kkg_esito.db_ko   // forse
//		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//		kst_esito.sqlerrtext = "Errore tabella 'Anteprime' (menu_window_anteprima). id_menu_window=" + string(ast_tab_menu_window_anteprima.anteprima)
//		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//	end if
	
	
return k_return

end function

public function boolean get_id_menu_window (ref st_tab_menu_window_oggetti kst_tab_menu_window_oggetti);//
//--- Trova il ID_PROGRAMMA 
//--- inp: nome_oggetto, funzione
//--- out: id_menu_window (che e' l'id del programma)
//
boolean k_return=false
integer k_ctr=0, k_pos=0


	k_ctr++
	k_pos = 0
	do while upperbound(kguo_g.kGst_tab_menu_window_oggetti[]) >= k_ctr and k_pos = 0 
		
		if kguo_g.kGst_tab_menu_window_oggetti[k_ctr].id > 0 then
			if trim(kguo_g.kGst_tab_menu_window_oggetti[k_ctr].nome_oggetto) = trim(kst_tab_menu_window_oggetti.nome_oggetto) then
				
				k_pos = pos(trim(kguo_g.kGst_tab_menu_window_oggetti[k_ctr].funzione), trim(kst_tab_menu_window_oggetti.funzione), 1) 
				
			end if
		end if
		k_ctr++				
		
	loop
	if k_pos > 0 then
		k_return=true	
		kst_tab_menu_window_oggetti.id_menu_window = trim(kguo_g.kGst_tab_menu_window_oggetti[k_ctr - 1].id_menu_window)
	end if
	
	
	
return k_return

end function

public function boolean open_w_tabelle_da_ds (datastore ads_dati_window, string a_modalita) throws uo_exception;//-------------------------------------------------------------------------------------------------------------------------------------
//--- 
//--- Apre una window con la tab ANTEPRIMA 
//--- Input: datastore: con i dati del dw legge la tabella window_anteprima e apre la window corretta
//---		    modalita  cosi' come impostato in kkg_modalita.xxxxx es: kkg_flag_modalita.visualizzazione
//---
//-------------------------------------------------------------------------------------------------------------------------------------
boolean k_return=false
st_tab_menu_window_anteprima kst_tab_menu_window_anteprima
st_open_w kst_open_w		
kuf_parent kuf1_parent

if ads_dati_window.rowcount( ) > 0 or a_modalita = kkg_flag_modalita.inserimento then

	kst_tab_menu_window_anteprima.anteprima = ads_dati_window.dataobject
	get_st_tab_menu_window_anteprima(kst_tab_menu_window_anteprima)
	
	kst_open_w.id_programma = kst_tab_menu_window_anteprima.id_menu_window
	kst_open_w.flag_modalita = a_modalita 
	kst_open_w.key9 = kst_tab_menu_window_anteprima.nome_id_tabella
	kst_open_w.key11_ds = create datastore
	kst_open_w.key11_ds.dataobject = ads_dati_window.dataobject
	ads_dati_window.rowscopy( ads_dati_window.getrow( ) , ads_dati_window.getrow( ), primary!, kst_open_w.key11_ds, 1, primary!)  // passo solo 1 riga
	kst_open_w.key11_ds.setrow(1)

//---- get del nome dell'oggetto kuf_....	
	kst_open_w.nome_oggetto = get_nome_oggetto(kst_open_w.id_programma) 
	if kst_open_w.nome_oggetto > " " then
		kuf1_parent = create using kst_open_w.nome_oggetto
		kuf1_parent.u_open_ds(kst_open_w)
		k_return=true
	end if
	
end if

return k_return
end function

public subroutine open_w_tabelle (st_open_w kst_open_w);//
//=== Apertura delle Window_Tabelle
string k_rc_open="0"
//string k_w_name, k_sn
int k_ctr, k_ctr_idx, k_rc, k_nr_opened
string k_id_programma_open
boolean k_boolean, k_open_window
arrangeopen k_arrangeopen
st_esito kst_esito
pointer kpointer_orig
w_super kw_window, kw_prima_window_operta 
w_super kw_window_open, kw_window_attiva
window kw_window_eccezioni
kuf_utility kuf1_utility
st_tab_base_docking kst_tab_base_docking
integer k_rtn 
 
//-------------------------------------------------------------------------------------------------
//=== Struttura di Input:
//--- st_open_w.id_programma = identificativo programma da lanciare
//--- st_open_w.id_programma_chiamante = identificativo programma Chiamante
//--- st_open_w.nome_oggetto = qui cerca di reperire il nome del user-object qual ad esempio 'kuf_clienti'
//--- st_open_w.sr_settore = settore prevalente x utente e funzione chiamata
//--- st_open_w.flag_primo_giro = S=finestra appena aperta
//--- st_open_w.flag_modalita = mod.operat: in=inserim; mo=modif.; ca=cancell.; vi=visual.; ecc....
//--- st_open_w.flag_utente_autorizzato = true utente autorizzato  
//--- st_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO/SI
//--- st_open_w.flag_leggi_dw = S=leggi su open;
//--- st_open_w.flag_cerca_in_lista = 1=?????;
//--- st_open_w.key1_9 = chiave di ricerca
//--- st_open_w.key10_window_chiamante = RISERVATA X riferimento alla window chiamante
//--- st_open_w.nome_id_tabella = nome del campo chiave univoca, es. utile x chiamare la funzione modifica da elenco
//--- st_open_w.campo_where = query 
//-------------------------------------------------------------------------------------------------

try

	kpointer_orig = setpointer(hourglass!)
	
	k_open_window = true
	
	//--- toglie i NULL dai dati
	if_isnull(kst_open_w)
	
	k_id_programma_open = trim(kst_open_w.id_programma)
	
	k_ctr_idx = UpperBound(kGst_tab_menu_window[])
	for k_ctr = 1 to k_ctr_idx 
		k_nr_opened ++
		if k_id_programma_open = trim(kGst_tab_menu_window[k_ctr].id) then
			exit
		end if
	next
	 
	if k_ctr <= k_ctr_idx then
	
		connetti( )  // connessioni DB
		
		if LenA(trim(kGst_tab_menu_window[k_ctr].titolo)) > 0 then
			kst_open_w.window_title = trim(kGst_tab_menu_window[k_ctr].titolo)
		else
			kst_open_w.window_title = " "
		end if
		kst_open_w.sr_settore = kGst_tab_menu_window[k_ctr].sr_settore  // imposta il settore prevalente x funzione e utente
	
//---- get del nome dell'oggetto kuf_....	
		kst_open_w.nome_oggetto = get_nome_oggetto(k_id_programma_open) 

		if autorizza_funzione(kst_open_w) then
		
			kst_open_w.flag_utente_autorizzato = true 
			
	//--- se sto aprendo una windows....
			if LenA(trim(kGst_tab_menu_window[k_ctr].window)) > 1 then
	
	//--- se window gia' aperta chiedo cosa fare
				kw_window = kguo_g.window_aperta_get(trim(kGst_tab_menu_window[k_ctr].window))
//				kw_window = prendi_win_uguale(trim(kGst_tab_menu_window[k_ctr].window))
//					if kw_window.ClassName( ) = trim(kGst_tab_menu_window[k_ctr].window) then

				if isvalid(kw_window) then

//--- Per window gia' aperta devo lanciare la u_riopen e basta
					if upper(kGst_tab_menu_window[k_ctr].msg_se_gia_open) = kki_msg_se_gia_open_riOpen then
						
						k_open_window = false
						try
							kw_window.u_riopen(kst_open_w) 
						catch (uo_exception kuo2_exception)
							kuo2_exception.messaggio_utente()
						end try
						
					else
						
//--- Per window gia' aperta se NON posso aprire altre istanze allora la metto solo a fuoco e basta
						kw_window.SetFocus()   // Fuoco sulla window già aperta
						if kGst_tab_menu_window[k_ctr].istanze < 2 then // se posso aprire solo un istanza allora...
							k_open_window = false
						else
//--- Per window gia' aperta controllo SE posso aprire più istanze e faccio la richiesta su farlo o tornare alla window gia' aperta
							if upper(kGst_tab_menu_window[k_ctr].msg_se_gia_open) = kki_msg_se_gia_open_esponi then
								k_rc = messagebox( "Funzione già aperta", "Premere 'SI' per aprire una nuova finestra, per rimanere su questa premere 'No' ", question!, yesno!, 2 )
								if k_rc = 2 then
									k_open_window = false
								end if
							end if
						end if
					end if
				end if
	
			end if
			
//--- Se la Window deve essere aperta allora....		
			if k_open_window then
					
				kst_open_w.window =  trim(kGst_tab_menu_window[k_ctr].window)
				kst_open_w.st_tab_menu_window = kGst_tab_menu_window[k_ctr]
				if kst_open_w.window > " " then  
		
					if isvalid(w_main) and kGst_tab_menu_window[k_ctr].primopiano <> "S"  then
	
//--- recupera il riferimento alla windows chiamante
						if len(trim(kst_open_w.id_programma_chiamante)) > 0 then
						else
							setnull(kst_open_w.key10_window_chiamante)
							kst_open_w.id_programma_chiamante = ""
							kw_window_attiva=kGuf_data_base.prendi_win_attiva()
							if isvalid(kw_window_attiva) and not isnull(kw_window_attiva) then
								kst_open_w.key10_window_chiamante = kw_window_attiva
								kst_open_w.id_programma_chiamante = trim(kw_window_attiva.get_id_programma())
							end if
						end if
//--- passa al pgm il nome del campo chiave primaria
						kst_open_w.nome_id_tabella = kGst_tab_menu_window[k_ctr].nome_id_tabella
					end if

//--- APRO LA WINDOW STANDARD
					kguo_g.kGst_open_w = kst_open_w

////--- ECCEZIONE per compatibilità con il vecchio pgm da ripristinare tra un p' di tempo 13-04-2017					
//					if kguo_g.kGst_open_w.window = "w_stampe" then
//						kGst_tab_menu_window[k_ctr].primopiano = "A"
//					end if

//--- Recupera la modalità della docking-window NON FUNZIONA BENE!!!!!!!!!!!!!!!
//					kst_tab_base_docking.wstate = ""
//					if kGst_tab_menu_window[k_ctr].primopiano <> "S" and kGst_tab_menu_window[k_ctr].primopiano <> "M" then
//						try
//							kst_tab_base_docking.wstate = KGuf_base_docking.get_dockingstate(kguo_g.kGst_open_w.window)
//						catch (uo_exception kuo_exception4)
//						end try
//
//						if kst_tab_base_docking.wstate > " " then
//	
//							choose case kst_tab_base_docking.wstate
//								case kguf_base_docking.kki_WindowDockStateDocked
//									kGst_tab_menu_window[k_ctr].primopiano = "A"
//								case kguf_base_docking.kki_WindowDockStateFloating
//									kGst_tab_menu_window[k_ctr].primopiano = "N"
//								case kguf_base_docking.kki_WindowDockStateTabbedDocument
//									kGst_tab_menu_window[k_ctr].primopiano = "N"
//								case kguf_base_docking.kki_WindowDockStateTabbedWindow
//									kGst_tab_menu_window[k_ctr].primopiano = "A"
//								case else
//									kGst_tab_menu_window[k_ctr].primopiano = "N"
//							end choose
//						end if
////						w_super kw_windw
////						openSheetWithParmFromDockingState(kw_windw, kguo_g.kGst_open_w.window, kst_w_docking.k_type[1], w_main, kst_w_docking.k_Name[1])  
////						w_main.CommitDocking()
//						
//					end if
//						
////--- preparo il flag come PRIMO-GIRO se non impostato						
//						if kguo_g.kGst_open_w.flag_primo_giro > " " then
//							kguo_g.kGst_open_w.flag_primo_giro = "S"
//						end if 

					choose case kGst_tab_menu_window[k_ctr].primopiano
//--- S = APRO LA WINDOW IN PRIMO PIANO SOPRA A TUTTE (DEVE ESSERE TIPO MAIN)
						case "S"
							k_rc_open = string(OpenWithParm(kw_window_open, kguo_g.kGst_open_w, kguo_g.kGst_open_w.window), "0")
//--- A = APRO WINDOW PARTICOLARE TIPO ZOOM/STAMPA/....
						case "A"
							kGst_tab_menu_window[k_ctr].primopiano = "A" 
							kw_prima_window_operta = kguo_g.window_aperta_get_x_primopiano(kGst_tab_menu_window[k_ctr].primopiano)
							if isnull(kw_prima_window_operta) then
								k_rc_open =  string(OpenSheetWithParmDocked(kw_window_open, kguo_g.kGst_open_w, kguo_g.kGst_open_w.window, w_main, WindowDockRight!, kguo_g.kGst_open_w.window ))
//								k_rc_open =  string(OpenSheetWithParmAsDocument(kw_window_open, kguo_g.kGst_open_w, kguo_g.kGst_open_w.window, w_main, k_w_name, true ))
							else
								k_rc_open =  string(OpenSheetWithParmInTabGroup(kw_window_open, kguo_g.kGst_open_w, kguo_g.kGst_open_w.window, kw_prima_window_operta, kguo_g.kGst_open_w.window ))
//								k_rc_open = string(OpenSheetWithParmAsDocument(kw_window_open, kguo_g.kGst_open_w, kguo_g.kGst_open_w.window, kw_prima_window_operta, k_w_name ))
							end if
//--- M = APRO WINDOW MENU PER I FATTI SUOI
						case "M"
							kGst_tab_menu_window[k_ctr].primopiano = "M" 
							kw_prima_window_operta = kguo_g.window_aperta_get_x_primopiano(kGst_tab_menu_window[k_ctr].primopiano)
							if isnull(kw_prima_window_operta) then
								OpenSheetDocked(kw_window_open, kguo_g.kGst_open_w.window, w_main, WindowDockLeft!, kguo_g.kGst_open_w.window)
//									kw_window_open.setsheetid(kguo_g.kGst_open_w.window)
							end if
//--- APRO TUTTE LE WINDOW NORMALI
						case else
							kGst_tab_menu_window[k_ctr].primopiano = "N" 
							kw_prima_window_operta = kguo_g.window_aperta_get_x_primopiano(kGst_tab_menu_window[k_ctr].primopiano)
//								kw_prima_window_operta = kguo_g.get_window_aperta("")
							if isnull(kw_prima_window_operta) then
//								if k_nr_opened = 0 then // prima window da aprire
								k_rc_open =  string(OpenSheetWithParmAsDocument(kw_window_open, kguo_g.kGst_open_w, kguo_g.kGst_open_w.window, w_main, kguo_g.kGst_open_w.window, true  ))
							else
								k_rc_open =  string(OpenSheetWithParmAsDocument(kw_window_open, kguo_g.kGst_open_w, kguo_g.kGst_open_w.window, kw_prima_window_operta, kguo_g.kGst_open_w.window ))
							end if
					end choose
//					if k_rc_open > "0" then
//						kw_window_open.SetFocus()   // Fuoco sulla window appena aperta
					//end if
	
				else
//--- Se manca il nome della Window probabilemente è un programma lanciato in modalita' batch...	
					if trim(kGst_tab_menu_window[k_ctr].batch ) = "S" then
						try 
						
							open_run_batch(kst_open_w)    // LANCIO FUNZIONE BATCH
							k_rc_open = "0"   				//evita il suono del programma
						
						catch (uo_exception kuo1_exception)
						
						end try
					end if
				end if
	
			end if
//250913			kw_window_open.show( )
	
			if k_rc_open = "1" then
	
	//=== Suona Motivo di attivazione programma
				if kst_open_w.flag_modalita = kkg_flag_modalita.inserimento &
					or kst_open_w.flag_modalita = kkg_flag_modalita.modifica &
					then
					kGuf_data_base.post suona_motivo(kki_suona_motivo_Open_w, 0)
				else
					if kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione &
						then
						kGuf_data_base.post suona_motivo(kki_suona_motivo_open_w_x_canc, 0)
					else
						kGuf_data_base.post suona_motivo(kki_suona_motivo_open_w_x_agg, 0)
					end if
				end if
			end if
		
		else
			kguo_exception.inizializza( )
			kguo_exception.messaggio_utente( "Accesso non Autorizzato", "La funzione richiesta (" + k_id_programma_open + ") non e' stata Autorizzata")
		end if
	else
		kguo_exception.inizializza( )
		kguo_exception.messaggio_utente("Operazione Interrotta", "La funzione richiesta (" + k_id_programma_open + ") non e' stata Abilitata")
	
	end if


catch (uo_exception kuo3_exception)
		kst_esito = kuo3_exception.get_st_esito()
		kuo3_exception.messaggio_utente("Operazione Interrotta", "Non è stato possibile aprire l'operazione di '" + k_id_programma_open + "'. ~n~r" + trim(kst_esito.sqlerrtext ) )
	
	
finally
//	autorizza_menu( ki_menu )    //illumina solo le voci di menu abilitate
 
//	setpointer(kpointer_orig)

end try


//return k_rc_open

end subroutine

public function string get_nome_oggetto (string a_menu_id);//
//--- Trova il nome Oggetto es "kuf_clienti"
//--- inp: id   es. kst_open_w.id_programma
//--- rit: nome_oggetto 
//
string k_return = ""
long k_ctr, k_ctr_idx


	a_menu_id = lower(trim(a_menu_id))

	k_ctr = 1
	k_ctr_idx = UpperBound(kGst_tab_menu_window[])
	do while k_ctr <= k_ctr_idx 
		if a_menu_id = (trim(kGst_tab_menu_window[k_ctr].id)) then
			k_return = trim(kGst_tab_menu_window[k_ctr].nome_oggetto)
			exit
		end if
		k_ctr++
	loop
		
return k_return

end function

on kuf_menu_window.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_menu_window.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
kiuf_sicurezza = create kuf_sicurezza

end event

