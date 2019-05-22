$PBExportHeader$w_super.srw
forward
global type w_super from window
end type
end forward

global type w_super from window
boolean visible = false
integer x = 29998
integer y = 30000
integer width = 3538
integer height = 1624
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
windowtype windowtype = child!
long backcolor = 32435950
string icon = "AppIcon!"
boolean toolbarvisible = false
integer toolbarx = 1
integer toolbary = 1
event type integer ue_menu ( string k_flag_richiesta )
event u_open_preliminari ( )
end type
global w_super w_super

type variables
//
protected string ki_win_titolo_orig = ""
protected string ki_win_titolo_custom = ""  //prolungamento titolo x personalizzazione nelle window figlie  
public st_open_w ki_st_open_w 
protected boolean ki_utente_abilitato = true

protected boolean ki_salva_controlli=false		// Se potenzialmente i controlli della window possono essere salvati
protected boolean ki_windowpredef=false		// Mostra il pulsante di sistemazione della window come predefinita
protected boolean ki_personalizza_pos_controlli=false		// possibile personalizz.posiz. dei controlli dentro la window
protected boolean ki_controlli_ripristinati=false		// una volta ripristinati lo mette a true

protected boolean ki_risize_w=false		// ridimensione dell'intera Window

//--- da usare per personalizzare il nome della Windows in salvataggio della SIZE e POSITION
protected string ki_nome_save = " "


//--- Flag che indica se la windows ha una TOOLBAR propria della WINDOW aperta, evita di fare i soliti riquadrini bianchi quando non esistono funzioni della window
public boolean ki_toolbar_window_presente=false

//--- se windows minimizzata
protected boolean ki_win_minimizzata=false		
protected boolean ki_win_massimizzata=false		

//--- valido fino al momento della visualizzazione degli oggetti (tipo le DW)
protected boolean ki_primo_giro_obj_visible = true

end variables

forward prototypes
public function boolean u_riopen (st_open_w kst_open_w) throws uo_exception
public subroutine smista_funz (string k_par_in)
public function string get_id_programma ()
protected subroutine u_win_open ()
public subroutine u_toolbar_restore (integer k_index_par, boolean k_toolbar_window_stato, boolean k_toolbar_window_presente)
public subroutine u_toolbar_save ()
public function integer u_win_close ()
public subroutine u_window_control_save ()
protected function st_window_size u_window_size_restore ()
protected subroutine u_window_size_save ()
public subroutine u_resize ()
public subroutine u_write_trace ()
public subroutine u_obj_visible ()
public subroutine u_obj_visible_0 ()
public subroutine u_resize_1 ()
public function boolean u_window_control_restore ()
public function boolean u_resize_predefinita ()
end prototypes

event type integer ue_menu(string k_flag_richiesta);//

smista_funz(trim(k_flag_richiesta)) 

return 1 

end event

event u_open_preliminari();//
//--- Operazioni iniziali nella OPEN da personalizzare - fatta apposta per gli eredi
//
				
end event

public function boolean u_riopen (st_open_w kst_open_w) throws uo_exception;//---
//--- Chiamata quando tento la Ri-OPEN della finestra  già Aperta
//---

ki_st_open_w = kst_open_w

this.setfocus()

return true

end function

public subroutine smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===


choose case k_par_in 


//	case KKG_FLAG_RICHIESTA.stampa		//richiesta stampa
//		stampa()

	case KKG_FLAG_RICHIESTA.esci		//richiesta uscita
		post close(this)




end choose

end subroutine

public function string get_id_programma ();//
return trim(ki_st_open_w.id_programma)
end function

protected subroutine u_win_open ();//---
//--- Chiamata in Apertura di una Windows
//---




end subroutine

public subroutine u_toolbar_restore (integer k_index_par, boolean k_toolbar_window_stato, boolean k_toolbar_window_presente);//---
//--- Ripristina le proprieta' di una toolbar
//---
//--- parametri di input:
//---    kw_super: reference della win
//---    k_index: il numero della toolbar che si vuole ripristinare (0=tutte) 
//---    k_toolbar_window_stato: se visibile o meno
//---
//--- parametro di out: 
//---
// Restore toolbar settings for the passed window
//integer k_index,k_index_max, k_row, k_offset, k_x, k_y, k_w, k_h, k_ctr 
//boolean k_visible 
//string k_visstring, k_alignstring, k_title, k_file, k_nome, k_rcx 
//toolbaralignment k_alignment  
//st_profilestring_ini kst_profilestring_ini
//w_super kw_super
//
//	kw_super = this
//	k_nome = "M2000_toolbar"  //--- Meglio se sempre uguale   trim(kw_super.ClassName())
//
//	kst_profilestring_ini.operazione = "1"
//	kst_profilestring_ini.valore = "0"
//	kst_profilestring_ini.file = "toolbar" 
//	kst_profilestring_ini.titolo = "toolbar" 
//
//
////k_nome = "generico." + "toolbar_" + kw_super.ClassName()
//
////--- se ho passato l'indice Elaboro solo quello!
//if k_index_par = 0 then 
//	k_index_par = 1
//	k_index_max = 4
//else
//	k_index_max = k_index_par
//end if
//
//FOR k_ctr = k_index_par  to k_index_max   
//	k_index = k_ctr
//	IF kw_super.GetToolbar(k_ctr, visible) = 1 THEN
//
//		if k_index = 1 then
//			k_title = "Toolbar Principale"
//			if k_toolbar_window_stato then
//				k_visstring = "true"
//			else
//				k_visstring = "false"
//			end if
//		else
//			k_title = "Toolbar Specifica"
//			if k_toolbar_window_presente then
//				k_visstring = "true"
//			else
//				k_visstring = "false"
//			end if
//		end if
//		
//		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_alignment"
//		kst_profilestring_ini.valore = "top" 
//		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//		k_alignstring = lower(trim(kst_profilestring_ini.valore))
//		if kst_profilestring_ini.esito <> "0" then
//			k_alignstring = "top" 
//		else
////				alignstring = "top" //---- FORZO IL TOP
//		end if
//		
//		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_row"
//		kst_profilestring_ini.valore = "1" 
//		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//		k_row = 0
//		if trim(kst_profilestring_ini.valore) <> "nullo" then
//			k_row = integer(kst_profilestring_ini.valore)
//		end if
//		if k_row = 0 then
//			k_row = 1
//		end if
//
//		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_offset"
//		kst_profilestring_ini.valore = "0" 
//		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//		k_offset = 0 
//		if trim(kst_profilestring_ini.valore) <> "nullo" then
//			k_offset = integer(kst_profilestring_ini.valore)
//		end if
//		if k_offset = 0 then
//			k_offset = 1
//		end if
//
//		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_x"
//		kst_profilestring_ini.valore = "0" 
//		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//		k_x = 0 
//		if trim(kst_profilestring_ini.valore) <> "nullo" then
//			k_x = integer(kst_profilestring_ini.valore)
//		end if
//
//		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_y"
//		kst_profilestring_ini.valore = "0" 
//		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//		k_y = 0 
//		if trim(kst_profilestring_ini.valore) <> "nullo" then
//			k_y = integer(kst_profilestring_ini.valore)
//		end if
//
//		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_w"
//		kst_profilestring_ini.valore = "0" 
//		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//		k_w = 0 
//		if trim(kst_profilestring_ini.valore) <> "nullo" then
//			k_w = integer(kst_profilestring_ini.valore)
//		end if
//		if k_w = 0 then
//			k_w = 400
//		end if
//
//		kst_profilestring_ini.nome = k_nome + "_" + String(k_index) + "_h"
//		kst_profilestring_ini.valore = "0" 
//		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//		k_h = 0 
//		if trim(kst_profilestring_ini.valore) <> "nullo" then
//			k_h = integer(kst_profilestring_ini.valore)
//		end if
//		if k_h = 0 then
//			k_h = 1
//		end if
//
//// Convert visstring to a boolean
//		CHOOSE CASE k_visstring
//			CASE "true"
//				k_visible = true
//			CASE "false"
//				k_visible = false
//		END CHOOSE
//		
//// Convert alignstring to toolbaralignment
//		CHOOSE CASE k_alignstring
//			CASE "left"
//				k_alignment = AlignAtLeft!
//			CASE "top"
//				k_alignment = AlignAtTop!
//			CASE "right"
//				k_alignment = AlignAtRight!
//			CASE "bottom"
//				k_alignment = AlignAtBottom!
//			CASE "floating"
//				k_alignment = Floating!
//			CASE ELSE
//				k_alignment = AlignAtTop!
//		END CHOOSE
//			
//// Setto la posizione solo la PRIMISSIMA volta x le toolbar 
//		if not kGuf_data_base.kI_toolbar_2_settata then
//			kw_super.SetToolbarPos(k_index, k_row, k_offset, false)
//			kw_super.SetToolbarPos(k_index, k_x, k_y, k_w, k_h)
//		end if
//		kw_super.SetToolbar(k_index, k_visible, k_alignment, k_title)
//   END IF
//	
////--- se non voglio Toolbar particolari per la window allora mi fermo, esco dal ciclo
//	if not k_toolbar_window_presente then
//		k_ctr = k_index_max + 1
//	end if
//	
//NEXT
//
////--- setto il flag x non rifare il SET delle toolbar
//kGuf_data_base.kI_toolbar_2_settata = true
//
////--- se non voglio Toolbar particolari per la window allora mi fermo, esco dal ciclo
//if kw_super.ki_toolbar_window_presente then
////--- se non è MDI visualizza la TOOLBAR
//	if kw_super.WindowType <> MDI! and kw_super.WindowType <> MDIHelp! then
//		kw_super.SetToolbar(2, true)
//	else
//		kw_super.SetToolbar(2, false)
//	end if
//else
//	kw_super.SetToolbar(2, false)
//end if
//

end subroutine

public subroutine u_toolbar_save ();//---
//--- Ripristina le proprieta' di una toolbar
//---
//--- parametri di input:
//---    kw_super: reference della win
//---
//--- parametro di out: 
//---
// Store the toolbar settings for the passed window
integer index, row, offset, k_x, k_y, k_w, k_h, k_ctr 
boolean k_visible 
string visstring, alignstring, k_title, k_nome,k_rcx
toolbaralignment alignment  
st_profilestring_ini kst_profilestring_ini
w_super kw_super


//k_section = "generico." + "toolbar_" + kw_super.ClassName()
	kw_super = this
	
	k_nome =  "M2000_toolbar" //--- meglio se sempre uguale    trim(kw_super.ClassName())

	kst_profilestring_ini.operazione = "2"
	kst_profilestring_ini.valore = "0"
	kst_profilestring_ini.file = "toolbar" 
	kst_profilestring_ini.titolo = "toolbar" 


	

FOR index = 2 to 4     
// Try to get the attributes for the bar.

	IF kw_super.GetToolbar(index, k_visible, alignment, k_title)= 1 THEN
// Convert visible to a string    
		CHOOSE CASE k_visible    
			CASE true       
				visstring = "true"    
			CASE false         
				visstring = "false"       
		END CHOOSE
// Convert alignment to a string        
		CHOOSE CASE alignment          
			CASE AlignAtLeft!             
				alignstring = "left"    
			CASE AlignAtTop!       
				alignstring = "top"          
			CASE AlignAtRight!             
				alignstring = "right"          
			CASE AlignAtBottom!             
				alignstring = "bottom"          
			CASE Floating!             
				alignstring = "floating"    
		END CHOOSE     
			
			
//--- Save the basic attributes       
		kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_visible"
		kst_profilestring_ini.valore = visstring 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_alignment"
		kst_profilestring_ini.valore = alignstring 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_title"
		kst_profilestring_ini.valore = k_title 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

//--- Save the fixed position
		kw_super.GetToolbarPos(index, row, offset)
		if row > 0 then
			kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_row"
			kst_profilestring_ini.valore = String(row) 
			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		end if
		if offset > 0 then
			kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_offset"
			kst_profilestring_ini.valore = String(offset) 
			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		end if

//--- Save the floating position 
		kw_super.GetToolbarPos(index, k_x, k_y, k_w, k_h)
		kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_x"
		kst_profilestring_ini.valore = String(k_x) 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_y"
		kst_profilestring_ini.valore = String(k_y) 
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		if k_w > 0 then
			kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_w"
			kst_profilestring_ini.valore = String(k_w) 
			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		end if
		if k_h > 0 then
			kst_profilestring_ini.nome = k_nome + "_" + String(index) + "_h"
			kst_profilestring_ini.valore = String(k_h) 
			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
		end if
	END IF
NEXT

end subroutine

public function integer u_win_close ();//---
//--- Chiamata in chiusura di una Windows
//---
int k_return = 0
int k_ctr
w_super kw_super
 
	kw_super = this
	
//--- salva le caratteristiche della windows+controlli+toolbar
	u_window_size_save()
	u_window_control_save()
//	u_toolbar_Save()

//--- Salva la docking-window 
	try
		k_ctr = KGuf_base_docking.set_dockingstate(kw_super)
	catch (uo_exception kuo_exception)
//		kuo_exception.messaggio_utente()
	end try
//	k_rtn = this.SaveDockingState(kguo_g.kG_DockingRegister + trim(ki_st_open_w.window))  
	
//--- Tolgo la window dalle aperte se è l'ultima resetto il menu
	if kguo_g.window_aperta_rimuove(kw_super) = 0 then
		if isvalid(w_main) then
			w_main.post u_menu_init()
		end if
	end if


return k_return

end function

public subroutine u_window_control_save ();//---
//---
//--- Salva le dimensioni e posizioni dei controlli x una prx apertura della window nel INI 
//---
//---
integer k_x, k_y, k_w, k_h, k_num_win, k_ctr 
string k_WindowState, k_section, k_rcx, k_classname 
boolean k_visible, k_enabled 
st_profilestring_ini kst_profilestring_ini
datawindow kdw_1
SingleLineEdit kSingleLineEdit_1
StaticText kStaticText_1
CommandButton kCommandButton_1
Treeview kTreeview_1
ListView kListView_1
w_super kw_super


//--- numero di win aperte con lo stesso nome
//	k_num_win = kGuf_data_base.prendi_num_win_uguale(trim(kw_super.ClassName()))	

	kw_super = this
	//--- Salva posizioni e dimensione delle dw dwlla windows
	if ki_st_open_w.st_tab_menu_window.salva_controlli = "S" then //and k_num_win = 1 &
	   
		k_section = "winsize_" + trim(ki_nome_save) //kw_super.ClassName()

		kst_profilestring_ini.operazione = "2"
		kst_profilestring_ini.file = "window"
		kst_profilestring_ini.titolo = "control"

		if ki_personalizza_pos_controlli then
			kst_profilestring_ini.valore = "True"
		else
			kst_profilestring_ini.valore = "False"
		end if
		kst_profilestring_ini.nome = k_section + "_personalizza_pos_controlli"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

		for k_ctr = 1 to upperbound( kw_super.control[] )
		
			if isvalid(kw_super.control[k_ctr]) then

				choose case kw_super.control[k_ctr].typeof()
					case datawindow!
						kdw_1 = kw_super.control[k_ctr]
						k_x = kdw_1.x
						k_y = kdw_1.y
						k_w = kdw_1.width
						k_h = kdw_1.height
						k_enabled = kdw_1.enabled
						k_visible = kdw_1.visible
						k_classname = trim(kdw_1.classname()) 
					case SingleLineEdit!
						kSingleLineEdit_1 = kw_super.control[k_ctr]
						k_x = kSingleLineEdit_1.x
						k_y = kSingleLineEdit_1.y
						k_w = kSingleLineEdit_1.width
						k_h = kSingleLineEdit_1.height
						k_enabled = kSingleLineEdit_1.enabled
						k_visible = kSingleLineEdit_1.visible
						k_classname = trim(kSingleLineEdit_1.classname()) 
					case StaticText!
						kStaticText_1 = kw_super.control[k_ctr]
						k_x = kStaticText_1.x
						k_y = kStaticText_1.y
						k_w = kStaticText_1.width
						k_h = kStaticText_1.height
						k_enabled = kStaticText_1.enabled
						k_visible = kStaticText_1.visible
						k_classname = trim(kStaticText_1.classname()) 
//					case CommandButton! 
//						kCommandButton_1 = kw_super.control[k_ctr]
//						k_x = kCommandButton_1.x
//						k_y = kCommandButton_1.y
//						k_w = kCommandButton_1.width
//						k_h = kCommandButton_1.height
//						k_enabled = kCommandButton_1.enabled
//						k_visible = kCommandButton_1.visible
//						k_classname = trim(kCommandButton_1.classname()) 
					case TreeView! 
						kTreeView_1 = kw_super.control[k_ctr]
						k_x = kTreeView_1.x
						k_y = kTreeView_1.y
						k_w = kTreeView_1.width
						k_h = kTreeView_1.height
						k_enabled = kTreeView_1.enabled
						k_visible = kTreeView_1.visible
						k_classname = trim(kTreeView_1.classname()) 
					case ListView! 
						kListView_1 = kw_super.control[k_ctr]
						k_x = kListView_1.x
						k_y = kListView_1.y
						k_w = kListView_1.width
						k_h = kListView_1.height
						k_enabled = kListView_1.enabled
						k_visible = kListView_1.visible
						k_classname = trim(kListView_1.classname()) 
					CASE ELSE
						// irrilevante
						k_classname = ""
				end choose

				if k_classname > " " then
					
					kst_profilestring_ini.valore = String(k_w)
					kst_profilestring_ini.nome = k_section + "_" + k_classname + "_w"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				
					kst_profilestring_ini.valore = String(k_h)
					kst_profilestring_ini.nome = k_section + "_" + k_classname + "_h"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				
					kst_profilestring_ini.valore = String(k_x)
					kst_profilestring_ini.nome = k_section + "_" + k_classname + "_x"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				
					kst_profilestring_ini.valore = String(k_y)
					kst_profilestring_ini.nome = k_section + "_" + k_classname + "_y"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				
					if k_visible then
						kst_profilestring_ini.valore = "1"
					else
						kst_profilestring_ini.valore = "0"
					end if
					kst_profilestring_ini.nome = k_section + "_" + k_classname + "_visible"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
				
					if k_enabled then
						kst_profilestring_ini.valore = "1"
					else
						kst_profilestring_ini.valore = "0"
					end if
					kst_profilestring_ini.nome = k_section + "_" + k_classname + "_enabled"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

					kst_profilestring_ini.valore = string(kw_super.control[k_ctr].typeof()) 
					kst_profilestring_ini.nome = k_section + "_" + k_classname +  "_typeof"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
			
				end if
			end if
			
		next //k_ctr
			
	end if
	
	
	
	
	
end subroutine

protected function st_window_size u_window_size_restore ();//---
//--- Ripristina le dimensioni e posizioni della Window dal INI 
//---
//---
string k_section, k_rcx 
int k_num_win, k_ctr
//datawindow kdw_1
st_window_size kst_window_size
st_profilestring_ini kst_profilestring_ini
w_super kw_super
kuf_utility kuf1_utility

//
//kw_super = this
//
////--- get proprietà della window
////kuf1_menu_window = create kuf_menu_window
////kst_tab_menu_window.window = trim(kw_super.ClassName())
////kuf1_menu_window.get_st_tab_menu_window( kst_tab_menu_window )
////destroy kuf1_menu_window
//	
////kw_super_ultima = kGuf_data_base.prendi_win_prec( )
////if NOT isnull(kw_super_ultima) then
////	if kw_super_ultima <> kw_super and kw_super_ultima.windowstate = MAXIMIZED! then
////		kw_super.windowstate = MAXIMIZED!
////	end if
////end if
//
//
//if this.windowstate <> MAXIMIZED! then
//	
////--- numero di win aperte con lo stesso nome
////	k_num_win = kGuf_data_base.prendi_num_win_uguale(trim(kw_super.ClassName()))	
//	
//	if ki_st_open_w.st_tab_menu_window.salva_size = "S" or len(trim(ki_st_open_w.id_programma)) = 0 then
//
//		k_section = "winsize_" + trim(ki_nome_save) //trim(kw_super.ClassName())
//	
//		kst_window_size.nome = + trim(ki_nome_save) //trim(kw_super.ClassName())
//	
//		kst_profilestring_ini.operazione = "1"
//		kst_profilestring_ini.valore = "0"
//		kst_profilestring_ini.file = "window"
//		kst_profilestring_ini.titolo = "window"
//
//		
////	   if k_num_win > 0 then // istanze
//			kst_profilestring_ini.nome = k_section + "_x"
//			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//			if kst_profilestring_ini.esito <> "1" then
//				kst_window_size.x = long(kst_profilestring_ini.valore)
//			end if
//			kst_profilestring_ini.nome = k_section + "_y"
//			k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//			if kst_profilestring_ini.esito <> "1" then
//				kst_window_size.y = long(kst_profilestring_ini.valore)
//			end if
////		else
////			kst_window_size.x = 1
////			kst_window_size.y = 1
////		end if
//		kst_profilestring_ini.nome = k_section + "_w"
//		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//		if kst_profilestring_ini.esito <> "1" then
//			kst_window_size.w = long(kst_profilestring_ini.valore)
//		end if
//		kst_profilestring_ini.nome = k_section + "_h"
//		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//		if kst_profilestring_ini.esito <> "1" then
//			kst_window_size.h = long(kst_profilestring_ini.valore)
//		end if
//		kst_profilestring_ini.nome = k_section + "_WindowState"
//		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//		if kst_profilestring_ini.esito <> "1" then
//			kst_window_size.WindowState = trim(kst_profilestring_ini.valore)
//		end if
//		
////--- per le windows MDI visualizza e dati x,y... errati allora massimizzo 
////		if kw_super.WindowType <> MDI! and kw_super.WindowType <> MDIHelp! &
////         and (lower(kst_window_size.WindowState) = "minimized!" &
////		        or lower(kst_window_size.WindowState) = "maximized!") then
////			kst_window_size.WindowState = "Normal!"
////			kw_super.WindowState = Normal!
////			kst_window_size = u_window_adatta_size(kw_super)
////		end if
//		if kst_window_size.w <= 0 or kst_window_size.h <= 160 or kst_window_size.x <= 0 or kst_window_size.y <= 0 then
//			kst_window_size.WindowState = "Normal!"
//			kst_window_size.x = 10
//			kst_window_size.w = w_main.width - kst_window_size.x - w_main.width * 0.10
//			kst_window_size.y = 10
//			kst_window_size.h = w_main.height - kst_window_size.y - w_main.height * 0.20
//		else
////		if kst_window_size.w <= 0 then
////--- per le windows MDI....
////			if kw_super.WindowType = MDI! or kw_super.WindowType = MDIHelp! then
////				kst_window_size.WindowState = "Normal!"
////				kst_window_size.w = 0
////			else
////				kst_window_size = u_window_adatta_size(kw_super)
////			end if
////		end if
////		if kst_window_size.h <= 160 then 
////--- per le windows MDI....
////			if kw_super.WindowType = MDI! or kw_super.WindowType = MDIHelp! then
////				kst_window_size.WindowState = "Normal!"
////				kst_window_size.h = 0
////			else
////				kst_window_size.h = w_main.height * 0.8
////			end if
////		end if
////		if kst_window_size.x <= 0 then
////--- per le windows MDI....
////			if kw_super.WindowType = MDI! or kw_super.WindowType = MDIHelp! then
////				kst_window_size.WindowState = "Normal!"
////				kst_window_size.x = 0
////			else
////				kst_window_size = u_window_adatta_size(kw_super)
////			end if
////		end if
////		if kst_window_size.y <= 0 then 
////--- per le windows MDI....
////			if kw_super.WindowType = MDI! or kw_super.WindowType = MDIHelp! then
////				kst_window_size.WindowState = "Normal!"
////				kst_window_size.y = 0
////			else
////				kst_window_size = u_window_adatta_size(kw_super)
////			end if
////		end if
//			kst_window_size.WindowState = "Normal!"
//			if w_main.width < (kst_window_size.w + kst_window_size.x) then
//				kst_window_size.x = 10
//				kst_window_size.w = w_main.width - kst_window_size.x - w_main.width * 0.10
//			end if
//			if w_main.height < (kst_window_size.h + kst_window_size.y) then
//				kst_window_size.y = 10
//				kst_window_size.h = w_main.height - kst_window_size.y - w_main.height * 0.20
//			end if
//		end if
//	else
//		
////--- dimensione predefinita		
//		if ki_st_open_w.st_tab_menu_window.salva_size = "X" then
//
////--- Set the size e posizione
//			if upper(left(kst_window_size.windowstate,9)) <> "MAXIMIZED" then
//				
//				kuf1_utility = create kuf_utility
//
//				this.SetRedraw(false)
//				
//				kuf1_utility.u_window_adatta_size(kw_super)
//
//				this.SetRedraw(true)
//				
//				destroy kuf1_utility
//				
//			end if
//			
//		end if
//
//	end if
//
//end if
	


return kst_window_size


end function

protected subroutine u_window_size_save ();//---
//--- Salva le dimensioni e posizioni della Window nel INI 
//---
//---
integer k_x, k_y, k_w, k_h, k_num_win, k_ctr 
string k_WindowState, k_section, k_rcx 
st_profilestring_ini kst_profilestring_ini
st_tab_menu_window kst_tab_menu_window
datawindow kdw_1
w_super kw_super


kw_super = this

//	kuf1_menu_window = create kuf_menu_window
//	kst_tab_menu_window.window = trim(kw_super.ClassName())
//	kuf1_menu_window.get_st_tab_menu_window( kst_tab_menu_window )
//	destroy kuf1_menu_window

//--- numero di win aperte con lo stesso nome
//	k_num_win = kGuf_data_base.prendi_num_win_uguale(trim(kw_super.ClassName()))	
	
if ki_st_open_w.st_tab_menu_window.salva_size = "S" and kw_super.WindowState <> Minimized! then

//--- salvo pos e dimensioni se finestra 'normal'
	if kw_super.WindowState = normal! then

		k_section = "winsize_" + trim(ki_nome_save) //trim(kw_super.ClassName())
	
		if kw_super.x > 0 then
			k_x = kw_super.x
		else
			k_x = 1
		end if
		if kw_super.y > 0 then
			k_y = kw_super.y
		else
			k_y = 1
		end if
		if kw_super.width > w_main.width then
			k_w = w_main.width
		else
			k_w = kw_super.width
		end if
		if kw_super.height > w_main.height then
			k_h = w_main.height
		else
			k_h = kw_super.height
		end if
//		if kw_super.width + x > w_main.width then
//			w = w_main.width - x -10
//		end if
//		if kw_super.height + y > w_main.height then
//			h = w_main.height - y -10
//		end if

	end if	
// Set the size e posizione
	choose case kw_super.WindowState
		case maximized!			
			k_WindowState = "Maximized!"
		case Minimized!			
			k_WindowState = "Minimized!"
		case normal!			
			k_WindowState = "Normal!"
	end choose
	kst_profilestring_ini.operazione = "2"
	kst_profilestring_ini.file = "window"
	kst_profilestring_ini.titolo = "window"

	kst_profilestring_ini.valore = String(k_WindowState)
	kst_profilestring_ini.nome = k_section + "_WindowState"
	k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))

//--- salvo pos e dimensioni se finestra 'normal'
	if kw_super.WindowState = normal! then
		
		kst_profilestring_ini.valore = String(k_w)
		kst_profilestring_ini.nome = k_section + "_w"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	
		kst_profilestring_ini.valore = String(k_h)
		kst_profilestring_ini.nome = k_section + "_h"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	
		kst_profilestring_ini.valore = String(k_x)
		kst_profilestring_ini.nome = k_section + "_x"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	
		kst_profilestring_ini.valore = String(k_y)
		kst_profilestring_ini.nome = k_section + "_y"
		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
	
	end if
end if
	
	
	
	
	
end subroutine

public subroutine u_resize ();//
//--- questa per gli eredi è meglio non fare niente 
//
boolean k_risize = false, k_predef = false


	if ki_personalizza_pos_controlli and not ki_controlli_ripristinati then
//--- posiziona e dimensiona gli oggetti personalizzati nella window	
		if u_window_control_restore() then
			ki_controlli_ripristinati = true
		else
			k_risize = true
		end if
		this.transparency = 0
	
	else
//--- se non personalizzata rende visibili i primi oggetti della window		
		k_risize = true
	end if
	
	if k_risize and not ki_controlli_ripristinati then
		k_predef = u_resize_predefinita( )
		if not k_predef then
			u_resize_1( )
		end if
		u_obj_visible()  
		if  k_predef then
			u_window_control_save( )  // salva subito le pos e size predef dei controlli 
		end if
	else
		if ki_risize_w then
			ki_risize_w = false
			u_resize_1( )
		end if
	end if
	
end subroutine

public subroutine u_write_trace ();//
//--- scrive TRACE su LOG degli errori se attivo
//
st_esito kst_esito

if kguo_g.kG_trace_attiva then
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito.trace
	kst_esito.sqlerrtext = &
			  + "n. " + string (Error.number) + " " + trim(error.Text) & 
			  + "; Oggetto: " + trim (Error.Object ) & 
			  + "; evento: " + trim (Error.ObjectEvent  ) & 
			  + "; alla linea: " + string (Error.Line ) & 
	
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
end if

end subroutine

public subroutine u_obj_visible ();//
//--- Chiamato solo una volta dopo il RESIZE
//--- Visualizza gli Oggetti
//
if ki_primo_giro_obj_visible then
	ki_primo_giro_obj_visible = false
	u_obj_visible_0()
	this.transparency = 0
end if

end subroutine

public subroutine u_obj_visible_0 ();//--- DA UTILIZZARE PER GLI EREDI
//--- Chiamato solo una volta dopo il RESIZE
//--- Visualizza gli Oggetti
//

end subroutine

public subroutine u_resize_1 ();//
//--- x gli oggetti che ereditano qui ci stanno le dimensioni personalizzate delle window finali
end subroutine

public function boolean u_window_control_restore ();//---
//--- Ripristina dimensioni e pozionne dei controlli salvati dall'ultima chiusura della window dal INI 
//--- ret: FALSE = non trova niente da ripristinare
//---
boolean k_return = false
string k_section, k_rcx, k_classname
int k_num_win, k_ctr, k_n_ctrl
long k_x, k_y, k_w, k_h
boolean k_visible 
windowobject kwindowobject_1
datawindow kdw_1
SingleLineEdit kSingleLineEdit_1
StaticText kStaticText_1
CommandButton kCommandButton_1
TreeView kTreeView_1
ListView kListView_1
st_profilestring_ini kst_profilestring_ini
w_super kw_super

//--- get proprieta' della window
//	kuf1_menu_window = create kuf_menu_window
//	kst_tab_menu_window.window = trim(kw_super.ClassName())
//	kuf1_menu_window.get_st_tab_menu_window( kst_tab_menu_window )
//	destroy kuf1_menu_window

//--- numero di win aperte con lo stesso nome
//	k_num_win = kGuf_data_base.prendi_num_win_uguale(trim(kw_super.ClassName()))	
	kw_super = this
//--- Ripristina posizioni e dimensione delle dw della windows
	if ki_salva_controlli then //and k_num_win = 1 then

		k_section = "winsize_" + trim(ki_nome_save) //kw_super.ClassName()

		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "0"
		kst_profilestring_ini.file = "window"
		kst_profilestring_ini.titolo = "control"
		
		ki_personalizza_pos_controlli = true
//		kst_profilestring_ini.nome = k_section + "_personalizza_pos_controlli"
//		k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
//		if kst_profilestring_ini.esito = "0" then
//			if trim(kst_profilestring_ini.valore) > " " then
//				if lower(trim(kst_profilestring_ini.valore)) = "true" then
//					ki_personalizza_pos_controlli = true
//				end if
//			end if
//		end if
		
		if ki_personalizza_pos_controlli then
			
			k_n_ctrl = upperbound( kw_super.control[] )
			kst_profilestring_ini.esito = "0"
			k_ctr = 1
			do while k_ctr <= k_n_ctrl and (kst_profilestring_ini.esito = "0" or kst_profilestring_ini.esito = "W")
			
				if isvalid( kw_super.control[k_ctr] ) then
	
					kwindowobject_1 = kw_super.control[k_ctr]
					k_classname = trim(kwindowobject_1.classname())
	
					kst_profilestring_ini.nome = k_section + "_" + k_classname + "_w"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
					if kst_profilestring_ini.esito = "0" then
						if long(kst_profilestring_ini.valore) > 0 then
							k_return = true
							k_w = long(kst_profilestring_ini.valore)
						else
							k_w = 0
						end if
					end if
					
					kst_profilestring_ini.nome = k_section + "_" + k_classname + "_h"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
					if kst_profilestring_ini.esito = "0" then
						if long(kst_profilestring_ini.valore) > 0 then
							k_return = true
							k_h = long(kst_profilestring_ini.valore)
						else
							k_h = 0
						end if
					end if
				
					kst_profilestring_ini.nome = k_section + "_" + k_classname + "_x"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
					if kst_profilestring_ini.esito = "0" then
						if long(kst_profilestring_ini.valore) > 0 then
							k_return = true
							k_x = long(kst_profilestring_ini.valore)
						else
							k_x = 0
						end if
					end if
				
					kst_profilestring_ini.nome = k_section + "_" + k_classname + "_y"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
					if kst_profilestring_ini.esito = "0" then
						if long(kst_profilestring_ini.valore) > 0 then
							k_return = true
							k_y = long(kst_profilestring_ini.valore)
						else
							k_y = 0
						end if
					end if
				
					kst_profilestring_ini.nome = k_section + "_" + k_classname + "_visible"
					k_rcx = trim(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
					if kst_profilestring_ini.esito = "0" then
						k_return = true
					else
						kst_profilestring_ini.valore = ""
					end if
					if trim(kst_profilestring_ini.valore) = "1" then
						k_visible = true
					else
						k_visible = false
					end if
				
			 		choose case kwindowobject_1.typeof()
						case datawindow!
							kdw_1 = kw_super.control[k_ctr]
							kdw_1.x = k_x
							kdw_1.y = k_y
							kdw_1.width = k_w 
							kdw_1.height = k_h
							kdw_1.visible = k_visible
						case SingleLineEdit!
							kSingleLineEdit_1 = kw_super.control[k_ctr]
							kSingleLineEdit_1.x = k_x 
							kSingleLineEdit_1.y = k_y 
							kSingleLineEdit_1.width = k_w  
							kSingleLineEdit_1.height = k_h
							kSingleLineEdit_1.visible = k_visible
						case StaticText!
							kStaticText_1 = kw_super.control[k_ctr]
							kStaticText_1.x = k_x
							kStaticText_1.y = k_y
							kStaticText_1.width = k_w  
							kStaticText_1.height = k_h
							kStaticText_1.visible = k_visible
//						case CommandButton! 
//							kCommandButton_1 = kw_super.control[k_ctr]
//							kCommandButton_1.x = k_x
//							kCommandButton_1.y = k_y
//							kCommandButton_1.width = k_w
//							kCommandButton_1.height = k_h
//							kCommandButton_1.visible = k_visible
						case TreeView! 
							kTreeView_1 = kw_super.control[k_ctr]
							kTreeView_1.x = k_x
							kTreeView_1.y = k_y 
							kTreeView_1.width = k_w
							kTreeView_1.height = k_h
							kTreeView_1.visible = k_visible
						case ListView! 
							kListView_1 = kw_super.control[k_ctr]
							kListView_1.x = k_x 
							kListView_1.y = k_y 
							kListView_1.width = k_w 
							kListView_1.height = k_h 
							kListView_1.visible = k_visible
						CASE ELSE
							// irrilevante
					end choose
					
				end if
				
				k_ctr++

			loop

			
		end if
	end if
	

return k_return



end function

public function boolean u_resize_predefinita ();//
//--- imposta le dimensioni predefinite
//--- torna FALSE se non c'è nessun dimensionamento predefinito
//
return false

end function

on w_super.create
end on

on w_super.destroy
end on

event open;//
	//NON SI PUO' SE E' UN MDI SHEET: this.hide( )
	
//--- Recupera i parametri passati con il WITHPARM
	if isvalid(message.powerobjectparm) then 
		ki_st_open_w = message.powerobjectparm
	else
		ki_st_open_w.flag_adatta_win = kkg.adatta_win
		ki_st_open_w.flag_modalita = "" 
	end if
//--- Imposta il flag di Giro di 'prima Volta' x evitare alcuni controlli 
	ki_st_open_w.flag_primo_giro = "S"

	if ki_st_open_w.st_tab_menu_window.salva_controlli = "S" then
		ki_salva_controlli = true
	end if

	ki_nome_save = trim(this.ClassName())

	post u_win_open( )

	//NON SE E' UN MDI SHEET: post event u_show()

end event

event resize;//
if ki_st_open_w.flag_primo_giro <> "S" then
	ki_risize_w = true
	u_resize()
end if


end event

event close;//
u_win_close( )
end event

