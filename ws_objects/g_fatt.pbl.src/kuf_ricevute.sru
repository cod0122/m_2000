$PBExportHeader$kuf_ricevute.sru
forward
global type kuf_ricevute from kuf_parent
end type
end forward

global type kuf_ricevute from kuf_parent
end type
global kuf_ricevute kuf_ricevute

type variables
//
public st_tab_ricevute kist_tab_ricevute

//--- Tipo Distinta
public constant string kki_rimessa_diretta = "0"
public constant string kki_RIBA = "2"
public constant string kki_bonifico = "3"
public constant string kki_mav = "4"
public constant string kki_altro = "5"
end variables

forward prototypes
public function double calcola_rata (long k_num_fatt, date k_data_fatt)
public function string tb_delete (long k_id)
public function string aggiorna_scadenza (ref st_tab_ricevute k_st_tab_ricevute)
public function string aggiorna_scadenza_1 (ref st_tab_ricevute k_st_tab_ricevute)
public function st_esito ric_gia_presentate ()
public function st_esito get_scadenze (ref st_tab_ricevute kst_tab_ricevute, ref st_ricevute_scadenze kst_ricevute_scadenze)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_ricevute kst_tab_ricevute)
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_ricevute kst_tab_ricevute)
public function st_esito anteprima_elenco (ref datastore kdw_anteprima, st_tab_ricevute kst_tab_ricevute)
public function st_esito tb_add (st_tab_ricevute kst_tab_riceute)
public function st_esito tb_update (st_tab_ricevute kst_tab_riceute)
public function st_esito crea_rate (st_tab_ricevute kst_tab_ricevute)
public function st_esito tb_delete_x_fatt (st_tab_ricevute kst_tab_ricevute)
public function boolean if_gia_presentate (st_tab_ricevute kst_tab_ricevute) throws uo_exception
private function date get_data_fine_mese (date k_data)
public function st_esito tb_update_num_data_fatt (st_tab_ricevute kst_tab_ricevute_old, st_tab_ricevute kst_tab_ricevute)
public function boolean link_call (ref datawindow adw_1, string a_campo_link) throws uo_exception
end prototypes

public function double calcola_rata (long k_num_fatt, date k_data_fatt);//
//--- calcolo importo rata rimanente per fattura
//
double k_rata=0, k_importo=0 


declare c_ric_importo cursor for
	select sum(rata), importo
		from ric
		where num_fatt = :k_num_fatt
   		   and data_fatt =:K_data_fatt
		group by importo	;
		
open c_ric_importo;
if sqlca.sqlcode = 0 then
	fetch c_ric_importo into :k_rata, :k_importo;
	close c_ric_importo;
end if


return (k_importo - k_rata)



end function

public function string tb_delete (long k_id);//
//====================================================================
//=== Cancella il rek dalla tabella IVA
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
integer k_sn=0
int k_rek_ok=0


//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

	
	delete from ric
		where id = :k_id
		using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = "1" + SQLCA.SQLErrText
	end if


//
////---- COMMIT....	
//	if kst_esito.esito = kkg_esito.db_ko then
//		if kst_tab_ricevute.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ricevute.st_tab_g_0.esegui_commit) then
//			kGuf_data_base.db_rollback_1( )
//		end if
//	else
//		if kst_tab_ricevute.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ricevute.st_tab_g_0.esegui_commit) then
//			kGuf_data_base.db_commit_1( )
//		end if
//	end if


return k_return
end function

public function string aggiorna_scadenza (ref st_tab_ricevute k_st_tab_ricevute);//
//====================================================================
//=== Marca come STAMPATA la Ricevuta
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
date k_data_st, k_data_fatt, k_scad
long k_num_fatt, k_clie, k_id
string k_flag_st

//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

k_id = k_st_tab_ricevute.id
k_data_st = k_st_tab_ricevute.data_st
k_data_fatt = k_st_tab_ricevute.data_fatt
k_scad = k_st_tab_ricevute.scad
k_num_fatt = k_st_tab_ricevute.num_fatt
k_flag_st = k_st_tab_ricevute.flag_st
k_clie = k_st_tab_ricevute.clie
	
//	update ric
//		set data_st = :k_st_tab_ricevute.data_st,
//		    flag_st = :k_st_tab_ricevute.flag_st
//		where scad = :k_st_tab_ricevute.scad
//		      and data_fatt = :k_st_tab_ricevute.data_fatt 
//		      and num_fatt = :k_st_tab_ricevute.num_fatt 
//		      and clie = :k_st_tab_ricevute.clie 
//		using sqlca;

	update ric
		set data_st = :k_data_st,
		    flag_st = :k_flag_st
		where id = :k_id
		using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = "1" + SQLCA.SQLErrText
	end if


return k_return
end function

public function string aggiorna_scadenza_1 (ref st_tab_ricevute k_st_tab_ricevute);//
//====================================================================
//=== Aggiorna + ricevute contemporaneamente
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
long k_id
int k_rc
string k_sql, k_virgola
pointer kp_oldpointer


//=== Puntatore Cursore da attesa.....
kp_oldpointer = SetPointer(HourGlass!)


//k_sn = messagebox("Elimina Categoria Omogenea :" + trim(k_id_catfi) ,&
//			"Vuoi cancellare eventuali righe Fattura abbinate a questa Categoria",&
//			question!, yesnocancel!) 

	k_id = k_st_tab_ricevute.id
	
	k_virgola = " "
	k_sql = " update ric set " 
	if not isnull(k_st_tab_ricevute.data_st) then
		k_sql = k_sql + k_virgola + "data_st = '" + string(k_st_tab_ricevute.data_st, "dd.mm.yyyy") + "' "
		k_virgola = ","
	end if
	if not isnull(k_st_tab_ricevute.flag_st) and LenA(trim(k_st_tab_ricevute.flag_st)) > 0 then
		if trim(k_st_tab_ricevute.flag_st) = "P" then
			k_sql = k_sql + k_virgola + "flag_st =  ' ' "
		else
			k_sql = k_sql + k_virgola + "flag_st =  '" + trim(k_st_tab_ricevute.flag_st) + "' "
		end if
		k_virgola = ","
	end if
	if not isnull(k_st_tab_ricevute.scad) then
		k_sql = k_sql + k_virgola + "scad =  '" + string(k_st_tab_ricevute.scad, "dd.mm.yyyy") + "' "
		k_virgola = ","
	end if
	if not isnull(k_st_tab_ricevute.dist) then
		k_sql = k_sql + k_virgola + "dist =  '" + trim(k_st_tab_ricevute.dist) + "' "
		k_virgola = ","
	end if
	if not isnull(k_st_tab_ricevute.tipo) then
		k_sql = k_sql + k_virgola + "tipo = '" + trim(k_st_tab_ricevute.tipo) + "' "
		k_virgola = ","
	end if
	
	k_sql = k_sql + "where id = " + string(k_id) + "   "
		
	EXECUTE immediate :k_sql using sqlca; 

	if sqlca.sqlcode <> 0 then
		k_return = "1" + SQLCA.SQLErrText
	else
		commit using sqlca;
	end if

	SetPointer(kp_oldpointer)


return k_return

end function

public function st_esito ric_gia_presentate ();//
//====================================================================
//=== 
//=== Leggo Ricevuta specifica
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=Esiste!; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//=== 
//====================================================================
//
st_esito kst_esito
int k_ctr=0



kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


//--- controllo se ci sono righe RIBA gia' presentate
	select count (*)   
		 into :k_ctr 
		 from ric
		 WHERE num_fatt = :kist_tab_ricevute.num_fatt
				 and data_fatt = :kist_tab_ricevute.data_fatt
				 and flag_st = 'S'
		 using sqlca;
		 
   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Scadenzario (kuf_ricevute.esiste)~n~r" + trim(sqlca.SQLErrText) 
		else
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura Scadenzario (kuf_ricevute.esiste)~n~r" + trim(sqlca.SQLErrText) 
		end if
	end if

return kst_esito

end function

public function st_esito get_scadenze (ref st_tab_ricevute kst_tab_ricevute, ref st_ricevute_scadenze kst_ricevute_scadenze);//
//--- restituisce Scadenze lette da tab SCADENZARIO
//--- input: struttura st_tab_ricevute  con num e data fattura 
//---           struttura st_ricevute_scadenze  con max 10 scadenze (importo+data) 
//---           st_esito standard
//
int k_ind = 0
boolean k_cursore_aperto = false
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_ricevute.num_fatt > 0 then
	
	declare get_scadenze_c1 cursor for
               select 
                          SCAD,
                          RATA
                     from  ric 
                     where NUM_FATT   = :kst_tab_ricevute.NUM_FATT
                           and DATA_FATT = :kst_tab_ricevute.DATA_FATT
			 using sqlca;
									
//--- ciclo lettura totali imponibili
	open get_scadenze_c1;
	if sqlca.sqlcode = 0 then
		k_cursore_aperto = true
		
		fetch get_scadenze_c1 into
			:kst_tab_ricevute.scad
			,:kst_tab_ricevute.rata;

		do while sqlca.sqlcode = 0 and k_ind < 5

			k_ind++

			choose case k_ind
				case 1
					if kst_tab_ricevute.rata > 0 then
						kst_ricevute_scadenze.importo_1 =   kst_tab_ricevute.rata
						kst_ricevute_scadenze.data_1 =   kst_tab_ricevute.scad
					else
						kst_ricevute_scadenze.importo_1 =   0
					end if
				case 2
					if kst_tab_ricevute.rata > 0 then
						kst_ricevute_scadenze.importo_2 =   kst_tab_ricevute.rata
						kst_ricevute_scadenze.data_2 =   kst_tab_ricevute.scad
					else
						kst_ricevute_scadenze.importo_2 =   0
					end if
				case 3
					if kst_tab_ricevute.rata > 0 then
						kst_ricevute_scadenze.importo_3 =   kst_tab_ricevute.rata
						kst_ricevute_scadenze.data_3 =   kst_tab_ricevute.scad
					else
						kst_ricevute_scadenze.importo_3 =   0
					end if
				case 4
					if kst_tab_ricevute.rata > 0 then
						kst_ricevute_scadenze.importo_4 =   kst_tab_ricevute.rata
						kst_ricevute_scadenze.data_4 =   kst_tab_ricevute.scad
					else
						kst_ricevute_scadenze.importo_4 =   0
					end if
				case 5
					if kst_tab_ricevute.rata > 0 then
						kst_ricevute_scadenze.importo_5 =   kst_tab_ricevute.rata
						kst_ricevute_scadenze.data_5 =   kst_tab_ricevute.scad
					else
						kst_ricevute_scadenze.importo_5 =   0
					end if
				case 6
					if kst_tab_ricevute.rata > 0 then
						kst_ricevute_scadenze.importo_6 =   kst_tab_ricevute.rata
						kst_ricevute_scadenze.data_6 =   kst_tab_ricevute.scad
					else
						kst_ricevute_scadenze.importo_6 =   0
					end if
				case 7
					if kst_tab_ricevute.rata > 0 then
						kst_ricevute_scadenze.importo_7 =   kst_tab_ricevute.rata
						kst_ricevute_scadenze.data_7 =   kst_tab_ricevute.scad
					else
						kst_ricevute_scadenze.importo_7 =   0
					end if
				case 8
					if kst_tab_ricevute.rata > 0 then
						kst_ricevute_scadenze.importo_8 =   kst_tab_ricevute.rata
						kst_ricevute_scadenze.data_8 =   kst_tab_ricevute.scad
					else
						kst_ricevute_scadenze.importo_8 =   0
					end if
				case 9
					if kst_tab_ricevute.rata > 0 then
						kst_ricevute_scadenze.importo_9 =   kst_tab_ricevute.rata
						kst_ricevute_scadenze.data_9 =   kst_tab_ricevute.scad
					else
						kst_ricevute_scadenze.importo_9 =   0
					end if
				case 10
					if kst_tab_ricevute.rata > 0 then
						kst_ricevute_scadenze.importo_10 =   kst_tab_ricevute.rata
						kst_ricevute_scadenze.data_10 =   kst_tab_ricevute.scad
					else
						kst_ricevute_scadenze.importo_10 =   0
					end if
				case else
					kst_esito.sqlcode = 0
					kst_esito.SQLErrText = "Scadenze documento n. " + string(kst_tab_ricevute.NUM_FATT ) + " del " + string(kst_tab_ricevute.DATA_FATT ) + " (ric) " &
												 + ": Attenzione Troppe Scadenze.  "
					kst_esito.esito = kkg_esito.err_logico
			end choose

				
			fetch get_scadenze_c1 into
				:kst_tab_ricevute.scad
				,:kst_tab_ricevute.rata;
		loop


	end if

	
	if k_ind = 0 then
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Scadenze del documento  n. " + string(kst_tab_ricevute.NUM_FATT ) + " del " + string(kst_tab_ricevute.DATA_FATT ) + " (ric) " &
										 + trim(SQLCA.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.SQLErrText = "Mancano le " + kst_esito.SQLErrText
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.db_wrn
				else	
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if
	else
		if sqlca.sqlcode < 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Scadenze Ricevute Fattura n. " + string(kst_tab_ricevute.NUM_FATT ) + " del " + string(kst_tab_ricevute.DATA_FATT ) + " (ric) " &
										 + trim(SQLCA.SQLErrText)
			kst_esito.esito = kkg_esito.db_ko
		end if
	end if
else
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Manca numero Fattura per Scadenze Ricevute  (ric) " 
	kst_esito.esito = kkg_esito.err_logico
end if

if k_cursore_aperto then
 	close get_scadenze_c1;
end if

return kst_esito

end function

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_ricevute kst_tab_ricevute);//
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
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_ricevute.id > 0 then

		kdw_anteprima.dataobject = "d_ricevute"		
		kdw_anteprima.settransobject(sqlca)

		kuf1_utility = create kuf_utility
		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_ricevute.id)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Ricevuta da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_ricevute kst_tab_ricevute);//
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
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_ricevute.id > 0 then

		kdw_anteprima.dataobject = "d_ricevute"		
		kdw_anteprima.settransobject(sqlca)

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_ricevute.id)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Ricevuta da visualizzare: ~n~r" + "nessun codice indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima_elenco (ref datastore kdw_anteprima, st_tab_ricevute kst_tab_ricevute);//
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
kst_open_w.flag_modalita = kkg_flag_modalita.anteprima
kst_open_w.id_programma = kkg_id_programma_anag

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_ricevute.num_fatt > 0 then

		kdw_anteprima.dataobject = "d_ric_l_in_fattura"		
		kdw_anteprima.settransobject(sqlca)

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_ricevute.num_fatt, kst_tab_ricevute.data_fatt)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessuna Ricevuta da visualizzare: ~n~r" + "nessun numero indicato"
		kst_esito.esito = kkg_esito.not_fnd
		
	end if
end if


return kst_esito

end function

public function st_esito tb_add (st_tab_ricevute kst_tab_riceute);//====================================================================
//=== Carica Ricevuta 
//=== 
//=== Input: st_tab_ricevute  
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
//
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



	if isnull(kst_tab_riceute.SCAD) then
		kst_tab_riceute.SCAD = date(0)
	end if
//ID,
	insert into RIC
						(
						 NUM_FATT,
						 DATA_FATT,
						 CLIE,
						 SCAD,
						 DIST,
						 TIPO,
						 DATA_ST,
						 FLAG_ST,
						 RATA,
						 IMPORTO
						)
				values
						(
						 :kst_tab_riceute.NUM_FATT,
						 :kst_tab_riceute.DATA_FATT,
						 :kst_tab_riceute.CLIE,
						 :kst_tab_riceute.SCAD,
						 :kst_tab_riceute.DIST,
						 :kst_tab_riceute.TIPO,
						 :kst_tab_riceute.DATA_ST,
						 :kst_tab_riceute.FLAG_ST,
						 :kst_tab_riceute.RATA,
						 :kst_tab_riceute.IMPORTO
						)
		using sqlca;
		 
   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Scadenzario (kuf_ricevute.esiste)~n~r" + trim(sqlca.SQLErrText) 
		else
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura Scadenzario (kuf_ricevute.esiste)~n~r" + trim(sqlca.SQLErrText) 
		end if
	end if
		
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kst_tab_riceute.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_riceute.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		if kst_tab_riceute.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_riceute.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if
		
         
 
return kst_esito


end function

public function st_esito tb_update (st_tab_ricevute kst_tab_riceute);//====================================================================
//=== Carica Ricevuta 
//=== 
//=== Input: st_tab_ricevute  
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
//
boolean k_rc
st_esito kst_esito
st_open_w kst_open_w



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



	if isnull(kst_tab_riceute.SCAD) then
		kst_tab_riceute.SCAD = date(0)
	end if

                            
	update RIC
			 set
				  RIC.NUM_FATT   = :kst_tab_riceute.NUM_FATT,
				  RIC.DATA_FATT  = :kst_tab_riceute.DATA_FATT,
				  RIC.CLIE       = :kst_tab_riceute.CLIE,
				  RIC.SCAD       = :kst_tab_riceute.SCAD,
				  RIC.DIST       = :kst_tab_riceute.DIST,
				  RIC.TIPO       = :kst_tab_riceute.TIPO,
				  RIC.DATA_ST    = :kst_tab_riceute.DATA_ST,
				  RIC.FLAG_ST    = :kst_tab_riceute.FLAG_ST,
				  RIC.RATA       = :kst_tab_riceute.RATA,
				  RIC.IMPORTO    = :kst_tab_riceute.IMPORTO
			 where id  = :kst_tab_riceute.id  
			using sqlca;

		 
   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Scadenzario (kuf_ricevute.esiste)~n~r" + trim(sqlca.SQLErrText) 
		else
			kst_esito.esito = kkg_esito.not_fnd
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura Scadenzario (kuf_ricevute.esiste)~n~r" + trim(sqlca.SQLErrText) 
		end if
	end if

//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kst_tab_riceute.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_riceute.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		if kst_tab_riceute.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_riceute.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if


return kst_esito


end function

public function st_esito crea_rate (st_tab_ricevute kst_tab_ricevute);//====================================================================
//=== Crea Rate della Fattura 
//=== 
//=== Input: st_tab_ricevute  
//=== Ritorna tab. ST_ESITO, Esiti:  STANDARD; 
//=== 
//====================================================================
//
boolean k_rc
int k_ctr, k_fatt_nr_mese, k_rata_nr_mesi, k_fatt_anno, k_fatt_nr_gg
//double K_RATA, K_RATA_1
dec{2} K_RATA, K_RATA_1
date k_scad_no_gg_ulteriori
st_tab_arfa kst_tab_arfa
st_tab_pagam kst_tab_pagam
st_tab_clienti kst_tab_clienti
st_fattura_totali kst_fattura_totali
st_esito kst_esito
st_open_w kst_open_w
kuf_fatt kuf1_fatt
kuf_clienti kuf1_clienti
kuf_ausiliari kuf1_ausiliari



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuf1_fatt = create kuf_fatt
kuf1_ausiliari = create kuf_ausiliari
kuf1_clienti = create kuf_clienti


kst_tab_arfa.num_fatt = kst_tab_ricevute.num_fatt 
kst_tab_arfa.data_fatt = kst_tab_ricevute.data_fatt 

//--- Piglia ID fattura
kst_esito = kuf1_fatt.get_id( kst_tab_arfa )
if kst_esito.esito = kkg_esito.ok then	
		
//--- legge i dati di Testata della fattura
	kst_esito = kuf1_fatt.get_testata( kst_tab_arfa )
	if kst_esito.esito = kkg_esito.ok then	
	
//--- legge il Totale della fattura
		kst_fattura_totali.totale = 0
		if kst_tab_arfa.tipo_doc = kuf1_fatt.kki_tipo_doc_fattura then
		
			kst_esito = kuf1_fatt.get_totali( kst_tab_arfa,  kst_fattura_totali )
			
		end if
		
	end if
	
end if

if kst_esito.esito = kkg_esito.ok then	

	if kst_fattura_totali.totale > 0 then
		
//--- legge il Tipo Pagamento
		kst_tab_pagam.codice = kst_tab_arfa.cod_pag 
		kst_esito = kuf1_ausiliari.tb_select(  kst_tab_pagam ) 
		if kst_esito.esito = kkg_esito.ok then	

//--- legge il Tipo Banca dal cliente
			kst_tab_clienti.codice = kst_tab_arfa.clie_3
			kuf1_clienti.get_tipo_banca(  kst_tab_clienti )
			
//--- calcolo RATE
			kst_tab_ricevute.clie = kst_tab_arfa.clie_3

//--- Calcolo importo della prima rata
			if kst_tab_pagam.RATE > 1 then
				K_RATA = kst_fattura_totali.totale / kst_tab_pagam.RATE
				K_RATA_1 = round(K_RATA + kst_fattura_totali.totale - K_RATA * kst_tab_pagam.RATE, 2)
			else
				K_RATA_1  = kst_fattura_totali.totale
				K_RATA    = 0
			end if
			kst_tab_ricevute.rata = K_RATA_1
			 
//--- calcolo data prima scadenza
			k_fatt_nr_gg = day(kst_tab_ricevute.data_fatt) 
			k_fatt_nr_mese = month(kst_tab_ricevute.data_fatt) 
			k_fatt_anno = year(kst_tab_ricevute.data_fatt) 
			if kst_tab_pagam.gg_1_rata >= 30 then 
				k_rata_nr_mesi = kst_tab_pagam.gg_1_rata / 30
				k_rata_nr_mesi = k_rata_nr_mesi + k_fatt_nr_mese
				if k_rata_nr_mesi > 12 then
					k_rata_nr_mesi = k_rata_nr_mesi - 12
					k_fatt_anno ++
				end if
			else
				k_rata_nr_mesi = k_fatt_nr_mese 
			end if
			
			if kst_tab_pagam.gg_1_rata > 0 then
				
//--- se 1/2 mese (es. 45gg cioe' 30+15 gg) quindi il MOD di 30 maggiore di 0, allora imposto Fine-Mese o Meta-Mese:
				if k_fatt_nr_gg > 15 then 
					choose case k_rata_nr_mesi
						case 4, 6, 9, 11 // apr, giu, sett, nov
							if int(mod(kst_tab_pagam.gg_1_rata, 30)) > 1 or k_fatt_nr_gg > 30 then
								k_fatt_nr_gg = 30 
							end if
								
						case 2 // febbraio
							if int(mod(kst_tab_pagam.gg_1_rata, 30)) > 1 or k_fatt_nr_gg > 28 then
								k_fatt_nr_gg = day(relativedate(date(k_fatt_anno, 03, 01), - 1)) // a parte il bisestile dovrebbe venire 28
	//							k_fatt_nr_gg = 28 
							end if
						case else
							if int(mod(kst_tab_pagam.gg_1_rata, 30)) > 1 then
								k_fatt_nr_gg = 31
							end if
					end choose
				else
					if int(mod(kst_tab_pagam.gg_1_rata, 30)) > 1 then
						k_fatt_nr_gg = 15
					end if
				end if
			end if
			kst_tab_ricevute.scad = date  ( k_fatt_anno, k_rata_nr_mesi, k_fatt_nr_gg )

//--- Fine mese?
			if kst_tab_pagam.scad = kuf1_ausiliari.ki_tab_pagam_scade_fm then 
				kst_tab_ricevute.scad = get_data_fine_mese(kst_tab_ricevute.scad)
			end if

			k_scad_no_gg_ulteriori = kst_tab_ricevute.scad
//--- se indicati gg ulteriori li somma alla scadenza calcolata
			if kst_tab_pagam.gg_ulteriori > 0 then
				kst_tab_ricevute.scad = relativedate(kst_tab_ricevute.scad, kst_tab_pagam.gg_ulteriori )
			end if
			
			kst_tab_ricevute.data_st = date(0)
			kst_tab_ricevute.flag_st = " "
			kst_tab_ricevute.importo = kst_fattura_totali.totale
			kst_tab_ricevute.dist = kst_tab_pagam.tipo  // tipo distinta
			kst_tab_ricevute.tipo = kst_tab_clienti. tipo_banca 

//--- SCRIVE nuova rata		
			kst_tab_ricevute.st_tab_g_0.esegui_commit = "N"
			kst_esito = tb_add( kst_tab_ricevute )
			
			if kst_tab_pagam.gg_int > 0 then
				kst_tab_pagam.gg_1_rata = kst_tab_pagam.gg_int
			end if
			
			k_ctr = 1
			do while kst_esito.esito = kkg_esito.ok and  k_ctr < kst_tab_pagam.RATE
				

//--- calcolo date scad successive alla prima					
				k_fatt_nr_gg = day(k_scad_no_gg_ulteriori) 
				k_fatt_nr_mese = month(k_scad_no_gg_ulteriori) 
				k_fatt_anno = year(k_scad_no_gg_ulteriori) 
				if kst_tab_pagam.gg_1_rata >= 30 then 
					k_rata_nr_mesi = kst_tab_pagam.gg_1_rata / 30
					k_rata_nr_mesi = k_rata_nr_mesi + k_fatt_nr_mese
					if k_rata_nr_mesi > 12 then
						k_rata_nr_mesi = k_rata_nr_mesi - 12
						k_fatt_anno ++
					end if
				else
					k_rata_nr_mesi = k_fatt_nr_mese 
				end if
				
				if kst_tab_pagam.gg_1_rata > 0 then
//--- se 1/2 mese (es. 45gg cioe' 30+15 gg) quindi il MOD di 30 maggiore di 0, allora imposto Fine-Mese o Meta-Mese:
					if k_fatt_nr_gg > 15 then 
						choose case k_rata_nr_mesi
							case 4, 6, 9, 11 // apr, giu, sett, nov
								if int(mod(kst_tab_pagam.gg_1_rata, 30)) > 1 or k_fatt_nr_gg > 30 then
									k_fatt_nr_gg = 30 
								end if
									
							case 2 // febbraio
								if int(mod(kst_tab_pagam.gg_1_rata, 30)) > 1 or k_fatt_nr_gg > 28 then
									k_fatt_nr_gg = 28 
								end if
							case else
								if int(mod(kst_tab_pagam.gg_1_rata, 30)) > 1 then
									k_fatt_nr_gg = 31
								end if
						end choose
					else
						if int(mod(kst_tab_pagam.gg_1_rata, 30)) > 1 then
							k_fatt_nr_gg = 15
						end if
					end if
				end if
				kst_tab_ricevute.scad = date  ( k_fatt_anno, k_rata_nr_mesi, k_fatt_nr_gg )
//					kst_tab_ricevute.scad = relativedate(kst_tab_ricevute.data_fatt,  kst_tab_pagam.gg_1_rata)

//--- Fine mese?
				if kst_tab_pagam.scad = kuf1_ausiliari.ki_tab_pagam_scade_fm then 
					kst_tab_ricevute.scad = get_data_fine_mese(kst_tab_ricevute.scad)
				end if

//--- se indicati gg ulteriori li somma alla scadenza calcolata
				k_scad_no_gg_ulteriori = kst_tab_ricevute.scad
				if kst_tab_pagam.gg_ulteriori > 0 then
					kst_tab_ricevute.scad = relativedate(kst_tab_ricevute.scad, kst_tab_pagam.gg_ulteriori )
				end if
				
				kst_tab_ricevute.rata = K_RATA
				kst_tab_ricevute.data_st = date(0)
				kst_tab_ricevute.flag_st = " "
				kst_tab_ricevute.importo = kst_fattura_totali.totale
				kst_tab_ricevute.dist = kst_tab_pagam.tipo
				kst_tab_ricevute.tipo = kst_tab_clienti.tipo_banca
//--- SCRIVE nuova rata				
				kst_tab_ricevute.st_tab_g_0.esegui_commit = "N"
				kst_esito = tb_add( kst_tab_ricevute )
				
				k_ctr++
			loop

			
		end if
		
//---- COMMIT....	
		if kst_esito.esito = kkg_esito.db_ko then
			kGuf_data_base.db_rollback_1( )
		else
			kGuf_data_base.db_commit_1( )
		end if
		
	end if
end if



destroy kuf1_fatt
destroy kuf1_ausiliari 
destroy kuf1_clienti 
                            

return kst_esito


end function

public function st_esito tb_delete_x_fatt (st_tab_ricevute kst_tab_ricevute);//
//====================================================================
//=== 
//=== Cancella Ricevute x della fattura specifica
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK!; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//=== 
//====================================================================
//
st_esito kst_esito
int k_ctr=0



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//--- 
	delete 
		 from ric
		 WHERE num_fatt = :kst_tab_ricevute.num_fatt
				 and data_fatt = :kst_tab_ricevute.data_fatt
		 using sqlca;
		 
   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Cancellaz.Scadenze Fattura (kuf_ricevute.esiste)~n~r" + trim(sqlca.SQLErrText) 
		end if
	end if


//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kst_tab_ricevute.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ricevute.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		if kst_tab_ricevute.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ricevute.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if


return kst_esito

end function

public function boolean if_gia_presentate (st_tab_ricevute kst_tab_ricevute) throws uo_exception;//
//====================================================================
//=== 
//=== Verifica presenza se SCADENZE della Fattura sono già state 'Presentate'  
//=== 
//=== Input: st_tab_ricevute: numero+data fattura
//=== Ritorna boolean TRUE = PRESENTATE 
//=== scatena un errore se DB KO                                    
//=== 
//====================================================================
//
boolean k_return = false
st_esito kst_esito
uo_exception kuo_exception


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


select min(flag_st)
 into 
	:kst_tab_ricevute.flag_st
	from ric
	where 
		num_fatt = :kst_tab_ricevute.num_fatt
		and data_fatt = :kst_tab_ricevute.data_fatt
	using sqlca;

	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Scadenzario:" + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kuo_exception.set_esito( kst_esito )
		throw kuo_exception		
	end if

	if kst_tab_ricevute.flag_st = "S" then
		k_return = true
	end if

return k_return

end function

private function date get_data_fine_mese (date k_data);//--- 
//--- Calcola la data fine mese
//--- Inp: data di calcolo se NULL imposta data-oggi
//--- Out: data a fine mese
//--- 
date k_return, k_data_app
int k_mese, k_anno



if isnull(k_data) then k_data = kg_dataoggi

k_anno = year(k_data) 
k_mese = month(k_data) 
if k_mese = 12 then 
	k_mese = 1
	k_anno ++
else
	k_mese ++
end if

k_data_app = date(k_anno, k_mese, 01)
k_return = relativedate (k_data_app, -1) 



return k_return



end function

public function st_esito tb_update_num_data_fatt (st_tab_ricevute kst_tab_ricevute_old, st_tab_ricevute kst_tab_ricevute);//
//====================================================================
//=== 
//=== Modifica data/numero fattura delle Ricevute 
//=== 
//=== Inp: st_tab_ricevute_old  num e data fattura da ricoprire
//===        st_tab_ricevute  num e data fattura nuovi
//=== Ritorna tab. ST_ESITO
//=== 
//====================================================================
//
st_esito kst_esito
int k_ctr=0



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


//--- 
	update ric
			set num_fatt = :kst_tab_ricevute.num_fatt
				 , data_fatt = :kst_tab_ricevute.data_fatt
		 WHERE num_fatt = :kst_tab_ricevute_old.num_fatt
				 and data_fatt = :kst_tab_ricevute_old.data_fatt
		 using sqlca;
		 
   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Modifica Scadenze Fattura ~n~r" + trim(sqlca.SQLErrText) 
		end if
	end if

//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kst_tab_ricevute.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ricevute.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		if kst_tab_ricevute.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_ricevute.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if


return kst_esito

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


st_tab_ricevute kst_tab_ricevute
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

	case "id_ric"
		kst_tab_ricevute.id = adw_1.getitemnumber(adw_1.getrow(), a_campo_link)
		if kst_tab_ricevute.id > 0 then
	
			kst_esito = this.anteprima ( kdsi_elenco_output, kst_tab_ricevute )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "id Ricevuta: " + string(kst_tab_ricevute.id)
		else
			k_return = false
		end if

	case "b_ric_lotto" 
		kst_tab_ricevute.num_fatt = adw_1.getitemnumber(adw_1.getrow(), "num_fatt")
		if kst_tab_ricevute.num_fatt > 0 then
			kst_tab_ricevute.data_fatt = adw_1.getitemdate(adw_1.getrow(), "data_fatt")

			kst_esito = this.anteprima_elenco( kdsi_elenco_output, kst_tab_ricevute )
			if kst_esito.esito <> kkg_esito.ok then
				kguo_exception.inizializza( )
				kguo_exception.set_esito( kst_esito)
				throw kguo_exception
			end if
			kst_open_w.key1 = "Scadenze Fattura n. " + trim(string(kst_tab_ricevute.num_fatt)) + " / " + string(kst_tab_ricevute.data_fatt, "yyyy")
		else
			k_return = false
		end if

end choose

if k_return then

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//--- Parametri : 
	//--- struttura st_open_w
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.id_programma = kkg_id_programma_elenco //get_id_programma( kst_open_w.flag_modalita ) //kkg_id_programma_elenco
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

on kuf_ricevute.create
call super::create
end on

on kuf_ricevute.destroy
call super::destroy
end on

