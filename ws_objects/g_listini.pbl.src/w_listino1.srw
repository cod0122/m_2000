$PBExportHeader$w_listino1.srw
forward
global type w_listino1 from w_listino
end type
end forward

global type w_listino1 from w_listino
end type
global w_listino1 w_listino1

forward prototypes
protected function string check_dati_listino ()
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
	
		k_riga = tab_1.tabpage_1.dw_1.getrow()
	
	//--- controllo se rec già esistente
		k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(1, "cod_cli")
		k_cod_art = tab_1.tabpage_1.dw_1.getitemstring(1, "cod_art")
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "dose")) then 
			k_dose = 0
		else
			k_dose = tab_1.tabpage_1.dw_1.getitemnumber(1, "dose")	 
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "mis_x")) then
			k_mis_x = 0
		else
			k_mis_x = tab_1.tabpage_1.dw_1.getitemnumber(1, "mis_x")
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "mis_y")) then
			k_mis_y = 0
		else
			k_mis_y = tab_1.tabpage_1.dw_1.getitemnumber(1, "mis_y")
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "mis_z")) then
			k_mis_z = 0
		else
			k_mis_z = tab_1.tabpage_1.dw_1.getitemnumber(1, "mis_z")
		end if
		if isnull(tab_1.tabpage_1.dw_1.getitemnumber(1, "magazzino")) then
			k_magazzino = 0
		else
			k_magazzino = tab_1.tabpage_1.dw_1.getitemnumber(1, "magazzino")
		end if
	
		SELECT 
				listino.cod_cli  
			 INTO 
					:k_cod_cli1  
			FROM listino 
			WHERE cod_cli = :k_cod_cli and cod_art = :k_cod_art
					and dose = :k_dose and mis_x = :k_mis_x 
					and mis_y = :k_mis_y and mis_z = :k_mis_z
					and magazzino = :k_magazzino;
	
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
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber ( 1, "cod_cli")) = true &
				or tab_1.tabpage_1.dw_1.getitemnumber ( 1, "cod_cli") = 0 then
				k_return = "Manca Cliente " + "~n~r" 
				k_errore = "3"
			end if
			if isnull(tab_1.tabpage_1.dw_1.getitemstring ( 1, "cod_art")) = true &
				or LenA(trim(tab_1.tabpage_1.dw_1.getitemstring ( 1, "cod_art"))) = 0 then
				k_return = k_return + "Manca Articolo "  + "~n~r" 
				k_errore = "3"
			end if
		end if
	
	
	//--- controllo esistenza codice Cliente
		if ki_st_open_w.flag_modalita = "in" then
			k_cod_cli = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "cod_cli")
			if k_cod_cli > 0 then
				k_rc = tab_1.tabpage_1.dw_1.getchild("cod_cli", kdwc_cli)
				k_rc = kdwc_cli.find("id_cliente="+trim(string(k_cod_cli,"####0")),0,kdwc_cli.rowcount())
				if k_rc <= 0 or isnull(k_rc) then
					k_return = k_return + "Non Trovata: Anagrafica Cliente "  + "~n~r" 
					k_errore = "3"
				end if
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
			if k_riga_art <= 0 or isnull(k_riga_art) then
				k_return = k_return + "Non Trovato: Codice Articolo "  + "~n~r" 
				k_errore = "3"
			end if
	//--- se specificato magazzino particolare allora deve essere uguale a quello sull'articolo
			k_magazzino = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "magazzino")
			if k_riga_art > 0  then
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
	
					k_return = k_return + "Dati incongruenti: Abbinato Articolo Disattivato per Listino Attivo"  + "~n~r" 
					k_errore = "3"
				end if
			else
				k_attivo_art = ""
				k_magazzino_art = 0
			end if
				
		end if
	
	////--- controllo esistenza codice sl_pt
	//	k_sl_pt = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "cod_sl_pt")
	//	if len(trim(k_sl_pt)) > 0 then
	//		k_rc = tab_1.tabpage_1.dw_1.getchild("cod_sl_pt", kdwc_sl_pt)
	//		k_rc = kdwc_sl_pt.find("cod_sl_pt=~""+trim(k_sl_pt)+"~"",0,kdwc_sl_pt.rowcount())
	//		if k_rc <= 0 or isnull(k_rc) then
	//			k_return = k_return + "Non Trovato: Codice Piano di Trattamento SL-PT "  + "~n~r" 
	//			k_errore = "3"
	//		end if
	//	end if
	//
	
	//--- controllo esistenza codice mc-co 
		k_contratto = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "contratto")
		k_mc_co = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "mc_co")
		k_sc_cf = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "sc_cf")
		k_contratto_descr = tab_1.tabpage_1.dw_1.getitemstring(k_rc, "contratti_descr")
		k_sl_pt = tab_1.tabpage_1.dw_1.getitemstring(k_rc, "cod_sl_pt")
	
		k_rc = tab_1.tabpage_1.dw_1.getchild("contratto", kdwc_contratto)
		if k_contratto > 0 then
			k_rc = kdwc_contratto.find("codice="+string(k_contratto,"#####"),1,kdwc_contratto.rowcount())
	
			if k_rc <= 0 or isnull(k_rc) then
	
				kuf1_contratti = create kuf_contratti
				k_st_tab_contratti.codice = k_contratto
				kst_esito = kuf1_contratti.select_riga(k_st_tab_contratti)
	//			k_sqlcode = kst_esito.sqlcode
				destroy kuf1_contratti
				if kst_esito.sqlcode <> 0 then
					k_return = k_return + "Non Trovato il codice Contratto indicato"  + "~n~r" 
					k_errore = "3"
				else
					k_mc_co_1 = trim(k_st_tab_contratti.mc_co)
					k_sc_cf_1 = trim(k_st_tab_contratti.sc_cf)
					k_contratto_descr = trim(k_st_tab_contratti.descr)
					k_sl_pt = trim(k_st_tab_contratti.sl_pt)
					k_contratto_data_scad = k_st_tab_contratti.data_scad
	
				end if
			else
				k_mc_co_1 = kdwc_contratto.getitemstring(k_rc, "mc_co")
				k_sc_cf_1 = kdwc_contratto.getitemstring(k_rc, "sc_cf")
				k_contratto_descr = kdwc_contratto.getitemstring(k_rc, "descr")
				k_sl_pt = kdwc_contratto.getitemstring(k_rc, "sl_pt")
				k_contratto_data_scad = kdwc_contratto.getitemdate(k_rc, "data_scad")
	
			end if
			if k_errore = "0" then
				if ((not isnull(k_mc_co) and LenA(trim(k_mc_co)) > 0) &
					 and (trim(k_mc_co_1) <> trim(k_mc_co) &
					 or isnull(k_mc_co_1))) &
					or &
					((not isnull(k_sc_cf) and LenA(trim(k_sc_cf)) > 0) &
					 and (trim(k_sc_cf_1) <> trim(k_sc_cf) &
					 or isnull(k_sc_cf_1))) &
					then
					k_return = k_return + &
					"Indicati dati errati tra MC-CO/SC-CF e il Codice, cancellare uno dei due"  + "~n~r" 
					k_errore = "1"
				else
					k_mc_co = k_mc_co_1
					k_sc_cf = k_sc_cf_1
				end if
			end if
		else
	//--- Nessun codice specificato, per cui cerco mc_co o/e sc_cf con find
			k_rc=0
			if LenA(trim(k_mc_co)) > 0 then
				if LenA(trim(k_sc_cf)) > 0 then
					k_rc = kdwc_contratto.find("mc_co=~""+trim(k_mc_co)+ &
							 "~" and sc_cf=~""+trim(k_sc_cf)+"~"" &
							 ,0,kdwc_contratto.rowcount())
				else
					k_rc = kdwc_contratto.find("mc_co=~""+trim(k_mc_co)+ &
							 "~" and (sc_cf=~" ~" or isnull(sc_cf))"&
							 ,0,kdwc_contratto.rowcount())
				end if
	
	//--- se non trovato contratto estendo la ricerca su tutti i contratti di tutti i clienti			
				if k_rc <= 0 or isnull(k_rc) then
					k_rc = kdwc_contratto.retrieve(0,"*")
				end if
				if LenA(trim(k_sc_cf)) > 0 then
					k_rc = kdwc_contratto.find("mc_co=~""+trim(k_mc_co)+ &
							 "~" and sc_cf=~""+trim(k_sc_cf)+"~"" &
							 ,0,kdwc_contratto.rowcount())
				else
					k_rc = kdwc_contratto.find("mc_co=~""+trim(k_mc_co)+ &
							 "~" and (sc_cf=~" ~" or isnull(sc_cf))"&
							 ,0,kdwc_contratto.rowcount())
				end if
				
			else
				if LenA(trim(k_sc_cf)) > 0 then
					k_rc = kdwc_contratto.find("sc_cf=~""+trim(k_sc_cf)+"~"" &
						,0,kdwc_contratto.rowcount())
				end if
			end if
			if LenA(trim(k_mc_co)) > 0 or LenA(trim(k_sc_cf)) > 0 then
				if k_rc <= 0 or isnull(k_rc) then
					k_return = k_return + "Non Trovato Contratto con MC-CO/SC-CF indicati "  + "~n~r" 
					k_errore = "3"
				else
					k_mc_co = kdwc_contratto.getitemstring(k_rc, "mc_co")
					k_sc_cf = kdwc_contratto.getitemstring(k_rc, "sc_cf")
					k_contratto = kdwc_contratto.getitemnumber(k_rc, "codice")
					k_contratto_descr = kdwc_contratto.getitemstring(k_rc, "descr")
					k_sl_pt = kdwc_contratto.getitemstring(k_rc, "sl_pt")
					k_contratto_data_scad = kdwc_contratto.getitemdate(k_rc, "data_scad")
				end if
			else
	//--- se nessun errore setto questo meno grave
				if trim(k_errore) = "0" then
					k_return = k_return + "Nessun Contratto indicato "  + "~n~r" 
					k_errore = "5"
				end if
			end if
		end if
		tab_1.tabpage_1.dw_1.setitem(k_riga, "contratto", k_contratto)
		tab_1.tabpage_1.dw_1.setitem(k_riga, "contratti_descr", k_contratto_descr)
		tab_1.tabpage_1.dw_1.setitem(k_riga, "mc_co", k_mc_co)
		tab_1.tabpage_1.dw_1.setitem(k_riga, "sc_cf", k_sc_cf)
		tab_1.tabpage_1.dw_1.setitem(k_riga, "cod_sl_pt", k_sl_pt)
	
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
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "dose")) then 
				tab_1.tabpage_1.dw_1.setitem(k_riga, "dose", 0)
			end if
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "mis_x")) then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "mis_x", 0)
			end if
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "mis_y")) then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "mis_y", 0)
			end if
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "mis_z")) then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "mis_z", 0)
			end if
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "occup_ped")) then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "occup_ped", 0)
			end if
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "peso_kg")) then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "peso_kg", 0)
			end if
			if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "campione")) then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "campione", "N")
			end if
			if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "travaso")) then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "travaso", "N")
			end if
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "magazzino")) then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "magazzino", kiuf_listino.kki_tipo_magazzino_standard )
			end if
			if isnull(tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "contratto")) then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "contratto", 0)
			end if
			if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "attivo")) then
				tab_1.tabpage_1.dw_1.setitem(k_riga, "attivo", "S")
			end if
	//		if isnull(tab_1.tabpage_1.dw_1.getitemstring(k_riga, "cod_sl_pt")) then
	//			tab_1.tabpage_1.dw_1.setitem(k_riga, "cod_sl_pt", " ")
	//		end if
		end if
		
	
end choose


return trim(k_errore) + (k_return)


end function

event open;call super::open;//
int k_rc, k_num
long k_cod_cli
string k_rag_soc, k_record_base 
//kuf_base kuf1_base
datawindowchild  kdwc_clienti, kdwc_contratto 
datawindowchild  kdwc_clienti_cod
datawindowchild  kdwc_contratto_des, kdwc_contratto_des1  



	k_cod_cli = long(trim(ki_st_open_w.key1))

//--- Attivo dw archivio Clienti
	k_rc = tab_1.tabpage_1.dw_1.getchild("rag_soc_10", kdwc_clienti)
	k_rc = kdwc_clienti.settransobject(sqlca)
	kdwc_clienti.insertrow(1)

	k_rc = tab_1.tabpage_1.dw_1.getchild("cod_cli", kdwc_clienti_cod)
	k_rc = kdwc_clienti_cod.settransobject(sqlca)
	kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_cod, 1, Primary!)


//--- Attivo dw archivio MC-CO
	k_rc = tab_1.tabpage_1.dw_1.getchild("contratto", kdwc_contratto)
	k_rc = kdwc_contratto.settransobject(sqlca)
	k_rc = kdwc_contratto.insertrow(1)

//--- Imposto i valori della pedana sui campi testo delle dw
//	kuf1_base = create kuf_base
//	k_record_base = kuf1_base.prendi_dato_base ("mis_ped")
//	destroy kuf_base
//	if LeftA(k_record_base,1) = "0" then		
//		k_num = integer(trim(MidA(k_record_base, 2, 5)))
//		tab_1.tabpage_1.dw_1.modify("t_mis_x.text='"+string(k_num, "####0")+"'") 		
//		k_num = integer(trim(MidA(k_record_base, 7, 5)))
//		tab_1.tabpage_1.dw_1.modify("t_mis_y.text='"+string(k_num, "####0")+"'") 		
//		k_num = integer(trim(MidA(k_record_base, 12, 5)))
//		tab_1.tabpage_1.dw_1.modify("t_mis_z.text='"+string(k_num, "####0")+"'") 		
//	end if




end event

on w_listino1.create
call super::create
end on

on w_listino1.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type st_ordina_lista from w_listino`st_ordina_lista within w_listino1
end type

type st_aggiorna_lista from w_listino`st_aggiorna_lista within w_listino1
end type

type cb_ritorna from w_listino`cb_ritorna within w_listino1
end type

type st_stampa from w_listino`st_stampa within w_listino1
end type

type cb_visualizza from w_listino`cb_visualizza within w_listino1
end type

type cb_modifica from w_listino`cb_modifica within w_listino1
end type

type cb_aggiorna from w_listino`cb_aggiorna within w_listino1
end type

type cb_cancella from w_listino`cb_cancella within w_listino1
end type

type cb_inserisci from w_listino`cb_inserisci within w_listino1
end type

type tab_1 from w_listino`tab_1 within w_listino1
end type

type tabpage_1 from w_listino`tabpage_1 within tab_1
end type

type dw_1 from w_listino`dw_1 within tabpage_1
end type

type st_1_retrieve from w_listino`st_1_retrieve within tabpage_1
end type

type tabpage_2 from w_listino`tabpage_2 within tab_1
end type

type dw_2 from w_listino`dw_2 within tabpage_2
end type

type st_2_retrieve from w_listino`st_2_retrieve within tabpage_2
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

