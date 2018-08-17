$PBExportHeader$w_fatture_new_st.srw
forward
global type w_fatture_new_st from w_g_tab
end type
type gb_stampa from groupbox within w_fatture_new_st
end type
type gb_aggiorna from groupbox within w_fatture_new_st
end type
type rb_stampa_tutto from radiobutton within w_fatture_new_st
end type
type rb_selezione from radiobutton within w_fatture_new_st
end type
type rb_definitiva from radiobutton within w_fatture_new_st
end type
type rb_prova from radiobutton within w_fatture_new_st
end type
type pb_ok from picturebutton within w_fatture_new_st
end type
type dw_fatture from uo_d_std_1 within w_fatture_new_st
end type
end forward

global type w_fatture_new_st from w_g_tab
integer width = 2784
integer height = 2156
string title = "Stampa Fatture / Note do Credito"
boolean maxbox = false
boolean resizable = false
long backcolor = 67108864
gb_stampa gb_stampa
gb_aggiorna gb_aggiorna
rb_stampa_tutto rb_stampa_tutto
rb_selezione rb_selezione
rb_definitiva rb_definitiva
rb_prova rb_prova
pb_ok pb_ok
dw_fatture dw_fatture
end type
global w_fatture_new_st w_fatture_new_st

type variables
//
ds_fatture kids_fatture
end variables

forward prototypes
protected subroutine stampa ()
private subroutine popola_lista_da_ds_fatture ()
private subroutine popola_ds_fatture_da_lista ()
end prototypes

protected subroutine stampa ();//--
//--- Lancia Aggiornamento e Stampa delle fatture 
//---
kuf_fatt kuf1_fatt

kuf1_fatt = create kuf_fatt

try 
	popola_ds_fatture_da_lista()
	kuf1_fatt.stampa_fattura (kids_fatture)

//--- Aggiornamento STAMAPATE se NON di PROVA	
	if rb_definitiva.checked then
		kuf1_fatt.aggiorna_fattura_flag_stampa(kids_fatture)
	end if
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally
	destroy kuf1_fatt

end try
end subroutine

private subroutine popola_lista_da_ds_fatture ();//---
//--- riempie la dw da oggetto ds_fatture
//---
long k_riga, k_riga_ins
st_tab_arfa kst_tab_arfa
st_tab_clienti kst_tab_clienti
kuf_fatt kuf1_fatt
kuf_clienti kuf1_clienti
st_esito kst_esito


kuf1_fatt = create kuf_fatt
kuf1_clienti = create kuf_clienti

for k_riga = 1 to kids_fatture.rowcount()

	k_riga_ins = dw_fatture.insertrow(0)

	kst_tab_arfa.num_fatt = kids_fatture.getitemnumber(k_riga, "num_fatt")
	kst_tab_arfa.data_fatt = kids_fatture.getitemdate(k_riga, "data_fatt")
	
	if (kids_fatture.getitemnumber(k_riga, "sel")) = 0 then
		dw_fatture.setitem(k_riga_ins,"sel", 0)
	else
		dw_fatture.setitem(k_riga_ins,"sel", 1)
	end if
		
	dw_fatture.setitem(k_riga_ins,"num_fatt", kst_tab_arfa.num_fatt)
	dw_fatture.setitem(k_riga_ins,"data_fatt", kst_tab_arfa.data_fatt)
	dw_fatture.setitem(k_riga_ins,"prof", kids_fatture.getitemnumber(k_riga, "prof"))

	kst_esito = kuf1_fatt.get_cliente( kst_tab_arfa )
	if kst_esito.esito = kkg_esito_ok then
		dw_fatture.setitem(k_riga_ins,"clie_3", kst_tab_arfa.clie_3)
	
		kst_tab_clienti.codice = kst_tab_arfa.clie_3
		kst_esito = kuf1_clienti.leggi_rag_soc( kst_tab_clienti )
		if kst_esito.esito = kkg_esito_ok then
			dw_fatture.setitem(k_riga_ins,"rag_soc_10", trim(kst_tab_clienti.rag_soc_10+kst_tab_clienti.rag_soc_11))
			dw_fatture.setitem(k_riga_ins,"loc_10", trim(kst_tab_clienti.loc_1))
			dw_fatture.setitem(k_riga_ins,"nazione", trim(kst_tab_clienti.id_nazione_1))
		else
			dw_fatture.setitem(k_riga_ins,"rag_soc_10", "***non trovato***")
		end if
	else
		dw_fatture.setitem(k_riga_ins,"clie_3", 0)
	end if
		
		
end for

destroy kuf1_fatt 
destroy kuf1_clienti 


end subroutine

private subroutine popola_ds_fatture_da_lista ();//---
//--- riempie la  ds_fatture  da dw di elenco
//---
long k_riga, k_riga_ds
st_tab_arfa kst_tab_arfa
st_tab_clienti kst_tab_clienti
st_esito kst_esito


kids_fatture.reset()


for k_riga = 1 to dw_fatture.rowcount()

	kst_tab_arfa.num_fatt = dw_fatture.getitemnumber(k_riga, "num_fatt")
	kst_tab_arfa.data_fatt = dw_fatture.getitemdate(k_riga, "data_fatt")
	
	
	if kst_tab_arfa.num_fatt > 0 then

		if rb_selezione.checked then
			if (dw_fatture.getitemnumber(k_riga, "sel")) = 1 then
				k_riga_ds = kids_fatture.insertrow(0)
				kids_fatture.setitem(k_riga_ds,"num_fatt", kst_tab_arfa.num_fatt)
				kids_fatture.setitem(k_riga_ds,"data_fatt", kst_tab_arfa.data_fatt)
				kids_fatture.setitem(k_riga_ds,"prof", dw_fatture.getitemnumber(k_riga, "prof"))
				kids_fatture.setitem(k_riga_ds,"sel", 1)
			end if
		else
			k_riga_ds = kids_fatture.insertrow(0)
			kids_fatture.setitem(k_riga_ds,"num_fatt", kst_tab_arfa.num_fatt)
			kids_fatture.setitem(k_riga_ds,"data_fatt", kst_tab_arfa.data_fatt)
			kids_fatture.setitem(k_riga_ds,"prof", dw_fatture.getitemnumber(k_riga, "prof"))
		
			if (dw_fatture.getitemnumber(k_riga, "sel")) = 0 then
				kids_fatture.setitem(k_riga_ds,"sel", 0)
			else
				kids_fatture.setitem(k_riga_ds,"sel", 1)
			end if
			
		end if			
	end if		
	
end for



end subroutine

on w_fatture_new_st.create
int iCurrent
call super::create
this.gb_stampa=create gb_stampa
this.gb_aggiorna=create gb_aggiorna
this.rb_stampa_tutto=create rb_stampa_tutto
this.rb_selezione=create rb_selezione
this.rb_definitiva=create rb_definitiva
this.rb_prova=create rb_prova
this.pb_ok=create pb_ok
this.dw_fatture=create dw_fatture
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_stampa
this.Control[iCurrent+2]=this.gb_aggiorna
this.Control[iCurrent+3]=this.rb_stampa_tutto
this.Control[iCurrent+4]=this.rb_selezione
this.Control[iCurrent+5]=this.rb_definitiva
this.Control[iCurrent+6]=this.rb_prova
this.Control[iCurrent+7]=this.pb_ok
this.Control[iCurrent+8]=this.dw_fatture
end on

on w_fatture_new_st.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_stampa)
destroy(this.gb_aggiorna)
destroy(this.rb_stampa_tutto)
destroy(this.rb_selezione)
destroy(this.rb_definitiva)
destroy(this.rb_prova)
destroy(this.pb_ok)
destroy(this.dw_fatture)
end on

event open;call super::open;//---
ki_st_open_w.flag_modalita = kkg_flag_modalita_stampa
kuf_fatt kuf1_fatt


ds_fatture kds_fatture 

try 

	if isvalid(ki_st_open_w.key12_any) then 
		kids_fatture = ki_st_open_w.key12_any
	else
		kids_fatture = create ds_fatture
	end if

//---
	if kids_fatture.rowcount() = 0 then

		kuf1_fatt = create kuf_fatt
		kuf1_fatt.get_fatture_da_stampare(kids_fatture)
			
	end if
	
	popola_lista_da_ds_fatture()
	
	if isvalid(kids_fatture) then destroy kids_fatture
	
	kids_fatture = create ds_fatture
	kids_fatture.dataobject = dw_fatture.dataobject
	
	dw_fatture.setfocus()

	catch (uo_exception kuo_exception)
			kuo_exception.messaggio_utente()
			this.postevent(close!)

	finally
		if isvalid(kuf1_fatt) then destroy kuf1_fatt
		
end try


end event

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_fatture_new_st
integer x = 1778
integer y = 1336
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_fatture_new_st
integer x = 2254
integer y = 1356
integer taborder = 0
end type

type st_stampa from w_g_tab`st_stampa within w_fatture_new_st
integer x = 1760
integer y = 1468
end type

type st_ritorna from w_g_tab`st_ritorna within w_fatture_new_st
integer x = 2267
integer y = 1464
end type

type gb_stampa from groupbox within w_fatture_new_st
integer x = 41
integer y = 40
integer width = 1317
integer height = 292
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Quali documenti in stampa"
end type

type gb_aggiorna from groupbox within w_fatture_new_st
integer x = 1403
integer y = 36
integer width = 864
integer height = 292
integer taborder = 40
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

type rb_stampa_tutto from radiobutton within w_fatture_new_st
integer x = 137
integer y = 116
integer width = 901
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
string text = "Stampa tutti i nuovi documenti "
end type

type rb_selezione from radiobutton within w_fatture_new_st
integer x = 133
integer y = 208
integer width = 1042
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Stampa solo i documenti selezionati"
boolean checked = true
end type

type rb_definitiva from radiobutton within w_fatture_new_st
integer x = 1481
integer y = 212
integer width = 530
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
string text = "Stampa definitiva"
end type

type rb_prova from radiobutton within w_fatture_new_st
integer x = 1481
integer y = 124
integer width = 507
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
string text = "Stampa di prova"
boolean checked = true
end type

type pb_ok from picturebutton within w_fatture_new_st
integer x = 2313
integer y = 140
integer width = 242
integer height = 156
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "RunReport!"
alignment htextalign = Center!
vtextalign vtextalign = top!
string powertiptext = "Stampa Fatture"
end type

event clicked;//
stampa()
end event

type dw_fatture from uo_d_std_1 within w_fatture_new_st
integer x = 50
integer y = 436
integer width = 2615
integer height = 1476
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_arfa_l"
boolean hscrollbar = true
boolean vscrollbar = true
end type

