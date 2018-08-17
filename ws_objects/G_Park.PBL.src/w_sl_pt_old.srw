$PBExportHeader$w_sl_pt_old.srw
forward
global type w_sl_pt_old from w_g_tab0
end type
end forward

global type w_sl_pt_old from w_g_tab0
int Width=2528
int Height=1448
boolean TitleBar=true
string Title="Piani di Trattamento"
boolean Resizable=false
end type
global w_sl_pt_old w_sl_pt_old

forward prototypes
public function string inizializza ()
private function integer modifica ()
private function string check_dati ()
end prototypes

public function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
string k_sl_pt, k_t_contr
int k_importa = 0
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	if len(trim(mid(st_parametri.text, 3, 20))) = 0 then
		k_sl_pt = "%"
	else
		k_sl_pt = trim(mid(st_parametri.text, 3, 20))
	end if

	if len(trim(mid(st_parametri.text, 50, 20))) = 0 then
		k_t_contr = "*"
	else
		k_t_contr = trim(mid(st_parametri.text, 50, 20))
	end if

//	dw_dett_0.visible = false


//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if cb_ritorna.enabled = false then  //solo la prima volta il tasto e' false 

		k_importa = kuf1_data_base.dw_importfile(mid(st_parametri.text, 3, 20), dw_lista_0)

	end if
		

	if k_importa <= 0 then // Nessuna importazione eseguita

		if dw_lista_0.retrieve(k_sl_pt, k_t_contr) < 1 then
			k_return = "1Non trovati Piani di Trattamento "

			SetPointer(oldpointer)
			messagebox("Lista Piani di Trattamento vuota", &
					"Nessun Codice Trovato per la richiesta fatta")

		end if		
	end if


return k_return



end function

private function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return
string k_key


	k_key = dw_lista_0.getitemstring(dw_lista_0.getrow(), "cod_sl_pt")
	
	k_return = dw_dett_0.retrieve( k_key ) 


return k_return

end function

private function string check_dati ();//
//=== Controllo dati inseriti
string k_return = " "
char k_errore = "0"
int k_rc=0
int k_nr_errori, k_riga, k_riga_t_contr
string k_descr, k_t_contr, k_find
datawindowchild kdwc_t_contr_d


	k_nr_errori = 1
	k_riga = 1

//--- Attivo dw archivio T.CONTRATTI
	dw_dett_0.getchild("t_contr", kdwc_t_contr_d)

	kdwc_t_contr_d.settransobject(sqlca)
	
	k_t_contr = dw_dett_0.getitemstring(k_riga, "t_contr")
	k_find= "codice='" + k_t_contr + "' " 
	k_riga_t_contr = kdwc_t_contr_d.find(k_find, 1, kdwc_t_contr_d.RowCount()) 
	if k_riga_t_contr <= 0 then
		
		k_return = "Contratto non Trovato nella Lista ~n~r" 
 		k_errore = "3"
		k_nr_errori++
		
	end if

	if k_errore = "0" then
		k_descr = dw_dett_0.getitemstring(k_riga, "descr")
	
		if trim(k_descr) = "" or isnull(k_descr) then
	
			if kdwc_t_contr_d.rowcount() > 0 then
				k_descr = kdwc_t_contr_d.getitemstring(k_riga_t_contr, "descr")
			end if
	
			if isnull(k_descr) then
				k_descr = ""
			end if
			
			dw_dett_0.setitem(k_riga, "descr", k_descr)
		end if
	
		k_rc=dw_dett_0.setitem(k_riga, "x_datins", today())
		k_rc=dw_dett_0.setitem(k_riga, "x_utente", "Pwd:"+string(kg_pwd, "###"))
		
	end if


return k_errore + k_return


end function

on w_sl_pt_old.create
call super::create
end on

on w_sl_pt_old.destroy
call super::destroy
end on

event closequery;//
int k_return 
//=== Chiamo l'evento della ancestor altrimenti non funziona il RETURN
k_return = Super::EVENT closequery ( )
RETURN k_return

end event

event resize;//
	this.setredraw(false)
//	tab_1.tabpage_art.dw_dett_1.width = dw_lista_0.width
//	tab_1.tabpage_scade.dw_dett_2.width = dw_lista_0.width
	this.setredraw(true)


end event

event open;call super::open;datawindowchild kdwc_t_contr, kdwc_t_contr_d

//--- Attivo dw archivio T.CONTRATTI
	dw_lista_0.getchild("t_contr", kdwc_t_contr)

	kdwc_t_contr.settransobject(sqlca)

	if kdwc_t_contr.rowcount() = 0 then
		kdwc_t_contr.retrieve("%")
		kdwc_t_contr.insertrow(1)
	end if
	

//--- Attivo dw archivio T.CONTRATTI
	dw_dett_0.getchild("t_contr", kdwc_t_contr_d)

	kdwc_t_contr_d.settransobject(sqlca)

	if kdwc_t_contr_d.rowcount() = 0 then
		kdwc_t_contr_d.retrieve("%")
		kdwc_t_contr_d.insertrow(1)
	end if


end event

type cb_modifica from w_g_tab0`cb_modifica within w_sl_pt_old
int X=2130
int Y=700
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_sl_pt_old
int Width=2505
int Height=532
string DataObject="d_sl_pt_l"
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_sl_pt_old
int X=2130
int Y=992
end type

type cb_cancella from w_g_tab0`cb_cancella within w_sl_pt_old
int X=2130
int Y=844
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_sl_pt_old
int X=2130
int Y=560
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_sl_pt_old
int X=2130
int Y=1140
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_sl_pt_old
int Y=548
int Width=2048
int Height=780
string DataObject="d_sl_pt"
end type

event dw_dett_0::clicked;//soppressione codice del padre
end event

type dw_filtro_0 from w_g_tab0`dw_filtro_0 within w_sl_pt_old
boolean BringToTop=true
end type

type sle_cerca from w_g_tab0`sle_cerca within w_sl_pt_old
boolean BringToTop=true
end type

type cb_cerca_1 from w_g_tab0`cb_cerca_1 within w_sl_pt_old
boolean BringToTop=true
end type

