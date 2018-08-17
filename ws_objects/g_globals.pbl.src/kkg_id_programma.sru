$PBExportHeader$kkg_id_programma.sru
$PBExportComments$Id del programma Chiamato (OBSOLETO)
forward
global type kkg_id_programma from nonvisualobject
end type
end forward

global type kkg_id_programma from nonvisualobject
end type
global kkg_id_programma kkg_id_programma

type variables
//--- ognuna di queste voci deve essere lo stesso id presente nella tabella MENU_WINDOWS 
//--- costanti OBSOLETE ora si usa la tabella menu_window_oggetti quindi per ottenere questo valore fare   nomeOggetto.get_id_window(enum_flag_modalita.xxxxxx)
constant string elenco = "elenco"
constant string barcode = "barcode"
constant string pl_barcode = "pl_barcode"
constant string dosimetria = "convalida"    
constant string dosimetria_da_autorizzare = "convalidaut"
constant string dosimetria_da_sbloccare = "convalidablk"
constant string sblocca_non_conforme = "nonconfsblk"
constant string anag = "cl"
constant string anag_rid = "cl_rid"
//constant string anag_memo = "cl_memo"
constant string attestati = "attestati"
//constant string riferimenti = "riferim_e"
constant string contratti = "ct"
//constant string contratti_rd = "ct_rd"
constant string contratti_rd_l = "ct_rd_l"
constant string contratti_generali_l = "ct_gen_l"
constant string sc_cf = "sc_cf" //capitolati
//constant string spedizioni = "sped"
constant string fatture_elenco = "fatture_l"
constant string fatture = "fatture"
constant string fatture_stampa = "fatt_new_st"
constant string sl_pt = "pt"
constant string artr = "artr"
constant string ricevute = "ricevute"
constant string stampa = "st1"
constant string pt_giri = "ptcicli"
constant string sv_sked_oper_g = "svsked_g"
constant string sv_sked_oper_v = "svsked_v"
constant string sv_sked_oper_log = "svsked_log"
constant string meca_aut_st_certif_farma = "meca_farma"
constant string stat_fatt = "skc"
constant string stat_produz = "stat_produz"
constant string stat_produz_no_importi = "st_prod_nimp"
constant string sped_vettori = "sped_vettori"
constant string meca_aut_st_certif_aliment = "meca_aliment"
constant string listini = "listino"
constant string listini2 = "listino2"
constant string listini_l = "listino_l"
constant string pilota_proprieta = "pilota_p"
constant string pilota_esporta_pl = "pilota_exp_p"
constant string pilota_importa_esiti = "pilota_imp_p"
constant string pilota_programmazione = "pilota_prg"
constant string profis_l = "profis_l"
constant string sr_change_pwd = "srpassword_c"
constant string sr_change_pwd_u = "srpassword"
constant string treeview_tabella = "treeview_tab"
constant string ausiliari = "au"
constant string ausiliari1 = "au1"
constant string nt_licenza = "nt_licenza"
constant string mtk = "mkt"
constant string contatti = "contatti"
constant string EXITM2000 = "exit"   //era solo EXIT

end variables

on kkg_id_programma.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kkg_id_programma.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

