$PBExportHeader$w_m_r_f.srw
forward
global type w_m_r_f from w_g_tab0
end type
end forward

global type w_m_r_f from w_g_tab0
integer width = 2994
integer height = 1984
string title = ""
boolean ki_toolbar_window_presente = true
end type
global w_m_r_f w_m_r_f

type variables
//
private kuf_clienti kiuf_clienti
private st_tab_clienti_m_r_f ki_st_tab_clienti_m_r_f, ki_st_tab_clienti_m_r_f_orig
private string ki_path_centrale =""


end variables

forward prototypes
public function string inizializza ()
private function string check_dati ()
private function string cancella ()
protected function integer visualizza ()
protected function integer inserisci ()
private function integer modifica ()
protected subroutine open_start_window ()
public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti)
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
protected subroutine riempi_id ()
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti, integer k_ctr)
protected function boolean aggiorna_tabelle_altre () throws uo_exception
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
//string k_key
long k_riga
int k_importa = 0
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//	if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.inserimento then 
//		
//		cb_inserisci.postevent(clicked!)
//		
//	else

//=== Legge le righe del dw salvate l'ultima volta (importfile)
		if ki_st_open_w.flag_primo_giro = 'S' then //se giro di prima volta
	
			k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
	
		end if
			
		
		if k_importa <= 0 then // Nessuna importazione eseguita
	
	
			if dw_lista_0.retrieve( ki_st_tab_clienti_m_r_f.clie_1, ki_st_tab_clienti_m_r_f.clie_2, ki_st_tab_clienti_m_r_f.clie_3 ) < 1 then
				k_return = "1Legami Clienti Non trovati  "
	
				SetPointer(oldpointer)
				messagebox("Lista 'Legami Clienti' Vuota", &
						"Nesun Codice Trovato per la richiesta fatta")
			else
				
				if ki_st_open_w.flag_primo_giro = "S" then 
					k_riga = 1
//--- se ho passato anche il CLIENTE allora....
					if ki_st_tab_clienti_m_r_f.clie_1 > 0 then
						k_riga = dw_lista_0.find( "clie_1 = " + string(ki_st_tab_clienti_m_r_f.clie_1) + " ", 1, dw_lista_0.rowcount( ) )
					end if
					if k_riga > 0 then 
						dw_lista_0.selectrow( 0, false)
						dw_lista_0.scrolltorow( k_riga)
						dw_lista_0.setrow( k_riga)
						dw_lista_0.selectrow( k_riga, true)
					end if
					
//--- se entro per modificare allora....
					if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.modifica then 
						cb_modifica.postevent(clicked!)
					end if
				end if
	
			end if		
		end if
	
//	end if
	attiva_tasti()
	
 	SetPointer(oldpointer)
	
return k_return



end function

private function string check_dati ();//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===                : 3=dati insufficienti; 4=OK con errori non gravi
//===                      : 5=OK con avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//=== Controllo dati inseriti
string k_return = ""
string k_errore = "0"
int k_rc=0
long k_riga
string k_descr=""
st_esito kst_esito
st_tab_clienti_m_r_f kst_tab_clienti_mrf
kuf_clienti kuf1_clienti


   k_riga = dw_dett_0.getrow()

   kst_tab_clienti_mrf.clie_1 = dw_dett_0.getitemnumber ( k_riga, "clie_1") 
   if isnull(kst_tab_clienti_mrf.clie_1) or kst_tab_clienti_mrf.clie_1 = 0 then
      k_return = k_return + "Manca il Mandante " + "~n~r"
      k_errore = "3"

   end if

   
//--- errori diversi
	if trim(k_errore) = "0" or trim(k_errore) = "4"  or trim(k_errore) = "5" then
			
	   kst_tab_clienti_mrf.clie_2 = dw_dett_0.getitemnumber ( k_riga, "clie_2") 
		if isnull(kst_tab_clienti_mrf.clie_2) or kst_tab_clienti_mrf.clie_2 = 0 then
					k_return = k_return + "Manca il Ricevente " + "~n~r" 
					k_errore = "4"
			end if
	
	   kst_tab_clienti_mrf.clie_3 = dw_dett_0.getitemnumber ( k_riga, "clie_3") 
		if isnull(kst_tab_clienti_mrf.clie_3) or kst_tab_clienti_mrf.clie_3 = 0 then
					k_return = k_return + "Manca il Cliente di fatturazione " + "~n~r" 
					k_errore = "4"
		end if
	
	
	end if

	if trim(k_errore) = "0" or trim(k_errore) = "4"  or trim(k_errore) = "5" then
   		
//--- controllo se record già presente			
		try
			if ki_st_tab_clienti_m_r_f_orig.clie_1 <> kst_tab_clienti_mrf.clie_1 &
						or ki_st_tab_clienti_m_r_f_orig.clie_2 <> kst_tab_clienti_mrf.clie_2 &
						or ki_st_tab_clienti_m_r_f_orig.clie_3 <> kst_tab_clienti_mrf.clie_3 then
				kst_tab_clienti_mrf.clie_1 = dw_dett_0.getitemnumber ( k_riga, "clie_1") 
				kst_tab_clienti_mrf.clie_2 = dw_dett_0.getitemnumber ( k_riga, "clie_2") 
				kst_tab_clienti_mrf.clie_3 = dw_dett_0.getitemnumber ( k_riga, "clie_3") 
				if kiuf_clienti.if_presente_m_r_f(kst_tab_clienti_mrf) then
					k_errore = "1"
					k_return = k_return + "Legame Clienti già presente " + "~n~r" 
				end if
			end if

		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
			k_return = k_return + kst_esito.sqlerrtext
			k_errore = "1"
		finally

		end try
		
	end if
	
	
return trim(k_errore) + trim(k_return)


end function

private function string cancella ();//
string k_return="0 "
string k_descr, k_descr1, k_descr2
string k_codice
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_tab_clienti_m_r_f kst_tab_clienti_mrf
st_esito kst_esito


//=== Controllo se sul dettaglio c'e' qualche cosa
if dw_dett_0.visible and dw_dett_0.rowcount() > 0 then
	k_riga = 1
	k_codice = string(dw_dett_0.getitemnumber(1, "clie_1"))
	k_descr = trim(dw_dett_0.getitemstring(1, "client_a_rag_soc_10"))
	k_descr1 = trim(dw_lista_0.getitemstring(k_riga, "client_b_rag_soc_10"))
	k_descr2 = trim(dw_lista_0.getitemstring(k_riga, "client_c_rag_soc_10"))
	kst_tab_clienti_mrf.clie_1 = dw_dett_0.getitemnumber(1, "clie_1") 
	kst_tab_clienti_mrf.clie_2 = dw_dett_0.getitemnumber(1, "clie_2") 
	kst_tab_clienti_mrf.clie_3 = dw_dett_0.getitemnumber(1, "clie_3") 
else
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
	k_riga = dw_lista_0.getselectedrow(0)	
	if k_riga > 0 then
		k_codice = string(dw_lista_0.getitemnumber(k_riga, "clie_1"))
		k_descr = trim(dw_lista_0.getitemstring(k_riga, "clienti_rag_soc_1"))
		k_descr1 = trim(dw_lista_0.getitemstring(k_riga, "clienti_rag_soc_2"))
		k_descr2 = trim(dw_lista_0.getitemstring(k_riga, "clienti_rag_soc_3"))
		kst_tab_clienti_mrf.clie_1 = dw_lista_0.getitemnumber(k_riga, "clie_1") 
		kst_tab_clienti_mrf.clie_2 = dw_lista_0.getitemnumber(k_riga, "clie_2") 
		kst_tab_clienti_mrf.clie_3 = dw_lista_0.getitemnumber(k_riga, "clie_3") 
	end if
end if

if isnull(k_codice) then
	k_codice = ". "
end if
if isnull(k_descr) = true or trim(k_descr) = "" then
	k_descr = "Mandante senza nominativo" 
end if

if k_riga > 0 and isnull(k_codice) = false then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina "  + this.title , "Sei sicuro di voler Cancellare il Legame: ~n~r" &
	             + string(kst_tab_clienti_mrf.clie_1) + " " + trim(k_descr) + " ~n~r" &
	             + string(kst_tab_clienti_mrf.clie_2) + " " + trim(k_descr1) + " ~n~r" &
	             + string(kst_tab_clienti_mrf.clie_3) + " " + trim(k_descr2), &
				question!, yesno!, 2) = 1 then
 
		
//=== Cancella la riga dal data windows di lista
		k_errore = kiuf_clienti.tb_delete_m_r_f(kst_tab_clienti_mrf) 
		if left(k_errore,1) = "0"  then

			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + MidA(k_errore, 2))

			else

//--- cancello riga a video
				k_codice = " "
//				k_riga = dw_dett_0.rowcount()	
				if dw_dett_0.visible and dw_dett_0.rowcount() > 0 then
//					k_codice = string(dw_dett_0.getitemnumber(1, "id_email_invio"))
					dw_dett_0.deleterow(1)
					
//					mostra_nascondi_dw()
					
				else
					if k_riga > 0 then
						dw_lista_0.deleterow(k_riga)
					end if
				end if

			end if

			dw_dett_0.setfocus()

		else
			k_errore1 = k_errore
			k_errore = kGuf_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							MidA(k_errore1, 2) ) 	
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + MidA(k_errore, 2))
			end if

			attiva_tasti()
	

		end if

	else
		messagebox("Elimina " + this.title , "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
//

end function

protected function integer visualizza ();//===
//=== Lettura del rek da visual.
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
st_tab_clienti_m_r_f kst_tab_clienti_m_r_f
kuf_utility kuf1_utility



	kst_tab_clienti_m_r_f.clie_1 = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "clie_1")
	kst_tab_clienti_m_r_f.clie_2 = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "clie_2")
	kst_tab_clienti_m_r_f.clie_3 = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "clie_3")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione

	k_return = dw_dett_0.retrieve( kst_tab_clienti_m_r_f.clie_1, kst_tab_clienti_m_r_f.clie_2, kst_tab_clienti_m_r_f.clie_3 ) 

//
//--- protezione campi per impedire la modifica
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	destroy kuf1_utility

	attiva_tasti()

return k_return

end function

protected function integer inserisci ();//
int k_rc, k_ctr, k_taborder
string k_rc1, k_style
long k_riga
//kuf_utility kuf1_utility
st_esito kst_esito
//datawindowchild kdwc_clienti_d


	ki_st_tab_clienti_m_r_f_orig.clie_1 = 0  // salva il record con la chiave in modo da evitare dupliche
	ki_st_tab_clienti_m_r_f_orig.clie_2 = 0  // salva il record con la chiave in modo da evitare dupliche
	ki_st_tab_clienti_m_r_f_orig.clie_3 = 0  // salva il record con la chiave in modo da evitare dupliche

	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 

	dw_dett_0.reset()
	dw_dett_0.insertrow(0)
	
	dw_dett_0.setitem(dw_dett_0.getrow(), "clie_1", 0 )
	dw_dett_0.setitem(dw_dett_0.getrow(), "clie_2", 0 )
	dw_dett_0.setitem(dw_dett_0.getrow(), "clie_3", 0 )
	dw_dett_0.setitem(dw_dett_0.getrow(), "clienti_a_rag_soc_10", "" )
	dw_dett_0.setitem(dw_dett_0.getrow(), "clienti_b_rag_soc_10", "" )
	dw_dett_0.setitem(dw_dett_0.getrow(), "clienti_c_rag_soc_10", "" )

	dw_dett_0.setcolumn(1)
	
//--- S-protezione campi per riabilitare la modifica a parte la chiave
//	kuf1_utility = create kuf_utility
//	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
//	kuf1_utility.u_proteggi_dw("0", "b_path_lettera", dw_dett_0)
//	destroy kuf1_utility  

	attiva_tasti()

//=== Posiziona il cursore sul Data Windows
	dw_dett_0.ResetUpdate ( ) 
	dw_dett_0.setfocus() 


return (0)


end function

private function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
string k_style, k_rc1
st_tab_clienti_m_r_f kst_tab_clienti_m_r_f
kuf_utility kuf1_utility



	kst_tab_clienti_m_r_f.clie_1 = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "clie_1")
	kst_tab_clienti_m_r_f.clie_2 = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "clie_2")
	kst_tab_clienti_m_r_f.clie_3 = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "clie_3")
	
	ki_st_tab_clienti_m_r_f_orig = kst_tab_clienti_m_r_f  // salva il record con la chiave in modo da evitare dupliche
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( kst_tab_clienti_m_r_f.clie_1, kst_tab_clienti_m_r_f.clie_2, kst_tab_clienti_m_r_f.clie_3 ) 


//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
   	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)

	attiva_tasti()

//=== Posiziona il cursore sul Data Windows
	dw_dett_0.SetColumn(1)
	dw_dett_0.ResetUpdate ( ) 
	dw_dett_0.setfocus() 


return k_return

end function

protected subroutine open_start_window ();//---
string k_esito
int k_rc
kuf_base kuf1_base
datawindowchild  kdwc_clienti_1, kdwc_clienti_2, kdwc_clienti_3,  kdwc_clienti_des_1, kdwc_clienti_des_2, kdwc_clienti_des_3


	kiuf_clienti = create kuf_clienti

	ki_toolbar_window_presente=true

//--- Salva Argomenti programma chiamante
	if Len(trim(ki_st_open_w.key1)) = 0 then // mandante
		ki_st_tab_clienti_m_r_f.clie_1 = 0
	else
		ki_st_tab_clienti_m_r_f.clie_1 = long(trim(ki_st_open_w.key1))
	end if
	if Len(trim(ki_st_open_w.key2)) = 0 then // Ricevente
		ki_st_tab_clienti_m_r_f.clie_2 = 0
	else
		ki_st_tab_clienti_m_r_f.clie_2 = long(trim(ki_st_open_w.key2))
	end if
	if Len(trim(ki_st_open_w.key3)) = 0 then // Fatturato
		ki_st_tab_clienti_m_r_f.clie_3 = 0
	else
		ki_st_tab_clienti_m_r_f.clie_3 = long(trim(ki_st_open_w.key3))
	end if


//--- Attivo dw archivio Clienti
	k_rc = dw_dett_0.getchild("clie_1", kdwc_clienti_1)
	k_rc = kdwc_clienti_1.settransobject(sqlca)
	k_rc = kdwc_clienti_1.insertrow(1)
	k_rc = dw_dett_0.getchild("clienti_a_rag_soc_10", kdwc_clienti_des_1)
	k_rc = kdwc_clienti_des_1.settransobject(sqlca)
	k_rc = kdwc_clienti_des_1.insertrow(1)
	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
		if kdwc_clienti_1.rowcount() < 2 then
			kdwc_clienti_1.retrieve("%")
			kdwc_clienti_1.RowsCopy(kdwc_clienti_1.GetRow(), kdwc_clienti_1.RowCount(), Primary!, kdwc_clienti_des_1, 1, Primary!)
			kdwc_clienti_1.setsort( "id_cliente A")
			kdwc_clienti_1.sort( )
			k_rc = kdwc_clienti_1.insertrow(1)
			k_rc = kdwc_clienti_des_1.insertrow(1)

			k_rc = dw_dett_0.getchild("clie_2", kdwc_clienti_2)
			k_rc = dw_dett_0.getchild("clienti_b_rag_soc_10", kdwc_clienti_des_2)
			k_rc = kdwc_clienti_2.settransobject(sqlca)
			k_rc = kdwc_clienti_des_2.settransobject(sqlca)
			kdwc_clienti_1.RowsCopy(kdwc_clienti_1.GetRow(), kdwc_clienti_1.RowCount(), Primary!, kdwc_clienti_2, 1, Primary!)
			kdwc_clienti_des_1.RowsCopy(kdwc_clienti_des_1.GetRow(), kdwc_clienti_des_1.RowCount(), Primary!, kdwc_clienti_des_2, 1, Primary!)
			
			k_rc = dw_dett_0.getchild("clie_3", kdwc_clienti_3)
			k_rc = dw_dett_0.getchild("clienti_c_rag_soc_10", kdwc_clienti_des_3)
			k_rc = kdwc_clienti_3.settransobject(sqlca)
			k_rc = kdwc_clienti_des_3.settransobject(sqlca)
			kdwc_clienti_1.RowsCopy(kdwc_clienti_1.GetRow(), kdwc_clienti_1.RowCount(), Primary!, kdwc_clienti_3, 1, Primary!)
			kdwc_clienti_des_1.RowsCopy(kdwc_clienti_des_1.GetRow(), kdwc_clienti_des_1.RowCount(), Primary!, kdwc_clienti_des_3, 1, Primary!)
		end if

	end if

end subroutine

public subroutine set_iniz_dati_cliente (ref st_tab_clienti kst_tab_clienti);//			
kst_tab_clienti.codice = 0
kst_tab_clienti.rag_soc_10 = " "

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

protected subroutine riempi_id ();////
//if dw_dett_0.rowcount() > 0 then
//	dw_dett_0.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins())
//	dw_dett_0.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente())
//end if
end subroutine

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti, integer k_ctr);//
//--- Visualizza dati Cliente 
//

if k_ctr = 1 then
	dw_dett_0.modify( "clie_1.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
	dw_dett_0.modify( "clienti_a_rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
	
	dw_dett_0.setitem( 1, "clie_1", kst_tab_clienti.codice)
	dw_dett_0.setitem( 1, "clienti_a_rag_soc_10", kst_tab_clienti.rag_soc_10 )
else
	if k_ctr = 2 then
		dw_dett_0.modify( "clie_2.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
		dw_dett_0.modify( "clienti_b_rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
		
		dw_dett_0.setitem( 1, "clie_2", kst_tab_clienti.codice)
		dw_dett_0.setitem( 1, "clienti_b_rag_soc_10", kst_tab_clienti.rag_soc_10 )
	else
		dw_dett_0.modify( "clie_3.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
		dw_dett_0.modify( "clienti_c_rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
		
		dw_dett_0.setitem( 1, "clie_3", kst_tab_clienti.codice)
		dw_dett_0.setitem( 1, "clienti_c_rag_soc_10", kst_tab_clienti.rag_soc_10 )
	end if
end if
	
//attiva_tasti()


end subroutine

protected function boolean aggiorna_tabelle_altre () throws uo_exception;//

//--- salva il record con la chiave in modo da evitare dupliche
	ki_st_tab_clienti_m_r_f_orig.clie_1 = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "clie_1")
	ki_st_tab_clienti_m_r_f_orig.clie_2 = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "clie_2")
	ki_st_tab_clienti_m_r_f_orig.clie_3 = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "clie_3")

return true
end function

on w_m_r_f.create
call super::create
end on

on w_m_r_f.destroy
call super::destroy
end on

event close;call super::close;//
if isvalid(kiuf_clienti) then destroy kiuf_clienti

end event

type st_ritorna from w_g_tab0`st_ritorna within w_m_r_f
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_m_r_f
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_m_r_f
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_m_r_f
integer x = 2350
integer y = 1348
end type

type st_stampa from w_g_tab0`st_stampa within w_m_r_f
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_m_r_f
integer x = 2350
integer y = 656
end type

type cb_modifica from w_g_tab0`cb_modifica within w_m_r_f
integer x = 2350
integer y = 908
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_m_r_f
integer x = 2350
integer y = 1200
end type

type cb_cancella from w_g_tab0`cb_cancella within w_m_r_f
integer x = 2350
integer y = 1052
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_m_r_f
integer x = 2350
integer y = 768
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_m_r_f
integer y = 1032
integer width = 2747
integer height = 688
boolean enabled = true
string dataobject = "d_m_r_f"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean ki_link_standard_attivi = false
boolean ki_colora_riga_aggiornata = false
end type

event dw_dett_0::editchanged;//soppressione codice del padre
end event

event dw_dett_0::itemchanged;call super::itemchanged;//
int k_errore=0, k_clie
long k_riga, k_rc
st_esito kst_esito
st_tab_clienti kst_tab_clienti
datawindowchild kdwc_1

string k
k=lower(dwo.name)
choose case 	trim(lower(dwo.name))


	case "clienti_a_rag_soc_10", "clienti_b_rag_soc_10" , "clienti_c_rag_soc_10" 
		
		choose case 	lower(dwo.name)
			case "clienti_a_rag_soc_10" 
				k_clie = 1
			case "clienti_b_rag_soc_10" 
				k_clie = 2
			case "clienti_c_rag_soc_10" 
				k_clie = 3
		end choose

		if len(trim(data)) > 0 then 
			dw_dett_0.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "rag_soc_1 like '%" + trim(data) + "%" +"'" , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = kdwc_1.getitemnumber( k_riga, "id_cliente")
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti, k_clie)
			else
				dw_dett_0.object.id_cliente[1] = 0
				dw_dett_0.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			set_iniz_dati_cliente(kst_tab_clienti)
			post put_video_cliente(kst_tab_clienti, k_clie)
		end if

	case "clie_1" , "clie_2", "clie_3" 
		choose case 	lower(dwo.name)
			case "clie_1" 
				k_clie = 1
			case "clie_2" 
				k_clie = 2
			case "clie_3" 
				k_clie = 3
		end choose
		if len(trim(data)) > 0 then 
			dw_dett_0.getchild(dwo.name, kdwc_1)
			k_riga = kdwc_1.find( "id_cliente = " + trim(data) + " " , 1, kdwc_1.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = long(trim(data))
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti, k_clie)
			else
				dw_dett_0.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			set_iniz_dati_cliente(kst_tab_clienti)
			post put_video_cliente(kst_tab_clienti, k_clie)
		end if


end choose 



return k_errore
	
end event

event dw_dett_0::itemfocuschanged;call super::itemfocuschanged;//int k_rc
//datawindowchild  kdwc_x, kdwc_x_des
//
//
//choose case lower(dwo.name)
//
//
////--- Attivo dw archivio CLIENTI
//	case "rag_soc_10", "id_cliente"
//		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
//			k_rc = this.getchild("id_cliente", kdwc_x)
//			if kdwc_x.rowcount() < 2 then
//				kdwc_x.retrieve("%")
//				k_rc = this.getchild("rag_soc_10", kdwc_x_des)
//				kdwc_x.RowsCopy(kdwc_x.GetRow(), kdwc_x.RowCount(), Primary!, kdwc_x_des, 1, Primary!)
//				kdwc_x.setsort( "id_cliente A")
//				kdwc_x.sort( )
//				k_rc = kdwc_x.insertrow(1)
//				k_rc = kdwc_x_des.insertrow(1)
//			end if	
//		end if
//
//end choose
//
//attiva_tasti()

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_m_r_f
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_m_r_f
integer y = 32
integer width = 2866
integer height = 864
string dataobject = "d_m_r_f_l_5"
boolean ki_link_standard_sempre_possibile = true
end type

type dw_guida from w_g_tab0`dw_guida within w_m_r_f
end type

