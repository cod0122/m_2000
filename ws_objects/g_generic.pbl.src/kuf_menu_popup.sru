$PBExportHeader$kuf_menu_popup.sru
forward
global type kuf_menu_popup from nonvisualobject
end type
end forward

global type kuf_menu_popup from nonvisualobject
end type
global kuf_menu_popup kuf_menu_popup

type variables
//
private m_popup mi_menu



end variables

forward prototypes
public subroutine u_popup (integer a_xpos, integer a_ypos)
end prototypes

public subroutine u_popup (integer a_xpos, integer a_ypos);//
string k_stringa=""
long k_riga=0
m_main k_menu 
w_g_tab kw_1




kw_1 = kGuf_data_base.prendi_win_attiva( )

if isvalid(kw_1) then

	//if isvalid(mi_menu) then destroy mi_menu
	//mi_menu = create m_popup
	
	k_menu = kw_1.ki_menu
	
//--- se non c'e' alcun menu non faccio sta roba
	if isvalid(kw_1.menuid) then

		mi_menu.u_inizializza( )
	 
		mi_menu.m_agglista.visible = k_menu.m_finestra.m_aggiornalista.enabled
		mi_menu.m_t_agglista.visible = k_menu.m_finestra.m_aggiornalista.enabled
		mi_menu.m_stampa.visible = k_menu.m_finestra.m_fin_stampa.enabled
		mi_menu.m_t_stampa.visible = k_menu.m_finestra.m_fin_stampa.enabled
		mi_menu.m_conferma.visible = k_menu.m_finestra.m_gestione.m_fin_conferma.enabled
		mi_menu.m_ritorna.visible = true
		mi_menu.m_inserisci.visible = k_menu.m_finestra.m_gestione.m_fin_inserimento.enabled
		mi_menu.m_modifica.visible = k_menu.m_finestra.m_gestione.m_fin_modifica.enabled
		mi_menu.m_t_modifica.visible = k_menu.m_finestra.m_gestione.m_fin_modifica.enabled
		mi_menu.m_cancella.visible = k_menu.m_finestra.m_gestione.m_fin_elimina.enabled
		mi_menu.m_t_cancella.visible = k_menu.m_finestra.m_gestione.m_fin_elimina.enabled
		mi_menu.m_visualizza.visible = k_menu.m_finestra.m_gestione.m_fin_visualizza.enabled
		mi_menu.m_adatta.visible = false
	
	
		mi_menu.m_conferma.text = trim(k_menu.m_finestra.m_gestione.m_fin_conferma.text) //+ "  " + mi_menu.m_conferma.tag
		mi_menu.m_visualizza.text = k_menu.m_finestra.m_gestione.m_fin_visualizza.text //+ "  " + mi_menu.m_visualizza.tag
		mi_menu.m_inserisci.text = trim(k_menu.m_finestra.m_gestione.m_fin_inserimento.text) //+ "  " + mi_menu.m_inserisci.tag
		mi_menu.m_modifica.text = k_menu.m_finestra.m_gestione.m_fin_modifica.text //+ "  " + mi_menu.m_modifica.tag
		mi_menu.m_stampa.text = trim(k_menu.m_finestra.m_fin_stampa.text)
		mi_menu.m_cancella.text = k_menu.m_finestra.m_gestione.m_fin_elimina.text //+ "  " + mi_menu.m_cancella.tag
		mi_menu.m_adatta.text = trim(k_menu.m_finestra.m_disponi.m_adatta.text)
		mi_menu.m_cerca.text = trim(k_menu.m_trova.m_fin_cerca.text)
		mi_menu.m_filtro.text = trim(k_menu.m_trova.m_fin_filtra.text)
		mi_menu.m_agglista.text = trim(k_menu.m_finestra.m_aggiornalista.text)
		mi_menu.m_ritorna.text = k_menu.m_finestra.m_chiudifinestra.text //+ "  " + mi_menu.m_ritorna.tag
	
		
		mi_menu.m_lib_1.text = k_menu.m_strumenti.m_fin_gest_libero1.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero1.tag)
		mi_menu.m_lib_1.visible = (k_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero1.enabled) 
		mi_menu.m_lib_1.enabled = k_menu.m_strumenti.m_fin_gest_libero1.enabled
		mi_menu.m_lib_1.menuimage = k_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName
		mi_menu.m_t_lib_1.visible = mi_menu.m_lib_1.visible
	
		mi_menu.m_lib_2.text = k_menu.m_strumenti.m_fin_gest_libero2.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero2.tag)
		mi_menu.m_lib_2.visible = (k_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero2.enabled) 
		mi_menu.m_lib_2.visible = (k_menu.m_strumenti.m_fin_gest_libero2.visible or k_menu.m_strumenti.m_fin_gest_libero2.enabled)
//		if (k_menu.m_strumenti.m_fin_gest_libero2.visible or k_menu.m_strumenti.m_fin_gest_libero2.enabled) then
//			mi_menu.m_lib_2.visible = true
//		else
//			mi_menu.m_lib_2.visible = false
//		end if
//			mi_menu.m_lib_2.visible = true
		mi_menu.m_lib_2.enabled = k_menu.m_strumenti.m_fin_gest_libero2.enabled
		mi_menu.m_lib_2.menuimage = k_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName
		mi_menu.m_t_lib_2.visible = mi_menu.m_lib_2.visible
		
		mi_menu.m_lib_3.text = k_menu.m_strumenti.m_fin_gest_libero3.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero3.tag)
		mi_menu.m_lib_3.visible = (k_menu.m_strumenti.m_fin_gest_libero3.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero3.enabled) 
		mi_menu.m_lib_3.enabled = k_menu.m_strumenti.m_fin_gest_libero3.enabled
		mi_menu.m_lib_3.menuimage = k_menu.m_strumenti.m_fin_gest_libero3.toolbaritemName
		mi_menu.m_t_lib_3.visible = mi_menu.m_lib_3.visible
		
		mi_menu.m_lib_4.text = k_menu.m_strumenti.m_fin_gest_libero4.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero4.tag)
		mi_menu.m_lib_4.visible = (k_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero4.enabled) 
		mi_menu.m_lib_4.enabled = k_menu.m_strumenti.m_fin_gest_libero4.enabled
		mi_menu.m_lib_4.menuimage = k_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName
		mi_menu.m_t_lib_4.visible = mi_menu.m_lib_4.visible
		
		mi_menu.m_lib_5.text = k_menu.m_strumenti.m_fin_gest_libero5.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero5.tag)
		mi_menu.m_lib_5.visible = (k_menu.m_strumenti.m_fin_gest_libero5.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero5.enabled) 
		mi_menu.m_lib_5.enabled = k_menu.m_strumenti.m_fin_gest_libero5.enabled
		mi_menu.m_lib_5.menuimage = k_menu.m_strumenti.m_fin_gest_libero5.toolbaritemName
		
		mi_menu.m_lib_6.text = k_menu.m_strumenti.m_fin_gest_libero6.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero6.tag)
		mi_menu.m_lib_6.visible = (k_menu.m_strumenti.m_fin_gest_libero6.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero6.enabled) 
		mi_menu.m_lib_6.enabled = k_menu.m_strumenti.m_fin_gest_libero6.enabled
		mi_menu.m_lib_6.menuimage = k_menu.m_strumenti.m_fin_gest_libero6.toolbaritemName
	
		mi_menu.m_lib_71.text = k_menu.m_strumenti.m_fin_gest_libero7.libero1.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero7.libero1.tag)
		mi_menu.m_lib_71.visible = (k_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled) 
		mi_menu.m_lib_71.enabled = k_menu.m_strumenti.m_fin_gest_libero7.libero1.enabled
		mi_menu.m_lib_71.menuimage = k_menu.m_strumenti.m_fin_gest_libero7.libero1.toolbaritemName
	
		mi_menu.m_lib_72.text = k_menu.m_strumenti.m_fin_gest_libero7.libero2.text 
		mi_menu.m_lib_72.visible = (k_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero7.libero2.enabled)
		mi_menu.m_lib_72.enabled = k_menu.m_strumenti.m_fin_gest_libero7.libero2.enabled
		mi_menu.m_lib_72.menuimage = k_menu.m_strumenti.m_fin_gest_libero7.libero2.toolbaritemName
	
		mi_menu.m_lib_73.text = k_menu.m_strumenti.m_fin_gest_libero7.libero3.text 
		mi_menu.m_lib_73.visible = (k_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero7.libero3.enabled)
		mi_menu.m_lib_73.enabled = k_menu.m_strumenti.m_fin_gest_libero7.libero3.enabled
		mi_menu.m_lib_73.menuimage = k_menu.m_strumenti.m_fin_gest_libero7.libero3.toolbaritemName
	
		mi_menu.m_lib_74.text = k_menu.m_strumenti.m_fin_gest_libero7.libero4.text 
		mi_menu.m_lib_74.visible = (k_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero7.libero4.enabled)
		mi_menu.m_lib_74.enabled = k_menu.m_strumenti.m_fin_gest_libero7.libero4.enabled
		mi_menu.m_lib_74.menuimage = k_menu.m_strumenti.m_fin_gest_libero7.libero4.toolbaritemName
		mi_menu.m_t_lib_7.visible =k_menu.m_strumenti.m_fin_gest_libero7.libero1.visible
	
		mi_menu.m_lib_8.text = k_menu.m_strumenti.m_fin_gest_libero8.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero8.tag)
		mi_menu.m_lib_8.visible = (k_menu.m_strumenti.m_fin_gest_libero8.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero8.enabled)
		mi_menu.m_lib_8.enabled = k_menu.m_strumenti.m_fin_gest_libero8.enabled
		mi_menu.m_lib_8.menuimage = k_menu.m_strumenti.m_fin_gest_libero8.toolbaritemName
		mi_menu.m_t_lib_8.visible = k_menu.m_strumenti.m_fin_gest_libero8.visible
	
		mi_menu.m_lib_9.text = k_menu.m_strumenti.m_fin_gest_libero9.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero9.tag)
		mi_menu.m_lib_9.visible = (k_menu.m_strumenti.m_fin_gest_libero9.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero9.enabled)
		mi_menu.m_lib_9.enabled = k_menu.m_strumenti.m_fin_gest_libero9.enabled
		mi_menu.m_lib_9.menuimage = k_menu.m_strumenti.m_fin_gest_libero9.toolbaritemName
	//	mi_menu.m_t_lib_9.visible = k_menu.m_strumenti.m_fin_gest_libero9.visible
	
		mi_menu.m_lib_10.text = k_menu.m_strumenti.m_fin_gest_libero10.text + "~t" + trim(k_menu.m_strumenti.m_fin_gest_libero10.tag)
		mi_menu.m_lib_10.visible = (k_menu.m_strumenti.m_fin_gest_libero10.toolbaritemVisible or k_menu.m_strumenti.m_fin_gest_libero10.enabled)
		mi_menu.m_lib_10.enabled = k_menu.m_strumenti.m_fin_gest_libero10.enabled
		mi_menu.m_lib_10.menuimage = k_menu.m_strumenti.m_fin_gest_libero10.toolbaritemName
	//	mi_menu.m_t_lib_10.visible = k_menu.m_strumenti.m_fin_gest_libero10.visible
	
	
	//=== Attivo il menu Popup
		mi_menu.visible = true
		a_xpos += kw_1.x
		a_ypos += kw_1.y
		mi_menu.popmenu(a_xpos, a_ypos)
		mi_menu.visible = false
		//destroy mi_menu
	

	end if
end if

end subroutine

on kuf_menu_popup.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_menu_popup.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//=== Creo menu Popup 
	mi_menu = create m_popup

end event

event destructor;//
	if isvalid(mi_menu) then destroy mi_menu

end event

