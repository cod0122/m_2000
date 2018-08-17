$PBExportHeader$w_import_cvs_crm_anag_old.srw
forward
global type w_import_cvs_crm_anag_old from window
end type
type cb_4 from commandbutton within w_import_cvs_crm_anag_old
end type
type cb_3 from commandbutton within w_import_cvs_crm_anag_old
end type
type cb_close from commandbutton within w_import_cvs_crm_anag_old
end type
type cb_2 from commandbutton within w_import_cvs_crm_anag_old
end type
type cb_1 from commandbutton within w_import_cvs_crm_anag_old
end type
type dw_1 from uo_d_std_1 within w_import_cvs_crm_anag_old
end type
end forward

global type w_import_cvs_crm_anag_old from window
integer width = 3991
integer height = 1684
boolean titlebar = true
string title = "Dati Anagrafiche CRM da file CSV"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 134217749
string icon = "AppIcon!"
boolean center = true
cb_4 cb_4
cb_3 cb_3
cb_close cb_close
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_import_cvs_crm_anag_old w_import_cvs_crm_anag_old

forward prototypes
private function st_esito importa_csv ()
private subroutine aggiorna_db ()
end prototypes

private function st_esito importa_csv ();//===
//=== Importa i record del file CSV selezionato formato:
//=== prima riga con nome-lotto + ; + data-lotto (yyyy-mm-dd)
//=== seguono tutte le righe con:  coefficiente + ; + dose 
//===
int k_file=0, k_rc 
int k_bytes, k_ctr, k_ctr_1, k_bytes_f, k_righe, k_righe_insert=0, k_bytes_appo
long k_colonna, k_riga
string k_rcx
string k_record, k_record_appo
string k_path, k_nome_file, k_ext

st_esito kst_esito, kst_esito_insert
st_tab_dosimetrie kst_tab_dosimetrie
st_profilestring_ini kst_profilestring_ini
kuf_utility kuf1_utility



//=== Clessidra di attesa
setpointer(hourglass!)

	
	kst_esito.esito = KKG_ESITO_OK
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
//	kst_profilestring_ini.operazione = kuf1_data_base.ki_profilestring_operazione_leggi
//	kst_profilestring_ini.file = "ambiente" 
//	kst_profilestring_ini.titolo = "ambiente" 
//	kst_profilestring_ini.nome = "arch_dosimetrie_csv"
//	kst_profilestring_ini.valore = " " 
//	k_rcx = trim(kuf1_data_base.profilestring_ini(kst_profilestring_ini))
//
//	k_path = trim(kst_profilestring_ini.valore)
//
//	if LenA(k_path) > 0 then
//		k_rcx = k_path
//		k_rc = LenA(k_rcx)
//		do while MidA(k_rcx, k_rc, 1) <> "\" and k_rc > 1
//			k_rcx = ReplaceA(k_rcx, k_rc, 1, " ")  
//			k_rc= k_rc - 1
//		loop
//		if DirectoryExists ( trim(k_rcx) ) then 
//			ChangeDirectory(trim(k_rcx)) 
//		end if
//		k_nome_file	= k_path
//	end if

k_rc = GetFileOpenName("Scegli Archivio 'Anagrafiche'", &
									k_path, k_nome_file, k_ext, "Anagrafiche in CSV (*.csv),*.csv") 

if k_rc <= 0 or LenA(trim(k_nome_file)) = 0 then
	k_path = " "
	kst_esito.esito = KKG_ESITO_NO_ESECUZIONE
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Elaborazione interrotta dall'utente" 
	
else
	k_file = fileopen( trim(k_path), linemode!, read!, lockreadwrite!)
	
	if k_file > 0 then

//=== Conto il nr. di record presenti		
		k_bytes = fileread(k_file, k_record) // legge una riga
		k_righe = 0
		k_ctr = 0
		do while k_bytes <> -100 
			k_bytes = fileread(k_file, k_record) // legge una riga
			
			k_righe++     //conta le righe 
		loop
		fileclose(k_file)

		if k_righe > 1 then 
			
			kuf1_utility = create kuf_utility
	
			k_righe = 0
			k_ctr_1=0
			k_file = fileopen( trim(k_path), linemode!, read!, lockreadwrite!)

			k_bytes = fileread(k_file, k_record) // legge una riga
			k_righe++

			do while k_bytes > 0 and LenA(trim(k_record)) < 4 // Leggo le righe fino a che non trovo qualcosa
				k_bytes = fileread(k_file, k_record) // legge una riga
				k_righe++
				if k_bytes <= 0 then
					k_record = " "
				end if
			loop
	
			k_record = LeftA(k_record, k_bytes)
			if isnull(k_record) then
				k_record = " "
			end if
			

//--- piglio il primo record di dettaglio
			k_bytes = fileread(k_file, k_record) // legge una riga
			k_righe++
			if k_bytes <= 0 then
				k_record = " "
			end if

			dw_1.reset( )

			do while k_bytes > 0 and kst_esito.esito = KKG_ESITO_OK

//--- ricopre la virgola con il punto
				kuf1_utility.u_replace(k_record, ".", ",")
				kuf1_utility.u_replace(k_record,"~"", " ")
				kuf1_utility.u_stringa_pulisci_x_msg(k_record)
				
//--- record di dettaglio piglio i campi a mettere nel DW
				k_ctr = PosA (k_record, ';')
				if k_ctr > 0 then
					
//--- inserisci nuovo record								
					k_riga = dw_1.insertrow(0)
					k_righe_insert++
					dw_1.setitem(k_riga, 1, k_riga)
					
//--- legge fino a che trova ';' e riempie tutte le colonne 		
					k_colonna = 3
					k_ctr_1 = 1
					do while k_ctr > 0 and k_colonna < 32 and k_bytes > 0

						if k_colonna = 3 then //id_cliente unico numerico
							if k_ctr = k_ctr_1 then
								dw_1.setitem(k_riga, k_colonna,0)
								dw_1.setitem(k_riga, 2, "S")
							else
								dw_1.setitem(k_riga, k_colonna,long(trim(MidA(k_record,k_ctr_1, k_ctr - k_ctr_1))))
							end if
						else
							if k_ctr = k_ctr_1 then
								dw_1.setitem(k_riga, k_colonna," ")
							else
								dw_1.setitem(k_riga, k_colonna,trim(MidA(k_record,k_ctr_1, k_ctr - k_ctr_1)))
							end if
						end if
//--- se ho superato la len el record legg altro record
						if (k_ctr + 1) < k_bytes  then
							k_ctr_1 = k_ctr + 1
							k_ctr = PosA (k_record, ';', k_ctr + 1)
//--- se non trovo il ';' ma non ho ancora letto tutte le colonne pobabile che il continuo sia nella riga successiva							
							if k_ctr = 0 then
								if k_colonna < 30 then
									do while k_ctr = 0 and k_bytes >= 0
										k_bytes_appo = k_bytes - k_ctr_1
										k_record_appo = trim(MidA(k_record,k_ctr_1, k_bytes - k_ctr_1))
										k_bytes = fileread(k_file, k_record) // legge una riga
										k_ctr_1=1
										if k_bytes > 0 then
											k_righe++
											kuf1_utility.u_replace(k_record, ".", ",")
											kuf1_utility.u_replace(k_record,"~"", " ")
											kuf1_utility.u_stringa_pulisci_x_msg(k_record)
											k_record = k_record_appo + k_record
											k_bytes = k_bytes + k_bytes_appo
											k_ctr = PosA (k_record, ';', 1)
										end if
									loop
									dw_1.setitem(k_riga, 2, "S")
									
									k_ctr_1 = 1
								else
									k_ctr = k_bytes
								end if
							end if
						else
							k_ctr = 0 //forzo uscita 
						end if
						k_colonna ++
					loop
				end if
				
				if k_bytes >= 0 then
					k_bytes = fileread(k_file, k_record) // legge una riga
					k_righe++
					if k_bytes <= 0 then
						k_record = " "
					end if
				end if

			loop
			
			fileclose(k_file)
			
			destroy kuf1_utility
			
		else
			kst_esito.esito = kkg_esito_blok
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "File inconsistente numero righe insufficiente: " + string(k_righe)
		end if
	else
		kst_esito.esito = kkg_esito_blok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "File non trovato o occupato, cercato: " + trim(k_path) 
	end if

	if kst_esito.esito <> kkg_esito_ok then
			
		kst_esito.SQLErrText = "Elaborazione terminata con Errore~n~r" + "controllare i valori inseriti.~n~r" &
										+ "Errore rilevato~n~r" &
			                     + trim(kst_esito.SQLErrText) + "~n~r" &
			                     + string(k_righe, "##,##0") + " righe elaborate~n~r" &
			                     + "dal file " + trim(k_path) + "~n~r" 
			
	else
		kst_esito.SQLErrText = "Elaborazione terminata Correttamente~n~r" + "controllare i valori inseriti.~n~r" &
			                     + string(k_righe, "##,##0") + " righe lette dal file~n~r" &
			                     + string(k_righe_insert, "##,##0") + " righe inserite in archivio~n~r" &
			                     + "dal file " + trim(k_path) + "~n~r" 
			
	end if

end if

//--- ripristina la path di lavoro
kuf1_data_base.setta_path_default()
							
							
return kst_esito


end function

private subroutine aggiorna_db ();//---
//--- Popola archivi da DW 
//---
int k_riga, k_ctr
string k_tel_r, k_tel
st_tab_clienti kst_tab_clienti, kst_tab_contatto1, kst_tab_contatto2, kst_tab_contatto3,kst_tab_contatto4, kst_tab_clienti_r 
st_tab_clienti_mkt kst_tab_clienti_mkt, kst_tab_contatto1_mkt, kst_tab_clienti_mkt_r
st_tab_clienti_web kst_tab_clienti_web, kst_tab_clienti_web_r
st_tab_clie_settori kst_tab_clie_settori
st_tab_clie_classi kst_tab_clie_classi
kuf_clienti kuf1_clienti
kuf_utility kuf1_utility
pointer kp




kp = setpointer(hourglass!)

kuf1_utility = create kuf_utility

for k_riga = 1 to dw_1.rowcount()

	kst_tab_clienti.codice = dw_1.getitemnumber( k_riga, "id_cliente")

	
//--- dati MKT cliente 	
	kst_tab_clienti_mkt.cod_atecori = trim(dw_1.getitemstring( k_riga, "cod_atecori"))
	kst_tab_clienti_mkt.altra_sede = trim(dw_1.getitemstring( k_riga, "altra_sede"))
	kst_tab_clienti_mkt.tipo_rapporto = trim(dw_1.getitemstring( k_riga, "tipo_rapporto"))
	kst_tab_clienti_mkt.note_prodotti = trim(dw_1.getitemstring( k_riga, "note_prodotto")) + " " +  trim(dw_1.getitemstring( k_riga, "note_prodotto_est")) 
	if len(trim(dw_1.getitemstring( k_riga, "valore_prodotto"))	) > 0 then
		kst_tab_clienti_mkt.note_prodotti += " (Valore=" + trim(dw_1.getitemstring( k_riga, "valore_prodotto")) + ") "
	end if
	if len(trim(dw_1.getitemstring( k_riga, "aziende_collegate"))) > 0 then
		kst_tab_clienti.rag_soc_10 = trim(dw_1.getitemstring( k_riga, "aziende_collegate"))
		select max(codice)
			into :kst_tab_clienti_mkt.id_cliente_link 
			from clienti
			where rag_soc_10 = :kst_tab_clienti.rag_soc_10
			using sqlca;
		if sqlca.sqlcode <> 0 then kst_tab_clienti_mkt.id_cliente_link  = 0
	end if
	

//--- divido le e-mail se ce ne sono + di una	
	kst_tab_clienti_web.email = trim(dw_1.getitemstring( k_riga, "e_mail"))
	kst_tab_clienti_web.email2 = ""
	kst_tab_clienti_web.email1 = ""
	k_ctr = pos(kst_tab_clienti_web.email,  " ", 1)
	if k_ctr < len(kst_tab_clienti_web.email) then
		kst_tab_clienti_web.email1 = mid(kst_tab_clienti_web.email, k_ctr+1)	
		kst_tab_clienti_web.email = left(kst_tab_clienti_web.email, k_ctr - 1)	
		k_ctr = pos(kst_tab_clienti_web.email1,  " ", 1)
		if k_ctr < len(kst_tab_clienti_web.email1) then
			kst_tab_clienti_web.email2 = mid(kst_tab_clienti_web.email1, k_ctr+1)	
			kst_tab_clienti_web.email1 = left(kst_tab_clienti_web.email1, k_ctr - 1)	
		end if
	end if

//--- dati Contatti
	kst_tab_contatto1.rag_soc_10 = trim(dw_1.getitemstring( k_riga, "contatto_1"))
	kst_tab_contatto1_mkt.qualifica = trim(dw_1.getitemstring( k_riga, "contatto_1_qualifica"))
	kst_tab_contatto2.rag_soc_10 = trim(dw_1.getitemstring( k_riga, "contatto_2"))
	kst_tab_contatto3.rag_soc_10 = trim(dw_1.getitemstring( k_riga, "contatto_3"))
	kst_tab_contatto4.rag_soc_10 = trim(dw_1.getitemstring( k_riga, "contatto_4"))
	
//--- tabelle Settori e Classi	
	kst_tab_clie_settori.descr = trim(dw_1.getitemstring( k_riga, "settore"))
	kst_tab_clie_classi.id_clie_classe = trim(dw_1.getitemstring( k_riga, "tipo_cliene"))
	if len(kst_tab_clie_classi.id_clie_classe) > 0 then
		kst_tab_clienti.id_clie_classe = kst_tab_clie_classi.id_clie_classe
		choose case kst_tab_clie_classi.id_clie_classe
			case "C1"
				kst_tab_clie_classi.descr = "Cliente storico importanza elevata"
			case "C2"
				kst_tab_clie_classi.descr = "Cliente storico importanza media"
			case "C3"
				kst_tab_clie_classi.descr = "Cliente storico non importante/saltuario"
			case "C4"
				kst_tab_clie_classi.descr = "Cliente nuovo buona potenzialità"
			case "C5"
				kst_tab_clie_classi.descr = "Cliente nuovo scarsa potenzialità"
			case else
				kst_tab_clie_classi.descr = " "
		end choose
	else
		kst_tab_clie_classi.id_clie_classe = ""
		kst_tab_clienti.id_clie_classe = ""
		kst_tab_clie_classi.descr = " "
	end if
	
//--- dati base cliente 	
	kst_tab_clienti.fono = trim(dw_1.getitemstring( k_riga, "fono"))
	kst_tab_clienti.fax = trim(dw_1.getitemstring( k_riga, "fax"))
	choose case  trim(dw_1.getitemstring( k_riga, "stato_cliente"))
		case "A"
			kst_tab_clienti.stato = kuf1_clienti.kki_cliente_stato_attivo
		case "A/P"
			kst_tab_clienti.stato = kuf1_clienti.kki_cliente_stato_attivo_parziale
		case "P"
			kst_tab_clienti.stato = kuf1_clienti.kki_cliente_stato_potenziale_in_contatto
		case else
			kst_tab_clienti.stato = " "
	end choose
	if isnumber(trim(dw_1.getitemstring( k_riga, "stato_cliente"))) then
		kst_tab_clienti.data_attivazione = date(integer(trim(dw_1.getitemstring( k_riga, "stato_cliente"))), 01, 01)
	else
		setnull(kst_tab_clienti.data_attivazione)
	end if
	
//--- UPDATE DB--------------------------------------------------------------------------------------
//--- tab SETTORI CLIENTI
	if  len(trim(kst_tab_clie_settori.descr)) > 0 then
		select 
			id_clie_settore 
			into
			:kst_tab_clie_settori.id_clie_settore
		from clie_settori
		where  descr = :kst_tab_clie_settori.descr
		using sqlca;
		if sqlca.sqlcode = 0 then 
			kst_tab_clienti.id_clie_settore = kst_tab_clie_settori.id_clie_settore
		else
			kst_tab_clienti.id_clie_settore = ""
		end if
	end if

//--- CLIENTI:
	select 
		fono 
		,fax
		,stato
		,data_attivazione
		,id_clie_classe
		,id_clie_settore
		into
		:kst_tab_clienti_r.fono 
		,:kst_tab_clienti_r.fax
		,:kst_tab_clienti_r.stato
		,:kst_tab_clienti_r.data_attivazione
		,:kst_tab_clienti_r.id_clie_classe
		,:kst_tab_clienti.id_clie_settore
	from clienti
	where codice = :kst_tab_clienti.codice 
	using sqlca;
	if sqlca.sqlcode = 0 then 

		if len(trim(kst_tab_clienti_r.fono)) > 0 and len(trim(kst_tab_clienti.fono)) > 0 then 
//--- controllo se numero TELEFONO già caricato
			k_ctr = pos(trim(kst_tab_clienti_r.fono),  kst_tab_clienti.fono, 1)
			if k_ctr = 0 then
				k_tel_r = kuf1_utility.u_stringa_numeri(kst_tab_clienti_r.fono)
				k_tel = kuf1_utility.u_stringa_numeri(kst_tab_clienti.fono)
				if k_tel_r <> k_tel then 
					kst_tab_clienti.fono = trim(kst_tab_clienti_r.fono) + "  " + kst_tab_clienti.fono
				else
					kst_tab_clienti.fono = trim(kst_tab_clienti_r.fono)
				end if
			else
				kst_tab_clienti.fono = trim(kst_tab_clienti_r.fono)
			end if
		else
			if len(trim(kst_tab_clienti_r.fono)) > 0 then
				kst_tab_clienti.fono = trim(kst_tab_clienti_r.fono)
			end if
		end if
		
		if len(trim(kst_tab_clienti_r.fax)) > 0 and len(trim(kst_tab_clienti.fax)) > 0 then 
//--- controllo se numero FAX già caricato
			k_ctr = pos(trim(kst_tab_clienti_r.fax),  kst_tab_clienti.fax, 1)
			if k_ctr = 0 then
				k_tel_r = kuf1_utility.u_stringa_numeri(kst_tab_clienti_r.fax)
				k_tel = kuf1_utility.u_stringa_numeri(kst_tab_clienti.fax)
				if k_tel_r <> k_tel then 
					kst_tab_clienti.fax = trim(kst_tab_clienti_r.fax) + "  " + kst_tab_clienti.fax
				else
					kst_tab_clienti.fax = trim(kst_tab_clienti_r.fax)
				end if
			else
				kst_tab_clienti.fax = trim(kst_tab_clienti_r.fax)
			end if
		else
			if len(trim(kst_tab_clienti_r.fax)) > 0 then
				kst_tab_clienti.fax = trim(kst_tab_clienti_r.fax)
			end if
		end if

		if len(trim(kst_tab_clienti_r.stato)) > 0 then
			kst_tab_clienti.stato = kst_tab_clienti_r.stato
		end if
		if kst_tab_clienti_r.data_attivazione > date(0) then
			kst_tab_clienti.data_attivazione = kst_tab_clienti_r.data_attivazione
		end if
		if len(trim( kst_tab_clienti_r.id_clie_classe)) > 0  then
			kst_tab_clienti.id_clie_classe = kst_tab_clienti_r.id_clie_classe
		end if

		update clienti 
			set fono = :kst_tab_clienti.fono 
			,fax = :kst_tab_clienti.fax
			,stato = :kst_tab_clienti.stato
			,data_attivazione = :kst_tab_clienti.data_attivazione
			,id_clie_classe = :kst_tab_clienti.id_clie_classe

		where codice = :kst_tab_clienti.codice 
		using sqlca;


//--- MKT:
		select 
			cod_atecori 
			,altra_sede
			,tipo_rapporto
			,note_prodotti
			,id_cliente_link
			into
			:kst_tab_clienti_mkt_r.cod_atecori 
			,:kst_tab_clienti_mkt_r.altra_sede
			,:kst_tab_clienti_mkt_r.tipo_rapporto
			,:kst_tab_clienti_mkt_r.note_prodotti
			,:kst_tab_clienti_mkt_r.id_cliente_link
		from clienti_mkt
		where id_cliente = :kst_tab_clienti.codice 
		using sqlca;
		if sqlca.sqlcode = 0 then 
		
			if len(trim(kst_tab_clienti_mkt_r.cod_atecori)) > 0 then
				kst_tab_clienti_mkt.cod_atecori = kst_tab_clienti_mkt_r.cod_atecori
			end if
			if len(trim(kst_tab_clienti_mkt_r.altra_sede)) > 0 then
				kst_tab_clienti_mkt.altra_sede = kst_tab_clienti_mkt_r.altra_sede
			end if
			if len(trim(kst_tab_clienti_mkt_r.tipo_rapporto)) > 0 then
				kst_tab_clienti_mkt.tipo_rapporto = kst_tab_clienti_mkt_r.tipo_rapporto
			end if
			if len(trim(kst_tab_clienti_mkt_r.note_prodotti)) > 0 then
				kst_tab_clienti_mkt.note_prodotti = kst_tab_clienti_mkt_r.note_prodotti
			end if
			if kst_tab_clienti_mkt_r.id_cliente_link > 0 then
				kst_tab_clienti_mkt.id_cliente_link = kst_tab_clienti_mkt_r.id_cliente_link
			end if
		
			update clienti_mkt 
				set cod_atecori = :kst_tab_clienti_mkt.cod_atecori 
				,altra_sede = :kst_tab_clienti_mkt.altra_sede
				,tipo_rapporto = :kst_tab_clienti_mkt.tipo_rapporto
				,note_prodotti = :kst_tab_clienti_mkt.note_prodotti
				,id_cliente_link = :kst_tab_clienti_mkt.id_cliente_link
			where id_cliente = :kst_tab_clienti.codice 
			using sqlca;
			
		else
			insert into clienti_mkt 
				(id_cliente
				,cod_atecori 
				,altra_sede
				,tipo_rapporto
				,note_prodotti
				,id_cliente_link)
				values 
				(:kst_tab_clienti.codice 
				,:kst_tab_clienti_mkt.cod_atecori 
				,:kst_tab_clienti_mkt.altra_sede
				,:kst_tab_clienti_mkt.tipo_rapporto
				,:kst_tab_clienti_mkt.note_prodotti
				,:kst_tab_clienti_mkt.id_cliente_link)
			using sqlca;
		end if	


//--- WEB:
		select 
			email 
			,email1
			,email2
			into
			:kst_tab_clienti_web_r.email 
			,:kst_tab_clienti_web_r.email1
			,:kst_tab_clienti_web_r.email2
		from clienti_web
		where id_cliente = :kst_tab_clienti.codice 
		using sqlca;
		if sqlca.sqlcode = 0 then 
		
			if len(trim(kst_tab_clienti_web_r.email)) > 0 then
				kst_tab_clienti_web.email = kst_tab_clienti_web_r.email
			end if
			if len(trim(kst_tab_clienti_web_r.email1)) > 0 then
				kst_tab_clienti_web.email1 = kst_tab_clienti_web_r.email1
			end if
			if len(trim(kst_tab_clienti_web_r.email2)) > 0 then
				kst_tab_clienti_web.email2 = kst_tab_clienti_web_r.email2
			end if

			update clienti_web 
				set email = :kst_tab_clienti_web.email 
				,email1 = :kst_tab_clienti_web.email1
				,email2 = :kst_tab_clienti_web.email2
			where id_cliente = :kst_tab_clienti.codice 
			using sqlca;
			
		else
			insert into clienti_web 
				(id_cliente
				,email 
				,email1
				,email2)
				values 
				(:kst_tab_clienti.codice 
				,:kst_tab_clienti_web.email 
				,:kst_tab_clienti_web.email1
				,:kst_tab_clienti_web.email2)
			using sqlca;

		end if


	end if
	
next

destroy kuf1_utility

setpointer(kp)

	
end subroutine

on w_import_cvs_crm_anag_old.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_close=create cb_close
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_close,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_import_cvs_crm_anag_old.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_close)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event resize;dw_1.x = 5
dw_1.y = 5

dw_1.width = newwidth - 30

cb_1.y = newheight - cb_1.height - 20
cb_2.y = cb_1.y
cb_3.y = cb_1.y
cb_4.y = cb_1.y
cb_close.y = cb_1.y

dw_1.height = cb_1.y - dw_1.y - 30 

end event

type cb_4 from commandbutton within w_import_cvs_crm_anag_old
integer x = 1504
integer y = 1412
integer width = 613
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recupera ultimo import"
end type

event clicked;//
	dw_1.reset()
	kuf1_data_base.dw_ripri_righe( "*", dw_1)


end event

type cb_3 from commandbutton within w_import_cvs_crm_anag_old
integer x = 1029
integer y = 1412
integer width = 471
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salva import"
end type

event clicked;//
kuf1_data_base.dw_salva_righe( "*", dw_1)

end event

type cb_close from commandbutton within w_import_cvs_crm_anag_old
integer x = 3506
integer y = 1412
integer width = 343
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Chiudi"
end type

event clicked;
//

close(parent)

end event

type cb_2 from commandbutton within w_import_cvs_crm_anag_old
integer x = 2409
integer y = 1412
integer width = 827
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean italic = true
string text = "Aggiorna Archivi M2000"
end type

event clicked;//
if messagebox("Importa Dati in M2000","Sei sicuro di voler procedere",question!, yesno!,2) = 1 then

	aggiorna_db()
	
end if
end event

type cb_1 from commandbutton within w_import_cvs_crm_anag_old
integer x = 151
integer y = 1412
integer width = 741
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Importa CSV Anagrafiche"
end type

event clicked;//
string k_file, k_file_1
int   li_fileid
st_esito kst_esito
//uo_csv_import kuo_cvs_import

 

//li_fileid = GetFileOpenName ("Open", k_file, k_file_1,  "cvs", "Anagrafiche da importare (*.cvs),*.csv ",   "", 512) 
//
//
//if li_fileid > 0 then 
	
	kst_esito = importa_csv()
	messagebox("Fine Elaborazione", kst_esito.sqlerrtext)
//	dw_1.importfile(CSV!, k_file, 2)
	
//	kuo_cvs_import = create uo_csv_import
//	
//	kuo_cvs_import.of_importfile( k_file, dw_1)
//	
//	destroy kuo_cvs_import
	
//end if
end event

type dw_1 from uo_d_std_1 within w_import_cvs_crm_anag_old
boolean visible = true
integer x = 23
integer y = 24
integer width = 3904
integer height = 1320
integer taborder = 10
boolean enabled = true
string dataobject = "d_import_csv_crm_anag"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
end type

