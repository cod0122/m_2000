$PBExportHeader$kuf_link_zoom.sru
forward
global type kuf_link_zoom from nonvisualobject
end type
end forward

global type kuf_link_zoom from nonvisualobject
end type
global kuf_link_zoom kuf_link_zoom

forward prototypes
public function string get_link_da_button (string a_button)
public subroutine link_standard_imposta_p (readonly datawindow adw_1)
public function boolean link_standard_call_p (ref datawindow adw_link, string a_nome_link) throws uo_exception
end prototypes

public function string get_link_da_button (string a_button);//-----------------------------------------------------------------------------------------------------------------------------------------------
//---
//--- Converte il link del BUTTON in un link riconosciuto come funzione da attivare
//--- Input:   a_button    = button pigiato
//---             
//--- Output: Link riconosciuto
//---             spazio = nesuna funzione riconosciuta
//---
//-----------------------------------------------------------------------------------------------------------------------------------------------
//
string k_return = " "


if left(a_button, 6) = "p_img_" or left(a_button, 4) = "img_" then
	a_button = replace(a_button, 1, 6, "b_")
end if

choose case a_button
		
	case "b_meca", "b_id_meca"
		k_return = "id_meca"
		
	case "b_barcode_dett"		
		k_return = "barcode"

	case "b_barcode_figli"		
		k_return = "barcode_figli"
		
	case "b_barcode" 
		k_return = "b_barcode_lotto"

	case "b_armo"
		k_return = "id_armo"

	case "b_arsp" 
		k_return = "b_arsp_lotto"
		
	case "b_arfa" 
		k_return = "b_arfa_lotto"
		
	case "b_fatt"
		k_return = "num_fatt"
		
	case "b_fatt_righe"
		k_return = "b_fatt_righe"
		
	case "b_certif" 
		k_return = "b_certif_lotto"
		
	case "b_cliente" 
		k_return = "id_cliente" 
		
	case "b_clie_1" 
		k_return = "clie_1" 
	case "b_clie_2" 
		k_return = "clie_2" 
	case "b_clie_3" 
		k_return = "clie_3" 
	
	case "b_sl_pt" 
		k_return = "sl_pt"
		
	case "b_contratto" 
		k_return = "contratti_codice"

	case "b_sc_cf" 
		k_return = "sc_cf"

	case "b_art" 
		k_return = "art"

	case "b_listino" 
		k_return = "id_listino"

	case "b_utente" 
		k_return = "x_utente"
		
	case "b_ric" 
		k_return = "id_ric"

	case "b_sped" 
		k_return = "num_bolla_out"
		
	case "b_contratto_rd" 
		k_return = "id_contratto_rd"
		
	case "b_gruppo"
		k_return = "gruppo"
		
	case "b_listino_pregruppo"
		k_return = "id_listino_pregruppo"

//	case "b_qtna_note"
//		k_return = "b_qtna_note"

	case "b_id_meca_righe", "b_sl_pt_dosimpos", "b_meca_reportpilota_id_meca"  
		k_return = mid(a_button,3)

	case "b_meca_dosim_barcode"
		k_return = "meca_dosim_barcode"

	case "b_flg_dosimetro"  
		k_return = "flg_dosimetro"

	case "b_ric_lotto", "b_cap_l",  "b_nazioni_l",  "b_clie_settori",  "b_clie_classi", "b_contab", "b_cliente_mkt", "b_cliente_web", "b_armo_prezzi" & 
		, "b_arsp_sped", "b_m_r_f", "b_elenco_clienti_del_contatto", "b_wm_pklist_righe", "b_docprod", "b_listino_link_pregruppi", "b_listino_pregruppi"&
		, "b_contratti", "b_meca_causali_l", "b_art_l", "p_memo", "p_memo_link", "b_clienti","p_clienti_memo_elenco", "p_meca_memo_elenco", "p_id_memo_no" &
		, "b_arfalistaxcontr", "b_qtna_note" &
		, "b_barcode_dosim_l", "b_meca_dosim_barcode_l", "b_dosim_lotto_dosim_l"&
		, "b_asn", "b_e1doco_lav", "b_e1apid_dett", "b_certif_stampa"
		k_return = a_button
		
		
	case else
		k_return = ""
		
end choose

return k_return


end function

public subroutine link_standard_imposta_p (readonly datawindow adw_1);//
//--- link_standard_imposta
//--- Imposta nel DW i "Link Standard" ovvero il campo blu sottolinato con "manina" come cursore
//
//---
long k_num_colonne_nr, k_ctr=1
string k_num_colonne, k_nome


	k_num_colonne = adw_1.Object.DataWindow.Column.Count
	if isnumber(k_num_colonne) then
		k_num_colonne_nr = integer(k_num_colonne)
	else
		k_num_colonne_nr = 99
	end if
	do 
		
			k_nome=lower(adw_1.Describe("#" + trim(string(k_ctr,"###"))+".name"))
			choose case k_nome

//--- se LINK standard (sottolinea il campo)
				case "clie_1", "clie_2", "clie_3", "clie", "cod_cli", "id_cliente", "id_cliente_link" &
					, "id_contatto_1", "id_contatto_2", "id_contatto_3", "id_contatto_4", "id_contatto_5" &   
					 ,"barcode","barcode_lav", "cod_sl_pt", "sl_pt", "contratto", "sc_cf" &
					 ,"barcode_figli" &
					 ,"art", "cod_art" &
					 ,"id_listino", "id_listino_voce" &
					 ,"id_meca", "meca_id" &
					 ,"id_armo" &
					 ,"x_utente"  &
					, "x_utente_cert_alim" &
					, "x_utente_cert_farm" &
					, "x_utente_cert_f_st" &
					, "id_ric" &
					, "num_bolla_out" &
					, "num_bolla_out_1" &
					, "id_sped" &
					, "email", "email1", "email2", "sito_web", "sito_web1" &
					, "id_contratto_rd" &
					, "id_contratto_co" &
					, "id_wm_pklist" &
					, "id_wm_pklist_padre" &
					, "idpkl" &
					, "esito_operazioni_ts_operazione"  &
					, "gruppo" &
					, "id_clie_settore" &
					, "gru" &
					, "num_certif"  &
					, "id_docprod"  &
					, "id_armo_prezzo" & 
					, "id_listino_pregruppo" &
					, "listino_id_parent" &
					, "id_memo" & 
					, "e1doco" & 
					, "e1rorn" &
					, "packinglistcode"

//					, "id_meca_righe" &
					
//--- se e' del tipo grid o tabular link sul valore alrimenti sul testo		
					if adw_1.Object.DataWindow.Type <> "Form" then
						
//						adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
						adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".Color = '" + string(kkg_colore.blu)+"' ")
						adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".pointer = 'HyperLink!' " )
					else
//--- ..... alrimenti sul testo		
//						adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
						adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
									  ".Color = '" + string(kkg_colore.blu)+"' ")
						adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
									  ".pointer = 'HyperLink!' " )
					  end if

				
//				case "barcode", "cod_sl_pt", "sl_pt", "contratto", "sc_cf"
//					
////--- se e' del tipo grid o tabular link sul valore alrimenti sul testo		
//					if adw_1.Object.DataWindow.Type <> "Form" then
//						
//						adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
//						adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".Color = '" + string(kkg_colore.blu)+"' ")
//						adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".pointer = 'HyperLink!' " )
//					else
////--- ..... alrimenti sul testo		
//						adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
//						adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".Color = '" + string(kkg_colore.blu)+"' ")
//						adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".pointer = 'HyperLink!' " )
//					  end if
//	      	k_lista = tab_1.tabpage_9.dw_9.Object.DataWindow.Processing se "1"=GRID

				
				case  "mc_co",  "contratti_codice"
					
					if adw_1.Object.DataWindow.Type <> "Form" then
						if trim(adw_1.Describe("contratti_codice.x")) <> "!" then 
//							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kkg_colore.blu)+"' ")
							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					else
						if trim(adw_1.Describe("contratti_codice_t.x")) <> "!" then 
//							adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							adw_1.Modify(k_nome+ "_t" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kkg_colore.blu)+"' ")
							adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					end if

				
//				case "barcode_figli"
//					
////--- se e' del tipo grid o tabular link sul valore alrimenti sul testo		
//					if adw_1.Object.DataWindow.Type <> "Form" then
//						
//						adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
//						adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".Color = '" + string(kkg_colore.blu)+"' ")
//						adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//									  ".pointer = 'HyperLink!' " )
//					else
////--- ..... alrimenti sul testo		
//						adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".Font.Underline = 1")
//						adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".Color = '" + string(kkg_colore.blu)+"' ")
//						adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//									  ".pointer = 'HyperLink!' " )
//					  end if
//								  
								  
				case "num_int"
//--- per farlo diventare un link ho bisogno anche del campo "id_meca"

					if adw_1.Object.DataWindow.Type <> "Form" then
						if trim(adw_1.Describe("id_meca.x")) <> "!" then 
//							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kkg_colore.blu)+"' ")
							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					else
						if trim(adw_1.Describe("num_int_t.x")) <> "!" then 
//							adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							adw_1.Modify(k_nome+ "_t" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kkg_colore.blu)+"' ")
							adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					end if
					
				case "num_fatt"  //, "data_fatt" 
					if adw_1.Object.DataWindow.Type <> "Form" then
						if trim(adw_1.Describe("num_fatt.x"))  <> "!" then 
//							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kkg_colore.blu)+"' ")
							adw_1.Modify("#" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					else
						if trim(adw_1.Describe("num_fatt.x"))  <> "!" then 
//							adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
//										  ".Font.Underline = 1")
							adw_1.Modify(k_nome+ "_t" + trim(string(k_ctr,"###"))+&
										  ".Color = '" + string(kkg_colore.blu)+"' ")
							adw_1.Modify(k_nome + "_t" + trim(string(k_ctr,"###"))+&
										  ".pointer = 'HyperLink!' " )
						end if
					end if
					

				
			end choose

		k_ctr = k_ctr + 1 

	loop while k_ctr <= k_num_colonne_nr 
end subroutine

public function boolean link_standard_call_p (ref datawindow adw_link, string a_nome_link) throws uo_exception;//
//--- Chiama le window con funzione standard di consultazione
//--- Input:   	adw_link   		= data_window su cui ho fatto click e quindi dalla quale prelevare i dati ad esmpio il 'ID' del record 
//---				a_nome_link  	= tipo di funzione standard da chiamare
//---             
//--- Output: boolean TRUE = ok e' entrato in funzione; FALSE=non ha fatto niente
//
boolean k_return=true
//st_esito kst_esito
//st_tab_meca kst_tab_meca
//st_tab_barcode kst_tab_barcode
//st_tab_certif kst_tab_certif
//st_tab_arfa kst_tab_arfa
//st_tab_sl_pt kst_tab_sl_pt
//st_tab_armo kst_tab_armo
//st_tab_clienti kst_tab_clienti
//st_tab_contratti kst_tab_contratti
//st_tab_prodotti kst_tab_prodotti
//st_tab_listino kst_tab_listino
//st_tab_listino_pregruppo kst_tab_listino_pregruppo
//st_tab_listino_link_pregruppi kst_tab_listino_link_pregruppi
//st_tab_sr_utenti kst_tab_sr_utenti
//st_tab_ricevute kst_tab_ricevute
//st_tab_prof kst_tab_prof
//kuf_armo_tree kuf1_armo_tree

//kuf_barcode_tree kuf1_barcode_tree
//kuf_sped kuf1_sped
//kuf_fatt kuf1_fatt
//kuf_certif kuf1_certif
//kuf_clienti kuf1_clienti
////kuf_sl_pt kuf1_sl_pt
//kuf_contratti kuf1_contratti 
//kuf_contratti_rd kuf1_contratti_rd 
//kuf_prodotti kuf1_prodotti 
//kuf_listino kuf1_listino
//kuf_listino_pregruppo kuf1_listino_pregruppo
//kuf_listino_link_pregruppi kuf1_listino_link_pregruppi
//kuf_sr_sicurezza kuf1_sr_sicurezza
//kuf_ricevute kuf1_ricevute
//kuf_prof kuf1_prof
////kuf_ausiliari kuf1_ausiliari
////kuf_wm_pklist kuf1_wm_pklist
//kuf_contratti_co kuf1_contratti_co
////kuf_esito_operazioni kuf1_esito_operazioni
//kuf_docprod kuf1_docprod
kuf_parent kuf1_parent
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)

st_open_w kst_open_w 
datastore kdsi_elenco_output   //ds da passare alla windows di elenco


if NOT isvalid(kdsi_elenco_output) then kdsi_elenco_output = create datastore //destroy kdsi_elenco_output


choose case a_nome_link
		
	case "barcode", "barcode_t", "barcode_lav" &
		,"barcode_figli", "barcode_figli_t" &
		,"b_barcode_lotto" &
		,"grp"
		kuf1_parent = create using "kuf_barcode_tree"
		
	case "num_int", "num_int_t", "id_meca", "b_armo", "id_armo", "id_meca_righe", "b_armo_prezzi", "id_armo_prezzo", "p_meca_memo_elenco" &
			, "b_armo_prezzi_xstato", "meca_id"
		kuf1_parent = create using "kuf_armo_tree"

	case "b_qtna_note"
		kuf1_parent = create using "kuf_meca_qtna"
		
	case "b_arfa_lotto", "num_fatt", "b_fatt_righe", "b_arfalistaxcontr"
		kuf1_parent = create using "kuf_fatt"

	case "b_arsp_lotto", "b_arsp_sped", "num_bolla_out", "num_bolla_out_1", "arsp_insped", "id_sped"
		kuf1_parent = create using "kuf_sped"
		
	case "clie_1", "clie_2", "clie_3", "clie", "cod_cli", "id_cliente", "id_cliente_link", "b_cliente_mkt", "b_cliente_web", "b_m_r_f", "id_contatto_1", "id_contatto_2", "id_contatto_3", "id_contatto_4", "id_contatto_5", "b_elenco_clienti_del_contatto" &    
			,"email", "email1", "email2",  "sito_web", "sito_web1", "b_clienti",  "p_clienti_memo_elenco"
		kuf1_parent = create using "kuf_clienti"
		
	case "id_contratto_rd" 
		kuf1_parent = create using "kuf_contratti_rd"
		
	case "id_contratto_co" 
		kuf1_parent = create using "kuf_contratti_co"
		
	case "num_certif"  &
			,"b_certif_lotto" &
			,"b_certif_stampa"
		kuf1_parent = create using "kuf_certif"
		
	case "cod_sl_pt", "sl_pt", "sl_pt_dosimpos"
		kuf1_parent = create using "kuf_sl_pt"

	case "id_listino", "id_listino_voce" &
			,"id_listino_voce_1", "id_listino_voce_2", "id_listino_voce_3" &
			,"id_listino_voce_4", "id_listino_voce_5", "id_listino_voce_6" &
			,"id_listino_voce_7", "id_listino_voce_8", "id_listino_voce_9", "id_listino_voce_10" &
			,"listino_id_parent"
		kuf1_parent = create using "kuf_listino"

	case "b_listino_link_pregruppi" 
		kuf1_parent = create using "kuf_listino_link_pregruppi"

	case "b_listino_pregruppi", "id_listino_pregruppo" 
		kuf1_parent = create using "kuf_listino_pregruppo"

	case "contratto", "mc_co", "contratti_codice",  "sc_cf", "cf", "b_contratti"
		kuf1_parent = create using "kuf_contratti"

	case "art", "cod_art", "b_art_l"
		kuf1_parent = create using "kuf_prodotti"

	case "x_utente" &
		, "x_utente_cert_alim" &
		, "x_utente_cert_farm" &
		, "x_utente_cert_f_st"
		kuf1_parent = create using "kuf_sr_sicurezza"

	case "id_ric", "b_ric_lotto" 
		kuf1_parent = create using "kuf_ricevute"
		
	case "b_contab" 
		kuf1_parent = create using "kuf_prof"

	case "id_wm_pklist", "b_wm_pklist_righe", "id_wm_pklist_riga", "id_wm_pklist_padre", "idpkl"
		kuf1_parent = create using "kuf_wm_pklist"

	case "esito_operazioni_ts_operazione" 
		kuf1_parent = create using "kuf_esito_operazioni"

	case "id_docprod", "b_docprod", "id_docprod_file" 
		kuf1_parent = create using "kuf_docprod"

	case "p_memo", "id_memo", "p_id_memo_no", "p_id_memo", "p_memo_x"
		kuf1_parent = create using "kuf_memo"
		
	case "p_memo_link", "id_memo_link"
		kuf1_parent = create using "kuf_memo_link"
		
	case "b_barcode_dosim_l", "b_meca_dosim_barcode_l", "meca_dosim_barcode" &
			, "b_meca_dosim_barcode", "flg_dosimetro" 
		kuf1_parent = create using "kuf_meca_dosim"

	case "b_cap_l", "b_clie_settori", "b_clie_classi", "b_nazioni_l", "gruppo", "id_clie_settore" &
			,"b_meca_causali_l", "b_dosim_lotto_dosim_l" 
		kuf1_parent = create using "kuf_ausiliari"

	case "b_asn", "e1doco", "e1rorn", "b_e1doco_lav", "b_e1apid_dett"
		kuf1_parent = create using "kuf_e1"
		
	case "packinglistcode"
		kuf1_parent = create using "kuf_wm_receiptgammarad"
		
	case "meca_reportpilota_id_meca"
		kuf1_parent = create using "kuf_meca_reportpilota"
		
	case else
		k_return = false
		
end choose

if k_return then
	k_return = kuf1_parent.link_call( adw_link, a_nome_link )
end if
	
SetPointer(kp_oldpointer)

	
return k_return


end function

on kuf_link_zoom.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_link_zoom.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

