$PBExportHeader$w_ufo1.srw
forward
global type w_ufo1 from window
end type
type dw_1 from datawindow within w_ufo1
end type
type st_1 from statictext within w_ufo1
end type
type pb_ok from picturebutton within w_ufo1
end type
type rb_emissione_tutto from radiobutton within w_ufo1
end type
type rb_modo_stampa_s from radiobutton within w_ufo1
end type
type rb_modo_stampa_e from radiobutton within w_ufo1
end type
type rb_prova from radiobutton within w_ufo1
end type
type rb_definitiva from radiobutton within w_ufo1
end type
type rb_emissione_selezione from radiobutton within w_ufo1
end type
type gb_aggiorna from groupbox within w_ufo1
end type
type gb_emissione from groupbox within w_ufo1
end type
type gb_produzione from groupbox within w_ufo1
end type
end forward

global type w_ufo1 from window
integer width = 3959
integer height = 1644
boolean titlebar = true
string title = "Alimentazione Conferma~'Ordine Listini"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
st_1 st_1
pb_ok pb_ok
rb_emissione_tutto rb_emissione_tutto
rb_modo_stampa_s rb_modo_stampa_s
rb_modo_stampa_e rb_modo_stampa_e
rb_prova rb_prova
rb_definitiva rb_definitiva
rb_emissione_selezione rb_emissione_selezione
gb_aggiorna gb_aggiorna
gb_emissione gb_emissione
gb_produzione gb_produzione
end type
global w_ufo1 w_ufo1

on w_ufo1.create
this.dw_1=create dw_1
this.st_1=create st_1
this.pb_ok=create pb_ok
this.rb_emissione_tutto=create rb_emissione_tutto
this.rb_modo_stampa_s=create rb_modo_stampa_s
this.rb_modo_stampa_e=create rb_modo_stampa_e
this.rb_prova=create rb_prova
this.rb_definitiva=create rb_definitiva
this.rb_emissione_selezione=create rb_emissione_selezione
this.gb_aggiorna=create gb_aggiorna
this.gb_emissione=create gb_emissione
this.gb_produzione=create gb_produzione
this.Control[]={this.dw_1,&
this.st_1,&
this.pb_ok,&
this.rb_emissione_tutto,&
this.rb_modo_stampa_s,&
this.rb_modo_stampa_e,&
this.rb_prova,&
this.rb_definitiva,&
this.rb_emissione_selezione,&
this.gb_aggiorna,&
this.gb_emissione,&
this.gb_produzione}
end on

on w_ufo1.destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.pb_ok)
destroy(this.rb_emissione_tutto)
destroy(this.rb_modo_stampa_s)
destroy(this.rb_modo_stampa_e)
destroy(this.rb_prova)
destroy(this.rb_definitiva)
destroy(this.rb_emissione_selezione)
destroy(this.gb_aggiorna)
destroy(this.gb_emissione)
destroy(this.gb_produzione)
end on

event open;//kuf_data_base kuf1_data_base
kuf1_data_base = create kuf_data_base
dw_1.settransobject( sqlca)
dw_1.retrieve()
end event

type dw_1 from datawindow within w_ufo1
integer x = 1216
integer y = 44
integer width = 2222
integer height = 1412
integer taborder = 20
string title = "none"
string dataobject = "d_ufo1_l"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_ufo1
integer x = 279
integer y = 1320
integer width = 695
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Esegui Operazione"
boolean focusrectangle = false
end type

type pb_ok from picturebutton within w_ufo1
integer x = 96
integer y = 1272
integer width = 146
integer height = 120
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "ExecuteSQL!"
vtextalign vtextalign = top!
string powertiptext = "Emissione  della stampa e/o elettronico"
end type

type rb_emissione_tutto from radiobutton within w_ufo1
integer x = 91
integer y = 96
integer width = 1042
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tutti i documenti "
end type

type rb_modo_stampa_s from radiobutton within w_ufo1
integer x = 91
integer y = 500
integer width = 1042
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Attivo"
boolean checked = true
end type

type rb_modo_stampa_e from radiobutton within w_ufo1
integer x = 91
integer y = 592
integer width = 1042
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "sospeso: da Attivare"
end type

type rb_prova from radiobutton within w_ufo1
integer x = 91
integer y = 892
integer width = 1042
integer height = 80
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo simulazione (solo Report)"
boolean checked = true
end type

type rb_definitiva from radiobutton within w_ufo1
integer x = 91
integer y = 980
integer width = 818
integer height = 80
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Definitivo e Report di verifica"
end type

type rb_emissione_selezione from radiobutton within w_ufo1
integer x = 91
integer y = 192
integer width = 1042
integer height = 80
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Solo documenti con ~'Sel~' attivato"
boolean checked = true
end type

type gb_aggiorna from groupbox within w_ufo1
integer x = 41
integer y = 804
integer width = 1125
integer height = 324
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = " Genera e Aggiorna "
end type

type gb_emissione from groupbox within w_ufo1
integer x = 23
integer width = 1125
integer height = 352
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "  Esegui"
end type

type gb_produzione from groupbox within w_ufo1
integer x = 27
integer y = 392
integer width = 1125
integer height = 352
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = " Stato Listini"
end type

