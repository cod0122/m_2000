$PBExportHeader$w_menu_tree.srw
forward
global type w_menu_tree from w_g_tab
end type
type st_1 from statictext within w_menu_tree
end type
type st_2 from statictext within w_menu_tree
end type
type st_3 from statictext within w_menu_tree
end type
type st_4 from statictext within w_menu_tree
end type
type st_5 from statictext within w_menu_tree
end type
type st_6 from statictext within w_menu_tree
end type
type st_7 from statictext within w_menu_tree
end type
type st_8 from statictext within w_menu_tree
end type
type st_9 from statictext within w_menu_tree
end type
type pb_1 from picturebutton within w_menu_tree
end type
type pb_10 from picturebutton within w_menu_tree
end type
type pb_11 from picturebutton within w_menu_tree
end type
type pb_12 from picturebutton within w_menu_tree
end type
type pb_13 from picturebutton within w_menu_tree
end type
type pb_2 from picturebutton within w_menu_tree
end type
type pb_3 from picturebutton within w_menu_tree
end type
type pb_4 from picturebutton within w_menu_tree
end type
type pb_5 from picturebutton within w_menu_tree
end type
type pb_6 from picturebutton within w_menu_tree
end type
type pb_7 from picturebutton within w_menu_tree
end type
type pb_8 from picturebutton within w_menu_tree
end type
type pb_9 from picturebutton within w_menu_tree
end type
type pb_l1 from picturebutton within w_menu_tree
end type
type pb_l10 from picturebutton within w_menu_tree
end type
type pb_l2 from picturebutton within w_menu_tree
end type
type pb_l3 from picturebutton within w_menu_tree
end type
type pb_l4 from picturebutton within w_menu_tree
end type
type pb_l5 from picturebutton within w_menu_tree
end type
type pb_l6 from picturebutton within w_menu_tree
end type
type pb_l71 from picturebutton within w_menu_tree
end type
type pb_l72 from picturebutton within w_menu_tree
end type
type pb_l73 from picturebutton within w_menu_tree
end type
type pb_l74 from picturebutton within w_menu_tree
end type
type pb_l75 from picturebutton within w_menu_tree
end type
type pb_l8 from picturebutton within w_menu_tree
end type
type pb_l9 from picturebutton within w_menu_tree
end type
type pb_t1 from picturebutton within w_menu_tree
end type
type pb_t2 from picturebutton within w_menu_tree
end type
type pb_t3 from picturebutton within w_menu_tree
end type
type cbx_txt from checkbox within w_menu_tree
end type
type st_l1 from statictext within w_menu_tree
end type
type st_l2 from statictext within w_menu_tree
end type
type st_l3 from statictext within w_menu_tree
end type
type st_l4 from statictext within w_menu_tree
end type
type st_l5 from statictext within w_menu_tree
end type
type st_l6 from statictext within w_menu_tree
end type
type st_l8 from statictext within w_menu_tree
end type
type st_l71 from statictext within w_menu_tree
end type
type st_l72 from statictext within w_menu_tree
end type
type st_l73 from statictext within w_menu_tree
end type
type st_l74 from statictext within w_menu_tree
end type
type st_l75 from statictext within w_menu_tree
end type
type st_l9 from statictext within w_menu_tree
end type
type st_l10 from statictext within w_menu_tree
end type
type st_t1 from statictext within w_menu_tree
end type
type st_10 from statictext within w_menu_tree
end type
type st_11 from statictext within w_menu_tree
end type
type st_12 from statictext within w_menu_tree
end type
type st_13 from statictext within w_menu_tree
end type
type st_t2 from statictext within w_menu_tree
end type
type st_t3 from statictext within w_menu_tree
end type
type pb_14 from picturebutton within w_menu_tree
end type
type st_14 from statictext within w_menu_tree
end type
type r_sep1 from roundrectangle within w_menu_tree
end type
type r_sep2 from roundrectangle within w_menu_tree
end type
end forward

global type w_menu_tree from w_g_tab
boolean visible = true
integer width = 219
integer height = 3112
string menuname = ""
boolean clientedge = true
boolean ki_esponi_msg_dati_modificati = false
boolean ki_sincronizza_window_consenti = false
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
st_9 st_9
pb_1 pb_1
pb_10 pb_10
pb_11 pb_11
pb_12 pb_12
pb_13 pb_13
pb_2 pb_2
pb_3 pb_3
pb_4 pb_4
pb_5 pb_5
pb_6 pb_6
pb_7 pb_7
pb_8 pb_8
pb_9 pb_9
pb_l1 pb_l1
pb_l10 pb_l10
pb_l2 pb_l2
pb_l3 pb_l3
pb_l4 pb_l4
pb_l5 pb_l5
pb_l6 pb_l6
pb_l71 pb_l71
pb_l72 pb_l72
pb_l73 pb_l73
pb_l74 pb_l74
pb_l75 pb_l75
pb_l8 pb_l8
pb_l9 pb_l9
pb_t1 pb_t1
pb_t2 pb_t2
pb_t3 pb_t3
cbx_txt cbx_txt
st_l1 st_l1
st_l2 st_l2
st_l3 st_l3
st_l4 st_l4
st_l5 st_l5
st_l6 st_l6
st_l8 st_l8
st_l71 st_l71
st_l72 st_l72
st_l73 st_l73
st_l74 st_l74
st_l75 st_l75
st_l9 st_l9
st_l10 st_l10
st_t1 st_t1
st_10 st_10
st_11 st_11
st_12 st_12
st_13 st_13
st_t2 st_t2
st_t3 st_t3
pb_14 pb_14
st_14 st_14
r_sep1 r_sep1
r_sep2 r_sep2
end type
global w_menu_tree w_menu_tree

type variables

end variables

forward prototypes
protected function string inizializza () throws uo_exception
protected subroutine attiva_menu ()
protected subroutine attiva_tasti ()
private subroutine u_toolbar_click (integer k_num_button)
private subroutine u_toolbar_lib_click (integer k_num_button)
public subroutine u_inizializza ()
private subroutine u_toolbar_t_click (integer k_num_button)
protected subroutine open_start_window ()
public subroutine u_build_menu (ref m_main am_main)
public subroutine u_resize_1 ()
public subroutine u_resize ()
private function boolean u_toolbar_lib_set ()
private function boolean u_toolbar_set_pb (ref picturebutton apb_1, readonly menu amenuitem_1, ref statictext ast_1)
private function boolean u_toolbar_lib_set_1 ()
private function boolean u_toolbar_set ()
private function boolean u_toolbar_t_set ()
private function boolean u_toolbar_fin_set ()
private function boolean u_resize_set_pb (ref picturebutton apb_1, ref statictext ast_1, ref integer a_nr_icone, ref integer k_x, ref integer k_y, integer k_start_x, integer k_st_width, integer k_st_y, integer k_st_x_delta, integer kpb_width, integer k_height)
private function boolean u_resize_set_sep (ref roundrectangle ar_sep, ref integer k_x, ref integer k_y, integer k_start_x, integer k_st_x_delta, integer k_height)
private function boolean u_set_ki_menu ()
end prototypes

protected function string inizializza () throws uo_exception;//

	if isnull(ki_menu) then
	else
		if isvalid(ki_menu) then
			ki_menu.m_trova.m_fin_cerca.enabled = false
			ki_menu.m_filtro.enabled = false

			u_toolbar_set( )
			u_toolbar_fin_set( )
			u_resize()
		end if
	end if
return "0"

end function

protected subroutine attiva_menu ();//

end subroutine

protected subroutine attiva_tasti ();//

end subroutine

private subroutine u_toolbar_click (integer k_num_button);//
string k_txt //, k_menu
int k_pos


if u_set_ki_menu() then
	
	choose case k_num_button
		case 1
			ki_menu.m_magazzino.m_mag_navigatore.event clicked( )
		case 2
			ki_menu.m_archivi.m_anagrafiche.m_lista_anag.event clicked( )
		case 3
			ki_menu.m_magazzino.m_pianidilavorazione.event clicked( )
		case 4
			ki_menu.m_archivi.m_listino.event clicked( )
		case 5
			ki_menu.m_archivi.m_contratti.event clicked( )
		case 6
			ki_menu.m_interrogazioni.m_report.event clicked( )
		case 7
			ki_menu.m_stat.m_st_produz.event clicked( )
		case 8
			ki_menu.m_finestra.m_fin_stampa.event clicked( )
		case 9
			ki_menu.m_finestra.m_aggiornalista.event clicked( )
		case 10
			ki_menu.m_finestra.m_gestione.m_fin_conferma.event clicked( )
		case 11
			ki_menu.m_finestra.m_gestione.m_fin_visualizza.event clicked( )
		case 12
			ki_menu.m_finestra.m_gestione.m_fin_modifica.event clicked( )
		case 13
			ki_menu.m_finestra.m_gestione.m_fin_inserimento.event clicked( )
		case 14
			ki_menu.m_finestra.m_gestione.m_fin_duplica.event clicked( )
		case 15
			ki_menu.m_finestra.m_gestione.m_fin_elimina.event clicked( )
	end choose

end if

this.enabled = true


end subroutine

private subroutine u_toolbar_lib_click (integer k_num_button);//
string k_txt //, k_menu
int k_pos

if u_set_ki_menu() then
	
	choose case k_num_button
		case 1
			ki_menu.m_strumenti.m_fin_gest_libero1.event clicked( )
		case 2
			ki_menu.m_strumenti.m_fin_gest_libero2.event clicked( )
		case 3
			ki_menu.m_strumenti.m_fin_gest_libero3.event clicked( )
		case 4
			ki_menu.m_strumenti.m_fin_gest_libero4.event clicked( )
		case 5
			ki_menu.m_strumenti.m_fin_gest_libero5.event clicked( )
		case 6
			ki_menu.m_strumenti.m_fin_gest_libero6.event clicked( )
		case 71
			ki_menu.m_strumenti.m_fin_gest_libero7.libero1.event clicked( )
		case 72
			ki_menu.m_strumenti.m_fin_gest_libero7.libero2.event clicked( )
		case 73
			ki_menu.m_strumenti.m_fin_gest_libero7.libero3.event clicked( )
		case 74
			ki_menu.m_strumenti.m_fin_gest_libero7.libero4.event clicked( )
		case 75
			ki_menu.m_strumenti.m_fin_gest_libero7.libero5.event clicked( )
		case 8
			ki_menu.m_strumenti.m_fin_gest_libero8.event clicked( )
		case 9
			ki_menu.m_strumenti.m_fin_gest_libero9.event clicked( )
		case 10
			ki_menu.m_strumenti.m_fin_gest_libero10.event clicked( )
	
	end choose

end if

end subroutine

public subroutine u_inizializza ();//
try
	
	inizializza( )
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try
end subroutine

private subroutine u_toolbar_t_click (integer k_num_button);//
string k_txt //, k_menu
int k_pos

if u_set_ki_menu() then

	choose case k_num_button
		case 1
			ki_menu.m_trova.m_fin_cerca.event clicked( )
		case 2
			ki_menu.m_trova.m_fin_ordina.event clicked( )
		case 3
			ki_menu.m_filtro.event clicked( )
	end choose

end if

end subroutine

protected subroutine open_start_window ();//
string k_rc
st_profilestring_ini kst_profile_string_ini


kst_profile_string_ini.nome = "menutoolbar_testo"
k_rc = kGuf_data_base.profilestring_ini(kst_profile_string_ini)
if kst_profile_string_ini.esito = "0" then
	if kst_profile_string_ini.valore = "0" then
		cbx_txt.checked = false
	else
		cbx_txt.checked = true
	end if
else
	cbx_txt.checked = true
end if

end subroutine

public subroutine u_build_menu (ref m_main am_main);//
//--- Imposta le voci di menu 
//--- Inp: il menu da 'trattare'
//
boolean k_changed

this.setredraw(false)

	if not u_set_ki_menu() then
		if NOT isnull(am_main) then
			if isvalid(am_main) then 
				ki_menu = am_main 
			end if
		end if
	end if

	if not isnull(ki_menu) and isvalid(ki_menu) then
	else
		if not isnull(w_main.ki_menu_0) and isvalid(w_main.ki_menu_0) then
			ki_menu = w_main.ki_menu_0
		end if
	end if
		
	if not isnull(ki_menu) and isvalid(ki_menu) then
		
		m_main = ki_menu
	
		if u_toolbar_set() then
			k_changed = true
		end if
		if u_toolbar_fin_set() then
			k_changed = true
		end if
		if u_toolbar_t_set() then
			k_changed = true
		end if
		if u_toolbar_lib_set() then
			k_changed = true
		end if
		
		if k_changed then
			u_resize( )
		end if
	
	end if


this.setredraw(true)
  
end subroutine

public subroutine u_resize_1 ();//
int k_x, k_y, k_st_y, kpb_width, k_st_width, k_st_widthx2, k_height, k_st_x_delta, k_cbx_x, k_start_x
int k_nr_icone
int k_appon
boolean k_spazio_bianco


//this.setredraw(false)

//--- conta le icone da aprire
if pb_1.enabled then	k_nr_icone ++
if pb_2.enabled then	k_nr_icone ++
if pb_3.enabled then	k_nr_icone ++
if pb_4.enabled then	k_nr_icone ++
if pb_5.enabled then	k_nr_icone ++
if pb_6.enabled then	k_nr_icone ++
if pb_7.enabled then	k_nr_icone ++
if pb_8.enabled then	k_nr_icone ++
if pb_9.enabled then	k_nr_icone ++
//--- pb di SALVA/NUOVO/...
if pb_10.enabled then k_nr_icone ++
if pb_11.enabled then k_nr_icone ++
if pb_12.enabled then k_nr_icone ++
if pb_13.enabled then k_nr_icone ++
if pb_14.enabled then k_nr_icone ++
//if pb_15.enabled then k_nr_icone ++  NO LA DELETE
//--- pb di TROVA/FILTRO
if pb_t1.enabled then k_nr_icone ++
if pb_t2.enabled then k_nr_icone ++
if pb_t3.enabled then k_nr_icone ++
//--- pb di TOOLS: LIB1-LIB10
if pb_l1.enabled then k_nr_icone ++
if pb_l2.enabled then k_nr_icone ++
if pb_l3.enabled then k_nr_icone ++
if pb_l4.enabled then k_nr_icone ++
if pb_l5.enabled then k_nr_icone ++
if pb_l6.enabled then k_nr_icone ++
if pb_l8.enabled then k_nr_icone ++
if pb_l9.enabled then k_nr_icone ++
if pb_l10.enabled then k_nr_icone ++
if pb_l71.enabled then k_nr_icone ++
if pb_l72.enabled then k_nr_icone ++
if pb_l73.enabled then k_nr_icone ++
if pb_l74.enabled then k_nr_icone ++
if pb_l75.enabled then k_nr_icone ++
//--- + due a spazio 
k_nr_icone += 2

if cbx_txt.checked then
	k_st_width = pb_1.width * 1.8  // testo esposto
	k_height = (pb_1.height + st_1.height) * 1.1 // testo esposto
else
	k_st_width = pb_1.width * 1.1  // testo nascosto
	k_height = pb_1.height * 1.1  // testo nascosto
end if
if this.width < k_st_width then // non posso ridimensionare troppo!
	this.width = k_st_width
end if
st_1.width = k_st_width
k_st_widthX2 = k_st_width * 2

r_sep1.width = k_st_width
r_sep2.width = k_st_width

if this.width > (k_st_width * k_nr_icone) then 
	k_x = (this.width - (k_st_width * k_nr_icone)) / 2
	k_cbx_x = k_x
else
	k_x = (pb_1.width * 1.6 - pb_1.width) / 2 //(this.width - k_st_width) / 2
	k_cbx_x = (pb_1.width * 1.5 - cbx_txt.width / 2) / 2 //(this.width - cbx_txt.width) / 2.5
end if
k_st_x_delta = (k_st_width - pb_1.width) / 2  //* 0.25
kpb_width = pb_1.width * 0.15 
k_st_y = pb_1.height

//k_start_y = 1 //(pb_1.height - st_1.height) / 2
k_start_x = k_x

//	kpb_height = pb_1.height * 0.10
//	kpb_width = pb_1.width * 0.15 
//	if (pb_1.height * 0.3) < kpb_height then
//		kpb_height = pb_1.height * 0.3
//	end if

cbx_txt.x = k_cbx_x
cbx_txt.y = (pb_1.height - cbx_txt.height) / 2
k_nr_icone = this.width / k_st_width 
k_nr_icone --
if k_nr_icone > 0 then 
	k_x += k_st_width + 10 //kpb_width
	k_y = 1
else
	k_y = pb_1.height
//	k_y += st_1.height * 2
	k_nr_icone = this.width / k_st_width 
end if

//--- INIZIO FUNZIONI TIPO STAMPA 
if u_resize_set_pb(pb_8, st_8, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_9, st_9, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if

//--- Inizio di SALVA/NUOVO/...
if u_resize_set_pb(pb_10, st_10, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_11, st_11, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_12, st_12, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_13, st_13, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_14, st_14, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
//NO ALLA DELETE if u_resize_set_pb(pb_15, st_15, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height)

if k_spazio_bianco and k_nr_icone = 1 then
	u_resize_set_sep(r_sep1, k_x, k_y, k_start_x, k_st_x_delta, k_height)
else
	r_sep1.visible = false
end if

//--- Inizio di TROVA/FILTRO
if u_resize_set_pb(pb_t1, st_t1, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_t2, st_t2, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_t3, st_t3, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if

//--- Inizio di TOOLS: LIB1-LIB10
if u_resize_set_pb(pb_l1, st_l1, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_l2, st_l2, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_l3, st_l3, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_l4, st_l4, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_l5, st_l5, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_l6, st_l6, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_l8, st_l8, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_l9, st_l9, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_l10, st_l10, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if

if u_resize_set_pb(pb_l71, st_l71, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_l72, st_l72, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_l73, st_l73, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_l74, st_l74, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_l75, st_l75, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if

//--- INIZIO APPLICAZIONI GENERICHE
if k_spazio_bianco and k_nr_icone = 1 then
//--- mette le icone delle Applicazioni in fondo all'elenco
	k_appon = (this.height - k_height * 8)
	if k_y < k_appon then
		k_y = k_appon
	end if
	u_resize_set_sep(r_sep2, k_x, k_y, k_start_x, k_st_x_delta, k_height)
else
	r_sep2.visible = false
end if

if u_resize_set_pb(pb_1, st_1, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_2, st_2, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_3, st_3, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_4, st_4, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_5, st_5, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_6, st_6, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if
if u_resize_set_pb(pb_7, st_7, k_nr_icone, k_x, k_y, k_start_x, k_st_width, k_st_y, k_st_x_delta,kpb_width, k_height) then
	k_spazio_bianco = true
end if

//this.setredraw(true)

end subroutine

public subroutine u_resize ();//
u_resize_1( )

end subroutine

private function boolean u_toolbar_lib_set ();//
boolean k_return 

//--- Inizio TOOLS LIB1-LIB10
//if pb_l1.visible <> (ki_menu.m_strumenti.m_fin_gest_libero1.enabled and ki_menu.m_strumenti.m_fin_gest_libero1.visible) &
//		or 	st_l1.text <> left(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) &
//		or pb_l2.visible <> (ki_menu.m_strumenti.m_fin_gest_libero2.enabled and ki_menu.m_strumenti.m_fin_gest_libero2.visible) &
//		or	st_l2.text <> left(ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) &
//		or pb_l3.visible <> (ki_menu.m_strumenti.m_fin_gest_libero3.enabled and ki_menu.m_strumenti.m_fin_gest_libero3.visible) &
//		or	st_l3.text <> left(ki_menu.m_strumenti.m_fin_gest_libero3.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) &
//		or pb_l4.visible <> (ki_menu.m_strumenti.m_fin_gest_libero4.enabled and ki_menu.m_strumenti.m_fin_gest_libero4.visible) &
//		or	st_l4.text <> left(ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) &
//		or pb_l5.visible <> (ki_menu.m_strumenti.m_fin_gest_libero5.enabled and ki_menu.m_strumenti.m_fin_gest_libero5.visible) &
//		or	st_l5.text <> left(ki_menu.m_strumenti.m_fin_gest_libero5.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) &
//		or pb_l6.visible <> (ki_menu.m_strumenti.m_fin_gest_libero6.enabled and ki_menu.m_strumenti.m_fin_gest_libero6.visible) &
//		or 	st_l6.text <> left(ki_menu.m_strumenti.m_fin_gest_libero6.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) &
//		or pb_l8.visible <> (ki_menu.m_strumenti.m_fin_gest_libero8.enabled and ki_menu.m_strumenti.m_fin_gest_libero8.visible) &
//		or 	st_l8.text <> left(ki_menu.m_strumenti.m_fin_gest_libero8.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) &
//		or pb_l9.visible <> (ki_menu.m_strumenti.m_fin_gest_libero9.enabled and ki_menu.m_strumenti.m_fin_gest_libero9.visible) &
//		or	st_l9.text <> left(ki_menu.m_strumenti.m_fin_gest_libero9.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) &
//		or pb_l10.visible <> (ki_menu.m_strumenti.m_fin_gest_libero10.enabled and ki_menu.m_strumenti.m_fin_gest_libero10.visible) &
//		or	st_l10.text <> left(ki_menu.m_strumenti.m_fin_gest_libero10.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) &
//		or pb_l71.visible <> (ki_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled and ki_menu.m_strumenti.m_fin_gest_libero7.libero1.visible) &
//		or	st_l71.text <> left(ki_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) &
//		or pb_l72.visible <> (ki_menu.m_strumenti.m_fin_gest_libero7.libero2.enabled and ki_menu.m_strumenti.m_fin_gest_libero7.libero2.visible) &
//		or	st_l72.text <> left(ki_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) &
//		or pb_l73.visible <> (ki_menu.m_strumenti.m_fin_gest_libero7.libero3.enabled and ki_menu.m_strumenti.m_fin_gest_libero7.libero3.visible) &
//		or	st_l73.text <> left(ki_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) &
//		or pb_l74.visible <> (ki_menu.m_strumenti.m_fin_gest_libero7.libero4.enabled and ki_menu.m_strumenti.m_fin_gest_libero7.libero4.visible) &
//		or 	st_l74.text <> left(ki_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) &
//		or pb_l75.visible <> (ki_menu.m_strumenti.m_fin_gest_libero7.libero5.enabled and ki_menu.m_strumenti.m_fin_gest_libero7.libero5.visible) &
//		or	st_l75.text <> left(ki_menu.m_strumenti.m_fin_gest_libero7.libero5.toolbaritemtext, (pos(ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemtext, ",")) - 1) then

	k_return = u_toolbar_lib_set_1( )
	
//end if

return k_return
end function

private function boolean u_toolbar_set_pb (ref picturebutton apb_1, readonly menu amenuitem_1, ref statictext ast_1);//
//--- Imposta nel picture-button i dati dall'item del menu 
//
boolean k_return


if apb_1.visible <> (amenuitem_1.enabled and (amenuitem_1.toolbaritemvisible or amenuitem_1.visible)) &
		or 	apb_1.powertiptext <> mid(amenuitem_1.toolbaritemtext, (pos(amenuitem_1.toolbaritemtext, ",")) + 1) then

	k_return = true

	apb_1.visible = (amenuitem_1.enabled and (amenuitem_1.toolbaritemvisible or amenuitem_1.visible)) //visible
	apb_1.enabled = amenuitem_1.enabled
	apb_1.picturename = amenuitem_1.toolbaritemname
	apb_1.disabledname = amenuitem_1.toolbaritemname
//	k_pos = pos(amenuitem_1.toolbaritemtext, ",")
	apb_1.powertiptext = mid(amenuitem_1.toolbaritemtext, (pos(amenuitem_1.toolbaritemtext, ",")) + 1)
	ast_1.text = left(amenuitem_1.toolbaritemtext, (pos(amenuitem_1.toolbaritemtext, ",")) - 1)
	
end if
	
return k_return

end function

private function boolean u_toolbar_lib_set_1 ();//
boolean k_return, k_changed


//--- TOOLSBAR FUNZIONI DINAMICHE LIB1-LIB10
k_changed = u_toolbar_set_pb(pb_l1, ki_menu.m_strumenti.m_fin_gest_libero1, st_l1)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_l2, ki_menu.m_strumenti.m_fin_gest_libero2, st_l2)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_l3, ki_menu.m_strumenti.m_fin_gest_libero3, st_l3)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_l4, ki_menu.m_strumenti.m_fin_gest_libero4, st_l4)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_l5, ki_menu.m_strumenti.m_fin_gest_libero5, st_l5)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_l6, ki_menu.m_strumenti.m_fin_gest_libero6, st_l6)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_l8, ki_menu.m_strumenti.m_fin_gest_libero8, st_l8)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_l9, ki_menu.m_strumenti.m_fin_gest_libero9, st_l9)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_l10, ki_menu.m_strumenti.m_fin_gest_libero10, st_l10)
if k_changed then k_return = true

k_changed = u_toolbar_set_pb(pb_l71, ki_menu.m_strumenti.m_fin_gest_libero7.libero1, st_l71)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_l72, ki_menu.m_strumenti.m_fin_gest_libero7.libero2, st_l72)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_l73, ki_menu.m_strumenti.m_fin_gest_libero7.libero3, st_l73)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_l74, ki_menu.m_strumenti.m_fin_gest_libero7.libero4, st_l74)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_l75, ki_menu.m_strumenti.m_fin_gest_libero7.libero5, st_l75)
if k_changed then k_return = true

return k_return


end function

private function boolean u_toolbar_set ();//
boolean k_return, k_changed

//--- Funzioni NAVIGATORE/CLIENTI/...
k_changed = u_toolbar_set_pb(pb_1,  ki_menu.m_magazzino.m_mag_navigatore, st_1)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_2,  ki_menu.m_archivi.m_anagrafiche.m_lista_anag, st_2)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_3,  ki_menu.m_magazzino.m_pianidilavorazione, st_3)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_4,  ki_menu.m_archivi.m_listino, st_4)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_5,  ki_menu.m_archivi.m_contratti, st_5)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_6,  ki_menu.m_interrogazioni.m_report, st_6)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_7,  ki_menu.m_stat.m_st_produz, st_7)
if k_changed then k_return = true

//pb_1.enabled = ki_menu.m_magazzino.m_mag_navigatore.enabled
//pb_1.picturename = ki_menu.m_magazzino.m_mag_navigatore.toolbaritemname
//k_pos = pos(ki_menu.m_magazzino.m_mag_navigatore.toolbaritemtext, ",")
//pb_1.powertiptext = mid(ki_menu.m_magazzino.m_mag_navigatore.toolbaritemtext, k_pos + 1)
//	st_1.text = left(ki_menu.m_magazzino.m_mag_navigatore.toolbaritemtext, k_pos - 1)

return k_return
end function

private function boolean u_toolbar_t_set ();//
boolean k_return, k_changed


//--- Inizio TROVA/FILTRO...
k_changed = u_toolbar_set_pb(pb_t1,  ki_menu.m_trova.m_fin_cerca, st_t1)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_t2,  ki_menu.m_trova.m_fin_ordina, st_t2)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_t3,  ki_menu.m_filtro, st_t3)
if k_changed then k_return = true

//pb_t1.enabled = ki_menu.m_trova.m_fin_cerca.enabled
//pb_t1.visible = ki_menu.m_trova.m_fin_cerca.enabled //visible
//pb_t1.picturename = ki_menu.m_trova.m_fin_cerca.toolbaritemname
//pb_t1.disabledname = ki_menu.m_trova.m_fin_cerca.toolbaritemname
//k_pos = pos(ki_menu.m_trova.m_fin_cerca.toolbaritemtext, ",")
//pb_t1.powertiptext = mid(ki_menu.m_trova.m_fin_cerca.toolbaritemtext, k_pos + 1)
//	st_t1.text = left(ki_menu.m_trova.m_fin_cerca.toolbaritemtext, k_pos - 1)

return k_return
end function

private function boolean u_toolbar_fin_set ();//
boolean k_return, k_changed


//--- Aggiorna Lista / Stampa
k_changed = u_toolbar_set_pb(pb_8, ki_menu.m_finestra.m_fin_stampa, st_8)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_9, ki_menu.m_finestra.m_aggiornalista, st_9)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_10, ki_menu.m_finestra.m_gestione.m_fin_conferma, st_10)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_11, ki_menu.m_finestra.m_gestione.m_fin_visualizza, st_11)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_12, ki_menu.m_finestra.m_gestione.m_fin_modifica, st_12)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_13, ki_menu.m_finestra.m_gestione.m_fin_inserimento, st_13)
if k_changed then k_return = true
k_changed = u_toolbar_set_pb(pb_14, ki_menu.m_finestra.m_gestione.m_fin_duplica, st_14)
if k_changed then k_return = true
//k_changed = u_toolbar_set_pb(pb_15, ki_menu.m_finestra.m_gestione.m_fin_elimina, st_15)
//if k_changed then k_return = true


//pb_8.enabled = ki_menu.m_finestra.m_fin_stampa.enabled
//pb_8.picturename = ki_menu.m_finestra.m_fin_stampa.toolbaritemname
//k_pos = pos(ki_menu.m_finestra.m_fin_stampa.toolbaritemtext, ",")
//pb_8.powertiptext = mid(ki_menu.m_finestra.m_fin_stampa.toolbaritemtext, k_pos + 1)
//st_8.text = left(ki_menu.m_finestra.m_fin_stampa.toolbaritemtext, k_pos - 1)
////if cbx_txt.checked then
//	st_8.text = left(ki_menu.m_finestra.m_fin_stampa.toolbaritemtext, k_pos - 1)
////end if

return k_return
end function

private function boolean u_resize_set_pb (ref picturebutton apb_1, ref statictext ast_1, ref integer a_nr_icone, ref integer k_x, ref integer k_y, integer k_start_x, integer k_st_width, integer k_st_y, integer k_st_x_delta, integer kpb_width, integer k_height);//
//--- posiziona PB e ST del menu in x e y
//
//
boolean k_spazio_bianco = false


//--- INIZIO FUNZIONI TIPO STAMPA 
//pb_7.visible = pb_7.enabled 
if apb_1.visible then
	k_spazio_bianco = true
	apb_1.x = k_x
	apb_1.y = k_y
	ast_1.visible = cbx_txt.checked
	ast_1.width = k_st_width
	ast_1.x = k_x - k_st_x_delta
	ast_1.y = apb_1.y + k_st_y
	a_nr_icone --
	if a_nr_icone > 0 then
		k_x += k_st_width + kpb_width
	else
		k_x = k_start_x
		k_y += k_height //+ kpb_height
		a_nr_icone = this.width / k_st_width 
	end if
else
	ast_1.visible = false
end if

return k_spazio_bianco


end function

private function boolean u_resize_set_sep (ref roundrectangle ar_sep, ref integer k_x, ref integer k_y, integer k_start_x, integer k_st_x_delta, integer k_height);//
//--- posiziona Separatore del menu in x e y
//
//


	if	k_x = k_start_x then
//		k_y += k_height * 0.3 //+ kpb_height
		ar_sep.x = k_x  - k_st_x_delta
		ar_sep.y = k_y - ar_sep.height //- k_height * 0.1
		ar_sep.visible = true
		k_y += k_height * 0.1 //+ kpb_height
	else
		ar_sep.visible = false
	end if
	
	
return ar_sep.visible


end function

private function boolean u_set_ki_menu ();//
boolean k_return = false
w_g_tab kw_g_tab


kw_g_tab = kGuf_data_base.prendi_win_attiva( )
if isvalid(kw_g_tab) then
	if NOT isnull(kw_g_tab) then
		if NOT isnull(kw_g_tab.ki_menu) and isvalid(kw_g_tab.ki_menu) then 
			ki_menu = kw_g_tab.ki_menu
		else
			ki_menu = kw_g_tab.menuid
		end if
	end if
else
	ki_menu = w_main.menuid
end if


if isvalid(ki_menu) then
	k_return = true
end if

return k_return

end function

on w_menu_tree.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.pb_1=create pb_1
this.pb_10=create pb_10
this.pb_11=create pb_11
this.pb_12=create pb_12
this.pb_13=create pb_13
this.pb_2=create pb_2
this.pb_3=create pb_3
this.pb_4=create pb_4
this.pb_5=create pb_5
this.pb_6=create pb_6
this.pb_7=create pb_7
this.pb_8=create pb_8
this.pb_9=create pb_9
this.pb_l1=create pb_l1
this.pb_l10=create pb_l10
this.pb_l2=create pb_l2
this.pb_l3=create pb_l3
this.pb_l4=create pb_l4
this.pb_l5=create pb_l5
this.pb_l6=create pb_l6
this.pb_l71=create pb_l71
this.pb_l72=create pb_l72
this.pb_l73=create pb_l73
this.pb_l74=create pb_l74
this.pb_l75=create pb_l75
this.pb_l8=create pb_l8
this.pb_l9=create pb_l9
this.pb_t1=create pb_t1
this.pb_t2=create pb_t2
this.pb_t3=create pb_t3
this.cbx_txt=create cbx_txt
this.st_l1=create st_l1
this.st_l2=create st_l2
this.st_l3=create st_l3
this.st_l4=create st_l4
this.st_l5=create st_l5
this.st_l6=create st_l6
this.st_l8=create st_l8
this.st_l71=create st_l71
this.st_l72=create st_l72
this.st_l73=create st_l73
this.st_l74=create st_l74
this.st_l75=create st_l75
this.st_l9=create st_l9
this.st_l10=create st_l10
this.st_t1=create st_t1
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
this.st_13=create st_13
this.st_t2=create st_t2
this.st_t3=create st_t3
this.pb_14=create pb_14
this.st_14=create st_14
this.r_sep1=create r_sep1
this.r_sep2=create r_sep2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_5
this.Control[iCurrent+6]=this.st_6
this.Control[iCurrent+7]=this.st_7
this.Control[iCurrent+8]=this.st_8
this.Control[iCurrent+9]=this.st_9
this.Control[iCurrent+10]=this.pb_1
this.Control[iCurrent+11]=this.pb_10
this.Control[iCurrent+12]=this.pb_11
this.Control[iCurrent+13]=this.pb_12
this.Control[iCurrent+14]=this.pb_13
this.Control[iCurrent+15]=this.pb_2
this.Control[iCurrent+16]=this.pb_3
this.Control[iCurrent+17]=this.pb_4
this.Control[iCurrent+18]=this.pb_5
this.Control[iCurrent+19]=this.pb_6
this.Control[iCurrent+20]=this.pb_7
this.Control[iCurrent+21]=this.pb_8
this.Control[iCurrent+22]=this.pb_9
this.Control[iCurrent+23]=this.pb_l1
this.Control[iCurrent+24]=this.pb_l10
this.Control[iCurrent+25]=this.pb_l2
this.Control[iCurrent+26]=this.pb_l3
this.Control[iCurrent+27]=this.pb_l4
this.Control[iCurrent+28]=this.pb_l5
this.Control[iCurrent+29]=this.pb_l6
this.Control[iCurrent+30]=this.pb_l71
this.Control[iCurrent+31]=this.pb_l72
this.Control[iCurrent+32]=this.pb_l73
this.Control[iCurrent+33]=this.pb_l74
this.Control[iCurrent+34]=this.pb_l75
this.Control[iCurrent+35]=this.pb_l8
this.Control[iCurrent+36]=this.pb_l9
this.Control[iCurrent+37]=this.pb_t1
this.Control[iCurrent+38]=this.pb_t2
this.Control[iCurrent+39]=this.pb_t3
this.Control[iCurrent+40]=this.cbx_txt
this.Control[iCurrent+41]=this.st_l1
this.Control[iCurrent+42]=this.st_l2
this.Control[iCurrent+43]=this.st_l3
this.Control[iCurrent+44]=this.st_l4
this.Control[iCurrent+45]=this.st_l5
this.Control[iCurrent+46]=this.st_l6
this.Control[iCurrent+47]=this.st_l8
this.Control[iCurrent+48]=this.st_l71
this.Control[iCurrent+49]=this.st_l72
this.Control[iCurrent+50]=this.st_l73
this.Control[iCurrent+51]=this.st_l74
this.Control[iCurrent+52]=this.st_l75
this.Control[iCurrent+53]=this.st_l9
this.Control[iCurrent+54]=this.st_l10
this.Control[iCurrent+55]=this.st_t1
this.Control[iCurrent+56]=this.st_10
this.Control[iCurrent+57]=this.st_11
this.Control[iCurrent+58]=this.st_12
this.Control[iCurrent+59]=this.st_13
this.Control[iCurrent+60]=this.st_t2
this.Control[iCurrent+61]=this.st_t3
this.Control[iCurrent+62]=this.pb_14
this.Control[iCurrent+63]=this.st_14
this.Control[iCurrent+64]=this.r_sep1
this.Control[iCurrent+65]=this.r_sep2
end on

on w_menu_tree.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.pb_1)
destroy(this.pb_10)
destroy(this.pb_11)
destroy(this.pb_12)
destroy(this.pb_13)
destroy(this.pb_2)
destroy(this.pb_3)
destroy(this.pb_4)
destroy(this.pb_5)
destroy(this.pb_6)
destroy(this.pb_7)
destroy(this.pb_8)
destroy(this.pb_9)
destroy(this.pb_l1)
destroy(this.pb_l10)
destroy(this.pb_l2)
destroy(this.pb_l3)
destroy(this.pb_l4)
destroy(this.pb_l5)
destroy(this.pb_l6)
destroy(this.pb_l71)
destroy(this.pb_l72)
destroy(this.pb_l73)
destroy(this.pb_l74)
destroy(this.pb_l75)
destroy(this.pb_l8)
destroy(this.pb_l9)
destroy(this.pb_t1)
destroy(this.pb_t2)
destroy(this.pb_t3)
destroy(this.cbx_txt)
destroy(this.st_l1)
destroy(this.st_l2)
destroy(this.st_l3)
destroy(this.st_l4)
destroy(this.st_l5)
destroy(this.st_l6)
destroy(this.st_l8)
destroy(this.st_l71)
destroy(this.st_l72)
destroy(this.st_l73)
destroy(this.st_l74)
destroy(this.st_l75)
destroy(this.st_l9)
destroy(this.st_l10)
destroy(this.st_t1)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.st_13)
destroy(this.st_t2)
destroy(this.st_t3)
destroy(this.pb_14)
destroy(this.st_14)
destroy(this.r_sep1)
destroy(this.r_sep2)
end on

event u_open;//
try

	kguo_g.kgw_toolbar_programmi = this
	
	if isvalid(w_main) then
		if isvalid(w_main.ki_menu_0) then
			if not isnull(w_main.ki_menu_0) then
				ki_menu = w_main.ki_menu_0
			else
				ki_menu = w_main.ki_menu_0
			end if
		else
			ki_menu = m_main
		end if
	else
		ki_menu = m_main
	end if
	
	open_start_window( )
	
	inizializza( )
	
	ki_st_open_w.flag_primo_giro = "N"
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
end try


end event

event close;//
//	setnull(kguo_g.kgw_toolbar_programmi)

string k_rc
st_profilestring_ini kst_profile_string_ini

	
	if cbx_txt.checked then
		kst_profile_string_ini.valore = "1"
	else
		kst_profile_string_ini.valore = "0"
	end if
	kst_profile_string_ini.nome = "menutoolbar_testo"
	k_rc = kGuf_data_base.profilestring_ini(kst_profile_string_ini)

	if isvalid(kguo_g.kgw_toolbar_programmi) then destroy kguo_g.kgw_toolbar_programmi
end event

event u_activate;//
//
w_g_tab kw_g_tab
boolean k_inizializza = true


if not ki_exit_si and not kguo_g.kG_exit_si then
	
	kw_g_tab = kGuf_data_base.prendi_win_attiva( )
	if isvalid(kw_g_tab) then
		if NOT isnull(kw_g_tab) then
			k_inizializza = false
			ki_menu = kw_g_tab.ki_menu
		end if
	end if


//--- se non c'e' alcun menu non faccio sta roba
	if k_inizializza then
		if isvalid(w_main) then
			k_inizializza = false
			ki_menu = w_main.ki_menu_0
//---	rifà la toolbar!
//			w_main.ki_menu_0.reset_menu_all( )
			w_main.ki_menu_0.u_imposta_window_menu()		
		end if
	end if
	
end if

end event

event deactivate;//

end event

event ue_menu;//
return 1
end event

event u_ricevi_da_elenco;//

end event

event open;//

	ki_st_open_w.flag_primo_giro = "S"

//--- altre operazioni
	post event u_open( )

end event

type st_ritorna from w_g_tab`st_ritorna within w_menu_tree
integer x = 14
integer y = 2808
integer textsize = -7
string facename = "Verdana"
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_menu_tree
integer x = 14
integer y = 3052
integer textsize = -7
string facename = "Verdana"
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_menu_tree
integer x = 14
integer y = 2968
integer textsize = -7
string facename = "Verdana"
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_menu_tree
integer x = 9
integer y = 2728
integer taborder = 0
end type

type st_stampa from w_g_tab`st_stampa within w_menu_tree
integer x = 14
integer y = 2884
integer textsize = -7
string facename = "Verdana"
end type

type st_1 from statictext within w_menu_tree
boolean visible = false
integer x = 105
integer y = 112
integer width = 210
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "Nav."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_menu_tree
boolean visible = false
integer x = 96
integer y = 220
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "1"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_menu_tree
boolean visible = false
integer x = 96
integer y = 308
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_menu_tree
boolean visible = false
integer x = 96
integer y = 396
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_menu_tree
boolean visible = false
integer x = 96
integer y = 488
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_menu_tree
boolean visible = false
integer x = 69
integer y = 588
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_menu_tree
boolean visible = false
integer x = 96
integer y = 704
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_menu_tree
boolean visible = false
integer x = 96
integer y = 788
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_9 from statictext within w_menu_tree
boolean visible = false
integer x = 96
integer y = 900
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_menu_tree
boolean visible = false
integer x = 27
integer y = 80
integer width = 123
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "treeview!"
alignment htextalign = left!
string powertiptext = "Navigazione dati magazzino"
end type

event clicked;//
u_toolbar_click(1)

end event

type pb_10 from picturebutton within w_menu_tree
boolean visible = false
integer x = 27
integer y = 972
integer width = 123
integer height = 104
integer taborder = 110
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DRaised!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_click(10)

end event

type pb_11 from picturebutton within w_menu_tree
boolean visible = false
integer x = 23
integer y = 1068
integer width = 123
integer height = 104
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DRaised!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_click(11)

end event

type pb_12 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 1164
integer width = 123
integer height = 104
integer taborder = 120
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DRaised!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_click(12)

end event

type pb_13 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 1256
integer width = 123
integer height = 104
integer taborder = 130
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DRaised!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_click(13)

end event

type pb_2 from picturebutton within w_menu_tree
boolean visible = false
integer x = 27
integer y = 188
integer width = 123
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "picture!"
alignment htextalign = left!
string powertiptext = "Elenco Anagrafiche"
end type

event clicked;//
u_toolbar_click(2)

end event

type pb_3 from picturebutton within w_menu_tree
boolean visible = false
integer x = 18
integer y = 284
integer width = 123
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "picture!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_click(3)

end event

type pb_4 from picturebutton within w_menu_tree
boolean visible = false
integer x = 9
integer y = 376
integer width = 123
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "picture!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_click(4)

end event

type pb_5 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 468
integer width = 123
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "picture!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_click(5)

end event

type pb_6 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 572
integer width = 123
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "picture!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_click(6)

end event

type pb_7 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 680
integer width = 123
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "picture!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_click(7)

end event

type pb_8 from picturebutton within w_menu_tree
boolean visible = false
integer x = 32
integer y = 776
integer width = 123
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "picture!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_click(8)

end event

type pb_9 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 872
integer width = 123
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "picture!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_click(9)

end event

type pb_l1 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 1404
integer width = 123
integer height = 104
integer taborder = 140
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(1)

end event

type pb_l10 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 1960
integer width = 123
integer height = 104
integer taborder = 250
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(10)

end event

type pb_l2 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 1480
integer width = 123
integer height = 104
integer taborder = 150
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(2)

end event

type pb_l3 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 1540
integer width = 123
integer height = 104
integer taborder = 160
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(3)

end event

type pb_l4 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 1620
integer width = 123
integer height = 104
integer taborder = 170
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(4)

end event

type pb_l5 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 1684
integer width = 123
integer height = 104
integer taborder = 180
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(5)

end event

type pb_l6 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 1748
integer width = 123
integer height = 104
integer taborder = 190
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(6)

end event

type pb_l71 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 2080
integer width = 123
integer height = 104
integer taborder = 200
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(71)

end event

type pb_l72 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 2164
integer width = 123
integer height = 104
integer taborder = 210
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(72)

end event

type pb_l73 from picturebutton within w_menu_tree
boolean visible = false
integer x = 18
integer y = 2216
integer width = 123
integer height = 104
integer taborder = 230
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(73)

end event

type pb_l74 from picturebutton within w_menu_tree
boolean visible = false
integer x = 9
integer y = 2272
integer width = 123
integer height = 104
integer taborder = 260
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(74)

end event

type pb_l75 from picturebutton within w_menu_tree
boolean visible = false
integer x = 9
integer y = 2344
integer width = 123
integer height = 104
integer taborder = 270
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(75)

end event

type pb_l8 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 1820
integer width = 123
integer height = 104
integer taborder = 220
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(8)

end event

type pb_l9 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 1896
integer width = 123
integer height = 104
integer taborder = 240
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DLowered!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_lib_click(9)

end event

type pb_t1 from picturebutton within w_menu_tree
boolean visible = false
integer x = 9
integer y = 2444
integer width = 123
integer height = 104
integer taborder = 280
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "BorderBox!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_t_click(1)

end event

type pb_t2 from picturebutton within w_menu_tree
boolean visible = false
integer y = 2516
integer width = 123
integer height = 104
integer taborder = 290
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "BorderBox!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_t_click(2)

end event

type pb_t3 from picturebutton within w_menu_tree
boolean visible = false
integer x = 5
integer y = 2604
integer width = 123
integer height = 104
integer taborder = 300
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "BorderBox!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_t_click(3)

end event

type cbx_txt from checkbox within w_menu_tree
integer x = 50
integer y = 8
integer width = 87
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
boolean checked = true
end type

event clicked;//
u_resize( )

end event

type st_l1 from statictext within w_menu_tree
boolean visible = false
integer x = 151
integer y = 1424
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_l2 from statictext within w_menu_tree
boolean visible = false
integer x = 151
integer y = 1512
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_l3 from statictext within w_menu_tree
boolean visible = false
integer x = 151
integer y = 1576
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_l4 from statictext within w_menu_tree
boolean visible = false
integer x = 151
integer y = 1652
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_l5 from statictext within w_menu_tree
boolean visible = false
integer x = 137
integer y = 1712
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_l6 from statictext within w_menu_tree
boolean visible = false
integer x = 142
integer y = 1788
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_l8 from statictext within w_menu_tree
boolean visible = false
integer x = 133
integer y = 1836
integer width = 219
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_l71 from statictext within w_menu_tree
boolean visible = false
integer x = 165
integer y = 2096
integer width = 219
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_l72 from statictext within w_menu_tree
boolean visible = false
integer x = 133
integer y = 2168
integer width = 219
integer height = 52
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_l73 from statictext within w_menu_tree
boolean visible = false
integer x = 137
integer y = 2228
integer width = 219
integer height = 52
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_l74 from statictext within w_menu_tree
boolean visible = false
integer x = 142
integer y = 2304
integer width = 219
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_l75 from statictext within w_menu_tree
boolean visible = false
integer x = 142
integer y = 2372
integer width = 219
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_l9 from statictext within w_menu_tree
boolean visible = false
integer x = 123
integer y = 1920
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_l10 from statictext within w_menu_tree
boolean visible = false
integer x = 123
integer y = 2000
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_t1 from statictext within w_menu_tree
boolean visible = false
integer x = 137
integer y = 2476
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_10 from statictext within w_menu_tree
boolean visible = false
integer x = 96
integer y = 1012
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_11 from statictext within w_menu_tree
boolean visible = false
integer x = 96
integer y = 1104
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_12 from statictext within w_menu_tree
boolean visible = false
integer x = 96
integer y = 1200
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_13 from statictext within w_menu_tree
boolean visible = false
integer x = 96
integer y = 1284
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_t2 from statictext within w_menu_tree
boolean visible = false
integer x = 137
integer y = 2544
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_t3 from statictext within w_menu_tree
boolean visible = false
integer x = 137
integer y = 2628
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_14 from picturebutton within w_menu_tree
boolean visible = false
integer x = 14
integer y = 1348
integer width = 123
integer height = 104
integer taborder = 140
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Border3DRaised!"
alignment htextalign = left!
end type

event clicked;//
u_toolbar_click(14)

end event

type st_14 from statictext within w_menu_tree
boolean visible = false
integer x = 96
integer y = 1376
integer width = 219
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 32238571
string text = "."
alignment alignment = center!
boolean focusrectangle = false
end type

type r_sep1 from roundrectangle within w_menu_tree
long linecolor = 12632256
linestyle linestyle = dot!
integer linethickness = 4
long fillcolor = 8421504
fillpattern fillpattern = diamond!
integer x = 366
integer y = 1172
integer width = 123
integer height = 8
integer cornerheight = 40
integer cornerwidth = 46
end type

type r_sep2 from roundrectangle within w_menu_tree
long linecolor = 12632256
linestyle linestyle = dot!
integer linethickness = 4
long fillcolor = 8421504
fillpattern fillpattern = diamond!
integer x = 366
integer y = 1036
integer width = 123
integer height = 8
integer cornerheight = 40
integer cornerwidth = 46
end type

