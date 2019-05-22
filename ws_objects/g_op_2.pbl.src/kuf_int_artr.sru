$PBExportHeader$kuf_int_artr.sru
forward
global type kuf_int_artr from kuf_parent
end type
end forward

global type kuf_int_artr from kuf_parent
end type
global kuf_int_artr kuf_int_artr

type variables
//
st_int_artr ki_st_int_artr

//
constant int kki_scelta_report_lotti_entrati = 1
constant int kki_scelta_report_generico = 2
constant int kki_scelta_report_coda_pilota = 3  
constant int kki_scelta_report_in_trattamento = 4
constant int kki_scelta_report_prevFineLav = 5
constant int kki_scelta_report_trattato = 6
constant int kki_scelta_report_chk_intra = 7
constant int kki_scelta_report_RegArt50 = 8
constant int kki_scelta_report_lotti_in_giacenza = 9
constant int kki_scelta_report_lotti_in_giacenza_gia_trattati = 10
constant int kki_scelta_report_lotti_da_sped = 11
constant int kki_scelta_report_lotti_sped = 12
constant int kki_scelta_report_etichette_lotti = 13
constant int kki_scelta_report_etichettine = 14
constant int kki_scelta_report_groupage = 15
constant int kki_scelta_report_bcode_trattati = 16
constant int kki_scelta_report_memo = 17
constant int kki_scelta_report_lotti_sped_dafatt = 18
constant int kki_scelta_report_attestati = 19
constant int kki_scelta_report_art_movim = 20
constant int kki_scelta_report_armo_Contratti = 21
constant int kki_scelta_report_LavxCapitolato = 22
constant int kki_scelta_report_nrdosimetri = 23
constant int kki_scelta_report_RunsRtrRts = 24

int kki_scelta_report_pic_lotti_entrati
int kki_scelta_report_pic_generico
int kki_scelta_report_pic_coda_pilota 
int kki_scelta_report_pic_in_trattamento 
int kki_scelta_report_pic_prevFineLav 
int kki_scelta_report_pic_trattato 
int kki_scelta_report_pic_chk_intra
int kki_scelta_report_pic_RegArt50 
int kki_scelta_report_pic_lotti_in_giacenza 
int kki_scelta_report_pic_lotti_in_giacenza_gia_trattati 
int kki_scelta_report_pic_lotti_da_sped 
int kki_scelta_report_pic_lotti_sped 
int kki_scelta_report_pic_etichette_lotti 
int kki_scelta_report_pic_etichettine 
int kki_scelta_report_pic_groupage 
int kki_scelta_report_pic_bcode_trattati 
int kki_scelta_report_pic_memo 
int kki_scelta_report_pic_lotti_sped_dafatt 
int kki_scelta_report_pic_attestati 
int kki_scelta_report_pic_art_movim 
int kki_scelta_report_pic_armo_Contratti 
int kki_scelta_report_pic_LavxCapitolato 
int kki_scelta_report_pic_nrdosimetri 
int kki_scelta_report_pic_RunsRtrRts 

end variables
forward prototypes
public function st_esito u_open ()
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
end prototypes

public function st_esito u_open ();//
//
//--- Chiama la OPEN senza particolari funzioni
//---
//--- Input: 
//---
//
boolean  k_return = true
st_open_w kst_open_w
st_esito kst_esito
date k_data


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	k_data = date(0)
	
	//kst_open_w.id_programma = get_id_programma(kkg_flag_modalita.visualizzazione)  //"int_1"
	kst_open_w.flag_primo_giro = "S"
	kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione // interrogazione
	kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
	kst_open_w.flag_leggi_dw = "N"
	kst_open_w.flag_cerca_in_lista = "1"
	kst_open_w.key1 = "0000000000" //mandante
	kst_open_w.key2 = "*" // stato lavorazione (N/I/F)
	kst_open_w.key3 = string(k_data,"dd/mm/yyyy")  //data inizio lav
	kst_open_w.key4 = string(k_data,"dd/mm/yyyy")  //data fine lav
	kst_open_w.key5 = "0000000000"  //cliente mand
	kst_open_w.key5 = "0000000000"  //cliente ricev
	kst_open_w.key5 = "0000000000"  //dose
	kst_open_w.key4 = string(k_data,"dd/mm/yyyy")  //data da 
	kst_open_w.key4 = string(k_data,"dd/mm/yyyy")  //data a 
	kst_open_w.key12_any = ki_st_int_artr
	kst_open_w.flag_where = " "
	
	kst_esito = u_open(kst_open_w)
 
 	if not k_return then
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Funzione richiesta non Eseguita: (id programma: " &
			               + trim(lower(get_id_programma(kkg_flag_modalita.visualizzazione)))+ ", modalita: " + trim(kkg_flag_modalita.visualizzazione) + ")~n~r"
	end if	
		

return kst_esito



end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true

end function

on kuf_int_artr.create
call super::create
end on

on kuf_int_artr.destroy
call super::destroy
end on

