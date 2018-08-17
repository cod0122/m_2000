$PBExportHeader$w_m2000tocrm.srw
forward
global type w_m2000tocrm from w_g_tab
end type
type cb_crm_art from commandbutton within w_m2000tocrm
end type
type st_1 from statictext within w_m2000tocrm
end type
type dw_elenco from uo_d_std_1 within w_m2000tocrm
end type
type cb_elenco_art from commandbutton within w_m2000tocrm
end type
type cb_crm_clie_classi from commandbutton within w_m2000tocrm
end type
type cb_elenco_clie_classi from commandbutton within w_m2000tocrm
end type
type cb_crm_clie_settori from commandbutton within w_m2000tocrm
end type
type cb_elenco_clie_settori from commandbutton within w_m2000tocrm
end type
type cb_crm_clienti from commandbutton within w_m2000tocrm
end type
type cb_elenco_clienti from commandbutton within w_m2000tocrm
end type
type cb_crm_contatti from commandbutton within w_m2000tocrm
end type
type cb_elenco_contatti from commandbutton within w_m2000tocrm
end type
type cb_crm_contratti from commandbutton within w_m2000tocrm
end type
type cb_elenco_contratti from commandbutton within w_m2000tocrm
end type
type cb_crm_gruppi from commandbutton within w_m2000tocrm
end type
type cb_elenco_gruppi from commandbutton within w_m2000tocrm
end type
type cb_crm_sl_pt from commandbutton within w_m2000tocrm
end type
type cb_elenco_sl_pt from commandbutton within w_m2000tocrm
end type
type cb_crm_listino from commandbutton within w_m2000tocrm
end type
type cb_elenco_listino from commandbutton within w_m2000tocrm
end type
type cb_crm_conferma_dordine from commandbutton within w_m2000tocrm
end type
type cb_elenco_conferma_dordine from commandbutton within w_m2000tocrm
end type
type cb_crm_tot_mese from commandbutton within w_m2000tocrm
end type
type cb_elenco_tot_mese from commandbutton within w_m2000tocrm
end type
type cb_1 from commandbutton within w_m2000tocrm
end type
type cb_2 from commandbutton within w_m2000tocrm
end type
type gb_stat from groupbox within w_m2000tocrm
end type
type gb_anag from groupbox within w_m2000tocrm
end type
type gb_contratti from groupbox within w_m2000tocrm
end type
end forward

global type w_m2000tocrm from w_g_tab
integer width = 4160
integer height = 2832
cb_crm_art cb_crm_art
st_1 st_1
dw_elenco dw_elenco
cb_elenco_art cb_elenco_art
cb_crm_clie_classi cb_crm_clie_classi
cb_elenco_clie_classi cb_elenco_clie_classi
cb_crm_clie_settori cb_crm_clie_settori
cb_elenco_clie_settori cb_elenco_clie_settori
cb_crm_clienti cb_crm_clienti
cb_elenco_clienti cb_elenco_clienti
cb_crm_contatti cb_crm_contatti
cb_elenco_contatti cb_elenco_contatti
cb_crm_contratti cb_crm_contratti
cb_elenco_contratti cb_elenco_contratti
cb_crm_gruppi cb_crm_gruppi
cb_elenco_gruppi cb_elenco_gruppi
cb_crm_sl_pt cb_crm_sl_pt
cb_elenco_sl_pt cb_elenco_sl_pt
cb_crm_listino cb_crm_listino
cb_elenco_listino cb_elenco_listino
cb_crm_conferma_dordine cb_crm_conferma_dordine
cb_elenco_conferma_dordine cb_elenco_conferma_dordine
cb_crm_tot_mese cb_crm_tot_mese
cb_elenco_tot_mese cb_elenco_tot_mese
cb_1 cb_1
cb_2 cb_2
gb_stat gb_stat
gb_anag gb_anag
gb_contratti gb_contratti
end type
global w_m2000tocrm w_m2000tocrm

type variables
//
private kuf_m2000tocrm kiuf_m2000tocrm
private kuo_sqlca_db_crm kiuo_sqlca_db_crm

end variables

forward prototypes
protected function string inizializza () throws uo_exception
protected subroutine open_start_window ()
public function long test ()
end prototypes

protected function string inizializza () throws uo_exception;//
this.visible = true


return "0"
end function

protected subroutine open_start_window ();//
kiuf_m2000tocrm = create kuf_m2000tocrm

try
	if not isvalid(kiuo_sqlca_db_crm) then kiuo_sqlca_db_crm = create kuo_sqlca_db_crm
	inizializza()
	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
	
	
end try

end subroutine

public function long test ();//------------------------------------------------------------------------------------------------------------------
//--- Copia i dati da M2000 alle tabelle di scambio con il CRM
//---
//--- out: numero di rghe copiate
//---
//------------------------------------------------------------------------------------------------------------------
long k_return= 0
long k_riga=0, k_righe= 0
int k_rc=0
datastore kds_crm_clienti

try
	
	kds_crm_clienti = create datastore 
	kds_crm_clienti.dataobject = "ds_crm_clienti" 
	kds_crm_clienti.settransobject( kguo_sqlca_db_magazzino )
	
	kiuo_sqlca_db_crm.db_connetti( )
	dw_elenco.dataobject = "ds_crmtab_crm_clienti"
	dw_elenco.settransobject( kiuo_sqlca_db_crm )
	
	
	//--- cancella tutte le righe in tabella
	dw_elenco.retrieve( )
	for k_riga =dw_elenco.rowcount( ) to 1 step -1
		dw_elenco.deleterow(k_riga)
	next
	dw_elenco.update( )
	kiuo_sqlca_db_crm.db_commit( )
	
	//--- copia le righe la M2000 a CRM
	kds_crm_clienti.retrieve()
	k_righe = kds_crm_clienti.rowcount() 
	if k_righe > 0 then
		for k_riga = 1 to k_righe 
			dw_elenco.insertrow(k_riga)
			dw_elenco.object.id_cliente[k_riga] = kds_crm_clienti.object.id_cliente[k_riga]
			dw_elenco.object.tipo[k_riga] = kds_crm_clienti.object.tipo[k_riga]
			dw_elenco.object.tipo_descr[k_riga] = kds_crm_clienti.object.tipo_descr[k_riga]
			dw_elenco.object.stato[k_riga] = kds_crm_clienti.object.stato[k_riga]
			dw_elenco.object.stato_descr[k_riga] = kds_crm_clienti.object.stato_descr[k_riga]
			dw_elenco.object.data_attivazione[k_riga] = kds_crm_clienti.object.data_attivazione[k_riga]
			dw_elenco.object.id_clie_settore[k_riga] = kds_crm_clienti.object.id_clie_settore[k_riga]
			dw_elenco.object.settore_descrizione[k_riga] = kds_crm_clienti.object.settore_descrizione[k_riga]
			dw_elenco.object.id_clie_classe[k_riga] = kds_crm_clienti.object.id_clie_classe[k_riga]
			dw_elenco.object.classe_descr[k_riga] = kds_crm_clienti.object.classe_descr[k_riga]
			dw_elenco.object.sede_rag_soc[k_riga] = kds_crm_clienti.object.sede_rag_soc[k_riga]
			dw_elenco.object.sede_indi[k_riga] = kds_crm_clienti.object.sede_indi[k_riga]
			dw_elenco.object.sede_cap[k_riga] = kds_crm_clienti.object.sede_cap[k_riga]
			dw_elenco.object.sede_loc[k_riga] = kds_crm_clienti.object.sede_loc[k_riga]
			dw_elenco.object.sede_prov[k_riga] = kds_crm_clienti.object.sede_prov[k_riga]
			dw_elenco.object.sede_zona[k_riga] = kds_crm_clienti.object.sede_zona[k_riga]
			dw_elenco.object.sede_nazione[k_riga] = kds_crm_clienti.object.sede_nazione[k_riga]
			dw_elenco.object.nazione_nome[k_riga] = kds_crm_clienti.object.nazione_nome[k_riga]
			dw_elenco.object.nazione_area[k_riga] = kds_crm_clienti.object.nazione_area[k_riga]
			dw_elenco.object.partitaiva[k_riga] = kds_crm_clienti.object.partitaiva[k_riga]
			dw_elenco.object.codicefiscale[k_riga] = kds_crm_clienti.object.codicefiscale[k_riga]
			dw_elenco.object.telefono[k_riga] = kds_crm_clienti.object.telefono[k_riga]
			dw_elenco.object.fax[k_riga] = kds_crm_clienti.object.fax[k_riga]
			dw_elenco.object.codice_pagamento[k_riga] = kds_crm_clienti.object.codice_pagamento[k_riga]
			dw_elenco.object.pagamento_descr[k_riga] = kds_crm_clienti.object.pagamento_descr[k_riga]
			dw_elenco.object.banca[k_riga] = kds_crm_clienti.object.banca[k_riga]
			dw_elenco.object.abi[k_riga] = kds_crm_clienti.object.abi[k_riga]
			dw_elenco.object.cab[k_riga] = kds_crm_clienti.object.cab[k_riga]
			
		end for
		k_rc = dw_elenco.update( )
		kiuo_sqlca_db_crm.db_commit( )
		k_return = dw_elenco.retrieve()
	
		kiuo_sqlca_db_crm.db_disconnetti( )
			
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

end try

return k_return


end function

on w_m2000tocrm.create
int iCurrent
call super::create
this.cb_crm_art=create cb_crm_art
this.st_1=create st_1
this.dw_elenco=create dw_elenco
this.cb_elenco_art=create cb_elenco_art
this.cb_crm_clie_classi=create cb_crm_clie_classi
this.cb_elenco_clie_classi=create cb_elenco_clie_classi
this.cb_crm_clie_settori=create cb_crm_clie_settori
this.cb_elenco_clie_settori=create cb_elenco_clie_settori
this.cb_crm_clienti=create cb_crm_clienti
this.cb_elenco_clienti=create cb_elenco_clienti
this.cb_crm_contatti=create cb_crm_contatti
this.cb_elenco_contatti=create cb_elenco_contatti
this.cb_crm_contratti=create cb_crm_contratti
this.cb_elenco_contratti=create cb_elenco_contratti
this.cb_crm_gruppi=create cb_crm_gruppi
this.cb_elenco_gruppi=create cb_elenco_gruppi
this.cb_crm_sl_pt=create cb_crm_sl_pt
this.cb_elenco_sl_pt=create cb_elenco_sl_pt
this.cb_crm_listino=create cb_crm_listino
this.cb_elenco_listino=create cb_elenco_listino
this.cb_crm_conferma_dordine=create cb_crm_conferma_dordine
this.cb_elenco_conferma_dordine=create cb_elenco_conferma_dordine
this.cb_crm_tot_mese=create cb_crm_tot_mese
this.cb_elenco_tot_mese=create cb_elenco_tot_mese
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_stat=create gb_stat
this.gb_anag=create gb_anag
this.gb_contratti=create gb_contratti
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_crm_art
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_elenco
this.Control[iCurrent+4]=this.cb_elenco_art
this.Control[iCurrent+5]=this.cb_crm_clie_classi
this.Control[iCurrent+6]=this.cb_elenco_clie_classi
this.Control[iCurrent+7]=this.cb_crm_clie_settori
this.Control[iCurrent+8]=this.cb_elenco_clie_settori
this.Control[iCurrent+9]=this.cb_crm_clienti
this.Control[iCurrent+10]=this.cb_elenco_clienti
this.Control[iCurrent+11]=this.cb_crm_contatti
this.Control[iCurrent+12]=this.cb_elenco_contatti
this.Control[iCurrent+13]=this.cb_crm_contratti
this.Control[iCurrent+14]=this.cb_elenco_contratti
this.Control[iCurrent+15]=this.cb_crm_gruppi
this.Control[iCurrent+16]=this.cb_elenco_gruppi
this.Control[iCurrent+17]=this.cb_crm_sl_pt
this.Control[iCurrent+18]=this.cb_elenco_sl_pt
this.Control[iCurrent+19]=this.cb_crm_listino
this.Control[iCurrent+20]=this.cb_elenco_listino
this.Control[iCurrent+21]=this.cb_crm_conferma_dordine
this.Control[iCurrent+22]=this.cb_elenco_conferma_dordine
this.Control[iCurrent+23]=this.cb_crm_tot_mese
this.Control[iCurrent+24]=this.cb_elenco_tot_mese
this.Control[iCurrent+25]=this.cb_1
this.Control[iCurrent+26]=this.cb_2
this.Control[iCurrent+27]=this.gb_stat
this.Control[iCurrent+28]=this.gb_anag
this.Control[iCurrent+29]=this.gb_contratti
end on

on w_m2000tocrm.destroy
call super::destroy
destroy(this.cb_crm_art)
destroy(this.st_1)
destroy(this.dw_elenco)
destroy(this.cb_elenco_art)
destroy(this.cb_crm_clie_classi)
destroy(this.cb_elenco_clie_classi)
destroy(this.cb_crm_clie_settori)
destroy(this.cb_elenco_clie_settori)
destroy(this.cb_crm_clienti)
destroy(this.cb_elenco_clienti)
destroy(this.cb_crm_contatti)
destroy(this.cb_elenco_contatti)
destroy(this.cb_crm_contratti)
destroy(this.cb_elenco_contratti)
destroy(this.cb_crm_gruppi)
destroy(this.cb_elenco_gruppi)
destroy(this.cb_crm_sl_pt)
destroy(this.cb_elenco_sl_pt)
destroy(this.cb_crm_listino)
destroy(this.cb_elenco_listino)
destroy(this.cb_crm_conferma_dordine)
destroy(this.cb_elenco_conferma_dordine)
destroy(this.cb_crm_tot_mese)
destroy(this.cb_elenco_tot_mese)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_stat)
destroy(this.gb_anag)
destroy(this.gb_contratti)
end on

event resize;call super::resize;//
dw_elenco.x = gb_anag.x + gb_anag.width + 50
dw_elenco.width = this.width - dw_elenco.x - 100

end event

type st_ritorna from w_g_tab`st_ritorna within w_m2000tocrm
integer x = 2994
integer y = 276
end type

type st_ordina_lista from w_g_tab`st_ordina_lista within w_m2000tocrm
integer x = 2994
integer y = 176
integer height = 408
end type

type st_aggiorna_lista from w_g_tab`st_aggiorna_lista within w_m2000tocrm
integer x = 2994
integer y = 436
end type

type cb_ritorna from w_g_tab`cb_ritorna within w_m2000tocrm
integer x = 2994
integer y = 160
end type

type st_stampa from w_g_tab`st_stampa within w_m2000tocrm
integer x = 2994
integer y = 352
end type

type cb_crm_art from commandbutton within w_m2000tocrm
integer x = 69
integer y = 400
integer width = 640
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Articoli"
end type

event clicked;//
long k_rc=0
st_esito kst_esito


try
	if messagebox("Esporta dati", "Genera dati 'ARTICOLI' per la Procedura CRM, confermare l'operazione !", information!, yesno!, 2) = 1 then
		k_rc = kiuf_m2000tocrm.u_m2000_to_crm_art( )
		
		if  k_rc > 0 then
			
			messagebox("Operazione terminata", "Sono stati esportati  " + string(k_rc) + " Articoli. ~n~rE' ora possibile eseguire l'importazione dal CRM. ", information!)
	
		else	
			messagebox("Operazione in anomalia ", "Dati non esportati o incompleti, procedura in errore", Exclamation!)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente( "Operazione errata", "Esportazione conclusa per errore ~n~r" + "Cod. " + string(kst_esito.sqlcode) + " - " + kst_esito.sqlerrtext)
	
end try


end event

type st_1 from statictext within w_m2000tocrm
integer x = 69
integer y = 60
integer width = 2181
integer height = 144
boolean bringtotop = true
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "ESPORTA DATI VERSO IL CRM"
boolean focusrectangle = false
end type

type dw_elenco from uo_d_std_1 within w_m2000tocrm
boolean visible = true
integer x = 1042
integer y = 328
integer width = 2825
integer height = 2232
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Consulta dati da esportare verso il CRM"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_elenco_art from commandbutton within w_m2000tocrm
integer x = 763
integer y = 400
integer width = 155
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;//
try
	kiuo_sqlca_db_crm.db_connetti( )
	dw_elenco.dataobject = "ds_crmtab_crm_art"
	dw_elenco.settransobject( kiuo_sqlca_db_crm )
	dw_elenco.retrieve()
	dw_elenco.enabled = true
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try
end event

type cb_crm_clie_classi from commandbutton within w_m2000tocrm
integer x = 69
integer y = 560
integer width = 640
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Classi cliente"
end type

event clicked;//
long k_rc=0
st_esito kst_esito


try
	if messagebox("Esporta dati", "Genera dati 'CLASSI CLIENTE' per la Procedura CRM, confermare l'operazione !", information!, yesno!, 2) = 1 then
		k_rc = kiuf_m2000tocrm.u_m2000_to_crm_clie_classi( )
		
		if  k_rc > 0 then
			
			messagebox("Operazione terminata", "Sono stati esportati  " + string(k_rc) + " Classi. ~n~rE' ora possibile eseguire l'importazione dal CRM. ", information!)
	
		else	
			messagebox("Operazione in anomalia ", "Dati non esportati o incompleti, procedura in errore", Exclamation!)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente( "Operazione errata", "Esportazione conclusa per errore ~n~r" + "Cod. " + string(kst_esito.sqlcode) + " - " + kst_esito.sqlerrtext)
	
end try


end event

type cb_elenco_clie_classi from commandbutton within w_m2000tocrm
integer x = 763
integer y = 560
integer width = 155
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;//
try
	kiuo_sqlca_db_crm.db_connetti( )
	dw_elenco.dataobject = "ds_crmtab_crm_clie_classi"
	dw_elenco.settransobject( kiuo_sqlca_db_crm )
	dw_elenco.retrieve()
	dw_elenco.enabled = true
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try
end event

type cb_crm_clie_settori from commandbutton within w_m2000tocrm
integer x = 69
integer y = 716
integer width = 640
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Settori cliente"
end type

event clicked;//
long k_rc=0
st_esito kst_esito


try
	if messagebox("Esporta dati", "Genera dati 'SETTORI CLIENTI' per la Procedura CRM, confermare l'operazione !", information!, yesno!, 2) = 1 then
		k_rc = kiuf_m2000tocrm.u_m2000_to_crm_clie_settori( )
		
		if  k_rc > 0 then
			
			messagebox("Operazione terminata", "Sono stati esportati  " + string(k_rc) + " Settori. ~n~rE' ora possibile eseguire l'importazione dal CRM. ", information!)
	
		else	
			messagebox("Operazione in anomalia ", "Dati non esportati o incompleti, procedura in errore", Exclamation!)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente( "Operazione errata", "Esportazione conclusa per errore ~n~r" + "Cod. " + string(kst_esito.sqlcode) + " - " + kst_esito.sqlerrtext)
	
end try


end event

type cb_elenco_clie_settori from commandbutton within w_m2000tocrm
integer x = 763
integer y = 716
integer width = 155
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;//
try
	kiuo_sqlca_db_crm.db_connetti( )
	dw_elenco.dataobject = "ds_crmtab_crm_clie_settori"
	dw_elenco.settransobject( kiuo_sqlca_db_crm )
	dw_elenco.retrieve()
	dw_elenco.enabled = true
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try
end event

type cb_crm_clienti from commandbutton within w_m2000tocrm
integer x = 69
integer y = 852
integer width = 640
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Anagrafiche"
end type

event clicked;//
long k_rc=0
st_esito kst_esito


try
	if messagebox("Esporta dati", "Genera 'ANAGRAFICHE CLIENTI, CONTATTI, ...' per la Procedura CRM, confermare l'operazione !", information!, yesno!, 2) = 1 then
//		k_rc = test()
		k_rc = kiuf_m2000tocrm.u_m2000_to_crm_clienti( )
		
		if  k_rc > 0 then
			
			messagebox("Operazione terminata", "Sono stati esportati  " + string(k_rc) + " Anagrafiche. ~n~rE' ora possibile eseguire l'importazione dal CRM. ", information!)
	
		else	
			messagebox("Operazione in anomalia ", "Dati non esportati o incompleti, procedura in errore", Exclamation!)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente( "Operazione errata", "Esportazione conclusa per errore ~n~r" + "Cod. " + string(kst_esito.sqlcode) + " - " + kst_esito.sqlerrtext)
	
end try


end event

type cb_elenco_clienti from commandbutton within w_m2000tocrm
integer x = 763
integer y = 852
integer width = 155
integer height = 104
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;//
try
	kiuo_sqlca_db_crm.db_connetti( )
	dw_elenco.dataobject = "d_crmtab_crm_clienti"
	dw_elenco.settransobject( kiuo_sqlca_db_crm )
	dw_elenco.retrieve()
	dw_elenco.enabled = true
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try
end event

type cb_crm_contatti from commandbutton within w_m2000tocrm
integer x = 69
integer y = 1000
integer width = 640
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contatti"
end type

event clicked;//
long k_rc=0
st_esito kst_esito


try
	if messagebox("Esporta dati", "Genera dati 'CONTATTI CLIENTI' per la Procedura CRM, confermare l'operazione !", information!, yesno!, 2) = 1 then
		k_rc = kiuf_m2000tocrm.u_m2000_to_crm_clienti_contatti( )
		
		if  k_rc > 0 then
			
			messagebox("Operazione terminata", "Sono stati esportati  " + string(k_rc) + " Contatti. ~n~rE' ora possibile eseguire l'importazione dal CRM. ", information!)
	
		else	
			messagebox("Operazione in anomalia ", "Dati non esportati o incompleti, procedura in errore", Exclamation!)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente( "Operazione errata", "Esportazione conclusa per errore ~n~r" + "Cod. " + string(kst_esito.sqlcode) + " - " + kst_esito.sqlerrtext)
	
end try


end event

type cb_elenco_contatti from commandbutton within w_m2000tocrm
integer x = 763
integer y = 1000
integer width = 155
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;//
try
	kiuo_sqlca_db_crm.db_connetti( )
	dw_elenco.dataobject = "ds_crmtab_crm_clienti_contatti"
	dw_elenco.settransobject( kiuo_sqlca_db_crm )
	dw_elenco.retrieve()
	dw_elenco.enabled = true
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try
end event

type cb_crm_contratti from commandbutton within w_m2000tocrm
integer x = 69
integer y = 1308
integer width = 640
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contratti"
end type

event clicked;//
long k_rc=0
st_esito kst_esito


try
	if messagebox("Esporta dati", "Genera dati 'CONTRATTI' per la Procedura CRM, confermare l'operazione !", information!, yesno!, 2) = 1 then
		k_rc = kiuf_m2000tocrm.u_m2000_to_crm_contratti( )
		
		if  k_rc > 0 then
			
			messagebox("Operazione terminata", "Sono stati esportati  " + string(k_rc) + " Contratti. ~n~rE' ora possibile eseguire l'importazione dal CRM. ", information!)
	
		else	
			messagebox("Operazione in anomalia ", "Dati non esportati o incompleti, procedura in errore", Exclamation!)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente( "Operazione errata", "Esportazione conclusa per errore ~n~r" + "Cod. " + string(kst_esito.sqlcode) + " - " + kst_esito.sqlerrtext)
	
end try


end event

type cb_elenco_contratti from commandbutton within w_m2000tocrm
integer x = 763
integer y = 1308
integer width = 155
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;//
try
	kiuo_sqlca_db_crm.db_connetti( )
	dw_elenco.dataobject = "ds_crmtab_crm_contratti"
	dw_elenco.settransobject( kiuo_sqlca_db_crm )
	dw_elenco.retrieve()
	dw_elenco.enabled = true
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try
end event

type cb_crm_gruppi from commandbutton within w_m2000tocrm
integer x = 69
integer y = 1460
integer width = 640
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Gruppi"
end type

event clicked;//
long k_rc=0
st_esito kst_esito


try
	if messagebox("Esporta dati", "Genera dati 'GRUPPI' per la Procedura CRM, confermare l'operazione !", information!, yesno!, 2) = 1 then
		k_rc = kiuf_m2000tocrm.u_m2000_to_crm_gruppi( )
		
		if  k_rc > 0 then
			
			messagebox("Operazione terminata", "Sono stati esportati  " + string(k_rc) + " Gruppi. ~n~rE' ora possibile eseguire l'importazione dal CRM. ", information!)
	
		else	
			messagebox("Operazione in anomalia ", "Dati non esportati o incompleti, procedura in errore", Exclamation!)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente( "Operazione errata", "Esportazione conclusa per errore ~n~r" + "Cod. " + string(kst_esito.sqlcode) + " - " + kst_esito.sqlerrtext)
	
end try


end event

type cb_elenco_gruppi from commandbutton within w_m2000tocrm
integer x = 763
integer y = 1460
integer width = 155
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;//
try
	kiuo_sqlca_db_crm.db_connetti( )
	dw_elenco.dataobject = "ds_crmtab_crm_gruppi"
	dw_elenco.settransobject( kiuo_sqlca_db_crm )
	dw_elenco.retrieve()
	dw_elenco.enabled = true
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try
end event

type cb_crm_sl_pt from commandbutton within w_m2000tocrm
integer x = 69
integer y = 1624
integer width = 640
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Piani di Trattamento"
end type

event clicked;//
long k_rc=0
st_esito kst_esito


try
	if messagebox("Esporta dati", "Genera dati dei 'PIANI DI TRATTAMENTO' per la Procedura CRM, confermare l'operazione !", information!, yesno!, 2) = 1 then
		k_rc = kiuf_m2000tocrm.u_m2000_to_crm_sl_pt( )
		
		if  k_rc > 0 then
			
			messagebox("Operazione terminata", "Sono stati esportati  " + string(k_rc) + " P.T.. ~n~rE' ora possibile eseguire l'importazione dal CRM. ", information!)
	
		else	
			messagebox("Operazione in anomalia ", "Dati non esportati o incompleti, procedura in errore", Exclamation!)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente( "Operazione errata", "Esportazione conclusa per errore ~n~r" + "Cod. " + string(kst_esito.sqlcode) + " - " + kst_esito.sqlerrtext)
	
end try


end event

type cb_elenco_sl_pt from commandbutton within w_m2000tocrm
integer x = 763
integer y = 1624
integer width = 155
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;//
try
	kiuo_sqlca_db_crm.db_connetti( )
	dw_elenco.dataobject = "ds_crmtab_crm_sl_pt"
	dw_elenco.settransobject( kiuo_sqlca_db_crm )
	dw_elenco.retrieve()
	dw_elenco.enabled = true
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try
end event

type cb_crm_listino from commandbutton within w_m2000tocrm
integer x = 69
integer y = 1940
integer width = 640
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Listini"
end type

event clicked;//
long k_rc=0
st_esito kst_esito


try
	if messagebox("Esporta dati", "Genera dati 'LISTINI' per la Procedura CRM, confermare l'operazione !", information!, yesno!, 2) = 1 then
		k_rc = kiuf_m2000tocrm.u_m2000_to_crm_listino( )
		
		if  k_rc > 0 then
			
			messagebox("Operazione terminata", "Sono stati esportati  " + string(k_rc) + " Listini. ~n~rE' ora possibile eseguire l'importazione dal CRM. ", information!)
	
		else	
			messagebox("Operazione in anomalia ", "Dati non esportati o incompleti, procedura in errore", Exclamation!)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente( "Operazione errata", "Esportazione conclusa per errore ~n~r" + "Cod. " + string(kst_esito.sqlcode) + " - " + kst_esito.sqlerrtext)
	
end try


end event

type cb_elenco_listino from commandbutton within w_m2000tocrm
integer x = 763
integer y = 1940
integer width = 155
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;//
try
	kiuo_sqlca_db_crm.db_connetti( )
	dw_elenco.dataobject = "ds_crmtab_crm_listino"
	dw_elenco.settransobject( kiuo_sqlca_db_crm )
	dw_elenco.retrieve()
	dw_elenco.enabled = true
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try
end event

type cb_crm_conferma_dordine from commandbutton within w_m2000tocrm
integer x = 69
integer y = 1780
integer width = 640
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Conferme Ordini"
end type

event clicked;//
long k_rc=0
st_esito kst_esito


try
	if messagebox("Esporta dati", "Genera dati di 'CONFERMA ORDINE' per la Procedura CRM, confermare l'operazione !", information!, yesno!, 2) = 1 then
		k_rc = kiuf_m2000tocrm.u_m2000_to_crm_confermaordine( )
		
		if  k_rc > 0 then
			
			messagebox("Operazione terminata", "Sono stati esportati  " + string(k_rc) + " Contratti CO. ~n~rE' ora possibile eseguire l'importazione dal CRM. ", information!)
	
		else	
			messagebox("Operazione in anomalia ", "Dati non esportati o incompleti, procedura in errore", Exclamation!)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente( "Operazione errata", "Esportazione conclusa per errore ~n~r" + "Cod. " + string(kst_esito.sqlcode) + " - " + kst_esito.sqlerrtext)
	
end try


end event

type cb_elenco_conferma_dordine from commandbutton within w_m2000tocrm
integer x = 763
integer y = 1780
integer width = 155
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;//
try
	kiuo_sqlca_db_crm.db_connetti( )
	dw_elenco.dataobject = "ds_crmtab_crm_confermaordine"
	dw_elenco.settransobject( kiuo_sqlca_db_crm )
	dw_elenco.retrieve()
	dw_elenco.enabled = true
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try
end event

type cb_crm_tot_mese from commandbutton within w_m2000tocrm
integer x = 69
integer y = 2432
integer width = 640
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Totali mese"
end type

event clicked;//
long k_rc=0
st_esito kst_esito


try
	if messagebox("Esporta dati", "Genera dati 'RIEPILOGATIVI TOTALI  MESE PER CONTRATTO' per la Procedura CRM, confermare l'operazione !", information!, yesno!, 2) = 1 then
		k_rc = kiuf_m2000tocrm.u_m2000_to_crm_cntr_tot_mese( )
		
		if  k_rc > 0 then
			
			messagebox("Operazione terminata", "Sono stati esportati  " + string(k_rc) + " 'Totali'. ~n~rE' ora possibile eseguire l'importazione dal CRM. ", information!)
	
		else	
			messagebox("Operazione in anomalia ", "Dati non esportati o incompleti, procedura in errore", Exclamation!)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente( "Operazione errata", "Esportazione conclusa per errore ~n~r" + "Cod. " + string(kst_esito.sqlcode) + " - " + kst_esito.sqlerrtext)
	
end try


end event

type cb_elenco_tot_mese from commandbutton within w_m2000tocrm
integer x = 763
integer y = 2432
integer width = 155
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;//
try
	kiuo_sqlca_db_crm.db_connetti( )
	dw_elenco.dataobject = "ds_crmtab_crm_cntr_tot_mese"
	dw_elenco.settransobject( kiuo_sqlca_db_crm )
	dw_elenco.retrieve()
	dw_elenco.enabled = true
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try
end event

type cb_1 from commandbutton within w_m2000tocrm
integer x = 69
integer y = 2264
integer width = 640
integer height = 104
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Previsioni mese"
end type

event clicked;//
long k_rc=0
st_esito kst_esito


try
	if messagebox("Esporta dati", "Genera dati 'PREVISIONI MESE PER CLIENTE' per la Procedura CRM, confermare l'operazione !", information!, yesno!, 2) = 1 then
		k_rc = kiuf_m2000tocrm.u_m2000_to_crm_previsioni( )
		
		if  k_rc > 0 then
			
			messagebox("Operazione terminata", "Sono stati esportati  " + string(k_rc) + " 'Previsioni'. ~n~rE' ora possibile eseguire l'importazione dal CRM. ", information!)
	
		else	
			messagebox("Operazione in anomalia ", "Dati non esportati o incompleti, procedura in errore", Exclamation!)
			
		end if
	end if
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	kguo_exception.inizializza( )
	kguo_exception.messaggio_utente( "Operazione errata", "Esportazione conclusa per errore ~n~r" + "Cod. " + string(kst_esito.sqlcode) + " - " + kst_esito.sqlerrtext)
	
end try


end event

type cb_2 from commandbutton within w_m2000tocrm
integer x = 763
integer y = 2264
integer width = 155
integer height = 104
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>"
end type

event clicked;//
long k_rc

try
	kiuo_sqlca_db_crm.db_connetti( )
	dw_elenco.dataobject = "ds_crmtab_crm_previsioni"
	dw_elenco.settransobject( kiuo_sqlca_db_crm )
	k_rc=dw_elenco.retrieve()
	dw_elenco.enabled = true
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()
end try
end event

type gb_stat from groupbox within w_m2000tocrm
integer x = 32
integer y = 2164
integer width = 937
integer height = 416
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "statistici"
end type

type gb_anag from groupbox within w_m2000tocrm
integer x = 32
integer y = 280
integer width = 937
integer height = 892
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "anagrafiche"
end type

type gb_contratti from groupbox within w_m2000tocrm
integer x = 32
integer y = 1220
integer width = 937
integer height = 892
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "contratti"
end type

