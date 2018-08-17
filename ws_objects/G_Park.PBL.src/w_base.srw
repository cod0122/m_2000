$PBExportHeader$w_base.srw
forward
global type w_base from w_g_tab
end type
type cb_conferma from commandbutton within w_base
end type
type tab_1 from tab within w_base
end type
type tabpage_generale from userobject within tab_1
end type
type dw_1 from datawindow within tabpage_generale
end type
type tabpage_generale from userobject within tab_1
dw_1 dw_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_dett_0 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_dett_0 dw_dett_0
end type
type tabpage_p from userobject within tab_1
end type
type dw_p from datawindow within tabpage_p
end type
type tabpage_p from userobject within tab_1
dw_p dw_p
end type
type tabpage_4 from userobject within tab_1
end type
type st_1 from statictext within tabpage_4
end type
type cb_pilota_proprieta from commandbutton within tabpage_4
end type
type dw_dett_2 from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
st_1 st_1
cb_pilota_proprieta cb_pilota_proprieta
dw_dett_2 dw_dett_2
end type
type tabpage_5 from userobject within tab_1
end type
type st_2 from statictext within tabpage_5
end type
type cb_wm_pklist_cfg from commandbutton within tabpage_5
end type
type dw_2 from datawindow within tabpage_5
end type
type tabpage_5 from userobject within tab_1
st_2 st_2
cb_wm_pklist_cfg cb_wm_pklist_cfg
dw_2 dw_2
end type
type tab_1 from tab within w_base
tabpage_generale tabpage_generale
tabpage_2 tabpage_2
tabpage_p tabpage_p
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
end forward

global type w_base from w_g_tab
integer x = 59
integer y = 48
integer width = 3351
integer height = 2248
string title = "Proprietà della Procedura"
long backcolor = 255
boolean toolbarvisible = false
boolean ki_sicronizza_window_consenti = false
cb_conferma cb_conferma
tab_1 tab_1
end type
global w_base w_base

type variables
//
//w_base kiw_this_window


string k_record_orig

end variables

forward prototypes
public subroutine scrivi_base ()
public subroutine leggi_base ()
protected function string inizializza () throws uo_exception
private subroutine stampa ()
private subroutine get_cartella_path_pilota ()
private subroutine get_path_centrale ()
private subroutine get_path_pgm_upd ()
protected subroutine smista_funz (string k_par_in)
protected subroutine attiva_menu ()
end prototypes

public subroutine scrivi_base ();//
//=== Aggiorna il BASE
//
kuf_base  kuf1_base
string k_record
string k_errore="0 "
string k_text, k_dati_id
int k_len, k_len_1, k_punt, k_ctr, k_ctr_1, k_errore_1, k_errore_agg=0
st_tab_base kst_tab_base
st_esito kst_esito


//tab_1.tabpage_personale.dw_dett_0.accepttext()
tab_1.tabpage_p.dw_p.accepttext()
tab_1.tabpage_generale.dw_1.accepttext()



//=== Aggiorno BASE
if tab_1.tabpage_generale.dw_1.getitemstatus(1, 0, primary!) = datamodified! or &
	tab_1.tabpage_generale.dw_1.getitemstatus(1, 0, primary!) = newmodified! then
	k_errore_1 = tab_1.tabpage_generale.dw_1.update()

	if k_errore_1 > 0 then
		
		kuf1_base = create kuf_base
		kst_tab_base.id_base = tab_1.tabpage_generale.dw_1.object.id[1]
		kst_tab_base.fatt_bolli_lim_stampa = tab_1.tabpage_generale.dw_1.object.base_fatt_bolli_lim_stampa[1] 
		kst_tab_base.fatt_bolli_note = tab_1.tabpage_generale.dw_1.object.base_fatt_bolli_note[1] 
		kst_tab_base.fatt_banca = tab_1.tabpage_generale.dw_1.object.base_fatt_banca[1] 
		if isnull (tab_1.tabpage_generale.dw_1.object.base_fatt_impon_minimo[1] ) then
			kst_tab_base.fatt_impon_minimo = 0
		else
			kst_tab_base.fatt_impon_minimo = tab_1.tabpage_generale.dw_1.object.base_fatt_impon_minimo[1] 
		end if
		kst_tab_base.st_tab_g_0.esegui_commit = "N" 
		kst_esito = kuf1_base.tb_update_base_fatt(kst_tab_base) 
		destroy kuf1_base
		if kst_esito.esito <> kkg_esito_db_ko then 
		
			COMMIT USING sqlca;
		else
			
			ROLLBACK USING sqlca;
			k_errore_agg = 1
			messagebox("Archivio 'Proprietà Procedura' Non Aggiornato (errore base_fatt):", trim(kst_esito.SQLErrText), &
							stopsign!, ok!) 
		end if
	ELSE
		ROLLBACK USING sqlca;

		k_errore_agg = 1
		messagebox("Archivio 'Proprietà Procedura' Non Aggiornato:", trim(sqlca.SQLErrText), &
						stopsign!, ok!) 
	end if
end if



if tab_1.tabpage_p.dw_p.getitemstatus(1, 0, primary!) = datamodified! or &
	tab_1.tabpage_p.dw_p.getitemstatus(1, 0, primary!) = newmodified! then

//=== Aggiorno parole chiavi
	k_errore_1 = tab_1.tabpage_p.dw_p.update()

	if k_errore_1 > 0 then
		COMMIT USING sqlca;
	ELSE
		ROLLBACK USING sqlca;

		k_errore_agg = 1
		messagebox("Password NON aggiornate:", trim(sqlca.SQLErrText), &
						stopsign!, ok!) 
	end if
end if


if	k_errore_agg = 0 then

	cb_ritorna.triggerevent (clicked!)

end if

end subroutine

public subroutine leggi_base ();//
//=== Legge l'archivio sequenzale di BASE
//
kuf_base kuf1_base
string k_record="0 "
string k_nome_db, k_parametro_db, k_path_db, k_path_dw
string k_nome_dbf, k_parametro_dbf, k_path_dbf
int k_ctr, k_ctr_1, k_punt, k_len
datawindowchild kdwc_menu


//kuf1_base = create kuf_base
////=== Torna: 1 char "0"=OK; "1"=ERRORE
////===        2 char in poi Record letto; Spiegazione errore  
//k_record = kuf1_base.leggi_base()
//
////=== Salvo in questa variabile globale di Window il rek Base
//k_record_orig = mid(k_record, 2)
//
//if len(k_record_orig) < 1024 then
//	k_record_orig = k_record_orig + space((1024 - len(k_record_orig)))
//end if
//
//if left(k_record, 1) = "1" then
//
//	messagebox("Archivio Base Non Disponibile", mid(k_record, 2), &
//					stopsign!, ok!) 
//	cb_abbandona.postevent (clicked!)
//
//else
//
//
////--- Attivo dw archivio MENU WINDOW
//	tab_1.tabpage_personale.dw_dett_0.getchild("finestra_inizio", kdwc_menu)
//
//	kdwc_menu.settransobject(sqlca)
//
//	k_record = mid(k_record, 2)
//
//	tab_1.tabpage_personale.dw_dett_0.insertrow(0)
//
//	if kdwc_menu.rowcount() = 0 then
//		kdwc_menu.retrieve()
//		kdwc_menu.insertrow(1)
//		kdwc_menu.setitem(1, "descr", "<Nulla>")
//		kdwc_menu.setitem(1, "id", "  ")
//	end if
//
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "rag_soc", trim(mid(k_record, 1, 48)))
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "indirizzo", trim(mid(k_record, 49, 24)))
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "localita", trim(mid(k_record, 73, 24)))
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "provincia", trim(mid(k_record, 97, 2)))
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "cap", trim(mid(k_record, 99, 5)))
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "p_iva", trim(mid(k_record, 104, 11)))
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "titolo_main", trim(mid(k_record, 115, 24)))
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "anno", trim(mid(k_record, 139, 4)))
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "finestra_inizio", trim(mid(k_record, 143, 13)))
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "font_alt", trim(mid(k_record, 156, 3)))
////	tab_1.tabpage_personale.dw_dett_0.setitem(1, "divisione", trim(mid(k_record, 160, 6)))
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "flag_salva_liste", trim(mid(k_record, 180, 1)))
////	tab_1.tabpage_personale.dw_dett_0.setitem(1, "ult_nr_commessa", trim(mid(k_record, 190, 10)))
////	tab_1.tabpage_personale.dw_dett_0.setitem(1, "ult_data_commessa", trim(mid(k_record, 200, 10)))
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "banca", trim(mid(k_record, 343, 45)))
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "tel", trim(mid(k_record, 388, 20)))
//	tab_1.tabpage_personale.dw_dett_0.setitem(1, "fax", trim(mid(k_record, 408, 20)))
//
//=== dw delle PASSWORD
//	tab_1.tabpage_p.dw_p.insertrow(0)
	if tab_1.tabpage_generale.enabled then
		tab_1.tabpage_generale.dw_1.retrieve()
	end if
	if tab_1.tabpage_p.enabled then
		tab_1.tabpage_p.dw_p.retrieve()
	end if

//
////=== Leggo contenuto del file di profilo il KG_PATH_PROCEDURA + "\confdb.ini" 	
//	k_nome_db = profilestring ( KG_PATH_PROCEDURA + "\confdb.ini", "Database", "DBMS","<NULLA>")
//	k_parametro_db = profilestring ( KG_PATH_PROCEDURA + "\confdb.ini", "Database", "DbParm","<NULLA>")
//	k_path_dw = profilestring ( KG_PATH_PROCEDURA + "\confdb.ini", "ambiente", "arch_saveas", "<NULLA>")
//	k_path_db = profilestring ( KG_PATH_PROCEDURA + "\confdb.ini", "ambiente", "arch_base", "<NULLA>")
////	k_nome_dbf = profilestring ( "KG_PATH_PROCEDURA + "\confdb.ini"", "Database_dbf", "DBMS","<NULLA (dbmax)>")
////	k_parametro_dbf = profilestring ( "KG_PATH_PROCEDURA + "\confdb.ini"", "Database_dbf", "DbParm","<NULLA (dbmax)>")
////	k_path_dbf = profilestring ( "KG_PATH_PROCEDURA + "\confdb.ini"", "ambiente", "arch_base_1", "<NULLA (/at_eco)>")
//
//	tab_1.tabpage_connessione.dw_dett_2.insertrow(0)
//	tab_1.tabpage_connessione.dw_dett_2.setitem(1, "nome_db", trim(k_nome_db))
//	tab_1.tabpage_connessione.dw_dett_2.setitem(1, "param_db", trim(k_parametro_db))
//	tab_1.tabpage_connessione.dw_dett_2.setitem(1, "path_db", trim(k_path_db))
//	tab_1.tabpage_connessione.dw_dett_2.setitem(1, "path_prog", trim(KG_PATH_PROCEDURA))
////	tab_1.tabpage_connessione.dw_dett_2.setitem(1, "param_dbf", trim(k_parametro_dbf))
////	tab_1.tabpage_connessione.dw_dett_2.setitem(1, "path_dbf", trim(k_path_dbf))
//	tab_1.tabpage_connessione.dw_dett_2.setitem(1, "path_files_dat", trim(k_path_dw))
//
//end if


end subroutine

protected function string inizializza () throws uo_exception;//----

	leggi_base()
	
	attiva_menu()

return "0"

end function

private subroutine stampa ();//
//=== stampa dw
string k_errore
st_stampe kst_stampe

		

	choose case tab_1.selectedtab
		case 1
			kst_stampe.dw_print = tab_1.tabpage_generale.dw_1
			kst_stampe.titolo = trim(tab_1.tabpage_generale.text)
			k_errore = string(kuf1_data_base.stampa_dw(kst_stampe))
//		case 2
//			k_errore = string(kuf1_data_base.stampa_dw(tab_1.tabpage_personale.dw_dett_0, &
//					tab_1.tabpage_personale.text))
		case 3
			kst_stampe.dw_print = tab_1.tabpage_p.dw_p
			kst_stampe.titolo = trim(tab_1.tabpage_p.text)
			k_errore = string(kuf1_data_base.stampa_dw(kst_stampe))
//		case 4
//			k_errore = string(kuf1_data_base.stampa_dw(tab_1.tabpage_connessione.dw_dett_2, &
//					tab_1.tabpage_connessione.text))
//		case 5
//			k_errore = string(kuf1_data_base.stampa_dw(tab_1.tabpage_errori.dw_2, &
//					tab_1.tabpage_errori.text))
	end choose


end subroutine

private subroutine get_cartella_path_pilota ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_generale.dw_1.getitemstring (1, "fpilota_out_path")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegli Cartella Scambio con il Pilota", k_path )

if k_ret = 1 then
	tab_1.tabpage_generale.dw_1.setitem(1, "fpilota_out_path", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine get_path_centrale ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_generale.dw_1.getitemstring (1, "path_centrale")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegli Cartella Server Centrale", k_path )

if k_ret = 1 then
	tab_1.tabpage_generale.dw_1.setitem(1, "path_centrale", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

private subroutine get_path_pgm_upd ();//
string k_path=".."
int k_ret


k_path = tab_1.tabpage_generale.dw_1.getitemstring (1, "path_pgm_upd")
if len(trim(k_path)) > 0 then
else
	k_path=".."
end if

k_ret = GetFolder ( "Scegli Cartella di Aggiornamento Procedura ", k_path )

if k_ret = 1 then
	tab_1.tabpage_generale.dw_1.setitem(1, "path_pgm_upd", trim(k_path))
else
	if k_ret < 0 then
//--- ERRORE	
	end if
end if


end subroutine

protected subroutine smista_funz (string k_par_in);//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===


choose case trim(k_par_in) 

	case kkg_flag_richiesta_refresh		//Aggiorna Liste
		leggi_base()

	case kkg_flag_richiesta_conferma		//Aggiorna DB
		scrivi_base()		

	case else
		super::smista_funz(k_par_in)


end choose


end subroutine

protected subroutine attiva_menu ();//
st_stampa.enabled = true
super::attiva_menu()
kG_menu.m_finestra.m_gestione.m_fin_conferma.enabled = true

end subroutine

event open;//
//int k_index=1 


//=== Mostra Finestra : max=61472; min=61488; normal=61728
//send(handle(this), 274, 61728, 0)

//=== Parametri passati con il WITHPARM
ki_st_open_w = message.powerobjectparm

kiw_this_window = this
ki_nome_save = trim(this.ClassName())

tab_1.tabpage_generale.dw_1.settransobject ( sqlca )

tab_1.tabpage_p.dw_p.settransobject ( sqlca )

this.tab_1.tabpage_5.picturename = kg_path_risorse + "\pklist.ico"

this.width = w_main.width * .90
this.height = w_main.height * .86
this.x = 100
this.y = 10

try
	post inizializza()

catch (uo_exception kuo_exception)

end try

end event

event close;//window k_window
//---
int k_chiudi

k_chiudi = kuf1_data_base.close_win(kiw_this_window, trim(ki_nome_save ))


end event

on w_base.create
int iCurrent
call super::create
this.cb_conferma=create cb_conferma
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_conferma
this.Control[iCurrent+2]=this.tab_1
end on

on w_base.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_conferma)
destroy(this.tab_1)
end on

event resize;int k_ctr


this.setredraw(false)

////=== Posiziona window all'interno MDI 
//if w_main.width > this.width then
//	this.x = (w_main.width - this.width) / 4
//else
//end if
//if w_main.height > this.height then
//	this.y = (w_main.height - this.height) / 6
//else
//end if
 

tab_1.width = this.width - 100
tab_1.height = this.height - 100 - cb_conferma.height * 2 

//tab_1.tabpage_generale.x = 50
//tab_1.tabpage_generale.y = 50
//tab_1.tabpage_p.x = tab_1.tabpage_generale.x
//tab_1.tabpage_p.y = tab_1.tabpage_generale.y

tab_1.tabpage_generale.dw_1.x = 50 //(tab_1.tabpage_generale.width - tab_1.tabpage_p.dw_p.width) / 2
tab_1.tabpage_generale.dw_1.y = 30 //(tab_1.tabpage_generale.height - tab_1.tabpage_p.dw_p.height) / 2
tab_1.tabpage_p.dw_p.x = tab_1.tabpage_generale.dw_1.x
tab_1.tabpage_p.dw_p.y = tab_1.tabpage_generale.dw_1.y

tab_1.tabpage_generale.dw_1.width = tab_1.tabpage_generale.width * 0.97
tab_1.tabpage_p.dw_p.width = tab_1.tabpage_generale.width * 0.97

tab_1.tabpage_generale.dw_1.height = tab_1.tabpage_generale.height * 0.98 
tab_1.tabpage_p.dw_p.height = tab_1.tabpage_generale.height * 0.98

cb_conferma.x = tab_1.x + tab_1.width - cb_conferma.width * 2 - 50
cb_conferma.y = tab_1.y + tab_1.height + 20 //cb_conferma.y / 3
cb_ritorna.x = cb_conferma.x + cb_conferma.width + 50
cb_ritorna.y = cb_conferma.y

//tab_1.tabpage_errori.x = tab_1.tabpage_generale.x
//tab_1.tabpage_errori.y = tab_1.tabpage_generale.y
//tab_1.tabpage_errori.dw_2.width = tab_1.tabpage_errori.width - 100
//tab_1.tabpage_errori.dw_2.Object.errori.width = tab_1.tabpage_errori.dw_2.width - 300

//tab_1.tabpage_errori.dw_2.height = tab_1.tabpage_errori.height - 200
//
//tab_1.tabpage_errori.dw_2.x = 50
//
//tab_1.tabpage_errori.dw_2.y = 50
//
//tab_1.tabpage_errori.dw_2.Object.errori.edit.AutoVScroll = TRUE
//tab_1.tabpage_errori.dw_2.Object.errori.edit.VScrollBar	= TRUE


this.setredraw(true)

end event

event closequery;//
//this.setredraw(false)

end event

type st_ordina_lista from w_g_tab`st_ordina_lista within w_base
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_base
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_base
boolean visible = true
integer x = 2510
integer y = 1892
integer width = 635
integer height = 84
integer weight = 700
string text = "&Chiudi"
end type

type st_stampa from w_g_tab`st_stampa within w_base
end type

type st_ritorna from w_g_tab`st_ritorna within w_base
end type

type dw_trova from w_g_tab`dw_trova within w_base
integer x = 882
integer y = 1820
end type

type dw_filtra from w_g_tab`dw_filtra within w_base
integer x = 901
integer y = 1656
end type

type cb_conferma from commandbutton within w_base
integer x = 64
integer y = 1844
integer width = 635
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Conferma"
end type

on clicked;//
scrivi_base()
end on

type tab_1 from tab within w_base
integer x = 5
integer y = 8
integer width = 3250
integer height = 1836
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long backcolor = 67108864
boolean multiline = true
boolean focusonbuttondown = true
boolean powertips = true
boolean boldselectedtext = true
boolean perpendiculartext = true
tabposition tabposition = tabsonleft!
integer selectedtab = 1
tabpage_generale tabpage_generale
tabpage_2 tabpage_2
tabpage_p tabpage_p
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

event selectionchanged;//
string k_errore 


choose case newindex
	case 1 
//		dw_dett_0.width = tabpage_generale.width
//		dw_dett_0.height = tabpage_generale.height
//		dw_dett_0.x = tabpage_generale.x + 70		
//		dw_dett_0.y = tabpage_generale.y + 30
//		dw_dett_0.visible = true
	case 2
//		dw_dett_2.width = tabpage_connessione.width
//		dw_dett_2.height = tabpage_connessione.height
//		dw_dett_2.x = tabpage_connessione.x
//		dw_dett_2.y = tabpage_connessione.y
//		dw_dett_2.visible = true
	case 3
//		dw_dett_2.width = tabpage_connessione.width
//		dw_dett_2.height = tabpage_connessione.height
//		dw_dett_2.x = tabpage_connessione.x
//		dw_dett_2.y = tabpage_connessione.y
//		dw_dett_2.visible = true

	case 5
//		k_errore = trim(kuf1_data_base.errori_db("R", ""))
//		if k_errore = "1" then
//			k_errore = "Nessun Errore da visualizzare"
//		end if
//		tab_1.tabpage_errori.dw_2.reset() 
//		tab_1.tabpage_errori.dw_2.insertrow(0) 
//		tab_1.tabpage_errori.dw_2.setitem(1,"errori", k_errore)
//
//		tab_1.tabpage_errori.dw_2.insertrow(0) 
////tab_1.tabpage_errori.dw_2.Object.errori.edit.Multiline = true
//		k_errore = trim(kuf1_data_base.errorlog_riempi_dw(tab_1.tabpage_errori.dw_2,2,1))
//		if k_errore = "1" then
//			k_errore = "Nessun Errore da visualizzare"
//			tab_1.tabpage_errori.dw_2.setitem(2,"errori", "Nessun Errore da visualizzare")
//		end if

		
end choose

choose case oldindex
	case 1 
//		dw_dett_0.visible = false
	case 2
//		dw_dett_2.visible = false
	case 3
//		dw_dett_2.visible = false
	case 4
//		mle_errori.visible = false
		
end choose


end event

on tab_1.create
this.tabpage_generale=create tabpage_generale
this.tabpage_2=create tabpage_2
this.tabpage_p=create tabpage_p
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={this.tabpage_generale,&
this.tabpage_2,&
this.tabpage_p,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_1.destroy
destroy(this.tabpage_generale)
destroy(this.tabpage_2)
destroy(this.tabpage_p)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

type tabpage_generale from userobject within tab_1
integer x = 567
integer y = 16
integer width = 2665
integer height = 1804
long backcolor = 31449055
string text = "Generale"
long tabtextcolor = 33554432
string picturename = "Application!"
long picturemaskcolor = 536870912
string powertiptext = "Configurazione della Procedura"
dw_1 dw_1
end type

on tabpage_generale.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_generale.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_generale
integer y = 12
integer width = 2647
integer height = 1484
integer taborder = 42
string title = "none"
string dataobject = "d_base_gen"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rbuttondown;//
	datawindow kdw
	kdw = this
	
//--- Calendario
	if row > 0 then
		if dwo.type = "column" then
			if lower(MidA(dwo.coltype,1,4)) = "date" &
				and integer(this.Describe(trim(dwo.name)+".TabSequence")) > 0 &
				and this.Describe(trim(dwo.name)+".Protect") = "0" & 
				and this.Describe(trim(dwo.name)+".edit.DisplayOnly") <> "yes"   & 
				then
				gf_dw_pop_calendar(kdw,dwo.name,dwo.coltype,row)
			else
				parent.triggerevent(rbuttondown!)
			end if
		else
			parent.triggerevent(rbuttondown!)
		end if
	else
		parent.triggerevent(rbuttondown!)
	end if

	


end event

event clicked;//
string k_upd_last_vers = " "
double k_versione = 0.0


if dwo.name = "update_last_vers_1" then
	k_upd_last_vers = this.GetItemString (1, "update_last_vers") 
	if k_upd_last_vers = "N" or isnull(k_upd_last_vers) then
		
		k_versione = double(this.GetItemString (1, "last_version"))
		if isnull(k_versione) then
			k_versione = 0.0
		end if
		if double(kkG_versione) > k_versione then 
			this.setitem(1, "last_version", kkG_versione)
		end if
		
	end if
end if

end event

event buttonclicked;//
if dwo.name = "b_tab_navigatore" then

	//--- chiamare la window 
	//
	//=== Parametri : 
	//=== struttura st_open_w
	kuf_menu_window kuf1_menu_window
	st_open_w kst_open_w
	
	kuf1_menu_window = create kuf_menu_window 
	kst_open_w.id_programma =kkg_id_programma_treeview_tabella
	kst_open_w.flag_primo_giro = kuf1_menu_window.kki_primo_giro_si
	kst_open_w.flag_modalita = kkg_flag_modalita_modifica
	kst_open_w.flag_adatta_win = KK_ADATTA_WIN
	kst_open_w.flag_leggi_dw = " "
	kst_open_w.flag_cerca_in_lista = " "
	kst_open_w.key2 = ""
	kst_open_w.key3 = "" 
	kst_open_w.key4 = ""
	kst_open_w.key12_any = ""
	kst_open_w.flag_where = " "
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window
	
else
	if dwo.name = "b_path_pilota" then
		get_cartella_path_pilota()
	end if
	if dwo.name = "b_path_centrale" then
		get_path_centrale()
	end if
	if dwo.name = "b_path_upd" then
		get_path_pgm_upd()
	end if
end if

end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 567
integer y = 16
integer width = 2665
integer height = 1804
boolean enabled = false
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_dett_0 dw_dett_0
end type

on tabpage_2.create
this.dw_dett_0=create dw_dett_0
this.Control[]={this.dw_dett_0}
end on

on tabpage_2.destroy
destroy(this.dw_dett_0)
end on

type dw_dett_0 from datawindow within tabpage_2
boolean visible = false
integer x = 261
integer y = 160
integer width = 1819
integer height = 1152
integer taborder = 32
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_nulla"
boolean resizable = true
boolean border = false
boolean livescroll = true
end type

type tabpage_p from userobject within tab_1
integer x = 567
integer y = 16
integer width = 2665
integer height = 1804
long backcolor = 67108864
string text = "Password ~r~nAccesso ~r~nMagazzino-NT"
long tabtextcolor = 33554432
string picturename = "CreateIndex!"
long picturemaskcolor = 536870912
string powertiptext = "Password di validazione programmi ~'Magazzino-NT~'"
dw_p dw_p
end type

on tabpage_p.create
this.dw_p=create dw_p
this.Control[]={this.dw_p}
end on

on tabpage_p.destroy
destroy(this.dw_p)
end on

type dw_p from datawindow within tabpage_p
integer x = 32
integer y = 20
integer width = 2583
integer height = 1732
integer taborder = 32
string dataobject = "d_base_p"
boolean resizable = true
boolean border = false
boolean livescroll = true
end type

type tabpage_4 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 567
integer y = 16
integer width = 2665
integer height = 1804
long backcolor = 67108864
string text = "Pilota"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom076!"
long picturemaskcolor = 536870912
st_1 st_1
cb_pilota_proprieta cb_pilota_proprieta
dw_dett_2 dw_dett_2
end type

on tabpage_4.create
this.st_1=create st_1
this.cb_pilota_proprieta=create cb_pilota_proprieta
this.dw_dett_2=create dw_dett_2
this.Control[]={this.st_1,&
this.cb_pilota_proprieta,&
this.dw_dett_2}
end on

on tabpage_4.destroy
destroy(this.st_1)
destroy(this.cb_pilota_proprieta)
destroy(this.dw_dett_2)
end on

type st_1 from statictext within tabpage_4
integer x = 155
integer y = 204
integer width = 1792
integer height = 184
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Aggiorna le Proprietà di scambio e accesso ai dati tra i Programmi di Gestione  Impianto e la Procedura M2000"
boolean focusrectangle = false
end type

type cb_pilota_proprieta from commandbutton within tabpage_4
integer x = 443
integer y = 472
integer width = 731
integer height = 112
integer taborder = 42
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Proprieta~' Pilota Impianto "
end type

event clicked;//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl_pt;
kuf_menu_window kuf1_menu_window
st_open_w k_st_open_w




K_st_open_w.id_programma = kkg_id_programma_pilota_proprieta
K_st_open_w.flag_primo_giro = "S"
K_st_open_w.flag_modalita = kkg_flag_modalita_modifica
K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
K_st_open_w.flag_leggi_dw = " "
K_st_open_w.key1 = " "
K_st_open_w.key2 = " "
K_st_open_w.key3 = " "
K_st_open_w.key4 = " "
K_st_open_w.flag_where = " "

kuf1_menu_window = create kuf_menu_window 

kuf1_menu_window.open_w_tabelle(k_st_open_w)

destroy kuf1_menu_window


end event

type dw_dett_2 from datawindow within tabpage_4
boolean visible = false
integer x = 1353
integer y = 776
integer width = 1001
integer height = 1000
integer taborder = 31
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_nulla"
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_5 from userobject within tab_1
integer x = 567
integer y = 16
integer width = 2665
integer height = 1804
long backcolor = 67108864
string text = "Warehouse ~r~nManagement"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "C:\GAMMARAD\PB_GMMRD11\ICONE\pklist.ico"
long picturemaskcolor = 536870912
st_2 st_2
cb_wm_pklist_cfg cb_wm_pklist_cfg
dw_2 dw_2
end type

on tabpage_5.create
this.st_2=create st_2
this.cb_wm_pklist_cfg=create cb_wm_pklist_cfg
this.dw_2=create dw_2
this.Control[]={this.st_2,&
this.cb_wm_pklist_cfg,&
this.dw_2}
end on

on tabpage_5.destroy
destroy(this.st_2)
destroy(this.cb_wm_pklist_cfg)
destroy(this.dw_2)
end on

type st_2 from statictext within tabpage_5
integer x = 224
integer y = 184
integer width = 1765
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Aggiorna le Proprietà di scambio e accesso ai dati tra i programmi di Gestione Logistica Magazzino e la Procedura M2000"
boolean focusrectangle = false
end type

type cb_wm_pklist_cfg from commandbutton within tabpage_5
integer x = 398
integer y = 456
integer width = 1115
integer height = 112
integer taborder = 42
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Proprieta~' del Warehouse Management"
end type

event clicked;//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key1=codice sl_pt;
kuf_menu_window kuf1_menu_window 
kuf_wm_pklist_cfg kuf1_wm_pklist_cfg
st_open_w k_st_open_w


kuf1_wm_pklist_cfg = create kuf_wm_pklist_cfg
kuf1_menu_window = create kuf_menu_window


K_st_open_w.id_programma = kuf1_wm_pklist_cfg.get_id_programma(kkg_flag_modalita_modifica)
K_st_open_w.flag_primo_giro = "S"
K_st_open_w.flag_modalita = kkg_flag_modalita_modifica
K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
K_st_open_w.flag_leggi_dw = " "
K_st_open_w.key1 = " "
K_st_open_w.key2 = " "
K_st_open_w.key3 = " "
K_st_open_w.key4 = " "
K_st_open_w.flag_where = " "

kuf1_menu_window.open_w_tabelle(k_st_open_w)

destroy kuf1_wm_pklist_cfg
destroy kuf1_menu_window





end event

type dw_2 from datawindow within tabpage_5
boolean visible = false
integer x = 1573
integer y = 964
integer width = 1193
integer height = 1040
integer taborder = 42
boolean enabled = false
string title = "none"
string dataobject = "d_nulla"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

