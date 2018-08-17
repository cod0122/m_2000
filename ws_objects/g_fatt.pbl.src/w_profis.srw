$PBExportHeader$w_profis.srw
forward
global type w_profis from w_g_tab0
end type
end forward

global type w_profis from w_g_tab0
integer height = 1980
string title = "Movimenti di Contabilità"
boolean ki_toolbar_window_presente = true
end type
global w_profis w_profis

type variables
//
kuf_prof kiuf_prof
kuf_prof_exp kiuf_prof_exp
private string ki_mostra_nascondi_in_lista = "S"

end variables

forward prototypes
protected function string cancella ()
protected function string inizializza ()
protected function integer visualizza ()
protected function integer modifica ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
public subroutine u_esolver_esporta_anag ()
public subroutine u_esolver_esporta_fatt ()
protected subroutine open_start_window ()
public subroutine mostra_nascondi_in_lista ()
protected subroutine set_titolo_window_personalizza ()
public subroutine u_esolver_esporta_fidi ()
public subroutine u_esolver_importa_fuori_fido ()
end prototypes

protected function string cancella ();//
string k_return="0 "
string k_codice
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_esito kst_esito
st_tab_prof kst_tab_prof
kuf_prof  kuf1_prof


k_riga =dw_dett_0.GetRow()	
if k_riga > 0 then
	
	kst_tab_prof.num_fatt = dw_dett_0.getitemnumber(k_riga, "num_fatt")
	kst_tab_prof.data_fatt = dw_dett_0.getitemdate(k_riga, "data_fatt")
//	kst_tab_prof.conto = dw_dett_0.getitemnumber(k_riga, "conto")
//	kst_tab_prof.s_conto = dw_dett_0.getitemnumber(k_riga, "s_conto")
	kst_tab_prof.importo = dw_dett_0.getitemnumber(k_riga, "importo")
	
	
	if isnull(kst_tab_prof.num_fatt) then
		kst_tab_prof.num_fatt = 0
	end if
	if isnull(kst_tab_prof.importo) then
		kst_tab_prof.importo = 0
	end if
	
	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Eliminare i movimenti per la Contabilità", "Sei sicuro di voler Cancellare : ~n~r" &
	             	+ "Fattura numero " + string(kst_tab_prof.num_fatt) &
					+ ", del " + string(kst_tab_prof.data_fatt) +  ".~n~r" &
					+ "Per ricreare questi movimenti sarà necessario rieseguire la Stampa del Documento "+  " ", &
				question!, yesno!, 2) = 1 then
//					 + ", di importo: " + string(kst_tab_prof.importo) , &
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_prof = create kuf_prof
		
//--- Cancella tutte le righe della Fattura in tabella PROF (di ESOLVER ex-profis)
		kst_tab_prof.conto = 0
		kst_tab_prof.s_conto = 0
		kst_esito = kuf1_prof.tb_delete(kst_tab_prof) 
		if kst_esito.esito = "0" then

			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + MidA(k_errore, 2))

			else

//--- cancello riga a video
				kst_tab_prof.num_fatt = 0
				k_riga = dw_dett_0.rowcount()	
				if k_riga > 0 then
					kst_tab_prof.num_fatt = dw_dett_0.getitemnumber(1, "num_fatt")
					dw_dett_0.deleterow(k_riga)
				end if
				if k_riga <= 0 or isnull(kst_tab_prof.num_fatt) then
					k_riga = dw_lista_0.getrow()	
					if k_riga > 0 then
						dw_lista_0.deleterow(k_riga)
					end if
				end if

			end if

			dw_dett_0.setfocus()

		else
			k_errore = kGuf_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							trim(kst_esito.sqlerrtext) ) 	
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + MidA(k_errore, 2))
			end if

			attiva_tasti()
	

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_prof

	else
		messagebox("Elimina riga per la Contabilità", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

else
	messagebox("Elimina riga per la Contabilità", "Prego, selezionare una riga da Eliminare")

end if

return(k_return)
//

end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 ", k_key = " "
int k_importa = 0
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_key = trim(ki_st_open_w.key1)+trim(ki_st_open_w.key2)+trim(ki_st_open_w.key3)&
      		  +trim(ki_st_open_w.key4)+trim(ki_st_open_w.key5)+trim(ki_st_open_w.key6)&
		  		  +trim(ki_st_open_w.key7)+trim(ki_st_open_w.key8)+trim(ki_st_open_w.key9)
		
		k_importa = kGuf_data_base.dw_importfile(trim(k_key), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita

		if dw_lista_0.retrieve() < 1 then
			k_return = "1Nessun movimento per la contabilità Trovato "

			SetPointer(oldpointer)
			messagebox("Lista Archivio Movimenti x il Profis Vuota", &
					"Nessun Codice Trovato per la richiesta fatta")
					
		else
			if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 
				mostra_nascondi_in_lista()
			end if
		end if

	end if		


	attiva_tasti()

return k_return



end function

protected function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
any k_key
string k_rc="", k_rc1="", k_style=""
int k_ctr=0
kuf_utility kuf1_utility
st_tab_prof kst_tab_prof

	
	kst_tab_prof.num_fatt = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "num_fatt")
	kst_tab_prof.data_fatt = dw_lista_0.getitemdate(dw_lista_0.getrow(), "data_fatt")
	kst_tab_prof.importo = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "importo")
	kst_tab_prof.conto = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "conto")
	kst_tab_prof.s_conto = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "s_conto")
		
	k_return = dw_dett_0.retrieve( kst_tab_prof.num_fatt, kst_tab_prof.data_fatt &
	                                         , kst_tab_prof.importo, kst_tab_prof.conto, kst_tab_prof.s_conto) 

	if k_return > 0 then
		
		ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	
	end if	


//--- Protezione campi per disabilitare la modifica 
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	kuf1_utility.u_proteggi_dw("1", "tipo_doc", dw_dett_0)
	kuf1_utility.u_proteggi_dw("1", "flag", dw_dett_0)
	kuf1_utility.u_proteggi_dw("1", "cod_pag", dw_dett_0)
	kuf1_utility.u_proteggi_dw("1", "profis", dw_dett_0)
	destroy kuf1_utility


return k_return

end function

protected function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_riga
string k_rc="", k_rc1="", k_style=""
int k_ctr=0
kuf_utility kuf1_utility
st_tab_prof kst_tab_prof


k_riga = dw_lista_0.getrow() //getselectedrow( 0)	

if k_riga > 0 then
	kst_tab_prof.num_fatt = dw_lista_0.getitemnumber(k_riga, "num_fatt")
	kst_tab_prof.data_fatt = dw_lista_0.getitemdate(k_riga, "data_fatt")
	kst_tab_prof.importo = dw_lista_0.getitemnumber(k_riga, "importo")
	kst_tab_prof.conto = dw_lista_0.getitemnumber(k_riga, "conto")
	kst_tab_prof.s_conto = dw_lista_0.getitemnumber(k_riga, "s_conto")
		
	k_return = dw_dett_0.retrieve( kst_tab_prof.num_fatt, kst_tab_prof.data_fatt &
	                                         , kst_tab_prof.importo, kst_tab_prof.conto, kst_tab_prof.s_conto) 
	
	if k_return > 0 then
		
		ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 
	
	end if	

end if

//--- S-Protezione campi per abilitare la modifica 
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
	kuf1_utility.u_proteggi_dw("0", "tipo_doc", dw_dett_0)
	kuf1_utility.u_proteggi_dw("0", "flag", dw_dett_0)
	kuf1_utility.u_proteggi_dw("0", "cod_pag", dw_dett_0)
	kuf1_utility.u_proteggi_dw("0", "profis", dw_dett_0)
	destroy kuf1_utility

attiva_tasti()

return k_return

end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu



	if not ki_menu.m_strumenti.m_fin_gest_libero2.visible then
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Mostra/Nascondi Documenti Trasferiti"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Mostra o Nasconde i documenti già esportati verso la Contabilità"
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Nascondi,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "DeleteRow!"
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	end if	

	if not ki_menu.m_strumenti.m_fin_gest_libero7.visible then
		
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.text = "Estrazione Clienti da Anagrafe per ESOLVER"
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.microhelp =  "Estrazione Clienti da Anagrafe per ESOLVER"
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.visible = true
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled = true
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemVisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemText = "Esp-Clienti,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero1.text
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemName = kGuo_path.get_risorse() + KKG.PATH_SEP + "cart_out32.gif"  //"Picture!" // "Destination5!"
	
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.text = "Estrazione Fatture per la Contabilità"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.microhelp =  "Estrazione file movimenti di fatturazione per la Contabilità"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemText = "Esp-Fatture,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemName = kGuo_path.get_risorse() + KKG.PATH_SEP + "cart_out32.gif"  //"fattura16x16.gif" 
////		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritembarindex=2
	
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.text = "Estrazione Lotti non fatturati (FIDI) per ESOLVER"
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.microhelp =  "Estrazione Lotti non fatturati (FIDI) per ESOLVER"
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.visible = true
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.enabled = true
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemVisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemText = "Esp-FIDI,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero3.text
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemName = kGuo_path.get_risorse() + KKG.PATH_SEP + "cart_out32.gif" 
//		
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.text = "Importa codici Cliente Fuori Fido da ESOLVER"
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.microhelp =  "Importa codici Cliente Fuori Fido da ESOLVER"
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.visible = true
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.enabled = true
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemVisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemText = "Inp-FIDI,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero4.text
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemName = kGuo_path.get_risorse() + KKG.PATH_SEP + "cart_inp32.gif"  
	
		ki_menu.m_strumenti.m_fin_gest_libero7.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.visible = true
	end if
	
//---
	super::attiva_menu()

end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

setpointer(kkg.pointer_attesa)

choose case trim(k_par_in) 

	case kkg_flag_richiesta.libero2		//Mostra/Nascondi righe
		mostra_nascondi_in_lista()

//--- ESOLVER
	case kkg_flag_richiesta.libero71		
		u_esolver_esporta_anag( )
	case kkg_flag_richiesta.libero72		
		u_esolver_esporta_fatt( )
	case kkg_flag_richiesta.libero73		
		u_esolver_esporta_fidi( )
	case kkg_flag_richiesta.libero74		
		u_esolver_importa_fuori_fido( )

	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

public subroutine u_esolver_esporta_anag ();//
string k_file, k_path, k_nulla="", k_ext, k_path_orig
integer k_nr_rec, k_nrc
boolean k_errore=false, k_elab=true
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_base kuf1_base


try	
	

//	k_path = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "arch_esolver_anag", trim(GetCurrentDirectory ( )) + KKG.PATH_SEP + "esolver.csv"))
	string k_esito=""
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "arch_esolver_anag")
	if left(k_esito,1) <> "0" then
		k_path = "" // ERRORE
//		kst_esito.nome_oggetto = this.classname()
//		kst_esito.esito = kkg_esito.db_ko  
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = mid(k_esito,2)
	else
		k_path = trim(mid(k_esito,2))
	end if
	destroy kuf1_base
	k_path_orig = k_path
	
	do
		k_nrc = GetFileSaveName("Scegli/Scrivi Nome Archivio per esportare le Anagrafiche in Contabilità", k_path, k_file, k_ext) 
		if k_nrc <= 0 then
			k_elab = false
		else
			if fileexists(k_path) then
				k_nrc = messagebox("Selezionato archivio Anagrafiche per la Contabilità",  "Archivio già presente.~n~r" + "File: " + trim(k_path) + "~n~r" &
					  + "Vuoi Sovrascriverlo?",  question!, yesnocancel!, 2) 
			else
				k_nrc = messagebox("Estrazione Anagrafiche", "Estrazione per la Contabilità ~n~r" + "File: " + trim(k_path), question!, yesnocancel!, 2) 
			end if
			if k_nrc = 1 then // scelto SI
				k_errore = true
			else
				if k_nrc = 2 then // scelto CANCEL
					k_elab = false
				end if
			end if

		end if
	
	loop while not k_elab and k_errore
	
	if k_errore and k_elab then
		if k_path_orig <> trim(k_path) then 
			kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_scrivi, "arch_esolver_anag", trim(k_path))
		end if	
	end if
	
	if k_errore then

		k_nr_rec = kiuf_prof_exp.esolver_esporta_anag(trim(k_path))

		if k_nr_rec > 0 then
			messagebox("Estrazione Anagrafiche", "Operazione corretta, sono state scritte " + string(k_nr_rec) + " anagrafiche per la Contabilità ~n~r" + "File: " + trim(k_path) + trim(k_file))
		else
			messagebox("Estrazione Anagrafiche", "Nessuna Anagrafica Scritta per la Contabilità ")
		end if			
	else
		messagebox("Estrazione Anagrafiche", "Nessuna estrazione Eseguita! ~n~r")
	end if

	
catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )

finally

end try


end subroutine

public subroutine u_esolver_esporta_fatt ();//
string k_file, k_path, k_nulla="", k_ext
integer k_nr_rec, k_nrc
boolean k_errore=false, k_elab=true
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


try	
	

		kiuf_prof_exp.u_open_w_profis_exp_fatt()

//		if k_nr_rec > 0 then
//			messagebox("Estrazione Anagrafiche", "Operazione corretta, sono state scritte " + string(k_nr_rec) + " anagrafiche per la Contabilità ~n~r" + "File: " + trim(k_path) + trim(k_file))
//		else
//			messagebox("Estrazione Anagrafiche", "Nessuna Anagrafica Scritta per la Contabilità ")
//		end if			
	
catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )

finally

end try


end subroutine

protected subroutine open_start_window ();//
	kiuf_prof = create kuf_prof
	kiuf_prof_exp = create kuf_prof_exp

	if Len(trim(ki_st_open_w.key2)) = 0 or isnull(ki_st_open_w.key2) then  // MOSTRA FATTURE S=TRASFERITE; N=DA TRASFERIRE; *=TUTTI  
		ki_mostra_nascondi_in_lista = "*"
	else
		ki_mostra_nascondi_in_lista  = trim(ki_st_open_w.key2)
	end if

end subroutine

public subroutine mostra_nascondi_in_lista ();//
string k_dataoggi
kuf_base kuf1_base

	
	dw_lista_0.setredraw(false)
	
	if ki_mostra_nascondi_in_lista = kiuf_prof.kki_fattura_profis_cont_no then	
		ki_mostra_nascondi_in_lista = kiuf_prof.kki_fattura_profis_cont_si
		dw_lista_0.u_filtra_record("profis = 'N' or IsNull(profis) ") 
	else
		ki_mostra_nascondi_in_lista = kiuf_prof.kki_fattura_profis_cont_no
		dw_lista_0.u_filtra_record("") 
	end if

attiva_tasti()


dw_lista_0.setredraw( true)

end subroutine

protected subroutine set_titolo_window_personalizza ();
super::set_titolo_window_personalizza()

choose case ki_mostra_nascondi_in_lista
   case kiuf_prof.kki_fattura_profis_cont_si 
      this.title += " - Documenti da Esportare "
   case else 
      this.title += " - Mostra tutti i Documenti in archivio "
end choose



end subroutine

public subroutine u_esolver_esporta_fidi ();//
string k_file, k_path, k_nulla="", k_ext, k_path_orig
integer k_nr_rec, k_nrc
boolean k_errore=false, k_elab=true
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_base kuf1_base


try	
	

//	k_path = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "arch_esolver_anag", trim(GetCurrentDirectory ( )) + KKG.PATH_SEP + "esolver.csv"))
	string k_esito=""
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "arch_esolver_expfidi")
	if left(k_esito,1) <> "0" then
		k_path = "" // ERRORE
	else
		k_path = trim(mid(k_esito,2))
	end if
	destroy kuf1_base
	k_path_orig = k_path
	
	do
		k_nrc = GetFileSaveName("Scegli/Scrivi file per esportare i dati per calcolo FIDI in Contabilità", k_path, k_file, k_ext) 
		if k_nrc <= 0 then
			k_elab = false
		else
			if fileexists(k_path) then
				k_nrc = messagebox("Selezionato archivio dati per la Contabilità",  "Archivio già presente.~n~r" + "File: " + trim(k_path) + "~n~r" &
					  + "Vuoi Sovrascriverlo?",  question!, yesnocancel!, 2) 
			else
				k_nrc = messagebox("Estrazione Dati per Fido", "Estrazione per la Contabilità ~n~r" + "File: " + trim(k_path), question!, yesnocancel!, 2) 
			end if
			if k_nrc = 1 then // scelto SI
				k_errore = true
			else
				if k_nrc = 2 then // scelto CANCEL
					k_elab = false
				end if
			end if

		end if
	
	loop while not k_elab and k_errore
	
	if k_errore and k_elab then
		if k_path_orig <> trim(k_path) then 
			kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_scrivi, "arch_esolver_expfidi", trim(k_path))
		end if	
	end if
	
	if k_errore then

		k_nr_rec = kiuf_prof_exp.esolver_esporta_fidi(trim(k_path))

		if k_nr_rec > 0 then
			messagebox("Estrazione Dati per Fido", "Operazione corretta, sono stati scritti " + string(k_nr_rec) + " righe dati per la Contabilità ~n~r" + "File: " + trim(k_path) + trim(k_file))
		else
			messagebox("Estrazione Dati per Fido", "Nessun dato scritto per la Contabilità ")
		end if			
	else
		messagebox("Estrazione Dati per Fido", "Nessuna estrazione Eseguita! ~n~r")
	end if

	
catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )

finally

end try


end subroutine

public subroutine u_esolver_importa_fuori_fido ();//
string k_file, k_path, k_nulla="", k_ext, k_path_orig
integer k_nr_rec, k_nrc
boolean k_errore=false, k_elab=true
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window
kuf_base kuf1_base


try	

	string k_esito=""
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "arch_esolver_inpfidi")
	if left(k_esito,1) <> "0" then
		k_path = "" // ERRORE
	else
		k_path = trim(mid(k_esito,2))
	end if
	destroy kuf1_base
	k_path_orig = k_path

	do
		k_nrc = GetFileOpenName("Scegli file per importare i dati di FUORI FIDI da ESOLVER", k_path, k_file, k_ext) 
		if k_nrc <= 0 or len(trim(k_file)) = 0 then
			k_elab = false
		else
			if fileexists(k_path) then
				k_nrc = messagebox("Estrazione dati Fuori Fido", "Estrazione dati Clienti Fuori Fido ricevuti da ESOLVER ~n~r" + "File: " + trim(k_path), question!, yesnocancel!, 2) 
				if k_nrc = 1 then // scelto SI
					k_errore = true
				else
					if k_nrc = 2 then // scelto CANCEL
						k_elab = false
					end if
				end if
			end if

		end if
	
	loop while not k_elab and k_errore
	
	if k_errore and k_elab then
		if k_path_orig <> trim(k_path) then 
			kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_scrivi, "arch_esolver_inpfidi", trim(k_path))
		end if	
	end if
	
	if k_errore then

		k_nr_rec = kiuf_prof_exp.esolver_importa_fuori_fido(trim(k_path))

		if k_nr_rec > 0 then
			messagebox("Estrazione dati Fuori Fido", "Operazione corretta, sono stati aggiornati " + string(k_nr_rec) + " Clienti ricevuti da ESOLVER ~n~r" + "File: " + trim(k_path) + trim(k_file))
		else
			messagebox("Estrazione dati Fuori Fido", "Nessun Cliente Fuori Fido ricevuto ")
		end if			
	else
		messagebox("Estrazione dati Fuori Fido", "Nessuna operazione Eseguita! ~n~r")
	end if

	
catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )

finally

end try


end subroutine

on w_profis.create
call super::create
end on

on w_profis.destroy
call super::destroy
end on

event close;call super::close;//
	if isvalid(kiuf_prof_exp) then destroy kiuf_prof_exp
	if isvalid(kiuf_prof) then destroy kiuf_prof

end event

type st_ritorna from w_g_tab0`st_ritorna within w_profis
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_profis
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_profis
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_profis
end type

type st_stampa from w_g_tab0`st_stampa within w_profis
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_profis
end type

type cb_modifica from w_g_tab0`cb_modifica within w_profis
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_profis
end type

type cb_cancella from w_g_tab0`cb_cancella within w_profis
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_profis
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_profis
integer x = 32
boolean enabled = true
string dataobject = "d_prof"
boolean ki_d_std_1_attiva_sort = false
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_profis
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_profis
string title = ""
string dataobject = "d_prof_l"
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
end type

type dw_guida from w_g_tab0`dw_guida within w_profis
end type

