$PBExportHeader$kuf_e1_wo_f5548014.sru
forward
global type kuf_e1_wo_f5548014 from kuf_parent
end type
end forward

global type kuf_e1_wo_f5548014 from kuf_parent
end type
global kuf_e1_wo_f5548014 kuf_e1_wo_f5548014

type variables
//
//--- Stato richiesto da E1 per la comunicazione del tipo operazione
constant string kki_stato_ev01_firstLoad = "1"		//primo barcode di inzio lav
constant string kki_stato_ev01_lastLoad = "2"			//ultimo barcode inizio lav
constant string kki_stato_ev01_firstUnload = "3" 	//primo barcode trattato
constant string kki_stato_ev01_lastUnload = "4"  	//ultimo barcode trattato
constant string kki_stato_ev01_QTdata = "5"   		//dati dosimetrici lotto

//--- definizione campo E1 tcicli_osmmcu x scambio dato Tipo-Cilco (Fila 1, Fila 2, Misto)
//constant string kki_tcicli_osmmcu_FILA1 = "27002"		//Fila 1 da E1 definito come IRRADIATOR A
//constant string kki_tcicli_osmmcu_FILA2 = "27005"		//Fila 2 da E1 definito come IRRADIATOR B
//constant string kki_tcicli_osmmcu_MISTO = "27006"		//File Miste da E1 definito come IRRADIATOR C
string kki_tcicli_osmmcu_FILA1 		//Fila 1 da E1 definito come IRRADIATOR A
string kki_tcicli_osmmcu_FILA2 		//Fila 2 da E1 definito come IRRADIATOR B
string kki_tcicli_osmmcu_MISTO 	//File Miste da E1 definito come IRRADIATOR C


end variables
forward prototypes
public subroutine _readme ()
public subroutine if_isnull (ref st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014)
public function integer set_datilav_f5548014 (st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014) throws uo_exception
public function integer u_set_datilav_toe1 () throws uo_exception
public function boolean if_esiste (st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014) throws uo_exception
public function integer u_allinea_datilav_e1 () throws uo_exception
public function boolean u_get_e1updts (ref st_tab_e1_wo_f5548014 ast_tab_e1_wo_f5548014) throws uo_exception
public function boolean tb_delete (readonly st_tab_e1_wo_f5548014 ast_tab_e1_wo_f5548014) throws uo_exception
public function st_esito u_batch_run () throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Oggetto collettore per lo scambio dati con il Work Order su E1 
//--- come ad esempio passare i dati di Lavorazione (inizio-fine-dosimetria)
//--- gestisce la tabella sul db interno 
end subroutine

public subroutine if_isnull (ref st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014);//
if isnull(kst_tab_e1_wo_f5548014.id_e1_wo_f5548014) then kst_tab_e1_wo_f5548014.id_e1_wo_f5548014 = 0		// ID
if isnull(kst_tab_e1_wo_f5548014.wo_osdoco) then kst_tab_e1_wo_f5548014.wo_osdoco = 0		//work order
if isnull(kst_tab_e1_wo_f5548014.flag_osev01) then kst_tab_e1_wo_f5548014.flag_osev01 = "" 	//tipo operazione
if isnull(kst_tab_e1_wo_f5548014.data_osa801) then kst_tab_e1_wo_f5548014.data_osa801 = kGuf_data_base.get_e1_dateformat(date(0))	//data
if isnull(kst_tab_e1_wo_f5548014.ora_oswwaet) then kst_tab_e1_wo_f5548014.ora_oswwaet = long(kGuf_data_base.get_e1_timeformat(time(0))) 	//ora
if isnull(kst_tab_e1_wo_f5548014.dosemin_os55gs25a) then kst_tab_e1_wo_f5548014.dosemin_os55gs25a = ""	//dose minima
if isnull(kst_tab_e1_wo_f5548014.dosemax_os55gs25b) then kst_tab_e1_wo_f5548014.dosemax_os55gs25b = ""	//dose massima
if isnull(kst_tab_e1_wo_f5548014.ciclo_os55gs25c) then kst_tab_e1_wo_f5548014.ciclo_os55gs25c = ""	//CYCLE 
if isnull(kst_tab_e1_wo_f5548014.osuser) then kst_tab_e1_wo_f5548014.osuser = ""	//utente 
if isnull(kst_tab_e1_wo_f5548014.e1updts) then kst_tab_e1_wo_f5548014.e1updts = datetime(date(0))
if isnull(kst_tab_e1_wo_f5548014.ngiri_ossetl) then kst_tab_e1_wo_f5548014.ngiri_ossetl = 0.0
if isnull(kst_tab_e1_wo_f5548014.tcicli_osmmcu) then kst_tab_e1_wo_f5548014.tcicli_osmmcu = ""

end subroutine

public function integer set_datilav_f5548014 (st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014) throws uo_exception;//
//------------------------------------------------------------------------------------
//--- Registra i dati per E1 circa i tempi di lavorazione e la dosimetria dei barcode 
//--- 
//--- inp: st_tab_e1_wo_f5548014 
//--- out:
//--- Ritorna: nr righe aggiornate
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------
int k_return
int k_righe
string k_nrusa
st_esito kst_esito
kds_e1_wo_f5548014 kds1_e1_wo_f5548014
kuf_utility kuf1_utility


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kds1_e1_wo_f5548014 = create kds_e1_wo_f5548014
	kuf1_utility = create kuf_utility
	
	if_isnull(kst_tab_e1_wo_f5548014)
	
	kds1_e1_wo_f5548014.settransobject(kguo_sqlca_db_magazzino)
	
	k_righe = kds1_e1_wo_f5548014.retrieve(kst_tab_e1_wo_f5548014.wo_osdoco, kst_tab_e1_wo_f5548014.flag_osev01)
	if k_righe < 0 then
	else
		if k_righe = 0 then
			kds1_e1_wo_f5548014.insertrow(0)
			kds1_e1_wo_f5548014.setitem(1, "id_e1_wo_f5548014", 0)		//ID
		end if
	
		kds1_e1_wo_f5548014.setitem(1, "wo_osdoco", kst_tab_e1_wo_f5548014.wo_osdoco)		//work order
		kds1_e1_wo_f5548014.setitem(1, "flag_osev01", kst_tab_e1_wo_f5548014.flag_osev01)  	//tipo operazione
		kds1_e1_wo_f5548014.setitem(1, "data_osa801", kst_tab_e1_wo_f5548014.data_osa801)		//data
		kds1_e1_wo_f5548014.setitem(1, "data_osdee", kst_tab_e1_wo_f5548014.data_osdee)		//data formato 'oracle'
		kds1_e1_wo_f5548014.setitem(1, "ora_oswwaet", kst_tab_e1_wo_f5548014.ora_oswwaet)	//ora
		k_nrusa = "0.00"
		if trim(kst_tab_e1_wo_f5548014.dosemin_os55gs25a) > " " then
			if isnumber(trim(kst_tab_e1_wo_f5548014.dosemin_os55gs25a)) then
				k_nrusa = kuf1_utility.u_num_itatousa(trim(kst_tab_e1_wo_f5548014.dosemin_os55gs25a))
			end if
		end if
		kds1_e1_wo_f5548014.setitem(1, "dosemin_os55gs25a", k_nrusa)	//dose minima
		k_nrusa = "0.00"
		if trim(kst_tab_e1_wo_f5548014.dosemax_os55gs25b) > " " then
			if isnumber(trim(kst_tab_e1_wo_f5548014.dosemax_os55gs25b)) then
				k_nrusa = kuf1_utility.u_num_itatousa(trim(kst_tab_e1_wo_f5548014.dosemax_os55gs25b))
			end if
		end if
		kds1_e1_wo_f5548014.setitem(1, "dosemax_os55gs25b", k_nrusa)	//dose massima
		kds1_e1_wo_f5548014.setitem(1, "ciclo_os55gs25c", kst_tab_e1_wo_f5548014.ciclo_os55gs25c)	//CYCLE 
		kds1_e1_wo_f5548014.setitem(1, "ngiri_ossetl", kst_tab_e1_wo_f5548014.ngiri_ossetl)	//N.GIRI 
		kds1_e1_wo_f5548014.setitem(1, "tcicli_osmmcu", kst_tab_e1_wo_f5548014.tcicli_osmmcu)	//Tipo CILCI (27002=fila 1 (A)/27005=fila 2 (B)/27006=misti (C))
		
		kst_tab_e1_wo_f5548014.e1updts = kguo_g.get_datetime_zero( ) // datetime(date(0))
		kds1_e1_wo_f5548014.setitem(1, "e1updts", kst_tab_e1_wo_f5548014.e1updts)	//CYCLE 
	
		k_righe = kds1_e1_wo_f5548014.u_update()
	end if
	if k_righe < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = k_righe
		kst_esito.SQLErrText = "Aggiornamento fallito in tabella dati lavorazione per E1 'e1_wo_F554814'. ~n~rWO (doco): "+string(kst_tab_e1_wo_f5548014.wo_osdoco)
		kguo_exception.inizializza()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

	k_return = k_righe

catch (uo_exception kuo_exception)
	if kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_rollback( )
	end if
	throw kuo_exception

finally
	if kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_e1_wo_f5548014.st_tab_g_0.esegui_commit) then
		kguo_sqlca_db_magazzino.db_commit( )
	end if
	if isvalid(kds1_e1_wo_f5548014) then destroy kds1_e1_wo_f5548014
	if isvalid(kuf1_utility) then destroy kuf1_utility
	
end try

return k_return

end function

public function integer u_set_datilav_toe1 () throws uo_exception;//
//------------------------------------------------------------------------------------------------
//--- Invia tutti i dati in sospeso a E1 circa i tempi di lavorazione e la dosimetria dei barcode 
//--- 
//--- inp: 
//--- out:
//--- Ritorna: nr righe aggiornate
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------------------
int k_return, k_rc
long k_righe_tot, k_riga
string k_string
st_esito kst_esito
st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014
st_tab_f5548014 kst_tab_f5548014, kst1_tab_f5548014
kuf_e1_f5548014 kuf1_e1_f5548014
datastore kds_e1_wo_f5548014_l_xe1

try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kuf1_e1_f5548014 = create kuf_e1_f5548014
	
	kds_e1_wo_f5548014_l_xe1 = create datastore
	kds_e1_wo_f5548014_l_xe1.dataobject = "ds_e1_wo_f5548014_l_xe1"
	kds_e1_wo_f5548014_l_xe1.settransobject(kguo_sqlca_db_magazzino)
	k_righe_tot = kds_e1_wo_f5548014_l_xe1.retrieve( )
	
	kst_tab_e1_wo_f5548014.e1updts = kGuf_data_base.prendi_dataora( )
	
	for k_riga = 1 to k_righe_tot

		kst_tab_f5548014.osdoco = kds_e1_wo_f5548014_l_xe1.getitemnumber(k_riga, "wo_osdoco")		//work order
		kst_tab_f5548014.osev01 = kds_e1_wo_f5548014_l_xe1.getitemstring(k_riga, "flag_osev01")  	//tipo operazione
		kst_tab_f5548014.osa801 = kds_e1_wo_f5548014_l_xe1.getitemstring(k_riga, "data_osa801")		//data
		kst_tab_f5548014.osdee = kds_e1_wo_f5548014_l_xe1.getitemnumber(k_riga, "data_osdee")		//data
		kst_tab_f5548014.oswwaet = kds_e1_wo_f5548014_l_xe1.getitemnumber(k_riga, "ora_oswwaet")	//ora
		kst_tab_f5548014.os55gs25a = kds_e1_wo_f5548014_l_xe1.getitemstring(k_riga, "dosemin_os55gs25a")	//dose minima
		kst_tab_f5548014.os55gs25b = kds_e1_wo_f5548014_l_xe1.getitemstring(k_riga, "dosemax_os55gs25b")	//dose massima
		kst_tab_f5548014.os55gs25c = kds_e1_wo_f5548014_l_xe1.getitemstring(k_riga, "ciclo_os55gs25c")	//CYCLE 
		kst_tab_f5548014.ossetl = kds_e1_wo_f5548014_l_xe1.getitemnumber(k_riga, "ngiri_ossetl")	//N.GIRI 

		k_string = trim(kds_e1_wo_f5548014_l_xe1.getitemstring(k_riga, "tcicli_osmmcu"))	//TIPI CICLI DA STRINGARE A DX (??)
		if k_string > " " then
			kst_tab_f5548014.osmmcu = space(12 - len(k_string)) + k_string
		else
			kst_tab_f5548014.osmmcu = space(12)
		end if
		
		kst_tab_f5548014.osuser = kds_e1_wo_f5548014_l_xe1.getitemstring(k_riga, "osuser")	//Utente 

//--- passo al peocesso di aggiornamento solo se sono su un record nuovo
		if kst_tab_f5548014.osdoco = kst1_tab_f5548014.osdoco and kst_tab_f5548014.osev01 = kst1_tab_f5548014.osev01 then
		else			
			kst1_tab_f5548014 = kst_tab_f5548014  // salva i dati per il controllo di cui sopra
				
			if not kuf1_e1_f5548014.if_esiste(kst_tab_f5548014) then
				try
					
					//--- Effettivo aggiornamento dei dati su E1
					kst_tab_f5548014.st_tab_g_0.esegui_commit = "N"
					kuf1_e1_f5548014.set_datilav_f5548014(kst_tab_f5548014)
			
					kds_e1_wo_f5548014_l_xe1.setitem(k_riga, "e1updts", kst_tab_e1_wo_f5548014.e1updts)	//data di aggiornamento a E1
			
					k_rc = kds_e1_wo_f5548014_l_xe1.update()
			
					if k_rc < 0 then
						kst_esito.esito = kkg_esito.db_ko
						kst_esito.sqlcode = k_return
						kst_esito.SQLErrText = "Aggiornamento data fallito in tabella dati lavorazione per E1 'e1_wo_F554814' ma dati E1 inviati correttamente. ~n~rWO (doco): "+string(kst_tab_e1_wo_f5548014.wo_osdoco)
						kguo_exception.inizializza()
						kguo_exception.set_esito (kst_esito)
						//throw kguo_exception
					end if
		
				catch (uo_exception kuo1_exception)
					
				
				finally
					kguo_sqlca_db_e1.db_commit( )
					kguo_sqlca_db_magazzino.db_commit( )
					k_return ++
				
				end try
			end if		
		end if		

	end for

	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_e1_f5548014) then destroy kuf1_e1_f5548014
	if isvalid(kds_e1_wo_f5548014_l_xe1) then destroy kds_e1_wo_f5548014_l_xe1
	
end try

return k_return

end function

public function boolean if_esiste (st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------------
//--- 
//--- Controlla esistenza Record
//--- 
//--- 
//--- Inp: st_tab_e1_wo_f5548014.wo_osdoco e kst_tab_e1_wo_f5548014.flag_osev01
//--- Out: TRUE = esiste
//---
//--- lancia exception
//---
//----------------------------------------------------------------------------------------------------------------
//
boolean k_return = false
long k_trovato=0
st_esito kst_esito



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = " "
kst_esito.nome_oggetto = this.classname()


//--- x numero spedicato			
	SELECT count(*)
			into :k_trovato
			 FROM e1_wo_f5548014  
			 where wo_osdoco  = :kst_tab_e1_wo_f5548014.wo_osdoco
			      and flag_osev01 = :kst_tab_e1_wo_f5548014.flag_osev01
			 using kguo_sqlca_db_magazzino ;
		
	if sqlca.sqlcode < 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Errore in verifica esistenza del record in tabella e1_wo_f5548014 (wo: '" + string(kst_tab_e1_wo_f5548014.wo_osdoco) + "' flag: '" + string(kst_tab_e1_wo_f5548014.flag_osev01) + "') " &
						 + "~n~rErrore: " + trim(SQLCA.SQLErrText)
									 
		kst_esito.esito = kkg_esito.db_ko
		
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	else
		if k_trovato > 0 then k_return = true
	end if
	

return k_return



end function

public function integer u_allinea_datilav_e1 () throws uo_exception;//
//------------------------------------------------------------------------------------------------
//--- Riallinea la data di aggiornamento a E1 rileggendo i dati di Lavorazione inviati a E1
//--- 
//--- inp: 
//--- out:
//--- Ritorna: nr righe aggiornate
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------------------
int k_return, k_rc, k_gg
long k_righe_tot, k_riga
string k_dato
date k_data_ini
boolean k_aggiorna = false
st_esito kst_esito
st_tab_e1_wo_f5548014 kst_tab_e1_wo_f5548014
st_tab_f5548014 kst_tab_f5548014
kuf_e1_f5548014 kuf1_e1_f5548014
kuf_base kuf1_base
datastore kds_e1_wo_f5548014_l_xdt


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
//--- recupera il num gg indietro da cui partire per l'elaborazione 	
	kuf1_base = create kuf_base
	k_dato = kuf1_base.prendi_dato_base("e1dtlav_allineagg")
	if left(k_dato,1) <> "0" then
		kst_esito.esito = kkg_esito.db_ko  
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = mid(k_dato,2)
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	else
		k_gg	= integer(mid(k_dato,2))
		if k_gg > 30 then // superiore a 30 sembrano un po' troppi!!
			k_gg = 30
		end if
	end if
	if isvalid(kuf1_base) then destroy kuf1_base 

	if k_gg > 0 then
		k_data_ini = relativedate(kguo_g.get_dataoggi( ), (-1 * k_gg))  // levo i giorni indicati in Proprietà
	else
		k_data_ini = kguo_g.get_dataoggi( )
	end if
	
	kuf1_e1_f5548014 = create kuf_e1_f5548014
	
	kds_e1_wo_f5548014_l_xdt = create datastore
	kds_e1_wo_f5548014_l_xdt.dataobject = "ds_e1_wo_f5548014_l_xdt"
	kds_e1_wo_f5548014_l_xdt.settransobject(kguo_sqlca_db_magazzino)
	k_righe_tot = kds_e1_wo_f5548014_l_xdt.retrieve(k_data_ini)
	
	
	for k_riga = 1 to k_righe_tot

		k_aggiorna = false
		kst_tab_e1_wo_f5548014.e1updts = kds_e1_wo_f5548014_l_xdt.getitemdatetime(k_riga, "e1updts")  	//ts di aggiornamento dei dati su E1

		kst_tab_f5548014.osdoco = kds_e1_wo_f5548014_l_xdt.getitemnumber(k_riga, "wo_osdoco")		//work order
		kst_tab_f5548014.osev01 = kds_e1_wo_f5548014_l_xdt.getitemstring(k_riga, "flag_osev01")  	//tipo operazione
//--- Verifica se i dati di lavorazione sono stati passati a E1
		if kuf1_e1_f5548014.if_esiste(kst_tab_f5548014) then
//--- se dati passati e update NON effettuato (mooooolto strano) allora forza l'update in tab M2000		
			if date(kst_tab_e1_wo_f5548014.e1updts) > kkg.DATA_NO then
			else
				k_aggiorna = true
				kst_tab_e1_wo_f5548014.e1updts = kGuf_data_base.prendi_dataora( )  // forza ts adesso!
			end if
		else
//--- se dati NON passati a E1 allora ripulisce il campo di update in tab M2000			
			if date(kst_tab_e1_wo_f5548014.e1updts) > kkg.DATA_NO then
				k_aggiorna = true
				kst_tab_e1_wo_f5548014.e1updts = datetime(date(0))  // forza ts a zero!
			end if
		end if

//--- data da aggiornare?
		if k_aggiorna then
	
			kds_e1_wo_f5548014_l_xdt.setitem(k_riga, "e1updts", kst_tab_e1_wo_f5548014.e1updts)	//data di aggiornamento a E1
	
			k_rc = kds_e1_wo_f5548014_l_xdt.update()
	
			if k_rc < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = k_return
				kst_esito.SQLErrText = "Aggiornamento data fallito in tabella dati lavorazione per E1 'e1_wo_F554814' ma dati E1 inviati correttamente. ~n~rWO (doco): "+string(kst_tab_e1_wo_f5548014.wo_osdoco)
				kguo_exception.inizializza()
				kguo_exception.set_esito (kst_esito)
				//throw kguo_exception
			else
				k_return ++ // record aggiornati
			end if


		end if
		
	end for

	kguo_sqlca_db_magazzino.db_commit( )

	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kuf1_e1_f5548014) then destroy kuf1_e1_f5548014
	if isvalid(kds_e1_wo_f5548014_l_xdt) then destroy kds_e1_wo_f5548014_l_xdt
	
end try

return k_return

end function

public function boolean u_get_e1updts (ref st_tab_e1_wo_f5548014 ast_tab_e1_wo_f5548014) throws uo_exception;//
//------------------------------------------------------------------------------------------------
//--- Recupera la data di aggiornamento dei dati a E1
//--- 
//--- inp: ast_tab_e1_wo_f5548014 wo_osdoco, flag_osev01
//--- out: ast_tab_e1_wo_f5548014.e1updts
//--- Ritorna: TRUE = data e1updts valorizzata x cui è stato trasferito a E1
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if ast_tab_e1_wo_f5548014.wo_osdoco > 0 and ast_tab_e1_wo_f5548014.flag_osev01 > " " then

	
		select e1_wo_f5548014.e1updts
		   into :ast_tab_e1_wo_f5548014.e1updts
		   from e1_wo_f5548014
			where e1_wo_f5548014.wo_osdoco = :ast_tab_e1_wo_f5548014.wo_osdoco
			      and e1_wo_f5548014.flag_osev01 = :ast_tab_e1_wo_f5548014.flag_osev01
			using kguo_sqlca_db_magazzino ;
			
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in lettura data di invio a E1 dei dati di lavorazione (tab 'e1_wo_F554814').~n~r"&
			          + "Codice cercato: wo_osdoco: " + string(ast_tab_e1_wo_f5548014.wo_osdoco) + " " &
						 + "flag_osev01: " + string(ast_tab_e1_wo_f5548014.flag_osev01) + "~n~r" &
						 + string(kguo_sqlca_db_magazzino.sqlcode) + " " + trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza()
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
		
		if date(ast_tab_e1_wo_f5548014.e1updts) > kkg.data_zero then
			k_return = true
		end if
		
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Lettura data di invio a E1 dei dati di lavorazione (tab 'e1_wo_F554814') non effettuata, manca il codice (osdoco, flag osev01)."
		kguo_exception.inizializza()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return k_return

end function

public function boolean tb_delete (readonly st_tab_e1_wo_f5548014 ast_tab_e1_wo_f5548014) throws uo_exception;//
//------------------------------------------------------------------------------------------------
//--- Rimuove riga dati di trattamento per E1
//--- 
//--- inp: ast_tab_e1_wo_f5548014 wo_osdoco, flag_osev01
//--- out: 
//--- Ritorna: TRUE = riga rimossa
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------------------
boolean k_return=false
st_esito kst_esito


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	if ast_tab_e1_wo_f5548014.wo_osdoco > 0 and ast_tab_e1_wo_f5548014.flag_osev01 > " " then

		delete 
		   from e1_wo_f5548014
			where e1_wo_f5548014.wo_osdoco = :ast_tab_e1_wo_f5548014.wo_osdoco
			      and e1_wo_f5548014.flag_osev01 = :ast_tab_e1_wo_f5548014.flag_osev01
			using kguo_sqlca_db_magazzino ;
			
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore in Rimozione riga dati di lavorazione per E1 (tab 'e1_wo_F554814').~n~r"&
			          + "Codice da rimuovere: wo_osdoco: " + string(ast_tab_e1_wo_f5548014.wo_osdoco) + " " &
						 + "flag_osev01: " + string(ast_tab_e1_wo_f5548014.flag_osev01) + "~n~r" &
						 + string(kguo_sqlca_db_magazzino.sqlcode) + " " + trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza()
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
		
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			k_return = true
		end if
		
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Rimozione riga dati lavorazione per E1 (tab 'e1_wo_F554814') non effettuata, manca il codice (osdoco, flag osev01)."
		kguo_exception.inizializza()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	
end try

return k_return

end function

public function st_esito u_batch_run () throws uo_exception;//---
//--- Lancio operazioni Batch
//---
int k_ctr
st_esito kst_esito


try 

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

//--- Invio dati trattamento/dosimetria a E1
	k_ctr = u_set_datilav_toe1( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." &
				+ "Sono stati inviati " + string(k_ctr) + " record dati di 'irraggiamento' al Sistema E-ONE" 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessun dato di 'irraggiamento' disponibile per E-ONE."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

on kuf_e1_wo_f5548014.create
call super::create
end on

on kuf_e1_wo_f5548014.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kki_tcicli_osmmcu_FILA1 = trim(kguo_g.E1MCU) + "02" //Fila 1 da E1 definito come IRRADIATOR A
kki_tcicli_osmmcu_FILA2 = trim(kguo_g.E1MCU) + "05"//Fila 2 da E1 definito come IRRADIATOR B
kki_tcicli_osmmcu_MISTO = trim(kguo_g.E1MCU) + "06" //File Miste da E1 definito come IRRADIATOR C

end event

