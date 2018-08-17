$PBExportHeader$w_toolbar_programmi.srw
forward
global type w_toolbar_programmi from window
end type
type st_memo from statictext within w_toolbar_programmi
end type
type p_memo from picturebutton within w_toolbar_programmi
end type
type toolbar_programmi from uo_toolbar_programmi within w_toolbar_programmi
end type
type toolbar_programmi from uo_toolbar_programmi within w_toolbar_programmi
end type
end forward

global type w_toolbar_programmi from window
boolean visible = false
integer width = 3557
integer height = 156
boolean border = false
windowtype windowtype = child!
long backcolor = 15780518
boolean toolbarvisible = false
integer animationtime = 50
event u_mouseover pbm_mousemove
event rbuttonup pbm_rbuttonup
event u_open ( )
st_memo st_memo
p_memo p_memo
toolbar_programmi toolbar_programmi
end type
global w_toolbar_programmi w_toolbar_programmi

type variables
//

public int ki_height=140 
public int ki_textsize = 14
end variables

forward prototypes
private subroutine smista_funz (string k_par_in)
public subroutine ingrandisci_toolbar_programmi ()
public subroutine diminuisci_toolbar_programmi ()
public subroutine imposta_toolbar_programmi ()
public subroutine set_p_memo (boolean a_set_avviso)
end prototypes

event u_mouseover;//
//			toolbar_programmi.textsize = 14

end event

event rbuttonup;//
string k_tag_old=""
string k_tag=""
m_popup m_menu
window  k_w_attiva


//=== Prende la window attiva in quel momento
	k_w_attiva = kGuf_data_base.prendi_win_attiva()

//=== Controlla se il valore e' valido
	IF IsValid(k_w_attiva) THEN
//		k_w_attiva.tag = "l1"

//=== Se sono sulla lista con il mouse allora posiziono il punt sul rek puntato

//=== Salvo il Tag attuale per reimpostarlo a fine routine
		k_tag_old = k_w_attiva.tag
		w_main.tag = " "

//=== Creo menu Popup 
		m_menu = create m_popup

		m_menu.m_lib_1.text = "Nascondi barra dei programmi"
		m_menu.m_lib_1.visible = true
		m_menu.m_lib_1.enabled = true
		m_menu.m_t_lib_1.visible = m_menu.m_lib_1.visible
		m_menu.m_lib_2.text = "Incrementare dimensioni della barra"
		m_menu.m_lib_2.visible = true
		m_menu.m_lib_2.enabled = true
		m_menu.m_lib_3.text = "Diminuire dimensioni della barra"
		m_menu.m_lib_3.visible = true
		m_menu.m_lib_3.enabled = true
//		m_menu.m_lib_2.text = ki_menu.m_finestra.m_gestione.m_fin_gest_libero2.text 
//		m_menu.m_lib_2.visible = ki_menu.m_finestra.m_gestione.m_fin_gest_libero2.visible
//		m_menu.m_lib_2.enabled = ki_menu.m_finestra.m_gestione.m_fin_gest_libero2.enabled
//		m_menu.m_t_lib_2.visible = m_menu.m_lib_2.visible
//		m_menu.m_lib_3.text = ki_menu.m_finestra.m_gestione.m_fin_gest_libero3.text 
//		m_menu.m_lib_3.visible = ki_menu.m_finestra.m_gestione.m_fin_gest_libero3.visible
//		m_menu.m_lib_3.enabled = ki_menu.m_finestra.m_gestione.m_fin_gest_libero3.enabled
//		m_menu.m_t_lib_3.visible = m_menu.m_lib_3.visible
//		m_menu.m_lib_4.text = ki_menu.m_finestra.m_gestione.m_fin_gest_libero4.text 
//		m_menu.m_lib_4.visible = ki_menu.m_finestra.m_gestione.m_fin_gest_libero4.visible
//		m_menu.m_lib_4.enabled = ki_menu.m_finestra.m_gestione.m_fin_gest_libero4.enabled
//		m_menu.m_t_lib_4.visible = m_menu.m_lib_4.visible

//=== Attivo il menu Popup
		m_menu.visible = true
		m_menu.popmenu(this.x + pointerx(), this.y + pointery())
		m_menu.visible = false

		destroy m_menu

		k_tag = k_w_attiva.tag 

		k_w_attiva.tag = k_tag_old 

		if trim(k_tag) <> "" then
			smista_funz(k_tag)
		end if
		
	end if
	

end event

event u_open();//
//---
string k_rcx 
string k_path = ""
//st_profilestring_ini kst_profilestring_ini
//kuf_menu_window kuf1_menu_window


//--- Ripristina propieta' della barra
//	kst_profilestring_ini.operazione = "1"
//	kst_profilestring_ini.valore = "0"
//	kst_profilestring_ini.file = "toolbar" 
//	kst_profilestring_ini.titolo = "windows_toolbar" 
	
//	kst_profilestring_ini.nome = "Barra_Programmi_visible"
//	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//	if kst_profilestring_ini.esito <> "1" then
//		if upper(trim(kst_profilestring_ini.valore)) = "FALSE" then
//			this.visible = false
//		else
//			this.visible = true
//		end if
//	end if
			
	toolbar_programmi.set_height(ki_height)
	
	k_path = trim(kguo_path.get_risorse( ) + kkg.PATH_SEP)
	p_memo.picturename =  k_path + "memo16.png" 
	p_memo.disabledname =  k_path + "memo_disab32.png"

	imposta_toolbar_programmi()
	

end event

private subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===


choose case LeftA(k_par_in, 2) 


	case KKG_FLAG_RICHIESTA.libero1 //nascondi windows		
		this.visible = false
		
	case KKG_FLAG_RICHIESTA.libero2 //incrementa dim		
		ingrandisci_toolbar_programmi	()	
//		if ki_barra_media then 
//			ki_barra_media = false
//			ki_barra_grande = true
//		else
//			if ki_barra_piccola then 
//				ki_barra_piccola = false
//				ki_barra_media = true
//			end if
//		end if
//		ridimensiona_toolbar_programmi()
		
	case KKG_FLAG_RICHIESTA.libero3 //decrementa dim
		diminuisci_toolbar_programmi	()		
//		if ki_barra_grande then 
//			ki_barra_grande = false
//			ki_barra_media = true
//		else
//			if ki_barra_media then 
//				ki_barra_media = false
//				ki_barra_piccola = true
//			end if
//		end if
//		ridimensiona_toolbar_programmi()


end choose


//return k_return

end subroutine

public subroutine ingrandisci_toolbar_programmi ();//---
//--- Ingrandisci la toolbar dei programmi attivi
//---
//

//	ki_height = ki_height * 1.15
	ki_textsize = ki_textsize + 2
	
 //  	height = ki_height
   	width = w_main.width - 50
//	x = 5 
//	y = w_main.height - height * 1.5 //- 185 //* 3.3  

	toolbar_programmi.textsize = ki_textsize 



end subroutine

public subroutine diminuisci_toolbar_programmi ();//---
//--- Diminuisci la toolbar dei programmi attivi
//---
//

//	ki_height = ki_height * 0.85
	ki_textsize = ki_textsize - 2
	
 //  	height = ki_height
   	width = w_main.width - 50
//	x = 5 
//	y = w_main.height - height - 185 //* 3.3  

	toolbar_programmi.textsize = ki_textsize 



end subroutine

public subroutine imposta_toolbar_programmi ();//---
//--- ridimensiona la toolbar dei programmi attivi
//---


setredraw( false)

   height = ki_height
   width = w_main.width - 50
	x = 5 
	y = w_main.height - height - 183 //(height * 2.2) //- 185  

	toolbar_programmi.height = height //- 10 //90 //height + 10
	toolbar_programmi.facename = "Arial"
	toolbar_programmi.textsize = ki_textsize

//	p_memo.height = height - 6 
	p_memo.x = width - p_memo.width - 35
	p_memo.y = 1
	st_memo.width = p_memo.width * 0.90
	st_memo.x = p_memo.x + (p_memo.width - st_memo.width) / 2 + 2
	st_memo.y = p_memo.y + 10
   toolbar_programmi.width =  p_memo.x - toolbar_programmi.x - 10
	toolbar_programmi.x = 5 
	toolbar_programmi.y = 3 


setredraw(true)
this.show( )

//
end subroutine

public subroutine set_p_memo (boolean a_set_avviso);//---

	p_memo.enabled = true //a_set_avviso
	st_memo.enabled = true //a_set_avviso
	st_memo.text = string(kguf_memo_allarme.get_nr_avvisi( ))

end subroutine

on w_toolbar_programmi.create
this.st_memo=create st_memo
this.p_memo=create p_memo
this.toolbar_programmi=create toolbar_programmi
this.Control[]={this.st_memo,&
this.p_memo,&
this.toolbar_programmi}
end on

on w_toolbar_programmi.destroy
destroy(this.st_memo)
destroy(this.p_memo)
destroy(this.toolbar_programmi)
end on

event close;//
//---
//--- Salva le proprieta' 
//---
string k_visible, k_nome,k_rcx
st_profilestring_ini kst_profilestring_ini



	kst_profilestring_ini.operazione = "2"
	kst_profilestring_ini.valore = "0"
	kst_profilestring_ini.file = "toolbar" 
	kst_profilestring_ini.titolo = "windows_toolbar" 

//--- Salva attributi della 'barra dei programmi aperti'
	if isvalid(w_toolbar_programmi) then
		kst_profilestring_ini.nome = "Barra_Programmi_visible"
		CHOOSE CASE this.visible    
			CASE true       
				k_visible = "true"    
			CASE false         
				k_visible = "false"       
			END CHOOSE
		kst_profilestring_ini.valore = k_visible
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		kst_profilestring_ini.nome = "Barra_Programmi_dimensione"
		kst_profilestring_ini.valore = string(this.toolbar_programmi.textsize)
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	end if

end event

event open;//
//---

x = 5 
y = w_main.height - height - 183 //(height * 2.2) //- 185  

post event u_open( )

//string k_rcx 
//st_profilestring_ini kst_profilestring_ini
//kuf_menu_window kuf1_menu_window
//
//
////--- Ripristina propieta' della barra
//	kst_profilestring_ini.operazione = "1"
//	kst_profilestring_ini.valore = "0"
//	kst_profilestring_ini.file = "toolbar" 
//	kst_profilestring_ini.titolo = "windows_toolbar" 
//	
//	kst_profilestring_ini.nome = "Barra_Programmi_visible"
//	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//	if kst_profilestring_ini.esito <> "1" then
//		if upper(trim(kst_profilestring_ini.valore)) = "FALSE" then
//			this.visible = false
//		else
//			this.visible = true
//		end if
//	end if
//
////	kst_profilestring_ini.nome = "Barra_Programmi_dimensione"
////	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
////	if kst_profilestring_ini.esito <> "1" then
////		if upper(trim(kst_profilestring_ini.valore)) = "10" then
////			this.visible = false
////		else
////			this.visible = true
////		end if
////	end if
//			
//	toolbar_programmi.set_height(ki_height)
//	
//	post imposta_toolbar_programmi()
//	
//
end event

type st_memo from statictext within w_toolbar_programmi
integer x = 3392
integer y = 88
integer width = 187
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 255
long backcolor = 553648127
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;//
p_memo.event clicked( )

end event

type p_memo from picturebutton within w_toolbar_programmi
integer x = 3291
integer width = 155
integer height = 104
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\gammarad\pb_gmmrd1252\icone\memo16.png"
string disabledname = "C:\gammarad\pb_gmmrd1252\icone\memo_disab32.png"
string powertiptext = "Apri coda MEMO"
long textcolor = 8388608
long backcolor = 553648127
end type

event clicked;//
string k_nr_allarmi=""

k_nr_allarmi = trim(st_memo.text)

kguf_memo_allarme.u_mostra_allarme(k_nr_allarmi)
//kguf_memo_allarme.set_visualizza_allarme()

end event

type toolbar_programmi from uo_toolbar_programmi within w_toolbar_programmi
integer width = 3223
integer height = 144
integer taborder = 10
string pointer = "HyperLink!"
long backcolor = 15780518
boolean focusonbuttondown = true
boolean createondemand = false
end type

