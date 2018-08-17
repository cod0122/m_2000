$PBExportHeader$w_contratti_generale_l.srw
forward
global type w_contratti_generale_l from w_g_tab0
end type
type rb_prova from radiobutton within w_contratti_generale_l
end type
type rb_definitiva from radiobutton within w_contratti_generale_l
end type
type cb_stampa_ok from commandbutton within w_contratti_generale_l
end type
type cb_stampa_annulla from commandbutton within w_contratti_generale_l
end type
type dw_periodo from uo_d_std_1 within w_contratti_generale_l
end type
type dw_tipo_contratto from uo_d_std_1 within w_contratti_generale_l
end type
type gb_stampa from groupbox within w_contratti_generale_l
end type
end forward

global type w_contratti_generale_l from w_g_tab0
integer width = 2898
integer height = 2084
string title = "Documenti di Vendita"
rb_prova rb_prova
rb_definitiva rb_definitiva
cb_stampa_ok cb_stampa_ok
cb_stampa_annulla cb_stampa_annulla
dw_periodo dw_periodo
dw_tipo_contratto dw_tipo_contratto
gb_stampa gb_stampa
end type
global w_contratti_generale_l w_contratti_generale_l

type variables
//
private date ki_data_ini 
private date ki_data_fin 
private string ki_tipo_contratto = "7"
private long ki_id_cliente 
private string ki_mostra_nascondi_in_lista="S"

private kuf_contratti_rd kiuf_contratti_rd


end variables
forward prototypes
private function string cancella ()
private function string inizializza ()
protected subroutine attiva_menu ()
protected subroutine smista_funz (string k_par_in)
private subroutine cambia_periodo_elenco ()
protected subroutine open_start_window ()
public subroutine stampa_doc_lancia ()
private subroutine stampa_doc ()
private function any popola_array_da_lista ()
protected subroutine attiva_tasti ()
protected function integer inserisci ()
end prototypes

private function string cancella ();//
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_tab_contratti_rd kst_tab_contratti_rd
st_tab_clienti kst_tab_clienti
st_esito kst_esito


k_riga = dw_lista_0.getrow()	
if k_riga > 0 then
	
	kst_tab_contratti_rd.id_contratto_rd = dw_lista_0.getitemnumber(k_riga, "nr_contratto")
	kst_tab_contratti_rd.offerta_data = dw_lista_0.getitemdate(k_riga, "data")
	kst_tab_contratti_rd.id_cliente = dw_lista_0.getitemnumber(k_riga, "id_cliente")
	kst_tab_clienti.rag_soc_10 = dw_lista_0.getitemstring(k_riga, "rag_soc_10")

	if isnull(kst_tab_clienti.rag_soc_10) = true or trim(kst_tab_clienti.rag_soc_10) = "" then
		kst_tab_clienti.rag_soc_10 = "Cliente senza Nominativo " 
	end if
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina Documento", "Sei sicuro di voler Cancellare il documento: ~n~r" &
	         + "nr. " + string(kst_tab_contratti_rd.id_contratto_rd, "#####") + " del " + string(kst_tab_contratti_rd.offerta_data) &
	         + " cliente " + string(kst_tab_contratti_rd.id_cliente)  + " - " + trim(kst_tab_clienti.rag_soc_10),  &
				question!, yesno!, 2) = 1 then
		
		
//=== Cancella la riga dal data windows di lista
		kst_esito = kiuf_contratti_rd.tb_delete( kst_tab_contratti_rd ) 
		if kst_esito.esito = kkg_esito_ok then
	
			dw_lista_0.setitemstatus(k_riga, 0, primary!, new!)
			dw_lista_0.deleterow(k_riga)

			dw_lista_0.setfocus()

		else

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							trim(kst_esito.sqlerrtext) )
	
			attiva_tasti()

		end if


	else
		messagebox("Elimina Documento", "Operazione Annullata !!")

	end if
end if

return " "

end function

private function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_vettore
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
int k_importa = 0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_importa = kuf1_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita
		if dw_lista_0.retrieve(ki_data_ini, ki_data_fin, ki_id_cliente) < 1 then
			k_return = "1Nessun Documento per il periodo: " + string(ki_data_ini) + " - " + string(ki_data_fin)

			SetPointer(oldpointer)
			messagebox("Elenco Documenti", &
					"Nessuna Documento per il periodo: " + string(ki_data_ini) + " - " + string(ki_data_fin))

		end if		
	end if

	attiva_tasti()

return k_return


end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


//---
	super::attiva_menu()


//
//--- Attiva/Dis. Voci di menu personalizzate
//
	kG_menu.m_strumenti.m_fin_gest_libero1.text = "Cambia il periodo di estrazione elenco (decorrenza)"
	kG_menu.m_strumenti.m_fin_gest_libero1.microhelp =  "Cambia periodo di estrazione elenco"
	kG_menu.m_strumenti.m_fin_gest_libero1.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.enabled = true
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Periodo,"+kG_menu.m_strumenti.m_fin_gest_libero1.text
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom015!"
	kG_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
	
	
	kG_menu.m_strumenti.m_fin_gest_libero2.text = "Stampa documenti selezionati"
	kG_menu.m_strumenti.m_fin_gest_libero2.microhelp =  "Stampa documenti selezionati"
	kG_menu.m_strumenti.m_fin_gest_libero2.visible = true
	kG_menu.m_strumenti.m_fin_gest_libero2.enabled = true
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Stampa,"+kG_menu.m_strumenti.m_fin_gest_libero2.text
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = kg_path_risorse + "\printer16x16.gif"
	kG_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
	
	

end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

choose case LeftA(k_par_in, 2) 


	case kkg_flag_richiesta_libero1		//cambia date di estrazione
		cambia_periodo_elenco()

	case kkg_flag_richiesta_libero2		//stampa fatture
		stampa_doc()

	case else
		super::smista_funz(k_par_in)

end choose



end subroutine

private subroutine cambia_periodo_elenco ();//---
//--- Visualizza il box x il cambio del Periodo di elenco fatture 
//---


dw_periodo.triggerevent("ue_visibile")

end subroutine

protected subroutine open_start_window ();//

kiuf_contratti_rd = create kuf_contratti_rd

//
//--- Argomenti:  KEY1 = cliente, KEY2= Data Inizio -   KEY3 = Data Fine 
	if len(trim(ki_st_open_w.key1)) > 0 then 
		ki_id_cliente = long(trim(ki_st_open_w.key1))
	else
		ki_id_cliente = 0
	end if
	if trim(ki_st_open_w.key2) = "" then
		if isdate(trim(ki_st_open_w.key2)) then
			ki_data_ini = date(trim(ki_st_open_w.key2))
		else
			ki_data_ini = relativedate(kg_dataoggi, -365)
		end if
	else
		ki_data_ini = relativedate(kg_dataoggi, -365)
	end if
	if trim(ki_st_open_w.key3) = "" then
		if isdate(trim(ki_st_open_w.key3)) then
			ki_data_fin = date(trim(ki_st_open_w.key3))
		else
			ki_data_fin = kg_dataoggi
		end if
	else
		ki_data_fin = kg_dataoggi
	end if
	


end subroutine

public subroutine stampa_doc_lancia ();//--
//--- Lancia Stampa delle fatture 
//---
int k_idx
st_esito kst_esito
st_tab_contratti_rd kst_tab_contratti_rd []


try 
	kst_tab_contratti_rd[] = popola_array_da_lista() // popola array con i doc selezionati per fare la stampa
	if upperbound(kst_tab_contratti_rd) > 0 then

		for k_idx = 1 to upperbound(kst_tab_contratti_rd)
	
			if not isnull(kst_tab_contratti_rd) and kst_tab_contratti_rd[k_idx].id_contratto_rd > 0 then
			
				if rb_prova.checked then
					
					kiuf_contratti_rd.stampa_documento_prova( kst_tab_contratti_rd [k_idx])
				else
					
					kiuf_contratti_rd.stampa_documento_definitiva(  kst_tab_contratti_rd [k_idx])
				end if
	
			end if
		next	
			
	else
		kguo_exception.setmessage( "Selezionare almeno un Documento da stampare")
		kguo_exception.messaggio_utente( )
	end if

	
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
finally

end try



end subroutine

private subroutine stampa_doc ();//---
//--- Visualizza il box x il cambio del stampa di elenco fatture 
//---

gb_stampa.x = (kiw_this_window.width  - gb_stampa.width) / 4
gb_stampa.y = (kiw_this_window.height - gb_stampa.height) / 4
rb_prova.x = gb_stampa.x + 78 
rb_prova.y = gb_stampa.y + 115
rb_definitiva.x = rb_prova.x 
rb_definitiva.y = gb_stampa.y + 203
cb_stampa_ok.x = gb_stampa.x + 78
cb_stampa_ok.y = gb_stampa.y + 319
cb_stampa_annulla.x = gb_stampa.x + 585
cb_stampa_annulla.y = cb_stampa_ok.y

gb_stampa.visible = true
rb_prova.visible = true
rb_definitiva.visible = true
cb_stampa_ok.visible = true
cb_stampa_annulla.visible = true

end subroutine

private function any popola_array_da_lista ();//---
//--- riempie la  ds_fatture  da dw di elenco
//---
long k_riga, k_riga_ds
st_tab_contratti_rd kst_tab_contratti_rd [] 



for k_riga = 1 to dw_lista_0.rowcount()

//--- se selezionata la metto da stampare
	if dw_lista_0.IsSelected ( k_riga)   then

		if dw_lista_0.getitemnumber(k_riga, "nr_contratto") > 0 then

			k_riga_ds ++
			kst_tab_contratti_rd[k_riga_ds].id_contratto_rd = dw_lista_0.getitemnumber(k_riga, "nr_contratto")
			
		end if			
	end if		
	
end for


return kst_tab_contratti_rd[]

end function

protected subroutine attiva_tasti ();//
       
super::attiva_tasti()		 

cb_cancella.enabled = false 

end subroutine

protected function integer inserisci ();//
long k_riga=0
st_tab_contratti_rd kst_tab_contratti_rd
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_contratti_rd.id_contratto_rd =0
kst_tab_contratti_rd.id_cliente = 0
//
k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
	
//--- identifico il contratto x chiamare l'applicazione giusta	
	choose case ki_tipo_contratto
			
		case "0" // Studio e Sviluppo
			kst_tab_contratti_rd.id_cliente = 0
			kst_tab_contratti_rd.id_contratto_rd = 0
			K_st_open_w.id_programma = kkg_id_programma_contratti_rd
			K_st_open_w.key1 = trim(string(kst_tab_contratti_rd.id_contratto_rd)) // id cont
			K_st_open_w.key2 = trim(string(kst_tab_contratti_rd.id_cliente)) // cod cliente

		case "4" // Capitolato
			K_st_open_w.key1 = trim(dw_lista_0.getitemstring( k_riga, "nr_contratto") )
			K_st_open_w.key2 = "*" //--- ATTIVO? *=tutti
			K_st_open_w.id_programma = kkg_id_programma_sc_cf
			
		case "7" // Contratto
			K_st_open_w.id_programma = kkg_id_programma_contratti
			K_st_open_w.key1 = trim(dw_lista_0.getitemstring( k_riga, "nr_contratto")) // codice contratto
			K_st_open_w.key2 = "*" //--- MC-COi
			
	end choose
	
//else
//	if len(trim(ki_st_open_w.key1)) > 0 then
//		kst_tab_contratti_rd.id_contratto_rd = dw_lista_0.getitemnumber( k_riga, "nr_contratto") 
//		kst_tab_contratti_rd.id_cliente = long(trim(ki_st_open_w.key1))
//	end if
end if
	

if dw_lista_0.getrow() > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//	K_st_open_w.id_programma = kkg_id_programma_contratti_rd
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita_inserimento
	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
//	K_st_open_w.key1 = trim(string(kst_tab_contratti_rd.id_contratto_rd)) // id cont
//	K_st_open_w.key2 = trim(string(kst_tab_contratti_rd.id_cliente)) // cod cliente
	K_st_open_w.key3 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dall'elenco")

end if

return (0)


end function

on w_contratti_generale_l.create
int iCurrent
call super::create
this.rb_prova=create rb_prova
this.rb_definitiva=create rb_definitiva
this.cb_stampa_ok=create cb_stampa_ok
this.cb_stampa_annulla=create cb_stampa_annulla
this.dw_periodo=create dw_periodo
this.dw_tipo_contratto=create dw_tipo_contratto
this.gb_stampa=create gb_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_prova
this.Control[iCurrent+2]=this.rb_definitiva
this.Control[iCurrent+3]=this.cb_stampa_ok
this.Control[iCurrent+4]=this.cb_stampa_annulla
this.Control[iCurrent+5]=this.dw_periodo
this.Control[iCurrent+6]=this.dw_tipo_contratto
this.Control[iCurrent+7]=this.gb_stampa
end on

on w_contratti_generale_l.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_prova)
destroy(this.rb_definitiva)
destroy(this.cb_stampa_ok)
destroy(this.cb_stampa_annulla)
destroy(this.dw_periodo)
destroy(this.dw_tipo_contratto)
destroy(this.gb_stampa)
end on

event close;call super::close;//
if isvalid(kiuf_contratti_rd) then destroy kiuf_contratti_rd

end event

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_contratti_generale_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_contratti_generale_l
integer x = 2427
integer y = 1160
integer height = 92
integer taborder = 90
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_contratti_generale_l
end type

type st_ritorna from w_g_tab0`st_ritorna within w_contratti_generale_l
end type

type dw_trova from w_g_tab0`dw_trova within w_contratti_generale_l
end type

type dw_filtra from w_g_tab0`dw_filtra within w_contratti_generale_l
integer taborder = 20
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_contratti_generale_l
integer x = 1801
integer y = 1252
end type

event cb_visualizza::clicked;//
long k_riga=0
st_tab_contratti_rd kst_tab_contratti_rd
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_contratti_rd.id_contratto_rd =0
kst_tab_contratti_rd.id_cliente = 0
//
k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
	
//--- identifico il contratto x chiamare l'applicazione giusta	
	choose case dw_lista_0.getitemstring( k_riga, "k_tipo_contratto") 
			
		case "0" // Studio e Sviluppo
			kst_tab_contratti_rd.id_cliente = dw_lista_0.getitemnumber( k_riga, "id_cliente") 
			kst_tab_contratti_rd.id_contratto_rd = long(dw_lista_0.getitemstring( k_riga, "nr_contratto") )
			K_st_open_w.id_programma = kkg_id_programma_contratti_rd_l
			K_st_open_w.key1 = trim(string(kst_tab_contratti_rd.id_contratto_rd)) // id cont
			K_st_open_w.key2 = trim(string(kst_tab_contratti_rd.id_cliente)) // cod cliente

		case "4" // Capitolato
			K_st_open_w.key1 = trim(dw_lista_0.getitemstring( k_riga, "nr_contratto") )
			K_st_open_w.key2 = "*" //--- ATTIVO? *=tutti
			K_st_open_w.id_programma = kkg_id_programma_sc_cf
			
		case "7" // Contratto
			K_st_open_w.id_programma = kkg_id_programma_contratti
			K_st_open_w.key1 = trim(dw_lista_0.getitemstring( k_riga, "nr_contratto")) // codice contratto
			K_st_open_w.key2 = "*" //--- ATTIVO? *=tutti
			
	end choose
end if
	

if dw_lista_0.getrow() > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.id_programma = kkg_id_programma_contratti_rd
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita_visualizzazione
	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_contratti_rd.id_contratto_rd)) // id cont
	K_st_open_w.key2 = trim(string(kst_tab_contratti_rd.id_cliente)) // cod cliente
	K_st_open_w.key3 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dall'elenco")

end if

return (0)



end event

type cb_modifica from w_g_tab0`cb_modifica within w_contratti_generale_l
integer x = 1783
integer y = 1152
integer height = 96
integer taborder = 70
end type

event cb_modifica::clicked;//
long k_riga=0
st_tab_contratti_rd kst_tab_contratti_rd
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_contratti_rd.id_contratto_rd =0
kst_tab_contratti_rd.id_cliente = 0
//
k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
	
//--- identifico il contratto x chiamare l'applicazione giusta	
	choose case dw_lista_0.getitemstring( k_riga, "k_tipo_contratto") 
			
		case "0" // Studio e Sviluppo
			kst_tab_contratti_rd.id_cliente = dw_lista_0.getitemnumber( k_riga, "id_cliente") 
			kst_tab_contratti_rd.id_contratto_rd = long(dw_lista_0.getitemstring( k_riga, "nr_contratto") )
			K_st_open_w.id_programma = kkg_id_programma_contratti_rd_l
			K_st_open_w.key1 = trim(string(kst_tab_contratti_rd.id_contratto_rd)) // id cont
			K_st_open_w.key2 = trim(string(kst_tab_contratti_rd.id_cliente)) // cod cliente

		case "4" // Capitolato
			K_st_open_w.key1 = trim(dw_lista_0.getitemstring( k_riga, "nr_contratto") )
			K_st_open_w.key2 = "*" //--- ATTIVO? *=tutti
			K_st_open_w.id_programma = kkg_id_programma_sc_cf
			
		case "7" // Contratto
			K_st_open_w.id_programma = kkg_id_programma_contratti
			K_st_open_w.key1 = trim(dw_lista_0.getitemstring( k_riga, "nr_contratto")) // codice contratto
			K_st_open_w.key2 = "*" //--- ATTIVO? *=tutti
			
	end choose
	
//else
//	if len(trim(ki_st_open_w.key1)) > 0 then
//		kst_tab_contratti_rd.id_contratto_rd = dw_lista_0.getitemnumber( k_riga, "nr_contratto") 
//		kst_tab_contratti_rd.id_cliente = long(trim(ki_st_open_w.key1))
//	end if
end if
	

if dw_lista_0.getrow() > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//	K_st_open_w.id_programma = kkg_id_programma_contratti_rd
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_modalita = kkg_flag_modalita_modifica
	K_st_open_w.flag_adatta_win = KK_ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
//	K_st_open_w.key1 = trim(string(kst_tab_contratti_rd.id_contratto_rd)) // id cont
//	K_st_open_w.key2 = trim(string(kst_tab_contratti_rd.id_cliente)) // cod cliente
	K_st_open_w.key3 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
else

	messagebox("Operazione non eseguita", "Selezionare una riga dall'elenco")

end if

return (0)


end event

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_contratti_generale_l
integer x = 1134
integer y = 1160
integer height = 96
integer taborder = 100
end type

type cb_cancella from w_g_tab0`cb_cancella within w_contratti_generale_l
integer x = 2121
integer y = 1164
integer height = 96
integer taborder = 80
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_contratti_generale_l
integer x = 1467
integer y = 1156
integer height = 96
integer taborder = 60
boolean enabled = false
end type

event cb_inserisci::clicked;//---
//--- Visualizza il box x il cambio del Periodo di elenco fatture 
//---


dw_tipo_contratto.triggerevent("ue_visibile")

end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_contratti_generale_l
integer x = 1769
integer y = 1104
integer width = 827
integer height = 524
integer taborder = 50
end type

on dw_dett_0::rbuttondown;call w_g_tab0`dw_dett_0::rbuttondown;//
//=== Scateno l'evento sulla window
parent.triggerevent("rbuttondown")

end on

on dw_dett_0::getfocus;////
//long k_id_vettore
//
////=== Verifico se ho gia' fatto almeno una retrieve o una insert
//if dw_dett_0.getrow() = 0 then
//	if cb_modifica.enabled = true then
//		cb_modifica.triggerevent("clicked")
//	else
//		cb_inserisci.triggerevent("clicked")
//	end if
//end if
//
////=== Controlla quali tasti attivare
//attiva_tasti()
//
//k_id_vettore = this.getitemnumber(1, "id_vettore")
////k_desc = this.getitemstring(1, "desc")
//
////=== Imposto valori di default se non ce ne sono
////if isnull(k_id_c_pag) = true or isnull(k_desc) = true or &
////	(trim(k_id_c_pag) = "" and &
////	 trim(k_desc) = "") then
////	setitem(1, "tipo", 1)
////	setitem(1, "scad_p", 1)
////end if
//
end on

type st_orizzontal from w_g_tab0`st_orizzontal within w_contratti_generale_l
integer x = 0
integer y = 1760
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_contratti_generale_l
integer width = 2807
integer height = 708
integer taborder = 120
string dataobject = "d_contratti_generale_l"
borderstyle borderstyle = stylelowered!
end type

type rb_prova from radiobutton within w_contratti_generale_l
boolean visible = false
integer x = 165
integer y = 1484
integer width = 818
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "stampa di Prova / Duplicato"
boolean checked = true
end type

type rb_definitiva from radiobutton within w_contratti_generale_l
boolean visible = false
integer x = 165
integer y = 1572
integer width = 539
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "stampa Definitiva"
end type

type cb_stampa_ok from commandbutton within w_contratti_generale_l
boolean visible = false
integer x = 165
integer y = 1688
integer width = 201
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;//
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

//
gb_stampa.visible = false
rb_prova.visible = false
rb_definitiva.visible = false
cb_stampa_ok.visible = false
cb_stampa_annulla.visible = false

stampa_doc_lancia()

SetPointer(oldpointer)


end event

type cb_stampa_annulla from commandbutton within w_contratti_generale_l
boolean visible = false
integer x = 672
integer y = 1688
integer width = 279
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Annulla"
end type

event clicked;//
gb_stampa.visible = false
rb_prova.visible = false
rb_definitiva.visible = false
cb_stampa_ok.visible = false
cb_stampa_annulla.visible = false

end event

type dw_periodo from uo_d_std_1 within w_contratti_generale_l
integer x = 114
integer y = 868
integer width = 955
integer height = 504
integer taborder = 60
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Periodo di estrazione"
string dataobject = "d_periodo"
boolean controlmenu = true
boolean hsplitscroll = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//
st_stampe kst_stampe
pointer oldpointer  // Declares a pointer variable

	
//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)
	

if dwo.name = "b_ok" then
	
	
	this.visible = false
	
	ki_data_ini  = this.getitemdate( 1, "data_dal")
	ki_data_fin  = this.getitemdate( 1, "data_al")
	inizializza()

else
	if dwo.name = "b_annulla" then

		this.visible = false
	
	
	end if
end if

SetPointer(oldpointer)


end event

event ue_visibile;call super::ue_visibile;//
int k_rc

	this.width = long(this.object.data_al.x) + long(this.object.data_al.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 160

	this.x = (kiw_this_window.width  - this.width) / 4
	this.y = (kiw_this_window.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	k_rc = this.setitem(1, "data_dal", ki_data_ini)
	k_rc = this.setitem(1, "data_al", ki_data_fin)
	this.visible = true
	this.setfocus()
end event

type dw_tipo_contratto from uo_d_std_1 within w_contratti_generale_l
integer x = 416
integer y = 104
integer width = 1001
integer height = 804
integer taborder = 70
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Tipo Contratto"
string dataobject = "d_contratti_generale_l_scelta"
boolean controlmenu = true
boolean hsplitscroll = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//
st_stampe kst_stampe
pointer oldpointer  // Declares a pointer variable

	
//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)
	

if dwo.name = "b_ok" then
	
	
	this.visible = false
	
	ki_tipo_contratto  = this.getitemstring( 1, "k_tipo_contratto")
	inserisci()

else
	if dwo.name = "b_annulla" then

		this.visible = false
	
	
	end if
end if

SetPointer(oldpointer)


end event

event ue_visibile;call super::ue_visibile;//
int k_rc

	this.width = long(this.object.data_al.x) + long(this.object.data_al.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 160

	this.x = (kiw_this_window.width  - this.width) / 4
	this.y = (kiw_this_window.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	k_rc = this.setitem(1, "k_tipo_contratto", ki_tipo_contratto)
	this.visible = true
	this.setfocus()
end event

type gb_stampa from groupbox within w_contratti_generale_l
boolean visible = false
integer x = 87
integer y = 1396
integer width = 946
integer height = 404
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Stampa e Aggiorna"
end type

