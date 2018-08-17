$PBExportHeader$w_base_0.srw
forward
global type w_base_0 from Window
end type
type dw_dett_0 from datawindow within w_base_0
end type
type cb_abbandona from commandbutton within w_base_0
end type
type cb_conferma from commandbutton within w_base_0
end type
end forward

global type w_base_0 from Window
int X=0
int Y=0
int Width=1298
int Height=1168
boolean TitleBar=true
string Title="Propieta' procedura"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean Resizable=true
dw_dett_0 dw_dett_0
cb_abbandona cb_abbandona
cb_conferma cb_conferma
end type
global w_base_0 w_base_0

type variables
string k_record_orig
end variables

forward prototypes
public subroutine leggi_base ()
public subroutine scrivi_base ()
end prototypes

public subroutine leggi_base ();//
//=== Legge l'archivio sequenzale di BASE
//
kuf_base kuf1_base
string k_record="0 "
string k_nome_db, k_parametro_db, k_path_db, k_path_dat


kuf1_base = create kuf_base
//=== Torna: 1 char "0"=OK; "1"=ERRORE
//===        2 char in poi Record letto; Spiegazione errore  
k_record = kuf1_base.leggi_base()

//=== Salvo in questa variabile globale di Window il rek Base
k_record_orig = mid(k_record, 2)
if len(k_record_orig) < 1024 then
	k_record_orig = k_record_orig + space((1024 - len(k_record_orig)))
end if
if left(k_record, 1) = "1" then

	messagebox("Archivio Base Non Disponibile", mid(k_record, 2), &
					stopsign!, ok!) 
	cb_abbandona.postevent (clicked!)

else

	k_record = mid(k_record, 2)

	dw_dett_0.insertrow(0)

	dw_dett_0.setitem(1, "rag_soc", trim(mid(k_record, 1, 48)))
	dw_dett_0.setitem(1, "indirizzo", trim(mid(k_record, 49, 24)))
	dw_dett_0.setitem(1, "localita", trim(mid(k_record, 73, 24)))
	dw_dett_0.setitem(1, "provincia", trim(mid(k_record, 97, 2)))
	dw_dett_0.setitem(1, "cap", trim(mid(k_record, 99, 5)))
	dw_dett_0.setitem(1, "p_iva", trim(mid(k_record, 104, 11)))
	dw_dett_0.setitem(1, "titolo_main", trim(mid(k_record, 115, 24)))
	dw_dett_0.setitem(1, "anno", trim(mid(k_record, 139, 4)))
	dw_dett_0.setitem(1, "finestra_inizio", trim(mid(k_record, 143, 13)))
	dw_dett_0.setitem(1, "font_alt", trim(mid(k_record, 156, 3)))
//	dw_dett_0.setitem(1, "divisione", trim(mid(k_record, 160, 6)))
	dw_dett_0.setitem(1, "flag_salva_liste", trim(mid(k_record, 180, 1)))
//	dw_dett_0.setitem(1, "ult_nr_commessa", trim(mid(k_record, 190, 10)))
//	dw_dett_0.setitem(1, "ult_data_commessa", trim(mid(k_record, 200, 10)))
	dw_dett_0.setitem(1, "banca", trim(mid(k_record, 343, 45)))
	dw_dett_0.setitem(1, "tel", trim(mid(k_record, 388, 20)))
	dw_dett_0.setitem(1, "fax", trim(mid(k_record, 408, 20)))


	dw_dett_0.setitem(1, "db_parm", trim(sqlca.dbparm))
	dw_dett_0.setitem(1, "db_connesso", trim(sqlca.database))
	dw_dett_0.setitem(1, "ut_connesso", trim(sqlca.userid))
	dw_dett_0.setitem(1, "ult_cod_sql", string(sqlca.sqlcode))
	dw_dett_0.setitem(1, "ult_nr_righe_sql", string(sqlca.sqlnrows))
	dw_dett_0.setitem(1, "ult_text_sql", trim(sqlca.sqlerrtext))


	
//=== Leggo contenuto del file di profilo il CONFDB.INI 	
//	k_nome_db = profilestring ( "confdb.ini", "Database", "DBMS","<NULLA (dbmax)>")
//	k_parametro_db = profilestring ( "confdb.ini", "Database", "DbParm","<NULLA (dbmax)>")
//	k_path_dat = profilestring ( "confdb.ini", "ambiente", "arch_n_cli", "<NULLA (/at_eco)>")
//	k_path_db = profilestring ( "confdb.ini", "ambiente", "arch_base", "<NULLA (/at_eco)>")
//	k_nome_dbf = profilestring ( "confdb.ini", "Database_dbf", "DBMS","<NULLA (dbmax)>")
//	k_parametro_dbf = profilestring ( "confdb.ini", "Database_dbf", "DbParm","<NULLA (dbmax)>")
//	k_path_dbf = profilestring ( "confdb.ini", "ambiente", "arch_base_1", "<NULLA (/at_eco)>")


end if

end subroutine

public subroutine scrivi_base ();//
//=== Aggiorna il BASE
//
kuf_base  kuf1_base
string k_record
string k_errore="0 "
string k_text
long k_len


dw_dett_0.accepttext()

if dw_dett_0.getitemstatus(1, 0, primary!) = datamodified! or &
	dw_dett_0.getitemstatus(1, 0, primary!) = newmodified! &
	then

	kuf1_base = create kuf_base

	k_record = left(k_record_orig, 1024)

	k_text = dw_dett_0.getitemstring(1, "rag_soc")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 49 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 1, 48, k_text)

	k_text = ""
	k_text =  dw_dett_0.getitemstring(1, "indirizzo")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 25 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 49, 24, k_text)

	k_text = ""
	k_text = dw_dett_0.getitemstring(1, "localita")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 25 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 73, 24, k_text)

	k_text = ""
 	k_text = dw_dett_0.getitemstring(1, "provincia")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 3 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 97, 2, k_text)

	k_text = ""
	k_text = dw_dett_0.getitemstring(1, "cap")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 6 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 99, 5, k_text)

	k_text = ""
 	k_text = dw_dett_0.getitemstring(1, "p_iva")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 12 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 104, 11, k_text)

	k_text = ""
 	k_text = dw_dett_0.getitemstring(1, "titolo_main")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 25 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 115, 24, k_text)

	k_text = ""
 	k_text = dw_dett_0.getitemstring(1, "anno")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 5 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 139, 4, k_text)

	k_text = ""
 	k_text = trim(dw_dett_0.getitemstring(1, "finestra_inizio"))
	if len(k_text) = 0 then
		k_text = "0"
	end if
	k_len = 14 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 143, 13, k_text)

	k_text = ""
 	k_text = trim(dw_dett_0.getitemstring(1, "font_alt"))
	if len(k_text) = 0 then
		k_text = "0"
	end if
	k_len = 4 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 156, 3, k_text)

	k_text = ""
// 	k_text = dw_dett_0.getitemstring(1, "divisione")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 6 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 160, 5, k_text)

	k_text = ""
 	k_text = dw_dett_0.getitemstring(1, "flag_salva_liste")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 2 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 180, 1, k_text)

	k_text = ""
// 	k_text = dw_dett_0.getitemstring(1, "ult_nr_commessa")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 11 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 190, 10, k_text)

	k_text = ""
// 	k_text = dw_dett_0.getitemstring(1, "ult_data_commessa")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 11 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 200, 10, k_text)

	k_text = ""
// 	k_text = dw_dett_0.getitemstring(1, "id_commessa")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 11 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 250, 10, k_text)

	k_text = ""
// 	k_text = dw_dett_0.getitemstring(1, "id_contatto")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 11 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 260, 10, k_text)

	k_text = ""
// 	k_text = dw_dett_0.getitemstring(1, "id_fatt_acq")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 11 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 270, 10, k_text)

	k_text = ""
// 	k_text = dw_dett_0.getitemstring(1, "id_protocollo")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 11 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 280, 10, k_text)

	k_text = ""
// 	k_text = dw_dett_0.getitemstring(1, "id_lav")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 11 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 290, 10, k_text)

	k_text = ""
// 	k_text = dw_dett_0.getitemstring(1, "banca")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 46 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 343, 45, k_text)

	k_text = ""
 	k_text = dw_dett_0.getitemstring(1, "tel")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 21 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 388, 20, k_text)

	k_text = ""
 	k_text = dw_dett_0.getitemstring(1, "fax")
	if isnull(k_text) then
		k_text=""
	end if
	k_len = 21 - len(k_text) 
	k_text = k_text + space(k_len)
	k_record = replace(k_record, 408, 20, k_text)

	k_errore = kuf1_base.scrivi_base(k_record_orig, k_record)
	
	if left(k_errore, 1) = "1" then 
		messagebox("Archivio Base Non Disponibile", mid(k_errore, 2), &
						stopsign!, ok!) 
	end if

end if

close(w_base)

end subroutine

event open;
//=== Mostra Finestra maximizzata = 61472
send(handle(this), 274,  61728, 0)
//this.windowstate = maximized!

//=== Posiziona window all'interno MDI 
if w_main.width > this.width then
	this.x = (w_main.width - this.width) / 4
else
	this.x = 1
end if
if w_main.height > this.height then
	this.y = (w_main.height - this.height) / 6
else
	this.y = 1
end if

//w_base.show()

leggi_base()

dw_dett_0.setfocus()
end event

on w_base_0.create
this.dw_dett_0=create dw_dett_0
this.cb_abbandona=create cb_abbandona
this.cb_conferma=create cb_conferma
this.Control[]={this.dw_dett_0,&
this.cb_abbandona,&
this.cb_conferma}
end on

on w_base_0.destroy
destroy(this.dw_dett_0)
destroy(this.cb_abbandona)
destroy(this.cb_conferma)
end on

type dw_dett_0 from datawindow within w_base_0
event ue_dwnkey pbm_dwnkey
int X=5
int Y=4
int Width=1234
int Height=948
int TabOrder=1
string DataObject="d_base_0"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_dwnkey;//
int k_col


//=== Controllo quale tasto da tastiera ha premuto
choose case key 
	case keyenter!, KeyDownArrow!
		k_col = this.getcolumn()
		k_col++
		this.setcolumn(k_col)
//	case else
//		tab_1.trigger event key (key, 0)
end choose

end event

type cb_abbandona from commandbutton within w_base_0
int X=846
int Y=964
int Width=343
int Height=84
int TabOrder=20
string Text="&Abbandona"
boolean Cancel=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(parent)
end on

type cb_conferma from commandbutton within w_base_0
int X=512
int Y=964
int Width=306
int Height=84
int TabOrder=10
string Text="&Conferma"
boolean Default=true
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//
scrivi_base()
close(parent)
end event

