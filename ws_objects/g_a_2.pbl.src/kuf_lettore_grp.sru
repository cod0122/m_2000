$PBExportHeader$kuf_lettore_grp.sru
forward
global type kuf_lettore_grp from kuf_parent
end type
end forward

global type kuf_lettore_grp from kuf_parent
end type
global kuf_lettore_grp kuf_lettore_grp

type variables
private:
ds_lettore_grp kids_lettore_grp
ds_file_lettore_grp kids_file_lettore_grp

end variables

forward prototypes
public function integer get_files_groupage (ref st_file_lettore_grp kst_file_lettore_grp[]) throws uo_exception
public function st_esito get_record (ref st_tab_lettore_grp kst_tab_lettore_grp)
public function st_esito popola_ds_file_grp (ref string k_file)
public function st_esito tb_delete (st_tab_lettore_grp kst_tab_lettore_grp)
public function st_esito tb_delete_all (st_tab_lettore_grp kst_tab_lettore_grp)
public function st_esito popola_tab_lettore_grp_da_ds ()
public function st_esito popola_tab_lettore_grp ()
public function st_esito delete_file_grp (ref string k_file)
public function boolean if_gia_caricato (st_tab_lettore_grp kst_tab_lettore_grp) throws uo_exception
public function long u_delete_file_all () throws uo_exception
end prototypes

public function integer get_files_groupage (ref st_file_lettore_grp kst_file_lettore_grp[]) throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Trova i nomi file dei Groupage presenti nella cartella impostata nelle Proprietà
//---	inp: st_file_lettore_grp vuoto
//---	out: st_file_lettore_grp array con il path e il nome dai file che contengono i groupage
//---	rit: nr file trovati
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
integer k_return=0
boolean k_b=false
string k_rc, k_file=""
int k_rcn, k_file_ind=0
long k_ind, k_nr_file_dirlist, k_nr_file
datastore kds_dirlist
string k_esito=""
st_esito kst_esito
st_tab_base kst_tab_base
kuf_file_explorer kuf1_file_explorer
kuf_base kuf1_base
 

 
	try
		kuf1_file_explorer = create kuf_file_explorer
		kuf1_base = create kuf_base

//--- piglia il path di dove sono i Packing-list Web
		k_esito = kuf1_base.prendi_dato_base( "path_file_groupage")
		if left(k_esito,1) <> "0" then
			kst_esito.nome_oggetto = this.classname()
			kst_esito.esito = kkg_esito.db_ko  
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Impostare su Proprietà la Cartella in cui trovare i Groupage scaricati dal Lettore ~n~r" + mid(k_esito,2)
			kGuo_exception.inizializza( )
			kGuo_exception.set_esito(kst_esito)
			throw kGuo_exception   
		else
			kst_tab_base.fgrp_out_path	= trim(mid(k_esito,2))
		end if

//--- piglia l'elenco dei file xml contenuti nella cartella
		kds_dirlist = kuf1_file_explorer.DirList(kst_tab_base.fgrp_out_path + "\*.*")
		k_nr_file_dirlist = kds_dirlist.rowcount( )

		for k_file_ind = 1 to k_nr_file_dirlist
		
//--- estrae il file da importare		
			k_file = trim(kds_dirlist.getitemstring(k_file_ind, "nome"))
			
			if kds_dirlist.getitemstring(k_file_ind, "tipo") = kuf1_file_explorer.k_dirlist_tipo_file then
				k_nr_file ++
				kst_file_lettore_grp[k_nr_file].nome_file = k_file
				kst_file_lettore_grp[k_nr_file].path_file = kst_tab_base.fgrp_out_path
			end if
			
		end for

		k_return = k_nr_file_dirlist

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
		
	finally
		if isvalid(kds_dirlist) then destroy kds_dirlist
		if isvalid(kuf1_base) then destroy kuf1_base
		if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
		
	end try
			


return k_return


end function

public function st_esito get_record (ref st_tab_lettore_grp kst_tab_lettore_grp);//
//--- legge il record dalla tabella
//--- inp: kst_tab_lettore_grp   id valorizzato
//--- out: kst_tab_lettore_grp valorizzata
//--- rit: st_esito
//
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kst_tab_lettore_grp.id > 0 then

	if kids_lettore_grp.retrieve( kst_tab_lettore_grp.id ) > 0 then
		
		kst_tab_lettore_grp.timestamp_inizio = kids_lettore_grp.object.timestamp_inizio
		kst_tab_lettore_grp.padre = kids_lettore_grp.object.padre
		kst_tab_lettore_grp.figlio = kids_lettore_grp.object.figlio
		kst_tab_lettore_grp.lkey = kids_lettore_grp.object.lkey
		kst_tab_lettore_grp.timestamp_lettura = kids_lettore_grp.object.timestamp_lettura
		kst_tab_lettore_grp.utente = kids_lettore_grp.object.utente
		kst_tab_lettore_grp.x_datins = kids_lettore_grp.object.x_datins
		kst_tab_lettore_grp.x_utente = kids_lettore_grp.object.x_utente
		
	else
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
			"Errore durante interrogazione Groupage da palmare (id " + string(kst_tab_lettore_grp.id) + ") ~n~r" &
							+ "Codice errore: " + string(kids_lettore_grp.kist_errori_gestione.sqlca.sqlcode)  &	
							+ " ~n~r" + trim(kids_lettore_grp.kist_errori_gestione.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
			
	end if
else
	
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Nessun ID indicato " 
	kst_esito.esito = kkg_esito.err_logico
end if


return kst_esito

end function

public function st_esito popola_ds_file_grp (ref string k_file);//
//--- legge i records dal path+file GROUPAGE
//--- inp: path+file
//--- out: kids_file_lettore_grp valorizzato
//--- rit: st_esito
//
st_esito kst_esito
integer li_FileNum, k_errore=0
string k_file_dati
st_tab_lettore_grp kst_tab_lettore_grp


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if len(trim(k_file)) > 0 then

	if FileExists (k_file ) then
		
		kids_file_lettore_grp.reset( )
		k_errore = kids_file_lettore_grp.importfile( CSV!, k_file)
		if k_errore < 0 then
		
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = &
				"Errore durante lettura File Groupage da palmare " + string(kst_tab_lettore_grp.id) + " ~n~r" &
								+ "Codice errore: " + string(k_errore) 
			kst_esito.esito = kkg_esito.db_ko
		end if
	else
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
			"Errore il File Groupage da palmare Non trovato" + string(kst_tab_lettore_grp.id) + " ~n~r" &
							+ "file cercato: " + string(k_file) 
		kst_esito.esito = kkg_esito.db_ko
		
	end if
else
	
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Nessun File Groupage da palmare indicato " 
	kst_esito.esito = kkg_esito.db_wrn
end if


return kst_esito

end function

public function st_esito tb_delete (st_tab_lettore_grp kst_tab_lettore_grp);//
//====================================================================
//=== Cancella il singolo record dalla tabella LETTORE_GRP
//=== 
//=== Input: st_tab_lettore_grp.id (la riga da cancellare)
//=== Ritorna ST_ESITO
//=== 
//====================================================================
//
boolean k_sicurezza_si=false
st_esito kst_esito, kst_esito1
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = this.get_id_programma( kst_open_w.flag_modalita )

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza_si = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza_si then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione Barcode da Groupage non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	delete from lettore_grp
		where id = :kst_tab_lettore_grp.id
			using sqlca;

	if sqlca.sqlcode < 0 then 
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
"Errore durante la cancellazione Barcode del Groupage da Lettore ~n~r" &
				+ " id: " + string(kst_tab_lettore_grp.id) &
				+ " ~n~rErrore-tab.LETTORE_GRP:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kGuf_data_base.errori_scrivi_esito(kst_esito)
	end if
	
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kst_tab_lettore_grp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_lettore_grp.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		if kst_tab_lettore_grp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_lettore_grp.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if


end if


return kst_esito

end function

public function st_esito tb_delete_all (st_tab_lettore_grp kst_tab_lettore_grp);//
//====================================================================
//=== Cancella l'intero Groupage dalla tabella LETTORE_GRP
//=== 
//=== Input: st_tab_lettore_grp.padre e timestamp_inizio (la riga da cancellare)
//=== Ritorna ST_ESITO
//=== 
//====================================================================
//
boolean k_sicurezza_si=false
st_esito kst_esito, kst_esito1
st_open_w kst_open_w
kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()



kst_open_w.flag_modalita = kkg_flag_modalita.cancellazione
kst_open_w.id_programma = this.get_id_programma( kst_open_w.flag_modalita )

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza_si = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza_si then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione Barcode da Groupage non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else
//--- ne approfitta cancellando anche groupage con PADRE=NULL
	delete from lettore_grp
		where timestamp_inizio = :kst_tab_lettore_grp.timestamp_inizio
		        and padre =  :kst_tab_lettore_grp.padre 
				  or padre is null
			using sqlca;

	if sqlca.sqlcode < 0 then 
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
"Errore durante la cancellazione del Groupage da Lettore ~n~r" &
				+ " padre: " + string(kst_tab_lettore_grp.padre) + " data: " + string(kst_tab_lettore_grp.timestamp_inizio) &
				+ " ~n~rErrore-tab.LETTORE_GRP:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kGuf_data_base.errori_scrivi_esito(kst_esito)
	end if
	
//---- COMMIT....	
	if kst_esito.esito = kkg_esito.db_ko then
		if kst_tab_lettore_grp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_lettore_grp.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		if kst_tab_lettore_grp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_lettore_grp.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if


end if



return kst_esito

end function

public function st_esito popola_tab_lettore_grp_da_ds ();//
//--- Scrive su tabella i records dal ds_file_lettore_grp 
//--- inp: 
//--- out: 
//--- rit: st_esito
//--- deve essere stato popolato il ds_file_lettore_grp 
//---
st_esito kst_esito
boolean k_doppi=false
integer k_riga, k_errore=0, k_riga_file=0, k_ind_doppi=0
string k_file_dati
st_tab_lettore_grp kst_tab_lettore_grp


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if kids_file_lettore_grp.rowcount( ) > 0 then
	
	kids_lettore_grp.reset( )
	
	for k_riga_file = 1 to kids_file_lettore_grp.rowcount( )

//--- controllo se GRP già caricato dallo stesso file
		k_doppi = false
		for k_ind_doppi = 1 to kids_lettore_grp.rowcount( )
			if kids_lettore_grp.object.timestamp_inizio[k_ind_doppi] = kids_file_lettore_grp.object.timestamp_inizio[k_riga_file] &
					and kids_lettore_grp.object.padre[k_ind_doppi] = kids_file_lettore_grp.object.padre[k_riga_file] &
					and kids_lettore_grp.object.figlio[k_ind_doppi] = kids_file_lettore_grp.object.figlio[k_riga_file] then
				k_doppi = true 
				k_ind_doppi =  kids_file_lettore_grp.rowcount( ) + 1  // Uscita CICLO
			end if
		end for
		if not k_doppi then  // controllo doppioni GRP anche su archivio
			try 
				kst_tab_lettore_grp.padre = trim(kids_file_lettore_grp.object.padre[k_riga_file])
				kst_tab_lettore_grp.figlio= trim(kids_file_lettore_grp.object.figlio[k_riga_file])
				kst_tab_lettore_grp.timestamp_inizio = trim(kids_file_lettore_grp.object.timestamp_inizio[k_riga_file]) 
				k_doppi = if_gia_caricato(kst_tab_lettore_grp)
			catch (uo_exception kuo_exception)
				kst_esito = kuo_exception.get_st_esito()
			end try 
		end if
		
		if not k_doppi then  // Nessun DOPPIONE carico!!!
			k_riga = kids_lettore_grp.insertrow(0)
			kids_lettore_grp.object.id[k_riga] = 0
			kids_lettore_grp.object.lkey[k_riga] = kids_file_lettore_grp.object.key[k_riga_file]
			kids_lettore_grp.object.timestamp_inizio[k_riga] = kids_file_lettore_grp.object.timestamp_inizio[k_riga_file]
			kids_lettore_grp.object.padre[k_riga] = kids_file_lettore_grp.object.padre[k_riga_file]
			kids_lettore_grp.object.figlio[k_riga] = kids_file_lettore_grp.object.figlio[k_riga_file]
			kids_lettore_grp.object.timestamp_lettura[k_riga] = kids_file_lettore_grp.object.timestamp_lettura[k_riga_file]
			kids_lettore_grp.object.utente[k_riga] = kids_file_lettore_grp.object.utente[k_riga_file]
			kids_lettore_grp.object.x_datins[k_riga] = kGuf_data_base.prendi_x_datins( )
			kids_lettore_grp.object.x_utente[k_riga] = kGuf_data_base.prendi_x_utente( )
		end if
		
	end for
	
	if k_riga > 0 then
		
		k_errore = kids_lettore_grp.update( )
		if k_errore < 0 then
			
			kst_esito.sqlcode = sqlca.sqlcode
			if kids_file_lettore_grp.rowcount() > 0 then
				kst_esito.SQLErrText = &
					"Errore durante inserimento dei Groupage da palmare  ~n~r" &
									+ "Esempio il Padre: " + kids_file_lettore_grp.object.barcode[1]  &	
									+ " key: " + kids_file_lettore_grp.object.key[1]	+ " ~n~r" &
									+ " data/ora inizio: " + kids_file_lettore_grp.object.timestamp_inizio[1]	+ " ~n~r" &
									+ "Codice errore: " + string(kids_lettore_grp.kist_errori_gestione.sqlca.sqlcode)  &	
									+ " ~n~r" + trim(kids_lettore_grp.kist_errori_gestione.SQLErrText)
			else
				kst_esito.SQLErrText = &
					"Errore durante in inserimento dei Groupage da palmare " &
									+ "(nessun barcode trovato): "   &	
									+ "Codice errore: " + string(kids_lettore_grp.kist_errori_gestione.sqlca.sqlcode)  &	
									+ " ~n~r" + trim(kids_lettore_grp.kist_errori_gestione.SQLErrText)
			end if
			kst_esito.esito = kkg_esito.db_ko
			
			if kst_tab_lettore_grp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_lettore_grp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
			
		else
//---- COMMIT....	
			if kst_tab_lettore_grp.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_lettore_grp.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
			
		end if
		
	end if
	

else
	
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Nessun Groupage da palmare presente " 
	kst_esito.esito = kkg_esito.db_wrn
end if


return kst_esito

end function

public function st_esito popola_tab_lettore_grp ();//
//--- Scrive su tabella i Groupage Scaricati nella cartella comune con il Lettore
//--- inp: 
//--- out: 
//--- rit: st_esito
//--- deve essere stato impostato il PATH dove il Lettore mette i Groupage sulle Proprietà Base
//---
string k_esito=""
string k_file=""
int k_n_file=0, k_ind
st_esito kst_esito
st_file_lettore_grp kst_file_lettore_grp[]



kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


try
//--- legge i groupage dalla cartella
	get_files_groupage(kst_file_lettore_grp[])
	
	k_n_file = upperbound(kst_file_lettore_grp[])
	for k_ind = 1 to k_n_file
		
//--- legge un file Groupage e lo importa nel DataStore
		if right(kst_file_lettore_grp[k_ind].path_file,1) <> "\" and right(kst_file_lettore_grp[k_ind].path_file,1) <> "/" then 
			k_file = kst_file_lettore_grp[k_ind].path_file + "\" + kst_file_lettore_grp[k_ind].nome_file
		else
			k_file = kst_file_lettore_grp[k_ind].path_file + kst_file_lettore_grp[k_ind].nome_file
		end if
		
		kst_esito = popola_ds_file_grp( k_file )
		
//--- inserisce dal DS nella tabella i record del GROUPAGE		
		if kst_esito.esito = kkg_esito.ok then
			kst_esito = popola_tab_lettore_grp_da_ds( )
		end if
		
		if kst_esito.esito = kkg_esito.ok or kst_esito.esito = kkg_esito.db_wrn then
			kst_esito = delete_file_grp( k_file )  // cancella il file appena inserito in tabella
		end if
		
//--- se si è verificato un errore grave esco!		
		if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
			//k_ind = k_n_file + 1  //USCITA !!!
			kGuo_exception.inizializza( )
			kGuo_exception.set_esito(kst_esito) // scrive LOG
		end if
		
	end for
	
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	
	
end try

//if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
//	kGuf_data_base.errori_scrivi_esito(kst_esito) // scrive LOG
//end if


return kst_esito

end function

public function st_esito delete_file_grp (ref string k_file);//
//--- Rimuove il file GROUPAGE
//--- inp: path+file
//--- out: 
//--- rit: st_esito
//
st_esito kst_esito
integer li_FileNum, k_errore=0
string k_file_dati
st_tab_lettore_grp kst_tab_lettore_grp
datastore kds_file_lettore_grp


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if len(trim(k_file)) > 0 then

//	if isvalid(kids_file_lettore_grp) then destroy kids_file_lettore_grp 

	if not FileDelete (trim(k_file) ) then
		
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = &
			"Errore durante Cancellazione File 'Groupage da palmare' " + " ~n~r" &
							+ "File: " + trim(k_file) 
		kst_esito.esito = kkg_esito.db_ko
	end if
	
//	if NOT isvalid(kids_file_lettore_grp) then
//		kids_lettore_grp = create ds_lettore_grp
//		kids_lettore_grp.dataobject = "ds_lettore_grp"
//		kids_lettore_grp.settransobject( sqlca)
//	end if
	
else
	
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Nessun File Groupage da palmare indicato " 
	kst_esito.esito = kkg_esito.db_wrn
end if


return kst_esito

end function

public function boolean if_gia_caricato (st_tab_lettore_grp kst_tab_lettore_grp) throws uo_exception;//
//====================================================================
//=== Controllo  se il Groupage è già stato caricato su  tabella LETTORE_GRP
//=== 
//=== Input: st_tab_lettore_grp.barcode e timestamp_inizio e figlio
//=== Ritorna: TRUE=caricato; FALSE=non caricato
//=== 
//=== Lancia Exception se ERRORE
//=== 
//====================================================================
//
boolean k_return=false
integer k_ind=0
st_esito kst_esito, kst_esito1


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


if len(trim(kst_tab_lettore_grp.padre)) > 0 then 

	select distinct 1 into :k_ind 
		from lettore_grp
		where padre = :kst_tab_lettore_grp.padre
				and timestamp_inizio = :kst_tab_lettore_grp.timestamp_inizio
				and figlio = :kst_tab_lettore_grp.figlio
			using sqlca;

	if sqlca.sqlcode < 0 then 
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
"Errore durante lettura Barcode Padre del Groupage da Lettore ~n~r" &
				+ " barcode: " + string(kst_tab_lettore_grp.padre) &
				+ " ~n~rErrore-tab.LETTORE_GRP:"	+ trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito.db_ko
		kGuf_data_base.errori_scrivi_esito(kst_esito)
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if
	
	if k_ind = 1 then k_return = TRUE 

	
else	
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = "Indicare il Barcode Padre del Groupage da Lettore ~n~r" + " id: " + string(kst_tab_lettore_grp.id) 
	kst_esito.esito = kkg_esito.no_esecuzione
	kGuf_data_base.errori_scrivi_esito(kst_esito)
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
end if


return k_return

end function

public function long u_delete_file_all () throws uo_exception;//
//--- Scrive su tabella i Groupage Scaricati nella cartella comune con il Lettore
//--- inp: 
//--- out: 
//--- rit: st_esito
//--- deve essere stato impostato il PATH dove il Lettore mette i Groupage sulle Proprietà Base
//---
long k_return
string k_file=""
int k_n_file, k_ind
st_esito kst_esito
st_file_lettore_grp kst_file_lettore_grp[]


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
	
//--- legge i groupage dalla cartella
	get_files_groupage(kst_file_lettore_grp[])
	
	k_n_file = upperbound(kst_file_lettore_grp[])
	for k_ind = 1 to k_n_file
		
//--- legge un file Groupage e lo importa nel DataStore
		if right(kst_file_lettore_grp[k_ind].path_file,1) <> kkg.path_sep then 
			kst_file_lettore_grp[k_ind].path_file += kkg.path_sep
		end if
		k_file = kst_file_lettore_grp[k_ind].path_file + kst_file_lettore_grp[k_ind].nome_file

		kst_esito = delete_file_grp( k_file )  // cancella il file 
		
	end for
	
	k_return = k_n_file
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
	
	
end try

if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
	kguo_exception.inizializza( )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if


return k_return

end function

on kuf_lettore_grp.create
call super::create
end on

on kuf_lettore_grp.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kids_file_lettore_grp = create ds_file_lettore_grp
kids_file_lettore_grp.dataobject = "ds_file_lettore_grp"

kids_lettore_grp = create ds_lettore_grp
kids_lettore_grp.dataobject = "ds_lettore_grp"
kids_lettore_grp.settransobject( sqlca)

end event

event destructor;call super::destructor;//
if isvalid(kids_file_lettore_grp) then destroy kids_file_lettore_grp
if isvalid(kids_lettore_grp) then destroy kids_lettore_grp

end event

