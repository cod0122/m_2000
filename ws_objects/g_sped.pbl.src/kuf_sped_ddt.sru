$PBExportHeader$kuf_sped_ddt.sru
forward
global type kuf_sped_ddt from nonvisualobject
end type
end forward

global type kuf_sped_ddt from nonvisualobject
end type
global kuf_sped_ddt kuf_sped_ddt

type variables
//
//OLD public string ki_dw_stampa_ddt = "d_ddt_st_ed1_08_2009"  
public string ki_dw_stampa_ddt = "d_ddt_st_ed7_10_2019" //"d_ddt_st_ed5_05_2016" //"d_ddt_st_ed4_09_2015" //"d_ddt_st_ed3_05_2011" //"d_ddt_st_ed2_08_2010"
private  st_ddt_stampa kist_ddt_stampa[]
public datastore kids_stampa_ddt
private kuf_sped kiuf_sped


private int ki_ddt_riga_corpo = 0
private constant int ki_ddt_riga_corpo_max= 19 //22 OLD
private string ki_stampante_predefinita = " "
private int ki_pag_ddt=0
private string ki_path_risorse=""


//--- Tipologia della copia
public constant int kki_tipo_num_copie_generica = 1 //stampa singola
public constant int kki_tipo_num_copie_doppia = 2   //stampa ricevente+interna
public constant int kki_tipo_num_copie_tripla = 3 		 //stampa ricevente+interna+cliente 
public constant int kki_tipo_num_copie_doppia_c = 5  //stampa ricevente+interna+cliente se diverso da ricev
//private int ki_tipo_stampa = 5
private string ki_tipo_stampa=""
private constant string kki_tipo_stampa_Generica = "G"	
private constant string kki_tipo_stampa_x_Ricevente = "R"  
private constant string kki_tipo_stampa_Interna = "I"   
private constant string kki_tipo_stampa_x_Vettore = "C"

end variables

forward prototypes
private function long produci_ddt_riga_add ()
public subroutine produci_ddt_fine ()
public function boolean produci_ddt_open ()
public function st_esito set_ddt_stampato_su_base ()
public function integer stampa_ddt (st_ddt_stampa kst_ddt_stampa[]) throws uo_exception
public function boolean stampa_ddt_emissione (string titolo) throws uo_exception
public function long produci_ddt_nuova_pagina ()
private function long produci_ddt_get_pagina ()
public function boolean produci_ddt_riga (ref ds_ddt_stampa kds_ddt_stampa, long k_riga_ds) throws uo_exception
public function boolean produci_ddt_piede (ref ds_ddt_stampa kds_ddt_stampa, long k_riga_dw) throws uo_exception
public function boolean produci_ddt_testa (ref ds_ddt_stampa kds_ddt_stampa, long k_riga_dw) throws uo_exception
public function st_esito produci_ddt_set_dw_loghi (ref datastore kds_ok, ref datawindow kdw_ok)
private function st_esito set_wm_pklist_righe (ref st_tab_sped kst_tab_sped, boolean k_set_spedito)
public function st_esito set_wm_pklist_righe_non_spedito (st_tab_sped kst_tab_sped)
public function st_esito set_wm_pklist_righe_spedito (st_tab_sped kst_tab_sped)
public function integer stampa_ddt_nuovo (st_ddt_stampa kst_ddt_stampa[]) throws uo_exception
public function integer produci_ddt (ref st_ddt_stampa kst_ddt_stampa[]) throws uo_exception
public function integer stampa_ddt_bianco () throws uo_exception
public subroutine produci_ddt_inizializza (ref st_tab_sped kst_tab_sped) throws uo_exception
public subroutine produci_ddt_inizio () throws uo_exception
public function boolean get_form_di_stampa (ref st_tab_sped kst_tab_sped) throws uo_exception
public function boolean set_form_di_stampa (st_tab_sped kst_tab_sped) throws uo_exception
public function integer stampa_ddt_esporta_digitale (st_docprod_esporta kst_docprod_esporta) throws uo_exception
public function boolean produci_ddt_riga_pagamento (ref ds_ddt_stampa kds_ddt_stampa, long k_riga_ds) throws uo_exception
public function st_esito set_ddt_aggiorna (st_ddt_stampa kst_ddt_stampa[])
private function boolean set_armo_prezzi_righe (ref st_tab_sped ast_tab_sped, boolean a_ripristino) throws uo_exception
public function boolean set_armo_prezzi_righe_all (ref st_tab_sped ast_tab_sped[], boolean a_ripristino) throws uo_exception
public function boolean if_stampato (st_tab_sped ast_tab_sped) throws uo_exception
public function boolean produci_ddt_riga_note_qtna (ref ds_ddt_stampa kds_ddt_stampa, long k_riga_ds) throws uo_exception
end prototypes

private function long produci_ddt_riga_add ();//--- 
//---  Aggiunge riga e controlla se FINE Pagina fa il salto
//---  Torna con il Numero Pagina e intanto incrementa la variabile d'Istanza del Numero di Riga 
//---
long k_pagina 


	ki_ddt_riga_corpo++

//--- se supero il nr-massimo di righe per facciata faccio salto pagina	
	if ki_ddt_riga_corpo > ki_ddt_riga_corpo_max then

//--- Nuova PAGINA		
		k_pagina=produci_ddt_nuova_pagina()

		ki_ddt_riga_corpo = 1
		
	else

//--- piglia la riga ( che e' poi il numero pagina del ddt in elaborazione)
		k_pagina = produci_ddt_get_pagina()		
		
	end if



return k_pagina


end function

public subroutine produci_ddt_fine ();//

if isvalid(kids_stampa_ddt) then destroy kids_stampa_ddt


end subroutine

public function boolean produci_ddt_open ();//---
//--- Apre l'output di stampa
//---
boolean k_return=true
kuf_base kuf1_base		


	kuf1_base = create kuf_base
		
//--- piglia la stampante del ddt	
	ki_stampante_predefinita = trim(mid(kuf1_base.prendi_dato_base( "stamp_ddt"),2))


	destroy kuf1_base


return k_return
end function

public function st_esito set_ddt_stampato_su_base ();//
//--- Aggiorna a il Numero e Data del d.d.t. stampato su BASE
//---
//--- input: -
//---                 
//--- Out: kst_esito 
//---
//
st_esito kst_esito
st_tab_arsp kst_tab_arsp
st_tab_sped kst_tab_sped
st_tab_base kst_tab_base
kuf_base kuf1_base


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
//--- piglio i dati dell'ultimo documento
	kst_tab_sped.clie_2 = 0
	kst_esito = kiuf_sped.get_ultimo_doc(kst_tab_sped)		

//--- Aggiorno numero e data di stampa sul base
	if kst_esito.esito = kkg_esito.ok then
		kuf1_base = create kuf_base 
		kst_tab_base.st_tab_g_0.esegui_commit = "S"
		kst_tab_base.key = "num_ddt_stamp"
		kst_tab_base.key1 = string(kst_tab_sped.num_bolla_out)
		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
		kst_tab_base.st_tab_g_0.esegui_commit = "S"
		kst_tab_base.key = "data_ddt_stamp"
		kst_tab_base.key1 = string(kst_tab_sped.data_bolla_out)
		kst_esito  = kuf1_base.metti_dato_base(kst_tab_base)
		destroy kuf1_base 
	end if
			

	

return kst_esito


end function

public function integer stampa_ddt (st_ddt_stampa kst_ddt_stampa[]) throws uo_exception;//
//--- stampa DDT (RISTAMPA)
//--- input:  st_ddt_stampa (struttura con elenco dei ddt)
//--- out: Numero ddt prodotti
//---
boolean k_stampato=true, k_sicurezza=true
int k_ctr=0, k_n_ddt_stampati=0
st_esito kst_esito 
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = kiuf_sped.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_sicurezza then
		k_stampato = false
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Stampa D.D.T. non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
	
	end if
	
	if upperbound(kst_ddt_stampa[]) > 0 then

//
//---- Crea oggetto x stampa 
		produci_ddt_inizio()

//--- produci stampa
		k_n_ddt_stampati = produci_ddt(kst_ddt_stampa[])
	
		if k_n_ddt_stampati > 0 then

//=== stampa dw
			k_stampato=stampa_ddt_emissione( trim("N. spedizione da " &
						 + trim(string(kst_ddt_stampa[1].num_bolla_out)) + " del " + trim(string(kst_ddt_stampa[1].data_bolla_out)))) 
	
			if not k_stampato then k_n_ddt_stampati = 0
		end if
		
//--- distrugge oggetti x stampa 
		produci_ddt_fine()

		
	end if
	



return k_n_ddt_stampati

end function

public function boolean stampa_ddt_emissione (string titolo) throws uo_exception;//
//--- stampa ddt - richiama il gestore delle stampa
//--- input:  titolo     un titolo per la stampa
//--- out: true = OK, false = non stampata
//---
boolean k_stampato=true
int k_errore=0, k_rc
st_stampe kst_stampe


try

	if kids_stampa_ddt.rowcount() > 0 then

		kst_stampe.tipo = kuf_stampe.ki_stampa_tipo_datastore_diretta
		kst_stampe.ds_print = create datastore
		kst_stampe.ds_print.dataobject = kids_stampa_ddt.dataobject
		kids_stampa_ddt.rowscopy( 1, kids_stampa_ddt.rowcount() , primary!, kst_stampe.ds_print, 1, primary!)
//		kst_stampe.ds_print = kids_stampa_ddt

		kst_stampe.titolo = trim(titolo)
		kst_stampe.titolo_2 = "DDT_" + string(kids_stampa_ddt.getitemnumber(1, "num_bolla_out_1")) + "_" + string(kids_stampa_ddt.getitemdate(1, "data_bolla_out"), "ddmmmyy")
		kst_stampe.stampante_predefinita = ki_stampante_predefinita
		kst_stampe.modificafont = kuf_stampe.ki_stampa_modificafont_no

//		k_errore = kGuf_data_base.st stampa_dw(kst_stampe)

		k_errore = kGuf_data_base.stampa_dw(kst_stampe)
		if k_errore <> 0 then
			kguo_exception.setmessage( "Si è verificato un problema durante l'apertura della Window di stampa. Controlla il tuo 'log' da menu M2000->Proprieta. Grazie. ")
			kguo_exception.messaggio_utente( )		
		end if
		
	end if
	
finally
	
end try

return k_stampato

end function

public function long produci_ddt_nuova_pagina ();//---
//--- Ripete la Testata della Pagina Precedente
//---
long k_pagina, k_pagina_prec
int k_rc


//--- imposta il dw
k_pagina = kids_stampa_ddt.insertrow( 0 ) 
   
if k_pagina > 1 then
		
	kids_stampa_ddt.setrow(k_pagina)   
	k_pagina_prec = k_pagina - 1
	ki_pag_ddt++

//--- Numero di Pagina	
	kids_stampa_ddt.setitem(k_pagina, "pagina",  "Pagina: " + string(ki_pag_ddt))  

//--- Tipo Copia
	kids_stampa_ddt.setitem(k_pagina, "tipo_copia",  kids_stampa_ddt.object.tipo_copia[k_pagina_prec])  

//--- riga indirizzo 
      kids_stampa_ddt.setitem(k_pagina, "dicit_ind_intest",  kids_stampa_ddt.object.dicit_ind_intest[k_pagina_prec])  
      kids_stampa_ddt.setitem(k_pagina, "dicit_ind_sped",  kids_stampa_ddt.object.dicit_ind_sped[k_pagina_prec])  

      kids_stampa_ddt.setitem(k_pagina, "intestazione",  kids_stampa_ddt.object.intestazione[k_pagina_prec])  
      kids_stampa_ddt.setitem(k_pagina, "intestazione_ind",  kids_stampa_ddt.object.intestazione_ind[k_pagina_prec])  

      kids_stampa_ddt.setitem(k_pagina, "indirizzo_riga_1",  kids_stampa_ddt.object.indirizzo_riga_1[k_pagina_prec])  
      kids_stampa_ddt.setitem(k_pagina, "indirizzo_riga_2",  kids_stampa_ddt.object.indirizzo_riga_2[k_pagina_prec])  
      kids_stampa_ddt.setitem(k_pagina, "indirizzo_riga_3",  kids_stampa_ddt.object.indirizzo_riga_3[k_pagina_prec])  
      kids_stampa_ddt.setitem(k_pagina, "indirizzo_riga_4",  kids_stampa_ddt.object.indirizzo_riga_4[k_pagina_prec])  
      kids_stampa_ddt.setitem(k_pagina, "indirizzo_riga_5",  kids_stampa_ddt.object.indirizzo_riga_5[k_pagina_prec])  

      kids_stampa_ddt.setitem(k_pagina, "num_bolla_out_1",  kids_stampa_ddt.object.num_bolla_out_1[k_pagina_prec])  
      kids_stampa_ddt.setitem(k_pagina, "data_bolla_out",  kids_stampa_ddt.object.data_bolla_out[k_pagina_prec])  
      kids_stampa_ddt.setitem(k_pagina, "clie_2",  kids_stampa_ddt.object.clie_2[k_pagina_prec])  
      kids_stampa_ddt.setitem(k_pagina, "clie_3",  kids_stampa_ddt.object.clie_3[k_pagina_prec])  
      kids_stampa_ddt.setitem(k_pagina, "causale",  kids_stampa_ddt.object.causale[k_pagina_prec])  
      kids_stampa_ddt.setitem(k_pagina, "trasporto",  kids_stampa_ddt.object.trasporto[k_pagina_prec])  

else
   k_pagina = 0
end if

return k_pagina

end function

private function long produci_ddt_get_pagina ();//--- 
//---  Torna il Numero Pagina 
//---
long k_riga 


//--- piglia la riga ( che e' poi il numero pagina del DDT in elaborazione)
	k_riga = kids_stampa_ddt.getrow(  ) 
		

return k_riga


end function

public function boolean produci_ddt_riga (ref ds_ddt_stampa kds_ddt_stampa, long k_riga_ds) throws uo_exception;//---
//--- Corpo ddt: Riga di Dettaglio
//---
boolean k_return=true
constant integer k_note_totali_len_riga = 73
string k_stampante, k_note_totali
long k_pagina
integer k_ctr, k_nrbarcode_trattati
integer k_ufo
double k_differernza
kuf_base kuf1_base		
st_esito kst_esito
st_tab_clienti kst_tab_clienti
st_tab_barcode kst_tab_barcode
kuf_clienti kuf1_clienti
kuf_barcode kuf1_barcode 


//--- aggiungo Riga e controllo Fine Pagina	
k_pagina = produci_ddt_riga_add() 
if k_pagina = 0 then 
	kst_esito.esito = kkg_esito.err_logico
	kst_esito.sqlcode = 0
	kst_esito.sqlerrtext = "Errore numero riga durante produzione stampa d.d.t."
	kst_esito.nome_oggetto = this.classname()
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

//--- Qta'	
kids_stampa_ddt.setitem(k_pagina, "qta_" + string(ki_ddt_riga_corpo), kds_ddt_stampa.object.arsp_colli[k_riga_ds])

if  kds_ddt_stampa.object.armo_dose[k_riga_ds] > 0 then
//--- descrizione	
	kids_stampa_ddt.setitem(k_pagina, "descr_" + string(ki_ddt_riga_corpo), "Colli contenenti come dichiarato dal cliente ")

//--- get del nr barcode trattati
	kst_tab_barcode.id_meca =  kds_ddt_stampa.object.meca_id_meca[k_riga_ds]
	if not isvalid(kuf1_barcode) then kuf1_barcode = create kuf_barcode
	k_nrbarcode_trattati = kuf1_barcode.get_nr_barcode_trattati_x_id_meca(kst_tab_barcode)
//---  se non ci sono barcode trattati non espone i KGY
	if k_nrbarcode_trattati > 0 then
//---  Kgy (dose) -- formatta senza far vedere i decimali se non necessario
		k_differernza = (kds_ddt_stampa.object.armo_dose[k_riga_ds] -  int(kds_ddt_stampa.object.armo_dose[k_riga_ds])) 
		if k_differernza <> 0 then
			kids_stampa_ddt.setitem(k_pagina, "kgy_" + string(ki_ddt_riga_corpo), string(kds_ddt_stampa.object.armo_dose[k_riga_ds], "###0.00") )
		else
			kids_stampa_ddt.setitem(k_pagina, "kgy_" + string(ki_ddt_riga_corpo), string(kds_ddt_stampa.object.armo_dose[k_riga_ds], "######") )
		end if
	end if
end if

if isnull(kds_ddt_stampa.object.arsp_note_1[k_riga_ds] ) then kds_ddt_stampa.object.arsp_note_1[k_riga_ds] = ""
if isnull(kds_ddt_stampa.object.arsp_note_2[k_riga_ds] ) then kds_ddt_stampa.object.arsp_note_2[k_riga_ds] = ""
if isnull(kds_ddt_stampa.object.arsp_note_3[k_riga_ds] ) then kds_ddt_stampa.object.arsp_note_3[k_riga_ds] = ""
//--- se caricate descrizioni uguali, una viene cancellata
if trim(kds_ddt_stampa.object.arsp_note_1[k_riga_ds] ) = trim(kds_ddt_stampa.object.arsp_note_2[k_riga_ds]) then
	kds_ddt_stampa.object.arsp_note_2[k_riga_ds] = ""
end if
if trim(kds_ddt_stampa.object.arsp_note_2[k_riga_ds] ) = trim(kds_ddt_stampa.object.arsp_note_3[k_riga_ds]) then
	kds_ddt_stampa.object.arsp_note_3[k_riga_ds] = ""
end if

//--- descrizione (note riga 1)	
k_note_totali = ""
if len(trim(kds_ddt_stampa.object.arsp_note_1[k_riga_ds] )+ trim(kds_ddt_stampa.object.arsp_note_2[k_riga_ds] ) ) > 0 then
////--- aggiungo riga e controllo Fine Pagina	
//	k_pagina = produci_ddt_riga_add() 
//	if k_pagina = 0 then 
//		kst_esito.esito = kkg_esito.err_logico
//		kst_esito.sqlcode = 0
//		kst_esito.sqlerrtext = "Errore numero riga durante produzione stampa d.d.t."
//		kst_esito.nome_oggetto = this.classname()
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if

	if len(trim(kds_ddt_stampa.object.arsp_note_1[k_riga_ds] ) ) > 0 then
		k_note_totali = RightTrim(kds_ddt_stampa.object.arsp_note_1[k_riga_ds]) + " " + RightTrim(kds_ddt_stampa.object.arsp_note_2[k_riga_ds] )
//		kids_stampa_ddt.setitem(k_pagina, "descr_" + string(ki_ddt_riga_corpo), trim(kds_ddt_stampa.object.arsp_note_1[k_riga_ds]) + " " + trim(kds_ddt_stampa.object.arsp_note_2[k_riga_ds] ))
	else
		k_note_totali = RightTrim(kds_ddt_stampa.object.arsp_note_2[k_riga_ds] )
//		kids_stampa_ddt.setitem(k_pagina, "descr_" + string(ki_ddt_riga_corpo), trim(kds_ddt_stampa.object.arsp_note_2[k_riga_ds] ))
	end if

end if

//--- descrizione (note riga 3)	
if len(trim(kds_ddt_stampa.object.arsp_note_3[k_riga_ds] )) > 0 then

////--- aggiungo riga e controllo Fine Pagina	
//	k_pagina = produci_ddt_riga_add() 
//	if k_pagina = 0 then 
//		kst_esito.esito = kkg_esito.err_logico
//		kst_esito.sqlcode = 0
//		kst_esito.sqlerrtext = "Errore numero riga durante produzione stampa d.d.t."
//		kst_esito.nome_oggetto = this.classname()
//		kguo_exception.set_esito(kst_esito)
//		throw kguo_exception
//	end if
	
	k_note_totali +=  " " + RightTrim(kds_ddt_stampa.object.arsp_note_3[k_riga_ds])
//	kids_stampa_ddt.setitem(k_pagina, "descr_" + string(ki_ddt_riga_corpo), trim(kds_ddt_stampa.object.arsp_note_3[k_riga_ds]) )
end if
		
		
//--- descrizione (10 note di ARMO_NT)	
for k_ctr = 1 to 10 step 2

	if isnull(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr)) ) then kds_ddt_stampa.setitem(k_riga_ds, "armo_nt_note_" + string(k_ctr), "")
	if isnull(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr + 1)) ) then kds_ddt_stampa.setitem(k_riga_ds, "armo_nt_note_" + string(k_ctr + 1), "")
//--- se descrizioni uguali una viene cancellata
	if trim(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr)) ) = trim(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr +1)) ) then
		 kds_ddt_stampa.setitem(k_riga_ds, "armo_nt_note_" + string(k_ctr + 1), "")
	end if
	
	if len(trim(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr))) + trim(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr + 1))) ) > 0 then
	
////--- aggiungo riga e controllo Fine Pagina	
//		k_pagina = produci_ddt_riga_add() 
//		if k_pagina = 0 then 
//			kst_esito.esito = kkg_esito.err_logico
//			kst_esito.sqlcode = 0
//			kst_esito.sqlerrtext = "Errore numero riga durante produzione stampa d.d.t."
//			kst_esito.nome_oggetto = this.classname()
//			kguo_exception.set_esito(kst_esito)
//			throw kguo_exception
//		end if

//--- se le note hanno qlc aggiungo uno spazio x separare
		if len(k_note_totali) > 0 then
			k_note_totali += " "
		end if

		if len(trim(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr))) + trim(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr + 1))) ) > 0 then

			k_note_totali += RightTrim(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr)) ) + " " + RightTrim(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr + 1)) )
//			kids_stampa_ddt.setitem(k_pagina, "descr_" + string(ki_ddt_riga_corpo), trim(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr)) ) + " " + trim(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr + 1)) ))
		else
			k_note_totali += RightTrim(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr + 1)) )
//			kids_stampa_ddt.setitem(k_pagina, "descr_" + string(ki_ddt_riga_corpo), trim(kds_ddt_stampa.getitemstring(k_riga_ds, "armo_nt_note_" + string(k_ctr + 1)) ))
		end if
		
	end if

next
		
//--- stampa le NOTE 
if len(trim(k_note_totali)) > 0 then
	
	k_note_totali = trim(k_note_totali)
	
	for k_ctr = 1 to len(k_note_totali) step 73 //--- attenzione se modifichi questo modifica anche k_note_totali_len_riga

//--- aggiungo riga e controllo Fine Pagina	
		k_pagina = produci_ddt_riga_add() 
		if k_pagina = 0 then 
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Errore numero riga durante produzione stampa d.d.t."
			kst_esito.nome_oggetto = this.classname()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		
		if (k_ctr + k_note_totali_len_riga) > len(k_note_totali) then 
			kids_stampa_ddt.setitem(k_pagina, "descr_" + string(ki_ddt_riga_corpo), mid(k_note_totali, k_ctr, len(k_note_totali) - k_ctr + 1))
		else
			kids_stampa_ddt.setitem(k_pagina, "descr_" + string(ki_ddt_riga_corpo), mid(k_note_totali, k_ctr, k_note_totali_len_riga ))
		end if
	end for
end if

	
 //--- Se merce che non e' da trattare stampa descrizione articolo
 if  kds_ddt_stampa.object.armo_dose[k_riga_ds] = 0 and trim(kds_ddt_stampa.object.prodotti_des[k_riga_ds] ) > " " then
//--- aggiungo riga e controllo Fine Pagina	
	k_pagina = produci_ddt_riga_add() 
	if k_pagina = 0 then 
		kst_esito.esito = kkg_esito.err_logico
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Errore numero riga durante produzione stampa d.d.t."
		kst_esito.nome_oggetto = this.classname()
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
		
	kids_stampa_ddt.setitem(k_pagina, "descr_" + string(ki_ddt_riga_corpo), trim(kds_ddt_stampa.object.prodotti_des[k_riga_ds] ))
end if	

//--- Bolla Mandante da non stampare se indicato in CAUSALE di SPED
if trim(kds_ddt_stampa.object.sped_ddt_st_num_data_in[k_riga_ds]) = kiuf_sped.kki_ddt_st_num_data_in_NO then
else
	if len(trim(kds_ddt_stampa.object.meca_num_bolla_in[k_riga_ds])) > 0 then
	
	//--- aggiungo riga e controllo Fine Pagina	
		k_pagina = produci_ddt_riga_add() 
		if k_pagina = 0 then 
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Errore numero riga durante produzione stampa d.d.t."
			kst_esito.nome_oggetto = this.classname()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
		//--- stampo il numero bolla di entrata 
		kids_stampa_ddt.setitem(k_pagina, "descr_" + string(ki_ddt_riga_corpo), "D.d.t. nr.  " + upper(trim(kds_ddt_stampa.object.meca_num_bolla_in[k_riga_ds])) + "  del  " &
											+ string(kds_ddt_stampa.object.meca_data_bolla_in[k_riga_ds]) )
	end if 
end if 

//--- Non stampa Cliente Mandante tra le righe di dettaglio se indicato in CAUSALE di SPED
if trim(kds_ddt_stampa.object.sped_ddt_st_num_data_in[k_riga_ds]) = kiuf_sped.kki_ddt_st_num_data_in_NO or isnull(kds_ddt_stampa.object.sped_ddt_st_num_data_in[k_riga_ds]) then
else
	//--- Se cliente Mandante diverso da Ricevente stampo Rag. soc. del Mandante}
	if kds_ddt_stampa.object.meca_clie_1[k_riga_ds] <> kds_ddt_stampa.object.sped_clie_2[k_riga_ds] then
		
	//--- aggiungo riga e controllo Fine Pagina	
		k_pagina = produci_ddt_riga_add() 
		if k_pagina = 0 then 
			kst_esito.esito = kkg_esito.err_logico
			kst_esito.sqlcode = 0
			kst_esito.sqlerrtext = "Errore numero riga durante produzione stampa d.d.t."
			kst_esito.nome_oggetto = this.classname()
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	//--- stampa dati mittente
		kids_stampa_ddt.setitem(k_pagina, "descr_" + string(ki_ddt_riga_corpo), "di: " + trim(kds_ddt_stampa.object.mittente_rag_soc_10[k_riga_ds] ) + " " &
											+ trim(kds_ddt_stampa.object.mittente_indi_1[k_riga_ds]) + " " + trim(kds_ddt_stampa.object.mittente_cap_1[k_riga_ds]) + " " &
											+ trim(kds_ddt_stampa.object.mittente_loc_1[k_riga_ds]) + " " + trim(kds_ddt_stampa.object.mittente_prov_1[k_riga_ds]))
		
	end if
end if

	
return k_return

end function

public function boolean produci_ddt_piede (ref ds_ddt_stampa kds_ddt_stampa, long k_riga_dw) throws uo_exception;//---
//--- Stampa coda del documento
//---
boolean k_return=true
long k_riga



	k_riga = produci_ddt_get_pagina()

//--- stampo Note 1 e 2 da SPED
 	if isnull(kds_ddt_stampa.object.sped_note_1[k_riga_dw]) then kds_ddt_stampa.object.sped_note_1[k_riga_dw] = ""
 	if isnull(kds_ddt_stampa.object.sped_note_2[k_riga_dw]) then kds_ddt_stampa.object.sped_note_2[k_riga_dw] = ""
	kids_stampa_ddt.setitem(k_riga, "sped_note",  trim(kds_ddt_stampa.object.sped_note_1[k_riga_dw])  +  trim(kds_ddt_stampa.object.sped_note_2[k_riga_dw])  )

	
	if isnull(kds_ddt_stampa.object.sped_cura_trasp[k_riga_dw]) then kds_ddt_stampa.object.sped_cura_trasp[k_riga_dw] = "V"
	choose case kds_ddt_stampa.object.sped_cura_trasp[k_riga_dw]
		case "M"
			kids_stampa_ddt.setitem(k_riga, "trasporto",  "Mittente")  
		case "D"
			kids_stampa_ddt.setitem(k_riga, "trasporto",  "Destinatario")  
			kids_stampa_ddt.setitem(k_riga, "vett_1",  "Destinatario")  
		case "V"
			kids_stampa_ddt.setitem(k_riga, "trasporto",  "Vettore")  
		case else
			kids_stampa_ddt.setitem(k_riga, "trasporto",  " ")  
	end choose

	if trim(kds_ddt_stampa.object.sped_cura_trasp[k_riga_dw]) <> "V" then
		
		if isnull(kds_ddt_stampa.object.sped_MEZZO[k_riga_dw]) then kds_ddt_stampa.object.sped_MEZZO[k_riga_dw] = " "
		if trim(kds_ddt_stampa.object.sped_MEZZO[k_riga_dw]) = "D" then
//			kids_stampa_ddt.setitem(k_riga, "consegna",  "Destinatario")  
		else
//			kids_stampa_ddt.setitem(k_riga, "consegna",  "Mittente")  
		end if

		if kds_ddt_stampa.object.sped_data_rit[k_riga_dw] > kkg.DATA_NO then 
			kids_stampa_ddt.setitem(k_riga, "data_ora_rit", string(kds_ddt_stampa.object.sped_data_rit[k_riga_dw]) + "  " + trim(kds_ddt_stampa.object.sped_ora_rit[k_riga_dw]))
		else
			kids_stampa_ddt.setitem(k_riga, "data_ora_rit",  " ")
		end if

	else
		
		if isnull(kds_ddt_stampa.object.sped_VETT_1[k_riga_dw]) then kds_ddt_stampa.object.sped_VETT_1[k_riga_dw] = " "
		if isnull(kds_ddt_stampa.object.sped_VETT_2[k_riga_dw]) then kds_ddt_stampa.object.sped_VETT_2[k_riga_dw] = " "
		kids_stampa_ddt.setitem(k_riga, "vett_1", trim(kds_ddt_stampa.object.sped_VETT_1[k_riga_dw]))
		kids_stampa_ddt.setitem(k_riga, "vett_2", trim(kds_ddt_stampa.object.sped_VETT_2[k_riga_dw]))
		
		if kds_ddt_stampa.object.sped_data_rit[k_riga_dw] > kkg.DATA_NO then 
			kids_stampa_ddt.setitem(k_riga, "data_ora_rit", string(kds_ddt_stampa.object.sped_data_rit[k_riga_dw]) + "  " + trim(kds_ddt_stampa.object.sped_ora_rit[k_riga_dw]))
		else
			kids_stampa_ddt.setitem(k_riga, "data_ora_rit",  " ")
		end if

	end if

	if isnull(kds_ddt_stampa.object.sped_aspetto[k_riga_dw]) then kds_ddt_stampa.object.sped_aspetto[k_riga_dw] = " " 
	kids_stampa_ddt.setitem(k_riga, "aspetto",  trim(kds_ddt_stampa.object.sped_aspetto[k_riga_dw]))  

	if isnull(kds_ddt_stampa.object.sped_colli[k_riga_dw]) then kds_ddt_stampa.object.sped_colli[k_riga_dw] = 0 
	kids_stampa_ddt.setitem(k_riga, "colli",  (kds_ddt_stampa.object.sped_colli[k_riga_dw]))  
	
//	if isnull(kds_ddt_stampa.object.peso_kg) then kds_ddt_stampa.object.peso_kg = 0 
//	kids_stampa_ddt.setitem(k_riga, "peso_kg",  string(kds_ddt_stampa.object.peso_kg))  
	
	
	if isnull(kds_ddt_stampa.object.sped_porto[k_riga_dw]) then kds_ddt_stampa.object.sped_porto[k_riga_dw] = " " 
	kids_stampa_ddt.setitem(k_riga, "porto",  trim(kds_ddt_stampa.object.sped_porto[k_riga_dw]))  
	
//	if isnull(kds_ddt_stampa.object.sped_note_qtna[k_riga_dw]) then kds_ddt_stampa.object.sped_note_qtna[k_riga_dw] = " "
//	kids_stampa_ddt.setitem(k_riga, "sped_note_qtna",  trim(kds_ddt_stampa.object.sped_note_qtna[k_riga_dw]))  
	


return k_return

end function

public function boolean produci_ddt_testa (ref ds_ddt_stampa kds_ddt_stampa, long k_riga_dw) throws uo_exception;//---
//--- Stampa la Testa  del documento
//---
boolean k_return=true
boolean k_stampa_indirizzo_2=false
string k_stampante,  k_rcx, k_file, k_num_bolla_out_bis
long k_riga
int k_rc
st_esito kst_esito
kuf_base kuf1_base
kuf_ausiliari kuf1_ausiliari
kuf_clienti kiuf_clienti



//--- imposta il dw
	k_riga = kids_stampa_ddt.insertrow( 0 ) 
	kids_stampa_ddt.setrow(k_riga)


//--- Valuta il Tipo di copia del ddt (se x il Ricevente/interna/cliente oppure Generica)
	choose case ki_tipo_stampa
			
		case kki_tipo_stampa_x_Ricevente
			kids_stampa_ddt.object.tipo_copia[k_riga] = "Copia destinatario " 
			
		case kki_tipo_stampa_Interna
			kids_stampa_ddt.object.tipo_copia[k_riga] = "Copia mittente (da trattenere) " 
			
		case kki_tipo_stampa_x_Vettore
			kids_stampa_ddt.object.tipo_copia[k_riga] = "Copia vettore "
			
		case else
			kids_stampa_ddt.object.tipo_copia[k_riga] = " "
			
	end choose

	
//--- Se non impostato indirizzo di spedizione sul Documento allora metto quello presente in Anagrafe x le spedizioni
	if len(trim(kds_ddt_stampa.object.sped_rag_soc_1[k_riga_dw])) = 0  then
					
		kds_ddt_stampa.object.sped_rag_soc_1[k_riga_dw] = kds_ddt_stampa.object.clienti_rag_soc_20[k_riga_dw] 
		kds_ddt_stampa.object.sped_rag_soc_2[k_riga_dw]  = kds_ddt_stampa.object.clienti_rag_soc_21[k_riga_dw]  
		kds_ddt_stampa.object.sped_indi[k_riga_dw]  = kds_ddt_stampa.object.clienti_indi_2[k_riga_dw]   
		kds_ddt_stampa.object.sped_cap[k_riga_dw]  = kds_ddt_stampa.object.clienti_cap_2[k_riga_dw]  
		kds_ddt_stampa.object.sped_loc[k_riga_dw] = kds_ddt_stampa.object.clienti_loc_2[k_riga_dw]  
		kds_ddt_stampa.object.sped_prov[k_riga_dw] = kds_ddt_stampa.object.clienti_prov_2[k_riga_dw]   
		kds_ddt_stampa.object.sped_id_nazione[k_riga_dw] = kds_ddt_stampa.object.clienti_id_nazione_2[k_riga_dw]   
		kds_ddt_stampa.object.sped_nazioni_nome[k_riga_dw] = kds_ddt_stampa.object.clienti_nazioni_nome_2[k_riga_dw]  
		
	end if
	
	
//--- riga intestazione ddt - controllo se indirizzio destinazione diverso da sede	
	if trim(kds_ddt_stampa.object.sped_rag_soc_1[k_riga_dw]) <> trim(kds_ddt_stampa.object.clienti_rag_soc_10[k_riga_dw]) &
				or trim(kds_ddt_stampa.object.sped_rag_soc_2[k_riga_dw])  <> trim(kds_ddt_stampa.object.clienti_rag_soc_11[k_riga_dw])   & 
				or trim(kds_ddt_stampa.object.sped_indi[k_riga_dw])  <> trim(kds_ddt_stampa.object.clienti_indi_1[k_riga_dw])  & 
				or trim(kds_ddt_stampa.object.sped_cap[k_riga_dw])  <> trim(kds_ddt_stampa.object.clienti_cap_1[k_riga_dw]) &
				or trim(kds_ddt_stampa.object.sped_loc[k_riga_dw])  <> trim(kds_ddt_stampa.object.clienti_loc_1[k_riga_dw])  & 
				or trim(kds_ddt_stampa.object.sped_prov[k_riga_dw])  <> trim(kds_ddt_stampa.object.clienti_prov_1[k_riga_dw]) then 
			
		k_rc=kids_stampa_ddt.setitem(k_riga, "dicit_ind_intest",  "Destinatario - Residenza o Domicilio " ) 
		k_rc=kids_stampa_ddt.setitem(k_riga, "dicit_ind_sped",  "Luogo di destinazione " )  
		k_rc=kids_stampa_ddt.setitem(k_riga, "intestazione",  kds_ddt_stampa.object.clienti_RAG_SOC_10[k_riga_dw] + " ~n~r " &  
																				+ kds_ddt_stampa.object.clienti_RAG_SOC_11[k_riga_dw] + "  ~n~r"  )
 
		k_rc=kids_stampa_ddt.setitem(k_riga, "intestazione_ind",  kds_ddt_stampa.object.clienti_INDI_1[k_riga_dw] + " ~n~r" &    
																				+ kds_ddt_stampa.object.clienti_CAP_1[k_riga_dw] +"  " &
																				+ trim(kds_ddt_stampa.object.clienti_LOC_1[k_riga_dw]) + "  (" &
																				+ trim(kds_ddt_stampa.object.clienti_PROV_1[k_riga_dw]) + ")  ~n~r" &  
																				+ trim(kds_ddt_stampa.object.clienti_nazioni_nome_1[k_riga_dw])  )
																				
		
	else
		k_rc=kids_stampa_ddt.setitem(k_riga, "dicit_ind_intest",  "  " ) 
		k_rc=kids_stampa_ddt.setitem(k_riga, "dicit_ind_sped",  "Destinatario - Residenza o Domicilio   " )  
	end if
	

//--- riga indirizzo	
	k_rc=kids_stampa_ddt.setitem(k_riga, "indirizzo_riga_1",  kds_ddt_stampa.object.sped_RAG_SOC_1[k_riga_dw])  
	k_rc=kids_stampa_ddt.setitem(k_riga, "indirizzo_riga_2",  kds_ddt_stampa.object.sped_RAG_SOC_2[k_riga_dw])  
	k_rc=kids_stampa_ddt.setitem(k_riga, "indirizzo_riga_3",  kds_ddt_stampa.object.sped_INDI[k_riga_dw])  
	kids_stampa_ddt.setitem(k_riga, "indirizzo_riga_4",  kds_ddt_stampa.object.sped_CAP[k_riga_dw] +" " &
																	+ trim(kds_ddt_stampa.object.sped_LOC[k_riga_dw]) + " " &
																	+ trim(kds_ddt_stampa.object.sped_PROV[k_riga_dw]) )  

    if len(trim(kds_ddt_stampa.object.sped_id_nazione[k_riga_dw])) > 0 then
		k_rc=kids_stampa_ddt.setitem(k_riga, "indirizzo_riga_5", kds_ddt_stampa.object.sped_nazioni_nome[k_riga_dw])  
	end if

//--- testata con il numero data ecc...
	if kds_ddt_stampa.object.sped_num_bolla_out[k_riga_dw] > 9000000 then  // se DDT BIS allora toglie 9000....
		k_num_bolla_out_bis = right(string(kds_ddt_stampa.object.sped_num_bolla_out[k_riga_dw]),6)
		kids_stampa_ddt.setitem(k_riga, "num_bolla_out_1", long(k_num_bolla_out_bis))  
	else
		kids_stampa_ddt.setitem(k_riga, "num_bolla_out_1", kds_ddt_stampa.object.sped_num_bolla_out[k_riga_dw])  
	end if
	kids_stampa_ddt.setitem(k_riga, "data_bolla_out",  (kds_ddt_stampa.object.sped_data_bolla_out[k_riga_dw]))  
	kids_stampa_ddt.setitem(k_riga, "id_sped",  (kds_ddt_stampa.object.id_sped[k_riga_dw]))  

	if isnull(kds_ddt_stampa.object.sped_clie_2[k_riga_dw]) then kds_ddt_stampa.object.sped_clie_2[k_riga_dw] = 0 
	kids_stampa_ddt.setitem(k_riga, "clie_2",  (kds_ddt_stampa.object.sped_clie_2[k_riga_dw]))  
	if isnull(kds_ddt_stampa.object.sped_clie_3[k_riga_dw]) then kds_ddt_stampa.object.sped_clie_3[k_riga_dw] = 0 
	kids_stampa_ddt.setitem(k_riga, "clie_3",  (kds_ddt_stampa.object.sped_clie_3[k_riga_dw]))  
	
	if isnull(kds_ddt_stampa.object.sped_causale[k_riga_dw]) then kds_ddt_stampa.object.sped_causale[k_riga_dw] = " " 
	kids_stampa_ddt.setitem(k_riga, "causale",  trim(kds_ddt_stampa.object.sped_causale[k_riga_dw]))  
	
	

//--- Numero di Pagina	
	kids_stampa_ddt.setitem(k_riga, "pagina",  "Pagina: " + string(ki_pag_ddt))  


return k_return

end function

public function st_esito produci_ddt_set_dw_loghi (ref datastore kds_ok, ref datawindow kdw_ok);//---
//--- Imposta i loghi passare o il DATASTORE o il DATAWINDOW
//---
string k_rcx, k_file
long k_riga
int k_rc
st_profilestring_ini kst_profilestring_ini
st_esito kst_esito



if not isvalid(kdw_ok) and not isvalid(kds_ok) then
kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Operazione interrotta: ~n~r" + "tipo oggetto non riconosciuto, errore internodel software "
	kst_esito.esito = kkg_esito.err_logico
end if	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//--- Loghi e loghetti
//--- path per reperire le ico del drag e drop
	if ki_path_risorse = "" then
		kst_profilestring_ini.operazione = "1"
		kst_profilestring_ini.valore = "\"
		kst_profilestring_ini.titolo = "risorse_grafiche" 
		kst_profilestring_ini.nome = "arch_graf"
		kGuf_data_base.profilestring_ini(kst_profilestring_ini)
		if kst_profilestring_ini.esito = "0" then
			ki_path_risorse = trim(kst_profilestring_ini.valore) 
		else
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Operazione interrotta: ~n~r" + "cartella risorsa grafica non trovata "
			kst_esito.esito = kkg_esito.blok
		end if
	end if
			
	if len(trim(ki_path_risorse)) > 0 then

//--- attenzione devono chiamarsi x forza:
//--- p_img
//--- p_img_0
//--- p_img_1
//--- p_img_2
//--- p_img_3
		
		if isvalid(kdw_ok) then
			k_rcx= trim(kdw_ok.Describe("txt_p_img.text"))
			k_rcx=kdw_ok.Modify("p_img.Filename='" + ki_path_risorse + "\" + k_rcx + "'")  // "logo_orig_blu.JPG" + "'")
			k_rcx= trim(kdw_ok.Describe("txt_p_img_1.text"))
			k_rcx=kdw_ok.Modify("p_img_1.Filename='"  + ki_path_risorse + "\" + k_rcx + "'")  // "logo_iso_blu.JPG"  + "'")
			k_rcx= trim(kdw_ok.Describe("txt_p_img_2.text"))
			k_rcx=kdw_ok.Modify("p_img_2.Filename='" + ki_path_risorse + "\" + k_rcx + "'")  // "logo_iso_blu.JPG"  + "'")
			k_rcx= trim(kdw_ok.Describe("txt_p_img_3.text"))
			k_rcx=kdw_ok.Modify("p_img_3.Filename='" + ki_path_risorse + "\" + k_rcx + "'")  // "logo_iso_blu.JPG"  + "'")
		else
			if isvalid(kds_ok) then
				k_rcx= trim(kds_ok.Describe("txt_p_img.text"))
				k_rcx=kds_ok.Modify("p_img.Filename='" + ki_path_risorse + "\" + k_rcx + "'")  // "logo_orig_blu.JPG" + "'")
				k_rcx= trim(kds_ok.Describe("txt_p_img_1.text"))
				k_rcx=kds_ok.Modify("p_img_1.Filename='" + ki_path_risorse + "\" + k_rcx + "' ")  // "logo_iso_blu.JPG"  + "'")
				k_rcx= trim(kds_ok.Describe("txt_p_img_2.text"))
				k_rcx=kds_ok.Modify("p_img_2.Filename='" + ki_path_risorse + "\" +  k_rcx + "' ")  // "logo_iso_blu.JPG"  + "'")
				k_rcx= trim(kds_ok.Describe("txt_p_img_3.text"))
				k_rcx=kds_ok.Modify("p_img_3.Filename='" + ki_path_risorse + "\" +  k_rcx + "' ")  // "logo_iso_blu.JPG"  + "'")
			end if
		end if
	
	end if



return kst_esito

end function

private function st_esito set_wm_pklist_righe (ref st_tab_sped kst_tab_sped, boolean k_set_spedito);//
//--- Aggiorna flag SPEDITO e NON-SPEDITO nelle righe tabella scambio WM  (WM_PKLIST_RIGHE)
//---
//--- input: kst_tab_sped.num_bolla_out / data_bolla_out
//---                 
//--- Out: kst_esito 
//---
//
int k_ctr=0, k_righe_ind=0
st_esito kst_esito
st_tab_arsp kst_tab_arsp[50]
st_tab_wm_pklist_righe kst_tab_wm_pklist_righe
kuf_wm_pklist_righe kuf1_wm_pklist_righe


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	if kst_tab_sped.num_bolla_out > 0 then  
		

//--- legge righe SPEDIZIONE
		declare set_wm_pklist_righe_C1 cursor for
                  select 
                           ARSP.ID_ARMO
                           ,sum(COLLI)
                      from ARSP
                     where  
                            ARSP.NUM_BOLLA_OUT  = :kst_tab_sped.NUM_BOLLA_OUT 
                            and ARSP.DATA_BOLLA_OUT = :kst_tab_sped.DATA_BOLLA_OUT
                     group by ID_ARMO
					using sqlca;

 		open set_wm_pklist_righe_C1;
		if sqlca.sqlcode = 0 then 
			
			k_ctr ++
			fetch set_wm_pklist_righe_C1 into
									:kst_tab_arsp[k_ctr].ID_ARMO
									, :kst_tab_arsp[k_ctr].COLLI;
									
			do while sqlca.sqlcode = 0
				
				k_ctr ++
				fetch set_wm_pklist_righe_C1 into
									:kst_tab_arsp[k_ctr].ID_ARMO
									, :kst_tab_arsp[k_ctr].COLLI;
			loop

			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore in ricerca righe D.d.t. nr.=" + string(kst_tab_sped.num_bolla_out) + " del "  + string(kst_tab_sped.data_bolla_out) +": ~n~r" &
										 + trim(SQLCA.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
			
			close set_wm_pklist_righe_C1;

//--- finalmente aggiorna il flag
			kuf1_wm_pklist_righe = create kuf_wm_pklist_righe
			
			k_ctr = 1
			do while  k_ctr < upperbound(kst_tab_arsp[]) and (kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn)
				
				if kst_tab_arsp[k_ctr].ID_ARMO > 0 then

					kst_tab_wm_pklist_righe.st_tab_g_0.esegui_commit = kst_tab_sped.st_tab_g_0.esegui_commit // richiesta la commit?
					
					kst_tab_wm_pklist_righe.id_armo = kst_tab_arsp[k_ctr].ID_ARMO
					kst_esito = kuf1_wm_pklist_righe.if_esiste_in_sped_x_id_armo(kst_tab_wm_pklist_righe)		//Controlla se esiste il PKLIST
					
//--- se esiste il pk-list aggiorna					
					if kst_esito.esito = kkg_esito.ok then
						if k_set_spedito then
							kst_esito = kuf1_wm_pklist_righe.set_sped_si_x_id_armo	(kst_tab_wm_pklist_righe)		// AGGIORNA PackingList a SPEDITO
						else
							kst_esito = kuf1_wm_pklist_righe.set_sped_no_x_id_armo(kst_tab_wm_pklist_righe)		// AGGIORNA PackingList a NON SPEDITO (reset)
						end if
					else
						if kst_esito.esito = kkg_esito.not_fnd then
							kst_esito.SQLErrText = "Paking list assente ddt nr.=" + string(kst_tab_sped.num_bolla_out) + " del "  + string(kst_tab_sped.data_bolla_out) +": ~n~r" &
										 + trim(kst_esito.SQLErrText)
							kst_esito.esito = kkg_esito.db_wrn //--- PKL non trovato
						end if
					end if
				end if
				
				k_ctr ++

			loop
			
			destroy kuf1_wm_pklist_righe 

		else
			if sqlca.sqlcode < 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore in ricerca (open) righe D.d.t. nr.=" + string(kst_tab_sped.num_bolla_out) + " del "  + string(kst_tab_sped.data_bolla_out) +") : ~n~r" &
										 + trim(SQLCA.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		
			
		if kst_esito.esito = kkg_esito.ok then
		
//---- COMMIT....	
			if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		else		
			
			kGuf_data_base.errori_scrivi_esito("W", kst_esito)  //--- scrive il LOG
			
			if kst_tab_sped.st_tab_g_0. esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
		end if

	end if

return kst_esito


end function

public function st_esito set_wm_pklist_righe_non_spedito (st_tab_sped kst_tab_sped);//
//--- Aggiorna flag a NON SPEDITO nelle righe tabella scambio WM  (WM_PKLIST_RIGHE)
//---
//--- input: kst_tab_sped.num_bolla_out / data_bolla_out
//---                 
//--- Out: kst_esito 
//---
//
st_esito kst_esito
boolean k_spedito=false


	kst_esito = set_wm_pklist_righe(kst_tab_sped, k_spedito)
	

return kst_esito


end function

public function st_esito set_wm_pklist_righe_spedito (st_tab_sped kst_tab_sped);//
//--- Aggiorna flag SPEDITO nelle righe tabella scambio WM  (WM_PKLIST_RIGHE)
//---
//--- input: kst_tab_sped.num_bolla_out / data_bolla_out
//---                 
//--- Out: kst_esito 
//---
//
st_esito kst_esito
boolean k_spedito=true


	kst_esito = set_wm_pklist_righe(kst_tab_sped, k_spedito)
	

return kst_esito


end function

public function integer stampa_ddt_nuovo (st_ddt_stampa kst_ddt_stampa[]) throws uo_exception;//
//--- stampa DDT mai stampati
//--- input:  st_ddt_stampa[] (elenco ddt)
//--- out: Numero doc prodotti
//---
boolean k_stampato=true, k_sicurezza=true
int k_ctr=0, k_n_ddt_stampati=0
int k_riga, k_index
st_sped_ddt kst_sped_ddt[]
st_esito kst_esito 
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
kuf_menu_window kuf1_menu_window
uo_exception kuo_exception

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = kiuf_sped.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_sicurezza then
	k_stampato = false

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Stampa Spedizione non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	
	kuo_exception = create uo_exception
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

end if

if upperbound(kst_ddt_stampa) > 0 then

	k_riga=0
	k_index = 1
	do while k_index <= UpperBound(kst_ddt_stampa)  //NOT k_fatt_selected_eof
		
		if kst_ddt_stampa[k_index].num_bolla_out > 0 then
			k_riga++
			kst_sped_ddt[k_riga].kst_tab_sped.id_sped = kst_ddt_stampa[k_index].id_sped
			kst_sped_ddt[k_riga].kst_tab_sped.num_bolla_out = kst_ddt_stampa[k_index].num_bolla_out
			kst_sped_ddt[k_riga].kst_tab_sped.data_bolla_out = kst_ddt_stampa[k_index].data_bolla_out
			kst_sped_ddt[k_riga].sel = 1
			k_n_ddt_stampati ++
		end if								
		k_index++
	loop


//=== Parametri : 
//=== struttura st_open_w
//=== dati particolare programma
//
//=== Si potrebbero passare:
//=== key=codice prodotto;
		
	Kst_open_w.flag_primo_giro = "S"
	Kst_open_w.flag_modalita = kkg_flag_modalita.stampa
	Kst_open_w.flag_adatta_win = KKG.ADATTA_WIN_NO
	Kst_open_w.flag_leggi_dw = "N"
	kst_open_w.key12_any = kst_sped_ddt[]   // struttura
	kst_open_w.flag_where = " "
	
		
	kuf1_menu_window = create kuf_menu_window 
	kuf1_menu_window.open_w_tabelle(kst_open_w)
	destroy kuf1_menu_window

end if




return k_n_ddt_stampati

end function

public function integer produci_ddt (ref st_ddt_stampa kst_ddt_stampa[]) throws uo_exception;//
//--- Costruisce i ddt da stampare  
//--- input:  st_ddt_stampa     da valorizzare num_bolla_out + data_bolla_out dai ddt
//--- out: true = OK, false = non stampata
//---
long krc=0
boolean k_stampato=true, k_sicurezza=true, k_boolean= true
boolean k_prima_volta=true
long k_ctr=0, k_n_ddt_prodotti=0, k_anno=0
long k_riga_ddt = 0, k_ddt_riga_arsp=0, k_num_copie=0
st_esito kst_esito 
uo_exception kuo_exception
st_tab_sped kst_tab_sped
st_sped_ddt kst_sped_ddt
ds_ddt_stampa kds_ddt_stampa



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""


	kds_ddt_stampa = create ds_ddt_stampa
	kds_ddt_stampa.settransobject(sqlca)



//--------------------------------------- CICLO PRINCIPALE ------------------------------------------------------------------
	for k_riga_ddt = 1 to upperbound(kst_ddt_stampa[])


		if kst_ddt_stampa[k_riga_ddt].num_bolla_out > 0 then


			kst_tab_sped.num_bolla_out = kst_ddt_stampa[k_riga_ddt].num_bolla_out
			kst_tab_sped.data_bolla_out = kst_ddt_stampa[k_riga_ddt].data_bolla_out


//---- inizializza x stampa 
			produci_ddt_inizializza(kst_tab_sped)


			if k_prima_volta then
				k_prima_volta = false

				k_boolean = produci_ddt_open()
				if not k_boolean then
					kst_esito.sqlcode = 0
					kst_esito.sqlerrtext = "Apertura Report Fallita."
					kst_esito.esito = kkg_esito.no_esecuzione
					kuo_exception = create uo_exception
					kuo_exception.set_esito( kst_esito )
					throw kuo_exception
				end if
	
			end if

//--- legge UNA bolla intera
			k_anno = year(kst_tab_sped.data_bolla_out)
			krc=kds_ddt_stampa.retrieve(kst_tab_sped.num_bolla_out, k_anno )
			if krc <= 0 then 
			else
				k_n_ddt_prodotti++ //nr bolle
				
				for k_num_copie = 1 to 3    //--- al massimo fa 3 copie
	
	//--- Identifico il Tipo di copia in Stampa		
					if kst_ddt_stampa[k_riga_ddt].tipo_num_copie <> kki_tipo_num_copie_generica then
						choose case k_num_copie
							case 1  // copia Ricevente
								ki_tipo_stampa = kki_tipo_stampa_x_Ricevente
							case 2 // copia Interna
								ki_tipo_stampa = kki_tipo_stampa_Interna
							case 3 // copia x il Vettore
								ki_tipo_stampa = kki_tipo_stampa_x_Vettore
							case else
								ki_tipo_stampa = kki_tipo_stampa_Generica
						end choose
					else	
						ki_tipo_stampa = kki_tipo_stampa_Generica
					end if
					
					
	//--- Righe DDT		
					ki_ddt_riga_corpo=0             //--- resetta il numero di riga di dettaglio
					ki_pag_DDT=1   //--- pagine doc
					
	//--- se ci sono righe prosegue 
					if kds_ddt_stampa.rowcount( ) > 0 then
		
		//				kst_tab_clienti.rag_soc_10 = kuf1_utility.u_stringa_pulisci(kst_tab_clienti.rag_soc_10)
		//				kst_tab_clienti.rag_soc_11 = kuf1_utility.u_stringa_pulisci(kst_tab_clienti.rag_soc_11)
	
	//--- eccezione x data e ora ritiro che puo' arrivare dalla struttura 
	//					if kst_ddt_stampa[k_riga_ddt].data_ora_rit_pers then
							kds_ddt_stampa.object.sped_data_rit[1] = kst_ddt_stampa[k_riga_ddt].data_rit 
							kds_ddt_stampa.object.sped_ora_rit[1] = kst_ddt_stampa[k_riga_ddt].ora_rit 
	//					else
	//						kst_ddt_stampa[k_riga_ddt].data_rit = kds_ddt_stampa.object.sped_data_rit[1]
	//						kst_ddt_stampa[k_riga_ddt].ora_rit = kds_ddt_stampa.object.sped_ora_rit[1] 
	//					end if
		
						k_boolean = produci_ddt_testa(kds_ddt_stampa, 1)
						if not k_boolean then
							kst_esito.sqlcode = 0
							kst_esito.sqlerrtext = "D.D.T.: Stampa testa e piede."
							kst_esito.esito = kkg_esito.no_esecuzione
							kuo_exception = create uo_exception
							kuo_exception.set_esito( kst_esito )
							throw kuo_exception
						end if
					
		
						for k_ddt_riga_arsp = 1 to kds_ddt_stampa.rowcount( ) 
						
							k_boolean = produci_ddt_riga(kds_ddt_stampa, k_ddt_riga_arsp)
							if not k_boolean then
								kst_esito.sqlcode = 0
								kst_esito.sqlerrtext = "D.D.T.: stampa Riga nr. " + string(k_ddt_riga_arsp) + " art. " + trim(kds_ddt_stampa.object.armo_art[k_ddt_riga_arsp])
								kst_esito.esito = kkg_esito.no_esecuzione
								kuo_exception = create uo_exception
								kuo_exception.set_esito( kst_esito )
								throw kuo_exception
							end if
							
		
							produci_ddt_riga_note_qtna(kds_ddt_stampa, k_ddt_riga_arsp)  	// stampa eventuale dicitura di Spedizione in Quarantena
							
						next
						
						produci_ddt_riga_pagamento(kds_ddt_stampa, 1)  	// stampa descrizione codice Pagamento 
						k_boolean = produci_ddt_piede(kds_ddt_stampa, 1) 	// stampa i dati finali del ddt
						
					end if
					
	//--- Valuta numero copie da fare x il DDT 
					choose case kst_ddt_stampa[k_riga_ddt].tipo_num_copie
							
						case kki_tipo_num_copie_generica
							k_num_copie = 4  // fatta la copia generica esco
							
						case kki_tipo_num_copie_doppia_c
							if kds_ddt_stampa.rowcount( ) > 0 then
								if (kds_ddt_stampa.object.sped_cura_trasp[1] <> "V" or isnull(kds_ddt_stampa.object.sped_cura_trasp[1])) and k_num_copie = 2 then  // se ddt x Vettore 
									k_num_copie = 4  // fatte le 2 copie esco
								end if
							else
								k_num_copie = 4  // fatte le 2 copie esco
							end if
							
						case kki_tipo_num_copie_doppia
							if k_num_copie = 2 then
								k_num_copie = 4  // fatte le 2 copie esco
							end if
							
					end choose
					
					
				next
				
			end if
		end if

	next
		
//--------------------------------------- FINE CICLO PRINCIPALE ------------------------------------------------------------------

	destroy kds_ddt_stampa


return k_n_ddt_prodotti

end function

public function integer stampa_ddt_bianco () throws uo_exception;//
//--- stampa DDT senza DATI solo prefincato
//--- input: nulla 
//--- out: Numero ddt prodotti
//---
boolean k_stampato=true, k_sicurezza=true
int k_ctr=0, k_n_ddt_stampati=0
st_esito kst_esito 
st_ddt_stampa kst_ddt_stampa[]
st_tab_sped kst_tab_sped
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza
uo_exception kuo_exception



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = kiuf_sped.get_id_programma(kst_open_w.flag_modalita)

//--- controlla se utente autorizzato alla funzione in atto
	kuf1_sicurezza = create kuf_sicurezza
	k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_sicurezza then
		k_stampato = false
	
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Stampa D.D.T. non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
		kst_esito.esito = kkg_esito.no_aut
		
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
	
	end if
	
	kst_ddt_stampa[1].clie_2 = 0	
	
	if upperbound(kst_ddt_stampa[]) > 0 then


//---- inizializza x stampa 
		kst_tab_sped.num_bolla_out = 0
		produci_ddt_inizializza(kst_tab_sped)
	
//--- produci stampa
		produci_ddt_open( )
		
//--- produce il dw vuoto
		kids_stampa_ddt.insertrow( 0 ) 

//=== stampa dw
		k_stampato=stampa_ddt_emissione( "Stampa D.D.T. bianco - solo prefincato " )
	
		if not k_stampato then k_n_ddt_stampati = 0
		
//--- distrugge oggetti x stampa 
		produci_ddt_fine()

		
	end if
	



return k_n_ddt_stampati

end function

public subroutine produci_ddt_inizializza (ref st_tab_sped kst_tab_sped) throws uo_exception;//
int k_rc=0
datawindow kdw_nullo


//	if len(trim(kids_stampa_ddt.dataobject)) > 0 then
//	else
	if NOT isvalid(kids_stampa_ddt) then 
		
		produci_ddt_inizio( )

	end if
	
	if len(trim(kids_stampa_ddt.dataobject)) = 0 then

//--- Imposta il Form di stampa 
		if kst_tab_sped.num_bolla_out = 0 then
			kids_stampa_ddt.dataobject = ki_dw_stampa_ddt
		else
			get_form_di_stampa(kst_tab_sped) 
			kids_stampa_ddt.dataobject = trim(kst_tab_sped.form_di_stampa) 
		end if
	
		k_rc=kids_stampa_ddt.SetTransObject(SQLCA)
		kids_stampa_ddt.reset()

//--- imposta i loghi 
		produci_ddt_set_dw_loghi(kids_stampa_ddt, kdw_nullo)
		
	end if
	

end subroutine

public subroutine produci_ddt_inizio () throws uo_exception;//

	kids_stampa_ddt = create datastore
//	kids_stampa_ddt.Object.DataWindow.ReadOnly='Yes'


end subroutine

public function boolean get_form_di_stampa (ref st_tab_sped kst_tab_sped) throws uo_exception;//
//----------------------------------------------------------------------------------------------------
//--- Torna il FORM_DI_STAMPA da Tabella SPED
//--- 
//--- 
//--- Inp: st_sped.num_bolla_out e data_bolla_out 
//--- Out: st_sped.form_di_stampa       
//--- Ritorna: TRUE = OK Trovato in archivio; False=Non trovato ma cmq imostato
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//-----------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_sped.num_bolla_out > 0 then
 
	select form_di_stampa
		  into :kst_tab_sped.form_di_stampa
		from sped  
		WHERE sped.num_bolla_out = :kst_tab_sped.num_bolla_out
					and data_bolla_out = :kst_tab_sped.data_bolla_out
		using sqlca;


	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante selezione del 'nome form di stampa' del d.d.t. ~n~r" &
					+ string(kst_tab_sped.num_bolla_out, "####0") + " del " &
					+ string(kst_tab_sped.data_bolla_out, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. d.d.t., Manca il nr. Spedizione (num_bolla_out) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

if kst_esito.esito = kkg_esito.err_logico or 	kst_esito.esito = kkg_esito.db_ko then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

if len(trim(kst_tab_sped.form_di_stampa)) > 0 then
	k_return = true
else
	kst_tab_sped.form_di_stampa = ki_dw_stampa_ddt
end if

return k_return

end function

public function boolean set_form_di_stampa (st_tab_sped kst_tab_sped) throws uo_exception;//
//---------------------------------------------------------------------------------------------------------------
//--- Imposta a FORM_DI_STAMPA in Tabella SPED
//--- 
//--- 
//--- Inp: st_sped.num_bolla_out e data_bolla_out e  form_di_stampa
//--- Out:        
//--- Ritorna: TRUE = OK
//---           		
//--- Lancia EXCEPTION x errore
//--- 
//---------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
st_esito kst_esito

	

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
	
if kst_tab_sped.num_bolla_out > 0 then

	kst_tab_sped.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sped.x_utente = kGuf_data_base.prendi_x_utente()

	UPDATE sped  
		  SET form_di_stampa = :kst_tab_sped.form_di_stampa
			,x_datins = :kst_tab_sped.x_datins
			,x_utente = :kst_tab_sped.x_utente
		WHERE sped.num_bolla_out = :kst_tab_sped.num_bolla_out
					and data_bolla_out = :kst_tab_sped.data_bolla_out
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore durante aggiorn. 'nome form di stampa' del d.d.t. ~n~r" &
					+ string(kst_tab_sped.num_bolla_out, "####0") + " del " &
					+ string(kst_tab_sped.data_bolla_out, "dd.mm.yyyy") &	
					+ " ~n~rErrore-tab.SPED:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//---- COMMIT o ROLLBACK....	
	if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn  then
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	else
		if kst_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_sped.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	end if

else
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Errore tab. d.d.t., Manca il nr. Spedizione (num_bolla_out) !" 
	kst_esito.esito = kkg_esito.err_logico
			
end if	

if kst_esito.esito = kkg_esito.err_logico or 	kst_esito.esito = kkg_esito.db_ko then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if

k_return = true

return k_return

end function

public function integer stampa_ddt_esporta_digitale (st_docprod_esporta kst_docprod_esporta) throws uo_exception;//
//--- Produce le DDT in digitale (pdf)
//--- input:  ds_ddt_stampa (datastore con elenco documenti)
//--- out: Numero documenti prodotte
//---
boolean k_stampato=true, k_sicurezza=true
long k_riga=0, k_righe_doc=0
int k_ctr=0, k_n_documenti_stampati=0, k_n_documenti, k_id_stampa
string k_esito="", k_stampante_pdf="", k_file_pdf=""
st_ddt_stampa kst_ddt_stampa[]
st_tab_docprod kst_tab_docprod
st_tab_sped kst_tab_sped
st_esito kst_esito 
st_open_w kst_open_w
kuf_docprod kuf1_docprod
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility
kuf_base kuf1_base
kuf_sped kuf1_sped
uo_exception kuo_exception

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



kuf1_sped = create kuf_sped
kst_open_w.flag_modalita = kkg_flag_modalita.stampa
kst_open_w.id_programma = kuf1_sped.get_id_programma(kst_open_w.flag_modalita)
destroy kuf1_sped

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_sicurezza then
	k_stampato = false

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Emissione DDT non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut
	
	kuo_exception = create uo_exception
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception

else

//--- Piglio il nome della stampante PDF
	kuf1_base = create kuf_base
	k_esito = kuf1_base.prendi_dato_base( "stamp_pdf")
	if left(k_esito,1) <> "0" then
		k_stampante_pdf = ""
//		kst_esito.nome_oggetto = this.classname()
//		kst_esito.esito = kkg_esito.db_ko  
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = mid(k_esito,2)
	else
		k_stampante_pdf	= trim(mid(k_esito,2))
	end if
	destroy kuf1_base


	try 
		
		kuf1_docprod = create kuf_docprod
		kuf1_utility = create kuf_utility
		kuf1_sped = create kuf_sped
		
		if len(trim(k_stampante_pdf)) > 0 then
			
			k_righe_doc = upperbound(kst_docprod_esporta.kst_tab_docprod[])
			if k_righe_doc > 0 then
		
				for k_riga = 1 to k_righe_doc

					kst_tab_docprod = kst_docprod_esporta.kst_tab_docprod[k_riga]
					
					kst_tab_sped.id_sped = kst_tab_docprod.id_doc
					if kuf1_sped.if_esiste(kst_tab_sped) then   // esiste il documento?
		

//--- "Esportazione Documenti" x cui piglio il PATH dal docprod							
						k_file_pdf =  kst_docprod_esporta.path[k_riga]	
						
//--- Controllo se manca il percorso
						if len(trim(k_file_pdf)) > 0 then 

//--- Se il flag DUPLICA e' attivo allora diplica solo il file (dal path precedente) senza rifare la Stampa (ovviamente l'ITEM deve essere superiore a 1)
							if  kst_docprod_esporta.duplica[k_riga] and k_riga > 1 then
	
								if kuf1_utility.u_copia_file( kst_docprod_esporta.path[k_riga - 1], kst_docprod_esporta.path[k_riga], true)  <> 1 then // duplica il file 
									kst_esito.sqlcode = 0
									kst_esito.SQLErrText = "DDT digitale non duplicato, generata solo una copia probabilmente per 'Uso Interno' ~n~r '" +   &
																				 + "tentativo fallito di copiare da:" + kst_docprod_esporta.path[k_riga - 1] + "'  ~n~r"  &
																				 + "in questa posizione: " + kst_docprod_esporta.path[k_riga ]
									kst_esito.esito = kkg_esito.no_esecuzione
									kguo_exception.set_esito(kst_esito)
									throw kguo_exception
								
								end if
							
							else
//---- Crea oggetto x la produzione del lay-out
								produci_ddt_inizio()
								
								kst_ddt_stampa[k_riga].tipo_num_copie = kki_tipo_num_copie_generica // emiss.solo di una copia
			
								kst_ddt_stampa[1].id_sped = kst_tab_docprod.id_doc
								kst_ddt_stampa[1].num_bolla_out = kst_tab_docprod.doc_num
								kst_ddt_stampa[1].data_bolla_out = kst_tab_docprod.doc_data
								produci_ddt(kst_ddt_stampa[])   // PRODUCE IL LAY-OUT 
	
//=== Crea il PDF
								kids_stampa_ddt.Object.DataWindow.Export.PDF.Method = Distill!
								kids_stampa_ddt.Object.DataWindow.Printer = k_stampante_pdf   
								kids_stampa_ddt.Object.DataWindow.Export.PDF.Distill.CustomPostScript="1"
								k_id_stampa = kids_stampa_ddt.saveas(k_file_pdf,PDF!, false)   //
						
								if k_id_stampa < 1 then
									
									kst_esito.sqlcode = 0
									kst_esito.SQLErrText = "DDT digitale su stampante: '" + k_stampante_pdf + "' non generato: ~n~r"  &
																				 + "Documento: " + trim(k_file_pdf) + " ~n~r" &
																				 + "Funzione fallita per errore: " + string(k_id_stampa)
									kst_esito.esito = kkg_esito.no_esecuzione
									kguo_exception.set_esito(kst_esito)
									throw kguo_exception
		
								end if
						
//--- distrugge oggetti x lay-out
								produci_ddt_fine()
								
							end if
							
							k_n_documenti_stampati ++
							
						else
							
							kst_esito.sqlcode = 0
							kst_esito.SQLErrText = "DDT elettronica non generato: ~n~r" + "Manca il nome della cartella per i DDT, impostarla prima della generazione"
							kst_esito.esito = kkg_esito.no_esecuzione
							kguo_exception.set_esito(kst_esito)
							throw kguo_exception
						end if
					end if
					
				end for
		
			end if		
	
		else
			
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "DDT elettronica non generata: ~n~r" + "Manca la stampante PDF, impostarla tra le Proprietà della Procedura"
			kst_esito.esito = kkg_esito.no_esecuzione
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if
		
	catch	(uo_exception kuo1_exception)
			throw kuo1_exception
		

	finally
		if isvalid(kuf1_docprod) then destroy kuf1_docprod
		if isvalid(kuf1_utility) then destroy kuf1_utility
		if isvalid(kuf1_sped) then destroy kuf1_sped
		
	end try
		
end if
	



return k_n_documenti_stampati

end function

public function boolean produci_ddt_riga_pagamento (ref ds_ddt_stampa kds_ddt_stampa, long k_riga_ds) throws uo_exception;//---
//--- Corpo ddt: Riga di Dettaglio
//---
boolean k_return=true
constant integer k_note_totali_len_riga = 73
string k_stampante, k_note_totali
long k_pagina
integer k_ctr
integer k_ufo
double k_differernza
kuf_base kuf1_base		
st_esito kst_esito
st_tab_clienti kst_tab_clienti
st_tab_arfa kst_tab_arfa
st_tab_pagam kst_tab_pagam
kuf_clienti kuf1_clienti
kuf_fatt kuf1_fatt
kuf_ausiliari kuf1_ausiliari
 

try
	kuf1_fatt = create kuf_fatt
	
	kst_tab_pagam.codice = 0	
//--- cerca il cod.pag sulla fattura	
	kst_tab_arfa.id_armo = kds_ddt_stampa.object.arsp_id_armo[k_riga_ds]
	if kuf1_fatt.get_id_da_id_armo(kst_tab_arfa) > 0 then
		if kuf1_fatt.get_cod_pag(kst_tab_arfa) > 0 then
			kst_tab_pagam.codice = kst_tab_arfa.cod_pag
		end if
	end if
//--- se sulla fattura non c'e' lo cerca sul cliente	
	if kst_tab_pagam.codice = 0 then	
		kuf1_clienti = create kuf_clienti
		kst_tab_clienti.codice = kds_ddt_stampa.object.sped_clie_3[k_riga_ds]
		kst_tab_pagam.codice = kuf1_clienti.get_cod_pag(kst_tab_clienti)
	end if

	if kst_tab_pagam.codice > 0 then
		
		kuf1_ausiliari = create kuf_ausiliari
		kst_esito = kuf1_ausiliari.tb_select(kst_tab_pagam)
		
		if kst_tab_pagam.rate = 0 and kst_tab_pagam.des > "" then

			if ki_ddt_riga_corpo < 13 then 
				ki_ddt_riga_corpo = 14	// vorrei stampare la dicitura in mezzo al ddt
			else
				ki_ddt_riga_corpo += 1    // lascio una riga vuota
			end if
			
//--- aggiungo Riga e controllo Fine Pagina	
			k_pagina = produci_ddt_riga_add() 
			if k_pagina = 0 then 
				kst_esito.esito = kkg_esito.err_logico
				kst_esito.sqlcode = 0
				kst_esito.sqlerrtext = "Errore numero riga durante produzione stampa d.d.t."
				kst_esito.nome_oggetto = this.classname()
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
			
			if  kds_ddt_stampa.object.armo_dose[k_riga_ds] > 0 then
//--- espone descrizione Pagamento	
				kids_stampa_ddt.setitem(k_pagina, "descr_" + string(ki_ddt_riga_corpo), "   ***   " + trim(kst_tab_pagam.des) + "   ***   ")
//				if k_pagina = 1 then  // se sono su pagina 1 allora faccio NERETTO 
//					kids_stampa_ddt.modify("descr_" + trim(string(ki_ddt_riga_corpo)) + ".Font.Weight='700'")
//				end if
			end if
		end if
		
	end if

catch (uo_exception kuo_exception)
	throw(kuo_exception)

finally
	if isvalid(kuf1_fatt) then destroy kuf1_fatt
	if isvalid(kuf1_clienti) then destroy kuf1_clienti
	if isvalid(kuf1_ausiliari) then destroy kuf1_ausiliari
	
end try


	
return k_return

end function

public function st_esito set_ddt_aggiorna (st_ddt_stampa kst_ddt_stampa[]);//
//--- Aggiornamenti vari del d.d.t. emesso
//---
//--- input: array kst_sped_ddt.kst_tab_sped.num_bolla_out / data_bolla_out
//---                 
//--- Out: kst_esito 
//---
//
int k_ind_sped=0
long k_nr_docprod=0
st_esito kst_esito
st_tab_arsp kst_tab_arsp
st_tab_sped kst_tab_sped, kst_tab_sped_x_docprod[]
kuf_sped kuf1_sped
kuf_docprod kuf1_docprod


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
	
try 	
	if UpperBound(kst_ddt_stampa[] ) > 0 then
	
		
		for k_ind_sped = 1 to UpperBound(kst_ddt_stampa[] ) 
		
			if kst_ddt_stampa[k_ind_sped].num_bolla_out > 0 then  
	
				kst_tab_sped.num_bolla_out = kst_ddt_stampa[k_ind_sped].num_bolla_out
				kst_tab_sped.data_bolla_out = kst_ddt_stampa[k_ind_sped].data_bolla_out
				
				k_nr_docprod++  // memorizzo in una tabella x altre elaborazioni
				kst_tab_sped_x_docprod[k_nr_docprod].id_sped = kst_ddt_stampa[k_ind_sped].id_sped
				kst_tab_sped_x_docprod[k_nr_docprod].num_bolla_out = kst_ddt_stampa[k_ind_sped].num_bolla_out
				kst_tab_sped_x_docprod[k_nr_docprod].data_bolla_out = kst_ddt_stampa[k_ind_sped].data_bolla_out
	
	//--- se il DDT non ha ancora il 'form_di_stampa' lo aggiorna
				if NOT get_form_di_stampa(kst_tab_sped) then
					kst_tab_sped.form_di_stampa = ki_dw_stampa_ddt
					kst_tab_sped.st_tab_g_0.esegui_commit = "N"
					set_form_di_stampa(kst_tab_sped)
				end if
	
	//--- valuto prima se ddt ha il flag a già fatturato, se così non faccio nulla
				kst_esito = kiuf_sped.get_sped_stampa(kst_tab_sped)		
				if kst_tab_sped.stampa <> kiuf_sped.kki_sped_flg_stampa_fatturato or isnull(kst_tab_sped.stampa) then
	
					kst_tab_sped.st_tab_g_0.esegui_commit = "N"
					kst_tab_arsp.st_tab_g_0.esegui_commit = "N"
		
		//--- Aggiorna il corpo
					kst_tab_sped.data_rit = kst_ddt_stampa[k_ind_sped].data_rit
					kst_tab_sped.ora_rit = kst_ddt_stampa[k_ind_sped].ora_rit 
					kst_esito = kiuf_sped.set_sped_stampata(kst_tab_sped)		
		
					if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
		//--- Aggiorna le righe
						kst_tab_arsp.num_bolla_out = kst_ddt_stampa[k_ind_sped].num_bolla_out
						kst_tab_arsp.data_bolla_out = kst_ddt_stampa[k_ind_sped].data_bolla_out
						kst_esito = kiuf_sped.set_righe_stampata(kst_tab_arsp)
					end if
					
					if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
		//--- Aggiorna righe del PackingList 
						kst_esito = this.set_wm_pklist_righe_spedito(kst_tab_sped)
					end if
				
					if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
		//---- COMMIT....	
						kGuf_data_base.db_commit_1( )
					else		
						kGuf_data_base.db_rollback_1( )
						
						kGuf_data_base.errori_scrivi_esito("W", kst_esito)  //--- scrive il LOG
						
					end if
		
				end if
			end if
			
		next
		
		
//--- Aggiorna la riga in ARMO_PREZZI x l'evento ddt da Fatturare ---------------------------------------------------------------------------------
		try 
			if k_nr_docprod > 0 then
				kst_tab_sped_x_docprod[1].st_tab_g_0.esegui_commit = "S"
				set_armo_prezzi_righe_all(kst_tab_sped_x_docprod[], false)
			end if
			
		catch (uo_exception kuo_exception1)
			kst_esito = kuo_exception1.get_st_esito( )
			kst_esito.sqlerrtext = "Archivi DDT Aggiornati in modo Corretto !  Ma si sono verificate le seguenti anonalie: ~n~r" + trim(kst_esito.sqlerrtext)
			
		finally
		
		end try
		
//--- Aggiunge la riga in DOCPROD x l'esportazione digitale ----------------------------------------------------------------------------------------
		try 
			kuf1_sped = create kuf_sped
			
			if k_nr_docprod > 0 then
				kst_tab_sped_x_docprod[1].st_tab_g_0.esegui_commit = "S"
				kuf1_sped.aggiorna_docprod(kst_tab_sped_x_docprod[])
			end if
			
		catch (uo_exception kuo_exception2)
			kst_esito = kuo_exception2.get_st_esito( )
			kst_esito.sqlerrtext = "Archivi DDT Aggiornati Correttamente !  Ma si sono verificate le seguenti anonalie: ~n~r" + trim(kst_esito.sqlerrtext)
			
		finally
			destroy kuf1_sped
		
		end try
				
		
		
	end if		
	
catch (uo_exception kuo_exception)
	kGuf_data_base.db_rollback_1( )
	kGuf_data_base.errori_scrivi_esito("W", kst_esito)  //--- scrive il LOG
	kuo_exception.messaggio_utente()	

end try

return kst_esito


end function

private function boolean set_armo_prezzi_righe (ref st_tab_sped ast_tab_sped, boolean a_ripristino) throws uo_exception;//
//--- Aggiorna i colli SPEDITO nelle righe tabella Prezzi-riga-lotto (ARMO_PREZZI)
//---
//--- input: st_tab_sped.id_sped
//---		a_ripristino 	flag se aggiungere o ripristinare
//---                 
//--- Out: boolean  true=tutto OK; false=se riga inesitente su armo-prezzi
//---
//
boolean k_return=false
int k_ctr=0, k_righe_ind=0
st_esito kst_esito
st_tab_arsp kst_tab_arsp[50]
st_tab_armo_prezzi kst_tab_armo_prezzi
kuf_armo_prezzi kuf1_armo_prezzi
kuf_sped kuf1_sped


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	

	if ast_tab_sped.num_bolla_out > 0 then  
		

//--- legge righe SPEDIZIONE
		declare set_armo_prezzi_righe_C1 cursor for
                  select 
                           ARSP.ID_ARMO
                           ,sum(COLLI)
						,max(stampa)			
                      from ARSP
                     where  
                            ARSP.id_sped  = :ast_tab_sped.id_sped 
                     group by ID_ARMO
					using kguo_sqlca_db_magazzino ;
//                            and ARSP.DATA_BOLLA_OUT = :ast_tab_sped.DATA_BOLLA_OUT

 		open set_armo_prezzi_righe_C1;
		if kguo_sqlca_db_magazzino.sqlcode = 0 then 
			
			k_ctr ++
			fetch set_armo_prezzi_righe_C1 into
									:kst_tab_arsp[k_ctr].ID_ARMO
									, :kst_tab_arsp[k_ctr].COLLI
									, :kst_tab_arsp[k_ctr].STAMPA;
									
			do while kguo_sqlca_db_magazzino.sqlcode = 0
				
				k_ctr ++
				fetch set_armo_prezzi_righe_C1 into
									:kst_tab_arsp[k_ctr].ID_ARMO
									, :kst_tab_arsp[k_ctr].COLLI
									, :kst_tab_arsp[k_ctr].STAMPA;
			loop

			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore ricerca righe d.d.t. nr.=" + string(ast_tab_sped.num_bolla_out) + " del "  + string(ast_tab_sped.data_bolla_out) +": ~n~r" &
										 + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
			
			close set_armo_prezzi_righe_C1;

//--- finalmente aggiorna il flag
			kuf1_armo_prezzi = create kuf_armo_prezzi
			
			k_ctr = 1
			do while  k_ctr < upperbound(kst_tab_arsp[]) and (kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn)
				
				if kst_tab_arsp[k_ctr].ID_ARMO > 0 then

					kst_tab_armo_prezzi.st_tab_g_0.esegui_commit = ast_tab_sped.st_tab_g_0.esegui_commit // richiesta la commit?
					
					kst_tab_armo_prezzi.id_armo = kst_tab_arsp[k_ctr].ID_ARMO
					
//--- Controlla se esiste la riga su ARMO_PREZZI:  se esiste Aggiorna					
					if kuf1_armo_prezzi.if_esiste_x_id_armo(kst_tab_armo_prezzi) then
						kst_tab_armo_prezzi.item_dafatt = kst_tab_arsp[k_ctr].colli
						if not a_ripristino then
							
							kuf1_armo_prezzi.esegui_evento_scarico(kst_tab_armo_prezzi)		// AGGIORNA Evento di SPEDITO
							
						else
							
							if kst_tab_arsp[k_ctr].STAMPA = kuf1_sped.kki_sped_flg_stampa_bolla_stampata then // ripristino sono se 'stampato' 
								kuf1_armo_prezzi.esegui_evento_scarico_ripristina(kst_tab_armo_prezzi)		// RIPRISTINA colli 
							end if
							
						end if
					else
						kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
						kst_esito.SQLErrText = "Prezzo riga lotto assente, d.d.t. nr.=" + string(ast_tab_sped.num_bolla_out) + " del "  + string(ast_tab_sped.data_bolla_out) +": ~n~r" &
										 + trim(kguo_sqlca_db_magazzino.SQLErrText)
					
						kst_esito.esito = kkg_esito.db_wrn //--- carico non trovato
					end if
				end if
				
				k_ctr ++

			loop
			
			destroy kuf1_armo_prezzi 

		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore Ricerca (open) righe d.d.t. nr.=" + string(ast_tab_sped.num_bolla_out) + " del "  + string(ast_tab_sped.data_bolla_out) +") : ~n~r" &
										 + trim(kguo_sqlca_db_magazzino.SQLErrText)
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
		
			
		if kst_esito.esito = kkg_esito.ok then
		
//---- COMMIT....	
			if ast_tab_sped.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_sped.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		else		
			
			kGuf_data_base.errori_scrivi_esito("W", kst_esito)  //--- scrive il LOG
			
			if ast_tab_sped.st_tab_g_0. esegui_commit <> "N" or isnull(ast_tab_sped.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
		end if

	end if
	
	
catch (uo_exception kuo_exception)	
	kst_esito = kuo_exception.get_st_esito()
	kst_esito.sqlerrtext = "Errore durante Aggiornamento Scarico x la FATTURAZIONE. Avvertire l'ufficio!!!! DDT: " + string(ast_tab_sped.num_bolla_out) + " del "  + string(ast_tab_sped.data_bolla_out) +") : ~n~r" &
								+ trim(kst_esito.SQLErrText)
	kuo_exception.set_esito(kst_esito)
	throw kuo_exception
	
finally
	if kst_esito.esito = kkg_esito.ok then
		k_return=true
	end if
	
end try

return k_return


end function

public function boolean set_armo_prezzi_righe_all (ref st_tab_sped ast_tab_sped[], boolean a_ripristino) throws uo_exception;//
//--- Aggiorna i colli SPEDITI nelle righe tabella Prezzi-riga-lotto (ARMO_PREZZI)
//---
//--- input: st_tab_sped.id_sped
//---		a_ripristino 	flag se aggiungere o ripristinare
//---                 
//--- Out: boolean  true=tutto OK; false=almeno 1 bolla non ok  oppure nessun ID passato
//---
//
boolean k_return=true
boolean k_rc=false
int k_array, k_ind
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	k_array = upperbound(ast_tab_sped)
	
	for k_ind = 1 to k_array

		if ast_tab_sped[k_ind].id_sped > 0 then  
		
			k_rc = set_armo_prezzi_righe(ast_tab_sped[k_ind], a_ripristino)  // ELABORA!!!
			
			if not k_rc and k_return then
				k_return = false     //setta qls non ha funzionato (probabile solo righe ARMO_PREZZI non trovate x questo Lotto)
			end if
			
		end if
		
	end for
	if not k_rc then
		k_return = false     //manco un ID passato!
	end if
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	
end try

return k_return


end function

public function boolean if_stampato (st_tab_sped ast_tab_sped) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla se DDT gia' stampato
//--- 
//--- 
//--- Inp: st_tab_sped.id_sped
//--- Out: TRUE = stampato
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
long k_trovato=0
st_esito kst_esito
kuf_sped kuf1_sped


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()

//--- x numero spedicato			
	SELECT stampa
			into :ast_tab_sped.stampa
			 FROM sped  
			 where  id_sped  = :ast_tab_sped.id_sped
			 using kguo_sqlca_db_magazzino;
		
	if kguo_sqlca_db_magazzino.sqlcode < 0 then
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Errore durante lettura DDT (sped) id = " + string(ast_tab_sped.id_sped) + " " &
						 + "~n~rErrore: " + trim(kguo_sqlca_db_magazzino.SQLErrText)
									 
		kst_esito.esito = KKG_ESITO.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if ast_tab_sped.stampa  = kuf1_sped.kki_sped_flg_stampa_bolla_stampata then 
			k_return = true
		end if
	end if
	

return k_return



end function

public function boolean produci_ddt_riga_note_qtna (ref ds_ddt_stampa kds_ddt_stampa, long k_riga_ds) throws uo_exception;//---
//--- Corpo ddt: Stampa riga Note QUARANTENA
//---
boolean k_return=true
constant integer k_note_totali_len_riga = 73
string k_stampante, k_note_totali
long k_pagina
integer k_ctr
integer k_ufo
double k_differernza
string k_esito
st_esito kst_esito
st_tab_clienti kst_tab_clienti
st_tab_meca_qtna kst_tab_meca_qtna
st_tab_base kst_tab_base
kuf_base kuf1_base
kuf_meca_qtna kuf1_meca_qtna
kuf_ausiliari kuf1_ausiliari
 

try
	
	
	if kds_ddt_stampa.object.meca_id_meca[k_riga_ds] > 0 then
		
		kuf1_meca_qtna = create kuf_meca_qtna
		kst_tab_meca_qtna.id_meca = kds_ddt_stampa.object.meca_id_meca[k_riga_ds]
		kst_tab_meca_qtna.id_meca_qtna = kuf1_meca_qtna.get_id_meca_qtna(kst_tab_meca_qtna)
		if  kst_tab_meca_qtna.id_meca_qtna > 0 then
			
	//--- verifica se Quarantena da stampare
			if kuf1_meca_qtna.if_stampa_nel_ddt(kst_tab_meca_qtna)  then
				
				
				kuf1_base = create kuf_base
				k_esito = kuf1_base.prendi_dato_base( "ddt_qtna_note")
				if left(k_esito,1) <> "0" then
					kst_esito.nome_oggetto = this.classname()
					kst_esito.esito = kkg_esito.db_ko  
					kst_esito.sqlcode = 0
					kst_esito.SQLErrText = mid(k_esito,2)
				else
					kst_tab_base.ddt_qtna_note	= trim(mid(k_esito,2))
				end if
	
	
	//			if ki_ddt_riga_corpo < 13 then 
	//				ki_ddt_riga_corpo = 14	// vorrei stampare la dicitura in mezzo al ddt
	//			else
	//				ki_ddt_riga_corpo += 1    // lascio una riga vuota
	//			end if
				
	//--- aggiungo Riga e controllo Fine Pagina	
				k_pagina = produci_ddt_riga_add() 
				if k_pagina = 0 then 
					kst_esito.esito = kkg_esito.err_logico
					kst_esito.sqlcode = 0
					kst_esito.sqlerrtext = "Errore numero riga durante produzione stampa d.d.t."
					kst_esito.nome_oggetto = this.classname()
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
				
	//--- espone descrizione QUARANTENA
				kids_stampa_ddt.setitem(k_pagina, "descr_" + string(ki_ddt_riga_corpo), "   ***   " + trim(kst_tab_base.ddt_qtna_note ) + "   ***   ")
			
			end if
			
		end if
		
	end if

catch (uo_exception kuo_exception)
	throw(kuo_exception)

finally
	if isvalid(kuf1_meca_qtna) then destroy kuf1_meca_qtna
	if isvalid(kuf1_base) then destroy kuf1_base
	
end try


	
return k_return

end function

on kuf_sped_ddt.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_sped_ddt.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
kiuf_sped = create kuf_sped

end event

event destructor;//
if isvalid(kiuf_sped) then destroy kiuf_sped

end event

