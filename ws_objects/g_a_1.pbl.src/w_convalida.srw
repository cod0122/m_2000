$PBExportHeader$w_convalida.srw
forward
global type w_convalida from w_g_tab0
end type
type dw_data from uo_d_std_1 within w_convalida
end type
end forward

global type w_convalida from w_g_tab0
integer width = 3634
integer height = 2100
string title = "Elenco CO"
long backcolor = 32501743
boolean ki_toolbar_window_presente = true
boolean ki_sincronizza_window_ok = true
dw_data dw_data
end type
global w_convalida w_convalida

type variables
//
//private string ki_mostra_nascondi_in_lista = "S"
//private kuf_clienti kiuf_clienti

//private st_tab_contratti ki_st_tab_contratti_arg
private st_tab_meca_dosimbozza kist_tab_meca_dosimbozza_insert
private date ki_data_int_da, ki_data_int_da_ultimo

private string ki_ultimo_codice_cercato="*********"
private int ki_ultimo_guida_flag_convalidati=0   // 0=da convalidare, 1=da riconvalidare, 2=convalidati

private st_tab_meca kist_tab_meca, kist_tab_meca_arg
private kuf_meca_dosimbozza kiuf_meca_dosimbozza
private kuf_meca_dosim_conv kiuf_meca_dosim_conv
private kuf_meca_dosim kiuf_meca_dosim
//private kuf_armo kiuf_armo
private kuf_ausiliari kiuf_ausiliari

//private datastore kdsi_elenco_output

end variables

forward prototypes
public function string inizializza ()
private function string cancella ()
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
private function double calcola_coeff_a_s (st_tab_meca_dosimbozza ast_tab_meca_dosimbozza)
protected subroutine pulizia_righe ()
protected function string aggiorna_tabelle ()
protected subroutine u_lista_deseleziona_tutti ()
protected subroutine u_lista_seleziona_tutti ()
public function boolean u_convalida ()
public subroutine u_riconvalida ()
private subroutine u_refresh_icone ()
private function integer u_retrieve_dw_lista ()
protected subroutine attiva_tasti_0 ()
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
//			k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
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
//		if dw_lista_0.retrieve(ki_st_tab_contratti_arg.cod_cli, ki_st_tab_contratti_arg.mc_co, ki_data_int_da) < 1 then
			
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
st_tab_meca_dosim kst_tab_meca_dosim


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	kst_tab_meca_dosimbozza.id_meca_dosimbozza = dw_dett_0.getitemnumber(1, "id_meca_dosimbozza")
	kst_tab_meca_dosimbozza.barcode = dw_dett_0.getitemstring(1, "meca_dosimbozza_barcode")
	kst_tab_meca_dosimbozza.barcode_lav = dw_dett_0.getitemstring(1, "barcode_lav")
	k_codice = kst_tab_meca_dosimbozza.id_meca_dosimbozza
	k_appo = kst_tab_meca_dosimbozza.barcode
	k_descr = kst_tab_meca_dosimbozza.barcode_lav
	if isnull(k_appo) then
		k_appo = ""
	end if
	if isnull(k_descr)then
		k_descr = "" 
	end if
	k_msg = "Sei sicuro di voler Rimuovere il DOSIMETRO" + &
			" " + trim(k_appo) + " lavorato con il barcode " + trim(k_descr) + " (id lettura: " + string(k_codice, "####0") + ")"
end if

if k_riga > 0 and k_codice > 0 then	

	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Lettura Dosimetro", k_msg, question!, yesno!, 2) = 1 then
 
//=== Cancella la riga dal data windows di lista
		try
			if kst_tab_meca_dosimbozza.id_meca_dosimbozza > 0 then
				kst_tab_meca_dosim.barcode = kst_tab_meca_dosimbozza.barcode 
				kiuf_meca_dosimbozza.tb_delete(kst_tab_meca_dosimbozza) 
				kiuf_meca_dosim.tb_delete(kst_tab_meca_dosim) 
			end if

			kguo_sqlca_db_magazzino.db_commit( )

//--- cancello riga a video
			k_codice = 0
			k_riga = dw_dett_0.rowcount()	
			if k_riga > 0 then
				k_codice = dw_dett_0.getitemnumber(1, "codice")
				dw_dett_0.deleterow(k_riga)
			end if
			if k_riga <= 0 or isnull(k_codice) then
				k_riga = dw_lista_0.getselectedrow(0)	
				if k_riga > 0 then
					dw_lista_0.deleterow(k_riga)
				end if
			end if

			dw_dett_0.setfocus()

		catch (uo_exception kuo_exception)
			kst_esito =kuo_exception.get_st_esito()
			k_return = "1" + trim(kst_esito.sqlerrtext) + " (" + string(kst_esito.sqlcode) + ")" 
			kGuf_data_base.db_rollback()

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

protected function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
long k_key, k_riga, k_riga_max
st_open_w kst_open_w
kuf_utility kuf1_utility	
st_tab_meca_dosim kst_tab_meca_dosim


	if ki_ultimo_guida_flag_convalidati = 0 then
	
		k_key = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_meca")
		
		ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 
	
		k_return = dw_dett_0.retrieve( k_key ) // legge le dosimetrie
	
//--- S-protezione campi per modifica
		kuf1_utility = create kuf_utility 
		kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)
		
//		dw_dett_0.modify("dosim_data.protect= 0
//		k_riga_max = dw_dett_0.rowcount( )
//		for k_riga = 1 to k_riga_max
//			kst_tab_meca_dosim.dosim_data = dw_dett_0.getitemdate( k_riga, "meca_dosim_dosim_data")
//			if kst_tab_meca_dosim.dosim_data > kkg.data_zero then
//				kuf1_utility.u_proteggi_dw("1", "dosim_data", dw_dett_0)
//				kuf1_utility.u_proteggi_dw("1", "dosim_temperatura", dw_dett_0)
//				kuf1_utility.u_proteggi_dw("1", "dosim_umidita", dw_dett_0)
//			end if
//		next
		destroy kuf1_utility	

//		dw_dett_0.event u_modifica_set_color()
		
//--- legge i DWC
		legge_dwc()

		attiva_tasti()
		
	end if

return k_return

end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu
boolean k_convalida = true
string k_convalida_text, k_convalida_help, k_convalida_short


//
//--- Attiva/Dis. Voci di menu personalizzate
//
	k_convalida_text = "Convalida Lotti con il segno di spunta"
	k_convalida_help = "Verifica lettura dosimetrica con i valori indicati a Contratto"
	k_convalida_short = "Convalida"
	if ki_ultimo_guida_flag_convalidati = 2 then
		k_convalida = false
	elseif ki_ultimo_guida_flag_convalidati = 1 then
		k_convalida_text = "Riconvalida Lotto selezionato"
		k_convalida_help = "Verifica convalida dosimetrica già rilevata in anomalia con i valori indicati a Contratto"
		k_convalida_short = "Riconvalida"
	end if
	if not ki_menu.m_strumenti.m_fin_gest_libero3.enabled <> k_convalida &
					or ki_menu.m_strumenti.m_fin_gest_libero3.text <> k_convalida_text &
					or not ki_menu.m_strumenti.m_fin_gest_libero3.visible then
		ki_menu.m_strumenti.m_fin_gest_libero3.text = k_convalida_text
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = k_convalida_help
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = k_convalida
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = k_convalida_short + "," + k_convalida_text
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "spunta32.png"
//		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
	end if

	if not ki_menu.m_strumenti.m_fin_gest_libero4.enabled then
		ki_menu.m_strumenti.m_fin_gest_libero4.text = "Cambia data estrazione lotti "
		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Cambia data estrazione lotti "
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = "Data,"+ki_menu.m_strumenti.m_fin_gest_libero4.text
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = "Custom015!"
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
	end if	
	
//	
	if ki_ultimo_guida_flag_convalidati = 0 then
		ki_menu.m_strumenti.m_fin_gest_libero8.enabled = true
	else
		ki_menu.m_strumenti.m_fin_gest_libero8.enabled = false
	end if
	if not ki_menu.m_strumenti.m_fin_gest_libero8.visible  then
		ki_menu.m_strumenti.m_fin_gest_libero8.text = "Deseleziona tutto "
		ki_menu.m_strumenti.m_fin_gest_libero8.microhelp = "Toglie il segno di spunta a tutti i lotti in elenco   "
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemtext = "Deseleziona,"+  ki_menu.m_strumenti.m_fin_gest_libero8.text
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemname = "custom080!"
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemvisible = true
//		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero8.visible = true
	end if
//	
	if ki_ultimo_guida_flag_convalidati = 0 then
		ki_menu.m_strumenti.m_fin_gest_libero9.enabled = true
	else
		ki_menu.m_strumenti.m_fin_gest_libero9.enabled = false
	end if
	if not ki_menu.m_strumenti.m_fin_gest_libero9.visible  then
		ki_menu.m_strumenti.m_fin_gest_libero9.text = "Seleziona tutto "
		ki_menu.m_strumenti.m_fin_gest_libero9.microhelp = "Segno di spunta su tutti i lotti in elenco   "
		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemtext = "Seleziona,"+ ki_menu.m_strumenti.m_fin_gest_libero9.text
		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemname = "custom038!"
//		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero9.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemvisible = true
	end if

	
	super::attiva_menu()

end subroutine

protected subroutine smista_funz (string k_par_in);//===

choose case LeftA(k_par_in, 2) 


//	case KKG_FLAG_RICHIESTA.libero1		//Mostra nasconde attivi/disattivi
//		mostra_nascondi_in_lista()

	case KKG_FLAG_RICHIESTA.libero3		//lancia CONVALIDA
		if ki_ultimo_guida_flag_convalidati = 0 then
			u_convalida( )
		else
			u_riconvalida( )
		end if

	case KKG_FLAG_RICHIESTA.libero4		//cambia data estrazione scadenze
		cambia_data_scadenze()
		
	case KKG_FLAG_RICHIESTA.libero8		//Togli Selezione
		this.u_lista_deseleziona_tutti( )

	case KKG_FLAG_RICHIESTA.libero9		//Metti Selezione
		this.u_lista_seleziona_tutti( )

	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

private function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
long k_key, k_riga
st_open_w kst_open_w
kuf_utility kuf1_utility


if dw_lista_0.rowcount( ) > 0 then
	k_riga = dw_lista_0.getrow()
	if k_riga > 0 then
	else
		k_riga = 1
	end if
	
	k_key = dw_lista_0.getitemnumber(k_riga, "id_meca")
	
	if k_key > 0 then
		ki_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione 
	
		k_return = dw_dett_0.retrieve( k_key ) // legge le dosimetrie
	
//--- protezione campi per visual
		kuf1_utility = create kuf_utility 
		kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
		destroy kuf1_utility	
	end if		

end if

return k_return


end function

protected subroutine riempi_id ();//
long k_riga=0, k_tot_righe
st_tab_meca_dosimbozza kst_tab_meca_dosimbozza


k_tot_righe = dw_dett_0.rowcount()

for k_riga = 1 to k_tot_righe
	kst_tab_meca_dosimbozza.id_meca_dosimbozza = dw_dett_0.getitemnumber(k_riga, "id_meca_dosimbozza")  
	if kst_tab_meca_dosimbozza.id_meca_dosimbozza > 0 then
		
		dw_dett_0.setitemstatus(k_riga, 0, Primary!, DataModified!)
		
	else
		dw_dett_0.setitemstatus(k_riga, 0, Primary!, NewModified!)
		
		dw_dett_0.setitem(k_riga, "id_meca_dosimbozza", 0)
	end if

	if dw_dett_0.getitemdate(k_riga, "dosim_data") > kguo_g.get_datazero( ) then
	else
		dw_dett_0.setitem(k_riga, "dosim_data", kguo_g.get_dataoggi( ) )
	end if

	dw_dett_0.setitem(k_riga, "x_data_dosim_lettura", kGuf_data_base.prendi_x_datins())
	dw_dett_0.setitem(k_riga, "x_utente_dosim_lettura", kGuf_data_base.prendi_x_utente())
	dw_dett_0.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
	dw_dett_0.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())
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
	kiuf_meca_dosim = create  kuf_meca_dosim
	kiuf_ausiliari = create kuf_ausiliari
	kiuf_meca_dosim_conv = create kuf_meca_dosim_conv
	
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
			ki_data_int_da = date(trim(ki_st_open_w.key3))
		else
			ki_data_int_da = relativedate(kguo_g.get_dataoggi( ), -65)
		end if
	else
		ki_data_int_da = relativedate(kguo_g.get_dataoggi( ), -65)
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

	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
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
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
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

dw_dett_0.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
dw_dett_0.modify( "clienti_rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
dw_dett_0.setitem(k_riga, "rag_soc_10", kst_tab_clienti.rag_soc_10)
dw_dett_0.setitem(k_riga, "cod_cli", kst_tab_clienti.codice)

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

protected subroutine pulizia_righe ();//
long k_riga, k_righe
boolean k_aggiorna=false


if ki_ultimo_guida_flag_convalidati = 0 then
	
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

end if


end subroutine

protected function string aggiorna_tabelle ();//
string k_return = "0"
st_tab_meca_dosimbozza kst_tab_meca_dosimbozza	
st_esito kst_esito
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode


try	
	 
	if dw_dett_0.update() < 0 then
		kguo_sqlca_db_magazzino.db_rollback()
		kst_esito.sqlcode = -1
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlerrtext = "Errore durante aggiornamento dati Convalida dosimetrica"
		kguo_exception.inizializza()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else

//=== Se tutto OK faccio la COMMIT		
		kguo_sqlca_db_magazzino.db_commit()
		
//--- ricostruisce situazione flag dosimetro sui barcode
		kuf1_barcode = create kuf_barcode
		kst_tab_barcode.id_meca = dw_dett_0.getitemnumber(1, "id_meca")
		kuf1_barcode.set_flg_dosimetro_all(kst_tab_barcode)
		
	end if
			
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	k_return = "1Errore: " + string(kst_esito.sqlcode) + " (" + trim(kst_esito.sqlerrtext) + ") "
	
finally
	if isvalid(kuf1_barcode) then destroy kuf1_barcode 
	
end try

return k_return
end function

protected subroutine u_lista_deseleziona_tutti ();//
//--- Deseleziona tutti i record del dw: dw_lista_0
//
long k_ctr


for k_ctr = 1 to dw_lista_0.rowcount( )
	
	dw_lista_0.object.k_esegui[k_ctr] = 0		
	
next




end subroutine

protected subroutine u_lista_seleziona_tutti ();//
//--- Seleziona tutti i record del dw: dw_lista_0
//
long k_ctr


for k_ctr = 1 to dw_lista_0.rowcount( )
	
	dw_lista_0.object.k_esegui[k_ctr] = 1		
	
next




end subroutine

public function boolean u_convalida ();//
//--- Convalida multipla Lotti 
//--- out: TRUE = convalida eseguita
//
boolean k_return = false 
int k_sn = 0, k_nr_ok, k_nr_ko, k_nr_notfnd, k_ctr, k_nr_elab
long k_riga, k_riga_max
string k_str
st_tab_meca_dosim kst_tab_meca_dosim
st_tab_meca_dosimbozza kst_tab_meca_dosimbozza
datastore kds_1
st_esito kst_esito


try
	k_riga_max = dw_lista_0.rowcount( )

//--- solo conteggio x info
	for k_riga = k_riga_max to 1 step -1  
		if dw_lista_0.getitemnumber( k_riga, "k_esegui_1") = 1 then
			k_ctr ++
		end if
	next

	if k_ctr = 0 then
		kguo_exception.inizializza()
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Segnare con la spunta almeno una riga in elenco"
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	if k_ctr > 1 then
		k_str = " dei " + string(k_ctr) + " dosimetri selezionati"
	else
		k_str = " del dosimetro selezionato"
	end if
	k_sn = messagebox("Convalida Lotti", "Eseguire l'operazione di Convalida" + k_str, question!, YesNo!, 2)
	if k_sn = 1 then

		kds_1 = create datastore
		kds_1.dataobject = "ds_meca_dosimbozza"
		kds_1.settransobject(kguo_sqlca_db_magazzino)
		
		SetPointer(kkg.pointer_attesa)
		
		for k_riga = k_riga_max to 1 step -1  
			
			if dw_lista_0.getitemnumber( k_riga, "k_esegui_1") = 1 then
				k_nr_elab++
	
				kst_tab_meca_dosimbozza.id_meca_dosimbozza = dw_lista_0.getitemnumber(k_riga, "id_meca_dosimbozza")
				if kds_1.retrieve(kst_tab_meca_dosimbozza.id_meca_dosimbozza) > 0 then
	
					kst_tab_meca_dosim.barcode = kds_1.getitemstring(1, "barcode")
					kst_tab_meca_dosim.barcode_lav = kds_1.getitemstring(1, "barcode_lav")
					kst_tab_meca_dosim.id_meca = kds_1.getitemnumber(1, "id_meca")
					kst_tab_meca_dosim.dosim_flg_tipo_dose = kds_1.getitemstring(1, "dosim_flg_tipo_dose")
					kst_tab_meca_dosim.dosim_lotto_dosim = kds_1.getitemstring(1, "dosim_lotto_dosim")
					kst_tab_meca_dosim.dosim_rapp_a_s = kds_1.getitemnumber(1, "dosim_rapp_a_s")
	
					kst_tab_meca_dosim = kiuf_meca_dosim.convalida_dosim(kst_tab_meca_dosim)  // CONVALIDA
	
					kst_tab_meca_dosim.dosim_data = kguo_g.get_dataoggi( )
					kst_tab_meca_dosim.dosim_assorb = kds_1.getitemnumber(1, "dosim_assorb")
					kst_tab_meca_dosim.dosim_spessore = kds_1.getitemnumber(1, "dosim_spessore")
					kst_tab_meca_dosim.dosim_temperatura = kds_1.getitemnumber(1, "dosim_temperatura")
					kst_tab_meca_dosim.dosim_umidita = kds_1.getitemnumber(1, "dosim_umidita")
					kst_tab_meca_dosim.dosim_dose = kds_1.getitemnumber(1, "dosim_dose")
	
					kst_tab_meca_dosim.st_tab_g_0.esegui_commit = "N"
					kiuf_meca_dosim.set_convalida_x_barcode(kst_tab_meca_dosim)    // AGGIORNA MECA_DOSIM
					
					dw_lista_0.deleterow(k_riga)
	
					if kst_tab_meca_dosim.err_lav_ok = kiuf_meca_dosim.ki_err_lav_ok_conv_aut_ok &
						  or kst_tab_meca_dosim.err_lav_ok = kiuf_meca_dosim.ki_err_lav_ok_conv_aut_ok &
						or kst_tab_meca_dosim.err_lav_ok = kiuf_meca_dosim.ki_err_lav_ok_conv_aut_ok then
						k_nr_ok ++
					else
						k_nr_ko ++
					end if
				else
					k_nr_notfnd ++
				end if
			end if
			
		next

		if (k_nr_ok + k_nr_ko) > 0 then
			kguo_sqlca_db_magazzino.db_commit( )
		end if
		
		SetPointer(kkg.pointer_default)
		
		if k_nr_ko > 0 then
			if k_nr_ok > 0 then
				if k_nr_notfnd > 0 then
					messagebox ("Convalida con Anomalie", "Sono stati Convalidati " + string((k_nr_ok + k_nr_ko)) + " dosimetri " &
			            + " di cui " + string(k_nr_ko) + " in ANOMALIA e " + string(k_nr_ok) + " con esito positivo. Inoltre " &
							+ string(k_nr_notfnd) + " dosimetri letti non sono stati trovati in archivio e sono lasciati con la spunta in elenco!" , stopsign!)
				else		
					messagebox ("Convalida con Anomalie", "Sono stati Convalidati " + string((k_nr_ok + k_nr_ko)) + " dosimetri " &
			            + " di cui " + string(k_nr_ko) + " in ANOMALIA e " + string(k_nr_ok) + " con esito positivo.", stopsign!)
				end if
			else		
				if k_nr_notfnd > 0 then
					if k_nr_notfnd > 1 then
						messagebox ("Operazione in Anomalia", "Tutti i " + string(k_nr_ko) + " dosimetri " &
					            + "sono stati esitati come ANOMALIA ! Inoltre " &
								+ string(k_nr_notfnd) + " dosimetri non sono stati trovati in archivio per fare la Convalida controlla in elenco se è stata lasciata la spunta", stopsign!)
					else		
						messagebox ("Operazione in Anomalia", "Tutti i " + string(k_nr_ko) + " dosimetri " &
					            + "sono stati esitati come ANOMALIA ! Inoltre " &
								+ string(k_nr_notfnd) + " dosimetro non è stato trovato in archivio per fare la Convalida, controlla in elenco se è stata lasciata la spunta", stopsign!)
					end if
				else		
					messagebox ("Operazione in Anomalia", "Tutti i " + string(k_nr_ko) + " dosimetri " &
					            + "sono stati esitati come ANOMALIA !", stopsign!)
				end if
			end if
		else		
			if k_nr_notfnd > 0 then
				if k_nr_notfnd > 1 then
					if k_nr_ok > 0 then
						messagebox ("Operazione conclusa correttamente", "Sono stati Convalidati " + string(k_nr_ok) + " dosimetri con esito positivo.  Inoltre " &
								+ string(k_nr_notfnd) + " dosimetri non sono stati trovati in archivio per fare la Convalida controlla in elenco se è stata lasciata la spunta")
					else		
						messagebox ("Operazione conclusa", "Non è stato Convalidato alcun dosimetro ma " &
								+ string(k_nr_notfnd) + " dosimetri non sono stati trovati in archivio per fare la Convalida controlla in elenco se è stata lasciata la spunta")
					end if
				else
					if k_nr_ok > 0 then
						messagebox ("Operazione conclusa correttamente", "Sono stati Convalidati " + string(k_nr_ok) + " dosimetri con esito positivo.  Inoltre " &
								+ string(k_nr_notfnd) + " dosimetro non è stato trovato in archivio per fare la Convalida, controlla in elenco se è stata lasciata la spunta")
					else		
						messagebox ("Operazione conclusa", "Non è stato Convalidato alcun dosimetro ma " &
								+ string(k_nr_notfnd) + " dosimetro non è stato trovato in archivio per fare la Convalida, controlla in elenco se è stata lasciata la spunta")
					end if
				end if
			else		
				messagebox ("Operazione conclusa correttamente", "Sono stati Convalidati " + string(k_nr_ok) + " dosimetri con esito positivo.")
			end if
		end if
	end if


catch (uo_exception kuo_exception)
	if (k_nr_ok + k_nr_ko) > 0 then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	kuo_exception.messaggio_utente()

finally
	if isvalid(kds_1) then destroy kds_1
	SetPointer(kkg.pointer_default)

end try	
	

return k_return
end function

public subroutine u_riconvalida ();//---
//--- Riconvalida lotto in anomalia 
//---
st_open_w kst_open_w


	if dw_dett_0.visible then
		mostra_nascondi_dw()
	end if
	if dw_lista_0.getrow() = 0 then
		messagebox("Riconvalida", "Selezionare una riga in elenco") 
	else
//--- Riconvalida
		kst_open_w.flag_modalita = kkg_flag_modalita.modifica
		kst_open_w.id_programma = kiuf_meca_dosim_conv.get_id_programma(kst_open_w.flag_modalita)
		kst_open_w.key1 = dw_lista_0.getitemstring( dw_lista_0.getrow(), "meca_dosim_barcode_1")
		kiuf_meca_dosim_conv.u_open(kst_open_w)
//		k_return = 1
	end if
		

end subroutine

private subroutine u_refresh_icone ();//
	dw_lista_0.event u_personalizza_dw( )   //carica eventuali ICONE
	dw_lista_0.groupcalc( )
	dw_dett_0.event u_personalizza_dw( )   //carica eventuali ICONE

end subroutine

private function integer u_retrieve_dw_lista ();//---
//---  Fa la Retrieve
//---
long k_return=0	


	if kist_tab_meca.id > 0 then
		ki_win_titolo_custom += "per ID lotto " + string(kist_tab_meca.id) 
	else
		ki_win_titolo_custom = "dalla data del " + string(ki_data_int_da) 
		if kist_tab_meca.clie_1 > 0 then
			ki_win_titolo_custom += " e per il codice anagrafica " + string(kist_tab_meca.clie_1) 
		end if
	end if

	if dw_dett_0.visible then
		mostra_nascondi_dw()
	end if
	//dw_lista_0.reset()

	ki_win_titolo_custom = "" 
	choose case ki_ultimo_guida_flag_convalidati
		case 0
			ki_win_titolo_custom += "da Convalidare "
			dw_lista_0.dataobject = "d_mecadosim_l_da_conv"
			dw_lista_0.settransobject(kguo_sqlca_db_magazzino)
			k_return = dw_lista_0.retrieve(ki_data_int_da, kist_tab_meca.clie_1, kist_tab_meca.id) 
			dw_dett_0.dataobject = "d_meca_dosimbozza_l"
			dw_dett_0.settransobject(kguo_sqlca_db_magazzino)
		case 1
			ki_win_titolo_custom += "da Riconvalidare "
			dw_lista_0.dataobject = "d_mecadosim_l_conv"
			dw_lista_0.settransobject(kguo_sqlca_db_magazzino)
			k_return = dw_lista_0.retrieve(ki_data_int_da, kist_tab_meca.clie_1, kist_tab_meca.id, ki_ultimo_guida_flag_convalidati) 
			dw_dett_0.dataobject = "d_meca_dosim_l"
			dw_dett_0.settransobject(kguo_sqlca_db_magazzino)
		case 2
			ki_win_titolo_custom += "Lotti Convalidati "
			dw_lista_0.dataobject = "d_mecadosim_l_conv"
			dw_lista_0.settransobject(kguo_sqlca_db_magazzino)
			k_return = dw_lista_0.retrieve(ki_data_int_da, kist_tab_meca.clie_1, kist_tab_meca.id, ki_ultimo_guida_flag_convalidati) 
			dw_dett_0.dataobject = "d_meca_dosim_l"
			dw_dett_0.settransobject(kguo_sqlca_db_magazzino)
	end choose

	u_refresh_icone()
	
	dw_guida.setitem(1,  "testo", "Trovati " + string(k_return, "###,##0") + " dosimetri ")

	if k_return > 0 then
		ki_sincronizza_window_consenti = true		// attivo sincronizzazione 
	else
		ki_sincronizza_window_consenti = false		// nessuna sincronizzazione permessa
	end if
	
	dw_lista_0.setfocus( )
	
	attiva_tasti( )

	
return k_return
	

end function

protected subroutine attiva_tasti_0 ();//
boolean k_modifica = false


super::attiva_tasti_0( )

if ki_ultimo_guida_flag_convalidati = 0 then //solo se sono su LETTURE allora abilita MODIFICA
	k_modifica = true
end if

if cb_inserisci.enabled or cb_modifica.enabled <> k_modifica then
	cb_inserisci.enabled = false
	cb_modifica.enabled = k_modifica
end if

end subroutine

on w_convalida.create
int iCurrent
call super::create
this.dw_data=create dw_data
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_data
end on

on w_convalida.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_data)
end on

event close;call super::close;//
//if isvalid(kiuf_armo)  then destroy kiuf_armo
if isvalid(kiuf_meca_dosim_conv)  then destroy kiuf_meca_dosim_conv
if isvalid(kiuf_meca_dosimbozza)  then destroy kiuf_meca_dosimbozza
if isvalid(kiuf_meca_dosim)  then destroy kiuf_meca_dosim


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

type st_ritorna from w_g_tab0`st_ritorna within w_convalida
integer x = 2821
integer y = 980
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_convalida
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_convalida
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_convalida
integer x = 2880
integer y = 1768
end type

type st_stampa from w_g_tab0`st_stampa within w_convalida
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_convalida
integer x = 2834
integer y = 1664
end type

type cb_modifica from w_g_tab0`cb_modifica within w_convalida
integer x = 2926
integer y = 1240
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_convalida
integer x = 2894
integer y = 1536
end type

type cb_cancella from w_g_tab0`cb_cancella within w_convalida
integer x = 2880
integer y = 1384
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_convalida
integer x = 2907
integer y = 1092
end type

event cb_inserisci::clicked;//
inserisci( )

end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_convalida
integer x = 5
integer y = 792
integer width = 2784
integer height = 1148
boolean enabled = true
string dataobject = "d_convalida_dosimbozza_l"
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = true
boolean ki_d_std_1_attiva_cerca = true
end type

event dw_dett_0::itemchanged;//
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

event dw_dett_0::rowfocuschanged;call super::rowfocuschanged;//
//--- se sono sul ELENCO e campo BARCODE DOSIMETRO ha un valore significa che questa riga è già stata associata a un barcode di lavorazione
//---    pertanto devo proteggere il campo del barcode di lavoro
string k_prot = "0"
kuf_utility kuf1_utility


	if this.dataobject = "d_convalida_dosimbozza_l" then
		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione and ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione then
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

event dw_dett_0::clicked;call super::clicked;////
//string k_prot = "0"
//long k_rc
//st_open_w kst_open_w
//st_tab_meca kst_tab_meca
//kuf_menu_window kuf1_menu_window
//
//
//choose case dwo.name
//
//	case "b_lotto_dosim" &
//		  ,"p_img_dosim_lotto_dosim_l"
//		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
//		kdsi_elenco_output.dataobject = "d_dosimetrie_lotto_l" 
//		k_rc = kdsi_elenco_output.settransobject ( sqlca )
//		k_rc = kdsi_elenco_output.retrieve()
//		kst_open_w.key1 = "Elenco Lotti Dosimetrici " 
//		if kdsi_elenco_output.rowcount() > 0 then
//	
//	//--- chiamare la window di elenco
//	//
//	//=== Parametri : 
//	//=== struttura st_open_w
//			kst_open_w.id_programma = kkg_id_programma.elenco
//			kst_open_w.flag_primo_giro = "S"
//			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
//			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
//			kst_open_w.flag_leggi_dw = " "
//			kst_open_w.flag_cerca_in_lista = " "
//			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
//			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
//			kst_open_w.key4 = get_id_programma( )  //--- Titolo della Window di chiamata per riconoscerla
//			kst_open_w.key12_any = kdsi_elenco_output
//			kst_open_w.flag_where = " "
//			kuf1_menu_window = create kuf_menu_window 
//			kuf1_menu_window.open_w_tabelle(kst_open_w)
//			destroy kuf1_menu_window
//		else
//			
//			messagebox("Elenco dosimetrie caricate", "Nessun valore disponibile ")
//			
//			
//		end if
//		
//	case else
//
////--- se sono su ELENCO e campo BARCODE DOSIMETRO ha un valore significa che questa riga è già stata associata a un barcode di lavorazione
////---    pertanto devo proteggere il campo del barcode di lavoro
//		
//		
//		if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione and ki_st_open_w.flag_modalita <> kkg_flag_modalita.cancellazione then
//			if this.dataobject = "d_convalida_dosimbozza_l" then
//				if trim(this.getitemstring( row, "barcode")) > " " and trim(this.getitemstring( row, "barcode_lav")) > " " then
//					k_prot = "1"
//				end if
//			end if
//			this.modify("barcode_lav.protect=" + k_prot)		
//		end if
//
//end choose
//
end event

event dw_dett_0::doubleclicked;	//
//disabilito il doubleclick
end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_convalida
integer x = 0
integer y = 744
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_convalida
integer x = 23
integer width = 3291
integer height = 732
string dataobject = "d_mecadosim_l_da_conv"
end type

event dw_lista_0::rowfocuschanged;call super::rowfocuschanged;//
if dw_dett_0.visible then
	visualizza( )
end if

end event

event dw_lista_0::clicked;call super::clicked;//
int k_esegui
long k_id, k_id_new, k_row, k_row_max
choose case dwo.name

	case "k_esegui" 
		if this.dataobject = "d_mecadosim_l_da_conv" then
			row=u_get_band_pointer()
			if this.getitemnumber( row, "k_esegui_1") = 1 then
				k_esegui = 0
			else
				k_esegui = 1
			end if
			k_id = this.getitemnumber( row, "id_meca_1")
			k_id_new = k_id
			k_row_max = this.rowcount( )
			k_row = row
			do while k_id = k_id_new and k_row <= k_row_max
				this.setitem( k_row, "k_esegui_1", k_esegui)
				k_row ++
				if k_row <= k_row_max then
					k_id_new = this.getitemnumber( k_row, "id_meca_1")
				end if
			loop 
		end if
		
end choose
end event

type dw_guida from w_g_tab0`dw_guida within w_convalida
boolean visible = true
integer y = 8
integer width = 3433
integer height = 84
boolean enabled = true
string dataobject = "d_convalida_guida"
end type

event dw_guida::ue_buttonclicked;call super::ue_buttonclicked;//---
boolean k_elabora=true
string k_codice_x
int k_guida_flag_convalidati = 1
kuf_utility kuf1_utility
st_dw_guida_estrazione kst_dw_guida_estrazione


try
	
	this.accepttext( )
	
   kist_tab_meca.id = this.getitemnumber(1, "id_meca")
   if isnull( kist_tab_meca.id ) then
      kist_tab_meca.id = 0
   end if

//--- solo se ricerco un codice diverso
	k_codice_x = trim(this.getitemstring(1, "codice"))
	if isnull(k_codice_x) then k_codice_x = ""
	k_guida_flag_convalidati = this.getitemnumber(1, "flag_sino")

	if ki_ultimo_codice_cercato <> k_codice_x &
					or k_guida_flag_convalidati <> ki_ultimo_guida_flag_convalidati &
					or ki_data_int_da_ultimo <> ki_data_int_da then
					
		ki_ultimo_guida_flag_convalidati = k_guida_flag_convalidati
		ki_data_int_da_ultimo = ki_data_int_da
		
		if ki_ultimo_codice_cercato <> k_codice_x then
			ki_ultimo_codice_cercato = k_codice_x
	
			kst_dw_guida_estrazione.input = k_codice_x
			kuf1_utility = create kuf_utility
			kuf1_utility.u_dw_guida_estrazione(kst_dw_guida_estrazione)
	
			kist_tab_meca.id = kst_dw_guida_estrazione.id_meca
			kist_tab_meca.clie_1 = kst_dw_guida_estrazione.id_cliente
			k_codice_x = kst_dw_guida_estrazione.output

			this.setitem(1, "id_meca", kist_tab_meca.id)
					
		end if            
		
		u_retrieve_dw_lista()
		
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	
end try


end event

event dw_guida::ue_retrieve_dinamico;call super::ue_retrieve_dinamico;//---	
//--- 
//---
if k_campo = "flag_sino" then //and (dw_guida.getitemstring(1, "codice") > " " or dw_lista_0.rowcount( ) > 0) then
	
	this.post event ue_buttonclicked()
	
end if

end event

type dw_data from uo_d_std_1 within w_convalida
integer x = 2651
integer y = 260
integer width = 827
integer height = 492
integer taborder = 70
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Data Lotto dal"
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
	
	this.accepttext( )
	ki_data_int_da  = this.getitemdate( 1, "kdata")

	//inizializza()
	dw_guida.event ue_buttonclicked( )

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
	k_rc = this.setitem(1, "kdata", ki_data_int_da)
	this.visible = true
	this.setfocus()
end event

event u_pigiato_enter;call super::u_pigiato_enter;//
	this.visible = false
	
	ki_data_int_da  = this.getitemdate( 1, "kdata")
	//inizializza()
	dw_guida.event ue_buttonclicked( )


end event

