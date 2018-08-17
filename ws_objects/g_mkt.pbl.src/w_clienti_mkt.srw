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
type dw_xplistbar_info from u_dw_xplistbar within w_clienti_mkt
end type
type dw_xplistbar_trova from u_dw_trova within w_clienti_mkt
end type
end forward

global type w_clienti_mkt from w_g_tab0
integer width = 2981
integer height = 2316
string icon = "C:\GAMMARAD\PB_GMMRD11\ICONE\mkt_icona.ico"
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
dw_xplistbar dw_xplistbar
dw_mkt dw_mkt
dw_web dw_web
dw_xplistbar_info dw_xplistbar_info
dw_xplistbar_trova dw_xplistbar_trova
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
private int ki_xpl_Sospesi = 0
private int ki_xpl_Tutti = 0
private int ki_xplistbar_riga_INFO=0
private int ki_xplistbar_riga_TROVA=0
private int ki_xplistbar_riga_lotto=0
private int ki_xplistbar_riga_fatt=0
private int ki_xplistbar_riga_sped=0
private int ki_xplistbar_riga_certif=0

private int ki_xpl_SCELTA = 0 // la voce scelta
private int ki_xpl_SCELTA_info = 0 // la voce scelta

//--- array da mettere xpListaBar nella sezione INFO
private  long ki_xplistbar_info_num[1 to 20]
private  date ki_xplistbar_info_data[1 to 20]

//--- x eitare di leggere le DW ad ogni cambio riga ma solo quando si 'sosta~'
private time ki_time_riga
private long ki_id_cliente_letto_mkt=0
private long ki_id_cliente_letto_web=0
private long ki_id_cliente_letto_INFO=0
private long ki_id_cliente_letto_TROVA=0
private long ki_time_riga_letta=0
//--- x rileggere la finstra di elenco dopo un tot che non si fa nulla
private time ki_time_rileggi_auto 

//--- x test sulla dimensione delle DW
private boolean k_dw_mkt_sized_icon = false
private boolean k_dw_web_sized_icon = false

//--- DW query ORIGINARIA x poter aggiungere il TROVA di volta in volta 
private string ki_sqlsyntax_origine=""
private string ki_sqlsyntax_origine_contatti=""

//--- Tipologia dell'estrazione
st_tab_clienti kist_tab_clienti

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
protected function string inizializza_post ()
private subroutine call_nuovo_anag (string k_id_programma)
protected function string leggi_liste ()
public subroutine lancia_ricerca_valore (string k_par_valore)
private subroutine call_memo ()
public function long u_retrieve ()
public subroutine u_timer ()
protected subroutine attiva_tasti_0 ()
public subroutine u_obj_visible_0 ()
public function boolean u_resize_predefinita ()
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
				if kst_esito.esito <> kkg_esito.ok then
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
				if kst_esito.esito <> kkg_esito.ok then
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
				if kst_esito.esito <> kkg_esito.ok then
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
				if kst_esito.esito <> kkg_esito.ok then
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
//			if kst_esito.esito <> kkg_esito.ok then
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
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
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
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
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
//kuf_menu_window kuf1_menu_window


if dw_lista_0.getrow() > 0 then

	k_id_cliente = dw_lista_0.getitemnumber(dw_lista_0.getrow(), "id_cliente") 


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli; key2=cod sl-pt

		K_st_open_w.id_programma = kkg_id_programma_contratti_generali_l
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.elenco
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = "N"
		K_st_open_w.flag_cerca_in_lista = "1"
		K_st_open_w.key1 = string(k_id_cliente, "0000000000") // cod cliente
		K_st_open_w.key2 = " " // sl-pt
		K_st_open_w.key3 = " "
		K_st_open_w.key4 = " "
		K_st_open_w.flag_where = " "
		
//		kuf1_menu_window = create kuf_menu_window 
		kGuf_menu_window.open_w_tabelle(k_st_open_w)
//		destroy kuf1_menu_window
								
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
	K_st_open_w.flag_modalita = kkg_flag_modalita.elenco
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
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
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
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
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
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


//--- se sono già visualizzate non ci ripasso...
	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then 

//
//--- Attiva/Dis. Voci di menu personalizzate
//
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Capitolati per l'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Capitolato,Elenco Capitolati per l'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText =  "Capit.,Elenco Capitolati per l'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom004!"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Elenco Contratti per l'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = "Contr.,Elenco Contratti per l'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText =  "Contratti,Elenco Contratti per l'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "DataWindow!"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero3.text = "Elenco Listini dell'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero3.microhelp = "Listini,Elenco Listini dell'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero3.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemText = "Listini,Elenco Listini dell'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName = "FormatDollar!"
		ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero4.text = "Elenco documenti di vendita "
		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp = "Fatture, Elenco documenti di vendita  "
		ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = "Fatture, Elenco documenti di vendita  "
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName ="fattura16x16.gif"
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName =kGuo_path.get_risorse() +  "\fattura16x16.gif"
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero5.text = "Nuovo Contatto "
		ki_menu.m_strumenti.m_fin_gest_libero5.microhelp = "Contatto, Nuovo Contatto  "
		ki_menu.m_strumenti.m_fin_gest_libero5.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero5.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible = false
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemText = "Cont.,Carica nuovo Contatto"
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName = "contatti_rubrica_nuovo.gif"
//		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName = kGuo_path.get_risorse() +  "\contatti_rubrica_nuovo.gif"
		ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritembarindex=2
	
		ki_menu.m_strumenti.m_fin_gest_libero8.text = "Estrazione statistico di magazzino per l'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero8.microhelp = "Stat.Fatt,Estrazione statistico di magazzino per l'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero8.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero8.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemText =  "Stat.Fat,Estrazione statistico di magazzino dell'anagrafica selezionata"
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemName = "Graph!"
		ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2

	end if
	
//--- Attiva/Dis. Voci di menu
	super::attiva_menu()
	
end subroutine

protected function string inizializza () throws uo_exception;//



//--- se Primo giro esegue prima il ripristina (inizializza_post) come l'ultima uscita
	if not ki_primo_giro then
		
//=== Puntatore Cursore da attesa.....
		SetPointer(kkg.pointer_attesa)

		dw_lista_0.setredraw(false)
		kist_tab_clienti.tipo = trim(ki_st_open_w.key1)
		kist_tab_clienti.stato = trim(ki_st_open_w.key2)
	
		if ki_st_open_w.key1 = kiuf_clienti.kki_tipo_contatto then
			
			dw_lista_0.dataobject = "d_contatti_l_mkt"
			dw_lista_0.settransobject( kguo_sqlca_db_magazzino )
			
		else

			dw_lista_0.dataobject = "d_clienti_l_mkt"
			dw_lista_0.settransobject( kguo_sqlca_db_magazzino )

			if isnull(ki_st_open_w.key1) or trim(ki_st_open_w.key1) = "*" or Len(trim(ki_st_open_w.key1)) = 0 then
				kist_tab_clienti.tipo = "%"
			end if
			if isnull(ki_st_open_w.key2) or trim(ki_st_open_w.key2) = "*" or Len(trim(ki_st_open_w.key2)) = 0 then
				kist_tab_clienti.stato = "%"
			end if
		end if

		u_retrieve()    // RETRIEVE
	
//		attiva_tasti()
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



k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
		
	kst_tab_clienti.codice = dw_lista_0.getitemnumber(k_riga, "id_cliente")
	if ki_id_cliente_letto_web <> kst_tab_clienti.codice or ki_id_cliente_letto_mkt <> kst_tab_clienti.codice then
//	if ki_time_riga_letta <> k_riga then
		
			
		kst_tab_clienti.rag_soc_10 = dw_lista_0.getitemstring(k_riga, "rag_soc_10")
	
		ki_time_riga_letta = k_riga
		
		oldpointer = SetPointer(HourGlass!)
		
	
		if NOT k_dw_mkt_sized_icon and ki_id_cliente_letto_mkt <> kst_tab_clienti.codice then
			dw_mkt.title = " Dati Marketing di " +  string (kst_tab_clienti.codice) + " " + trim(kst_tab_clienti.rag_soc_10)
			ki_id_cliente_letto_mkt = kst_tab_clienti.codice
			dw_mkt.retrieve(kst_tab_clienti.codice)  // legge i dati di MKT
		end if
		
		if NOT k_dw_web_sized_icon and ki_id_cliente_letto_web <> kst_tab_clienti.codice then
			dw_web.title = " Dati Web di " +  string (kst_tab_clienti.codice)  + " " + trim(kst_tab_clienti.rag_soc_10)
			ki_id_cliente_letto_web = kst_tab_clienti.codice
			dw_web.retrieve(kst_tab_clienti.codice) // legge i dati WEB
		end if

		SetPointer(oldpointer)

	end if

	if ki_xplistbar_riga_INFO > 0 then // se esiste il paragrafo INFO...
		if NOT dw_xplistbar_info.of_iffilter( ki_xplistbar_riga_INFO) then //--- se non è un ramo collassato allora leggo
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
				k_lotto =  " "
				k_lotto_pic = " "
				if kst_esito.esito = kkg_esito.ok then
					ki_xplistbar_info_num[ki_xplistbar_riga_lotto] = kst_tab_meca.id
					if kst_tab_meca.id > 0 then //~r"
						k_lotto = "ult.Rif.: " + string(kst_tab_meca.num_int) + "  " +string(kst_tab_meca.data_int, "dd/mm/yy")
						k_lotto_pic = 'molletta.gif'
					end if
				end if
				
		//--- piglia i dati dell'ultimo d.d.t.		
				kst_tab_sped.clie_2 = kst_tab_clienti.codice
				kst_esito = kuf1_sped.get_ultimo_doc(kst_tab_sped)
				k_sped =  " "
				k_sped_pic = " "
				if kst_esito.esito = kkg_esito.ok then
					ki_xplistbar_info_num[ki_xplistbar_riga_sped] = kst_tab_sped.num_bolla_out 
					ki_xplistbar_info_data[ki_xplistbar_riga_sped] = kst_tab_sped.data_bolla_out 
					if kst_tab_sped.num_bolla_out > 0 then
						k_sped = "ult.Sped.: " + string(kst_tab_sped.num_bolla_out) + "  " +string(kst_tab_sped.data_bolla_out, "dd/mm/yy")
						k_sped_pic = 'molletta.gif'
					end if
				end if
				
		//--- piglia i dati dell'ultima fattura		
				kst_tab_arfa.clie_3 = kst_tab_clienti.codice
				kst_esito = kuf1_fatt.get_ultimo_doc_ins(kst_tab_arfa)
				k_fatt =  " "
				k_fatt_pic = " "
				if kst_esito.esito = kkg_esito.ok then
					ki_xplistbar_info_num[ki_xplistbar_riga_fatt] = kst_tab_arfa.id_fattura
					if kst_tab_arfa.id_fattura > 0 then
						k_fatt = "ult.Fatt.: " + string(kst_tab_arfa.num_fatt ) + "  " +string(kst_tab_arfa.data_fatt, "dd/mm/yy")
						k_fatt_pic = 'molletta.gif'
					end if
				end if
		
		//--- piglia i dati dell'ultimo attestato		
				kst_tab_certif.clie_2 = kst_tab_clienti.codice
				kst_esito = kuf1_certif.get_ultimo_doc_ins(kst_tab_certif)
				k_certif =  " "
				k_certif_pic = " "
				if kst_esito.esito = kkg_esito.ok then
					ki_xplistbar_info_num[ki_xplistbar_riga_certif] = kst_tab_certif.num_certif
					if kst_tab_certif.id > 0 then
						k_certif = "ult.Att.: " + string(kst_tab_certif.num_certif ) + "  " +string(kst_tab_certif.data, "dd/mm/yy")
						k_certif_pic = 'molletta.gif'
					end if
				end if
				
				destroy kuf1_fatt 
				destroy kuf1_armo 
				destroy kuf1_sped 
				destroy kuf1_certif
		
		//--- set dei valori nella xp-listbar
//				dw_xplistbar_info.setredraw( false)
				if isnull(kst_tab_clienti.rag_soc_10) then
					dw_xplistbar_info.of_setitem( ki_xplistbar_riga_info, " Info ", "") // + "~n~r" + mid(trim(kst_tab_clienti.rag_soc_10),13,17), " ")
				else					
					dw_xplistbar_info.of_setitem( ki_xplistbar_riga_info, " Info di " + left(trim(kst_tab_clienti.rag_soc_10),12), "") // + "~n~r" + mid(trim(kst_tab_clienti.rag_soc_10),13,17), " ")
				end if
				dw_xplistbar_info.of_setitem( ki_xplistbar_riga_lotto, k_lotto, k_lotto_pic)
				dw_xplistbar_info.of_setitem( ki_xplistbar_riga_sped, k_sped, k_sped_pic)
				dw_xplistbar_info.of_setitem( ki_xplistbar_riga_fatt, k_fatt, k_fatt_pic)
				dw_xplistbar_info.of_setitem( ki_xplistbar_riga_certif, k_certif, k_certif_pic)
				dw_xplistbar_info.setredraw( true)
			end if	
		
			SetPointer(oldpointer)
			
		end if
	end if
		
//--- x evitare uno strano fenomeno di spostamento dell'elenco in basso.....
	dw_xplistbar_info.enabled = true
	
	dw_lista_0.setfocus( )
		
else
	dw_mkt.title = " Nessun dato Marketing presente " 
	dw_web.title = " Nessun dato Web presente "
	dw_mkt.reset( )
	dw_web.reset()
	if ki_xplistbar_riga_INFO > 0 then // se esiste il paragrafo INFO...
		ki_xplistbar_info_num[ki_xplistbar_riga_lotto] = 0 
		ki_xplistbar_info_num[ki_xplistbar_riga_sped] = 0  
		ki_xplistbar_info_data[ki_xplistbar_riga_sped] = date(0) 
		ki_xplistbar_info_num[ki_xplistbar_riga_fatt] = 0
		ki_xplistbar_info_num[ki_xplistbar_riga_certif] = 0
//--- set dei valori nella xp-listbar
//		dw_xplistbar_info.setredraw( false)
		dw_xplistbar_info.of_setitem( ki_xplistbar_riga_info, " Info  ", "")
		dw_xplistbar_info.of_setitem( ki_xplistbar_riga_lotto, k_lotto, k_lotto_pic)
		dw_xplistbar_info.of_setitem( ki_xplistbar_riga_sped, k_sped, k_sped_pic)
		dw_xplistbar_info.of_setitem( ki_xplistbar_riga_fatt, k_fatt, k_fatt_pic)
		dw_xplistbar_info.of_setitem( ki_xplistbar_riga_certif, k_certif, k_certif_pic)
		dw_xplistbar_info.setredraw( true)
	end if
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
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

		if isnumber(trim(kst_profilestring_ini.valore)) then
			dw_xplistbar.setrow(integer(trim(kst_profilestring_ini.valore)))
			dw_xplistbar.event ue_clicked(integer (trim(kst_profilestring_ini.valore))) //lancia inizializza()
	
//--- Ripri il numero di riga in cui è
			kst_profilestring_ini.operazione = "1"
			kst_profilestring_ini.nome = trim(kiw_this_window.classname()) + "_" + "setRigaDwAnagrafe"
			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		
//			kst_profilestring_ini.valore = String(dw_anagrafe.getselectedrow(0))
			if isnumber(trim(kst_profilestring_ini.valore)) then
				if long(trim(kst_profilestring_ini.valore)) > 0 then
					dw_lista_0.selectrow(0, false)
					dw_lista_0.selectrow(long (trim(kst_profilestring_ini.valore)), true)
					if dw_lista_0.rowcount( ) > long (trim(kst_profilestring_ini.valore)) then
						dw_lista_0.scrolltorow((long (trim(kst_profilestring_ini.valore)) - 4))
					end if
					dw_lista_0.setrow(long (trim(kst_profilestring_ini.valore)))
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
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	
//--- salva il numero di riga in cui è
		kst_profilestring_ini.operazione = "2"
		kst_profilestring_ini.valore = String(dw_lista_0.getselectedrow(0))
		kst_profilestring_ini.nome = trim(kiw_this_window.classname()) + "_" + "setRigaDwAnagrafe"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	

end subroutine

protected subroutine open_start_window ();//
datastore kds_1

	kiuf_clienti = create kuf_clienti
	
	
	ki_toolbar_window_presente=true
	
	ki_trova_campo_def = 2 // setta il campo di default x il TROVA

	kiw_this_window.icon = "mkt_icona.ico"
//	kiw_this_window.icon = kGuo_path.get_risorse() +  "\" + "mkt_icona.ico"
	
//	this.tab_1.tabpage_1.picturename = kGuo_path.get_risorse() + "\" + "cliente.gif"

//--- Funzione di TROVA: Salva la Query di Origine (devo pero' add il TILDE altrimenti quando ripristino non va bene!!!-------------
	kds_1 = create datastore
	int k_pos
	int kstart_pos = 1
	kds_1.dataobject = "d_clienti_l_mkt"
	ki_sqlsyntax_origine = upper(kds_1.Describe("DataWindow.Table.Select"))
	// Aggiunge al APICE la TILDE ( ' con ~~')
	kstart_pos = pos(ki_sqlsyntax_origine, "'", 1)
	DO WHILE kstart_pos > 0
		 ki_sqlsyntax_origine = Replace(ki_sqlsyntax_origine, kstart_pos, 1, "~~'")
		 kstart_pos = pos(ki_sqlsyntax_origine, "'", kstart_pos+2 )
	LOOP
	k_pos = 0
	kstart_pos = 1
	kds_1.dataobject = "d_contatti_l_mkt"
	ki_sqlsyntax_origine_contatti = upper(kds_1.Describe("DataWindow.Table.Select"))
	// Aggiunge al APICE la TILDE ( ' con ~~')
	kstart_pos = pos(ki_sqlsyntax_origine_contatti, "'", 1)
	DO WHILE kstart_pos > 0
		 ki_sqlsyntax_origine_contatti = Replace(ki_sqlsyntax_origine_contatti, kstart_pos, 1, "~~'")
		 kstart_pos = pos(ki_sqlsyntax_origine_contatti, "'", kstart_pos+2 )
	LOOP
//--- FINE: Salva la Query di Origine (devo pero' add il TILDE altrimenti quando ripristino non va bene!!!-------------

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

	case "l5"		//carica Contatto...
		call_nuovo_anag (kkg_id_programma_anag_rid) 

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
	k_rag_soc = dw_lista_0.getitemstring(k_riga, "rag_soc_10")
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
	
			k_errore = kGuf_data_base.db_commit()
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
			k_errore = kGuf_data_base.db_rollback()

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

protected function string inizializza_post ();//
ki_primo_giro=false

ripristina_ult_uscita()
		
//--- chiude il ramo "INFO"  	
dw_xplistbar_info.trigger Event ue_clicked_0(ki_xplistbar_riga_INFO, "") 
	
dw_xplistbar.visible = true
dw_xplistbar_trova.visible = true
dw_xplistbar_info.visible = true

return "0"
end function

private subroutine call_nuovo_anag (string k_id_programma);//
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice cli;

	K_st_open_w.id_programma = k_id_programma

	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
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

end subroutine

protected function string leggi_liste ();//
string k_return="0"


//--- ripristina Query di Origine (potrebbe essere stata modificata da una funzione di 'TROVA')	
	dw_lista_0.Modify("DataWindow.Table.Select='"+ki_sqlsyntax_origine+ "'")


	k_return = super::leggi_liste()


return k_return



end function

public subroutine lancia_ricerca_valore (string k_par_valore);//---
//--- Manipola la query aggiungendo la parte della WHERE
//---
string k_query,k_select_orig, k_select, k_order_by, k_select_new, k_rc, k_utente="", k_view
int k_pos
int kstart_pos = 1
string k_valore


k_valore = "%" + upper(k_par_valore) + "%"

	
	//--- costruisco la view dei Trattati  
k_utente = "U" + string(kguo_utente.get_id_utente( ))
k_view = "vx_" + trim(k_utente) + "_clienti_mkt"  	
k_query = " " 
k_query =  "CREATE VIEW " + trim(k_view) + " AS   "  
k_query +=  &
		 + "  SELECT  * " &
		 + " FROM clienti  " &
		 + " where CLIENTI.CODICE in ( " 
k_query += &
  " SELECT DISTINCT clienti.codice  " &
  	+ "FROM (clienti LEFT OUTER JOIN clienti_mkt ON  " &
 	 		 + " clienti.codice = clienti_mkt.id_cliente  " &
	  + " LEFT OUTER JOIN clienti_web ON  " &
	  + " clienti.codice = clienti_web.id_cliente)   " &
	  + "  LEFT OUTER JOIN clienti as cont1 ON  " &
	  + " clienti_mkt.id_contatto_1 > 0 and clienti_mkt.id_contatto_1 = cont1.codice   " &
	  + "  LEFT OUTER JOIN clienti as cont2 ON  " &
	  + " clienti_mkt.id_contatto_2 > 0 and clienti_mkt.id_contatto_2 = cont2.codice   " &
	  + "  LEFT OUTER JOIN clienti as cont3 ON  " &
	  + " clienti_mkt.id_contatto_3 > 0 and clienti_mkt.id_contatto_3 = cont3.codice   " &
	  + "  LEFT OUTER JOIN clienti as cont4 ON  " &
	  + " clienti_mkt.id_contatto_4 > 0 and clienti_mkt.id_contatto_4 = cont4.codice   " &
	  + "  LEFT OUTER JOIN clienti as cont5 ON  " &
	  + " clienti_mkt.id_contatto_5 > 0 and clienti_mkt.id_contatto_5 = cont5.codice   " &
	  + "  LEFT OUTER JOIN gru ON  " &
	  + " clienti_mkt.gruppo > 0 and clienti_mkt.gruppo = gru.codice   " &
	  + "  LEFT OUTER JOIN province ON  " &
	  + " (clienti.prov_1 = province.sigla or clienti.prov_2 = province.sigla) " &
	  + " WHERE  " &
	+ " upper(coalesce(CONVERT(VARCHAR,clienti.codice),~' ~')+coalesce(clienti.p_iva,~' ~')+coalesce(clienti.cf,~' ~')+coalesce(clienti.rag_soc_10,~' ~')+coalesce(clienti.rag_soc_11,' ')+coalesce(clienti.rag_soc_20,' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(clienti.rag_soc_21,' ')+coalesce(clienti.indi_1,' ')+coalesce(clienti.loc_1,' ')+coalesce(clienti.cap_1,' ')+coalesce(clienti.prov_1,' ')+coalesce(clienti.indi_2,' ')+coalesce(clienti.loc_2,' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(clienti.cap_2,' ')+coalesce(clienti.prov_2,' ')+coalesce(clienti.fono,' ')+coalesce(clienti.fax,' ')+coalesce(clienti.banca,' ')+coalesce(CONVERT(VARCHAR,clienti.abi),' ')+coalesce(CONVERT(VARCHAR,clienti.cab),' ')+coalesce(CONVERT(VARCHAR,clienti.iva),' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(clienti_mkt.qualifica,' ')+coalesce(clienti_mkt.tipo_rapporto,' ')+coalesce(CONVERT(VARCHAR,clienti_mkt.id_cliente_link),' ')+coalesce(clienti_mkt.altra_sede,' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(CONVERT(VARCHAR,clienti_mkt.id_contatto_1),' ')+coalesce(TRIM(clienti_mkt.contatto_1_qualif),' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(CONVERT(VARCHAR,clienti_mkt.id_contatto_2),' ')+coalesce(TRIM(clienti_mkt.contatto_2_qualif),' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(CONVERT(VARCHAR,clienti_mkt.id_contatto_3),' ')+coalesce(TRIM(clienti_mkt.contatto_3_qualif),' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(CONVERT(VARCHAR,clienti_mkt.id_contatto_4),' ')+coalesce(TRIM(clienti_mkt.contatto_4_qualif),' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(CONVERT(VARCHAR,clienti_mkt.id_contatto_5),' ')+coalesce(TRIM(clienti_mkt.contatto_5_qualif),' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(clienti_mkt.note_attivita,' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(clienti_mkt.note_prodotti,' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(clienti_web.email,' ')+coalesce(clienti_web.email1,' ')+coalesce(clienti_web.email2,' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(clienti_web.sito_web,' ')+coalesce(clienti_web.sito_web1,' ')) " &   
	+ " like '" + k_valore + "' "  & 
	+ " or upper(coalesce(clienti_web.blog_web,' ')+coalesce(clienti_web.blog_web1,' ')) " &   
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(cont1.rag_soc_10,' ')+coalesce(cont1.rag_soc_11,' ')) " &   
	+ " like '" + k_valore + "' "  &   
	+ " or upper(coalesce(cont2.rag_soc_10,' ')+coalesce(cont2.rag_soc_11,' ')) " &   
	+ " like '" + k_valore + "' "  & 
	+ " or upper(coalesce(cont3.rag_soc_10,' ')+coalesce(cont3.rag_soc_11,' ')) " &   
	+ " like '" + k_valore + "' "  & 
	+ " or upper(coalesce(cont4.rag_soc_10,' ')+coalesce(cont4.rag_soc_11,' ')) " &   
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(cont5.rag_soc_10,' ')+coalesce(cont5.rag_soc_11,' ')) " &   
	+ " like '" + k_valore + "' "   &
	+ " or coalesce(CONVERT(VARCHAR,clienti_mkt.gruppo),' ')+upper(coalesce(gru.des,' ')) " &   
	+ " like '" + k_valore + "' "   &
	+ " or upper(coalesce(province.regione,' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or upper(coalesce(province.prov,' ')) " &
	+ " like '" + k_valore + "' "  &
	+ " or coalesce(CONVERT(VARCHAR,clienti.id_clie_classe),' ') " &
	+ " like '" + k_valore + "' "  &
     + " ) " 
k_query += "   "
kguo_sqlca_db_magazzino.db_crea_view(1, k_view, k_query)		


if dw_lista_0.dataobject = "d_contatti_l_mkt" then
	k_select_orig = ki_sqlsyntax_origine_contatti
else
	k_select_orig = ki_sqlsyntax_origine 
end if

//
////=== Cerca la clausola GROUP BY per inserire la nuova parte della Query
//k_pos = Pos(k_select_orig, "GROUP BY")
//if k_pos > 0 then
//	k_select = Left(k_select_orig, k_pos - 1)
//	k_order_by = mid(k_select_orig, k_pos)
//else
////=== allora Cerca la clausola ORDER BY
//	k_pos = Pos(k_select_orig, "ORDER BY")
//	if k_pos > 0 then
//		k_select = Left(k_select_orig, k_pos - 1)
//		k_order_by = mid(k_select_orig, k_pos)
//	end if
//end if

//k_select_new = k_select + " and CLIENTI.CODICE in (" + k_query + ") " + k_order_by + "'"

////--- sostituisci la TAB alla VIEW
//k_pos = pos(k_select_orig, "   FROM CLIENTI   ", 1)
//if k_pos > 0 then 
//	k_select = Left(k_select_orig, k_pos - 1)
//	k_order_by = mid(k_select_orig, k_pos + 17)
//end if
//k_select_new = k_select + "   FROM "+ k_view + " as clienti   " + k_order_by + "'"

//--- la Query sui contatti è più complicata, dentro ci sono delle UNION ALL x cui ciclo più volte
//if dw_lista_0.dataobject = "d_contatti_l_mkt" then

	k_pos = Pos(k_select_orig, "   FROM CLIENTI   ", 1)
	k_select_new = k_select_orig
	do while k_pos > 0
		if k_pos > 0 then
			k_select = Left(k_select_new, k_pos - 1)
			k_order_by = mid(k_select_new, k_pos + 17)
		end if
		k_select_new = k_select + "   FROM "+ k_view + " as clienti   " + k_order_by + "'"
		//k_select_new = k_select + " and CLIENTI.CODICE in (" + k_query + ") " + k_order_by + "'"
		
		k_pos = Pos(k_select_new, "   FROM CLIENTI   ",  (k_pos + 17))  // leggo il successivo 
		//k_pos = Pos(k_select_new, "UNION ALL", (k_pos + 11)) // + len(k_query) + len(k_order_by) + 1)
	loop


//end if


k_select_new = "DataWindow.Table.Select='" + k_select_new

k_rc = dw_lista_0.Modify(k_select_new)

//--- RETRIVE su DW_LISTA
try
	
	u_retrieve()    // RETRIEVE
//	inizializza()
	dw_lista_0.title = dw_lista_0.title + " - Valore Cercato: " + k_par_valore
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )
end try





end subroutine

private subroutine call_memo ();//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
st_tab_clienti_memo kst_tab_clienti_memo 
st_memo kst_memo
kuf_memo kuf1_memo
kuf_memo_inout kuf1_memo_inout


try   
	k_riga = dw_lista_0.getrow()
	if k_riga > 0 then
	
		kst_tab_clienti_memo.id_cliente_memo = dw_lista_0.getitemnumber( k_riga, "id_cliente_memo" ) 
//		if kst_tab_clienti_memo.id_cliente_memo > 0 then
//			kiuf_clienti.get_id_memo(kst_tab_clienti_memo)
//		else
			kst_tab_clienti_memo.id_memo = 0
//		end if
		kst_tab_clienti_memo.id_cliente = dw_lista_0.getitemnumber( k_riga, "id_cliente" ) 
			
		if kst_tab_clienti_memo.id_cliente  > 0 then
			
			kuf1_memo = create kuf_memo 
			kuf1_memo_inout = create kuf_memo_inout
			kst_tab_clienti_memo.tipo_sv = ki_st_open_w.sr_settore
			kst_memo.st_tab_clienti_memo = kst_tab_clienti_memo
			kuf1_memo_inout.memo_xcliente(kst_memo.st_tab_clienti_memo, kst_memo.st_tab_memo)
			kuf1_memo.u_attiva_funzione(kst_memo,kkg_flag_modalita.inserimento )   // APRE FUNZIONE
			
		end if
	end if 
		
catch (uo_exception	kuo_exception)
	kuo_exception.messaggio_utente()
		
end try
	


end subroutine

public function long u_retrieve ();//
long k_return = 0


		SetPointer(kkg.pointer_attesa)
	
		dw_lista_0.event set_titolo( )
		
		k_return = dw_lista_0.retrieve(kist_tab_clienti.tipo, kist_tab_clienti.stato)

		dw_lista_0.setredraw(true)
	//	dw_lista_0.visible = true
		SetPointer(kkg.pointer_default)
		
		dw_lista_0.setfocus( )

return k_return

end function

public subroutine u_timer ();//--- rilegge automaticamente se per un tot di tempo non si fa nulla 
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
	
//--- x evitare uno strano fenomeno di spostamento dell'elenco in basso.....
		dw_xplistbar_info.enabled = true

	end if
end if


end subroutine

protected subroutine attiva_tasti_0 ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================
long k_nr_righe


super::attiva_tasti_0()

cb_ritorna.enabled = true
cb_inserisci.enabled = true
cb_visualizza.enabled = true
st_aggiorna_lista.enabled = true
st_ordina_lista.enabled = true

//cb_aggiorna.enabled = false
cb_modifica.enabled = false
cb_cancella.enabled = false


//=== Nr righe nel DW lista
if dw_lista_0.rowcount ( ) > 0 then
	cb_modifica.enabled = true
	cb_cancella.enabled = true
end if


end subroutine

public subroutine u_obj_visible_0 ();//
		dw_lista_0.visible = true
		dw_mkt.visible = true
		dw_web.visible = true

		dw_xplistbar.visible = true
		dw_xplistbar_trova.visible = true
		dw_xplistbar_info.visible = true

end subroutine

public function boolean u_resize_predefinita ();//
int k_dist_bordi, k_spess_bordi_x, k_spess_bordi_y


//	if this.sizetype <> 1 or isnull(this.sizetype) then		

		this.setredraw(false)
		
		//NewHeight = this.height
		//NewWidth = this.width
		
		k_dist_bordi = 5
		k_spess_bordi_x = 5 //65
		k_spess_bordi_y = 20 //175
		
		dw_xplistbar.x = k_dist_bordi
		dw_xplistbar.y = k_dist_bordi
		dw_xplistbar.Height = 1200 // (NewHeight - k_spess_bordi_y) / 2 //(k_dist_bordi * 4)
		dw_xplistbar.width = 891
		dw_xplistbar.of_resize( dw_xplistbar.width)

		dw_xplistbar_trova.x = k_dist_bordi
		dw_xplistbar_trova.y = dw_xplistbar.y +dw_xplistbar.Height
		dw_xplistbar_trova.Height = 350 //NewHeight - dw_xplistbar.Height - dw_xplistbar_info.Height  
		dw_xplistbar_trova.width = dw_xplistbar.width
		dw_xplistbar_trova.of_resize( dw_xplistbar_trova.width)

		dw_xplistbar_info.x = k_dist_bordi
		dw_xplistbar_info.y = dw_xplistbar_trova.y+dw_xplistbar_trova.Height
		dw_xplistbar_info.Height = this.Height - dw_xplistbar.Height - dw_xplistbar_trova.Height  // 600 //(NewHeight - dw_xplistbar.Height) / 2  
		dw_xplistbar_info.width = dw_xplistbar.width
		dw_xplistbar_info.of_resize( dw_xplistbar_info.width)

		if ki_st_open_w.flag_adatta_win = KKG.ADATTA_WIN and not (ki_personalizza_pos_controlli) then
	
			dw_lista_0.width = this.width - dw_xplistbar.width - k_dist_bordi * 2 - k_spess_bordi_x 
			dw_mkt.width =dw_lista_0.width * 0.55
			dw_web.width = dw_lista_0.width - dw_mkt.width  //- k_dist_bordi * 3 - k_spess_bordi_x) * 0.45
		
			dw_lista_0.height = this.Height * 0.60  //(dw_xplistbar.Height + dw_xplistbar_info.height) * 0.60 
			dw_mkt.height = this.Height - dw_lista_0.height  - k_spess_bordi_y //(dw_xplistbar.Height + dw_xplistbar_info.height) - dw_lista_0.height  - k_spess_bordi_y
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
	
	//end if

return TRUE


end function

on w_clienti_mkt.create
int iCurrent
call super::create
this.dw_xplistbar=create dw_xplistbar
this.dw_mkt=create dw_mkt
this.dw_web=create dw_web
this.dw_xplistbar_info=create dw_xplistbar_info
this.dw_xplistbar_trova=create dw_xplistbar_trova
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_xplistbar
this.Control[iCurrent+2]=this.dw_mkt
this.Control[iCurrent+3]=this.dw_web
this.Control[iCurrent+4]=this.dw_xplistbar_info
this.Control[iCurrent+5]=this.dw_xplistbar_trova
end on

on w_clienti_mkt.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_xplistbar)
destroy(this.dw_mkt)
destroy(this.dw_web)
destroy(this.dw_xplistbar_info)
destroy(this.dw_xplistbar_trova)
end on

event close;call super::close;//--- Salva le impostazioni x poterle recuperare al prx avvio
salva_impostazioni()

if isvalid(kiuf_clienti) then destroy kiuf_clienti


end event

event timer;call super::timer;//
//il TIMER in mdalità docking non funzia più!!
//u_timer()

end event

type st_ritorna from w_g_tab0`st_ritorna within w_clienti_mkt
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_clienti_mkt
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_clienti_mkt
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_clienti_mkt
end type

type st_stampa from w_g_tab0`st_stampa within w_clienti_mkt
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
		K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
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
		K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
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
//--- Nuova Anagrafe
//
	if dw_xplistbar.getrow( ) = ki_xpl_Contatti then 
		call_nuovo_anag (kkg_id_programma_anag_rid) // carica Contatto
	else
		call_nuovo_anag (kkg_id_programma_anag)
	end if

end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_clienti_mkt
integer x = 1819
integer y = 1648
integer width = 722
integer height = 248
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_clienti_mkt
integer x = 1339
integer y = 756
integer width = 1307
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
		this.title = "ELENCO " + upper( k_titolo )
		destroy kuf1_utility
	end if
			


end event

event dw_lista_0::clicked;call super::clicked;//
string k_nome


k_nome = dwo.name

//---- inizia il timer per eventuale auto-lettura  NON FUNZIA IN DOCKING
//ki_time_rileggi_auto = now()
//ki_time_riga = now()

//--- rilegge le liste ad ogni click in quanto il TIMER in mdalità docking non funzia più
	leggi_dw_dettaglio()
	

//if dwo.name = "id_cliente_memo" or dwo.name = "p_id_memo" or dwo.name = "p_id_memo_no" then
if k_nome = "p_id_memo_no" then
	call_memo()
end if

this.setfocus( )

end event

event dw_lista_0::constructor;call super::constructor;//
//this.ki_icona_normale = kGuo_path.get_risorse() + "\" + "clienti16.gif"
//this.object.p_id_memo.filename = kGuo_path.get_risorse() + "\" + "edit16.gif"
//this.object.p_id_memo_no.filename = kGuo_path.get_risorse() + "\" + "document_new.gif"

this.ki_icona_normale = "clienti16.gif"
//this.object.p_id_memo.filename = "edit16.gif"
//this.object.p_id_memo_no.filename = "document_new.gif"

end event

event dw_lista_0::getfocus;call super::getfocus;//---- inizia il timer per eventuale auto-lettura
//ki_time_rileggi_auto = now()
//ki_time_riga = now()

//---- Scatena il timer (vedi l'evento) 
//	timer (0.30)  NON FUNZIONA PIU' IN MODALITA DOCKING

end event

event dw_lista_0::losefocus;call super::losefocus;//---- Spegne il timer (vedi l'evento)
//	timer (0)  NON FUNZIONA PIU' IN MODALITA DOCKING

end event

event dw_lista_0::rowfocuschanged;call super::rowfocuschanged;//
//--- rilegge le liste 	
//		leggi_dw_dettaglio()

end event

type dw_guida from w_g_tab0`dw_guida within w_clienti_mkt
end type

type dw_xplistbar from u_dw_xplistbar within w_clienti_mkt
boolean visible = false
integer x = 32
integer y = 20
integer width = 891
integer height = 964
integer taborder = 30
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//
Long ll_parent

//Add new item
ll_parent = THIS.of_AddItem('header','Anagrafe  ',0, '')
 
ki_xpl_Contatti = THIS.of_AddItem('child','Contatti ',ll_parent, 'contatti_rubrica.gif')
ki_xpl_Potenziali = THIS.of_AddItem('child','Potenziali da contattare ',ll_parent, 'cliente_potenziale.gif')  //~r
ki_xpl_Potenziali_contattatto = THIS.of_AddItem('child','Potenziali in contatto ',ll_parent, 'cliente_contattato.gif')
ki_xpl_Attivi_parziali = THIS.of_AddItem('child','Attivi parziali ',ll_parent, 'cliente_parziale.gif')
THIS.of_AddItem('child',' ',ll_parent, ' ')
ki_xpl_Attivi = THIS.of_AddItem('child','Attivi completi  ',ll_parent, 'cliente_in_prod.gif')
THIS.of_AddItem('child',' ',ll_parent, ' ')
ki_xpl_Sospesi = THIS.of_AddItem('child','Sospesi ',ll_parent, 'cliente_close.gif')
ki_xpl_Chiuso = THIS.of_AddItem('child','Chiusi ',ll_parent, 'cliente_close.gif')
THIS.of_AddItem('child',' ',ll_parent, ' ')
ki_xpl_Tutti = THIS.of_AddItem('child','Tutti',ll_parent, 'clienti.gif')
//THIS.of_AddItem('child',' ',ll_parent, ' ')
//THIS.of_AddItem('child','Sounds, Speech, and~rAudio Devices',ll_parent, 'sound.bmp')
THIS.of_AddItem('filler','',ll_parent, '')//filler is necessary for looks

////Add new item
//ll_parent = THIS.of_AddItem('header','Info       ',0, '') 
//ki_xplistbar_riga_INFO = ll_parent
//ki_xplistbar_riga_lotto=THIS.of_AddItem('child',' ',ll_parent, '' )  // 'Ult. Lotto: ',ll_parent, ' ' )
////ki_xplistbar_riga_lotto=THIS.of_AddItem('child','-',ll_parent, '') //'molletta.gif')
//ki_xplistbar_riga_fatt=THIS.of_AddItem('child',' ',ll_parent, '' ) //'Ult. Fattura: ',ll_parent, '' )
////ki_xplistbar_riga_fatt=THIS.of_AddItem('child','-',ll_parent, '') 
//ki_xplistbar_riga_sped=THIS.of_AddItem('child',' ',ll_parent, '' ) //'Ult. Spedizione: ',ll_parent, '' )
////ki_xplistbar_riga_sped=THIS.of_AddItem('child','-',ll_parent, '') 
//ki_xplistbar_riga_certif=THIS.of_AddItem('child',' ',ll_parent, '' ) //'Ult. Attestato: ',ll_parent, '' )
////ki_xplistbar_riga_certif=THIS.of_AddItem('child','-',ll_parent, '') 
//
//THIS.of_AddItem('filler','',ll_parent, '')//filler is necessary for looks


end event

event getfocus;call super::getfocus;//---- inizia il timer per eventuale auto-lettura
ki_time_riga = now()
ki_time_rileggi_auto = now()

end event

event ue_clicked;call super::ue_clicked;//
//--- Cliccato item di dettaglio: faccio qlc
//

try
	
//--- ripristina Query di Origine (potrebbe essere stata modificata da una funzione di 'TROVA')	
	dw_lista_0.Modify("DataWindow.Table.Select='"+ki_sqlsyntax_origine+ "'")

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
			
		case ki_xpl_Sospesi
			ki_xpl_SCELTA = kriga
			ki_st_open_w.key1 = "" //kiuf_clienti.kki_tipo_fatturato
			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_sospeso 
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
			
//		case ki_xplistbar_riga_lotto & 
//			,ki_xplistbar_riga_fatt &
//			,ki_xplistbar_riga_sped &
//			,ki_xplistbar_riga_certif 
//			ki_xpl_SCELTA_info = kriga
//			call_anteprima()
			
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
//if ki_xplistbar_riga_INFO = row then
//	ki_id_cliente_letto_INFO = 0
//end if

this.setredraw( true )
end event

type dw_mkt from uo_d_std_1 within w_clienti_mkt
event pbm_dwnresize pbm_dwnresize
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

type dw_xplistbar_info from u_dw_xplistbar within w_clienti_mkt
event u_popola_dw ( )
boolean visible = false
integer x = 27
integer y = 1460
integer width = 891
integer height = 164
integer taborder = 10
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event u_popola_dw();//
this.setredraw( false )
ki_xplistbar_riga_lotto=THIS.of_AddItem('child',' ',ki_xplistbar_riga_INFO, ' ' )  // 'Ult. Lotto: ',ll_parent, ' ' )
//ki_xplistbar_riga_lotto=THIS.of_AddItem('child','-',ll_parent, '') //'molletta.gif')
ki_xplistbar_riga_fatt=THIS.of_AddItem('child',' ',ki_xplistbar_riga_INFO, ' ' ) //'Ult. Fattura: ',ll_parent, '' )
//ki_xplistbar_riga_fatt=THIS.of_AddItem('child','-',ll_parent, '') 
ki_xplistbar_riga_sped=THIS.of_AddItem('child',' ',ki_xplistbar_riga_INFO, ' ' ) //'Ult. Spedizione: ',ll_parent, '' )
//ki_xplistbar_riga_sped=THIS.of_AddItem('child','-',ll_parent, '') 
ki_xplistbar_riga_certif=THIS.of_AddItem('child',' ',ki_xplistbar_riga_INFO, ' ' ) //'Ult. Attestato: ',ll_parent, '' )
//ki_xplistbar_riga_certif=THIS.of_AddItem('child','-',ll_parent, '') 
THIS.of_AddItem('filler','',ki_xplistbar_riga_INFO, '')//filler is necessary for looks
this.setredraw( true )

end event

event constructor;call super::constructor;//
Long ll_parent

////Add new item
//ll_parent = THIS.of_AddItem('header','Anagrafe  ',0, '')
// 
//ki_xpl_Contatti = THIS.of_AddItem('child','Contatti ',ll_parent, 'contatti_rubrica.gif')
//ki_xpl_Potenziali = THIS.of_AddItem('child','Potenziali da~rcontattare ',ll_parent, 'cliente_potenziale.gif')
//ki_xpl_Potenziali_contattatto = THIS.of_AddItem('child','Potenziali in~rcontatto ',ll_parent, 'cliente_contattato.gif')
//ki_xpl_Attivi_parziali = THIS.of_AddItem('child','Attivi~rparziali ',ll_parent, 'cliente_parziale.gif')
//ki_xpl_Attivi = THIS.of_AddItem('child','Attivi ~rcompleti  ',ll_parent, 'cliente_in_prod.gif')
//ki_xpl_Chiuso = THIS.of_AddItem('child','Chiusi ',ll_parent, 'cliente_close.gif')
//ki_xpl_Tutti = THIS.of_AddItem('child','Tutti',ll_parent, 'clienti.gif')
////THIS.of_AddItem('child','Sounds, Speech, and~rAudio Devices',ll_parent, 'sound.bmp')
//THIS.of_AddItem('filler','',ll_parent, '')//filler is necessary for looks

//Add new item
ll_parent = THIS.of_AddItem('header','Info       ',0, '') 
ki_xplistbar_riga_INFO = ll_parent
this.event u_popola_dw()


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
			
//		case ki_xpl_Contatti
//			ki_xpl_SCELTA = kriga
//			ki_st_open_w.key1 = kiuf_clienti.kki_tipo_contatto
//			ki_st_open_w.key2 = ""
//			inizializza()
//			
//		case ki_xpl_Potenziali
//			ki_xpl_SCELTA = kriga
//			ki_st_open_w.key1 = "" 
//			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_potenziale_da_contattare 
//			inizializza()
//			
//		case ki_xpl_Potenziali_contattatto
//			ki_xpl_SCELTA = kriga
//			ki_st_open_w.key1 = "" 
//			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_potenziale_in_contatto 
//			inizializza()
//			
//		case ki_xpl_Attivi_parziali
//			ki_xpl_SCELTA = kriga
//			ki_st_open_w.key1 = "" 
//			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_attivo_parziale
//			inizializza()
//			
//		case ki_xpl_Attivi
//			ki_xpl_SCELTA = kriga
//			ki_st_open_w.key1 = "" //kiuf_clienti.kki_tipo_fatturato
//			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_attivo
//			inizializza()
//			
//		case ki_xpl_Chiuso
//			ki_xpl_SCELTA = kriga
//			ki_st_open_w.key1 = "" //kiuf_clienti.kki_tipo_fatturato
//			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_estinto 
//			inizializza()
//			
//		case ki_xpl_Tutti
//			ki_xpl_SCELTA = kriga
//			ki_st_open_w.key1 = ""
//			ki_st_open_w.key2 = ""
//			inizializza()

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
//--- se sono PRIMA_VOLTA 
if THIS.Object.item_type[row] = "HC" then 
	if ki_xplistbar_riga_INFO = row then
		ki_id_cliente_letto_INFO = 0
	end if

	this.setredraw( true )
end if
end event

type dw_xplistbar_trova from u_dw_trova within w_clienti_mkt
boolean visible = false
integer x = 37
integer y = 1020
integer width = 864
integer taborder = 50
boolean bringtotop = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//
Long ll_parent=0


//Add new item
//ll_parent = THIS.of_AddItem('header','Trova       ',0, '') 
//ki_xplistbar_riga_TROVA = ll_parent
//ll_parent=THIS.of_AddItem('header','Trova  ',ll_parent, 'lente16x16.gif' )  // 'Ult. Lotto: ',ll_parent, ' ' )
//ki_xplistbar_riga_TROVA=THIS.of_AddItem('header','',ll_parent, '' )  // 'Ult. Lotto: ',ll_parent, ' ' )
ki_xplistbar_riga_TROVA=THIS.of_AddItem('header','Trova  ',ll_parent, 'lente16x16.gif' )  // 'Ult. Lotto: ',ll_parent, ' ' )
//ki_xplistbar_riga_lotto=THIS.of_AddItem('child','-',ll_parent, '') //'molletta.gif')

//THIS.of_AddItem('filler','',ll_parent, '')//filler is necessary for looks


end event

event ue_clicked;call super::ue_clicked;//---
//--- Ricerca del valore 
//---
string k_valore=""

this.accepttext( )
k_valore = trim(this.getitemstring( kriga, "item_input")) 

if len(k_valore) > 0 then
	lancia_ricerca_valore(k_valore)
end if
	

end event

