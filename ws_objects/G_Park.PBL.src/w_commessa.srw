$PBExportHeader$w_commessa.srw
forward
global type w_commessa from w_g_tab_3
end type
type ln_1 from line within tabpage_4
end type
type ln_1 from line within tabpage_4
end type
end forward

global type w_commessa from w_g_tab_3
int X=170
int Y=149
int Width=3127
int Height=1677
boolean TitleBar=true
string Title="Commessa"
end type
global w_commessa w_commessa

forward prototypes
private subroutine inizializza ()
protected subroutine inizializza_1 ()
private subroutine inizializza_2 ()
private subroutine inizializza_3 ()
private function integer inserisci ()
private function integer check_contatto ()
private function integer check_rek (long k_nro_commessa, date k_data)
private function integer check_prot ()
private function string check_dati ()
private subroutine riempi_id ()
protected function integer cancella ()
private function integer check_cliente ()
private function integer check_budget ()
private function integer check_resp ()
private subroutine leggi_altre_tab ()
private subroutine pulizia_righe ()
private subroutine attiva_tasti ()
protected function string aggiorna ()
private function string dati_modif (string k_titolo)
private subroutine check_stato (string k_stato)
end prototypes

private subroutine inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//======================================================================
//
string k_scelta
string k_stato = "0"
long  k_key, k_id_cliente
int k_err_ins, k_rc
datawindowchild kdwc_cliente, kdwc_cliente_1, kdwc_cliente_2 
datawindowchild kdwc_contatto, kdwc_divisione, kdwc_tipo, kdwc_protocollo


//=== Annotazioni Commesse
//tab_1.tabpage_4.dw_41.settransobject(sqlca)


if tab_1.tabpage_1.dw_1.rowcount() = 0 then
	
	k_scelta = trim(mid(st_parametri.text, 1, 2))
	
	k_key = long(mid(st_parametri.text, 3, 10))


	tab_1.tabpage_1.dw_1.getchild("clienti_a_rag_soc_1", kdwc_cliente)
	tab_1.tabpage_1.dw_1.getchild("clienti_b_rag_soc_1", kdwc_cliente_1)
	tab_1.tabpage_1.dw_1.getchild("clienti_c_rag_soc_1", kdwc_cliente_2)
	tab_1.tabpage_1.dw_1.getchild("id_contatto", kdwc_contatto)
	tab_1.tabpage_1.dw_1.getchild("id_divisione", kdwc_divisione)
	tab_1.tabpage_1.dw_1.getchild("id_t_lavoro", kdwc_tipo)
	tab_1.tabpage_1.dw_1.getchild("id_protocollo", kdwc_protocollo)

	kdwc_cliente.settransobject(sqlca)
	kdwc_cliente_1.settransobject(sqlca)
	kdwc_cliente_2.settransobject(sqlca)
	kdwc_contatto.settransobject(sqlca)
	kdwc_divisione.settransobject(sqlca)
	kdwc_tipo.settransobject(sqlca)
	kdwc_protocollo.settransobject(sqlca)

//	kdwc_cliente.insertrow(0)
//	kdwc_cliente_1.insertrow(0)
//	kdwc_cliente_2.insertrow(0)
	kdwc_contatto.insertrow(0)
//	kdwc_divisione.insertrow(0)
//	kdwc_tipo.insertrow(0)
	kdwc_protocollo.insertrow(0)

	if kdwc_cliente.rowcount() = 0 then
		kdwc_cliente.retrieve("", KK_TIPO_CLIENTE)
		kdwc_cliente.insertrow(1)
	end if
	if kdwc_cliente_1.rowcount() = 0 then
		kdwc_cliente_1.retrieve("",  KK_TIPO_DIPENDENTE)
		kdwc_cliente_1.insertrow(1)
	end if
	if kdwc_cliente_2.rowcount() = 0 then
		kdwc_cliente_2.retrieve("",  KK_TIPO_DIPENDENTE)
		kdwc_cliente_2.insertrow(1)
	end if
	if kdwc_divisione.rowcount() = 0 then
		kdwc_divisione.retrieve("")
		kdwc_divisione.insertrow(1)
	end if
	if kdwc_tipo.rowcount() = 0 then
		kdwc_tipo.retrieve("")
		kdwc_tipo.insertrow(1)
	end if


	if k_key = 0 then
		
		k_err_ins = inserisci()
		tab_1.tabpage_1.dw_1.setfocus()
	else

		k_rc = tab_1.tabpage_1.dw_1.retrieve(k_key) 
		
		choose case k_rc

			case is < 0				
				messagebox("Operazione fallita", &
					"Mi spiace ma si e' verificato un errore interno al programma~n~r" + &
					"(ID Commessa cercata :" + string(k_key) + ")~n~r" )
				cb_ritorna.postevent(clicked!)

			case 0
	
				tab_1.tabpage_1.dw_1.reset()
				attiva_tasti()

				if k_scelta = "mo" then
					messagebox("Ricerca fallita", &
						"Mi spiace ma la Commessa non e' in archivio ~n~r" + &
						"(ID Commessa cercata :" + string(k_key) + ")~n~r" )
					
					close(w_commessa)
					
				else
					k_err_ins = inserisci()
					tab_1.tabpage_1.dw_1.setfocus()
				end if
			case is > 0		
				if k_scelta = "in" then
					messagebox("Trovata Commessa", &
						"La Commessa e' gia' in archivio ~n~r" + &
						"(ID Commessa cercata :" + string(k_key) + ")~n~r" )
			
					st_parametri.text = replace(st_parametri.text, 1, 2, "mo")

				end if

				k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
				if k_id_cliente > 0 then
					kdwc_contatto.retrieve(k_id_cliente)
					kdwc_protocollo.retrieve(k_id_cliente, k_key)
				end if

//				kdwc_contatto.insertrow(1)
//				kdwc_protocollo.insertrow(1)
	
				tab_1.tabpage_1.dw_1.setcolumn(3)
				tab_1.tabpage_1.dw_1.setfocus()
				
				k_stato = tab_1.tabpage_1.dw_1.getitemstring ( 1, "stato") 
				
				attiva_tasti()
		
		end choose

	end if

else
	attiva_tasti()
	k_stato = tab_1.tabpage_1.dw_1.getitemstring ( 1, "stato") 

end if

check_stato(k_stato) //abilita/disabilita la possibilita di modifiche
	



end subroutine

protected subroutine inizializza_1 ();////======================================================================
//=== Inizializzazione del TAB 2 controllandone i valori se gia' presenti
//======================================================================
//
long k_id_commessa
string k_scelta


k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")  
k_scelta = mid(st_parametri.text,1 ,2)

//=== Se nr.commessa non impostato forzo una INSERISCI commessa, impostando in nr.commessa
	if k_id_commessa = 0 then
		inserisci()
		k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")  
	end if

//=== Se tab_2 non ha righe INSERISCI_TAB_2 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con la commessa allora resetto		
	if tab_1.tabpage_2.dw_2.rowcount() > 0 then
		if tab_1.tabpage_2.dw_2.getitemnumber(1, "id_commessa") <> k_id_commessa then 
			tab_1.tabpage_2.dw_2.reset()
		end if
	end if

	if tab_1.tabpage_2.dw_2.rowcount() < 1 then
//			if k_scelta <> "in" then

		if tab_1.tabpage_2.dw_2.retrieve(k_id_commessa) <= 0 then

			inserisci()
		else
			attiva_tasti()
		end if				
	else
		attiva_tasti()
	end if

	tab_1.tabpage_2.dw_2.setfocus()
	

	



end subroutine

private subroutine inizializza_2 ();////======================================================================
//=== Inizializzazione del TAB 3 controllandone i valori se gia' presenti
//======================================================================
//
long k_id_commessa, k_id_cliente
string k_scelta


k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")  
k_scelta = mid(st_parametri.text,1 ,2)

//=== Se nr.commessa non impostato forzo una INSERISCI commessa, impostando in nr.commessa
	if k_id_commessa = 0 then
		inserisci()
		k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")  
	end if

//=== Se tab_3 non ha righe INSERISCI_tab_3 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con la commessa allora resetto		
//	if tab_1.tabpage_3.dw_3.rowcount() > 0 then
//		if tab_1.tabpage_3.dw_3.getitemnumber(1, "id_commessa") <> k_id_commessa then 
//			tab_1.tabpage_3.dw_3.reset()
//		end if
//	end if
	if tab_1.tabpage_3.dw_3.rowcount() < 1 then

		k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")  

//=== Parametri : commessa, cliente, flag di solo rek della commessa
		if tab_1.tabpage_3.dw_3.retrieve(k_id_commessa, k_id_cliente, 0) <= 0 then

			inserisci()
		else
					
//=== Setto il valore ON del check box
			tab_1.tabpage_3.dw_3.Modify("id_commessa.CheckBox.On='"+ &
										string(k_id_commessa, "#####")+"'")
			attiva_tasti()

		end if				
	else
		attiva_tasti()
	end if

	tab_1.tabpage_3.dw_3.setfocus()
	

end subroutine

private subroutine inizializza_3 ();////======================================================================
//=== Inizializzazione del TAB 4 controllandone i valori se gia' presenti
//======================================================================
//
long k_id_commessa
string k_scelta


k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")  
k_scelta = mid(st_parametri.text,1 ,2)

//=== Se nr.commessa non impostato forzo una INSERISCI commessa, impostando in nr.commessa
	if k_id_commessa = 0 then
		inserisci()
		k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")  
	end if

//=== Se tab_4 non ha righe INSERISCI_TAB_4 altrimenti controllo che righe sono
//=== Se le righe presenti non c'entrano con la commessa allora resetto		
	if tab_1.tabpage_4.dw_4.rowcount() > 0 then
		if tab_1.tabpage_4.dw_4.getitemnumber(1, "id_commessa") <> k_id_commessa then 
			tab_1.tabpage_4.dw_4.reset()
		end if
	end if

	if tab_1.tabpage_4.dw_4.rowcount() < 1 then
//			if k_scelta <> "in" then

		if tab_1.tabpage_4.dw_4.retrieve(k_id_commessa) <= 0 then

			inserisci()
		else
			attiva_tasti()
		end if				
//			else
//				inserisci()
//			end if
	else
		attiva_tasti()

	end if

////=== Se tab_4 non ha righe INSERISCI_TAB_41 altrimenti controllo che righe sono
////=== Se le righe presenti non c'entrano con la commessa allora resetto
//	if tab_1.tabpage_4.dw_41.rowcount() > 0 then
//		tab_1.tabpage_4.dw_41.accepttext()
//		if tab_1.tabpage_4.dw_41.getitemnumber(1, "id_commessa") <> k_id_commessa then 
//			tab_1.tabpage_4.dw_41.reset()
//		end if
//	end if
//
//	if tab_1.tabpage_4.dw_41.rowcount() < 1 then
//
//		if tab_1.tabpage_4.dw_41.retrieve(k_id_commessa) <= 0 then
//
//			inserisci()
//		else
//			attiva_tasti()
//		end if				
//	else
//		attiva_tasti()
//	end if
//	
//	tab_1.tabpage_4.dw_41.setfocus()
//	

	



end subroutine

private function integer inserisci ();//
int k_return=1, k_ctr
string k_errore="0 "
date k_data
long k_id_commessa, k_nro_commessa, k_riga, k_id_cliente, k_id_protocollo
datawindowchild kdwc_cliente, kdwc_cliente_1, kdwc_cliente_2 
datawindowchild kdwc_contatto, kdwc_divisione, kdwc_tipo, kdwc_protocollo
kuf_base kuf1_base


//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//if left(dati_modif(""), 1) = "1" then //Richisto Aggiornamento

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
//	k_errore = aggiorna_dati()

//end if


if left(k_errore, 1) = "0" then

//=== Pulizia dei campi
	attiva_tasti()

//=== Aggiunge una riga al data windows
	choose case tab_1.selectedtab 
		case  1 
	
			tab_1.tabpage_1.dw_1.getchild("clienti_a_rag_soc_1", kdwc_cliente)
			tab_1.tabpage_1.dw_1.getchild("clienti_b_rag_soc_1", kdwc_cliente_1)
			tab_1.tabpage_1.dw_1.getchild("clienti_c_rag_soc_1", kdwc_cliente_2)
			tab_1.tabpage_1.dw_1.getchild("id_contatto", kdwc_contatto)
			tab_1.tabpage_1.dw_1.getchild("id_divisione", kdwc_divisione)
			tab_1.tabpage_1.dw_1.getchild("id_t_lavoro", kdwc_tipo)
			tab_1.tabpage_1.dw_1.getchild("id_protocollo", kdwc_protocollo)

			kdwc_cliente.settransobject(sqlca)
			kdwc_cliente_1.settransobject(sqlca)
			kdwc_cliente_2.settransobject(sqlca)
			kdwc_contatto.settransobject(sqlca)
			kdwc_divisione.settransobject(sqlca)
			kdwc_tipo.settransobject(sqlca)
			kdwc_protocollo.settransobject(sqlca)
	
			kuf1_base = create kuf_base
			k_id_commessa = long(mid(kuf1_base.prendi_dato_base("id_commessa"),2)) + 1
			k_nro_commessa = long(mid(kuf1_base.prendi_dato_base("ult_nro_commessa"),2)) + 1
			destroy kuf1_base

			if tab_1.tabpage_1.dw_1.rowcount() > 0 then
				k_data = tab_1.tabpage_1.dw_1.getitemdate(1, "commesse_data")
				tab_1.tabpage_1.dw_1.reset()
			else
				k_data = today()
			end if
			
//			if kdwc_cliente.retrieve('',  KK_TIPO_CLIENTE) > 0 then
//				kdwc_cliente.insertrow(1)
//			end if
//			if kdwc_cliente_1.retrieve('',  KK_TIPO_DIPENDENTE) > 0 then
//				kdwc_cliente_1.insertrow(1)
//			end if
//			if kdwc_cliente_2.retrieve('',  KK_TIPO_DIPENDENTE) > 0 then
//				kdwc_cliente_2.insertrow(1)
//			end if
////			if kdwc_contatto.retrieve("")
//			kdwc_contatto.insertrow(0)
//			if kdwc_divisione.retrieve("") > 0 then
//				kdwc_divisione.insertrow(1)
//			end if
//			if kdwc_tipo.retrieve("") > 0 then
//				kdwc_tipo.insertrow(1)
//			end if
////			kdwc_prottocollo.retrieve()
//			kdwc_protocollo.insertrow(0)

			tab_1.tabpage_1.dw_1.insertrow(0)
			
			tab_1.tabpage_1.dw_1.setitem(1, "id_commessa", k_id_commessa)
			tab_1.tabpage_1.dw_1.setitem(1, "nro_commessa", k_nro_commessa)
			tab_1.tabpage_1.dw_1.setitem(1, "commesse_data", k_data)
			tab_1.tabpage_1.dw_1.setitem(1, "stato", "0")
			
			tab_1.tabpage_1.dw_1.setcolumn(3)
			
		case 2 // dati dettaglio commessa inizializzazione
			k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")
			k_data = today()
			
			if k_id_commessa > 0 then
				k_riga = tab_1.tabpage_2.dw_2.insertrow(0)

				tab_1.tabpage_2.dw_2.setitem(k_riga, "id_commessa", k_id_commessa)
				tab_1.tabpage_2.dw_2.setitem(k_riga, "data_prev", k_data)
				tab_1.tabpage_2.dw_2.setitem(k_riga, "id_fase", 0)
				if k_riga > 1 then
					k_ctr = tab_1.tabpage_2.dw_2.getitemnumber((k_riga - 1) , "sequenza") + 1
				else
					k_ctr = 1
				end if
				tab_1.tabpage_2.dw_2.setitem(k_riga, "sequenza", k_ctr)

				k_riga = tab_1.tabpage_2.dw_2.rowcount()
				if k_riga = 1 then
					for k_riga = 2 to 10
						tab_1.tabpage_2.dw_2.insertrow(0)
						tab_1.tabpage_2.dw_2.setitem(k_riga, "id_commessa", k_id_commessa)
						tab_1.tabpage_2.dw_2.setitem(k_riga, "data_prev", k_data)
						tab_1.tabpage_2.dw_2.setitem(k_riga, "id_fase", 0)
						tab_1.tabpage_2.dw_2.setitem(k_riga, "sequenza", k_riga)
					next
					k_riga = 1
				end if
				tab_1.tabpage_2.dw_2.scrolltorow(k_riga)
				tab_1.tabpage_2.dw_2.setrow(k_riga)
				tab_1.tabpage_2.dw_2.setcolumn(3)
//=== Se satato commessa a 0=Creazione allora Sequenze Straordinarie NON possibili
				if tab_1.tabpage_1.dw_1.getitemstring(1, "stato") = "0" then
					tab_1.tabpage_2.dw_2.modify("tipo.tabsequence=0")
				else
					tab_1.tabpage_2.dw_2.modify("tipo.tabsequence=1")
				end if
			end if
			
		case 3 // protocolli da abbinare alla commessa
			k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")
			k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
				 
			if k_id_cliente > 0 and k_id_commessa > 0 then
				tab_1.tabpage_3.dw_3.Modify("id_commessa.CheckBox.On='"+ &
										string(k_id_commessa, "#####")+"'")

//=== Parametri : commessa, cliente, flag di rek commessa + altri prot non abbinati
				if tab_1.tabpage_3.dw_3.retrieve(k_id_commessa, k_id_cliente, 1) > 0 then
					tab_1.tabpage_3.dw_3.scrolltorow(1)
					tab_1.tabpage_3.dw_3.setrow(1)
					tab_1.tabpage_3.dw_3.setcolumn(1)
//=== Imposto il protocollo messo in testata
					k_id_protocollo = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_protocollo")
					if k_id_protocollo > 0 then 
						k_ctr = tab_1.tabpage_3.dw_3.find("id_protocollo=" + &
											string(k_id_protocollo, "#####"), 0, &
											tab_1.tabpage_3.dw_3.rowcount())
						if k_ctr > 0 then 
							if tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, "id_commessa") = 0 or & 
								isnull(tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, "id_commessa")) then 
							
								tab_1.tabpage_3.dw_3.setitem(k_ctr, "id_commessa", k_id_commessa)
							end if
						end if
					end if

				end if
			end if

			
		case 4 // anticipi su commessa
			k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")
	
			if k_id_commessa > 0 then
				k_riga = tab_1.tabpage_4.dw_4.insertrow(0)

				tab_1.tabpage_4.dw_4.setitem(k_riga, "id_commessa", k_id_commessa)
				tab_1.tabpage_4.dw_4.scrolltorow(k_riga)
				tab_1.tabpage_4.dw_4.setrow(k_riga)
				tab_1.tabpage_4.dw_4.setcolumn(1)

//				if tab_1.tabpage_4.dw_41.rowcount() = 0 then
//					k_riga = tab_1.tabpage_4.dw_41.insertrow(0)
//
//					tab_1.tabpage_4.dw_41.setitem(k_riga, "id_commessa", k_id_commessa)
//					tab_1.tabpage_4.dw_41.scrolltorow(k_riga)
//					tab_1.tabpage_4.dw_41.setrow(k_riga)
//					tab_1.tabpage_4.dw_41.setcolumn(1)
//				end if
			end if
			
	end choose	

	k_return = 0

end if

return (k_return)



end function

private function integer check_contatto ();//
int k_return = 0
long k_id
string k_rag_soc, k_tel_num, k_fax_num


k_id = long(tab_1.tabpage_1.dw_1.gettext())

if k_id > 0 then

//	k_rag_soc = k_rag_soc + "%"
	declare c_clienti cursor for  
		SELECT 
   	       "contatti"."tel_num",  
   	       "contatti"."fax_num"  
    	FROM "contatti"  
   	WHERE "id_contatto" = :k_id   ;

//	k_rag_soc = "Anagrafica non trovata"

	open c_clienti;
	if sqlca.sqlcode = 0 then
		
		fetch c_clienti into :k_tel_num, :k_fax_num;
		if sqlca.sqlcode = 0 then

			tab_1.tabpage_1.dw_1.setitem(1, "contatti_tel_num", k_tel_num)
			tab_1.tabpage_1.dw_1.setitem(1, "contatti_fax_num", k_tel_num)

		else			
			k_return = 1
		end if
		close c_clienti;
	else
		k_return = 1

	end if
			
end if

return k_return

end function

private function integer check_rek (long k_nro_commessa, date k_data);//
int k_return = 0
int k_anno
long k_id_commessa 
string k_rag_soc_1
datetime k_data_comm


k_anno = year(k_data)


	SELECT 
			"commesse"."id_commessa",
			"commesse"."data",
         "clienti"."rag_soc_1"  
   	 INTO :k_id_commessa, 
		 		:k_data_comm,
      	   :k_rag_soc_1  
    	FROM "commesse" inner join "clienti" on
		 	  "commesse"."id_cliente" = "clienti"."id_cliente" 
   	WHERE "commesse"."nro_commessa" = :k_nro_commessa and
				year("commesse"."data") = :k_anno;

	if sqlca.sqlcode = 0 then

		if messagebox("Commessa gia' in Archivio", & 
					"Vuoi modificare la commessa del "+ &
					string (k_data_comm, "dd-mm-yy") + "~n~r"+ &
					"di " + trim(k_rag_soc_1), question!, yesno!, 2) = 1 then
		
//			tab_1.tabpage_1.dw_1.reset()

			st_parametri.text = replace(st_parametri.text, 1, 2, "mo")
			st_parametri.text = replace(st_parametri.text, 3, 10, &
								string(k_id_commessa,"0000000000"))

			tab_1.tabpage_1.dw_1.reset()
			inizializza()
			
		else
			
			k_return = 1
		end if
	end if  

	attiva_tasti()



return k_return


end function

private function integer check_prot ();//
int k_return = 0
long k_id, k_nro_protocollo, k_riga
datetime k_data
string k_rag_soc, k_tipo, k_descrizione


k_rag_soc = trim(tab_1.tabpage_1.dw_1.gettext())

if len(k_rag_soc) > 0 then

//	k_rag_soc = k_rag_soc + "%"
	declare c_protocolli cursor for  
		SELECT 
   	       "protocolli"."tipo",  
   	       "protocolli"."nro_protocollo",  
   	       "protocolli"."data",  
   	       "protocolli"."descrizione",  
   	       "clienti"."rag_soc_1"  
    	FROM "protocolli" left outer join "clienti" on 
		 	"protocolli"."id_cliente" = "clienti"."id_cliente" 
   	WHERE "id_protocollo" = :k_id and
   	       ("protocolli"."id_commessa" is null or
    	        "protocolli"."id_commessa" = 0)	; 

//	k_rag_soc = "Anagrafica non trovata"

	open c_protocolli; 
	if sqlca.sqlcode = 0 then
		
		fetch c_protocolli into :k_tipo, :k_nro_protocollo, :k_data, 
							:k_descrizione, :k_rag_soc;
		if sqlca.sqlcode = 0 then

			k_riga = tab_1.tabpage_3.dw_3.getrow()

//			tab_1.tabpage_3.dw_3.setitem(k_riga, "protocolli_tipo", k_tipo)
			tab_1.tabpage_3.dw_3.setitem(k_riga, "protocolli_nro_protocollo", k_nro_protocollo)
			tab_1.tabpage_3.dw_3.setitem(k_riga, "protocolli_data", k_data)
			tab_1.tabpage_3.dw_3.setitem(k_riga, "protocolli_descrizione", k_descrizione)

		else			
			k_return = 1
//			k_rag_soc = "Anagrafica non trovata"
		end if
		close c_protocolli;
	else
		k_return = 1

	end if
			
end if

return k_return

end function

private function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = ""
char k_errore = "0"
long k_nr_righe
int k_riga
int k_nr_errori
string k_key_str
char k_stato, k_tipo
long k_key



//=== Controllo il primo tab
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	k_nr_errori = 0
	k_riga = 1

	k_key = tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "nro_commessa") 
	if isnull(k_key) or k_key = 0 then
		k_return = "Manca il Numero " + tab_1.tabpage_1.text + "~n~r"
		k_errore = "3"
		k_nr_errori++
	else
		if isnull(tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "commesse_data")) = true then
			k_return = "Manca la Data " + tab_1.tabpage_1.text + "~n~r" 
			k_errore = "3"
			k_nr_errori++
		end if
		if tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_cliente") = 0 or &
			isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_cliente")) = true then
			k_return = k_return + "Manca il Cliente " + tab_1.tabpage_1.text + "~n~r" 
			k_errore = "3"
			k_nr_errori++
		end if
	end if


//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
	k_riga = tab_1.tabpage_2.dw_2.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		k_key = tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "sequenza") 

		if isnull(k_key) then
			tab_1.tabpage_2.dw_2.setitem ( k_riga, "sequenza", 0) 
			k_key = 0
		end if

		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
			if isnull(tab_1.tabpage_2.dw_2.getitemdate ( k_riga, "data_prev")) = true then
				k_return = "Data " + tab_1.tabpage_2.text + " alla riga " + &
				string(k_riga, "#####") + " non impostata~n~r" 
				k_errore = "4"
				k_nr_errori++
			end if

			if k_errore = "0" and k_riga < k_nr_righe and k_key > 0 then
				k_tipo = tab_1.tabpage_2.dw_2.getitemstring ( k_riga, "tipo") 
				if tab_1.tabpage_2.dw_2.find("sequenza = " +  &
							string(k_key, "#####") + " and tipo='" + k_tipo + "'", &
							(k_riga+1), k_nr_righe) > 0 then
					k_return = "La stessa sequenza " + tab_1.tabpage_2.text + " ripetuta piu' volte~n~r" 
					k_return = k_return + "(Codice " + string(k_key) + ") ~n~r"
					k_errore = "4"
					k_nr_errori++
				end if
			end if
		end if
		k_riga++

		k_riga = tab_1.tabpage_2.dw_2.getnextmodified(k_riga, primary!)

	loop

//=== Controllo altro tab
	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
	k_riga = tab_1.tabpage_4.dw_4.getnextmodified(0, primary!)

	do while k_riga > 0  and k_nr_errori < 10

		k_key_str = tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "id_fattura") 


		if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 

			if isnull(tab_1.tabpage_4.dw_4.getitemdate ( k_riga, "data_fattura")) = true then
				k_return = "Manca la Data " + tab_1.tabpage_4.text + " alla riga " + &
				string(k_riga, "#####") + " ~n~r" 
				k_errore = "3"
				k_nr_errori++
			end if

			if k_nr_errori < 9 then // per non uscire da check senza contr.eventuali eltri errori gravi 
				if isnull(tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "importo")) = true or & 
					tab_1.tabpage_4.dw_4.getitemnumber ( k_riga, "importo") = 0 then
					k_return = "Manca l'Importo " + tab_1.tabpage_4.text + " alla riga " + &
					string(k_riga, "#####") + " ~n~r" 
					k_errore = "4"
					k_nr_errori++
				end if
			end if

		end if
		k_riga++

		k_riga = tab_1.tabpage_4.dw_4.getnextmodified(k_riga, primary!)

	loop



return k_errore + k_return


end function

private subroutine riempi_id ();//
//=== Imposta gli Effettivi ID degli archivi
long k_righe, k_ctr, k_id_commessa, k_nro_commessa, k_nro_old, k_id_fase
long k_id_commessa_1, k_nro_commessa_1
string k_ret_code
kuf_base kuf1_base


//=== Salvo ID Commessa originale x piu' avanti
	k_id_commessa_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")

//=== Se non sono in caricamento commessa allora prelevo l'ID dalla dw
	if tab_1.tabpage_1.dw_1.getitemstatus(1, 0, primary!) <> newmodified! then
		k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")
	else
		
		kuf1_base = create kuf_base
	//=== Imposto il ID COMMESSA su arch. Azienda
		k_ret_code = kuf1_base.prendi_dato_base("id_commessa")
		if left(k_ret_code, 1) = "0" then
			k_id_commessa = long(mid(k_ret_code, 2)) + 1
			k_ret_code = kuf1_base.metti_dato_base(0, "id_commessa", string(k_id_commessa,"#####"))
		end if
		if left(k_ret_code, 1) = "1" then
	
			k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")
			
			messagebox("Aggiornamento Automatico Fallito !!", &
				"Attenzione: non sono riuscito ad aggiornare il contatore COMMESSE,~n~r" + &
				"in archivio Azienda. ~n~r" + &
				"Aggiornare immediatamente in modo manuale il 'ID Commessa' in Azienda. ~n~r" + &
				"Per eseguire l'aggiornamento fare ALT+Z ed impostare  ~n~r" + &
				"il numero " + string(k_id_commessa,"#####") + " nel campo 'ID Commess'. ~n~r" + &
				"Eseguire poi gli opportuni controlli su questi dati Commessa. ~n~r" + &
				"Se il problema persiste, si prega di contattare il programmatore. Grazie", &
				stopsign!, ok!)
				
		end if		
	//=== Imposto il NRO COMMESSA su arch. Azienda
		k_ret_code = kuf1_base.prendi_dato_base("ult_nro_commessa")
		if left(k_ret_code, 1) = "0" then
			k_nro_commessa = long(mid(k_ret_code, 2)) + 1
			k_ret_code = kuf1_base.metti_dato_base(0, "ult_nro_commessa",&
								string(k_nro_commessa,"#####"))
		end if
		if left(k_ret_code, 1) = "1" then
	
			k_nro_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "nro_commessa")
			
			messagebox("Aggiornamento Automatico Fallito !!", &
				"Attenzione: non sono riuscito ad aggiornare il numero COMMESSA,~n~r" + &
				"in archivio Azienda. ~n~r" + &
				"Aggiornare immediatamente in modo manuale il 'numero Commessa' in Azienda. ~n~r" + &
				"Per eseguire l'aggiornamento fare ALT+Z ed impostare  ~n~r" + &
				"il numero " + string(k_nro_commessa,"#####") + " nel campo 'Commessa'. ~n~r" + &
				"Eseguire poi gli opportuni controlli su questi dati Commessa. ~n~r" + &
				"Se il problema persiste, si prega di contattare il programmatore. Grazie" , &
				stopsign!, ok!)
				
		end if		
	
		destroy kuf1_base
		k_nro_commessa_1 = tab_1.tabpage_1.dw_1.getitemnumber(1, "nro_commessa")
		if k_nro_commessa <> k_nro_commessa_1 then

//=== ho trovato il nr commessa diverso da quello in BASE controllo se commessa gia' caricata
			select id_commessa into :k_ctr
				from commesse
				where nro_commessa = :k_nro_commessa_1;

			if sqlca.sqlcode = 0 then
				k_nro_old = tab_1.tabpage_1.dw_1.getitemnumber(1, "nro_commessa") 
				messagebox("Aggiornamento Commessa", &
					"Mi spiace ma il numero abbinato a questa commessa e' stato cambiato ~n~r" + &
					"da " + string(k_nro_old,"#####") + " a " + &
						string(k_nro_commessa,"#####") + "~n~r" + &
					"Motivo : potrebbero esserci altri utenti che stanno caricando Commesse, ~n~r" + &
					"nessun pericolo di perdita dati. ", &
					information!, ok!)
			end if
		end if		
	
	
		tab_1.tabpage_1.dw_1.setitem(1, "nro_commessa", k_nro_commessa)
	
		tab_1.tabpage_1.dw_1.setitem(1, "id_commessa", k_id_commessa)

	end if
	
	k_righe = tab_1.tabpage_2.dw_2.rowcount()
	if k_righe > 0 then

//=== legge il contatore ID_FASE su COMMESSE
		k_id_fase = tab_1.tabpage_1.dw_1.getitemnumber(1, "ult_id_fase")
		if isnull(k_id_fase) then
			k_id_fase = 0
		end if

		for k_ctr = 1 to k_righe
			
			tab_1.tabpage_2.dw_2.setitem(k_ctr, "id_commessa", k_id_commessa)

			if tab_1.tabpage_2.dw_2.getitemstatus(k_ctr, 0, primary!) = newmodified! then
//=== Imposto il tipo a N se no  COSTO STRAORDINARIO
				if tab_1.tabpage_2.dw_2.getitemstring(k_ctr, "tipo") = "S" then
				else
					tab_1.tabpage_2.dw_2.setitem(k_ctr, "tipo", "N")
				end if					
//=== Imposta il ID_FASE su COMMESSE_PREV SOLO SE NUOVO MOVIM
				if tab_1.tabpage_2.dw_2.getitemnumber(k_ctr, "id_fase") = 0 then
					k_id_fase ++
					tab_1.tabpage_2.dw_2.setitem(k_ctr, "id_fase", k_id_fase)
				end if
			end if
		next

//=== agiorna il contatore ID_FASE su COMMESSE
		tab_1.tabpage_1.dw_1.setitem(1, "ult_id_fase", k_id_fase)
				
	end if

//=== Controllo e imposto il Protocollo abbinato se cambiato all'ultimo momento
	if k_id_commessa <> k_id_commessa_1 then
		k_righe = tab_1.tabpage_3.dw_3.rowcount()
		if k_righe > 0 then

			for k_ctr = 1 to k_righe
			
				if tab_1.tabpage_3.dw_3.getitemnumber(k_ctr, "id_commessa") = k_id_commessa_1 then 
					tab_1.tabpage_3.dw_3.setitem(k_ctr, "id_commessa", k_id_commessa)
				end if
			next
		end if
	end if

	k_righe = tab_1.tabpage_4.dw_4.rowcount()
	if k_righe > 0 then

		for k_ctr = 1 to k_righe
			
//			if tab_1.tabpage_scade.dw_dett_2.getitemstatus(k_ctr, 0, primary!) = &
//				newmodified! then
			tab_1.tabpage_4.dw_4.setitem(k_ctr, "id_commessa", k_id_commessa)
				
		next
	end if

//	k_righe = tab_1.tabpage_4.dw_41.rowcount()
//	if k_righe > 0 then
//
//		k_righe = tab_1.tabpage_4.dw_41.accepttext()
//
//		for k_ctr = 1 to k_righe
//			
//			tab_1.tabpage_4.dw_41.setitem(k_ctr, "id_commessa", k_id_commessa)
//				
//		next
//	end if
	


end subroutine

protected function integer cancella ();//
//=== Cancellazione rekord dal DB
//=== Ritorna : 0=OK 1=KO 2=non eseguita
//
int k_return=0
string k_desc, k_record, k_record_1
long k_key = 0, k_nro=0, k_id_fase
string k_errore = "0 ", k_errore1 = "0 ", k_nro_fatt
long k_riga, k_seq
date k_data
kuf_commesse  kuf1_commesse



//=== 
choose case tab_1.selectedtab 
	case 1 
		k_record = " Commessa "
		k_riga = tab_1.tabpage_1.dw_1.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "id_commessa")
				k_nro = tab_1.tabpage_1.dw_1.getitemnumber(k_riga, "nro_commessa")
				k_data = tab_1.tabpage_1.dw_1.getitemdate(k_riga, "commesse_data")
				k_desc = tab_1.tabpage_1.dw_1.getitemstring(k_riga, "titolo")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza descrizione" 
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare la Commessa~n~r" + &
					string(k_nro, "#####") + " del " + string(k_data, "dd-mm-yy") + &
					"~n~r" + trim(k_desc) + " ?"
			else
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
	case 2
		k_record = " Costo "
		k_riga = tab_1.tabpage_2.dw_2.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_commessa")
				k_id_fase = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "id_fase")
				k_seq = tab_1.tabpage_2.dw_2.getitemnumber(k_riga, "sequenza")
				k_desc = tab_1.tabpage_2.dw_2.getitemstring(k_riga, "descrizione")
				if isnull(k_desc) = true or trim(k_desc) = "" then
					k_desc = "senza descrizione" 
				end if
				k_record_1 = &
					"Sei sicuro di voler eliminare il Costo~n~r" + &
					string(k_seq, "#####") + " " + trim(k_desc) + " ?"
			else
				tab_1.tabpage_2.dw_2.deleterow(k_riga)
			end if
		end if
	case 4
		k_record = " Fattura di anticipo "
		k_riga = tab_1.tabpage_4.dw_4.getrow()	
		if k_riga > 0 then
			if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> new! and &
				tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) <> newmodified! then 
				k_key = tab_1.tabpage_4.dw_4.getitemnumber(k_riga, "id_commessa")
				k_nro_fatt = tab_1.tabpage_4.dw_4.getitemstring(k_riga, "id_fattura")
				k_data = tab_1.tabpage_4.dw_4.getitemdate(k_riga, "data_fattura")
				k_record_1 = &
					"Sei sicuro di voler eliminare la Fattura~n~r" + &
					trim(k_nro_fatt) + " del " + string(k_data, "dd-mm-yy") + " ?"
			else
				tab_1.tabpage_4.dw_4.deleterow(k_riga)
			end if
		end if
end choose	



//=== Se righe in lista
if k_riga > 0 and k_key > 0 then
	
//=== Richiesta di conferma della eliminazione del rek
	if messagebox("Elimina" + k_record, k_record_1, &
		question!, yesno!, 1) = 1 then
 
//=== Creo l'oggetto che ha la funzione x cancellare la tabella
		kuf1_commesse = create kuf_commesse
		
//=== Cancella la riga dal data windows di lista
		choose case tab_1.selectedtab 
			case 1 
				k_errore = kuf1_commesse.tb_delete(k_key) 
			case 2
				k_errore = kuf1_commesse.tb_delete_1("commesse_prev", k_key, string(k_id_fase)) 
			case 4
				k_errore = kuf1_commesse.tb_delete_1("commesse_fatture", k_key, k_nro_fatt) 
		end choose	
		if left(k_errore, 1) = "0" then

			k_errore = kuf1_data_base.db_commit()
			if left(k_errore, 1) <> "0" then
				k_return = 1
				messagebox("Problemi durante la Cancellazione !!", &
						"Controllare i dati. " + mid(k_errore, 2))

			else
				
				choose case tab_1.selectedtab 
					case 1 
						tab_1.tabpage_1.dw_1.deleterow(k_riga)
					case 2
						tab_1.tabpage_2.dw_2.deleterow(k_riga)
					case 4
						tab_1.tabpage_4.dw_4.deleterow(k_riga)
				end choose	

			end if

		else
			k_return = 1
			k_errore1 = k_errore
			k_errore = kuf1_data_base.db_rollback()

			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
							mid(k_errore1, 2) ) 	
			if left(k_errore, 1) <> "0" then
				messagebox("Problemi durante il recupero dell'errore !!", &
					"Controllare i dati. " + mid(k_errore, 2))
			end if

			attiva_tasti()

		end if

//=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
		destroy kuf1_commesse

	else
		messagebox("Elimina" + k_record,  "Operazione Annullata !!")
		k_return = 2
	end if


end if


choose case tab_1.selectedtab 
	case 1 
		tab_1.tabpage_1.dw_1.setfocus()
		tab_1.tabpage_1.dw_1.setcolumn(1)
	case 2
		tab_1.tabpage_2.dw_2.setfocus()
		tab_1.tabpage_2.dw_2.setcolumn(1)
	case 4
		tab_1.tabpage_4.dw_4.setfocus()
		tab_1.tabpage_4.dw_4.setcolumn(1)
end choose	


return k_return

end function

private function integer check_cliente ();//
int k_return 
string k_rag_soc, k_rag_soc_1
long k_id_cliente


k_rag_soc_1 = trim(tab_1.tabpage_1.dw_1.gettext())

if len(k_rag_soc_1) > 0 then

	declare c_clienti cursor for  
		SELECT 
  	     "clienti"."id_cliente",  
  	     "clienti"."rag_soc_1"  
    	FROM "clienti"  
   	WHERE ucase("clienti"."rag_soc_1") >= :k_rag_soc_1 and 
 	  	      ("clienti"."tipo" = :KK_TIPO_CLIENTE or 
 	  	       "clienti"."tipo" = :KK_TIPO_CLI_FOR) 
			order by "clienti"."rag_soc_1" ;

	k_rag_soc = "Anagrafica non trovata"

	open c_clienti;
	if sqlca.sqlcode = 0 then
		
		fetch c_clienti into :k_id_cliente, :k_rag_soc;
		if sqlca.sqlcode = 0 then

			tab_1.tabpage_1.dw_1.setitem(1, "id_cliente", k_id_cliente)
			tab_1.tabpage_1.dw_1.setitem(1, "clienti_a_rag_soc_1", k_rag_soc)
			tab_1.tabpage_1.dw_1.settext(k_rag_soc)
		else			
			k_rag_soc = "Anagrafica non trovata"
		end if
		close c_clienti;
	end if
			
end if

k_return = 1

return k_return

end function

private function integer check_budget ();//
int k_return 
string k_rag_soc, k_rag_soc_1
long k_id_cliente


k_rag_soc_1 = trim(tab_1.tabpage_1.dw_1.gettext())

if len(k_rag_soc_1) > 0 then

	declare c_clienti cursor for  
		SELECT 
  	     "clienti"."id_cliente",  
  	     "clienti"."rag_soc_1"  
    	FROM "clienti"  
   	WHERE "clienti"."rag_soc_1" >= :k_rag_soc_1 and 
 	  	      "clienti"."tipo" = :KK_TIPO_DIPENDENTE 
			order by "clienti"."rag_soc_1" ;

	k_rag_soc = "Anagrafica non trovata"

	open c_clienti;
	if sqlca.sqlcode = 0 then
		
		fetch c_clienti into :k_id_cliente, :k_rag_soc;
		if sqlca.sqlcode = 0 then

			tab_1.tabpage_1.dw_1.setitem(1, "id_cliente_b", k_id_cliente)
			tab_1.tabpage_1.dw_1.setitem(1, "clienti_b_rag_soc_1", k_rag_soc)
			tab_1.tabpage_1.dw_1.settext(k_rag_soc)
		else			
			k_rag_soc = "Anagrafica non trovata"
		end if
		close c_clienti;
	end if
			
end if

k_return = 1

return k_return

end function

private function integer check_resp ();//
int k_return 
string k_rag_soc, k_rag_soc_1
long k_id_cliente


k_rag_soc_1 = trim(tab_1.tabpage_1.dw_1.gettext())

if len(k_rag_soc_1) > 0 then

	declare c_clienti cursor for  
		SELECT 
  	     "clienti"."id_cliente",  
  	     "clienti"."rag_soc_1"  
    	FROM "clienti"  
   	WHERE "clienti"."rag_soc_1" >= :k_rag_soc_1 and 
 	  	      "clienti"."tipo" = :KK_TIPO_DIPENDENTE 
			order by "clienti"."rag_soc_1" ;

	k_rag_soc = "Anagrafica non trovata"

	open c_clienti;
	if sqlca.sqlcode = 0 then
		
		fetch c_clienti into :k_id_cliente, :k_rag_soc;
		if sqlca.sqlcode = 0 then

			tab_1.tabpage_1.dw_1.setitem(1, "id_cliente_d", k_id_cliente)
			tab_1.tabpage_1.dw_1.setitem(1, "clienti_c_rag_soc_1", k_rag_soc)
			tab_1.tabpage_1.dw_1.settext(k_rag_soc)
		else			
			k_rag_soc = "Anagrafica non trovata"
		end if
		close c_clienti;
	end if
			
end if

k_return = 1

return k_return

end function

private subroutine leggi_altre_tab ();//
long k_id_cliente, k_null, k_id_commessa
datawindowchild kdwc_contatto, kdwc_protocollo


	k_id_cliente = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_cliente")
	k_id_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "id_commessa")
	if isnull(k_id_commessa) then
		k_id_commessa = 0
	end if

	setnull(k_null)
	tab_1.tabpage_1.dw_1.setitem(1, "id_contatto", k_null)
	tab_1.tabpage_1.dw_1.setitem(1, "id_protocollo", k_null)

	tab_1.tabpage_1.dw_1.getchild("id_contatto", kdwc_contatto)
	kdwc_contatto.settransobject(sqlca)
	tab_1.tabpage_1.dw_1.getchild("id_protocollo", kdwc_protocollo)
	kdwc_protocollo.settransobject(sqlca)

	if k_id_cliente > 0 then
		kdwc_contatto.retrieve(k_id_cliente)
		kdwc_protocollo.retrieve(k_id_cliente, k_id_commessa)
	end if	
	kdwc_contatto.insertrow(1)
	kdwc_protocollo.insertrow(1)
	
	
end subroutine

private subroutine pulizia_righe ();//
long k_riga
long k_nr_righe


tab_1.tabpage_1.dw_1.accepttext()
tab_1.tabpage_2.dw_2.accepttext()
tab_1.tabpage_3.dw_3.accepttext()
tab_1.tabpage_4.dw_4.accepttext()
//tab_1.tabpage_4.dw_41.accepttext()

//=== Pulizia dei rek non validi sui vari TAB
	k_nr_righe = tab_1.tabpage_1.dw_1.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_1.dw_1.getitemstatus(k_riga, 0, primary!) = newmodified! then 
			if (isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "nro_commessa")) or &
				 tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "nro_commessa") = 0) or &
				(isnull(tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_cliente")) or &
				 tab_1.tabpage_1.dw_1.getitemnumber ( k_riga, "id_cliente") = 0) or &
				(isnull(tab_1.tabpage_1.dw_1.getitemdate ( k_riga, "commesse_data"))) &
				then
		
				tab_1.tabpage_1.dw_1.deleterow(k_riga)
			end if
		end if
		
	next

	
	k_nr_righe = tab_1.tabpage_2.dw_2.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_2.dw_2.getitemstatus(k_riga, 0, primary!) = newmodified! then 
			if (isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "lav_interne")) or &
				 tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "lav_interne") = 0) and &
				(isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "lav_esterne")) or &
				 tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "lav_esterne") = 0) and &
				(isnull(tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "materiale")) or &
				 tab_1.tabpage_2.dw_2.getitemnumber ( k_riga, "materiale") = 0) &
				then
		
				tab_1.tabpage_2.dw_2.deleterow(k_riga)
			end if
		end if
		
	next


//	k_nr_righe = tab_1.tabpage_3.dw_3.rowcount()
//	for k_riga = k_nr_righe to 1 step -1
//		if tab_1.tabpage_3.dw_3.getitemstatus(k_riga, 0, primary!) = newmodified! then 
//		if (isnull(tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, "id_commessa")) or &
//			 tab_1.tabpage_3.dw_3.getitemnumber ( k_riga, "id_commessa") = 0) &
//			then
//			tab_1.tabpage_3.dw_3.deleterow(k_riga)
//			//			tab_1.tabpage_3.dw_3.setitem(k_riga, "id_commessa", k_id_commessa)
//		end if
//	next
//

	k_nr_righe = tab_1.tabpage_4.dw_4.rowcount()
	for k_riga = k_nr_righe to 1 step -1

		if tab_1.tabpage_4.dw_4.getitemstatus(k_riga, 0, primary!) = newmodified! then 
			if (isnull(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "id_fattura")) or &
				 len(trim(tab_1.tabpage_4.dw_4.getitemstring ( k_riga, "id_fattura"))) = 0) &
				then
		
				tab_1.tabpage_4.dw_4.deleterow(k_riga)
			end if
		end if
		
	next

//	k_nr_righe = tab_1.tabpage_4.dw_41.rowcount()
//	for k_riga = k_nr_righe to 1 step -1
//
//		if (isnull(tab_1.tabpage_4.dw_41.getitemstring ( k_riga, "commesse_note_at_note")) or &
//			 len(trim(tab_1.tabpage_4.dw_41.getitemstring ( k_riga, "commesse_note_at_note"))) = 0) &
//			then
//		
//			tab_1.tabpage_4.dw_41.deleterow(k_riga)
//		end if
//		
//	next
//

end subroutine

private subroutine attiva_tasti ();//
//=========================================================================
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

//long k_nr_righe


cb_ritorna.enabled = true
cb_inserisci.enabled = true
cb_aggiorna.enabled = true
cb_cancella.enabled = true

cb_ritorna.default = false
cb_inserisci.default = false
cb_aggiorna.default = false
cb_cancella.default = false

//=== Nr righe ne DW lista
choose case tab_1.selectedtab
	case 1
		if tab_1.tabpage_1.dw_1.rowcount() = 0 then
			cb_inserisci.enabled = true
			cb_inserisci.default = true
			cb_cancella.enabled = false
			cb_aggiorna.enabled = false
		end if
	case 2
		if tab_1.tabpage_2.dw_2.rowcount() = 0 then
			cb_inserisci.enabled = true
			cb_inserisci.default = true
			cb_aggiorna.enabled = false
			cb_cancella.enabled = false
		end if
	case 3
		cb_cancella.enabled = false
		if tab_1.tabpage_3.dw_3.rowcount() = 0 then
			cb_inserisci.enabled = true
			cb_inserisci.default = true
			cb_aggiorna.enabled = false
		end if
	case 4
		if tab_1.tabpage_4.dw_4.rowcount() = 0 then
//			tab_1.tabpage_4.dw_41.rowcount() = 0 then
			cb_inserisci.enabled = true
			cb_inserisci.default = true
			cb_cancella.enabled = false
			cb_aggiorna.enabled = false
			cb_inserisci.enabled = true
		else
			if tab_1.tabpage_4.dw_4.rowcount() = 0 then
				cb_cancella.enabled = false
			end if
		end if
end choose
            

end subroutine

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle 
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="0 ", k_errore="0 ", k_errore1="0 "

//=== Aggiorna, se modificato, la TAB_1	
if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 OR &
	tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_1.dw_1.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_1.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_1.text + "' ~n~r" 
				end if
end if

//=== Aggiorna, se modificato, la TAB_2
if tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 or & 
	tab_1.tabpage_2.dw_2.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_2.dw_2.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_2.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_2.text + "' ~n~r" 
	end if	
end if

//=== Aggiorna, se modificato, la TAB_3
if tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 or & 
	tab_1.tabpage_3.dw_3.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_3.dw_3.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio " + tab_1.tabpage_3.text + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio '" + &
					tab_1.tabpage_3.text + "' ~n~r" 
	end if	
end if

//=== Aggiorna, se modificato, la TAB_4
if tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 or &
	tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0 & 
	then

	if tab_1.tabpage_4.dw_4.update() = 1 then

//=== Se tutto OK faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Archivio Anticipi Commessa " + mid(k_errore1, 2)
		else // Tutti i Dati Caricati in Archivio
			k_return ="0 "
		end if
	else
		k_errore1 = kuf1_data_base.db_rollback()
		k_return="1Fallito aggiornamento archivio 'Anticipi Commessa" + &
					 "' ~n~r" 
	end if	
end if

////=== Aggiorna, se modificato, la TAB_4 dw_41
//if tab_1.tabpage_4.dw_41.getnextmodified(0, primary!) > 0 or &
//	tab_1.tabpage_4.dw_41.getnextmodified(0, delete!) > 0 & 
//	then
//
//	if tab_1.tabpage_4.dw_41.update() = 1 then
//
////=== Se tutto OK faccio la COMMIT		
//		k_errore1 = kuf1_data_base.db_commit()
//		if left(k_errore1, 1) <> "0" then
//			k_return = "3" + "Archivio Note Commessa " + mid(k_errore1, 2)
//		else // Tutti i Dati Caricati in Archivio
//			k_return ="0 "
//		end if
//	else
//		k_errore1 = kuf1_data_base.db_rollback()
//		k_return="1Fallito aggiornamento archivio 'Note Commessa'" + &
//					" ~n~r" 
//	end if	
//end if


//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 		 : 2=LIBERO
//===			 : 3=Commit fallita

if left(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Eseguita !!", &
		mid(k_return, 2))
else
	if left(k_return, 1) = "3" then
		messagebox("Registrazione dati : problemi nella 'Commit' !!", &
			"Consiglio : chiudere e ripetere le operazioni eseguite")
	end if
end if


return k_return

end function

private function string dati_modif (string k_titolo);//
//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
int k_msg=0


//=== Toglie le righe eventualmente da non registrare
	pulizia_righe()
	
//	 	tab_1.tabpage_4.dw_41.getnextmodified(0, primary!) > 0 or & 
//	 	tab_1.tabpage_4.dw_41.getnextmodified(0, delete!) > 0 & 
	if tab_1.tabpage_1.dw_1.getnextmodified(0, primary!) > 0 or & 
	 	tab_1.tabpage_2.dw_2.getnextmodified(0, primary!) > 0 or & 
	 	tab_1.tabpage_3.dw_3.getnextmodified(0, primary!) > 0 or & 
	 	tab_1.tabpage_4.dw_4.getnextmodified(0, primary!) > 0 or & 
		tab_1.tabpage_1.dw_1.getnextmodified(0, delete!) > 0 or & 
	 	tab_1.tabpage_2.dw_2.getnextmodified(0, delete!) > 0 or & 
	 	tab_1.tabpage_3.dw_3.getnextmodified(0, delete!) > 0 or & 
	 	tab_1.tabpage_4.dw_4.getnextmodified(0, delete!) > 0  & 
		then 

		if isnull(k_titolo) or len(trim(k_titolo)) = 0 then
			k_titolo = "Aggiorna Archivio"
		end if

		k_msg = messagebox(k_titolo, "Dati Modificati, vuoi Salvare gli Aggiornamenti ?", &
							question!, yesnocancel!, 1) 
	
		if k_msg = 1 then
			k_return = "1Dati Modificati"	
		else
			k_return = string(k_msg)			
		end if

	end if


return k_return
end function

private subroutine check_stato (string k_stato);//
//=== Abilita/disabilita la commessa ai cambiamenti
//

	if k_stato = "0" or k_stato = "1" or k_stato = "2" or k_stato = "3" then
		
		tab_1.tabpage_1.dw_1.modify("nro_commessa.tabsequence=1 " + &
										"~tnro_commessa.tabsequence=2 " + &
										"~tcommesse_data.tabsequence=3 " + &
										"~ttitolo.tabsequence=4 " + &
										"~tclienti_a_rag_soc_1.tabsequence=5 " + &
										"~tid_contatto.tabsequence=6 " + &
										"~tid_t_lavoro.tabsequence=7 " + &
										"~tid_divisione.tabsequence=8 " + &
										"~tclienti_b_rag_soc_1.tabsequence=9 " + &
										"~tclienti_c_rag_soc_1.tabsequence=10 " + &
										"~tid_protocollo.tabsequence=11 " + &
										"~timporto_prev.tabsequence=12 ")

		tab_1.tabpage_2.dw_2.enabled = true

//		k_return = "La commessa non puo' essere modificata in corso o fine opera~n~r" + &
//					  "Lo Stato commessa e': 'Operativa' o 'Conclusa'~n~r" + &
//                "Se si ha quindi necessita' di modificare, la commessa si deve ~n~r" + &
//                 "cambiare lo Stato commessa (primo pannello).~n~r"  
//		k_errore = "1"
	else

		tab_1.tabpage_1.dw_1.modify("nro_commessa.tabsequence=0 " + &
										"~tnro_commessa.tabsequence=0 " + &
										"~tcommesse_data.tabsequence=0 " + &
										"~ttitolo.tabsequence=0 " + &
										"~tclienti_a_rag_soc_1.tabsequence=0 " + &
										"~tid_contatto.tabsequence=0 " + &
										"~tid_t_lavoro.tabsequence=0 " + &
										"~tid_divisione.tabsequence=0 " + &
										"~tclienti_b_rag_soc_1.tabsequence=0 " + &
										"~tclienti_c_rag_soc_1.tabsequence=0 " + &
										"~tid_protocollo.tabsequence=0 " + &
										"~timporto_prev.tabsequence=0 ")
										
		tab_1.tabpage_2.dw_2.enabled = false

	end if


end subroutine

on w_commessa.create
int iCurrent
call w_g_tab_3::create
iCurrent=UpperBound(this.Control)
end on

on w_commessa.destroy
call w_g_tab_3::destroy
end on

event closequery;//
int k_return 
//=== Chiamo l'evento della ancestor altrimenti non funziona il RETURN
k_return = Super::EVENT closequery ( )
RETURN k_return

end event

event resize;call super::resize;//
//tab_1.tabpage_4.dw_4.height = tab_1.tabpage_4.dw_4.height / 2
//tab_1.tabpage_4.dw_4.x = tab_1.tabpage_4.dw_4.x + 100
//tab_1.tabpage_4.dw_4.y = tab_1.tabpage_4.dw_41.height 


end event

type cb_ritorna from w_g_tab_3`cb_ritorna within w_commessa
int X=2711
int Y=1445
boolean Visible=true
end type

type cb_aggiorna from w_g_tab_3`cb_aggiorna within w_commessa
int X=1971
int Y=1445
boolean Visible=true
end type

type cb_cancella from w_g_tab_3`cb_cancella within w_commessa
int X=2341
int Y=1445
boolean Visible=true
end type

type cb_inserisci from w_g_tab_3`cb_inserisci within w_commessa
int X=1601
int Y=1445
boolean Visible=true
end type

event cb_inserisci::clicked;//
//=== 
string k_errore="0"

//=== Nuova Commessa
	choose case tab_1.selectedtab 
		case  1, 3 
	
			k_errore = left(dati_modif(parent.title), 1)

//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
			if k_errore = "1" then //Fare gli aggiornamenti

//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
				k_errore = aggiorna_dati()		

			else

				if k_errore = "2" then //Aggiornamento non richiesto
					k_errore = "0"
				end if

			end if
			
	end choose
	
	if left(k_errore, 1) = "0" then 
		inserisci()
	end if

end event

type st_parametri from w_g_tab_3`st_parametri within w_commessa
int X=234
int Y=1445
end type

type tab_1 from w_g_tab_3`tab_1 within w_commessa
int X=23
int Width=3041
int Height=1397
end type

type tabpage_1 from w_g_tab_3`tabpage_1 within tab_1
int X=19
int Y=113
int Width=3004
int Height=1269
string Text="Commessa"
end type

type dw_1 from w_g_tab_3`dw_1 within tabpage_1
int X=5
int Y=17
int Width=2967
int Height=1245
string DataObject="d_commessa"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=false
end type

event dw_1::itemchanged;call super::itemchanged;//
date k_data
long k_nro_commessa
string k_rag_soc
int k_errore=0


choose case dwo.name 
	case "nro_commessa" 
		k_data = tab_1.tabpage_1.dw_1.getitemdate(1, "commesse_data")
		k_nro_commessa = long(tab_1.tabpage_1.dw_1.gettext())
		if isnull(k_data) = false and &
			isnull(k_nro_commessa) = false and k_nro_commessa > 0 then
			if check_rek( k_nro_commessa, k_data ) > 0 then
				k_errore = 1
			end if
		end if
	case "commesse_data" 
		k_data = date(tab_1.tabpage_1.dw_1.gettext())
		k_nro_commessa = tab_1.tabpage_1.dw_1.getitemnumber(1, "nro_commessa")
		if isnull(k_data) = false and &
			isnull(k_nro_commessa) = false and k_nro_commessa > 0 then
			if check_rek( k_nro_commessa, k_data ) > 0 then
				k_errore = 1
			end if
		end if
	case "id_contatto" 
		if check_contatto() > 0 then
			k_errore = 1
		end if
	case "clienti_a_rag_soc_1" 
		check_cliente()
		leggi_altre_tab()
		k_errore = 1
	case "clienti_b_rag_soc_1" 
		check_budget()
		k_errore = 1
	case "clienti_c_rag_soc_1" 
		check_resp()
		k_errore = 1
	case "stato" 
		check_stato(this.gettext())
//		k_errore = 1
end choose 

if k_errore = 1 then
	return 2
end if
	
end event

type tabpage_2 from w_g_tab_3`tabpage_2 within tab_1
int X=19
int Y=113
int Width=3004
int Height=1269
string Text="Budget"
end type

type dw_2 from w_g_tab_3`dw_2 within tabpage_2
int X=1
int Width=2981
int Height=1229
string DataObject="d_comm_prev"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event dw_2::rowfocuschanged;call super::rowfocuschanged;//
if tab_1.tabpage_2.dw_2.getcolumn() < 3 then

	tab_1.tabpage_2.dw_2.setcolumn(3)	
end if


end event

type tabpage_3 from w_g_tab_3`tabpage_3 within tab_1
int X=19
int Y=113
int Width=3004
int Height=1269
boolean Visible=true
string Text="Protocolli"
end type

type dw_3 from w_g_tab_3`dw_3 within tabpage_3
int Width=2967
int Height=1233
string DataObject="d_comm_prot"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event dw_3::itemchanged;call super::itemchanged;//


choose case dwo.name 
	case "id_protocollo" 
		if check_prot() > 0 then
			return 2
		end if
end choose
end event

type tabpage_4 from w_g_tab_3`tabpage_4 within tab_1
int X=19
int Y=113
int Width=3004
int Height=1269
boolean Visible=true
string Text="Anticipi"
ln_1 ln_1
end type

on tabpage_4.create
this.ln_1=create ln_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=ln_1
end on

on tabpage_4.destroy
call super::destroy
destroy(this.ln_1)
end on

type dw_4 from w_g_tab_3`dw_4 within tabpage_4
int X=5
int Y=25
int Width=2785
int Height=1117
int TabOrder=10
string DataObject="d_comm_fatt"
boolean VScrollBar=true
end type

type tabpage_5 from w_g_tab_3`tabpage_5 within tab_1
int X=19
int Y=113
int Width=3004
int Height=1269
end type

type dw_5 from w_g_tab_3`dw_5 within tabpage_5
boolean Visible=false
end type

type ln_1 from line within tabpage_4
boolean Enabled=false
int BeginX=362
int BeginY=2377
int EndX=2675
int EndY=2377
int LineThickness=5
end type

