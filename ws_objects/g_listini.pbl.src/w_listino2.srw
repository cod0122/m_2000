$PBExportHeader$w_listino2.srw
forward
global type w_listino2 from w_listino
end type
end forward

global type w_listino2 from w_listino
integer width = 1915
integer height = 608
end type
global w_listino2 w_listino2

forward prototypes
protected function string check_dati_listino ()
protected subroutine attiva_menu ()
end prototypes

protected function string check_dati_listino ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con errori non gravi
//===                : 5=OK con avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//=== Controllo dati inseriti
string k_return = " ", k_errore = "0"
int k_rc=0
long k_cod_cli1, k_cod_cli
long k_contratto, k_riga, k_riga_art
string k_sl_pt, k_cod_art, k_sqlcode, k_mc_co, k_sc_cf, k_mc_co_1, k_sc_cf_1, k_null
string k_contratto_descr
string k_attivo, k_attivo_art
int k_magazzino, k_magazzino_art
date k_contratto_data_scad
long k_mis_x, k_mis_y, k_mis_z
double k_dose
st_tab_contratti k_st_tab_contratti
st_esito kst_esito
datawindowchild  kdwc_contratto, kdwc_cli, kdwc_art, kdwc_art_des
kuf_contratti kuf1_contratti


choose case tab_1.selectedtab 
	case  1 
	
		if tab_1.tabpage_1.dw_1.rowcount() > 0 then
	
			k_riga = 1
		
		//--- controllo se rec già esistente
			k_cod_art = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_art")
		
			SELECT 
					listino.cod_cli  
				 INTO 
						:k_cod_cli1  
				FROM listino 
				WHERE cod_cli = :k_cod_cli and cod_art = :k_cod_art;
		
			if sqlca.sqlcode = 0 then
		
				if ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento then
		
					k_return = "Prezzo Listino gia' in Archivio"
					k_errore = "1"
		
				end if
			else
				
				if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.cancellazione then
			
					k_return = "Prezzo Listino non trovato in Archivio"
					k_errore = "1"
		
				end if  
		
		
			end if
		
		//-- Controllo esistenza minima dei dati
			if k_errore = "0" then
				if isnull(tab_1.tabpage_1.dw_1.getitemstring ( 1, "cod_art")) = true &
					or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring ( 1, "cod_art"))) = 0 then
					k_return = k_return + "Manca Articolo "  + "~n~r" 
					k_errore = "3"
				end if
			end if
		
		//--- controllo esistenza codice Articolo
			k_cod_art = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "cod_art")
			if LenA(trim(k_cod_art)) > 0 then
				k_rc = tab_1.tabpage_1.dw_1.getchild("cod_art", kdwc_art)
				
		//--- Se Lista a ZERO allora Attivo dw archivio Prodotto
				if kdwc_art.rowcount() <= 3 or isnull(kdwc_art.rowcount()) then
			
					k_rc = kdwc_art.settransobject(sqlca)
				
					ki_cod_art = "%"
					kdwc_art.retrieve("%")
					kdwc_art.insertrow(1)
				
					k_rc = tab_1.tabpage_1.dw_1.getchild("cod_art_des", kdwc_art_des)
				
					k_rc = kdwc_art_des.settransobject(sqlca)
				
					kdwc_art.RowsCopy(kdwc_art.GetRow(), &
							 kdwc_art.RowCount(), Primary!, kdwc_art_des, 1, Primary!)
		
				end if
				
				k_riga_art = kdwc_art.find("codice=~""+trim(k_cod_art)+"~"",0,kdwc_art.rowcount())
				if k_riga <= 0 or isnull(k_rc) then
					k_return = k_return + "Non Trovato: Codice Articolo "  + "~n~r" 
					k_errore = "3"
				end if
		//--- se specificato magazzino particolare allora deve essere uguale a quello sull'articolo
				k_magazzino = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "magazzino")
				k_magazzino_art = kdwc_art.getitemnumber(k_riga_art, "magazzino")
				if (k_magazzino = kkg_magazzino.LAVORAZIONE or k_magazzino = kkg_magazzino.NOBARCODE) and &
					(k_magazzino_art = kkg_magazzino.LAVORAZIONE or k_magazzino_art = kkg_magazzino.NOBARCODE) and &
					k_magazzino <> k_magazzino_art then
		
					k_return = k_return + "Dati incongruenti: Tipo Magazzino indicato diverso nell'Articolo "  + "~n~r" 
					k_errore = "3"
		
				end if
		//--- L'articolo deve essere attivo se il listino e' attivo!!!
				k_attivo = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "attivo")
				k_attivo_art = kdwc_art.getitemstring(k_riga_art, "attivo")
				if k_attivo_art = "N" and k_attivo = "S" then
		
					k_return = k_return + "Dati incongruenti: Abbinato Articolo 'Disattivato' per Listino 'Attivo'"  + "~n~r" 
					k_errore = "3"
		
				end if
			end if
		
			//--- se nessun errore grave setto questo meno grave
			if trim(k_errore) > "3" or trim(k_errore) = "0" then
				if k_contratto > 0 and KG_DATAOGGI > k_contratto_data_scad then
					k_return = k_return + "Il Contratto indicato è Scaduto il "  + &
								  string(k_contratto_data_scad, "dd/mm/yy") + "~n~r" 
					if trim(k_errore) = "0" then
						k_errore = "5"
					end if
				end if
			end if
		
		
		//--- se nessun errore grave:  Non tollerati i campo a NULL
			if trim(k_errore) > "3" or trim(k_errore) = "0"then
				k_riga = tab_1.tabpage_1.dw_1.getrow()
				if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "tipo")) then
					tab_1.tabpage_1.dw_1.setitem(k_riga, "tipo", kiuf_listino.kki_tipo_prezzo_a_collo)
				end if
				if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "campione")) then
					tab_1.tabpage_1.dw_1.setitem(k_riga, "campione", "N")
				end if
				if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "magazzino")) then
					tab_1.tabpage_1.dw_1.setitem(k_riga, "magazzino", kiuf_listino.kki_tipo_magazzino_nessuno )
				end if
				if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "attivo")) then
					tab_1.tabpage_1.dw_1.setitem(k_riga, "attivo", "S")
				end if
				
				
			end if
		end if			
	
end choose


return trim(k_errore) + (k_return)


end function

protected subroutine attiva_menu ();//

	ki_menu.m_strumenti.m_fin_gest_libero1.visible = false
	ki_menu.m_strumenti.m_fin_gest_libero1.enabled = false
	
	super::attiva_menu( )

end subroutine

on w_listino2.create
call super::create
end on

on w_listino2.destroy
call super::destroy
end on

type st_ritorna from w_listino`st_ritorna within w_listino2
end type

type st_ordina_lista from w_listino`st_ordina_lista within w_listino2
end type

type st_aggiorna_lista from w_listino`st_aggiorna_lista within w_listino2
end type

type cb_ritorna from w_listino`cb_ritorna within w_listino2
end type

type st_stampa from w_listino`st_stampa within w_listino2
end type

type cb_visualizza from w_listino`cb_visualizza within w_listino2
end type

type cb_modifica from w_listino`cb_modifica within w_listino2
end type

type cb_aggiorna from w_listino`cb_aggiorna within w_listino2
end type

type cb_cancella from w_listino`cb_cancella within w_listino2
end type

type cb_inserisci from w_listino`cb_inserisci within w_listino2
end type

type tab_1 from w_listino`tab_1 within w_listino2
end type

on tab_1.create
call super::create
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6,&
this.tabpage_7,&
this.tabpage_8,&
this.tabpage_9}
end on

on tab_1.destroy
call super::destroy
end on

type tabpage_1 from w_listino`tabpage_1 within tab_1
string text = "Listino 2"
end type

type dw_1 from w_listino`dw_1 within tabpage_1
string dataobject = "d_listino_no_dose"
end type

type st_1_retrieve from w_listino`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_listino`tabpage_2 within tab_1
end type

type dw_2 from w_listino`dw_2 within tabpage_2
end type

type st_2_retrieve from w_listino`st_2_retrieve within tabpage_2
end type

type dw_10 from w_listino`dw_10 within tabpage_2
end type

type tabpage_3 from w_listino`tabpage_3 within tab_1
end type

type dw_3 from w_listino`dw_3 within tabpage_3
end type

type st_3_retrieve from w_listino`st_3_retrieve within tabpage_3
end type

type tabpage_4 from w_listino`tabpage_4 within tab_1
end type

type dw_4 from w_listino`dw_4 within tabpage_4
end type

type st_4_retrieve from w_listino`st_4_retrieve within tabpage_4
end type

type ln_1 from w_listino`ln_1 within tabpage_4
end type

type tabpage_5 from w_listino`tabpage_5 within tab_1
end type

type dw_5 from w_listino`dw_5 within tabpage_5
string dataobject = "d_armo_listino_l_no_dose"
end type

type st_5_retrieve from w_listino`st_5_retrieve within tabpage_5
end type

type tabpage_6 from w_listino`tabpage_6 within tab_1
end type

type st_6_retrieve from w_listino`st_6_retrieve within tabpage_6
end type

type dw_6 from w_listino`dw_6 within tabpage_6
end type

type tabpage_7 from w_listino`tabpage_7 within tab_1
end type

type st_7_retrieve from w_listino`st_7_retrieve within tabpage_7
end type

type dw_7 from w_listino`dw_7 within tabpage_7
end type

type tabpage_8 from w_listino`tabpage_8 within tab_1
end type

type st_8_retrieve from w_listino`st_8_retrieve within tabpage_8
end type

type dw_8 from w_listino`dw_8 within tabpage_8
end type

type tabpage_9 from w_listino`tabpage_9 within tab_1
end type

type st_9_retrieve from w_listino`st_9_retrieve within tabpage_9
end type

type dw_9 from w_listino`dw_9 within tabpage_9
end type

type dw_periodo from w_listino`dw_periodo within w_listino2
end type

