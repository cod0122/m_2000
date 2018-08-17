$PBExportHeader$w_contratti_rd_l.srw
forward
global type w_contratti_rd_l from w_g_tab0
end type
type dw_periodo from uo_d_std_1 within w_contratti_rd_l
end type
type dw_stampa from uo_d_std_1 within w_contratti_rd_l
end type
end forward

global type w_contratti_rd_l from w_g_tab0
integer width = 2898
integer height = 2084
string title = "Contratti Studio e Sviluppo"
boolean ki_toolbar_window_presente = true
dw_periodo dw_periodo
dw_stampa dw_stampa
end type
global w_contratti_rd_l w_contratti_rd_l

type variables
//
private date ki_data_ini 
private date ki_data_fin 
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
public subroutine call_crea_listino ()
private subroutine call_memo_old ()
end prototypes

private function string cancella ();//
string k_errore = "0 ", k_errore1 = "0 "
long k_riga
st_tab_contratti_rd kst_tab_contratti_rd
st_tab_clienti kst_tab_clienti
st_esito kst_esito


if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if


k_riga = dw_lista_0.getselectedrow(0)	
if k_riga > 0 then
	
	kst_tab_contratti_rd.id_contratto_rd = dw_lista_0.getitemnumber(k_riga, "id_contratto_rd")
	kst_tab_contratti_rd.offerta_data = dw_lista_0.getitemdate(k_riga, "offerta_data")
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
		if kst_esito.esito = kkg_esito.ok then
	
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
long k_riga_sel=0
pointer oldpointer  // Declares a pointer variable


//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

//=== Legge le righe del dw salvate l'ultima volta (importfile)
	if ki_st_open_w.flag_primo_giro = "S" then  //solo la prima volta il tasto e' false 

		k_importa = kGuf_data_base.dw_importfile(trim(ki_syntaxquery), dw_lista_0)

	end if
		
	if k_importa <= 0 then // Nessuna importazione eseguita
		k_riga_sel = dw_lista_0.getselectedrow(0)  // x riposizionarsi sulla riga
		if dw_lista_0.retrieve(ki_data_ini, ki_data_fin, ki_id_cliente) < 1 then
			k_return = "1Nessun Documento per il periodo: " + string(ki_data_ini) + " - " + string(ki_data_fin)

			SetPointer(oldpointer)
			messagebox("Elenco Documenti", &
					"Nessuna Documento per il periodo: " + string(ki_data_ini) + " - " + string(ki_data_fin))
		else
			if k_riga_sel > 0 then
				dw_lista_0.selectrow( k_riga_sel, true)
			end if
		end if		
	end if

	attiva_tasti()

return k_return


end function

protected subroutine attiva_menu ();//--- Attiva/Dis. Voci di menu


//
//--- Attiva/Dis. Voci di menu personalizzate
//
	if not ki_menu.m_strumenti.m_fin_gest_libero1.visible then
	
		ki_menu.m_strumenti.m_fin_gest_libero1.text = "Cambia il periodo di estrazione elenco (decorrenza)"
		ki_menu.m_strumenti.m_fin_gest_libero1.microhelp =  "Cambia periodo di estrazione elenco"
		ki_menu.m_strumenti.m_fin_gest_libero1.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemText = "Periodo,"+ki_menu.m_strumenti.m_fin_gest_libero1.text
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritemName = "Custom015!"
		ki_menu.m_strumenti.m_fin_gest_libero1.toolbaritembarindex=2
		
		
		ki_menu.m_strumenti.m_fin_gest_libero2.text = "Stampa documenti selezionati"
		ki_menu.m_strumenti.m_fin_gest_libero2.microhelp =  "Stampa documenti selezionati"
		ki_menu.m_strumenti.m_fin_gest_libero2.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemText = "Stampa,"+ki_menu.m_strumenti.m_fin_gest_libero2.text
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = "printer16x16.gif"
//		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritemName = kGuo_path.get_risorse() + "\printer16x16.gif"
		ki_menu.m_strumenti.m_fin_gest_libero2.toolbaritembarindex=2
		
		
		ki_menu.m_strumenti.m_fin_gest_libero4.text = "Crea Listino dal Contratto"
		ki_menu.m_strumenti.m_fin_gest_libero4.microhelp =  "Trasferisci documenti nel Listino"
		ki_menu.m_strumenti.m_fin_gest_libero4.visible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.enabled = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemVisible = true
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemText = "Crea,"+ki_menu.m_strumenti.m_fin_gest_libero4.text
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = "Custom079!"
//		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritemName = kGuo_path.get_risorse() + "\printer16x16.gif"
		ki_menu.m_strumenti.m_fin_gest_libero4.toolbaritembarindex=2

	end if

//---
	super::attiva_menu()


end subroutine

protected subroutine smista_funz (string k_par_in);//
//===

choose case k_par_in


	case kkg_flag_richiesta.libero1		//cambia data di estrazione
		cambia_periodo_elenco()

	case kkg_flag_richiesta.libero2		//stampa fatture
		stampa_doc()

	case kkg_flag_richiesta.libero4		//genera listino e co da contratti
		call_crea_listino()

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


	ki_toolbar_window_presente=true

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
//			ki_data_fin = kg_dataoggi
			ki_data_fin = date(2099, 12, 31)
		end if
	else
		ki_data_fin = date(2099, 12, 31)
//		ki_data_fin = kg_dataoggi
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
			
				if not isnull(kst_tab_contratti_rd) and kst_tab_contratti_rd[k_idx].id_contratto_rd > 0 then
				
					if dw_stampa.object.rb_stampa[1] = 0 then
						
						kiuf_contratti_rd.stampa_documento_prova( kst_tab_contratti_rd [k_idx])
					else
						
						kiuf_contratti_rd.stampa_documento_definitiva(  kst_tab_contratti_rd [k_idx])
					end if
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
//--- Visualizza il box x di stampa 
//---

dw_stampa.event ue_visibile(not dw_stampa.visible)

end subroutine

private function any popola_array_da_lista ();//---
//--- riempie la  ds_fatture  da dw di elenco
//---
long k_riga, k_riga_ds
st_tab_contratti_rd kst_tab_contratti_rd [] 



for k_riga = 1 to dw_lista_0.rowcount()

//--- se selezionata la metto da stampare
	if dw_lista_0.IsSelected ( k_riga)   then

		if dw_lista_0.getitemnumber(k_riga, "id_contratto_rd") > 0 then

			k_riga_ds ++
			kst_tab_contratti_rd[k_riga_ds].id_contratto_rd = dw_lista_0.getitemnumber(k_riga, "id_contratto_rd")
			
		end if			
	end if		
	
end for


return kst_tab_contratti_rd[]

end function

public subroutine call_crea_listino ();//
//
kuf_contratti_rd_to_lis kuf1_contratti_rd

//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key= vedi sotto
	st_open_w k_st_open_w

	kuf1_contratti_rd = create kuf_contratti_rd_to_lis
	
	
	K_st_open_w.flag_modalita = kkg_flag_modalita.elenco
	K_st_open_w.id_programma = kuf1_contratti_rd.get_id_programma( K_st_open_w.flag_modalita ) 
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = " " 
	K_st_open_w.key2 = " " //
	K_st_open_w.key3 = " " // 
	K_st_open_w.key4 = " " // 
	K_st_open_w.key5 = " " //
	K_st_open_w.key6 = " " //
	K_st_open_w.flag_where = " "
	
	kGuf_menu_window.open_w_tabelle(k_st_open_w)
								
	destroy kuf1_contratti_rd
	
end subroutine

private subroutine call_memo_old ();//
//=== Legge il rek dalla DW lista per la modifica
long k_riga
st_tab_clienti_memo kst_tab_clienti_memo 
kuf_clienti kuf1_clienti
st_memo kst_memo
kuf_memo kuf1_memo
kuf_memo_inout kuf1_memo_inout

try   
	k_riga = dw_lista_0.getrow()
	if k_riga > 0 then
	
		kuf1_clienti = create kuf_clienti
	
		kst_tab_clienti_memo.id_cliente_memo = dw_lista_0.getitemnumber( k_riga, "id_cliente_memo" ) 
//		if kst_tab_clienti_memo.id_cliente_memo > 0 then
//			kuf1_clienti.get_id_memo(kst_tab_clienti_memo)
//		else
			kst_tab_clienti_memo.id_memo = 0
//		end if
		kst_tab_clienti_memo.id_cliente = dw_lista_0.getitemnumber( k_riga, "id_cliente" ) 
			
		if kst_tab_clienti_memo.id_cliente  > 0 then
			kuf1_memo = create kuf_memo
			kuf1_memo_inout = create kuf_memo_inout
			kst_tab_clienti_memo.tipo_sv = ki_st_open_w.sr_settore //kuf1_memo.kki_tipo_sv_CCO
			kst_memo.st_tab_clienti_memo = kst_tab_clienti_memo
			kuf1_memo_inout.memo_xcliente(kst_memo.st_tab_clienti_memo, kst_memo.st_tab_memo)
			kuf1_memo.u_attiva_funzione(kst_memo,kkg_flag_modalita.inserimento )   // APRE FUNZIONE
			
		end if
	end if 
		
catch (uo_exception	kuo_exception)
	kuo_exception.messaggio_utente()
		
end try
	


end subroutine

on w_contratti_rd_l.create
int iCurrent
call super::create
this.dw_periodo=create dw_periodo
this.dw_stampa=create dw_stampa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_periodo
this.Control[iCurrent+2]=this.dw_stampa
end on

on w_contratti_rd_l.destroy
call super::destroy
destroy(this.dw_periodo)
destroy(this.dw_stampa)
end on

event close;call super::close;//
if isvalid(kiuf_contratti_rd) then destroy kiuf_contratti_rd

end event

type st_ritorna from w_g_tab0`st_ritorna within w_contratti_rd_l
end type

type st_ordina_lista from w_g_tab0`st_ordina_lista within w_contratti_rd_l
integer x = 1262
integer y = 1388
end type

type st_aggiorna_lista from w_g_tab0`st_aggiorna_lista within w_contratti_rd_l
end type

type cb_ritorna from w_g_tab0`cb_ritorna within w_contratti_rd_l
integer x = 2427
integer y = 1160
integer height = 92
integer taborder = 90
boolean cancel = true
end type

type st_stampa from w_g_tab0`st_stampa within w_contratti_rd_l
end type

type cb_visualizza from w_g_tab0`cb_visualizza within w_contratti_rd_l
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
if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if

k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
	kst_tab_contratti_rd.id_cliente = dw_lista_0.getitemnumber( k_riga, "id_cliente") 
	kst_tab_contratti_rd.id_contratto_rd = dw_lista_0.getitemnumber( k_riga, "id_contratto_rd") 
//else
//	if len(trim(ki_st_open_w.key1)) > 0 then
//		kst_tab_contratti_rd.id_cliente = long(trim(ki_st_open_w.key1))
//	end if
end if
	

if dw_lista_0.getselectedrow(0) > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
	K_st_open_w.id_programma = kiuf_contratti_rd.get_id_programma(K_st_open_w.flag_modalita)
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_contratti_rd.id_contratto_rd)) // id cont
	K_st_open_w.key2 = "0" //trim(string(kst_tab_contratti_rd.id_cliente)) // cod cliente
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

type cb_modifica from w_g_tab0`cb_modifica within w_contratti_rd_l
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
if dw_lista_0.getselectedrow(0) = 0 then 
	if dw_lista_0.getrow() > 0 then 
		dw_lista_0.selectrow(dw_lista_0.getrow(), true)
	end if
end if

k_riga = dw_lista_0.getselectedrow(0)
if k_riga > 0 then
	kst_tab_contratti_rd.id_cliente = dw_lista_0.getitemnumber( k_riga, "id_cliente") 
	kst_tab_contratti_rd.id_contratto_rd = dw_lista_0.getitemnumber( k_riga, "id_contratto_rd") 
//else
//	if len(trim(ki_st_open_w.key1)) > 0 then
//		kst_tab_contratti_rd.id_contratto_rd = dw_lista_0.getitemnumber( k_riga, "id_contratto_rd") 
//		kst_tab_contratti_rd.id_cliente = long(trim(ki_st_open_w.key1))
//	end if
end if
	

if k_riga > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.modifica
	K_st_open_w.id_programma = kiuf_contratti_rd.get_id_programma(K_st_open_w.flag_modalita)
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_contratti_rd.id_contratto_rd)) // id cont
	K_st_open_w.key2 = "0" //trim(string(kst_tab_contratti_rd.id_cliente)) // cod cliente
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

type cb_aggiorna from w_g_tab0`cb_aggiorna within w_contratti_rd_l
integer x = 1134
integer y = 1160
integer height = 96
integer taborder = 100
end type

type cb_cancella from w_g_tab0`cb_cancella within w_contratti_rd_l
integer x = 2121
integer y = 1164
integer height = 96
integer taborder = 80
end type

type cb_inserisci from w_g_tab0`cb_inserisci within w_contratti_rd_l
integer x = 1467
integer y = 1156
integer height = 96
integer taborder = 60
boolean enabled = false
end type

event cb_inserisci::clicked;//
long k_riga=0
st_tab_contratti_rd kst_tab_contratti_rd
st_open_w k_st_open_w
kuf_menu_window kuf1_menu_window


kst_tab_contratti_rd.id_contratto_rd =0
kst_tab_contratti_rd.id_cliente = 0
//
//k_riga = dw_lista_0.getselectedrow(0)
//if k_riga > 0 then
//	kst_tab_contratti_rd.id_cliente = dw_lista_0.getitemnumber( k_riga, "id_cliente") 
//	kst_tab_contratti_rd.id_contratto_rd = dw_lista_0.getitemnumber( k_riga, "id_contratto_rd") 
//else
	if len(trim(ki_st_open_w.key1)) > 0 then
		kst_tab_contratti_rd.id_cliente = long(trim(ki_st_open_w.key1))
	end if
//end if
	

//if dw_lista_0.getrow() > 0 then
//
//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
	K_st_open_w.flag_modalita = kkg_flag_modalita.inserimento
	K_st_open_w.id_programma = kiuf_contratti_rd.get_id_programma(K_st_open_w.flag_modalita)
	K_st_open_w.flag_primo_giro = "S"
	K_st_open_w.flag_adatta_win = KKG.ADATTA_WIN
	K_st_open_w.flag_leggi_dw = " "
	K_st_open_w.flag_cerca_in_lista = " "
	K_st_open_w.key1 = trim(string(kst_tab_contratti_rd.id_contratto_rd)) // id cont
	K_st_open_w.key2 = trim(string(kst_tab_contratti_rd.id_cliente)) // cod cliente
	K_st_open_w.key3 = " " 
	K_st_open_w.flag_where = " "
	
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(k_st_open_w)
	destroy kuf1_menu_window

								
//else
//
//	messagebox("Operazione non eseguita", "Selezionare una riga dalla lista")
//
//end if

return (0)
end event

type dw_dett_0 from w_g_tab0`dw_dett_0 within w_contratti_rd_l
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

type st_orizzontal from w_g_tab0`st_orizzontal within w_contratti_rd_l
integer x = 0
integer y = 1760
end type

type dw_lista_0 from w_g_tab0`dw_lista_0 within w_contratti_rd_l
integer width = 2807
integer height = 708
integer taborder = 120
string dataobject = "d_contratti_rd_l"
borderstyle borderstyle = stylelowered!
end type

type dw_guida from w_g_tab0`dw_guida within w_contratti_rd_l
end type

type dw_periodo from uo_d_std_1 within w_contratti_rd_l
integer x = 114
integer y = 684
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
	this.modify("data_al.protect='1'")
	this.modify("data_al.background.color='"+string(kkg_colore.grigio)+"'")
	this.visible = true
	this.setfocus()
end event

type dw_stampa from uo_d_std_1 within w_contratti_rd_l
integer x = 160
integer y = 1148
integer width = 1033
integer height = 504
integer taborder = 80
boolean bringtotop = true
boolean enabled = true
boolean titlebar = true
string title = "Stampa e Aggiorna"
string dataobject = "d_stampa"
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
	
	oldpointer = SetPointer(HourGlass!)
	
	stampa_doc_lancia()
	
	if dw_stampa.object.rb_stampa[1] = 1 then  // se definitiva rilegge 
	
		inizializza()
		
	end if

else
	if dwo.name = "b_annulla" then

		this.visible = false
	
	
	end if
end if

SetPointer(oldpointer)


end event

event ue_visibile;call super::ue_visibile;//
int k_rc

	this.width = long(this.object.rb_stampa.x) + long(this.object.rb_stampa.width) + 100
	this.height = long(this.object.b_ok.y) + long(this.object.b_ok.height) + 160

	this.x = (kiw_this_window.width  - this.width) / 4
	this.y = (kiw_this_window.height - this.height) / 4

	this.reset()
	k_rc = this.insertrow(0)
	
	this.visible = true
	this.setfocus()
end event

