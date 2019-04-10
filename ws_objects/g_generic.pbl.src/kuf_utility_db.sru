$PBExportHeader$kuf_utility_db.sru
forward
global type kuf_utility_db from nonvisualobject
end type
end forward

global type kuf_utility_db from nonvisualobject
end type
global kuf_utility_db kuf_utility_db

forward prototypes
private function boolean u_crea_view_v_arfa_riga () throws uo_exception
private function boolean u_crea_view_v_arfa_tot_imponibili () throws uo_exception
private function boolean u_crea_view_v_arfa_x_id_armo () throws uo_exception
public function boolean u_crea_view () throws uo_exception
private function boolean u_crea_view_v_armo_out_colli () throws uo_exception
private function boolean u_crea_view_v_arsp_colli_x_id_armo () throws uo_exception
private function boolean u_crea_view_v_crm_listino_prezzi () throws uo_exception
private function boolean u_crea_view_v_armo_colli_inout () throws uo_exception
private function boolean u_crea_view_v_armo_out_dosezero_old () throws uo_exception
private function boolean u_crea_view_v_meca_pl () throws uo_exception
public function integer u_crea_spl_chiudi_bolle ()
private function boolean u_crea_view_e1_v_e1barcode () throws uo_exception
private function boolean u_crea_view_v_meca_dosim_barcode_max () throws uo_exception
private function boolean v_crea_view_v_contratti_doc () throws uo_exception
private function boolean v_crea_view_v_contratti_all_rid () throws uo_exception
end prototypes

private function boolean u_crea_view_v_arfa_riga () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_arfa_riga'
//=== Righe fattura 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer  // Declares a pointer variable




//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	k_sql = "CREATE VIEW v_arfa_riga  " &
			 + " (num_fatt , " &
			 + " data_fatt , " &
			 + " id_arfa , " &
			 + " id_fattura , " &
			 + " id_armo , " &
			 + " id_armo_prezzo,  " &
			 + " id_arsp , " &
			 + " nriga , " &
			 + " num_bolla_out , " &
			 + " data_bolla_out , " &
			 + " tipo_riga , " &
			 + " des , " &
			 + " iva , " &
			 + " colli , " &
			 + " prezzo_u , " &
			 + " prezzo_t , " &
			 + " clie_3 , " &
			 + " tipo_doc , " &
			 + " stampa , " &
			 + " colli_out , " &
			 + " peso_kg_out , " &
			 + " tipo_l , " &
			 + " cod_pag , " & 
			 + " id_arfa_se_nc,  " &
			+ " num_int,   " &
			+ " data_int,  " &
			+ " art , " &
			+ " dose,    " &
			+ " gruppo,  " &
			+ " magazzino,   " &
			+ " id_listino,  " &
			+ " campione,  " &
			+ " alt_2,  " &
			+ " id_meca,  " &
			+ " contratto  " &
			 + ") " &
			+ " AS  " &
			+ " select  " & 
			 + " x0.num_fatt , " &
			 + " x0.data_fatt , " &
			 + " x0.id_arfa , " &
			 + " x0.id_fattura , " &
			 + " x0.id_armo , " &
			 + " x0.id_armo_prezzo,  " &
			 + " x0.id_arsp , " &
			 + " x0.nriga , " &
			 + " x0.num_bolla_out , " &
			 + " x0.data_bolla_out , " &
			 + " x0.tipo_riga , " &
			 + " x0.des , " &
			 + " x0.iva , " &
			 + " x0.colli , " &
			 + " x0.prezzo_u , " &
			 + " x0.prezzo_t , " &
			 + " x0.clie_3 , " &
			 + " x0.tipo_doc , " &
			 + " x0.stampa , " &
			 + " x0.colli_out , " &
			 + " x0.peso_kg_out , " &
			 + " x0.tipo_l , " &
			 + " x0.cod_pag , " &
			 + " x0.id_arfa_se_nc  " &
			+ "    ,x1.num_int   " &
			+ "    ,x1.data_int  " &
			+ "    ,x1.art " &
			+ "    ,x1.dose    " &
			+ "    ,x2.gruppo  " &
			+ "    ,x1.magazzino   " &
			+ "    ,x1.id_listino  " &
			+ "    ,x1.campione  " &
			+ "    ,x1.alt_2  " &
			+ "    ,x1.id_meca  " &
			+ " ,xL.contratto  " &
			 + " 	from     " &
			 + " 		arfa x0 inner join armo x1 on x1.id_armo = x0.id_armo   " &
			 + " 			   left join prodotti x2 on x2.codice = x1.art   " &
			 + " 			   left join listino xL on x1.id_listino = xL.id   " &
			 + " union all  " &
			 + "     select    " &
			 + " x3.num_fatt , " &
			 + " x3.data_fatt , " &
			 + " x3.id_arfa_v , " &
			 + " x3.id_fattura , " &
			 + " 0 , " &
			 + " 0 , " &
			 + " 0 , " &
			 + " x3.nriga , " &
			 + " 0 ,  " &
	 		 + " CONVERT(DATE, '01.01.1899'),  " &
			 + " 'V' ,  " &
			 + " x3.comm,    " &
			 + " x3.iva , " &
			 + " 0 , " &
			 + " x3.prezzo_u , " &
			 + " x3.prezzo_t , " &
			 + " x3.clie_3 , " &
			 + " x3.tipo_doc , " &
			 + " x3.stampa , " &
			 + " x3.colli , " &
			 + " 0.00 , " &
			 + " ''  , " &
			 + " x3.cod_pag , " &
			 + " 0,  " &
			 + " 0 ,  " &
	 		 + " CONVERT(DATE, '01.01.1899'),  " &
			+ "  x3.art , " &
			+ "  0,    " &
			+ "  x4.gruppo,  " &
			+ "  0,  " &
			+ "  0,   " &
			+ "  'S',  " &
			+ "  0,  " &
			+ "  0,  " &
			+ " x3.contratto  " &
			 + "  	from  arfa_v x3  " &
			 + " 				left join prodotti x4 on (x4.codice = x3.art )  " 

	EXECUTE IMMEDIATE "drop VIEW v_arfa_riga" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(oldpointer)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_arfa_riga): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
	else
//		k_sql = "grant select on v_arfa_riga to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(oldpointer)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_arfa_riga): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(oldpointer)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_arfa_riga' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(oldpointer)

return k_return

end function

private function boolean u_crea_view_v_arfa_tot_imponibili () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View
//=== 
int k_errore=0
boolean k_codice = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer  // Declares a pointer variable




//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	k_sql = "	CREATE VIEW v_arfa_tot_imponibili  (id_fattura, num_fatt,data_fatt,iva,prezzo_t) AS " &
	 + " select x0.id_fattura ,x0.num_fatt ,x0.data_fatt ,x0.iva ,sum( " &
	 + "         x0.prezzo_t ) " &
	  + "  from arfa x0 " &
	  + "  where  x0.iva > 0 " &
		+ "	 group by " &
		+ "    x0.id_fattura " &
		+ "  , x0.num_fatt " &
		+ "  , x0.data_fatt" &
		+ "  ,x0.iva " &
	+ " union all" &
		+ " Select " &
		+ "    x1.id_fattura " &
		+ "    ,x1.num_fatt " &
		+ "    ,x1.data_fatt" &
		+ "    ,x1.iva " &
		+ "    ,sum(x1.prezzo_t )" &
		 + "   from arfa_v x1" &
  		+ "  where  x1.iva > 0 " &
		+ " 	group by " &
		+ " 	    x1.id_fattura " &
		+ " 	  , x1.num_fatt " &
		+ " 	   ,x1.data_fatt " &
		+ " 	   ,x1.iva "  


	EXECUTE IMMEDIATE "drop VIEW v_arfa_tot_imponibili" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(oldpointer)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on V_ARFA_TOT_IMPONIBILI to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(oldpointer)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			

	k_sql = "CREATE VIEW v_arfa  " &
	+ " (id_armo, clie_3 " &
  	+  " ,id_fattura " &
  	+  " ,num_fatt " &
	 +  " ,data_fatt " &
	  +  ",num_bolla_out " &
	  +  ",data_bolla_out " &
	  +  ",num_int, data_int  " &
 	 + " ,tipo_riga  " &
 	 + " ,nriga ,art  " &
	 + " ,iva,dose,colli  " &
  	 + " ,colli_out,peso_kg_out,prezzo_u,prezzo_t  " &
	 + " ,tipo_doc,stampa  " &
	 + " ,tipo_l " &
 	 + " ,cod_pag,prodotti_des  " &
 	 + " ,gruppo  " &
 	 + " ,magazzino  " &
 	 + " ,campione) " &
  	 + " AS  " &
      + " select x0.id_armo ,x0.clie_3 " & 
	 + "	,x0.id_fattura " & 
	 + "	,x0.num_fatt ,x0.data_fatt " & 
	  + "	,x0.num_bolla_out   " &
      + "   ,x0.data_bolla_out ,x1.num_int ,x1.data_int  " &
	 + "    ,x0.tipo_riga   " &
      + "    ,x0.nriga   " &
      + "    ,x1.art ,x0.iva ,x1.dose ,x0.colli ,x0.colli_out   " &
      + "    ,x0.peso_kg_out ,x0.prezzo_u   " &
      + "    ,x0.prezzo_t   " &
      + "    ,x0.tipo_doc   " &
      + "    ,x0.stampa   " &
      + "    ,x0.tipo_l     " &
      + "    ,x0.cod_pag  " &
      + "    ,x2.des    " &
      + "    ,x2.gruppo  " &
      + "    ,x1.magazzino   " &
      + "    ,x1.campione  " &
	 + " 	from (    " &
	 + " 		(arfa x0 join armo x1 on (x1.id_armo = x0.id_armo ) )  " &
	 + " 							left join prodotti x2 on (x2.codice = x1.art ) )  " &
 	 + " union all  " &
	 + "     select 0   " &
	 + " 		,x3.clie_3   " &
	 + " 		,x3.id_fattura   " &
	 + " 		,x3.num_fatt   " &
	 + " 		,x3.data_fatt   " &
	 + " 		,0  " &
	 + "       ,CONVERT(DATE, '01.01.1899') " &
	 + " 		,0   " &
	 + "       ,CONVERT(DATE, '01.01.1899') " &
	 + " 		,'V'   " &
      + "        ,x3.nriga  ,' '  " &
	 + " 		,x3.iva   " &
	 + " 		,0 ,x3.colli   " &
	 + " 		,x3.colli   " &
	 + " 		,0 ,x3.prezzo_u    " &
	 + " 		,x3.prezzo_t    " &
	 + " 		,x3.tipo_doc    " &
	 + " 		,x3.stampa    " &
	 + " 		,'C'    " &
	 + " 		,x3.cod_pag   " &
	 + " 		,x3.comm    " &
	 + " 		,0    " &
	 + " 		,0   " &
	 + " 		,'S'   " &
	 + "  	from  arfa_v x3  " 

	EXECUTE IMMEDIATE "drop VIEW v_arfa" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(oldpointer)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (2): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_arfa to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(oldpointer)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (2): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			



	SetPointer(oldpointer)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW fatture completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(oldpointer)

return k_codice

end function

private function boolean u_crea_view_v_arfa_x_id_armo () throws uo_exception;//-----------------------------------------------------------------------------------------------------------------------------
//--- Crea la View totali x id_armo
//--- 
//--- 
//------------------------------------------------------------------------------------------------------------------------------
boolean k_return = false
string k_sql
st_esito kst_esito
st_tab_treeview kst_tab_treeview_nulla, kst_tab_treeview
st_tab_treeview kst_tab_treeview_array[]
pointer oldpointer


try
	
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname( )



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(kkg.pointer_attesa )

	k_sql = "	CREATE VIEW v_arfa_x_id_armo  " & 
			+ "(id_armo, colli, colli_out, prezzo_t) AS " &
	 		+ " select  x0.id_armo, sum(x0.colli),  sum(x0.colli_out) , sum(x0.prezzo_t)  " &
	  		+ "     from arfa x0 " &
			+ "	 group by " &
			+ "           x0.id_armo " 

	EXECUTE IMMEDIATE "drop VIEW v_arfa_x_id_armo" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;
	if sqlca.sqlcode <> 0 then
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kguo_exception.inizializza( )
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
		kguo_exception.set_esito(kst_esito )
		throw kguo_exception
	end if
	
//	k_sql = "grant select on v_arfa_x_id_armo to ixuser as informix"		
//	EXECUTE IMMEDIATE :k_sql using sqlca;
//	if sqlca.sqlcode <> 0 then
//		kst_esito.esito = kkg_esito.db_ko
//		kst_esito.sqlcode = sqlca.sqlcode
//		kst_esito.sqlerrtext = "Errore durante GRANT View (1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//		kguo_exception.inizializza( )
//		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
//		kguo_exception.set_esito(kst_esito )
//		throw kguo_exception
//	end if	


	SetPointer(kkg.pointer_default)

	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.sqlerrtext = "Generazione VIEW fatture completata." 
	kguo_exception.inizializza( )
	kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_OK )
	kguo_exception.set_esito(kst_esito )
	kguo_exception.scrivi_log()
	 
	k_return = true
	
catch (uo_exception kuo_exception)
	kst_esito = kuo_exception.get_st_esito()
		
		
end try

return k_return


end function

public function boolean u_crea_view () throws uo_exception;//-------------------------------------------------------------------------------------------------------------
//--- Lanciato probabilemente solo la prima volta x creare le diverse view utili alla Procedura
//---
//---
//-------------------------------------------------------------------------------------------------------------
//
//
boolean krc = false, k_return=true

try

	krc = u_crea_view_v_arfa_x_id_armo( ) 
	if not krc then k_return=false
	krc = u_crea_view_v_arfa_tot_imponibili( ) 
	if not krc then k_return=false
	krc = u_crea_view_v_arfa_riga() 
	if not krc then k_return=false
	krc = u_crea_view_v_armo_out_colli()
	if not krc then k_return=false
	krc = u_crea_view_v_arsp_colli_x_id_armo()	
	if not krc then k_return=false
	krc = u_crea_view_v_crm_listino_prezzi()
	if not krc then k_return=false
	krc = u_crea_view_v_armo_colli_inout()
	if not krc then k_return=false
	krc = u_crea_view_v_meca_pl()
	if not krc then k_return=false
	krc = u_crea_view_v_meca_dosim_barcode_max()
	if not krc then k_return=false
	krc = v_crea_view_v_contratti_doc()
	if not krc then k_return=false
	krc = v_crea_view_v_contratti_all_rid()
	if not krc then k_return=false


catch (uo_exception kuo_exception)
	k_return = false
	kuo_exception.messaggio_utente()		
	
end try

return k_return 

end function

private function boolean u_crea_view_v_armo_out_colli () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_armo_out_colli'
//=== Righe fattura 
//===
int k_errore=0
boolean k_codice = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer  // Declares a pointer variable




//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	k_sql = "CREATE VIEW v_armo_out_colli  (" &
			+ " id_armo,   " &
				+ " colli   " &
				+ ") " &
				+ " AS  " &
				+ " select  " & 
				+ " armo_out.id_armo,  " &  
				+ " sum(armo_out.colli)    " &
				+ " from armo_out " &
				+ " group by id_armo "

	EXECUTE IMMEDIATE "drop VIEW v_armo_out_colli" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(oldpointer)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_armo_out_colli): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_armo_out_colli to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(oldpointer)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_armo_out_colli): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(oldpointer)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_armo_out_colli' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(oldpointer)

return k_codice

end function

private function boolean u_crea_view_v_arsp_colli_x_id_armo () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_arfa_riga'
//=== Righe fattura 
//===
int k_errore=0
boolean k_codice = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer  // Declares a pointer variable




//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	k_sql = "CREATE VIEW v_arsp_colli_x_id_armo  (" &
			+ " id_armo,   " &
				+ " colli   " &
				+ ") " &
				+ " AS  " &
				+ " select  " & 
				+ " arsp.id_armo,  " &  
				+ " sum(arsp.colli)    " &
				+ " from arsp " &
				+ " group by id_armo "

	EXECUTE IMMEDIATE "drop VIEW v_arsp_colli_x_id_armo" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(oldpointer)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_arsp_colli_x_id_armo): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_arsp_colli_x_id_armo to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(oldpointer)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_arsp_colli_x_id_armo): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(oldpointer)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_arsp_colli_x_id_armo' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(oldpointer)

return k_codice

end function

private function boolean u_crea_view_v_crm_listino_prezzi () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_crm_listino_prezzi' x CRM esterno
//=== Righe prezzi Listino
//===
int k_errore=0
boolean k_codice = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer  // Declares a pointer variable




//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	k_sql = "CREATE VIEW v_crm_listino_prezzi  (" &
                           + " id_listino,   " &
         				+ " prezzo,      " &
         				+ " id_listino_voce,   " &
         				+ " voce_decriz,   " &
         				+ " id_cond_fatt,      " &
         				+ " cond_fatt_descriz     " &
				+ " ) as   " &
  				+ " SELECT listino.id,      " &
         				+ " listino.prezzo,      " &
         				+ " 0,   " &
         				+ " '',   " &
         				+ " listino.id_cond_fatt_1,      " &
         				+ " cond_fatt.descr     " &
    				+ " FROM listino LEFT OUTER JOIN cond_fatt ON listino.id_cond_fatt_1 = cond_fatt.id   " &
   				+ " WHERE   " &
         				+ " listino.attivo = 'S' and attiva_listino_pregruppi <> 'S' and prezzo > 0      " &
		+ " union all   " &
				+ "   SELECT listino.id,      " &
         				+ " listino.prezzo_2,      " &
         				+ " 0,   " &
         				+ " '',   " &
         				+ " listino.id_cond_fatt_2,      " &
        			 	    + " cond_fatt.descr     " &
    				+ " FROM listino LEFT OUTER JOIN cond_fatt ON listino.id_cond_fatt_2 = cond_fatt.id   " &
   				+ " WHERE  listino.attivo = 'S' and attiva_listino_pregruppi <> 'S' and prezzo_2 > 0     " & 
		+ " union all   " &
  				+ " SELECT listino.id,      " &
         				+ " listino.prezzo_3,      " &
         				+ " 0,   " &
         				+ " '',   " &
         				+ " listino.id_cond_fatt_3,      " &
         				+ " cond_fatt.descr     " &
    				+ " FROM listino LEFT OUTER JOIN cond_fatt ON listino.id_cond_fatt_3 = cond_fatt.id   " &
   				+ " WHERE   " &
         				+ " listino.attivo = 'S' and attiva_listino_pregruppi <> 'S' and prezzo_3 > 0      " &
		+ " union all   " &   
  				+ " SELECT listino.id,   " &   
         				+ " listino_pregruppi_voci.prezzo,      " &
         				+ " listino_pregruppi_voci.id_listino_voce,      " &
         				+ " listino_voci.descr,      " &
         				+ " listino_link_pregruppi.id_cond_fatt,      " &
         				+ " cond_fatt.descr     " &
    				+ " FROM listino LEFT OUTER JOIN listino_link_pregruppi ON listino.id = listino_link_pregruppi.id_listino    " &
                         				+ " LEFT OUTER JOIN cond_fatt ON listino_link_pregruppi.id_cond_fatt = cond_fatt.id    " &
                         				+ " INNER JOIN listino_pregruppi_voci ON listino_link_pregruppi.id_listino_pregruppo = listino_pregruppi_voci.id_listino_pregruppo       " &
                         				+ " INNER JOIN listino_voci ON  listino_pregruppi_voci.id_listino_voce = listino_voci.id_listino_voce       " &
   				+ " WHERE    " &
         				+ " ( ( listino.attivo = 'S' and attiva_listino_pregruppi = 'S' ) )     " 

	EXECUTE IMMEDIATE "drop VIEW v_crm_listino_prezzi" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(oldpointer)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_crm_listino_prezzi): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_crm_listino_prezzi to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(oldpointer)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_crm_listino_prezzi): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(oldpointer)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_crm_listino_prezzi' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(oldpointer)

return k_codice

end function

private function boolean u_crea_view_v_armo_colli_inout () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_armo_colli_inout'
//=== Righe fattura 
//===
int k_errore=0
boolean k_codice = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer  // Declares a pointer variable




//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	k_sql = "CREATE VIEW v_armo_colli_inout  " &
			 + " (ID_MECA , " &
			 + " ID_ARMO , " &
			 + " COLLI_1 , " &
			 + " COLLI_2 , " &
			 + " colli_sped , " &
			 + " colli_fatt , " &
			 + " colli_trattati , " &
			 + " colli_danontrattare  " &
			 + ") " &
			+ " AS  " &
			+ " select  " & 
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2 , " &
			 + " sum(ARSP.COLLI) as colli_sped , " &
			 + " sum(0) , " &
			 + " sum(0) , " &
			 + " sum(0)  " &
			 + " from " &
			 + " 	ARMO left outer join ARSP on ARMO.ID_ARMO = ARSP.ID_ARMO  " &
          + " group by " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2  " &
		  + " union all  " &
			 + "     select    " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2 , " &
			 + " sum(0) , " &
			 + " sum(ARFA.COLLI) as colli_fatt , " &
			 + " sum(0) , " &
			 + " sum(0)  " &
			 + " from " &
			 + " 	ARMO inner join ARFA on ARMO.ID_ARMO = ARFA.ID_ARMO  " &
          + " group by " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2  " &
		 + " union all  " &
			 + "     select    " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2 , " &
			 + " sum(0) , " &
			 + " sum(0) , " &
			 + " count(barcode) as colli_trattati , " &
			 + " sum(0)  " &
			 + " from " &
			 + " 	ARMO inner join BARCODE on ARMO.ID_ARMO = BARCODE.ID_ARMO and barcode.data_lav_fin > CONVERT(DATE, '01.01.1899') " &
          + " group by " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2  " &
		 + " union all  " &
			 + "     select    " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2 , " &
			 + " sum(0) , " &
			 + " sum(0) , " &
			 + " sum(0) , " &
			 + " count(barcode) as colli_danontrattare  " &
			 + " from " &
			 + " 	ARMO inner join BARCODE on ARMO.ID_ARMO = BARCODE.ID_ARMO and barcode.causale = 'T' " &
          + " group by " &
			 + " ARMO.ID_MECA , " &
			 + " ARMO.ID_ARMO , " &
			 + " ARMO.COLLI_1 , " &
			 + " ARMO.COLLI_2  " 

//			 + " colli_nontrattati , " &

//		 + " union all  " &
//			 + "     select    " &
//			 + " ARMO.ID_MECA , " &
//			 + " ARMO.ID_ARMO , " &
//			 + " ARMO.COLLI_1 , " &
//			 + " ARMO.COLLI_2 , " &
//			 + " sum(0) , " &
//			 + " sum(0) , " &
//			 + " sum(0) , " &
//			 + " count(barcode) as colli_nontrattati , " &
//			 + " sum(0)  " &
//			 + " from " &
//			 + " 	ARMO inner join BARCODE on ARMO.ID_ARMO = BARCODE.ID_ARMO and (barcode.data_lav_fin <= date(0) or barcode.data_lav_fin is null)" &
//          + " group by " &
//			 + " ARMO.ID_MECA , " &
//			 + " ARMO.ID_ARMO , " &
//			 + " ARMO.COLLI_1 , " &
//			 + " ARMO.COLLI_2  " &

	EXECUTE IMMEDIATE "drop VIEW v_armo_colli_inout" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(oldpointer)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_armo_colli_inout): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_armo_colli_inout to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(oldpointer)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_armo_colli_inout): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(oldpointer)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_armo_colli_inout' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(oldpointer)

return k_codice

end function

private function boolean u_crea_view_v_armo_out_dosezero_old () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_armo_out_dosezero'
//=== Righe fattura 
//===
int k_errore=0
boolean k_codice = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer  // Declares a pointer variable




//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

	k_sql = "CREATE VIEW v_armo_out_dosezero  (" &
			+ " ID_ARMO, " &
			+ " ,colli " &
			+ ") " &
			+ " AS  " &
		+ "	select " &
			+ " ID_ARMO, " &
			+ " ,sum(arsp.colli_2) " &
			+ " from ARMO inner join arsp on armo.id_armo = arsp.id_armo " &
			+ " where ARMO.DATA_INT > today -700  and " &
			+ " ARMO.DOSE = 0 " &
			+ " group by id_armo " &
		+ " union all " &
		+ " select " &
			+ " ID_ARMO, " &
			+ " ,sum(armo_out.colli) " &
			+ " from ARMO inner join armo_out on armo.id_armo = armo_out.id_armo " &
			+ " where ARMO.DATA_INT > today -700  and " &
			+ " ARMO.DOSE = 0 " &
			+ " group by id_armo "

	EXECUTE IMMEDIATE "drop VIEW v_armo_out_dosezero" using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_codice = false
		k_errore = 1
		SetPointer(oldpointer)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_armo_out_dosezero): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_armo_out_dosezero to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_codice = false
//			k_errore = 1
//			SetPointer(oldpointer)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_armo_out_dosezero): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(oldpointer)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.ok
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_armo_out_dosezero' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(oldpointer)

return k_codice

end function

private function boolean u_crea_view_v_meca_pl () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_meca_pl_v1' (ex v_meca_pl)
//=== Righe fattura 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	k_sql = "CREATE VIEW v_meca_pl_v1  " &
			+ " (id_armo , " &
			+ " contati, " & 
         + " contati_orig, " & 
         + " data_ent,    " & 
         + " data_int,    " & 
         + " num_int,    " & 
         + " contratto,    " & 
         + " area_mag,     " & 
			+ " area_mag_pos, "  &
         + " mc_co,    " & 
         + " sc_cf,    " & 
         + " sl_pt,    " & 
         + " descr,  "   & 
         + " clie_1,    " & 
         + " clie_2,    " & 
         + " clie_3,    " & 
         + " num_bolla_in,    " & 
         + " data_bolla_in,   " & 
         + " consegna_data, " & 
         + " consegna_dataora, " & 
			+ " pl_barcode, " &
         + " fila_1,    " & 
         + " fila_2,    " & 
         + " fila_1p,    " & 
         + " fila_2p,    " & 
         + " grp " & 
         + " ,stato_in_attenzione " & 
         + " ,id " & 
         + " ,barcode_dosimetro " & 
         + " ,k_wm_associato " & 
         + " ,e1doco " & 
         + " ,e1rorn " & 
         + " ,e1srst " & 
	      + ") " &
			+ " AS  " &
			+ " select  " & 
         + " barcode.id_armo,    " & 
         + " count(*) as contati, " & 
         + " count(*) as contati_orig, " & 
         + " meca.data_ent,    " & 
         + " meca.data_int,    " & 
         + " meca.num_int,    " & 
         + " meca.contratto,    " & 
         + " meca.area_mag,     " & 
			+ " substring(meca.area_mag, 5, 1), "  &
         + " contratti.mc_co,    " & 
         + " contratti.sc_cf,    " & 
         + " contratti.sl_pt,    " & 
         + " contratti.descr,  "   & 
         + " meca.clie_1,    " & 
         + " meca.clie_2,    " & 
         + " meca.clie_3,    " & 
         + " meca.num_bolla_in,    " & 
         + " meca.data_bolla_in,   " & 
         + " consegna_data, " & 
         + " CONVERT(DATETIME, CONVERT(CHAR(8), consegna_data, 112) + ' ' + CONVERT(CHAR(8), coalesce(consegna_ora, '00:00:00'), 108)) , " &
			+ " coalesce(barcode.pl_barcode, 0), " &
         + " barcode.fila_1,    " & 
         + " barcode.fila_2,    " & 
         + " barcode.fila_1p,    " & 
         + " barcode.fila_2p,    " & 
         + " max(barcode.groupage) as grp " & 
         + " ,meca.stato_in_attenzione " & 
         + " ,meca.id " & 
         + " ,'' as barcode_dosimetro" & 
         + " ,'A' as k_wm_associato " & 
         + " ,coalesce(meca.e1doco, 0) " & 
         + " ,coalesce(meca.e1rorn, 0) " & 
         + " ,coalesce(e1srst, 'NC') " & 
     + " FROM  meca " & 
          + " INNER JOIN barcode ON meca.id = barcode.id_meca " & 
          + " LEFT OUTER JOIN contratti ON meca.contratto = contratti.codice  " & 
   + " WHERE  " & 
        + "  (meca.stato = 0 or meca.stato is null)  " &
        + " and ((meca.aperto <> 'N' and meca.aperto <> 'A') or meca.aperto is null)  " &
		+ "   and (barcode.barcode_lav is null or barcode.barcode_lav = '')  " &
		 + "  and barcode.data_stampa > CONVERT(date,'01.01.1899')  " &
		 + "  and (barcode.data_sosp <= CONVERT(date,'01.01.1990') or barcode.data_sosp is null)   " &
		 + "  and (barcode.causale <> 'T' or barcode.causale is null)   " &
    + " group by " &
		 + " barcode.id_armo , " &
         + " meca.data_int,   " &
         + " meca.data_ent,   " &
         + " meca.num_int,   " &
         + " meca.contratto,  "  &
         + " meca.area_mag,   " &
         + " contratti.mc_co,  "  &
         + " contratti.sc_cf,  "  &
         + " contratti.sl_pt,  "  &
         + " contratti.descr,  "  &
         + " meca.clie_1,  "  &
         + " meca.clie_2,  "  &
         + " meca.clie_3,  "  &
         + " meca.num_bolla_in,  "  &
         + " meca.data_bolla_in, "  &
         + " meca.consegna_data, " &
         + " meca.consegna_ora, " &
		   + " barcode.pl_barcode, " &
         + " barcode.fila_1,   " &
         + " barcode.fila_2,  "  &
         + " barcode.fila_1p, "   &
         + " barcode.fila_2p,  "  &
         + " meca.stato_in_attenzione " &
         + " ,meca.id " &
         + " ,meca.e1doco " & 
         + " ,meca.e1rorn " &
         + " ,meca.e1srst " 


//         + " coalesce(CONVERT(DATETIME, CONVERT(CHAR(8), consegna_data, 112) + ' ' + CONVERT(CHAR(8), consegna_ora, 108)), convert(datetime, '01.01.1900 00:00:00')) , " &
//         + " meca.consegna_data, " & 
///         + " coalesce(meca.consegna_ora, convert(time, '00:00')), " & 


	EXECUTE IMMEDIATE "drop VIEW v_meca_pl_v1 " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(oldpointer)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(oldpointer)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(oldpointer)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_meca_pl_v1' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(oldpointer)

return k_return

end function

public function integer u_crea_spl_chiudi_bolle ();
//CREATE FUNCTION u_m2000_chiudi_bolle()
//		RETURNING INT
//
//   define
//      k_conta_righe           integer
//      ,k_colli_arfa           integer
//      ,k_colli_arsp           integer
//      ,K_NUM_BOLLA_OUT        like ARSP.NUM_BOLLA_OUT 
//      ,K_DATA_BOLLA_OUT       like ARSP.DATA_BOLLA_OUT 
//      ,K_ID_ARMO              like ARMO.ID_ARMO
//      ,k_data_start           date
//      ,k_gg                   integer
//      ,k_mm                   integer
//      ,k_aa                   integer
//      ,k_data_elab          date
//
//
//
//#   begin work
//
//   let K_AA    = year(today) - 1
//   let K_MM    = month(today)
//   let K_GG    = day(today)
//   if k_mm > 6 then
//      let k_mm = k_mm - 6
//   else
//      let k_aa = k_aa - 1
//      let k_mm = k_mm + 6 
//   end if
//   let k_data_start = mdy(k_mm, k_gg, k_aa)
//   
//   
//   let k_data_elab = mdy(01,01, year(today) - 1)      
//
//#--- declare per estrazione BOLLE con flag non 'F' da un anno e piu' indietro
//   declare M_ESTR_S_c_elenco_bolle cursor with hold for
//   select NUM_BOLLA_OUT, DATA_BOLLA_OUT
//       from sped 
//       where DATA_BOLLA_OUT > k_data_elab
//             and STAMPA <> 'F'
//
//#--- declare per estrazione righe BOLLA
//   declare M_ESTR_S_c_elenco_righe cursor with hold for
//   select distinct id_armo
//       from arsp 
//       where NUM_BOLLA_OUT = K_NUM_BOLLA_OUT
//             and DATA_BOLLA_OUT = K_DATA_BOLLA_OUT
//
//
//   open M_ESTR_S_c_elenco_bolle 
//
//#--- estrae le bolle non fatturate
//   foreach M_ESTR_S_c_elenco_bolle into K_NUM_BOLLA_OUT, K_DATA_BOLLA_OUT
//          
//      open M_ESTR_S_c_elenco_righe 
//
//#--- estrae la riga della bolle non fatturata
//      foreach  M_ESTR_S_c_elenco_righe into k_id_armo
//
//         select sum(colli)
//           into k_colli_arsp
//           from arsp 
//           where id_armo = k_id_armo 
//
//         let k_colli_arfa = 0 
//         select sum(colli)
//           into k_colli_arfa
//           from arfa
//           where id_armo = k_id_armo and (id_armo_prezzo = 0 or id_armo_prezzo is null)
//
//#--- se non trovato alcun collo fatturato allora tento per lotti con i prezzi spacchettati
//         if status > 0 or k_colli_arfa = 0 or k_colli_arfa is null then   
//
//            select sum(colli)
//              into k_colli_arfa
//              from arfa, armo_prezzi
//              where arfa.id_armo = k_id_armo and arfa.id_armo_prezzo > 0 
//                    and arfa.id_armo_prezzo = armo_prezzi.id_armo_prezzo and armo_prezzi.tipo_calcolo = "U"
//
//         end if
//         
//         if status >= 0 then
//         
//#--- se la riga e' stata totalmete fatturata
//            if k_colli_arfa = k_colli_arsp then 
//
//#--- aggiorna ARSP con il flag BOLLA FATTURATA              
//               update ARSP
//                 set
//                    ARSP.STAMPA = "F" 
//                 where ARSP.NUM_BOLLA_OUT  = K_NUM_BOLLA_OUT  and
//                       ARSP.DATA_BOLLA_OUT = K_DATA_BOLLA_OUT and
//                       ARSP.ID_ARMO        = K_ID_ARMO
//
//            end if
//         end if
//
//      end foreach 
//
//      CLOSE M_ESTR_S_c_elenco_righe 
//
//#--- Conta le righe bolla SENZA il flag BOLLA FATTURATA              
//      let k_conta_righe = 0
//      select count(*) into k_conta_righe
//            from arsp
//            where  ARSP.STAMPA          <> "F"
//                   and ARSP.NUM_BOLLA_OUT  = K_NUM_BOLLA_OUT  
//                   and ARSP.DATA_BOLLA_OUT = K_DATA_BOLLA_OUT 
//                   
//      if k_conta_righe = 0 then
//#--- se non ci sono piu' righe NON FATT allora aggiorna SPED con il flag BOLLA FATTURATA              
//         update SPED
//           set
//              STAMPA          = "F"
//           where NUM_BOLLA_OUT  = K_NUM_BOLLA_OUT  and
//                 DATA_BOLLA_OUT = K_DATA_BOLLA_OUT 
//      end if
//
//   end foreach 
//
//   CLOSE M_ESTR_S_c_elenco_bolle 
//
//#   commit work
//
//   if INT_FLAG != 0 then
//      goto M_ESTR_S_FORZA_FINE8
//   end if
//
//#=== Errore durante estrazione
//   if STATUS != 0 then
//      let K_STATUS = 19
//   end if
//
//   if INT_FLAG != 0 then
//      goto M_ESTR_S_FORZA_FINE8
//   end if
//      
//   goto M_ESTR_S_OK8
//
//
//label M_ESTR_S_FORZA_FINE8:
//   let K_STATUS  = 7
//
//
//label M_ESTR_S_OK8:
//
//end function
//
return 0
end function

private function boolean u_crea_view_e1_v_e1barcode () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View su DB ORACLE 'v_e1barcode' 
//=== Righe fattura 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
kuf_e1_conn_cfg kuf1_e1_conn_cfg


try

//=== Puntatore Cursore da attesa.....
	SetPointer(kkg.pointer_attesa)

	kuf1_e1_conn_cfg = create kuf_e1_conn_cfg

	k_sql = "CREATE VIEW v_e1barcode  " &
			+ " (wadoco , " &
			+ " waan8, " & 
	       	+ " wadrqj, " & 
  	       	+ " wmcpil,    " & 
  	       	+ " wmlotn,    " & 
  	       	+ " iolot2,    " & 
  	       	+ " waapid     " & 
	      	+ ") " &
			+ " AS  " &
			+ " select  " & 
         + "  f4801.wadoco , " & 
          + " f4801.waan8 , " & 
          + " f4801.wadrqj , " & 
          + " f3111.wmcpil , " & 
          + " f3111.wmlotn , " & 
          + " f4108.iolot2 , " & 
          + " f4801.waapid " & 
     + " FROM  F4801_ADT  f4801   " & 
          + " INNER JOIN F3111_ADT  f3111 on ON f4801.wadoco = f3111.wmdoco  " & 
          + " inner join F4108_adt  f4108 on f3111.wmlotn = f4108.iolotn  " & 
   + " WHERE  " & 
        + "  f3111.wmlnty = 'S'   " &
		+ "   and f4801.wasrst = '08'  " &
		+ "  and f4801.wamcu = '" + kguo_g.E1MCU + "'  " &
		+ "  and f4108.iomcu = '" + kguo_g.E1MCU + "'  "

//	k_sql = kuf1_e1_conn_cfg.u_sql_set_schema_nome(k_sql)  // imposta il giusto nome schema

	kguo_sqlca_db_e1.db_connetti( )

	EXECUTE IMMEDIATE "drop VIEW v_e1barcode " using kguo_sqlca_db_e1 ;

	EXECUTE IMMEDIATE :k_sql using kguo_sqlca_db_e1;

	if kguo_sqlca_db_e1.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		kguo_exception.inizializza()
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = kguo_sqlca_db_e1.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_e1barcode): " + string(kguo_sqlca_db_e1.sqldbcode, "#####") + "; " +kguo_sqlca_db_e1.sqlerrtext
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
		kguo_exception.set_esito(kst_esito )
		throw kguo_exception
//	else
//		k_sql = "grant select on v_e1barcode to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using kguo_sqlca_db_e1;
//		if kguo_sqlca_db_e1.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = kguo_sqlca_db_e1.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_e1barcode): " + string(kguo_sqlca_db_e1.sqldbcode, "#####") + "; " +kguo_sqlca_db_e1.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
		
	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = kguo_sqlca_db_e1.sqlcode
	kst_esito.sqlerrtext = "Generazione VIEW 'v_e1barcode' completata." 
	kguo_exception.inizializza()
	kguo_exception.set_tipo( kguo_exception.KK_st_uo_exception_tipo_OK )
	kguo_exception.set_esito(kst_esito )
	kguo_exception.scrivi_log()
	
catch	 (uo_exception kuo_exception)
	throw kuo_exception
	
finally
	SetPointer(kkg.pointer_default)
	
end try

return k_return

end function

private function boolean u_crea_view_v_meca_dosim_barcode_max () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_meca_dosim_barcode_max'
//=== Righe fattura 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)


	k_sql = "CREATE VIEW v_meca_dosim_barcode_max  " &
			+ " (id_meca , " &
			+ " barcode_dosimetro " & 
	      + ") " &
			+ " AS  " &
			+ " select  distinct " & 
                      + " meca_dosim.id_meca  " & 
                      + "  ,max(meca_dosim.barcode_dosimetro)  " & 
                      + " FROM  meca_dosim " &
					+ " group by meca_dosim.id_meca "

	EXECUTE IMMEDIATE "drop VIEW v_meca_dosim_barcode_max " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(oldpointer)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_meca_dosim_barcode_max): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
	end if	

	SetPointer(oldpointer)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_meca_pl_v1' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(oldpointer)

return k_return

end function

private function boolean v_crea_view_v_contratti_doc () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_contratti_doc' 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
	oldpointer = SetPointer(HourGlass!)

k_sql = "create view v_contratti_doc  " &
		+ " as SELECT ctr.id_contratto_doc " &
		+ " ,ctr.offerta_data " &
		+ " ,ctr.stampa_tradotta " & 
		+ " ,ctr.stato " &
		+ " ,ctr.data_stampa " & 
		+ " ,form_di_stampa " & 
		+ " ,ctr.esito_operazioni_ts_operazione " & 
		+ " ,JSON_VALUE(ctr.dati_contratto, '$.anno') anno " & 
		+ " ,JSON_VALUE(ctr.dati_contratto,'$.magazzino') magazzino " & 
		+ " ,trim(JSON_VALUE(ctr.dati_contratto ,'$.offerta_validita')) offerta_validita " & 
		+ " ,trim(JSON_VALUE(ctr.dati_contratto ,'$.oggetto')) oggetto " & 
		+ " ,case  " & 
 		+ " when JSON_VALUE(ctr.dati_contratto ,'$.id_cliente') > '0' then JSON_VALUE(ctr.dati_contratto ,'$.id_cliente')  " & 
		+ " 	 else 0 " & 
		+ " end id_cliente " & 
		+ " ,JSON_VALUE(ctr.dati_contratto ,'$.id_clie_settore') id_clie_settore " & 
		+ " ,JSON_VALUE(ctr.dati_contratto ,'$.gruppo') gruppo " & 
		+ " ,trim(JSON_VALUE(ctr.dati_contratto ,'$.nome_contatto')) nome_contatto " & 
		+ " ,trim(JSON_VALUE(ctr.dati_contratto ,'$.note')) note " & 
		+ " ,trim(JSON_VALUE(ctr.dati_contratto ,'$.note_audit')) note_audit " & 
		+ " ,trim(JSON_VALUE(ctr.dati_contratto ,'$.note_fasi_operative')) note_fasi_operative " & 
		+ " ,JSON_VALUE(ctr.dati_contratto ,'$.iva') iva " & 
		+ " ,JSON_VALUE(ctr.dati_contratto ,'$.cod_pag') cod_pag " & 
		+ " ,trim(JSON_VALUE(ctr.dati_contratto ,'$.banca')) banca " & 
		+ " ,JSON_VALUE(ctr.dati_contratto ,'$.abi') abi  " & 
		+ " ,JSON_VALUE(ctr.dati_contratto ,'$.cab') cab " & 
		+ " ,trim(JSON_VALUE(ctr.dati_contratto ,'$.altre_condizioni')) altre_condizioni " & 
		+ " ,JSON_VALUE(ctr.dati_contratto ,'$.data_inizio') data_inizio  " & 
		+ " ,JSON_VALUE(ctr.dati_contratto ,'$.data_fine') data_fine " & 
		+ " ,JSON_VALUE(ctr.dati_contratto ,'$.fattura_da') fattura_da " & 
		+ " ,trim(JSON_VALUE(ctr.dati_contratto ,'$.art')) art " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.id_listino_pregruppo') id_listino_pregruppo  " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[0].id_listino_voce') id_listino_voce_1 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[1].id_listino_voce') id_listino_voce_2 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[2].id_listino_voce') id_listino_voce_3 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[3].id_listino_voce') id_listino_voce_4 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[4].id_listino_voce') id_listino_voce_5 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[5].id_listino_voce') id_listino_voce_6 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[6].id_listino_voce') id_listino_voce_7 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[7].id_listino_voce') id_listino_voce_8 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[8].id_listino_voce') id_listino_voce_9 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[9].id_listino_voce') id_listino_voce_10 " & 
		+ " , case  " & 
 		+ " when JSON_VALUE(ctr.dati_contratto ,'$.voci[0].voce_prezzo') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.voci[0].voce_prezzo'))  " & 
 		+ " else 0.00 " & 
		+ " end voce_prezzo_1 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[1].voce_prezzo') voce_prezzo_2 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[2].voce_prezzo') voce_prezzo_3 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[3].voce_prezzo') voce_prezzo_4 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[4].voce_prezzo') voce_prezzo_5 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[5].voce_prezzo') voce_prezzo_6 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[6].voce_prezzo') voce_prezzo_7 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[7].voce_prezzo') voce_prezzo_8 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[8].voce_prezzo') voce_prezzo_9 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[9].voce_prezzo') voce_prezzo_10 " & 
		+ " , case  " & 
		+ "  when JSON_VALUE(ctr.dati_contratto ,'$.totale_contratto') > '0' then convert(float, JSON_VALUE(ctr.dati_contratto ,'$.totale_contratto'))  " & 
		+ "  else 0.00 " & 
		+ " end totale_contratto " & 
		+ " , trim(JSON_VALUE(ctr.dati_contratto ,'$.voci[0].descr')) descr_1 " & 
		+ " , trim(JSON_VALUE(ctr.dati_contratto ,'$.voci[1].descr')) descr_2 " & 
		+ " , trim(JSON_VALUE(ctr.dati_contratto ,'$.voci[2].descr'))  descr_3 " &
		+ " , trim(JSON_VALUE(ctr.dati_contratto ,'$.voci[3].descr'))  descr_4 " &
		+ " , trim(JSON_VALUE(ctr.dati_contratto ,'$.voci[4].descr'))  descr_5 " &
		+ " , trim(JSON_VALUE(ctr.dati_contratto ,'$.voci[5].descr'))  descr_6 " &
		+ " , trim(JSON_VALUE(ctr.dati_contratto ,'$.voci[6].descr'))  descr_7 " &
		+ " , trim(JSON_VALUE(ctr.dati_contratto ,'$.voci[7].descr'))  descr_8 " &
		+ " , trim(JSON_VALUE(ctr.dati_contratto ,'$.voci[8].descr'))  descr_9 " &
		+ " , trim(JSON_VALUE(ctr.dati_contratto ,'$.voci[9].descr'))  descr_10 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[0].voce_prezzo_tot') voce_prezzo_tot_1 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[1].voce_prezzo_tot') voce_prezzo_tot_2  " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[2].voce_prezzo_tot') voce_prezzo_tot_3  " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[3].voce_prezzo_tot') voce_prezzo_tot_4  " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[4].voce_prezzo_tot') voce_prezzo_tot_5  " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[5].voce_prezzo_tot') voce_prezzo_tot_6  " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[6].voce_prezzo_tot') voce_prezzo_tot_7  " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[7].voce_prezzo_tot') voce_prezzo_tot_8  " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[8].voce_prezzo_tot') voce_prezzo_tot_9 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[9].voce_prezzo_tot ') voce_prezzo_tot_10 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[0].voce_qta') voce_qta_1 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[1].voce_qta') voce_qta_2 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[2].voce_qta') voce_qta_3 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[3].voce_qta') voce_qta_4 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[4].voce_qta') voce_qta_5 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[5].voce_qta') voce_qta_6 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[6].voce_qta') voce_qta_7 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[7].voce_qta') voce_qta_8 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[8].voce_qta') voce_qta_9 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[9].voce_qta') voce_qta_10 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[0].flg_st_voce') flg_st_voce_1 " & 
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[1].flg_st_voce') flg_st_voce_2 " &  
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[2].flg_st_voce') flg_st_voce_3 " &  
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[3].flg_st_voce') flg_st_voce_4 " &  
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[4].flg_st_voce') flg_st_voce_5 " &  
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[5].flg_st_voce') flg_st_voce_6 " &  
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[6].flg_st_voce') flg_st_voce_7 " &  
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[7].flg_st_voce') flg_st_voce_8 " &  
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[8].flg_st_voce') flg_st_voce_9 " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.voci[9].flg_st_voce') flg_st_voce_10 " &  
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.flg_fatt_dopo_valid') flg_fatt_dopo_valid " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.id_meca_causale') id_meca_causale " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.acconto_perc') acconto_perc " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.acconto_imp') acconto_imp " &
		+ " , JSON_VALUE(ctr.dati_contratto ,'$.acconto_cod_pag') acconto_cod_pag " &
		+ " , JSON_VALUE(ctr.dati_contratto, '$.id_docprod') id_docprod " &
		+ " , JSON_VALUE(ctr.dati_contratto, '$.quotazione_tipo') quotazione_tipo " &
		+ " , trim(JSON_VALUE(ctr.dati_contratto, '$.quotazione_cod')) quotazione_cod " &
		+ " , trim(JSON_VALUE(ctr.dati_contratto, '$.cliente_desprod')) cliente_desprod " &
		+ " , trim(JSON_VALUE(ctr.dati_contratto, '$.cliente_desprod_rid')) cliente_desprod_rid " &
		+ " , ctr.x_datins " &
		+ " , ctr.x_utente " &
		+ " FROM contratti_doc as ctr " 
		
	EXECUTE IMMEDIATE "drop VIEW v_contratti_doc " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(oldpointer)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_contratti_doc): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(oldpointer)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(oldpointer)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_contratti_doc' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(oldpointer)

return k_return

end function

private function boolean v_crea_view_v_contratti_all_rid () throws uo_exception;//
//=== Estemporanea da lanciare una sola volta
//=== Crae tabella View  'v_contratti_all_rid' 
//===
int k_errore=0
boolean k_return = true
string k_sql
st_esito kst_esito
uo_exception kuo_exception
pointer oldpointer  // Declares a pointer variable



//=== Puntatore Cursore da attesa.....
oldpointer = SetPointer(HourGlass!)

k_sql = "create view  v_contratti_all_rid   " &
		+ "as   " &
		+ " SELECT  " &
		+ " offerta_data  " &
		+ " , [offerta_validita]  " &
		+ " , isnull([oggetto], '') oggetto  " &
		+ " , isnull([id_cliente], 0) id_cliente  " &
		+ " , isnull([nome_contatto], '') nome_contatto  " &
		+ " , isnull([note], '') note  " &
		+ " , isnull(note_audit, '') note_audit  " &
		+ " , isnull(note_fasi_operative, '') note_fasi_operative  " &
		+ " , isnull([banca], '') banca  " &
		+ " , isnull([abi], 0) abi  " &
		+ " , isnull([cab], 0) cab  " &
		+ " , isnull([altre_condizioni], '') altre_condizioni  " &
		+ " , isnull([fattura_da], '') fattura_da  " &
		+ " ,'' quotazione_cod  " &
		+ " ,'' cliente_desprod  " &
		+ " ,'' cliente_desprod_rid  " &
		+ " ,'' unita_misura  " &
		+ " ,'' note_qtax  " &
		+ " ,'' note_fatt  " &
		+ " ,'' consegna_des  " &
		+ " ,'' ritiro_des  " &                                        
		+ " ,'' contratti_des  " &                                        
		+ " ,'' reso_des  " &                                        
		+ " ,'' gest_doc_des  " &                                        
		+ " ,'' dir_tecnico_des  " &                                        
		+ " ,'' analisi_lab_des  " &                                        
		+ " ,'' dosim_agg_des  " &                                        
		+ " ,'' logistica_des  " &                                        
		+ " ,'' stoccaggio_des  " &                                        
		+ " ,'' altro_des  " &                                        
		+ " ,'' note_interne  " &                                        
		+ " FROM contratti_rd " &                                        
		+ " union all  " &                                        
		+ " SELECT  " &                                        
		+ " offerta_data  " &                                        
		+ " , [offerta_validita]  " &                                        
		+ " , isnull([oggetto], '')  " &                                        
		+ " , isnull([id_cliente], 0)  " &                                        
		+ " , isnull([nome_contatto], '')  " &                                        
		+ " , isnull([note], '')  " &                                        
		+ " , '' note_audit  " &                                        
		+ " , '' note_fasi_operative  " &                                        
		+ " , isnull([banca], '')  " &                                        
		+ " , isnull([abi], 0)  " &                                        
		+ " , isnull([cab], 0)  " &                                        
		+ " , isnull([altre_condizioni], '')  " &                                        
		+ " , isnull([fattura_da], '')  " &                                        
		+ " , '' quotazione_cod  " &                                        
		+ " , '' cliente_desprod  " &                                        
		+ " , '' cliente_desprod_rid  " &                                        
		+ " , isnull([unita_misura], '')  " &                                        
		+ " , isnull([note_qtax], '')  " &                                        
		+ " , isnull([note_fatt], '')  " &                                        
		+ " , isnull([consegna_des], '')  " &                                        
		+ " , isnull([ritiro_des], '')  " &                                        
		+ " , isnull([contratti_des], '')  " &                                        
		+ " , isnull([reso_des], '')  " &                                        
		+ " , isnull([gest_doc_des], '')  " &                                        
		+ " , isnull([dir_tecnico_des], '')  " &                                        
		+ " , isnull([analisi_lab_des], '')  " &                                        
		+ " , isnull([dosim_agg_des], '')  " &                                        
		+ " , isnull([logistica_des], '')  " &                                        
		+ " , isnull([stoccaggio_des], '')  " &                                        
		+ " , isnull([altro_des], '')  " &                                        
		+ " , isnull([note_interne], '')  " &                                        
		+ " FROM contratti_co " &                                        
		+ " union all  " &                                        
		+ " SELECT   " &                                        
		+ " offerta_data  " &                                        
		+ " ,JSON_VALUE(ctr.dati_contratto ,'$.offerta_validita') offerta_validita,  " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.oggetto') oggetto,  " &                                        
		+ " case    " &                                        
		+ "   when JSON_VALUE(ctr.dati_contratto ,'$.id_cliente') > '0' then JSON_VALUE(ctr.dati_contratto ,'$.id_cliente')  " &                                         
		+ "   else 0  " &                                        
		+ " end id_cliente,   " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.nome_contatto')  nome_contatto,  " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.note') note,  " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.note_audit') note_audit,  " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.note_fasi_operative') note_fasi_operative,  " &                                        
		+ " rtrim(JSON_VALUE(ctr.dati_contratto ,'$.banca')) banca  " &                                        
		+ " ,case    " &                                        
		+ "   when JSON_VALUE(ctr.dati_contratto ,'$.abi') > '0' then JSON_VALUE(ctr.dati_contratto ,'$.abi')  " &                                        
		+ "   else 0  " &                                        
		+ " end abi  " &                                        
		+ " ,case    " &                                        
		+ "   when JSON_VALUE(ctr.dati_contratto ,'$.cab') > '0' then JSON_VALUE(ctr.dati_contratto ,'$.cab')   " &                                        
		+ "   else 0  " &                                        
		+ " end cab,   " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.altre_condizioni') altre_condizioni,  " &                                        
		+ " JSON_VALUE(ctr.dati_contratto ,'$.fattura_da') fattura_da  " &                                        
		+ " , JSON_VALUE(ctr.dati_contratto, '$.quotazione_cod') quotazione_cod  " &                                        
		+ " , JSON_VALUE(ctr.dati_contratto, '$.cliente_desprod') cliente_desprod  " &                                        
		+ " , JSON_VALUE(ctr.dati_contratto, '$.cliente_desprod_rid') cliente_desprod_rid  " &                                        
		+ " ,'' unita_misura  " &                                        
		+ " ,'' note_qtax  " &                                        
		+ " ,'' note_fatt  " &                                        
		+ " ,'' consegna_des  " &                                        
		+ " ,'' ritiro_des  " &                                        
		+ " ,'' contratti_des  " &                                        
		+ " ,'' reso_des  " &                                        
		+ " ,'' gest_doc_des  " &                                        
		+ " ,'' dir_tecnico_des  " &                                        
		+ " ,'' analisi_lab_des  " &                                        
		+ " ,'' dosim_agg_des  " &                                        
		+ " ,'' logistica_des  " &                                        
		+ " ,'' stoccaggio_des  " &                                        
		+ " ,'' altro_des  " &                                        
		+ " ,'' note_interne  " &                                        
		+ " FROM contratti_doc as ctr  "
	
	EXECUTE IMMEDIATE "drop VIEW v_contratti_all_rid " using sqlca;

	EXECUTE IMMEDIATE :k_sql using sqlca;

	if sqlca.sqlcode <> 0 then
		k_return = false
		k_errore = 1
		SetPointer(oldpointer)
		kuo_exception = create uo_exception
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante creazione View (v_contratti_all_rid): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
		kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
		kuo_exception.set_esito(kst_esito )
		throw kuo_exception
//	else
//		k_sql = "grant select on v_meca_pl_v1 to ixuser as informix"		
//		EXECUTE IMMEDIATE :k_sql using sqlca;
//		if sqlca.sqlcode <> 0 then
//			k_return = false
//			k_errore = 1
//			SetPointer(oldpointer)
//			kuo_exception = create uo_exception
//			kst_esito.nome_oggetto = this.classname()
//			kst_esito.esito = kkg_esito.db_ko
//			kst_esito.sqlcode = sqlca.sqlcode
//			kst_esito.sqlerrtext = "Errore durante GRANT View (v_meca_pl_v1): " + string(sqlca.sqldbcode, "#####") + "; " +sqlca.sqlerrtext
//			kuo_exception.set_tipo( kuo_exception.kk_st_uo_exception_tipo_err_int )
//			kuo_exception.set_esito(kst_esito )
//			throw kuo_exception
//		end if	
	end if	
			


	SetPointer(oldpointer)

	if k_errore = 0 then
		
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Generazione VIEW 'v_contratti_all_rid' completata." 
		kuo_exception = create uo_exception
		kuo_exception.set_tipo( kuo_exception.KK_st_uo_exception_tipo_OK )
		kuo_exception.set_esito(kst_esito )
		kuo_exception.scrivi_log()
		destroy kuo_exception
	end if
	
	 
SetPointer(oldpointer)

return k_return

end function

on kuf_utility_db.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_utility_db.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

