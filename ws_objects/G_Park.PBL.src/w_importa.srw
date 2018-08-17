$PBExportHeader$w_importa.srw
forward
global type w_importa from window
end type
type cb_1 from commandbutton within w_importa
end type
type st_2 from statictext within w_importa
end type
type sle_odbc from singlelineedit within w_importa
end type
type st_1 from statictext within w_importa
end type
type sle_file from singlelineedit within w_importa
end type
end forward

global type w_importa from window
integer width = 2725
integer height = 1408
boolean titlebar = true
string title = "Importa Listino"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
st_2 st_2
sle_odbc sle_odbc
st_1 st_1
sle_file sle_file
end type
global w_importa w_importa

on w_importa.create
this.cb_1=create cb_1
this.st_2=create st_2
this.sle_odbc=create sle_odbc
this.st_1=create st_1
this.sle_file=create sle_file
this.Control[]={this.cb_1,&
this.st_2,&
this.sle_odbc,&
this.st_1,&
this.sle_file}
end on

on w_importa.destroy
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.sle_odbc)
destroy(this.st_1)
destroy(this.sle_file)
end on

event open;//
sle_odbc.text = profilestring ( KG_PATH_PROCEDURA + KK_NOME_PROFILE_BASE, "Database", "DbParm", "NESSUNO")

end event
type cb_1 from commandbutton within w_importa
integer x = 2272
integer y = 256
integer width = 265
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sfoglia"
end type

event clicked;//
long k_nrc 
string k_path
string k_file
string k_ext



		k_nrc = GetFileOpenName("Scegli Archivio 'Listino TXT'", &
										k_path, k_file, k_ext, "*.txt, *.*") 
							
		if k_nrc <= 0 then
			k_path = " "
		else
			sle_file.text = trim(k_path)
		end if

end event
type st_2 from statictext within w_importa
integer x = 251
integer y = 480
integer width = 1024
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nome Base Dati (attraverso ODBC):"
boolean focusrectangle = false
end type

type sle_odbc from singlelineedit within w_importa
integer x = 247
integer y = 564
integer width = 1993
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_importa
integer x = 251
integer y = 172
integer width = 841
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Listino da Importare:"
boolean focusrectangle = false
end type

type sle_file from singlelineedit within w_importa
integer x = 247
integer y = 260
integer width = 1993
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

