$PBExportHeader$w_ddt_l.srw
forward
global type w_ddt_l from w_g_tab0
end type
type rb_prova from radiobutton within w_ddt_l
end type
type rb_definitiva from radiobutton within w_ddt_l
end type
type cb_stampa_ok from commandbutton within w_ddt_l
end type
type cb_stampa_annulla from commandbutton within w_ddt_l
end type
type dw_periodo from uo_d_std_1 within w_ddt_l
end type
type gb_stampa from groupbox within w_ddt_l
end type
end forward

global type w_ddt_l from w_g_tab0
integer width = 2898
integer height = 2084
string title = "Documenti di Vendita"
boolean ki_toolbar_window_presente = true
rb_prova rb_prova
rb_definitiva rb_definitiva
cb_stampa_ok cb_stampa_ok
cb_stampa_annulla cb_stampa_annulla
dw_periodo dw_periodo
gb_stampa gb_stampa
end type
global w_ddt_l w_ddt_l

type variables
//
private date ki_data_ini 
private date ki_data_fin 
private string ki_mostra_nascondi_in_lista="S"
private string ki_win_titolo_orig_save = ""

kuf_sped kiuf_sped
st_sped_ddt kist_sped_ddt[]

end variables

forward prototypes
private function string inizializza ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private subroutine cambia_periodo_elenco ()
public subroutine popola_st_sped_ddt_da_lista ()
private subroutine stampa_ddt ()
public subroutine stampa_ddt_lancia ()
protected subroutine open_start_window ()
end prototypes

private function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
int k_importa = 0
st_tab_sped kst_tab_sped
kuf_listino kuf1_listino
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita
		
		if len(trim(ki_st_open_w.key1)) > 0 then 
			kst_tab_sped.clie_2 = long(trim(ki_st_open_w.key1))
		else
			kst_tab_sped.clie_2 = 0
		end if
		if dw_lista_0.retrieve(ki_data_ini, ki_data_fin, kst_tab_sped.clie_2) < 1 then
			k_return = "1Nessuna Spedizione per il periodo: " + string(ki_data_ini) + " - " + string(ki_data_fin)

			SetPointer(oldpointer)
			messagebox("Elenco ddt", &
					"Nessuna Spedizione per il periodo: " + string(ki_data_ini) + " - " + string(ki_data_fin))

		end if		
	end if

	ki_win_titolo_orig = ki_win_titolo_orig_save
	ki_win_titolo_orig += " dal " + string(ki_data_ini) + " al " + string(ki_data_fin)
	kiw_this_window.title = ki_win_titolo_orig

	attiva_tasti()

return k_return


end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Cambia il periodo di estrazione elenco ddt"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp =  "Cambia il periodo di estrazione elenco ddt"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Periodo,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom015!"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		
		
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Stampa ddt selezionate"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp =  "Stampa ddt selezionate"
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Stampa,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = kGuo_path.get_risorse() + "\printer16x16.gif"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
	end if	
	
//---
	super::attiva_menu()



end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

choose case LeftA(k_par_in, 2) 


	case KKG_FLAG_RICHIESTA.libero1		//cambia date di estrazione
		cambia_periodo_elenco()

	case KKG_FLAG_RICHIESTA.libero2		//stampa ddt
		stampa_ddt_lancia()

	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

private subroutine cambia_periodo_elenco ();//---
//--- Visualizza il box x il cambio del Periodo di elenco ddt 
//---


dw_periodo.triggerevent("ue_visibile")

end subroutine

public subroutine popola_st_sped_ddt_da_lista ();//---
//--- riempie la  st_sped_ddt  da dw di elenco
//---
long k_riga, k_riga_st
st_esito kst_esito
st_sped_ddt kst_sped_ddt_vuota[]


kist_sped_ddt[] = kst_sped_ddt_vuota[]


k_riga_st = 0
for k_riga = 1 to dw_lista_0.rowcount()

//--- se selezionata la metto da stampare
	if dw_lista_0.IsSelected ( k_riga)   then

		if dw_lista_0.getitemnumber(k_riga, "num_bolla_out") > 0 then

			k_riga_st++
			kist_sped_ddt[k_riga_st].kst_tab_sped.id_sped = dw_lista_0.getitemnumber(k_riga, "id_sped")
			kist_sped_ddt[k_riga_st].kst_tab_sped.num_bolla_out = dw_lista_0.getitemnumber(k_riga, "num_bolla_out")
			kist_sped_ddt[k_riga_st].kst_tab_sped.data_bolla_out = dw_lista_0.getitemdate(k_riga, "data_bolla_out")
			kist_sped_ddt[k_riga_st].sel = 1
			
		end if			
	end if		
	
end for



end subroutine

private subroutine stampa_ddt ();//---
//--- Visualizza il box x il cambio del stampa di elenco ddt 
//---

gb_stampa.x = (kiw_this_window.width  - gb_stampa.width) / 4
gb_stampa.y = (kiw_this_window.height - gb_stampa.height) / 4
rb_prova.x = gb_stampa.x + 78 
rb_prova.y = gb_stampa.y + 115
rb_definitiva.x = rb_prova.x 
rb_definitiva.y = gb_stampa.y + 203
cb_stampa_ok.x = gb_stampa.x + 78
cb_stampa_ok.y = gb_stampa.y + 319
cb_stampa_annulla.x = gb_stampa.x + 585
cb_stampa_annulla.y = cb_stampa_ok.y

gb_stampa.visible = true
rb_prova.visible = true
rb_definitiva.visible = true
cb_stampa_ok.visible = true
cb_stampa_annulla.visible = true

end subroutine

public subroutine stampa_ddt_lancia ();//--
//--- Lancia Aggiornamento e Stampa delle ddt 
//---
LONG k_riga_ddt=0
st_esito kst_esito
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window



try 
	
	popola_st_sped_ddt_da_lista()
	if upperbound(kist_sped_ddt[]) > 0 then
		
		
//		kuf1_sped.stampa_fattura (kist_sped_ddt)
//
////--- Aggiornamento STAMAPATE se NON di PROVA	
//		if rb_definitiva.checked then
//
////			kuf1_sped.aggiorna_fattura_flag_stampa(kist_sped_ddt)
//	
//			if kist_sped_ddt.rowcount() > 0 then
//				for k_riga_ddt = 1 to kist_sped_ddt.rowcount()
//					kst_tab_sped[k_riga_ddt].num_bolla_out = kist_sped_ddt.object.num_bolla_out[k_riga_ddt]
//					kst_tab_sped[k_riga_ddt].data_bolla_out = kist_sped_ddt.object.data_bolla_out[k_riga_ddt]
//				next
//			end if
//		
//	//--- aggiorna flag di stampa
//			kuf1_sped.aggiorna_fattura_flag_stampa(kst_tab_sped[])
//
//	//--- aggiorna tabelle tipo PROFIS, SCADENZE....		
//			kst_esito = kuf1_sped.aggiorna_tabelle_correlate(kst_tab_sped[])
//			if kst_esito.esito = kkg_esito.db_ko then
//				kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
//				kguo_exception.set_esito( kst_esito )
//			end if
//			
//
//		end if

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
		K_st_open_w.id_programma = kiuf_sped.get_id_programma(kkg_flag_modalita.stampa)
		K_st_open_w.flag_primo_giro = "S"
		K_st_open_w.flag_modalita = kkg_flag_modalita.stampa
		K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
		K_st_open_w.flag_leggi_dw = " "
		K_st_open_w.flag_cerca_in_lista = " "
		K_st_open_w.key12_any = kist_sped_ddt[]  // struttura bolla da stampare
		K_st_open_w.key1 = " "
		K_st_open_w.key2 = " "
		K_st_open_w.key3 = " " 
		K_st_open_w.flag_where = " "
		
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(k_st_open_w)
		destroy kuf1_menu_window
	
								
	else
		kguo_exception.setmessage( "Selezionare almeno un documento da stampare")
		kguo_exception.messaggio_utente( )
	end if

	
	
	
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally

end try



end subroutine

protected subroutine open_start_window ();//
	kiuf_sped = create kuf_sped
	ki_win_titolo_orig_save = ki_win_titolo_orig
	
	ki_toolbar_window_presente=true

//--- Argomenti:  KEY1 = cliente, KEY2= Data Inizio -   KEY3 = Data Fine 
	if trim(ki_st_open_w.key2) = "" then
		if isdate(trim(ki_st_open_w.key2)) then
			ki_data_ini = date(trim(ki_st_open_w.key2))
		else
			ki_data_ini = relativedate(kg_dataoggi, -35)
		end if
	else
		ki_data_ini = relativedate(kg_dataoggi, -35)
	end if
	if trim(ki_st_open_w.key3) = "" then
		if isdate(trim(ki_st_open_w.key3)) then
			ki_data_fin = date(trim(ki_st_open_w.key3))
		else
			ki_data_fin = kg_dataoggi
		end if
	else
		ki_data_fin = kg_dataoggi
	end if
	

//	tab_1.tabpage_1.dw_1.object.b_ric_lotto.filename ="pdf16.png" 

end subroutine

on w_ddt_l.create
int iCurrent
call super::create
this.rb_prova=create rb_prova
this.rb_definitiva=create rb_definitiva
this.cb_stampa_ok=create cb_stampa_ok
this.cb_stampa_annulla=create cb_stampa_annulla
this.dw_periodo=create dw_periodo
this.gb_stampa=create gb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_prova
this.Control[iCurrent+2]=this.rb_definitiva
this.Control[iCurrent+3]=this.cb_stampa_ok
this.Control[iCurrent+4]=this.cb_stampa_annulla
this.Control[iCurrent+5]=this.dw_periodo
this.Control[iCurrent+6]=this.gb_stampa
end on

on w_ddt_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_prova)
destroy(this.rb_definitiva)
destroy(this.cb_stampa_ok)
destroy(this.cb_stampa_annulla)
destroy(this.dw_periodo)
destroy(this.gb_stampa)
end on

event close;call super::close;//
if isvalid(kiuf_sped) then destroy kiuf_sped

end event

type st_ritorna from w_g_tab0`st_ritorna within w_ddt_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_ddt_l
integer x = 1408
integer y = 1124
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_ddt_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_ddt_l
integer x = 2427
integer y = 1160
integer height = 92
integer taborder = 90
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_ddt_l
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_ddt_l
integer x = 1563
integer y = 1368
end type

type cb_modifica from w_g_tab0`cb_modifica within w_ddt_l
integer x = 1783
integer y = 1152
integer height = 96
integer taborder = 70
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_ddt_l
integer x = 1134
integer y = 1160
integer height = 96
integer taborder = 100
end type

type cb_cancella from w_g_tab0`cb_cancella within w_ddt_l
integer x = 2121
integer y = 1164
integer height = 96
integer taborder = 80
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_ddt_l
integer x = 1467
integer y = 1156
integer height = 96
integer taborder = 60
boolean enabled = false
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_ddt_l
integer x = 1769
integer y = 1104
integer width = 827
integer height = 524
integer taborder = 50
end type

on dw_dett_0::rbuttondown;call w_g_tab0`dw_dett_0::rbuttondown;//
//=== Scateno l'evento sulla window
parent.triggerevent("rbuttondown")

end on

on dw_dett_0::getfocus;////
//long k_id_vettore
//
////=== Verifico se ho gia' fatto almeno una retrieve o una insert
//if dw_dett_0.getrow() = 0 then
//	if cb_modifica.enabled = true then
//		cb_modifica.triggerevent("clicked")
//	else
//		cb_inserisci.triggerevent("clicked")
//	end if
//end if
//
////=== Controlla quali tasti attivare
//attiva_tasti()
//
//k_id_vettore = this.getitemnumber(1, "id_vettore")
////k_desc = this.getitemstring(1, "desc")
//
////=== Imposto valori di default se non ce ne sono
////if isnull(k_id_c_pag) = true or isnull(k_desc) = true or &
////	(trim(k_id_c_pag) = "" and &
////	 trim(k_desc) = "") then
////	setitem(1, "tipo", 1)
////	setitem(1, "scad_p", 1)
////end if
//
end on

type st_orizzontal from w_g_tab0`st_orizzontal within w_ddt_l
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_ddt_l
integer width = 2807
integer height = 708
integer taborder = 120
string dataobject = "d_sped_l_2"
borderstyle borderstyle = stylelowered!
end type

type dw_guida from w_g_tab0`dw_guida within w_ddt_l
end type

type rb_prova from radiobutton within w_ddt_l
boolean visible = false
integer x = 165
integer y = 1484
integer width = 818
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "stampa di Prova / Duplicato"
boolean checked = true
end type

type rb_definitiva from radiobutton within w_ddt_l
boolean visible = false
integer x = 165
integer y = 1572
integer width = 539
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "stampa Definitiva"
end type

type cb_stampa_ok from commandbutton within w_ddt_l
boolean visible = false
integer x = 165
integer y = 1688
integer width = 201
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;//
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

//
gb_stampa.visible = false
rb_prova.visible = false
rb_definitiva.visible = false
cb_stampa_ok.visible = false
cb_stampa_annulla.visible = false

stampa_ddt_lancia()

SetPointer(oldpointer)


end event

type cb_stampa_annulla from commandbutton within w_ddt_l
boolean visible = false
integer x = 672
integer y = 1688
integer width = 279
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;//
gb_stampa.visible = false
rb_prova.visible = false
rb_definitiva.visible = false
cb_stampa_ok.visible = false
cb_stampa_annulla.visible = false

end event

type dw_periodo from uo_d_std_1 within w_ddt_l
integer x = 114
integer y = 868
integer width = 955
integer height = 504
integer taborder = 60
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Periodo di estrazione"
string dataobject = "d_periodo"
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
	
	this.accepttext( )
	this.visible = false
	
	ki_data_ini  = this.getitemdate( 1, "data_dal")
	ki_data_fin  = this.getitemdate( 1, "data_al")
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

	this.width = long(this.object.data_al.x) + long(this.object.data_al.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 160

	this.x = (kiw_this_window.width  - this.width) / 4
	this.y = (kiw_this_window.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	k_rc = this.setitem(1, "data_dal", ki_data_ini)
	k_rc = this.setitem(1, "data_al", ki_data_fin)
	this.visible = true
	this.setfocus()
end event

type gb_stampa from groupbox within w_ddt_l
boolean visible = false
integer x = 87
integer y = 1396
integer width = 946
integer height = 404
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Stampa e Aggiorna"
end type

