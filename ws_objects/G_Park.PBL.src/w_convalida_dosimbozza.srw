$PBExportHeader$w_convalida_dosimbozza.srw
forward
global type w_convalida_dosimbozza from w_g_tab0
end type
type dw_data from uo_d_std_1 within w_convalida_dosimbozza
end type
end forward

global type w_convalida_dosimbozza from w_g_tab0
integer width = 3634
integer height = 2100
string title = "Elenco CO"
long backcolor = 32501743
boolean ki_toolbar_window_presente = true
dw_data dw_data
end type
global w_convalida_dosimbozza w_convalida_dosimbozza

type variables
//
//private string ki_mostra_nascondi_in_lista = "S"
//private kuf_clienti kiuf_clienti

//private st_tab_contratti ki_st_tab_contratti_arg
private st_tab_meca_dosimbozza kist_tab_meca_dosimbozza_insert
private date ki_data_scad

private string ki_ultimo_codice_cercato="*********"
private int ki_ultimo_dosimbozza_si=0 

private st_tab_meca kist_tab_meca, kist_tab_meca_arg
private kuf_meca_dosimbozza kiuf_meca_dosimbozza
private kuf_armo kiuf_armo
private kuf_ausiliari kiuf_ausiliari

//private datastore kdsi_elenco_output

end variables

forward prototypes
public function string inizializza ()
private function string cancella ()
protected function integer inserisci ()
private function integer check_rek (string k_mc_co)
private function integer check_rek_sc_cf (string k_sc_cf)
protected function integer modifica ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private function integer visualizza ()
protected subroutine riempi_id ()
protected subroutine open_start_window ()
public subroutine legge_dwc ()
public subroutine call_listini ()
public subroutine posiziona_su_codice ()
private subroutine cambia_data_scadenze ()
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti)
public function integer u_retrieve_dw_lista ()
public subroutine set_dw_dett_0_dataobject ()
private function double calcola_coeff_a_s (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza)
protected subroutine attiva_tasti ()
protected subroutine pulizia_righe ()
protected function string aggiorna_tabelle ()
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
string k_return="0 ", k_key = " "
int k_importa = 0, k_rc
long k_riga=0
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti



//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa )

//=== Legge le righe del dw salvate l'ultima volta (importfile)
//		if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 
//	
//			k_importa = kuf1_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
//	
//		end if
//			
//		if k_importa <= 0 then // Nessuna importazione eseguita

//--- Se non ho indicato un contratto/cliente particolare mi fermo e chiedo all'operatore
	if ki_st_open_w.flag_primo_giro = "S" then

		if kist_tab_meca_arg.clie_3 = 0 and kist_tab_meca_arg.id = 0  then

			dw_guida.setfocus( )
			dw_guida.setitem(1,"codice", "")

		else
			if kist_tab_meca_arg.id > 0  then
				dw_guida.setitem(1,"codice", string(kist_tab_meca_arg.id))
			else
				kuf1_clienti = create kuf_clienti
				kst_tab_clienti.codice = kist_tab_meca_arg.clie_3
				kuf1_clienti.get_nome(kst_tab_clienti)
				if len(trim(kst_tab_clienti.rag_soc_10)) > 0 then
					dw_guida.setitem(1,"codice", string(kst_tab_clienti.rag_soc_10 ))
				else
					dw_guida.setitem(1,"codice", "")
				end if
			end if
		end if
		
		dw_guida.setcolumn("codice")

	end if

	if ki_st_open_w.flag_primo_giro <> "S" or kist_tab_meca_arg.clie_3 > 0 or kist_tab_meca_arg.id > 0 then

//		if dw_lista_0.retrieve(ki_st_tab_clienti.rag_soc_10, ki_st_tab_clienti.tipo) < 1 then
		if u_retrieve_dw_lista() < 1 then
//		if dw_lista_0.retrieve(ki_st_tab_contratti_arg.cod_cli, ki_st_tab_contratti_arg.mc_co, ki_data_scad) < 1 then
			
			k_return = "1Nessun Lotto Trovato "

		else
		
			if ki_st_open_w.flag_primo_giro = "S" then 
				
				//mostra_nascondi_in_lista()

//--- Si posiziona sul codice indicato e eventualmente  apre come richiesto il codice
				if kist_tab_meca_arg.clie_3 > 0 then
					kist_tab_meca_arg.id = dw_lista_0.getitemnumber(1, "codice")
				end if
				if kist_tab_meca_arg.id > 0 then
					post posiziona_su_codice( )
				end if
			end if
		end if
	
	end if		
	
	
	SetPointer(kkg.pointer_default)

//	end if
//	attiva_tasti()


return k_return



end function

private function string cancella ();//
string k_return="0 "
string k_descr
long k_codice
string k_appo, k_msg
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_esito kst_esito
st_tab_meca_dosimbozza kst_tab_meca_dosimbozza


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.getrow()	
if k_riga > 0 then
	kst_tab_meca_dosimbozza.id_meca_dosimbozza = dw_dett_0.getitemnumber(k_riga, "id_meca_dosimbozza")
	kst_tab_meca_dosimbozza.barcode = dw_dett_0.getitemstring(k_riga, "barcode")
	kst_tab_meca_dosimbozza.barcode_lav = dw_dett_0.getitemstring(k_riga, "barcode_lav")
	kst_tab_meca_dosimbozza.barcode_dosimetro = dw_dett_0.getitemstring(k_riga, "barcode_dosimetro")
	k_codice = kst_tab_meca_dosimbozza.id_meca_dosimbozza
	k_appo = kst_tab_meca_dosimbozza.barcode
	k_descr = kst_tab_meca_dosimbozza.barcode_lav
	if trim(k_appo) > " " then 
		k_msg = "Rimuovere i dati Letti del dosimetro " + trim(kst_tab_meca_dosimbozza.barcode_dosimetro) + " barcode " + trim(k_appo) &
				 + "~n~rlavorato con " + trim(k_descr) + " (id lettura: " + string(k_codice, "####0") + ")"
	else
		k_msg = "Rimuovere i dati Letti del dosimetro " + trim(kst_tab_meca_dosimbozza.barcode_dosimetro)  &
				 + "~n~rbarcode lavorato: " + trim(k_descr) + " (id lettura: " + string(k_codice, "####0") + ")"
	end if
end if
////=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
//if k_riga <= 0 or isnull(k_codice) then
//	k_riga = dw_lista_0.getselectedrow(0)	
//	if k_riga > 0 then
//		kst_tab_meca_dosimbozza.id_meca_dosimbozza = 0
//		kst_tab_meca_dosimbozza.barcode = ""
//		kst_tab_meca_dosimbozza.barcode_lav = ""
//		kst_tab_meca_dosimbozza.id_meca = dw_lista_0.getitemnumber(1, "id_meca")
//		k_codice = kst_tab_meca_dosimbozza.id_meca
//		k_appo = string(dw_lista_0.getitemstring(k_riga, "num_int")) + " del " + string(dw_lista_0.getitemdate(k_riga, "data_int"), "dd.mmm")
//		k_descr = dw_lista_0.getitemstring(k_riga, "rag_soc_10")
//		k_msg = "Sei sicuro di voler Rimuovere TUTTE i dati letti del~n~r" + &
//				"Lotto " + trim(k_appo) + " cliente " + trim(k_descr) + " (id lotto: " + string(k_codice, "####0") + ")"
//	end if
//end if

if isnull(k_appo) then
	k_appo = ""
end if
if isnull(k_descr)then
	k_descr = "" 
end if

if k_riga > 0 and k_codice > 0 then	

	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Lettura Dosimetro", k_msg, &
				question!, yesno!, 2) = 1 then
	
//=== Cancella la riga dal data windows di lista
		try
//			if kst_tab_meca_dosimbozza.id_meca_dosimbozza > 0 then
//				kiuf_meca_dosimbozza.tb_delete(kst_tab_meca_dosimbozza) 
//			else
//				kiuf_meca_dosimbozza.tb_delete_x_id_meca(kst_tab_meca_dosimbozza)
//			end if
//			k_errore = kuf1_data_base.db_commit()

//--- cancello riga a video
			dw_dett_0.deleterow(k_riga)
			if k_riga > dw_dett_0.rowcount( ) then
				k_riga --
				dw_lista_0.getselectedrow(k_riga)	
			end if

			dw_dett_0.setfocus()

		catch (uo_exception kuo_exception)
			kst_esito =kuo_exception.get_st_esito()
			k_return = "1" + trim(kst_esito.sqlerrtext) + " (" + string(kst_esito.sqlcode) + ")" 
			kuf1_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							MidA(k_return, 2) ) 	
		
		finally
			attiva_tasti()
			
		end try

	else
		messagebox("Elimina Lettura Dosimetrica", "Operazione Annullata !!")
	end if

	k_riga = dw_dett_0.rowcount()	
	if k_riga > 0 then
		dw_dett_0.setcolumn(1)
	end if

end if

return(k_return)
end function

protected function integer inserisci ();//
int k_rc
long k_riga, k_righe
//string k_rc1, k_style
kuf_utility kuf1_utility
st_esito kst_esito
datastore kds_1
//datawindowchild kdwc_clienti_d


//	dw_lista_0.reset()

	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 

//--- se sono sul dw 'singolo' cambia su quello a elenco copiando i dati
	if dw_dett_0.dataobject = "d_convalida_dosimbozza" and dw_dett_0.rowcount( ) > 0 then
		kds_1 = create datastore
		kds_1.dataobject = dw_dett_0.dataobject
		k_rc = dw_dett_0.rowscopy( 1, dw_dett_0.rowcount( ), primary!, kds_1, 1, primary!)
		dw_dett_0.dataobject = "d_convalida_dosimbozza_l"
		dw_dett_0.settransobject(kguo_sqlca_db_magazzino)
		k_righe = kds_1.rowcount( )
		k_rc = kds_1.rowscopy( 1, k_righe, primary!, dw_dett_0, 1, primary!)
		dw_dett_0.resetupdate( )
		for k_riga = 1 to k_righe
			if dw_dett_0.getitemnumber(k_riga, "id_meca_dosimbozza") > 0 then
				dw_dett_0.setitemstatus(k_riga, 0, primary!, NotModified!)
			else			
				dw_dett_0.setitemstatus(k_riga, 0, primary!, new!)
			end if
		next
	end if

//--- Aggiunge una riga al data windows
	k_riga = dw_dett_0.insertrow(0)
	dw_dett_0.scrolltorow(k_riga)
	//dw_dett_0.setcolumn(1)

//--- imposta dati di default
	dw_dett_0.setitem(k_riga, "id_meca_dosimbozza", 0)
	if k_riga > 1 then
		dw_dett_0.setitem(k_riga, "id_meca", dw_dett_0.getitemnumber(k_riga - 1, "id_meca"))
		dw_dett_0.setitem(k_riga, "dosim_data", dw_dett_0.getitemdate(k_riga - 1, "dosim_data"))
		dw_dett_0.setitem(k_riga, "dosim_lotto_dosim", dw_dett_0.getitemstring(k_riga - 1, "dosim_lotto_dosim"))
		dw_dett_0.setitem(k_riga, "dosim_temperatura", dw_dett_0.getitemnumber(k_riga - 1, "dosim_temperatura"))
		dw_dett_0.setitem(k_riga, "dosim_umidita", dw_dett_0.getitemnumber(k_riga - 1, "dosim_umidita"))
		dw_dett_0.setitem(k_riga, "data_int", dw_dett_0.getitemdate(k_riga - 1, "data_int"))
		dw_dett_0.setitem(k_riga, "num_int", dw_dett_0.getitemnumber(k_riga - 1, "num_int"))
		dw_dett_0.setitem(k_riga, "contratto", dw_dett_0.getitemnumber(k_riga - 1, "contratto"))
		dw_dett_0.setitem(k_riga, "sc_cf", dw_dett_0.getitemstring(k_riga - 1, "sc_cf"))
		dw_dett_0.setitem(k_riga, "meca_note_lav_ok", dw_dett_0.getitemstring(k_riga - 1, "meca_note_lav_ok"))
	else
		dw_dett_0.setitem(k_riga, "id_meca", dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_meca"))
		dw_dett_0.setitem(k_riga, "dosim_data", kguo_g.get_dataoggi( ) )
		dw_dett_0.setitem(k_riga, "data_int", dw_dett_0.getitemdate(dw_lista_0.getrow(), "data_int"))
		dw_dett_0.setitem(k_riga, "num_int", dw_dett_0.getitemnumber(dw_lista_0.getrow(), "num_int"))
		dw_dett_0.setitem(k_riga, "contratto", dw_dett_0.getitemnumber(dw_lista_0.getrow(), "contratto"))
//		dw_dett_0.setitem(k_riga, "sc_cf", dw_dett_0.getitemstring(dw_lista_0.getrow(), "sc_cf"))
//		dw_dett_0.setitem(k_riga, "meca_note_lav_ok", dw_dett_0.getitemstring(dw_lista_0.getrow(), ""))
	end if

	dw_dett_0.setitemstatus(k_riga, 0, primary!, New!)   // resetta lo status a NUOVO come senza imputazioni
	
//--- S-protezione campi per riabilitare la modifica 
	kuf1_utility = create kuf_utility 
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
	destroy kuf1_utility	

	//dw_dett_0.resetupdate( )

	attiva_tasti()

	
//--- legge i DWC
	legge_dwc()

//=== Posiziona il cursore sul Data Windows
	dw_dett_0.setfocus() 

return (0)


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



	if not dw_lista_0.enabled then
		k_key = kist_tab_meca_arg.id
	else
		k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_meca")
	end if
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	set_dw_dett_0_dataobject( )  //imposta il dw giusto (unico o multiriga)
	k_return = dw_dett_0.retrieve( k_key ) // legge le dosimetrie

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility 
	kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
	destroy kuf1_utility	

//--- legge i DWC
	legge_dwc()

	attiva_tasti()

//	dw_dett_0.SetColumn(9)


return k_return

end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


//---
	super::attiva_menu()


//
//--- Attiva/Dis. Voci di menu personalizzate
//
//	if not kI_menu.m_strumenti.m_fin_gest_libero1.visible then
//		kI_menu.m_strumenti.m_fin_gest_libero1.text = "Mostra/Nascondi righe Disattivate"
//		kI_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Mostra o Nasconde le righe Contratti non piu' Attivi"
//		kI_menu.m_strumenti.m_fin_gest_libero1.visible = true
//		kI_menu.m_strumenti.m_fin_gest_libero1.enabled = true
//		kI_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
//		kI_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Nascondi,"+kI_menu.m_strumenti.m_fin_gest_libero1.text
//		kI_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "DeleteRow!"
////		kI_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
//	end if
//
//	if not kI_menu.m_strumenti.m_fin_gest_libero3.Visible then
//		kI_menu.m_strumenti.m_fin_gest_libero3.text = "Listini Contratto"
//		kI_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Listini,Elenco Listini del Contratto selezionato"
//		kI_menu.m_strumenti.m_fin_gest_libero3.enabled = true
//		kI_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
//		kI_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Listini, Elenco Listini del Contratto selezionato"
//		kI_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "FormatDollar!"
////		kI_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
//		kI_menu.m_strumenti.m_fin_gest_libero3.visible = true
//	end if
	
	if not kI_menu.m_strumenti.m_fin_gest_libero4.visible then
		kI_menu.m_strumenti.m_fin_gest_libero4.text = "Cambia data estrazione scadenze "
		kI_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Cambia data estrazione scadenze "
		kI_menu.m_strumenti.m_fin_gest_libero4.enabled = true
		kI_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = "Scadenze,"+kI_menu.m_strumenti.m_fin_gest_libero4.text
		kI_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = "Custom015!"
//		kI_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
		kI_menu.m_strumenti.m_fin_gest_libero4.visible = true
		kI_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
	end if	
end subroutine

protected subroutine smista_funz (string k_par_in);//===

choose case LeftA(k_par_in, 2) 


//	case kkg_flag_richiesta_libero1		//Mostra nasconde attivi/disattivi
//		mostra_nascondi_in_lista()

//	case kkg_flag_richiesta_libero3		//chiama LISTINI
//		call_listini( )

	case kkg_flag_richiesta_libero4		//cambia data estrazione scadenze
		cambia_data_scadenze()
		
	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

private function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc, k_taborder
long k_key
int k_ctr
kuf_utility kuf1_utility



	k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_meca")
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione 

	set_dw_dett_0_dataobject( )  //imposta il dw giusto (unico o multiriga)
	k_return = dw_dett_0.retrieve( k_key ) // legge le dosimetrie

//--- protezione campi per visual
	kuf1_utility = create kuf_utility 
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	destroy kuf1_utility	


return k_return


end function

protected subroutine riempi_id ();//
long k_riga=0, k_tot_righe
int k_nrbcode = 1, k_trovati=0
st_tab_meca_dosimbozza kst_tab_meca_dosimbozza


k_tot_righe = dw_dett_0.rowcount()

if k_tot_righe > 0 then
	kst_tab_meca_dosimbozza.id_meca = dw_dett_0.getitemnumber(1, "id_meca")  
end if

for k_riga = 1 to k_tot_righe

//--- Il barcode dosimetro è obbligatorio! se manca lo inventa	
	kst_tab_meca_dosimbozza.barcode = dw_dett_0.getitemstring(k_riga, "barcode")
	if trim(kst_tab_meca_dosimbozza.barcode) > " " then
	else
		//--- il nuovo barcode dosimetro sarà composto con ID_MECA + X + num. progressivo
		kst_tab_meca_dosimbozza.barcode = string(kst_tab_meca_dosimbozza.id_meca) + "X" + string(k_nrbcode)
		k_trovati = dw_dett_0.find("barcode = '" + trim(kst_tab_meca_dosimbozza.barcode) + "' ", 1, dw_dett_0.rowcount())
		do while k_trovati > 0
			k_nrbcode ++
			kst_tab_meca_dosimbozza.barcode = string(kst_tab_meca_dosimbozza.id_meca) + "X" + string(k_nrbcode)
			k_trovati = dw_dett_0.find("barcode = '" + trim(kst_tab_meca_dosimbozza.barcode) + "' ", 1, dw_dett_0.rowcount())
		loop
		dw_dett_0.setitem(k_riga, "barcode", trim(kst_tab_meca_dosimbozza.barcode))  // AGGIUNGO IL BARCODE APPENA RICAVATO
		 
	end if
	
	kst_tab_meca_dosimbozza.id_meca_dosimbozza = dw_dett_0.getitemnumber(k_riga, "id_meca_dosimbozza")  
	if kst_tab_meca_dosimbozza.id_meca_dosimbozza > 0 then
	
		if dw_dett_0.GetItemStatus(k_riga, 0, Primary!) = DataModified! then
			dw_dett_0.setitem(k_riga, "x_datins", kuf1_data_base.prendi_x_datins())
			dw_dett_0.setitem(k_riga, "x_utente", kuf1_data_base.prendi_x_utente())
		end if
			
		//dw_dett_0.setitemstatus(k_riga, 0, Primary!, DataModified!)
		
	else
		dw_dett_0.setitem(k_riga, "x_data_dosim_lettura", kuf1_data_base.prendi_x_datins())
		dw_dett_0.setitem(k_riga, "x_utente_dosim_lettura", kuf1_data_base.prendi_x_utente())
		dw_dett_0.setitem(k_riga, "x_datins", kuf1_data_base.prendi_x_datins())
		dw_dett_0.setitem(k_riga, "x_utente", kuf1_data_base.prendi_x_utente())
		dw_dett_0.setitemstatus(k_riga, 0, Primary!, NewModified!)
		
		dw_dett_0.setitem(k_riga, "id_meca_dosimbozza", 0)
	end if

	if dw_dett_0.getitemdate(k_riga, "dosim_data") > kguo_g.get_datazero( ) then
	else
		dw_dett_0.setitem(k_riga, "dosim_data", kguo_g.get_dataoggi( ) )
	end if

next		

//--- salva valori x ricordarli come valori di default	
kist_tab_meca_dosimbozza_insert.dosim_data = dw_dett_0.getitemdate(1, "dosim_data")
kist_tab_meca_dosimbozza_insert.dosim_lotto_dosim = dw_dett_0.getitemstring(1, "dosim_lotto_dosim")
kist_tab_meca_dosimbozza_insert.dosim_temperatura = dw_dett_0.getitemnumber(1, "dosim_temperatura")
kist_tab_meca_dosimbozza_insert.dosim_umidita = dw_dett_0.getitemnumber(1, "dosim_umidita")
kist_tab_meca_dosimbozza_insert.dosim_flg_tipo_dose = dw_dett_0.getitemstring(1, "dosim_flg_tipo_dose")

end subroutine

protected subroutine open_start_window ();//---
int k_rc
datawindowchild  kdwc_clienti_d, kdwc_sc_cf_d, kdwc_sl_pt_d 
kuf_elenco kuf1_elenco


	kiuf_meca_dosimbozza = create kuf_meca_dosimbozza
	kiuf_armo = create  kuf_armo
	kiuf_ausiliari = create kuf_ausiliari
//	kiuf_clienti = create kuf_clienti
	
	SetPointer(kkg.pointer_attesa)

//--- Elabora Argomenti programma chiamante
	kist_tab_meca_arg.id = 0
	if trim(ki_st_open_w.key1) > " " then									// ID MECA
		if isnumber(ki_st_open_w.key1) then						
			kist_tab_meca_arg.id = long(ki_st_open_w.key1)
		end if
	end if
	kist_tab_meca_arg.clie_3 = 0
	if trim(ki_st_open_w.key1) > " " then									// ID CLIENTE
		if isnumber(ki_st_open_w.key2) then						
			kist_tab_meca_arg.clie_3 = long(ki_st_open_w.key2)
		end if
	end if

	if trim(ki_st_open_w.key3) > " " then									// DA QUALE DATA SCADENZA?
		if isdate(trim(ki_st_open_w.key3)) then
			ki_data_scad = date(trim(ki_st_open_w.key3))
		else
			ki_data_scad = relativedate(kguo_g.get_dataoggi( ), -365)
		end if
	else
		ki_data_scad = relativedate(kguo_g.get_dataoggi( ), -365)
	end if
	
	dw_guida.insertrow(0)
	dw_guida.setitem(1, "codice", "")

	SetPointer(kkg.pointer_default)



end subroutine

public subroutine legge_dwc ();//--- legge i DWC presenti
int k_rc=0
long k_id_meca
datawindowchild  kdwc_1 //, kdwc_sc_cf_d, kdwc_sl_pt_d, kdwc_clienti 


//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

//--- Attivo dw archivio Clienti
	k_rc = dw_dett_0.getchild("barcode_lav", kdwc_1)
	k_rc = kdwc_1.settransobject(sqlca)

//	k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_des)
//	k_rc = kdwc_clienti_des.settransobject(sqlca)
//	k_rc = kdwc_clienti_des.insertrow(1)

	if ki_st_open_w.flag_modalita <> kkg_flag_modalita_visualizzazione then
		if kdwc_1.rowcount() < 2 then
			k_id_meca = dw_lista_0.getitemnumber(dw_lista_0.getrow( ), "id_meca")
			kdwc_1.retrieve(k_id_meca)
			k_rc = kdwc_1.insertrow(1)
//			kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)
//			kdwc_clienti.setsort( "id_cliente A")
//			kdwc_clienti.sort( )
		end if
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
		kst_open_w.flag_modalita = kkg_flag_modalita_elenco
		kuf1_listino.link_call_imvc(kst_tab_listino, kst_open_w)
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kuf1_listino) then destroy kuf1_listino	
	
	
end try 

end subroutine

public subroutine posiziona_su_codice ();//
long k_riga


//--- se ho passato anche il codice contratto allora....
	k_riga = dw_lista_0.find( "id_meca = " + string(kist_tab_meca_arg.id), 1, dw_lista_0.rowcount( ) )
	if k_riga > 0 then 
		dw_lista_0.selectrow( 0, false)
		dw_lista_0.setrow( k_riga)

//--- se entro per fare qls sulla riga allora....
		u_lancia_funzione_imvc(ki_st_open_w)	
		
		dw_lista_0.selectrow( k_riga, true)
		dw_lista_0.scrolltorow( k_riga)
		
	end if

end subroutine

private subroutine cambia_data_scadenze ();//---
//--- Visualizza il box x il cambio DATA
//---


dw_data.triggerevent("ue_visibile")

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

dw_dett_0.modify( "id_cliente.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
dw_dett_0.modify( "clienti_rag_soc_10.Background.Color = '" + string(KK_COLORE_BIANCO) + "' " ) 
dw_dett_0.setitem(k_riga, "rag_soc_10", kst_tab_clienti.rag_soc_10)
dw_dett_0.setitem(k_riga, "cod_cli", kst_tab_clienti.codice)

end subroutine

public function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	
	
	ki_win_titolo_custom = "" 
	if ki_ultimo_dosimbozza_si = 0 then
		ki_win_titolo_custom += "dosim. da rilev. "
	else
		ki_win_titolo_custom += "dosim. già lette "
	end if
	if kist_tab_meca.id > 0 then
		ki_win_titolo_custom += "per ID lotto " + string(kist_tab_meca.id) 
	else
		ki_win_titolo_custom = "dalla data del " + string(ki_data_scad) 
		if kist_tab_meca.clie_1 > 0 then
			ki_win_titolo_custom += " e per il codice anagrafica " + string(kist_tab_meca.clie_1) 
		end if
	end if
	
	dw_lista_0.reset()
	k_return = dw_lista_0.retrieve(ki_data_scad, kist_tab_meca.clie_1, kist_tab_meca.id, ki_ultimo_dosimbozza_si) 
	
	dw_guida.setitem(1,  "testo", "Trovati " + string(k_return, "###,##0") + " Lotti ")

	if k_return > 0 then
		ki_sincronizza_window_consenti = true		// attivo sincronizzazione 
	else
		ki_sincronizza_window_consenti = false		// nessuna sincronizzazione permessa
	end if
	
	dw_lista_0.setfocus( )
	
	attiva_tasti( )

	
return k_return
	

end function

public subroutine set_dw_dett_0_dataobject ();//	
//--- imposta la dw a un solo record oppure a multirecord
//
	if dw_lista_0.getitemnumber(dw_lista_0.getrow(), "n_dosim") > 1 then
		dw_dett_0.dataObject = "d_convalida_dosimbozza_l"
		dw_dett_0.ki_attiva_standard_select_row = true
		dw_dett_0.ki_d_std_1_attiva_sort = true
		dw_dett_0.ki_d_std_1_attiva_cerca = true
		dw_dett_0.ki_colora_riga_aggiornata = true
	else
		dw_dett_0.dataObject = "d_convalida_dosimbozza"
		dw_dett_0.ki_attiva_standard_select_row = false
		dw_dett_0.ki_d_std_1_attiva_sort = false
		dw_dett_0.ki_d_std_1_attiva_cerca = false
		dw_dett_0.ki_colora_riga_aggiornata = false
	end if
	dw_dett_0.settransobject(kguo_sqlca_db_magazzino)
	
end subroutine

private function double calcola_coeff_a_s (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza);//
//--- 
//
double k_coeff_a_s=0


	if ast_tab_meca_dosimbozza.dosim_assorb > 0 and ast_tab_meca_dosimbozza.dosim_spessore > 0 then

		k_coeff_a_s = ast_tab_meca_dosimbozza.dosim_assorb / & 
					  ast_tab_meca_dosimbozza.dosim_spessore 
	end if
	
	if	k_coeff_a_s > 0 then
		
		ast_tab_meca_dosimbozza.dosim_rapp_a_s = round(k_coeff_a_s, 2)
		
	end if

return ast_tab_meca_dosimbozza.dosim_rapp_a_s

end function

protected subroutine attiva_tasti ();//
boolean k_call_attiva_menu=false


super::attiva_tasti()		 

if cb_inserisci.enabled then
	if not dw_dett_0.visible then

		cb_inserisci.enabled = false

		k_call_attiva_menu = true
		
	end if
end if
if cb_cancella.enabled then
	if dw_dett_0.visible and dw_dett_0.rowcount( ) > 0 &
	      and (ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento &
	           or ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica) then
	else

		cb_cancella.enabled = false

		k_call_attiva_menu = true
		
	end if
end if

if k_call_attiva_menu then
	attiva_menu()		
end if


end subroutine

protected subroutine pulizia_righe ();//
long k_riga, k_righe
boolean k_aggiorna=false


dw_dett_0.accepttext()

k_righe = dw_dett_0.rowcount()
for k_riga = 1 to k_righe
	if dw_dett_0.getitemnumber(k_riga, "id_meca_dosimbozza") > 0 then
	else
		if dw_dett_0.getitemnumber(k_riga, "dosim_rapp_a_s") > 0 then
		else
			dw_dett_0.deleterow(k_riga)  // riga senza dose non la registra
		end if
	end if
next
//--- verifica se ci sono righe nel PRIMARY da aggiornare
k_righe = dw_dett_0.rowcount()
for k_riga = 1 to k_righe
	if dw_dett_0.getitemstatus(k_riga, 0, primary!) = newModified! or dw_dett_0.getitemstatus( k_riga, 0, primary!) = dataModified! then
		k_aggiorna = true
	end if
next

//--- rimuove dal DELETE! le righe non necessarie
k_righe = dw_dett_0.DeletedCount()
for k_riga = 1 to k_righe
	if dw_dett_0.getitemnumber(k_riga, "id_meca_dosimbozza", delete!, false) > 0 then
		dw_dett_0.RowsDiscard(k_riga, k_riga, Delete!)
	end if
next

//--- se non ancora aggiornabile controlla allora dentro alle righe CANCELLATE se ce ne sono allora divente ahggiornabile
if not k_aggiorna then
	if dw_dett_0.DeletedCount() > 0 then
		k_aggiorna = true
	end if
end if

//--- se alla fine non c'e' niente da aggiornare resetta il flag
if not k_aggiorna then
	dw_dett_0.resetupdate( )  // resetta il flag di UPDATE se nessuna riga è aggiornabile 
end if

end subroutine

protected function string aggiorna_tabelle ();//
string k_return = "0"
int k_riga, k_righe
st_tab_meca_dosim kst_tab_meca_dosim
st_esito kst_esito
kuf_meca_dosim kuf1_meca_dosim


try
	 
	if dw_dett_0.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		kguo_sqlca_db_magazzino.db_commit()

		k_righe = dw_dett_0.rowcount()
//--- se non ancora caricato in MECA_DOSIM lo faccio ora 		
		kuf1_meca_dosim = create kuf_meca_dosim
		for k_riga = 1 to k_righe
			kst_tab_meca_dosim.barcode = dw_dett_0.getitemstring(k_riga, "barcode")
			if NOT kuf1_meca_dosim.if_esiste(kst_tab_meca_dosim) then
				kst_tab_meca_dosim.id_meca = dw_dett_0.getitemnumber(k_riga, "id_meca")
				kst_tab_meca_dosim.barcode_dosimetro = dw_dett_0.getitemstring(k_riga, "barcode_dosimetro")
				kst_tab_meca_dosim.barcode_lav = dw_dett_0.getitemstring(k_riga, "barcode_lav")
				kuf1_meca_dosim.tb_add_barcode(kst_tab_meca_dosim)  // ADD in MECA_DOSIM
			end if
		next
	end if
			
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	k_return = "1Errore: " + string(kst_esito.sqlcode) + "(" + trim(kst_esito.sqlerrtext) + ")"
	
finally
	if isvalid(kuf1_meca_dosim) then destroy kuf1_meca_dosim 
	
end try

return k_return

end function

on w_convalida_dosimbozza.create
int iCurrent
call super::create
this.dw_data=create dw_data
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_data
end on

on w_convalida_dosimbozza.destroy
call super::destroy
destroy(this.dw_data)
end on

event close;call super::close;//
if isvalid(kiuf_armo)  then destroy kiuf_armo
//if isvalid(kiuf_clienti)  then destroy kiuf_clienti

end event

event u_ricevi_da_elenco;call super::u_ricevi_da_elenco;//
//
int k_rc
window k_window
kuf_menu_window kuf1_menu_window 



	if isvalid(kst_open_w) then

		if not isvalid(kdsi_elenco_input) then kdsi_elenco_input = create datastore
		
//--- Se dalla w di elenco non ho premuto un pulsante ma ad esempio doppio-click		
		if kst_open_w.key2 = "d_dosimetrie_lotto_l" and long(kst_open_w.key3) > 0 then
		
			kdsi_elenco_input = kst_open_w.key12_any 
		
			if kdsi_elenco_input.rowcount() > 0 then

				dw_dett_0.setitem(1, "dosim_lotto_dosim",  kdsi_elenco_input.getitemstring(long(kst_open_w.key3), "lotto_dosim"))
			
			end if				
		end if

	end if





end event

type st_ritorna from w_g_tab0`st_ritorna within w_convalida_dosimbozza
integer x = 2821
integer y = 980
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_convalida_dosimbozza
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_convalida_dosimbozza
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_convalida_dosimbozza
integer x = 2880
integer y = 1768
end type

type st_stampa from w_g_tab0`st_stampa within w_convalida_dosimbozza
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_convalida_dosimbozza
integer x = 2834
integer y = 1664
end type

type cb_modifica from w_g_tab0`cb_modifica within w_convalida_dosimbozza
integer x = 2926
integer y = 1240
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_convalida_dosimbozza
integer x = 2894
integer y = 1536
end type

type cb_cancella from w_g_tab0`cb_cancella within w_convalida_dosimbozza
integer x = 2880
integer y = 1384
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_convalida_dosimbozza
integer x = 2907
integer y = 1092
end type

event cb_inserisci::clicked;//
inserisci( )

end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_convalida_dosimbozza
integer x = 5
integer y = 792
integer width = 2784
integer height = 1148
boolean enabled = true
string dataobject = "d_convalida_dosimbozza"
borderstyle borderstyle = stylelowered!
boolean ki_colora_riga_aggiornata = false
boolean ki_d_std_1_attiva_sort = false
end type

event dw_dett_0::itemchanged;call super::itemchanged;//
string k_rag_soc, k_sc_cf, k_sl_pt, k_sl_pt_dwc
long k_rc, k_riga=0
integer k_return=0, k_id_meca_causale
st_esito kst_esito
st_tab_meca_dosimbozza kst_tab_meca_dosimbozza
st_tab_dosimetrie kst_tab_dosimetrie
datawindowchild kdwc_x, kdwc_x_sl_pt


choose case dwo.name

//	case "RAG_SOC_10" 
//		if isnull(data) = false and Len(trim(data)) > 0 then
//			k_rc = this.getchild("rag_soc_10", kdwc_x)
//			k_rag_soc = Trim(data)
//			if isnumber(k_rag_soc) then
//				k_riga = kdwc_x.find("id_cliente = " + k_rag_soc + " ",0,kdwc_x.rowcount())
//				if k_riga > 0  then
//					k_rag_soc = kdwc_x.getitemstring(k_riga, "rag_soc_1")
//				end if
//				k_riga = kdwc_x.find("rag_soc_1 =~""+ trim(k_rag_soc)+"~"",0,kdwc_x.rowcount())
//			else
//				k_riga = kdwc_x.find("rag_soc_1 like ~"%"+trim(k_rag_soc)+"%~"",0,kdwc_x.rowcount())
//				if k_riga <= 0 or isnull(k_riga) then
//					k_riga = kdwc_x.find("rag_soc_1 like ~"%"+trim(k_rag_soc)+"%~"",0,kdwc_x.rowcount()) // seconda ricerca approssimativa
//				end if
//			end if
//		
//			if k_riga <= 0 or isnull(k_riga) then
//				k_return = 2
//				this.setitem(row, "rag_soc_10", (k_rag_soc)+" - NON TROVATO -")
//				this.setitem(row, "cod_cli", 0)
//			else
//
////				this.setitem(row, "rag_soc_10", kdwc_x.getitemstring(k_riga, "rag_soc_1"))
////				this.setitem(row, "cod_cli", kdwc_x.getitemnumber(k_riga, "id_cliente"))
//				kst_tab_clienti.rag_soc_10 = kdwc_x.getitemstring(k_riga, "rag_soc_1")
//				kst_tab_clienti.codice = kdwc_x.getitemnumber(k_riga, "id_cliente")
//				post put_video_cliente(kst_tab_clienti)
//			end if
//		else
//			this.setitem(row, "rag_soc_10", "")
//			this.setitem(row, "cod_cli", 0)
//		end if

//--- calolo Dose dalla 'curva' del lotto dosimetrico 
	case "dosim_spessore", "dosim_assorb", "dosim_lotto_dosim" 
		kst_tab_dosimetrie.coeff_a_s = 0.0
		kst_tab_dosimetrie.dose = 0.0
		if len(trim(data)) > 0 and isnumber(trim(data)) then 
			if dwo.name = "dosim_spessore" then
				kst_tab_meca_dosimbozza.dosim_assorb = this.getitemnumber( row, "dosim_assorb")
				kst_tab_meca_dosimbozza.dosim_spessore = integer(data)
				kst_tab_dosimetrie.lotto_dosim = this.getitemstring(row, "dosim_lotto_dosim")
			else
				if dwo.name = "dosim_assorb" then
					kst_tab_meca_dosimbozza.dosim_spessore = this.getitemnumber( row, "dosim_spessore")
					kst_tab_meca_dosimbozza.dosim_assorb = integer(data)
					kst_tab_dosimetrie.lotto_dosim = this.getitemstring(row, "dosim_lotto_dosim")
				else
					kst_tab_dosimetrie.lotto_dosim = trim(data)
				end if
			end if
		end if
		if kst_tab_meca_dosimbozza.dosim_spessore > 0 and kst_tab_meca_dosimbozza.dosim_assorb > 0 then
			kst_tab_dosimetrie.coeff_a_s = calcola_coeff_a_s(kst_tab_meca_dosimbozza)
			kst_tab_dosimetrie.dose = 0.0
			if trim(kst_tab_dosimetrie.lotto_dosim) > " " then
		//--- get della DOSE attraverso il coff_a_s nella tabella DOSIMETRIE(la curva) x fare la convalida
				kst_esito = kiuf_ausiliari.tb_dosimetrie_select(kst_tab_dosimetrie) 
				if kst_esito.esito <> kkg_esito.ok then
					kst_tab_dosimetrie.dose = 0.0
				end if
			end if
		end if
		this.setitem(row, "dosim_rapp_a_s", kst_tab_dosimetrie.coeff_a_s)
		this.setitem(row, "dosim_dose", kst_tab_dosimetrie.dose)
		if kst_tab_dosimetrie.dose > 0 then
			this.modify("dosim_spessore.backcolor=" + string(kkg_colore.err_dato))
			this.modify("dosim_assorb.backcolor=" + string(kkg_colore.err_dato))
		else
			this.modify("dosim_spessore.backcolor=" + string(kkg_colore.bianco))
			this.modify("dosim_assorb.backcolor=" + string(kkg_colore.bianco))
		end if

end choose

return k_return



end event

event dw_dett_0::itemfocuschanged;//
//long k_rc, k_riga
//string k_sl_pt, k_sc_cf, k_dwc_sl_pt
//datawindowchild kdwc_x, kdwc_x_sc_cf, kdwc_x_des
//
//
//if ki_st_open_w.flag_modalita <> kkg_flag_modalita_visualizzazione then
//
//	choose case upper(dwo.name)
//
//		case "RAG_SOC_10", "COD_CLI"  
//
////--- Attivo dw archivio Clienti
//			k_rc = this.getchild("cod_cli", kdwc_x)
//			if kdwc_x.rowcount() < 2 then
//				kdwc_x.retrieve("%")
//				k_rc = this.getchild("rag_soc_10", kdwc_x_des)
//				kdwc_x.RowsCopy(kdwc_x.GetRow(), kdwc_x.RowCount(), Primary!, kdwc_x_des, 1, Primary!)
//				kdwc_x.setsort( "id_cliente A")
//				kdwc_x.sort( )
//				k_rc = kdwc_x.insertrow(1)
//				k_rc = kdwc_x_des.insertrow(1)
//			end if	
////			k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_x)
////			if kdwc_x.rowcount() < 2 then
////				kdwc_x.retrieve("%")
////				kdwc_x.insertrow(1)
////			end if
//
//		case "SC_CF" 
//
////--- Attivo dw archivio Capitolati
//			k_rc = dw_dett_0.getchild("sc_cf", kdwc_x)
//			if kdwc_x.rowcount() < 2 then
//				kdwc_x.retrieve(0, "S")
//				kdwc_x.insertrow(1)
//			end if
//
//
//		case "SL_PT" 
//
////--- Attivo dw archivio PT
//			k_rc = dw_dett_0.getchild("sl_pt", kdwc_x)
//			if kdwc_x.rowcount() < 2 then
//				kdwc_x.retrieve()
//				kdwc_x.insertrow(1)
//			end if
//
////--- se il codice CAPITOLATO contiene il SL-PT allora è quello da impostare 
//			k_sc_cf = dw_dett_0.getitemstring(row, "sc_cf")
//			if not isnull(k_sc_cf) and Len(trim(k_sc_cf)) > 0 then
////				k_rc = dw_dett_0.getchild("sc_cf", kdwc_x)
////--- Attivo dw archivio Capitolati
//				k_rc = dw_dett_0.getchild("sc_cf", kdwc_x_sc_cf)
//				if kdwc_x_sc_cf.rowcount() < 2 then
//					kdwc_x_sc_cf.retrieve(0, "S")
//					kdwc_x_sc_cf.insertrow(1)
//				end if
//				k_riga = kdwc_x.find("sc_cf = '" + trim(k_sc_cf) + "' ", 1, kdwc_x.RowCount())
//				if k_riga > 0 then
//					k_dwc_sl_pt =  kdwc_x.getitemstring(k_riga, "cod_sl_pt")
//					if not isnull(k_dwc_sl_pt) and Len(trim(k_dwc_sl_pt)) > 0 then
//						k_sl_pt =  dw_dett_0.getitemstring(row, "sl_pt")
//						if isnull(k_sl_pt) or Len(trim(k_sl_pt)) = 0 then
//							k_rc = dw_dett_0.setitem(row, "sl_pt", trim(k_dwc_sl_pt))
//						end if
//						//---- filtro da lista sl_pt quelli con il sc_cf impostato
//						k_rc = kdwc_x.SetFilter("sc_cf = '" + trim(k_sc_cf) + "' ")
//						k_rc = kdwc_x.Filter()
//						if kdwc_x.rowcount() = 0 then
//							k_rc = kdwc_x.SetFilter("")
//							k_rc = kdwc_x.Filter()
//						end if
//					else
//						k_rc = kdwc_x.SetFilter("")
//						k_rc = kdwc_x.Filter()
//						
//					end if
//				end if
//			end if
//
//		case "ID_MECA_CAUSALE" 
//
////--- Attivo dw archivio CAUSALI
//			k_rc = dw_dett_0.getchild("id_meca_causale", kdwc_x)
//			if kdwc_x.rowcount() < 2 then
//				kdwc_x.retrieve()
//				kdwc_x.insertrow(1)
//			end if
//
//	end choose
//end if

end event

event dw_dett_0::rowfocuschanged;call super::rowfocuschanged;//
//--- se sono sul ELENCO e campo BARCODE DOSIMETRO ha un valore significa che questa riga è già stata associata a un barcode di lavorazione
//---    pertanto devo proteggere il campo del barcode di lavoro
string k_prot = "0"
kuf_utility kuf1_utility


	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione and ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione then
		if this.dataobject = "d_convalida_dosimbozza_l" then
			if trim(this.getitemstring( currentrow, "barcode")) > " " and trim(this.getitemstring( currentrow, "barcode_lav")) > " " then
				k_prot = "1"
			end if
		end if
//--- S-protezione campi per riabilitare la modifica 
		kuf1_utility = create kuf_utility 
		kuf1_utility.u_proteggi_dw(k_prot, "barcode_lav", dw_dett_0)
		destroy kuf1_utility		
	end if

end event

event dw_dett_0::clicked;call super::clicked;//
string k_prot = "0"
long k_rc
st_open_w kst_open_w
st_tab_meca kst_tab_meca
kuf_menu_window kuf1_menu_window


choose case dwo.name

	case "b_lotto_dosim" &
		  ,"p_img_dosim_lotto_dosim_l"
		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
		kdsi_elenco_output.dataobject = "d_dosimetrie_lotto_l" 
		k_rc = kdsi_elenco_output.settransobject ( sqlca )
		k_rc = kdsi_elenco_output.retrieve()
		kst_open_w.key1 = "Elenco Lotti Dosimetrici " 
		if kdsi_elenco_output.rowcount() > 0 then
	
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
			kst_open_w.id_programma = kkg_id_programma.elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KK_ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
			kst_open_w.key4 = get_id_programma( )  //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_elenco_output
			kst_open_w.flag_where = " "
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(kst_open_w)
			destroy kuf1_menu_window
		else
			
			messagebox("Elenco dosimetrie caricate", "Nessun valore disponibile ")
			
			
		end if
		
	case else

//--- se sono su ELENCO e campo BARCODE DOSIMETRO ha un valore significa che questa riga è già stata associata a un barcode di lavorazione
//---    pertanto devo proteggere il campo del barcode di lavoro
		
		
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione and ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione then
			if this.dataobject = "d_convalida_dosimbozza_l" then
				if trim(this.getitemstring( row, "barcode")) > " " and trim(this.getitemstring( row, "barcode_lav")) > " " then
					k_prot = "1"
				end if
			end if
			this.modify("barcode_lav.protect=" + k_prot)		
		end if

end choose

end event

event dw_dett_0::doubleclicked;//
//disabilito il doubleclick
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_convalida_dosimbozza
integer x = 0
integer y = 744
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_convalida_dosimbozza
integer x = 23
integer width = 3291
integer height = 732
string dataobject = "d_mecadosim_l_da_leggere"
end type

type dw_guida from w_g_tab0`dw_guida within w_convalida_dosimbozza
boolean visible = true
integer y = 8
integer width = 3433
integer height = 84
boolean enabled = true
string dataobject = "d_meca_dosimbozza_guida"
end type

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---
boolean k_elabora=true
string k_codice_x, k_numero_x, k_anno_x, k_cliente_x
int k_dosimbozza_si = 1
long k_codice
st_tab_armo kst_tab_armo


try
	
   kist_tab_meca.id = dw_guida.getitemnumber(1, "id_meca")
   if isnull( kist_tab_meca.id ) then
      kist_tab_meca.id = 0
   end if


//--- solo se ricerco un codice diverso
	k_codice_x = trim(dw_guida.getitemstring(1, "codice"))
	if isnull(k_codice_x) then k_codice_x = ""
	k_dosimbozza_si = dw_guida.getitemnumber(1, "dosimbozza_si")

	if ki_ultimo_codice_cercato <> k_codice_x or k_dosimbozza_si <> ki_ultimo_dosimbozza_si then
		ki_ultimo_dosimbozza_si = k_dosimbozza_si
		
		if ki_ultimo_codice_cercato <> k_codice_x then
			ki_ultimo_codice_cercato = k_codice_x
	
	//--- se la stringa di ricerca è vuota allora mostra tutto			
			if k_codice_x > " " then 	
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
			end if				
			if k_codice_x > " " then 
			else
				k_codice_x = "0"  
				k_numero_x = "0" 
				k_anno_x = "0" 
				kist_tab_meca.id = 0
				kist_tab_meca.clie_1 = 0
//				u_retrieve_dw_lista()
			end if
			
			if not isnumber(k_codice_x) or not isnumber(k_numero_x) or not isnumber(k_anno_x) then
				kguo_exception.inizializza( )
				kguo_exception.setmessage("Codice Lotto non numerico", "Digitare: num. lotto oppure il numero e anno separati da un '/' oppure il codice ID lotto, oppure il codice Cliente/Mandante")
				throw kguo_exception
			else
				k_codice = long(k_codice_x)
				if k_codice > 0 and k_codice < 50000 then // se minore di 50 mila sicuramente si tratta di un numero lotto o codice cliente altrimentise > 5000 di un ID lotto 
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
					
				//if kist_tab_meca.id > 0 or kist_tab_meca.clie_1 > 0 then
				//end if
				
			end if
		end if            
		u_retrieve_dw_lista()
	end if
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try


end event

type dw_data from uo_d_std_1 within w_convalida_dosimbozza
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

