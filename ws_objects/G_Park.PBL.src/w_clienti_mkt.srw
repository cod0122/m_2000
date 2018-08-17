$PBExportHeader$w_clienti_mkt.srw
forward
global type w_clienti_mkt from w_g_tab0
end type
type dw_xplistbar from u_dw_xplistbar within w_clienti_mkt
end type
type dw_mkt from uo_d_std_1 within w_clienti_mkt
end type
type dw_web from uo_d_std_1 within w_clienti_mkt
end type
end forward

global type w_clienti_mkt from w_g_tab0
integer width = 768
integer height = 524
long backcolor = 16711680
dw_xplistbar dw_xplistbar
dw_mkt dw_mkt
dw_web dw_web
end type
global w_clienti_mkt w_clienti_mkt

type variables
//
//
private kuf_clienti kiuf_clienti

private boolean ki_primo_giro=true

//--- indice delle VOCI dentro alla XpListBar
private int ki_xpl_Contatti = 0
private int ki_xpl_Potenziali = 0
private int ki_xpl_Potenziali_contattatto = 0
private int ki_xpl_Attivi_parziali = 0
private int ki_xpl_Attivi = 0
private int ki_xpl_Chiuso = 0
private int ki_xpl_Tutti = 0
private int ki_xplistbar_riga_INFO=0
private int ki_xplistbar_riga_lotto=0
private int ki_xplistbar_riga_fatt=0
private int ki_xplistbar_riga_sped=0
private int ki_xplistbar_riga_certif=0

private int ki_xpl_SCELTA = 0 // la voce scelta
private int ki_xpl_SCELTA_info = 0 // la voce scelta

//--- array da mettere xpListaBar nella sezione INFO
private  long ki_xplistbar_info_num[10 to 30]
private  date ki_xplistbar_info_data[10 to 30]

//--- x eitare di leggere le DW ad ogni cambio riga ma solo quando si 'sosta'
private time ki_time_riga
private long ki_id_cliente_letto_mkt=0
private long ki_id_cliente_letto_web=0
private long ki_id_cliente_letto_INFO=0
private long ki_time_riga_letta=0
//--- x rileggere la finstra di elenco dopo un tot che non si fa nulla
private time ki_time_rileggi_auto 

//--- x test sulla dimensione delle DW
private boolean k_dw_mkt_sized_icon = false
private boolean k_dw_web_sized_icon = false


end variables

forward prototypes
private subroutine call_anteprima ()
private subroutine call_elenco_capitolati ()
private subroutine call_elenco_contratti ()
private subroutine call_elenco_fatture ()
private subroutine call_elenco_listino ()
private subroutine call_elenco_stat_fatt ()
protected subroutine attiva_menu ()
protected function string inizializza () throws uo_exception
public subroutine leggi_dw_dettaglio ()
private subroutine ripristina_ult_uscita ()
private subroutine salva_impostazioni ()
protected subroutine open_start_window ()
protected subroutine smista_funz (string k_par_in)
protected subroutine cancella_cliente ()
protected subroutine attiva_tasti ()
private subroutine call_memo ()
protected function string inizializza_post ()
end prototypes

private subroutine call_anteprima ();//
boolean k_call=false
st_tab_meca kst_tab_meca
st_tab_arfa kst_tab_arfa
st_tab_sped kst_tab_sped 
st_tab_certif kst_tab_certif
st_open_w kst_open_w
st_esito kst_esito
kuf_fatt kuf1_fatt
kuf_armo kuf1_armo
kuf_sped kuf1_sped
kuf_certif kuf1_certif
kuf_menu_window kuf1_menu_window
uo_exception kuo_exception 


if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore

try
	choose case ki_xpl_SCELTA_info 
			
		case ki_xplistbar_riga_lotto
			kdsi_elenco_output.reset( )
			kuf1_armo = create kuf_armo
			kst_tab_meca.id = ki_xplistbar_info_num[ki_xplistbar_riga_lotto]
			if kst_tab_meca.id > 0 then
				k_call=true
				kst_esito = kuf1_armo.anteprima_testa ( kdsi_elenco_output, kst_tab_meca )
				destroy kuf1_armo
				if kst_esito.esito <> kkg_esito_ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito)
					throw kuo_exception
				end if
				kst_open_w.key1 = "Dettaglio del Lotto (id=" + trim(string(kst_tab_meca.id))  + ") "
			end if

		case ki_xplistbar_riga_fatt
			kdsi_elenco_output.reset( )
			kuf1_fatt = create kuf_fatt
			kst_tab_arfa.id_fattura = ki_xplistbar_info_num[ki_xplistbar_riga_fatt]
			if kst_tab_arfa.id_fattura > 0 then
				k_call=true
				kst_esito = kuf1_fatt.anteprima( kdsi_elenco_output, kst_tab_arfa )
				destroy kuf1_fatt
				if kst_esito.esito <> kkg_esito_ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito)
					throw kuo_exception
				end if
				kst_open_w.key1 = "Documento di Vendita (id=" + trim(string(kst_tab_arfa.id_fattura))  + ") "
			end if

		case ki_xplistbar_riga_sped
			kdsi_elenco_output.reset( )
			kuf1_sped = create kuf_sped
			kst_tab_sped.num_bolla_out = ki_xplistbar_info_num[ki_xplistbar_riga_sped]
			kst_tab_sped.data_bolla_out = ki_xplistbar_info_data[ki_xplistbar_riga_sped]
			if kst_tab_sped.num_bolla_out > 0 then
				k_call=true
				kst_esito = kuf1_sped.anteprima( kdsi_elenco_output, kst_tab_sped )
				destroy kuf1_sped
				if kst_esito.esito <> kkg_esito_ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito)
					throw kuo_exception
				end if
				kst_open_w.key1 = "Documento di Trasporto (num.=" + trim(string(kst_tab_sped.num_bolla_out))  + ") "
			end if

		case ki_xplistbar_riga_certif
			kdsi_elenco_output.reset( )
			kuf1_certif = create kuf_certif
			kst_tab_certif.num_certif = ki_xplistbar_info_num[ki_xplistbar_riga_certif]
			if kst_tab_certif.num_certif > 0 then
				k_call=true
				kst_esito = kuf1_certif.anteprima( kdsi_elenco_output, kst_tab_certif )
				destroy kuf1_certif
				if kst_esito.esito <> kkg_esito_ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito)
					throw kuo_exception
				end if
				kst_open_w.key1 = "Attestato (num=" + trim(string(kst_tab_certif.num_certif))  + ") "
			end if

	end choose
//			kuf1_barcode = create kuf_barcode
//			kst_esito = kuf1_barcode.anteprima ( kdsi_elenco_output, kst_tab_barcode )
//			destroy kuf1_barcode
//			if kst_esito.esito <> kkg_esito_ok then
//				kuo_exception = create uo_exception
//				kuo_exception.set_esito( kst_esito)
//				throw kuo_exception
//			end if
//			kst_open_w.key1 = "Dettaglio Barcode : " + trim(string(kst_tab_barcode.barcode,"@@@ @@@@@@@@@")) 
//

//
	if kdsi_elenco_output.rowcount() > 0 then
	
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.id_programma =kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita_elenco
		kst_open_w.flag_adatta_win = KK_ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kuf1_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window


	else
		
		messagebox("Elenco Dati", 	"Nessun valore disponibile. ")
		
	end if


catch (uo_exception kuo_exception1)
	kuo_exception1.messaggio_utente()
	
end try


end subroutine

private subroutine call_elenco_capitolati ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if dw_lista_0.getrow() > 0 then

	k_id_cliente = dw_lista_0.getitemnumber( dw_lista_0.getrow(), "id_cliente") 


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

		K_st_open_w.id_programma = kkg_id_programma_sc_cf
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "  "
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = "*" // flag attivi
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_contratti ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if dw_lista_0.getrow() > 0 then

	k_id_cliente = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_cliente") 


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

		K_st_open_w.id_programma = kkg_id_programma_contratti
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "  "
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = " " // sl-pt
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_fatture ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if dw_lista_0.getrow() > 0 then

	k_id_cliente = dw_lista_0.getitemnumber( dw_lista_0.getrow(), "id_cliente") 

//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_fatture_elenco
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita_elenco
	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
	K_st_open_w.key2 = " "  //data da  
	K_st_open_w.key3 = " "  //data a
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_listino ();//
string k_where
long k_id_cliente
string k_stato, k_tipo
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if dw_lista_0.getrow() > 0 then

	k_id_cliente = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_cliente") 


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=vedi sotto

		K_st_open_w.id_programma = kkg_id_programma_listini_l
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = "  "
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = " " // cod articolo 
		K_st_open_w.key3 = " " // dose
		K_st_open_w.key4 = " " // misure imballo
		K_st_open_w.key5 = " " // misure imballo
		K_st_open_w.key6 = " " // misure imballo
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if


end subroutine

private subroutine call_elenco_stat_fatt ();//
string k_anno
long k_id_cliente
kuf_base kuf1_base
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


if dw_lista_0.getrow() > 0 then


	k_id_cliente = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_cliente") 

	k_anno = string(year(kg_dataoggi))
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

	K_st_open_w.id_programma =kkg_id_programma_stat_fatt
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = "sk"
	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
	K_st_open_w.flag_leggi_dw = "N"
	K_st_open_w.flag_cerca_in_lista = "1"
	K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
	K_st_open_w.key2 = "0000000000"  //dose
	K_st_open_w.key3 = "0000000000"  //id gruppo
	K_st_open_w.key4 = "01/01/" + k_anno  //data da
	K_st_open_w.key5 = "31/12/" + k_anno //data a
	K_st_open_w.key6 = " " 
	K_st_open_w.key7 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")

end if




end subroutine

protected subroutine attiva_menu ();//
boolean k_insert = true
//

this.setredraw( false )

//--- Attiva/Dis. Voci di menu
	super::attiva_menu()

	if ki_st_open_w.flag_modalita = kkg_flag_modalita_inserimento then
		k_insert = false
	end if

	
//
//--- Attiva/Dis. Voci di menu personalizzate
//
	kG_menu.m_strumenti.m_fin_gest_libero1.text = "Capitolati per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
   "Capitolato,Elenco Capitolati per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero1.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.enabled = k_insert
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText =  "Capitolati,Elenco Capitolati per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom004!"
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero2.text = "Elenco Contratti per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero2.microhelp = &
   "Contratti,Elenco Contratti per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero2.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero2.enabled = k_insert
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText =  "Contratti,Elenco Contratti per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "DataWindow!"
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero3.text = "Elenco Listini dell'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero3.microhelp = &
   "Listini,Elenco Listini dell'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero3.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero3.enabled = k_insert
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Listini,Elenco Listini dell'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "FormatDollar!"
	kG_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero4.text = "Elenco documenti di vendita "
	kG_menu.m_strumenti.m_fin_gest_libero4.microhelp = &
	"Fatture, Elenco documenti di vendita  "
	kG_menu.m_strumenti.m_fin_gest_libero4.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero4.enabled = k_insert
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = "Fatture, Elenco documenti di vendita  "
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName =kg_path_risorse +  "\fattura16x16.gif"
	kG_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2

	kG_menu.m_strumenti.m_fin_gest_libero8.text = "Estrazione statistico di magazzino per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero8.microhelp = &
   "Stat.Fatt,Estrazione statistico di magazzino per l'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero8.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero8.enabled = k_insert
	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemText =  "Stat.Fat,Estrazione statistico di magazzino dell'anagrafica selezionata"
	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritemName = "Graph!"
	kG_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2

	this.setredraw( true )

end subroutine

protected function string inizializza () throws uo_exception;//
st_tab_clienti kst_tab_clienti
pointer oldpointer  // Declares a pointer variable




//--- se Ptimo giro ripristina come l'ulima uscita
	if ki_primo_giro then
		
//=== Puntatore Cursore da attesa.....
		oldpointer = SetPointer(HourGlass!)

		kst_tab_clienti.tipo = trim(ki_st_open_w.key1)
		kst_tab_clienti.stato = trim(ki_st_open_w.key2)
	
		if isnull(ki_st_open_w.key1) or trim(ki_st_open_w.key1) = "*" or Len(trim(ki_st_open_w.key1)) = 0 then
			kst_tab_clienti.tipo = "%"
		end if
		if isnull(ki_st_open_w.key2) or trim(ki_st_open_w.key2) = "*" or Len(trim(ki_st_open_w.key2)) = 0 then
			kst_tab_clienti.stato = "%"
		end if
	
		dw_lista_0.event set_titolo( )
		
		dw_lista_0.retrieve(kst_tab_clienti.tipo, kst_tab_clienti.stato)

		SetPointer(oldpointer)
	end if


return "0"

end function

public subroutine leggi_dw_dettaglio ();//
//--- legge le dw di dettaglio
//
long k_riga=0
string k_lotto='', k_lotto_pic='', k_fatt='', k_fatt_pic='', k_sped='', k_sped_pic='', k_certif='', k_certif_pic=''
st_esito kst_esito
st_tab_clienti kst_tab_clienti
st_tab_meca kst_tab_meca
st_tab_arfa kst_tab_arfa
st_tab_sped kst_tab_sped 
st_tab_certif kst_tab_certif
kuf_fatt kuf1_fatt
kuf_armo kuf1_armo
kuf_sped kuf1_sped
kuf_certif kuf1_certif
pointer oldpointer  // Declares a pointer variable




if dw_lista_0.getselectedrow(0) > 0 then
		
	kst_tab_clienti.codice = dw_lista_0.getitemnumber(dw_lista_0.getselectedrow(0), "id_cliente")
	if ki_id_cliente_letto_web <> kst_tab_clienti.codice or ki_id_cliente_letto_mkt <> kst_tab_clienti.codice then
//	if ki_time_riga_letta <> dw_lista_0.getselectedrow(0) then
		
		ki_time_riga_letta = dw_lista_0.getselectedrow(0)
		
		oldpointer = SetPointer(HourGlass!)
		
	
		if NOT k_dw_mkt_sized_icon and ki_id_cliente_letto_mkt <> kst_tab_clienti.codice then
			dw_mkt.title = " Dati Marketing di " +  string (kst_tab_clienti.codice) 
			ki_id_cliente_letto_mkt = kst_tab_clienti.codice
			dw_mkt.retrieve(kst_tab_clienti.codice)  // legge i dati di MKT
		end if
		
		if NOT k_dw_web_sized_icon and ki_id_cliente_letto_web <> kst_tab_clienti.codice then
			dw_web.title = " Dati Web di " +  string (kst_tab_clienti.codice) 
			ki_id_cliente_letto_web = kst_tab_clienti.codice
			dw_web.retrieve(kst_tab_clienti.codice) // legge i dati WEB
		end if

		SetPointer(oldpointer)

	end if

	if NOT dw_xplistbar.of_iffilter( ki_xplistbar_riga_INFO) then //--- se non è un ramo collassato allora leggo
		if ki_id_cliente_letto_INFO <> kst_tab_clienti.codice then
			ki_id_cliente_letto_INFO = kst_tab_clienti.codice

			oldpointer = SetPointer(HourGlass!)
			
			kuf1_fatt = create kuf_fatt
			kuf1_armo = create kuf_armo
			kuf1_sped = create kuf_sped
			kuf1_certif = create kuf_certif
	
	//--- piglia i dati dell'ultimo lotto		
			kst_tab_meca.clie_1 = kst_tab_clienti.codice
			kst_tab_meca.clie_2 = kst_tab_clienti.codice
			kst_tab_meca.clie_3 = kst_tab_clienti.codice
			kst_esito = kuf1_armo.get_ultimo_doc_ins(kst_tab_meca)
			if kst_esito.esito = kkg_esito_ok then
				ki_xplistbar_info_num[ki_xplistbar_riga_lotto] = kst_tab_meca.id
				if kst_tab_meca.id > 0 then
					k_lotto = "Ult. Lotto: ~r" + string(kst_tab_meca.num_int) + "  " +string(kst_tab_meca.data_int, "dd/mm/yy")
					k_lotto_pic = 'molletta.gif'
				end if
			end if
			
	//--- piglia i dati dell'ultimo d.d.t.		
			kst_tab_sped.clie_2 = kst_tab_clienti.codice
			kst_esito = kuf1_sped.get_ultimo_doc(kst_tab_sped)
			if kst_esito.esito = kkg_esito_ok then
				ki_xplistbar_info_num[ki_xplistbar_riga_sped] = kst_tab_sped.num_bolla_out 
				ki_xplistbar_info_data[ki_xplistbar_riga_sped] = kst_tab_sped.data_bolla_out 
				if kst_tab_sped.num_bolla_out > 0 then
					k_sped = "Ult. Spedizione: ~r" + string(kst_tab_sped.num_bolla_out) + "  " +string(kst_tab_sped.data_bolla_out, "dd/mm/yy")
					k_sped_pic = 'molletta.gif'
				end if
			end if
			
	//--- piglia i dati dell'ultima fattura		
			kst_tab_arfa.clie_3 = kst_tab_clienti.codice
			kst_esito = kuf1_fatt.get_ultimo_doc_ins(kst_tab_arfa)
			if kst_esito.esito = kkg_esito_ok then
				ki_xplistbar_info_num[ki_xplistbar_riga_fatt] = kst_tab_arfa.id_fattura
				if kst_tab_arfa.id_fattura > 0 then
					k_fatt = "Ult. Fatttura: ~r" + string(kst_tab_arfa.num_fatt ) + "  " +string(kst_tab_arfa.data_fatt, "dd/mm/yy")
					k_fatt_pic = 'molletta.gif'
				end if
			end if
	
	//--- piglia i dati dell'ultimo attestato		
			kst_tab_certif.clie_2 = kst_tab_clienti.codice
			kst_esito = kuf1_certif.get_ultimo_doc_ins(kst_tab_certif)
			if kst_esito.esito = kkg_esito_ok then
				ki_xplistbar_info_num[ki_xplistbar_riga_certif] = kst_tab_certif.num_certif
				if kst_tab_certif.id > 0 then
					k_certif = "Ult. Attestato: ~r" + string(kst_tab_certif.num_certif ) + "  " +string(kst_tab_certif.data, "dd/mm/yy")
					k_certif_pic = 'molletta.gif'
				end if
			end if
			
			destroy kuf1_fatt 
			destroy kuf1_armo 
			destroy kuf1_sped 
			destroy kuf1_certif
	
	//--- set dei valori nella xp-listbar
			dw_xplistbar.setredraw( false)
			dw_xplistbar.of_setitem( ki_xplistbar_riga_info, " Info di " + string(kst_tab_clienti.codice), "")
			dw_xplistbar.of_setitem( ki_xplistbar_riga_lotto, k_lotto, k_lotto_pic)
			dw_xplistbar.of_setitem( ki_xplistbar_riga_sped, k_sped, k_sped_pic)
			dw_xplistbar.of_setitem( ki_xplistbar_riga_fatt, k_fatt, k_fatt_pic)
			dw_xplistbar.of_setitem( ki_xplistbar_riga_certif, k_certif, k_certif_pic)
			dw_xplistbar.setredraw( true)
		end if	
	
		SetPointer(oldpointer)
		
	end if
	dw_lista_0.setfocus( )
		
else
	dw_mkt.title = " Nessun dato Marketing presente " 
	dw_web.title = " Nessun dato Web presente "
	dw_mkt.reset( )
	dw_web.reset()
	ki_xplistbar_info_num[ki_xplistbar_riga_lotto] = 0 
	ki_xplistbar_info_num[ki_xplistbar_riga_sped] = 0  
	ki_xplistbar_info_data[ki_xplistbar_riga_sped] = date(0) 
	ki_xplistbar_info_num[ki_xplistbar_riga_fatt] = 0
	ki_xplistbar_info_num[ki_xplistbar_riga_certif] = 0
//--- set dei valori nella xp-listbar
	dw_xplistbar.setredraw( false)
	dw_xplistbar.of_setitem( ki_xplistbar_riga_info, " Info  ", "")
	dw_xplistbar.of_setitem( ki_xplistbar_riga_lotto, k_lotto, k_lotto_pic)
	dw_xplistbar.of_setitem( ki_xplistbar_riga_sped, k_sped, k_sped_pic)
	dw_xplistbar.of_setitem( ki_xplistbar_riga_fatt, k_fatt, k_fatt_pic)
	dw_xplistbar.of_setitem( ki_xplistbar_riga_certif, k_certif, k_certif_pic)
	dw_xplistbar.setredraw( true)
end if
	

end subroutine

private subroutine ripristina_ult_uscita ();//---
//--- Recupera le impostazioni dell'ultima chiusura della finestra e le ripropone
//---
string k_rcx
st_profilestring_ini kst_profilestring_ini


//--- Ripri il numero il tipo di richiesta in cui è attivo
		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.nome = trim(kiw_this_window.classname()) + "_" + "setRigaXpListBar"
		k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))

		if isnumber(trim(kst_profilestring_ini.valore)) then
			dw_xplistbar.setrow(integer(trim(kst_profilestring_ini.valore)))
			dw_xplistbar.event ue_clicked(integer (trim(kst_profilestring_ini.valore))) //lancia inizializza()
	
//--- Ripri il numero di riga in cui è
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.nome = trim(kiw_this_window.classname()) + "_" + "setRigaDwAnagrafe"
			k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
		
//			kst_profilestring_ini.valore = String(dw_anagrafe.getselectedrow(0))
			if isnumber(trim(kst_profilestring_ini.valore)) then
				if long(trim(kst_profilestring_ini.valore)) > 0 then
					dw_lista_0.selectrow(0, false)
					dw_lista_0.selectrow(long (trim(kst_profilestring_ini.valore)), true)
					if dw_lista_0.rowcount( ) > long (trim(kst_profilestring_ini.valore)) then
						dw_lista_0.scrolltorow((long (trim(kst_profilestring_ini.valore)) - 4))
					end if
				end if
			end if
				
		end if


end subroutine

private subroutine salva_impostazioni ();//---
//--- Salva le impostazioni della finestra così da riproporle in prx open
//---
string k_rcx
st_profilestring_ini kst_profilestring_ini


//--- salva il numero il tipo di richiesta in cui è attivo
		kst_profilestring_ini.operazione = "2"
		kst_profilestring_ini.valore = String(ki_xpl_SCELTA)
		kst_profilestring_ini.nome = trim(kiw_this_window.classname()) + "_" + "setRigaXpListBar"
		k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
	
//--- salva il numero di riga in cui è
		kst_profilestring_ini.operazione = "2"
		kst_profilestring_ini.valore = String(dw_lista_0.getselectedrow(0))
		kst_profilestring_ini.nome = trim(kiw_this_window.classname()) + "_" + "setRigaDwAnagrafe"
		k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
	

end subroutine

protected subroutine open_start_window ();//
	kiuf_clienti = create kuf_clienti
	
	ki_trova_campo_def = 2 // setta il campo di default x il TROVA

//	this.tab_1.tabpage_1.picturename = kg_path_risorse + "\" + "cliente.gif"

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

	case "l1"		//Contratti...
		call_elenco_capitolati()

	case "l2"		//Contratti...
		call_elenco_contratti()

	case "l3"		//Listino...
		call_elenco_listino()

	case "l4"		//Fatture...
		call_elenco_fatture()

	case "l8"		//Statistica...
		call_elenco_stat_fatt()



	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

protected subroutine cancella_cliente ();//
string k_rag_soc
long k_id_cliente
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
kuf_clienti  kuf1_clienti  


k_riga = dw_lista_0.getrow()	
if k_riga > 0 then
	k_rag_soc = dw_lista_0.getitemstring(k_riga, "rag_soc_1")
	k_id_cliente = dw_lista_0.getitemnumber(k_riga, "id_cliente")

	if isnull(k_rag_soc) = true or trim(k_rag_soc) = "" then
		k_rag_soc = "Anagrafica Senza Ragione Sociale" 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina Anagrafica", "Sei sicuro di voler Cancellare : ~n~r" + k_rag_soc, &
				question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_clienti = create kuf_clienti
		
//=== Cancella la riga dal data windows di lista
		k_errore = kuf1_clienti.tb_delete(k_id_cliente) 
		if LeftA(k_errore, 1) = "0" then
	
			k_errore = kuf1_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + MidA(k_errore, 2))

			else

				dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
				dw_lista_0.deleterow(k_riga)

			end if

			dw_lista_0.setfocus()

		else
			k_errore1 = k_errore
			k_errore = kuf1_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							MidA(k_errore1, 2) ) 	
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
						"Controllare i dati. " + MidA(k_errore, 2))
			end if

	
			attiva_tasti()

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_clienti

	else
		messagebox("Elimina Anagrafica", "Operazione Annullata !!")

	end if
end if

end subroutine

protected subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================
long k_nr_righe


super::attiva_tasti()

cb_ritorna.enabled = true
cb_inserisci.enabled = true
cb_visualizza.enabled = true
st_aggiorna_lista.enabled = true

//cb_aggiorna.enabled = false
cb_modifica.enabled = false
cb_cancella.enabled = false


//=== Nr righe nel DW lista
if dw_lista_0.rowcount ( ) > 0 then
	cb_modifica.enabled = true
	cb_cancella.enabled = true
end if

            
attiva_menu()


end subroutine

private subroutine call_memo ();//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
st_tab_clienti_memo kst_tab_clienti_memo 
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	kst_tab_clienti_memo.id_memo = dw_lista_0.getitemnumber( k_riga, "id_memo" ) 
	kst_tab_clienti_memo.id_cliente = dw_lista_0.getitemnumber( k_riga, "id_cliente" ) 
		
	if kst_tab_clienti_memo.id_cliente  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli;

		K_st_open_w.id_programma = kkg_id_programma_anag_memo
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita_modifica
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = string(kst_tab_clienti_memo.id_memo)
		K_st_open_w.key2 = string(kst_tab_clienti_memo.id_cliente)
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
		
	end if
end if
	




end subroutine

protected function string inizializza_post ();//
ki_primo_giro=false

post ripristina_ult_uscita()
		
//--- chiude il ramo "INFO"  	
dw_xplistbar.trigger Event ue_clicked_0(ki_xplistbar_riga_INFO, "") 
	

return "0"
end function

on w_clienti_mkt.create
int iCurrent
call super::create
this.dw_xplistbar=create dw_xplistbar
this.dw_mkt=create dw_mkt
this.dw_web=create dw_web
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_xplistbar
this.Control[iCurrent+2]=this.dw_mkt
this.Control[iCurrent+3]=this.dw_web
end on

on w_clienti_mkt.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_xplistbar)
destroy(this.dw_mkt)
destroy(this.dw_web)
end on

event resize;int k_dist_bordi, k_spess_bordi_x, k_spess_bordi_y

	if sizetype = 0 or isnull(sizetype) then		
		
//		if isnull(NewHeight) then NewHeight = this.height
//		if isnull(NewWidth) then NewWidth = this.width
		NewHeight = this.height
		NewWidth = this.width
		
		k_dist_bordi = 5
		k_spess_bordi_x = 65
		k_spess_bordi_y = 175
		
		dw_xplistbar.x = k_dist_bordi
		dw_xplistbar.y = k_dist_bordi
		dw_xplistbar.Height = NewHeight - k_spess_bordi_y //(k_dist_bordi * 4)
		dw_xplistbar.width = 891
	
		this.setredraw(false)
		
		if ki_st_open_w.flag_adatta_win = KK_ADATTA_WIN 	and not(ki_personalizza_pos_controlli) then
	
			dw_lista_0.width = newwidth - dw_xplistbar.width  - k_dist_bordi * 2 - k_spess_bordi_x 
			dw_mkt.width =dw_lista_0.width * 0.55
			dw_web.width = dw_lista_0.width - dw_mkt.width  //- k_dist_bordi * 3 - k_spess_bordi_x) * 0.45
		
			dw_lista_0.height = dw_xplistbar.Height * 0.60 
			dw_mkt.height = dw_xplistbar.Height - dw_lista_0.height -  k_dist_bordi // * 3 - k_spess_bordi_y
			dw_web.height = dw_mkt.height 
			
	//=== Posiziona dw nella window 
			dw_lista_0.x = dw_xplistbar.x +   dw_xplistbar.width + k_dist_bordi * 2
			dw_lista_0.y = dw_xplistbar.y +  k_dist_bordi 
			dw_mkt.x = dw_lista_0.x 
			dw_mkt.y = dw_lista_0.height + k_dist_bordi * 3
			dw_web.x = dw_mkt.x + dw_mkt.width + k_dist_bordi 
			dw_web.y = dw_mkt.y //dw_anagrafe.height + k_dist_bordi * 3
	
		end if
	
		this.setredraw(true)
	
	end if


end event

event close;call super::close;//--- Salva le impostazioni x poterle recuperare al prx avvio
salva_impostazioni()

if isvalid(kiuf_clienti) then destroy kiuf_clienti


end event

event timer;call super::timer;//--- rilegge automaticamente se per un tot di tempo non si fa nulla sul navigatore
if relativetime ( ki_time_rileggi_auto, 1800 ) < now() then

//---- reinizializza il timer per eventuale auto-lettura
	ki_time_rileggi_auto = now()

//--- rilegge le liste 	
	smista_funz(kkg_flag_richiesta_refresh)

else
	
	//--- rilegge automaticamente se per un tot di tempo non si fa nulla sul navigatore
	if relativetime ( ki_time_riga, 1 ) < now() then
	
	//---- reinizializza il timer per eventuale auto-lettura del dettaglio
		ki_time_riga = now()
	
	//--- rilegge le liste 	
		leggi_dw_dettaglio()
	
	end if
end if


end event

event activate;call super::activate;//---- Scatena il timer (vedi l'evento)
	timer (0.30)


end event

event deactivate;call super::deactivate;//---- Spegne il timer (vedi l'evento)
	timer (0)

end event

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_clienti_mkt
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_clienti_mkt
end type

type st_stampa from w_g_tab0`st_stampa within w_clienti_mkt
end type

type st_ritorna from w_g_tab0`st_ritorna within w_clienti_mkt
end type

type dw_trova from w_g_tab0`dw_trova within w_clienti_mkt
integer x = 1417
integer y = 1308
end type

type dw_filtra from w_g_tab0`dw_filtra within w_clienti_mkt
integer x = 599
integer y = 1412
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_clienti_mkt
end type

event cb_visualizza::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
long k_id_cliente
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_id_cliente = dw_lista_0.getitemnumber( k_riga, "id_cliente" ) 
		
	if k_id_cliente  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli;
		if dw_xplistbar.getrow( ) = ki_xpl_Contatti then 
			K_st_open_w.id_programma = kkg_id_programma_anag_rid
		else
			K_st_open_w.id_programma = kkg_id_programma_anag
		end if

		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita_visualizzazione
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = string(k_id_cliente, "0000000000")
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
		
	end if
end if
	


end event

type cb_modifica from w_g_tab0`cb_modifica within w_clienti_mkt
end type

event cb_modifica::clicked;//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
long k_id_cliente
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


k_riga = dw_lista_0.getrow()
if k_riga > 0 then

	k_id_cliente = dw_lista_0.getitemnumber( k_riga, "id_cliente" ) 
		
	if k_id_cliente  > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli;

		if dw_xplistbar.getrow( ) = ki_xpl_Contatti then 
			K_st_open_w.id_programma = kkg_id_programma_anag_rid
		else
			K_st_open_w.id_programma = kkg_id_programma_anag
		end if
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita_modifica
		K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key1 = string(k_id_cliente, "0000000000")
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
		
	end if
end if
	




end event

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_clienti_mkt
end type

type cb_cancella from w_g_tab0`cb_cancella within w_clienti_mkt
end type

event cb_cancella::clicked;//
cancella_cliente()

end event

type cb_inserisci from w_g_tab0`cb_inserisci within w_clienti_mkt
end type

event cb_inserisci::clicked;//
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli;

	if dw_xplistbar.getrow( ) = ki_xpl_Contatti then 
		K_st_open_w.id_programma = kkg_id_programma_anag_rid
	else
		K_st_open_w.id_programma = kkg_id_programma_anag
	end if

	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita_inserimento
	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
	K_st_open_w.flag_leggi_dw = "N"
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = "0000000000"
	K_st_open_w.key2 = " "
	K_st_open_w.key3 = " "
	K_st_open_w.key4 = " "
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_clienti_mkt
integer x = 1819
integer y = 1648
integer width = 722
integer height = 248
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_clienti_mkt
boolean visible = false
integer x = 1339
integer y = 756
integer width = 1307
boolean enabled = false
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_clienti_mkt
event set_titolo ( )
integer x = 992
integer y = 24
integer width = 2930
integer height = 764
boolean titlebar = true
string title = "anagrafe"
string dataobject = "d_clienti_l_mkt"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
end type

event dw_lista_0::set_titolo();//
//--- Cliccato item di dettaglio: faccio qlc
//
string k_titolo
kuf_utility kuf1_utility


	if ki_xpl_SCELTA > 0 then
		kuf1_utility = create kuf_utility
		k_titolo = kuf1_utility.u_stringa_pulisci_x_msg( dw_xplistbar.of_getItem(ki_xpl_SCELTA) )
		this.title = "Anagrafe: " + k_titolo
		destroy kuf1_utility
	end if
			


end event

event dw_lista_0::clicked;call super::clicked;//---- inizia il timer per eventuale auto-lettura
ki_time_rileggi_auto = now()
ki_time_riga = now()

if dwo.name = "id_memo" or dwo.name = "p_id_memo" or dwo.name = "p_id_memo_no" then
	call_memo()
end if


end event

event dw_lista_0::constructor;call super::constructor;//
this.ki_icona_normale = kg_path_risorse + "\" + "clienti16.gif"
this.object.p_id_memo.filename = kg_path_risorse + "\" + "edit16.gif"
this.object.p_id_memo_no.filename = kg_path_risorse + "\" + "document_new.gif"

end event

event dw_lista_0::getfocus;call super::getfocus;//---- inizia il timer per eventuale auto-lettura
ki_time_rileggi_auto = now()
ki_time_riga = now()

end event

type dw_xplistbar from u_dw_xplistbar within w_clienti_mkt
integer x = 50
integer y = 16
integer width = 891
integer height = 2332
integer taborder = 30
boolean bringtotop = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//
Long ll_parent

//Add new item
ll_parent = THIS.of_AddItem('header','Anagrafe  ',0, '')
 
ki_xpl_Contatti = THIS.of_AddItem('child','Contatti ',ll_parent, 'contatti_rubrica.gif')
ki_xpl_Potenziali = THIS.of_AddItem('child','Potenziali da~rcontattare ',ll_parent, 'cliente_potenziale.gif')
ki_xpl_Potenziali_contattatto = THIS.of_AddItem('child','Potenziali in~rcontatto ',ll_parent, 'cliente_contattato.gif')
ki_xpl_Attivi_parziali = THIS.of_AddItem('child','Attivi~rparziali ',ll_parent, 'cliente_parziale.gif')
ki_xpl_Attivi = THIS.of_AddItem('child','Attivi ~rcompleti  ',ll_parent, 'cliente_in_prod.gif')
ki_xpl_Chiuso = THIS.of_AddItem('child','Chiusi ',ll_parent, 'cliente_close.gif')
ki_xpl_Tutti = THIS.of_AddItem('child','Tutti',ll_parent, 'clienti.gif')
//THIS.of_AddItem('child','Sounds, Speech, and~rAudio Devices',ll_parent, 'sound.bmp')
THIS.of_AddItem('filler','',ll_parent, '')//filler is necessary for looks

//Add new item
ll_parent = THIS.of_AddItem('header','Info       ',0, '') 
ki_xplistbar_riga_INFO = ll_parent
ki_xplistbar_riga_lotto=THIS.of_AddItem('child',' ',ll_parent, ' ' )  // 'Ult. Lotto: ',ll_parent, ' ' )
//ki_xplistbar_riga_lotto=THIS.of_AddItem('child','-',ll_parent, '') //'molletta.gif')
ki_xplistbar_riga_fatt=THIS.of_AddItem('child',' ',ll_parent, '' ) //'Ult. Fattura: ',ll_parent, '' )
//ki_xplistbar_riga_fatt=THIS.of_AddItem('child','-',ll_parent, '') 
ki_xplistbar_riga_sped=THIS.of_AddItem('child',' ',ll_parent, '' ) //'Ult. Spedizione: ',ll_parent, '' )
//ki_xplistbar_riga_sped=THIS.of_AddItem('child','-',ll_parent, '') 
ki_xplistbar_riga_certif=THIS.of_AddItem('child',' ',ll_parent, '' ) //'Ult. Attestato: ',ll_parent, '' )
//ki_xplistbar_riga_certif=THIS.of_AddItem('child','-',ll_parent, '') 

//private int =0
//private int =0

//THIS.of_AddItem('child','Contratti',ll_parent, 'help.bmp')
//THIS.of_AddItem('child','Capitolati',ll_parent, 'help.bmp')
//THIS.of_AddItem('child','Movimenti',ll_parent, 'help.bmp')
THIS.of_AddItem('filler','',ll_parent, '')//filler is necessary for looks
end event

event getfocus;call super::getfocus;//---- inizia il timer per eventuale auto-lettura
ki_time_riga = now()
ki_time_rileggi_auto = now()

end event

event ue_clicked;call super::ue_clicked;//
//--- Cliccato item di dettaglio: faccio qlc
//

try
	
	
	choose case kriga
			
		case ki_xpl_Contatti
			ki_xpl_SCELTA = kriga
			ki_st_open_w.key1 = kiuf_clienti.kki_tipo_contatto
			ki_st_open_w.key2 = ""
			inizializza()
			
		case ki_xpl_Potenziali
			ki_xpl_SCELTA = kriga
			ki_st_open_w.key1 = "" 
			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_potenziale_da_contattare 
			inizializza()
			
		case ki_xpl_Potenziali_contattatto
			ki_xpl_SCELTA = kriga
			ki_st_open_w.key1 = "" 
			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_potenziale_in_contatto 
			inizializza()
			
		case ki_xpl_Attivi_parziali
			ki_xpl_SCELTA = kriga
			ki_st_open_w.key1 = "" 
			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_attivo_parziale
			inizializza()
			
		case ki_xpl_Attivi
			ki_xpl_SCELTA = kriga
			ki_st_open_w.key1 = "" //kiuf_clienti.kki_tipo_fatturato
			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_attivo
			inizializza()
			
		case ki_xpl_Chiuso
			ki_xpl_SCELTA = kriga
			ki_st_open_w.key1 = "" //kiuf_clienti.kki_tipo_fatturato
			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_estinto 
			inizializza()
			
		case ki_xpl_Tutti
			ki_xpl_SCELTA = kriga
			ki_st_open_w.key1 = ""
			ki_st_open_w.key2 = ""
			inizializza()

		case 0
			ki_xpl_SCELTA = 0
			ki_st_open_w.key1 = ""
			ki_st_open_w.key2 = ""
			inizializza()
			
		case ki_xplistbar_riga_lotto & 
			,ki_xplistbar_riga_fatt &
			,ki_xplistbar_riga_sped &
			,ki_xplistbar_riga_certif 
			ki_xpl_SCELTA_info = kriga
			call_anteprima()
			
		case else
			ki_xpl_SCELTA = 0
			ki_st_open_w.key1 = ""
			ki_st_open_w.key2 = ""
			inizializza()
			
	end choose

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()	

end try

end event

event ue_clicked_0;call super::ue_clicked_0;//
if ki_xplistbar_riga_INFO = row then
	ki_id_cliente_letto_INFO = 0
end if

end event

type dw_mkt from uo_d_std_1 within w_clienti_mkt
event pbm_dwnresize pbm_dwnresize
boolean visible = true
integer x = 983
integer y = 860
integer width = 1577
integer height = 1472
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "dati Marketing"
string dataobject = "d_clienti_mkt_1"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = false
end type

event pbm_dwnresize;//
if sizetype = 1 then
	k_dw_mkt_sized_icon = true
else
	k_dw_mkt_sized_icon = false
end if


end event

event clicked;call super::clicked;//---- inizia il timer per eventuale auto-lettura
ki_time_rileggi_auto = now()
ki_time_riga = now()

end event

event getfocus;call super::getfocus;//---- inizia il timer per eventuale auto-lettura
ki_time_rileggi_auto = now()
ki_time_riga = now()

end event

event scrollvertical;call super::scrollvertical;//
ki_time_riga = now()

end event

type dw_web from uo_d_std_1 within w_clienti_mkt
event pbm_dwnresize pbm_dwnresize
boolean visible = true
integer x = 2848
integer y = 864
integer width = 1339
integer height = 1472
integer taborder = 40
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "dati Web"
string dataobject = "d_clienti_web_1"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = false
end type

event pbm_dwnresize;//
if sizetype = 1 then
	k_dw_mkt_sized_icon = true
else
	k_dw_mkt_sized_icon = false
end if


end event

event clicked;call super::clicked;//---- inizia il timer per eventuale auto-lettura
ki_time_rileggi_auto = now()
ki_time_riga = now()

end event

event getfocus;call super::getfocus;//---- inizia il timer per eventuale auto-lettura
ki_time_rileggi_auto = now()
ki_time_riga = now()

end event

