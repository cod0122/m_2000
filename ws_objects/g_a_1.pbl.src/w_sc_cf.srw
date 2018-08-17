$PBExportHeader$w_sc_cf.srw
forward
global type w_sc_cf from w_g_tab0
end type
type dw_dis_attiva from uo_d_std_1 within w_sc_cf
end type
end forward

global type w_sc_cf from w_g_tab0
integer width = 2994
integer height = 1984
string title = "Capitolati di Fornitura (CF)"
boolean maxbox = false
windowanimationstyle openanimation = topslide!
boolean ki_toolbar_window_presente = true
dw_dis_attiva dw_dis_attiva
end type
global w_sc_cf w_sc_cf

type variables
//
private string ki_mostra_nascondi_in_lista = "S"
private st_tab_contratti ki_st_tab_contratti_arg

end variables

forward prototypes
public function string inizializza ()
private function string check_dati ()
private function string cancella ()
private function integer check_rek (string k_mc_co)
protected function integer visualizza ()
protected subroutine attiva_menu ()
public subroutine mostra_nascondi_in_lista ()
protected subroutine smista_funz (string k_par_in)
protected function integer inserisci ()
private function integer modifica ()
protected subroutine open_start_window ()
protected subroutine set_titolo_window_personalizza ()
public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti)
private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti)
public function long u_retrieve_dw ()
end prototypes

public function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
//string k_key
long k_riga
int k_importa = 0
pointer oldpointer  // Declares a pointer variable



//	if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.inserimento then 
//		
//		cb_inserisci.postevent(clicked!)
//		
//	else

//=== Legge le righe del dw salvate l'ultima volta (importfile)
		if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima 
	
			k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)
	
		end if
			
		
		if k_importa <= 0 then // Nessuna importazione eseguita
	
			if u_retrieve_dw() < 1 then
				
				k_return = "1Non trovati Capitolati di Fornitura "
	
				SetPointer(oldpointer)
				messagebox("Lista 'Capitolati' Vuota", &
						"Nesun Codice Trovato per la richiesta fatta")
			else
				
				if ki_st_open_w.flag_primo_giro = "S" then 
					k_riga = 1
//--- se ho passato anche il codice contratto allora....
					if len(trim(ki_st_tab_contratti_arg.sc_cf)) > 0 then
						k_riga = dw_lista_0.find( "codice = '" + string(ki_st_tab_contratti_arg.sc_cf) + "' ", 1, dw_lista_0.rowcount( ) )
					end if
					if k_riga > 0 then 
						dw_lista_0.selectrow( 0, false)
						dw_lista_0.scrolltorow( k_riga)
						dw_lista_0.setrow( k_riga)
						dw_lista_0.selectrow( k_riga, true)
					end if
					
//--- se entro per modificare allora....
					if ki_st_open_w.flag_modalita = KKG_FLAG_RICHIESTA.modifica then 
						cb_modifica.postevent(clicked!)
					end if
				end if
	
			end if		
		end if
	
return k_return



end function

private function string check_dati ();//
//=== Controllo dati inseriti
string k_return = ""
string k_errore = "0"
int k_rc=0
long k_riga, k_find_riga
string k_key, k_rag_soc_10
string k_descr, k_sc_cf=""
datawindowchild kdwc_clienti_d



	k_riga = 1
		

	k_key = dw_dett_0.getitemstring ( k_riga, "codice") 
	if isnull(k_key) or LenA(trim(k_key)) = 0 then
		k_return = k_return + "Manca il Codice SC-CF " + "~n~r"
		k_errore = "3"
//	end if

//--- Attivo dw archivio Clienti e imposto il codice su dw per aggiornamento
//   if trim(k_errore) = "0" then
		k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_d)
		k_rc = kdwc_clienti_d.settransobject(sqlca)
		k_rag_soc_10=dw_dett_0.getitemstring(k_riga, "rag_soc_10")
		if not isnull(k_rag_soc_10) then
			
			if kdwc_clienti_d.rowcount() < 2 then
				kdwc_clienti_d.retrieve("%")
				kdwc_clienti_d.insertrow(1)
			end if
	
			k_find_riga=kdwc_clienti_d.find("rag_soc_1=~""+trim(k_rag_soc_10)+"~"",&
													  0, kdwc_clienti_d.rowcount())
			if k_find_riga > 0 then
				dw_dett_0.setitem(k_riga, "cod_cli", &
										kdwc_clienti_d.getitemnumber(k_find_riga, "id_cliente"))
			else
				dw_dett_0.setitem(k_riga, "cod_cli", 0)
			end if
		else
			dw_dett_0.setitem(k_riga, "cod_cli", 0)
		end if
	
		if isnull(dw_dett_0.getitemstring ( k_riga, "descr")) = true then
				k_return = k_return + "Manca la Descrizione " + "~n~r" 
				k_errore = "3"
		end if
	end if

//--- codice sl-pt obbligatorio
	if isnull(dw_dett_0.getitemstring ( k_riga, "sl_pt")) &
	   or LenA(trim(dw_dett_0.getitemstring ( k_riga, "sl_pt"))) = 0 then
		k_return = k_return + "Manca il dato '" + &
		             trim(dw_dett_0.object.sl_pt_t.text) + "'~n~r" 
		k_errore = "3"
	end if

	
//--- errori diversi
   if trim(k_errore) = "0" then
		
			
		if date(dw_dett_0.getitemdate(dw_dett_0.getrow(), "data")) > &
		   date(dw_dett_0.getitemdate(dw_dett_0.getrow(), "data_scad")) then
		
				k_return = k_return + "data Decorrenza maggiore " &
				           + "della data di Scadenza"  + "~n~r" 
				k_errore = "1"

		end if


//--- c'e' gia' il sc-cf?
      if ki_st_open_w.flag_modalita = "in" then
			
			k_sc_cf = trim(dw_dett_0.getitemstring(1, "codice"))  

			SELECT 
				   sc_cf.descr
			 INTO 
					:k_descr
			FROM sc_cf 
			WHERE codice = :k_sc_cf ;

			if sqlca.sqlcode = 0 then 
				
				if LenA(trim(k_descr)) = 0 then 
					k_sc_cf = "nessuna descrizione "
				end if
		
				k_return = k_return + "SC-CF " + trim(k_sc_cf) + &
				           " già in Archivio con descrizione:~n~r" + &
							  trim(k_descr) 
				k_errore = "1"
		
			end if		
		end if
	end if

	
	if trim(k_errore) = "0" then
		if isnull(dw_dett_0.getitemnumber(dw_dett_0.getrow(), "cod_cli")) & 
		   or dw_dett_0.getitemnumber(dw_dett_0.getrow(), "cod_cli") = 0 then 
			k_return = k_return + "Manca Cliente " + "~n~r" 
			k_errore = "5"
		end if
	end if


//--- se nessun errore grave
	if trim(k_errore) > "3" or trim(k_errore) = "0"then

		k_riga = dw_dett_0.getrow()

//--- Non tollerati i campo a NULL
		if isnull(dw_dett_0.getitemstring(k_riga, "attivo")) then
			k_rc=dw_dett_0.setitem(k_riga, "attivo", "S")
		end if
		if isnull(dw_dett_0.getitemdate(k_riga, "data")) then 
			k_rc=dw_dett_0.setitem(k_riga, "data", kguo_g.get_dataoggi())
		end if

//--- imposto i dati di default
		dw_dett_0.setitem(k_riga, "x_datins", kGuf_data_base.prendi_x_datins())
		dw_dett_0.setitem(k_riga, "x_utente", kGuf_data_base.prendi_x_utente())

	end if
	

return trim(k_errore) + trim(k_return)


end function

private function string cancella ();//
string k_return="0 "
string k_descr
string k_codice
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
kuf_contratti  kuf1_contratti


//=== Controllo se sul dettaglio c'e' qualche cosa
k_riga = dw_dett_0.rowcount()	
if k_riga > 0 then
	k_codice = trim(dw_dett_0.getitemstring(1, "codice"))
	k_descr = trim(dw_dett_0.getitemstring(1, "descr"))
end if
//=== Se sul dw non c'e' nessuna riga o nessun codice allora pesco dalla lista
if k_riga <= 0 or isnull(k_codice) then
	k_riga = dw_lista_0.getrow()	
	if k_riga > 0 then
		k_codice = trim(dw_lista_0.getitemstring(k_riga, "codice"))
		k_descr = trim(dw_lista_0.getitemstring(k_riga, "descr"))
	end if
end if

if isnull(k_codice) then
	k_codice = ". "
end if
if isnull(k_descr) = true or trim(k_descr) = "" then
	k_descr = "Capitolato senza descrizione" 
end if

if k_riga > 0 and isnull(k_codice) = false then	
	
//=== Richiesta di conferma della eliminazione del rek

	if messagebox("Elimina Capitolato SC-CF", "Sei sicuro di voler Cancellare : ~n~r" &
	             + trim(k_codice) + " " + trim(k_descr), &
				question!, yesno!, 2) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_contratti = create kuf_contratti
		
//=== Cancella la riga dal data windows di lista
		k_errore = kuf1_contratti.tb_delete_sc_cf(k_codice) 
		if LeftA(k_errore, 1) = "0" then

			k_errore = kGuf_data_base.db_commit()
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante la Cancellazione", &
						"Controllare i dati. " + MidA(k_errore, 2))

			else

//--- cancello riga a video
				k_codice = " "
				k_riga = dw_dett_0.rowcount()	
				if k_riga > 0 then
					k_codice = trim(dw_dett_0.getitemstring(1, "codice"))
					dw_dett_0.deleterow(k_riga)
				end if
				if k_riga <= 0 or isnull(k_codice) then
					k_riga = dw_lista_0.getrow()	
					if k_riga > 0 then
						dw_lista_0.deleterow(k_riga)
					end if
				end if

			end if

			dw_dett_0.setfocus()

		else
			k_errore1 = k_errore
			k_errore = kGuf_data_base.db_rollback()

			messagebox("Problemi durante la Cancellazione - Operazione fallita !!", &
							MidA(k_errore1, 2) ) 	
			if LeftA(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + MidA(k_errore, 2))
			end if

			attiva_tasti()
	

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_contratti

	else
		messagebox("Elimina Contratto", "Operazione Annullata !!")
	end if

	dw_dett_0.setcolumn(1)

end if

return(k_return)
//

end function

private function integer check_rek (string k_mc_co);//
int k_return = 0
int k_anno
string k_descr, k_sc_cf = ""


	k_sc_cf = dw_dett_0.getitemstring(1, "codice")  

	SELECT
         sc_cf.descr
   	 INTO
      	   :k_descr
    	FROM sc_cf  
   	WHERE codice = :k_sc_cf ;

	if sqlca.sqlcode = 0 then 
		
		if LenA(trim(k_descr)) = 0 then 
			k_sc_cf = "non presente "
		end if
		
		if messagebox("Capitolato gia' in Archivio", & 
					"Trovato Capitolato " + trim(k_sc_cf) + " " + & 
					"con questa descrizione:  ~n~r" + trim(k_descr), &
				   StopSign!) = 2 then
		

			dw_dett_0.reset()
//			inizializza()
		
			k_return = 1
		end if
	end if  

//	attiva_tasti()



return k_return


end function

protected function integer visualizza ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc, k_taborder
string k_key
datawindowchild kdwc_clienti_d
kuf_utility kuf1_utility


	k_key = trim(dw_lista_0.getitemstring(dw_lista_0.getrow(), "codice"))
	
	ki_st_open_w.flag_modalita = "vi" 

	k_return = dw_dett_0.retrieve( k_key ) 


//--- protezione campi per impedire la modifica
	kuf1_utility = create kuf_utility
	kuf1_utility.u_proteggi_dw("1", 0, dw_dett_0)
	destroy kuf1_utility

	attiva_tasti()

return k_return

end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu



//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if ki_menu.m_strumenti.m_fin_gest_libero1.enabled <> cb_modifica.enabled then
		
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Attiva/Disattiva Capitolati alla data"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp = &
		"Attiva / Disattiva i Capitolati compresi nel periodo indicato"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = cb_modifica.enabled
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Attiva,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Application5!"
//		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
	end if
//

	if not ki_menu.m_strumenti.m_fin_gest_libero2.visible then
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Mostra/Nascondi Capitolati Attivi"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp = &
		"Mostra o Nasconde le righe dei Capitolati Attivi/Non Attivi"
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Mostra,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "DeleteRow!"
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	end if	

//---
	super::attiva_menu()


end subroutine

public subroutine mostra_nascondi_in_lista ();//
string k_dataoggi
kuf_base kuf1_base

	
	dw_lista_0.setredraw(false)
	
//
//--- piglia la data oggi
//	kuf1_base = create kuf_base
//	k_dataoggi = kuf1_base.prendi_dato_base("dataoggi") 
//	if left(k_dataoggi, 1) = "0" then
//		k_dataoggi = string(date(mid(k_dataoggi, 2)), "dd.mm.yyyy")
//	else
//		k_dataoggi = string(today())
//	end if
//	destroy kuf1_base
					
//
	if ki_mostra_nascondi_in_lista = "S" then	
		ki_mostra_nascondi_in_lista = "N"
		if u_retrieve_dw() > 0 then 
			dw_lista_0.u_filtra_record("attivo = 'N'") 
		end if
	else
		if ki_mostra_nascondi_in_lista = "N" then	
			ki_mostra_nascondi_in_lista = "*"
			if u_retrieve_dw() > 0 then 
				dw_lista_0.u_filtra_record("") 
			end if
		else
			ki_mostra_nascondi_in_lista = "S"
			dw_lista_0.u_filtra_record("attivo = 'S' or IsNull(attivo) ") 
			//leggi_liste()
		end if
	end if

attiva_tasti()


dw_lista_0.setredraw( true)

end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

choose case LeftA(k_par_in, 2) 


	case KKG_FLAG_RICHIESTA.libero1		//Aggiorna flag di Dis/attivazione
		if dw_dis_attiva.rowcount() = 0 then
			dw_dis_attiva.insertrow(0)
		end if
		dw_dis_attiva.enabled=true
		dw_dis_attiva.visible=true
		dw_dis_attiva.setfocus()

	case KKG_FLAG_RICHIESTA.libero2		//Mostra/Nascondi righe
		mostra_nascondi_in_lista()

	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

protected function integer inserisci ();//
int k_rc, k_ctr, k_taborder
string k_rc1, k_style
long k_riga
st_tab_clienti kst_tab_clienti
kuf_clienti kuf1_clienti
st_esito kst_esito
datawindowchild kdwc_clienti_d



	dw_dett_0.reset()

	ki_st_open_w.flag_modalita = kkg_flag_modalita.inserimento 
	
//=== Aggiunge una riga al data windows
	dw_dett_0.scrolltorow(dw_dett_0.insertrow(dw_dett_0.getrow() + 1))
	dw_dett_0.setcolumn(1)
	
//--- imposta il cliente se impostato tra gli Argomenti iniziali
	if ki_st_tab_contratti_arg.cod_cli > 0 then
		dw_dett_0.setitem(1, "cod_cli", ki_st_tab_contratti_arg.cod_cli)
		k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_d)
		if kdwc_clienti_d.rowcount( ) > 1 then
			k_riga = kdwc_clienti_d.find("id_cliente = " + string(ki_st_tab_contratti_arg.cod_cli), 1, dw_dett_0.rowcount( ) )
			if k_riga > 0 then
				 dw_dett_0.setitem(1, "rag_soc_10", kdwc_clienti_d.getitemstring( k_riga, "rag_soc_1") )
			end if
		else
			kuf1_clienti = create kuf_clienti
			kst_tab_clienti.codice = ki_st_tab_contratti_arg.cod_cli
			kst_esito = kuf1_clienti.get_nome( kst_tab_clienti )
			if kst_esito.esito = kkg_esito.ok then
		 		dw_dett_0.setitem(1, "rag_soc_10", kst_tab_clienti.rag_soc_10 )
			end if
			destroy kuf1_clienti
		end if 
	end if

	
	dw_dett_0.setitem(dw_dett_0.getrow(), "attivo", "S")
	dw_dett_0.setitem(dw_dett_0.getrow(), "data", kguo_g.get_dataoggi( ) )
	dw_dett_0.setitem(dw_dett_0.getrow(), "data_scad", date(string(kguo_g.get_anno( )) + "-12-31"))

//--- S-protezione campi per riabilitare la modifica a parte la chiave
	k_rc1 = ""
	k_ctr=0
	do while k_rc1 = ""
		k_ctr = k_ctr + 1 

		k_rc1=dw_dett_0.Modify("#" + trim(string(k_ctr,"###"))+".Protect='0'")
		if k_rc1 = "" then

			k_taborder=integer(dw_dett_0.Describe("#" + trim(string(k_ctr,"###"))+".TabSequence"))
			if k_taborder > 0 then
				k_style=dw_dett_0.Describe("#" + trim(string(k_ctr,"###"))+".Edit.Style")
//				if upper(k_style) <> "DDDW" and upper(k_style) <> "CHECKBOX" then
					
					k_rc1=string(rgb(255,255,255))
					dw_dett_0.Modify("#" + trim(string(k_ctr,"###"))+&
									  ".Background.Color='"+k_rc1+"'")
					k_rc1=""
//				end if
			end if
		end if
	loop 


	attiva_tasti()

//=== Posiziona il cursore sul Data Windows
	dw_dett_0.ResetUpdate ( ) 
	dw_dett_0.setfocus() 


return (0)


end function

private function integer modifica ();//===
//=== Lettura del rek da modificare
//=== Routine STANDARD ma event. modificabile
//=== Torna : <=0=Ko, >0=Ok
int k_return, k_rc,  k_ctr, k_taborder
string k_style, k_rc1
string k_key
datawindowchild kdwc_clienti_d
kuf_utility kuf1_utility


	k_key = trim(dw_lista_0.getitemstring(dw_lista_0.getrow(), "codice"))
	
	ki_st_open_w.flag_modalita = kkg_flag_modalita.modifica 

	k_return = dw_dett_0.retrieve( k_key ) 


//--- S-protezione campi per riabilitare la modifica a parte la chiave
	kuf1_utility = create kuf_utility
   kuf1_utility.u_proteggi_dw("0", 0, dw_dett_0)

//--- Inabilita campo cliente per la modifica se Funzione MODIFICA
	if trim(ki_st_open_w.flag_modalita) = kkg_flag_modalita.modifica then
		kuf1_utility.u_proteggi_dw("1", 1, dw_dett_0)
	end if

//--- disabilita la modifica sul codice
//	k_rc1=dw_dett_0.Modify("codice.Protect='1'")
//	k_rc1=string(rgb(192,192,192))
//	dw_dett_0.Modify("codice.Background.Color='"+k_rc1+"'")
//	

	attiva_tasti()

	dw_dett_0.SetColumn(2)


return k_return

end function

protected subroutine open_start_window ();//---
int k_rc
datawindowchild  kdwc_clienti, kdwc_clienti_des, kdwc_sl_pt_d 


	ki_toolbar_window_presente=true

//--- Salva Argomenti programma chiamante
	if Len(trim(ki_st_open_w.key1)) = 0 then // CODICE CLIENTE
		ki_st_tab_contratti_arg.cod_cli = 0
	else
		ki_st_tab_contratti_arg.cod_cli = long(trim(ki_st_open_w.key1))
	end if
//	if trim(ki_st_open_w.key2) > " " then  // MOSTRA CONTRATTI S=IN VIGORE; N=SCADUTI; *=TUTTI  
//		ki_mostra_nascondi_in_lista  = trim(trim(ki_st_open_w.key2))
//	else
		ki_mostra_nascondi_in_lista = "*"
//	end if
	if Len(trim(ki_st_open_w.key3)) = 0 or isnull(trim(ki_st_open_w.key3)) then  // CODICE CONTRATTO 
		ki_st_tab_contratti_arg.sc_cf = ""
	else
		ki_st_tab_contratti_arg.sc_cf  = trim(trim(ki_st_open_w.key3))
	end if


//--- Attivo dw archivio Clienti
//	k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_d)
//	k_rc = kdwc_clienti_d.settransobject(sqlca)
//	if kdwc_clienti_d.rowcount() = 0 then
//		kdwc_clienti_d.insertrow(1)
//	end if
//--- Attivo dw archivio Clienti
	k_rc = dw_dett_0.getchild("cod_cli", kdwc_clienti)
	k_rc = kdwc_clienti.settransobject(sqlca)
	k_rc = kdwc_clienti.insertrow(1)

	k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_des)
	k_rc = kdwc_clienti_des.settransobject(sqlca)
	k_rc = kdwc_clienti_des.insertrow(1)

//	if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then
		if kdwc_clienti.rowcount() < 2 then
			kdwc_clienti.retrieve("%")
			kdwc_clienti.RowsCopy(kdwc_clienti.GetRow(), kdwc_clienti.RowCount(), Primary!, kdwc_clienti_des, 1, Primary!)
			kdwc_clienti.setsort( "id_cliente A")
			kdwc_clienti.sort( )
			k_rc = kdwc_clienti.insertrow(1)
			k_rc = kdwc_clienti_des.insertrow(1)
		end if
//	end if


//--- Attivo dw archivio SL-PT
	k_rc = dw_dett_0.getchild("sl_pt", kdwc_sl_pt_d)
	k_rc = kdwc_sl_pt_d.settransobject(sqlca)
	if kdwc_sl_pt_d.rowcount() = 0 then
		kdwc_sl_pt_d.insertrow(1)
	end if


end subroutine

protected subroutine set_titolo_window_personalizza ();

super::set_titolo_window_personalizza()

choose case ki_mostra_nascondi_in_lista
   case 'S'  // solo in vigore
      this.title += " - Capitolati in vigore "
   case 'N'  // solo Scaduti
      this.title += " - Capitolati scaduti "
   case else //faccio vedere tutto
      this.title += " - Tutti i Capitolati "
end choose



end subroutine

public function boolean get_dati_cliente (ref st_tab_clienti kst_tab_clienti);//
boolean k_return = false
st_esito kst_esito
kuf_clienti kuf1_clienti


try
	
	kuf1_clienti = create kuf_clienti

	k_return = kuf1_clienti.leggi (kst_tab_clienti)

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	

finally
	destroy kuf1_clienti
	
end try

return k_return


end function

private subroutine put_video_cliente (st_tab_clienti kst_tab_clienti);//
//--- Visualizza dati Cliente 
//
long k_riga=1

dw_dett_0.modify( "id_cliente.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
dw_dett_0.modify( "clienti_rag_soc_10.Background.Color = '" + string(kkg_colore.BIANCO) + "' " ) 
dw_dett_0.setitem(k_riga, "rag_soc_10", kst_tab_clienti.rag_soc_10)
dw_dett_0.setitem(k_riga, "cod_cli", kst_tab_clienti.codice)

end subroutine

public function long u_retrieve_dw ();//
//--- retrieve principale
//
long k_return


//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa )


	k_return = dw_lista_0.retrieve(ki_st_tab_contratti_arg.cod_cli, ki_mostra_nascondi_in_lista ) 
			
	
	SetPointer(kkg.pointer_default)
	
return k_return



end function

on w_sc_cf.create
int iCurrent
call super::create
this.dw_dis_attiva=create dw_dis_attiva
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_dis_attiva
end on

on w_sc_cf.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_dis_attiva)
end on

type st_ritorna from w_g_tab0`st_ritorna within w_sc_cf
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_sc_cf
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_sc_cf
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_sc_cf
integer x = 2350
integer y = 1348
end type

type st_stampa from w_g_tab0`st_stampa within w_sc_cf
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_sc_cf
integer x = 2350
integer y = 656
end type

type cb_modifica from w_g_tab0`cb_modifica within w_sc_cf
integer x = 2350
integer y = 908
end type

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_sc_cf
integer x = 2350
integer y = 1200
end type

type cb_cancella from w_g_tab0`cb_cancella within w_sc_cf
integer x = 2350
integer y = 1052
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_sc_cf
integer x = 2350
integer y = 768
end type

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_sc_cf
integer y = 832
integer width = 2747
integer height = 888
boolean enabled = true
string dataobject = "d_sc_cf"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_dett_0::editchanged;//soppressione codice del padre
end event

event dw_dett_0::itemchanged;call super::itemchanged;//
string k_rag_soc, k_sl_pt
long k_rc, k_riga=0
integer k_return=0
st_tab_clienti kst_tab_clienti
datawindowchild kdwc_cli, kdwc_x


choose case upper(dwo.name)

	case "RAG_SOC_10" 
	
		k_rag_soc = RightTrim(data)
		if isnull(k_rag_soc) = false and LenA(trim(k_rag_soc)) > 0 then
			
			k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_cli)
			k_rc = kdwc_cli.find("rag_soc_1 like ~""+k_rag_soc+"%~"",0,kdwc_cli.rowcount())
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				dw_dett_0.setitem(row, "rag_soc_10", k_rag_soc+" - NON TROVATO -")
				dw_dett_0.setitem(row, "cod_cli", 0)
			else
				kst_tab_clienti.rag_soc_10 = kdwc_cli.getitemstring(k_riga, "rag_soc_1")
				kst_tab_clienti.codice = kdwc_cli.getitemnumber(k_riga, "id_cliente")
				post put_video_cliente(kst_tab_clienti)
//				k_return = 2
//				dw_dett_0.setitem(row, "rag_soc_10", kdwc_cli.getitemstring(k_riga, "rag_soc_1"))
//				dw_dett_0.setitem(row, "cod_cli", kdwc_cli.getitemnumber(k_riga, "id_cliente"))
			end if
			
		end if

	case "COD_CLI" 
		if len(trim(data)) > 0 and isnumber(trim(data)) then 
			dw_dett_0.getchild(dwo.name, kdwc_cli)
			k_riga = kdwc_cli.find( "id_cliente = " + trim(data) + " " , 1, kdwc_cli.rowcount())
			if k_riga > 0 then
				kst_tab_clienti.codice = long(trim(data))
				get_dati_cliente(kst_tab_clienti)
				post put_video_cliente(kst_tab_clienti)
			else
				dw_dett_0.modify( dwo.name + ".Background.Color = '" + string(kkg_colore.ERR_DATO) + "' ") 
			end if
		else
			kst_tab_clienti.codice = 0
			kst_tab_clienti.rag_soc_10 = ""
			post put_video_cliente(kst_tab_clienti)
		end if
		
		
	case "SL_PT" 
		k_sl_pt = RightTrim(trim(data))
		if isnull(k_sl_pt) = false and LenA(trim(k_sl_pt)) > 0 then
			
			k_rc = dw_dett_0.getchild("sl_pt", kdwc_x)
			k_rc = kdwc_x.find("cod_sl_pt =~""+(k_sl_pt)+"~"",0,kdwc_x.rowcount())
			k_riga = k_rc
			if k_riga <= 0 or isnull(k_riga) then
				k_return = 2
				dw_dett_0.setitem(row, "sl_pt_descr", "NON TROVATO")
			else
				k_return = 2
				dw_dett_0.setitem(row, "sl_pt", kdwc_x.getitemstring(k_riga, "cod_sl_pt"))
				dw_dett_0.setitem(row, "sl_pt_descr", kdwc_x.getitemstring(k_riga, "descr"))
			end if
			
		end if

	end choose

	return k_return




end event

event dw_dett_0::itemfocuschanged;call super::itemfocuschanged;long k_rc
datawindowchild kdwc_clienti_d, kdwc_x, kdwc_x_des



if ki_st_open_w.flag_modalita <> kkg_flag_modalita.visualizzazione then

	choose case upper(dwo.name)

		case "RAG_SOC_10", "COD_CLI" 

		//--- Attivo dw archivio Clienti
			k_rc = this.getchild("cod_cli", kdwc_x)
			if kdwc_x.rowcount() < 2 then
				kdwc_x.retrieve("%")
				k_rc = this.getchild("rag_soc_10", kdwc_x_des)
				kdwc_x.RowsCopy(kdwc_x.GetRow(), kdwc_x.RowCount(), Primary!, kdwc_x_des, 1, Primary!)
				kdwc_x.setsort( "id_cliente A")
				kdwc_x.sort( )
				k_rc = kdwc_x.insertrow(1)
				k_rc = kdwc_x_des.insertrow(1)
			end if	

//			k_rc = dw_dett_0.getchild("rag_soc_10", kdwc_clienti_d)
//			if kdwc_clienti_d.rowcount() < 2 then
//				kdwc_clienti_d.retrieve("%")
//				kdwc_clienti_d.insertrow(1)
//			end if
		

		case "SL_PT" 

//--- Attivo dw archivio Clienti
			k_rc = dw_dett_0.getchild("sl_pt", kdwc_x)

			if kdwc_x.rowcount() < 2 then
				kdwc_x.retrieve("%")
				kdwc_x.insertrow(1)
			end if

	end choose
end if

end event

type st_orizzontal from w_g_tab0`st_orizzontal within w_sc_cf
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_sc_cf
integer y = 32
integer width = 2866
integer height = 864
string dataobject = "d_sc_cf_l"
end type

type dw_guida from w_g_tab0`dw_guida within w_sc_cf
end type

type dw_dis_attiva from uo_d_std_1 within w_sc_cf
integer x = 155
integer y = 1176
integer width = 1934
integer height = 672
integer taborder = 110
boolean bringtotop = true
boolean titlebar = true
string title = " Attiva / Disattiva i Capitolati nel periodo indicato"
string dataobject = "d_sc_cf_att_dis"
boolean controlmenu = true
boolean hsplitscroll = false
end type

event buttonclicked;call super::buttonclicked;//
date k_data_da, k_data_a
string k_attivo
pointer kpointer_old
kuf_contratti kuf1_contratti
st_esito kst_esito


	this.accepttext()

	if dwo.name = "cb_annulla" then
		
		dw_lista_0.setfocus()
		this.visible = false
		
	end if
	
	if dwo.name = "cb_esegui" then
		k_data_da = (this.getitemdate(1,"data_scad_ini"))
		k_data_a = (this.getitemdate(1,"data_scad_fin"))
		k_attivo = trim(this.getitemstring(1,"flag"))

		if k_data_da > k_data_a then
			messagebox("Dati incongruenti ", &
						"Data inizio maggiore di data fine periodo, ~n~r" + &
						"Controlla i Valori e riprova")
		else
			kpointer_old = setpointer(hourglass!)
			kuf1_contratti = create kuf_contratti
			kst_esito = kuf1_contratti.sc_cf_aggiorna_attivo(k_data_da, k_data_a, k_attivo)
			destroy kuf1_contratti
			if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
				setpointer(kpointer_old)
				messagebox("Operazione non eseguita", &
						"Aggiornamento fallito, errore:~n~r" + &
						string(kst_esito.sqlcode) + " - " + trim(kst_esito.sqlerrtext), &
						stopsign!)
				this.setfocus()
			else
				leggi_liste()
				dw_lista_0.setfocus()
				this.visible = false
			end if
		end if
		
		setpointer(kpointer_old)
		
	end if
	
	attiva_tasti()
	
		
end event

