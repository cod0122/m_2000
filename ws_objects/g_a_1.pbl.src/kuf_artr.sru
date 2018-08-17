$PBExportHeader$kuf_artr.sru
forward
global type kuf_artr from nonvisualobject
end type
end forward

global type kuf_artr from nonvisualobject
end type
global kuf_artr kuf_artr

type variables
//
public st_tab_artr kist_tab_artr

end variables

forward prototypes
public subroutine tree_cbarre (ref treeview ktree_artr)
public function st_esito leggi (integer k_tipo, ref st_tab_artr kst_tab_artr)
public function st_esito cancella_pl_barcode (ref st_tab_artr kst_tab_artr)
public function st_esito crea_attestato_dettaglio (ref st_tab_artr kst_tab_artr)
public subroutine if_isnull (st_tab_artr kst_tab_artr)
public function st_esito aggiorna_data_stampa_attestato (ref st_tab_artr kst_tab_artr)
public function st_esito tb_delete ()
public function st_esito chiudi_lavorazione (ref st_tab_artr kst_tab_artr)
public function st_esito anteprima (datawindow kdw_anteprima, st_tab_artr kst_tab_artr)
public function st_esito togli_colli_in_lavorazione (ref st_tab_artr kst_tab_artr)
public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto)
public function st_esito apri_lavorazione (readonly st_tab_artr kst_tab_artr)
public function st_esito get_num_certif (ref st_tab_artr kst_tab_artr)
public function long get_id_armo_da_num_certif (st_tab_artr kst_tab_artr) throws uo_exception
public function long get_colli_da_id_armo_pl_barcode (st_tab_artr kst_tab_artr) throws uo_exception
public function boolean tb_sistema_lotto (st_tab_artr ast_tab_artr) throws uo_exception
public function long get_colli_trattati_x_id_armo (st_tab_artr kst_tab_artr) throws uo_exception
public function st_esito get_colli_trattati (ref st_tab_artr kst_tab_artr, long k_id_meca)
end prototypes

public subroutine tree_cbarre (ref treeview ktree_artr);//--- 
//--- Costruzione treeview dei rec artr da lavorare
//---

end subroutine

public function st_esito leggi (integer k_tipo, ref st_tab_artr kst_tab_artr);//
//====================================================================
//=== Legge tab ARTR 
//=== 
//--- Input: tipo 1=colli trattati x ID_ARMO
//---             2=data lavorazione di inizio e fine x Num.Attestato
//---             3=data lavorazione di inizio e fine e Colli Trattati x ID_MECA (passato in artr.id_armo)
//---             4=Colli Trattati x ID_MECA  (passato in artr.id_armo)
//=== Ritorna tab. ST_ESITO, Esiti: Come da standard
//====================================================================
//
string k_return = "0 "
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	choose case k_tipo

		case 1

			select sum(colli_trattati)
				 into :kst_tab_artr.colli
				 from artr 
				 where artr.id_armo in
					(select b.id_armo
						 from armo a inner join armo b on
								b.num_int = a.num_int and b.data_int = a.data_int
						  where a.id_armo = :kst_tab_artr.id_armo )
				 using sqlca;
				 
		case 2

			select  distinct min(artr.data_in), 
				      max(artr.data_fin)
				 into  :kst_tab_artr.data_in
				      ,:kst_tab_artr.data_fin
				 from artr 
				 where artr.num_certif = :kst_tab_artr.num_certif
				 using sqlca;

		case 3

			select distinct
			          min(artr.data_in), 
				      max(artr.data_fin)
				 into 
				      :kst_tab_artr.data_in
				      ,:kst_tab_artr.data_fin
				 from artr 
				 where artr.id_armo in
					(select a.id_armo
						 from armo a 
						  where a.id_meca = :kst_tab_artr.id_armo )
				 using sqlca;

		case 4

			select sum(colli_trattati)
				 into :kst_tab_artr.colli
				 from artr 
				 where artr.id_armo in
					(select a.id_armo
						 from armo a
						  where a.id_meca = :kst_tab_artr.id_armo )
				 using sqlca;

			
		case else
			kst_esito.esito = kkg_esito.blok
			kst_esito.sqlcode = 0
			kst_esito.SQLErrText = "Errore interno oggetto Kuf_artr.leggi (tipo=" &
								 + string(k_tipo) + ") "
								 
			
		end choose
		

	choose case k_tipo

		case 1, 2, 3, 4

			if sqlca.sqlcode <> 0 then
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.SQLErrText = "Tab.Lavorazioni ARTR (id=" &
									 + string(kst_tab_artr.id_armo) + "): " + trim(SQLCA.SQLErrText)
									 
				if sqlca.sqlcode = 100 then
					kst_esito.esito = kkg_esito.not_fnd
				else
					if sqlca.sqlcode > 0 then
						kst_esito.esito = kkg_esito.db_wrn
					else	
						kst_esito.esito = kkg_esito.db_ko
					end if
				end if
			end if

	end choose

return kst_esito


end function

public function st_esito cancella_pl_barcode (ref st_tab_artr kst_tab_artr);//
//====================================================================
//=== Delete dei rek ARTR di un determinato PL_BARCODE 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Non trovato 
//===                                     2=Errore Grave
//===                                     3=altro errore
//====================================================================
//
string k_return = "0 "
long k_id_armo, k_colli, k_colli_trattati, k_colli_groupage 
st_esito kst_esito
st_tab_armo kst_tab_armo
st_tab_barcode kst_tab_barcode
kuf_armo kuf1_armo
//kuf_barcode kuf1_barcode



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	k_id_armo = kst_tab_artr.id_armo 

	delete 
	    from artr 
		 where pl_barcode = :kst_tab_artr.pl_barcode
		 using sqlca;
	

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Lavorazioni: " + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = "1"
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = "3"
			else	
				kst_esito.esito = "2"
			end if
		end if
	end if


return kst_esito

end function

public function st_esito crea_attestato_dettaglio (ref st_tab_artr kst_tab_artr);//
//====================================================================
//=== 
//=== Aggiorna, ARTR con il NUM CERTIF
//=== 
//=== Inp:  id_armo e pl_barcode
//=== Out:  num_certif
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
string k_return = "0 ", k_rc
long k_id_armo
st_esito kst_esito, kst1_esito
st_tab_base kst_tab_base
st_tab_armo kst_tab_armo
kuf_base kuf1_base



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	

	k_id_armo = kst_tab_artr.id_armo

//--- becco il ID_MECA dall'ARMO
	select distinct id_meca 
	    into :kst_tab_armo.id_meca
	    from armo
		 where id_armo = :k_id_armo;

//--- estrazione delle righe x l'entrata con num certificato
	declare c_crea_att_dett_1 cursor for
	    select distinct b.num_certif
	        from armo as a inner join artr as b on 
					 a.id_armo = b.id_armo
			 where a.id_meca = :kst_tab_armo.id_meca and 
					 b.num_certif > 0
			 order by b.num_certif desc
			 using kguo_sqlca_db_magazzino;


	kst_tab_artr.num_certif = 0 

	kst_tab_artr.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_artr.x_utente = kGuf_data_base.prendi_x_utente()

//--- becco il num_certif per la riga entrata e pl_barcode
	select distinct artr.num_certif
	     into :kst_tab_artr.num_certif
		  from artr
	   where id_armo = :k_id_armo and pl_barcode = :kst_tab_artr.pl_barcode 
	   using kguo_sqlca_db_magazzino;

//--- Se num certificato non ancora impostato, procedo
	if kst_tab_artr.num_certif = 0 or isnull(kst_tab_artr.num_certif) then
	
		open c_crea_att_dett_1;
		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			fetch c_crea_att_dett_1 into :kst_tab_artr.num_certif;
			if kguo_sqlca_db_magazzino.sqlcode < 0 then
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore durante lettura Numero Certificato da id lotto: " + string(kst_tab_armo.id_meca) + " ~n~r" + trim(kguo_sqlca_db_magazzino.sqlerrtext)
			end if
			close c_crea_att_dett_1;
		else
			if kguo_sqlca_db_magazzino.sqlcode < 0 then 
				kst_esito.esito = kkg_esito.db_ko
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore durante tentativo di lettura Numero Certificato da id lotto (open): " + string(kst_tab_armo.id_meca) + " ~n~r" + trim(kguo_sqlca_db_magazzino.sqlerrtext)
			end if
		end if
		
		if kst_esito.esito = "0" then
			
			if kst_tab_artr.num_certif > 0 then
			else

				kuf1_base = create kuf_base
//--- Acchiappo numero certificato 
				k_rc = kuf1_base.prendi_dato_base("num_certif")
				if LeftA(k_rc, 1) = "0" then
					kst_tab_artr.num_certif = long(trim(MidA(k_rc, 2))) + 1
				end if
				if isnull(kst_tab_artr.num_certif) or  kst_tab_artr.num_certif = 0 then
					kst_esito.esito = kkg_esito.not_fnd
					kst_esito.sqlcode = 0
					kst_esito.SQLErrText = "Errore durante lettura Numero Attestato, controlla Archivio Azienda "
				end if
				
//--- Imposta il nuovo num. certificato			
				kst_tab_base.st_tab_g_0.esegui_commit = kst_tab_artr.st_tab_g_0.esegui_commit 
				kst_tab_base.key = "num_certif"
				kst_tab_base.key1 = string(kst_tab_artr.num_certif)
				kst1_esito  = kuf1_base.metti_dato_base(kst_tab_base)
				if kst1_esito.esito = kkg_esito.db_ko then
					kst_esito.esito = kst1_esito.esito
					kst_esito.sqlcode = kst1_esito.sqlcode
					kst_esito.SQLErrText = "Errore durante scritttura in Archvio Azienda del Numero Certificato: " + string(kst_tab_artr.num_certif) + " ~n~r" + trim(kguo_sqlca_db_magazzino.sqlerrtext)
				end if

				destroy kuf1_base
				
			end if
			
				
			if kst_esito.esito = kkg_esito.ok then
				
				update artr 
						 set num_certif = :kst_tab_artr.num_certif,
				    	    x_datins = :kst_tab_artr.x_datins,
					       x_utente = :kst_tab_artr.x_utente
						 where id_armo = :k_id_armo
						   and pl_barcode = :kst_tab_artr.pl_barcode
						using kguo_sqlca_db_magazzino;
		
				if kguo_sqlca_db_magazzino.sqlcode = 0 then
				else
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = &
					"Errore durante aggiornamento Numero Attestato su archivio Trattamento (artr) ~n~r" 	+  trim(kguo_sqlca_db_magazzino.SQLErrText) 
				end if

				if kst_tab_artr.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_artr.st_tab_g_0.esegui_commit) then
					if kguo_sqlca_db_magazzino.sqlcode = 0 then
						kguo_sqlca_db_magazzino.db_commit()
					else
						kguo_sqlca_db_magazzino.db_rollback()
					end if
				end if
				
			end if

			
		end if
		
	end if	



return kst_esito


end function

public subroutine if_isnull (st_tab_artr kst_tab_artr);//
	
if isnull(kst_tab_artr.data_in) then kst_tab_artr.data_in = date(0)
if isnull(kst_tab_artr.data_fin) then kst_tab_artr.data_fin = date(0)
if isnull(kst_tab_artr.colli) then kst_tab_artr.colli = 0
if isnull(kst_tab_artr.colli_groupage) then kst_tab_artr.colli_groupage = 0
if isnull(kst_tab_artr.colli_trattati) then kst_tab_artr.colli_trattati = 0
if isnull(kst_tab_artr.num_certif) then kst_tab_artr.num_certif = 0


end subroutine

public function st_esito aggiorna_data_stampa_attestato (ref st_tab_artr kst_tab_artr);//
//====================================================================
//=== 
//===  ARTR: Toglie la data di stampa attestato
//=== 
//=== In input:  st_tab_artr
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
string k_return = "0 ", k_rc
long k_id_armo
st_esito kst_esito, kst1_esito
st_tab_base kst_tab_base
st_tab_armo kst_tab_armo
kuf_base kuf1_base


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	kst_tab_artr.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_artr.x_utente = kGuf_data_base.prendi_x_utente()
				

	kst_esito.st_tab_g_0 = kst_tab_artr.st_tab_g_0 
	if kst_esito.st_tab_g_0.esegui_commit <> "S" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
		kst_esito.st_tab_g_0.esegui_commit = "N"
	end if


	if isnull(kst_tab_artr.data_st) then kst_tab_artr.data_st = date(0)
	
	if kst_tab_artr.num_certif > 0 then

		update artr 
			 set data_st = :kst_tab_artr.data_st,
				 x_datins = :kst_tab_artr.x_datins,
				 x_utente = :kst_tab_artr.x_utente
			 where num_certif = :kst_tab_artr.num_certif
			using kguo_sqlca_db_magazzino;

		if kguo_sqlca_db_magazzino.sqlcode = 0 then
			if kst_esito.st_tab_g_0.esegui_commit = "S" then
				kguo_sqlca_db_magazzino.db_commit() 
			end if
		else
			if kst_esito.st_tab_g_0.esegui_commit = "S" then
				kguo_sqlca_db_magazzino.db_rollback() 
			end if
			kst_esito.esito = "1"
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = &
			"Errore in Aggiornamento archivio 'Trattamenti' (kuf_artr:aggiorna_data_stampa_attestato)~n~r" &
								+ "(" + trim(kguo_sqlca_db_magazzino.SQLErrText) + ")"
		end if
		
	else
		kst_esito.esito = "3"
		kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
		kst_esito.SQLErrText = &
		"Aggiornamento archivio 'Trattamenti', num. certificato non conosciuto ~n~r(kuf_artr:aggiorna_data_stampa_attestato)~n~r" &
							+ "(" + trim(kguo_sqlca_db_magazzino.SQLErrText) + ")"
		
	end if
	

return kst_esito


end function

public function st_esito tb_delete ();//
//====================================================================
//=== 
//=== Cancella Lavorazioni con ID ARMO
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
		 from artr
		 WHERE id_armo = :kist_tab_artr.id_armo
		 using sqlca;
		 
   if sqlca.sqlcode <> 0 then
	   if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore in Cancellaz.Lavorazione (kuf_artr.tb_delete)~n~r" + trim(sqlca.SQLErrText) 

		end if
	end if

	if sqlca.sqlcode < 0 then
		if kist_tab_artr.st_tab_g_0.esegui_commit <> "N" or isnull(kist_tab_artr.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_rollback_1( )
		end if
	else
		if kist_tab_artr.st_tab_g_0.esegui_commit <> "N" or isnull(kist_tab_artr.st_tab_g_0.esegui_commit) then
			kGuf_data_base.db_commit_1( )
		end if
	end if


return kst_esito

end function

public function st_esito chiudi_lavorazione (ref st_tab_artr kst_tab_artr);//
//====================================================================
//=== Aggiunge rek ARTR 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Errore Grave
//===                                     2=Errore gestito
//===                                     3=altro errore
//===                                     100=Non trovato 
//=== 
//====================================================================
//
string k_return = "0 "
long k_ctr //k_id_armo, k_colli_trattati, k_colli_in_lav  
st_esito kst_esito
st_tab_armo kst_tab_armo
st_tab_barcode kst_tab_barcode
st_tab_artr kst_tab_artr1
kuf_armo kuf1_armo
kuf_barcode kuf1_barcode


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kst_esito.st_tab_g_0 = kst_tab_artr.st_tab_g_0 


	kst_tab_artr.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_artr.x_utente = kGuf_data_base.prendi_x_utente()

	try 
			
		kuf1_barcode = create kuf_barcode

//--- Piglia la data di fine trattamento più recente x id riga 			
		kst_tab_barcode.id_armo = kst_tab_artr.id_armo
		kst_tab_barcode.pl_barcode = kst_tab_artr.pl_barcode
		kst_tab_artr.data_fin = kuf1_barcode.get_data_lav_fin_x_id_armo(kst_tab_barcode)
			
//--- Piglia il numero colli che hanno finito il trattamento x id riga 			
		kst_tab_barcode.id_armo = kst_tab_artr.id_armo
		kst_tab_barcode.pl_barcode = kst_tab_artr.pl_barcode
		kst_tab_artr.colli_trattati = kuf1_barcode.get_conta_barcode_x_id_armo_fine_lav(kst_tab_barcode)

//--- controllo la presenza del record in ARTR
		select sum(colli) , sum(colli_groupage)
			 into :kst_tab_artr.colli
			 	,:kst_tab_artr.colli_groupage
			 from artr 
			 where id_armo = :kst_tab_artr.id_armo 
				 and pl_barcode = :kst_tab_artr.pl_barcode
			 using kguo_sqlca_db_magazzino;

//--- se manca il record del trattamento oppure  colli trattati sono maggiori dei colli in trattamento chiamo la 'apri trattamento'
		if kguo_sqlca_db_magazzino.sqlcode = 100 or  kst_tab_artr.colli_trattati > kst_tab_artr.colli or isnull (kst_tab_artr.colli) or kst_tab_artr.colli = 0 then

//--- Aggiornamento tabella ARTR 
			kst_tab_artr1.pl_barcode = kst_tab_artr.pl_barcode
			kst_tab_artr1.id_armo = kst_tab_artr.id_armo
			kst_tab_artr1.st_tab_g_0.esegui_commit = kst_tab_artr.st_tab_g_0.esegui_commit 
			kst_esito = apri_lavorazione(kst_tab_artr1)
			
			
//			kuf1_barcode = create kuf_barcode
//			kst_tab_barcode.id_armo = kst_tab_artr.id_armo
//			kst_tab_barcode.pl_barcode = kst_tab_artr.pl_barcode
//			kst_tab_artr1.colli = kuf1_barcode.get_conta_barcode_x_pl_in_lav(kst_tab_barcode)
//			if isnull(kst_tab_artr1.colli) then
//				kst_tab_artr1.colli = 1
//			end if
//					
//			k_colli_in_lav = kst_tab_artr1.colli
//			k_colli_trattati = 0
//		
////--- Aggiornamento tabella ARTR 
//			setnull(kst_tab_artr1.data_fin) 
//			kst_tab_artr1.pl_barcode = kst_tab_artr.pl_barcode
//			kst_tab_artr1.data_in = kst_tab_artr.data_fin
//			kst_tab_artr1.colli_groupage = 0 
//			kst_tab_artr1.id_armo = kst_tab_artr.id_armo
//			kst_tab_artr1.st_tab_g_0.esegui_commit = kst_tab_artr.st_tab_g_0.esegui_commit 
//			kst_esito = apri_lavorazione(kst_tab_artr1)

			if kst_esito.esito = kkg_esito.db_ko then
				kst_esito.esito = kkg_esito.db_wrn
				kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
				kst_esito.SQLErrText = "Errore durante aggiornamento tabella Trattamenti: lotto id=" + string(kst_tab_artr.id_armo) + "!! " 
			else

//--- rifaccio la query x controllo la presenza del record in ARTR
				select sum(colli) , sum(colli_groupage)
					 into :kst_tab_artr.colli
						,:kst_tab_artr.colli_groupage
					 from artr 
					 where id_armo = :kst_tab_artr.id_armo 
						 and pl_barcode = :kst_tab_artr.pl_barcode
					 using kguo_sqlca_db_magazzino;

			end if
		
		end if

//--- Imposto il numero colli che hanno concluso il Trattamento
		if kst_esito.esito <> kkg_esito.db_ko then

//--- se PL chiuso allora imposto la data di chiusura altrimenti aggiorno solo il numero dei colli
			if  kst_tab_artr.colli_trattati >= kst_tab_artr.colli then

//--- aggiornamento	
				update artr 
						 set data_fin = :kst_tab_artr.data_fin,
							  colli_trattati = :kst_tab_artr.colli_trattati, 
							  x_datins = :kst_tab_artr.x_datins,
							  x_utente = :kst_tab_artr.x_utente
						 where id_armo = :kst_tab_artr.id_armo
						 and pl_barcode = :kst_tab_artr.pl_barcode
						using kguo_sqlca_db_magazzino;
			else
//--- aggiornamento	
				update artr 
						 set 
							  colli_trattati = :kst_tab_artr.colli_trattati, 
							  x_datins = :kst_tab_artr.x_datins,
							  x_utente = :kst_tab_artr.x_utente
						 where id_armo = :kst_tab_artr.id_armo
						 and pl_barcode = :kst_tab_artr.pl_barcode
						using kguo_sqlca_db_magazzino;
	
			end if

			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_commit( )
				end if
			else
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = "Tab. Lavorazioni: Errore in Aggiornamento Fine Lavorazione (id=" + string(kst_tab_artr.id_armo) + ").~n~r" &
										+ "(" + trim(kguo_sqlca_db_magazzino.SQLErrText) + ")"
					if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
						kguo_sqlca_db_magazzino.db_rollback( )
					end if
				end if
			end if
		end if
	
				
	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()
		
	finally
		if isvalid(kuf1_barcode) then destroy kuf1_barcode
	end try 


return kst_esito

end function

public function st_esito anteprima (datawindow kdw_anteprima, st_tab_artr kst_tab_artr);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut: 
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: come standard
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
kst_open_w.id_programma = kkg_id_programma_attestati

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito.no_aut

else

	if kst_tab_artr.num_certif > 0 then

		kdw_anteprima.dataobject = "d_artr"		
		kdw_anteprima.settransobject(sqlca)

		kuf1_utility = create kuf_utility
		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_artr.num_certif )

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Attestato da visualizzare: ~n~r" + "nessun numero attestato indicato"
		kst_esito.esito = kkg_esito.blok
		
	end if
end if


return kst_esito

end function

public function st_esito togli_colli_in_lavorazione (ref st_tab_artr kst_tab_artr);//
//====================================================================
//=== Toglie COLLI da ARTR 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Non trovato 
//===                                     2=Errore Grave
//===                                     3=altro errore
//====================================================================
//
string k_return = "0 "
st_esito kst_esito
st_tab_artr kst_tab_artr_orig


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kst_tab_artr.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_artr.x_utente = kGuf_data_base.prendi_x_utente()

	if isnull(kst_tab_artr.colli_groupage) then
		kst_tab_artr.colli_groupage = 0
	end if

	select colli, colli_groupage
	    into :kst_tab_artr_orig.colli
		 , :kst_tab_artr_orig.colli_groupage
	    from artr 
		 where id_armo = :kst_tab_artr.id_armo 
		       and pl_barcode = :kst_tab_artr.pl_barcode
		 using sqlca;
	
	if sqlca.sqlcode = 0 then
		
		if isnull(kst_tab_artr_orig.colli_groupage) then
			kst_tab_artr_orig.colli_groupage = 0
		end if
		
		kst_tab_artr_orig.colli = kst_tab_artr_orig.colli - kst_tab_artr.colli
		kst_tab_artr_orig.colli_groupage = kst_tab_artr_orig.colli_groupage - kst_tab_artr.colli_groupage

		if kst_tab_artr_orig.colli > 0 then
			update artr set
				  colli = :kst_tab_artr_orig.colli
				  ,colli_groupage = :kst_tab_artr_orig.colli_groupage
 				 ,x_datins = :kst_tab_artr.x_datins
				 ,x_utente = :kst_tab_artr.x_utente
				 where id_armo = :kst_tab_artr.id_armo 
		   	     	 and pl_barcode = :kst_tab_artr.pl_barcode
				 using sqlca;
		else
			delete from artr
			 where id_armo = :kst_tab_artr.id_armo 
			          and pl_barcode = :kst_tab_artr.pl_barcode
					 using sqlca;
		end if

	else
		
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Lavorazioni: " + trim(SQLCA.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito.not_fnd
		else
			if sqlca.sqlcode > 0 then
				kst_esito.esito = kkg_esito.db_wrn
			else	
				kst_esito.esito = kkg_esito.db_ko
			end if
		end if
	end if


return kst_esito

end function

public function integer u_tree_riempi_listview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);//
//--- Visualizza Listview
integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_corrente, k_handle_item_rit
integer k_ctr, k_pictureindex
string k_label, k_oggetto_corrente, k_oggetto_padre
int k_ind
string k_campo[15]
alignment k_align[15]
alignment k_align_1
treeviewitem ktvi_treeviewitem
listviewitem klvi_listviewitem
st_esito kst_esito
st_treeview_data kst_treeview_data
st_tab_treeview kst_tab_treeview
st_treeview_data_any kst_treeview_data_any
st_profilestring_ini kst_profilestring_ini
kuf_armo kuf1_armo
kuf_meca_dosim kuf1_meca_dosim

	
//--- ricavo il tipo oggetto e richiamo la windows di dettaglio 
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_corrente = kst_treeview_data.handle
	
	if k_handle_item_corrente = 0 or isnull(k_handle_item_corrente) then
//--- item di ritorno di default
		k_handle_item_corrente = kuf1_treeview.kitv_tv1.finditem(CurrentTreeItem!, 0)
	end if
		
//--- prendo il item padre per settare il ritorno di default
	k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_corrente)
	if k_handle_item_padre > 0 then
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem) 
	else
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem) 
	end if
	kst_treeview_data = ktvi_treeviewitem.data  
	k_oggetto_padre = trim(kst_treeview_data.oggetto)

//--- cancello dalla listview tutto
	kuf1_treeview.kilv_lv1.DeleteItems()
		 
	klvi_listviewitem.data = kst_treeview_data
	klvi_listviewitem.label = ".."
	klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
	k_handle_item_rit = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
		
	if k_handle_item_corrente > 0 then

		kuf1_treeview.kitv_tv1.getitem(k_handle_item_corrente, ktvi_treeviewitem)

//--- leggo il primo item dalla treeview per esporlo nella list
		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_corrente)
		k_rc = kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem) 
		kst_treeview_data = ktvi_treeviewitem.data  

		kuf1_treeview.kilv_lv1.DeleteColumns ( )
		
//--- 

//=== Costruisce e Dimensiona le colonne all'interno della listview
		k_ind=1
		choose case k_tipo_oggetto
			case kuf1_treeview.kist_treeview_oggetto.certif_da_st_dett
				k_campo[k_ind] = "Attestato da stampare"
			case kuf1_treeview.kist_treeview_oggetto.certif_da_st_farma_dett 
				k_campo[k_ind] = "Attestato farmaceutico"
			case kuf1_treeview.kist_treeview_oggetto.certif_da_st_alimen_dett 
				k_campo[k_ind] = "Attestato alimentare"
			case kuf1_treeview.kist_treeview_oggetto.certif_da_st_sd_dett 
				k_campo[k_ind] = "Attestato da SD"
			case kuf1_treeview.kist_treeview_oggetto.certif_in_lav_dett
				k_campo[k_ind] = "Attestato in lav."
			case kuf1_treeview.kist_treeview_oggetto.certif_da_conv_dett
				k_campo[k_ind] = "Attestato da Conv."
			case kuf1_treeview.kist_treeview_oggetto.certif_err_dett
				k_campo[k_ind] = "Attestato -"
		end choose
		
		kuf1_treeview.kilv_lv1.getColumn(1, k_label, k_align_1, k_ctr) 
		if k_label <> k_campo[k_ind] then
			kuf1_treeview.kilv_lv1.DeleteColumns ( )
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Riferimento"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "WO / SO"
			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "dosimetro"
//			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "bolla mandante"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Colli entrati/trattati (di cui in groupage)"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "lav.inizio-fine"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "CO"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Ricevente"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Cliente"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Lavorazione"
			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "Dosimetria"
			k_align[k_ind] = left!
//			k_ind++
//			k_campo[k_ind] = "Ulteriori Informazioni"
//			k_align[k_ind] = left!
			k_ind++
			k_campo[k_ind] = "FINE"
			k_align[k_ind] = left!
			
			k_ind=1
			do while trim(k_campo[k_ind]) <> "FINE"

				kst_profilestring_ini.operazione = kGuf_data_base.ki_profilestring_operazione_leggi 
				kst_profilestring_ini.file = "treeview"
				kst_profilestring_ini.titolo = "treeview"
				kst_profilestring_ini.nome = "tv_larg_campo_" + trim(k_tipo_oggetto) + "_" + k_campo[k_ind]
				kst_profilestring_ini.valore = "0"
				k_rc = integer(kGuf_data_base.profilestring_ini(kst_profilestring_ini))
 
				if kst_profilestring_ini.esito = "0" then
					k_ctr = integer(kst_profilestring_ini.valore)
				end if
				if k_ctr = 0 then
					k_ctr = (kuf1_treeview.kilv_lv1.width) / 4 //50 * len(trim(k_campo[k_ind])) 
				end if
				kuf1_treeview.kilv_lv1.addColumn(trim(k_campo[k_ind]), k_align[k_ind], k_ctr)
				k_ind++
			loop

		end if
//---

		do while k_handle_item > 0
				
			kuf1_treeview.kitv_tv1.getitem(k_handle_item, ktvi_treeviewitem)
	
			kst_treeview_data = ktvi_treeviewitem.data
			kst_treeview_data_any = kst_treeview_data.struttura
			kst_tab_treeview = kst_treeview_data_any.st_tab_treeview

//--- imposto il pic corretto
			klvi_listviewitem.pictureindex = kst_treeview_data.pic_list
	
			klvi_listviewitem.label = kst_treeview_data.label
			klvi_listviewitem.data = kst_treeview_data

			klvi_listviewitem.selected = false

			k_ctr = kuf1_treeview.kilv_lv1.additem(klvi_listviewitem)
			k_ind = 0
			
			kst_tab_treeview.voce =  &
									  string(kst_treeview_data_any.st_tab_artr.num_certif, "##,##0") + " " 
			if kst_treeview_data_any.st_tab_artr.data_st > date(0) then
				kst_tab_treeview.voce =  trim(kst_treeview_data_any.st_tab_treeview.voce) + "  " &
									  + string(kst_treeview_data_any.st_tab_artr.data_st, "dd.mm.yy") + "  "
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  &
										  string(kst_treeview_data_any.st_tab_meca.num_int, "####0") &
										  + "  " + string(kst_treeview_data_any.st_tab_meca.data_int, "dd.mm.yy") 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_meca.e1doco > 0 then
				kst_tab_treeview.voce = string(kst_treeview_data_any.st_tab_meca.e1doco, "#") + " / "
			else
				kst_tab_treeview.voce = "- / "
			end if
			if kst_treeview_data_any.st_tab_meca.e1rorn > 0 then
				kst_tab_treeview.voce += string(kst_treeview_data_any.st_tab_meca.e1rorn, "#") 
			else
				kst_tab_treeview.voce += "-"
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, kst_tab_treeview.voce)

//			kst_tab_treeview.voce = trim(kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.barcode_dosimetro) + "  (" &
//											+ trim(kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.barcode_dosimetro) + ") "
//			k_ind++
//			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  &
										  string(kst_treeview_data_any.st_tab_meca.data_bolla_in, "dd.mmm") &
										  + " - " + trim(kst_treeview_data_any.st_tab_meca.num_bolla_in) 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  &
										  string(kst_treeview_data_any.st_tab_armo.colli_2, "####0") &
										  + " / " + string(kst_treeview_data_any.st_tab_artr.colli_trattati, "####0") &
										  + " (" + string(kst_treeview_data_any.st_tab_artr.colli_groupage, "####0") + ")" 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			if kst_treeview_data_any.st_tab_artr.data_in > date(0) then							  	
				kst_tab_treeview.voce =  &
										  + string(kst_treeview_data_any.st_tab_artr.data_in, "dd/mmm") 
			end if
			if kst_treeview_data_any.st_tab_artr.data_fin > date(0) then							  	
				kst_tab_treeview.voce += " - " &
										  + string(kst_treeview_data_any.st_tab_artr.data_fin, "dd/mmm")  
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =  trim(kst_treeview_data_any.st_tab_contratti.mc_co ) 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )
			
			kst_tab_treeview.voce =  &
											  + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_11) &
											  + "  (" + string(kst_treeview_data_any.st_tab_meca.clie_2, "####0") &
											  + ")  " 
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

			kst_tab_treeview.voce =   trim(kst_treeview_data_any.st_tab_clienti.rag_soc_20) &
											  + "  (" + string(kst_treeview_data_any.st_tab_meca.clie_3, "####0") &
											  + ") " 
//											  + " / " + string(kst_treeview_data_any.st_tab_meca.clie_1, "####0") &
//											  + " " + trim(kst_treeview_data_any.st_tab_clienti.rag_soc_10) &
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )


			kst_tab_treeview.voce = ""
			if kst_treeview_data_any.st_tab_meca.data_lav_fin > date(0) then
				if kst_treeview_data_any.st_tab_meca.err_lav_fin = kuf1_armo.ki_err_lav_fin_ko then
					if kst_treeview_data_any.st_tab_meca.cert_forza_stampa = "1" then
						kst_tab_treeview.voce = "stampa forzata! " 
					else
						kst_tab_treeview.voce = "con Anomalia! " 
					end if
				else
					kst_tab_treeview.voce = "corretta "
				end if
			else
				kst_tab_treeview.voce = "da Trattare " 
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )


			kst_tab_treeview.voce = ""
			if kst_treeview_data_any.st_tab_meca.st_tab_meca_dosim.dosim_data > date(0) then 
				if kst_treeview_data_any.st_tab_meca.err_lav_ok = kuf1_meca_dosim.ki_err_lav_ok_conv_ko_sbloc then
					if kst_treeview_data_any.st_tab_meca.cert_forza_stampa = "1" then
						kst_tab_treeview.voce = "stampa forzata! " 
					else
						kst_tab_treeview.voce = "con Anomalia! " 
					end if
				else
					if kst_treeview_data_any.st_tab_meca.err_lav_ok = kuf1_meca_dosim.ki_err_lav_ok_conv_ko_bloc then
						if kst_treeview_data_any.st_tab_meca.cert_forza_stampa = "1" then
							kst_tab_treeview.voce = "stampa forzata! "
						else
							kst_tab_treeview.voce = "da Sbloccare (anomalie)!  "
						end if
					else
						if kst_treeview_data_any.st_tab_meca.err_lav_ok = kuf1_meca_dosim.ki_err_lav_ok_conv_da_aut then
							kst_tab_treeview.voce = kst_tab_treeview.voce + "fare Seconda Lettura "
						else
							if kst_treeview_data_any.st_tab_meca.err_lav_ok = kuf1_meca_dosim.ki_err_lav_ok_conv_ko_da_aut then
								kst_tab_treeview.voce = kst_tab_treeview.voce + "Prima Lettura con Anomalie"
							else
								if kst_treeview_data_any.st_tab_meca.err_lav_ok = kuf1_meca_dosim.ki_err_lav_ok_conv_aut_ok then
									kst_tab_treeview.voce = kst_tab_treeview.voce + "corretta "
								else
									kst_tab_treeview.voce = kst_tab_treeview.voce + "da Convalidare "
								end if
							end if
						end if
					end if
				end if
			else
				kst_tab_treeview.voce = "da Convalidare  " 
			end if
			k_ind++
			kuf1_treeview.kilv_lv1.setitem(k_ctr, k_ind, trim(kst_tab_treeview.voce) )

				
			k_handle_item = kuf1_treeview.kitv_tv1.finditem(NextTreeItem!, k_handle_item)
			
		loop
		
	end if

	if k_handle_item_rit > 0 then
//		k_handle_item = kuf1_treeview.kitv_tv1.finditem(ParentTreeItem!, k_handle_item_rit)
//		if k_handle_item <= 0 then
//			k_handle_item = 1
//		end if
		kst_treeview_data.handle_padre = k_handle_item_corrente
		kst_treeview_data.handle = k_handle_item_padre
		kst_treeview_data.oggetto = k_oggetto_padre
		kst_treeview_data.oggetto_listview = k_tipo_oggetto
		ktvi_treeviewitem.data = kst_treeview_data
		klvi_listviewitem.label = ".."
		klvi_listviewitem.data = kst_treeview_data
		klvi_listviewitem.pictureindex = kuf1_treeview.kist_treeview_oggetto.pic_ritorna_item_padre
		kuf1_treeview.kilv_lv1.setitem(k_handle_item_rit, klvi_listviewitem)
	end if

return k_return

end function

public function integer u_tree_riempi_treeview (ref kuf_treeview kuf1_treeview, readonly string k_tipo_oggetto);
//--- Visualizza Treeview

integer k_return = 0, k_rc
long k_handle_item = 0, k_handle_item_padre = 0, k_handle_item_figlio = 0
integer k_ctr, k_pic_list, k_mese, k_anno
string k_tipo_oggetto_padre, k_tipo_oggetto_figlio
string k_query_select, k_query_where, k_query_order
date k_save_data_int, k_data_da, k_data_a, k_data_0, k_dataoggi_meno1anno, k_dataoggi
boolean k_da_elaborare=false, k_flag_da_lavorare=false, k_flag_lotto_lav_completata=false, k_flag_record_da_esporre=false, k_lotto_convalidato=false
treeviewitem ktvi_treeviewitem
st_esito kst_esito//, kst_esito_appo
st_treeview_data kst_treeview_data
st_treeview_data_any kst_treeview_data_any
st_tab_treeview kst_tab_treeview
st_tab_artr kst_tab_artr, kst_tab_artr_old 
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_armo kst_tab_armo, kst_tab_armo_old
st_tab_contratti kst_tab_contratti
st_tab_certif kst_tab_certif
st_tab_barcode kst_tab_barcode
kuf_artr kuf1_artr
kuf_sl_pt kuf1_sl_pt
kuf_armo kuf1_armo
kuf_meca_dosim kuf1_meca_dosim


try 
	
	k_data_0 = date(0)		 

//--- Ricavo l'oggetto figlio dal DB 
	kst_tab_treeview.id = k_tipo_oggetto
	kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
	k_tipo_oggetto_figlio = kst_tab_treeview.funzione
	
//--- Acchiappo handle dell'item
	kst_treeview_data = kuf1_treeview.u_get_st_treeview_data ()
	k_handle_item_padre = kst_treeview_data.handle

	if k_handle_item_padre > 0 then
		kuf1_treeview.kitv_tv1.getitem(k_handle_item_padre, ktvi_treeviewitem)
		kst_treeview_data = ktvi_treeviewitem.data
		k_tipo_oggetto_padre = kst_treeview_data.oggetto
	else
		k_handle_item_padre = kuf1_treeview.kitv_tv1.finditem(RootTreeItem!, 0)
		k_tipo_oggetto_padre = k_tipo_oggetto_figlio
	end if

	k_data_0 = date(0)
	k_data_a = date(0)
	k_data_da = date(0)
	
//--- Periodo di estrazione, se la data e' a zero allora calcolo in automatico -3 mesi
	kst_treeview_data_any = kst_treeview_data.struttura
	if (kst_treeview_data_any.st_tab_artr.data_in = date (0) &
	    or isnull(kst_treeview_data_any.st_tab_artr.data_in)) &
		 then

//--- Ricavo la data da dataoggi e vado indietro per sicurezza di alcuni mesi
		k_dataoggi = kguo_g.get_dataoggi()
		k_data_a = relativedate(k_dataoggi, 1)
		k_data_da = date(year(relativedate(k_data_a,-480)), month(relativedate(k_data_a,-480)),01)
		k_dataoggi_meno1anno = relativedate(k_dataoggi,-480)

	else
//--- Se data passata prendo periodo di 1 mese
		k_mese = month(kst_treeview_data_any.st_tab_artr.data_in) 
		k_anno = year(kst_treeview_data_any.st_tab_artr.data_in)
		k_data_da = date (k_anno, k_mese, 01) 
		if k_mese = 12 then
			k_mese = 1
			k_anno ++
		else
			k_mese = k_mese + 1
		end if
		k_data_a = date (k_anno, k_mese, 01) 
	
	end if
		 
	k_handle_item_figlio = kuf1_treeview.kitv_tv1.finditem(ChildTreeItem!, k_handle_item_padre)

//--- Procedo alla lettura della tab solo se non ho figli 
	if k_handle_item_figlio <= 0 or kuf1_treeview.ki_forza_refresh = kuf1_treeview.ki_forza_refresh_si then

//--- crea oggetti
		kuf1_sl_pt = create kuf_sl_pt
		kuf1_armo = create kuf_armo
		kuf1_artr = create kuf_artr
		kuf1_meca_dosim = create kuf_meca_dosim 
		
//--- Imposta le propietà di default della tree 
		kuf1_treeview.u_imposta_propieta( ktvi_treeviewitem, k_tipo_oggetto, kuf1_treeview.kist_treeview_oggetto)

//--- Preleva dall'archivio dati di conf della tree 
		kst_tab_treeview.id = trim(k_tipo_oggetto)
		kst_esito = kuf1_treeview.u_select_tab_treeview(kst_tab_treeview)
		if kst_esito.esito = "0" then
			ktvi_treeviewitem.pictureindex = kst_tab_treeview.pic_close
			ktvi_treeviewitem.selectedpictureindex = kst_tab_treeview.pic_open 
			k_pic_list = kst_tab_treeview.pic_list 
		end if


//--- Cancello gli Item dalla tree prima di ripopolare
		kuf1_treeview.u_delete_item_child(k_handle_item_padre)

//		+ "  meca_dosim.dosim_data,   " & 
//		+ "  meca_dosim.dosim_dose,   " & 
//		+ "  meca_dosim.dosim_assorb,   " &
//		+ "  meca_dosim.dosim_spessore,   " &
//		+ "  meca_dosim.dosim_rapp_a_s,   " &
//		+ "  meca_dosim.dosim_lotto_dosim,   " &
//		+ "  meca_dosim.barcode,   " &
//		+ "  meca_dosim.barcode_dosimetro,   " &
//		+   "  LEFT OUTER JOIN meca_dosim ON  " &
//		+   "  meca.id = meca_dosim.id_meca) " &
	
		k_query_select = &
		"  	SELECT " &
		+ " artr.num_certif, " &
		+ "  meca.id, " &
		+ "  meca.num_int, " &
		+ "  meca.data_int, " &
		+ "  meca.area_mag, " &
		+ "  meca.clie_1,  " &
		+ "  meca.clie_2,  " &
		+ "  meca.clie_3,  " &
		+ "  meca.num_bolla_in, " &
		+ "  meca.data_bolla_in, " &
		+ "  meca.data_lav_fin,   " & 
    		+ "  meca.err_lav_fin, " &    
		+ "  meca.err_lav_ok,   " & 
		+ "  meca.note_lav_ok,  " & 
		+ "  meca.cert_forza_stampa,   " &
		+ "  meca.contratto, " &
		+ "  (c1.rag_soc_10) as c1_rag_soc_10, " &
		+ "  (c2.rag_soc_10) as c2_rag_soc_10, " &
		+ "  (c3.rag_soc_10) as c3_rag_soc_10, " &
		+ "  contratti.mc_co " &
		+ " ,isnull(meca.e1doco,0) as e1doco" &
		+ " ,isnull(meca.e1rorn,0) as e1rorn " &
		+ " FROM  " &
		+ "	   artr INNER JOIN armo ON  " &
		+ "		  artr.id_armo = armo.id_armo " &
		+ "           inner JOIN meca ON  " &
		+    "	  armo.id_meca = meca.id " &
		+ 	"   inner JOIN  clienti c1 on meca.clie_1 = c1.codice " &
		+	 "   inner JOIN clienti c2 on meca.clie_2 = c2.codice " &
		+ 	"   inner JOIN clienti c3 on meca.clie_3 = c3.codice " &
		+ 	"    LEFT OUTER JOIN contratti ON  " &
		+    "  meca.contratto = contratti.codice  " &
		
		choose case k_tipo_oggetto

//--- solo materiale farmaceutico				
//--- solo materiale alimentare				
//--- dettaglio
			case kuf1_treeview.kist_treeview_oggetto.certif_da_st_dett &
				  ,kuf1_treeview.kist_treeview_oggetto.certif_da_st_sd_dett &
				  ,kuf1_treeview.kist_treeview_oggetto.certif_da_st_farma_dett &
				  ,kuf1_treeview.kist_treeview_oggetto.certif_da_st_alimen_dett 
				k_query_select = &
						+ k_query_select &
						+ "  inner JOIN sl_pt ON  " &
						+ " armo.cod_sl_pt = sl_pt.cod_sl_pt " &

				k_query_where = " where " 
				if k_data_da  <> k_data_0 then
					k_query_where = k_query_where &
					+ " artr.data_in > '"+ string(k_dataoggi_meno1anno)+"' " &
					+ " and artr.data_in >= ? and artr.data_in < ?   "
				end if
//					+ " and meca_dosim.dosim_data > '" + string(KKG.DATA_NO) + "' " &
				k_query_where += &
					+ " and (artr.data_st <= '" + string(KKG.DATA_NO) + "' or artr.data_st is null) " &
					+ " and artr.data_fin > '" + string(KKG.DATA_NO) + "' " &
					+ " and (meca.err_lav_ok = '"+ kuf1_meca_dosim.ki_err_lav_ok_conv_ko_sbloc &
					+ "' or meca.err_lav_ok = '"+kuf1_meca_dosim.ki_err_lav_ok_conv_aut_ok &
					+ "' or meca.cert_forza_stampa = '1') " &
					+ " and (meca.err_lav_fin <> '"+ kuf1_armo.ki_err_lav_fin_ko +"' or meca.err_lav_fin is null or meca.cert_forza_stampa = '1') " &
					+ " and artr.num_certif > 0 " &
					+ " and armo.dose > 0 " &
					+ " and armo.cod_sl_pt <> ' ' " 

 // solo materiale farmaceutico					
			   if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.certif_da_st_farma_dett then
					k_query_where = k_query_where &
						+ " and sl_pt.tipo = '" + kuf1_sl_pt.ki_tipo_prodotto_farmaceutico + "' " &
						+ " and (meca.cert_farma_st_ok is null or meca.cert_farma_st_ok = '')  " 
				else
 // solo materiale alimentare
					if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.certif_da_st_alimen_dett then
						k_query_where = k_query_where &
						+ " and sl_pt.tipo = '" + kuf1_sl_pt.ki_tipo_prodotto_alimentare + "' " &
						+ " and (meca.cert_aliment_st_ok is null or meca.cert_aliment_st_ok = '')  " 
					else
 // se diverso da mat. come sopra oppure ho dato l'ok al mat. di cui sopra
						k_query_where = k_query_where &
							+ " and ((sl_pt.tipo is null or sl_pt.tipo = '" + kuf1_sl_pt.ki_tipo_altro + "' " &
							+ "  or sl_pt.tipo is null or sl_pt.tipo = '" + kuf1_sl_pt.ki_tipo_dispositivo_medico + "' ) " &
							+ " or ((sl_pt.tipo = '" + kuf1_sl_pt.ki_tipo_prodotto_farmaceutico + "' and meca.cert_farma_st_ok = '1') " &
							+ "  or (sl_pt.tipo = '" + kuf1_sl_pt.ki_tipo_prodotto_alimentare + "' and meca.cert_aliment_st_ok = '1') " &
							+ "   )) " 
// se sono solo x Contratti SD							
					 	if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.certif_da_st_sd_dett then
							k_query_where = k_query_where &
								+ " and contratti.mc_co like 'SD%' "
						end if
							
					end if
				end if
									
			case kuf1_treeview.kist_treeview_oggetto.certif_in_lav_dett
				k_query_where = " where " 
				if k_data_da  <> k_data_0 then
					k_query_where = k_query_where &
					+ " artr.data_in > '"+ string(k_dataoggi_meno1anno)+"' " &
					+ " and (artr.data_in >= ? and artr.data_in < ?) and "
				end if
				k_query_where = k_query_where &
					+ " (artr.data_st <= '" + string(KKG.DATA_NO) + "' or artr.data_st is null) " &
					+ " and (meca.data_lav_fin is null or meca.data_lav_fin <= '" + string(KKG.DATA_NO) + "')" &
					+ " and artr.num_certif > 0 " &
					+ " and armo.dose > 0 " &
					+ " and armo.cod_sl_pt <> ' ' " 

			case kuf1_treeview.kist_treeview_oggetto.certif_da_conv_dett
				k_query_where = " where " 
				if k_data_da  <> k_data_0 then
					k_query_where = k_query_where &
					+ " artr.data_in > '"+ string(k_dataoggi_meno1anno)+"' " &
					+ " and (artr.data_in >= ? and artr.data_in < ?) and "
				end if
				k_query_where = k_query_where &
					+ " (artr.data_st <= '" + string(KKG.DATA_NO) + "' or artr.data_st is null) " &
					+ " and artr.data_fin > '" + string(KKG.DATA_NO) + "' " &
					+ " and (meca.err_lav_ok is null or meca.err_lav_ok = '"+ kuf1_meca_dosim.ki_err_lav_ok_da_conv &
					+ "' or meca.err_lav_ok = '"+kuf1_meca_dosim.ki_err_lav_ok_conv_ko_da_aut &
					+ "' or meca.err_lav_ok = '"+kuf1_meca_dosim.ki_err_lav_ok_conv_da_aut &
					+ "' or meca.err_lav_ok = '"+kuf1_meca_dosim.ki_err_lav_ok_conv_ko_da_aut &
					+ "'  ) " &
					+ " and artr.num_certif > 0 " &
					+ " and armo.dose > 0 " &
					+ " and armo.cod_sl_pt <> ' ' " 
					
			case kuf1_treeview.kist_treeview_oggetto.certif_err_dett
				k_query_where = " where " 
				if k_data_da  <> k_data_0 then
					k_query_where = k_query_where &
					+ " artr.data_in > '01.01.2004' " &
					+ " and (artr.data_in >= ? and artr.data_in < ?) and "
				end if
//					+ " and meca_dosim.dosim_data > '" + string(KKG.DATA_NO) + "'  " &
				k_query_where = k_query_where &
					+ " (artr.data_st <= '" + string(KKG.DATA_NO) + "' or artr.data_st is null) " &
					+ " and artr.data_fin > '" + string(KKG.DATA_NO) + "'  " &
					+ " and (meca.err_lav_ok = '"+kuf1_meca_dosim.ki_err_lav_ok_conv_ko_sbloc +"' " &
					+ "  or meca.err_lav_ok = '"+kuf1_meca_dosim.ki_err_lav_ok_conv_ko_bloc +"' " &
					+ "  or meca.err_lav_fin = '"+kuf1_armo.ki_err_lav_fin_ko+"') " &
					+ " and (meca.cert_forza_stampa <> '1' or meca.cert_forza_stampa is null) " &
					+ " and artr.num_certif > 0 " &
					+ " and armo.dose > 0 " &
					+ " and armo.cod_sl_pt <> ' ' " 
					
			case else
					k_query_where = " "
	
		end choose
		
		k_query_order = &
		+ "	 group by " &
		+ "	      artr.num_certif, " &
		+ "	      meca.id, " &
		+ "			meca.num_int, " &
		+ "			meca.data_int, " &
		+ "			meca.area_mag, " &
		+ "         meca.clie_1,  " &
		+ "         meca.clie_2,  " &
		+ "         meca.clie_3,  " &
		+ "			meca.num_bolla_in, " &
		+ "			meca.data_bolla_in, " &
		+ "         meca.data_lav_fin,   " & 
      	+ "   		meca.err_lav_fin, " &    
		+ "         meca.err_lav_ok,   " & 
		+ "         meca.note_lav_ok,  " & 
		+ "         meca.cert_forza_stampa,   " &
		+ "			meca.contratto, " &
		+ "         c1.rag_soc_10, " &
		+ "         c2.rag_soc_10, " &
		+ "         c3.rag_soc_10, " &
		+ "         mc_co " &
		+ "    ,meca.e1doco" &
		+ "    ,meca.e1rorn " & 
		+ "	 order by " &
		+ "		 artr.num_certif desc"

	
//--- Composizione della Query	
		if LenA(trim(k_query_where)) > 0 then
			declare kc_treeview dynamic cursor for SQLSA ;
			k_query_select = k_query_select + k_query_where + k_query_order
			prepare SQLSA from :k_query_select using sqlca;
		end if		
		
		choose case k_tipo_oggetto

//--- solo materiale farmaceutico				
//--- solo materiale alimentare	
			case kuf1_treeview.kist_treeview_oggetto.certif_da_st_dett &
				  ,kuf1_treeview.kist_treeview_oggetto.certif_da_st_farma_dett &
				  ,kuf1_treeview.kist_treeview_oggetto.certif_da_st_alimen_dett &
				  ,kuf1_treeview.kist_treeview_oggetto.certif_da_st_sd_dett 
				if k_data_a  <> k_data_0 then
					open dynamic kc_treeview using :k_data_da, :k_data_a;
				else
					open dynamic kc_treeview ;
				end if
					
			case kuf1_treeview.kist_treeview_oggetto.certif_in_lav_dett &
			    ,kuf1_treeview.kist_treeview_oggetto.certif_da_conv_dett
				if k_data_a  <> k_data_0 then
					open dynamic kc_treeview using :k_data_da, :k_data_a;
				else
					open dynamic kc_treeview ;
				end if
					

			case kuf1_treeview.kist_treeview_oggetto.certif_err_dett
				if k_data_a  <> k_data_0 then
//					open dynamic kc_treeview using :k_data_da, :k_data_a, :k_data_0, :k_data_a, :k_data_0;
					open dynamic kc_treeview using :k_data_da, :k_data_a;
				else
					open dynamic kc_treeview ;
				end if
					
			case else
				sqlca.sqlcode = 100
	
		end choose
		
		if sqlca.sqlcode <> 0 then
			sqlca.sqlerrtext = trim(sqlca.sqlerrtext) + k_query_select
			kuf1_treeview.u_sql_scrivi_log(sqlca)
		else

		
//         			,:kst_tab_meca.st_tab_meca_dosim.dosim_data   
//					,:kst_tab_meca.st_tab_meca_dosim.dosim_dose
//         			,:kst_tab_meca.st_tab_meca_dosim.dosim_assorb  
//         			,:kst_tab_meca.st_tab_meca_dosim.dosim_spessore  
//         			,:kst_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s  
//         			,:kst_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim  
//         			,:kst_tab_meca.st_tab_meca_dosim.barcode
//					,:kst_tab_meca.st_tab_meca_dosim.barcode_dosimetro  
			
			fetch kc_treeview 
				into
					 :kst_tab_artr.num_certif
					,:kst_tab_meca.id   
					,:kst_tab_meca.num_int   
					,:kst_tab_meca.data_int   
					,:kst_tab_meca.area_mag   
					,:kst_tab_meca.clie_1  
					,:kst_tab_meca.clie_2  
					,:kst_tab_meca.clie_3  
					,:kst_tab_meca.num_bolla_in 
					,:kst_tab_meca.data_bolla_in 
					,:kst_tab_meca.data_lav_fin 
         			,:kst_tab_meca.err_lav_fin   
         			,:kst_tab_meca.err_lav_ok   
         			,:kst_tab_meca.note_lav_ok  
         			,:kst_tab_meca.cert_forza_stampa  
					,:kst_tab_contratti.codice
					,:kst_tab_clienti.rag_soc_10 
					,:kst_tab_clienti.rag_soc_11 
					,:kst_tab_clienti.rag_soc_20 
					,:kst_tab_contratti.mc_co 
         		,:kst_tab_meca.e1doco   
         		,:kst_tab_meca.e1rorn 
               ;

			kst_tab_artr_old.colli = 0
			kst_tab_artr_old.colli_trattati = 0
			kst_tab_artr_old.colli_groupage = 0
	
//			kst_tab_artr_old.num_certif = kst_tab_artr.num_certif					  
			kst_tab_artr_old.num_certif = 0
			
			do while sqlca.sqlcode = 0

				kst_tab_armo.id_meca = kst_tab_meca.id
				kuf1_artr.get_colli_trattati(kst_tab_artr, kst_tab_meca.id) // colli trattati/groupage
				kst_tab_armo.id_meca = kst_tab_meca.id
				kst_tab_armo.colli_2 = kuf1_armo.get_colli_lotto(kst_tab_armo)  // colli entrati

				kuf1_artr.if_isnull(kst_tab_artr)
				kuf1_armo.if_isnull_meca(kst_tab_meca)
				if isnull(kst_tab_armo.id_armo) then kst_tab_armo.id_armo = 0
				if isnull(kst_tab_armo.colli_2) then kst_tab_armo.colli_2 = 0
				if isnull(kst_tab_contratti.codice) then kst_tab_contratti.codice = 0
//				if isnull(kst_tab_contratti.sc_cf) then kst_tab_contratti.sc_cf = " "
				if isnull(kst_tab_contratti.mc_co) then kst_tab_contratti.mc_co = " "
//				if isnull(kst_tab_contratti.descr) then kst_tab_contratti.descr = " "
				if isnull(kst_tab_clienti.rag_soc_10) then kst_tab_clienti.rag_soc_10 = " "
				if isnull(kst_tab_clienti.rag_soc_11) then kst_tab_clienti.rag_soc_11 = " "
				if isnull(kst_tab_clienti.rag_soc_20) then kst_tab_clienti.rag_soc_20 = " "
					
//--- A rottura di num certificato ------------------------------------------------------------------ 
				if kst_tab_artr.num_certif <> kst_tab_artr_old.num_certif then

//--- scrivo l'item solo a fine certificato
//					kst_treeview_data_any.st_tab_armo.colli_2 = kst_tab_armo_old.colli_2 
//					kst_treeview_data_any.st_tab_artr.colli = kst_tab_artr_old.colli 
//					kst_treeview_data_any.st_tab_artr.colli_trattati = kst_tab_artr_old.colli_trattati 
//					kst_treeview_data_any.st_tab_artr.colli_groupage = kst_tab_artr_old.colli_groupage 
					kst_tab_armo.num_int = kst_tab_meca.num_int
					kst_tab_armo.data_int = kst_tab_meca.data_int
					kst_tab_certif.num_certif = kst_tab_artr.num_certif
					

					k_flag_da_lavorare = false
					k_flag_lotto_lav_completata = false
					k_flag_record_da_esporre = false
					k_lotto_convalidato = false
					kst_tab_meca.st_tab_meca_dosim.dosim_data = kkg.data_no
					
//--- per ogni lotto controllo se lavorazione completata 					
					kst_tab_armo.id_meca = kst_tab_meca.id
					if kuf1_armo.if_lotto_completo(kst_tab_armo) then
						k_flag_lotto_lav_completata = true
					end if
	
//					if kst_tab_meca.st_tab_meca_dosim.dosim_data <= KKG.DATA_NO or isnull(kst_tab_meca.st_tab_meca_dosim.dosim_data) &
//						or not k_flag_lotto_lav_completata then
//	//					or kst_tab_meca.data_lav_fin <= KKG.DATA_NO or isnull(kst_tab_meca.data_lav_fin) then
//						k_flag_da_lavorare = true
//					end if
	
//--- per ogni lotto controllo se Convalida effettuata
					if k_flag_lotto_lav_completata then
						if kuf1_armo.if_convalidato(kst_tab_meca) then
							k_lotto_convalidato = true
						end if
//--- get della data di Convalida
						kst_tab_meca.st_tab_meca_dosim.id_meca = kst_tab_meca.id
						kst_tab_meca.st_tab_meca_dosim.dosim_data = kuf1_meca_dosim.get_dosim_data_max(kst_tab_meca.st_tab_meca_dosim)
					end if
					
//--- lotto da_stampare/da_stampare_farmaceutico/da_stampare_alimentare
					if k_lotto_convalidato &
					   and (k_tipo_oggetto=kuf1_treeview.kist_treeview_oggetto.certif_da_st_dett &
				  		     or k_tipo_oggetto=kuf1_treeview.kist_treeview_oggetto.certif_da_st_farma_dett &
				           or k_tipo_oggetto=kuf1_treeview.kist_treeview_oggetto.certif_da_st_alimen_dett) then
						k_flag_record_da_esporre = true
					end if
//--- lotto in lavorazione
					if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.certif_in_lav_dett and NOT k_flag_lotto_lav_completata &
						 	and kst_tab_artr.colli > kst_tab_artr.colli_trattati then
						k_flag_record_da_esporre = true
					end if
//--- lotto da Convalidare					
					if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.certif_da_conv_dett &
					 		and k_flag_lotto_lav_completata and not k_lotto_convalidato then
						k_flag_record_da_esporre = true
					end if

//--- lotto con anomalia
//4-3-05						 and kst_treeview_data_any.st_tab_artr.colli <= kst_treeview_data_any.st_tab_artr.colli_trattati &
					if k_tipo_oggetto = kuf1_treeview.kist_treeview_oggetto.certif_err_dett &
						 			and k_flag_lotto_lav_completata &
									and kst_tab_meca.st_tab_meca_dosim.dosim_data > kkg.data_zero then
						k_flag_record_da_esporre = true
					end if

					if k_flag_record_da_esporre then
						
//--- leggo le date di inizio e fine lavorazione
//						kst_tab_artr.num_certif = kst_treeview_data_any.st_tab_artr.num_certif 
						kst_esito = kuf1_artr.leggi(2, kst_tab_artr)
						
//--- dati esposti nell'item	
						kst_treeview_data.label = &
										 string(kst_tab_artr.num_certif, "##,##0") &
										  + "   (" + string(kst_tab_meca.num_int, "####0") &
										  + "/" + string(kst_tab_meca.data_int, "mmm.yy") &
										  + "   " &
										  + string(kst_tab_clienti.rag_soc_11, "@@@@@@@@@@") + ")"

//--- riempo dati tabella dell'item
						kst_treeview_data_any.st_tab_artr = kst_tab_artr
						kst_treeview_data_any.st_tab_meca = kst_tab_meca
						kst_treeview_data_any.st_tab_armo = kst_tab_armo
						kst_treeview_data_any.st_tab_clienti = kst_tab_clienti
						kst_treeview_data_any.st_tab_contratti = kst_tab_contratti
						kst_treeview_data_any.st_tab_certif = kst_tab_certif

						kst_treeview_data.struttura = kst_treeview_data_any
						kst_treeview_data.oggetto = k_tipo_oggetto_figlio 
						kst_treeview_data.handle = k_handle_item_padre
						ktvi_treeviewitem.label = kst_treeview_data.label
						ktvi_treeviewitem.data = kst_treeview_data
	
//--- Nuovo Item
						ktvi_treeviewitem.selected = false
						k_handle_item = kuf1_treeview.kitv_tv1.insertitemlast(k_handle_item_padre, ktvi_treeviewitem)
					
//--- salvo handle del item appena inserito nella stessa struttura
						kst_treeview_data.handle = k_handle_item
	
						kst_treeview_data.pic_list = k_pic_list
	
//--- inserisco il handle di questa riga tra i dati del item
						ktvi_treeviewitem.data = kst_treeview_data
	
						kuf1_treeview.kitv_tv1.setitem(k_handle_item, ktvi_treeviewitem)
						
						kst_tab_armo.num_int = kst_tab_meca.num_int
						kst_tab_armo.data_int = kst_tab_meca.data_int
						kst_tab_certif.num_certif = kst_tab_artr.num_certif
						
		
						kst_treeview_data_any.st_tab_treeview = kst_tab_treeview 
					end if

//--- inizializza 					
					kst_tab_artr_old.num_certif = kst_tab_artr.num_certif					  
//					kst_tab_armo_old.colli_2 = 0
//					kst_tab_artr_old.colli = 0
//					kst_tab_artr_old.colli_trattati = 0
//					kst_tab_artr_old.colli_groupage = 0


				end if

				
				
//         			,:kst_tab_meca.st_tab_meca_dosim.dosim_data   
//					,:kst_tab_meca.st_tab_meca_dosim.dosim_dose
//         			,:kst_tab_meca.st_tab_meca_dosim.dosim_assorb  
//         			,:kst_tab_meca.st_tab_meca_dosim.dosim_spessore  
//         			,:kst_tab_meca.st_tab_meca_dosim.dosim_rapp_a_s  
//         			,:kst_tab_meca.st_tab_meca_dosim.dosim_lotto_dosim  
//         			,:kst_tab_meca.st_tab_meca_dosim.barcode
//         			,:kst_tab_meca.st_tab_meca_dosim.barcode_dosimetro  

				fetch kc_treeview 
				into
					 :kst_tab_artr.num_certif
					,:kst_tab_meca.id   
					,:kst_tab_meca.num_int   
					,:kst_tab_meca.data_int   
					,:kst_tab_meca.area_mag   
					,:kst_tab_meca.clie_1  
					,:kst_tab_meca.clie_2  
					,:kst_tab_meca.clie_3  
					,:kst_tab_meca.num_bolla_in 
					,:kst_tab_meca.data_bolla_in 
					,:kst_tab_meca.data_lav_fin 
         			,:kst_tab_meca.err_lav_fin   
         			,:kst_tab_meca.err_lav_ok   
         			,:kst_tab_meca.note_lav_ok  
         			,:kst_tab_meca.cert_forza_stampa  
					,:kst_tab_contratti.codice
					,:kst_tab_clienti.rag_soc_10 
					,:kst_tab_clienti.rag_soc_11 
					,:kst_tab_clienti.rag_soc_20 
					,:kst_tab_contratti.mc_co 
         			,:kst_tab_meca.e1doco   
         			,:kst_tab_meca.e1rorn 
               ;

	
			loop
			
			close kc_treeview;

		end if
	end if 

	
catch (uo_exception kuo_exception)
	kuo_exception.messaggio_utente()

finally
	if isvalid(kuf1_sl_pt)  then destroy kuf1_sl_pt
	if isvalid(kuf1_artr)  then destroy kuf1_artr
	if isvalid(kuf1_armo)  then destroy kuf1_armo
	if isvalid(kuf1_meca_dosim)  then destroy kuf1_meca_dosim
	
end try

 
return k_return


end function

public function st_esito apri_lavorazione (readonly st_tab_artr kst_tab_artr);//
//====================================================================
//=== Aggiunge rek ARTR 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Non trovato 
//===                                     2=Errore Grave
//===                                     3=altro errore
//====================================================================
//
string k_return = "0 "
long k_ctr
//long k_id_armo, k_colli, k_colli_trattati, k_colli_groupage 
st_esito kst_esito
st_tab_armo kst_tab_armo
st_tab_barcode kst_tab_barcode
kuf_armo kuf1_armo
kuf_barcode kuf1_barcode


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
//	k_id_armo = kst_tab_artr.id_armo 
	
	kst_tab_artr.x_datins = kGuf_data_base.prendi_x_datins()
	kst_tab_artr.x_utente = kGuf_data_base.prendi_x_utente()

	kuf1_barcode = create kuf_barcode
	
	try 

//--- Piglia la data di inizio trattamento più antica x id riga 			
		kst_tab_barcode.id_armo = kst_tab_artr.id_armo
		kst_tab_barcode.pl_barcode = kst_tab_artr.pl_barcode
		kst_tab_artr.data_in = kuf1_barcode.get_data_lav_ini_x_id_armo(kst_tab_barcode)

//--- Piglia il numero colli che sono stati messi nel PL  x id riga 			
		kst_tab_barcode.id_armo = kst_tab_artr.id_armo
		kst_tab_barcode.pl_barcode = kst_tab_artr.pl_barcode
		kst_tab_artr.colli = kuf1_barcode.get_conta_barcode_x_id_armo_pl_barcode(kst_tab_barcode)

//--- Piglia il numero colli Groupage come Figli che sono in PL x id riga 			
		kst_tab_barcode.id_armo = kst_tab_artr.id_armo
		kst_tab_barcode.pl_barcode = kst_tab_artr.pl_barcode
		kst_tab_artr.colli_groupage = kuf1_barcode.get_conta_barcode_groupage_x_id_armo(kst_tab_barcode)

		setnull(kst_tab_artr.data_fin) 

//--- Test di esistenza del record di Trattamento	
		select count(*)  into :k_ctr
			 from artr 
			 where id_armo = : kst_tab_artr.id_armo  
					 and pl_barcode = :kst_tab_artr.pl_barcode
			 using sqlca;
 //colli, colli_trattati, colli_groupage			 
//			 into :k_colli, :k_colli_trattati, :k_colli_groupage
		

		if sqlca.sqlcode = 100 or isnull(k_ctr) or k_ctr = 0 then
	
			insert into artr 
				( id_armo
				 ,data_in
				 ,data_fin
				 ,pl_barcode
				 ,colli 
				 ,colli_trattati
				 ,colli_groupage
				 ,x_datins
				 ,x_utente)
			values
				( :kst_tab_artr.id_armo
				 ,:kst_tab_artr.data_in
				 ,:kst_tab_artr.data_fin
				 ,:kst_tab_artr.pl_barcode
				 ,:kst_tab_artr.colli 
				 ,0
				 ,:kst_tab_artr.colli_groupage
				 ,:kst_tab_artr.x_datins
				 ,:kst_tab_artr.x_utente
				 )
			 using sqlca;
		
		else
				
			update artr set
				  colli = :kst_tab_artr.colli
				 ,colli_groupage = :kst_tab_artr.colli_groupage
				 ,x_datins = :kst_tab_artr.x_datins
				 ,x_utente = :kst_tab_artr.x_utente
			 where id_armo = : kst_tab_artr.id_armo 
					 and pl_barcode = :kst_tab_artr.pl_barcode
			 using sqlca;
			
		end if
		
		
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Lavorazioni: " + trim(SQLCA.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito.not_fnd
			else
				if sqlca.sqlcode > 0 then
					kst_esito.esito = kkg_esito.err_formale
				else	
					kst_esito.esito = kkg_esito.db_ko
				end if
			end if
		end if
	
	
		if sqlca.sqlcode < 0 then
			if kist_tab_artr.st_tab_g_0.esegui_commit <> "N" or isnull(kist_tab_artr.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_rollback_1( )
			end if
		else
			if kist_tab_artr.st_tab_g_0.esegui_commit <> "N" or isnull(kist_tab_artr.st_tab_g_0.esegui_commit) then
				kGuf_data_base.db_commit_1( )
			end if
		end if

	catch (uo_exception kuo_exception)
		kst_esito = kuo_exception.get_st_esito()

	finally
		destroy kuf1_barcode
		
	end try

return kst_esito

end function

public function st_esito get_num_certif (ref st_tab_artr kst_tab_artr);//
//----------------------------------------------------------------------------------------------------------
//--- 
//--- Legge il NUM CERTIF
//--- 
//--- Inp:  id_armo e pl_barcode
//--- Out:  num_certif
//---  
//--- Ritorna tab. ST_ESITO
//--- 
//----------------------------------------------------------------------------------------------------------
//
string k_rc
st_esito kst_esito, kst1_esito
st_tab_base kst_tab_base
st_tab_armo kst_tab_armo
kuf_base kuf1_base
kuf_armo kuf1_armo


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	

	kst_tab_armo.id_armo = kst_tab_artr.id_armo

//--- becco il ID_MECA dall'ARMO
	kuf1_armo = create kuf_armo
	kst_esito = kuf1_armo.get_id_meca(kst_tab_armo)
	destroy kuf1_armo

	if kst_esito.esito = kkg_esito.ok then
		
//--- Cerca num certificato
		declare c_crea_att_dett_1 cursor for
		    select distinct b.num_certif
	   	     from armo as a inner join artr as b on 
						 a.id_armo = b.id_armo
				 where a.id_meca = :kst_tab_armo.id_meca and 
						 b.num_certif > 0
				 order by b.num_certif desc
				 using kguo_sqlca_db_magazzino;

		kst_tab_artr.num_certif = 0 

//--- becco il num_certif per id riga e pl_barcode
		select max(artr.num_certif)
			  into :kst_tab_artr.num_certif
			  from artr
			where id_armo = :kst_tab_armo.id_armo and pl_barcode = :kst_tab_artr.pl_barcode 
			using kguo_sqlca_db_magazzino;

//--- Se num certificato non ancora impostato, procedo
		if kst_tab_artr.num_certif = 0 or isnull(kst_tab_artr.num_certif) then
	
			open c_crea_att_dett_1;
			if kguo_sqlca_db_magazzino.sqlcode = 0 then
				fetch c_crea_att_dett_1 into :kst_tab_artr.num_certif;
				
				if kguo_sqlca_db_magazzino.sqlcode < 0 then
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = "Legge Numero Certificato da id lotto: " + string(kst_tab_armo.id_meca) + " ~n~r" + trim(kguo_sqlca_db_magazzino.sqlerrtext)
				end if
				close c_crea_att_dett_1;
			else
				if kguo_sqlca_db_magazzino.sqlcode < 0 then 
					kst_esito.esito = kkg_esito.db_ko
					kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
					kst_esito.SQLErrText = "Legge Numero Certificato da id lotto (open): " + string(kst_tab_armo.id_meca) + " ~n~r" + trim(kguo_sqlca_db_magazzino.sqlerrtext)
				end if
			end if
		
			if kst_esito.esito = kkg_esito.ok then
	
//--- se Numero Certificato mai impostato lo ricavo dal BASE	
				if isnull(kst_tab_artr.num_certif) or kst_tab_artr.num_certif = 0 then

					kuf1_base = create kuf_base
//--- Acchiappo numero certificato 
					k_rc = kuf1_base.prendi_dato_base("num_certif")
					if LeftA(k_rc, 1) = "0" then
						kst_tab_artr.num_certif = long(trim(MidA(k_rc, 2))) + 1    // l'ultimo numero + 1
					end if
					if isnull(kst_tab_artr.num_certif) or  kst_tab_artr.num_certif = 0 then
						kst_esito.esito = "1"
						kst_esito.sqlcode = 0
						kst_esito.SQLErrText = "Errore durante lettura Numero Certificato, controlla Archivio Azienda (base)"
					end if
				end if
				
				destroy kuf1_base
				
			end if
			
			
		end if
		
	end if	


return kst_esito


end function

public function long get_id_armo_da_num_certif (st_tab_artr kst_tab_artr) throws uo_exception;//
//====================================================================
//--- Legge tab ARTR x trovare il ID_ARMO piu' grande
//---
//--- Input: st_tab_artr.num_certif
//--- out:     
//--- Ritorna: ID_ARMO  (0=non trovato)
//---
//====================================================================
//
long k_return = 0
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


//	select distinct id_meca
//				 into :k_return
//				 from armo
//				 where armo.id_armo in
	select max( a.id_armo )
				 into :k_return
						 from artr a
						  where a.num_certif = :kst_tab_artr.num_certif 
				 using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Lavorazioni, ARTR ricerca del ID ARMO, per l'Attestato nr.= " &
									 + string(kst_tab_artr.num_certif) + "): " + trim(SQLCA.SQLErrText)
									 
		if sqlca.sqlcode > 0 or isnull(k_return) then
			k_return = 0
		else
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito_reset( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if
	end if


return k_return


end function

public function long get_colli_da_id_armo_pl_barcode (st_tab_artr kst_tab_artr) throws uo_exception;//
//====================================================================
//--- Legge tab ARTR x reperire il Numerto Colli 
//---
//--- Input: st_tab_artr.id_armo, pl_abarcode 
//--- out:     
//--- Ritorna: COLLI  (0=non trovato)
//---
//====================================================================
//
long k_return = 0
st_esito kst_esito



	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	select count (a.colli)
				 into :k_return
						 from artr a
						  where a.id_armo = :kst_tab_artr.id_armo and a.pl_barcode = :kst_tab_artr.pl_barcode
				 using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Lavorazioni (ARTR) calcolo COLLI per riga Lotto id = " &
									 + string(kst_tab_artr.id_armo) + "): " + trim(SQLCA.SQLErrText)
									 
		if sqlca.sqlcode > 0 or isnull(k_return) then
			k_return = 0
		else
			kst_esito.esito = kkg_esito.db_ko
			kguo_exception.set_esito_reset( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
			
		end if
	end if


return k_return


end function

public function boolean tb_sistema_lotto (st_tab_artr ast_tab_artr) throws uo_exception;//
//=== 
//=== Sistema da tabella BARCODE la tab. ARTR (colli, trattati, groupage...)
//=== input: ast_tab_artr.id_armo
//===   
//

int  k_codice=0, k_ind=0
st_tab_artr kst_tab_artr[]
st_tab_artr kst_tab_artr1
st_tab_barcode kst_tab_barcode
kuf_barcode kuf1_barcode
st_esito kst_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	declare c_tb_sistema_movimento cursor for
		select colli, colli_trattati, colli_groupage,  id_armo, pl_barcode
			from  artr
			where id_armo = :ast_tab_artr.id_armo
//			(select id_armo from armo where id_meca = :ast_tab_artr.id_)
			using kguo_sqlca_db_magazzino;
//			for update;


	open c_tb_sistema_movimento;
	
	if sqlca.sqlcode = 0 then
		
		k_ind = 1
		fetch c_tb_sistema_movimento into :kst_tab_artr[k_ind].colli,:kst_tab_artr[k_ind].colli_trattati,:kst_tab_artr[k_ind].colli_groupage,:kst_tab_artr[k_ind].id_armo,  :kst_tab_artr[k_ind].pl_barcode;
	
	   	do while sqlca.sqlcode = 0 
			
			fetch c_tb_sistema_movimento into :kst_tab_artr[k_ind].colli,:kst_tab_artr[k_ind].colli_trattati,:kst_tab_artr[k_ind].colli_groupage,:kst_tab_artr[k_ind].id_armo,  :kst_tab_artr[k_ind].pl_barcode;
		
		loop


		close c_tb_sistema_movimento;

		try

			kuf1_barcode = create kuf_barcode
			
			for k_ind = 1 to upperbound(kst_tab_artr)

//--- calcolo dei colli effettivamente messi nel PL e quindi in Lavorazione (Legge BARCODE)
				kst_tab_barcode.id_armo = kst_tab_artr[k_ind].id_armo
				kst_tab_barcode.pl_barcode = kst_tab_artr[k_ind].pl_barcode
				kst_tab_artr1.colli_groupage = kuf1_barcode.get_conta_barcode_groupage_x_id_armo(kst_tab_barcode)
				kst_tab_artr1.colli_trattati = kuf1_barcode.get_conta_barcode_x_id_armo_fine_lav(kst_tab_barcode)
				kst_tab_artr1.colli = kuf1_barcode.get_conta_barcode_x_id_armo_pl_barcode(kst_tab_barcode) 
		
				if kst_tab_artr1.colli_groupage <> kst_tab_artr[k_ind].colli_groupage or kst_tab_artr1.colli_trattati <> kst_tab_artr[k_ind].colli_trattati &
							or kst_tab_artr1.colli <> kst_tab_artr[k_ind].colli then
					
					if  kst_tab_artr1.colli = 0 then //se non ci sono colli posso proprio togliere questo record
						delete from artr 
							where id_armo = :kst_tab_artr[k_ind].id_armo
									  and pl_barcode = :kst_tab_artr[k_ind].pl_barcode
						  using kguo_sqlca_db_magazzino;
					
					else	// altrimenti aggiorno i vari colli
						
						update artr 
								  set  colli = :kst_tab_artr1.colli,     
										colli_trattati = :kst_tab_artr1.colli_trattati,
										colli_groupage = :kst_tab_artr1.colli_groupage 
							where id_armo = :kst_tab_artr[k_ind].id_armo
									  and pl_barcode = :kst_tab_artr[k_ind].pl_barcode
						  using kguo_sqlca_db_magazzino;
					end if
		
					if kguo_sqlca_db_magazzino.sqlcode = 0 then
						k_codice ++
					else
						if kguo_sqlca_db_magazzino.sqlcode < 0 then
							kst_esito.esito = kkg_esito.db_ko
							kst_esito.sqlcode = sqlca.sqlcode
							kst_esito.sqlerrtext = "Errore durante sistemazione archivio Trattati (ARTR)- Riga Lotto: " + string(kst_tab_artr[k_ind].id_armo) + "  ~n~r " + string(sqlca.sqlcode) + " " + sqlca.sqlerrtext 
							kguo_exception.inizializza( )
							kguo_exception.set_esito(kst_esito)
							throw kguo_exception
						end if

					end if
					
				end if
				
			end for
				
		catch (uo_exception kuo1_exception)
			throw kuo1_exception
				
		finally
			if kst_esito.esito = kkg_esito.db_ko then
				if ast_tab_artr.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_artr.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_rollback( )
				end if
			else
				if ast_tab_artr.st_tab_g_0.esegui_commit <> "N" or isnull(ast_tab_artr.st_tab_g_0.esegui_commit) then
					kguo_sqlca_db_magazzino.db_commit( )
				end if
			end if
			if isvalid(kuf1_barcode) then destroy kuf1_barcode
				
		end try
			

	
	end if	
	 

	if k_codice > 0 then
	
		return true
	else
		
		return false
	end if

end function

public function long get_colli_trattati_x_id_armo (st_tab_artr kst_tab_artr) throws uo_exception;//
//----------------------------------------------------------------------------------------------------------
//--- 
//--- Legge COLLI TRATTATI DELLA RIGA LOTTO 
//--- 
//--- Inp:  id_armo 
//--- Out:  colli
//---  
//--- Ritorna tab. ST_ESITO
//--- 
//----------------------------------------------------------------------------------------------------------
//
long k_return = 0
st_esito kst_esito, kst1_esito


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	


//--- Ricavo il numero colli gia' Trattati
	
	select sum(b.colli_trattati)
	  into :kst_tab_artr.colli 
	  from artr as b 
		 where b.id_armo = :kst_tab_artr.id_armo
		       and data_fin > convert(date,'01.01.1899')
		 using kguo_sqlca_db_magazzino;


	if kguo_sqlca_db_magazzino.sqlcode = 0 then
		if kst_tab_artr.colli > 0 then 
			
			k_return = kst_tab_artr.colli
			
		end if
	else
		
		if kguo_sqlca_db_magazzino.sqlcode < 0 then 
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = kguo_sqlca_db_magazzino.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura Numero Colli Trattati da ID_ARMO lotto (artr): " + string(kst_tab_artr.id_armo) + " ~n~r" + trim(kguo_sqlca_db_magazzino.sqlerrtext)
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)	
			throw kguo_exception
		end if
	end if


return k_return 


end function

public function st_esito get_colli_trattati (ref st_tab_artr kst_tab_artr, long k_id_meca);//
//----------------------------------------------------------------------------------------------------------
//--- 
//--- Legge COLLI TRATTATI LOTTO INTERO
//--- 
//--- Inp:  id_armo + id_meca
//--- Out:  colli, colli_trattati, colli_groupage
//---  
//--- Ritorna tab. ST_ESITO
//--- 
//----------------------------------------------------------------------------------------------------------
//
st_esito kst_esito, kst1_esito
//st_tab_armo kst_tab_armo
//kuf_armo kuf1_armo


	kst_esito.esito = kkg_esito.ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	

//	kst_tab_armo.id_armo = kst_tab_artr.id_armo

////--- becco il ID_MECA dall'ARMO
//	kuf1_armo = create kuf_armo
//	kst_esito = kuf1_armo.get_id_meca(kst_tab_armo)
//	destroy kuf1_armo

	if kst_esito.esito = kkg_esito.ok then

//			 in
//			    ( select distinct id_meca from armo where id_armo = :kst_tab_artr.id_armo )

//--- Ricavo il numero colli gia' Trattati
		kst_tab_artr.colli  = 0
		
		select sum(b.colli_trattati)
				 ,sum(b.colli)
				 ,sum(b.colli_groupage)
		  into :kst_tab_artr.colli_trattati 
		  		,:kst_tab_artr.colli 
				,:kst_tab_artr.colli_groupage
		  from armo as a inner join artr as b on 
				 a.id_armo = b.id_armo
			 where a.id_meca = :k_id_meca
			 using sqlca;
			 
			 
		if isnull(kst_tab_artr.colli ) then 
			kst_tab_artr.colli  = 0
		end if

		if sqlca.sqlcode < 0 then 
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Errore durante lettura Numero Colli Trattati per ID lotto (artr): " + string(k_id_meca) + " ~n~r" + trim(sqlca.sqlerrtext)
		end if

	end if

return kst_esito


end function

on kuf_artr.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_artr.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

