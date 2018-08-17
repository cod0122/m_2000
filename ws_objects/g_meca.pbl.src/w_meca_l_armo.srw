$PBExportHeader$w_meca_l_armo.srw
forward
global type w_meca_l_armo from w_g_tab0
end type
type dw_data from uo_d_std_1 within w_meca_l_armo
end type
end forward

global type w_meca_l_armo from w_g_tab0
integer width = 3634
integer height = 2100
string title = "Elenco CO"
long backcolor = 32501743
boolean ki_toolbar_window_presente = true
dw_data dw_data
end type
global w_meca_l_armo w_meca_l_armo

type variables
//
private st_tab_meca kist_tab_meca
private string ki_ultimo_codice_cercato="999999"
private date ki_data_scad
private kuf_armo kiuf_armo
private kuf_listino kiuf_listino
private kuf_armo_nt kiuf_armo_nt
private kuf_armo_checkmappa kiuf_armo_checkmappa
private kuf_sl_pt kiuf_sl_pt

end variables

forward prototypes
public function string inizializza ()
private function integer check_rek (string k_mc_co)
private function integer check_rek_sc_cf (string k_sc_cf)
protected function integer modifica ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
protected function string check_dati ()
private function integer visualizza ()
protected subroutine riempi_id ()
protected subroutine open_start_window ()
public subroutine legge_dwc ()
public subroutine call_listini ()
public subroutine posiziona_su_codice ()
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti)
public function integer u_retrieve_dw_lista ()
private subroutine u_cambia_data ()
public function integer u_open_riferimenti_autorizza ()
private subroutine u_dw_riga_ricalcolo (ref st_tab_armo ast_tab_armo)
private subroutine u_dw_riga_ricalcolo_1 (ref st_tab_armo ast_tab_armo, ref st_tab_listino ast_tab_listino)
protected function string aggiorna_tabelle ()
private subroutine call_art_x_contratto ()
public subroutine u_video_sl_pt_misure (st_tab_sl_pt kst_tab_sl_pt)
private subroutine call_lotto (long a_id_meca)
public function long u_attiva_fattura_voci_armo_prezzi ()
end prototypes

public function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_key
long  k_riga=0
int k_importa = 0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//--- Se non ho richiesto un codice particolare mi fermo x chiedere
	if ki_st_open_w.flag_primo_giro = "S" then
		if kist_tab_meca.id = 0 and kist_tab_meca.clie_1 = 0 then

			dw_guida.setfocus( )
			dw_guida.setitem(1,"codice", "")

		else
			dw_guida.setitem(1,"codice", string(kist_tab_meca.id ))
		end if
		
		dw_guida.setcolumn("codice")

	end if
//=== Legge le righe del dw salvate l'ultima volta (importfile)
//	if ki_st_open_w.flag_primo_giro = "S" then  
//		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
//	end if
		
	//	if k_importa <= 0 then // Nessuna importazione eseguita
	if kist_tab_meca.id > 0 or kist_tab_meca.clie_1 > 0 or ki_st_open_w.flag_primo_giro <> "S" then

		if u_retrieve_dw_lista() < 1 then
			k_return = "1Lotti Non trovati "
	
			SetPointer(oldpointer)
			messagebox("Elenco Lotti Vuota", &
					"Nesun Codice Trovato per la richiesta fatta")
		end if		

	
//		end if
		
	
	end if
	
	attiva_tasti()


return k_return


end function

private function integer check_rek (string k_mc_co);//
int k_return = 0
int k_anno
string k_descr, k_sc_cf = ""
long k_codice, k_codice_1


	k_codice_1 = dw_dett_0.getitemnumber(1, "codice")  

	SELECT 
	      contratti.codice, 
         contratti.descr,
			SC_CF
   	 INTO :k_codice,
      	   :k_descr,
				:k_sc_cf
    	FROM contratti 
   	WHERE mc_co = :k_mc_co and codice <> :k_codice_1;

	if sqlca.sqlcode = 0 then 
		
		if LenA(trim(k_sc_cf)) = 0 then 
			k_sc_cf = " "
		else
			k_sc_cf = "SC-CF " + trim(k_sc_cf)
		end if
		
		if messagebox("MC-CO gia' in Archivio", & 
					"Trovato Contratto con codice: " + string(k_codice,"#####") + "~n~r" &
					+ trim(k_sc_cf) + " - " + trim(k_descr) + "~n~r" + &
					"Vuoi proseguire ugualmente?", question!, yesno!, 2) = 2 then
		

			dw_dett_0.reset()
//			inizializza()
		
			k_return = 1
		end if
	end if  

//	attiva_tasti()



return k_return


end function

private function integer check_rek_sc_cf (string k_sc_cf);//
int k_return = 0
int k_anno
string k_descr, k_mc_co = ""
long k_codice, k_codice_1


	k_codice_1 = dw_dett_0.getitemnumber(1, "codice")  

	SELECT 
	      contratti.codice, 
         contratti.descr,
			mc_co
   	 INTO :k_codice,
      	   :k_descr,
				:k_mc_co
    	FROM contratti 
   	WHERE mc_co = :k_sc_cf and codice <> :k_codice_1;

	if sqlca.sqlcode = 0 then 
		
		if LenA(trim(k_mc_co)) = 0 then 
			k_mc_co = " "
		else
			k_mc_co = "MC-CO " + trim(k_sc_cf)
		end if
		
		if messagebox("SC-CF gia' in Archivio", & 
					"Trovato Contratto con codice: " + string(k_codice,"#####") + "~n~r" &
					+ trim(k_mc_co) + " - " + trim(k_descr) + "~n~r" + &
					"Vuoi proseguire ugualmente?", question!, yesno!, 2) = 2 then
		

			dw_dett_0.reset()
//			inizializza()
		
			k_return = 1
		end if
	end if  

//	attiva_tasti()



return k_return


end function

protected function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc,  k_ctr, k_taborder
string k_style, k_rc1
long k_key
kuf_utility kuf1_utility	


//--- legge i DWC
	legge_dwc()

	if not dw_lista_0.enabled then
//		k_key = ki_st_tab_contratti_arg.codice
	else
		k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_armo")
	end if
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( k_key ) 

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility 
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
//--- proteggi
	kuf1_utility.u_proteggi_dw("1", "colli_2", dw_dett_0)
	kuf1_utility.u_proteggi_dw("1", "pedane", dw_dett_0)
	kuf1_utility.u_proteggi_dw("1", "colli_fatt", dw_dett_0)
	destroy kuf1_utility	

	attiva_tasti()

	dw_dett_0.SetColumn("cod_sl_pt")


return k_return

end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
	
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Cambia data estrazione Lotti"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Cambia data estrazione Lotti"
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Data,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom015!"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		
	end if
	if NOT ki_menu.m_strumenti.m_fin_gest_libero2.enabled then
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Autorizza Lotto"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Autorizzazioni Lotto "
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true // ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Autorizza,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "Error!"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	end if	
	if NOT ki_menu.m_strumenti.m_fin_gest_libero3.enabled then
		ki_menu.m_strumenti.m_fin_gest_libero3.text = "imposta Voci lotto da Fatturare"
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = "imposta Voci riga lotto da Fatturare"
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true // ki_menu.m_strumenti.m_fin_gest_libero2.enabled
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Da-Fatt,"+ki_menu.m_strumenti.m_fin_gest_libero3.text
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "carrello16.png"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
	end if	
	

	super::attiva_menu()


end subroutine

protected subroutine smista_funz (string k_par_in);//===

choose case LeftA(k_par_in, 2) 

	case KKG_FLAG_RICHIESTA.libero1		//cambia data estrazione scadenze
		u_cambia_data()

	case KKG_FLAG_RICHIESTA.libero2 		//Chiama Lotto x le Autorizzazioni
		u_open_riferimenti_autorizza( )
		
	case KKG_FLAG_RICHIESTA.libero3 		//Attiva Fatturazione Voci
		u_attiva_fattura_voci_armo_prezzi()
		
	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

protected function string check_dati ();//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//
string k_return = " "
string k_errore = "0"
long k_ctr
st_tab_armo kst_tab_armo
st_esito kst_esito,kst_esito1
datastore kds_inp_testa, kds_inp_righe


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Controllo i tab
	if dw_dett_0.rowcount() > 0 then
		kst_tab_armo.id_meca = dw_dett_0.getitemnumber(1, "id_meca")  
		if kst_tab_armo.id_meca > 0 then
			kds_inp_testa = create datastore
			kds_inp_testa.dataobject = "d_meca_testata"
			kds_inp_testa.settransobject(kguo_sqlca_db_magazzino)
			kds_inp_testa.retrieve(kst_tab_armo.id_meca)  // carica Tstata del LOTTO !!!!!!
			
			kds_inp_righe = create datastore
			kds_inp_righe.dataobject = "d_armo_l_righe"
			kds_inp_righe.settransobject(kguo_sqlca_db_magazzino)
			kst_tab_armo.id_armo = dw_dett_0.getitemnumber(1, "id_armo")  
			if kst_tab_armo.id_armo > 0 then
				kds_inp_righe.retrieve(kst_tab_armo.id_meca)  // carica le righe del LOTTO !!!!!!
				if kds_inp_righe.rowcount( ) > 0 then
		//--- lascio solo la riga che mi interessa
					for k_ctr = 1 to kds_inp_righe.rowcount( ) 
						if kst_tab_armo.id_armo <>  kds_inp_righe.getitemnumber(k_ctr, "id_armo") then
							kds_inp_righe.deleterow(k_ctr)
						end if
					end for
				end if
		//--- popolo i campi letti con i valori impostati 		
				if kds_inp_righe.rowcount( ) = 1 then
					kds_inp_righe.setitem( 1, "art", dw_dett_0.getitemstring(1, "art"))
					kds_inp_righe.setitem( 1, "colli_2", dw_dett_0.getitemnumber(1, "colli_2"))
					kds_inp_righe.setitem( 1, "pedane", dw_dett_0.getitemnumber(1, "pedane"))
					kds_inp_righe.setitem( 1, "larg_2", dw_dett_0.getitemnumber(1, "larg_2"))
					kds_inp_righe.setitem( 1, "lung_2", dw_dett_0.getitemnumber(1, "lung_2"))
					kds_inp_righe.setitem( 1, "alt_2", dw_dett_0.getitemnumber(1, "alt_2"))
					kds_inp_righe.setitem( 1, "dose", dw_dett_0.getitemnumber(1, "dose"))
					kds_inp_righe.setitem( 1, "peso_kg", dw_dett_0.getitemnumber(1, "peso_kg"))
					kds_inp_righe.setitem( 1, "m_cubi", dw_dett_0.getitemnumber(1, "m_cubi"))
					kds_inp_righe.setitem( 1, "magazzino", dw_dett_0.getitemnumber(1, "magazzino"))
					kds_inp_righe.setitem( 1, "cod_sl_pt", dw_dett_0.getitemstring(1, "cod_sl_pt"))
				end if
			end if
		end if
		kds_inp_righe.ResetUpdate() 
		kst_esito = kiuf_armo_checkmappa.u_check_dati(kds_inp_testa, kds_inp_righe)
	end if
	
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

finally
	choose case kst_esito.esito
		case kkg_esito.OK
			k_errore = "0"
		case kkg_esito.ERR_LOGICO
			k_errore = "1"
		case kkg_esito.err_formale
			k_errore = "2"
		case kkg_esito.DATI_INSUFF
			k_errore = "3"
		case kkg_esito.DB_WRN
			k_errore = "4"
		case kkg_esito.DATI_WRN
			k_errore = "5"
		case else
			k_errore = "1"
	end choose

	k_return = trim(kst_esito.sqlerrtext)
	
end try


return k_errore + k_return


end function

private function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc, k_taborder
long k_key
int k_ctr
string k_rc1="", k_style, k_colore
kuf_utility kuf1_utility



	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_armo")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione 

	k_return = dw_dett_0.retrieve( k_key ) 

//--- protezione campi per visual
	kuf1_utility = create kuf_utility 
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	destroy kuf1_utility	

//	attiva_tasti()


return k_return


end function

protected subroutine riempi_id ();//
long k_riga=1



	dw_dett_0.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
	dw_dett_0.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())

////--- salva valori x ricordarli come valori di default	
//	 ki_st_tab_contratti_insert.data = dw_dett_0.getitemdate(1, "data")
//	 ki_st_tab_contratti_insert.data_scad = dw_dett_0.getitemdate(1, "data_scad")

end subroutine

protected subroutine open_start_window ();//
long k_rc=0
datawindowchild kdwc_cliente

	
	ki_sincronizza_window_consenti = false		// inizialmente nessuna sincronizzazione permessa
	
	kiuf_armo = create kuf_armo
	kiuf_listino = create kuf_listino
	kiuf_armo_nt = create kuf_armo_nt
	kiuf_armo_checkmappa = create kuf_armo_checkmappa
	kiuf_sl_pt = create kuf_sl_pt

//---
	kist_tab_meca.id = long(trim(ki_st_open_w.key1))  // ID lotto
	if isnull(kist_tab_meca.id ) then
		kist_tab_meca.id = 0
	end if
	kist_tab_meca.clie_1 =  long(trim(ki_st_open_w.key2))  // codice mandante/cliente
	if isnull(kist_tab_meca.clie_1) then
		kist_tab_meca.clie_1 = 0
	end if
	if trim(ki_st_open_w.key3) = "" then									// da quale data partire
		if isdate(trim(ki_st_open_w.key3)) then
			ki_data_scad = date(trim(ki_st_open_w.key3))
		else
			ki_data_scad = relativedate(kg_dataoggi, -180)
		end if
	else
		ki_data_scad = relativedate(kg_dataoggi, -180)
	end if

	dw_guida.insertrow(0)

//--- nasconde pulsanti
	dw_dett_0.object.b_ok.visible = false
	dw_dett_0.object.b_esci.visible = false
	

end subroutine

public subroutine legge_dwc ();//--- legge i DWC presenti
int k_rc=0
datawindowchild  kdwc_sl_pt_d



//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)



//--- Attivo dw archivio SL-PT
	k_rc = dw_dett_0.getchild("cod_sl_pt", kdwc_sl_pt_d)
	k_rc = kdwc_sl_pt_d.settransobject(sqlca)
//	kdwc_sl_pt_d.reset()
//--- Attivo dw archivio PT
	k_rc = dw_dett_0.getchild("cod_sl_pt", kdwc_sl_pt_d)
	if kdwc_sl_pt_d.rowcount() < 2 then
		kdwc_sl_pt_d.retrieve()
		kdwc_sl_pt_d.insertrow(1)
	end if



	SetPointer(kkg.pointer_default)
	
	

end subroutine

public subroutine call_listini ();//---
st_tab_listino kst_tab_listino
kuf_listino kuf1_listino
st_open_w kst_open_w

try

	if dw_lista_0.getselectedrow(0) > 0 then
		kst_tab_listino.contratto = dw_lista_0.getitemnumber(dw_lista_0.getselectedrow(0), "codice")
	
//--- protezione campi per visual
		kuf1_listino = create kuf_listino 
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kuf1_listino.link_call_imvc(kst_tab_listino, kst_open_w)
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kuf1_listino) then destroy kuf1_listino	
	
	
end try 

end subroutine

public subroutine posiziona_su_codice ();
end subroutine

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
kuf_clienti kuf1_clienti


try
	
	kuf1_clienti = create kuf_clienti

	k_return = kuf1_clienti.leggi (kst_tab_clienti)

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
	destroy kuf1_clienti
	
end try

return k_return


end function

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//
long k_riga=1

dw_dett_0.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
dw_dett_0.modify( "clienti_rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
dw_dett_0.setitem(k_riga, "rag_soc_10", kst_tab_clienti.rag_soc_10)
dw_dett_0.setitem(k_riga, "cod_cli", kst_tab_clienti.codice)

end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	
	
	ki_win_titolo_custom = "" 
	if kist_tab_meca.id > 0 then
		ki_win_titolo_custom += "per ID lotto " + string(kist_tab_meca.id) 
	else
		ki_win_titolo_custom = "dalla data del " + string(ki_data_scad) 
		if kist_tab_meca.clie_1 > 0 then
			ki_win_titolo_custom += " e per il codice anagrafica " + string(kist_tab_meca.clie_1) 
		end if
	end if
	
	dw_lista_0.reset()
	k_return = dw_lista_0.retrieve(ki_data_scad, kist_tab_meca.clie_1, kist_tab_meca.id ) 
	
	if k_return > 0 then
		ki_sincronizza_window_consenti = true		// attivo sincronizzazione 
	else
		ki_sincronizza_window_consenti = false		// nessuna sincronizzazione permessa
	end if
	
	dw_lista_0.setfocus( )
	
	attiva_tasti( )

	
return k_return
	

end function

private subroutine u_cambia_data ();//---
//--- Visualizza il box x il cambio DATA
//---


dw_data.triggerevent("ue_visibile")

end subroutine

public function integer u_open_riferimenti_autorizza ();//
//--- Chiama finestra di dettaglio
//
integer k_riga = 0
st_tab_g_0 kst_tab_g_0
kuf_meca_autorizza kuf1_meca_autorizza

try
	k_riga = dw_lista_0.getrow()	
	if k_riga > 0 then
		
		kst_tab_g_0.id = dw_lista_0.getitemnumber(k_riga, "id_meca") // id
		if kst_tab_g_0.id > 0 then
	
			kuf1_meca_autorizza = create kuf_meca_autorizza
			if kuf1_meca_autorizza.if_sicurezza(kkg_flag_modalita.modifica) then
				kuf1_meca_autorizza.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.modifica )
			else
				kuf1_meca_autorizza.u_open_applicazione(kst_tab_g_0, kkg_flag_modalita.visualizzazione )
			end if
		else
			messagebox("Operazione non eseguita", "ID Lotto non identificato")
									
		end if							
	else
	
		messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
	
	end if

 
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

 
end try
 
return k_riga

end function

private subroutine u_dw_riga_ricalcolo (ref st_tab_armo ast_tab_armo);//--
//---  Ricalcolo dei campi in base al numero colli indicato in INPUT
//---
st_tab_listino kst_tab_listino

try
	if ast_tab_armo.colli_2 > 0 then

		kst_tab_listino.occup_ped = dw_dett_0.getitemnumber(1, "listino_occup_ped")
		kst_tab_listino.peso_kg = dw_dett_0.getitemnumber(1, "listino_peso_kg")
		kst_tab_listino.m_cubi_f = dw_dett_0.getitemnumber(1, "listino_m_cubi")
		u_dw_riga_ricalcolo_1(ast_tab_armo, kst_tab_listino)

		if ast_tab_armo.pedane > 0 then
		else
			ast_tab_armo.pedane = dw_dett_0.getitemnumber(1, "pedane")
		end if
		if ast_tab_armo.peso_kg > 0 then
		else
			ast_tab_armo.peso_kg = dw_dett_0.getitemnumber(1, "peso_kg")
		end if
		if ast_tab_armo.m_cubi > 0 then
		else
			ast_tab_armo.m_cubi = dw_dett_0.getitemnumber(1, "m_cubi")
		end if
		
	else
		kst_tab_listino.occup_ped = 0
		kst_tab_listino.peso_kg = 0
		ast_tab_armo.m_cubi = 0
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try




end subroutine

private subroutine u_dw_riga_ricalcolo_1 (ref st_tab_armo ast_tab_armo, ref st_tab_listino ast_tab_listino);//--
//---  Ricalcolo dei campi in base al numero colli indicato in INPUT
//---

	
	if ast_tab_armo.colli_2 > 0 then
		if ast_tab_listino.occup_ped > 0 then
			ast_tab_armo.pedane = ast_tab_armo.colli_2 * ast_tab_listino.occup_ped / 100
		else
			ast_tab_armo.pedane = 0
		end if
		if ast_tab_listino.peso_kg > 0 then
			ast_tab_armo.peso_kg = ast_tab_armo.colli_2 * ast_tab_listino.peso_kg
		else
			ast_tab_armo.peso_kg = 0
		end if

		if ast_tab_listino.m_cubi_f > 0 then
		else
			ast_tab_listino.m_cubi_f = (ast_tab_listino.mis_x/1000 * ast_tab_listino.mis_y/1000 * ast_tab_listino.mis_z/1000)
		end if
		if ast_tab_listino.m_cubi_f > 0 then
			ast_tab_armo.m_cubi = ast_tab_armo.colli_2 * ast_tab_listino.m_cubi_f
		else
			ast_tab_armo.m_cubi = 0
		end if
	else
		ast_tab_listino.occup_ped = 0
		ast_tab_listino.peso_kg = 0
		ast_tab_armo.m_cubi = 0
	end if
	




end subroutine

protected function string aggiorna_tabelle ();//
string k_return = "0"
st_tab_armo_nt kst_tab_armo_nt
st_esito kst_esito



	if dw_dett_0.getitemstatus(1, "armo_nt_note_1", primary!) = DataModified! &
			or  dw_dett_0.getitemstatus(1, "armo_nt_note_2", primary!) = DataModified! &
			or  dw_dett_0.getitemstatus(1, "armo_nt_note_3", primary!) = DataModified! &
			or  dw_dett_0.getitemstatus(1, "armo_nt_note_4", primary!) = DataModified! &
			or  dw_dett_0.getitemstatus(1, "armo_nt_note_5", primary!) = DataModified! &
			or  dw_dett_0.getitemstatus(1, "armo_nt_note_6", primary!) = DataModified! &
			or  dw_dett_0.getitemstatus(1, "armo_nt_note_7", primary!) = DataModified! &
			or  dw_dett_0.getitemstatus(1, "armo_nt_note_8", primary!) = DataModified! &
			or  dw_dett_0.getitemstatus(1, "armo_nt_note_9", primary!) = DataModified! &
			or  dw_dett_0.getitemstatus(1, "armo_nt_note_10", primary!) = DataModified! then

		kst_tab_armo_nt.id_armo = dw_dett_0.getitemnumber(1, "id_armo")
		kst_tab_armo_nt.note[1] = trim(dw_dett_0.getitemstring(1, "armo_nt_note_1"))
		kst_tab_armo_nt.note[2] = trim(dw_dett_0.getitemstring(1, "armo_nt_note_2"))
		kst_tab_armo_nt.note[3] = trim(dw_dett_0.getitemstring(1, "armo_nt_note_3"))
		kst_tab_armo_nt.note[4] = trim(dw_dett_0.getitemstring(1, "armo_nt_note_4"))
		kst_tab_armo_nt.note[5] = trim(dw_dett_0.getitemstring(1, "armo_nt_note_5"))
		kst_tab_armo_nt.note[6] = trim(dw_dett_0.getitemstring(1, "armo_nt_note_6"))
		kst_tab_armo_nt.note[7] = trim(dw_dett_0.getitemstring(1, "armo_nt_note_7"))
		kst_tab_armo_nt.note[8] = trim(dw_dett_0.getitemstring(1, "armo_nt_note_8"))
		kst_tab_armo_nt.note[9] = trim(dw_dett_0.getitemstring(1, "armo_nt_note_9"))
		kst_tab_armo_nt.note[10] = trim(dw_dett_0.getitemstring(1, "armo_nt_note_10"))

		try
			
			kiuf_armo_nt.tb_update_armo_nt(kst_tab_armo_nt)  // aggiorna NOTE
			
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			k_return = "1Errore: " + kst_esito.esito + " " + trim(kst_esito.sqlerrtext) + " (" + string(kst_esito.SQLcode) + ")" 
			
		end try

	end if
	
	if dw_dett_0.update() <> 1 then

		k_return = "1Errore: " + dw_dett_0.ki_SQLsyntax + " (" + string(dw_dett_0.ki_SQLdbcode) + ")" 

	end if
	

return k_return
end function

private subroutine call_art_x_contratto ();//
//--- Fa l'elenco Articoli x contratto
//
long k_righe_articoli=0, k_riga_nuova_in_lista=0
st_tab_meca kst_tab_meca
st_tab_armo kst_tab_armo
st_tab_armo_nt kst_tab_armo_nt
st_open_w kst_open_w
datastore kds_1	
kuf_elenco kuf1_elenco


try
	
	SetPointer(kkg.pointer_attesa )

	if not isvalid(kds_1) then
		kds_1 = create datastore
	end if
	kst_tab_meca.contratto = dw_lista_0.getitemnumber( 1, "contratto")
	kst_tab_meca.clie_3 = dw_lista_0.getitemnumber( 1, "clie_3")
	if kst_tab_meca.contratto > 0 then
		if isnull(kst_tab_meca.clie_3) then kst_tab_meca.clie_3 = 0
		kds_1.dataobject = "d_listino_l_x_contratto" 
		kds_1.settransobject(sqlca) 
		k_righe_articoli = kds_1.retrieve(kst_tab_meca.contratto, kst_tab_meca.clie_3)
	else
		kguo_exception.inizializza( )
		kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito )
		kguo_exception.setmessage("Non è stato indicato alcun Contratto in Testata, operazione bloccata")
		throw kguo_exception
	end if
	if k_righe_articoli > 0 then
		dw_dett_0.setfocus( )
//--- elenco righe contratto 	
		kuf1_elenco = create kuf_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		if kst_tab_meca.clie_3 > 0 then
			kst_open_w.key1 = "Elenco Articoli per il Contratto " + string(kst_tab_meca.contratto) + " e Cliente " + string(kst_tab_meca.clie_3)
		else
			kst_open_w.key1 = "Elenco Articoli per il Contratto " + string(kst_tab_meca.contratto) 
		end if
		kst_open_w.key2 = trim(kds_1.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = trim(this.title)    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kds_1
		kst_open_w.key7 = kuf1_elenco.ki_esci_dopo_scelta  // esce subito dopo la scelta
		kuf1_elenco.u_open(kst_open_w)
	else
		messagebox("Elenco articoli contratto", "Nessun valore disponibile per il Contratto: " + string(kst_tab_meca.contratto) + " del Cliente " + string(kst_tab_meca.clie_3))
	end if
						
catch (uo_exception kuo_exception)
	SetPointer(kkg.pointer_default)
	kuo_exception.messaggio_utente()
	
finally
	SetPointer(kkg.pointer_default )
	
end try


	



		
		
		


end subroutine

public subroutine u_video_sl_pt_misure (st_tab_sl_pt kst_tab_sl_pt);//
//--- Mette in mappa i dati x/y/z + dose
//
double k_m_cubi = 0.00

	if kst_tab_sl_pt.mis_x > 0 then
		dw_dett_0.setitem(1, "larg_2", kst_tab_sl_pt.mis_z)
		dw_dett_0.setitem(1, "lung_2", kst_tab_sl_pt.mis_x)
		dw_dett_0.setitem(1, "alt_2", kst_tab_sl_pt.mis_y)
		k_m_cubi = (kst_tab_sl_pt.mis_x/1000 *  kst_tab_sl_pt.mis_y/1000 *  kst_tab_sl_pt.mis_z/1000)
		dw_dett_0.setitem( 1, "m_cubi", k_m_cubi)
	end if

	if kst_tab_sl_pt.dose > 0 then
		dw_dett_0.setitem(1, "dose", kst_tab_sl_pt.dose)
	end if
	
	
end subroutine

private subroutine call_lotto (long a_id_meca);//
//--- Fa elenco Contratti x Mandante
//
long k_riga
st_open_w kst_open_w
//st_tab_meca kst_tab_meca


//k_riga = dw_dett_0.getselectedrow(0)
//if k_riga > 0 then	
//	kst_tab_meca.id = dw_dett_0.getitemnumber( k_riga, "id_meca")
	if a_id_meca > 0 then
		SetPointer(kkg.pointer_attesa )
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.modifica
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.key1 = string(a_id_meca)
		kiuf_armo.u_open(kst_open_w)
		SetPointer(kkg.pointer_default )
	else
		kguo_exception.messaggio_utente("Modifica Lotto", "Nessun Lotto da aprire, id non indicato ")
	end if
//else
//	kguo_exception.messaggio_utente("Modifica Lotto", "Nessun Lotto da aprire, selezionare una riga in elenco ")
//end if
//				

	



		
		
		


end subroutine

public function long u_attiva_fattura_voci_armo_prezzi ();//
//--- Attiva fatturazione x le Voci Prezzi Lotto
//--- out: numero di righe aggiornate
//
st_tab_armo_prezzi kst_tab_armo_prezzi
kuf_armo_prezzi kuf1_armo_prezzi
long k_riga = 0, k_return=0
int k_sn

try

	k_riga = dw_lista_0.getselectedrow(k_riga)

	if  k_riga > 0 then

		if  dw_lista_0.getselectedrow(k_riga) > 0 then
			k_sn = messagebox("MULTIPLA Attivazione Fatturazione Voci", "Confermare l'operazione di cambio stato a  'da Fatturare' sulle righe Lotto selezionate" , question!, yesno!, 2)
		else
			k_sn = messagebox("Attiva Fatturazione Voci", "Confermare l'operazione di cambio stato a  'da Fatturare'  sul Lotto n." + string(dw_lista_0.getitemnumber(k_riga, "id_meca")) + " (riga "+ string(dw_lista_0.getitemnumber(k_riga, "id_armo")) + ")", question!, yesno!, 2)
		end if
	end if

	if k_sn = 2 then
		messagebox("Attivazione Fatturazione Voci", "Operazione annullata dall'utente")
	else
		kuf1_armo_prezzi = create kuf_armo_prezzi

		k_riga = dw_lista_0.getselectedrow(0)
		do while k_riga > 0 
	
		
			kst_tab_armo_prezzi.id_armo = dw_lista_0.getitemnumber(k_riga, "id_armo")
			kuf1_armo_prezzi.set_dafatt_x_id_armo(kst_tab_armo_prezzi)
			k_return ++
			
			k_riga = dw_lista_0.getselectedrow(k_riga)
		loop

		messagebox("Operazione terminata", "Sono state aggiornate " + string(k_return) + " righe lotto.")
		
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	if isvalid(kuf1_armo_prezzi) then destroy kuf1_armo_prezzi
	
end try

return k_return

end function

on w_meca_l_armo.create
int iCurrent
call super::create
this.dw_data=create dw_data
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_data
end on

on w_meca_l_armo.destroy
call super::destroy
destroy(this.dw_data)
end on

event close;call super::close;//
if isvalid(kiuf_armo)  then destroy kiuf_armo
if isvalid(kiuf_listino)  then destroy kiuf_listino


end event

event u_open;call super::u_open;//
	ki_win_titolo_custom = " dalla data del " + string(ki_data_scad) 

end event

type st_ritorna from w_g_tab0`st_ritorna within w_meca_l_armo
integer x = 2821
integer y = 980
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_meca_l_armo
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_meca_l_armo
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_meca_l_armo
integer x = 2880
integer y = 1768
end type

type st_stampa from w_g_tab0`st_stampa within w_meca_l_armo
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_meca_l_armo
integer x = 2834
integer y = 1664
end type

type cb_modifica from w_g_tab0`cb_modifica within w_meca_l_armo
integer x = 2926
integer y = 1240
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_meca_l_armo
integer x = 2894
integer y = 1536
end type

type cb_cancella from w_g_tab0`cb_cancella within w_meca_l_armo
integer x = 2880
integer y = 1384
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_meca_l_armo
integer x = 2907
integer y = 1092
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_meca_l_armo
event u_set_m_cubi ( )
integer x = 5
integer y = 792
integer width = 2784
integer height = 1148
boolean enabled = true
string dataobject = "d_armo_riga"
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
end type

event dw_dett_0::u_set_m_cubi();//======================================================================
//=== 
//======================================================================
//
long k_riga=0, k_riga1=0, k_progressivo
double k_m_cubi = 0.00
st_tab_armo kst_tab_armo 
st_tab_listino kst_tab_listino


try
	
	kst_tab_armo.id_listino = this.getitemnumber(1, "id_listino" )
	if kst_tab_armo.id_listino > 0 then		

		kst_tab_armo.colli_2 = this.getitemnumber(1, "colli_2" )
		kst_tab_listino.id = kst_tab_armo.id_listino
		kiuf_listino.get_dati_x_armo(kst_tab_listino)   // get dati da listino

		u_dw_riga_ricalcolo_1(kst_tab_armo, kst_tab_listino) // calcola

		this.setitem( 1, "peso_kg", kst_tab_armo.peso_kg)

	end if
		
	if kst_tab_armo.m_cubi = 0 then
		kst_tab_armo.larg_2 = this.getitemnumber(1, "larg_2")
		kst_tab_armo.lung_2 = this.getitemnumber(1, "lung_2")
		kst_tab_armo.alt_2 = this.getitemnumber(1, "alt_2")
		kst_tab_armo.m_cubi = (kst_tab_armo.larg_2/1000 *  kst_tab_armo.lung_2/1000 *  kst_tab_armo.alt_2/1000)
		this.setitem( 1, "m_cubi", kst_tab_armo.m_cubi)
	end if
	
	if isnull(kst_tab_armo.m_cubi) then kst_tab_armo.m_cubi = 0.00 

	this.setitem( 1, "m_cubi", kst_tab_armo.m_cubi)
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try


	
end event

event dw_dett_0::itemchanged;call super::itemchanged;//
string  k_sl_pt
long k_rc, k_riga=0
integer k_return=0
st_tab_sl_pt kst_tab_sl_pt
datawindowchild kdwc_x


choose case upper(dwo.name)

		
	case "COD_SL_PT" 

		k_sl_pt = upper(trim(data))
		this.modify("cod_sl_pt.background = " + string( kkg_colore.bianco ))
		if isnull(k_sl_pt) = false and LenA(trim(k_sl_pt)) > 0 then
			
			k_rc = this.getchild("cod_sl_pt", kdwc_x)
			k_rc = kdwc_x.find("cod_sl_pt =~""+(k_sl_pt)+"~"",0,kdwc_x.rowcount())
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				try
					kst_tab_sl_pt.cod_sl_pt = k_sl_pt
					kiuf_sl_pt.get_misure(kst_tab_sl_pt)  // legge le misure dalla tabella
					post u_video_sl_pt_misure(kst_tab_sl_pt)
				catch (uo_exception kuo_exception)
					k_return = 2
					this.modify("cod_sl_pt.background = " + string( kkg_colore.err_dato ))
				end try
			else
				kst_tab_sl_pt.mis_x =  kdwc_x.getitemnumber( k_riga, "mis_x")
				kst_tab_sl_pt.mis_y =  kdwc_x.getitemnumber( k_riga, "mis_y")
				kst_tab_sl_pt.mis_z =  kdwc_x.getitemnumber( k_riga, "mis_z")
				kst_tab_sl_pt.dose =  kdwc_x.getitemnumber( k_riga, "dose")
				post u_video_sl_pt_misure(kst_tab_sl_pt)
			end if
			
		end if

		
end choose

return k_return



end event

event dw_dett_0::clicked;call super::clicked;//
//=== Premuto pulsante nella DW
//
string k_nome

	this.accepttext( )

	k_nome = lower(trim(dwo.name))
	choose case k_nome

//--- elenco Articoli
		case "p_img_listino_1"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				call_art_x_contratto()
			else
				messagebox("Operazione bloccata", "Funzione non attiva per questa modalità", Information!)
			end if

//--- ricalcolo m cubi
		case "p_img_m_cubi"
			if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento or ki_st_open_w.flag_modalita =  kkg_flag_modalita.modifica then
				event u_set_m_cubi()
			end if

		
	end choose


	post attiva_tasti()

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_meca_l_armo
integer x = 0
integer y = 744
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_meca_l_armo
integer x = 23
integer width = 3291
integer height = 732
string dataobject = "d_armo_l_cntr_sd"
end type

event dw_lista_0::clicked;call super::clicked;//
//=== Premuto pulsante nella DW
//
string k_nome
st_tab_meca kst_tab_meca


	k_nome = lower(trim(dwo.name))
	choose case k_nome

//--- elenco Articoli
		case "img_p_lotto_sd", "id_meca_1"
			kst_tab_meca.id = this.getitemnumber( row, "id_meca")
			call_lotto(kst_tab_meca.id)

		
	end choose


//	post attiva_tasti()

end event

type dw_guida from w_g_tab0`dw_guida within w_meca_l_armo
boolean visible = true
integer y = 8
boolean enabled = true
string dataobject = "d_meca_l_armo_guida"
end type

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---
boolean k_elabora=true
string k_codice_x, k_numero_x, k_anno_x, k_cliente_x
long k_codice
st_tab_armo kst_tab_armo

   kist_tab_meca.id = dw_guida.getitemnumber(1, "id_meca")
   if isnull( kist_tab_meca.id ) then
      kist_tab_meca.id = 0
   end if


//--- solo se ricerco un codice diverso
	k_codice_x = trim(dw_guida.getitemstring(1, "codice"))
	if isnull(k_codice_x) then k_codice_x = ""
	if ki_ultimo_codice_cercato <> k_codice_x then
		ki_ultimo_codice_cercato = k_codice_x

//--- se la stringa di ricerca è vuota allora mostra tutto			
		if len(k_codice_x) = 0 then 	
			kist_tab_meca.id = 0
			kist_tab_meca.clie_1 = 0
			u_retrieve_dw_lista()
		else
			if pos(k_codice_x, "/", 1) > 1 then
				k_numero_x = trim(left(k_codice_x, pos(k_codice_x, "/", 1) - 1))
				k_anno_x = trim(mid(k_codice_x, pos(k_codice_x, "/", 1) + 1))
				if len(trim(k_anno_x)) = 0 then 
					k_anno_x = string(kguo_g.get_anno( ))
					k_cliente_x = k_numero_x    //potrebbe essere un cliente poichè ho digitato solo un numero es "397/"
				end if
				if isnumber(k_numero_x) then
					k_codice_x = k_numero_x
				end if
			else
				k_cliente_x = k_codice_x
				k_numero_x = k_codice_x
				k_anno_x = string(kguo_g.get_anno())
			end if
			
			if k_codice_x > " " then 
			else
				k_codice_x = "0"  
				k_numero_x = "0" 
			end if
			
			if not isnumber(k_codice_x) or not isnumber(k_numero_x) or not isnumber(k_anno_x) then
				kguo_exception.messaggio_utente( "Codice Lotto non numerico", "Digitare: num. lotto oppure il numero e anno separati da un '/' oppure il codice ID lotto, oppure il codice Cliente/Mandante")
			else
				k_codice = long(k_codice_x)
				if k_codice < 50000 then // se minore di 50 mila sicuramente si tratta di un numero lotto o codice cliente altrimentise > 5000 di un ID lotto 
					kst_tab_armo.num_int = k_codice
					kst_tab_armo.data_int = date(integer(k_anno_x), 01, 01)
					kiuf_armo.get_id_meca(kst_tab_armo)
					kist_tab_meca.id = kst_tab_armo.id_meca
					kist_tab_meca.clie_1 = long(k_cliente_x)
				else
					kist_tab_meca.id = k_codice
					kist_tab_meca.clie_1 = 0
				end if
				
				dw_guida.setitem(1, "id_meca", kist_tab_meca.id)
					
				if kist_tab_meca.id > 0 or kist_tab_meca.clie_1 > 0 then
					u_retrieve_dw_lista()
				end if
				
			end if
		end if            
      end if
//   end if

end event

type dw_data from uo_d_std_1 within w_meca_l_armo
integer x = 2651
integer y = 260
integer width = 827
integer height = 492
integer taborder = 70
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Scadenze dal"
string dataobject = "d_data"
boolean controlmenu = true
boolean hsplitscroll = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//
st_stampe kst_stampe
pointer oldpointer  // Declares a pointer variable

	
//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)
	

if dwo.name = "b_ok" then
	
	
	this.visible = false
	
	ki_data_scad  = this.getitemdate( 1, "kdata")
	inizializza()

else
	if dwo.name = "b_annulla" then

		this.visible = false
	
	
	end if
end if

SetPointer(oldpointer)


end event

event ue_visibile;call super::ue_visibile;//
int k_rc

	this.width = long(this.object.kdata.x) + long(this.object.kdata.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 160

	this.x = (kiw_this_window.width  - this.width) / 4
	this.y = (kiw_this_window.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	k_rc = this.setitem(1, "kdata", ki_data_scad)
	this.visible = true
	this.setfocus()
end event

