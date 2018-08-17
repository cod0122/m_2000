$PBExportHeader$w_sd_md.srw
forward
global type w_sd_md from w_g_tab0
end type
end forward

global type w_sd_md from w_g_tab0
integer width = 2994
integer height = 1984
string title = "Dose-Mapping (SD-MD)"
boolean maxbox = false
boolean ki_toolbar_window_presente = true
end type
global w_sd_md w_sd_md

type variables
//
//--- query il lista su attivi(=S),tutti(=*), non attivi(=N)
private string ki_mostra_nascondi_in_lista = "S"
private string ki_win_titolo_orig_save = ""

private st_tab_sd_md kist_tab_sd_md
private kuf_contratti kiuf_contratti

end variables

forward prototypes
public function string inizializza ()
private function string check_dati ()
private function string cancella ()
protected function integer visualizza ()
public subroutine mostra_nascondi_in_lista ()
protected function integer inserisci ()
private function integer modifica ()
protected subroutine open_start_window ()
protected subroutine set_titolo_window_personalizza ()
protected subroutine riempi_id ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
end prototypes

public function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string k_stato = "0"
string  k_key
int k_ctr=0, k_riga=0
int k_err_ins, k_rc
kuf_utility kuf1_utility

//=== 


//if dw_lista_0.rowcount() = 0 then
	
	k_scelta = trim(ki_st_open_w.flag_modalita)
	
	k_rc = dw_lista_0.retrieve(ki_mostra_nascondi_in_lista) 

		
	choose case k_rc

		case is < 0				
			messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(codice ricercato:" + trim(k_key) + ")~n~r" )
			cb_ritorna.postevent(clicked!)

		case 0
			dw_lista_0.reset()

		case is > 0		
//				if k_scelta = kkg_flag_modalita.inserimento then
//					messagebox("Trovata Anagrafica", &
//						"Il Dose-Mapping e' gia' in archivio ~n~r" + &
//						"(codice ricercato :" + trim(k_key) + ")~n~r" )
//		
//					k_err_ins = inserisci()
//					
//				else
//					
//					if k_scelta = kkg_flag_modalita.modifica then
//				
//						k_riga = dw_lista_0.find("id_sd_md = " + string(kist_tab_sd_md.id_sd_md) , 1, dw_lista_0.rowcount() )
//						if k_riga = 0 then k_riga = 1
//							
//						dw_lista_0.setrow( k_riga )
//						dw_lista_0.selectrow( k_riga, true)
//						dw_lista_0.scrolltorow( k_riga )
//						
//					end if
//					
					dw_lista_0.setfocus()
//				end if
					
		
	end choose


//end if


attiva_tasti()

//--- Inabilita campi alla modifica se Vsualizzazione
   kuf1_utility = create kuf_utility 
   if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.visualizzazione then
	
      kuf1_utility.u_proteggi_dw("1", 0, dw_lista_0)

	else		
		
//--- se Funzione MODIFICA
	   	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
			kuf1_utility.u_proteggi_dw("0", 0, dw_lista_0)
		end if

	end if
	destroy kuf1_utility
	

return "0"

end function

private function string check_dati ();//
//=== Controllo dati inseriti
string k_return = ""
string k_errore = "0"
long k_riga
string k_key
datawindowchild kdwc_clienti_d

	

	k_riga = 1
		

	k_key = dw_dett_0.getitemstring ( k_riga, "sd_md") 
	if isnull(k_key) or LenA(trim(k_key)) = 0 then
		k_return = k_return + "Manca il " + dw_dett_0.describe("sd_md_t.text") + " " + "~n~r"
		k_errore = "3"
	end if


	k_key = dw_dett_0.getitemstring ( k_riga, "sl_pt") 
	if isnull(k_key) or LenA(trim(k_key)) = 0 then
		k_return = k_return + "Manca il " + dw_dett_0.describe("sl_pt_t.text") + " " + "~n~r"
		k_errore = "3"
	end if

	
//--- c'e' gia' il SD-MD?
	kist_tab_sd_md.id_sd_md = dw_dett_0.getitemnumber(1, "id_sd_md")
	kist_tab_sd_md.sd_md = trim(dw_dett_0.getitemstring(1, "sd_md"))  
	kist_tab_sd_md.sl_pt = trim(dw_dett_0.getitemstring(1, "sl_pt"))  

	if len(trim(kist_tab_sd_md.sd_md)) > 0 then
		SELECT id_sd_md
		 INTO :kist_tab_sd_md.id_sd_md
		FROM sd_md 
		WHERE sd_md = :kist_tab_sd_md.sd_md
				and id_sd_md <> :kist_tab_sd_md.id_sd_md
				using sqlca;

		if sqlca.sqlcode = 0 then 
			if kist_tab_sd_md.id_sd_md > 0 then
				k_return = k_return + dw_dett_0.describe("sd_md_t.text") + " '" + trim(kist_tab_sd_md.sd_md) + "' "+ &
							  "già presente in Archivio per ID '" + string(kist_tab_sd_md.id_sd_md ) + "' ~n~r" 
				k_errore = "3"
			end if	
		end if	
	end if
	

//--- errori diversi
	if trim(k_errore) = "0" then
		
//--- c'e' gia' il sc-cf?
		if len(trim(kist_tab_sd_md.sl_pt)) > 0 then

			SELECT max (sd_md)
			 INTO :kist_tab_sd_md.sd_md
			FROM sd_md 
			WHERE sl_pt = :kist_tab_sd_md.sl_pt 
					 and id_sd_md <> :kist_tab_sd_md.id_sd_md
					 using sqlca;
	
			if sqlca.sqlcode = 0 then 
				if len(trim(kist_tab_sd_md.sd_md)) > 0 then
					k_return = k_return + dw_dett_0.describe("sl_pt_t.text") + " '" + trim(kist_tab_sd_md.sl_pt ) + "' "+ &
								  "già in Archivio per Dose-Mapping '" + trim(kist_tab_sd_md.sd_md ) + "' ~n~r" 
					k_errore = "4"
				end if	
			end if		
		end if
		
	end if



return trim(k_errore) + trim(k_return)


end function

private function string cancella ();//
string k_return="0 "
string k_descr
string k_codice
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_tab_sd_md kst_tab_sd_md
st_esito kst_esito
kuf_contratti  kuf1_contratti


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	k_codice = trim(dw_dett_0.getitemstring(1, "sd_md"))
	k_descr = trim(dw_dett_0.getitemstring(1, "sl_pt"))
	kst_tab_sd_md.id_sd_md =  dw_dett_0.getitemnumber(1, "id_sd_md")
end if
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
if k_riga <= 0 or isnull(kst_tab_sd_md.id_sd_md) then
	k_riga = dw_lista_0.getrow()	
	if k_riga > 0 then
		k_codice = trim(dw_lista_0.getitemstring(k_riga, "sd_md"))
		k_descr = trim(dw_lista_0.getitemstring(k_riga, "sl_pt"))
		kst_tab_sd_md.id_sd_md =  dw_lista_0.getitemnumber(k_riga, "id_sd_md")
	end if
end if

if isnull(k_codice) then
	k_codice = ". "
end if
if isnull(k_descr) = true or trim(k_descr) = "" then
	k_descr = "Dose-Mapping senza descrizione" 
end if

if k_riga > 0 and isnull(k_codice) = false then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Dose-Mapping ", "Sei sicuro di voler Cancellare : ~n~r" &
	             + "ID: " + string(kst_tab_sd_md.id_sd_md)+ ";  codice: " + trim(k_codice) + " - associato al Piano di Trattamento: " + trim(k_descr), &
				question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_contratti = create kuf_contratti
		
//=== Cancella la riga dal data windows di lista
		kst_esito = kuf1_contratti.tb_delete(kst_tab_sd_md) 
		
		if kst_esito.esito = kkg_esito.ok then

			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + MidA(k_errore, 2))

			else

//--- cancello riga a video
				k_riga = dw_dett_0.rowcount()	
				if k_riga > 0 then
					kst_tab_sd_md.id_sd_md = dw_dett_0.getitemnumber(1, "id_sd_md")
					dw_dett_0.deleterow(k_riga)
				end if
				if k_riga <= 0 or isnull(kst_tab_sd_md.id_sd_md) then
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
		destroy kuf1_contratti

	else
		messagebox("Elimina Dose Mapping", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
//

end function

protected function integer visualizza ();//===
//=== Lettura del rek x visualizzazione
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc
long k_key
kuf_utility kuf1_utility


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_sd_md")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione

	k_return = dw_dett_0.retrieve( k_key ) 

//--- protezione campi per impedire la modifica
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	destroy kuf1_utility

	attiva_tasti()

return k_return

end function

public subroutine mostra_nascondi_in_lista ();//
kuf_base kuf1_base
string k_dataoggi
boolean k_rc


	pointer kpointer_orig
	kpointer_orig = setpointer(hourglass!)


	dw_lista_0.setredraw(false)


//--- se NON sono al primo giro
	if ki_st_open_w.flag_primo_giro <> "S" then
		leggi_liste()
	end if

	ki_win_titolo_orig = ki_win_titolo_orig_save
	choose case ki_mostra_nascondi_in_lista
		case "S" 	
			leggi_liste()
//			dw_lista_0.u_filtra_record("listino_attivo <> 'N' and (data_scad >= date('" + string(kG_dataoggi) + "') or isnull(data_scad) ) ")   
		case "N" 
			leggi_liste()
//			k_rc=dw_lista_0.u_filtra_record("listino_attivo = 'N' or data_scad < date('" + string(kG_dataoggi) + "') ")  
		case "*"
			leggi_liste()
//			dw_lista_0.u_filtra_record("") 
		case "D"
			leggi_liste()
//			dw_lista_0.u_filtra_record("listino_dose = 0.00 or isnull(listino_dose) ") 
	end choose

	dw_lista_0.setredraw(true)

	attiva_tasti()
	
	setpointer(kpointer_orig)




end subroutine

protected function integer inserisci ();//
int k_rc, k_ctr, k_taborder
string k_rc1, k_style
long k_riga
st_tab_clienti kst_tab_clienti
kuf_utility kuf1_utility
st_esito kst_esito
datawindowchild kdwc_1



	dw_dett_0.reset()

	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 
	
//=== Aggiunge una riga al data windows
	dw_dett_0.insertrow(0)
	dw_dett_0.setcolumn(1)
	
	k_rc = dw_dett_0.getchild("sl_pt", kdwc_1)
	if kdwc_1.rowcount( ) < 2 then
		kdwc_1.retrieve(0, "S")
		kdwc_1.insertrow(1)
	end if
	
//--- S-protezione campi 
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
	destroy kuf1_utility

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
int k_return, k_rc
long k_key
datawindowchild kdwc_1
kuf_utility kuf1_utility


	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_sd_md")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( k_key ) 

//--- imposta il dw-child	
	k_rc = dw_dett_0.getchild("sl_pt", kdwc_1)
	if kdwc_1.rowcount( ) < 2 then
		kdwc_1.retrieve(0, "S")
		kdwc_1.insertrow(1)
	end if

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
	destroy kuf1_utility

	attiva_tasti()

	dw_dett_0.SetColumn(2)


return k_return

end function

protected subroutine open_start_window ();//
int k_rc
datawindowchild  kdwc_1



	kiuf_contratti = create kuf_contratti

	ki_win_titolo_orig_save = ki_win_titolo_orig

//--- Attivo dw-child sul dettaglio
	k_rc = dw_dett_0.getchild("sl_pt", kdwc_1)

	k_rc = kdwc_1.settransobject(sqlca)

	if kdwc_1.rowcount() = 0 then
		kdwc_1.insertrow(1)
	end if

	if isnumber(trim(ki_st_open_w.key1)) then
		kist_tab_sd_md.id_sd_md = long(trim(ki_st_open_w.key1))
	else
		kist_tab_sd_md.id_sd_md = 0
	end if

	if len(trim(ki_st_open_w.key1)) > 0 then
		ki_mostra_nascondi_in_lista = trim(ki_st_open_w.key1)
	else
		ki_mostra_nascondi_in_lista = "S"
	end if




end subroutine

protected subroutine set_titolo_window_personalizza ();
super::set_titolo_window_personalizza()

choose case ki_mostra_nascondi_in_lista
   case 'S'  // solo in vigore
      this.title += " - righe Dose-Mapping in Vigore "
   case 'N'  // solo Scaduti
      this.title += " - Solo righe Dose-Mapping Scaduti "
   case '*'  // Tutte
      this.title += " - Mostra tutti i Dose-Mapping "
end choose

end subroutine

protected subroutine riempi_id ();//
//--- imposto i dati di default
int k_rc=0


	k_rc=dw_dett_0.setitem(1, "x_datins", kGuf_data_base.prendi_x_datins( ) )
	k_rc=dw_dett_0.setitem(1, "x_utente", kGuf_data_base.prendi_x_utente( ) )



end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

choose case k_par_in 


	case KKG_FLAG_RICHIESTA.libero71		//Mostra solo Validi
		ki_mostra_nascondi_in_lista = "S"
		mostra_nascondi_in_lista()
	case KKG_FLAG_RICHIESTA.libero72		//Mostra solo scaduti
		ki_mostra_nascondi_in_lista = "N"
		mostra_nascondi_in_lista()
	case KKG_FLAG_RICHIESTA.libero73		//Mostra tutti
		ki_mostra_nascondi_in_lista = "*"
		mostra_nascondi_in_lista()

	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu

//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
	
	
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.text = "Mostra righe Dose-Mapping in Vigore "
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.microhelp = "Mostra righe SD-MD in Vigore"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemText = "Validi,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemName = "DataWindow1!"
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.text = "Mostra righe Dose-Mapping Scaduti"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.microhelp = "Mostra righe SD-MD Scaduti"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemText = "Scaduti,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemName = "DataWindow2!"
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.text = "Mostra Tutti i Dose-Mapping"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.microhelp = "Mostra Tutti i SD-MD"
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemText = "Tutti,"+ki_menu.m_strumenti.m_fin_gest_libero7.libero3.text
		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemName = "EditDataTabular!" //"DataWindow5!"
//		ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero7.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero7.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero7.visible = true

	end if


	super::attiva_menu()



end subroutine

on w_sd_md.create
call super::create
end on

on w_sd_md.destroy
call super::destroy
end on

type st_ritorna from w_g_tab0`st_ritorna within w_sd_md
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_sd_md
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_sd_md
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_sd_md
integer x = 2350
integer y = 1348
end type

type st_stampa from w_g_tab0`st_stampa within w_sd_md
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_sd_md
integer x = 2350
integer y = 656
end type

type cb_modifica from w_g_tab0`cb_modifica within w_sd_md
integer x = 2350
integer y = 908
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_sd_md
integer x = 2350
integer y = 1200
end type

type cb_cancella from w_g_tab0`cb_cancella within w_sd_md
integer x = 2350
integer y = 1052
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_sd_md
integer x = 2350
integer y = 768
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_sd_md
integer y = 832
integer width = 2747
integer height = 888
boolean enabled = true
string dataobject = "d_sd_md"
boolean border = true
boolean hsplitscroll = false
borderstyle borderstyle = stylelowered!
end type

event dw_dett_0::editchanged;//soppressione codice del padre
end event

event dw_dett_0::itemchanged;call super::itemchanged;//
string k_sl_pt
long k_rc, k_riga=0
integer k_return=0
datawindowchild kdwc_x


choose case upper(dwo.name)
		
	case "SL_PT" 

		k_sl_pt = RightTrim(trim(data))
		if isnull(k_sl_pt) = false and LenA(trim(k_sl_pt)) > 0 then
			
			k_rc = dw_dett_0.getchild("sl_pt", kdwc_x)
			k_rc = kdwc_x.find("cod_sl_pt =~""+(k_sl_pt)+"~"",0,kdwc_x.rowcount())
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				dw_dett_0.setitem(row, "sl_pt_descr", "NON TROVATO")
			else
				k_return = 2
				dw_dett_0.setitem(row, "sl_pt", kdwc_x.getitemstring(k_riga, "cod_sl_pt"))
				dw_dett_0.setitem(row, "sl_pt_descr", kdwc_x.getitemstring(k_riga, "descr"))
			end if
			
		end if

	end choose

	return k_return




end event

event dw_dett_0::itemfocuschanged;call super::itemfocuschanged;long k_rc
datawindowchild kdwc_clienti_d, kdwc_x



if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then

	choose case upper(dwo.name)

		case "RAG_SOC_10" 

		//--- Attivo dw archivio Clienti
			k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_d)
		
		//	k_rc = kdwc_clienti_d.settransobject(sqlca)
		
			if kdwc_clienti_d.rowcount() < 2 then
				kdwc_clienti_d.retrieve("%")
				kdwc_clienti_d.insertrow(1)
			end if
		

		case "SL_PT" 

//--- Attivo dw archivio Clienti
			k_rc = dw_dett_0.getchild("sl_pt", kdwc_x)

			if kdwc_x.rowcount() < 2 then
				kdwc_x.retrieve("%")
				kdwc_x.insertrow(1)
			end if

	end choose
end if

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_sd_md
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_sd_md
integer y = 32
integer width = 2866
integer height = 864
string dataobject = "d_sd_md_l"
boolean ki_link_standard_sempre_possibile = true
end type

type dw_guida from w_g_tab0`dw_guida within w_sd_md
end type

