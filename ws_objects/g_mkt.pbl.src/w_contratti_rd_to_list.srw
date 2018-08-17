$PBExportHeader$w_contratti_rd_to_list.srw
forward
global type w_contratti_rd_to_list from w_contratti_co_to_list
end type
end forward

global type w_contratti_rd_to_list from w_contratti_co_to_list
end type
global w_contratti_rd_to_list w_contratti_rd_to_list

type variables
//
kuf_contratti_rd kiuf_contratti_rd
end variables

forward prototypes
public function long esegui ()
protected subroutine open_start_window ()
public subroutine elenco_esiti (boolean k_visibile)
end prototypes

public function long esegui ();//
//--- lancia l'operazione di inserimento Conferme Ordine e Listini  da  Contratto Studio Sviluppo
//
long k_return = 0
long k_ctr=0, k_ctr_contratti_rd=0, k_ctr_da_trasferire=0
st_contratti_rd_to_listini kst_contratti_rd_to_listini
st_tab_contratti_rd kst_tab_contratti_rd

	
	try 
		
//--- apri il LOG
		kiuf_contratti_rd.log_inizializza( )

		
		if this.rb_definitiva_no.checked then // è di simulazione?
			kst_contratti_rd_to_listini.k_simulazione = "S"
		else
			if this.rb_definitiva_si.checked then // è definitiva?
				kst_contratti_rd_to_listini.k_simulazione = "N"  // crea CO e LISTINI in automatico
			else
				kst_contratti_rd_to_listini.k_simulazione = "M"  // crea manualmente l'operatore il CO e LISTINI
			end if
		end if
		if this.rb_stato_attivo.checked then  // attiva subito il listino?
			kst_contratti_rd_to_listini.k_subito_in_vigore = "S" 
		else
			kst_contratti_rd_to_listini.k_subito_in_vigore = "N" 
		end if
//		if this.rb_occup_pedana_precisa.checked then  // come calcolare l'occcupazione impianto?
//			kst_contratti_rd_to_listini.k_occup_pedana_precisa = "S" 
//		else
//			kst_contratti_rd_to_listini.k_occup_pedana_precisa = "N" 
//		end if

		if kst_contratti_rd_to_listini.k_simulazione = "N" then
			k_ctr = messagebox("Operazione DEFINITIVA", "Proseguire con l'operazione di trasferimento dei Contratti?", Question!, yesno!, 2)
		else
			if kst_contratti_rd_to_listini.k_simulazione = "M" then
				k_ctr = messagebox("Operazione DEFINITIVA", "Dovrai creare Conferma Ordine e Listini manualmente, sei sicuro di voler proseguire?", Question!, yesno!, 2)
			else
				k_ctr = 1  // simulazione non chiedo nulla
			end if
		end if

//--- se ho risposto OK 
		if k_ctr = 1 then
			for k_ctr = 1 to dw_documenti.rowcount( )
				
				if dw_documenti.getitemnumber(k_ctr, "sel") = 1 or rb_emissione_tutto.checked then
					
					k_ctr_da_trasferire ++
					
					kst_tab_contratti_rd.id_contratto_rd = dw_documenti.getitemnumber(k_ctr, "id_contratto_rd")
	//--- LANCIA LA CONVERSIONE	
					k_return = kiuf_contratti_rd.u_conv_to_conferma_ordine_e_listini( kst_tab_contratti_rd, kst_contratti_rd_to_listini)
					if k_return > 0 then
						
						k_ctr_contratti_rd ++
					end if
				end if
			end for
	
			if kst_contratti_rd_to_listini.k_simulazione = "S" then
				kguo_exception.setmessage("Fine Simulazione Trasferimento, visualizza l'esito nel Log")
				kguo_exception.messaggio_utente( )
			else
				if k_ctr_contratti_rd > 0 then
					kguo_exception.setmessage("Contratti Studio Sviluppo 'Trasferiti': " + string(k_ctr_contratti_rd) )
					kguo_exception.messaggio_utente( )
					
					inizializza( ) // rilegge l'elenco
				else
					kguo_exception.set_tipo(kguo_exception.kk_st_uo_exception_tipo_dati_anomali )
					if k_ctr_da_trasferire = 0 then
						kguo_exception.setmessage("Selezionare almeno un Contratto Studio Sviluppo da Trasferire")
					else
						kguo_exception.setmessage("Nessun Contratto Studio Sviluppo Trasferito")
					end if
					kguo_exception.messaggio_utente( )
					
				end if
			end if
		else
			kguo_exception.setmessage("Operazione interrotta dall'utente")
			kguo_exception.messaggio_utente( )
		end if		

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()

	finally
		kiuf_contratti_rd.log_destroy( )
		
		
	end try


return k_return


end function

protected subroutine open_start_window ();//---
//
pointer kpointer_orig

kiuf_contratti_rd = create kuf_contratti_rd

dw_documenti.settransobject( sqlca )
dw_esiti.settransobject( sqlca )


try 
	
	kpointer_orig = setpointer(hourglass!)

//--- lancia la retrieve!
	inizializza( )

	catch (uo_exception kuo_exception)
		kuo_exception.messaggio_utente()
		this.postevent(close!)

	finally
		setpointer(kpointer_orig)	
		
end try


end subroutine

public subroutine elenco_esiti (boolean k_visibile);//
kuf_esito_operazioni kuf1_esito_operazioni
datetime k_ts


if k_visibile then

	k_ts = datetime(relativedate( kg_dataoggi, - 30))
	
	dw_esiti.retrieve(kuf1_esito_operazioni.kki_tipo_operazione_rdco_to_listino, "S", k_ts  )

end if

dw_esiti.event ue_visibile(k_visibile)

end subroutine

on w_contratti_rd_to_list.create
call super::create
end on

on w_contratti_rd_to_list.destroy
call super::destroy
end on

type st_ritorna from w_contratti_co_to_list`st_ritorna within w_contratti_rd_to_list
end type

type st_ordina_lista from w_contratti_co_to_list`st_ordina_lista within w_contratti_rd_to_list
end type

type st_aggiorna_lista from w_contratti_co_to_list`st_aggiorna_lista within w_contratti_rd_to_list
end type

type cb_ritorna from w_contratti_co_to_list`cb_ritorna within w_contratti_rd_to_list
end type

type st_stampa from w_contratti_co_to_list`st_stampa within w_contratti_rd_to_list
end type

type rb_emissione_tutto from w_contratti_co_to_list`rb_emissione_tutto within w_contratti_rd_to_list
end type

type rb_emissione_selezione from w_contratti_co_to_list`rb_emissione_selezione within w_contratti_rd_to_list
end type

type rb_definitiva_si from w_contratti_co_to_list`rb_definitiva_si within w_contratti_rd_to_list
end type

type rb_definitiva_no from w_contratti_co_to_list`rb_definitiva_no within w_contratti_rd_to_list
end type

type pb_ok from w_contratti_co_to_list`pb_ok within w_contratti_rd_to_list
end type

type dw_documenti from w_contratti_co_to_list`dw_documenti within w_contratti_rd_to_list
string dataobject = "d_contratti_rd_l_x_conversione"
end type

type st_1 from w_contratti_co_to_list`st_1 within w_contratti_rd_to_list
end type

type rb_stato_da_attivare from w_contratti_co_to_list`rb_stato_da_attivare within w_contratti_rd_to_list
end type

type rb_stato_attivo from w_contratti_co_to_list`rb_stato_attivo within w_contratti_rd_to_list
end type

type pb_st_esiti_operazioni from w_contratti_co_to_list`pb_st_esiti_operazioni within w_contratti_rd_to_list
end type

type dw_esiti from w_contratti_co_to_list`dw_esiti within w_contratti_rd_to_list
end type

type st_esiti_operazioni from w_contratti_co_to_list`st_esiti_operazioni within w_contratti_rd_to_list
end type

type rb_occup_pedana_vincolata from w_contratti_co_to_list`rb_occup_pedana_vincolata within w_contratti_rd_to_list
boolean visible = false
boolean enabled = false
end type

type rb_occup_pedana_precisa from w_contratti_co_to_list`rb_occup_pedana_precisa within w_contratti_rd_to_list
boolean visible = false
boolean enabled = false
end type

type rb_definitiva_manuale from w_contratti_co_to_list`rb_definitiva_manuale within w_contratti_rd_to_list
end type

type gb_aggiorna from w_contratti_co_to_list`gb_aggiorna within w_contratti_rd_to_list
end type

type gb_emissione from w_contratti_co_to_list`gb_emissione within w_contratti_rd_to_list
end type

type gb_occup_pedana from w_contratti_co_to_list`gb_occup_pedana within w_contratti_rd_to_list
boolean visible = false
boolean enabled = false
end type

type gb_produzione from w_contratti_co_to_list`gb_produzione within w_contratti_rd_to_list
end type

type rr_1 from w_contratti_co_to_list`rr_1 within w_contratti_rd_to_list
end type

