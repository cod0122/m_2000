$PBExportHeader$w_ddt_new_st.srw
forward
global type w_ddt_new_st from w_fatture_new_st
end type
type ddlb_copie from dropdownlistbox within w_ddt_new_st
end type
type cbx_forza_wm_camion_caricato from checkbox within w_ddt_new_st
end type
type gb_copie from groupbox within w_ddt_new_st
end type
end forward

global type w_ddt_new_st from w_fatture_new_st
integer height = 2252
string title = ""
ddlb_copie ddlb_copie
cbx_forza_wm_camion_caricato cbx_forza_wm_camion_caricato
gb_copie gb_copie
end type
global w_ddt_new_st w_ddt_new_st

type variables
//
private st_sped_ddt kist_sped_ddt[]
private int k_ddlb_copie_index=2
end variables

forward prototypes
protected subroutine stampa ()
private subroutine popola_lista_da_st ()
private subroutine popola_st_da_lista ()
protected subroutine open_start_window ()
protected function string inizializza () throws uo_exception
protected function string leggi_liste ()
protected subroutine inizializza_lista ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private function boolean check_lista_se_ristampa ()
protected subroutine stampa_ddt_bianco ()
public function boolean u_riopen (st_open_w kst_open_w) throws uo_exception
private subroutine popola_lista_no_st ()
end prototypes

protected subroutine stampa ();//--
//--- Lancia Aggiornamento e Stampa dei DDT 
//---
long k_riga_ddt=0, k_riga=0
int k_nr_ddt=0, k_ind=0, k_camion_caricato=0
boolean k_flag_camion_caricato_si=true
kuf_sped_ddt kuf1_sped_ddt
kuf_sped kuf1_sped
st_tab_sped kst_tab_sped
st_ddt_stampa kst_ddt_stampa[]
st_esito kst_esito
uo_exception kuo1_exception
pointer kpointer


kpointer = setpointer(hourglass!)

kuf1_sped_ddt = create kuf_sped_ddt
kuf1_sped = create kuf_sped
kuo1_exception = create uo_exception

kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try 
//--- set nell'area kist_sped_ddt[] delle bolle da stmpare dal DW	
	popola_st_da_lista()

//--- controllo array ai documenti?  
	if UpperBound(kist_sped_ddt[]) > 0 then
	
		for k_riga_ddt = 1 to UpperBound(kist_sped_ddt[])
			if kist_sped_ddt[k_riga_ddt].kst_tab_sped.NUM_BOLLA_OUT > 0 then

//--- controlla se Spedizione caricata su camion				
				k_flag_camion_caricato_si = true
				if not cbx_forza_wm_camion_caricato.checked	then	
//--- Camion Caricato (merce scaricata) da WM?		
					try
						kst_tab_sped.num_bolla_out = kist_sped_ddt[k_riga_ddt].kst_tab_sped.NUM_BOLLA_OUT
						kst_tab_sped.data_bolla_out = kist_sped_ddt[k_riga_ddt].kst_tab_sped.DATA_BOLLA_OUT
						k_camion_caricato = kuf1_sped.get_sped_camion_caricato(kst_tab_sped)
						
					catch (uo_exception kuo_exception_camion_caricato)
						kst_esito = kuo_exception_camion_caricato.get_st_esito()		
						k_riga_ddt = UpperBound(kist_sped_ddt[]) + 1
						k_flag_camion_caricato_si = false
					end try
					if k_camion_caricato = kuf1_sped.kki_sped_camion_caricato_no or k_camion_caricato = kuf1_sped.kki_sped_camion_caricato_NON_GESTITO then
						k_flag_camion_caricato_si = false
					end if
				end if
				
				if k_flag_camion_caricato_si then
					k_riga++
					kst_ddt_stampa[k_riga].NUM_BOLLA_OUT = kist_sped_ddt[k_riga_ddt].kst_tab_sped.NUM_BOLLA_OUT
					kst_ddt_stampa[k_riga].DATA_BOLLA_OUT = kist_sped_ddt[k_riga_ddt].kst_tab_sped.DATA_BOLLA_OUT
					kst_ddt_stampa[k_riga].ID_SPED = kist_sped_ddt[k_riga_ddt].kst_tab_sped.ID_SPED

					kst_ddt_stampa[k_riga].data_rit = kist_sped_ddt[k_riga_ddt].kst_tab_sped.data_rit
					kst_ddt_stampa[k_riga].ora_rit = kist_sped_ddt[k_riga_ddt].kst_tab_sped.ora_rit
//--- valuta come valorizzare data e ora ritiro se impostata a mappa o NO
//					if dw_documenti.getitemstring(k_riga,"no_rit")	= "S" or dw_documenti.getitemstring(k_riga,"updst_rit") = "S" then
//						kst_ddt_stampa[k_riga].data_ora_rit_pers = true
//					else
//						kst_ddt_stampa[k_riga].data_ora_rit_pers = false
//					end if 
			
//--- valuta tipo numero copie da fare
					choose case k_ddlb_copie_index 
						case 1 
							kst_ddt_stampa[k_riga].tipo_num_copie = kuf1_sped_ddt.kki_tipo_num_copie_doppia_c
						case 2
							kst_ddt_stampa[k_riga].tipo_num_copie = kuf1_sped_ddt.kki_tipo_num_copie_tripla
						case 3
							kst_ddt_stampa[k_riga].tipo_num_copie = kuf1_sped_ddt.kki_tipo_num_copie_generica
					end choose
					kist_sped_ddt[k_riga_ddt].kst_tab_sped.NUM_BOLLA_OUT = 0  // stampa effettuata pulisco lo slot x toglierlo dall'elenco
					kist_sped_ddt[k_riga_ddt].kst_tab_sped.ID_SPED = 0  // stampa effettuata pulisco lo slot x toglierlo dall'elenco
				end if
			end if

		next
		
//--- se tutto OK  procedo con l'emissione		
		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then	
			
	//--- STAMPA se richiesto esplicitamente 
			if rb_modo_stampa_s.checked  then
			
				k_nr_ddt = kuf1_sped_ddt.stampa_ddt (kst_ddt_stampa[])  // STAMPA
			
				if k_nr_ddt = 0 then
					kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_dati_insufficienti )
					kuo1_exception.setmessage(" Nessun documento Stampato ")
				else
					kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_ok )
					if k_nr_ddt = 1 then
						kuo1_exception.setmessage("Fine elaborazione, 1 documento stampato")
					else
						kuo1_exception.setmessage("Fine elaborazione, " + string(k_nr_ddt) + " documenti stampati")
					end if
				end if
			end if
		
	//--- PDF!!!
			if not rb_modo_stampa_s.checked then
			
//				k_nr_ddt = kuf1_sped_ddt.stampa_ddt_digitale (kist_sped_ddt[])
			
				if k_nr_ddt = 0 then
					kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_dati_insufficienti )
					kuo1_exception.setmessage(" Nessun documento digitalizzato ")
				else
					kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_ok )
					if k_nr_ddt = 1 then
						kuo1_exception.setmessage("Fine elaborazione, 1 documento digitale emesso")
					else
						kuo1_exception.setmessage("Fine elaborazione, " + string(k_nr_ddt) + " documenti digitali emessi")
					end if
				end if
			
			end if
		
			if k_nr_ddt > 0 then
//--- x DEFAULT Aggiorna DB (rb_DEFINITIVA)
				if not rb_prova.checked then
//--- aggiorna dati di stampa
					if cbx_aggiorna_stato.checked then
						
						kuf1_sped_ddt.set_ddt_aggiorna(kst_ddt_stampa[])  // AGGIORNA!!!!!
						
//--- funzione utile alla sincronizzazione con la window di ritorno (come il navigatore)
						kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w)
						
					end if
					

				end if
			end if
		end if
			
		kuo1_exception.messaggio_utente( )

//--- se tutto OK e stampato il cartaceo e ho stampato qls allora cancello i ddt stampati dall'elenco
		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then	
			popola_lista_no_st( )
//			if rb_modo_stampa_s.checked  then
//				if k_nr_ddt > 0 then
//					popola_lista_da_st( ) // stampa effettuata pulisco l'elenco
//				end if
//			end if
		end if
		
	end if
	
catch (uo_exception kuo_exception)
	
	kGuf_data_base.errori_scrivi_esito("W", kst_esito)  //--- scrive il LOG
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kuf1_sped_ddt) then destroy kuf1_sped_ddt
	if isvalid(kuf1_sped) then destroy kuf1_sped
	if isvalid(kuo1_exception) then destroy kuo1_exception

	setpointer(kpointer)
	
//--- se richiesto ed elenco vuoto esce dalla funzione	
	if cbx_chiude.checked then
		if dw_documenti.rowcount( ) = 0 then
			cb_ritorna.event clicked( )
		end if
	end if
		
end try


end subroutine

private subroutine popola_lista_da_st ();//
//---
//--- riempie dw da oggetto st_sped_ddt
//---
long k_riga, k_riga_ins
int k_camion_caricato=0
st_tab_sped kst_tab_sped
st_tab_clienti kst_tab_clienti
kuf_sped kuf1_sped
kuf_clienti kuf1_clienti
kuf_wm_pklist_righe kuf1_wm_pklist_righe
st_esito kst_esito
pointer kpointer_orig


kpointer_orig = setpointer(hourglass!)

kuf1_sped = create kuf_sped
kuf1_clienti = create kuf_clienti

dw_documenti.reset()

for k_riga = 1 to upperbound(kist_sped_ddt[])

	
	kst_tab_sped.num_bolla_out = kist_sped_ddt[k_riga].kst_tab_sped.num_bolla_out
	kst_tab_sped.data_bolla_out = kist_sped_ddt[k_riga].kst_tab_sped.data_bolla_out
	kst_tab_sped.id_sped = kist_sped_ddt[k_riga].kst_tab_sped.id_sped

//--- piglia dati ddt
	if kst_tab_sped.num_bolla_out > 0 then
		
		k_riga_ins = dw_documenti.insertrow(0) //--- nuova riga 
	
		
		if kist_sped_ddt[k_riga].sel = 0 then
			dw_documenti.setitem(k_riga_ins,"sel", 0)
		else
			dw_documenti.setitem(k_riga_ins,"sel", 1)
		end if
			
		dw_documenti.setitem(k_riga_ins,"num_bolla_out", kist_sped_ddt[k_riga].kst_tab_sped.num_bolla_out)
		dw_documenti.setitem(k_riga_ins,"data_bolla_out", kist_sped_ddt[k_riga].kst_tab_sped.data_bolla_out)
		dw_documenti.setitem(k_riga_ins,"id_sped", kist_sped_ddt[k_riga].kst_tab_sped.id_sped)
		
		kst_esito = kuf1_sped.select_testa(kst_tab_sped)
		if kst_esito.esito = kkg_esito.ok then
			
			dw_documenti.setitem(k_riga_ins,"data_rit", kst_tab_sped.data_rit)
			dw_documenti.setitem(k_riga_ins,"ora_rit", kst_tab_sped.ora_rit)
			dw_documenti.setitem(k_riga_ins,"clie_2", kst_tab_sped.clie_3)

			kst_tab_clienti.codice = kst_tab_sped.clie_2
			kst_esito = kuf1_clienti.leggi_rag_soc( kst_tab_clienti )
			if kst_esito.esito = kkg_esito.ok then
				dw_documenti.setitem(k_riga_ins,"rag_soc_10", trim(kst_tab_clienti.rag_soc_10+kst_tab_clienti.rag_soc_11))
				dw_documenti.setitem(k_riga_ins,"loc_10", trim(kst_tab_clienti.loc_1))
				dw_documenti.setitem(k_riga_ins,"nazione", trim(kst_tab_clienti.id_nazione_1))
			else
				dw_documenti.setitem(k_riga_ins,"rag_soc_10", "***non trovato***")
			end if
			
			kst_tab_clienti.codice = kst_tab_sped.clie_3
			kst_esito = kuf1_clienti.leggi_rag_soc( kst_tab_clienti )
			if kst_esito.esito = kkg_esito.ok then
				dw_documenti.setitem(k_riga_ins,"cliente", string(kst_tab_sped.clie_3) + "  " + trim(kst_tab_clienti.rag_soc_10))
			
			else
				dw_documenti.setitem(k_riga_ins,"cliente", "***non trovato***")
			end if
			
		end if

//--- mette aggiorna data ritiro in automatico se DATA_RIT non impostata
		if dw_documenti.getitemdate(k_riga_ins,"data_rit") > kkg.DATA_NO then
			if trim(dw_documenti.getitemstring(k_riga_ins,"ora_rit")) > " " then
			else
				dw_documenti.setitem(k_riga_ins,"ora_rit", string(now(), "hh:mm"))
			end if
		else
			dw_documenti.setitem(k_riga_ins,"updst_rit", "S")
		end if

		dw_documenti.setitem(k_riga_ins,"colli_out", kst_tab_sped.colli )
		
//--- valuta se ddt completamente stampato	
//		if kst_tab_sped.stampa
		try
			if kst_tab_sped.stampa <> kuf1_sped.kki_sped_flg_stampa_bolla_da_stamp then
				if not kuf1_sped.if_stampata(kst_tab_sped) then
					kst_tab_sped.stampa = kuf1_sped.kki_sped_flg_stampa_bolla_da_stamp
				end if
			end if
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()		
		end try
		dw_documenti.setitem(k_riga_ins,"stampato", kst_tab_sped.stampa )

//--- Camion Caricato (merce scaricata) da WM?		
		try
			k_camion_caricato = kuf1_sped.get_sped_camion_caricato(kst_tab_sped)
			dw_documenti.setitem(k_riga_ins,"arsp_insped", k_camion_caricato )
		catch (uo_exception kuo1_exception)
			kst_esito = kuo1_exception.get_st_esito()		
		end try
			
//--- se si è verificato un errore			
		if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
			
			kguo_exception.set_esito(kst_esito)
			kguo_exception.messaggio_utente( )

		end if
			
	end if
		
		
end for

destroy kuf1_sped
destroy kuf1_clienti 

setpointer(kpointer_orig)  



end subroutine

private subroutine popola_st_da_lista ();//
//---
//--- riempie la  st_sped_ddt   da DW
//---
long k_riga=0, k_riga_ins=0
string k_diprova = "N"
st_sped_ddt kst_sped_ddt[]
pointer kpointer_orig

//st_esito kst_esito

kpointer_orig = setpointer(hourglass!)

kist_sped_ddt[] = kst_sped_ddt[]

if rb_prova.checked then k_diprova = "S"

for k_riga = 1 to dw_documenti.rowcount()


	if dw_documenti.getitemnumber(k_riga,"num_bolla_out") > 0 then
		
//--- solo i documenti selezionati
		if not (rb_emissione_selezione.checked) or (dw_documenti.getitemnumber(k_riga, "sel")) = 1 then

			k_riga_ins++


			if rb_emissione_selezione.checked then
				kist_sped_ddt[k_riga_ins].sel = 1
			else
				if dw_documenti.getitemnumber(k_riga,"sel") = 0 then
					kist_sped_ddt[k_riga_ins].sel = 0 
				else
					kist_sped_ddt[k_riga_ins].sel = 1
				end if
			end if
			
			kist_sped_ddt[k_riga_ins].diprova = k_diprova
			
			kist_sped_ddt[k_riga_ins].kst_tab_sped.id_sped = dw_documenti.getitemnumber(k_riga,"id_sped")
			kist_sped_ddt[k_riga_ins].kst_tab_sped.num_bolla_out = dw_documenti.getitemnumber(k_riga,"num_bolla_out")
			kist_sped_ddt[k_riga_ins].kst_tab_sped.data_bolla_out = dw_documenti.getitemdate(k_riga,"data_bolla_out")
		
//--- valuta come valorizzare data e ora ritiro		
			if dw_documenti.getitemstring(k_riga,"no_rit") = "S" then
				kist_sped_ddt[k_riga_ins].kst_tab_sped.data_rit = date(0)
				kist_sped_ddt[k_riga_ins].kst_tab_sped.ora_rit = ""
			else
				if dw_documenti.getitemstring(k_riga,"updst_rit")	= "S" then
					kist_sped_ddt[k_riga_ins].kst_tab_sped.data_rit = date(kGuf_data_base.prendi_dataora( ))
					kist_sped_ddt[k_riga_ins].kst_tab_sped.ora_rit = string(kGuf_data_base.prendi_dataora( ), "hh:mm:ss")
				else
					kist_sped_ddt[k_riga_ins].kst_tab_sped.data_rit = dw_documenti.getitemdate(k_riga,"data_rit")
					kist_sped_ddt[k_riga_ins].kst_tab_sped.ora_rit = trim(dw_documenti.getitemstring(k_riga,"ora_rit"))
				end if
			end if
			
			kist_sped_ddt[k_riga_ins].kst_tab_sped.clie_2 = dw_documenti.getitemnumber(k_riga,"clie_2")
			kist_sped_ddt[k_riga_ins].kst_tab_sped.colli = dw_documenti.getitemnumber(k_riga,"colli_out")
			kist_sped_ddt[k_riga_ins].kst_tab_sped.stampa = dw_documenti.getitemstring(k_riga,"stampato")
		
		end if
	end if
		
		
end for


setpointer(kpointer_orig)  



end subroutine

protected subroutine open_start_window ();//---
boolean k_bolla_trovata=false
long k_ctr
st_sped_ddt kst_sped_ddt_vuota[]
ki_st_open_w.flag_modalita = kkg_flag_modalita.stampa
kuf_sped kuf1_sped
pointer kpointer_orig


try 
	kpointer_orig = setpointer(hourglass!)

	pb_ok.picturename = "printer.gif" //kGuo_path.get_risorse() + KKG.PATH_SEP + "printer.gif"
	st_aggiorna_lista.enabled  = TRUE

//--- per default fa le copie 2+1 (ricevente+Interna+cliente se diverso dal ricevente)
	ddlb_copie.selectitem(k_ddlb_copie_index)
	

	if isvalid(ki_st_open_w.key12_any[]) then 
		kist_sped_ddt[]	 = ki_st_open_w.key12_any   //--- argomento Struttura con le bolle da mettere in elenco
	else
		kist_sped_ddt[]	 = kst_sped_ddt_vuota[]		
	end if

//--- controlla se bolle già stampate o no (piu' o meno)
	if check_lista_se_ristampa( ) then
		rb_prova.checked = true
	else
		rb_definitiva.checked = true
	end if

	post inizializza_lista()
////--- pone i link nel dw
//	u_personalizza_dw()
//
//	for k_ctr = 1 to UpperBound(kist_sped_ddt[])
//		if kist_sped_ddt [k_ctr].kst_tab_sped.num_bolla_out > 0 then 
//			k_bolla_trovata = true
//			exit
//		end if
//	next
//	
//	if not k_bolla_trovata then
//
//		kuf1_sped = create kuf_sped
//		kuf1_sped.get_ddt_da_stampare(kist_sped_ddt[])
//			
//	end if
//	
//	popola_lista_da_st()
//	
//	kist_sped_ddt[] = kst_sped_ddt_vuota[]
//	
//	dw_documenti.setfocus()
//
	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		this.postevent(close!)

	finally
		if isvalid(kuf1_sped) then destroy kuf1_sped
		setpointer(kpointer_orig)  
		
end try


end subroutine

protected function string inizializza () throws uo_exception;//---
boolean k_bolla_trovata=false
long k_ctr
st_sped_ddt kst_sped_ddt_vuota[]
ki_st_open_w.flag_modalita = kkg_flag_modalita.stampa
kuf_sped kuf1_sped
pointer kpointer_orig



try 
	kpointer_orig = setpointer(hourglass!)

	dw_documenti.reset( )
	
//--- pone i link nel dw
	u_personalizza_dw()

	for k_ctr = 1 to UpperBound(kist_sped_ddt[])
		if kist_sped_ddt [k_ctr].kst_tab_sped.num_bolla_out > 0 then 
			k_bolla_trovata = true
			exit
		end if
	next
	
	if not k_bolla_trovata then

		kuf1_sped = create kuf_sped
		kuf1_sped.get_ddt_da_stampare(kist_sped_ddt[])
			
	end if
	
	popola_lista_da_st()
	
	kist_sped_ddt[] = kst_sped_ddt_vuota[]
	
	dw_documenti.setfocus()

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		this.postevent(close!)

	finally
		if isvalid(kuf1_sped) then destroy kuf1_sped
		setpointer(kpointer_orig)  
		
end try

return "0"

end function

protected function string leggi_liste ();//
//======================================================================
//=== Liste Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
long k_riga
st_sped_ddt kst_sped_ddt_vuota[]


	try
		dw_documenti.setredraw(false)
	
		k_riga = dw_documenti.getrow()

//		if isvalid(ki_st_open_w.key12_any[]) then 
//			kist_sped_ddt[]	 = ki_st_open_w.key12_any   //--- argomento Struttura con le bolle da mettere in elenco
//		else
//			kist_sped_ddt[]	 = kst_sped_ddt_vuota[]		
//		end if
		
		inizializza()
		
		if k_riga > dw_documenti.rowcount() or k_riga = 0 then
			k_riga = dw_documenti.rowcount() 
		end if
		if k_riga > 0 then
			dw_documenti.sort()
			if k_riga > 3 then
				dw_documenti.scrolltorow(k_riga - 3)
			else
				dw_documenti.scrolltorow(k_riga)
			end if
			dw_documenti.setrow(k_riga)
			dw_documenti.selectrow(0 , false)
			dw_documenti.selectrow(k_riga , true)
		else
	
			k_return = "1 "
	
		end if
		
		dw_documenti.setredraw(true)
		
	catch (uo_exception kuo_ecxception)

	end try
	
return k_return





end function

protected subroutine inizializza_lista ();//
//=== Routine STANDARD
//=== Ritorna 0=ok 1=errore
//
int k_return=0
string k_inizializza
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	dw_documenti.ki_d_std_1_primo_giro = true

	dw_documenti.SetRedraw (false)
	dw_documenti.SetRedraw (false)


	
	try
		
		k_inizializza = inizializza() //Reimposta i tasti e fa la retrieve di lista
			
		
	catch (uo_exception kuo_exception)
		
	end try


	
//=== Se le INIZIALIZZA tornano con errore = 2 allora chiudo la windows	
	if LeftA(k_inizializza,1) <> "2" then

//--- fa delle cose personalizzate per i figli
		inizializza_post()
		
		attiva_tasti()

		dw_documenti.SetRedraw (true)
		post fine_primo_giro()

	 	SetPointer(oldpointer)

	else

	 	SetPointer(oldpointer)

//--- FORZA USCITA!!!
		post close(this)
	end if
	
	


end subroutine

protected subroutine attiva_menu ();

	if ki_menu.m_finestra.m_aggiornalista.enabled <> st_aggiorna_lista.enabled then
		ki_menu.m_finestra.m_aggiornalista.enabled = st_aggiorna_lista.enabled 
	end if

//	
	if not ki_menu.m_strumenti.m_fin_gest_libero8.enabled  then
		ki_menu.m_strumenti.m_fin_gest_libero8.text = "Stampa d.d.t. bianco "
		ki_menu.m_strumenti.m_fin_gest_libero8.microhelp = 	"Stampa d.d.t. bianco senza dati  "
		ki_menu.m_strumenti.m_fin_gest_libero8.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero8.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemtext = "Bianco,"+ ki_menu.m_strumenti.m_fin_gest_libero8.text
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemname = "Layer!"
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemvisible = true
	end if

	super::attiva_menu()
	
end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===

choose case LeftA(k_par_in, 2) 

	case KKG_FLAG_RICHIESTA.refresh		//Aggiorna Liste
		leggi_liste()

	case KKG_FLAG_RICHIESTA.libero8		//Stampa bolla bianca!
		stampa_ddt_bianco()

	case else // standard
		super::smista_funz(k_par_in)
		
end choose



end subroutine

private function boolean check_lista_se_ristampa ();//
//---
//--- Controlla se almeno una bolla già stampata vuol dire (x ora) RISTAMPA
//---
boolean k_return = false
long k_riga
st_tab_sped kst_tab_sped
kuf_sped kuf1_sped
st_esito kst_esito
pointer kpointer_orig


kpointer_orig = setpointer(hourglass!)

kuf1_sped = create kuf_sped

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


for k_riga = 1 to upperbound(kist_sped_ddt[])
	
	kst_tab_sped.num_bolla_out = kist_sped_ddt[k_riga].kst_tab_sped.num_bolla_out
	kst_tab_sped.data_bolla_out = kist_sped_ddt[k_riga].kst_tab_sped.data_bolla_out
	kst_tab_sped.id_sped = kist_sped_ddt[k_riga].kst_tab_sped.id_sped

	try 
		if kst_tab_sped.num_bolla_out > 0 then

//--- piglia dati ddt
			if kst_tab_sped.id_sped > 0 then
				
	//			kst_esito = kuf1_sped.get_sped_stampa(kst_tab_sped)
	//			if kst_esito.esito = kkg_esito.ok then
					
	//				if kst_tab_sped.stampa <> kuf1_sped.kki_sped_flg_stampa_bolla_da_stamp then
					if kuf1_sped.if_stampata(kst_tab_sped) then //get_sped_stampa(kst_tab_sped)
						
						k_return = true
						
						exit
						
					end if
					
	//			else
	//				
	//	//--- se si è verificato un errore			
	//				if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn and kst_esito.esito <> kkg_esito.not_fnd then
	//				
	//					kguo_exception.set_esito(kst_esito)
	//					kguo_exception.messaggio_utente( )
	//	
	//				end if
	//			end if
			else
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Codice ID del d.d.t. non indicato~n~r" &
							+ string(kst_tab_sped.num_bolla_out, "####0") + " del " &
							+ string(kst_tab_sped.data_bolla_out, "dd.mm.yyyy")
				kst_esito.esito = kkg_esito.ko
			end if
		end if	
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito() 
		
	
	end try
	
end for

if kst_esito.esito <> kkg_esito.ok then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	kguo_exception.messaggio_utente( )
end if

destroy kuf1_sped

setpointer(kpointer_orig)  


return k_return
end function

protected subroutine stampa_ddt_bianco ();//--
//--- Lancia Aggiornamento e Stampa dei DDT 
//---
kuf_sped_ddt kuf1_sped_ddt
st_esito kst_esito
uo_exception kuo1_exception
pointer kpointer


kpointer = setpointer(hourglass!)

kuf1_sped_ddt = create kuf_sped_ddt
kuo1_exception = create uo_exception

kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try 
	kuf1_sped_ddt.stampa_ddt_bianco( )
			
catch (uo_exception kuo_exception)
	
	kGuf_data_base.errori_scrivi_esito("W", kst_esito)  //--- scrive il LOG
	kuo_exception.messaggio_utente()
	
finally
	destroy kuf1_sped_ddt
	destroy kuo1_exception
	
	setpointer(kpointer)
	
end try


end subroutine

public function boolean u_riopen (st_open_w kst_open_w) throws uo_exception;//---
//--- Chiamata quando tento la Ri-OPEN della finestra  già Aperta
//---

ki_st_open_w = kst_open_w

this.setfocus()

event u_open( )

return true

end function

private subroutine popola_lista_no_st ();//
//---
//--- pulisce dw da righe stampate
//---
long k_riga, k_righe


k_righe = dw_documenti.rowcount( )

for k_riga = k_righe to 1 step -1

	if rb_modo_stampa_s.checked  then
		
		if dw_documenti.getitemnumber( k_riga, "sel") = 1 then
			dw_documenti.deleterow(k_riga)
		end if
		
	else
		
		dw_documenti.reset( )
		
	end if
		
end for




end subroutine

on w_ddt_new_st.create
int iCurrent
call super::create
this.ddlb_copie=create ddlb_copie
this.cbx_forza_wm_camion_caricato=create cbx_forza_wm_camion_caricato
this.gb_copie=create gb_copie
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_copie
this.Control[iCurrent+2]=this.cbx_forza_wm_camion_caricato
this.Control[iCurrent+3]=this.gb_copie
end on

on w_ddt_new_st.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_copie)
destroy(this.cbx_forza_wm_camion_caricato)
destroy(this.gb_copie)
end on

type st_ritorna from w_fatture_new_st`st_ritorna within w_ddt_new_st
integer x = 2638
integer y = 1980
end type

type st_ordina_lista from w_fatture_new_st`st_ordina_lista within w_ddt_new_st
end type

type st_aggiorna_lista from w_fatture_new_st`st_aggiorna_lista within w_ddt_new_st
end type

type cb_ritorna from w_fatture_new_st`cb_ritorna within w_ddt_new_st
end type

type st_stampa from w_fatture_new_st`st_stampa within w_ddt_new_st
integer x = 2130
integer y = 1992
end type

type rb_emissione_tutto from w_fatture_new_st`rb_emissione_tutto within w_ddt_new_st
integer x = 78
integer y = 472
integer width = 928
end type

type rb_emissione_selezione from w_fatture_new_st`rb_emissione_selezione within w_ddt_new_st
integer x = 78
integer y = 560
end type

type rb_definitiva from w_fatture_new_st`rb_definitiva within w_ddt_new_st
integer y = 1328
integer width = 1138
string text = "EFFETTIVA (Aggiorna Archivi)"
boolean checked = true
end type

event rb_definitiva::clicked;//
//--- evita evento padre
end event

type rb_prova from w_fatture_new_st`rb_prova within w_ddt_new_st
integer y = 1240
string text = "Solo Ristampa (no Aggiornamenti) "
boolean checked = false
end type

type pb_ok from w_fatture_new_st`pb_ok within w_ddt_new_st
integer y = 1712
end type

type dw_documenti from w_fatture_new_st`dw_documenti within w_ddt_new_st
integer height = 1936
string dataobject = "d_sped_l5"
end type

type cbx_aggiorna_stato from w_fatture_new_st`cbx_aggiorna_stato within w_ddt_new_st
integer x = 160
integer y = 1428
integer width = 887
string text = "Aggiorna lo Stato in ~'Stampato~'"
end type

type cbx_update_profis from w_fatture_new_st`cbx_update_profis within w_ddt_new_st
boolean visible = false
integer x = 32
integer y = 2004
end type

type st_1 from w_fatture_new_st`st_1 within w_ddt_new_st
integer y = 1780
end type

type cbx_update_tab_varie from w_fatture_new_st`cbx_update_tab_varie within w_ddt_new_st
boolean visible = false
integer x = 32
integer y = 2088
end type

type rb_modo_stampa_e from w_fatture_new_st`rb_modo_stampa_e within w_ddt_new_st
integer x = 78
integer y = 940
boolean enabled = false
end type

type rb_modo_stampa_s from w_fatture_new_st`rb_modo_stampa_s within w_ddt_new_st
integer x = 78
integer y = 848
end type

type cbx_chiude from w_fatture_new_st`cbx_chiude within w_ddt_new_st
integer x = 101
integer y = 1588
integer width = 1024
integer height = 92
string text = "Esce a fine stampa se elenco vuoto"
end type

type gb_aggiorna from w_fatture_new_st`gb_aggiorna within w_ddt_new_st
integer y = 1152
integer height = 384
end type

type gb_emissione from w_fatture_new_st`gb_emissione within w_ddt_new_st
integer y = 368
integer height = 336
end type

type gb_produzione from w_fatture_new_st`gb_produzione within w_ddt_new_st
integer y = 740
end type

type ddlb_copie from dropdownlistbox within w_ddt_new_st
integer x = 73
integer y = 104
integer width = 1061
integer height = 352
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Ricevente e Vettore se presente","Ricevente e Vettore ","Generica (solo una copia)"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//
k_ddlb_copie_index = index
end event

type cbx_forza_wm_camion_caricato from checkbox within w_ddt_new_st
integer x = 78
integer y = 228
integer width = 1038
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Emettere ddt non caricati su camion"
boolean checked = true
end type

type gb_copie from groupbox within w_ddt_new_st
integer x = 27
integer y = 16
integer width = 1125
integer height = 328
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Numero Copie "
end type

