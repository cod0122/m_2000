$PBExportHeader$kuf_clienti_memo.sru
forward
global type kuf_clienti_memo from kuf_parent
end type
end forward

global type kuf_clienti_memo from kuf_parent
end type
global kuf_clienti_memo kuf_clienti_memo

forward prototypes
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function boolean u_open_applicazione (ref st_tab_g_0 kst_tab_g_0, string k_flag_modalita)
public function boolean if_sicurezza (string aflag_modalita) throws uo_exception
public function boolean if_esiste (st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception
public function long get_id_cliente (ref st_tab_clienti_memo kst_tab_clienti_memo) throws uo_exception
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
	Kst_open_w.key2 = "4" 	// elenco dei letti e da leggere
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

public function boolean if_esiste (st_tab_clienti_memo ast_tab_clienti_memo) throws uo_exception;//
//====================================================================
//=== Verifica se esiste almeno un MEMO x questo cliente
//=== 
//=== Input: st_tab_clienti_memo.id_cliente
//=== Output:                   
//=== Ritorna: 
//===           		  
//====================================================================
boolean k_return = false
string k_string = ""
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


SELECT distinct '1'
INTO :k_string
FROM clienti_memo
where id_cliente = :ast_tab_clienti_memo.id_cliente
using kguo_sqlca_db_magazzino;


 if kguo_sqlca_db_magazzino.sqlcode <> 0 then
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in rilevazione esistenza MEMO clienti." + "~n~r" + trim(sqlca.SQLErrText) 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito)
		throw kguo_exception
	end if
end if

if k_string = "1" then k_return = true

return k_return



end function

public function long get_id_cliente (ref st_tab_clienti_memo kst_tab_clienti_memo) throws uo_exception;//
//--------------------------------------------------------------------
//--- Torna il campo ID_CLIENTE 
//--- 
//--- Input: st_tab_clienti_memo.id_cliente_memo 
//--- Ritorna  ID_CLIENTE 
//--- 
//--- x errore lancia exception
//--------------------------------------------------------------------
long k_return = 0
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if kst_tab_clienti_memo.id_cliente_memo > 0 then
	
	select id_cliente 
	    into :kst_tab_clienti_memo.id_cliente
			from clienti_memo
			WHERE id_cliente_memo = :kst_tab_clienti_memo.id_cliente_memo
			using kguo_sqlca_db_magazzino;
			
	if kguo_sqlca_db_magazzino.sqlcode <> 0 then
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore lettura codice 'Cliente' da avviso MEMO CLIENTI (id " + string(kst_tab_clienti_memo.id_cliente_memo) + ")~n~r" + trim(kguo_sqlca_db_magazzino.SQLErrText) 

			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		end if
	else
		if kst_tab_clienti_memo.id_cliente_memo > 0 then
			k_return = kst_tab_clienti_memo.id_cliente_memo
		end if
	end if
end if		


return k_return

end function

on kuf_clienti_memo.create
call super::create
end on

on kuf_clienti_memo.destroy
call super::destroy
end on

