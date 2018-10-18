$PBExportHeader$kuf_meca_reportpilota.sru
forward
global type kuf_meca_reportpilota from kuf_parent
end type
end forward

global type kuf_meca_reportpilota from kuf_parent
end type
global kuf_meca_reportpilota kuf_meca_reportpilota

type variables

end variables

forward prototypes
public function boolean tb_add (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception
public function boolean tb_update (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception
public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception
public function long get_id_meca (st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception
public function datastore importa_report_pilota () throws uo_exception
public function long u_job_importa_report_pilota () throws uo_exception
public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception
public function boolean u_stampa (st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception
private function any get_docpath () throws uo_exception
public function string get_pathreport (ref st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception
public function string get_nomereport (ref st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception
private function any u_build_path_all (string a_path[], st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception
private function string u_build_pathreport (ref st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception
public function string u_get_path_nomereport (ref st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception
private function any get_path_all (ref st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception
public function st_esito u_batch_run () throws uo_exception
end prototypes

public function boolean tb_add (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception;// funzione che fa l'insert sulla tabella meca_fconv
boolean	k_return = false
//st_esito kst_esito
//
//
//kst_esito.esito = kkg_esito.ok
//kst_esito.sqlcode = 0
//kst_esito.SQLErrText = ""
//kst_esito.nome_oggetto = this.classname()
//
//	
//try
//	if if_sicurezza(kkg_flag_modalita.modifica) then // ,"Inserimento 'Evento quarantena su lotto' non Autorizzata:") then
//
//	//--- imposto dati utente e data aggiornamento
//		ast_tab_meca_fconv.x_datins = kGuf_data_base.prendi_x_datins()
//		ast_tab_meca_fconv.x_utente = kGuf_data_base.prendi_x_utente()
//		
//	//--- toglie valori NULL
////		if_isnull(ast_tab_meca_fconv)
//		  
//		  INSERT INTO meca_fconv  
//				( id_meca,   
//				  x_datins_fconv,   
//				  x_utente_fconv,   
//				  x_datins,   
//				  x_utente)  
//	  VALUES ( 
//				  :ast_tab_meca_fconv.id_meca,   
//				  :ast_tab_meca_fconv.x_datins_fconv,   
//				  :ast_tab_meca_fconv.x_utente_fconv,   
//				  :ast_tab_meca_fconv.x_datins,   
//				  :ast_tab_meca_fconv.x_utente )  
//		USING kguo_sqlca_db_magazzino;
//		
//		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
//			if kguo_sqlca_db_magazzino.sqlcode < 0 then
//				kst_esito.esito = kkg_esito.db_ko
//				kst_esito.sqlcode = sqlca.sqlcode
//				kst_esito.SQLErrText = "Errore in carico Forzatura Convalida~n~r" + trim(sqlca.SQLErrText) 
//				kguo_exception.inizializza( )
//				kguo_exception.set_esito( kst_esito)
//			end if
//		else
//			k_return = true
//		end if
//
//		if ast_tab_meca_fconv.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_fconv.st_tab_g_0.esegui_commit) then
//			if kguo_sqlca_db_magazzino.sqlcode = 0 then
//				kguo_sqlca_db_magazzino.db_commit( )
//			else
//				kguo_sqlca_db_magazzino.db_rollback( )
//			end if
//		end if				
//
//		if kst_esito.esito = kkg_esito.db_ko then
//			throw kguo_exception
//		end if
//
//	end if
//	
//catch (uo_exception kuo_exception)
//	throw kuo_exception 
//	
//end try


return k_return

end function

public function boolean tb_update (st_tab_meca_fconv ast_tab_meca_fconv) throws uo_exception;// funzione che fa update sulla tabella meca_fconv
boolean	k_return = false
//st_esito kst_esito
//
//
//kst_esito.esito = kkg_esito.ok
//kst_esito.sqlcode = 0
//kst_esito.SQLErrText = ""
//kst_esito.nome_oggetto = this.classname()
//
//	
//try
//	if if_sicurezza(kkg_flag_modalita.modifica) then // ,"Inserimento 'Evento quarantena su lotto' non Autorizzata:") then
//
//	//--- imposto dati utente e data aggiornamento
//		ast_tab_meca_fconv.x_datins_fconv = ast_tab_meca_fconv.x_datins_fconv
//		ast_tab_meca_fconv.x_utente_fconv = ast_tab_meca_fconv.x_utente_fconv
//		ast_tab_meca_fconv.x_datins = kGuf_data_base.prendi_x_datins()
//		ast_tab_meca_fconv.x_utente = kGuf_data_base.prendi_x_utente()
//		
//	//--- toglie valori NULL
////		if_isnull(ast_tab_meca_fconv)
//		  
//		  update meca_fconv  
//				set id_meca = :ast_tab_meca_fconv.id_meca
//				  ,x_datins_fconv = :ast_tab_meca_fconv.x_datins_fconv   
//				  ,x_utente_fconv = :ast_tab_meca_fconv.x_utente_fconv 
//				  ,x_datins = :ast_tab_meca_fconv.x_datins
//				  ,x_utente = :ast_tab_meca_fconv.x_utente 
//		USING kguo_sqlca_db_magazzino;
//		
//		if kguo_sqlca_db_magazzino.sqlcode <> 0 then
//			if kguo_sqlca_db_magazzino.sqlcode < 0 then
//				kst_esito.esito = kkg_esito.db_ko
//				kst_esito.sqlcode = sqlca.sqlcode
//				kst_esito.SQLErrText = "Errore in aggiornameneto Forzatura Convalida~n~r" + trim(sqlca.SQLErrText) 
//				kguo_exception.inizializza( )
//				kguo_exception.set_esito( kst_esito)
//			end if
//		else
//			k_return = true
//		end if
//
//		if ast_tab_meca_fconv.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_meca_fconv.st_tab_g_0.esegui_commit) then
//			if kguo_sqlca_db_magazzino.sqlcode = 0 then
//				kguo_sqlca_db_magazzino.db_commit( )
//			else
//				kguo_sqlca_db_magazzino.db_rollback( )
//			end if
//		end if				
//
//		if kst_esito.esito = kkg_esito.db_ko then
//			throw kguo_exception
//		end if
//
//	end if
//	
//catch (uo_exception kuo_exception)
//	throw kuo_exception 
//	
//end try


return k_return

end function

public function boolean if_sicurezza (st_open_w ast_open_w) throws uo_exception;//
return true

end function

public function long get_id_meca (st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception;//--------------------------------------------------------------------------------------
//--- Torna id Lotto da nome file generato dal Pilota 
//---
//--- inp: st_tab_meca_reportpilota.nomereportorig = nome del file di origine creato dal Pilota
//--- Out: ast_tab_meca_reportpilota.id_meca
//---
//--------------------------------------------------------------------------------------
long	k_return 
int k_uno
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
try
	
	if trim(ast_tab_meca_reportpilota.nomereportorig) > " " then

		select meca_reportpilota.id_meca 
			into
				  :ast_tab_meca_reportpilota.id_meca
			  from meca_reportpilota  
			  where nomereportorig = :ast_tab_meca_reportpilota.nomereportorig
			  using kguo_sqlca_db_magazzino;
	  
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura Id Lotto dal nome del report pdf generato dal pilota: " + trim(ast_tab_meca_reportpilota.nomereportorig) + "~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		else
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				if ast_tab_meca_reportpilota.id_meca > 0 then
					k_return = ast_tab_meca_reportpilota.id_meca
				end if
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

public function datastore importa_report_pilota () throws uo_exception;//
//------------------------------------------------------------------------------------------------------------------------------------
//---
//---	Importa i report prodotti dal Pilota dalla cartella impostata nelle Proprietà
//---	inp: 
//---	out: 
//---	rit: nr file trovati
//---	x ERRORE lancia UO_EXCEPTION
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
//integer k_return=0
boolean k_b=false
string k_rc, k_file="", k_path[], k_docpath[], k_path_all[], k_nome_file_dest, k_file_find
int k_rcn, k_file_ind=0, k_ctr
long k_ind, k_nr_file_dirlist=0, k_nr_doc, k_wo_non_importati
date k_dataoggi
string k_esito, k_num_x
int k_npath_tot, k_npath
st_tab_meca kst_tab_meca
st_tab_meca_reportpilota kst_tab_meca_reportpilota
st_esito kst_esito
st_tab_base kst_tab_base
kuf_file_explorer kuf1_file_explorer
kuf_base kuf1_base
kuf_armo kuf1_armo
datastore kds_dirlist
datastore kds_meca_reportpilota, kds_meca_reportpilota_errori
 
 
	try

		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = ""

		kds_meca_reportpilota = create datastore
		kds_meca_reportpilota.dataobject = "ds_meca_reportpilota"
		kds_meca_reportpilota.settransobject( kguo_sqlca_db_magazzino )
		
		kds_meca_reportpilota_errori = create datastore
		kds_meca_reportpilota_errori.dataobject = "ds_meca_reportpilota_errori"
		
//--- legge i path nei quali copiare i report
		k_docpath[] = get_docpath ( )
		k_ctr = upperbound(k_docpath[])
		for k_ind = 1 to k_ctr
			if trim(k_docpath[k_ind]) > " " then
				k_npath_tot ++
				k_path[k_npath_tot] = k_docpath[k_ind]
			else
				exit 
			end if
		end for
		if k_npath_tot = 0  then 
			kst_esito.esito = kkg_esito.no_esecuzione  
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Nessun report importato dal Pilota. Cartella non impostata in archivio~n~r" 
			kGuo_exception.inizializza( )
			kGuo_exception.set_esito(kst_esito)
			throw kGuo_exception   
		end if
			
		kuf1_file_explorer = create kuf_file_explorer
		kuf1_base = create kuf_base
		kuf1_armo = create kuf_armo

//--- piglia il path di dove sono i Report del PILOTA
		k_esito = kuf1_base.prendi_dato_base( "path_report_pilota")
		if left(k_esito,1) <> "0" then
			kst_esito.esito = kkg_esito.no_esecuzione  
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Impostare in Proprietà la Cartella in cui trovare i Report prodotti dal 'Pilota' ~n~r" + mid(k_esito,2)
			kGuo_exception.inizializza( )
			kGuo_exception.set_esito(kst_esito)
			throw kGuo_exception   
		else
			kst_tab_base.dir_report_pilota = trim(mid(k_esito,2))
		end if

//--- piglia l'elenco dei file xml contenuti nella cartella Pilota formato: WOnnnnnnnn.pdf
		k_file_find = kst_tab_base.dir_report_pilota + kkg.path_sep + "WO*.pdf"
		kds_dirlist = kuf1_file_explorer.DirList(k_file_find)
		k_nr_file_dirlist = kds_dirlist.rowcount( )

		for k_file_ind = 1 to k_nr_file_dirlist
		
//--- estrae il file da importare		
			k_file = trim(kds_dirlist.getitemstring(k_file_ind, "nome"))
			if k_file > " " then

//--- get codice E1 - WO dal nome file che è ad esempio WO01234567.pdf
				k_num_x = mid(k_file, 3, len(k_file) - 6)
				if isnumber(k_num_x) then
					kst_tab_meca.e1doco = long(k_num_x)

//--- get del ID_MECA
					kst_tab_meca_reportpilota.id_meca = kuf1_armo.get_id_meca_da_e1doco(kst_tab_meca)	
					if kst_tab_meca_reportpilota.id_meca > 0 then
	
						//--- verifica di non avere già importato il file
						if get_nomereport(kst_tab_meca_reportpilota) > " " then
						else

							u_build_pathreport(kst_tab_meca_reportpilota) // get del path 'relativo' del Report
			
							k_path_all = u_build_path_all(k_path[], kst_tab_meca_reportpilota)  // aggiunge al percorso di root quello relativo
					
							for k_npath = 1 to k_npath_tot
								if k_path_all[k_npath] > " " then 
	
									k_dataoggi = kguo_g.get_dataoggi( )
									//--- compone il nome file es. rPilota180627_WO01234567_id345678.pdf
									k_nome_file_dest = "rPilota" + string(k_dataoggi, "yymmdd") + "_" +  left(k_file, len(k_file) - 4) &
													+ "_id" + string(kst_tab_meca.id, "#") + ".pdf"
	
	//--- copia il file dalla cartella PILOTA alla cartella Interna definita in Procedura (crea la cartella se non esiste)
									kguo_path.u_drectory_create(k_path_all[k_npath])
									k_rcn = FileCopy (kst_tab_base.dir_report_pilota + kkg.path_sep + k_file, k_path_all[k_npath] + k_nome_file_dest, true)
									
									choose case k_rcn
										case 1 
											//--- scrivo solo il Report interno in tabella
											if k_npath = 1 then
												k_nr_doc = kds_meca_reportpilota.insertrow(0)
												kds_meca_reportpilota.setitem(k_nr_doc, "id_meca", kst_tab_meca.id)
												kds_meca_reportpilota.setitem(k_nr_doc, "nomereportorig", k_file)
												kds_meca_reportpilota.setitem(k_nr_doc, "nomereport", k_nome_file_dest)
												kds_meca_reportpilota.setitem(k_nr_doc, "pathreport",  kst_tab_meca_reportpilota.pathreport)
												kds_meca_reportpilota.setitem(k_nr_doc, "x_datins", kGuf_data_base.prendi_x_datins())
												kds_meca_reportpilota.setitem(k_nr_doc, "x_utente", kGuf_data_base.prendi_x_utente())
											end if
										case -1
											k_wo_non_importati ++
											k_nr_doc = kds_meca_reportpilota_errori.insertrow(0)
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "id_meca", kst_tab_meca.id)
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "nomereportorig", k_file)
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "nomereport", k_nome_file_dest)
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "pathreport",  k_path_all[k_npath])
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "x_datins", kGuf_data_base.prendi_x_datins())
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "x_utente", kGuf_data_base.prendi_x_utente())
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "k_errore_msg", "Errore in apertura del Report Pilota: "+kst_tab_base.dir_report_pilota + kkg.path_sep + k_file)
//											kst_esito.esito = kkg_esito.no_esecuzione  
//											kst_esito.sqlcode = 0
//											kst_esito.SQLErrText = "Errore in apertura report Pilota durante la copia da~n~r" + kst_tab_base.dir_report_pilota + kkg.path_sep + k_file &
//																			+ " a ~n~r" + k_path_all[k_npath] + k_nome_file_dest
//											kGuo_exception.inizializza( )
//											kGuo_exception.set_esito(kst_esito)
//											throw kGuo_exception   
										case -2	
											k_wo_non_importati ++
											k_nr_doc = kds_meca_reportpilota_errori.insertrow(0)
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "id_meca", kst_tab_meca.id)
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "nomereportorig", k_file)
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "nomereport", k_nome_file_dest)
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "pathreport",  k_path_all[k_npath])
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "x_datins", kGuf_data_base.prendi_x_datins())
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "x_utente", kGuf_data_base.prendi_x_utente())
											kds_meca_reportpilota_errori.setitem(k_nr_doc, "k_errore_msg", "Errore in scrittura del Report Pilota: "+k_path_all[k_npath] + k_nome_file_dest)
//											kst_esito.esito = kkg_esito.no_esecuzione  
//											kst_esito.sqlcode = 0
//											kst_esito.SQLErrText = "Errore in scrittura report Pilota durante la copia da~n~r" + kst_tab_base.dir_report_pilota + kkg.path_sep + k_file &
//																			+ " a ~n~r" + k_path_all[k_npath] + k_nome_file_dest
//											kGuo_exception.inizializza( )
//											kGuo_exception.set_esito(kst_esito)
//											throw kGuo_exception   
									end choose
									
								end if
							end for
						end if
					else
						k_wo_non_importati ++
						k_nr_doc = kds_meca_reportpilota_errori.insertrow(0)
						kds_meca_reportpilota_errori.setitem(k_nr_doc, "id_meca", kst_tab_meca.id)
						kds_meca_reportpilota_errori.setitem(k_nr_doc, "nomereportorig", k_file)
						kds_meca_reportpilota_errori.setitem(k_nr_doc, "nomereport", "")
						kds_meca_reportpilota_errori.setitem(k_nr_doc, "pathreport", "")
						kds_meca_reportpilota_errori.setitem(k_nr_doc, "x_datins", kGuf_data_base.prendi_x_datins())
						kds_meca_reportpilota_errori.setitem(k_nr_doc, "x_utente", kGuf_data_base.prendi_x_utente())
						kds_meca_reportpilota_errori.setitem(k_nr_doc, "k_errore_msg", "Lotto non trovato in archivio")
//						kst_esito.esito = kkg_esito.no_esecuzione  
//						kst_esito.sqlcode = 0
//						kst_esito.SQLErrText = "Non è stato trovato il Lotto per il Report Pilota '" + k_file + "', Verificare l'esattezza del dato o rimuovere il file~n~r" + kst_tab_base.dir_report_pilota + kkg.path_sep + k_file 
//						kGuo_exception.inizializza( )
//						kGuo_exception.set_esito(kst_esito)
//						throw kGuo_exception   
					end if					
						
				end if
			end if

			
		end for

		k_ind = kds_meca_reportpilota.rowcount( )
		if k_ind > 0 then
			if kds_meca_reportpilota.update( ) > 0 then
				kguo_sqlca_db_magazzino.db_commit( )
				kds_meca_reportpilota.saveas(k_path[1]+kkg.path_sep +"ReportPilotaOKFileList.xlsx", XLSX!, true)
			else
				if upperbound(k_path) > 0 then
					kguo_path.u_drectory_create(k_path[1])
					kds_meca_reportpilota.saveas(k_path[1]+kkg.path_sep +"ReportPilotaERRORFileList.xlsx", XLSX!, true)
				else
					k_path[1] = ""
				end if
				kst_esito.esito = kkg_esito.no_esecuzione  
				kst_esito.sqlcode = 0
				kst_esito.SQLErrText = "Errore in aggiornamento dati dei '" + string(k_ind) + "' Report Pilota importati~n~r da '" + kst_tab_base.dir_report_pilota + kkg.path_sep +"'" &
												+ "~n~ra '" + k_path[1] + "'n~r" + trim(kguo_sqlca_db_magazzino.sqlerrtext)
				kGuo_exception.inizializza( )
				kGuo_exception.set_esito(kst_esito)
				throw kGuo_exception   
			end if
		end if

//--- se ci sono ERRORI li segnala				
		if k_wo_non_importati > 0 then
			if upperbound(k_path) > 0 then
				kguo_path.u_drectory_create(k_path[1])
				kds_meca_reportpilota_errori.saveas(k_path[1]+kkg.path_sep +"ReportPilotaERRORFileList.xlsx", XLSX!, true)
			else
				k_path[1] = ""
			end if
			kst_esito.esito = kkg_esito.DATI_WRN 
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Operazione di importazione incompleta. Sono stati importati " + string(k_ind) + " documenti da~n~r" &
							  + "'" + kst_tab_base.dir_report_pilota + "'~n~r in '" + k_path[1] + k_nome_file_dest + "'~n~r"&
							  +"Ma si sono vericati degli errori e " + string(k_wo_non_importati) + " file non sono stati importati.~n~r" &
							  +"Prego controllare il tabulato dei documenti non importati in '" + k_path[1]+kkg.path_sep + "ErroreReportPilotaFileList.xlsx" + "'"
			kGuo_exception.inizializza( )
			kGuo_exception.set_esito(kst_esito)
			throw kGuo_exception   
		end if

		//k_return = k_nr_doc

	catch (uo_exception kuo_exception)
		throw kuo_exception
		
		
	finally
		if isvalid(kds_dirlist) then destroy kds_dirlist
		if isvalid(kuf1_base) then destroy kuf1_base
		if isvalid(kuf1_file_explorer) then destroy kuf1_file_explorer
		if isvalid(kuf1_armo) then destroy kuf1_armo
		
	end try
			


return kds_meca_reportpilota


end function

public function long u_job_importa_report_pilota () throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Importa file prodotti dal PILOTA 
//--- 
//--- Input: 
//--- out: 
//--- Rit: numero righe aggiornate su MECA_REPORTPILOTA 
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
long k_return=0
datastore kds_1
st_esito kst_esito


//setpointer()

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try
//	kds_1 = create datastore
//	kds_1.dataobject = "ds_meca_senza_data_ent"
//	kds_1.settrans(kguo_sqlca_db_magazzino)

//--- Copia i file del Pilota nella cartella interna e riempie il ds 
	kds_1 = importa_report_pilota( )
	if isvalid(kds_1) then
		k_return = kds_1.rowcount( ) 
	end if
		
	
catch (uo_exception kuo_exception) 
	k_return = 0
	throw kuo_exception
	
finally
	if isvalid(kds_1) then destroy kds_1
//	setpointer(kp_originale)

end try

return k_return


end function

public function boolean link_call (ref datawindow adw_link, string a_campo_link) throws uo_exception;//
//=== 
//====================================================================
//=== Attiva LINK cliccato 
//===
//=== Par. Inut: 
//===               datawindow su cui è stato attivato il LINK
//===               nome campo di LINK
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
//=== 
long k_rc
string k_rcx
boolean k_return=false
string k_dataobject, k_path[], k_nome_path_file
int k_npath_tot
st_tab_meca_reportpilota kst_tab_meca_reportpilota
st_esito kst_esito
datastore kdsi_elenco_output, kds_1   //ds da passare alla windows di elenco
st_open_w kst_open_w 
kuf_menu_window kuf1_menu_window
kuf_file_explorer kuf1_file_explorer


SetPointer(kkg.pointer_attesa)

kdsi_elenco_output = create datastore

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


if adw_link.getrow() = 0 then
else
	choose case a_campo_link

		case "meca_reportpilota_id_meca"
			kst_tab_meca_reportpilota.id_meca = adw_link.getitemnumber(adw_link.getrow(), "id_meca")
			if kst_tab_meca_reportpilota.id_meca > 0 then
				kst_tab_meca_reportpilota.nomereport = get_nomereport(kst_tab_meca_reportpilota)

//--- legge i path nei quali trovare report
				k_path[] = get_path_all(kst_tab_meca_reportpilota)
				k_npath_tot = upperbound(k_path[])
				if k_npath_tot = 0 then 
					kst_esito.esito = kkg_esito.no_esecuzione  
					kst_esito.sqlcode = 0
					kst_esito.SQLErrText = "Assente cartella Report Pilota in archivio~n~r" 
					kGuo_exception.inizializza( )
					kGuo_exception.set_esito(kst_esito)
					throw kGuo_exception   
				end if

				k_nome_path_file = k_path[1] +  kst_tab_meca_reportpilota.nomereport
				if k_nome_path_file > " " then
					k_return = true
				end if
			end if
	
	end choose
end if


if k_return then

	try
		k_return = if_sicurezza(kkg_flag_modalita.elenco)
	catch (uo_exception kuo_exception)
		throw kuo_exception
	end try

	if not k_return then
	
	else
//		kdsi_elenco_output.dataobject = k_dataobject		
//		kdsi_elenco_output.settransobject(sqlca)
//
//		kdsi_elenco_output.reset()	
		
		choose case a_campo_link
					
			case "meca_reportpilota_id_meca"
				kuf1_file_explorer = create kuf_file_explorer
				kuf1_file_explorer.of_execute(k_nome_path_file)
				
//				k_rc=kdsi_elenco_output.retrieve(kst_tab_meca_reportpilota.id_meca)
		
//			case "meca_dosim_barcode" 
//				k_rc=kdsi_elenco_output.retrieve(kst_tab_meca_reportpilota.barcode)
		
		end choose

	end if
	

	if kdsi_elenco_output.rowcount() > 0 then
	
		
	//--- chiamare la window di elenco
	//
	//=== Parametri : 
	//=== struttura st_open_w
		kst_open_w.id_programma = kkg_id_programma.elenco  //kkg_id_programma_elenco
		kst_open_w.flag_primo_giro = "S"
		kst_open_w.flag_modalita = kkg_flag_modalita.elenco
		kst_open_w.flag_adatta_win = KKG.ADATTA_WIN
		kst_open_w.flag_leggi_dw = " "
		kst_open_w.flag_cerca_in_lista = " "
		kst_open_w.key2 = trim(kdsi_elenco_output.dataobject)
		kst_open_w.key3 = "0"     //--- viene riempito con il nr di riga selezionata
		kst_open_w.key4 = kGuf_data_base.prendi_win_attiva_titolo()    //--- Titolo della Window di chiamata per riconoscerla
		kst_open_w.key12_any = kdsi_elenco_output
		kst_open_w.flag_where = " "
		kuf1_menu_window = create kuf_menu_window 
		kuf1_menu_window.open_w_tabelle(kst_open_w)
		destroy kuf1_menu_window


//	else
//		
//		kguo_exception.inizializza()
//		kguo_exception.setmessage(u_get_errmsg_nontrovato(kst_open_w.flag_modalita ))
//		throw kguo_exception
//		
		
	end if

end if

SetPointer(kkg.pointer_default)



return k_return

end function

public function boolean u_stampa (st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Stampa documento pdf generato dal PILOTA (dati trattamenti barcode)
//--- 
//--- Input: st_tab_meca_reportpilota.id_meca
//--- out: 
//--- Rit: true x stampa ok
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
boolean k_return = false
long k_righe
string k_path[], k_file
st_stampe kst_stampe
st_esito kst_esito
kuf_utility kuf1_utility


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	
	ast_tab_meca_reportpilota.nomereport = get_nomereport(ast_tab_meca_reportpilota)
	if ast_tab_meca_reportpilota.nomereport > " " then
		k_path = get_path_all(ast_tab_meca_reportpilota)
		if upperbound(k_path) > 0 then 
			
			kuf1_utility = create kuf_utility
			k_file = k_path[1]  + ast_tab_meca_reportpilota.nomereport
			if kuf1_utility.u_print_file(k_file) then
				k_return = true
			else
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Stampa dati trattamento barcode (Report Pilota) (" + k_file + ") non effettuata,~n~r" & 
				+ "verificare se il file è corretto." 
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
			end if
		else
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Stampa dati trattamento barcode (Report Pilota) (nome file=" + ast_tab_meca_reportpilota.nomereport + ") non effettuata,~n~r" & 
			+ "definizione delle Cartelle assente" 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
		end if
	end if
	
catch (uo_exception kuo_exception)
		throw kuo_exception
	
finally
	if isvalid(kuf1_utility) then destroy kuf1_utility
	
end try

return k_return
end function

private function any get_docpath () throws uo_exception;//----------------------------------------------------------------------
//--- Torna i PATH (array) definiti in tabella per i Report Pilota della Procedura
//---
//--- input: 
//--- Rit: string array = path 
//---
//--- Lancia EXCEPTION
//---
//----------------------------------------------------------------------
string k_return[20]
long k_righe, k_riga
string k_path[20], k_esito, k_path_interno, k_path_esterno
date k_dataoggi
st_tab_docpath kst_tab_docpath[]
st_tab_doctipo kst_tab_doctipo
st_esito kst_esito
kuf_docpath kuf1_docpath
kuf_doctipo kuf1_doctipo
kuf_armo kuf1_armo

try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kuf1_docpath = create kuf_docpath
	kuf1_doctipo = create kuf_doctipo

	kst_tab_doctipo.tipo = kuf1_doctipo.kki_tipo_report_pilota
	kst_tab_docpath[1].id_doctipo = kuf1_doctipo.get_id_doctipo_da_tipo(kst_tab_doctipo)
	if kst_tab_docpath[1].id_doctipo > 0 then 
			
		k_righe = kuf1_docpath.get_path_x_tipo(kst_tab_docpath[])

//--- Path x uso interno sempre presente 
		k_path_interno = kguo_path.get_doc_root_interno() 
					
//--- valuto se PATH anche x documento Uso Esterno
		if kuf1_docpath.if_uso_esterno(kst_tab_docpath[1]) then 
			k_path_esterno = kguo_path.get_doc_root_esterno()
		end if
		for k_riga = 1 to k_righe
			
			k_path[k_riga] = k_path_interno + KKG.PATH_SEP + trim(kst_tab_docpath[k_riga].path)
			
			if k_path_esterno > " " then
				k_riga ++
				k_path[k_riga] = k_path_esterno + KKG.PATH_SEP + trim(kst_tab_docpath[k_riga].path_x_documentale)
			end if
		next
			
		k_return = k_path
			
	end if
					

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	if isvalid(kuf1_docpath) then destroy kuf1_docpath
	if isvalid(kuf1_doctipo) then destroy kuf1_doctipo
	
end try
			

return k_return[]

end function

public function string get_pathreport (ref st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception;//--------------------------------------------------------------------------------------
//--- Torna il path relativo del file  
//---
//--- inp: st_tab_meca_reportpilota.id_meca
//--- Out: ast_tab_meca_reportpilota.pathreport = path relativo del file importato dal Pilota con barra finale
//---
//--------------------------------------------------------------------------------------
string	k_return 
int k_uno
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
try
	
	if ast_tab_meca_reportpilota.id_meca > 0 then

		select meca_reportpilota.pathreport 
			into
				  :ast_tab_meca_reportpilota.pathreport
			  from meca_reportpilota  
			  where id_meca = :ast_tab_meca_reportpilota.id_meca
			  using kguo_sqlca_db_magazzino;
	  
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura del path del report pdf importato dal pilota, id Lotto: " + string(ast_tab_meca_reportpilota.id_meca) + "~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		else
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				if trim(ast_tab_meca_reportpilota.pathreport) > " " then
					k_return = trim(ast_tab_meca_reportpilota.pathreport)
				end if
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

public function string get_nomereport (ref st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception;//--------------------------------------------------------------------------------------
//--- Torna nome file  
//---
//--- inp: st_tab_meca_reportpilota.id_meca
//--- Out: ast_tab_meca_reportpilota.nomereport = nome del file importato dal Pilota
//---
//--------------------------------------------------------------------------------------
string	k_return 
int k_uno
st_esito kst_esito


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
try
	
	if ast_tab_meca_reportpilota.id_meca > 0 then

		select meca_reportpilota.nomereport 
			into
				  :ast_tab_meca_reportpilota.nomereport
			  from meca_reportpilota  
			  where id_meca = :ast_tab_meca_reportpilota.id_meca
			  using kguo_sqlca_db_magazzino;
	  
		if kguo_sqlca_db_magazzino.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in lettura nome del report pdf importato dal pilota, id Lotto: " + string(ast_tab_meca_reportpilota.id_meca) + "~n~r" + trim(sqlca.SQLErrText) 
			kguo_exception.inizializza( )
			kguo_exception.set_esito( kst_esito)
			throw kguo_exception
		else
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				if trim(ast_tab_meca_reportpilota.nomereport) > " " then
					k_return = trim(ast_tab_meca_reportpilota.nomereport)
				end if
			end if
		end if
	end if
	
catch (uo_exception kuo_exception)
	throw kuo_exception 
	
end try


return k_return

end function

private function any u_build_path_all (string a_path[], st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception;//----------------------------------------------------------------------
//--- Fonde la root (array)  con il PATH relativo circa i Report Pilota della Procedura
//---
//--- input: st_tab_meca_reportpilota.pathreport
//--- Rit: string array = path 
//---
//--- Lancia EXCEPTION
//---
//----------------------------------------------------------------------
string k_return[20]
long k_righe, k_riga
string k_path[20], k_esito, k_path_interno, k_path_esterno
st_tab_meca kst_tab_meca
st_esito kst_esito
kuf_armo kuf1_armo

try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca_reportpilota.pathreport > " " then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca il path realtivo al reprt per completare il nome della cartella del Report Pilota, operazione non eseguita!"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

	k_path[] = a_path[]
	k_righe = upperbound(k_path[])
					
	for k_riga = 1 to k_righe
		if k_path[k_riga] > " " then
			k_path[k_riga] += ast_tab_meca_reportpilota.pathreport 
		end if
	next
			
	k_return = k_path
			

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	
end try
			

return k_return[]

end function

private function string u_build_pathreport (ref st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception;//----------------------------------------------------------------------
//--- Costruisce il PATH (relativo) Report Pilota della Procedura
//---
//--- inp: st_tab_meca_reportpilota.id_meca
//--- Out: st_tab_meca_reportpilota.pathreport
//--- Rit: string path del report pilota
//---
//--- Lancia EXCEPTION
//---
//----------------------------------------------------------------------
string k_return
date k_data
st_tab_meca kst_tab_meca
st_esito kst_esito
kuf_armo kuf1_armo
kuf_docpath kuf1_docpath

try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if ast_tab_meca_reportpilota.id_meca > 0 then
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.SQLErrText = "Manca il Lotto id compilare la cartella interna del Report Pilota, operazione non eseguita!"
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- get dati lotto da usare per il path	
	kuf1_armo = create kuf_armo
	kst_tab_meca.id = ast_tab_meca_reportpilota.id_meca
	kuf1_armo.get_dati_rid(kst_tab_meca )
	
//--- get del path da iinestare sul path root del documento
	kuf1_docpath = create kuf_docpath
	k_data =  date(kst_tab_meca.data_ent)
	if k_data > kkg.data_no then
	else
		k_data = kst_tab_meca.data_int
	end if
	ast_tab_meca_reportpilota.pathreport  = kuf1_docpath.get_path_suff_generale(kst_tab_meca.clie_3, k_data )
//	kkg.path_sep  + string(kst_tab_meca.data_ent, "yyyy") + kkg.path_sep &
//									+ string(kst_tab_meca.clie_3, "00000") + kkg.path_sep &
//									+ string(kst_tab_meca.data_ent, "mm")  &
//									+ kkg.path_sep 
			
	k_return = ast_tab_meca_reportpilota.pathreport 
			

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	if isvalid(kuf1_armo) then destroy kuf1_armo
	if isvalid(kuf_docpath) then destroy kuf_docpath
	
end try
			

return k_return

end function

public function string u_get_path_nomereport (ref st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception;//--------------------------------------------------------------------------------------------------------------
//--- Torna il nome del documento pdf e il path di dove si trova
//--- 
//--- Input: st_tab_meca_reportpilota.id_meca
//--- out: 
//--- Rit: true x stampa ok
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
string k_return = ""
string k_path[], k_file
st_esito kst_esito


try

	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	ast_tab_meca_reportpilota.nomereport = get_nomereport(ast_tab_meca_reportpilota)
	if ast_tab_meca_reportpilota.nomereport > " " then
		k_path = get_path_all(ast_tab_meca_reportpilota)
		if upperbound(k_path) > 0 then 
			//+ KKG.PATH_SEP
			k_return = k_path[1] + ast_tab_meca_reportpilota.nomereport
		else
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlerrtext = "Stampa dati trattamento barcode (Report Pilota) (nome file=" + ast_tab_meca_reportpilota.nomereport + ") non effettuata,~n~r" & 
			+ "definizione delle Cartelle assente" 
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
		end if
	end if
	
catch (uo_exception kuo_exception)
		throw kuo_exception
	
finally
	
end try

return k_return
end function

private function any get_path_all (ref st_tab_meca_reportpilota ast_tab_meca_reportpilota) throws uo_exception;//----------------------------------------------------------------------
//--- Torna i PATH (array) Report Pilota della Procedura
//---
//--- input: st_tab_meca_reportpilota.id_meca
//--- Rit: string array = path 
//---
//--- Lancia EXCEPTION
//---
//----------------------------------------------------------------------
string k_return[20]
string k_path[20]
//st_esito kst_esito

try

	k_path = get_docpath()   // get dalla tabella il percorso 'root'

	get_pathreport(ast_tab_meca_reportpilota) // get del path 'relativo' del Report
			
	k_return = u_build_path_all(k_path, ast_tab_meca_reportpilota)  // aggiunge al percorso di root quello relativo
			

catch (uo_exception kuo1_exception)
	throw kuo1_exception
	
finally
	
end try
			

return k_return[]

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

//--- Importa Report Prodotti dal PILOTA dalla cartella del Pilota a quella interna
	k_ctr = u_job_importa_report_pilota( )
	if k_ctr > 0 then
		kst_esito.SQLErrText = "Operazione conclusa correttamente." &
									+ "Sono stati importati " + string(k_ctr) + " nuovi Report (pdf) prodotti dal Pilota" 
	else
		kst_esito.SQLErrText = "Operazione conclusa. Nessun nuovo Report (pdf) prodotto dal Pilota è stato trovato."
	end if


catch (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	
end try


return kst_esito
end function

on kuf_meca_reportpilota.create
call super::create
end on

on kuf_meca_reportpilota.destroy
call super::destroy
end on

event constructor;call super::constructor;//--- solo per autorizzazione a FORZARE LA CONVALIDA Lotto anche con letture parziali dei dosimetri
//--- 

ki_msgErrDescr="Forza Convalida Lotto"
end event

