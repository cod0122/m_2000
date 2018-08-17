$PBExportHeader$w_listino_duplica_massiva1.srw
forward
global type w_listino_duplica_massiva1 from w_fatture_new_st
end type
type ddlb_copie from dropdownlistbox within w_listino_duplica_massiva1
end type
type cbx_forza_wm_camion_caricato from checkbox within w_listino_duplica_massiva1
end type
type dw_box from datawindow within w_listino_duplica_massiva1
end type
type gb_copie from groupbox within w_listino_duplica_massiva1
end type
end forward

global type w_listino_duplica_massiva1 from w_fatture_new_st
integer width = 4466
integer height = 2820
string title = ""
boolean center = true
ddlb_copie ddlb_copie
cbx_forza_wm_camion_caricato cbx_forza_wm_camion_caricato
dw_box dw_box
gb_copie gb_copie
end type
global w_listino_duplica_massiva1 w_listino_duplica_massiva1

type variables
//
private st_listino_duplica kist_listino_duplica[]
private kuf_listino kiuf_listino
private kuf_listino_duplica_massiva kiuf_listino_duplica_massiva

private st_sped_ddt kist_sped_ddt[]
private int k_ddlb_copie_index=2
end variables
forward prototypes
private subroutine popola_lista_da_st ()
private subroutine popola_st_da_lista ()
protected subroutine open_start_window ()
protected function string inizializza () throws uo_exception
protected function string leggi_liste ()
protected subroutine inizializza_lista ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private function boolean check_lista_se_ristampa ()
public function boolean u_riopen (st_open_w kst_open_w) throws uo_exception
protected function string check_dati ()
protected subroutine u_esegui ()
public subroutine u_set_dw_documenti_prezzo_nuovo ()
public function boolean u_get_prezzo_nuovo (ref decimal a_prezzo)
end prototypes

private subroutine popola_lista_da_st ();//
//---
//--- riempie la dw da oggetto st_sped_ddt
//---
long k_riga, k_riga_ins
int k_camion_caricato=0
st_tab_listino kst_tab_listino
st_tab_clienti kst_tab_clienti
st_tab_prodotti kst_tab_prodotti
st_tab_gru kst_tab_gru
st_tab_contratti kst_tab_contratti
kuf_prodotti kuf1_prodotti
kuf_clienti kuf1_clienti
kuf_ausiliari kuf1_ausiliari
kuf_contratti kuf1_contratti
st_esito kst_esito
pointer kpointer_orig


try
	
	kpointer_orig = setpointer(hourglass!)
	
	kuf1_ausiliari = create kuf_ausiliari
	kuf1_prodotti = create kuf_prodotti
	kuf1_clienti = create kuf_clienti
	kuf1_contratti = create kuf_contratti
	
	dw_documenti.reset()
	
	for k_riga = 1 to upperbound(kist_listino_duplica[])
	
		
		kst_tab_listino.id = kist_listino_duplica[k_riga].id_listino
	
	//--- piglia dati ddt
		if kst_tab_listino.id > 0 then
			
			k_riga_ins = dw_documenti.insertrow(0) //--- nuova riga 
			
			if kist_listino_duplica[k_riga].sel = 0 then
				dw_documenti.setitem(k_riga_ins,"sel", 0)
			else
				dw_documenti.setitem(k_riga_ins,"sel", 1)
			end if
				
			dw_documenti.setitem(k_riga_ins,"id_listino", kist_listino_duplica[k_riga].id_listino)
			
			if kiuf_listino.select_riga(kst_tab_listino) then
				
				dw_documenti.setitem(k_riga_ins,"prezzo", kst_tab_listino.prezzo)
				dw_documenti.setitem(k_riga_ins,"prezzo_2", kst_tab_listino.prezzo_2)
				dw_documenti.setitem(k_riga_ins,"prezzo_3", kst_tab_listino.prezzo_3)
				dw_documenti.setitem(k_riga_ins,"cod_cli", kst_tab_listino.cod_cli)
				dw_documenti.setitem(k_riga_ins,"cod_art", kst_tab_listino.cod_art)
				dw_documenti.setitem(k_riga_ins,"contratto", kst_tab_listino.contratto)
				dw_documenti.setitem(k_riga_ins,"attiva_listino_pregruppi", kst_tab_listino.attiva_listino_pregruppi)
				dw_documenti.setitem(k_riga_ins,"dose", kst_tab_listino.dose)
				dw_documenti.setitem(k_riga_ins,"magazzino", kst_tab_listino.magazzino)
				dw_documenti.setitem(k_riga_ins,"mis_x", kst_tab_listino.mis_x)
				dw_documenti.setitem(k_riga_ins,"mis_y", kst_tab_listino.mis_y)
				dw_documenti.setitem(k_riga_ins,"mis_z", kst_tab_listino.mis_z)
				dw_documenti.setitem(k_riga_ins,"occup_ped", kst_tab_listino.occup_ped)
				dw_documenti.setitem(k_riga_ins,"peso_kg", kst_tab_listino.peso_kg)
				dw_documenti.setitem(k_riga_ins,"campione", kst_tab_listino.campione)
				dw_documenti.setitem(k_riga_ins,"tipo", kst_tab_listino.tipo)
				dw_documenti.setitem(k_riga_ins,"attivo", kst_tab_listino.attivo)
				dw_documenti.setitem(k_riga_ins,"x_datins", kst_tab_listino.x_datins)
				dw_documenti.setitem(k_riga_ins,"attivo", kst_tab_listino.attivo)
	
	
				kst_tab_clienti.codice = kst_tab_listino.cod_cli
				kst_esito = kuf1_clienti.leggi_rag_soc( kst_tab_clienti )
				if kst_esito.esito = kkg_esito_ok then
					dw_documenti.setitem(k_riga_ins,"rag_soc_10", trim(kst_tab_clienti.rag_soc_10+kst_tab_clienti.rag_soc_11))
	//				dw_documenti.setitem(k_riga_ins,"loc_10", trim(kst_tab_clienti.loc_1))
	//				dw_documenti.setitem(k_riga_ins,"nazione", trim(kst_tab_clienti.id_nazione_1))
				else
					dw_documenti.setitem(k_riga_ins,"rag_soc_10", "***non trovato***")
				end if
				
				kst_tab_prodotti.codice = kst_tab_listino.cod_art
				kst_esito = kuf1_prodotti.select_riga(kst_tab_prodotti)
				if kst_esito.esito = kkg_esito_ok then
					dw_documenti.setitem(k_riga_ins,"prodotti_des", kst_tab_prodotti.des)
					dw_documenti.setitem(k_riga_ins,"prodotti_gruppo", kst_tab_prodotti.gruppo)
				else
					dw_documenti.setitem(k_riga_ins,"prodotti_des", "***non trovato***")
					dw_documenti.setitem(k_riga_ins,"prodotti_gruppo", "")
				end if
				
				if kst_tab_prodotti.gruppo > 0 then
					kst_tab_gru.codice = kst_tab_prodotti.gruppo
					kst_esito = kuf1_ausiliari.tb_select(kst_tab_gru)
					if kst_esito.esito = kkg_esito_ok then
						dw_documenti.setitem(k_riga_ins,"gru_des", kst_tab_gru.des)
					else
						dw_documenti.setitem(k_riga_ins,"gru_des", "***non trovato***")
					end if
				else
					dw_documenti.setitem(k_riga_ins,"gru_des", "")
				end if
				
				if kst_tab_listino.contratto > 0 then
					kst_tab_contratti.codice = kst_tab_listino.contratto
					kst_esito = kuf1_contratti.select_riga(kst_tab_contratti)
					if kst_esito.esito = kkg_esito_ok then
						dw_documenti.setitem(k_riga_ins,"mc_co", kst_tab_contratti.mc_co)
						dw_documenti.setitem(k_riga_ins,"sc_cf", kst_tab_contratti.mc_co)
						dw_documenti.setitem(k_riga_ins,"sl_pt", kst_tab_contratti.mc_co)
						//dw_documenti.setitem(k_riga_ins,"data_scad", kst_tab_contratti.mc_co)
					else
						dw_documenti.setitem(k_riga_ins,"mc_co", "***non trovato***")
						dw_documenti.setitem(k_riga_ins,"sc_cf", "")
						dw_documenti.setitem(k_riga_ins,"sl_pt", "")
						//dw_documenti.setitem(k_riga_ins,"data_scad", "")
					end if
				else
					dw_documenti.setitem(k_riga_ins,"mc_co", "")
					dw_documenti.setitem(k_riga_ins,"sc_cf", "")
					dw_documenti.setitem(k_riga_ins,"sl_pt", "")
					//dw_documenti.setitem(k_riga_ins,"data_scad", "")
				end if
				
			end if
	
	//--- se si è verificato un errore			
			if kst_esito.esito <> kkg_esito_ok and kst_esito.esito <> kkg_esito_db_wrn then
				throw kguo_exception
			end if
				
		end if
			
			
	end for

	
catch (uo_exception kuo1_exception)
	kuo1_exception.messaggio_utente()
	
finally
	setpointer(kpointer_orig)  

end try


end subroutine

private subroutine popola_st_da_lista ();//
//---
//--- riempie la  st_listino_duplica   da DW
//---
long k_riga=0, k_riga_ins=0
string k_diprova = "N"
st_listino_duplica kst_listino_duplica[]
pointer kpointer_orig

//st_esito kst_esito

kpointer_orig = setpointer(hourglass!)

kist_listino_duplica[] = kst_listino_duplica[]

if rb_prova.checked then k_diprova = "S"

for k_riga = 1 to dw_documenti.rowcount()


	if dw_documenti.getitemnumber(k_riga,"id_listino") > 0 then
		
//--- solo i documenti selezionati
		if not (rb_emissione_selezione.checked) or (dw_documenti.getitemnumber(k_riga, "sel")) = 1 then

			k_riga_ins++


			if rb_emissione_selezione.checked then
				kist_listino_duplica[k_riga_ins].sel = 1
			else
				if dw_documenti.getitemnumber(k_riga,"sel") = 0 then
					kist_listino_duplica[k_riga_ins].sel = 0 
				else
					kist_listino_duplica[k_riga_ins].sel = 1
				end if
			end if
			
			kist_listino_duplica[k_riga_ins].diprova = k_diprova
			
			kist_listino_duplica[k_riga_ins].id_listino = dw_documenti.getitemnumber(k_riga,"id_listino")
		
//--- valuta come valorizzare i PREZZI		
			if dw_documenti.getitemnumber(k_riga,"prezzo")	>= dw_box.getitemnumber(1,"soglia_min") &
						and dw_documenti.getitemnumber(k_riga,"prezzo")	<= dw_box.getitemnumber(1,"soglia_max") then
				if dw_box.getitemstring(1, "tipo") = "P" then
					kist_listino_duplica[k_riga_ins].prezzo = dw_documenti.getitemnumber(k_riga,"prezzo") * ( 1 + dw_box.getitemnumber(1,"percentuale")/100)
				else
					kist_listino_duplica[k_riga_ins].prezzo = dw_box.getitemnumber(1,"importo")
				end if
			end if
			if dw_documenti.getitemnumber(k_riga,"prezzo_2")	>= dw_box.getitemnumber(1,"soglia_min") &
						and dw_documenti.getitemnumber(k_riga,"prezzo_2")	<= dw_box.getitemnumber(1,"soglia_max") then
				if dw_box.getitemstring(1, "tipo") = "P" then
					kist_listino_duplica[k_riga_ins].prezzo_2 = dw_documenti.getitemnumber(k_riga,"prezzo_2") * ( 1 + dw_box.getitemnumber(1,"percentuale")/100)
				else
					kist_listino_duplica[k_riga_ins].prezzo_2 = dw_box.getitemnumber(1,"importo")
				end if
			end if
			if dw_documenti.getitemnumber(k_riga,"prezzo_3")	>= dw_box.getitemnumber(1,"soglia_min") &
						and dw_documenti.getitemnumber(k_riga,"prezzo_3")	<= dw_box.getitemnumber(1,"soglia_max") then
				if dw_box.getitemstring(1, "tipo") = "P" then
					kist_listino_duplica[k_riga_ins].prezzo_3 = dw_documenti.getitemnumber(k_riga,"prezzo_3") * ( 1 + dw_box.getitemnumber(1,"percentuale")/100)
				else
					kist_listino_duplica[k_riga_ins].prezzo_3 = dw_box.getitemnumber(1,"importo")
				end if
			end if
			
		
		end if
	end if
		
		
end for


setpointer(kpointer_orig)  



end subroutine

protected subroutine open_start_window ();//---
boolean k_bolla_trovata=false
long k_ctr
st_listino_duplica kst_listino_duplica_vuota[]
ki_st_open_w.flag_modalita = kkg_flag_modalita_stampa


try 
	setpointer(kkg.pointer_attesa)

	pb_ok.picturename = kg_path_risorse + kkg_path_sep + "euro40.png"
	st_aggiorna_lista.enabled  = TRUE

	if isvalid(ki_st_open_w.key12_any) then 
		kist_listino_duplica[]	 = ki_st_open_w.key12_any   //--- argomento Struttura con le bolle da mettere in elenco
	else
		kist_listino_duplica[]	 = kst_listino_duplica_vuota[]		
	end if

//--- controlla se bolle già stampate o no (piu' o meno)
	if check_lista_se_ristampa( ) then
		rb_prova.checked = true
	else
		rb_definitiva.checked = true
	end if

 	kiuf_listino = create kuf_listino
	kiuf_listino_duplica_massiva = create kuf_listino_duplica_massiva

	dw_box.insertrow(0)
	
	post inizializza_lista()

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		this.postevent(close!)

	finally
		setpointer(kkg.pointer_default)  
		
end try


end subroutine

protected function string inizializza () throws uo_exception;//---
boolean k_bolla_trovata=false
long k_ctr
date k_data
st_sped_ddt kst_sped_ddt_vuota[]
ki_st_open_w.flag_modalita = kkg_flag_modalita_stampa
kuf_sped kuf1_sped
pointer kpointer_orig



try 
	kpointer_orig = setpointer(hourglass!)

	dw_documenti.reset( )
	
//--- pone i link nel dw
	u_personalizza_dw()

	for k_ctr = 1 to UpperBound(kist_sped_ddt[])
		if kist_sped_ddt [k_ctr].kst_tab_sped.num_bolla_out > 0 then 
			k_bolla_trovata = true
			exit
		end if
	next
	
	if not k_bolla_trovata then

		kuf1_sped = create kuf_sped
		kuf1_sped.get_ddt_da_stampare(kist_sped_ddt[])
			
	end if
	
//--- se non è stato passato nulla faccio la retrieve
	if upperbound(kist_listino_duplica[]) = 0 then
		k_data = relativedate(kguo_g.get_dataoggi( ), -1000)
		dw_documenti.retrieve(0, k_data, 0)
	else
		popola_lista_da_st()
	end if
	
	kist_sped_ddt[] = kst_sped_ddt_vuota[]
	
	dw_documenti.setfocus()

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		this.postevent(close!)

	finally
		if isvalid(kuf1_sped) then destroy kuf1_sped
		setpointer(kpointer_orig)  
		
end try

return "0"

end function

protected function string leggi_liste ();//
//======================================================================
//=== Liste Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
long k_riga
st_sped_ddt kst_sped_ddt_vuota[]


	try
		dw_documenti.setredraw(false)
	
		k_riga = dw_documenti.getrow()

//		if isvalid(ki_st_open_w.key12_any[]) then 
//			kist_sped_ddt[]	 = ki_st_open_w.key12_any   //--- argomento Struttura con le bolle da mettere in elenco
//		else
//			kist_sped_ddt[]	 = kst_sped_ddt_vuota[]		
//		end if
		
		inizializza()
		
		if k_riga > dw_documenti.rowcount() or k_riga = 0 then
			k_riga = dw_documenti.rowcount() 
		end if
		if k_riga > 0 then
			dw_documenti.sort()
			if k_riga > 3 then
				dw_documenti.scrolltorow(k_riga - 3)
			else
				dw_documenti.scrolltorow(k_riga)
			end if
			dw_documenti.setrow(k_riga)
			dw_documenti.selectrow(0 , false)
			dw_documenti.selectrow(k_riga , true)
		else
	
			k_return = "1 "
	
		end if
		
		dw_documenti.setredraw(true)
		
	catch (uo_exception kuo_ecxception)

	end try
	
return k_return





end function

protected subroutine inizializza_lista ();//
//=== Routine STANDARD
//=== Ritorna 0=ok 1=errore
//
int k_return=0
string k_inizializza
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	//dw_documenti.ki_d_std_1_primo_giro = true

	dw_documenti.SetRedraw (false)
	dw_documenti.SetRedraw (false)


	try
		
		k_inizializza = inizializza() //Reimposta i tasti e fa la retrieve di lista
			
		
	catch (uo_exception kuo_exception)
		
	end try


	
//=== Se le INIZIALIZZA tornano con errore = 2 allora chiudo la windows	
	if LeftA(k_inizializza,1) <> "2" then

//--- fa delle cose personalizzate per i figli
		inizializza_post()
		
		attiva_tasti()

		dw_documenti.SetRedraw (true)
		post fine_primo_giro()

	 	SetPointer(oldpointer)

	else

	 	SetPointer(oldpointer)

//--- FORZA USCITA!!!
		post close(this)
	end if
	
	


end subroutine

protected subroutine attiva_menu ();

	if kI_menu.m_finestra.m_aggiornalista.enabled <> st_aggiorna_lista.enabled then
		kI_menu.m_finestra.m_aggiornalista.enabled = st_aggiorna_lista.enabled 
	end if

//	if not kI_menu.m_strumenti.m_fin_gest_libero8.enabled  then
//		kI_menu.m_strumenti.m_fin_gest_libero8.text = "Stampa d.d.t. bianco "
//		kI_menu.m_strumenti.m_fin_gest_libero8.microhelp = 	"Stampa d.d.t. bianco senza dati  "
//		kI_menu.m_strumenti.m_fin_gest_libero8.visible = true
//		kI_menu.m_strumenti.m_fin_gest_libero8.enabled = true
//		kI_menu.m_strumenti.m_fin_gest_libero8.toolbaritemtext = "Bianco,"+ kI_menu.m_strumenti.m_fin_gest_libero8.text
//		kI_menu.m_strumenti.m_fin_gest_libero8.toolbaritemname = "Layer!"
//		kI_menu.m_strumenti.m_fin_gest_libero8.toolbaritembarindex=2
//		kI_menu.m_strumenti.m_fin_gest_libero8.toolbaritemvisible = true
//	end if

	super::attiva_menu()
	
end subroutine

protected subroutine smista_funz (string k_par_in);//---
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//===

choose case LeftA(k_par_in, 2) 

	case kkg_flag_richiesta_refresh		//Aggiorna Liste
		leggi_liste()

//	case kkg_flag_richiesta_libero8		//Stampa bolla bianca!
//		stampa_ddt_bianco()

	case else // standard
		super::smista_funz(k_par_in)
		
end choose



end subroutine

private function boolean check_lista_se_ristampa ();//
//---
//--- Controlla se almeno una bolla già stampata vuol dire (x ora) RISTAMPA
//---
boolean k_return = false
long k_riga
st_tab_sped kst_tab_sped
kuf_sped kuf1_sped
st_esito kst_esito
pointer kpointer_orig


kpointer_orig = setpointer(hourglass!)

kuf1_sped = create kuf_sped

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


for k_riga = 1 to upperbound(kist_sped_ddt[])
	
	kst_tab_sped.num_bolla_out = kist_sped_ddt[k_riga].kst_tab_sped.num_bolla_out
	kst_tab_sped.data_bolla_out = kist_sped_ddt[k_riga].kst_tab_sped.data_bolla_out
	kst_tab_sped.id_sped = kist_sped_ddt[k_riga].kst_tab_sped.id_sped

	try 
		if kst_tab_sped.num_bolla_out > 0 then

//--- piglia dati ddt
			if kst_tab_sped.id_sped > 0 then
				
	//			kst_esito = kuf1_sped.get_sped_stampa(kst_tab_sped)
	//			if kst_esito.esito = kkg_esito_ok then
					
	//				if kst_tab_sped.stampa <> kuf1_sped.kki_sped_flg_stampa_bolla_da_stamp then
					if kuf1_sped.if_stampata(kst_tab_sped) then //get_sped_stampa(kst_tab_sped)
						
						k_return = true
						
						exit
						
					end if
					
	//			else
	//				
	//	//--- se si è verificato un errore			
	//				if kst_esito.esito <> kkg_esito_ok and kst_esito.esito <> kkg_esito_db_wrn and kst_esito.esito <> kkg_esito_not_fnd then
	//				
	//					kguo_exception.set_esito(kst_esito)
	//					kguo_exception.messaggio_utente( )
	//	
	//				end if
	//			end if
			else
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Codice ID del d.d.t. non indicato~n~r" &
							+ string(kst_tab_sped.num_bolla_out, "####0") + " del " &
							+ string(kst_tab_sped.data_bolla_out, "dd.mm.yyyy")
				kst_esito.esito = kkg_esito.ko
			end if
		end if	
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito() 
		
	
	end try
	
end for

if kst_esito.esito <> kkg_esito.ok then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	kguo_exception.messaggio_utente( )
end if

destroy kuf1_sped

setpointer(kpointer_orig)  


return k_return
end function

public function boolean u_riopen (st_open_w kst_open_w) throws uo_exception;//---
//--- Chiamata quando tento la Ri-OPEN della finestra  già Aperta
//---

ki_st_open_w = kst_open_w

this.setfocus()

event u_open( )

return true

end function

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK ma errore non grave
//===                : 5=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================
//
string k_return = " "
string k_errore = "0"
st_esito kst_esito
dec k_soglia_min = 0.00, k_soglia_max = 0.00, k_percento = 0.00, k_importo=0.00
string k_tipo
string k_espressione = "if (prezzo > 0 "
//datastore kds_inp
//kuf_parent kuf1_parent


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_tipo = dw_box.getitemstring(1, "tipo")
	k_percento = dw_box.getitemnumber(1, "percento")
	k_importo = dw_box.getitemnumber(1, "importo")

	choose case k_tipo
		case "P"
			if k_percento <> 0 then
			else
				kst_esito.sqlerrtext = "Indicare la Percentuale"
				kst_esito.esito = kkg_esito.DATI_INSUFF
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		case "I"
			if k_importo <> 0 then
			else
				kst_esito.sqlerrtext = "Indicare l'Importo"
				kst_esito.esito = kkg_esito.DATI_INSUFF
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
	end choose
	
	if kst_esito.esito = kkg_esito.ok then
		k_soglia_min = dw_box.getitemnumber( 1, "soglia_min")
		if k_soglia_min > 0 then
			k_soglia_max = dw_box.getitemnumber( 1, "soglia_max")
			if k_soglia_max > 0 and k_soglia_max < k_soglia_min then
				kst_esito.sqlerrtext = "Soglia Minima superiore alla Massima"
				kst_esito.esito = kkg_esito.DATI_INSUFF
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		end if
	end if

	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()

finally
	choose case kst_esito.esito
		case kkg_esito.OK
			k_errore = "0"
		case kkg_esito.ERR_LOGICO
			k_errore = "1"
		case kkg_esito.err_formale
			k_errore = "2"
		case kkg_esito.DATI_INSUFF
			k_errore = "3"
		case kkg_esito.DB_WRN
			k_errore = "4"
		case kkg_esito.DATI_WRN
			k_errore = "5"
		case else
			k_errore = "1"
	end choose

	k_return = trim(kst_esito.sqlerrtext)
//--- Attenzione se ho interesse di conoscere i campi in errore scorrere i TAG di ciascun campo nel DATASTORE dove c'e' il tipo di errore riscontrato 	
	
end try

return k_errore + k_return


end function

protected subroutine u_esegui ();//--
//--- Lancia Duplica LISTINI
//---
long k_riga_ddt=0, k_riga=0
int k_nr_duplicati=0, k_ind=0, k_camion_caricato=0
boolean k_flag_camion_caricato_si=true
kuf_sped_ddt kuf1_sped_ddt
kuf_sped kuf1_sped
st_tab_sped kst_tab_sped
st_listino_duplica kst_listino_duplica[]
st_esito kst_esito
uo_exception kuo1_exception
pointer kpointer


kpointer = setpointer(hourglass!)

kuf1_sped_ddt = create kuf_sped_ddt
kuf1_sped = create kuf_sped
kuo1_exception = create uo_exception

kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try 
//--- set nell'area kist_listino_duplica[] delle bolle da stmpare dal DW	
	popola_st_da_lista()

//--- controllo array ai documenti?  
	if UpperBound(kist_listino_duplica[]) > 0 then
	
		for k_riga_ddt = 1 to UpperBound(kist_listino_duplica[])
			if kist_listino_duplica[k_riga_ddt].id_listino > 0 then

				k_riga++
				kst_listino_duplica[k_riga].id_listino = kist_listino_duplica[k_riga_ddt].id_listino
				
				kst_listino_duplica[k_riga].prezzo = kist_listino_duplica[k_riga_ddt].prezzo
				u_get_prezzo_nuovo(kst_listino_duplica[k_riga].prezzo) 
				
				kst_listino_duplica[k_riga].prezzo_2 = kist_listino_duplica[k_riga_ddt].prezzo_2
				u_get_prezzo_nuovo(kst_listino_duplica[k_riga].prezzo_2) 

				kst_listino_duplica[k_riga].prezzo_3 = kist_listino_duplica[k_riga_ddt].prezzo_3
				u_get_prezzo_nuovo(kst_listino_duplica[k_riga].prezzo_3) 

				kst_listino_duplica[k_riga].attivo = kiuf_listino.kki_attivo_da_fare
				
				kiuf_listino_duplica_massiva.u_duplica_listini(kst_listino_duplica[])
			
			end if

		next
		
//--- se tutto OK  procedo con l'elaborazione		
		if kst_esito.esito = kkg_esito_ok or kst_esito.esito = kkg_esito_db_wrn then	
			
//			k_nr_duplicati = kuf1_sped_ddt.stampa_ddt (kst_listino_duplica[])  
			
			if k_nr_duplicati = 0 then
				kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_dati_insufficienti )
				kuo1_exception.setmessage(" Nessun listino Duplicato ")
			else

				kuo1_exception.set_tipo(kuo1_exception.kk_st_uo_exception_tipo_ok )
				if k_nr_duplicati = 1 then
					kuo1_exception.setmessage("Fine elaborazione, 1 Listino duplicato")
				else
					kuo1_exception.setmessage("Fine elaborazione, " + string(k_nr_duplicati) + " Listini duplicati")
				end if
			end if
		
//--- x DEFAULT Aggiorna DB (rb_DEFINITIVA)
			if k_nr_duplicati > 0 then
				if not rb_prova.checked then

//					kuf1_sped_ddt.set_ddt_aggiorna(kst_listino_duplica[])  // AGGIORNA!!!!!
						
//--- funzione utile alla sincronizzazione con la window di ritorno (come il navigatore)
					kiuf1_sync_window.u_window_set_funzione_aggiornata(ki_st_open_w)
						
				end if

			end if
		end if
			
		kuo1_exception.messaggio_utente( )

//--- se tutto OK
		if kst_esito.esito = kkg_esito_ok or kst_esito.esito = kkg_esito_db_wrn then	
			if rb_modo_stampa_s.checked  then
				if k_nr_duplicati > 0 then
					popola_lista_da_st( ) // elaborazione effettuata pulisco l'elenco
				end if
			end if
		end if
		
	end if
	
catch (uo_exception kuo_exception)
	
	kuf1_data_base.errori_scrivi_esito("W", kst_esito)  //--- scrive il LOG
	kuo_exception.messaggio_utente()
	
finally
	if isvalid(kuf1_sped_ddt) then destroy kuf1_sped_ddt
	if isvalid(kuf1_sped) then destroy kuf1_sped
	if isvalid(kuo1_exception) then destroy kuo1_exception

	setpointer(kpointer)
	
//--- se richiesto ed elenco vuoto esce dalla funzione	
	if cbx_chiude.checked then
		if dw_documenti.rowcount( ) = 0 then
			cb_ritorna.event clicked( )
		end if
	end if
		
end try


end subroutine

public subroutine u_set_dw_documenti_prezzo_nuovo ();//
//---- Calcola PREZZO nuovo
//
dec k_soglia_min = 0.00, k_soglia_max = 0.00, k_percento = 0.00, k_importo=0.00
string k_espressione = "if (prezzo > 0 "


	k_soglia_min = dw_box.getitemnumber( 1, "soglia_min")
	if k_soglia_min > 0 then
		k_espressione += " and prezzo >= " + string(k_soglia_min)
	end if
	k_soglia_max = dw_box.getitemnumber( 1, "soglia_max")
	if k_soglia_max > 0 then
		k_espressione += " and prezzo <= " + string(k_soglia_max)
	else
		if k_soglia_min > 0 then
			k_espressione += " and prezzo <= 9999999 "
		end if
	end if
	
	choose case dw_box.getitemstring( 1, "tipo")
		case "P"
			k_percento = dw_box.getitemnumber( 1, "percento")
			if k_percento <> 0 then
				k_espressione += ", prezzo * (1 + " + string(k_percento) + "/100), 0) "
			end if
		case "I"
			k_importo = dw_box.getitemnumber( 1, "importo")
			if k_importo <> 0 then
				k_espressione += ", " + string(k_importo) + ", 0) "
			end if
		case "N"
			k_espressione = "0" 
	end choose
	
	dw_documenti.modify("k_prezzo.expression = '" + k_espressione + "' ")



end subroutine

public function boolean u_get_prezzo_nuovo (ref decimal a_prezzo);//
//--- Calcola PREZZO nuovo
//--- inp: prezzo vecchio
//--- out: prezzo nuovo
//--- rit: TRUE = da elaborare; FALSE = non rientra nelle soglie
//
//
boolean k_return = false
dec k_soglia_min = 0.00, k_soglia_max = 0.00, k_percento = 0.00, k_importo=0.00


	k_soglia_min = dw_box.getitemnumber( 1, "soglia_min")
	if k_soglia_min > 0 then
	else
		k_soglia_min = 0
	end if
	k_soglia_max = dw_box.getitemnumber( 1, "soglia_max")
	if k_soglia_max > 0 then
		k_soglia_max = 9999999.99
	end if
	
	if a_prezzo >= k_soglia_min and a_prezzo <= k_soglia_max then
		k_return = true
		choose case dw_box.getitemstring( 1, "tipo")
			case "P"
				k_percento = dw_box.getitemnumber( 1, "percento")
				if k_percento <> 0 then
					a_prezzo = a_prezzo * (1 + k_percento/100)
				end if
			case "I"
				k_importo = dw_box.getitemnumber( 1, "importo")
				if k_importo <> 0 then
					a_prezzo = k_importo
				end if
			case "N"
				
		end choose
	end if
	
return k_return



end function

on w_listino_duplica_massiva1.create
int iCurrent
call super::create
this.ddlb_copie=create ddlb_copie
this.cbx_forza_wm_camion_caricato=create cbx_forza_wm_camion_caricato
this.dw_box=create dw_box
this.gb_copie=create gb_copie
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_copie
this.Control[iCurrent+2]=this.cbx_forza_wm_camion_caricato
this.Control[iCurrent+3]=this.dw_box
this.Control[iCurrent+4]=this.gb_copie
end on

on w_listino_duplica_massiva1.destroy
call super::destroy
destroy(this.ddlb_copie)
destroy(this.cbx_forza_wm_camion_caricato)
destroy(this.dw_box)
destroy(this.gb_copie)
end on

type st_ritorna from w_fatture_new_st`st_ritorna within w_listino_duplica_massiva1
integer x = 2638
integer y = 1980
end type

type st_ordina_lista from w_fatture_new_st`st_ordina_lista within w_listino_duplica_massiva1
end type

type st_aggiorna_lista from w_fatture_new_st`st_aggiorna_lista within w_listino_duplica_massiva1
end type

type cb_ritorna from w_fatture_new_st`cb_ritorna within w_listino_duplica_massiva1
end type

type st_stampa from w_fatture_new_st`st_stampa within w_listino_duplica_massiva1
integer x = 2130
integer y = 1992
end type

type rb_emissione_tutto from w_fatture_new_st`rb_emissione_tutto within w_listino_duplica_massiva1
integer x = 73
integer y = 120
integer width = 928
string text = "Duplica Tutti i Listini in elenco"
end type

type rb_emissione_selezione from w_fatture_new_st`rb_emissione_selezione within w_listino_duplica_massiva1
integer x = 73
integer y = 208
integer width = 1056
string text = "Duplica solo i Listini con ~'Sel~' attivato"
end type

type rb_definitiva from w_fatture_new_st`rb_definitiva within w_listino_duplica_massiva1
integer y = 1580
integer width = 919
string text = "EFFETTIVA (Duplica Listini)"
boolean checked = true
end type

event rb_definitiva::clicked;//
//--- evita evento padre
end event

type rb_prova from w_fatture_new_st`rb_prova within w_listino_duplica_massiva1
integer y = 1480
string text = "Simulazione (solo Log) "
boolean checked = false
end type

type pb_ok from w_fatture_new_st`pb_ok within w_listino_duplica_massiva1
integer y = 1752
string picturename = "C:\testGammarad\pb_gmmrd126\icone\euro40.png"
end type

event pb_ok::clicked;//
string k_errore_dati


k_errore_dati = check_dati()

if  Left(k_errore_dati,1) = "0" then

	u_esegui( )

else

	messagebox("Dati errati",  Mid(k_errore_dati, 2))

end if
end event

type dw_documenti from w_fatture_new_st`dw_documenti within w_listino_duplica_massiva1
integer width = 3168
integer height = 1936
string dataobject = "d_clienti_listino_l_sel"
end type

type cbx_aggiorna_stato from w_fatture_new_st`cbx_aggiorna_stato within w_listino_duplica_massiva1
boolean visible = false
integer x = 101
integer y = 2576
integer width = 887
string text = "Aggiorna lo Stato in ~'Stampato~'"
end type

type cbx_update_profis from w_fatture_new_st`cbx_update_profis within w_listino_duplica_massiva1
boolean visible = false
integer x = 2075
integer y = 2568
end type

type st_1 from w_fatture_new_st`st_1 within w_listino_duplica_massiva1
integer y = 1820
string text = "Avvia Operazione"
end type

type cbx_update_tab_varie from w_fatture_new_st`cbx_update_tab_varie within w_listino_duplica_massiva1
boolean visible = false
integer x = 2048
integer y = 2480
end type

type rb_modo_stampa_e from w_fatture_new_st`rb_modo_stampa_e within w_listino_duplica_massiva1
boolean visible = false
integer x = 1234
integer y = 2276
boolean enabled = false
end type

type rb_modo_stampa_s from w_fatture_new_st`rb_modo_stampa_s within w_listino_duplica_massiva1
boolean visible = false
integer x = 1248
integer y = 2356
boolean enabled = false
end type

type cbx_chiude from w_fatture_new_st`cbx_chiude within w_listino_duplica_massiva1
boolean visible = false
integer x = 992
integer y = 2556
integer width = 1024
integer height = 92
boolean enabled = false
string text = "Esce a fine stampa se elenco vuoto"
end type

type gb_aggiorna from w_fatture_new_st`gb_aggiorna within w_listino_duplica_massiva1
integer y = 1392
integer height = 292
string text = " Tipo Operazione "
end type

type gb_emissione from w_fatture_new_st`gb_emissione within w_listino_duplica_massiva1
integer x = 23
integer y = 16
integer height = 336
string text = " Applica su "
end type

type gb_produzione from w_fatture_new_st`gb_produzione within w_listino_duplica_massiva1
integer y = 396
integer height = 872
string text = " Imposta nuovi Prezzi "
end type

type ddlb_copie from dropdownlistbox within w_listino_duplica_massiva1
integer x = 101
integer y = 2288
integer width = 1061
integer height = 352
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Ricevente e Vettore se presente","Ricevente e Vettore ","Generica (solo una copia)"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//
k_ddlb_copie_index = index
end event

type cbx_forza_wm_camion_caricato from checkbox within w_listino_duplica_massiva1
boolean visible = false
integer x = 105
integer y = 2412
integer width = 1038
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Emettere ddt non caricati su camion"
end type

type dw_box from datawindow within w_listino_duplica_massiva1
integer x = 46
integer y = 492
integer width = 1065
integer height = 744
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_box_cambio_prezzi"
boolean border = false
end type

event itemchanged;//
//--- Protegge o meno i campi PERCENTO e IMPORTO
if dwo.name = "tipo" then
	choose case data
		case "P"
			this.Modify("percento.Protect='0'")		
			this.Modify("importo.Protect='1'")
	
			this.Modify("importo.Background.Color='-1' ")
			this.Modify("percento.Background.Color='" + string(rgb(255,255,255)) + "' ")
		case "I"
			this.Modify("percento.Protect='1'")		
			this.Modify("importo.Protect='0'")
	
			this.Modify("percento.Background.Color='-1' ")
			this.Modify("importo.Background.Color='" + string(rgb(255,255,255)) + "' ")
		case "N"
			this.Modify("percento.Protect='1'")		
			this.Modify("importo.Protect='1'")
	
			this.Modify("percento.Background.Color='-1' ")
			this.Modify("importo.Background.Color='-1' ")
	end choose
end if
	
post u_set_dw_documenti_prezzo_nuovo()


end event

type gb_copie from groupbox within w_listino_duplica_massiva1
boolean visible = false
integer x = 55
integer y = 2200
integer width = 1125
integer height = 328
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Numero Copie "
end type

