$PBExportHeader$kuf_utenti_memo.sru
forward
global type kuf_utenti_memo from kuf_parent
end type
end forward

global type kuf_utenti_memo from kuf_parent
end type
global kuf_utenti_memo kuf_utenti_memo

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean u_open_applicazione (ref st_tab_g_0 kst_tab_g_0, string k_flag_modalita)
public function boolean if_sicurezza (string aflag_modalita) throws uo_exception
end prototypes

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
//--- sempre OK in sicurezza
return true

end function

public function boolean u_open_applicazione (ref st_tab_g_0 kst_tab_g_0, string k_flag_modalita);//
kuf_menu_window kuf1_menu_window
st_open_w Kst_open_w


	Kst_open_w.flag_modalita = k_flag_modalita
	Kst_open_w.id_programma = this.get_id_programma(Kst_open_w.flag_modalita)
	Kst_open_w.flag_primo_giro = "S"
	Kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	Kst_open_w.flag_leggi_dw = " "
	Kst_open_w.flag_cerca_in_lista = " "

	Kst_open_w.key1 = string(kst_tab_g_0.id) 	// id cliente
	Kst_open_w.key2 = trim(kst_tab_g_0.idx) 	// settore
	Kst_open_w.key3 = "4" 	// elenco dei letti e da leggere
	Kst_open_w.key12_any = this			// questo oggetto di gestione del trovo
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window
				
				
return true
end function

public function boolean if_sicurezza (string aflag_modalita) throws uo_exception;//
//--- sempre OK in sicurezza
return true

end function

on kuf_utenti_memo.create
call super::create
end on

on kuf_utenti_memo.destroy
call super::destroy
end on

