$PBExportHeader$w_contratti_xsmart.srw
forward
global type w_contratti_xsmart from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_contratti_xsmart from w_g_tab_3
integer x = 169
integer y = 148
integer width = 3214
integer height = 1680
string title = "Esporta dati x il WEB"
long backcolor = 32501743
integer animationtime = 0
boolean ki_toolbar_window_presente = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_toolbar_programmi_attiva_voce = false
boolean ki_nessun_tasto_funzionale = true
boolean ki_sincronizza_window_consenti = false
boolean ki_fai_nuovo_dopo_update = false
boolean ki_fai_nuovo_dopo_insert = false
boolean ki_msg_dopo_update = false
string ki_syntaxquery = ""
string ki_dw_titolo_modif_1 = ""
end type
global w_contratti_xsmart w_contratti_xsmart

type variables
//
private date ki_data_estrazione
end variables

forward prototypes
protected function string inizializza ()
protected subroutine open_start_window ()
protected subroutine attiva_menu ()
public subroutine u_esporta ()
public subroutine smista_funz (string k_par_in)
protected subroutine inizializza_1 () throws uo_exception
protected subroutine attiva_tasti_0 ()
end prototypes

protected function string inizializza ();//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
int k_rc



	if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
		tab_1.tabpage_1.text = " Elenco Contratti attivi al " + string(ki_data_estrazione)
		k_rc = tab_1.tabpage_1.dw_1.retrieve(ki_data_estrazione) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

		end choose

		tab_1.tabpage_1.dw_1.event getfocus( )
		
	end if


	
return "0"


end function

protected subroutine open_start_window ();//
	ki_data_estrazione = kguo_g.get_dataoggi( )
	
end subroutine

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Esporta Dati"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = "Esporta elenco per il WEB (SMART)"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Esporta,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "csv32.png" //kguo_path.get_risorse( ) + KKG.PATH_SEP + "csv32.png"
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
	end if	

//---
	super::attiva_menu()

end subroutine

public subroutine u_esporta ();//
string k_file, k_path, k_nulla="", k_ext="csv", k_path_orig, k_rcx 
integer k_nr_rec, k_nrc, k_id_stampa
boolean k_errore=false, k_elab=true
string k_titolo, k_dato_base
datawindow kdw_1
DataStore kds_1
st_open_w k_st_open_w
kuf_base kuf1_base
kuf_file_explorer kuf1_file_explorer
kuf_utility kuf1_utility


try	
	
	kuf1_utility = create kuf_utility

//--- get di quale elenco esportare	
	choose case tab_1.selectedtab 
		case 1 
			k_titolo = trim(tab_1.tabpage_1.text)
			kdw_1 = tab_1.tabpage_1.dw_1
		case 2 
			k_titolo = trim(tab_1.tabpage_2.text)
			kdw_1 = tab_1.tabpage_2.dw_2
	end choose
	
//	k_path = trim(kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_leggi, "arch_esolver_anag", trim(GetCurrentDirectory ( )) + KKG.PATH_SEP + "esolver.csv"))
	string k_esito=""
	kuf1_base = create kuf_base
	k_dato_base = "xsmart_" + kuf1_utility.u_stringa_compatta(k_titolo)
	k_esito = kuf1_base.prendi_dato_base(k_dato_base)
	if left(k_esito,1) <> "0" then
		k_path = "" // ERRORE
	else
		k_path = trim(mid(k_esito,2))
	end if
	destroy kuf1_base
	k_path_orig = k_path
	
	do
		k_nrc = GetFileSaveName("Nome del file per esportare '" + k_titolo + "' nel formato 'csv'" &
               				, k_path, k_file, "csv", "Testo (*.csv),*.csv",k_path)
		if k_nrc <= 0 then
			k_elab = false
		else
			if fileexists(k_path) then
				k_nrc = messagebox("Selezionato archivio",  "Archivio già presente.~n~r" + "File: " + trim(k_path) + "~n~r" &
					  + "Vuoi Sovrascriverlo?",  question!, yesnocancel!, 2) 
			else
				k_nrc = messagebox("Esporta dati", "Estrazione '" + k_titolo + "'~n~r" + "File: " + trim(k_path), question!, yesnocancel!, 2) 
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
			kGuf_data_base.profilestring_leggi_scrivi(kGuf_data_base.ki_profilestring_operazione_scrivi, k_dato_base, trim(k_path))
		end if	
	end if
	
	if k_errore then
		SetPointer(kkg.pointer_attesa)
		kds_1 = create DataStore
		kds_1.dataobject = kdw_1.dataobject
		kdw_1.ROWscopy( 1, kdw_1.rowcount( ) , primary!, kds_1, 1, primary!)

		choose case tab_1.selectedtab 
			case 1 
//--- queste colonne non voglio che escano in CSV		
				k_rcx = kds_1.Modify("cod_cli_t.text='Id_cliente'")
				k_rcx = kds_1.Modify("data.visible='0'")
				k_rcx = kds_1.Modify("attivo.visible='0'")
			case 2
		end choose
		
//--- Produzione del file CSV		
		k_nr_rec = kuf1_utility.u_ds_to_csv(kds_1, k_path)
		
		SetPointer(kkg.pointer_default)
//		if k_nr_rec > 0 then
		if messagebox("Operazione terminata correttamente",  "Vuoi aprire subito il file contenente " + string(k_nr_rec) + " righe dei dati esportati~n~r"&
									+ trim(k_path), Question!, yesno!, 1) = 1 then
			SetPointer(kkg.pointer_attesa)
			kuf1_file_explorer = create kuf_file_explorer
			kuf1_file_explorer.of_execute( trim(k_path))
			destroy kuf1_file_explorer
		end if
//		end if		
		
		
	else
		messagebox("Estrazione Dati", "Nessuna esportazione Eseguita! ~n~r")
	end if

//--- Ripristina path di lavoro
	kGuf_data_base.setta_path_default()
	
catch(uo_exception kuo_exception)
	kuo_exception.messaggio_utente( )

finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kds_1) then destroy kds_1

end try


end subroutine

public subroutine smista_funz (string k_par_in);//
choose case left(k_par_in, 2) 


	case kkg_flag_richiesta.libero1 //esporta in csv
		u_esporta()

	case else
		super::smista_funz(k_par_in)
		
end choose





end subroutine

protected subroutine inizializza_1 () throws uo_exception;//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
int k_rc



	if tab_1.tabpage_2.dw_2.rowcount() = 0 then
	
		tab_1.tabpage_1.text = " Elenco Legami Mandanti-Riceventi-Clienti attivi"
		k_rc = tab_1.tabpage_2.dw_2.retrieve() 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_2.dw_2.reset()
				attiva_tasti()

		end choose

		tab_1.tabpage_2.dw_2.event getfocus( )
		
	end if




end subroutine

protected subroutine attiva_tasti_0 ();//
	st_aggiorna_lista.enabled = true
	super::attiva_tasti_0()
	

end subroutine

on w_contratti_xsmart.create
int iCurrent
call super::create
end on

on w_contratti_xsmart.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ritorna from w_g_tab_3`st_ritorna within w_contratti_xsmart
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type st_ordina_lista from w_g_tab_3`st_ordina_lista within w_contratti_xsmart
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type st_aggiorna_lista from w_g_tab_3`st_aggiorna_lista within w_contratti_xsmart
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type cb_ritorna from w_g_tab_3`cb_ritorna within w_contratti_xsmart
integer x = 2711
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type st_stampa from w_g_tab_3`st_stampa within w_contratti_xsmart
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type cb_visualizza from w_g_tab_3`cb_visualizza within w_contratti_xsmart
integer x = 1175
integer y = 1440
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_modifica from w_g_tab_3`cb_modifica within w_contratti_xsmart
integer x = 503
integer y = 1436
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_contratti_xsmart
integer x = 1970
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_contratti_xsmart
integer x = 2341
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
string text = ""
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_contratti_xsmart
integer x = 1600
integer y = 1444
integer width = 0
integer height = 0
integer taborder = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
boolean enabled = false
string text = ""
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//=== Nuovo Rekord
	choose case tab_1.selectedtab 
		case  1, 3 
	
			k_errore = LeftA(dati_modif(parent.title), 1)

//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
			if k_errore = "1" then //Fare gli aggiornamenti

//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
				k_errore = aggiorna_dati()		

			else

				if k_errore = "2" then //Aggiornamento non richiesto
					k_errore = "0"
				end if

			end if
			
	end choose
	
	if LeftA(k_errore, 1) = "0" then 
		inserisci()
	end if

end event

type tab_1 from w_g_tab_3`tab_1 within w_contratti_xsmart
integer x = 0
integer y = 0
integer width = 3040
integer height = 1396
integer taborder = 0
integer weight = 0
string facename = ""
long backcolor = 32172778
end type

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
call super::destroy
end on

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 32435950
string text = " Elenco Contratti"
long tabtextcolor = 0
long tabbackcolor = 33554431
string picturename = "Export5!"
long picturemaskcolor = 553648127
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
integer x = 14
integer y = 44
integer width = 2967
integer height = 1144
integer taborder = 0
string title = ""
string dataobject = "d_listino_x_smart"
boolean hsplitscroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_d_std_1_primo_giro = true
string ki_dragdrop_display = ""
end type

type st_1_retrieve from w_g_tab_3`st_1_retrieve within tabpage_1
integer x = 507
integer y = 832
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 31909606
string text = " Elenco Legami"
long tabtextcolor = 0
long tabbackcolor = 32501743
string picturename = "Export5!"
long picturemaskcolor = 553648127
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
boolean visible = true
integer x = 0
integer y = 24
integer width = 2981
integer height = 1180
integer taborder = 0
boolean enabled = true
string title = ""
string dataobject = "ds_mrf_x_smart"
boolean hsplitscroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_sempre_possibile = true
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_d_std_1_primo_giro = true
string ki_dragdrop_display = ""
end type

type st_2_retrieve from w_g_tab_3`st_2_retrieve within tabpage_2
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
long backcolor = 31909606
string text = ""
long tabtextcolor = 0
long tabbackcolor = 33544171
long picturemaskcolor = 553648127
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
integer x = 0
integer y = 48
integer width = 2967
integer height = 1156
integer taborder = 0
string title = ""
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
string ki_dragdrop_display = ""
end type

type st_3_retrieve from w_g_tab_3`st_3_retrieve within tabpage_3
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
long backcolor = 32501743
string text = ""
long tabtextcolor = 0
long tabbackcolor = 16777215
long picturemaskcolor = 553648127
ln_1 ln_1
end type

on tabpage_4.create
this.ln_1=create ln_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ln_1
end on

on tabpage_4.destroy
call super::destroy
destroy(this.ln_1)
end on

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
integer x = 0
integer y = 24
integer width = 2939
integer height = 1116
integer taborder = 10
string title = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
string ki_dragdrop_display = ""
end type

type st_4_retrieve from w_g_tab_3`st_4_retrieve within tabpage_4
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
integer width = 3003
integer height = 1268
boolean enabled = false
long backcolor = 31909606
string text = ""
long tabtextcolor = 0
long tabbackcolor = 33544171
long picturemaskcolor = 553648127
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
integer x = 0
integer y = 20
integer width = 2935
integer height = 1152
integer taborder = 0
string title = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
string ki_dragdrop_display = ""
end type

type st_5_retrieve from w_g_tab_3`st_5_retrieve within tabpage_5
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type tabpage_6 from w_g_tab_3`tabpage_6 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 0
string text = ""
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

type st_6_retrieve from w_g_tab_3`st_6_retrieve within tabpage_6
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type dw_6 from w_g_tab_3`dw_6 within tabpage_6
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer taborder = 0
string title = ""
string dataobject = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
string ki_dragdrop_display = ""
end type

type tabpage_7 from w_g_tab_3`tabpage_7 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 0
string text = ""
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

type st_7_retrieve from w_g_tab_3`st_7_retrieve within tabpage_7
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type dw_7 from w_g_tab_3`dw_7 within tabpage_7
integer y = 0
integer width = 0
integer height = 0
integer taborder = 0
string title = ""
string dataobject = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
string ki_dragdrop_display = ""
end type

type tabpage_8 from w_g_tab_3`tabpage_8 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 0
string text = ""
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

type st_8_retrieve from w_g_tab_3`st_8_retrieve within tabpage_8
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type dw_8 from w_g_tab_3`dw_8 within tabpage_8
integer y = 0
integer width = 0
integer height = 0
integer taborder = 0
string title = ""
string dataobject = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
string ki_dragdrop_display = ""
end type

type tabpage_9 from w_g_tab_3`tabpage_9 within tab_1
integer width = 3003
integer height = 1268
long backcolor = 0
string text = ""
long tabtextcolor = 0
long tabbackcolor = 0
long picturemaskcolor = 0
end type

type st_9_retrieve from w_g_tab_3`st_9_retrieve within tabpage_9
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer textsize = 0
integer weight = 0
fontpitch fontpitch = default!
fontfamily fontfamily = anyfont!
string facename = ""
long textcolor = 0
long backcolor = 0
string text = ""
end type

type dw_9 from w_g_tab_3`dw_9 within tabpage_9
integer x = 0
integer y = 0
integer width = 0
integer height = 0
integer taborder = 0
string title = ""
string dataobject = ""
boolean hscrollbar = false
boolean vscrollbar = false
boolean hsplitscroll = false
boolean livescroll = false
string ki_icona_normale = ""
string ki_icona_selezionata = ""
boolean ki_disattiva_moment_cb_aggiorna = false
boolean ki_link_standard_attivi = false
boolean ki_button_standard_attivi = false
string ki_ultima_dataobject = ""
boolean ki_colora_riga_aggiornata = false
string ki_sqlsyntax = ""
string ki_sqlerrtext = ""
boolean ki_attiva_standard_select_row = false
boolean ki_d_std_1_attiva_cerca = false
string ki_dragdrop_display = ""
end type

type ln_1 from line within tabpage_4
integer linethickness = 4
integer beginx = 361
integer beginy = 2376
integer endx = 2674
integer endy = 2376
end type

