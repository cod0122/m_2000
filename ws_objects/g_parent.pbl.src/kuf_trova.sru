$PBExportHeader$kuf_trova.sru
forward
global type kuf_trova from kuf_parent
end type
end forward

global type kuf_trova from kuf_parent
end type
global kuf_trova kuf_trova

type variables
//
private graphicobject ki_obj_su_cui_trovare // oggetto (datawindow) con i dati da trovare
private w_g_tab kiw_su_cui_trovare		// window contenente il dw con i dati su cui effettuare la ricerca
private w_g_trova kiw_trova		// piccola window con i parametri di trova
//private uo_d_std_trova kiuo_dw_trova
private int ki_num_campo_trova = 1


end variables

forward prototypes
private subroutine u_open_window (string a_titolo)
public subroutine u_close_window_trova ()
private function graphicobject get_obj_trova ()
public subroutine u_trova ()
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
private subroutine set_obj_su_cui_trovare (ref graphicobject a_obj)
public function boolean u_attiva_funzione_trova (string a_flag_richiesta, ref w_g_tab a_w_attiva) throws uo_exception
private function graphicobject get_obj_su_cui_trovare ()
public subroutine u_set_obj_trova (ref uo_d_std_trova auo_dw_trova) throws uo_exception
public subroutine u_riattiva_funzione_trova (string a_flag_richiesta) throws uo_exception
private function w_g_trova get_window_trova ()
private function integer get_num_campo_trova ()
public subroutine u_set_window_trova (ref w_g_trova a_window)
end prototypes

private subroutine u_open_window (string a_titolo);//
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


	K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	K_st_open_w.id_programma = this.get_id_programma(K_st_open_w.flag_modalita)
	K_st_open_w.flag_primo_giro = ""
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	k_st_open_w.key1 = a_titolo  				// descrizione trovo
	K_st_open_w.key12_any = this			// questo oggetto di gestione del trovo
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_trova(k_st_open_w)
	destroy kuf1_menu_window
								

end subroutine

public subroutine u_close_window_trova ();//
//--- Chiude la window contenente il trova
//
if isvalid(kiw_trova) then 
//	kiw_trova.hide( )
	kiw_trova.chiudi_immediato()
end if


end subroutine

private function graphicobject get_obj_trova ();//
	return kiw_trova.dw_trova 



end function

public subroutine u_trova ();//
//--- Applica il trova x i Dati indicati 
//
//

kiw_trova.dw_trova.u_trova( )


end subroutine

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true
end function

private subroutine set_obj_su_cui_trovare (ref graphicobject a_obj);//
ki_obj_su_cui_trovare = a_obj

end subroutine

public function boolean u_attiva_funzione_trova (string a_flag_richiesta, ref w_g_tab a_w_attiva) throws uo_exception;//
//--- Attiva la window x fare una ricerca sui dati in elenco
//--- Inp: 	flag_richiesta ('cerca' o 'cerca ancora')
//---			window del obj (datawindow) su cui fare il trova
//
boolean k_return = false
graphicobject k_obj_su_cui_trovare // oggetto (datawindow) con i dati da trovare



//--- Windows ATTIVA su cui cercare valida?
if isvalid(a_w_attiva) then

	kiw_su_cui_trovare =  a_w_attiva

	if not isvalid(kiw_su_cui_trovare) then
		kguo_exception.inizializza( )
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
		kguo_exception.setmessage( "Finestra nella quale cercare non valida!" )
		throw kguo_exception
	end if

//--- se è cambiato l'elenco su cui cercare allora  
	k_obj_su_cui_trovare = kiw_su_cui_trovare.kigrf_x_trova
	if not isvalid(k_obj_su_cui_trovare) then
		kguo_exception.inizializza( )
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_dati_non_eseguito )
		kguo_exception.setmessage( "Seleziona l'elenco sul quale effettuare la ricerca!" )
		throw kguo_exception
	end if		
	if ki_obj_su_cui_trovare = k_obj_su_cui_trovare then
	else
		ki_obj_su_cui_trovare = k_obj_su_cui_trovare
		if not isvalid(kiw_trova) then
			a_flag_richiesta = KKG_FLAG_RICHIESTA.trova	
		end if
	end if
	
//--- numero del campo di default x la ricerca
	if kGuo_g.kgw_attiva.ki_trova_campo_def > 0 then
		ki_num_campo_trova = kiw_su_cui_trovare.ki_trova_campo_def
	else
		ki_num_campo_trova = 1
	end if

	
//---- se window non ancora aperta
	if not isvalid(kiw_trova) then
		a_flag_richiesta = KKG_FLAG_RICHIESTA.trova	
		u_open_window(kiw_su_cui_trovare.title)	
	else
		if a_flag_richiesta = KKG_FLAG_RICHIESTA.trova	then
			kiw_trova.u_inizializza()
	//		kiw_su_cui_trovare.dw_trova.set_cerca_in_any(ki_num_campo_trova)
		end if

	//---- Mostra solo la funzione Window Cerca
		if a_flag_richiesta = KKG_FLAG_RICHIESTA.trova	or isnull(get_obj_trova()) then
				
			kiw_trova.WindowState = normal!
			k_return = true
		
		else
		
	//--- Esegue  Continua ricerca....	
			if a_flag_richiesta = KKG_FLAG_RICHIESTA.trova_ancora then
				u_trova( )
				k_return = true
			end if
		
		end if
		
		if isvalid(kiw_trova) then
			kiw_trova.bringtotop = true
		end if
	end if

end if

return k_return

end function

private function graphicobject get_obj_su_cui_trovare ();//
//--- torna l'oggetto grafico della window su cui fare la ricerca 
return kiw_su_cui_trovare.kigrf_x_trova



end function

public subroutine u_set_obj_trova (ref uo_d_std_trova auo_dw_trova) throws uo_exception;//

try
	
	auo_dw_trova.set_obj_trova(ki_obj_su_cui_trovare)
	auo_dw_trova.ki_trova_campo_def = get_num_campo_trova()
	auo_dw_trova.set_cerca_in_any(auo_dw_trova.ki_trova_campo_def ) //imposta i parametri x trova

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try
end subroutine

public subroutine u_riattiva_funzione_trova (string a_flag_richiesta) throws uo_exception;//
//--- Riattiva la window x fare una ricerca sui dati in elenco
//--- Inp: 	flag_richiesta ('cerca' o 'cerca ancora')
//---	
//


//--- Windows ATTIVA su cui cercare valida?
if isvalid(kiw_su_cui_trovare) then

	u_attiva_funzione_trova(a_flag_richiesta, kiw_su_cui_trovare)
	
else
	
	kiw_trova.chiudi_immediato()

end if


end subroutine

private function w_g_trova get_window_trova ();//
return kiw_trova 


end function

private function integer get_num_campo_trova ();//
	return ki_num_campo_trova



end function

public subroutine u_set_window_trova (ref w_g_trova a_window);//
kiw_trova = a_window

end subroutine

on kuf_trova.create
call super::create
end on

on kuf_trova.destroy
call super::destroy
end on

event destructor;call super::destructor;//
if isvalid(kiw_trova) then kiw_trova.chiudi_immediato()





end event

