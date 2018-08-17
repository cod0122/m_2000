$PBExportHeader$w_convalida_calc.srw
forward
global type w_convalida_calc from window
end type
type dw_conv from datawindow within w_convalida_calc
end type
end forward

global type w_convalida_calc from window
integer width = 1394
integer height = 732
boolean titlebar = true
string title = "Simulatore"
boolean controlmenu = true
windowtype windowtype = child!
long backcolor = 32172778
boolean center = true
event u_open ( )
dw_conv dw_conv
end type
global w_convalida_calc w_convalida_calc

type variables
//datastore kdsi_elenco
protected st_tab_base kist_tab_base
protected st_tab_meca kist_tab_meca
private st_tab_meca_dosim kist_tab_meca_dosim
private datastore kdsi_elenco_output

private kuf_meca_dosim kiuf_meca_dosim
//private kuf_armo kiuf_armo
private string ki_err_lav_ok=""
private string ki_titolo_window_orig

private kuf_file_dragdrop kiuf_file_dragdrop
end variables

forward prototypes
protected function string inizializza ()
private subroutine suggerisci_valore ()
private subroutine calcola_coeff_a_s ()
private function st_esito leggi_lotto_dosimetrico (st_tab_dosimetrie kst_tab_dosimetrie) throws uo_exception
protected subroutine open_start_window ()
protected subroutine inizializza_personale (st_tab_meca_dosim kst_tab_meca_dosim)
public function integer u_retrieve (st_tab_meca_dosim ast_tab_meca_dosim)
protected function string aggiorna_dati ()
public subroutine u_resize ()
end prototypes

event u_open();//

try 


//		if isnull(ki_st_open_w.key1) then ki_st_open_w.key1 = ""

		u_resize( )
		open_start_window()
		inizializza()
	
		this.show( )	
		this.SetPosition(topmost! )

catch(uo_exception kuo_exception )
	post event close( )

end try


end event

protected function string inizializza ();//======================================================================
//=== Inizializzazione della Windows
//=== 
//======================================================================
//
int k_ctr=0 
string k_errore = "0"
int k_rc
datawindowchild kdwc_1


try

	dw_conv.getchild("dosim_lotto_dosim", kdwc_1)
	if kdwc_1.rowcount( ) > 0 then
	else
		k_rc = kdwc_1.settransobject(sqlca)
		k_rc = kdwc_1.retrieve()
//		k_rc = kdwc_1.insertrow(0)
	end if

	dw_conv.getchild("dosim_rapp_a_s", kdwc_1)
	if kdwc_1.rowcount( ) > 0 then
	else
		kdwc_1.settransobject(sqlca)
		kdwc_1.retrieve()
	end if

	dw_conv.setfocus()
	dw_conv.setcolumn(1)
			
//--- in caso di errore...
catch (uo_exception kuo_exception1)
	k_errore = "1"
	kuo_exception1.messaggio_utente()
//	cb_ritorna.postevent(clicked!)
end try



return k_errore


end function

private subroutine suggerisci_valore ();//
//--- 
//
long k_riga
double k_coeff_a_s, k_rc_d
int k_assorbanza, k_spessore
string k_lotto_dosim 
datawindowchild kdwc_1
st_esito kst_esito
st_tab_armo kst_tab_armo
st_tab_dosimetrie kst_tab_dosimetrie
kuf_armo kuf1_armo
kuf_ausiliari kuf1_ausiliari
pointer kp_oldpointer 


//=== Puntatore Cursore da attesa..... 
	kp_oldpointer = SetPointer(HourGlass!)

	dw_conv.accepttext()
	
	k_riga = dw_conv.getrow()
	k_assorbanza = dw_conv.getitemnumber(k_riga, "dosim_assorb")
	k_spessore = dw_conv.getitemnumber(k_riga, "dosim_spessore")

	if dw_conv.getitemnumber(k_riga, "num_int") > 0 &
	   and dw_conv.getitemdate(k_riga, "data_int") > date(0) &
		and LenA(trim(dw_conv.getitemstring(k_riga,"dosim_lotto_dosim"))) > 0 & 
		then
	
		if (isnull(k_assorbanza) or k_assorbanza = 0 &
			 or isnull(k_spessore) or k_spessore = 0) &
			and (k_spessore > 0 or k_assorbanza > 0) then
			
			kuf1_armo = create kuf_armo
			kst_tab_armo.num_int = dw_conv.getitemnumber(k_riga, "num_int") 
			kst_tab_armo.data_int = dw_conv.getitemdate(k_riga, "data_int") 
			kst_tab_armo.dose = 0
			kst_esito = kuf1_armo.leggi_riga("D", kst_tab_armo)
			destroy kuf1_armo
			
			if kst_esito.esito = "0" and kst_tab_armo.dose > 0 then
				dw_conv.setitem(k_riga, "data_int", kst_tab_armo.data_int) 
				
				k_lotto_dosim = trim(dw_conv.getitemstring(k_riga, "dosim_lotto_dosim"))
				kst_tab_dosimetrie.coeff_a_s = 0
				kst_tab_dosimetrie.dose = kst_tab_armo.dose
				kst_tab_dosimetrie.lotto_dosim = k_lotto_dosim
				kuf1_ausiliari = create kuf_ausiliari
				kst_esito = kuf1_ausiliari.tb_dosimetrie_select(kst_tab_dosimetrie)
				destroy kuf1_ausiliari
				
				if kst_esito.esito = "0" and kst_tab_dosimetrie.coeff_a_s > 0 then
					
					if k_assorbanza > 0 then
						k_rc_d = k_assorbanza / kst_tab_dosimetrie.coeff_a_s
						k_spessore = round( k_rc_d, 0)
						dw_conv.setitem(k_riga, "dosim_spessore", k_spessore)
					else
						k_rc_d = k_spessore * kst_tab_dosimetrie.coeff_a_s 
						k_assorbanza = round( k_rc_d, 0)
						dw_conv.setitem(k_riga, "dosim_assorb", k_assorbanza)
					end if
					
//					dw_conv.setitem(k_riga, "dosim_coeff_a_s", kst_tab_dosimetrie.coeff_a_s)
//--- Calcola il rapporto a/s e trova la dose
					calcola_coeff_a_s ()
					
				else
		
					messagebox("Suggerisci Valore", &
			         "Coefficiente non valorizzato in tabella per il Lotto~n~r" &
						+ k_lotto_dosim &
						+ " e Dose " + string(kst_tab_armo.dose, "#####0.00"), &
					  Information!)
				
					
				end if
			else
		
				messagebox("Suggerisci Valore", &
			         "Dose non trovata, riprova o~n~rcorreggi il Riferimento indicato", &
					  Information!)
				
			end if
		else
		
			messagebox("Suggerisci Valore", &
			         "Dati Insufficienti/Abbondanti, impostare/azzerare ~n~ril valore in Assorbanza o Spessore", &
					  Information!)
			
		end if
		
	else
		
		messagebox("Suggerisci Valore", &
			         "Dati Insufficienti, impostare il Nome Lotto e Riferimento", &
					  Information!)
		
	end if
				
	
	SetPointer(kp_oldpointer)
	

end subroutine

private subroutine calcola_coeff_a_s ();//
//--- 
//
long k_riga, k_riga_dwc
double k_coeff_a_s=0
string k_lotto_dosim="" 
pointer kp_oldpointer 
st_esito kst_esito
st_tab_dosimetrie kst_tab_dosimetrie
kuf_ausiliari kuf1_ausiliari


//=== Puntatore Cursore da attesa..... 
	kp_oldpointer = SetPointer(HourGlass!)

	dw_conv.accepttext() 

	k_riga = dw_conv.getrow() 
	k_lotto_dosim = trim(dw_conv.getitemstring(k_riga, "dosim_lotto_dosim")) 
	
	k_coeff_a_s = dw_conv.getitemnumber(k_riga, "dosim_rapp_a_s") 
	
	if dw_conv.getitemnumber(k_riga, "dosim_assorb") > 0 & 
		and dw_conv.getitemnumber(k_riga, "dosim_spessore") > 0 &
		then
		k_coeff_a_s = dw_conv.getitemnumber(k_riga, "dosim_assorb") / & 
				  dw_conv.getitemnumber(k_riga, "dosim_spessore") 
	end if
	
	kst_tab_dosimetrie.dose = 0
	
	if	k_coeff_a_s > 0 then
		
		kst_tab_dosimetrie.lotto_dosim = k_lotto_dosim
		kst_tab_dosimetrie.coeff_a_s = round(k_coeff_a_s, 2)
		
//--- legge archivio delle dosimetrie x reperire la dose	di lavorazione	
		kuf1_ausiliari = create kuf_ausiliari
		kst_esito = kuf1_ausiliari.tb_dosimetrie_select (kst_tab_dosimetrie)
		destroy kuf_ausiliari
		
		if kst_esito.esito <> "0" then
			kst_tab_dosimetrie.dose = 0
		end if
		
	end if

	dw_conv.setitem(k_riga, "dosim_rapp_a_s", k_coeff_a_s)
	dw_conv.setitem(k_riga, "dosim_dose", kst_tab_dosimetrie.dose)

	SetPointer(kp_oldpointer)


end subroutine

private function st_esito leggi_lotto_dosimetrico (st_tab_dosimetrie kst_tab_dosimetrie) throws uo_exception;//
st_esito kst_esito
kuf_ausiliari kuf1_ausiliari


	kst_esito.esito = kkg_esito.ok

	if LenA(trim(kst_tab_dosimetrie.lotto_dosim)) > 0 then

		kuf1_ausiliari = create kuf_ausiliari
		kst_esito = kuf1_ausiliari.tb_dosimetrie_select_lotto_1(kst_tab_dosimetrie) 
		destroy kuf1_ausiliari

		if kst_esito.esito <> kkg_esito.ok then
			kguo_exception.inizializza( )
			kguo_exception.SetMessage ( &
				"Nome Lotto Dosimetrico non Trovato ~n~r" + &
				"( Codice cercato: " + trim(kst_tab_dosimetrie.lotto_dosim) + " )" )
			kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_anomali)
			throw kguo_exception
		else
			if kst_tab_dosimetrie.attivo <> "S" then
				kguo_exception.inizializza( )
				kguo_exception.SetMessage ( &
					"Nome Lotto Dosimetrico non Attivo ~n~r" + &
					"( Codice cercato: " + trim(kst_tab_dosimetrie.lotto_dosim) + " )" )
				kguo_exception.set_tipo(kguo_exception.KK_st_uo_exception_tipo_dati_anomali)
				throw kguo_exception
			end if
		end if
	end if
	
return kst_esito
	
end function

protected subroutine open_start_window ();//
	kiuf_meca_dosim = create kuf_meca_dosim

	dw_conv.insertrow(0)



	
end subroutine

protected subroutine inizializza_personale (st_tab_meca_dosim kst_tab_meca_dosim);////
////======================================================================
////=== Inizializzazione della Windows
////=== Ripristino DW; tasti; e retrieve liste
////======================================================================
////
//int k_rc
//
//
//try
//		
////--- salvo i dati appena letti per verifiche 
//	if dw_conv.rowcount() > 0 then
//		kist_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s = dw_conv.getitemnumber(1, "dosim_rapp_a_s")
//		kist_tab_meca.st_tab_meca_dosim.dosim_assorb = dw_conv.getitemnumber(1, "dosim_assorb")
//		kist_tab_meca.st_tab_meca_dosim.dosim_spessore = dw_conv.getitemnumber(1, "dosim_spessore")
//	end if
//	
//catch (uo_exception kuo_exception)
//	kuo_exception.messaggio_utente()
//
//
//finally 	
//	attiva_tasti( )
//
//end try
//
//
end subroutine

public function integer u_retrieve (st_tab_meca_dosim ast_tab_meca_dosim);//
int k_righe = 0
//
//try
//		
//	inizializza_personale(ast_tab_meca_dosim)
//
//catch (uo_exception kuo_exception)
//	throw kuo_exception
//	
//end try

return k_righe

end function

protected function string aggiorna_dati ();//
	if trim(dw_conv.getitemstring(1,"dosim_lotto_dosim")) > " " then 
//--- Calcola il rapporto a/s e trova la dose
		calcola_coeff_a_s ()
	end if

return "0"
end function

public subroutine u_resize ();//
//--- dimensioni
	this.width = 1350
	this.height = 700

	dw_conv.move( 1, 1)
	dw_conv.resize(this.width , this.height )

end subroutine

on w_convalida_calc.create
this.dw_conv=create dw_conv
this.Control[]={this.dw_conv}
end on

on w_convalida_calc.destroy
destroy(this.dw_conv)
end on

event close;if isvalid(kiuf_meca_dosim) then destroy kiuf_meca_dosim
//if isvalid(kiuf_armo) then destroy kiuf_armo

end event

event open;//
post event u_open()

end event

type dw_conv from datawindow within w_convalida_calc
integer x = 18
integer y = 16
integer width = 1326
integer height = 584
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_convalida_calc"
boolean border = false
boolean livescroll = true
end type

event clicked;//
//=== Premuto pulsante nella DW
//
int k_rc
long k_riga
string k_lotto_dosim
boolean k_link_standard_sempre_possibile
st_open_w kst_open_w
kuf_menu_window kuf1_menu_window


choose case dwo.name

//	case "b_ok" 
//		cb_aggiorna.triggerevent(clicked!)

	case "b_lotto_dosim" &
		, "dosim_rapp_a_s_t" 
		
		if not isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore
	
		choose case dwo.name
				
//			case "b_lotto_dosim"
//				kdsi_elenco_output.dataobject = "d_dosimetrie_lotto_l" 
//				k_rc = kdsi_elenco_output.settransobject ( sqlca )
//				k_rc = kdsi_elenco_output.retrieve()
//				kst_open_w.key1 = "Elenco Lotti Dosimetrici " 
				
			case "dosim_rapp_a_s_t"
				kdsi_elenco_output.dataobject = "d_dosimetrie_coeff_lotto_l" 
				k_rc = kdsi_elenco_output.settransobject ( sqlca )
				k_riga = dw_conv.getrow()
				k_lotto_dosim = trim(dw_conv.getitemstring(k_riga, "dosim_lotto_dosim")) 
				k_rc = kdsi_elenco_output.retrieve(k_lotto_dosim)
				kst_open_w.key1 = "Elenco Coeff.Dosimetrici del Lotto: " + k_lotto_dosim 
				
		end choose
	
		if kdsi_elenco_output.rowcount() > 0 then
	
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
			kst_open_w.id_programma = kkg_id_programma.elenco
			kst_open_w.flag_primo_giro = "S"
			kst_open_w.flag_modalita = kkg_flag_modalita.elenco
			kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
			kst_open_w.flag_leggi_dw = " "
			kst_open_w.flag_cerca_in_lista = " "
			kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
			kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		//	kst_open_w.key4 = get_id_programma( ) //kiw_this_window.title    //--- Titolo della Window di chiamata per riconoscerla
			kst_open_w.key12_any = kdsi_elenco_output
			kst_open_w.flag_where = " "
			kuf1_menu_window = create kuf_menu_window 
			kuf1_menu_window.open_w_tabelle(kst_open_w)
			destroy kuf1_menu_window
	
		else
			
			messagebox("Elenco Dati", "Nessun valore disponibile. ")
			
			
		end if


end choose

//
end event

event itemchanged;//
st_esito kst_esito
st_tab_dosimetrie kst_tab_dosimetrie


choose case dwo.name
				
	case "dosim_assorb" & 
			,"dosim_spessore" 
		if trim(this.getitemstring(row,"dosim_lotto_dosim")) > " " then 
//--- Calcola il rapporto a/s e trova la dose
			calcola_coeff_a_s ()
		end if
		
	case "dosim_lotto_dosim" 
		try
			kst_tab_dosimetrie.lotto_dosim = trim(data)
			kst_esito = leggi_lotto_dosimetrico(kst_tab_dosimetrie)
		catch (uo_exception kuo_exception1)
			kuo_exception1.messaggio_utente()
			return 1   // dato non accettato!
		end try
		
end choose

end event

