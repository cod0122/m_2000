$PBExportHeader$w_sk_stampe.srw
forward
global type w_sk_stampe from Window
end type
type em_data_chiusura from editmask within w_sk_stampe
end type
type st_6b from statictext within w_sk_stampe
end type
type st_17 from statictext within w_sk_stampe
end type
type ddlb_stampa from dropdownlistbox within w_sk_stampe
end type
type st_16 from statictext within w_sk_stampe
end type
type dw_collab from datawindow within w_sk_stampe
end type
type dw_r_budget from datawindow within w_sk_stampe
end type
type st_15 from statictext within w_sk_stampe
end type
type st_14 from statictext within w_sk_stampe
end type
type dw_r_comm from datawindow within w_sk_stampe
end type
type dw_divisione from datawindow within w_sk_stampe
end type
type st_13 from statictext within w_sk_stampe
end type
type st_12 from statictext within w_sk_stampe
end type
type st_11 from statictext within w_sk_stampe
end type
type st_10 from statictext within w_sk_stampe
end type
type st_9 from statictext within w_sk_stampe
end type
type ddlb_stato from dropdownlistbox within w_sk_stampe
end type
type st_parametri from statictext within w_sk_stampe
end type
type st_6 from statictext within w_sk_stampe
end type
type cb_ok from commandbutton within w_sk_stampe
end type
type st_5 from statictext within w_sk_stampe
end type
type cb_ritorna from commandbutton within w_sk_stampe
end type
type dw_t_lavoro from datawindow within w_sk_stampe
end type
type dw_clienti from datawindow within w_sk_stampe
end type
type st_2 from statictext within w_sk_stampe
end type
type em_nro_a from editmask within w_sk_stampe
end type
type em_nro_da from editmask within w_sk_stampe
end type
type em_data_a from editmask within w_sk_stampe
end type
type em_data_da from editmask within w_sk_stampe
end type
type st_3 from statictext within w_sk_stampe
end type
type gb_2 from groupbox within w_sk_stampe
end type
type gb_1 from groupbox within w_sk_stampe
end type
end forward

global type w_sk_stampe from Window
int X=434
int Y=268
int Width=2254
int Height=1564
boolean TitleBar=true
string Title="Scheda Criteri di Stampa"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean Resizable=true
WindowType WindowType=child!
event ue_menu pbm_custom01
em_data_chiusura em_data_chiusura
st_6b st_6b
st_17 st_17
ddlb_stampa ddlb_stampa
st_16 st_16
dw_collab dw_collab
dw_r_budget dw_r_budget
st_15 st_15
st_14 st_14
dw_r_comm dw_r_comm
dw_divisione dw_divisione
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
ddlb_stato ddlb_stato
st_parametri st_parametri
st_6 st_6
cb_ok cb_ok
st_5 st_5
cb_ritorna cb_ritorna
dw_t_lavoro dw_t_lavoro
dw_clienti dw_clienti
st_2 st_2
em_nro_a em_nro_a
em_nro_da em_nro_da
em_data_a em_data_a
em_data_da em_data_da
st_3 st_3
gb_2 gb_2
gb_1 gb_1
end type
global w_sk_stampe w_sk_stampe

forward prototypes
protected subroutine inizializza ()
protected function string smista_funz (string k_par_in)
protected subroutine leggi_liste ()
protected function string check_dati ()
protected subroutine posiz_window ()
protected function integer check_cliente ()
private function integer check_r_comm ()
private function integer check_r_budget ()
private function integer check_collab ()
private function string estrae_dati ()
end prototypes

event ue_menu;//
smista_funz(this.tag)
end event

protected subroutine inizializza ();//

em_nro_da.text = ""
em_nro_a.text = ""
setnull(em_data_da.text)
setnull(em_data_a.text)
setnull(em_data_chiusura.text)

dw_t_lavoro.setitem(1, "id_t_lavoro", "")
dw_clienti.setitem(1, "rag_soc_1", "")
dw_collab.setitem(1, "rag_soc_1", "")
dw_divisione.setitem(1, "id_divisione", "")
dw_r_comm.setitem(1, "rag_soc_1", "")
dw_r_budget.setitem(1, "rag_soc_1", "")
//

end subroutine

protected function string smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===
string k_return="0 "


choose case left(k_par_in, 2) 

	case "ag"		//richiesta aggiorna la stampa (retrieve)
		leggi_liste()	

	case "st"		//richiesta 
		cb_ok.triggerevent("clicked")

	case "ri"		//richiesta uscita
		cb_ritorna.triggerevent("clicked")

end choose


return k_return



end function

protected subroutine leggi_liste ();//
//=== Legge le drop data windows e il BASE 
//
kuf_base kuf1_base
string k_record="0 "
string k_id_t_lavoro=" "
string k_data
int k_pos, k_riga, k_ctr, k_ind
datawindowchild  kdwc_collab, kdwc_r_comm, kdwc_r_budget
datawindowchild  kdwc_clienti, kdwc_t_lavori, kdwc_divisioni


//=== catturo gli handle dei drop_data_windows
	dw_clienti.getchild("rag_soc_1", kdwc_clienti)
	dw_collab.getchild("rag_soc_1", kdwc_collab)
	dw_r_budget.getchild("rag_soc_1", kdwc_r_budget)
	dw_r_comm.getchild("rag_soc_1", kdwc_r_comm)
	dw_t_lavoro.getchild("descrizione", kdwc_t_lavori)
	dw_divisione.getchild("descrizione", kdwc_divisioni)
	
//=== per evitare la richiesta del Argument_retrieval 
	kdwc_clienti.settransobject ( sqlca )
	kdwc_collab.settransobject ( sqlca )
	kdwc_r_budget.settransobject ( sqlca )
	kdwc_r_comm.settransobject ( sqlca )
	kdwc_t_lavori.settransobject ( sqlca )
	kdwc_divisioni.settransobject ( sqlca )
//string k_long
//	k_long = dw_clienti.modify("d_clienti_l.Retrieve.AsNeeded=Yes")
//	k_long = kdwc_modelli.modify("d_modelli_l.Retrieve.AsNeeded=yes")
//	k_long = kdwc_collab.modify("d_fornitori_l.Retrieve.AsNeeded=yes")
//	k_long = kdwc_id_t_lavoro.modify("d_tipi_ordine.Retrieve.AsNeeded=yes")

	kdwc_clienti.retrieve("", kk_tipo_cliente)
	kdwc_collab.retrieve("", kk_tipo_fornitore)
	kdwc_r_budget.retrieve("", kk_tipo_dipendente)
	kdwc_r_comm.retrieve("", kk_tipo_dipendente)
	kdwc_t_lavori.retrieve("")
	kdwc_divisioni.retrieve("")

	kdwc_clienti.insertrow(1)
	kdwc_collab.insertrow(1)
	kdwc_r_budget.insertrow(1)
	kdwc_r_comm.insertrow(1)
	kdwc_t_lavori.insertrow(1)
	kdwc_divisioni.insertrow(1)
               
	kdwc_clienti.setrow(1)
	kdwc_collab.setrow(1)
	kdwc_r_budget.setrow(1)
	kdwc_r_comm.setrow(1)
	kdwc_t_lavori.setrow(1)
	kdwc_divisioni.setrow(1)

	kdwc_clienti.scrolltorow(1)
	kdwc_collab.scrolltorow(1)
	kdwc_r_budget.scrolltorow(1)
	kdwc_r_comm.scrolltorow(1)
	kdwc_t_lavori.scrolltorow(1)
	kdwc_divisioni.scrolltorow(1)

//	kdwc_clienti.modify("d_clienti_ord_l.Retrieve.AsNeeded=no")
//	kdwc_modelli.modify("d_modelli_ord_l.Retrieve.AsNeeded=no")
//	kdwc_collab.modify("d_fornitori_l.Retrieve.AsNeeded=no")
//	kdwc_id_t_lavoro.modify("d_tipi_ord_l.Retrieve.AsNeeded=no")


end subroutine

protected function string check_dati ();//
string k_return ="0 "
string k_errore = ""


if long(trim(em_nro_a.text)) < long(trim(em_nro_da.text)) then
	k_errore = "Numero Commessa di Inizio maggiore di quello di Fine~n~r"
	k_return = "1"
end if
if date(em_data_a.text) < date(em_data_da.text) then
	k_errore = k_errore + "Data Commessa di Inizio maggiore di quella di Fine~n~r"
	k_return = "1"
end if
if date(em_data_chiusura.text) < date(em_data_da.text) then
	k_errore = k_errore + "Data Conclusione minore della data di Inizio~n~r"
	k_return = "1"
end if
if len(trim(ddlb_stampa.text)) = 0 then
	k_errore = k_errore + "Prego, specificare il Tipo di Stampa~n~r"
	k_return = "1"
end if

return k_return + k_errore
end function

protected subroutine posiz_window ();//


//=== Posiziona Windows
if w_main.width > w_sk_stampe.width then
	w_sk_stampe.x = (w_main.width - w_sk_stampe.width) / 4
else
	w_sk_stampe.x = 1
end if
if w_main.height > w_sk_stampe.height then
	w_sk_stampe.y = (w_main.height - w_sk_stampe.height) / 6
else
	w_sk_stampe.y = 1
end if


end subroutine

protected function integer check_cliente ();//
//=== Controlla esistenza del cliente
//
int k_return= 0
long k_riga_ddw, k_id_cliente
string k_rag_soc
long k_prova


	k_rag_soc = dw_clienti.gettext()

	if len(k_rag_soc) > 0 then 

		 DECLARE clienti CURSOR FOR  
  			SELECT "clienti"."id_cliente",   
      	   	 "clienti"."rag_soc_1"  
    		FROM "clienti"  
  		 	WHERE "clienti"."rag_soc_1" >= :k_rag_soc and
				   ("clienti"."tipo" = :kk_tipo_cli_for or
					 "clienti"."tipo" = :kk_tipo_cliente)
				order by "clienti"."rag_soc_1" ;

	 	open clienti ;

		if sqlca.sqlcode = 0 then		
			fetch clienti into :k_id_cliente, :k_rag_soc ;
		end if

		if sqlca.sqlcode = 0 then		

			dw_clienti.setitem(dw_clienti.getrow(), "rag_soc_1", k_rag_soc)
			
			dw_clienti.settext(k_rag_soc)

		else

			dw_clienti.settext("Non Trovato") 


		end if

	 	close clienti ;

	else

		dw_clienti.setitem(dw_clienti.getrow(), "rag_soc_1", "")
		dw_clienti.settext("")

	end if

	k_return = 1

return k_return
////
end function

private function integer check_r_comm ();//
//=== Controlla esistenza del Responsabile Commerciale
//
int k_return= 0
long k_riga_ddw, k_id_cliente
string k_rag_soc
long k_prova


	k_rag_soc = dw_r_comm.gettext()

	if len(k_rag_soc) > 0 then 

		 DECLARE clienti CURSOR FOR  
  			SELECT 
			       "clienti"."id_cliente",   
      	   	 "clienti"."rag_soc_1"  
    		FROM ( "clienti" inner join "commesse" on 
			     "clienti"."id_cliente" = "commesse"."id_cliente_d")
  		 	WHERE "clienti"."rag_soc_1" >= :k_rag_soc  
				order by "clienti"."rag_soc_1" ;

	 	open clienti ;

		if sqlca.sqlcode = 0 then		
			fetch clienti into :k_id_cliente, :k_rag_soc ;
		end if

		if sqlca.sqlcode = 0 then		

			dw_r_comm.setitem(dw_r_comm.getrow(), "rag_soc_1", k_rag_soc)
			
			dw_r_comm.settext(k_rag_soc)

		else

			dw_r_comm.settext("Non Trovato") 


		end if

	 	close clienti ;

	else

		dw_r_comm.setitem(dw_r_comm.getrow(), "rag_soc_1", "")
		dw_r_comm.settext("")

	end if

	k_return = 1

return k_return
////
end function

private function integer check_r_budget ();//
//=== Controlla esistenza del Responsabile Commerciale
//
int k_return= 0
long k_riga_ddw, k_id_cliente
string k_rag_soc
long k_prova


	k_rag_soc = dw_r_budget.gettext()

	if len(k_rag_soc) > 0 then 

		 DECLARE clienti CURSOR FOR  
  			SELECT 
			       "clienti"."id_cliente",   
      	   	 "clienti"."rag_soc_1"  
    		FROM ( "clienti" inner join "commesse" on 
			     "clienti"."id_cliente" = "commesse"."id_cliente_b" )
  		 	WHERE "clienti"."rag_soc_1" >= :k_rag_soc  
				order by "clienti"."rag_soc_1" ;

	 	open clienti ;

		if sqlca.sqlcode = 0 then		
			fetch clienti into :k_id_cliente, :k_rag_soc ;
		end if

		if sqlca.sqlcode = 0 then		

			dw_r_budget.setitem(dw_r_budget.getrow(), "rag_soc_1", k_rag_soc)
			
			dw_r_budget.settext(k_rag_soc)

		else

			dw_r_budget.settext("Non Trovato") 


		end if

	 	close clienti ;

	else

		dw_r_budget.setitem(dw_r_budget.getrow(), "rag_soc_1", "")
		dw_r_budget.settext("")

	end if

	k_return = 1

return k_return
////
end function

private function integer check_collab ();//
//=== Controlla esistenza del cliente
//
int k_return= 0
long k_riga_ddw, k_id_cliente
string k_rag_soc
long k_prova


	k_rag_soc = dw_collab.gettext()

	if len(k_rag_soc) > 0 then 

		 DECLARE clienti CURSOR FOR  
  			SELECT "clienti"."id_cliente",   
      	   	 "clienti"."rag_soc_1"  
    		FROM "clienti"  
  		 	WHERE "clienti"."rag_soc_1" >= :k_rag_soc and
					"clienti"."tipo" <> :kk_tipo_cliente
				order by "clienti"."rag_soc_1" ;

	 	open clienti ;

		if sqlca.sqlcode = 0 then		
			fetch clienti into :k_id_cliente, :k_rag_soc ;
		end if

		if sqlca.sqlcode = 0 then		

			dw_collab.setitem(dw_collab.getrow(), "rag_soc_1", k_rag_soc)
			
			dw_collab.settext(k_rag_soc)

		else

			dw_collab.settext("Non Trovato") 


		end if

	 	close clienti ;

	else

		dw_collab.setitem(dw_collab.getrow(), "rag_soc_1", "")
		dw_collab.settext("")

	end if

	k_return = 1

return k_return
////
end function

private function string estrae_dati ();//
string k_return=""
long k_id_cliente, k_id_collab, k_id_cliente_d, k_id_cliente_b
long k_nro_da, k_nro_a
date k_data_da, k_data_a
string k_id_divisione, k_id_t_lavoro, k_stato
datawindowchild  kdwc_clienti, kdwc_collab, kdwc_r_comm, kdwc_r_budget
datawindowchild  kdwc_t_lavori, kdwc_divisioni
string k_cli_rag_soc, k_for_rag_soc, k_rag_soc, k_nome_stampa, k_titolo, k_parametri
date k_data_chiusura


//=== catturo gli handle dei drop_data_windows
	dw_clienti.getchild("rag_soc_1", kdwc_clienti)
	dw_collab.getchild("rag_soc_1", kdwc_collab)
	dw_r_comm.getchild("rag_soc_1", kdwc_r_comm)
	dw_r_budget.getchild("rag_soc_1", kdwc_r_budget)
	dw_t_lavoro.getchild("descrizione", kdwc_t_lavori)
	dw_divisione.getchild("descrizione", kdwc_divisioni)

	dw_clienti.gettext ()
	dw_collab.gettext ()
	dw_r_comm.gettext ()
	dw_r_budget.gettext ()
	dw_t_lavoro.gettext ()
	dw_divisione.gettext ()

//dw_dett_0.height = integer(dw_dett_0.Describe("id_cliente.Height")) * 11 + 40 

k_id_cliente = kdwc_clienti.getitemnumber(kdwc_clienti.getrow(), &
									"id_cliente")

if isnull(k_id_cliente) then
	k_id_cliente= 0
	k_cli_rag_soc = space(50)
else
	k_rag_soc = dw_clienti.getitemstring(1, "rag_soc_1")
	k_cli_rag_soc = k_rag_soc + space(50 - len(k_rag_soc))
end if

k_id_collab = kdwc_collab.getitemnumber(kdwc_collab.getrow(), &
									"id_cliente")
if isnull(k_id_collab) then
	k_id_collab= 0
	k_for_rag_soc = space(50)
else
	k_rag_soc = dw_collab.getitemstring(1, "rag_soc_1")
	k_for_rag_soc = k_rag_soc + space(50 - len(k_rag_soc))
end if

k_id_t_lavoro = kdwc_t_lavori.getitemstring(kdwc_t_lavori.getrow(), &
									"id_t_lavoro")
if isnull(k_id_t_lavoro) then
	k_id_t_lavoro= space(10)
else
	k_id_t_lavoro = k_id_t_lavoro + space(10 - len(k_id_t_lavoro))
end if

k_id_divisione = kdwc_divisioni.getitemstring(kdwc_divisioni.getrow(), &
									"id_divisione")
if isnull(k_id_divisione) then
	k_id_divisione= space(10)
else
	k_id_divisione = k_id_divisione + space(10 - len(k_id_divisione))
end if

k_nro_da = long(em_nro_da.text)
if isnull(k_nro_da) then
	k_nro_da = 0
end if

k_nro_a = long(em_nro_a.text)
if isnull(k_nro_a) then
	k_nro_a = 0
end if

if trim(em_data_da.text) <> "00/00/00" then
	k_data_da = date(em_data_da.text)
else
	k_data_da=date("00/00/0000") 
end if  
if trim(em_data_a.text) <> "00/00/00" then
	k_data_a = date(em_data_a.text)
else
	k_data_a=date("00/00/0000")
end if  
if trim(em_data_chiusura.text) <> "00/00/00" then
	k_data_chiusura = date(em_data_chiusura.text)
else
	k_data_chiusura = date("00/00/0000")
end if  

k_id_cliente_d = Kdwc_r_comm.getitemnumber(kdwc_r_comm.getrow(), "id_cliente")
if isnull(k_id_cliente_d) then
	k_id_cliente_d = 0 
end if
	
//=== Estrae lo Stato
k_stato = ddlb_stato.text
if isnull(k_stato) or k_stato = "<Tutte>" or len(trim(k_stato)) = 0 then
	k_stato = space(29) + "*"
else
	k_stato = left((trim(k_stato) + space(30)), 29) + mid(k_stato, 31, 1) 
end if
//k_stato = k_stato + space(10) + mid(k_stato,30,1)
	
//=== Estrae il Tipo di Stampa da Effettuare
k_nome_stampa = ddlb_stampa.text
if isnull(k_nome_stampa) then
	k_nome_stampa = ""
end if

CHOOSE CASE k_nome_stampa
	CASE "Elenco costi collaboratore Interno"
	   k_nome_stampa = "costi_int"
      k_titolo = "Elenco Costi Interni per Collaboratore" + space(30)
      k_parametri = "S" + space(50) //--- S=con nr.copie
	CASE "Elenco costi collaboratore Esterno"
	   k_nome_stampa = "costi_est"
		k_titolo = "Elenco Costi Esterni per Collaboratore" + space(30)
      k_parametri = "S" + space(50) //--- S=con nr.copie
	CASE "Situazione Valori Commessa"
	   k_nome_stampa = "costi_comm"
		k_titolo = "Situazione Costi-Acconti Commessa" + space(35)
      k_parametri = "S" + space(50) //--- S=con nr.copie
	CASE "Consuntivo Valori Commessa"
	   k_nome_stampa = "costi_com1"
		k_titolo = "Consuntivo Costi-Margine Commessa" + space(35)
      k_parametri = "S" + space(50) //--- S=con nr.copie
END CHOOSE

k_nome_stampa = k_nome_stampa + space(10)

k_id_cliente_b = kdwc_r_budget.getitemnumber(kdwc_r_budget.getrow(), "id_cliente")
if isnull(k_id_cliente_b) then
	k_id_cliente_b = 0
end if


k_return =  left(k_parametri, 50) + &  
            left(k_titolo, 50) + &
			   string(k_nome_stampa, "@@@@@@@@@@") + & 
				string(k_nro_da, "0000000000") + &
			   string(k_nro_a, "0000000000") + &
            string(k_data_da, "dd/mm/yyyy") + &
			   string(k_data_a, "dd/mm/yyyy") + &
			   string(k_id_cliente, "0000000000") + &
			   string(k_id_collab, "0000000000") + &
			   string(k_id_divisione, "@@@@@@@@@@") + &
			   string(k_id_t_lavoro, "@@@@@@@@@@") + &
			   string(k_id_cliente_d, "0000000000") + &
			   string(k_id_cliente_b, "0000000000") + &  
			   left(k_stato, 30) + &
			   string(k_data_chiusura, "dd/mm/yyyy")

k_return = k_return + space(300 - len(k_return)) + &
			  k_cli_rag_soc + k_for_rag_soc

return k_return

end function
event open;//
long k_id_cliente
string k_scelta

//=== Mostra Finestra maximizzata
	send(handle(this), 274, 61728, 0)

//=== Parametri passati con il WITHPARM
	st_parametri.text = message.stringparm
	k_scelta = left(message.stringparm, 2)

posiz_window()

//choose case k_scelta 
//
//	case "om"
//		w_sk_stampe.title = "Interrogazione : Consumi per Modelli-composizioni-colori"  
//
//	case "op"
//		w_sk_stampe.title = "Interrogazione : Pezzi Ordinati per taglie-modelli-colori"  
//
//	case "or" 
//		w_sk_stampe.title = "Stampa Ordini"  
//
//	case "et" 
//		w_sk_stampe.title = "Stampa Etichette : parametri di estrazione ordini"  
//
//
//end choose

//=== set transobject per il datawindows di dettaglio
	dw_t_lavoro.settransobject ( sqlca )
	dw_clienti.settransobject ( sqlca )
	dw_collab.settransobject ( sqlca )
	dw_divisione.settransobject ( sqlca )
	dw_r_comm.settransobject ( sqlca )
	dw_r_budget.settransobject ( sqlca )

//=== Riempe il drop-list Box delgli Stati
	kuf1_data_base.riempi_ddlb_stato(trim(mid(st_parametri.text,3,10)),&
										ddlb_stato)

	leggi_liste()	

	dw_t_lavoro.insertrow(1)
	dw_clienti.insertrow(1)
	dw_collab.insertrow(1)
	dw_divisione.insertrow(1)
	dw_r_comm.insertrow(1)
	dw_r_budget.insertrow(1)

	
inizializza()

//attiva_tasti()

em_nro_da.setfocus()
//dw_dett_0.setrowfocusindicator ( Hand! )



end event

on w_sk_stampe.create
this.em_data_chiusura=create em_data_chiusura
this.st_6b=create st_6b
this.st_17=create st_17
this.ddlb_stampa=create ddlb_stampa
this.st_16=create st_16
this.dw_collab=create dw_collab
this.dw_r_budget=create dw_r_budget
this.st_15=create st_15
this.st_14=create st_14
this.dw_r_comm=create dw_r_comm
this.dw_divisione=create dw_divisione
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.ddlb_stato=create ddlb_stato
this.st_parametri=create st_parametri
this.st_6=create st_6
this.cb_ok=create cb_ok
this.st_5=create st_5
this.cb_ritorna=create cb_ritorna
this.dw_t_lavoro=create dw_t_lavoro
this.dw_clienti=create dw_clienti
this.st_2=create st_2
this.em_nro_a=create em_nro_a
this.em_nro_da=create em_nro_da
this.em_data_a=create em_data_a
this.em_data_da=create em_data_da
this.st_3=create st_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.em_data_chiusura,&
this.st_6b,&
this.st_17,&
this.ddlb_stampa,&
this.st_16,&
this.dw_collab,&
this.dw_r_budget,&
this.st_15,&
this.st_14,&
this.dw_r_comm,&
this.dw_divisione,&
this.st_13,&
this.st_12,&
this.st_11,&
this.st_10,&
this.st_9,&
this.ddlb_stato,&
this.st_parametri,&
this.st_6,&
this.cb_ok,&
this.st_5,&
this.cb_ritorna,&
this.dw_t_lavoro,&
this.dw_clienti,&
this.st_2,&
this.em_nro_a,&
this.em_nro_da,&
this.em_data_a,&
this.em_data_da,&
this.st_3,&
this.gb_2,&
this.gb_1}
end on

on w_sk_stampe.destroy
destroy(this.em_data_chiusura)
destroy(this.st_6b)
destroy(this.st_17)
destroy(this.ddlb_stampa)
destroy(this.st_16)
destroy(this.dw_collab)
destroy(this.dw_r_budget)
destroy(this.st_15)
destroy(this.st_14)
destroy(this.dw_r_comm)
destroy(this.dw_divisione)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.ddlb_stato)
destroy(this.st_parametri)
destroy(this.st_6)
destroy(this.cb_ok)
destroy(this.st_5)
destroy(this.cb_ritorna)
destroy(this.dw_t_lavoro)
destroy(this.dw_clienti)
destroy(this.st_2)
destroy(this.em_nro_a)
destroy(this.em_nro_da)
destroy(this.em_data_a)
destroy(this.em_data_da)
destroy(this.st_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

on rbuttondown;//
string k_stringa=""
long k_riga=0
string k_tag_old=""
string k_tag=""
m_popup m_menu



//=== Salvo il Tag attuale per reimpostarlo a fine routine
		k_tag_old = this.tag

//=== Creo menu Popup 
		m_menu = create m_popup

		m_menu.m_agglista.visible = true
		m_menu.m_t_agglista.visible = true
		m_menu.m_inserisci.visible = false
		m_menu.m_inserisci.enabled = false
		m_menu.m_modifica.visible = false
		m_menu.m_t_modifica.visible = false
		m_menu.m_cancella.visible = false
		m_menu.m_cancella.enabled = false
		m_menu.m_t_cancella.visible = false
		m_menu.m_conferma.visible = false
		m_menu.m_conferma.enabled = false
		m_menu.m_stampa.visible = true
		m_menu.m_t_stampa.visible = true
		m_menu.m_ritorna.visible = true

//=== Attivo il menu Popup
		m_menu.visible = true
		m_menu.popmenu(this.x + pointerx(), this.y + pointery())
		m_menu.visible = false

		destroy m_menu

		k_tag = this.tag 

		this.tag = k_tag_old 

		smista_funz(k_tag)


end on

type em_data_chiusura from editmask within w_sk_stampe
int X=585
int Y=460
int Width=334
int Height=88
int TabOrder=60
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yy"
MaskDataType MaskDataType=DateMask!
long TextColor=16711680
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_6b from statictext within w_sk_stampe
int X=585
int Y=388
int Width=439
int Height=60
boolean Enabled=false
string Text="Conclusa al"
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_17 from statictext within w_sk_stampe
int X=1143
int Y=1028
int Width=329
int Height=60
boolean Enabled=false
string Text="Stampa"
boolean FocusRectangle=false
long TextColor=8388736
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type ddlb_stampa from dropdownlistbox within w_sk_stampe
event selectionchanged pbm_cbnselchange
int X=1143
int Y=1100
int Width=1019
int Height=560
int TabOrder=120
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=8388736
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Elenco costi collaboratore Interno",&
"Elenco costi collaboratore Esterno",&
"Situazione Valori Commessa",&
"Consuntivo Valori Commessa"}
end type

event selectionchanged;//
string k_stampa, k_id_comp

	if trim(ddlb_stampa.text) = "<Tutte>" then
		k_stampa = "*"
	else
		k_stampa = trim(ddlb_stampa.text) 
	end if

	if k_stampa <> mid(st_parametri.text,13,10) then
		k_stampa = k_stampa + space(10)
		st_parametri.text = replace(st_parametri.text,13,10,k_stampa)
	end if



end event

type st_16 from statictext within w_sk_stampe
int X=41
int Y=1024
int Width=530
int Height=60
boolean Enabled=false
string Text="Collaboratore "
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type dw_collab from datawindow within w_sk_stampe
event itemchanged pbm_dwnitemchange
int X=37
int Y=1100
int Width=1083
int Height=108
int TabOrder=110
string DataObject="d_clienti_l_2_ddw"
boolean Border=false
boolean LiveScroll=true
end type

event losefocus;if check_collab() = 1 then
	return 2
end if

end event

type dw_r_budget from datawindow within w_sk_stampe
event itemchanged pbm_dwnitemchange
int X=1147
int Y=876
int Width=1019
int Height=108
int TabOrder=100
string DataObject="d_clienti_l_r_budget_ddw"
boolean Border=false
boolean LiveScroll=true
end type

event losefocus;if check_r_budget () = 1 then
	return 2
end if

end event

type st_15 from statictext within w_sk_stampe
int X=1143
int Y=796
int Width=640
int Height=60
boolean Enabled=false
string Text="Resp. Budget"
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_14 from statictext within w_sk_stampe
int X=41
int Y=804
int Width=640
int Height=60
boolean Enabled=false
string Text="Resp. Commerciale"
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type dw_r_comm from datawindow within w_sk_stampe
event itemchanged pbm_dwnitemchange
int X=41
int Y=876
int Width=1074
int Height=108
int TabOrder=90
string DataObject="d_clienti_l_r_comm_ddw"
boolean Border=false
boolean LiveScroll=true
end type

event losefocus;if check_r_comm() = 1 then
	return 2
end if

end event

type dw_divisione from datawindow within w_sk_stampe
event itemchanged pbm_dwnitemchange
int X=1147
int Y=672
int Width=1015
int Height=92
int TabOrder=80
string DataObject="d_divisioni_ddw"
boolean Border=false
boolean LiveScroll=true
end type

type st_13 from statictext within w_sk_stampe
int X=1147
int Y=604
int Width=421
int Height=60
boolean Enabled=false
string Text="Divisione"
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_12 from statictext within w_sk_stampe
int X=1568
int Y=244
int Width=78
int Height=76
boolean Enabled=false
string Text="a"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_11 from statictext within w_sk_stampe
int X=1093
int Y=244
int Width=91
int Height=76
boolean Enabled=false
string Text="da"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_10 from statictext within w_sk_stampe
int X=544
int Y=244
int Width=73
int Height=76
boolean Enabled=false
string Text="a"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_9 from statictext within w_sk_stampe
int X=69
int Y=244
int Width=101
int Height=76
boolean Enabled=false
string Text="da"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type ddlb_stato from dropdownlistbox within w_sk_stampe
int X=41
int Y=460
int Width=498
int Height=560
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=16711680
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;//
string k_stato, k_id_comp

	if trim(ddlb_stato.text) = "<Tutte>" then
		k_stato = "*"
	else
		if trim(ddlb_stato.text) = "<Nessuna>" then
			k_stato = ""
		else
			k_stato = trim(ddlb_stato.text) 
		end if
	end if

	if k_stato <> mid(st_parametri.text,13,10) then
		k_stato = k_stato + space(10)
		st_parametri.text = replace(st_parametri.text,13,10,k_stato)
	end if



end event

type st_parametri from statictext within w_sk_stampe
int X=137
int Y=1252
int Width=247
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=16777215
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_sk_stampe
int X=41
int Y=388
int Width=329
int Height=60
boolean Enabled=false
string Text="Stato"
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type cb_ok from commandbutton within w_sk_stampe
int X=1294
int Y=1316
int Width=389
int Height=96
int TabOrder=130
string Text="&OK"
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

event clicked;//
string k_dati, k_errore
string k_scelta


k_errore = check_dati()

if left(k_errore, 1) <> "0" then

	messagebox("Immessi Dati Incongruenti", mid(k_errore, 2), &
					exclamation!, ok!)
else
	k_dati = estrae_dati() 

	if len(k_dati) < 1  then
		messagebox("Nessun Ordine Elaborato ", "Nessuna Stampa per la richiesta fatta", &
					exclamation!, ok!)
	else 

		w_main.open_w_tabelle("st1" + k_dati )


	//	cb_ritorna.triggerevent(clicked!)

	end if
end if

end event

type st_5 from statictext within w_sk_stampe
int X=14
int Y=12
int Width=2190
int Height=92
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleRaised!
string Text="Criteri di selezione  (per i dati non impostati viene assunto ~"Tutto~")"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388736
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ritorna from commandbutton within w_sk_stampe
int X=1778
int Y=1316
int Width=389
int Height=96
int TabOrder=140
string Text="&Ritorna"
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

on clicked;close(parent)
end on

type dw_t_lavoro from datawindow within w_sk_stampe
int X=41
int Y=672
int Width=1065
int Height=92
int TabOrder=70
string DataObject="d_t_lavori_ddw"
boolean Border=false
boolean LiveScroll=true
end type

type dw_clienti from datawindow within w_sk_stampe
int X=1143
int Y=460
int Width=1097
int Height=108
int TabOrder=60
string DataObject="d_clienti_l_2_ddw"
boolean Border=false
boolean LiveScroll=true
end type

event losefocus;if check_cliente() = 1 then
	return 2
end if

end event

type st_2 from statictext within w_sk_stampe
int X=1134
int Y=388
int Width=293
int Height=60
boolean Enabled=false
string Text="Cliente    "
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type em_nro_a from editmask within w_sk_stampe
int X=645
int Y=236
int Width=311
int Height=80
int TabOrder=20
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
long TextColor=16711680
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type em_nro_da from editmask within w_sk_stampe
int X=192
int Y=236
int Width=311
int Height=80
int TabOrder=10
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
long TextColor=16711680
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type em_data_a from editmask within w_sk_stampe
int X=1669
int Y=236
int Width=334
int Height=84
int TabOrder=40
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yy"
MaskDataType MaskDataType=DateMask!
long TextColor=16711680
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type em_data_da from editmask within w_sk_stampe
int X=1216
int Y=236
int Width=334
int Height=84
int TabOrder=30
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="dd/mm/yy"
MaskDataType MaskDataType=DateMask!
long TextColor=16711680
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_3 from statictext within w_sk_stampe
int X=41
int Y=604
int Width=421
int Height=60
boolean Enabled=false
string Text="Tipo lavoro"
boolean FocusRectangle=false
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type gb_2 from groupbox within w_sk_stampe
int X=1065
int Y=140
int Width=983
int Height=236
string Text="Periodo"
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type gb_1 from groupbox within w_sk_stampe
int X=41
int Y=140
int Width=983
int Height=236
string Text="Numero Commessa"
long TextColor=8421376
long BackColor=12632256
int TextSize=-10
int Weight=700
string FaceName="Courier New"
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

