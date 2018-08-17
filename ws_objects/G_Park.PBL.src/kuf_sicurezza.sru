$PBExportHeader$kuf_sicurezza.sru
forward
global type kuf_sicurezza from nonvisualobject
end type
end forward

global type kuf_sicurezza from nonvisualobject
end type
global kuf_sicurezza kuf_sicurezza

forward prototypes
public function st_esito tb_delete_sr_prof_funz (st_tab_sr_prof_funz kst_tab_sr_prof_funz)
public function st_esito tb_delete_sr_prof_utenti (st_tab_sr_prof_utenti kst_tab_sr_prof_utenti)
public function st_esito tb_insert_sr_prof_utenti (st_tab_sr_prof_utenti kst_tab_sr_prof_utenti)
public function st_esito tb_insert_sr_prof_funz (st_tab_sr_prof_funz kst_tab_sr_prof_funz)
public function st_esito tb_delete_sr_profili (st_tab_sr_profili kst_tab_sr_profili)
public function st_esito tb_delete_sr_utenti (st_tab_sr_utenti kst_tab_sr_utenti)
public function st_esito tb_delete_sr_funzioni (st_tab_sr_funzioni kst_tab_sr_funzioni)
public function st_esito tb_update_password (st_tab_sr_utenti kst_tab_sr_utenti)
public function st_esito check_user_password (st_tab_sr_utenti kst_tab_sr_utenti)
public function boolean autorizza_funzione (st_open_w kst_open_w)
end prototypes

public function st_esito tb_delete_sr_prof_funz (st_tab_sr_prof_funz kst_tab_sr_prof_funz);//
//====================================================================
//=== Cancella il rek dalla tabella Associazioni Profili-Funzioni Utenti
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 


	delete from sr_prof_funz
		where id = :kst_tab_sr_prof_funz.id  
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza Profili-Funzioni:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else
				kst_esito.esito = "1"
			end if
		end if
	else
		kst_esito.esito = "0"
	end if





return kst_esito

end function

public function st_esito tb_delete_sr_prof_utenti (st_tab_sr_prof_utenti kst_tab_sr_prof_utenti);//
//====================================================================
//=== Cancella il rek dalla tabella Associazioni Profili-Utenti
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 


	delete from sr_prof_utenti
		where id = :kst_tab_sr_prof_utenti.id  
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza Profili-Utenti:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else
				kst_esito.esito = "1"
			end if
		end if
	else
		kst_esito.esito = "0"
	end if





return kst_esito

end function

public function st_esito tb_insert_sr_prof_utenti (st_tab_sr_prof_utenti kst_tab_sr_prof_utenti);//
//====================================================================
//=== Aggiunge rek nella tabella Associazioni Profili-Utenti
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 


	select id
		 into :kst_tab_sr_prof_utenti.id
		 from sr_prof_utenti
			where id_profili = :kst_tab_sr_prof_utenti.id_profili
			      and id_utenti = :kst_tab_sr_prof_utenti.id_utenti
			using sqlca;

	if sqlca.sqlcode = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Associazione gia' presente nella Tab.Sicurezza Profili-Utenti:~n~r" &
		                       + trim(sqlca.SQLErrText)
		kst_esito.esito = "2"

	else

		kst_tab_sr_prof_utenti.x_datins = kuf1_data_base.prendi_x_datins()
		kst_tab_sr_prof_utenti.x_utente = kuf1_data_base.prendi_x_utente()
		
		INSERT INTO sr_prof_utenti  
				( id,   
				  id_profili,   
				  id_utenti,   
				  x_datins,   
				  x_utente )  
			VALUES ( 0,   
						:kst_tab_sr_prof_utenti.id_profili,   
						:kst_tab_sr_prof_utenti.id_utenti,   
						:kst_tab_sr_prof_utenti.x_datins,   
						:kst_tab_sr_prof_utenti.x_utente )  
			using sqlca;

		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Sicurezza Profili-Utenti:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = "100"
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = "2"
				else
					kst_esito.esito = "1"
				end if
			end if
		else
			commit using sqlca;
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Sicurezza Profili-Utenti:" + trim(sqlca.SQLErrText)
			else
				kst_esito.esito = "0"
			end if
		end if
	end if





return kst_esito

end function

public function st_esito tb_insert_sr_prof_funz (st_tab_sr_prof_funz kst_tab_sr_prof_funz);//
//====================================================================
//=== Aggiunge rek nella tabella Associazioni Profili-Funzioni Utenti
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 


	select id
		 into :kst_tab_sr_prof_funz.id
		 from sr_prof_funz
			where id_profili = :kst_tab_sr_prof_funz.id_profili
			      and id_funzioni = :kst_tab_sr_prof_funz.id_funzioni
			using sqlca;

	if sqlca.sqlcode = 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Associazione gia' presente in Tabella~n~r" &
		                       + "Sicurezza Profili-Funzioni (id=" &
									  + string(kst_tab_sr_prof_funz.id) + ")" &
									  + ":~n~r" &
		                       + trim(sqlca.SQLErrText)
		kst_esito.esito = "2"

	else

		kst_tab_sr_prof_funz.x_datins = kuf1_data_base.prendi_x_datins()
		kst_tab_sr_prof_funz.x_utente = kuf1_data_base.prendi_x_utente()
		
		INSERT INTO sr_prof_funz  
				( id,   
				  id_profili,   
				  id_funzioni,   
				  x_datins,   
				  x_utente )  
			VALUES ( 0,   
						:kst_tab_sr_prof_funz.id_profili,   
						:kst_tab_sr_prof_funz.id_funzioni,   
						:kst_tab_sr_prof_funz.x_datins,   
						:kst_tab_sr_prof_funz.x_utente )  
			using sqlca;

		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Sicurezza Profili-Funzioni:" + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = "100"
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = "2"
				else
					kst_esito.esito = "1"
				end if
			end if
		else
			commit using sqlca;
			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Sicurezza Profili-Funzioni:" + trim(sqlca.SQLErrText)
			else
				kst_esito.esito = "0"
			end if
		end if
	end if




return kst_esito

end function

public function st_esito tb_delete_sr_profili (st_tab_sr_profili kst_tab_sr_profili);//
//====================================================================
//=== Cancella il rek dalla tabella Sicurezza Utenti
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

declare c_prof_utenti cursor for
	select id
		from sr_prof_utenti
		where id_profili = :kst_tab_sr_profili.id ;
declare c_prof_funzioni cursor for
	select id
		from sr_prof_funz
		where id_profili = :kst_tab_sr_profili.id ;

		
open c_prof_utenti;
if sqlca.sqlcode = 0 then
	fetch c_prof_utenti into :k_id;
	if sqlca.sqlcode = 0 then
		k_rek_ok = 1
	end if
	close c_prof_utenti;
else
	open c_prof_funzioni;
	if sqlca.sqlcode = 0 then
		fetch c_prof_funzioni into :k_id;
		if sqlca.sqlcode = 0 then
			k_rek_ok = 1
		end if
		close c_prof_funzioni;
	end if
end if
	
if k_rek_ok = 1 then
	messagebox("Cancellazione Profilo: " + trim(kst_tab_sr_profili.nome) + &
	      "non consentita",&
			"Profilo ancora associato a Utenti e/o Funzioni~n~r" + &
			"Occorre prima cancellare tutte le associazioni ancora presenti"  &
			, stopsign!, ok!) 
	kst_esito.esito = "2"
	kst_esito.SQLErrText = "Tab.Sicurezza-Profili, elaborazione non Consentita: codice associato a Utenti/Funzioni" 
else

	delete from sr_profili
		where id = :kst_tab_sr_profili.id  
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza-Profili:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else
				kst_esito.esito = "1"
			end if
		end if
	else
		kst_esito.esito = "0"
	end if


end if



return kst_esito

end function

public function st_esito tb_delete_sr_utenti (st_tab_sr_utenti kst_tab_sr_utenti);//
//====================================================================
//=== Cancella il rek dalla tabella Sicurezza Utenti
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

declare c_prof_utenti cursor for
	select id
		from sr_prof_utenti
		where id_utenti = :kst_tab_sr_utenti.id ;

		
open c_prof_utenti;
if sqlca.sqlcode = 0 then
	fetch c_prof_utenti into :k_id;
	if sqlca.sqlcode = 0 then
		k_rek_ok = 1
	end if
	close c_prof_utenti;
end if
	
if k_rek_ok = 1 then
	messagebox("Cancellazione Utente: " + trim(kst_tab_sr_utenti.nome) + &
	      "non consentita",&
			"Utente ancora presente nei Profili~n~r" + &
			"Occorre prima cancellare tutte le associazioni ancora presenti"  &
			, stopsign!, ok!) 
	kst_esito.esito = "2"
	kst_esito.SQLErrText = "Tab.Sicurezza-Utenti, elaborazione non Consentita: codice ancora presente tra i Profili" 
else

	delete from sr_utenti
		where id = :kst_tab_sr_utenti.id  
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza-Utenti:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else
				kst_esito.esito = "1"
			end if
		end if
	else
		kst_esito.esito = "0"
	end if


end if



return kst_esito

end function

public function st_esito tb_delete_sr_funzioni (st_tab_sr_funzioni kst_tab_sr_funzioni);//
//====================================================================
//=== Cancella il rek dalla tabella Sicurezza Funzioni
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

declare c_prof_funz cursor for
	select id
		from sr_prof_funz
		where id_funzioni = :kst_tab_sr_funzioni.id ;

		
open c_prof_funz;
if sqlca.sqlcode = 0 then
	fetch c_prof_funz into :k_id;
	if sqlca.sqlcode = 0 then
		k_rek_ok = 1
	end if
	close c_prof_funz;
end if
	
if k_rek_ok = 1 then
	messagebox("Cancellazione Funzione: " + trim(kst_tab_sr_funzioni.nome) + &
	      "non consentita",&
			"Il Codice e' ancora presente nei Profili Utenti~n~r" + &
			"Occorre prima cancellare tutte le associazioni ancora presenti"  &
			, stopsign!, ok!) 
	kst_esito.esito = "2"
	kst_esito.SQLErrText = "Tab.Sicurezza-Funzioni, elaborazione non Consentita: codice ancora in Profili Utenti" 
else

	delete from sr_funzioni
		where id = :kst_tab_sr_funzioni.id  
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza-Funzioni:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else
				kst_esito.esito = "1"
			end if
		end if
	else
		kst_esito.esito = "0"
	end if


end if



return kst_esito

end function

public function st_esito tb_update_password (st_tab_sr_utenti kst_tab_sr_utenti);//
//====================================================================
//=== Aggiunge rek nella tabella Associazioni Profili-Utenti
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

integer k_sn=0
int k_rek_ok=0
long k_id
st_esito kst_esito
kuf_cripta kuf1_cripta


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""

//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 


//	select id
//		 into :kst_tab_sr_prof_utenti.id
//		 from sr_prof_utenti
//			where id_profili = :kst_tab_sr_prof_utenti.id_profili
//			      and id_utenti = :kst_tab_sr_prof_utenti.id_utenti
//			using sqlca;
//
//	if sqlca.sqlcode = 0 then
//		kst_esito.sqlcode = sqlca.sqlcode
//		kst_esito.SQLErrText = "Associazione gia' presente nella Tab.Sicurezza Profili-Utenti:~n~r" &
//		                       + trim(sqlca.SQLErrText)
//		kst_esito.esito = "2"
//
//	else

	kst_tab_sr_utenti.x_datins = kuf1_data_base.prendi_x_datins()
	kst_tab_sr_utenti.x_utente = kuf1_data_base.prendi_x_utente()

	if isnull(kst_tab_sr_utenti.password) then
		kst_tab_sr_utenti.password = " "
	else
		if len(trim(kst_tab_sr_utenti.password)) > 0 then
			kuf1_cripta = create kuf_cripta
			kst_tab_sr_utenti.password = trim(kuf1_cripta.of_set (trim(kst_tab_sr_utenti.password)))
			destroy kuf1_cripta
		end if
	end if
	
	update sr_utenti  
			set password = :kst_tab_sr_utenti.password,  
			    x_datins = :kst_tab_sr_utenti.x_datins,   
			    x_utente = :kst_tab_sr_utenti.x_utente  
		where id = :kst_tab_sr_utenti.id
		using sqlca;

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza Utenti:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "2"
			else
				kst_esito.esito = "1"
			end if
		end if
	else
		commit using sqlca;
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Sicurezza Utenti:" + trim(sqlca.SQLErrText)
		else
			kst_esito.esito = "0"
		end if
	end if


	



return kst_esito

end function

public function st_esito check_user_password (st_tab_sr_utenti kst_tab_sr_utenti);//
//=== 
//=== ESITO:       '0'=accesso ok; 
//                 '1'=utente inesistente; 
//						 '2'=password errata; 
//						 '3'=utente disattivato
//                 '9'=errore DB; 
//
//
//====================================================================
//=== Controlla la Utente e Password 
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0
//=== 
//====================================================================

string k_codice_up, k_codice_lo
st_esito kst_esito
st_tab_sr_utenti kst_tab_sr_utenti_1 
kuf_cripta kuf1_cripta


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

	k_codice_up = upper(kst_tab_sr_utenti.codice)
	k_codice_lo = lower(kst_tab_sr_utenti.codice)

	SELECT password, nome, stato
    INTO :kst_tab_sr_utenti_1.password
	      ,:kst_tab_sr_utenti_1.nome
	      ,:kst_tab_sr_utenti_1.stato
    FROM sr_utenti  
	 where codice = :k_codice_up or codice = :k_codice_lo
	 using sqlca;

	if sqlca.sqlcode = 0 then
		if kst_tab_sr_utenti_1.stato = "0" then
			
			if len(trim(kst_tab_sr_utenti_1.password)) > 0 then

//--- decripta la password				
				kuf1_cripta = create kuf_cripta
				kst_tab_sr_utenti_1.password = kuf1_cripta.of_decrypt(trim(kst_tab_sr_utenti_1.password))
				destroy kuf1_cripta
				
				if upper(trim(kst_tab_sr_utenti_1.password)) <> upper(trim(kst_tab_sr_utenti.password)) then
					kst_esito.esito = "2"
					if len(trim(kst_tab_sr_utenti.password)) = 0 then
						kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: digitare la Password " 
					else
						kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: digitata Password errata " 
					end if
				end if
				
			end if
			
		else
			kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Utente non Abilitato, contattare l'amministratore " 
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
			kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Utente " &
	 		                       + kst_tab_sr_utenti_1.codice + " non Trovato"
		else
			kst_esito.esito = "1"
			kst_esito.SQLErrText = "Tab.Sicurezza-Utenti non accessibile:" + trim(sqlca.SQLErrText)
		end if
	end if
	
return kst_esito


end function

public function boolean autorizza_funzione (st_open_w kst_open_w);//
//
//=== Controlla se funzione Autorizzata o meno 
//
boolean k_return = false
long k_ctr, k_ctr_idx




k_ctr = 1
k_ctr_idx = UpperBound(kstG_tab_menu_window[])
do while k_ctr <= k_ctr_idx 
	if trim(kst_open_w.id_programma) = trim(kstG_tab_menu_window[k_ctr].id) then
		exit
	end if
	k_ctr++
loop

if k_ctr <= k_ctr_idx then

	choose case kst_open_w.flag_modalita
			
		case kkg_flag_modalita_cancellazione
			k_ctr = pos ( upper(kstG_tab_menu_window[k_ctr].funzioni), "C" )
		case kkg_flag_modalita_elenco
			k_ctr = pos ( upper(kstG_tab_menu_window[k_ctr].funzioni), "E" )
		case kkg_flag_modalita_inserimento
			k_ctr = pos ( upper(kstG_tab_menu_window[k_ctr].funzioni), "I" )
		case kkg_flag_modalita_modifica
			k_ctr = pos ( upper(kstG_tab_menu_window[k_ctr].funzioni), "M" )
		case kkg_flag_modalita_visualizzazione
			k_ctr = pos ( upper(kstG_tab_menu_window[k_ctr].funzioni), "V" )
		case kkg_flag_modalita_chiudi_pl
			k_ctr = pos ( upper(kstG_tab_menu_window[k_ctr].funzioni), "P" )
		
	end choose

	if k_ctr > 0 then
		k_return = true
	end if

end if


return k_return

end function
on kuf_sicurezza.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_sicurezza.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

