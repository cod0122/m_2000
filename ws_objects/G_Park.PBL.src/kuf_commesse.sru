$PBExportHeader$kuf_commesse.sru
forward
global type kuf_commesse from nonvisualobject
end type
end forward

global type kuf_commesse from nonvisualobject
end type
global kuf_commesse kuf_commesse

forward prototypes
public function string tb_delete (long k_id_commessa)
public function string tb_delete_1 (readonly string k_scelta, long k_id_commessa, string k_key_str)
public function string tb_delete_prev (long k_id_commessa, integer k_id_fase)
public function string tb_delete_lav (readonly string k_scelta, long k_id_lav)
end prototypes

public function string tb_delete (long k_id_commessa);//
//====================================================================
//=== Cancella il rek dalla tabella Clienti e Clienti_sped
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
string k_rag_soc, k_stato_desc
datetime k_data
long k_nro_commessa
char k_stato


//=== Controllo se nelle COMMESSE ci sono clienti
DECLARE commesse CURSOR FOR  
  SELECT 
  			"commesse"."nro_commessa",
  			"commesse"."data",
  			"commesse"."stato",
  			"clienti"."rag_soc_1"
    FROM ("commesse" left outer join "clienti" on
	 		 "commesse"."id_cliente" = "clienti"."id_cliente")
   WHERE "commesse"."id_commessa" = :k_id_commessa ;

open commesse;
if sqlca.sqlCode = 0 then

	fetch commesse INTO :k_nro_commessa, :k_data, :k_stato, :k_rag_soc ;

	if sqlca.sqlCode = 0 then
		
		choose case integer(k_stato)
			case 0
				k_stato_desc = " in fase di Creazione "
			case 1 to 7
				k_stato_desc = " Operativa (aperta) "
			case 8, 9
				k_stato_desc = " Chiusa "
		end choose
	else
		k_return = "1"
	end if

	close commesse;
else
	k_return = "1"
end if

//=== commessa non trovata
if k_return = "1" then
	k_return = "1" + "Mi spiace ma la Commessa " + &
		   string(k_nro_commessa, "#####") + " del " + &
		 	string(k_data, "dd/mm/yy") + "~n~r" + & 	
			"non e' stata trovata in archivio."
else
	if integer(k_stato) > 3 and integer(k_stato) < 8 then
		k_return = "2" + "Mi spiace ma la Commessa " + &
			   string(k_nro_commessa, "#####") + " del " + &
			 	string(k_data, "dd/mm/yy") + "~n~r" + &	
				"e' Operativa, l'operazione non e' stata autorizzata."
		
	else
		
		if isnull(k_rag_soc) then
			k_rag_soc = "Anagrafica NON in archivio"
		end if

		if messagebox ("Operazione Distruttiva", &
				"Confermi la cancellazione della Commessa " + k_stato_desc + "~n~r" + &
				string(k_nro_commessa, "#####") + " del " + &
				string(k_data, "dd/mm/yy") + " ~n~r" + &
				"di " + trim(k_rag_soc) + " ?~n~r", &
			 	question!, yesno!, 2) = 2 then
	
			k_return = "2Operazione annullata"
		end if
	end if
end if

//=== Se tutto OK e ho confermato allora DISTRUGGO
if left(k_return, 1) = "0" then
	
	delete from "commesse"
			where "id_commessa" = :k_id_commessa ;

	if sqlca.sqlCode <> 0 then

		k_return = "1" + SQLCA.SQLErrText

	else

		delete from "commesse_prev"
			where "id_commessa" = :k_id_commessa ;

		delete from "commesse_note"
			where "id_commessa" = :k_id_commessa ;

		delete from "commesse_fatture"
			where "id_commessa" = :k_id_commessa ;

		delete from "lav_art"
			where "id_commessa" = :k_id_commessa ;

		delete from "lav_int"
			where "id_commessa" = :k_id_commessa ;

		delete from "lav_est"
			where "id_commessa" = :k_id_commessa ;

		delete from "fatt_acq"
			where "id_commessa" = :k_id_commessa ;

		delete from "costi_art"
			where "id_commessa" = :k_id_commessa ;

		delete from "costi_cli"
			where "id_commessa" = :k_id_commessa ;
			
	end if
end if



return k_return
end function

public function string tb_delete_1 (readonly string k_scelta, long k_id_commessa, string k_key_str);//
//====================================================================
//=== Cancella il rek dalle tabelle correlate a COMMESSE 
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================
//
string k_return = "0 "
long k_key
int k_key_1

choose case k_scelta
		
	case "commesse_prev"
		k_key = long(k_key_str)
		tb_delete_prev(k_id_commessa, k_key)
						
	case "commesse_note"
		delete from "commesse_note"
				where "id_commessa" = :k_id_commessa  ;
						
	case "commesse_fatture"
		delete from "commesse_fatture"
				where "id_commessa" = :k_id_commessa  and 
						"id_fattura" = :k_key_str ;
						
	case "fatt_acq"
		delete from "fatt_acq"
				where "id_fattura" = :k_id_commessa  ;
						
	case "fatt_acq_riga"
		k_key_1 = integer(k_key_str)
		delete from "fatt_acq"
				where "id_fattura" = :k_id_commessa  and
						"id_riga" = :k_key_1 ;
	
	case else
		k_return = "1Errore strutturale Interno al programma scelta :~n~r" + &
						k_scelta + ", annotarsi l'errore e contattare il programmatore.~n~r" + &
						"Grazie per la collaborazione. Buon lavoro."
		
end choose

if sqlca.sqlCode <> 0 then

	k_return = "1" + SQLCA.SQLErrText

end if


return k_return
end function

public function string tb_delete_prev (long k_id_commessa, integer k_id_fase);//
//====================================================================
//=== Cancella il rek dalla tabella Clienti e Clienti_sped
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
string k_rag_soc, k_descrizione, k_art
datetime k_data


//=== Controllo se LAVORAZIONI
DECLARE commesse_1 CURSOR FOR  
  SELECT 
  			"descrizione",
  			"data_lav",
  			"clienti"."rag_soc_1"
    FROM ("lav_int" left outer join "clienti" on
	 		 "lav_int"."id_cliente" = "clienti"."id_cliente")
   WHERE "id_commessa" = :k_id_commessa and
			"id_fase" = :k_id_fase ;

DECLARE commesse_2 CURSOR FOR  
  SELECT 
  			"descrizione",
  			"data_lav",
  			"clienti"."rag_soc_1"
    FROM ("lav_est" left outer join "clienti" on
	 		 "lav_est"."id_cliente" = "clienti"."id_cliente")
   WHERE "id_commessa" = :k_id_commessa and
			"id_fase" = :k_id_fase ;

DECLARE commesse_3 CURSOR FOR  
  SELECT 
  			"lav_art"."descrizione",
  			"data_lav",
  			"articoli"."descrizione"
    FROM ("lav_art" left outer join "articoli" on
	 		 "lav_art"."id_art" = "articoli"."id_art")
   WHERE "id_commessa" = :k_id_commessa and
			"id_fase" = :k_id_fase ;


open commesse_1;
if sqlca.sqlCode = 0 then

	fetch commesse_1 INTO :k_descrizione, :k_data, :k_rag_soc ;

	if sqlca.sqlCode = 0 then
		
		if isnull(k_descrizione) then
			k_descrizione = "descrizione non fornita"
		end if
		if isnull(k_rag_soc) then
			k_rag_soc = "anagrafica non trovata"
		end if

		k_return = "1" + "Mi spiace ma la lavorazione ha gia' ~n~r" + &
				 "in carico dei costi come in data " + &
		 		 string(k_data, "dd/mm/yy") + "~n~r" + & 	
				 "di " + k_rag_soc + "~n~r" + &
				 "per " + k_descrizione + "~n~r" + &
				"non posso autorizzare l'operazione."
	end if

	close commesse_1;
end if

if left(k_return, 1) = "0" then
	open commesse_2;
	if sqlca.sqlCode = 0 then

		fetch commesse_2 INTO :k_descrizione, :k_data, :k_rag_soc ;

		if sqlca.sqlCode = 0 then
		
			if isnull(k_descrizione) then
				k_descrizione = "descrizione non fornita"
			end if
			if isnull(k_rag_soc) then
				k_rag_soc = "anagrafica non trovata"
			end if

			k_return = "1" + "Mi spiace ma la lavorazione ha gia' ~n~r" + &
					 "in carico dei costi come in data " + &
		 			 string(k_data, "dd/mm/yy") + "~n~r" + & 	
					 "di " + k_rag_soc + "~n~r" + &
					 "per " + k_descrizione + "~n~r" + &
					"non posso autorizzare l'operazione."
		end if

		close commesse_2;
	end if
end if

if left(k_return, 1) = "0" then
	open commesse_3;
	if sqlca.sqlCode = 0 then

		fetch commesse_3 INTO :k_descrizione, :k_data, :k_art ;

		if sqlca.sqlCode = 0 then
		
			if isnull(k_descrizione) then
				k_descrizione = "descrizione non fornita"
			end if
			if isnull(k_art) then
				k_art = "articolo non trovato"
			end if

			k_return = "1" + "Mi spiace ma la fase ha gia' ~n~r" + &
					 "in carico dei costi come in data " + & 
		 			 string(k_data, "dd/mm/yy") + "~n~r" + & 	
					 "articolo " + k_art + "~n~r" + &
					 "descrizione " + k_descrizione + "~n~r" + &
					"non posso autorizzare l'operazione."
		end if

		close commesse_3;
	end if
end if

//=== Se tutto OK e ho confermato allora DISTRUGGO
if left(k_return, 1) = "0" then
	
	delete from "commesse_prev"
				where "id_commessa" = :k_id_commessa  and 
						"id_fase" = :k_id_fase ;

	if sqlca.sqlCode <> 0 then

		k_return = "1" + SQLCA.SQLErrText
	end if
end if



return k_return		



end function

public function string tb_delete_lav (readonly string k_scelta, long k_id_lav);//
//====================================================================
//=== Cancella il rek dalle tabelle correlate a COMMESSE 
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================
//
string k_return = "0 "


choose case k_scelta
						
	case "lav_art", "lav"

		delete from "costi_art" 
				where "id_commessa" in 
					(select "id_commessa" from "lav_art"
						where  "id_lav" = :k_id_lav) and
				     "id_art" in 
					(select "id_art" from "lav_art"
						where  "id_lav" = :k_id_lav) ;
					
		delete from "lav_art"
				where  "id_lav" = :k_id_lav ;

	case "lav_int", "lav"

		delete from "costi_cli" 
				where "id_commessa" in 
					(select "id_commessa" from "lav_int"
						where  "id_lav" = :k_id_lav) and
				     "id_cliente" in 
					(select "id_cliente" from "lav_int"
						where  "id_lav" = :k_id_lav) ;

		delete from "lav_int"
				where "id_lav" = :k_id_lav;

	case "lav_est", "lav"
		delete from "lav_est"
				where "id_lav" = :k_id_lav;
	
	case else
		k_return = "1Errore strutturale Interno al programma scelta :~n~r" + &
						k_scelta + ", annotarsi l'errore e contattare il programmatore.~n~r" + &
						"Grazie per la collaborazione. Buon lavoro."
		
end choose

if sqlca.sqlCode <> 0 then

	k_return = "1" + SQLCA.SQLErrText

end if


return k_return
end function

on kuf_commesse.create
TriggerEvent( this, "constructor" )
end on

on kuf_commesse.destroy
TriggerEvent( this, "destructor" )
end on

