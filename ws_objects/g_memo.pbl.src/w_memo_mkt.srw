$PBExportHeader$w_memo_mkt.srw
forward
global type w_memo_mkt from w_g_tab0
end type
type dw_xplistbar from u_dw_xplistbar within w_memo_mkt
end type
type dw_mkt from uo_d_std_1 within w_memo_mkt
end type
type dw_web from uo_d_std_1 within w_memo_mkt
end type
type dw_xplistbar_info from u_dw_xplistbar within w_memo_mkt
end type
type dw_xplistbar_trova from u_dw_trova within w_memo_mkt
end type
type dw_periodo from uo_dw_periodo within w_memo_mkt
end type
end forward

global type w_memo_mkt from w_g_tab0
integer width = 3744
integer height = 2124
long backcolor = 16711680
string icon = "C:\GAMMARAD\PB_GMMRD11\ICONE\mkt_icona.ico"
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
dw_xplistbar dw_xplistbar
dw_mkt dw_mkt
dw_web dw_web
dw_xplistbar_info dw_xplistbar_info
dw_xplistbar_trova dw_xplistbar_trova
dw_periodo dw_periodo
end type
global w_memo_mkt w_memo_mkt

type variables
//
//
Protected:
//boolean ki_attiva_toolbar_periodo=false

Protected:
kuf_memo kiuf_memo
kuf_memo_utenti kiuf_memo_utenti
st_tab_memo_utenti kist_tab_memo_utenti
st_tab_memo kist_tab_memo
//string ki_stato_cercato
//long ki_id_dacercare
//long ki_id_memo_rtf=0


//--- Tipologia dell'estrazione
private string ki_tipo = ""
private string ki_stato = ""
private long ki_id = 0   // id può esserci id_meca o id_cliente
private string ki_settore = ""
private long ki_id_cliente = 0
private long ki_id_meca = 0

private boolean ki_primo_giro=true

//--- indice delle VOCI dentro alla XpListBar
private int ki_xpl_nuovi = 0
private int ki_xpl_Attivi = 0
//private int ki_xpl_Letti_contattatto = 0
private int ki_xpl_xLotto = 0
private int ki_xpl_xCliente = 0
private int ki_xpl_Completa = 0
private int ki_xpl_Rimossi = 0
//private int ki_xpl_Attivi = 0
private int ki_xplistbar_riga_INFO=0
private int ki_xplistbar_riga_TROVA=0
private int ki_xplistbar_riga_lotto=0
private int ki_xplistbar_riga_clienti=0
//private int ki_xplistbar_riga_sped=0
//private int ki_xplistbar_riga_certif=0

private int ki_xpl_SCELTA = 0 // la voce scelta
private int ki_xpl_SCELTA_info = 0 // la voce scelta

//--- array da mettere xpListaBar nella sezione INFO
private  long ki_xplistbar_info_num[1 to 20]
private  date ki_xplistbar_info_data[1 to 20]

//--- x eitare di leggere le DW ad ogni cambio riga ma solo quando si 'sosta~'
private time ki_time_riga
private long ki_id_memo_letto_proprieta=0
private long ki_id_memo_letto_allegati=0
private long ki_id_memo_letto_INFO=0
//private long ki_id_cliente_letto_INFO=0
//private long ki_id_cliente_letto_TROVA=0
private long ki_time_riga_letta=0
//--- x rileggere la finstra di elenco dopo un tot che non si fa nulla
private time ki_time_rileggi_auto 

//--- x test sulla dimensione delle DW
private boolean k_dw_mkt_sized_icon = false
private boolean k_dw_web_sized_icon = false

//--- DW query ORIGINARIA x poter aggiungere il TROVA di volta in volta 
private string ki_sqlsyntax_origine=""


end variables

forward prototypes
private subroutine call_anteprima ()
protected function string inizializza () throws uo_exception
public subroutine leggi_dw_dettaglio ()
private subroutine ripristina_ult_uscita ()
private subroutine salva_impostazioni ()
protected subroutine open_start_window ()
protected subroutine smista_funz (string k_par_in)
protected function string inizializza_post ()
protected function string leggi_liste ()
public subroutine lancia_ricerca_valore (string k_par_valore)
public function long u_retrieve ()
protected subroutine cambia_periodo_elenco ()
protected subroutine attiva_menu ()
protected subroutine cancella_memo ()
private subroutine call_nuovo_memo ()
private subroutine inizializza_ramo (integer a_attiva_ramo)
protected function integer inserisci ()
protected function integer modifica ()
protected function integer visualizza ()
public subroutine u_cambia_stato (long a_riga)
protected function string cancella ()
protected subroutine attiva_tasti_0 ()
public subroutine u_resize_1 ()
end prototypes

private subroutine call_anteprima ();//
boolean k_call=false
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_open_w kst_open_w
st_esito kst_esito
kuf_armo kuf1_armo
kuf_clienti kuf1_clienti
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
			
		case ki_xplistbar_riga_clienti
			kdsi_elenco_output.reset( )
			kuf1_clienti = create kuf_clienti
			kst_tab_clienti.codice = ki_xplistbar_info_num[ki_xplistbar_riga_clienti]
			if kst_tab_clienti.codice > 0 then
				k_call=true
				kst_esito = kuf1_clienti.anteprima ( kdsi_elenco_output, kst_tab_clienti )
				destroy kuf1_armo
				if kst_esito.esito <> kkg_esito.ok then
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito)
					throw kuo_exception
				end if
				kst_open_w.key1 = "Dettaglio Anagrafica (codice=" + trim(string(kst_tab_clienti.codice))  + ") "
			end if


	end choose

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

protected function string inizializza () throws uo_exception;//



//--- se Primo giro esegue prima il ripristina (inizializza_post) come l'ulima uscita
	if not ki_primo_giro then
		
//=== Puntatore Cursore da attesa.....
		SetPointer(kkg.pointer_attesa)

		dw_lista_0.setredraw(false)
	
//		dw_lista_0.dataobject = "d_memo_l_utente"
//		dw_lista_0.settransobject( kguo_sqlca_db_magazzino )
		
		u_retrieve()    // RETRIEVE
	
		attiva_tasti()
	end if


return "0"

end function

public subroutine leggi_dw_dettaglio ();//
//--- legge le dw di dettaglio
//
long k_riga=0
string k_lotto='', k_lotto_pic='', k_cliente='', k_cliente_pic=''
st_esito kst_esito
st_tab_memo kst_tab_memo
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
//st_tab_sped kst_tab_sped 
//st_tab_certif kst_tab_certif
//kuf_fatt kuf1_fatt
//kuf_armo kuf1_armo
kuf_clienti kuf1_clienti
//kuf_certif kuf1_certif
pointer oldpointer  // Declares a pointer variable



k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
		
	kst_tab_memo.id_memo = dw_lista_0.getitemnumber(k_riga, "id_memo")
	if ki_id_memo_letto_allegati <> kst_tab_memo.id_memo or ki_id_memo_letto_proprieta <> kst_tab_memo.id_memo then
//	if ki_time_riga_letta <> k_riga then
			
		ki_time_riga_letta = k_riga
		
		oldpointer = SetPointer(HourGlass!)
		
	
		if NOT k_dw_mkt_sized_icon and ki_id_memo_letto_proprieta <> kst_tab_memo.id_memo then
			dw_mkt.title = " Proprietà Memo " +  string (kst_tab_memo.id_memo) 
			ki_id_memo_letto_proprieta = kst_tab_memo.id_memo
			dw_mkt.retrieve(kst_tab_memo.id_memo)  // legge i dati di MKT
		end if
		
		if NOT k_dw_web_sized_icon and ki_id_memo_letto_allegati <> kst_tab_memo.id_memo then
			dw_web.title = " Allgati Memo " +  string (kst_tab_memo.id_memo)  
			ki_id_memo_letto_allegati = kst_tab_memo.id_memo
			dw_web.retrieve(kst_tab_memo.id_memo) // legge i dati WEB
		end if

		SetPointer(oldpointer)

	end if

	if ki_xplistbar_riga_INFO > 0 then // se esiste il paragrafo INFO...
		if NOT dw_xplistbar_info.of_iffilter( ki_xplistbar_riga_INFO) then //--- se non è un ramo collassato allora leggo
			if ki_id_memo_letto_INFO <> kst_tab_memo.id_memo then
				ki_id_memo_letto_INFO = kst_tab_memo.id_memo
	
//				oldpointer = SetPointer(HourGlass!)
//				
				kuf1_clienti = create kuf_clienti
//				kuf1_armo = create kuf_armo
//				kuf1_sped = create kuf_sped
//				kuf1_certif = create kuf_certif
//		
//--- piglia i dati del lotto		
//				kst_tab_meca.clie_1 = kst_tab_memo.id_memo
//				kst_tab_meca.clie_2 = kst_tab_memo.id_memo
//				kst_tab_meca.clie_3 = kst_tab_memo.id_memo
//				kst_esito = kuf1_armo.get_ultimo_doc_ins(kst_tab_meca)
//				k_lotto =  " "
//				k_lotto_pic = " "
//				if kst_esito.esito = kkg_esito.ok then
				kst_tab_meca.id = dw_lista_0.getitemnumber(k_riga, "id_meca")
				ki_xplistbar_info_num[ki_xplistbar_riga_lotto] = kst_tab_meca.id
				if kst_tab_meca.id > 0 then //~r"
					kst_tab_meca.num_int = dw_lista_0.getitemnumber(k_riga, "num_int")
					kst_tab_meca.data_int = dw_lista_0.getitemdate(k_riga, "data_int")
					k_lotto = "Lotto.: " + string(kst_tab_meca.num_int) + "  " +string(kst_tab_meca.data_int, "dd/mm/yy")
					k_lotto_pic = 'molletta.gif'
				end if
				
				kst_tab_clienti.codice = dw_lista_0.getitemnumber(k_riga, "id_cliente")
				ki_xplistbar_info_num[ki_xplistbar_riga_clienti] = kst_tab_clienti.codice
				if kst_tab_clienti.codice > 0 then 
					kuf1_clienti.get_nome(kst_tab_clienti)
					k_cliente = trim(kst_tab_clienti.rag_soc_10) 
					k_cliente_pic = 'molletta.gif'
				end if
			
//		//--- piglia i dati dell'ultimo d.d.t.		
//				kst_tab_sped.clie_2 = kst_tab_memo.id_memo
//				kst_esito = kuf1_sped.get_ultimo_doc(kst_tab_sped)
//				k_sped =  " "
//				k_sped_pic = " "
//				if kst_esito.esito = kkg_esito.ok then
//					ki_xplistbar_info_num[ki_xplistbar_riga_sped] = kst_tab_sped.num_bolla_out 
//					ki_xplistbar_info_data[ki_xplistbar_riga_sped] = kst_tab_sped.data_bolla_out 
//					if kst_tab_sped.num_bolla_out > 0 then
//						k_sped = "ult.Sped.: " + string(kst_tab_sped.num_bolla_out) + "  " +string(kst_tab_sped.data_bolla_out, "dd/mm/yy")
//						k_sped_pic = 'molletta.gif'
//					end if
//				end if
				
//		//--- set dei valori nella xp-listbar
////				dw_xplistbar_info.setredraw( false)
//				if isnull(kst_tab_memo.rag_soc_10) then
//					dw_xplistbar_info.of_setitem( ki_xplistbar_riga_info, " Info ", "") // + "~n~r" + mid(trim(kst_tab_memo.rag_soc_10),13,17), " ")
//				else					
//					dw_xplistbar_info.of_setitem( ki_xplistbar_riga_info, " Info di " + left(trim(kst_tab_memo.rag_soc_10),12), "") // + "~n~r" + mid(trim(kst_tab_memo.rag_soc_10),13,17), " ")
//				end if
				dw_xplistbar_info.of_setitem( ki_xplistbar_riga_lotto, k_lotto, k_lotto_pic)
				dw_xplistbar_info.of_setitem( ki_xplistbar_riga_clienti, k_cliente, k_cliente_pic)
//				dw_xplistbar_info.of_setitem( ki_xplistbar_riga_fatt, k_fatt, k_fatt_pic)
//				dw_xplistbar_info.of_setitem( ki_xplistbar_riga_certif, k_certif, k_certif_pic)
				dw_xplistbar_info.setredraw( true)
			end if	
		
//			SetPointer(oldpointer)
			
		end if
	end if
	dw_lista_0.setfocus( )
		
else
	dw_mkt.title = " Nessun dato presente " 
	dw_web.title = " Nessun Allegato presente "
	dw_mkt.reset( )
	dw_web.reset()
	if ki_xplistbar_riga_INFO > 0 then // se esiste il paragrafo INFO...
		ki_xplistbar_info_num[ki_xplistbar_riga_lotto] = 0 
//		ki_xplistbar_info_num[ki_xplistbar_riga_sped] = 0  
//		ki_xplistbar_info_data[ki_xplistbar_riga_sped] = date(0) 
//		ki_xplistbar_info_num[ki_xplistbar_riga_fatt] = 0
//		ki_xplistbar_info_num[ki_xplistbar_riga_certif] = 0
//--- set dei valori nella xp-listbar
//		dw_xplistbar_info.setredraw( false)
		dw_xplistbar_info.of_setitem( ki_xplistbar_riga_info, " Info  ", "")
		dw_xplistbar_info.of_setitem( ki_xplistbar_riga_lotto, k_lotto, k_lotto_pic)
//		dw_xplistbar_info.of_setitem( ki_xplistbar_riga_sped, k_sped, k_sped_pic)
//		dw_xplistbar_info.of_setitem( ki_xplistbar_riga_fatt, k_fatt, k_fatt_pic)
//		dw_xplistbar_info.of_setitem( ki_xplistbar_riga_certif, k_certif, k_certif_pic)
		dw_xplistbar_info.setredraw( true)
	end if
end if
	

end subroutine

private subroutine ripristina_ult_uscita ();//---
//--- Recupera le impostazioni dell'ultima chiusura della finestra e le ripropone
//---
string k_rcx
st_profilestring_ini kst_profilestring_ini


//--- Ripri il numero il tipo di richiesta in cui era attivo
		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.nome = trim(kiw_this_window.classname()) + "_" + "setRigaXpListBar"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

		if isnumber(trim(kst_profilestring_ini.valore)) then
			dw_xplistbar.setrow(integer(trim(kst_profilestring_ini.valore)))
			dw_xplistbar.event ue_clicked(integer (trim(kst_profilestring_ini.valore))) //lancia inizializza()
	
//--- Ripri il numero di riga in cui era
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
	kiuf_memo_utenti = create kuf_memo_utenti
	kiuf_memo = create kuf_memo

//--- param di input	
	ki_tipo = trim(ki_st_open_w.key1)
	ki_stato = trim(ki_st_open_w.key2)
	if isnumber(trim(ki_st_open_w.key3)) then
		ki_id = long(ki_st_open_w.key3)
	end if
	ki_settore	= trim(ki_st_open_w.key4)
	if isnumber(ki_st_open_w.key5) then
		ki_id_cliente = long(ki_st_open_w.key5)
	else
		ki_id_cliente = 0
	end if
	if isnumber(ki_st_open_w.key6) then
		ki_id_meca = long(ki_st_open_w.key6)
	else
		ki_id_meca = 0
	end if
	
//--- inizializza box periodo
	dw_periodo.inizializza( kiw_this_window )
	dw_periodo.ki_data_ini = relativedate(dw_periodo.ki_data_fin, -365)
	
	ki_toolbar_window_presente=true

	kist_tab_memo_utenti.id_sr_utente = kguo_utente.get_id_utente( )
	
	ki_trova_campo_def = 2 // setta il campo di default x il TROVA

	kiw_this_window.icon = "mkt_icona.ico"
//	kiw_this_window.icon = kGuo_path.get_risorse() +  "\" + "mkt_icona.ico"
	
//	this.tab_1.tabpage_1.picturename = kGuo_path.get_risorse() + "\" + "cliente.gif"

//--- Funzione di TROVA: Salva la Query di Origine (devo pero' add il TILDE altrimenti quando ripristino non va bene!!!-------------
	int k_pos
	int kstart_pos = 1
	
	ki_sqlsyntax_origine = upper(dw_lista_0.Describe("DataWindow.Table.Select"))
	// Aggiunge al APICE la TILDE ( ' con ~~')
	kstart_pos = pos(ki_sqlsyntax_origine, "'", 1)
	DO WHILE kstart_pos > 0
		 ki_sqlsyntax_origine = Replace(ki_sqlsyntax_origine, kstart_pos, 1, "~~'")
		 kstart_pos = pos(ki_sqlsyntax_origine, "'", kstart_pos+2 )
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

	case kkg_flag_richiesta.libero6		//cambia data di estrazione
		cambia_periodo_elenco()

	case else
		super::smista_funz(k_par_in)

end choose

end subroutine

protected function string inizializza_post ();//
long k_riga = 0
ki_primo_giro=false

if trim(ki_st_open_w.key1) = "" and trim(ki_st_open_w.key2) = "" then
	ripristina_ult_uscita()
else
	choose case ki_stato
		case kiuf_memo.kki_memo_daleggere
			k_riga = ki_xpl_nuovi
		case kiuf_memo.kki_memo_tutti
			k_riga = ki_xpl_Completa
		case kiuf_memo.kki_memo_attivi
			k_riga = ki_xpl_attivi
		case kiuf_memo.kki_memo_rimossi
			k_riga = ki_xpl_rimossi
		case else
			k_riga = ki_xpl_attivi
	end choose

	inizializza_ramo(k_riga)	
end if
		
//--- lancia il cerca...
//if ki_settore > " " then
//	dw_xplistbar_trova.setitem( 1, "item_input", ki_settore)
//	dw_xplistbar_trova.trigger Event ue_clicked(1) 
//end if
//--- chiude il ramo "INFO"  	
dw_xplistbar_info.trigger Event ue_clicked_0(ki_xplistbar_riga_INFO, "") 
	

return "0"
end function

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
string k_query,k_select_orig, k_select, k_order_by, k_select_new, k_rc
int k_pos
int kstart_pos = 1
string k_valore


k_valore = "%" + upper(k_par_valore) + "%"

k_query = &
  " SELECT DISTINCT memo.id_memo  " &
  	+ "FROM memo left outer join memo_link on memo.id_memo = memo_link.id_memo   " &
  	+ "                  left outer join clienti_memo on memo.id_memo = clienti_memo.id_memo   " &
  	+ "			  left outer join clienti on clienti_memo.id_cliente = clienti.codice " &
  	+ "                  left outer join meca_memo on memo.id_memo = meca_memo.id_memo   " &
  	+ "			  left outer join meca on meca_memo.id_meca = meca.id " &
  	+ "WHERE (~~'" + k_valore + "~~' = ~~'%%~~' or memo.titolo like ~~'" + k_valore + "~~' OR memo.note like ~~'" + k_valore + "~~' " & 
  	+ "           OR memo_link.titolo like ~~'" + k_valore + "~~' OR memo_link.link like ~~'" + k_valore + "~~' OR memo_link.nome like ~~'" + k_valore + "~~' ) " &
	+ " or upper(coalesce(clienti.codice,~~~' ~~~')+coalesce(clienti.p_iva,~~~' ~~~')+coalesce(clienti.cf,~~~' ~~~')+coalesce(clienti.rag_soc_10,~~~' ~~~')+coalesce(clienti.rag_soc_11,~~' ~~')+coalesce(clienti.rag_soc_20,~~' ~~')) " &
	+ " like ~~'" + k_valore + "~~' "  &
	+ " or coalesce(memo.tipo_sv,~~' ~~') " + " like ~~'" + k_valore + "~~' "  & 
	+ " or coalesce(memo.x_utente,~~' ~~') " + " like ~~'" + k_valore + "~~' "  & 
	+ " or coalesce(memo.utente_ins,~~' ~~') " + " like ~~'" + k_valore + "~~' "  & 
	+ " or coalesce(meca.num_int,~~' ~~') " + " like ~~'" + k_valore + "~~' "  & 
	+ " or coalesce(meca.id,~~' ~~') " + " like ~~'" + k_valore + "~~' "  
 

k_select_orig = ki_sqlsyntax_origine //upper(dw_lista_0.Describe("DataWindow.Table.Select"))

//=== Cerca la clausola where nella select per sostituirla
k_pos = Pos(k_select_orig, "ORDER BY")
if k_pos > 0 then
	k_select = Left(k_select_orig, k_pos - 1)
	k_order_by = mid(k_select_orig, k_pos)
end if

//// Aggiunge al APICE la TILDE ( ' con ~~')
//kstart_pos = pos(k_select, "'", 1)
//DO WHILE kstart_pos > 0
//    k_select = Replace(k_select, kstart_pos, 1, "~~'")
//    kstart_pos = pos(k_select, "'", kstart_pos+2 )
//LOOP

k_select_new = "DataWindow.Table.Select='" &
	+ k_select + " and memo.id_memo in (" + k_query + ") " + k_order_by + "'"

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

public function long u_retrieve ();//
//---
//---  Fa la Retrieve
//---
long k_return=0	
long k_id_utente=0
datetime k_data_da, k_data_a
st_tab_memo_utenti kst_tab_memo_utenti_da, kst_tab_memo_utenti_a



	try

		SetPointer(kkg.pointer_attesa)
	
		dw_lista_0.event set_titolo( )

		choose case ki_tipo
			case kiuf_memo.kki_tipovisualizza_xUTENTE
				ki_id = 0
			case kiuf_memo.kki_tipovisualizza_xMECA
				if ki_id = 999999 or ki_id = 0 then
					ki_id = 888888 
				end if
			case kiuf_memo.kki_tipovisualizza_xANAG
				if ki_id = 888888 or ki_id = 0 then
					ki_id = 999999
				end if
			case else
				ki_id = 0
		end choose
		
		if isnull(ki_stato) then
			ki_stato = kiuf_memo.kki_memo_daleggere 
		end if
		choose case ki_stato
			case kiuf_memo.kki_memo_daleggere
				kst_tab_memo_utenti_da.stato = kiuf_memo_utenti.kki_stato_nuovo
				kst_tab_memo_utenti_a.stato = kiuf_memo_utenti.kki_stato_nuovo
			case kiuf_memo.kki_memo_attivi
				kst_tab_memo_utenti_da.stato = kiuf_memo_utenti.kki_stato_nuovo
				kst_tab_memo_utenti_a.stato = kiuf_memo_utenti.kki_stato_letto
			case kiuf_memo.kki_memo_tutti
				kst_tab_memo_utenti_da.stato = kiuf_memo_utenti.kki_stato_nuovo
				kst_tab_memo_utenti_a.stato = kiuf_memo_utenti.kki_stato_rimosso
			case kiuf_memo.kki_memo_rimossi
				kst_tab_memo_utenti_da.stato = kiuf_memo_utenti.kki_stato_rimosso
				kst_tab_memo_utenti_a.stato = kiuf_memo_utenti.kki_stato_rimosso
		end choose
		
		k_data_da = datetime( dw_periodo.ki_data_ini)
		k_data_a = datetime( relativedate(dw_periodo.ki_data_fin, 1))
		
		kst_tab_memo_utenti_da.x_utente = "*"
		
		dw_lista_0.reset()  
		k_return = dw_lista_0.retrieve(ki_id, ki_id_cliente, ki_id_meca, kst_tab_memo_utenti_da.stato, kst_tab_memo_utenti_a.stato, kst_tab_memo_utenti_da.x_utente, kist_tab_memo_utenti.id_sr_utente , k_data_da, k_data_a)
		if trim(ki_settore) > " " then
			dw_lista_0.setfilter("tipo_sv = '" + trim(ki_settore) + "' ")
			dw_lista_0.TItle = "Elenco Memo per il Settore  '" + trim(ki_settore) + "' "
			ki_settore = ""
		else
			dw_lista_0.setfilter("")
		end if
		dw_lista_0.filter( )
			
		choose case ki_tipo
			case kiuf_memo.kki_tipovisualizza_xUTENTE
				dw_lista_0.setsort("x_datins")
			case kiuf_memo.kki_tipovisualizza_xMECA
				dw_lista_0.setsort("data_int, num_int")
			case kiuf_memo.kki_tipovisualizza_xANAG
				dw_lista_0.setsort("rag_soc_10")
			case else
				dw_lista_0.setsort("x_datins")
		end choose
		dw_lista_0.sort( )

		dw_lista_0.setfocus( )

		
	catch (uo_exception kuo_excepion)
		kuo_excepion.messaggio_utente()


	finally
		attiva_tasti( )
		dw_lista_0.setredraw(true)
		dw_lista_0.visible = true
		SetPointer(kkg.pointer_default)

		
	end try
	
return k_return

end function

protected subroutine cambia_periodo_elenco ();//---
//--- Visualizza il box x il cambio del Periodo di elenco fatture 
//---


dw_periodo.event ue_visible( )

end subroutine

protected subroutine attiva_menu ();//
//
//--- Attiva/Dis. Voci di menu personalizzate
//

//	if ki_attiva_toolbar_periodo then
		if NOT ki_menu.m_strumenti.m_fin_gest_libero6.enabled then 
			ki_menu.m_strumenti.m_fin_gest_libero6.text = "Cambia il periodo di estrazione elenco "
			ki_menu.m_strumenti.m_fin_gest_libero6.microhelp =  "Cambia periodo di estrazione "
			ki_menu.m_strumenti.m_fin_gest_libero6.visible = true
			ki_menu.m_strumenti.m_fin_gest_libero6.enabled = true
			ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemVisible = true
			ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemText = "Periodo,"+ki_menu.m_strumenti.m_fin_gest_libero6.text
			ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemName = "Custom015!"
			ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritembarindex=2
		end if
//	end if	

//--- Attiva/Dis. Voci di menu
	super::attiva_menu()
	
	
end subroutine

protected subroutine cancella_memo ();//
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_tab_memo kst_tab_memo
st_tab_clienti kst_tab_clienti
st_esito kst_esito


if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if


k_riga = dw_lista_0.getselectedrow(0)	
if k_riga > 0 then
	
	kst_tab_memo.id_memo = dw_lista_0.getitemnumber(k_riga, "id_memo")
	kst_tab_memo.titolo  = dw_lista_0.getitemstring(k_riga, "titolo")

	if isnull(kst_tab_memo.titolo) = true or trim(kst_tab_memo.titolo) = "" then
		kst_tab_memo.titolo = "*senza titolo* " 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina MEMO", "Sei sicuro di voler Cancellare il MEMO " + string(kst_tab_memo.id_memo)  + " : ~n~r" &
	         + trim(kst_tab_memo.titolo),  &
				question!, yesno!, 2) = 1 then
		
		try
		
//=== Cancella la riga dal data windows di lista
			if kiuf_memo.tb_delete( kst_tab_memo ) then

		
				dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
				dw_lista_0.deleterow(k_riga)

				dw_lista_0.setfocus()
			else
				kguo_exception.inizializza( )
				kguo_exception.messaggio_utente( "Cancellazione MEMO", "Operazione non eseguita")
			end if

			
		catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente( "Cancellazione Fallita", "")

			attiva_tasti()

		end try


	else
		kguo_exception.inizializza( )
		kguo_exception.messaggio_utente( "Cancellazione MEMO", "Operazione Annullata")

	end if
end if



end subroutine

private subroutine call_nuovo_memo ();//
//=== Legge il rek dalla DW lista per Inserimento

long k_riga
st_memo kst_memo
st_tab_g_0 kst_tab_g_0
kuf_menu_window kuf1_menu_window

try
	k_riga = dw_lista_0.getrow()
	if k_riga > 0 then
	
		kst_memo.st_tab_memo.id_memo = 0
			
		if kst_memo.st_tab_memo.id_memo  > 0 then
	
			kiuf_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.inserimento)
			
		end if
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try


end subroutine

private subroutine inizializza_ramo (integer a_attiva_ramo);//---
//--- Attiva il ramo e lancia inizializza standard
//---

	dw_xplistbar.setrow(a_attiva_ramo)
	dw_xplistbar.event ue_clicked(a_attiva_ramo) //lancia inizializza()
	if dw_lista_0.rowcount() > 0 then
		dw_lista_0.selectrow(0, false)
		dw_lista_0.selectrow(1, true)
		dw_lista_0.setrow(1)
	end if
				


end subroutine

protected function integer inserisci ();//
//=== Legge il rek dalla DW lista per Inserimento

long k_riga
st_memo kst_memo
st_tab_g_0 kst_tab_g_0
kuf_menu_window kuf1_menu_window

try
	k_riga = dw_lista_0.getrow()
	if k_riga > 0 then
	
		kst_memo.st_tab_memo.id_memo = 0
		kiuf_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.inserimento)
			
	end if

catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_riga
end function

protected function integer modifica ();//
//=== Legge il rek dalla DW lista per la modifica

long k_riga
st_memo kst_memo
st_tab_g_0 kst_tab_g_0
kuf_menu_window kuf1_menu_window


try

	k_riga = dw_lista_0.getrow()
	if k_riga > 0 then
	
		kst_memo.st_tab_memo.id_memo = dw_lista_0.getitemnumber( k_riga, "id_memo" ) 

//--- se sono sui RIMOSSI prima di modificarlo devo RIPRISTINARLO
		if dw_xplistbar.getrow( ) = ki_xpl_rimossi then
			if messagebox("Ripristino MEMO", "Vuoi ripristinare il memo " + string(kst_memo.st_tab_memo.id_memo) + " che era stato rimosso? ", question!, yesno!, 1) = 1 then
				u_cambia_stato(dw_lista_0.getrow( ))
			end if
		else

//--- entra in MODIFICA			
			if kst_memo.st_tab_memo.id_memo  > 0 then
		
				kiuf_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.modifica)
				
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_riga


end function

protected function integer visualizza ();//
//=== Legge il rek dalla DW lista per la Visualizzazione
long k_riga
st_memo kst_memo
st_tab_g_0 kst_tab_g_0
kuf_menu_window kuf1_menu_window


try

	k_riga = dw_lista_0.getrow()
	if k_riga > 0 then
	
		kst_memo.st_tab_memo.id_memo = dw_lista_0.getitemnumber( k_riga, "id_memo" ) 
			
		if kst_memo.st_tab_memo.id_memo  > 0 then
	
			kiuf_memo.u_attiva_funzione(kst_memo, kkg_flag_modalita.visualizzazione)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try

return k_riga


end function

public subroutine u_cambia_stato (long a_riga);//
//long k_riga = 0
st_tab_memo_utenti kst_tab_memo_utenti


try
	if a_riga > 0 then
		kst_tab_memo_utenti.id_memo_utente = dw_lista_0.getitemnumber(a_riga, "id_memo_utente")
		if kst_tab_memo_utenti.id_memo_utente > 0 then
			kst_tab_memo_utenti.stato = kiuf_memo_utenti.get_stato(kst_tab_memo_utenti)
			if kst_tab_memo_utenti.stato = kiuf_memo_utenti.kki_stato_rimosso then   // era nello stato di RIMOSSO?
				kst_tab_memo_utenti.contatore = kiuf_memo_utenti.get_contatore(kst_tab_memo_utenti)
				kiuf_memo_utenti.set_stato_nuovo(kst_tab_memo_utenti)   // prima lo metto a NUOVO
				if kst_tab_memo_utenti.contatore > 0 then
					 kiuf_memo_utenti.set_stato_letto(kst_tab_memo_utenti)  // poi se l'avevo già letto lo metto tale
				end if
			else
				 kiuf_memo_utenti.set_stato_rimosso(kst_tab_memo_utenti)  // se non era RIMOSSO lo metto tale
			end if
			smista_funz(KKG_FLAG_RICHIESTA.refresh)
		end if
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()


end try
end subroutine

protected function string cancella ();//

if dw_xplistbar.getrow( ) = ki_xpl_rimossi then
	cancella_memo()
else
	u_cambia_stato(dw_lista_0.getrow( ))
end if

return "0"

end function

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

            
//attiva_menu()


end subroutine

public subroutine u_resize_1 ();int k_dist_bordi, k_spess_bordi_x, k_spess_bordi_y


//	if sizetype <> 1 or isnull(sizetype) then		

		this.setredraw(false)
		
//		NewHeight = this.height
//		NewWidth = this.width
		
		k_dist_bordi = 5
		k_spess_bordi_x = 5 // 65
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

		
		this.setredraw(false)
		
		if ki_st_open_w.flag_adatta_win = KKG.ADATTA_WIN 	and not(ki_personalizza_pos_controlli) then
	
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
			dw_lista_0.visible = true
			dw_mkt.visible = true
			dw_web.visible = true
	
		end if
	
		dw_xplistbar.visible = true
		dw_xplistbar_trova.visible = true
		dw_xplistbar_info.visible = true
	
		this.setredraw(true)
	
//	end if


end subroutine

on w_memo_mkt.create
int iCurrent
call super::create
this.dw_xplistbar=create dw_xplistbar
this.dw_mkt=create dw_mkt
this.dw_web=create dw_web
this.dw_xplistbar_info=create dw_xplistbar_info
this.dw_xplistbar_trova=create dw_xplistbar_trova
this.dw_periodo=create dw_periodo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_xplistbar
this.Control[iCurrent+2]=this.dw_mkt
this.Control[iCurrent+3]=this.dw_web
this.Control[iCurrent+4]=this.dw_xplistbar_info
this.Control[iCurrent+5]=this.dw_xplistbar_trova
this.Control[iCurrent+6]=this.dw_periodo
end on

on w_memo_mkt.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_xplistbar)
destroy(this.dw_mkt)
destroy(this.dw_web)
destroy(this.dw_xplistbar_info)
destroy(this.dw_xplistbar_trova)
destroy(this.dw_periodo)
end on

event close;call super::close;//--- Salva le impostazioni x poterle recuperare al prx avvio
salva_impostazioni()


end event

event timer;call super::timer;////--- rilegge automaticamente se per un tot di tempo non si fa nulla sul navigatore
//if relativetime ( ki_time_rileggi_auto, 1800 ) < now() then
//
////---- reinizializza il timer per eventuale auto-lettura
//	ki_time_rileggi_auto = now()
//
////--- rilegge le liste 	
//	smista_funz(kkg_flag_richiesta_refresh)
//
//else
//	
//	//--- rilegge automaticamente se per un tot di tempo non si fa nulla sul navigatore
//	if relativetime ( ki_time_riga, 1 ) < now() then
//	
//	//---- reinizializza il timer per eventuale auto-lettura del dettaglio
//		ki_time_riga = now()
//	
//	//--- rilegge le liste 	
//		leggi_dw_dettaglio()
//	
////--- x evitare uno strano fenomeno di spostamento dell'elenco in basso.....
//		dw_xplistbar_info.enabled = true
//
//	end if
//end if
//
//
end event

type st_ritorna from w_g_tab0`st_ritorna within w_memo_mkt
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_memo_mkt
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_memo_mkt
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_memo_mkt
end type

type st_stampa from w_g_tab0`st_stampa within w_memo_mkt
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_memo_mkt
end type

type cb_modifica from w_g_tab0`cb_modifica within w_memo_mkt
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_memo_mkt
end type

type cb_cancella from w_g_tab0`cb_cancella within w_memo_mkt
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_memo_mkt
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_memo_mkt
integer x = 1819
integer y = 1648
integer width = 722
integer height = 248
end type

type st_orizzontal from w_g_tab0`st_orizzontal within w_memo_mkt
integer x = 1339
integer y = 756
integer width = 1307
boolean enabled = false
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_memo_mkt
event set_titolo ( )
integer x = 992
integer y = 24
integer width = 2930
integer height = 764
boolean titlebar = true
string title = "MEMO"
string dataobject = "d_memo_l_mkt"
boolean controlmenu = true
boolean maxbox = true
boolean resizable = true
boolean ki_link_standard_sempre_possibile = true
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

////---- inizia il timer per eventuale auto-lettura
//ki_time_rileggi_auto = now()
//ki_time_riga = now()


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
ki_time_rileggi_auto = now()
ki_time_riga = now()

//---- Scatena il timer (vedi l'evento)
//manda in crash m2000	timer (0.30)
//--- rilegge le liste 	
	leggi_dw_dettaglio()
//--- x evitare uno strano fenomeno di spostamento dell'elenco in basso.....
//	dw_xplistbar_info.enabled = true

end event

event dw_lista_0::losefocus;call super::losefocus;//---- Spegne il timer (vedi l'evento)
	timer (0)

end event

event dw_lista_0::rowfocuschanged;call super::rowfocuschanged;//--- rilegge le liste 	
	leggi_dw_dettaglio()
//--- x evitare uno strano fenomeno di spostamento dell'elenco in basso.....
//	dw_xplistbar_info.enabled = true

end event

type dw_guida from w_g_tab0`dw_guida within w_memo_mkt
end type

type dw_xplistbar from u_dw_xplistbar within w_memo_mkt
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
ll_parent = THIS.of_AddItem('header','MEMO  ',0, '')
 
ki_xpl_nuovi = THIS.of_AddItem('child',' Da Leggere ',ll_parent, 'balloon_nuovi32.png')
ki_xpl_Attivi = THIS.of_AddItem('child',' Attivi ',ll_parent, 'balloon_attivi32.png')  //~r
THIS.of_AddItem('child',' ',ll_parent, ' ')
//ki_xpl_Letti_contattatto = THIS.of_AddItem('child','Letti ',ll_parent, 'cliente_contattato.gif')
ki_xpl_xLotto = THIS.of_AddItem('child',' per Lotto ',ll_parent, 'balloon_xlotto32.png')
ki_xpl_xCliente = THIS.of_AddItem('child',' per Cliente ',ll_parent, 'balloon_xcliente32.png')
THIS.of_AddItem('child',' ',ll_parent, ' ')
//ki_xpl_Attivi = THIS.of_AddItem('child','Attivi',ll_parent, 'baloon_completa32.png')
ki_xpl_Completa = THIS.of_AddItem('child',' Tutti ',ll_parent, 'balloon_completa32.png')
THIS.of_AddItem('child',' ',ll_parent, ' ')
ki_xpl_Rimossi = THIS.of_AddItem('child',' Rimossi ',ll_parent, 'balloon_rimossi32.png')
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
			
		case ki_xpl_nuovi
			ki_xpl_SCELTA = kriga
			ki_tipo = kiuf_memo.kki_tipovisualizza_xUtente
			ki_stato = kiuf_memo.kki_memo_daleggere
			inizializza()
			
		case ki_xpl_Attivi
			ki_xpl_SCELTA = kriga
			ki_tipo = kiuf_memo.kki_tipovisualizza_xUtente 
			ki_stato = kiuf_memo.kki_memo_Attivi
			inizializza()
			
		case ki_xpl_xLotto
			ki_xpl_SCELTA = kriga
			ki_tipo = kiuf_memo.kki_tipovisualizza_xMeca
			ki_stato = kiuf_memo.kki_memo_attivi
			inizializza()
			
		case ki_xpl_xCliente
			ki_xpl_SCELTA = kriga
			ki_tipo = kiuf_memo.kki_tipovisualizza_xAnag
			ki_stato = kiuf_memo.kki_memo_attivi
			inizializza()
			
		case ki_xpl_Rimossi
			ki_xpl_SCELTA = kriga
			ki_tipo = kiuf_memo.kki_tipovisualizza_xUtente 
			ki_stato = kiuf_memo.kki_memo_rimossi
			inizializza()
			
		case ki_xpl_Completa
			ki_xpl_SCELTA = kriga
			ki_tipo = kiuf_memo.kki_tipovisualizza_xUtente
			ki_stato = kiuf_memo.kki_memo_tutti 
			inizializza()

		case 0
			ki_xpl_SCELTA = 0
			ki_tipo = ""
			ki_stato = ""
			inizializza()
			
//		case ki_xplistbar_riga_lotto & 
//			,ki_xplistbar_riga_fatt &
//			,ki_xplistbar_riga_sped &
//			,ki_xplistbar_riga_certif 
//			ki_xpl_SCELTA_info = kriga
//			call_anteprima()
			
		case else
			ki_xpl_SCELTA = 0
			ki_tipo = ""
			ki_stato = ""
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

type dw_mkt from uo_d_std_1 within w_memo_mkt
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
string title = "Proprietà Memo"
string dataobject = "d_memo"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_sort = false
boolean ki_d_std_1_attiva_cerca = false
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

type dw_web from uo_d_std_1 within w_memo_mkt
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
string title = "Allegati Memo"
string dataobject = "d_memo_link_l"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = false
boolean ki_link_standard_sempre_possibile = true
boolean ki_colora_riga_aggiornata = false
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

type dw_xplistbar_info from u_dw_xplistbar within w_memo_mkt
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
////ki_xplistbar_riga_lotto=THIS.of_AddItem('child','-',ll_parent, '') //'molletta.gif')
ki_xplistbar_riga_clienti=THIS.of_AddItem('child',' ',ki_xplistbar_riga_INFO, ' ' ) //'Ult. Fattura: ',ll_parent, '' )
////ki_xplistbar_riga_fatt=THIS.of_AddItem('child','-',ll_parent, '') 
//ki_xplistbar_riga_sped=THIS.of_AddItem('child',' ',ki_xplistbar_riga_INFO, ' ' ) //'Ult. Spedizione: ',ll_parent, '' )
////ki_xplistbar_riga_sped=THIS.of_AddItem('child','-',ll_parent, '') 
//ki_xplistbar_riga_certif=THIS.of_AddItem('child',' ',ki_xplistbar_riga_INFO, ' ' ) //'Ult. Attestato: ',ll_parent, '' )
////ki_xplistbar_riga_certif=THIS.of_AddItem('child','-',ll_parent, '') 
THIS.of_AddItem('filler','',ki_xplistbar_riga_INFO, '')//filler is necessary for looks
this.setredraw( true )

end event

event constructor;call super::constructor;//
Long ll_parent

////Add new item
//ll_parent = THIS.of_AddItem('header','Anagrafe  ',0, '')
// 
//ki_xpl_nuovi = THIS.of_AddItem('child','Contatti ',ll_parent, 'contatti_rubrica.gif')
//ki_xpl_Letti = THIS.of_AddItem('child','Potenziali da~rcontattare ',ll_parent, 'cliente_potenziale.gif')
//ki_xpl_Letti_contattatto = THIS.of_AddItem('child','Potenziali in~rcontatto ',ll_parent, 'cliente_contattato.gif')
//ki_xpl_xLotto = THIS.of_AddItem('child','Attivi~rparziali ',ll_parent, 'cliente_parziale.gif')
//ki_xpl_xCliente = THIS.of_AddItem('child','Attivi ~rcompleti  ',ll_parent, 'cliente_in_prod.gif')
//ki_xpl_TuttieRimossi = THIS.of_AddItem('child','Chiusi ',ll_parent, 'cliente_close.gif')
//ki_xpl_Attivi = THIS.of_AddItem('child','Tutti',ll_parent, 'clienti.gif')
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
			
//		case ki_xpl_nuovi
//			ki_xpl_SCELTA = kriga
//			ki_st_open_w.key1 = kiuf_clienti.kki_tipo_contatto
//			ki_st_open_w.key2 = ""
//			inizializza()
//			
//		case ki_xpl_Letti
//			ki_xpl_SCELTA = kriga
//			ki_st_open_w.key1 = "" 
//			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_potenziale_da_contattare 
//			inizializza()
//			
//		case ki_xpl_Letti_contattatto
//			ki_xpl_SCELTA = kriga
//			ki_st_open_w.key1 = "" 
//			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_potenziale_in_contatto 
//			inizializza()
//			
//		case ki_xpl_xLotto
//			ki_xpl_SCELTA = kriga
//			ki_st_open_w.key1 = "" 
//			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_attivo_parziale
//			inizializza()
//			
//		case ki_xpl_xCliente
//			ki_xpl_SCELTA = kriga
//			ki_st_open_w.key1 = "" //kiuf_clienti.kki_tipo_fatturato
//			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_attivo
//			inizializza()
//			
//		case ki_xpl_TuttieRimossi
//			ki_xpl_SCELTA = kriga
//			ki_st_open_w.key1 = "" //kiuf_clienti.kki_tipo_fatturato
//			ki_st_open_w.key2 = kiuf_clienti.kki_cliente_stato_estinto 
//			inizializza()
//			
//		case ki_xpl_Attivi
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
			,ki_xplistbar_riga_clienti 
//			,ki_xplistbar_riga_sped &
//			,ki_xplistbar_riga_certif 
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
		ki_id_memo_letto_INFO = 0
	end if

	this.setredraw( true )
end if
end event

type dw_xplistbar_trova from u_dw_trova within w_memo_mkt
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

type dw_periodo from uo_dw_periodo within w_memo_mkt
integer x = 416
integer y = 1468
integer taborder = 60
boolean bringtotop = true
end type

event ue_clicked;call super::ue_clicked;//
try
	inizializza( )
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try

		
end event

