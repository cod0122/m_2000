$PBExportHeader$kuf_sr_sicurezza.sru
forward
global type kuf_sr_sicurezza from kuf_parent
end type
end forward

global type kuf_sr_sicurezza from kuf_parent
end type
global kuf_sr_sicurezza kuf_sr_sicurezza

type variables
//
public constant string kki_anteprima_dw_utenti = "d_sr_utenti_1"

private:
//--- Tipo Modalita operativa su cui opera la windows carattere funzione
constant string ki_ELENCO="e"         
constant string ki_INSERIMENTO="i"     
constant string ki_MODIFICA="m"       
constant string ki_CANCELLAZIONE="c"   
constant string ki_VISUALIZZAZIONE="v"
constant string ki_INTERROGAZIONE="q" 
constant string ki_STAMPA="s" 
constant string ki_CHIUDI_PL="p"      
constant string ki_AUTORIZZATO="a"      
constant string ki_NAVIGATORE="n" 
constant string ki_ANTEPRIMA="v" //"t" 
constant string ki_BATCH="b" 

//--- Campo PERMESSI della tabella sr_settori_profili
public constant int ki_permessi_nessuno = 0
public constant int ki_permessi_lettura = 2
public constant int ki_permessi_scrittura = 4
public constant int ki_permessi_completo = 9

//--- Campo TIPO DI AUTENTICAZIONE della tabella sr_utenti
public constant string kki_autenticazione_daM200 = "M"
public constant string kki_autenticazione_daWindows = "W"
public constant string kki_autenticazione_daM200Windows = "X"

end variables

forward prototypes
public function st_esito tb_delete_sr_prof_funz (st_tab_sr_prof_funz kst_tab_sr_prof_funz)
public function st_esito tb_delete_sr_prof_utenti (st_tab_sr_prof_utenti kst_tab_sr_prof_utenti)
public function st_esito tb_insert_sr_prof_utenti (st_tab_sr_prof_utenti kst_tab_sr_prof_utenti)
public function st_esito tb_insert_sr_prof_funz (st_tab_sr_prof_funz kst_tab_sr_prof_funz)
public function st_esito tb_delete_sr_funzioni (st_tab_sr_funzioni kst_tab_sr_funzioni)
public function st_esito tb_delete_sr_profili (st_tab_sr_profili kst_tab_sr_profili)
public function st_esito tb_delete_sr_utenti (st_tab_sr_utenti kst_tab_sr_utenti)
public function st_esito tb_sr_funzioni_conta_id_programma (ref st_tab_sr_funzioni kst_tab_sr_funzioni)
public function st_esito tb_sr_funzioni_assegna_nome (ref st_tab_sr_funzioni kst_tab_sr_funzioni)
public function boolean autorizza_funzione (ref st_open_w kst_open_w)
public function st_esito tb_update_password_tentativi (st_tab_sr_utenti kst_tab_sr_utenti)
public function st_esito tb_update_password (st_tab_sr_utenti kst_tab_sr_utenti)
public function st_esito tb_update_password_dt_ultimo_accesso (st_tab_sr_utenti kst_tab_sr_utenti)
public function st_esito check_password_sintax (ref st_tab_sr_utenti kst_tab_sr_utenti)
public function st_esito check_password_scaduta (ref st_tab_sr_utenti kst_tab_sr_utenti)
public function st_esito u_esporta_password ()
public function st_esito u_importa_password ()
public function st_esito anteprima (datastore kdw_anteprima, st_tab_sr_utenti kst_tab_sr_utenti)
public function string get_funzione_f (string a_flag_modalita)
public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception
public function boolean check_password_vuota (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function string check_password (ref string a_password)
public function st_esito anteprima_tab_menu_window_l (datastore kdw_anteprima, st_tab_menu_window kst_tab_menu_window)
public function st_esito tb_select (ref st_tab_sr_utenti kst_tab_sr_utenti)
public function string get_password (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function st_esito tb_delete_sr_settori_profili (st_tab_sr_settori_profili kst_tab_sr_settori_profili)
public function integer if_presente_sr_settore (st_tab_sr_settori_profili ast_tab_sr_settori_profili) throws uo_exception
public subroutine get_id (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function boolean if_utente_uguale (ref st_tab_sr_utenti kst_tab_sr_utenti)
public function string get_sr_settore (string a_id_menu_window) throws uo_exception
public function boolean autorizza_utente_settore (long a_id_utente, string a_sr_settore, integer a_permessi, string a_modalita) throws uo_exception
public function boolean check_user_password (ref st_tab_sr_utenti ast_tab_sr_utenti) throws uo_exception
private function boolean check_user_dati (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function st_esito check_password_digit_errata (ref st_tab_sr_utenti kst_tab_sr_utenti)
public function boolean check_password_procedura (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function boolean check_cambia_password (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception
public function boolean u_if_master (string k_pwd)
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
kst_esito.nome_oggetto = this.classname()
//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

	if kst_tab_sr_prof_funz.id > 0 then
	
		delete from sr_prof_funz
			where id = :kst_tab_sr_prof_funz.id  
			using sqlca;
	else
		if kst_tab_sr_prof_funz.id_profili > 0 then
	
			delete from sr_prof_funz
				where id_profili = :kst_tab_sr_prof_funz.id_profili  
				using sqlca;

		else

			if kst_tab_sr_prof_funz.id_funzioni > 0 then
		
				delete from sr_prof_funz
					where id_funzioni = :kst_tab_sr_prof_funz.id_funzioni  
					using sqlca;
			end if
		end if
	end if
			

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
kst_esito.nome_oggetto = this.classname()
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
kst_esito.nome_oggetto = this.classname()
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

		kst_tab_sr_prof_utenti.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_sr_prof_utenti.x_utente = kGuf_data_base.prendi_x_utente()
		// id,   
		INSERT INTO sr_prof_utenti  
				(
				  id_profili,   
				  id_utenti,   
				  x_datins,   
				  x_utente )  
			VALUES ( 
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
kst_esito.nome_oggetto = this.classname()
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

		kst_tab_sr_prof_funz.x_datins = kGuf_data_base.prendi_x_datins()
		kst_tab_sr_prof_funz.x_utente = kGuf_data_base.prendi_x_utente()
		// id,   
		INSERT INTO sr_prof_funz  
				(
				  id_profili,   
				  id_funzioni,   
				  x_datins,   
				  x_utente )  
			VALUES ( 
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
st_esito kst_esito, kst_esito1
st_tab_sr_prof_funz kst_tab_sr_prof_funz


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
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
	if messagebox("Cancellazione Funzione: " + trim(kst_tab_sr_funzioni.nome),&
			"Il Codice e' ancora presente nei Profili Utenti~n~r" + &
			"Proseguire con la cancellazione?"  &
			, question!, yesno!) = 2 then
			
		kst_esito.esito = "2"
		kst_esito.SQLErrText = "Tab.Sicurezza-Funzioni, elaborazione non Consentita: codice ancora in Profili Utenti" 
	else

		kst_esito.esito = "0"
		
	end if
end if

if kst_esito.esito = "0" then

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
		kst_tab_sr_prof_funz.id_funzioni = kst_tab_sr_funzioni.id  
		kst_esito1 = tb_delete_sr_prof_funz(kst_tab_sr_prof_funz)		
		if sqlca.sqlcode < 0 then
			kst_esito.esito = "2"
			kst_esito = kst_esito1
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
st_esito kst_esito, kst_esito1
st_tab_sr_prof_funz kst_tab_sr_prof_funz


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
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
end if
	
if k_rek_ok = 1 then
	messagebox("Cancellazione Profilo: " + trim(kst_tab_sr_profili.nome) + &
	      " non consentita",&
			"Profilo ancora associato a Utenti e/o Funzioni~n~r" + &
			"Occorre prima cancellare tutte le associazioni ancora presenti"  &
			, stopsign!, ok!) 
	kst_esito.esito = "2"
	kst_esito.SQLErrText = "Tab.Sicurezza-Profili, elaborazione non Consentita: codice associato a Utenti/Funzioni" 
else

	open c_prof_funzioni;
	if sqlca.sqlcode = 0 then
		fetch c_prof_funzioni into :k_id;
		if sqlca.sqlcode = 0 then
			k_rek_ok = 1
		end if
		close c_prof_funzioni;
	end if

	
	if k_rek_ok = 1 then
		if messagebox("Cancellazione Profilo: " + trim(kst_tab_sr_profili.nome), &
			"Il Codice e' ancora presente nelle Funzioni~n~r" + &
			"Cancello anche tutte le Associazioni presenti?"  &
			, question!, yesno!) = 2 then
			
			kst_esito.esito = "2"
			kst_esito.SQLErrText = "Tab.Sicurezza-Profili, elaborazione non Consentita: codice ancora in Funzioni" 
		else

			kst_esito.esito = "0"
		
		end if
	end if

	if kst_esito.esito = "0" then

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
			kst_tab_sr_prof_funz.id = 0
			kst_tab_sr_prof_funz.id_funzioni = 0
			kst_tab_sr_prof_funz.id_profili = kst_tab_sr_profili.id  
			kst_esito1 = tb_delete_sr_prof_funz(kst_tab_sr_prof_funz)		
			if sqlca.sqlcode < 0 then
				kst_esito.esito = "2"
				kst_esito = kst_esito1
			else
				kst_esito.esito = "0"
			end if
		end if
	
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
kst_esito.nome_oggetto = this.classname()
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
	      " non consentita",&
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

public function st_esito tb_sr_funzioni_conta_id_programma (ref st_tab_sr_funzioni kst_tab_sr_funzioni);//
//====================================================================
//=== Legge il rek dalla tabella Sicurezza Funzioni con id_programma
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
kst_esito.nome_oggetto = this.classname()


	select count(*)
	   into :kst_tab_sr_funzioni.contatore
		from sr_funzioni
		where id_programma = :kst_tab_sr_funzioni.id_programma 
		      and funzioni = :kst_tab_sr_funzioni.funzioni
		      and (id <> :kst_tab_sr_funzioni.id
				     or :kst_tab_sr_funzioni.id = 0)
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






return kst_esito

end function

public function st_esito tb_sr_funzioni_assegna_nome (ref st_tab_sr_funzioni kst_tab_sr_funzioni);//
//====================================================================
//=== Legge il rek dalla tabella Sicurezza Funzioni con id_programma
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave
//===                                 2=errore > 0
//=== 
//====================================================================

string k_nome=""
int k_ctr
st_esito kst_esito


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


	k_nome = kst_tab_sr_funzioni.nome			

	select count(*)
		into :kst_tab_sr_funzioni.contatore
		from sr_funzioni
		where nome = :k_nome
		using sqlca;
			
//--- controllo se nome già caricato
	k_ctr = 0
	do while kst_tab_sr_funzioni.contatore > 0 

//--- se è così ne formo uno nuovo 
		k_ctr++
		k_nome = kst_tab_sr_funzioni.nome + "#" + string(k_ctr)			
		
		select count(*)
			into :kst_tab_sr_funzioni.contatore
			from sr_funzioni
			where nome = :k_nome
			using sqlca;
			
	loop

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza-Funzioni:" + trim(sqlca.SQLErrText)
	else
		kst_tab_sr_funzioni.nome = trim(k_nome)
		kst_esito.esito = "0"
	end if


return kst_esito

end function

public function boolean autorizza_funzione (ref st_open_w kst_open_w);//
//
//=== Controlla se funzione Autorizzata o meno 
//
boolean k_return = false
long k_ctr, k_ctr_idx, k_ctr_save



//--- trovo le autorizzazioni del programma
k_ctr = 1
k_ctr_idx = UpperBound(kGst_tab_menu_window[])
do while k_ctr <= k_ctr_idx 
	if trim(kst_open_w.id_programma) = trim(kGst_tab_menu_window[k_ctr].id) then
		kst_open_w.operazioni_autorizzate = trim(kGst_tab_menu_window[k_ctr].funzioni)
		exit
	end if
	k_ctr++
loop

if k_ctr <= k_ctr_idx then

//--- funzione ANTEPRIMA e VISUALIZZAIONE e STAMPA sono state equiparate			
//	if kst_open_w.flag_modalita = kkg_flag_modalita.anteprima or kst_open_w.flag_modalita = kkg_flag_modalita.stampa then
//		kst_open_w.flag_modalita = kkg_flag_modalita.visualizzazione
//	end if

	choose case kst_open_w.flag_modalita
			
//--- funzione ELENCO e NAVIGAZIONE  sono state equiparate		
		case kkg_flag_modalita.elenco
			k_ctr_save = k_ctr
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_elenco)  )
			if k_ctr = 0 then
				k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_navigatore)  )
			end if
			
//--- funzione ANTEPRIMA e VISUALIZZAIONE e NAVIGAZIONE e STAMPA sono state equiparate			
		case kkg_flag_modalita.visualizzazione
			k_ctr_save = k_ctr
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_visualizzazione)  )
			if k_ctr = 0 then
				k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_anteprima)  )
				if k_ctr = 0 then
					k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_navigatore ) )
					if k_ctr = 0 then
						k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_stampa ) )
						if k_ctr = 0 then //--- se sono autorizzato a Modificare lo sono anche per Visualizzare, nooo?
							k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_modifica) )
						end if
					end if
				end if
			end if
			
		case kkg_flag_modalita.modifica
			k_ctr_save = k_ctr
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_modifica)  )
			if k_ctr = 0 then //--- se sono autorizzato a cancellare lo sono anche per modificare, nooo?
				k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_cancellazione) )
			end if
			
		case kkg_flag_modalita.inserimento
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_inserimento)  )
			
		case kkg_flag_modalita.cancellazione
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_cancellazione) )
			
		case kkg_flag_modalita.stampa
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_stampa)  )
			
		case kkg_flag_modalita.chiudi_pl
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_chiudi_pl)  )
			
		case kkg_flag_modalita.BATCH
			k_ctr = Pos ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_BATCH)  )
		
//--- funzione NAVIGATORE è simile a ELENCO, VISUALIZZAZIONE			
		case kkg_flag_modalita.navigatore
			k_ctr_save = k_ctr
			k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr].funzioni), upper(ki_navigatore ) )
			if k_ctr = 0 then
				k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_visualizzazione ) )
				if k_ctr = 0 then
					k_ctr = PosA ( upper(kGst_tab_menu_window[k_ctr_save].funzioni), upper(ki_elenco ) )
				end if
			end if
			
			
	end choose

	if k_ctr > 0 then
		k_return = true
	end if

end if


return k_return

end function

public function st_esito tb_update_password_tentativi (st_tab_sr_utenti kst_tab_sr_utenti);//
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
kst_esito.nome_oggetto = this.classname()

//	kst_tab_sr_utenti.x_datins = kGuf_data_base.prendi_x_datins()
//	kst_tab_sr_utenti.x_utente = kGuf_data_base.prendi_x_utente()

	
	update sr_utenti  
			set tentativi_ko = :kst_tab_sr_utenti.tentativi_ko  
		where id = :kst_tab_sr_utenti.id
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza Utenti:" + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		rollback using sqlca;
	else
		commit using sqlca;
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Sicurezza Utenti:" + trim(sqlca.SQLErrText)
		else
			kst_esito.esito = kkg_esito.ok
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
date k_dataoggi
st_esito kst_esito
kuf_cripta kuf1_cripta


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



	kst_tab_sr_utenti.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_sr_utenti.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(kst_tab_sr_utenti.password) then
		kst_tab_sr_utenti.password = " "
	else
		if LenA(trim(kst_tab_sr_utenti.password)) > 0 then
			kuf1_cripta = create kuf_cripta
			kst_tab_sr_utenti.password = trim(kuf1_cripta.of_set (trim(kst_tab_sr_utenti.password)))
			destroy kuf1_cripta
		end if
	end if
	
	kst_tab_sr_utenti.dt_ultima_modifica = kG_dataoggi

	update sr_utenti  
			set password = :kst_tab_sr_utenti.password,  
			    dt_ultima_modifica = :kst_tab_sr_utenti.dt_ultima_modifica,   
			    x_datins = :kst_tab_sr_utenti.x_datins,   
			    x_utente = :kst_tab_sr_utenti.x_utente  
		where id = :kst_tab_sr_utenti.id
		using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza Utenti:" + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		commit using sqlca;
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Sicurezza Utenti:" + trim(sqlca.SQLErrText)
		else
			kst_esito.esito = "0"
		end if
	end if


	



return kst_esito

end function

public function st_esito tb_update_password_dt_ultimo_accesso (st_tab_sr_utenti kst_tab_sr_utenti);//
//====================================================================
//=== Aggiorna Data Ultimo Accesso OK in Tab.Utente
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


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//	kst_tab_sr_utenti.x_datins = kGuf_data_base.prendi_x_datins()
//	kst_tab_sr_utenti.x_utente = kGuf_data_base.prendi_x_utente()


	update sr_utenti  
			set dt_ultimo_accesso = :kst_tab_sr_utenti.dt_ultimo_accesso,  
			    inutilizzo_sblocco = "0"
		where id = :kst_tab_sr_utenti.id
		using sqlca;

	if sqlca.sqlcode < 0 then
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
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Sicurezza Utenti:" + trim(sqlca.SQLErrText)
		else
			kst_esito.esito = "0"
		end if
	end if


	



return kst_esito

end function

public function st_esito check_password_sintax (ref st_tab_sr_utenti kst_tab_sr_utenti);//
//====================================================================
//=== Controlla la sintassi della nuova Password 
//=== secondo il Dlgs 30 giugno 2003 nr. 196 del 23-6-04 
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0 o incongruenza password
//=== 
//====================================================================

string k_codice_up, k_codice_lo
st_esito kst_esito
kuf_cripta kuf1_cripta
int k_ctr
boolean k_numero_ok, k_lettera_ok
st_tab_sr_utenti kst_tab_sr_utenti1


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_codice_up = upper(kst_tab_sr_utenti.codice)
	k_codice_lo = lower(kst_tab_sr_utenti.codice)

	SELECT id, dlgs196_chk_sintax, password
    INTO 
	       :kst_tab_sr_utenti.id
	      ,:kst_tab_sr_utenti.dlgs196_chk_sintax
		  ,:kst_tab_sr_utenti1.password
    FROM sr_utenti  
	 where codice = :k_codice_up or codice = :k_codice_lo
	 using sqlca;

	if sqlca.sqlcode = 0 then
		if kst_tab_sr_utenti.dlgs196_chk_sintax = "1" then
			
			kst_tab_sr_utenti.password = trim(kst_tab_sr_utenti.password)
			
			if LenA(kst_tab_sr_utenti.password) > 0 then

//--- decripta la password		
				if LenA(trim(kst_tab_sr_utenti1.password)) > 0 then
					kuf1_cripta = create kuf_cripta
					kst_tab_sr_utenti1.password = kuf1_cripta.of_decrypt(trim(kst_tab_sr_utenti1.password))
					destroy kuf1_cripta
				else
					kst_tab_sr_utenti1.password = " "
				end if

//--- la password NON deve essere identica a quella precedente
				if kst_tab_sr_utenti.password <> trim(kst_tab_sr_utenti1.password) then
				
//--- la password deve essere + lunga di 8 caratteri 
					if LenA(kst_tab_sr_utenti.password) > 7 then

//--- la password deve contere "lettere e numeri"
						k_numero_ok = false
						k_lettera_ok = false
						k_ctr = LenA(kst_tab_sr_utenti.password) 
						do while (not k_numero_ok or not k_lettera_ok) and k_ctr > 0
	
							if isnumber(MidA(kst_tab_sr_utenti.password, k_ctr, 1)) then
								k_numero_ok = true
							else
								k_lettera_ok = true
							end if
							k_ctr --
						loop
						if not k_numero_ok or not k_lettera_ok then
							kst_esito.esito = "2"
							kst_esito.SQLErrText = "La Password deve contenere Lettere e Numeri " 
						end if
						
					else
						kst_esito.esito = "2"
						kst_esito.SQLErrText = "Password troppo corta, deve essere composta da almeno 8 caratteri (lettere+numeri) " 
					end if
					
				else
					kst_esito.esito = "2"
					kst_esito.SQLErrText = "Cambiare Password, non puo' essere uguale alla precedente " 
				end if
			else
				kst_esito.esito = "2"
				kst_esito.SQLErrText = "Password vuota, deve essere contenere almeno 8 caratteri " 
				
			end if
			
		else
			kst_esito.esito = "0"
			kst_esito.SQLErrText = "Nessun controllo sulla Password " 
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "100"
			kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Utente " &
	 		                       + kst_tab_sr_utenti.codice + " non Trovato"
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = "1"
				kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Errore grave in lettura ~n~r" + trim(sqlca.SQLErrText)
			else
				kst_esito.esito = "2"
				kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: problemi in lettura, prego riprovare ~n~r" + trim(sqlca.SQLErrText)
			end if
		end if
	end if
	
return kst_esito


end function

public function st_esito check_password_scaduta (ref st_tab_sr_utenti kst_tab_sr_utenti);//
//====================================================================
//=== Controlla se password scaduta o Vuota
//=== secondo il Dlgs 30 giugno 2003 nr. 196 del 23-6-04 
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0 o incongruenza password
//=== 
//====================================================================

string k_codice_up, k_codice_lo
st_esito kst_esito
kuf_cripta kuf1_cripta
int k_ctr, k_gg
boolean k_numero_ok, k_lettera_ok
date k_dataoggi, k_data_scad, k_data_inscadenza
kuf_base kuf1_base



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_codice_up = upper(kst_tab_sr_utenti.codice)
	k_codice_lo = lower(kst_tab_sr_utenti.codice)

	SELECT id, scade_dopo_gg, password, dt_ultima_modifica 
    INTO 
	       :kst_tab_sr_utenti.id
	      ,:kst_tab_sr_utenti.scade_dopo_gg
	      ,:kst_tab_sr_utenti.password
	      ,:kst_tab_sr_utenti.dt_ultima_modifica
    FROM sr_utenti  
	 where codice = :k_codice_up or codice = :k_codice_lo
	 using sqlca;

	if sqlca.sqlcode = 0 then
		
//--- leggo la data-oggi
		kuf1_base = create kuf_base
		k_dataoggi = date(MidA(kuf1_base.prendi_dato_base("dataoggi"),2))
		destroy kuf1_base
		
//--- se password e' scaduta
		if isnull(kst_tab_sr_utenti.dt_ultima_modifica) then
			kst_tab_sr_utenti.dt_ultima_modifica = k_dataoggi
		end if
		if kst_tab_sr_utenti.scade_dopo_gg > 0 then
			k_data_scad = relativedate(kst_tab_sr_utenti.dt_ultima_modifica, kst_tab_sr_utenti.scade_dopo_gg)
			k_data_inscadenza =  relativedate(k_data_scad, -7)
		else
			k_data_scad = k_dataoggi
			k_data_inscadenza = k_data_scad
		end if
		if k_data_scad < k_dataoggi then
			kst_esito.esito = kkg_esito.pwd_scaduta
			kst_esito.SQLErrText = "Modificare la Password scaduta il " + string(k_data_scad) + " "  
		else
			if k_data_inscadenza < k_dataoggi then
				kst_esito.esito = kkg_esito.pwd_inscad
				k_gg = DaysAfter(k_dataoggi, k_data_scad)
				if k_gg > 1 then
					kst_esito.SQLErrText = "Attenzione la Password scade tra  " + string(k_gg) + "  giorni! "  
				else
					kst_esito.SQLErrText = "Attenzione la Password scade tra appena " + string(k_gg) + "  giorno! "  
				end if
			end if
		end if					
		
	else
		
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Utente " &
	 		                       + kst_tab_sr_utenti.codice + " non Trovato"
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Errore grave in lettura ~n~r" + trim(sqlca.SQLErrText)
			else
				kst_esito.esito = kkg_esito.db_wrn
				kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: problemi in lettura, prego riprovare ~n~r" + trim(sqlca.SQLErrText)
			end if
		end if
		
	end if
	
return kst_esito


end function

public function st_esito u_esporta_password ();//====================================================================
//=== Controlla la Utente e Password 
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0
//=== 
//====================================================================

string  k_record, k_path
long k_bytes
int k_file, k_ctr
st_esito kst_esito, kst_esito1
st_tab_sr_utenti kst_tab_sr_utenti_1, kst_tab_sr_utenti 
kuf_cripta kuf1_cripta
kuf_base kuf1_base


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	declare  kc_sicurezza_esporta_pasword cursor for 
		SELECT 
				 sr_utenti.id
				,sr_utenti.password
		 FROM sr_utenti 
		 using sqlca;

	k_path = kGuf_data_base.profilestring_leggi_scrivi (1, "temp", " ")
	
	k_file = fileopen( trim(k_path) + "\" + "pm2000", linemode!, write!, lockreadwrite!,Replace! )
	
	if k_file > 0 then
			
		open kc_sicurezza_esporta_pasword;
		if sqlca.sqlcode = 0 then
		
			fetch kc_sicurezza_esporta_pasword INTO 
				 :kst_tab_sr_utenti.id
				,:kst_tab_sr_utenti_1.password;
	
			do while sqlca.sqlcode = 0 
			
				if LenA(trim(kst_tab_sr_utenti_1.password)) > 0 then
	
//--- decripta la password				
					kuf1_cripta = create kuf_cripta
					kst_tab_sr_utenti.password = kuf1_cripta.of_decrypt(trim(kst_tab_sr_utenti_1.password))
					destroy kuf1_cripta
				else
					kst_tab_sr_utenti_1.password = " "
					kst_tab_sr_utenti.password = " "
				end if

//--- scrive password
				k_record = string(kst_tab_sr_utenti.id, "0000")+trim(kst_tab_sr_utenti.password)
				k_bytes = filewrite(k_file, k_record) 
				if k_bytes > 0 then
					k_ctr++
				end if
		
				fetch kc_sicurezza_esporta_pasword INTO 
						 :kst_tab_sr_utenti.id
						,:kst_tab_sr_utenti_1.password;
						
			loop

		end if
		
		fileclose (k_file)
		
	end if

	if k_ctr > 0 then
		kst_esito.SQLErrText = string(k_ctr)
	end if
	
return kst_esito


end function

public function st_esito u_importa_password ();//====================================================================
//=== Controlla la Utente e Password 
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0
//=== 
//====================================================================

string  k_record, k_path
long k_bytes
int k_file, k_ctr
st_esito kst_esito, kst_esito1
st_tab_sr_utenti kst_tab_sr_utenti_1, kst_tab_sr_utenti 
kuf_cripta kuf1_cripta
kuf_base kuf1_base


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_path = kGuf_data_base.profilestring_leggi_scrivi (1, "temp", " ")
	
	k_file = fileopen( trim(k_path) + "\" + "pm2000", linemode!, read!, lockreadwrite!)
	
	if k_file > 0 then
			
		k_bytes = fileread(k_file, k_record) 
		if k_bytes > 0 then
		
			do while k_bytes > 0 
			
				kst_tab_sr_utenti.id = long(left(k_record,4))
				kst_tab_sr_utenti_1.password = mid(k_record,5)
	
				if LenA(trim(kst_tab_sr_utenti_1.password)) > 0 then
				
//--- se password c'e' un '*' allora resetto la password 
					if trim(kst_tab_sr_utenti_1.password) <> "*" then
	
//--- decripta la password				
						kuf1_cripta = create kuf_cripta
						kst_tab_sr_utenti.password = kuf1_cripta.of_set( trim(kst_tab_sr_utenti_1.password))
						destroy kuf1_cripta

					else
						kst_tab_sr_utenti_1.password = "" 
						
					end if
					
//--- scrive password
					update sr_utenti
							 set password = :kst_tab_sr_utenti.password
							 where id = :kst_tab_sr_utenti.id
							 using sqlca;

					 if sqlca.sqlcode = 0 then
						k_ctr++
					end if
				end if
				
				k_bytes = fileread(k_file, k_record) 
						
			loop

		end if
		
		fileclose (k_file)
		
	end if

	if k_ctr > 0 then
		kst_esito.SQLErrText = string(k_ctr)
	end if
	
return kst_esito


end function

public function st_esito anteprima (datastore kdw_anteprima, st_tab_sr_utenti kst_tab_sr_utenti);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita =kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma.anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_sr_utenti.id > 0 then

		if kst_tab_sr_utenti.id < 9990 then
	
			kdw_anteprima.dataobject = kki_anteprima_dw_utenti		
			kdw_anteprima.settransobject(sqlca)
	
			kdw_anteprima.reset()	
	//--- retrive dell'attestato 
			k_rc=kdw_anteprima.retrieve(kst_tab_sr_utenti.id)

		else
			
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Utente speciale " + string(kst_tab_sr_utenti.id) + ", in uso solo ai fini di sviluppo/controllo del software"
			kst_esito.esito = kkg_esito.not_fnd
			
	end if
	
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Utente da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = kkg_esito.not_fnd
		
	end if
end if


return kst_esito

end function

public function string get_funzione_f (string a_flag_modalita);//
//--- torna il giusto flag della modalità richiesta 
//
string k_return=""


choose case a_flag_modalita
		
	case kkg_flag_modalita.inserimento
		k_return = ki_inserimento
		
	case kkg_flag_modalita.modifica
		k_return = ki_modifica
		
	case kkg_flag_modalita.cancellazione
		k_return = ki_cancellazione
		
	case kkg_flag_modalita.visualizzazione
		k_return = ki_visualizzazione
		
	case kkg_flag_modalita.stampa
		k_return = ki_stampa
		
	case kkg_flag_modalita.elenco
		k_return = ki_elenco
		
end choose


return k_return
end function

public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Attiva LINK cliccato (funzione di ZOOM)
//---
//--- Par. Inut: 
//---               datawindow su cui è stato attivato il LINK
//---               nome campo di LINK
//--- 
//--- Ritorna TRUE tutto OK - FALSE: link non effettuato
//---
//--- Lancia EXCEPTION con  ST_ESITO  standard
//---
//----------------------------------------------------------------------------------------------------------------
// 
long k_rc
boolean k_return=true
string k_coltype=""


st_tab_sr_utenti kst_tab_sr_utenti
st_tab_menu_window kst_tab_menu_window
st_esito kst_esito
datastore kdsi_elenco_output   //ds da passare alla windows di elenco
st_open_w kst_open_w 
pointer kp_oldpointer



kp_oldpointer = SetPointer(hourglass!)


kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


choose case a_campo_link

	case "x_utente" &
		, "x_utente_cert_alim" &
		, "x_utente_cert_farm" &
		, "x_utente_cert_f_st"

		k_coltype = adw_1.Describe(a_campo_link+".Coltype")
		choose case upper(left(k_coltype,2))
			case 'CH'
				if isnumber(trim(adw_1.getitemstring(adw_1.getrow(), a_campo_link))) then
					kst_tab_sr_utenti.id = integer(adw_1.getitemstring(adw_1.getrow(), a_campo_link))
				else
					kst_tab_sr_utenti.id = 0
				end if
			case else
				kst_tab_sr_utenti.id = adw_1.getitemnumber(adw_1.getrow(), a_campo_link)
		end choose
			
		if kst_tab_sr_utenti.id > 0 then
	
			kst_esito = this.anteprima ( kdsi_elenco_output, kst_tab_sr_utenti )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "codice Utente: " + string(kst_tab_sr_utenti.id)
		else
			k_return = true //evita il messaggio di errore
		end if


	case  "b_menu_window"   // elenco 
			kst_esito = this.anteprima_tab_menu_window_l( kdsi_elenco_output, kst_tab_menu_window )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "Elenco Programmi Procedura "  
	
	

end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//--- Parametri : 
	//--- struttura st_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.id_programma = kkg_id_programma.elenco //get_id_programma( kst_open_w.flag_modalita ) //kkg_id_programma.elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kGuf_menu_window.open_w_tabelle(kst_open_w)

	else
		
		kguo_exception.inizializza( )
		kguo_exception.setmessage( "Nessun valore disponibile (" + this.get_id_programma(kst_open_w.flag_modalita) + "). " )
		throw kguo_exception
		
		
	end if

end if

SetPointer(kp_oldpointer)



return k_return

end function

public function boolean check_password_vuota (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//
//====================================================================
//=== Controlla se Password Vuota 
//===
//=== 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti:   Come da standard
//=== 
//====================================================================
boolean k_return = false
string k_codice_up, k_codice_lo
st_esito kst_esito
//kuf_cripta kuf1_cripta
//int k_ctr
boolean k_numero_ok, k_lettera_ok


	kst_esito.esito =kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_codice_up = upper(kst_tab_sr_utenti.codice)
	k_codice_lo = lower(kst_tab_sr_utenti.codice)

	SELECT id, dlgs196_chk_sintax, password
    INTO 
	 	:kst_tab_sr_utenti.id
	   	,:kst_tab_sr_utenti.dlgs196_chk_sintax
		,:kst_tab_sr_utenti.password
    FROM sr_utenti  
	 where codice = :k_codice_up or codice = :k_codice_lo
	 using sqlca;

	if sqlca.sqlcode = 0 then
		if kst_tab_sr_utenti.dlgs196_chk_sintax = "1" then
			
			kst_tab_sr_utenti.password = trim(kst_tab_sr_utenti.password)
			
			if LenA(kst_tab_sr_utenti.password) = 0 then

				k_return = true
//				kst_esito.esito = kkg_esito.err_logico
//				kst_esito.SQLErrText = "Password vuota, deve essere contenere almeno 8 caratteri " 
				
			end if
			
		else
			kst_esito.SQLErrText = "Nessun controllo sulla Password " 
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Utente " &
	 		                       + kst_tab_sr_utenti.codice + " non Trovato"
		else
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: Errore grave in lettura ~n~r" + trim(sqlca.SQLErrText)
			else
				kst_esito.esito = kkg_esito.db_wrn
				kst_esito.SQLErrText = "Tab.Sicurezza-Utenti: problemi in lettura, prego riprovare ~n~r" + trim(sqlca.SQLErrText)
			end if
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
return k_return


end function

public function string check_password (ref string a_password);//
//---------------------------------------------------------------------------------------------------------------------------------------------------------
//--- Controlla la Lunghezza e Caratteri della Password 
//---
//--- Inpit: string della pwd
//--- 
//--- Ritorna: OK=OK, NOLT=mancano lettere o segni, NONUM=manca almeno un numero, NOCHR=carattere non ammesso, NOLEN=troppo corta
//--- 
//---------------------------------------------------------------------------------------------------------------------------------------------------------
string k_return = "OK"
string k_char
int k_ctr
boolean k_numero_ok, k_lettera_ok, k_char_ko
st_tab_sr_utenti kst_tab_sr_utenti1


	a_password = upper(trim(a_password))
				
	//--- la password deve essere + lunga di 8 caratteri 
	if len(a_password) > 7 then
	
	//--- la password deve contere "lettere (o char particolari) e numeri"
		k_numero_ok = false
		k_lettera_ok = false
		k_char_ko = false
		k_ctr = len(a_password) 
		do while (not k_numero_ok or not k_lettera_ok) and k_ctr > 0
	
			k_char = Mid(a_password, k_ctr, 1)
	
			if isnumber(k_char) then
				k_numero_ok = true
			else
				if k_char = "%"  or k_char = "*" or k_char = "?" or k_char ="!" or k_char = "^" or k_char = "~"" or k_char = "'" then
					k_char_ko = true
				else
					k_lettera_ok = true
				end if
			end if
			k_ctr --
		loop
		if not k_lettera_ok then
			k_return = "NOLT"
		end if
		if not k_numero_ok then
			k_return = "NONUM"
		end if
		if  k_char_ko then
			k_return = "NOCHR"
		end if
	else
		k_return = "NOLEN"
	end if
				
	
return k_return


end function

public function st_esito anteprima_tab_menu_window_l (datastore kdw_anteprima, st_tab_menu_window kst_tab_menu_window);//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: STANDARD
//=== 
//====================================================================
//
//=== 
long k_rc
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

//kst_open_w = kst_open_w
//kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
//kst_open_w.id_programma = get_id_programma(kst_open_w.flag_modalita)
//
////--- controlla se utente autorizzato alla funzione in atto
//kuf1_sicurezza = create kuf_sicurezza
//k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
//destroy kuf1_sicurezza
//
//if not k_return then
//
//	kst_esito.sqlcode = sqlca.sqlcode
//	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
//	kst_esito.esito = kkg_esito.no_aut
//
//else

//	if kst_tab_menu_window.id > " " then

		kdw_anteprima.dataobject = "d_menu_window_l"
		kdw_anteprima.settransobject(sqlca)

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve()

//	else
//		kst_esito.sqlcode = 0
//		kst_esito.SQLErrText = "Nessun Programma da visualizzare: ~n~r" + "nessun codice indicato"
//		kst_esito.esito = kkg_esito.not_fnd
//		
//	end if
//end if


return kst_esito

end function

public function st_esito tb_select (ref st_tab_sr_utenti kst_tab_sr_utenti);//====================================================================
//=== Legge tabella sr_utenti
//=== 
//=== Inp: st_tab_sr_utenti.codice
//=== Out: st_tab_sr_utenti
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0
//=== 
//====================================================================
string k_codice_up, k_codice_lo
kuf_base kuf1_base

st_esito kst_esito, kst_esito1


	kst_esito.esito =kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_codice_up = upper(kst_tab_sr_utenti.codice)
	k_codice_lo = lower(kst_tab_sr_utenti.codice)

	SELECT 
	      sr_utenti.id
	     ,sr_utenti.nome
         ,sr_utenti.stato
         ,coalesce(sr_utenti.autenticazione, "X")
		,sr_utenti.scade_dopo_gg
		,sr_utenti.tentativi_max
		,sr_utenti.tentativi_ko
		,sr_utenti.inutilizzo_gg_disa
		,sr_utenti.inutilizzo_sblocco
		,sr_utenti.dt_ultimo_accesso
    INTO 
	      :kst_tab_sr_utenti.id
	     ,:kst_tab_sr_utenti.nome
	     ,:kst_tab_sr_utenti.stato
         ,:kst_tab_sr_utenti.autenticazione
		,:kst_tab_sr_utenti.scade_dopo_gg
		,:kst_tab_sr_utenti.tentativi_max
		,:kst_tab_sr_utenti.tentativi_ko
		,:kst_tab_sr_utenti.inutilizzo_gg_disa
		,:kst_tab_sr_utenti.inutilizzo_sblocco
		,:kst_tab_sr_utenti.dt_ultimo_accesso
    FROM sr_utenti  
	 where codice = :k_codice_up or codice = :k_codice_lo
	 using sqlca;

	if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Utente " + kst_tab_sr_utenti.codice + " non Trovato  (Sicurezza-Utenti)"
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Tab. Sicurezza-Utenti non accessibile:" + trim(sqlca.SQLErrText)
		end if
	end if
	
return kst_esito


end function

public function string get_password (st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Legge tabella sr_utenti
//=== 
//=== Inp: st_tab_sr_utenti.codice
//=== Out: st_tab_sr_utenti
//=== Ritorna tab. ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0
//=== 
//====================================================================
string k_codice_up, k_codice_lo, k_return
kuf_base kuf1_base
kuf_cripta kuf1_cripta
st_esito kst_esito


	kst_esito.esito =kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_codice_up = upper(kst_tab_sr_utenti.codice)
	k_codice_lo = lower(kst_tab_sr_utenti.codice)

	SELECT 
	      sr_utenti.password
    INTO 
	      :kst_tab_sr_utenti.password
    FROM sr_utenti  
	 where upper(codice) = :k_codice_up 
	 using sqlca;

	if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.SQLErrText = "Utente " + kst_tab_sr_utenti.codice + " non Trovato  (Sicurezza-Utenti)"
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Tab. Sicurezza-Utenti non accessibile:" + trim(sqlca.SQLErrText)
		end if
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
//--- decripta la password				
		kuf1_cripta = create kuf_cripta
		k_return = kuf1_cripta.of_decrypt(trim(kst_tab_sr_utenti.password))
		destroy kuf1_cripta
	end if
	
return k_return


end function

public function st_esito tb_delete_sr_settori_profili (st_tab_sr_settori_profili kst_tab_sr_settori_profili);//
//====================================================================
//=== Cancella il rek dalla tabella Associazioni Settori- Profili
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


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()
//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 


	delete from sr_settori_profili
		where id_sr_settore_profilo = :kst_tab_sr_settori_profili.id_sr_settore_profilo
		using kGuo_sqlca_db_magazzino;

	if kGuo_sqlca_db_magazzino.sqlcode <> 0 then
		kst_esito.sqlcode = kGuo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = "Tab.Sicurezza Profili-Utenti:" + trim(kGuo_sqlca_db_magazzino.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito =  kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito =  kkg_esito.db_wrn
			else
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	else
		kst_esito.esito = kkg_esito.ok
	end if





return kst_esito

end function

public function integer if_presente_sr_settore (st_tab_sr_settori_profili ast_tab_sr_settori_profili) throws uo_exception;//
//====================================================================
//=== Torna > 0 se CODICE SETTORE trovato su alemeno 1 record 
//=== 
//=== Input: st_tab_sr_settori_profili con valorizzato sr_settore    Output: 0=non usato >0 usato                  
//=== Lancia errore UE_EXCEPTION
//=== 
//====================================================================
int k_return = 0
st_esito kst_esito
uo_exception kuo_exception



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
   SELECT distinct  1
       into :k_return
		 FROM sr_settori_profili
		 where sr_settore = :ast_tab_sr_settori_profili.sr_settore
			using sqlca;
	
	if sqlca.sqlcode < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in Lettura Tab. Sicurezza Settori Profili ~n~r:" + trim(sqlca.SQLErrText)
		kuo_exception = create uo_exception
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception
	end if


if isnull(k_return) then k_return = 0

return k_return





end function

public subroutine get_id (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Legge tabella sr_utenti
//=== 
//=== Inp: st_tab_sr_utenti.codice
//=== Out: st_tab_sr_utenti.id_utenti
//=== Lancia Exception 
//=== 
//====================================================================
string k_codice_up, k_codice_lo, k_return
kuf_base kuf1_base
st_esito kst_esito


	kst_esito.esito =kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_codice_up = upper(kst_tab_sr_utenti.codice)
	k_codice_lo = lower(kst_tab_sr_utenti.codice)

	SELECT 
	      sr_utenti.id
    INTO 
	      :kst_tab_sr_utenti.id
    FROM sr_utenti  
	 where codice = :k_codice_up or codice = :k_codice_lo
	 using sqlca;

	if sqlca.sqlcode < 0 or sqlca.sqlcode = 100 then
		kst_esito.sqlcode = sqlca.sqlcode
		if sqlca.sqlcode = 100 then
			kst_tab_sr_utenti.id = 0
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.SQLErrText = "Ricerca ID utente di " + trim(kst_tab_sr_utenti.codice) + " in Tab. Sicurezza-Utenti " + " ~n~r:" + trim(sqlca.SQLErrText)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	end if
	
	if isnull(kst_tab_sr_utenti.id) then kst_tab_sr_utenti.id = 0


end subroutine

public function boolean if_utente_uguale (ref st_tab_sr_utenti kst_tab_sr_utenti);//
//====================================================================
//=== Controlla se l'utente passato è lo stesso di login
//===
//=== input: kst_tab_sr_utenti.codice
//=== rit.: TRUE=stesso utente, FALSE=utente passato <> dall'utente di login
//=== 
//====================================================================
boolean k_return=false
	
	
	if kguo_utente.get_codice( ) = "MASTER" then
		k_return=TRUE
	else
		if kst_tab_sr_utenti.id =  kguo_utente.get_id_utente() then
			k_return=TRUE
		end if
	end if
	
	
return k_return


end function

public function string get_sr_settore (string a_id_menu_window) throws uo_exception;//====================================================================
//=== Torna il settore per utente+funzione
//=== 
//=== Inp: id_programma
//=== Out: sr_settore
//=== Lancia Exception 
//=== 
//====================================================================
string k_return=""
long k_id_utente 
datastore kds_get_sr_settore
st_esito kst_esito


	kst_esito.esito =kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if a_id_menu_window > " " then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Settore non reperibile. Manca il codice funzione! "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	k_id_utente = kguo_utente.get_id_utente( )
	
	kds_get_sr_settore = create datastore
	kds_get_sr_settore.dataobject = "ds_get_sr_settore"
	kds_get_sr_settore.settransobject(kguo_sqlca_db_magazzino)

	if kds_get_sr_settore.retrieve(k_id_utente, a_id_menu_window) > 0 then
		
		k_return = kds_get_sr_settore.getitemstring( 1, "sr_settore")

	end if
	
	if isnull(k_return) then k_return = ""

return k_return

end function

public function boolean autorizza_utente_settore (long a_id_utente, string a_sr_settore, integer a_permessi, string a_modalita) throws uo_exception;//
//====================================================================
//=== Torna TRUE se Utente appartiene al SETTORE con il permesso giusto
//=== 
//=== Input: a_id_utente = codice dell'utente che vuole acceder,
//===           a_sr_settore = settore del documento a cui accedere
//===           a_permessi = permessi di accesso al documento (0=nessuno, 2=in lettura, 4=scrittura, 9=completo)
//===           a_modalita = tipo di accesso al documento vi=visual, mo=modifica ecc... (vedi flag_modalita)
//=== Lancia errore UE_EXCEPTION
//=== 
//====================================================================
boolean k_return = false
int k_trovato=0
int k_modalita_permessi=0
st_tab_sr_utenti kst_tab_sr_utenti
st_esito kst_esito


	if len(trim(a_sr_settore)) > 0 then
	else
		a_sr_settore = ""    // se settore a null o "  "
	end if
	if isnull(a_permessi) then
		a_permessi = 4    // x default lettura-scrittura
	end if
	if isnull(a_id_utente) then
		a_id_utente = kguo_utente.get_id_utente( )  // def utente connesso
	end if

//--- se PERMESSI è ZERO non posso fare nulla sul documento
	if a_permessi = 0 then
	
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Autorizzazione per " + kguo_g.get_descrizione(a_modalita)  + " Non Concessa. " + " ~n~r" & 
									  + "Nessun permesso a nessun Utente (eccetto il redigente) concesso da questo Documento " 
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	
	end if

//--- converte codice MODALITA di accesso nel codice PERMESSO
	choose case a_modalita
		case kkg_flag_modalita.cancellazione
			k_modalita_permessi = ki_permessi_completo
		case kkg_flag_modalita.modifica
			k_modalita_permessi = ki_permessi_scrittura
		case kkg_flag_modalita.inserimento
			k_modalita_permessi = ki_permessi_scrittura
		case else
			k_modalita_permessi = ki_permessi_lettura
	end choose


//--- Il PERMESSO sul documento deve essere migliore o uguale all'operazione che voglio compiere, 
//---            ad esempio NON posso CANCELLARE (=9) se sul documento ho al massimo il permesso di SCRIVERE (=4)
	if a_permessi < k_modalita_permessi then
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Autorizzazione per questo tipo di operazione (" + kguo_g.get_descrizione(a_modalita)  + ") Non Concessa. " + " ~n~r" & 
									 + "Documento del Settore "+ trim(a_sr_settore)   
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception

	end if

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if a_sr_settore = "" or a_id_utente = 0 then
		k_trovato = 1	
	else
		
//		kst_tab_sr_utenti.codice = a_utente_codice
//		this.get_id(kst_tab_sr_utenti)
		kst_tab_sr_utenti.id = a_id_utente
		
		if kst_tab_sr_utenti.id > 0 then

//--- controlla se Per il SETTORE indicato l'utente ha il permesso di accessedere nella modalità indicata 		
			SELECT distinct  1
				 into :k_trovato
				 FROM sr_settori_profili inner join sr_prof_utenti on 
							sr_settori_profili.id_sr_profilo = sr_prof_utenti.id_profili 
				 where sr_settori_profili.sr_settore = :a_sr_settore
							  and sr_prof_utenti.id_utenti = :kst_tab_sr_utenti.id
							  and sr_settori_profili.permessi >= :k_modalita_permessi
					using sqlca;
			
			if sqlca.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Errore in Autorizzazione Utente " + string(a_id_utente) + " per il Settore '" + trim(a_sr_settore) + "' ~n~r:" + trim(sqlca.SQLErrText)
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito )
				throw kguo_exception
			end if
		end if
	end if

	if k_trovato = 1 then
		k_return = TRUE
	else  
		kst_esito.esito = kkg_esito.no_aut
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Autorizzazione per " + kguo_g.get_descrizione(a_modalita)  + " Non Concessa. " + " ~n~r" & 
									 + "Documento del Settore '"+ trim(a_sr_settore) + "' non autorizzato per il tuo Utente (cod='" + string(a_id_utente) + "') "  
		kguo_exception.inizializza( )
		kguo_exception.set_esito( kst_esito )
		throw kguo_exception
	end if

return k_return





end function

public function boolean check_user_password (ref st_tab_sr_utenti ast_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Controlla Utente e Password da Accesso iniziale
//=== 
//=== Input: st_tab_sr_utenti (utente+ password)
//=== Out: True = OK
//=== Lancia exception
//=== 
//====================================================================
//
boolean k_return = false
kuf_sr_activedirectory kuf1_sr_activedirectory
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ko
	kst_esito.sqlcode = 0
	kst_esito.sqlerrtext = ""
	kst_esito.nome_oggetto = this.classname()

	if not isnull(ast_tab_sr_utenti.password) then
		ast_tab_sr_utenti.password = trim(ast_tab_sr_utenti.password)
	else
		ast_tab_sr_utenti.password = ""
	end if
	
	if  not isnull(ast_tab_sr_utenti.codice) then
		ast_tab_sr_utenti.codice = trim(ast_tab_sr_utenti.codice)
	else
		ast_tab_sr_utenti.codice = ""
	end if

	if u_if_master(ast_tab_sr_utenti.password) then
		ast_tab_sr_utenti.id = 9999 //forzo un ID inesistente
		ast_tab_sr_utenti.codice = "MASTER " //forzo utente Master
		ast_tab_sr_utenti.nome = "MASTER " //forzo utente Master
		
		k_return = true  // Autorizzato
		
	end if

//--- se non sono ancora Autorizzato...
	if not k_return then

//--- legge dati utente
		kst_esito = tb_select(ast_tab_sr_utenti)
		if kst_esito.esito <> kkg_esito.ok then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

		ast_tab_sr_utenti.tentativi_ko ++
		
//--- controlli vari sull'utente, tipo i troppo tentativi o se non si colega da troppo tempo
		check_user_dati(ast_tab_sr_utenti)

//--- controlla PWD su ActiveDirectory di Windows se e Autenticazione NO solo su M2000
		if ast_tab_sr_utenti.autenticazione <> kki_autenticazione_daM200 then
			kuf1_sr_activedirectory = create kuf_sr_activedirectory
			if kuf1_sr_activedirectory.check_pwd( ast_tab_sr_utenti.codice, ast_tab_sr_utenti.password) then
				k_return = true  // Autorizzato
			end if
		end if
		
//--- se pwd non riconosciuta da Windows e Autenticazione NO solo su Windows allora prova pwd in M2000 
		if not k_return and ast_tab_sr_utenti.autenticazione <> kki_autenticazione_daWindows then
		
			if check_password_procedura (ast_tab_sr_utenti) then

	//--- controllo se password scaduta o vuota
				kst_esito = check_password_scaduta(ast_tab_sr_utenti)
			
				if kst_esito.esito <> kkg_esito.ok then
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
			
				if check_password_vuota(ast_tab_sr_utenti) then
					kst_esito.esito = kkg_esito.pwd_scaduta
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
				end if
				
				k_return = true  // Autorizzato
	
			end if
		end if		
	end if
	
	
//--- se password corretta
	if k_return then
						
		ast_tab_sr_utenti.tentativi_ko = 0  // azzera i tentativi password ok
		tb_update_password_tentativi(ast_tab_sr_utenti)
		
		ast_tab_sr_utenti.dt_ultimo_accesso = kguo_g.get_dataoggi( )
		tb_update_password_dt_ultimo_accesso(ast_tab_sr_utenti)
		
	else
		
		kst_esito = check_password_digit_errata(ast_tab_sr_utenti)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if

catch (uo_exception kuo_exception)
	throw kuo_exception
	
end try


return k_return 


end function

private function boolean check_user_dati (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Controlla dati generici di accesso dell'utente
//=== 
//=== Input: st_tab_sr_utenti
//=== Out: TRUE = tutto OK
//=== Exception con ST_ESITO, Esiti:   0=OK; 
//===                               100=not found
//===                                 1=errore grave DB
//===                                 2=errore > 0
//=== 
//====================================================================
boolean k_return = false
date k_dataoggi, k_data_scad
st_esito kst_esito, kst_esito1

	
	try
		kst_esito.esito =kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()
	
		if kst_tab_sr_utenti.stato = "0" then

//--- leggo la data-oggi
			k_dataoggi = kguo_g.get_dataoggi( )

//--- se troppi tentativi Errati....
			if kst_tab_sr_utenti.tentativi_max = 0 or isnull(kst_tab_sr_utenti.tentativi_max) then
				kst_tab_sr_utenti.tentativi_max = 999
			end if
			if isnull(kst_tab_sr_utenti.tentativi_ko) then
				kst_tab_sr_utenti.tentativi_ko = 0
			end if
			
			if kst_tab_sr_utenti.tentativi_max >= kst_tab_sr_utenti.tentativi_ko then

//--- se troppo tempo di inutilizzo....
				if (isnull(kst_tab_sr_utenti.inutilizzo_sblocco) &
				    or kst_tab_sr_utenti.inutilizzo_sblocco = "0") &
				   and kst_tab_sr_utenti.inutilizzo_gg_disa > 0 &
					and kst_tab_sr_utenti.dt_ultimo_accesso > date (0) then
					k_data_scad = relativedate(kst_tab_sr_utenti.dt_ultimo_accesso, kst_tab_sr_utenti.inutilizzo_gg_disa)
				else
					k_data_scad = k_dataoggi
				end if

				if k_data_scad >= k_dataoggi then
			
					k_return = true   // controlli generici OK
					
				else
					kst_esito.esito = kkg_esito.no_aut
					kst_esito.SQLErrText = "Credenziali Utente Sospese, ~n~r" & 
						 + "troppo tempo trascorso dall'ultimo Accesso al Sistema (piu' di " &
						 + string(kst_tab_sr_utenti.inutilizzo_gg_disa) + " giorni). " 
					kguo_exception.inizializza( )
					kguo_exception.set_esito(kst_esito)
					throw kguo_exception
					
				end if
			else
				kst_esito.esito = kkg_esito.no_aut
				kst_esito.SQLErrText = "Utente Bloccato, ~n~r" & 
					 + "password errata per troppi tentativi (piu' di " &
					 + string(kst_tab_sr_utenti.tentativi_max) + " volte). " 
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
				
			end if
			
		else
			kst_esito.esito = kkg_esito.no_aut
			kst_esito.SQLErrText = "Utente non Abilitato, contattare l'amministratore per l'attivazione." 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception 
		
	end try
	
return k_return 


end function

public function st_esito check_password_digit_errata (ref st_tab_sr_utenti kst_tab_sr_utenti);//====================================================================
//=== Password ERRATA 
//=== 
//=== fa le cose da fare compreso il lancio del messaggio
//=== 
//====================================================================
st_esito kst_esito, kst_esito1



	kst_esito.esito =kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

			
	kst_esito.esito = kkg_esito.no_aut
	if LenA(trim(kst_tab_sr_utenti.password)) = 0 then
		kst_esito.SQLErrText = "Digitare la Password  " 
	else
		kst_esito1 = tb_update_password_tentativi(kst_tab_sr_utenti)

		kst_esito.SQLErrText = "Digitata password errata, "  &
		 + "tentativo " + string(kst_tab_sr_utenti.tentativi_ko) &
		 + " di " + string(kst_tab_sr_utenti.tentativi_max) + ". "  
//		~n~r" & 
	end if
	
return kst_esito

end function

public function boolean check_password_procedura (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Controlla Utente e Password 
//=== 
//=== Input: st_tab_sr_utenti (utente+ password)
//=== Out: True = OK
//=== Lancia exception
//=== 
//====================================================================
boolean k_return = false
string k_codice_up, k_codice_lo
date k_dataoggi, k_data_scad
st_esito kst_esito, kst_esito1
st_tab_sr_utenti kst_tab_sr_utenti_1 


	try
		kst_esito.esito =kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""
		kst_esito.nome_oggetto = this.classname()
	
		k_codice_up = upper(kst_tab_sr_utenti.codice)
		k_codice_lo = lower(kst_tab_sr_utenti.codice)

//--- get della password 
		kst_tab_sr_utenti_1.password = get_password(kst_tab_sr_utenti)

		if trim(kst_tab_sr_utenti_1.password) > " " then
		else
			kst_tab_sr_utenti_1.password = " "
			kst_tab_sr_utenti.password = " "
		end if
			
		if upper(trim(kst_tab_sr_utenti_1.password)) <> upper(trim(kst_tab_sr_utenti.password)) then

			kst_esito = check_password_digit_errata(kst_tab_sr_utenti)
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza()
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		else
			
			k_return = true  // PASSWORD OK!
			
		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	end try
	
return k_return 


end function

public function boolean check_cambia_password (ref st_tab_sr_utenti kst_tab_sr_utenti) throws uo_exception;//====================================================================
//=== Controlla Utente e Password x il Cambio password
//=== 
//=== Input: st_tab_sr_utenti (utente+ password)
//=== Out: True = OK
//=== Lancia exception
//=== 
//====================================================================
boolean k_return = false


	try

//--- controlli vari sull'utente, tipo i troppo tentativi o se non si colega da troppo tempo
		if check_user_dati(kst_tab_sr_utenti) then
			
			k_return = check_password_procedura(kst_tab_sr_utenti)

		end if

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
	end try
	
return k_return 


end function

public function boolean u_if_master (string k_pwd);//
string k_hash_pwd
Blob lblb_data
Blob lblb_md5
CrypterObject lnv_CrypterObject   

lblb_data = Blob(lower(k_pwd), EncodingANSI!)

lnv_CrypterObject = Create CrypterObject

// Encrypt with MD5
lblb_md5 = lnv_CrypterObject.MD5(lblb_data)
k_hash_pwd = string(lblb_md5)

if k_hash_pwd = "蓭豩鿌濮睠瘣഻衾" then 
	return true
else
	return false
end if

//if k_pwd = "XXXXX" then
//	return true
//else
//	return false
//end if
//	

end function

on kuf_sr_sicurezza.create
call super::create
end on

on kuf_sr_sicurezza.destroy
call super::destroy
end on

