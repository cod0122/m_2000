$PBExportHeader$kuf_g_clienti_l.sru
forward
global type kuf_g_clienti_l from kuf_parent
end type
end forward

global type kuf_g_clienti_l from kuf_parent
end type
global kuf_g_clienti_l kuf_g_clienti_l

type variables
//
private datawindow ki_dw_main // oggetto (datawindow) con i dati da trovare
private w_g_clienti_l kiw_g_clienti_l		// piccola window con i parametri di trova
//private uo_d_g_clienti_l kiuo_dw_g_clienti_l
private int ki_riga_selezionata = 0

private string ki_colonna_nome_parziale = ""
private string ki_colonna_codice = ""
private string ki_colonna_nome = ""

end variables

forward prototypes
public subroutine u_close_window_g_clienti_l ()
private function graphicobject get_obj_g_clienti_l ()
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
private function w_g_clienti_l get_window_g_clienti_l ()
public subroutine u_set_window_g_clienti_l (ref w_g_clienti_l a_window)
public function boolean u_attiva_funzione_g_clienti_l (ref datawindow a_dw_attiva, string a_colonna_nome_parziale, string a_colonna_codice, string a_colonna_nome) throws uo_exception
private subroutine u_open_window ()
public subroutine u_cerca_cliente ()
public subroutine u_nascondi ()
end prototypes

public subroutine u_close_window_g_clienti_l ();//
//--- Chiude la window contenente il trova
//
if isvalid(kiw_g_clienti_l) then 
//	kiw_g_clienti_l.hide( )
	kiw_g_clienti_l.chiudi_immediato()
end if


end subroutine

private function graphicobject get_obj_g_clienti_l ();//
	return kiw_g_clienti_l.dw_g_clienti_l 



end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true
end function

private function w_g_clienti_l get_window_g_clienti_l ();//
return kiw_g_clienti_l 


end function

public subroutine u_set_window_g_clienti_l (ref w_g_clienti_l a_window);//
kiw_g_clienti_l = a_window

end subroutine

public function boolean u_attiva_funzione_g_clienti_l (ref datawindow a_dw_attiva, string a_colonna_nome_parziale, string a_colonna_codice, string a_colonna_nome) throws uo_exception;//
//--- Attiva la window x fare l'elenco dei Clienti
//--- Inp: 	datawindow del dato da cercare
//---			nome colonna fa cui prendere il nominativo parziale da cercare
//---            nome colonna su cui mettere il codice selezionato
//---            nome colonna su cui mettere la ragione sociale selezionata (opzionale)
//
boolean k_return = false
graphicobject k_obj_su_cui_g_clienti_lre // oggetto (datawindow) con i dati da trovare



//--- Windows ATTIVA su cui cercare valida?
if isvalid(a_dw_attiva) then

	ki_dw_main =  a_dw_attiva
	ki_colonna_nome_parziale = a_colonna_nome_parziale
	ki_colonna_codice = a_colonna_codice
	ki_colonna_nome = a_colonna_nome

	if not isvalid(ki_dw_main) then
		kguo_exception.inizializza( )
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
		kguo_exception.setmessage( "Oggetto sul quale cercare non valido!" )
		throw kguo_exception
	end if

//--- se è cambiato l'elenco su cui cercare allora  
//	if ki_obj_su_cui_g_clienti_lre = k_obj_su_cui_g_clienti_lre then
//	else
//		ki_obj_su_cui_g_clienti_lre = k_obj_su_cui_g_clienti_lre
//		if not isvalid(kiw_g_clienti_l) then
//			a_flag_richiesta = KKG_FLAG_RICHIESTA.trova	
//		end if
//	end if
	
	
//---- se window non ancora aperta
	if not isvalid(kiw_g_clienti_l) then
		u_open_window()	
	else
		u_cerca_cliente()
	end if

	
	if isvalid(kiw_g_clienti_l) then
		kiw_g_clienti_l.bringtotop = true
	end if

end if

return k_return

end function

private subroutine u_open_window ();//
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


	K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	K_st_open_w.id_programma = this.get_id_programma(K_st_open_w.flag_modalita)
	K_st_open_w.flag_primo_giro = ""
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	k_st_open_w.key1 = ""  				// descrizione trovo
	K_st_open_w.key12_any = this			// questo oggetto di gestione del trovo
	
	kuf1_menu_window = create kuf_menu_window 
	OpenWithParm(w_g_clienti_l, k_st_open_w)

	//kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window
								

end subroutine

public subroutine u_cerca_cliente ();//
//--- Trova 
//
long k_riga=0
string k_codice = ""


if  kiw_g_clienti_l.dw_g_clienti_l.rowcount() > 0 then
	k_codice = "%" + upper(trim(ki_dw_main.getitemstring(1,ki_colonna_nome_parziale))) + "%"
	k_riga = kiw_g_clienti_l.dw_g_clienti_l.find( "rag_soc_1 like '" + k_codice + "' " , 1, kiw_g_clienti_l.dw_g_clienti_l.rowcount())
	
	//setPointer(oldpointer)
	if k_riga > 0 then
			
		kiw_g_clienti_l.dw_g_clienti_l.ExpandAllChildren(k_riga,1)
		kiw_g_clienti_l.dw_g_clienti_l.scrolltorow(k_riga)
		kiw_g_clienti_l.dw_g_clienti_l.SelectRow(0, FALSE)
		kiw_g_clienti_l.dw_g_clienti_l.selectrow(k_riga, true)
		kiw_g_clienti_l.dw_g_clienti_l.setrow(k_riga)
			
	end if
end if

ki_dw_main.setfocus( )  //riprende il focus l'oggetto chiamante

end subroutine

public subroutine u_nascondi ();//
if isvalid(kiw_g_clienti_l) then
	kiw_g_clienti_l.visible = false
end if

end subroutine

on kuf_g_clienti_l.create
call super::create
end on

on kuf_g_clienti_l.destroy
call super::destroy
end on

event destructor;call super::destructor;//
if isvalid(kiw_g_clienti_l) then kiw_g_clienti_l.chiudi_immediato()





end event

