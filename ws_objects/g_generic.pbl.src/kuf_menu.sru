$PBExportHeader$kuf_menu.sru
forward
global type kuf_menu from nonvisualobject
end type
end forward

global type kuf_menu from nonvisualobject
end type
global kuf_menu kuf_menu

type variables
//
//private st_tab_menu_window_oggetti kist_tab_menu_window_oggetti[]

end variables

forward prototypes
public function integer set_tab_menu_window ()
private function boolean set_tab_menu_window_oggetti ()
private function string u_esplode_funzione (string k_funzione)
private function boolean set_tab_menu_window_anteprima ()
public function boolean get_st_tab_menu_window (ref st_tab_menu_window k_st_tab)
public function boolean get_nome_oggetto_da_window_oggetti (ref st_tab_menu_window_oggetti kst_tab_menu_window_oggetti)
public function string get_anteprima_nome_id_tabella (ref string a_id_menu_window) throws uo_exception
end prototypes

public function integer set_tab_menu_window ();//
//--- Memorizzo in una array di memoria l'intero menu abilitato x l'utente, se MASTER invece carico tutte
//--- le voci
//
string k_codice, k_cursore
integer k_ctr=0, k_ctr_prec=0
string k_utente
long k_id_utente, k_righe_settore, k_riga_find
st_esito kst_esito
st_tab_menu_window kst_tab_menu_window[]
st_tab_menu_window_oggetti kst_tab_menu_window_oggetti
datastore kds_get_sr_settore


kds_get_sr_settore = create datastore
kds_get_sr_settore.dataobject = "ds_get_sr_settore_all_x_id_utente"  //"ds_get_sr_settore"
kds_get_sr_settore.settransobject( kguo_sqlca_db_magazzino )

//--- Carica la tabella Menu + Oggetti 
set_tab_menu_window_oggetti()

//--- Inizializza SICUREZZA: le abilitazioni alle funzioni
kGst_tab_menu_window[] = kst_tab_menu_window[]

k_id_utente = kguo_utente.get_id_utente() 
k_utente = upper(trim(kguo_utente.get_codice()))
choose case k_utente
		
	case '*VUOTO*'   // solo x l'utente che accede inizialmente: AGGIUNGERE A MANO LE FUNZIONI NECESSARIO 
		k_cursore = &
			" select distinct " + &
			"   trim(menu_window.id), " + &
			"	 trim(menu_window.window), " + &
			"	 menu_window.istanze, " + &
			"	 menu_window.salva_size, " + &
			"	 menu_window.salva_controlli, " + & 
			"	 menu_window.min_w_prec, " + &
			"	 trim(menu_window.titolo), " + &
			"	 trim(menu_window.funzioni), " + &
			"	 menu_window.batch, " + &
			"    menu_window.msg_se_gia_open, " + &
			"    menu_window.primopiano " + &
			"    ,menu_window_anteprima.nome_id_tabella " + &
			" from  " + &
			"   menu_window left outer join menu_window_anteprima on menu_window.id = menu_window_anteprima.id_menu_window " + &
			" where  menu_window.id in ('srpassword_c') " + &
			" order by 1  " 
			
	case 'MASTER'  // è il mio utente per avere tutto Autorizzzato
		k_cursore = &
			" select distinct " + &
			"   trim(menu_window.id), " + &
			"	 trim(menu_window.window), " + &
			"	 menu_window.istanze, " + &
			"	 menu_window.salva_size, " + &
			"	 menu_window.salva_controlli, " + &
			"	 menu_window.min_w_prec, " + &
			"	 trim(menu_window.titolo), " + &
			"	 trim(menu_window.funzioni), " + &
			"	 menu_window.batch, " + &
			"    menu_window.msg_se_gia_open, " + &
			"    menu_window.primopiano " + &
			"    ,menu_window_anteprima.nome_id_tabella " + &
			" from  " + &
			"   menu_window left outer join menu_window_anteprima on menu_window.id = menu_window_anteprima.id_menu_window " + &
			" order by 1  " 
			
	case else
		k_cursore = &
			" select distinct " + &
			"   trim(menu_window.id), " + &
			"	 trim(menu_window.window), " + &
			"	 menu_window.istanze, " + &
			"	 menu_window.salva_size, " + &
			"	 menu_window.salva_controlli, " + &
			"	 menu_window.min_w_prec, " + &
			"	 trim(menu_window.titolo), " + &
			"	 trim(sr_funzioni.funzioni), " + &
			"	 menu_window.batch, " + &
			"    menu_window.msg_se_gia_open, " + &
			"    menu_window.primopiano " + &
			"    ,menu_window_anteprima.nome_id_tabella " + &
			" from  " + &
			" sr_utenti inner join sr_prof_utenti on " + &
			"    sr_utenti.id = sr_prof_utenti.id_utenti  " + &
			"			      inner join sr_prof_funz on " + &
			"    sr_prof_utenti.id_profili = sr_prof_funz.id_profili  " + &
			"               inner join sr_profili on  " + &
			"    sr_prof_funz.id_profili = sr_profili.id " + &
			"               inner join sr_funzioni on  " + &
			"    sr_prof_funz.id_funzioni = sr_funzioni.id " + &
			"               inner join menu_window on  " + &
			"    sr_funzioni.id_programma = menu_window.id " + &
			"               left outer join menu_window_anteprima on menu_window.id = menu_window_anteprima.id_menu_window " + &
			" where  " + &
			"    ( upper(sr_utenti.codice) = '" + k_utente + "' " + &
			"	  and sr_utenti.stato = '0' " + &
			"	  and sr_profili.stato = '0' ) " + &
			" order by 1  " 
end choose


//prepare :k_cursore
declare kc_menu_window dynamic cursor for sqlsa;
//		using sqlca;
PREPARE SQLSA FROM :k_cursore; 

open dynamic kc_menu_window; // using :kguo_utente.get_codice();

if sqlca.sqlcode = 0 then

	k_ctr=1 
	kGst_tab_menu_window[k_ctr].id = " "
	fetch	kc_menu_window
			 into :kGst_tab_menu_window[k_ctr].id,
					:kGst_tab_menu_window[k_ctr].window,
					:kGst_tab_menu_window[k_ctr].istanze,
					:kGst_tab_menu_window[k_ctr].salva_size,
					:kGst_tab_menu_window[k_ctr].salva_controlli,
					:kGst_tab_menu_window[k_ctr].min_w_prec,  
					:kGst_tab_menu_window[k_ctr].titolo,  
					:kGst_tab_menu_window[k_ctr].funzioni,  
					:kGst_tab_menu_window[k_ctr].batch,  
					:kGst_tab_menu_window[k_ctr].msg_se_gia_open,  
					:kGst_tab_menu_window[k_ctr].primopiano  
					,:kGst_tab_menu_window[k_ctr].nome_id_tabella  
					;
//	k_ctr++

	if sqlca.sqlcode = 0 then
		k_righe_settore = kds_get_sr_settore.retrieve(k_id_utente)  // acchiappa i SETTORI , kGst_tab_menu_window[k_ctr].id)
		kGst_tab_menu_window[2].id = " "
	end if

	do while sqlca.sqlcode = 0 
		
//--- per raggruppare le funzioni in una unica voce nella tabella
		if k_ctr_prec > 0 then
			if kGst_tab_menu_window[k_ctr].id = kGst_tab_menu_window[k_ctr_prec].id then
			
				kGst_tab_menu_window[k_ctr_prec].funzioni += trim(kGst_tab_menu_window[k_ctr].funzioni) 
				
			else
				k_ctr_prec = k_ctr
			end if
		end if
		

//--- rintraccia il settore 'prevalente' x questo funzione e utente		
		kGst_tab_menu_window[k_ctr].sr_settore = ""
//		if k_id_utente > 0 then
		if k_righe_settore > 0 then
			k_riga_find = kds_get_sr_settore.find("menu_window_id = '" + trim(kGst_tab_menu_window[k_ctr].id) + "'", 1, k_righe_settore)
			if k_riga_find > 0 then
				kGst_tab_menu_window[k_ctr].sr_settore = kds_get_sr_settore.getitemstring(k_riga_find, "sr_settore")
			end if
		end if

//--- get del nome Oggetto (kuf_....)		
		kst_tab_menu_window_oggetti.id_menu_window = kGst_tab_menu_window[k_ctr].id
		kst_tab_menu_window_oggetti.funzione = ""
		if get_nome_oggetto_da_window_oggetti(kst_tab_menu_window_oggetti) then
			kGst_tab_menu_window[k_ctr].nome_oggetto = kst_tab_menu_window_oggetti.nome_oggetto
		else
			kGst_tab_menu_window[k_ctr].nome_oggetto = ""
		end if
		
		if isnull(kGst_tab_menu_window[k_ctr].primopiano) then
			kGst_tab_menu_window[k_ctr].primopiano = "N"
		end if

//--- solo nel giro di prima volta 
		if k_ctr_prec = 0 then
			k_ctr_prec = 1
		end if

		k_ctr = k_ctr_prec + 1
		kGst_tab_menu_window[k_ctr].id = " "

//--- Utente speciale allora abilito Tutte le Funzioni
		if k_utente = 'MASTER' then
			kGst_tab_menu_window[k_ctr_prec].funzioni = kkg_flag_modalita.anteprima &
													  + kkg_flag_modalita.cancellazione &
													  + kkg_flag_modalita.chiudi_pl &
													  + kkg_flag_modalita.elenco &
													  + kkg_flag_modalita.inserimento &
													  + kkg_flag_modalita.interrogazione &
													  + kkg_flag_modalita.modifica &
													  + kkg_flag_modalita.navigatore &
													  + kkg_flag_modalita.stampa &
													  + kkg_flag_modalita.visualizzazione
		end if


		fetch	kc_menu_window
			 into :kGst_tab_menu_window[k_ctr].id,
					:kGst_tab_menu_window[k_ctr].window,
					:kGst_tab_menu_window[k_ctr].istanze,
					:kGst_tab_menu_window[k_ctr].salva_size,
					:kGst_tab_menu_window[k_ctr].salva_controlli,
					:kGst_tab_menu_window[k_ctr].min_w_prec, 
					:kGst_tab_menu_window[k_ctr].titolo,  
					:kGst_tab_menu_window[k_ctr].funzioni,  
					:kGst_tab_menu_window[k_ctr].batch,  
					:kGst_tab_menu_window[k_ctr].msg_se_gia_open,  
					:kGst_tab_menu_window[k_ctr].primopiano  
					,:kGst_tab_menu_window[k_ctr].nome_id_tabella  
					;
	loop

	close kc_menu_window;

	k_ctr = k_ctr - 1	

//--- Carica la tabella  "Anteprime+id campo tabella"  x chiamare le funzioni dallo zoom
	if k_ctr > 0 then
		set_tab_menu_window_anteprima()
	end if

else
	
	kst_esito.esito = "1"
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.sqlerrtext = "Errore durante lettura tabella SICUREZZA funzione 'SELECT_ALL' in 'kuf_menu_window' " + &
									"Dbms.: " + trim(sqlca.dbparm) + "; " + &
						         " " + trim(sqlca.sqlerrtext)

//=== Segna lo Start dell'applicazione (I=messaggio Informativo)
	kGuf_data_base.errori_scrivi_esito("W", kst_esito) 
	
	
end if	
	
	
return k_ctr

end function

private function boolean set_tab_menu_window_oggetti ();//
//--- Memorizzo in una array di memoria l'intera tabella menu + Oggetti compattandola
//--- le voci
//
boolean k_return=false
string k_codice, k_cursore
integer k_ctr=0 //, k_ctr_prec=0
st_tab_menu_window_oggetti kst_tab_menu_window_oggetti
st_esito kst_esito



if upper(kguo_utente.get_codice()) = 'MASTER' then

	k_cursore = &
		" select " + &
		"   id, " + &
		"	 nome_oggetto, " + &
		"    funzione, " +  &
		"	 id_menu_window " + &
		" from  " + &
	   " menu_window_oggetti " + &
		" order by nome_oggetto, id_menu_window  " 
else	
	k_cursore = &
		" select " + &
		"   id, " + &
		"	 nome_oggetto, " + &
		"    funzione, " +  &
		"	 id_menu_window " + &
		" from  " + &
	   " menu_window_oggetti " + &
	   " where  id_menu_window in ( " + &
		" select " + &
		"   menu_window.id " + &
		" from  " + &
	   " sr_utenti inner join sr_prof_utenti on " + &
		"    sr_utenti.id = sr_prof_utenti.id_utenti  " + &
		"			      inner join sr_prof_funz on " + &
		"    sr_prof_utenti.id_profili = sr_prof_funz.id_profili  " + &
		"               inner join sr_profili on  " + &
		"    sr_prof_funz.id_profili = sr_profili.id " + &
		"               inner join sr_funzioni on  " + &
		"    sr_prof_funz.id_funzioni = sr_funzioni.id " + &
		"               inner join menu_window on  " + &
		"    sr_funzioni.id_programma = menu_window.id " + &
	   " where  " + &
		"    ( upper(sr_utenti.codice) = '" + trim(kguo_utente.get_codice()) + "' " + &
		"	  and sr_utenti.stato = '0' " + &
		"	  and sr_profili.stato = '0' ) " + &
		"	 ) " + &
		" order by nome_oggetto, id_menu_window  " 
end if	

//prepare :k_cursore
declare kc_menu_window dynamic cursor for sqlsa;
//		using sqlca;
PREPARE SQLSA FROM :k_cursore; 

open dynamic kc_menu_window; // using :kguo_utente.get_codice();

if sqlca.sqlcode = 0 then

	k_ctr=1 
	kguo_g.kGst_tab_menu_window_oggetti[k_ctr] = kst_tab_menu_window_oggetti
	kguo_g.kGst_tab_menu_window_oggetti[k_ctr].id = 0
	
	fetch	kc_menu_window
			 into :kst_tab_menu_window_oggetti.id,
					:kst_tab_menu_window_oggetti.nome_oggetto,
					:kst_tab_menu_window_oggetti.funzione,
					:kst_tab_menu_window_oggetti.id_menu_window
					;
	
	do while sqlca.sqlcode = 0 
		
//--- raggruppa le funzioni in una unica voce ad esempio clienti con "in" "mo" "vi" che chiamano lo stesso programma  nel campo funzioni avro' "+in+mo+vi"

		if trim(kst_tab_menu_window_oggetti.nome_oggetto) = trim(kguo_g.kGst_tab_menu_window_oggetti[k_ctr].nome_oggetto) &
					 and trim(kst_tab_menu_window_oggetti.id_menu_window) = trim(kguo_g.kGst_tab_menu_window_oggetti[k_ctr].id_menu_window) then

//--- Esplode funzioni 
			kguo_g.kGst_tab_menu_window_oggetti[k_ctr].funzione += u_esplode_funzione(trim(kst_tab_menu_window_oggetti.funzione))
			
		else
				
			k_ctr++
			kguo_g.kGst_tab_menu_window_oggetti[k_ctr] = kst_tab_menu_window_oggetti
//--- Esplode funzioni 
			kguo_g.kGst_tab_menu_window_oggetti[k_ctr].funzione = u_esplode_funzione(trim(kst_tab_menu_window_oggetti.funzione))

		end if

		fetch	kc_menu_window
			 into :kst_tab_menu_window_oggetti.id,
					:kst_tab_menu_window_oggetti.nome_oggetto,
					:kst_tab_menu_window_oggetti.funzione,
					:kst_tab_menu_window_oggetti.id_menu_window
					;
	loop
	
	close kc_menu_window;
	
	//k_ctr = k_ctr - 1	

else
	
	kst_esito.esito = "1"
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.sqlerrtext = "Errore durante lettura tabella SICUREZZA funzione 'SELECT_ALL' in 'kuf_menu_window.set_tab_menu_window_oggetti' " + &
									"Dbms.: " + trim(sqlca.dbparm) + "; " + &
						         " " + trim(sqlca.sqlerrtext)

//=== Segna lo Start dell'applicazione (I=messaggio Informativo)
	kGuf_data_base.errori_scrivi_esito("W", kst_esito) 
	
	
end if	
	
	
return k_return

end function

private function string u_esplode_funzione (string k_funzione);//
//--- Esplode le funzioni di autorizzazione
//
string k_funzione_composta


//--- Se trovo i caratteri 'ivmc' s'intendono le funzioni di +in+vi+mo+ca posso aggiungere anche 'es' ovvero +el+st e anche 'a' ovvero +an
				choose case trim(k_funzione)
					case "ivmcesa", "*", "ivmcesab"   // tutte le funzioni
						k_funzione_composta = "+in+vi+mo+ca+el+st+an+qy+bt"
					case "*-el"   // tutte le funzioni escluso Elenco
						k_funzione_composta = "+in+vi+mo+ca+st+an+qy"
					case "*-es"   // tutte le funzioni escluso Elenco e Stampa
						k_funzione_composta = "+in+vi+mo+ca+an+qy"
					case "*-ev"   // tutte le funzioni escluso Elenco e Visualizz (e Anteprima)
						k_funzione_composta = "+in+mo+ca+st"
					case "*-bt"   // tutte le funzioni escluso Batch
						k_funzione_composta =  "+in+vi+mo+ca+el+st+an+qy"
					case "*-mo"   // tutte le funzioni escluso Modifica
						k_funzione_composta =  "+in+vi+ca+el+st+an+qy"
					case "vm"   // gestione parziale no a inserimento, cancellazione 
						k_funzione_composta = "+vi+mo"
					case "vmc"   // gestione parziale non inserimento
						k_funzione_composta = "+vi+mo+ca"
					case "ivmc"   // l'ntera gestione
						k_funzione_composta = "+in+vi+an+mo+ca"
					case "ivmce"   // l'ntera gestione + elenco
						k_funzione_composta = "+in+vi-an+mo+ca+el"
					case "vi"   // solo Visualizzazione e Anteprima
						k_funzione_composta = "+vi+an+qy"
					case "es"   // solo elenco e stampa
						k_funzione_composta = "+el+st+qy"
					case "esa"   // solo elenco e stampa e anteprima
						k_funzione_composta = "+el+st+an+qy"
					case "vesa"   // solo CONSULTAZIONE
						k_funzione_composta = "+el+st+an+vi+qy"
					case else // solo la funzione indicata
						k_funzione_composta = "+" + trim(k_funzione) 
				end choose


return k_funzione_composta
end function

private function boolean set_tab_menu_window_anteprima ();//
//--- Memorizzo in una array di memoria l'intera tabella menu + Oggetti compattandola
//--- le voci
//
boolean k_return=false
string k_codice, k_cursore
integer k_ctr=0 //, k_ctr_prec=0
st_tab_menu_window_anteprima kst_tab_menu_window_anteprima
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if upper(kguo_utente.get_codice()) = 'MASTER' then

	k_cursore = &
		" select " + &
		"   id, " + &
		"	 anteprima, " + &
		"	 nome_id_tabella, " + &
		"	 id_menu_window " + &
		" from  " + &
	   " menu_window_anteprima " + &
		" order by anteprima, id_menu_window  " 
else	
	k_cursore = &
		" select " + &
		"   id, " + &
		"	 anteprima, " + &
		"	 nome_id_tabella, " + &
		"	 id_menu_window " + &
		" from  " + &
	   " menu_window_anteprima " + &
	   " where  id_menu_window in ( " + &
		" select " + &
		"   menu_window.id " + &
		" from  " + &
	   " sr_utenti inner join sr_prof_utenti on " + &
		"    sr_utenti.id = sr_prof_utenti.id_utenti  " + &
		"			      inner join sr_prof_funz on " + &
		"    sr_prof_utenti.id_profili = sr_prof_funz.id_profili  " + &
		"               inner join sr_profili on  " + &
		"    sr_prof_funz.id_profili = sr_profili.id " + &
		"               inner join sr_funzioni on  " + &
		"    sr_prof_funz.id_funzioni = sr_funzioni.id " + &
		"               inner join menu_window on  " + &
		"    sr_funzioni.id_programma = menu_window.id " + &
	   " where  " + &
		"    ( upper(sr_utenti.codice) = '" + trim(kguo_utente.get_codice()) + "' " + &
		"	  and sr_utenti.stato = '0' " + &
		"	  and sr_profili.stato = '0' ) " + &
		"	 ) " + &
		" order by anteprima, id_menu_window  " 
end if	

//prepare :k_cursore
declare kc_menu_window_anteprima dynamic cursor for sqlsa;
//		using sqlca;
PREPARE SQLSA FROM :k_cursore; 

open dynamic kc_menu_window_anteprima; // using :kguo_utente.get_codice();

if sqlca.sqlcode = 0 then

//	k_ctr=1 
//	kgst_tab_menu_window_anteprima[k_ctr] = kst_tab_menu_window_anteprima
//	kgst_tab_menu_window_anteprima[k_ctr].id = 0
	
	fetch	kc_menu_window_anteprima
			 into :kst_tab_menu_window_anteprima.id,
					:kst_tab_menu_window_anteprima.anteprima,
					:kst_tab_menu_window_anteprima.nome_id_tabella,
					:kst_tab_menu_window_anteprima.id_menu_window
					;
	
	do while sqlca.sqlcode = 0 
		
		k_ctr++
		kgst_tab_menu_window_anteprima[k_ctr].id = kst_tab_menu_window_anteprima.id
		kgst_tab_menu_window_anteprima[k_ctr].anteprima = trim(kst_tab_menu_window_anteprima.anteprima)
		kgst_tab_menu_window_anteprima[k_ctr].nome_id_tabella = trim(kst_tab_menu_window_anteprima.nome_id_tabella)
		kgst_tab_menu_window_anteprima[k_ctr].id_menu_window = trim(kst_tab_menu_window_anteprima.id_menu_window)


		fetch	kc_menu_window_anteprima
			 into :kst_tab_menu_window_anteprima.id,
					:kst_tab_menu_window_anteprima.anteprima,
					:kst_tab_menu_window_anteprima.nome_id_tabella,
					:kst_tab_menu_window_anteprima.id_menu_window
					;
	loop
	
	close kc_menu_window_anteprima;
	
	k_ctr++
	kgst_tab_menu_window_anteprima[k_ctr].anteprima = "FINE"

else
	
	kst_esito.esito = kkg_esito.db_ko
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.sqlerrtext = "Errore durante lettura tabella 'menu_window_anteprima',  oggetto: " +  this.classname() + &
						         " ~n~r" + trim(sqlca.sqlerrtext)

//=== Segna lo Start dell'applicazione (I=messaggio Informativo)
	kGuf_data_base.errori_scrivi_esito("W", kst_esito) 
	
	
end if	
	
	
return k_return

end function

public function boolean get_st_tab_menu_window (ref st_tab_menu_window k_st_tab);//
//--- Get delle Caratteristiche delle Window specifica
//--- torna la struttura valorizzata e 
//---      true = OK
//---      false = KO
//---
boolean k_return = false
long k_ctr, k_ctr_idx


k_st_tab.window =  trim(k_st_tab.window)
k_st_tab.id = ""

k_ctr_idx = UpperBound(kGst_tab_menu_window[])
for k_ctr = 1 to k_ctr_idx 
	if k_st_tab.window = trim(kGst_tab_menu_window[k_ctr].window) then

		k_st_tab.id = trim(kGst_tab_menu_window[k_ctr].id) 
		k_st_tab.window = trim(kGst_tab_menu_window[k_ctr].window)
		k_st_tab.istanze = (kGst_tab_menu_window[k_ctr].istanze)
		k_st_tab.funzioni = trim(kGst_tab_menu_window[k_ctr].funzioni)
		k_st_tab.salva_size = trim(kGst_tab_menu_window[k_ctr].salva_size)
		k_st_tab.salva_controlli = trim(kGst_tab_menu_window[k_ctr].salva_controlli)
		k_st_tab.min_w_prec = trim(kGst_tab_menu_window[k_ctr].min_w_prec) 
		k_st_tab.batch = trim(kGst_tab_menu_window[k_ctr].batch)		
		k_st_tab.msg_se_gia_open = trim(kGst_tab_menu_window[k_ctr].msg_se_gia_open)		
			
		k_return = true
		
		exit
	end if
end for


//
//	select id,
//			 window,
//			 istanze,
//			 funzioni,
//			 salva_size,
//			 min_w_prec 
//	 into :k_st_tab.id,
//			:k_st_tab.window,
//			:k_st_tab.istanze,
//			:k_st_tab.funzioni,
//			:k_st_tab.salva_size,
//			:k_st_tab.min_w_prec  
//		 from   
//	      menu_window inner join sr_funzioni on 
//		"    sr_utenti.id = sr_prof_utenti.id_utenti  " + &
//		"			      inner join sr_prof_funz on " + &
//		"    sr_prof_utenti.id_profili = sr_prof_funz.id_profili  " + &
//		"               inner join sr_profili on  " + &
//		"    sr_prof_funz.id_profili = sr_profili.id " + &
//		"               inner join sr_funzioni on  " + &
//		"    sr_prof_funz.id_funzioni = sr_funzioni.id " + &
//		"               inner join menu_window on  " + &
//		"    sr_funzioni.id_programma = menu_window.id " + &
//	   " where  " + &
//		"    ( sr_utenti.codice = :kguo_utente.get_codice() " + &
//		"	  and sr_utenti.stato = '0' " + &
//		"	  and sr_profili.stato = '0' ) " + &
//			 
//		from menu_window
//		where window = :k_st_tab.window
//		using sqlca;
//
//
return k_return

end function

public function boolean get_nome_oggetto_da_window_oggetti (ref st_tab_menu_window_oggetti kst_tab_menu_window_oggetti);//
//--- Trova il nome Oggetto che gestisce la Funzione del tipo 'KUF_CLIENTI'
//--- inp: id_menu_window, funzione ( se spazio piglia il primo Kuf_... per id )
//--- out: nome_oggetto 
//
boolean k_return=false
integer k_ctr=0, k_pos=0


	k_ctr++
	k_pos = 0
	do while upperbound(kguo_g.kGst_tab_menu_window_oggetti[]) >= k_ctr and k_pos = 0 
		
		if kguo_g.kGst_tab_menu_window_oggetti[k_ctr].id > 0 then
			if trim(kguo_g.kGst_tab_menu_window_oggetti[k_ctr].id_menu_window) = trim(kst_tab_menu_window_oggetti.id_menu_window) then
				
				if trim(kst_tab_menu_window_oggetti.funzione) > " " then
					k_pos = pos(trim(kguo_g.kGst_tab_menu_window_oggetti[k_ctr].funzione), trim(kst_tab_menu_window_oggetti.funzione), 1) 
				else
					k_pos = 1  //ESCO X OK!
				end if
				
			end if
		end if
		k_ctr++				
		
	loop
	if k_pos > 0 then
		k_return=true	
		kst_tab_menu_window_oggetti.nome_oggetto = trim(kguo_g.kGst_tab_menu_window_oggetti[k_ctr - 1].nome_oggetto)
	end if
	
	
	
return k_return

end function

public function string get_anteprima_nome_id_tabella (ref string a_id_menu_window) throws uo_exception;//
//--- Trova il dato NOME_ID_TABELLA (nome del campo codice univoco della tabella coinvolta es. id_cliente) 
//--- inp: id_menu_window
//--- Rit: nome_id_tabella  (se spazio = NON TROVATO)
//---
//
string k_return = ""
int k_ctr=1
st_esito kst_esito
st_tab_menu_window_anteprima kst_tab_menu_window_anteprima


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

a_id_menu_window = trim(a_id_menu_window)

do while kgst_tab_menu_window_anteprima[k_ctr].id_menu_window <> a_id_menu_window &
			and kgst_tab_menu_window_anteprima[k_ctr].anteprima <> "FINE" and k_ctr < 100
	k_ctr ++
loop

if k_ctr = 99 then
	kst_esito.esito = kkg_esito.ko  
	kst_esito.sqlcode = 0
	kst_esito.sqlerrtext = "Errore ricerca in array 'Anteprima' superato il limite massimo = " + string(k_ctr)
	kguo_exception.inizializza()
	kguo_exception.set_esito(kst_esito)
	kguo_exception.messaggio_utente( )
else
	if kgst_tab_menu_window_anteprima[k_ctr].id_menu_window = a_id_menu_window  then
		if trim(kgst_tab_menu_window_anteprima[k_ctr].nome_id_tabella) > " " then
			k_return = trim(kgst_tab_menu_window_anteprima[k_ctr].nome_id_tabella)  // OK TROVATO!!!!
		end if
	end if
end if


//  SELECT menu_window_anteprima.id,   
//         menu_window_anteprima.anteprima,   
//         menu_window_anteprima.nome_id_tabella,   
//         menu_window_anteprima.id_menu_window  
//    INTO :ast_tab_menu_window_anteprima.id,   
//         :ast_tab_menu_window_anteprima.anteprima,   
//         :ast_tab_menu_window_anteprima.nome_id_tabella,   
//         :ast_tab_menu_window_anteprima.id_menu_window  
//    FROM menu_window_anteprima  
//   WHERE menu_window_anteprima.anteprima = :ast_tab_menu_window_anteprima.anteprima   
//				using kguo_sqlca_db_magazzino;
//	
//	if kguo_sqlca_db_magazzino.sqlcode < 0 then
//		kst_esito.esito = kkg_esito.db_ko   // forse
//		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//		kst_esito.sqlerrtext = "Errore tabella 'Anteprime' (menu_window_anteprima). id_menu_window=" + string(ast_tab_menu_window_anteprima.anteprima)
//		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
//	end if
	
	
return k_return

end function

on kuf_menu.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_menu.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

