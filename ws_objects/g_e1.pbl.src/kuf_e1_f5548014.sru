$PBExportHeader$kuf_e1_f5548014.sru
forward
global type kuf_e1_f5548014 from kuf_parent
end type
end forward

global type kuf_e1_f5548014 from kuf_parent
end type
global kuf_e1_f5548014 kuf_e1_f5548014

type variables
////
////--- Stato richiesto da E1 per la comunicazione del tipo operazione
//constant string kki_stato_ev01_firstLoad = "1"		//primo barcode di inzio lav
//constant string kki_stato_ev01_lastLoad = "2"			//ultimo barcode inizio lav
//constant string kki_stato_ev01_firstUnload = "3" 	//primo barcode trattato
//constant string kki_stato_ev01_lastUnload = "4"  	//ultimo barcode trattato
//constant string kki_stato_ev01_QTdata = "5"   		//dati dosimetrici lotto
//
end variables

forward prototypes
public subroutine _readme ()
public function integer set_datilav_f5548014 (st_tab_f5548014 kst_tab_f5548014) throws uo_exception
public subroutine if_isnull (ref st_tab_f5548014 kst_tab_f5548014)
public function boolean if_esiste (st_tab_f5548014 kst_tab_f5548014) throws uo_exception
end prototypes

public subroutine _readme ();//
//--- Oggetto per lo scambio dati con il Work Order su E1 
//--- come ad esempio passare i dati di Lavorazione (inizio-fine-dosimetria)
//
end subroutine

public function integer set_datilav_f5548014 (st_tab_f5548014 kst_tab_f5548014) throws uo_exception;//
//------------------------------------------------------------------------------------
//--- Registra i dati per E1 circa i tempi di lavorazione e la dosimetria dei barcode 
//--- 
//--- inp: st_tab_f5548014 
//--- out:
//--- Ritorna: nr righe aggiornate
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------
int k_return
st_esito kst_esito
kds_e1_f5548014 kds1_e1_f5548014


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kds1_e1_f5548014 = create kds_e1_f5548014
	
	kds1_e1_f5548014.db_connetti( )
	kds1_e1_f5548014.reset( )
	kds1_e1_f5548014.insertrow(0)
	
	if_isnull(kst_tab_f5548014)
	
	kds1_e1_f5548014.setitem(1, "osdoco", kst_tab_f5548014.osdoco)		//work order
	kds1_e1_f5548014.setitem(1, "osev01", kst_tab_f5548014.osev01)  	//tipo operazione
	kds1_e1_f5548014.setitem(1, "osa801", kst_tab_f5548014.osa801)		//data
	kds1_e1_f5548014.setitem(1, "osdee", kst_tab_f5548014.osdee)		//data formato E1
	kds1_e1_f5548014.setitem(1, "oswwaet", kst_tab_f5548014.oswwaet)	//ora
	if isnull(kst_tab_f5548014.os55gs25a) then
		kds1_e1_f5548014.setitem(1, "os55gs25a", " ")
	else
		kds1_e1_f5548014.setitem(1, "os55gs25a", kst_tab_f5548014.os55gs25a)	//dose minima
	end if	
	if isnull(kst_tab_f5548014.os55gs25a) then
		kds1_e1_f5548014.setitem(1, "os55gs25b", " ")
	else
		kds1_e1_f5548014.setitem(1, "os55gs25b", kst_tab_f5548014.os55gs25b)	//dose massima
	end if	
	if isnull(kst_tab_f5548014.os55gs25a) then
		kds1_e1_f5548014.setitem(1, "os55gs25c", " ")
	else
		kds1_e1_f5548014.setitem(1, "os55gs25c", kst_tab_f5548014.os55gs25c)	//CYCLE 
	end if	
	if isnull(kst_tab_f5548014.ossetl) then
		kds1_e1_f5548014.setitem(1, "ossetl", 0.00)
	else
		kds1_e1_f5548014.setitem(1, "ossetl", kst_tab_f5548014.ossetl)	//N.GIRI 
	end if	
	if isnull(kst_tab_f5548014.osmmcu) then
		kds1_e1_f5548014.setitem(1, "osmmcu", " ")
	else
		kds1_e1_f5548014.setitem(1, "osmmcu", kst_tab_f5548014.osmmcu)	//TIPI CICLI 
	end if	
	
// kds1_e1_f5548014.setitem(1, "osuser", kst_tab_f5548014.osuser)	//Utente  22082016 NIENTE su richiesta per test da Karen Johnson
	kds1_e1_f5548014.setitem(1, "osedsp", " ")	//flag esito di E1 
	

	k_return = kds1_e1_f5548014.u_update()
	if k_return < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = k_return
		kst_esito.SQLErrText = "Aggiornamento fallito per scambio dati con E1 'F554814'. ~n~rWO (doco): "+string(kst_tab_f5548014.osdoco)
		kguo_exception.inizializza()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
	if kst_tab_f5548014.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_f5548014.st_tab_g_0.esegui_commit) then
		kds1_e1_f5548014.db_commit( )
	end if

catch (uo_exception kuo_exception)
	if kst_tab_f5548014.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_f5548014.st_tab_g_0.esegui_commit) then
		kds1_e1_f5548014.db_rollback( )
	end if
	throw kuo_exception

finally
	if isvalid(kds1_e1_f5548014) then destroy kds1_e1_f5548014
	
end try

return k_return

end function

public subroutine if_isnull (ref st_tab_f5548014 kst_tab_f5548014);//
if isnull(kst_tab_f5548014.osdoco) then kst_tab_f5548014.osdoco = 0		//work order
if isnull(kst_tab_f5548014.osev01) then kst_tab_f5548014.osev01 = "" 	//tipo operazione
if isnull(kst_tab_f5548014.osa801) then kst_tab_f5548014.osa801 = kGuf_data_base.get_e1_dateformat(date(0))	//data
if isnull(kst_tab_f5548014.oswwaet) then kst_tab_f5548014.oswwaet = long(kGuf_data_base.get_e1_timeformat(time(0))) 	//ora
if isnull(kst_tab_f5548014.os55gs25a) then kst_tab_f5548014.os55gs25a = ""	//dose minima
if isnull(kst_tab_f5548014.os55gs25b) then kst_tab_f5548014.os55gs25b = ""	//dose massima
if isnull(kst_tab_f5548014.os55gs25c) then kst_tab_f5548014.os55gs25c = ""	//CYCLE 

end subroutine

public function boolean if_esiste (st_tab_f5548014 kst_tab_f5548014) throws uo_exception;//
//------------------------------------------------------------------------------------
//--- Verifica la presenza del rec
//--- 
//--- inp: st_tab_f5548014 osdoco (WO) e osev01 (tipo operazione 1-5)
//--- out:
//--- Ritorna: TRUE = riga trovata
//--- lancia exception x errore grave
//------------------------------------------------------------------------------------
boolean k_return=false
int k_trovato
st_esito kst_esito
kds_e1_f5548014_ifesiste kds1_e1_f5548014_ifesiste


try
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kds1_e1_f5548014_ifesiste = create kds_e1_f5548014_ifesiste
	
	kds1_e1_f5548014_ifesiste.db_connetti( )
	
	if kst_tab_f5548014.osdoco > 0 and trim(kst_tab_f5548014.osev01) > " " then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = k_trovato
		kst_esito.SQLErrText = "Verifica presenza in tab. E1 'F5548014' (usata per lo scambio dati di trattamento), mancano i dati per la ricerca del codice WO e tipo operazione'."
		kguo_exception.inizializza()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

	k_trovato = kds1_e1_f5548014_ifesiste.retrieve(kst_tab_f5548014.osdoco, trim(kst_tab_f5548014.osev01))

	if k_trovato < 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = k_trovato
		kst_esito.SQLErrText = "Verifica presenza in tab. E1 'F5548014' (usata per lo scambio dati di trattamento) fallita'. ~n~rWO (doco): " &
									  + string(kst_tab_f5548014.osdoco) + " operaz.: " + trim(kst_tab_f5548014.osev01)
		kguo_exception.inizializza()
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

	if k_trovato > 0 then
		k_return = true
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception

finally
	if isvalid(kds1_e1_f5548014_ifesiste) then destroy kds1_e1_f5548014_ifesiste
	
end try

return k_return

end function

on kuf_e1_f5548014.create
call super::create
end on

on kuf_e1_f5548014.destroy
call super::destroy
end on

