$PBExportHeader$w_convalida_dett.srw
forward
global type w_convalida_dett from w_g_tab_3
end type
end forward

global type w_convalida_dett from w_g_tab_3
integer width = 3314
integer height = 2092
string title = "Dosimetria"
long backcolor = 32172778
boolean ki_esponi_msg_dati_modificati = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_fai_proteggi_dopo_update = true
boolean ki_msg_dopo_update = false
end type
global w_convalida_dett w_convalida_dett

type variables
//datastore kdsi_elenco
protected st_tab_base kist_tab_base
protected st_tab_meca kist_tab_meca
private st_tab_meca_dosim kist_tab_meca_dosim

private kuf_meca_dosim kiuf_meca_dosim
private kuf_armo kiuf_armo
private string ki_err_lav_ok=""
private string ki_titolo_window_orig

private kuf_file_dragdrop kiuf_file_dragdrop
end variables

forward prototypes
private subroutine inserisci_anomalie ()
private subroutine inserisci_ok ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
public function string aggiorna ()
protected function string inizializza ()
protected subroutine inizializza_lista ()
private subroutine suggerisci_valore ()
private subroutine calcola_coeff_a_s ()
protected function string check_dati ()
private function st_esito leggi_lotto_dosimetrico (st_tab_dosimetrie kst_tab_dosimetrie) throws uo_exception
protected subroutine open_start_window ()
protected subroutine inizializza_personale (st_tab_meca_dosim kst_tab_meca_dosim)
public function integer convalida_old ()
public function boolean convalida ()
public function integer u_retrieve (st_tab_meca_dosim ast_tab_meca_dosim)
protected function int leggi_db_to_dw (st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception
protected subroutine attiva_tasti_0 ()
end prototypes

private subroutine inserisci_anomalie ();//
//--- Aggiungo il rec Riferimento tra le Anomalie
//
long k_riga
st_tab_meca kst_tab_meca 


	k_riga = tab_1.tabpage_1.dw_1.getrow()
	kst_tab_meca.num_int = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_int")
	kst_tab_meca.data_int = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_int")
	
	tab_1.tabpage_3.dw_3.retrieve(kst_tab_meca.num_int, kst_tab_meca.data_int)
	

end subroutine

private subroutine inserisci_ok ();//
//--- Aggiungo il rec Riferimento tra i Convalidati
//
long k_riga
st_tab_meca kst_tab_meca 


	k_riga = tab_1.tabpage_1.dw_1.getrow()
	kst_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_meca")
	kst_tab_meca.num_int = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_int")
	kst_tab_meca.data_int = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_int")
	
	tab_1.tabpage_2.dw_2.retrieve(kst_tab_meca.num_int, kst_tab_meca.data_int)
	
////-----------------------------------------------------------------------------------------------------------------------
//	try
////--- Genera avviso Pronto Merce  x fare poi l'invio via e-mail 
//		kst_tab_meca.st_tab_g_0.esegui_commit = "S"
////		kiuf_meca_dosim.add_email_invio(kst_tab_meca)
//		kiuf_meca_dosim.add_avviso_pronto_merce(kst_tab_meca)    // pronto merce
////-----------------------------------------------------------------------------------------------------------------------
//	catch (uo_exception kuo_exception)
//		kuo_exception.messaggio_utente()
//		
//	end try
end subroutine

protected subroutine smista_funz (string k_par_in);//
//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===
string k_return="0 "


choose case LeftA(k_par_in, 2) 

	case "l1"		//richiesta suggerisci valore...
		suggerisci_valore()
		
	case else
		super::smista_funz(k_par_in)		
		
end choose








end subroutine

protected subroutine attiva_menu ();//

	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Suggerisci Valore..."
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
//	ki_menu.m_lib_1.visible = true
	end if
	

	super::attiva_menu()
	
end subroutine

public function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 ", k_errore1="0 "
boolean k_convalida = false
long k_riga
st_esito kst_esito
st_tab_meca_dosim kst_tab_meca_dosim


try
	SetPointer(kkg.pointer_attesa)

//--- Verifica dati Dosimetrici
	k_convalida = convalida() 

//--- Aggiorna, se Modificato, la TAB_1 (MECA)	
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 then
				
//--- Aggiorna dati di convalida sul Riferimento MECA 
		k_riga = tab_1.tabpage_1.dw_1.getrow()
		kst_tab_meca_dosim.id_meca = tab_1.tabpage_1.dw_1.getitemnumber( k_riga, "id_meca")
//		kst_tab_meca.num_int = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_int")
//		kst_tab_meca.data_int = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_int")
		kst_tab_meca_dosim.dosim_dose = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_dose")
		kst_tab_meca_dosim.dosim_data = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "dosim_data")
		kst_tab_meca_dosim.err_lav_ok = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "err_lav_ok")
		kst_tab_meca_dosim.note_lav_ok = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "note_lav_ok")
		kst_tab_meca_dosim.dosim_lotto_dosim = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "dosim_lotto_dosim")
		kst_tab_meca_dosim.dosim_flg_tipo_dose = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "dosim_flg_tipo_dose")
		kst_tab_meca_dosim.dosim_assorb = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_assorb")
		kst_tab_meca_dosim.dosim_spessore = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_spessore")
		kst_tab_meca_dosim.dosim_rapp_a_s = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_rapp_a_s")
		kst_tab_meca_dosim.dosim_temperatura = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_temperatura")
		kst_tab_meca_dosim.dosim_umidita = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_umidita")
		kst_tab_meca_dosim.barcode = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "meca_dosim_barcode_1")
		kst_tab_meca_dosim.barcode_lav = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "barcode_lav")

		kst_tab_meca_dosim.st_tab_g_0.esegui_commit = "N"
		kiuf_meca_dosim.set_convalida_x_barcode(kst_tab_meca_dosim)    // AGGIORNA MECA_DOSIM

//--- rilegge la riga appena aggiornata
		u_retrieve(kst_tab_meca_dosim)


	end if

//--- Se tutto OK faccio la COMMIT
	kguo_sqlca_db_magazzino.db_commit()
	
//--- TUTTO OK resetto il buffer di aggiornamento			
	tab_1.tabpage_1.dw_1.resetupdate()
		
//--- se tutto ok inserisco il rec nel tab 2 e 3
//--- Verifica Dosimetrica buona...
	if k_convalida then
		messagebox("Operazione conclusa", "Convalida effettuata con esito positivo", Information!)
//--- inserisce record riferimento tra i Convalidati		
//		inserisci_ok ()
	else
		messagebox("Operazione conclusa", "Convalida in Anomalia", Exclamation!)
//--- inserisce record riferimento tra le Anomalie		
//		inserisci_anomalie ()
	end if


catch (uo_exception kuo_exception)
	kguo_sqlca_db_magazzino.db_rollback()
	kuo_exception.messaggio_utente( )
	kst_esito = kguo_exception.get_st_esito( )
	k_return ="1" + trim(kst_esito.sqlerrtext) + " (sqlcode=" + string(kst_esito.sqlcode) + ") "

finally
//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_default)

end try


//=== errore : 0=tutto OK o NON RICHIESTA; 
//===          1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita
return k_return

end function

protected function string inizializza ();
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
int k_ctr=0 
string k_errore = "0"
int k_rc
st_tab_armo kst_tab_armo
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_meca kst_tab_meca
st_tab_dosimetrie kst_tab_dosimetrie
st_esito kst_esito
kuf_ausiliari kuf1_ausiliari

try
	

////--- attraverso i parametri di INPUT piglia il ID_MECA
//	kst_tab_meca_dosim.id_meca = 0
//	if len(trim(ki_st_open_w.key1)) > 0 and isnumber(trim(ki_st_open_w.key1)) then
//		kst_tab_armo.num_int = long(trim(ki_st_open_w.key1))
//		kst_tab_armo.data_int = date(trim(ki_st_open_w.key2))
//		kiuf_armo.get_id_meca(kst_tab_armo)
		kst_tab_meca_dosim.barcode = kist_tab_meca_dosim.barcode
//	end if	

	if tab_1.tabpage_1.dw_1.rowcount( ) = 0 then 
		
		u_retrieve(kst_tab_meca_dosim)
		
	end if
	tab_1.tabpage_1.dw_1.setfocus()
	tab_1.tabpage_1.dw_1.setcolumn(1)
			

//--- in caso di errore...
catch (uo_exception kuo_exception1)
	k_errore = "1"
	kuo_exception1.messaggio_utente()
	cb_ritorna.postevent(clicked!)
end try



return k_errore


end function

protected subroutine inizializza_lista ();//
datawindowchild kdwc_1

//--- inizializzo il valore della tolleranza per validaz.dosimetrica
	setnull(kist_tab_base.valid_t_dose_min)

	if ki_st_open_w.flag_primo_giro = 'S' then //se giro di prima volta
	
		tab_1.tabpage_1.dw_1.getchild("dosim_rapp_a_s", kdwc_1)
		kdwc_1.settransobject(sqlca)
		kdwc_1.insertrow(0)
	
	end if


	super::inizializza_lista()


end subroutine

private subroutine suggerisci_valore ();//
//--- 
//
long k_riga
double k_coeff_a_s, k_rc_d
int k_assorbanza, k_spessore
string k_lotto_dosim 
datawindowchild kdwc_1
st_esito kst_esito
st_tab_armo kst_tab_armo
st_tab_dosimetrie kst_tab_dosimetrie
kuf_armo kuf1_armo
kuf_ausiliari kuf1_ausiliari
pointer kp_oldpointer 


//=== Puntatore Cursore da attesa..... 
	kp_oldpointer = SetPointer(HourGlass!)

	tab_1.tabpage_1.dw_1.accepttext()
	
	k_riga = tab_1.tabpage_1.dw_1.getrow()
	k_assorbanza = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_assorb")
	k_spessore = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_spessore")

	if tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_int") > 0 &
	   and tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_int") > date(0) &
		and LenA(trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga,"dosim_lotto_dosim"))) > 0 & 
		then
	
		if (isnull(k_assorbanza) or k_assorbanza = 0 &
			 or isnull(k_spessore) or k_spessore = 0) &
			and (k_spessore > 0 or k_assorbanza > 0) then
			
			kuf1_armo = create kuf_armo
			kst_tab_armo.num_int = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_int") 
			kst_tab_armo.data_int = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_int") 
			kst_tab_armo.dose = 0
			kst_esito = kuf1_armo.leggi_riga("D", kst_tab_armo)
			destroy kuf1_armo
			
			if kst_esito.esito = "0" and kst_tab_armo.dose > 0 then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "data_int", kst_tab_armo.data_int) 
				
				k_lotto_dosim = trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "dosim_lotto_dosim"))
				kst_tab_dosimetrie.coeff_a_s = 0
				kst_tab_dosimetrie.dose = kst_tab_armo.dose
				kst_tab_dosimetrie.lotto_dosim = k_lotto_dosim
				kuf1_ausiliari = create kuf_ausiliari
				kst_esito = kuf1_ausiliari.tb_dosimetrie_select(kst_tab_dosimetrie)
				destroy kuf1_ausiliari
				
				if kst_esito.esito = "0" and kst_tab_dosimetrie.coeff_a_s > 0.000 then
					
					if k_assorbanza > 0 then
						k_rc_d = k_assorbanza / kst_tab_dosimetrie.coeff_a_s
						k_spessore = round( k_rc_d, 0)
						tab_1.tabpage_1.dw_1.setitem(k_riga, "dosim_spessore", k_spessore)
					else
						k_rc_d = k_spessore * kst_tab_dosimetrie.coeff_a_s 
						k_assorbanza = round( k_rc_d, 0)
						tab_1.tabpage_1.dw_1.setitem(k_riga, "dosim_assorb", k_assorbanza)
					end if
					
//					tab_1.tabpage_1.dw_1.setitem(k_riga, "dosim_coeff_a_s", kst_tab_dosimetrie.coeff_a_s)
//--- Calcola il rapporto a/s e trova la dose
					calcola_coeff_a_s ()
					
				else
		
					messagebox("Suggerisci Valore", &
			         "Coefficiente non valorizzato in tabella per il Lotto~n~r" &
						+ k_lotto_dosim &
						+ " e Dose " + string(kst_tab_armo.dose, "#####0.00"), &
					  Information!)
				
					
				end if
			else
		
				messagebox("Suggerisci Valore", &
			         "Dose non trovata, riprova o~n~rcorreggi il Riferimento indicato", &
					  Information!)
				
			end if
		else
		
			messagebox("Suggerisci Valore", &
			         "Dati Insufficienti/Abbondanti, impostare/azzerare ~n~ril valore in Assorbanza o Spessore", &
					  Information!)
			
		end if
		
	else
		
		messagebox("Suggerisci Valore", &
			         "Dati Insufficienti, impostare il Nome Lotto e Riferimento", &
					  Information!)
		
	end if
				
	
	SetPointer(kp_oldpointer)
	

end subroutine

private subroutine calcola_coeff_a_s ();//
//--- 
//
long k_riga, k_riga_dwc
double k_coeff_a_s
string k_lotto_dosim="" 
pointer kp_oldpointer 
st_esito kst_esito
st_tab_dosimetrie kst_tab_dosimetrie
kuf_ausiliari kuf1_ausiliari


//=== Puntatore Cursore da attesa..... 
	kp_oldpointer = SetPointer(HourGlass!)

	tab_1.tabpage_1.dw_1.accepttext() 

	k_riga = tab_1.tabpage_1.dw_1.getrow() 
	k_lotto_dosim = trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "dosim_lotto_dosim")) 
	
	k_coeff_a_s = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_rapp_a_s") 
	
	if trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "blocca_rapporto")) <> "1" &
	   or isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "blocca_rapporto")) then 
//	if isnull(k_coeff_a_s) or k_coeff_a_s = 0 then
		
		if tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_assorb") > 0 & 
			and tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_spessore") > 0 &
			then
			k_coeff_a_s = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_assorb") / & 
					  tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_spessore") 
		end if
	end if
	
	kst_tab_dosimetrie.dose = 0
	
	if	k_coeff_a_s > 0 then
		
		kst_tab_dosimetrie.lotto_dosim = k_lotto_dosim
		kst_tab_dosimetrie.coeff_a_s = round(k_coeff_a_s, 3)
		
//--- legge archivio delle dosimetrie x reperire la dose	di lavorazione	
		kuf1_ausiliari = create kuf_ausiliari
		kst_esito = kuf1_ausiliari.tb_dosimetrie_select (kst_tab_dosimetrie)
		destroy kuf_ausiliari
		
		if kst_esito.esito <> "0" then
			kst_tab_dosimetrie.dose = 0
		end if
		
	end if

	tab_1.tabpage_1.dw_1.setitem(k_riga, "dosim_rapp_a_s", k_coeff_a_s)
	tab_1.tabpage_1.dw_1.setitem(k_riga, "dosim_dose", kst_tab_dosimetrie.dose)

	SetPointer(kp_oldpointer)


end subroutine

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = ""
char k_errore = "0"
int k_riga
st_tab_meca kst_tab_meca
st_esito kst_esito
kuf_armo kuf1_armo


	
	k_riga = tab_1.tabpage_1.dw_1.getrow()

	if isnull(tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "dosim_data"))  &
		or tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "dosim_data") = date(0) &
		then
		k_return = "Impostare la data di Convalida " + "~n~r"
		k_errore = "3"
	end if
	
	if isnull(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "dosim_lotto_dosim")) = true &
		or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "dosim_lotto_dosim"))) = 0 &
		then
		k_return = k_return + "Impostare il Nome Lotto " + "~n~r"
		k_errore = "3"
	end if
	
	if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "num_int")) &
		or ((tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "num_int"))) = 0 then
		k_return = k_return + "Impostare il Lotto da Convalidare" + "~n~r" 
		k_errore = "3"
	else
		kst_tab_meca.num_int = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "num_int") 
		kst_tab_meca.data_int = tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "data_int")

//--- se data mancante la forzo io			
		if kst_tab_meca.data_int = date(0) or isnull(kst_tab_meca.data_int) then
			kst_tab_meca.data_int = kguo_g.get_dataoggi()
		end if
		tab_1.tabpage_1.dw_1.setitem ( k_riga, "data_int", kst_tab_meca.data_int) 
		
		kuf1_armo = create kuf_armo
		kst_esito = kuf1_armo.leggi_testa("A", kst_tab_meca)
		destroy kuf_armo

		tab_1.tabpage_1.dw_1.setitem ( k_riga, "id_meca", kst_tab_meca.id) 

		if kst_esito.esito <> "0" then
			k_return = k_return + "Lotto non Trovato" + "~n~r" 
			k_errore = "1"
		else

//--- se inserimento non deve essere mai stata convalidata
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
			   and kst_tab_meca.st_tab_meca_dosim.dosim_data > date(0) then
				k_return = k_return + "Lotto gia' Convalidato" + "~n~r" 
				k_errore = "1"
			end if			
		end if
	end if
	
	if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosim_assorb")) &
		or ((tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosim_assorb"))) = 0 then
		k_return = k_return + "Impostare 'Assorbanza' " + "~n~r" 
		k_errore = "3"
	end if
	
	if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosim_spessore")) &
		or ((tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosim_spessore"))) = 0 then
		k_return = k_return + "Impostare 'Spessore' " + "~n~r" 
		k_errore = "3"
	end if
	
	if trim(tab_1.tabpage_1.dw_1.getitemstring ( k_riga, "dosim_flg_tipo_dose")) > " " then
	else
		k_return = k_return + "Impostare '" + trim(tab_1.tabpage_1.dw_1.describe("dosim_flg_tipo_dose_t.text")) + "' " + "~n~r" 
		k_errore = "3"
	end if

//	lo fa dentro a CALCOLA_COEFF if	k_errore = "0" or k_errore = "4" then
//		tab_1.tabpage_1.dw_1.setitem(k_riga, "dosim_rapp_a_s", &
//		  ( tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosim_assorb") &
//		    / tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "dosim_spessore"))  &
//		 )
//	end if

	if	k_errore = "0" or k_errore = "4" then
//--- calcol coeff x convalida 	
		calcola_coeff_a_s ()
	end if
	
//--- Se sono in Autorizzazione Controllo se sono stati modificati i dati di calcolo 	
	if	k_errore = "0" or k_errore = "4" then
		if kist_tab_meca.err_lav_ok = kiuf_meca_dosim.ki_err_lav_ok_conv_da_aut &
			or kist_tab_meca.err_lav_ok = kiuf_meca_dosim.ki_err_lav_ok_conv_ko_da_aut then
			if kist_tab_meca.num_int <> tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int") &
					or kist_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s <> tab_1.tabpage_1.dw_1.getitemnumber(1, "dosim_rapp_a_s") &
					or kist_tab_meca.st_tab_meca_dosim.dosim_assorb <> tab_1.tabpage_1.dw_1.getitemnumber(1, "dosim_assorb") &
					or kist_tab_meca.st_tab_meca_dosim.dosim_spessore <> tab_1.tabpage_1.dw_1.getitemnumber(1, "dosim_spessore") &
					or kist_tab_meca.st_tab_meca_dosim.dosim_temperatura <> tab_1.tabpage_1.dw_1.getitemnumber(1, "dosim_temperatura") &
					or kist_tab_meca.st_tab_meca_dosim.dosim_umidita <> tab_1.tabpage_1.dw_1.getitemnumber(1, "dosim_umidita") then
				k_return = k_return + "Sono stati modificati i dati della Precedente Rilevazione " + "~n~r" &
										  + "ATTENZIONE: dopo la conferma non sara' piu' possibile modificare i dati!"+ "~n~r"
				k_errore = "4"
			end if
		end if
	end if
	

//--- imposta campi automatici
	tab_1.tabpage_1.dw_1.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
	tab_1.tabpage_1.dw_1.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())

	
	
return k_errore + k_return


end function

private function st_esito leggi_lotto_dosimetrico (st_tab_dosimetrie kst_tab_dosimetrie) throws uo_exception;//
st_esito kst_esito
kuf_ausiliari kuf1_ausiliari


	kst_esito.esito = kkg_esito.ok

	if LenA(trim(kst_tab_dosimetrie.lotto_dosim)) > 0 then

		kuf1_ausiliari = create kuf_ausiliari
		kst_esito = kuf1_ausiliari.tb_dosimetrie_select_lotto_1(kst_tab_dosimetrie) 
		destroy kuf1_ausiliari

		if kst_esito.esito <> kkg_esito.ok then
			kguo_exception.inizializza( )
			kguo_exception.SetMessage ( &
				"Nome Lotto Dosimetrico non Trovato ~n~r" + &
				"( Codice cercato: " + trim(kst_tab_dosimetrie.lotto_dosim) + " )" )
			kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_anomali)
			throw kguo_exception
		else
			if kst_tab_dosimetrie.attivo <> "S" then
				kguo_exception.inizializza( )
				kguo_exception.SetMessage ( &
					"Nome Lotto Dosimetrico non Attivo ~n~r" + &
					"( Codice cercato: " + trim(kst_tab_dosimetrie.lotto_dosim) + " )" )
				kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_anomali)
				throw kguo_exception
			end if
		end if
	end if
	
return kst_esito
	
end function

protected subroutine open_start_window ();//
	kiuf_meca_dosim = create kuf_meca_dosim
	kiuf_armo = create kuf_armo

//--- Codice del Barcode obbligatorio
	kist_tab_meca_dosim.barcode = trim(ki_st_open_w.key1)
	
//--- salva il valore del tipo di stato della lettura dosimetrica x le liste
	ki_err_lav_ok = ki_st_open_w.key3 

//--- attiva eventuale Drag&Drop di files da Windows	Explorer
	if not isvalid(kiuf_file_dragdrop) then kiuf_file_dragdrop = create kuf_file_dragdrop 
	kiuf_file_dragdrop.u_attiva(handle(tab_1.tabpage_1.dw_1))





	
end subroutine

protected subroutine inizializza_personale (st_tab_meca_dosim kst_tab_meca_dosim);//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
int k_rc
st_open_w kst_open_w
st_tab_armo kst_tab_armo, kst1_tab_armo, kst2_tab_armo, kst3_tab_armo
st_esito kst_esito
kuf_utility kuf1_utility


try
		
	kist_tab_meca.id = kst_tab_meca_dosim.id_meca

//--- salvo i dati appena letti per verifiche 
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
//		kist_tab_meca.id = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")
		kist_tab_meca.num_int = tab_1.tabpage_1.dw_1.getitemnumber(1, "num_int")
		kist_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s = tab_1.tabpage_1.dw_1.getitemnumber(1, "dosim_rapp_a_s")
		kist_tab_meca.st_tab_meca_dosim.dosim_assorb = tab_1.tabpage_1.dw_1.getitemnumber(1, "dosim_assorb")
		kist_tab_meca.st_tab_meca_dosim.dosim_spessore = tab_1.tabpage_1.dw_1.getitemnumber(1, "dosim_spessore")
		kist_tab_meca.st_tab_meca_dosim.dosim_temperatura = tab_1.tabpage_1.dw_1.getitemnumber(1, "dosim_temperatura")
		kist_tab_meca.st_tab_meca_dosim.dosim_umidita = tab_1.tabpage_1.dw_1.getitemnumber(1, "dosim_umidita")
		kist_tab_meca.err_lav_ok = tab_1.tabpage_1.dw_1.getitemstring(1, "err_lav_ok")
		if isnull(kist_tab_meca.err_lav_ok) then
			kist_tab_meca.err_lav_ok = kiuf_meca_dosim.ki_err_lav_ok_da_conv
		end if
		if kist_tab_meca.num_int > 0 then
			ki_err_lav_ok = kist_tab_meca.err_lav_ok
		end if
	else
		kist_tab_meca.err_lav_ok = ki_err_lav_ok
	end if
	kiuf_armo.if_isnull_meca(kist_tab_meca)


//--- Se ho gia' fatto la prima rilevazione della dosimetria allora entro in modifica 
//--- ovviamente se non ho gia' fatto l'operazione di autorizzazione, poiche' chiude ogni altra modifica
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica and tab_1.tabpage_1.dw_1.rowcount() > 0 then
		
		if kiuf_armo.if_lotto_dosimetria_gia_autorizzata(kist_tab_meca) then
		
//--- se Dosimetria gia' definitiva allora do il mesg
			if kiuf_armo.if_lotto_dosimetria_gia_definitivo(kist_tab_meca) then
				
				ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione

//				messagebox("Rilevazione Dosimetria", &
//						"La Dosimetria risulta gia' Rilevata in modo definitivo  ~n~rpertanto la modifica non e' permessa ~n~r" + &
//						"~n~r(Codice stato dosimetria: " + trim(kist_tab_meca.err_lav_ok) + ")~n~r" )
			end if		
		end if
	end if

//02082007--- Messaggio dello stato di Lavorazione dei Lotti, avverto se non completo
	if kist_tab_meca.id > 0 then
		kst_tab_armo.id_meca = kist_tab_meca.id 
		kst_tab_armo.colli_2 = kiuf_armo.get_colli_lotto( kst_tab_armo ) //270614 get_colli_entrati_xbcode( kst_tab_armo )
		if kst_tab_armo.colli_2 > 0 then
			kst1_tab_armo.id_meca = kist_tab_meca.id 
			kst1_tab_armo.colli_2 = kiuf_armo.get_colli_trattati( kst1_tab_armo )
			if kst1_tab_armo.colli_2 > 0 then
				
				kst2_tab_armo.id_meca = kist_tab_meca.id 
				kst2_tab_armo.colli_2 = kiuf_armo.get_colli_danontrattare( kst2_tab_armo ) 		//giu/2016 get_colli_da_non_trattare( kst2_tab_armo )
				
				kst3_tab_armo.id_meca = kist_tab_meca.id 
				kst3_tab_armo.colli_2 = kiuf_armo.get_colli_in_lav( kst3_tab_armo )
				if kst3_tab_armo.colli_2 = 0 and (kst_tab_armo.colli_2 - kst2_tab_armo.colli_2) <=  kst1_tab_armo.colli_2 then // se i colli entrati - quelli da non trattare >= colli trattati
					tab_1.tabpage_1.dw_1.setitem( 1, "stato_lotto", "Lavorazione Lotto completata (colli="&
													                            + string (kst_tab_armo.colli_2 - kst2_tab_armo.colli_2) + ")")
					tab_1.tabpage_1.dw_1.setitem( 1, "stato_lotto_flag", " ")
				else
					tab_1.tabpage_1.dw_1.setitem( 1, "stato_lotto", "INCOMPLETO, Lotto ancora da trattare: colli entrati=" &
													                            + string (kst_tab_armo.colli_2 - kst2_tab_armo.colli_2)+"  " &
																			 + "in lavorazione=" + string (kst3_tab_armo.colli_2)+"  " & 
																			 + "trattati=" + string (kst1_tab_armo.colli_2)+")")
					tab_1.tabpage_1.dw_1.setitem( 1, "stato_lotto_flag", "E")
				end if
			else
				kst3_tab_armo.id_meca = kist_tab_meca.id 
				kst3_tab_armo.colli_2 = kiuf_armo.get_colli_in_lav( kst3_tab_armo )
				if kst3_tab_armo.colli_2 > 0 then
					tab_1.tabpage_1.dw_1.setitem( 1, "stato_lotto", "LOTTO DA TRATTARE:  " &
					                                    + string (kst3_tab_armo.colli_2) + " COLLI IN LAVORAZIONE !!!!!! ")
					tab_1.tabpage_1.dw_1.setitem( 1, "stato_lotto_flag", "E")
				else
					tab_1.tabpage_1.dw_1.setitem( 1, "stato_lotto", "LOTTO DA TRATTARE NESSUN COLLO LAVORATO !!!!!! ")
					tab_1.tabpage_1.dw_1.setitem( 1, "stato_lotto_flag", "E")
				end if
			end if		
		else
			tab_1.tabpage_1.dw_1.setitem( 1, "stato_lotto", "Non RILEVATO: "+trim(sqlca.sqlerrtext))
			tab_1.tabpage_1.dw_1.setitem( 1, "stato_lotto_flag", "E")
		end if
	else
		tab_1.tabpage_1.dw_1.setitem( 1, "stato_lotto_flag", " ")
		tab_1.tabpage_1.dw_1.setitem( 1, "stato_lotto", " ")
	end if

//--- personalizza colore della dw a seconda della stato
	if tab_1.tabpage_1.dw_1.rowcount() > 0 then
		tab_1.tabpage_1.dw_1.modify("b_ok.text='"+"&Convalida" +"'")
		tab_1.tabpage_1.dw_1.modify("b_ok.visible='1'")
		kst_open_w = ki_st_open_w
		ki_st_open_w.id_programma = kkg_id_programma_dosimetria
		
		choose case ki_err_lav_ok
			
			case "", kiuf_meca_dosim.ki_err_lav_ok_da_conv
				tab_1.tabpage_1.dw_1.modify("DataWindow.Color='" + string(kkg_colore.BLU_CHIARO)+"'")

			case kiuf_meca_dosim.ki_err_lav_ok_conv_da_aut
				ki_st_open_w.id_programma = kkg_id_programma_dosimetria_da_autorizzare
				tab_1.tabpage_1.dw_1.modify("DataWindow.Color='" + string(kkg_colore.BLU)+"'")
				tab_1.tabpage_1.dw_1.modify("b_ok.text='"+" &Convalida Dosimetria " +"'")

			case kiuf_meca_dosim.ki_err_lav_ok_conv_aut_ok
				tab_1.tabpage_1.dw_1.modify("DataWindow.Color='" + string(kkg_colore.GRIGIO)+"'")
				ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
				tab_1.tabpage_1.dw_1.modify("b_ok.visible='0'")

			case kiuf_meca_dosim.ki_err_lav_ok_conv_ko_da_aut
				ki_st_open_w.id_programma = kkg_id_programma_dosimetria_da_autorizzare
				tab_1.tabpage_1.dw_1.modify("DataWindow.Color='" + string(kkg_colore.ROSSO_CHIARO)+"'")
				tab_1.tabpage_1.dw_1.modify("b_ok.text='"+" &Riconvalida " +"'")

			case kiuf_meca_dosim.ki_err_lav_ok_conv_ko_bloc
				ki_st_open_w.id_programma = kkg_id_programma_dosimetria_da_sbloccare
				tab_1.tabpage_1.dw_1.modify("DataWindow.Color='" + string(kkg_colore.ROSSO)+"'")
				tab_1.tabpage_1.dw_1.modify("b_ok.text='"+" &Rilascia Dosimetria " +"'")

			case kiuf_meca_dosim.ki_err_lav_ok_conv_ko_sbloc
				tab_1.tabpage_1.dw_1.modify("DataWindow.Color='" + string(kkg_colore.GRIGIO)+"'")
				ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
				tab_1.tabpage_1.dw_1.modify("b_ok.visible='0'")

			case else
				if isnull(ki_err_lav_ok) then
					tab_1.tabpage_1.dw_1.modify("DataWindow.Color='" + string(kkg_colore.BLU_CHIARO)+"'")
				else
					tab_1.tabpage_1.dw_1.modify("DataWindow.Color='" + string(kkg_colore.BIANCO)+"'")
				end if

		end choose
		
//--- ricontrollo la sicurezza se ho cambiato il id programma
		if kst_open_w.id_programma <> ki_st_open_w.id_programma then
			ki_utente_abilitato = sicurezza(ki_st_open_w)
			if not ki_utente_abilitato then
				ki_st_open_w.id_programma = kst_open_w.id_programma
				ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
				tab_1.tabpage_1.dw_1.modify("b_ok.visible='0'")
			end if
		end if
		
	end if

//--- Inabilita campi alla modifica se Visualizzazione
	kuf1_utility = create kuf_utility 
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione &
		or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione &
		or kist_tab_meca.err_lav_ok = kiuf_meca_dosim.ki_err_lav_ok_conv_ko_bloc then
		
		tab_1.tabpage_1.dw_1.resetupdate( ) //resetto qls campo con stato di 'aggiornamento'
		
		kuf1_utility.u_proteggi_dw("1", 0, tab_1.tabpage_1.dw_1)
		
		if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione &
			or trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.cancellazione &
			then
			kuf1_utility.u_proteggi_dw("1", "b_ok", tab_1.tabpage_1.dw_1)
		end if

	else		
		
//--- S-protezione campi 
		kuf1_utility.u_proteggi_dw("0", 0, tab_1.tabpage_1.dw_1)
//		kuf1_utility.u_proteggi_dw("0", "b_ok", tab_1.tabpage_1.dw_1)

	end if
	
//--- se cancellazione
	if ki_st_open_w.flag_modalita = kkg_flag_modalita.cancellazione then

		cb_cancella.postevent (clicked!)
		cb_ritorna.postevent(clicked!)
		
	end if

	tab_1.tabpage_1.dw_1.resetupdate()
	
	kist_tab_meca.err_lav_ok = ki_err_lav_ok

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()


finally 	
//--- setta il titolo della window
	ki_st_open_w.window_title=ki_titolo_window_orig + " '" + kiuf_armo.err_lav_ok_dammi_descr(kist_tab_meca) + "' "
	set_titolo_window()

	attiva_tasti( )
	if isvalid(kuf1_utility) then destroy kuf1_utility

end try


end subroutine

public function integer convalida_old ();//OBSOLETA
//--- Controllo dati di convalida dosimetrica 
//--- Ritorno:   0=ok,  1=ko
//
int k_return = 1
//long k_riga
//string k_rc
//double k_dose_min, k_dose_max
//st_esito kst_esito
//st_tab_armo kst_tab_armo 
//st_tab_meca kst_tab_meca
//st_tab_sl_pt kst_tab_sl_pt
//st_tab_dosimetrie kst_tab_dosimetrie
//st_tab_contratti kst_tab_contratti
//kuf_contratti kuf1_contratti
//kuf_ausiliari kuf1_ausiliari
//kuf_armo kuf1_armo
//kuf_sl_pt kuf1_sl_pt
//kuf_base kuf1_base
//pointer kp_oldpointer
//
//
////=== Puntatore Cursore da attesa..... 
//	kp_oldpointer = SetPointer(HourGlass!)
//
//	tab_1.tabpage_1.dw_1.accepttext()
//
//	k_riga = tab_1.tabpage_1.dw_1.getrow()
//	kst_tab_armo.num_int = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "num_int")
//	kst_tab_armo.data_int = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "data_int")
//	kst_tab_dosimetrie.lotto_dosim = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "dosim_lotto_dosim")
//	kst_tab_dosimetrie.coeff_a_s = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_rapp_a_s")
//	kst_tab_meca.contratto = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "contratto")
//	kst_tab_contratti.sc_cf = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "contratti_sc_cf")
//	setnull(kst_tab_meca.err_lav_ok)
//	setnull(kst_tab_meca.note_lav_ok)
//	
//	kuf1_armo = create kuf_armo
//	kst_esito = kuf1_armo.leggi_riga("D", kst_tab_armo) 
//	destroy kuf1_armo
//
//	if kst_esito.esito = "0" then
//
//		tab_1.tabpage_1.dw_1.setitem(k_riga, "data_int", kst_tab_armo.data_int)
//
//		kuf1_ausiliari = create kuf_ausiliari
//		kst_esito = kuf1_ausiliari.tb_dosimetrie_select(kst_tab_dosimetrie) 
//		destroy kuf1_ausiliari
//
//		if kst_esito.esito = "0" then
//			
//			kst_tab_sl_pt.cod_sl_pt = kst_tab_armo.cod_sl_pt
//			kuf1_sl_pt = create kuf_sl_pt
//			kst_esito = kuf1_sl_pt.select_riga(kst_tab_sl_pt)
//			destroy kuf1_sl_pt
//			
//			if kst_esito.esito = "0" then
//
////--- prende (se non gia' fatto) eventuale tolleranza per la validazione dosimetrica
//				if isnull(kist_tab_base.valid_t_dose_min) then
//					kist_tab_base.valid_t_dose_min = 0
//					kuf1_base = create kuf_base 
//					k_rc = kuf1_base.prendi_dato_base("valid_tolleranza_dose_min")
//					if LeftA(k_rc,1) = "0" then
//						if isnumber (trim(MidA(k_rc,2))) then
//							kist_tab_base.valid_t_dose_min = integer(MidA(k_rc,2))
//						end if
//					end if
//					destroy kuf1_base 
//				end if
// 
////--- valorizzo la tolleranza di misurazione della dose min-max				
//				k_dose_min = kst_tab_sl_pt.dose_min * (1 - kist_tab_base.valid_t_dose_min/100)
////*** 14-7-2005 ********** ATTENZIONE SU RICHIESTA DELLA ZAMBONI DISATTIVO CONTROLLO CON LA TOLLERANZA **************
////*** 03-1-2006 ********** ATTENZIONE SU RICHIESTA DI BASCHIERI RIATTIVO IL CONTROLLO CON LA TOLLERANZA **************
////--- se ha il capitolato prendo il valore di riferimento dal contratto minimo + la Tolleranza				
//				if LenA(trim(kst_tab_contratti.sc_cf)) > 0 then 
////					k_dose_max = kst_tab_sl_pt.dose_min * (1 + kist_tab_base.valid_t_dose_min/100)
//					k_dose_max = kst_tab_sl_pt.dose_max * (1 + kist_tab_base.valid_t_dose_min/100)
//				else
//					k_dose_max = kst_tab_sl_pt.dose_max 
//				end if
//	
//				if kst_tab_dosimetrie.dose >= k_dose_min &
//					and kst_tab_dosimetrie.dose <= k_dose_max then
//					k_return = 0
//					kst_tab_meca.note_lav_ok = "Verifica dosimetrica convalidata "
////					tab_1.tabpage_1.dw_1.setitem(k_riga, "err_lav_ok", kuf_armo.ki_err_lav_ok_conv_da_aut)
////					tab_1.tabpage_1.dw_1.setitem(k_riga, "note_lav_ok", "Verifica dosimetrica convalidata ")
//				else
//					kst_tab_meca.note_lav_ok = &
//								 "Dose " &
//								 + string(kst_tab_dosimetrie.dose, "#####0.00") &
//								 + " fuori dal range previsto in SL-PT (" &
//								 + string(kst_tab_sl_pt.dose_min) &
//								 + "-" + string(kst_tab_sl_pt.dose_max) + ")"
//				end if
//			else
//				kst_tab_meca.note_lav_ok = "Piano di Lavorazione non trovato "
//			end if
//		else
//			kst_tab_meca.note_lav_ok = "Lotto Dosimetrico non trovato per il rapporto A/S calcolato"
//		end if
//	else
//		kst_tab_meca.note_lav_ok = "Riferimento non trovato "
//	end if
//	
////
////--- se sono stati rilevati errori di dosimetria	
//	if k_return = 1 then
////--- se era da "Prima Convalida"
//		if kist_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_da_conv then
//			kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_ko_da_aut
//		else
////--- se era in "anomalia da autorizzare...."
//			if kist_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_ko_da_aut then
//				kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_ko_bloc
//			else
////--- se era in "OK da autorizzare...."
//				if kist_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_da_aut then
//					kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_ko_da_aut
//				else
////--- se era in "BLOCCATO...."
//					if kist_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_ko_bloc then
//						kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_ko_sbloc
//						kst_tab_meca.note_lav_ok += " - Sbloccato "
//					end if			
//				end if			
//			end if
//		end if
//	else	
////--- se dosimetria OK	
//		if k_return = 0 then
////--- se era da "Prima Convalida" si e' deciso di dare immediatamente l'autorizzazione
//			if kist_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_da_conv then
////				kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_da_aut
//				kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_aut_ok
//			else
////--- se era in "anomalia da autorizzare...."
//				if kist_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_ko_da_aut then
//					kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_aut_ok
//				else
////--- se era in "OK da autorizzare...."
//					if kist_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_da_aut then
//						kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_aut_ok
//					else
////--- se era in "BLOCCATO...."
//						if kist_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_ko_bloc then
//							kst_tab_meca.err_lav_ok = kuf_armo.ki_err_lav_ok_conv_aut_ok
//						end if	
//					end if
//				end if
//			end if
//		end if
//	end if			
//	if isnull(kst_tab_meca.note_lav_ok) then
//		kst_tab_meca.err_lav_ok = kist_tab_meca.err_lav_ok
//		kst_tab_meca.note_lav_ok = kist_tab_meca.note_lav_ok
////	else
////		if isnull(kst_tab_meca.err_lav_ok) then
////			kst_tab_meca.note_lav_ok += " - prima lettura da verificare "
////		end if
//	end if
//
//	tab_1.tabpage_1.dw_1.setitem(k_riga, "err_lav_ok", kst_tab_meca.err_lav_ok)
//	tab_1.tabpage_1.dw_1.setitem(k_riga, "note_lav_ok", kst_tab_meca.note_lav_ok)
//
//
//	SetPointer(kp_oldpointer)
//
return k_return


end function

public function boolean convalida ();//
//--- Controllo dati di convalida dosimetrica 
//--- Ritorno: TRUE = ok, FALSE=ko
//
boolean k_ok = false
long k_riga
st_esito kst_esito
st_tab_meca_dosim kst_tab_meca_dosim


try
	
	SetPointer(kkg.pointer_attesa)

	tab_1.tabpage_1.dw_1.accepttext()

	k_riga = tab_1.tabpage_1.dw_1.getrow()
	kst_tab_meca_dosim.barcode = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "meca_dosim_barcode_1")
	kst_tab_meca_dosim.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_meca")
	kst_tab_meca_dosim.dosim_lotto_dosim = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "dosim_lotto_dosim")
	kst_tab_meca_dosim.dosim_rapp_a_s = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_rapp_a_s")
	kst_tab_meca_dosim.dosim_flg_tipo_dose = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "dosim_flg_tipo_dose")

	kst_tab_meca_dosim = kiuf_meca_dosim.convalida_dosim(kst_tab_meca_dosim)

//	tab_1.tabpage_1.dw_1.setitem(k_riga, "data_int", kst_tab_meca_dosim.data_int)
	tab_1.tabpage_1.dw_1.setitem(k_riga, "err_lav_ok", kst_tab_meca_dosim.err_lav_ok)
	tab_1.tabpage_1.dw_1.setitem(k_riga, "note_lav_ok", kst_tab_meca_dosim.note_lav_ok)

	if kst_tab_meca_dosim.err_lav_ok = kiuf_meca_dosim.ki_err_lav_ok_conv_aut_ok &
              or kst_tab_meca_dosim.err_lav_ok = kiuf_meca_dosim.ki_err_lav_ok_conv_aut_ok &
              or kst_tab_meca_dosim.err_lav_ok = kiuf_meca_dosim.ki_err_lav_ok_conv_aut_ok then
		k_ok = true
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	SetPointer(kkg.pointer_default)

end try	
	

return k_ok


end function

public function integer u_retrieve (st_tab_meca_dosim ast_tab_meca_dosim);//
int k_righe = 0

try
//--- legge l'archivio dosimetrie
	k_righe = leggi_db_to_dw(ast_tab_meca_dosim) 
		
//--- impostazioni generali dei dati window
	if k_righe > 0 then 
		ast_tab_meca_dosim.id_meca = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_meca")
		inizializza_personale(ast_tab_meca_dosim)
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try

return k_righe

end function

protected function int leggi_db_to_dw (st_tab_meca_dosim kst_tab_meca_dosim) throws uo_exception;//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_key, k_dataoggix
long  k_num_int, k_riga 
int k_anno
int k_righe
st_tab_meca kst_tab_meca


	if trim(kst_tab_meca_dosim.barcode) > " " then
	
//		kst_tab_meca.id = kst_tab_meca_dosim.id_meca
//		kiuf_armo.get_num_int(kst_tab_meca)
//		if kst_tab_meca.num_int > 0 then
//			k_num_int = kst_tab_meca.num_int 
//			k_anno = year(kst_tab_meca.data_int )
//			k_key = string(kst_tab_meca.num_int ) + " " + string(kst_tab_meca.data_int)
//		end if
//		
//		if isnull(k_anno) or k_anno = 0 then
//			k_anno = year(kg_dataoggi)
//		end if

		k_righe = tab_1.tabpage_1.dw_1.retrieve(kst_tab_meca_dosim.barcode) 
		
		choose case k_righe

			case is < 0	
				kguo_exception.inizializza( )
				kguo_exception.SetMessage ( &
					"Errore in accesso ai dati dosimetrici~n~r" + &
					"(barcode cercato:" + trim(kst_tab_meca_dosim.barcode) + ")") 
				kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_anomali)

			case 0
				kguo_exception.inizializza( )
				kguo_exception.SetMessage ( &
					"Barcode non trovato in archivio ~n~r" + &
					"(barcode cercato:" + trim(kst_tab_meca_dosim.barcode) + ")" )
				kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_anomali)
				throw kguo_exception				
				tab_1.tabpage_1.dw_1.reset()
				
			case is > 0		
//--- Calcola il rapporto a/s e trova la dose
//				calcola_coeff_a_s ()

		end choose

	end if

return k_righe


end function

protected subroutine attiva_tasti_0 ();//
super::attiva_tasti_0()

if tab_1.tabpage_2.dw_2.rowcount() > 0 then
	tab_1.tabpage_2.enabled = true
else
	tab_1.tabpage_2.enabled = false
end if
if tab_1.tabpage_3.dw_3.rowcount() > 0 then
	tab_1.tabpage_3.enabled = true
else
	tab_1.tabpage_3.enabled = false
end if

//--- abilito nuovo così da non uscire x forza dalla window x Convalidarne uno nuovo
cb_inserisci.enabled = true

end subroutine

on w_convalida_dett.create
call super::create
end on

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_return
int k_rc
long k_num_int, k_riga
date k_data_int
double k_coeff_a_s
int k_assorbanza, k_spessore


if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica then

	if isvalid(kst_open_w) then

		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
		
//--- Se dalla w di elenco non ho premuto un pulsante ma ad esempio doppio-click		
		if kst_open_w.key2 = "d_dosimetrie_lotto_l" and long(kst_open_w.key3) > 0 then
		
			kdsi_elenco_input = kst_open_w.key12_any 
		
			if kdsi_elenco_input.rowcount() > 0 then

				k_return = 1
				tab_1.tabpage_1.dw_1.setitem(1, "dosim_lotto_dosim",  kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "lotto_dosim"))
				
			end if
			
		else
			
			if kst_open_w.key2 = "d_dosimetrie_coeff_lotto_l" and long(kst_open_w.key3) > 0 then
				
				k_return = 1
				kdsi_elenco_input = kst_open_w.key12_any 

				tab_1.tabpage_1.dw_1.gettext()
				
				k_riga = tab_1.tabpage_1.dw_1.getrow ()
				
				k_coeff_a_s = kdsi_elenco_input.getitemnumber(long(kst_open_w.key3), "coeff_a_s")

				k_assorbanza = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_assorb")
				k_spessore = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dosim_spessore")
				if k_assorbanza > 0 and (k_spessore = 0 or isnull(k_spessore)) then
					k_spessore = k_assorbanza / k_coeff_a_s
					tab_1.tabpage_1.dw_1.setitem(1, "dosim_spessore", k_spessore)
				else	
					if k_spessore > 0 and (k_assorbanza = 0 or isnull(k_assorbanza)) then
						k_assorbanza = k_spessore * k_coeff_a_s
						tab_1.tabpage_1.dw_1.setitem(1, "dosim_assorb", k_assorbanza)
					end if
				end if
					
			end if				
		end if
		attiva_tasti()
				
	end if
end if

return k_return

end event

on w_convalida_dett.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;//
if isvalid(kiuf_meca_dosim) then destroy kiuf_meca_dosim
if isvalid(kiuf_armo) then destroy kiuf_armo

end event

type st_ritorna from w_g_tab_3`st_ritorna within w_convalida_dett
integer x = 562
integer y = 1700
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_convalida_dett
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_convalida_dett
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_convalida_dett
integer x = 1522
integer y = 1784
end type

type st_stampa from w_g_tab_3`st_stampa within w_convalida_dett
integer x = 997
integer y = 1704
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_convalida_dett
integer x = 1915
integer y = 1792
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_convalida_dett
integer x = 398
integer y = 1784
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_convalida_dett
integer x = 782
integer y = 1784
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_convalida_dett
integer x = 1152
integer y = 1784
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_convalida_dett
integer x = 18
integer y = 1788
end type

event cb_inserisci::clicked;//
int k_return=1
string k_errore="0 "
long k_ctr
boolean k_dosim_presente=false
kuf_utility kuf1_utility


try

	kuf1_utility = create kuf_utility

//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
	if LeftA(dati_modif(""), 1) = "1" then //Richisto Aggiornamento
	
//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
		k_errore = aggiorna_dati()
		
//--- se tutto ok	
		if k_errore = "0" then
			
			if convalida() then
//--- inserisce record riferimento tra i Convalidati		
				inserisci_ok ()
			else
//--- inserisce record riferimento tra le Anomalie		
				inserisci_anomalie ()
			
				messagebox("Verifica dosimetrica fallita", "Riferimento inserito nella lista delle Anomalie",  stopsign!)
			end if
		end if 
	
	
	end if


	if LeftA(k_errore, 1) = "0" then
		
		inserisci( )

	end if

//--- in caso di errore...
catch (uo_exception kuo_exception1)
	kuo_exception1.messaggio_utente()
	
finally
	ki_st_open_w.key1="0"
	if isvalid(kuf1_utility ) then destroy kuf1_utility
	
end try



return (k_return)


end event

type tab_1 from w_g_tab_3`tab_1 within w_convalida_dett
integer x = 23
integer y = 40
integer width = 2903
integer height = 1616
end type

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
call super::destroy
end on

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 2866
integer height = 1488
string text = "Dosimetria"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
event u_dropfiles pbm_dropfiles
integer x = 23
integer y = 32
integer width = 2752
integer height = 1352
string dataobject = "d_convalida_dett"
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
end type

event dw_1::clicked;call super::clicked;//
//=== Premuto pulsante nella DW
//
int k_rc
long k_riga
string k_lotto_dosim
boolean k_link_standard_sempre_possibile
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window


choose case dwo.name

	case "b_ok" 
		cb_aggiorna.triggerevent(clicked!)


	case "id_meca" &
 		 ,"contratto" &
	//--- lancia lo standard ZOOM....
		try
			k_link_standard_sempre_possibile = ki_link_standard_sempre_possibile
			ki_link_standard_sempre_possibile = true
			
			link_standard_call(this, dwo.name, row) 
			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
	
		finally
			ki_link_standard_sempre_possibile = k_link_standard_sempre_possibile
			
		end try


	case "b_lotto_dosim" &
		, "dosim_rapp_a_s_t" 
		
		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
		
	
	//--- popolo il datasore (dw non visuale) per appoggio elenco
	
		choose case dwo.name
				
//			case "b_lotto_dosim"
//				kdsi_elenco_output.dataobject = "d_dosimetrie_lotto_l" 
//				k_rc = kdsi_elenco_output.settransobject ( sqlca )
//				k_rc = kdsi_elenco_output.retrieve()
//				kst_open_w.key1 = "Elenco Lotti Dosimetrici " 
				
			case "dosim_rapp_a_s_t"
				kdsi_elenco_output.dataobject = "d_dosimetrie_coeff_lotto_l" 
				k_rc = kdsi_elenco_output.settransobject ( sqlca )
				k_riga = tab_1.tabpage_1.dw_1.getrow()
				k_lotto_dosim = trim(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "dosim_lotto_dosim")) 
				k_rc = kdsi_elenco_output.retrieve(k_lotto_dosim)
				kst_open_w.key1 = "Elenco Coeff.Dosimetrici del Lotto: " + k_lotto_dosim 
				
		end choose
	
		if kdsi_elenco_output.rowcount() > 0 then
	
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
			kst_open_w.id_programma = kkg_id_programma.elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = get_id_programma( ) //kiw_this_window.title    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_elenco_output
			kst_open_w.flag_where = " "
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(kst_open_w)
			destroy kuf1_menu_window
	
		else
			
			messagebox("Elenco Dati", "Nessun valore disponibile. ")
			
			
		end if


end choose

//
end event

event dw_1::itemchanged;call super::itemchanged;//
st_esito kst_esito
st_tab_dosimetrie kst_tab_dosimetrie


choose case dwo.name
				
	case "dosim_assorb" & 
			,"dosim_spessore" 
		if trim(this.getitemstring(row,"dosim_lotto_dosim")) > " " then 
//--- Calcola il rapporto a/s e trova la dose
			calcola_coeff_a_s ()
		end if
		
	case "dosim_lotto_dosim" 
		try
			kst_tab_dosimetrie.lotto_dosim = trim(data)
			kst_esito = leggi_lotto_dosimetrico(kst_tab_dosimetrie)
		catch (uo_exception kuo_exception1)
			kuo_exception1.messaggio_utente()
			return 1   // dato non accettato!
		end try
		
end choose

end event

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
integer x = 2286
integer y = 24
long textcolor = 0
long backcolor = 16777215
long bordercolor = 16777215
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
boolean visible = false
integer width = 2866
integer height = 1488
boolean enabled = false
string text = "Normale"
long tabtextcolor = 0
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer width = 2464
integer height = 1144
boolean enabled = true
string dataobject = "d_convalida_dosim_elenco"
end type

event dw_2::retrievestart;call super::retrievestart;// in questo modo la retrieve va in APPEND
return 2
end event

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 2866
integer height = 1488
boolean enabled = false
string text = "Anomalie"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
boolean visible = true
integer width = 2514
integer height = 1236
boolean enabled = true
string dataobject = "d_convalida_dosim_elenco"
end type

event dw_3::retrievestart;call super::retrievestart;// in questo modo la retrieve va in APPEND
return 2
end event

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 2866
integer height = 1488
boolean enabled = false
end type

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 2866
integer height = 1488
boolean enabled = false
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 2866
integer height = 1488
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 2866
integer height = 1488
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 2866
integer height = 1488
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 2866
integer height = 1488
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
end type

type st_duplica from w_g_tab_3`st_duplica within w_convalida_dett
end type

