$PBExportHeader$kuf_barcode.sru
forward
global type kuf_barcode from nonvisualobject
end type
end forward

global type kuf_barcode from nonvisualobject
end type
global kuf_barcode kuf_barcode

type variables
//--- causali
public constant string ki_causale_non_trattare="T"

//--- variabile di stato campo errore
public constant string ki_err_lav_fin_ko ="1"
public constant string ki_err_lav_fin_ok ="0"

//--- id streamer della stampa etichette
public long ki_id_print_etichette=0 
public boolean ki_stampa_etichetta_autorizza = false

//--- contatore etichette nella pagina (probabile al max 2 o 4)
private int ki_num_etichetta_in_pag=0 
st_tab_barcode kist_tab_barcode_stampa_save

//--- Datasore elenco Figli del Barcode
public string ki_ds_barcode_figli_elenco = "ds_barcode_figli_elenco"

//--- Datawindow elenco Figli e Padri potenziali
public constant string kk_dw_nome_barcode_l_padri_potenziali = "d_barcode_l_padri"  
public constant string kk_dw_nome_barcode_l_figli_potenziali = "d_barcode_l_figli_potenziali"  

//--- Flag Groupage
public constant string ki_barcode_groupage_SI = "S"
public constant string ki_barcode_groupage_NO = "N"

st_tab_barcode kist_tab_barcode
DECLARE kicursor_barcode_1 CURSOR FOR 
                SELECT barcode.barcode
					       ,barcode.pl_barcode
						FROM barcode
					   where 
							  barcode.barcode = :kist_tab_barcode.barcode 
							   or 
							  (
							   :kist_tab_barcode.barcode = '*'
								    and (:kist_tab_barcode.pl_barcode = 0
								         or barcode.pl_barcode = :kist_tab_barcode.pl_barcode 
								         or barcode.pl_barcode is null
											or barcode.pl_barcode = 0)
								  and barcode.num_int = :kist_tab_barcode.num_int
								  and barcode.data_int = :kist_tab_barcode.data_int 
								  and (barcode.fila_1 = :kist_tab_barcode.fila_1
								   or (barcode.fila_1 is null and :kist_tab_barcode.fila_1 = 999))
								  and (barcode.fila_1p = :kist_tab_barcode.fila_1p
								   or (barcode.fila_1p is null and :kist_tab_barcode.fila_1p = 999))
								  and (barcode.fila_2 = :kist_tab_barcode.fila_2
								   or (barcode.fila_2 is null and :kist_tab_barcode.fila_2 = 999))
								  and (barcode.fila_2p = :kist_tab_barcode.fila_2p
								   or (barcode.fila_2p is null and :kist_tab_barcode.fila_2p = 999))
								) ; 

//--- estrazione dei barcode non lavorati e in pl_barcode specifico
 declare kicursor_barcode_2 cursor for
   SELECT 
         barcode.data_int,   
         barcode.num_int,   
         barcode.tipo_cicli,   
         barcode.fila_1,   
         barcode.fila_2,   
         barcode.fila_1p,   
         barcode.fila_2p   
    FROM barcode 
   WHERE barcode.num_int = :kist_tab_barcode.num_int 
         and barcode.data_int >= :kist_tab_barcode.data_int  
		  and ((barcode.pl_barcode = 0 or barcode.pl_barcode is null) 
			 or (:kist_tab_barcode.pl_barcode > 0 
			     and barcode.pl_barcode = :kist_tab_barcode.pl_barcode)) 
		  and (barcode.barcode_lav is null or barcode.barcode_lav = '')
		  and barcode.data_stampa > 0 
		  and (barcode.data_sosp = date(0) or barcode.data_sosp is null)  ;
		  
		  
	

end variables

forward prototypes
private subroutine stampa_barcode (string k_barcode, long k_id_print, integer k_coord_x, integer k_coord_y, integer k_altezza_cb)
public function string togli_pl_barcode (ref st_tab_barcode kst_tab_barcode)
public function string togli_pl_barcode_all (ref st_tab_barcode kst_tab_barcode)
public function st_esito togli_pl_barcode_chiuso (st_tab_barcode kst_tab_barcode)
public function st_esito select_barcode (ref st_tab_barcode kst_tab_barcode)
public function st_esito tb_prendi_campo (ref st_tab_barcode kst_tab_barcode, string k_campo)
public function st_esito tb_update_campo (st_tab_barcode kst_tab_barcode, string k_campo)
public function st_esito metti_pl_barcode (ref st_tab_barcode kst_tab_barcode, string k_tipo)
public function st_esito kicursor_barcode_1_close ()
public function st_esito kicursor_barcode_1_open ()
public subroutine if_isnull (ref st_tab_barcode kst_tab_barcode)
public function st_esito tb_delete_x_rif (ref st_tab_barcode kst_tab_barcode)
public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_barcode kst_tab_barcode)
public function st_esito kicursor_barcode_1_fetch ()
public function integer stampa_etichetta_riferimento (string k_barcode, long k_num_int, date k_data_int)
public subroutine stampa_etichetta_riferimento_autorizza ()
public subroutine stampa_etichetta_riferimento_close ()
public subroutine stampa_etichetta_riferimento_open ()
private subroutine stampa_barcode_f (string k_barcode, long k_id_print, integer k_coord_x, integer k_coord_y, integer k_altezza_cb, integer k_id_font)
public function integer stampa_etichetta_riferimento_ristampa (string k_barcode, long k_num_int, date k_data_int)
public function st_tab_barcode get_primo_barcode_in_lav () throws uo_exception
public subroutine check_anomalie_lavorazione (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public subroutine togli_pl_barcode_non_chiuso (st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean if_barcode_trattato (st_tab_barcode kst_tab_barcode) throws uo_exception
public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode)
public function st_esito anteprima_elenco (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode)
public function boolean if_barcode_in_pl_chiuso (st_tab_barcode kst_tab_barcode) throws uo_exception
public function st_esito if_essere_barcode_padre (ref st_tab_barcode kst_tab_barcode_figlio, ref st_tab_barcode kst_tab_barcode_padre) throws uo_exception
public function boolean if_barcode_in_pl (st_tab_barcode kst_tab_barcode) throws uo_exception
public function st_esito select_barcode_trattamento (ref st_tab_barcode kst_tab_barcode)
public function st_esito if_essere_barcode_figlio (ref st_tab_barcode kst_tab_barcode_figlio, ref st_tab_barcode kst_tab_barcode_padre) throws uo_exception
public function st_esito tb_aggiungi_figlio (st_tab_barcode kst_tab_barcode)
public function st_esito tb_togli_figlio (st_tab_barcode kst_tab_barcode)
public function st_esito anteprima_elenco_figli (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode)
public function long get_conta_figli (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function st_esito tb_togli_figli_tutti (st_tab_barcode kst_tab_barcode)
public function st_esito tb_delete (ref st_tab_barcode kst_tab_barcode)
public function datastore get_figli_barcode (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean if_barcode_figlio (st_tab_barcode kst_tab_barcode) throws uo_exception
public function boolean get_padre (ref st_tab_barcode kst_tab_barcode) throws uo_exception
public function st_esito tb_set_padre (st_tab_barcode kst_tab_barcode)
public function st_esito tb_togli_figlio_al_padre (st_tab_barcode kst_tab_barcode)
public function long get_conta_barcode_x_id_armo_fine_lav (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function long get_conta_barcode_x_id_armo_in_lav (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function long get_conta_barcode_groupage_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function date get_data_lav_ini_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
public function date get_data_lav_fin_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception
end prototypes

private subroutine stampa_barcode (string k_barcode, long k_id_print, integer k_coord_x, integer k_coord_y, integer k_altezza_cb);//
// stampa codice a barre standard CODE 39
//
// 1'' (inches) = 2,54 cm 
// ogni carattere è composto da 5 barre e 4 spazi (=9 elementi)
// ogni elemento può essere fine o grosso (narrow o wide)
// 3 dei 9 elementi deve essere wide (ecco xchè si chiama 'code 39')
// la tabella k_caratt_barcode è di 44, ogni stringa contiene 9 caratteri che indicano 
// la sequenza 'sottile' e 'grosso' iniziando dall'elemento barra poi spazio poi barra ecc... 
// la codebar intera è composta da una zona franca di almeno 0,1'' + il carattere di 
// inizio '*' + il codice + il carattere di fine '*' + zona franca di almeno 0,1''
//
string k_caratt_barcode[0 to 44, 0 to 1], k_caratt_bar_sp=""
string k_open_print="N"
int k_spessore=0, k_altezza=0, k_coord_y1, k_font_alt=18, k_max_item=0
double k_coeff_di_spessore = 0.85 
int k_ctr=0, k_ctr1=0, k_ctr2=0


                                  k_caratt_bar_sp='bsbsbsbsb'
k_caratt_barcode[00,0]='0';  k_caratt_barcode[00,1]='nnnwwnwnn'
k_caratt_barcode[01,0]='1';  k_caratt_barcode[01,1]='wnnwnnnnw'
k_caratt_barcode[02,0]='2';  k_caratt_barcode[02,1]='nnwwnnnnw'
k_caratt_barcode[03,0]='3';  k_caratt_barcode[03,1]='wnwwnnnnn'
k_caratt_barcode[04,0]='4';  k_caratt_barcode[04,1]='nnnwwnnnw'
k_caratt_barcode[05,0]='5';  k_caratt_barcode[05,1]='wnnwwnnnn'
k_caratt_barcode[06,0]='6';  k_caratt_barcode[06,1]='nnwwwnnnn'
k_caratt_barcode[07,0]='7';  k_caratt_barcode[07,1]='nnnwnnwnw'
k_caratt_barcode[08,0]='8';  k_caratt_barcode[08,1]='wnnwnnwnn'
k_caratt_barcode[09,0]='9';  k_caratt_barcode[09,1]='nnwwnnwnn'
k_caratt_barcode[10,0]='a';  k_caratt_barcode[10,1]='wnnnnwnnw'
k_caratt_barcode[11,0]='b';  k_caratt_barcode[11,1]='nnwnnwnnw'
k_caratt_barcode[12,0]='c';  k_caratt_barcode[12,1]='wnwnnwnnn'
k_caratt_barcode[13,0]='d';  k_caratt_barcode[13,1]='nnnnwwnnw'
k_caratt_barcode[14,0]='e';  k_caratt_barcode[14,1]='wnnnwwnnn'
k_caratt_barcode[15,0]='f';  k_caratt_barcode[15,1]='nnwnwwnnn'
k_caratt_barcode[16,0]='g';  k_caratt_barcode[16,1]='nnnnnwwnw'
k_caratt_barcode[17,0]='h';  k_caratt_barcode[17,1]='wnnnnwwnn'
k_caratt_barcode[18,0]='i';  k_caratt_barcode[18,1]='nnwnnwwnn'
k_caratt_barcode[19,0]='j';  k_caratt_barcode[19,1]='nnnnwwwnn'
k_caratt_barcode[20,0]='k';  k_caratt_barcode[20,1]='wnnnnnnww'
k_caratt_barcode[21,0]='l';  k_caratt_barcode[21,1]='nnwnnnnww'
k_caratt_barcode[22,0]='m';  k_caratt_barcode[22,1]='wnwnnnnwn'
k_caratt_barcode[23,0]='n';  k_caratt_barcode[23,1]='nnnnwnnww'
k_caratt_barcode[24,0]='o';  k_caratt_barcode[24,1]='wnnnwnnwn'
k_caratt_barcode[25,0]='p';  k_caratt_barcode[25,1]='nnwnwnnwn'
k_caratt_barcode[26,0]='q';  k_caratt_barcode[26,1]='nnnnnnwww'
k_caratt_barcode[27,0]='r';  k_caratt_barcode[27,1]='wnnnnnwwn'
k_caratt_barcode[28,0]='s';  k_caratt_barcode[28,1]='nnwnnnwwn'
k_caratt_barcode[29,0]='t';  k_caratt_barcode[29,1]='nnnnwnwwn'
k_caratt_barcode[30,0]='u';  k_caratt_barcode[30,1]='wwnnnnnnw'
k_caratt_barcode[31,0]='v';  k_caratt_barcode[31,1]='nwwnnnnnw'
k_caratt_barcode[32,0]='w';  k_caratt_barcode[32,1]='wwwnnnnnn'
k_caratt_barcode[33,0]='x';  k_caratt_barcode[33,1]='nwnnwnnnw'
k_caratt_barcode[34,0]='y';  k_caratt_barcode[34,1]='wwnnwnnnn'
k_caratt_barcode[35,0]='z';  k_caratt_barcode[35,1]='nwwnwnnnn'
k_caratt_barcode[36,0]='-';  k_caratt_barcode[36,1]='nwnnnnwnw'
k_caratt_barcode[37,0]='.';  k_caratt_barcode[37,1]='wwnnnnwnn'
k_caratt_barcode[38,0]=' ';  k_caratt_barcode[38,1]='nwwnnnwnn'
k_caratt_barcode[39,0]='*';  k_caratt_barcode[39,1]='nwnnwnwnn'
k_caratt_barcode[40,0]='$';  k_caratt_barcode[40,1]='nwnwnwnnn'
k_caratt_barcode[41,0]='/';  k_caratt_barcode[41,1]='nwnwnnnwn'
k_caratt_barcode[42,0]='+';  k_caratt_barcode[42,1]='nwnnnwnwn'
k_caratt_barcode[43,0]='%';  k_caratt_barcode[43,1]='nnnwnwnwn'
k_caratt_barcode[44,0]=' ';  k_caratt_barcode[44,1]='         '

k_max_item = upperbound(k_caratt_barcode, 1)


	if k_id_print = 0 or isnull(k_id_print) then
		k_open_print = "S"
	   k_id_print = PrintOpen( )
	end if
	
	if k_coord_x = 0 or isnull(k_coord_x) then
		k_coord_x = 1170
	end if
	if k_coord_y = 0 or isnull(k_coord_y) then
		k_coord_y = 3500
	end if
	if k_altezza_cb = 0 or isnull(k_altezza_cb) then
		k_altezza_cb = 1600
	end if
	k_coord_y1 = k_coord_y - k_font_alt
	k_altezza = k_altezza_cb + k_coord_y


//--- definizione di un font per la stampa di stringhe
	PrintDefineFont(k_id_print, 1, "Courier 10,12,15", - k_font_alt, 400, Fixed!, Modern!, FALSE, FALSE)
	
//--- carattere di inizio codice a barre
	for k_ctr1 = 1 to 9
		
      if MidA(k_caratt_barcode[39,1],k_ctr1,1) = 'n' then
			k_spessore = 10 * k_coeff_di_spessore
		else
			k_spessore = 25 * k_coeff_di_spessore
		end if

		if k_ctr1 = 5 then   // stampo il carattere per chiarezza
			printtext (k_id_print, MidA(k_caratt_barcode[39,0],k_ctr1,1), k_coord_x, k_coord_y1, 1)
		end if
		
      if MidA(k_caratt_bar_sp,k_ctr1,1) = 'b' then
			Printline(k_id_print, k_coord_x, k_coord_y, k_coord_x, k_altezza, k_spessore)
		end if
		k_coord_x = k_coord_x + k_spessore
		
	next

//--- stringa alfanumerica dell'effettivo codice a barre riempita con zero a destra
   k_barcode = trim(k_barcode) + FillA("0", (13 - LenA(trim(k_barcode)))) 
	
		
	for k_ctr2 = 1 to 13
		
		k_ctr=0
		do while MidA(k_barcode, k_ctr2, 1) = trim(k_caratt_barcode[k_ctr,0]) or k_ctr = k_max_item
			k_ctr++
		loop

//--- se carattere del barcode non trovato in tabella code-39 allora forzo l'uscita!
		if k_ctr = k_max_item then
			k_ctr2 = 14
		end if
		
		for k_ctr1 = 1 to 9
			if MidA(k_caratt_barcode[k_ctr,1],k_ctr1,1) = 'n' then
				k_spessore = 10 * k_coeff_di_spessore
			else
				k_spessore = 25 * k_coeff_di_spessore
			end if
	
			if k_ctr1 = 5 then   // stampo il carattere per chiarezza
			   printtext (k_id_print, MidA(k_caratt_barcode[k_ctr,0],k_ctr1,1), k_coord_x, k_coord_y1, 1)
			end if
				
			if MidA(k_caratt_bar_sp,k_ctr1,1) = 'b' then
				Printline(k_id_print, k_coord_x, k_coord_y, k_coord_x, k_altezza, k_spessore)
			end if
			k_coord_x = k_coord_x + k_spessore
			
		next
	next
	
//--- carattere di fine codice a barre
	for k_ctr1 = 1 to 9
      if MidA(k_caratt_barcode[39,1],k_ctr1,1) = 'n' then
			k_spessore = 10 * k_coeff_di_spessore
		else
			k_spessore = 25 * k_coeff_di_spessore
		end if

		if k_ctr1 = 5 then   // stampo il carattere per chiarezza
			printtext (k_id_print, MidA(k_caratt_barcode[39,0],k_ctr1,1), k_coord_x, k_coord_y1, 1)
		end if
		
      if MidA(k_caratt_bar_sp,k_ctr1,1) = 'b' then
			Printline(k_id_print, k_coord_x, k_coord_y, k_coord_x, k_altezza, k_spessore)
		end if
		k_coord_x = k_coord_x + k_spessore
		
	next


	if k_open_print = "S" then
		PrintClose(k_id_print)
	end if
	




end subroutine

public function string togli_pl_barcode (ref st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Toglie il codice di P.L.
//=== 
//=== Input: Passare sia il BARCODE che il PL_BARCODE
//===
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
int k_rek_ok=0
string k_codice
st_tab_pl_barcode kst_tab_pl_barcode



	k_codice = trim(kst_tab_barcode.barcode)

	select data_chiuso
	   into :kst_tab_pl_barcode.data_chiuso
	   from pl_barcode
		where codice = :kst_tab_barcode.pl_barcode 
		using sqlca;
	
	if kst_tab_pl_barcode.data_chiuso > date(0) then

		k_rek_ok = 1

		messagebox("Operazione non possibile",&
			"P.L. già chiuso in data " + string(kst_tab_pl_barcode.data_chiuso, "dd/mm/yyyy"), &
			StopSign!) 
	else
		
		
		select data_lav_ini, data_lav_fin, data_lav_ok 
			into  :kst_tab_barcode.data_lav_ini
			     ,:kst_tab_barcode.data_lav_fin
			     ,:kst_tab_barcode.data_lav_ok
			from barcode
			where barcode = :k_codice
			using sqlca;
		
		choose case true

			case  &
	   	     kst_tab_barcode.data_lav_ok > date(0) 

				k_rek_ok = 1
				  
				messagebox("Operazione non possibile",&
					"BARCODE già esitato il " + string(kst_tab_barcode.data_lav_ok, "dd/mm/yyyy")  &
					+ " pronto per la spedizione", &
					StopSign!) 
				
			case  &
	   	     kst_tab_barcode.data_lav_fin > date(0) 

				k_rek_ok = 1
				  
				messagebox("Operazione non possibile",&
					"BARCODE già trattato, lavorazione conclusa il " + string(kst_tab_barcode.data_lav_fin, "dd/mm/yyyy"),  &
					StopSign!) 
				
			case  &
	   	     kst_tab_barcode.data_lav_fin > date(0) 
				  
				k_rek_ok = 1

				messagebox("Operazione non possibile",&
					"BARCODE in lavorazione dal " + string(kst_tab_barcode.data_lav_ini, "dd/mm/yyyy"),  &
					StopSign!) 
				
		end choose

	end if

	
	if k_rek_ok = 0 then

		update barcode 
		   set 
				pl_barcode = 0, 
				data_lav_ini = date(0)
			where barcode = :k_codice
			using sqlca;
			
		if sqlca.sqlcode = 0 then
			commit using sqlca;
		else
			k_return = "1" + SQLCA.SQLErrText
		end if
		
	else	

		k_return = "2" + "Operazione non eseguita, errore gestito" 

	end if



return k_return
end function

public function string togli_pl_barcode_all (ref st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Toglie il codice di P.L.
//=== 
//=== Input: Passare sia il BARCODE che il PL_BARCODE
//===
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
int k_rek_ok=0
long k_codice
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_barcode kst1_tab_barcode 



	k_codice = kst_tab_barcode.pl_barcode

	select data_chiuso
	   into :kst_tab_pl_barcode.data_chiuso
	   from pl_barcode
		where codice = :kst_tab_barcode.pl_barcode 
		using sqlca;
	
	if kst_tab_pl_barcode.data_chiuso > date(0) then

		k_rek_ok = 1

		messagebox("Operazione non possibile",&
			"P.L. già chiuso in data " + string(kst_tab_pl_barcode.data_chiuso, "dd/mm/yyyy"), &
			StopSign!) 
	else
		
		
		select distinct data_lav_ini, data_lav_fin, data_lav_ok 
			into  :kst_tab_barcode.data_lav_ini
			     ,:kst_tab_barcode.data_lav_fin
			     ,:kst_tab_barcode.data_lav_ok
			from barcode
			where pl_barcode = :k_codice
			using sqlca;
		
		choose case true

			case &
	   	     kst_tab_barcode.data_lav_ok > date(0) 

				k_rek_ok = 1
				  
				messagebox("Operazione non possibile",&
					"BARCODE già esitati il " + string(kst_tab_barcode.data_lav_ok, "dd/mm/yyyy")  &
					+ " pronti per la spedizione", &
					StopSign!) 
				
			case  &
	   	     kst_tab_barcode.data_lav_fin > date(0) 

				k_rek_ok = 1
				  
				messagebox("Operazione non possibile",&
					"BARCODE già trattati, lavorazione conclusa il " + string(kst_tab_barcode.data_lav_fin, "dd/mm/yyyy"),  &
					StopSign!) 
				
			case  &
	   	     kst_tab_barcode.data_lav_ini > date(0) 
				  
				k_rek_ok = 1

				messagebox("Operazione non possibile",&
					"BARCODE in lavorazione dal " + string(kst_tab_barcode.data_lav_ini, "dd/mm/yyyy"),  &
					StopSign!) 
				
		end choose

	end if

	
	if k_rek_ok = 0 then

		kst1_tab_barcode.data_lav_ini = date(0)
		update barcode 
		   set 
				pl_barcode = 0, 
				data_lav_ini = :kst1_tab_barcode.data_lav_ini

			where pl_barcode = :k_codice
			using sqlca;
			
		if sqlca.sqlcode = 0 then
			commit using sqlca;
		else
			k_return = "1" + SQLCA.SQLErrText
		end if
		
	else	

		k_return = "2" + "Operazione non eseguita, errore gestito" 

	end if



return k_return
end function

public function st_esito togli_pl_barcode_chiuso (st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Toglie il codice di P.L. da BARCODE gia' chiusi
//=== 
//=== Input: Passare il PL_BARCODE
//===
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 1=Non trovato 
//===                                     2=Errore Grave
//===                                     3=altro errore
//====================================================================
//
st_esito kst_esito
st_tab_armo kst_tab_armo
//st_tab_barcode kst_tab_barcode
kuf_armo kuf1_armo



	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	
	kst_tab_barcode.ora_lav_ini = time("00:00")

//			pl_barcode = 0 
//			,groupage = " "

	update barcode 
		set 
			lav_fila_1 = 0
			,lav_fila_2 = 0
			,lav_fila_1p = 0
			,lav_fila_2p = 0
			,data_lav_ini = date(0)
			,ora_lav_ini = :kst_tab_barcode.ora_lav_ini
			,data_lav_fin = date(0)
			,ora_lav_fin = :kst_tab_barcode.ora_lav_ini
			,data_lav_ok = date(0)
			,note_lav_fin = " "
			,err_lav_fin = " "
		where pl_barcode = :kst_tab_barcode.pl_barcode
		using sqlca;
		

	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(SQLCA.SQLErrText)
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

public function st_esito select_barcode (ref st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Select rek Barcode
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//=== 
//====================================================================
//

string k_return = "0 "
st_esito kst_esito


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	select 
	       	 data,
	       	 barcode_lav,
			 id_armo,
			 pl_barcode,
			 groupage,
			 pl_barcode_progr,
			 num_int,
			 data_int,
			 data_stampa,
			 data_lav_ini,
			 data_lav_fin,
			 data_lav_ok,
			 data_sosp,
			 tipo_cicli,
			 fila_1,
			 fila_2,
			 fila_1p,
			 fila_2p,
			 posizione,
			 bilancella,
			 id_meca,
			 ora_lav_ini,
			 ora_lav_fin,
			 lav_fila_1,
			 lav_fila_2,
			 lav_fila_1p,
			 lav_fila_2p,
			 err_lav_fin,
			 err_lav_ok,
			 x_datins,
			 x_utente
		into
	          :kst_tab_barcode.data,
	          :kst_tab_barcode.barcode_lav,
			 :kst_tab_barcode.id_armo,
			 :kst_tab_barcode.pl_barcode,
			 :kst_tab_barcode.groupage,
			 :kst_tab_barcode.pl_barcode_progr,
			 :kst_tab_barcode.num_int,
			 :kst_tab_barcode.data_int,
			 :kst_tab_barcode.data_stampa,
			 :kst_tab_barcode.data_lav_ini,
			 :kst_tab_barcode.data_lav_fin,
			 :kst_tab_barcode.data_lav_ok,
			 :kst_tab_barcode.data_sosp,
			 :kst_tab_barcode.tipo_cicli,
			 :kst_tab_barcode.fila_1,
			 :kst_tab_barcode.fila_2,
			 :kst_tab_barcode.fila_1p,
			 :kst_tab_barcode.fila_2p,
			 :kst_tab_barcode.posizione,
			 :kst_tab_barcode.bilancella,
			 :kst_tab_barcode.id_meca,
			 :kst_tab_barcode.ora_lav_ini,
			 :kst_tab_barcode.ora_lav_fin,
			 :kst_tab_barcode.lav_fila_1,
			 :kst_tab_barcode.lav_fila_2,
			 :kst_tab_barcode.lav_fila_1p,
			 :kst_tab_barcode.lav_fila_2p,
			 :kst_tab_barcode.err_lav_fin,
			 :kst_tab_barcode.err_lav_ok,
			 :kst_tab_barcode.x_datins,
			 :kst_tab_barcode.x_utente
		from barcode
		where barcode = :kst_tab_barcode.barcode
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito_not_fnd
		else
			kst_esito.esito = kkg_esito_db_ko
		end if
	end if


return kst_esito
end function

public function st_esito tb_prendi_campo (ref st_tab_barcode kst_tab_barcode, string k_campo);//
//====================================================================
//=== Prende un campo del rek Barcode
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//====================================================================

st_esito kst_esito 
kuf_base kuf1_base



	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if not isnull(k_campo) &
		and LenA(trim(k_campo)) > 0 then

		kst_tab_barcode.x_datins = datetime(today())
		kst_tab_barcode.x_utente = "Pwd:"+trim(string(kg_pwd, "##0"))

		choose case k_campo


			case "fila_1_e_fila_2"
				
				select sl_pt.tipo_cicli,
				       sl_pt.fila_1, 
						 sl_pt.fila_2,
				       sl_pt.fila_1p, 
						 sl_pt.fila_2p
					into :kst_tab_barcode.tipo_cicli,
					     :kst_tab_barcode.fila_1,
						  :kst_tab_barcode.fila_2,
					     :kst_tab_barcode.fila_1p,
						  :kst_tab_barcode.fila_2p
					from (barcode inner join armo on
						  barcode.id_armo = armo.id_armo)
						  inner join sl_pt on
						  armo.cod_sl_pt = sl_pt.cod_sl_pt
					where barcode.barcode = :kst_tab_barcode.barcode;
						
				if sqlca.sqlcode <> 0 then
					kst_esito.esito = "1"
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.sqlerrtext = "SL-PT del Barcode " + trim(kst_tab_barcode.barcode) &
					            + " non trovato (Errore=" &
								  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
				else													  

					if isnull(kst_tab_barcode.tipo_cicli) then
						kst_tab_barcode.tipo_cicli = " "
					end if
					if isnull(kst_tab_barcode.fila_1) then
						kst_tab_barcode.fila_1 = 0
					end if
					if isnull(kst_tab_barcode.fila_1p) then
						kst_tab_barcode.fila_1p = 0
					end if
					if isnull(kst_tab_barcode.fila_2) then
						kst_tab_barcode.fila_2 = 0
					end if
					if isnull(kst_tab_barcode.fila_2p) then
						kst_tab_barcode.fila_2p = 0
					end if
						
				end if
				
				
//			case "conta_groupage_id_armo"
			case "conta_barcode_pl_id_armo"
				
				kst_tab_barcode.contati = 0
				select count(*) 
					into :kst_tab_barcode.contati
					from barcode 
					where (barcode.pl_barcode = :kst_tab_barcode.pl_barcode 
					       or :kst_tab_barcode.pl_barcode = 0)
					      and barcode.id_armo = :kst_tab_barcode.id_armo;
						
				if sqlca.sqlcode <> 0 then
					kst_esito.esito = "1"
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.sqlerrtext = "Piano di Lavoro " + string(kst_tab_barcode.pl_barcode) &
					           + " non trovato in tab. Barcode (Errore=" &
								  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
				end if

				if isnull(kst_tab_barcode.contati) then
					kst_tab_barcode.contati = 0
				end if

			case else 
				kst_esito.esito = "1"
				kst_esito.sqlcode = 0
				kst_esito.sqlerrtext = "Errore Interno, sbagliato parametro di programma:" + string(k_campo) 
				
		end choose


	end if

return kst_esito

end function

public function st_esito tb_update_campo (st_tab_barcode kst_tab_barcode, string k_campo);//
//====================================================================
//=== Update un campo del rek Piano Lavorazione Barcode
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//=== 
//====================================================================

st_esito kst_esito 
kuf_base kuf1_base



	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 

	if not isnull(k_campo) &
		and LenA(trim(k_campo)) > 0 then
	
		kst_tab_barcode.x_datins = kuf1_data_base.prendi_x_datins()
		kst_tab_barcode.x_utente = kuf1_data_base.prendi_x_utente()

		choose case k_campo
				
			case "data_lav_ini"
				
				if isnull(kst_tab_barcode.lav_fila_1) then
					kst_tab_barcode.lav_fila_1 = 0
				end if
				if isnull(kst_tab_barcode.lav_fila_2) then
					kst_tab_barcode.lav_fila_2 = 0
				end if
				if isnull(kst_tab_barcode.lav_fila_1p) then
					kst_tab_barcode.lav_fila_1p = 0
				end if
				if isnull(kst_tab_barcode.lav_fila_2p) then
					kst_tab_barcode.lav_fila_2p = 0
				end if
				if isnull(kst_tab_barcode.posizione) then
					kst_tab_barcode.posizione = " "
				end if
				if isnull(kst_tab_barcode.bilancella) then
					kst_tab_barcode.bilancella = 0
				end if
				if isnull(kst_tab_barcode.ora_lav_ini) then
					kst_tab_barcode.ora_lav_ini = time("00:00")
				end if
				
				update barcode set 	 
						 lav_fila_1 = :kst_tab_barcode.lav_fila_1,
						 lav_fila_2 = :kst_tab_barcode.lav_fila_2,
						 lav_fila_1p = :kst_tab_barcode.lav_fila_1p,
						 lav_fila_2p = :kst_tab_barcode.lav_fila_2p,
						 ora_lav_ini = :kst_tab_barcode.ora_lav_ini,
						 data_lav_ini = :kst_tab_barcode.data_lav_ini,
						 err_lav_fin  = :kst_tab_barcode.err_lav_fin,
						 posizione = :kst_tab_barcode.posizione,
						 bilancella = :kst_tab_barcode.bilancella,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using sqlca;

	
//					update barcode set 	 
//						 data_lav_ini = :kst_tab_barcode.data_lav_ini,
//						 x_datins = :kst_tab_barcode.x_datins,
//						 x_utente = :kst_tab_barcode.x_utente
//					where barcode = :kst_tab_barcode.barcode
//					using sqlca;
//				
				
//				
//			case "rifer_file_no_lav"
//				
//				if isnull(kst_tab_barcode.fila_1) then
//					kst_tab_barcode.fila_1 = 0 
//				end if
//				if isnull(kst_tab_barcode.fila_2) then
//					kst_tab_barcode.fila_2 = 0 
//				end if
//				if isnull(kst_tab_barcode.fila_1p) then
//					kst_tab_barcode.fila_1p = 0 
//				end if
//				if isnull(kst_tab_barcode.fila_2p) then
//					kst_tab_barcode.fila_2p = 0 
//				end if
//			
//				update barcode set 	 
//						 fila_1 = :kst_tab_barcode.fila_1,
//						 fila_2 = :kst_tab_barcode.fila_2,
//						 fila_1p = :kst_tab_barcode.fila_1p,
//						 fila_2p = :kst_tab_barcode.fila_2p,
//						 x_datins = :kst_tab_barcode.x_datins,
//						 x_utente = :kst_tab_barcode.x_utente
//					where num_int = :kst_tab_barcode.num_int
//					      and data_int = :kst_tab_barcode.data_int
//							and data_stampa > date(0)
//							and (data_lav_ini = date(0) or data_lav_ini is null) 
//							and (pl_barcode = 0 or pl_barcode is null) 
//					using sqlca;

//--- aggiorna giri nel barcode				
			case "barcode_update_giri"
				
				if isnull(kst_tab_barcode.tipo_cicli) then
					kst_tab_barcode.tipo_cicli = " " 
				end if
				if isnull(kst_tab_barcode.fila_1) then
					kst_tab_barcode.fila_1 = 0 
				end if
				if isnull(kst_tab_barcode.fila_2) then
					kst_tab_barcode.fila_2 = 0 
				end if
				if isnull(kst_tab_barcode.fila_1p) then
					kst_tab_barcode.fila_1p = 0 
				end if
				if isnull(kst_tab_barcode.fila_2p) then
					kst_tab_barcode.fila_2p = 0 
				end if
			
				update barcode set 	 
						 tipo_cicli = :kst_tab_barcode.tipo_cicli,
						 fila_1 = :kst_tab_barcode.fila_1,
						 fila_2 = :kst_tab_barcode.fila_2,
						 fila_1p = :kst_tab_barcode.fila_1p,
						 fila_2p = :kst_tab_barcode.fila_2p,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using sqlca;
				

			case "ripri_pl_barcode"
				
				update barcode set 	 
						 pl_barcode = 0,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using sqlca;
				
				

			case "ripri_fila_orig"
//				
					select sl_pt.tipo_cicli, 
					       sl_pt.fila_1, 
					       sl_pt.fila_2,
							 sl_pt.fila_1p, 
					       sl_pt.fila_2p
					   into 
						     :kst_tab_barcode.tipo_cicli,
						     :kst_tab_barcode.fila_1,
						     :kst_tab_barcode.fila_2,
					        :kst_tab_barcode.fila_1p,
						     :kst_tab_barcode.fila_2p
					   from (barcode inner join armo on
						     barcode.id_armo = armo.id_armo)
							  inner join sl_pt on
							  armo.cod_sl_pt = sl_pt.cod_sl_pt
					   where barcode.barcode = :kst_tab_barcode.barcode;
						
					if sqlca.sqlcode <> 0 then
						kst_esito.esito = "2"
						kst_esito.sqlerrtext = "Piano di Lavorazione (SL-PT) non trovato (Errore=" &
						           + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
					else													  
	
						if isnull(kst_tab_barcode.fila_1) then
							kst_tab_barcode.fila_1 = 0
						end if
						if isnull(kst_tab_barcode.fila_2) then
							kst_tab_barcode.fila_2 = 0
						end if
						
						update barcode set 	 
							 tipo_cicli = :kst_tab_barcode.tipo_cicli,
							 fila_1 = :kst_tab_barcode.fila_1,
							 fila_2 = :kst_tab_barcode.fila_2,
							 fila_1p = :kst_tab_barcode.fila_1p,
							 fila_2p = :kst_tab_barcode.fila_2p,
							 x_datins = :kst_tab_barcode.x_datins,
							 x_utente = :kst_tab_barcode.x_utente
						where barcode = :kst_tab_barcode.barcode
						using sqlca;
					end if
				
				
			case "data_lav_fin"
				
				update barcode set 	 
						 data_lav_fin = :kst_tab_barcode.data_lav_fin,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using sqlca;
				


			case "data_lav_ini_fin"
				
				if isnull(kst_tab_barcode.err_lav_fin) or LenA(trim(kst_tab_barcode.err_lav_fin)) = 0 then
					kst_tab_barcode.err_lav_fin = "0"
				end if
				if isnull(kst_tab_barcode.lav_fila_1) then
					kst_tab_barcode.lav_fila_1 = 0
				end if
				if isnull(kst_tab_barcode.lav_fila_2) then
					kst_tab_barcode.lav_fila_2 = 0
				end if
				if isnull(kst_tab_barcode.lav_fila_1p) then
					kst_tab_barcode.lav_fila_1p = 0
				end if
				if isnull(kst_tab_barcode.lav_fila_2p) then
					kst_tab_barcode.lav_fila_2p = 0
				end if
				if isnull(kst_tab_barcode.posizione) then
					kst_tab_barcode.posizione = " "
				end if
				if isnull(kst_tab_barcode.bilancella) then
					kst_tab_barcode.bilancella = 0
				end if
				if isnull(kst_tab_barcode.ora_lav_ini) then
					kst_tab_barcode.ora_lav_ini = time("00:00")
				end if
				if isnull(kst_tab_barcode.ora_lav_fin) then
					kst_tab_barcode.ora_lav_fin = time("00:00")
				end if
				
				update barcode set 	 
						 lav_fila_1 = :kst_tab_barcode.lav_fila_1,
						 lav_fila_2 = :kst_tab_barcode.lav_fila_2,
						 lav_fila_1p = :kst_tab_barcode.lav_fila_1p,
						 lav_fila_2p = :kst_tab_barcode.lav_fila_2p,
						 ora_lav_ini = :kst_tab_barcode.ora_lav_ini,
						 ora_lav_fin = :kst_tab_barcode.ora_lav_fin,
						 data_lav_ini = :kst_tab_barcode.data_lav_ini,
						 data_lav_fin = :kst_tab_barcode.data_lav_fin,
						 err_lav_fin  = :kst_tab_barcode.err_lav_fin,
						 note_lav_fin = :kst_tab_barcode.note_lav_fin,
						 upd_data_fin = :kst_tab_barcode.x_datins,
						 upd_utente_fin = :kst_tab_barcode.x_utente,
						 posizione = :kst_tab_barcode.posizione,
						 bilancella = :kst_tab_barcode.bilancella,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using sqlca;


//			case "data_lav_ini_fin_ok"
//				
//				if isnull(kst_tab_barcode.err_lav_fin) or len(trim(kst_tab_barcode.err_lav_fin)) = 0 then
//					kst_tab_barcode.err_lav_fin = "0"
//				end if
//				if isnull(kst_tab_barcode.err_lav_ok) or len(trim(kst_tab_barcode.err_lav_ok)) = 0 then
//					kst_tab_barcode.err_lav_ok = "0"
//				end if
//				if isnull(kst_tab_barcode.lav_fila_1) then
//					kst_tab_barcode.lav_fila_1 = 0
//				end if
//				if isnull(kst_tab_barcode.lav_fila_2) then
//					kst_tab_barcode.lav_fila_2 = 0
//				end if
//				if isnull(kst_tab_barcode.lav_fila_1p) then
//					kst_tab_barcode.lav_fila_1p = 0
//				end if
//				if isnull(kst_tab_barcode.lav_fila_2p) then
//					kst_tab_barcode.lav_fila_2p = 0
//				end if
//				if isnull(kst_tab_barcode.ora_lav_ini) then
//					kst_tab_barcode.ora_lav_ini = time("00:00")
//				end if
//				if isnull(kst_tab_barcode.ora_lav_fin) then
//					kst_tab_barcode.ora_lav_fin = time("00:00")
//				end if
//				
//				update barcode set 	 
//						 lav_fila_1 = :kst_tab_barcode.lav_fila_1,
//						 lav_fila_2 = :kst_tab_barcode.lav_fila_2,
//						 lav_fila_1p = :kst_tab_barcode.lav_fila_1p,
//						 lav_fila_2p = :kst_tab_barcode.lav_fila_2p,
//						 ora_lav_ini = :kst_tab_barcode.ora_lav_ini,
//						 ora_lav_fin = :kst_tab_barcode.ora_lav_fin,
//						 data_lav_ini = :kst_tab_barcode.data_lav_ini,
//						 data_lav_fin = :kst_tab_barcode.data_lav_fin,
//						 err_lav_fin  = :kst_tab_barcode.err_lav_fin,
//						 note_lav_fin = :kst_tab_barcode.note_lav_fin,
//						 upd_data_fin = :kst_tab_barcode.x_datins,
//						 upd_utente_fin = :kst_tab_barcode.x_utente,
//			          	 data_lav_ok  = :kst_tab_barcode.data_lav_ok,   
//						 err_lav_ok  = :kst_tab_barcode.err_lav_ok,
//						 note_lav_ok = :kst_tab_barcode.note_lav_ok,
//	                		 upd_data_ok  = :kst_tab_barcode.x_datins,   
//                   		 upd_utente_ok  = :kst_tab_barcode.x_utente,
//						 x_datins = :kst_tab_barcode.x_datins,
//						 x_utente = :kst_tab_barcode.x_utente
//					where barcode = :kst_tab_barcode.barcode
//					using sqlca;


			case "data_lav_ok_x_rif"
				
				if isnull(kst_tab_barcode.err_lav_ok) or LenA(trim(kst_tab_barcode.err_lav_ok)) = 0 then
					kst_tab_barcode.err_lav_ok = "0"
				end if
//				if isnull(kst_tab_barcode.lav_dose) then
//					kst_tab_barcode.lav_dose = 0
//				end if
//						 lav_dose = :kst_tab_barcode.lav_dose,
				
				update barcode set 	 
			          data_lav_ok  = :kst_tab_barcode.data_lav_ok,   
						 err_lav_ok  = :kst_tab_barcode.err_lav_ok,
						 note_lav_ok = :kst_tab_barcode.note_lav_ok,
	                upd_data_ok  = :kst_tab_barcode.x_datins,   
                   upd_utente_ok  = :kst_tab_barcode.x_utente,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where num_int = :kst_tab_barcode.num_int
					      and data_int = :kst_tab_barcode.data_int
					using sqlca;


////--- Inizializza il Barcode come se fosse ancora da pianificare				
//			case "ripri_da_pianificare"
//				
//				kst_tab_barcode.pl_barcode = 0
//				kst_tab_barcode.data_lav_ini = date(0)
//				kst_tab_barcode.ora_lav_ini = time(0)
//				kst_tab_barcode.data_lav_fin = date(0)
//				kst_tab_barcode.ora_lav_fin = time(0)
//				kst_tab_barcode.err_lav_fin = " "
//				kst_tab_barcode.note_lav_fin = " "
//				kst_tab_barcode.data_lav_ok = date(0)
//				kst_tab_barcode.err_lav_ok = " "
//				kst_tab_barcode.note_lav_ok = " "
//				kst_tab_barcode.upd_data_ok = datetime(0)
//				kst_tab_barcode.upd_utente_ok = " "
//				kst_tab_barcode.lav_fila_1 = 0
//				kst_tab_barcode.lav_fila_2 = 0
//				kst_tab_barcode.lav_fila_1p = 0
//				kst_tab_barcode.lav_fila_2p = 0
//				kst_tab_barcode.lav_fila_1 = 0
//				kst_tab_barcode.upd_data_fin = datetime(0)
//				kst_tab_barcode.upd_utente_fin = " "
//				kst_tab_barcode.posizione = " "
//				kst_tab_barcode.bilancella = 0
//				
//				update barcode set 	 
//						 data_lav_fin = :kst_tab_barcode.data_lav_fin,
//						 x_datins = :kst_tab_barcode.x_datins,
//						 x_utente = :kst_tab_barcode.x_utente
//					where barcode = :kst_tab_barcode.barcode
//					using sqlca;

			case else 
				kst_esito.esito = "2"
				kst_esito.sqlerrtext = "Errore Interno, sbagliato parametro di programma:" + string(k_campo) 
				
		end choose


		if kst_esito.esito = "0" then
			if sqlca.sqlcode = 0 then
				if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
					commit using sqlca;
				end if
			else
				if sqlca.sqlcode = 100 then
					kst_esito.esito = "100"
					kst_esito.sqlcode = SQLCA.sqlcode
					kst_esito.sqlerrtext = "tab.Barcode: " + trim(SQLCA.SQLErrText)
				else
					if sqlca.sqlcode <> 0 then
						kst_esito.esito = "2"
						kst_esito.sqlcode = SQLCA.sqlcode
						kst_esito.sqlerrtext = "tab.Barcode: " + trim(SQLCA.SQLErrText)
					end if
				end if
			end if
		end if

	end if





return kst_esito


end function

public function st_esito metti_pl_barcode (ref st_tab_barcode kst_tab_barcode, string k_tipo);//
//====================================================================
//=== Update rek Barcode con i dati del P.L.
//=== 
//=== Ritorna 1 char : 0=OK; 1=not found; 2=errore grave; 
//===           		: 3=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================
string k_return = "0 "
string k_barcode
st_esito kst_esito


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = " "
	kst_esito.nome_oggetto = this.classname()

	k_barcode = trim(kst_tab_barcode.barcode)
	

//	if isnull(kst_tab_barcode.groupage) or len(trim(kst_tab_barcode.groupage)) = 0 then
//		kst_tab_barcode.groupage = "N"
//	end if
	if isnull(kst_tab_barcode.pl_barcode) or kst_tab_barcode.pl_barcode = 0 then
		kst_esito.esito = "1"
		kst_esito.SQLErrText = "Errore interno. PL_barcode non corretto = <" &
							   + string(kst_tab_barcode.pl_barcode) + "> "		                  
	end if
	if isnull(kst_tab_barcode.pl_barcode_progr) or kst_tab_barcode.pl_barcode_progr = 0 then
		kst_esito.esito = "1"
		kst_esito.SQLErrText = "Errore interno. Pl_barcode_progr non corretto = <" &
							   + string(kst_tab_barcode.pl_barcode_progr) + "> "		                  
	end if
//	if isnull(kst_tab_barcode.fila_1) then
//		kst_tab_barcode.fila_1 = 0
//	end if
//	if isnull(kst_tab_barcode.fila_1p) then
//		kst_tab_barcode.fila_1p = 0
//	end if
//	if isnull(kst_tab_barcode.fila_2) then
//		kst_tab_barcode.fila_2 = 0
//	end if
//	if isnull(kst_tab_barcode.fila_2p) then
//		kst_tab_barcode.fila_2p = 0
//	end if

//			 groupage = :kst_tab_barcode.groupage,
//			 barcode_lav = :kst_tab_barcode.barcode_lav,
//			 fila_1 = :kst_tab_barcode.fila_1, 
//			 fila_2 = :kst_tab_barcode.fila_2, 
//			 fila_1p = :kst_tab_barcode.fila_1p, 
//			 fila_2p = :kst_tab_barcode.fila_2p, 

	if kst_esito.esito = "0" then
	
		update barcode set
			 pl_barcode = :kst_tab_barcode.pl_barcode,
			 pl_barcode_progr = :kst_tab_barcode.pl_barcode_progr,
			 x_datins = :kst_tab_barcode.x_datins,
			 x_utente = :kst_tab_barcode.x_utente
		where barcode = :k_barcode
		using sqlca;
	
		if sqlca.sqlcode <> 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
			if sqlca.sqlcode > 0 then
				if sqlca.sqlcode = 100 then
					kst_esito.esito = kkg_esito_not_fnd
				else
					kst_esito.esito = kkg_esito_db_wrn
				end if
			else
				kst_esito.esito = kkg_esito_db_ko
			end if
		else
			kst_esito.esito = kkg_esito_ok
		end if
	end if


return kst_esito

end function

public function st_esito kicursor_barcode_1_close ();//
//====================================================================
//=== Open del cursore kicursor_barcode_no_pl e restituzione dei dati 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//=== 
//====================================================================
//
st_esito kst_esito 


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	close kicursor_barcode_1;

	if sqlca.sqlcode > 0 then
		kst_esito.esito = "1"
		kst_esito.sqlcode = SQLCA.sqlcode
		kst_esito.sqlerrtext = "tab.Barcode (cursore 'barcode_pl_no'): " + trim(SQLCA.SQLErrText)
	else
		if sqlca.sqlcode < 0 then
			kst_esito.esito = "2"
			kst_esito.sqlcode = SQLCA.sqlcode
			kst_esito.sqlerrtext = "tab.Barcode (cursore 'barcode_pl_no'): " + trim(SQLCA.SQLErrText)
		end if
	end if


return kst_esito

end function

public function st_esito kicursor_barcode_1_open ();//
//====================================================================
//=== Open del cursore kicursor_barcode_no_pl e restituzione dei dati 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//=== 
//====================================================================

st_esito kst_esito 
//integer k_sn=0
//int k_rek_ok=0
//string k_codice
//

	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if isnull(kist_tab_barcode.pl_barcode) then
		kist_tab_barcode.pl_barcode = 0
	end if
		
	if isnull(kist_tab_barcode.fila_1) then
		kist_tab_barcode.fila_1 = 999
	end if
	if isnull(kist_tab_barcode.fila_1p) then
		kist_tab_barcode.fila_1p = 999
	end if
	if isnull(kist_tab_barcode.fila_2) then
		kist_tab_barcode.fila_2 = 999
	end if
	if isnull(kist_tab_barcode.fila_2p) then
		kist_tab_barcode.fila_2p = 999
	end if
	
	open kicursor_barcode_1;

	if sqlca.sqlcode > 0 then
		kst_esito.esito = "1"
		kst_esito.sqlcode = SQLCA.sqlcode
		kst_esito.sqlerrtext = "tab.Barcode (cursore 'barcode_pl_no'): " + trim(SQLCA.SQLErrText)
	else
		if sqlca.sqlcode < 0 then
			kst_esito.esito = "2"
			kst_esito.sqlcode = SQLCA.sqlcode
			kst_esito.sqlerrtext = "tab.Barcode (cursore 'barcode_pl_no'): " + trim(SQLCA.SQLErrText)
		end if
	end if


return kst_esito
end function

public subroutine if_isnull (ref st_tab_barcode kst_tab_barcode);//---
//--- toglie i NULL ai campi della tabella 
//---

if isnull(kst_tab_barcode.barcode) then	kst_tab_barcode.barcode = " "
if isnull(kst_tab_barcode.fila_1) then	kst_tab_barcode.fila_1 = 0
if isnull(kst_tab_barcode.fila_1p) then	kst_tab_barcode.fila_1p = 0
if isnull(kst_tab_barcode.fila_2) then	kst_tab_barcode.fila_2 = 0
if isnull(kst_tab_barcode.fila_2p) then	kst_tab_barcode.fila_2p = 0
if isnull(kst_tab_barcode.lav_fila_1) then kst_tab_barcode.lav_fila_1 = 0
if isnull(kst_tab_barcode.lav_fila_1p) then kst_tab_barcode.lav_fila_1p = 0
if isnull(kst_tab_barcode.lav_fila_2) then kst_tab_barcode.lav_fila_2 = 0
if isnull(kst_tab_barcode.lav_fila_2p) then kst_tab_barcode.lav_fila_2p = 0
if isnull(kst_tab_barcode.note_lav_fin) then	kst_tab_barcode.note_lav_fin = " "
if isnull(kst_tab_barcode.err_lav_fin) then kst_tab_barcode.err_lav_fin = "0"
if isnull(kst_tab_barcode.data_lav_fin) then	kst_tab_barcode.data_lav_fin = date(0)

end subroutine

public function st_esito tb_delete_x_rif (ref st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Cancella i rek dalla tabella BARCODE con l'id del RIFERIMENTO
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================
boolean k_sicurezza
st_esito kst_esito
st_open_w kst_open_w
st_tab_barcode kst1_tab_barcode
kuf_sicurezza kuf1_sicurezza


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()


kst_open_w.flag_modalita = kkg_flag_modalita_cancellazione
kst_open_w.id_programma = kkg_id_programma_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_sicurezza = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza


if not k_sicurezza then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Cancellazione dei Barcode non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = "1"

else

//=== 

	
//	delete from barcode
//		where id_meca = :kst_tab_barcode.id_meca
//		using sqlca;

//--- evito la commit all'interno di ogni barcode xche' la faccio dopo sull'intero riferimento
	kst1_tab_barcode.st_tab_g_0.esegui_commit = "N"

	declare  c_tb_delete_x_rif cursor for
		select barcode from barcode
			where id_meca = :kst_tab_barcode.id_meca
			using sqlca;

//--- ciclo di cancellazione barcode x barcode
	open c_tb_delete_x_rif;
	fetch c_tb_delete_x_rif into :kst1_tab_barcode.barcode;
	do while sqlca.sqlcode = 0 and kst_esito.esito = kkg_esito_ok
	
		kst_esito = tb_delete(kst1_tab_barcode) 
	
		fetch c_tb_delete_x_rif into :kst1_tab_barcode.barcode;
	
	loop


	if kst_esito.esito = kkg_esito_db_ko then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = &
					"Errore durante la cancellazione dei Barcode (id_meca =" &
					+ string(kst_tab_barcode.id_meca, "####0") + ") " &
					+ " ~n~rErrore-tab.BARCODE:"	+ trim(sqlca.SQLErrText)
		if kst_tab_barcode.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_barcode.st_tab_g_0.esegui_commit) then
			kuf1_data_base.db_rollback_1( )
		end if
	else
		if kst_tab_barcode.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_barcode.st_tab_g_0.esegui_commit) then
			kuf1_data_base.db_commit_1( )
		end if
	end if

end if



return kst_esito
end function

public function st_esito anteprima (ref datawindow kdw_anteprima, st_tab_barcode kst_tab_barcode);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut:  
//===               datawindow su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
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
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
kuf_utility kuf1_utility


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_anteprima
kst_open_w.id_programma = kkg_id_programma_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = "100"

else

	if LenA(trim(kst_tab_barcode.barcode)) > 0 then

		kdw_anteprima.dataobject = "d_barcode"		
		kdw_anteprima.settransobject(sqlca)

		kuf1_utility = create kuf_utility
		kuf1_utility.u_dw_toglie_ddw(1, kdw_anteprima)
		destroy kuf1_utility

		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_barcode.barcode)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Barcode da visualizzare: ~n~r" + "nessun codice barcode indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito kicursor_barcode_1_fetch ();//
//====================================================================
//=== Open del cursore kicursor_barcode_no_pl e restituzione dei dati 
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//=== 
//====================================================================
//
st_esito kst_esito 


	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	fetch kicursor_barcode_1 into :kist_tab_barcode.barcode, :kist_tab_barcode.pl_barcode;

	if sqlca.sqlcode > 0 then
		kst_esito.esito = "1"
		kst_esito.sqlcode = SQLCA.sqlcode
		kst_esito.sqlerrtext = "tab.Barcode (cursore 'barcode_pl_no'): " + trim(SQLCA.SQLErrText)
	else
		if sqlca.sqlcode < 0 then
			kst_esito.esito = "2"
			kst_esito.sqlcode = SQLCA.sqlcode
			kst_esito.sqlerrtext = "tab.Barcode (cursore 'barcode_pl_no'): " + trim(SQLCA.SQLErrText)
		end if
	end if
	if isnull(kist_tab_barcode.barcode) then kist_tab_barcode.barcode = " "
	if isnull(kist_tab_barcode.pl_barcode) then kist_tab_barcode.pl_barcode = 0


return kst_esito

end function

public function integer stampa_etichetta_riferimento (string k_barcode, long k_num_int, date k_data_int);//
// stampa dell'etichetta con il codice a barre di entrata 
// return:  numero di barcode stampati 0=nessuno
//
int k_rc=0
string k_nessuna_elab="N"
string k_path_risorse, k_barcode_x
int k_barcode_altezza=0, k_barcode_coord_x, k_barcode_coord_y
int k_barcode_tot_lotto, k_conta_barcode=0, k_barcode_gia_stampati=0, k_etichette_stampate=0
int k_ctr=0, k_ctr1=0, k_ctr2=0, k_rec_mod=0
date k_dataoggi 
constant int k_num_righe_giu=5800 
constant int k_num_righe_giu_x4=4020  
constant int k_num_col_dx_x4=5450 
boolean k_monoetichetta = false
int k_num_righe = 1, k_inizio_riga=0, k_inizio_col=0
int k_num_colonne = 0
int k_font_01[3], k_font_02[3], k_font_03[3], k_font_04[3], k_font_05[3], k_font_06[3] 
int k_font_07[3], k_font_08[3], k_font_09[3]
string k_data_cript[0 to 9] = {'A','T','E','L','O','R','I','N','U','S'}
string k_consegna_data_cript
pointer kpointer  // Declares a pointer variable
kuf_base kuf1_base
st_tab_barcode kst_tab_barcode
st_tab_meca kst_tab_meca
st_tab_clienti kst_tab_clienti
st_tab_sl_pt kst_tab_sl_pt
st_tab_armo kst_tab_armo
st_tab_pl_barcode kst_tab_pl_barcode
st_tab_contratti kst_tab_contratti
st_tab_prodotti kst_tab_prodotti
st_tab_base kst_tab_base


declare kc_listview cursor for
	SELECT 
         barcode.barcode,
         barcode.barcode_lav,
			barcode.data,
			barcode.pl_barcode,
         barcode.num_int,   
         barcode.data_int,   
         barcode.data_stampa,
			barcode.data_lav_ini,
			barcode.data_lav_fin,
			barcode.data_lav_ok,
			barcode.data_sosp,
         meca.clie_2, 
         meca.clie_3, 
			meca.num_bolla_in,
			meca.data_bolla_in,
			meca.area_mag,
			meca.consegna_data,
			meca.contratto,
			contratti.mc_co,
			contratti.sc_cf,
			contratti.descr,
			contratti.et_bcode_st_dt_rif,
         c2.rag_soc_10,
         c3.rag_soc_10,
			armo.dose,
			armo.larg_2,
			armo.lung_2,
			armo.alt_2,
			armo.peso_kg,
			sl_pt.cod_sl_pt,
			sl_pt.descr,
			prodotti.normative
    FROM ((((((barcode LEFT OUTER JOIN meca ON 
	       barcode.num_int = meca.num_int and barcode.data_int = meca.data_int)
			 LEFT OUTER JOIN clienti c2 ON 
			 meca.clie_2 = c2.codice)
			 LEFT OUTER JOIN clienti c3 ON 
			 meca.clie_3 = c3.codice)
			 LEFT OUTER JOIN contratti ON 
			 meca.contratto = contratti.codice)
			 LEFT OUTER JOIN armo ON 
			 barcode.id_armo = armo.id_armo)
			 LEFT OUTER JOIN sl_pt ON 
			 armo.cod_sl_pt = sl_pt.cod_sl_pt
			 LEFT OUTER JOIN prodotti ON 
			 armo.art = prodotti.codice)
    WHERE 
	       barcode.num_int = :k_num_int and barcode.data_int = :k_data_int
			 and barcode.barcode like :k_barcode
	 order by
		 barcode.barcode;


	declare kc_barcode_conta cursor  for
		SELECT barcode.barcode 
			FROM barcode 
		WHERE barcode.num_int = :k_num_int and barcode.data_int = :k_data_int
		order by barcode.barcode using sqlca;



//=== Puntatore Cursore da attesa.....
	kpointer = SetPointer(HourGlass!)


	kuf1_base = create kuf_base

	k_conta_barcode = 0
	k_barcode_gia_stampati = 0
	k_barcode_tot_lotto = 0
	k_etichette_stampate=0

//
//=== Controlla se funzione Autorizzata o meno 
//
	if not ki_stampa_etichetta_autorizza then 
		
		stampa_etichetta_riferimento_autorizza()
		
	end if
	
	if ki_stampa_etichetta_autorizza then

		if isnull(k_barcode) then
			k_barcode = " "
		end if
		
		k_dataoggi = date(MidA(kuf1_base.prendi_dato_base("dataoggi"),2))
	
	
		SELECT count(*)
			into :k_barcode_gia_stampati  
		 FROM barcode 
		 WHERE 
				 barcode.num_int = :k_num_int 
				 and barcode.data_int = :k_data_int 
				 and barcode.data_stampa > date(0)  
				 and (barcode = :k_barcode  or :k_barcode = ' ')
 		   using sqlca;
		if sqlca.sqlcode <> 0 then
			k_barcode_gia_stampati = 0
		end if
	
//--- conto il numero totale di barcode da esporre in etichetta	
		SELECT count(*)
			into :k_barcode_tot_lotto  
		 FROM barcode 
		 WHERE 
				 barcode.num_int = :k_num_int 
				 and barcode.data_int = :k_data_int 
		 using sqlca;


//--- Stampa dell'intero riferimento ?
		k_barcode = trim(k_barcode)
		if LenA(k_barcode) = 0  then
			k_barcode = "%"
		else
//--- se ho richiesto solo la stampa di 1 barcode... faccio solo quella				
//---  e ricavo il numero del barcode in cui sono x fare stampa: n di nn
			open kc_barcode_conta;
			if sqlca.sqlcode = 0 then
				
				do 
					k_conta_barcode++
					fetch kc_barcode_conta into :k_barcode_x;
				loop while trim(k_barcode_x) <> k_barcode and sqlca.sqlcode = 0
				
				close kc_barcode_conta;
				
			end if
			
		end if

				 
	end if

//--- se query ok e funzione Abilitata
	if sqlca.sqlcode = 0 and ki_stampa_etichetta_autorizza then

//
//--- individuo il tipo modulo x etichette codici a barre da stampare (2 o 4 o ... etich x modulo)
		kst_tab_base.barcode_modulo = trim(MidA(kuf1_base.prendi_dato_base( "barcode_modulo"),2))

		open kc_listview;
		
		if sqlca.sqlcode = 0 then

			if ki_id_print_etichette = 0 then   // se streamer stampa non ancora open...
				k_monoetichetta = true
				stampa_etichetta_riferimento_open()
			end if

			if ki_id_print_etichette = 0 then   // se streamer stampa non open...
				k_nessuna_elab = "S"
			end if
				

			if	k_nessuna_elab <> "S" then
	
				k_font_01 [1] = 1 ; k_font_01 [2] = -06 ; k_font_01 [3] = 400  
				k_font_02 [1] = 2 ; k_font_02 [2] = -12 ; k_font_02 [3] = 400 
				k_font_03 [1] = 3 ; k_font_03 [2] = -16 ; k_font_03 [3] = 700 
				k_font_04 [1] = 4 ; k_font_04 [2] = -26 ; k_font_04 [3] = 400
				k_font_05 [1] = 5 ; k_font_05 [2] = -40 ; k_font_05 [3] = 700
				k_font_06 [1] = 6 ; k_font_06 [2] = -32 ; k_font_06 [3] = 700  //400=nrmal,700=bold
				k_font_07 [1] = 7 ; k_font_07 [2] = -86 ; k_font_07 [3] = 700   
				k_font_08 [1] = 8 ; k_font_08 [2] = -110 ; k_font_08 [3] = 600
				k_font_09 [1] = 9 ; k_font_09 [2] = -10 ; k_font_09 [3] = 400  
			
				if trim(kst_tab_base.barcode_modulo) = "4" then
		
					k_barcode_coord_x = (2.0 / 2.54) * 520   //--- (Xcm / coeff di conv x pollici) * migliaia
					k_barcode_coord_y = (7.0 / 2.54) * 580   //--- (Xcm / coeff di conv x pollici) * migliaia
	//				k_barcode_altezza = 1400 
					k_barcode_altezza = (0.6 / 2.54) * 1200   //--- (Xcm / coeff di conv x pollici) * migliaia
				
//--- definizione di un font per la stampa di stringhe MASSIMO 8
					PrintDefineFont(ki_id_print_etichette, k_font_01[1], "Arial", k_font_01[2], k_font_01[3], Fixed!, Modern!, FALSE, FALSE) //piccolissimo
					PrintDefineFont(ki_id_print_etichette, k_font_02[1], "Arial", k_font_02[2], k_font_02[3], Fixed!, Modern!, FALSE, FALSE)
					PrintDefineFont(ki_id_print_etichette, k_font_03[1], "Arial", k_font_03[2], k_font_03[3], Fixed!, Modern!, FALSE, FALSE)
					PrintDefineFont(ki_id_print_etichette, k_font_04[1], "Arial", k_font_04[2], k_font_04[3], Fixed!, Modern!, FALSE, FALSE) //grande
					PrintDefineFont(ki_id_print_etichette, k_font_05[1], "Arial", k_font_05[2], k_font_05[3], Fixed!, Modern!, FALSE, FALSE)
					PrintDefineFont(ki_id_print_etichette, k_font_06[1], "Arial", k_font_06[2], k_font_06[3], Fixed!, Modern!, FALSE, FALSE)
					PrintDefineFont(ki_id_print_etichette, k_font_07[1], "Arial", k_font_07[2], k_font_07[3], Fixed!, Modern!, FALSE, FALSE)
					PrintDefineFont(ki_id_print_etichette, k_font_08[1], "Arial", k_font_08[2], k_font_08[3], Fixed!, Modern!, FALSE, FALSE) //molto grande tipo barcode
					PrintDefineFont(ki_id_print_etichette, k_font_09[1], "Arial", k_font_09[2], k_font_09[3], Fixed!, Modern!, FALSE, FALSE)
						
				else		
	
					k_barcode_coord_x = (2.0 / 2.54) * 1000   //--- (Xcm / coeff di conv x pollici) * migliaia
					k_barcode_coord_y = (7.0 / 2.54) * 1000   //--- (Xcm / coeff di conv x pollici) * migliaia
					k_barcode_altezza = (0.6 / 2.54) * 1000   //--- (Xcm / coeff di conv x pollici) * migliaia
		
//--- definizione di un font per la stampa di stringhe
					PrintDefineFont(ki_id_print_etichette, k_font_01[1], "Arial", k_font_01[2], k_font_01[3], Fixed!, Modern!, FALSE, FALSE)
					PrintDefineFont(ki_id_print_etichette, k_font_02[1], "Arial", k_font_02[2], k_font_02[3], Fixed!, Modern!, FALSE, FALSE)
					PrintDefineFont(ki_id_print_etichette, k_font_03[1], "Arial", k_font_03[2], k_font_03[3], Fixed!, Modern!, FALSE, FALSE)
					PrintDefineFont(ki_id_print_etichette, k_font_04[1], "Arial", k_font_04[2], k_font_04[3], Fixed!, Modern!, FALSE, FALSE)
					PrintDefineFont(ki_id_print_etichette, k_font_05[1], "Arial", k_font_05[2], k_font_05[3], Fixed!, Modern!, FALSE, FALSE)
					PrintDefineFont(ki_id_print_etichette, k_font_06[1], "Arial", k_font_06[2], k_font_06[3], Fixed!, Modern!, FALSE, FALSE)
					PrintDefineFont(ki_id_print_etichette, k_font_07[1], "Arial", k_font_07[2], k_font_07[3], Fixed!, Modern!, FALSE, FALSE)
					PrintDefineFont(ki_id_print_etichette, k_font_08[1], "Arial", k_font_08[2], k_font_08[3], Fixed!, Modern!, FALSE, FALSE)
					PrintDefineFont(ki_id_print_etichette, k_font_09[1], "Arial", k_font_09[2], k_font_09[3], Fixed!, Modern!, FALSE, FALSE)

				end if

	
				k_path_risorse = trim(kuf1_data_base.profilestring_leggi_scrivi(1, "arch_graf", " "))
	
//--- prima lettura fuori ciclo	
				fetch kc_listview 
					into
						  :kst_tab_barcode.barcode
						 ,:kst_tab_barcode.barcode_lav
						 ,:kst_tab_barcode.data
						 ,:kst_tab_barcode.pl_barcode 
						 ,:kst_tab_barcode.num_int   
						 ,:kst_tab_barcode.data_int   
						 ,:kst_tab_barcode.data_stampa   
						 ,:kst_tab_barcode.data_lav_ini 
						 ,:kst_tab_barcode.data_lav_fin 
						 ,:kst_tab_barcode.data_lav_ok 
						 ,:kst_tab_barcode.data_sosp 
						 ,:kst_tab_meca.clie_2  
						 ,:kst_tab_meca.clie_3  
						 ,:kst_tab_meca.num_bolla_in 
						 ,:kst_tab_meca.data_bolla_in 
						 ,:kst_tab_meca.area_mag
 						 ,:kst_tab_meca.consegna_data
						 ,:kst_tab_contratti.codice
						 ,:kst_tab_contratti.mc_co
						 ,:kst_tab_contratti.sc_cf
						 ,:kst_tab_contratti.descr
 						 ,:kst_tab_contratti.et_bcode_st_dt_rif
						 ,:kst_tab_clienti.rag_soc_10 
						 ,:kst_tab_clienti.rag_soc_20 
						 ,:kst_tab_armo.dose 
						 ,:kst_tab_armo.larg_2
						 ,:kst_tab_armo.lung_2
						 ,:kst_tab_armo.alt_2
						 ,:kst_tab_armo.peso_kg
						 ,:kst_tab_sl_pt.cod_sl_pt 
						 ,:kst_tab_sl_pt.descr 
						 ,:kst_tab_prodotti.normative
						  ;
		
//--- salvo il nr. rif xche' al cambio devo fare il salto pagina (ordinato in ottobre/2006) SE PRIMA VOLTA
				if isnull(kist_tab_barcode_stampa_save.num_int) or kist_tab_barcode_stampa_save.num_int = 0 then
					kist_tab_barcode_stampa_save.num_int = kst_tab_barcode.num_int	
				end if
		
//------------------------------------------------------------------------------------------------------------------------------------ CICLO LETTURE
				do while sqlca.sqlcode = 0 and k_nessuna_elab <> "S"

//--- contatore delle etichette stampate
					k_etichette_stampate++
				
//--- se ho richiesto la stampa di tutti i barcode
					if k_barcode = "%"  then
						k_conta_barcode++
					end if
				
//--- "cripto" la data di consegna
					k_consegna_data_cript = ""
              		if kst_tab_meca.consegna_data > date(0) then
						k_consegna_data_cript = string(kst_tab_meca.consegna_data, "ddmmyy")
						k_consegna_data_cript = k_data_cript[integer(MidA(k_consegna_data_cript,1,1))] &
	                                       + k_data_cript[integer(MidA(k_consegna_data_cript,2,1))] & 					
														+ "." &
	                                       + k_data_cript[integer(MidA(k_consegna_data_cript,3,1))] & 					
	                                       + k_data_cript[integer(MidA(k_consegna_data_cript,4,1))] & 					
														+ "." &
	                                       + k_data_cript[integer(MidA(k_consegna_data_cript,5,1))] & 					
	                                       + k_data_cript[integer(MidA(k_consegna_data_cript,6,1))]  					
 					end if

					ki_num_etichetta_in_pag ++
						
						
//--- MODULO A 4 ETICHETTE ------------------------------------------------------------------------------------- 
					if trim(kst_tab_base.barcode_modulo) = "4" then

						if kist_tab_barcode_stampa_save.num_int <> kst_tab_barcode.num_int	 then
							
							kist_tab_barcode_stampa_save.num_int = kst_tab_barcode.num_int	
							if ki_num_etichetta_in_pag > 1 then
//--- forzo salto pagina 			
								ki_num_etichetta_in_pag = 5
							end if
						end if

//--- Numero etichetta
						choose case ki_num_etichetta_in_pag
								
							case 1
								k_num_colonne = -300
								k_num_righe = 0
								
							case 2
								k_num_colonne = -300
								k_num_righe = k_num_righe_giu_x4
								
							case 3
								k_num_colonne = k_num_col_dx_x4
								k_num_righe = 0
								
							case 4
								k_num_colonne = k_num_col_dx_x4
								k_num_righe = k_num_righe_giu_x4
								
							case else
//--- salto pagina 
								PrintPage ( ki_id_print_etichette )
								ki_num_etichetta_in_pag = 1
								k_num_colonne = -300
								k_num_righe = 0
						end choose


// stampa il logo ad inizio foglio
						PrintBitmap(ki_id_print_etichette, k_path_risorse + "\et_bcode_x4.bmp", 300+k_num_colonne, 1+ k_num_righe, 0, 0)
						PrintBitmap(ki_id_print_etichette, k_path_risorse + "\logo.bmp", 300+k_num_colonne, 30 + k_num_righe, 2500, 500)

//--- Sezione Anagrafiche Clienti 
						k_inizio_riga = 720
						k_inizio_col = 450
						printtext (ki_id_print_etichette, "Cliente :", k_inizio_col+k_num_colonne, k_inizio_riga + k_num_righe, k_font_01[1])
						printtext (ki_id_print_etichette, "Ricevente :", k_inizio_col+k_num_colonne, k_inizio_riga +300 + k_num_righe, k_font_01[1])
						printtext (ki_id_print_etichette, string(kst_tab_meca.clie_3,"####0") , k_inizio_col+550+k_num_colonne, k_inizio_riga + k_num_righe, k_font_01[1])
						printtext (ki_id_print_etichette, string(kst_tab_meca.clie_2,"####0") , k_inizio_col+550+k_num_colonne, k_inizio_riga + 300 + k_num_righe, k_font_01[1])
						printtext (ki_id_print_etichette, trim(kst_tab_clienti.rag_soc_20) , k_inizio_col+850+k_num_colonne, k_inizio_riga - 80 + k_num_righe, k_font_03[1])
						printtext (ki_id_print_etichette, trim(kst_tab_clienti.rag_soc_10) , k_inizio_col+850+k_num_colonne, k_inizio_riga + 220 + k_num_righe, k_font_03[1])

//--- Sezione Riferimento
						k_inizio_col = 2700   //2750
						k_inizio_riga = 1480  //1500
						printtext (ki_id_print_etichette, "RIF.: ", k_inizio_col+k_num_colonne, k_inizio_riga + 100 + k_num_righe, k_font_01[1])
						printtext (ki_id_print_etichette, string(kst_tab_barcode.num_int,"####0") , k_inizio_col + 200+k_num_colonne, k_inizio_riga - 150 + k_num_righe, k_font_05[1])
 						if isnull(kst_tab_contratti.et_bcode_st_dt_rif) or kst_tab_contratti.et_bcode_st_dt_rif <> "N" then
							printtext (ki_id_print_etichette, string(kst_tab_barcode.data_int,"dd/mm/yy") , k_inizio_col+k_num_colonne, k_inizio_riga + 300+100 + k_num_righe, k_font_02[1])
						end if
	
//--- Sezione Lotto
						printtext (ki_id_print_etichette, "Lotto: ", k_inizio_col+1660+k_num_colonne, k_inizio_riga + 100 + k_num_righe, k_font_01[1])
						printtext (ki_id_print_etichette, string(k_conta_barcode,"####0") + "." + string (k_barcode_tot_lotto,"####0") &
										, k_inizio_col+1890+k_num_colonne, k_inizio_riga -150 + k_num_righe, k_font_06[1])
//										, k_inizio_col+1870+k_num_colonne, k_inizio_riga -150 + k_num_righe, k_font_05[1])
						if LenA(trim(k_consegna_data_cript)) > 0 then
							printtext (ki_id_print_etichette, trim(k_consegna_data_cript), k_inizio_col+k_num_colonne, k_inizio_riga + 770+100 + k_num_righe, k_font_02[1]) //data consegna criptata
						end if

//--- Sezione Destra MC-CC e SC.CF
						k_inizio_riga = 1550
						k_inizio_col = 3550   
						//4000
						if LenA(trim(kst_tab_contratti.mc_co)) > 0 then
							printtext (ki_id_print_etichette, "Contratto Comm.: ", k_inizio_col+k_num_colonne, k_inizio_riga + 360 + k_num_righe, k_font_01[1])
							printtext (ki_id_print_etichette, trim(kst_tab_contratti.mc_co), k_inizio_col+800+k_num_colonne, k_inizio_riga + 300 + k_num_righe, k_font_02[1])
						end if
						if LenA(trim(kst_tab_contratti.sc_cf)) > 0 then
							printtext (ki_id_print_etichette, "Capitolato di Forn.: ", k_inizio_col+k_num_colonne, k_inizio_riga + 550 + k_num_righe, k_font_01[1])
							printtext (ki_id_print_etichette, trim(kst_tab_contratti.sc_cf), k_inizio_col+800+k_num_colonne, k_inizio_riga + 490  + k_num_righe, k_font_02[1])
						end if
						if LenA(trim(kst_tab_meca.area_mag)) > 0 then
							printtext (ki_id_print_etichette, "Area di Ubicazione: ", k_inizio_col+k_num_colonne, k_inizio_riga + 800 + k_num_righe, k_font_01[1])
							printtext (ki_id_print_etichette, string(trim(kst_tab_meca.area_mag),"@ @@@@@@@@@@@"), k_inizio_col+800+k_num_colonne, k_inizio_riga + 740 + k_num_righe, k_font_02[1])
						end if
//--- Prodotto...
						k_inizio_riga = 2560
						k_inizio_col = 450
						if LenA(trim(kst_tab_prodotti.normative)) > 0 then
							printtext (ki_id_print_etichette, "Prodotto: ", k_inizio_col+k_num_colonne, k_inizio_riga +30+ k_num_righe, k_font_01[1])
							printtext (ki_id_print_etichette, trim(kst_tab_prodotti.normative), k_inizio_col+550+k_num_colonne, k_inizio_riga + k_num_righe, k_font_09[1]) //k_font_02[1])
						end if
//--- Altezza Pallet...
						k_inizio_riga = 2560
						k_inizio_col = 5130
						if kst_tab_armo.alt_2 > 100 then
							printtext (ki_id_print_etichette, "Altezza: ", k_inizio_col+k_num_colonne, k_inizio_riga +30+ k_num_righe, k_font_01[1])
							printtext (ki_id_print_etichette,  string((kst_tab_armo.alt_2 / 10),"####0"), k_inizio_col+350+k_num_colonne, k_inizio_riga + k_num_righe, k_font_09[1]) 
						end if
	
//--- Sezione BARCODE il codice, se il barcode inizia con una lettera debbo togliere lo spazio in mezzo 
						k_inizio_riga = 2730
//						printtext (ki_id_print_etichette, string(trim(kst_tab_barcode.barcode),"@@@ @@@@@"), 400, 3950 + k_num_righe, k_font_07[1])
						if isnumber(LeftA(kst_tab_barcode.barcode,1)) then
							printtext (ki_id_print_etichette, string(trim(kst_tab_barcode.barcode),"@@@ @@@@@"), 260+k_num_colonne, k_inizio_riga + k_num_righe, k_font_07[1])
						else							
							printtext (ki_id_print_etichette, string(trim(kst_tab_barcode.barcode),"@@@@@@@@"), 260+k_num_colonne, k_inizio_riga + k_num_righe, k_font_07[1])
						end if
//--- Sezione BARCODE il codice a BARRE
						stampa_barcode_f ( kst_tab_barcode.barcode, ki_id_print_etichette, (k_barcode_coord_x+k_num_colonne+50), (k_barcode_coord_y + k_num_righe), k_barcode_altezza, k_font_01[1] )
						PrintDefineFont(ki_id_print_etichette, k_font_01[1], "Arial", k_font_01[2], k_font_01[3], Fixed!, Modern!, FALSE, FALSE) //ripristino il font

						
					else		
//--- MODULO A 2 ETICHETTE ------------------------------------------------------------------------------------- 

						if ki_num_etichetta_in_pag = 2 then
							k_num_righe = k_num_righe_giu
						else
							k_num_righe = 0
//--- salto pagina 
							if ki_num_etichetta_in_pag > 2 then
								PrintPage ( ki_id_print_etichette )
								ki_num_etichetta_in_pag = 1
							end if
						end if
					
					
// stampa il logo ad inizio foglio
						PrintBitmap(ki_id_print_etichette, k_path_risorse + "\et_bcode.bmp", 300, 1 + k_num_righe, 7800, 5750)
						PrintBitmap(ki_id_print_etichette, k_path_risorse + "\logo.bmp", 300, 1 + k_num_righe, 0, 0)


//--- Sezione Anagrafiche Clienti 
						printtext (ki_id_print_etichette, "Cliente :", 450, 1200 + k_num_righe, k_font_02[1])
						printtext (ki_id_print_etichette, "Ricevente :", 450, 1800 + k_num_righe, k_font_02[1])
						printtext (ki_id_print_etichette, string(kst_tab_meca.clie_3,"####0") , 1600, 1200 + k_num_righe, k_font_02[1])
						printtext (ki_id_print_etichette, string(kst_tab_meca.clie_2,"####0") , 1600, 1800 + k_num_righe, k_font_02[1])
						printtext (ki_id_print_etichette, trim(kst_tab_clienti.rag_soc_20) , 2050, 1050 + k_num_righe, k_font_04[1])
						printtext (ki_id_print_etichette, trim(kst_tab_clienti.rag_soc_10) , 2050, 1650 + k_num_righe, k_font_04[1])
	
//--- Sezione Sinistra Riferimento
						printtext (ki_id_print_etichette, "RIF: ", 450 - 50, 2400 - 20  + k_num_righe, k_font_02[1])
						printtext (ki_id_print_etichette, string(kst_tab_barcode.num_int,"####0") , 1800 - 800, 2300 + k_num_righe - 80, k_font_05[1])
						if isnull(kst_tab_contratti.et_bcode_st_dt_rif) or kst_tab_contratti.et_bcode_st_dt_rif <> "N" then
							printtext (ki_id_print_etichette, string(kst_tab_barcode.data_int,"dd/mm/yy") , 2950 - 600, 2400 + k_num_righe, k_font_03[1])
						end if

//--- Sezione Lotto
						printtext (ki_id_print_etichette, "Lotto: ", 400, 3650 + k_num_righe, k_font_02[1])
						printtext (ki_id_print_etichette, string(k_conta_barcode,"####0") + "." 	+ string (k_barcode_tot_lotto,"####0") &
									, 920, 3450 + k_num_righe, k_font_06[1])
//									, 920, 3450 + k_num_righe, k_font_05[1])
						if LenA(trim(k_consegna_data_cript)) > 0 then
							printtext (ki_id_print_etichette, trim(k_consegna_data_cript), 3150 - 600, 3650 + k_num_righe, k_font_02[1]) //data consegna criptata
						end if

//--- Sezione Destra MC-CC e SC.CF
						k_inizio_col = 3550   
						if LenA(trim(kst_tab_contratti.mc_co)) > 0 then
							printtext (ki_id_print_etichette, "Contratto Commerciale: ", k_inizio_col +150, 2350 + k_num_righe, k_font_02[1])
							printtext (ki_id_print_etichette, trim(kst_tab_contratti.mc_co), k_inizio_col +2050, 2300 + k_num_righe, k_font_03[1])
						end if
						if LenA(trim(kst_tab_contratti.sc_cf)) > 0 then
							printtext (ki_id_print_etichette, "Capitolato di Fornitura: ", k_inizio_col+150, 2650 + k_num_righe, k_font_02[1])
							printtext (ki_id_print_etichette, trim(kst_tab_contratti.sc_cf), k_inizio_col+2050, 2600 + k_num_righe, k_font_03[1])
						end if
						if LenA(trim(kst_tab_prodotti.normative)) > 0 then
							printtext (ki_id_print_etichette, "Prodotto: ", k_inizio_col+150, 2950 + k_num_righe, k_font_02[1])
							printtext (ki_id_print_etichette, trim(kst_tab_prodotti.normative), k_inizio_col+900, 2950 + k_num_righe, k_font_09[1]) //k_font_03[1])
						end if
						if LenA(trim(kst_tab_meca.area_mag)) > 0 then
							printtext (ki_id_print_etichette, "Area di Ubicazione: ", k_inizio_col+150, 3250 + k_num_righe, k_font_02[1])
							printtext (ki_id_print_etichette, string(trim(kst_tab_meca.area_mag),"@ @@@@@@@@@@@"), k_inizio_col+2050, 3200 + k_num_righe, k_font_03[1])
						end if
//--- Altezza Pallet...
						if kst_tab_armo.alt_2 > 100 then
							printtext (ki_id_print_etichette, "Altezza Pallet: ", k_inizio_col+150, 3550 + k_num_righe, k_font_02[1])
							printtext (ki_id_print_etichette,  string((kst_tab_armo.alt_2 / 10),"####0"), k_inizio_col+2050, 3520 + k_num_righe, k_font_03[1]) 
						end if

//--- Sezione BARCODE il codice, se il barcode inizia con una lettera debbo togliere lo spazio in mezzo 
						if isnumber(LeftA(kst_tab_barcode.barcode,1)) then
							printtext (ki_id_print_etichette, string(trim(kst_tab_barcode.barcode),"@@@ @@@@@"), 280, 3950 + k_num_righe, k_font_08[1])
						else
							printtext (ki_id_print_etichette, string(trim(kst_tab_barcode.barcode),"@@@@@@@@"), 280, 3950 + k_num_righe, k_font_08[1])
						end if

//--- Sezione BARCODE il codice a BARRE
						stampa_barcode_f ( kst_tab_barcode.barcode, ki_id_print_etichette, k_barcode_coord_x, (k_barcode_coord_y + k_num_righe), k_barcode_altezza, k_font_01 [1] )
						PrintDefineFont(ki_id_print_etichette, k_font_01[1], "Arial", k_font_01[2], k_font_01[3], Fixed!, Modern!, FALSE, FALSE) //ripristino il font
					end if
					
//--- Aggiorno data di stampa
					update barcode
						set data_stampa = :k_dataoggi
						 WHERE 
							 barcode = :kst_tab_barcode.barcode
						using sqlca;
					if sqlca.sqlcode = 0 then
						k_rec_mod++
					end if

					
				
				
				fetch kc_listview 
							into
						  :kst_tab_barcode.barcode
						 ,:kst_tab_barcode.barcode_lav
						 ,:kst_tab_barcode.data
						 ,:kst_tab_barcode.pl_barcode 
						 ,:kst_tab_barcode.num_int   
						 ,:kst_tab_barcode.data_int   
						 ,:kst_tab_barcode.data_stampa   
						 ,:kst_tab_barcode.data_lav_ini 
						 ,:kst_tab_barcode.data_lav_fin 
						 ,:kst_tab_barcode.data_lav_ok 
						 ,:kst_tab_barcode.data_sosp 
						 ,:kst_tab_meca.clie_2  
						 ,:kst_tab_meca.clie_3  
						 ,:kst_tab_meca.num_bolla_in 
						 ,:kst_tab_meca.data_bolla_in 
						 ,:kst_tab_meca.area_mag
 						 ,:kst_tab_meca.consegna_data
						 ,:kst_tab_contratti.codice
						 ,:kst_tab_contratti.mc_co
						 ,:kst_tab_contratti.sc_cf
						 ,:kst_tab_contratti.descr
 						 ,:kst_tab_contratti.et_bcode_st_dt_rif
						 ,:kst_tab_clienti.rag_soc_10 
						 ,:kst_tab_clienti.rag_soc_20 
						 ,:kst_tab_armo.dose 
						 ,:kst_tab_armo.larg_2
						 ,:kst_tab_armo.lung_2
						 ,:kst_tab_armo.alt_2
						 ,:kst_tab_armo.peso_kg
						 ,:kst_tab_sl_pt.cod_sl_pt 
						 ,:kst_tab_sl_pt.descr 
						 ,:kst_tab_prodotti.normative
						  ;
				

				loop
			
			end if

//--- Spedisce la stampa alla dispositivo e chiude la coda se sono in modalita' mono-etichetta
			if k_monoetichetta then
				stampa_etichetta_riferimento_close()
//				PrintClose(ki_id_print_etichette)
			end if
			
		end if
		
		close kc_listview;


		if k_rec_mod > 0 then
			commit using sqlca;
		end if
		
	end if

	destroy kuf1_base


	SetPointer(kpointer)
	

	return k_etichette_stampate



end function

public subroutine stampa_etichetta_riferimento_autorizza ();//
// stampa dell'etichetta: Controllo Autorizzazione alla stampa 
// return:  set ki_stampa_etichetta_autorizza
//
int k_rc=0
boolean k_abilitato=true
pointer kpointer  // Declares a pointer variable
kuf_sicurezza kuf1_sicurezza
st_open_w kst_open_w



//=== Puntatore Cursore da attesa.....
	kpointer = SetPointer(HourGlass!)

//
//=== Controlla se funzione Autorizzata o meno 
//
	kst_open_w.id_programma = "stb"
	kst_open_w.flag_modalita = kkg_flag_modalita_stampa
	
	kuf1_sicurezza = create kuf_sicurezza
	k_abilitato = kuf1_sicurezza.autorizza_funzione(kst_open_w)
	destroy kuf1_sicurezza
	
	if not k_abilitato then
		ki_stampa_etichetta_autorizza = false

		SetPointer(kpointer)
		messagebox("Accesso non Autorizzato", &
					  "La funzione richiesta non e' stata abilitata", &
					  information!)
	else
		ki_stampa_etichetta_autorizza = true
	end if

	SetPointer(kpointer)
	





end subroutine

public subroutine stampa_etichetta_riferimento_close ();//
// stampa dell'etichetta: CLOSE dello streamer di stampa
// return:  set ki_id_print_etichette a zero 
//
int k_rc=0
pointer kpointer

//=== Puntatore Cursore da attesa.....
	kpointer = SetPointer(HourGlass!)


	if ki_id_print_etichette > 0 then   // se streamer stampa non ancora open...
		if PrintClose(ki_id_print_etichette) > 0 then
			ki_id_print_etichette = 0
		end if
	end if


	SetPointer(kpointer)
	




end subroutine

public subroutine stampa_etichetta_riferimento_open ();//
// stampa dell'etichetta: Open dello streamer di stampa
// return:  set ki_id_print_etichette
//
int k_rc=0
string k_nessuna_elab="N"
string k_path_risorse, k_stampante
pointer kpointer  // Declares a pointer variable
kuf_base kuf1_base



//=== Puntatore Cursore da attesa.....
	kpointer = SetPointer(HourGlass!)

		kuf1_base = create kuf_base
		k_stampante = trim(MidA(kuf1_base.prendi_dato_base( "stamp_cbarre"),2))
		destroy kuf1_base
		if LenA(trim(k_stampante)) = 0 or isnull(k_stampante) then
			k_rc = printsetup() 
		
			if k_rc < 1 or isnull(k_rc) or k_rc = 0 then
				k_nessuna_elab = "S" 
			end if
		else		
			 
			if PrintSetPrinter (k_stampante) <= 0 then
				k_nessuna_elab = "S"
			end if
			
		end if

		if	k_nessuna_elab <> "S" then
			if ki_id_print_etichette = 0 then   // se streamer stampa non ancora open...
				ki_id_print_etichette = PrintOpen( )
				if ki_id_print_etichette < 0 then
					ki_id_print_etichette = 0
				else
					ki_num_etichetta_in_pag=0  // contatore etichette nella pagina (probabile al max 2 o 4)
				end if
			end if
		else
			ki_id_print_etichette = 0
		end if


	SetPointer(kpointer)
	




end subroutine

private subroutine stampa_barcode_f (string k_barcode, long k_id_print, integer k_coord_x, integer k_coord_y, integer k_altezza_cb, integer k_id_font);//
// stampa codice a barre standard CODE 39
// utilizza il font 
// 3OF9_NEW.TTF (3 of 9 Barcode)
//
// 1'' (inches) = 2,54 cm 
// CODE 3/9:
// lungo 13 caratteri
// ogni carattere è composto da 5 barre e 4 spazi (=9 elementi)
// ogni elemento può essere fine o grosso (narrow o wide)
// 3 dei 9 elementi deve essere wide (ecco xchè si chiama 'code 39')
// la codebar intera è composta da una zona franca di almeno 0,1'' + il carattere di 
// inizio '*' + il codice + il carattere di fine '*' + zona franca di almeno 0,1''
//

string k_open_print="N"
int k_altezza=0, k_coord_y1, k_font_alt=0 
int k_ctr=0



	if k_id_print = 0 or isnull(k_id_print) then
		k_open_print = "S"
	   k_id_print = PrintOpen( )
	end if
	
	if k_coord_x = 0 or isnull(k_coord_x) then
		k_coord_x = 100
	end if
	if k_coord_y = 0 or isnull(k_coord_y) then
		k_coord_y = 100
	end if
	if k_altezza_cb = 0 or isnull(k_altezza_cb) then
		k_font_alt = 24
	else
		k_font_alt = k_altezza_cb
	end if
	k_coord_y1 = k_coord_y 
	
	if k_id_font = 0 or isnull(k_id_font) then
		k_id_font = 1
	end if

	if LenA(trim(k_barcode)) > 0 then

//--- stringa alfanumerica dell'effettivo codice a barre riempita con spazi + uno zero a destra e il crt "*" a inizio e fine
	   k_barcode = "*" + trim(k_barcode) + "*" //fill(" ", (12 - len(trim(k_barcode)))) + "0" + "*"

//--- definizione di un font per la stampa di stringhe
		PrintDefineFont(k_id_print, k_id_font, "3 of 9 Barcode", k_font_alt, 400, Fixed!, Modern!, FALSE, FALSE)

		printtext (k_id_print, k_barcode, k_coord_x, k_coord_y1, 1)
		k_coord_y1 = k_coord_y1 + k_font_alt - 2
		printtext (k_id_print, k_barcode, k_coord_x, k_coord_y1, 1)
		k_coord_y1 = k_coord_y1 + k_font_alt - 2
		printtext (k_id_print, k_barcode, k_coord_x, k_coord_y1, 1)

	end if
	
	if k_open_print = "S" then
			PrintClose(k_id_print)
	end if
	




end subroutine

public function integer stampa_etichetta_riferimento_ristampa (string k_barcode, long k_num_int, date k_data_int);//
// stampa dell'etichetta: controllo se sono in ristampa o e' la prima volta
// return:  Numero dei BARCODE ancora da stampare 0=tutti ristampati, NEGATIVO = ERRORE SQL (sqlcode)
//
int k_rc=0
int k_barcode_da_stampare=0
pointer kpointer  // Declares a pointer variable
st_esito kst_esito 



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""

//=== Puntatore Cursore da attesa.....
	kpointer = SetPointer(HourGlass!)
	
	SELECT count(*)
		into :k_barcode_da_stampare  
	 FROM barcode 
	 WHERE 
			 barcode.num_int = :k_num_int 
			 and barcode.data_int = :k_data_int 
			 and (barcode.data_stampa <= date(0) or barcode.data_stampa is null)
			 and (barcode = :k_barcode  or :k_barcode = ' ')
			 using sqlca;

	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode > 0 then
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
			if sqlca.sqlcode = 100 then
				kst_esito.esito = kkg_esito_not_fnd
			end if
			k_barcode_da_stampare=-sqlca.sqlcode
		else
			k_barcode_da_stampare=sqlca.sqlcode
			kst_esito.esito = kkg_esito_db_ko
		end if
	else
		kst_esito.esito = kkg_esito_ok
	end if

	SetPointer(kpointer)
	

	return k_barcode_da_stampare



end function

public function st_tab_barcode get_primo_barcode_in_lav () throws uo_exception;//
//====================================================================
//=== Estrae barcode e data del piu' vecchio ancora in lavorazione (da una certa data ad oggi)  
//=== 
//=== Input: nulla
//=== Output: la struttura st_tab_barcode con la DATA_lav_ini valorizzata
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
st_tab_barcode kst_tab_barcode
string k_dataoggi_x
kuf_base kuf1_base
st_esito kst_esito


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	kuf1_base = create kuf_base
	k_dataoggi_x = MidA(kuf1_base.prendi_dato_base("dataoggi"),2)
	if isdate(k_dataoggi_x) then
		kst_tab_barcode.data_lav_ini = relativedate (date(k_dataoggi_x), -30)  //indietro di 1 mese
	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Errore in Lettura Data-oggi:  " + k_dataoggi_x
		kst_esito.esito = kkg_esito_err_formale
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

	select distinct min(barcode)
	         ,data_lav_ini
		into
	          :kst_tab_barcode.barcode,
			 :kst_tab_barcode.data_lav_ini
		from barcode
		where data_lav_ini = :kst_tab_barcode.data_lav_ini
		group by barcode.data_lav_ini
		using sqlca;


	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode > 0 then
			kst_tab_barcode.barcode = " "
			kst_tab_barcode.data_lav_ini = date(0)
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito_db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if


return kst_tab_barcode

end function

public subroutine check_anomalie_lavorazione (ref st_tab_barcode kst_tab_barcode) throws uo_exception;//
//=== Controlla dati di LAVORAZIONE 
//--- 
//--- Input: reference della struttura st_tab_barcode con i dati di trattamento valorizzati
//--- Output: struttura st_tab_barcode con i dati di esito valorizzati
//---
//--- Lancia un EXCEPTION se si verificano errore gravi
//---
//---
//--- Estrae da archivio Pilota di out
//---
//--- k_errore: 2=interrotto da utente/dati insuff 1=errore programma 
//
string k_barcode_esito="0", k_flag_esponi_gia_lavorato

st_esito kst_esito
uo_exception kuo_exception
//pointer oldpointer  // Declares a pointer variable

kuf_armo kuf1_armo
kuf_sl_pt kuf1_sl_pt

st_tab_sl_pt kst_tab_sl_pt, kst_tab_sl_pt_vuota
st_tab_armo kst_tab_armo, kst1_tab_armo, kst_tab_armo_vuota


//oldpointer = SetPointer(HourGlass!)

kuo_exception = create uo_exception

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.sqlerrtext = " "
kst_esito.nome_oggetto = this.classname()
	
	

kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kuo_exception = create uo_exception
	

//---- x default esito POSITIVO
kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ok


		
kuf1_sl_pt = create kuf_sl_pt
kuf1_armo = create kuf_armo
//kuf1_artr = create kuf_artr
//kuf1_certif = create kuf_certif

			

//--- pulizia campi di appoggio
kst_tab_sl_pt.fila_1 = 0
kst_tab_sl_pt.fila_2 = 0
kst_tab_sl_pt.fila_1p = 0
kst_tab_sl_pt.fila_2p = 0
kst_tab_barcode.note_lav_fin = ""

if kst_tab_barcode.id_armo > 0 then

//--- legge tab ARMO x prendere cod sl-pt
	kst_tab_armo = kst_tab_armo_vuota
	kst_tab_armo.id_armo = kst_tab_barcode.id_armo
	kst_esito = kuf1_armo.leggi_riga("1", kst_tab_armo)

	if kst_esito.esito = kkg_esito_ok and kst_tab_armo.num_int > 0 then

//--- legge tab ARMO x prendere totale colli del riferimento 
		kst1_tab_armo = kst_tab_armo_vuota
		kst1_tab_armo.id_armo = kst_tab_barcode.id_armo
		kst_esito = kuf1_armo.leggi_riga("R", kst1_tab_armo)
		if kst_esito.esito <> kkg_esito_ok then
			kst1_tab_armo.colli_2 = 0
		end if
						
//--- legge tab SL PT x prendere cod GIRI FILA
		if not isnull(kst_tab_armo.cod_sl_pt) and &
			LenA(trim(kst_tab_armo.cod_sl_pt)) > 0 then
			
			kst_tab_sl_pt = kst_tab_sl_pt_vuota
			kst_tab_sl_pt.cod_sl_pt = kst_tab_armo.cod_sl_pt 
			kst_esito = kuf1_sl_pt.select_riga(kst_tab_sl_pt)
			if kst_esito.esito <> kkg_esito_ok then
				kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
				kst_tab_barcode.note_lav_fin += "SL-PT non Trovato - "
//					k_barcode_esito = "2"
//					k_barcode_esito_txt = k_barcode_esito_txt + "SL-PT non Trovato - " 
			else
				
				if (kst_tab_sl_pt.fila_1 = 0 or isnull(kst_tab_sl_pt.fila_1)) &
					and (kst_tab_sl_pt.fila_2 = 0 or isnull(kst_tab_sl_pt.fila_2)) &
					and (kst_tab_sl_pt.fila_1p = 0 or isnull(kst_tab_sl_pt.fila_1p)) &
					and (kst_tab_sl_pt.fila_2p = 0 or isnull(kst_tab_sl_pt.fila_2p)) &
					then
					kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
					kst_tab_barcode.note_lav_fin +=  "Cicli Non Impostati su SL-PT - "
//									k_barcode_esito = "2"
//									k_barcode_esito_txt = k_barcode_esito_txt + "Cicli Non Impostati su SL-PT - " 
								
				end if
							
			end if
		else
			kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
			kst_tab_barcode.note_lav_fin +=  "SL-PT non Impostato in Entrata (vedi riferimento) - " 
//				k_barcode_esito = "2"
//				k_barcode_esito_txt = k_barcode_esito_txt + "SL-PT non Impostato in Entrata (vedi riferimento) - " 
			kst_tab_sl_pt.cod_sl_pt = " "
			kst_tab_sl_pt.descr = " "
		end if
	else
		kst_tab_barcode.note_lav_fin +=  "Riga Entrata merce non Trovata - " 
//			k_barcode_esito_txt = k_barcode_esito_txt + "Riga Entrata merce non Trovata - " 
	end if
else
	kst_tab_barcode.note_lav_fin +=  "Riga Entrata sconosciuta - " 
end if
	
if kst_esito.esito = kkg_esito_db_ko then // errore grave SQL
	kuo_exception.set_esito (kst_esito)
	throw kuo_exception
end if
	
//--- controllo valori dei Cicli	del PILOTA con quelli presenti sul BARCODE		
if isnull(kst_tab_barcode.fila_1) then kst_tab_barcode.fila_1 = 0  
if isnull(kst_tab_barcode.fila_2) then kst_tab_barcode.fila_2 = 0  
if isnull(kst_tab_barcode.fila_1p) then kst_tab_barcode.fila_1p = 0  
if isnull(kst_tab_barcode.fila_2p) then kst_tab_barcode.fila_2p = 0  
if isnull(kst_tab_sl_pt.fila_1) then kst_tab_sl_pt.fila_1 = 0  
if isnull(kst_tab_sl_pt.fila_2) then kst_tab_sl_pt.fila_2 = 0  
if isnull(kst_tab_sl_pt.fila_1p) then	kst_tab_sl_pt.fila_1p = 0  
if isnull(kst_tab_sl_pt.fila_2p) then kst_tab_sl_pt.fila_2p = 0  
					

//--- controllo se cicli impostati almeno sul piano di lavorazione 
if kst_tab_sl_pt.fila_1 = 0 and kst_tab_barcode.fila_1 = 0 &
	and kst_tab_sl_pt.fila_2 = 0 and kst_tab_barcode.fila_2 = 0 &
	and kst_tab_sl_pt.fila_1p = 0 and kst_tab_barcode.fila_1p = 0 &
	and kst_tab_sl_pt.fila_2p = 0 and kst_tab_barcode.fila_2p = 0 then
	kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
	kst_tab_barcode.note_lav_fin +=   "SL-PT e Pian.Lavoraz. senza Cicli - " 
//	k_barcode_esito = "2"
//	k_barcode_esito_txt = k_barcode_esito_txt + "SL-PT e Pian.Lavoraz. senza Cicli - " 
else

//--- confronto tra cicli pianificati nel barcode con quelli su Sl-PT
	if kst_tab_sl_pt.fila_1 <> kst_tab_barcode.fila_1 then
		if kst_tab_sl_pt.tipo_cicli <> kkg_sl_pt_tipo_cicli_norm_1 then
			kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
			kst_tab_barcode.note_lav_fin +=   "Impostati Cicli diversi tra SL-PT (F1=" & 
									 + trim(string(kst_tab_sl_pt.fila_1)) + ") " &
									 + "e Pian.Lavoraz. (F1=" &
									 + trim(string(kst_tab_barcode.fila_1)) + ") "
//			k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli diversi tra SL-PT (F1=" &
		else
//--- se tipo cicli "a scelta" controllo se diverso anche fila 2
			if kst_tab_sl_pt.fila_2 <> kst_tab_barcode.fila_2 then
				kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
				kst_tab_barcode.note_lav_fin +=    "Impostati Cicli diversi tra SL-PT (F1/2=" & 
									 + trim(string(kst_tab_sl_pt.fila_1)) + "/" &
									 + trim(string(kst_tab_sl_pt.fila_2)) + ") " &
									 + "e Pian.Lavoraz. (F1/2=" &
									 + trim(string(kst_tab_barcode.fila_1)) + "/" &
									 + trim(string(kst_tab_barcode.fila_2)) + ") "
//				k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli diversi tra SL-PT (F1/2=" &
			end if	
		end if	
	end if
	if kst_tab_sl_pt.fila_1p <> kst_tab_barcode.fila_1p then
		if kst_tab_sl_pt.tipo_cicli <> kkg_sl_pt_tipo_cicli_norm_1 then
			kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
			kst_tab_barcode.note_lav_fin +=  "Impostati Cicli permutati diversi tra SL-PT (F1p=" & 
								 + trim(string(kst_tab_sl_pt.fila_1p)) + ") " &
								 + "e P.Lavoraz. (F1p=" &
								 + trim(string(kst_tab_barcode.fila_1p)) + ") "
//			k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli permutati diversi tra SL-PT (F1p=" &
		else
//--- se tipo cicli "a scelta" controllo se diverso anche fila 2
			if kst_tab_sl_pt.fila_2p <> kst_tab_barcode.fila_2p then
				kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
				kst_tab_barcode.note_lav_fin += "Impostati Cicli permutati diversi tra SL-PT (F1p/2p="  & 
									 + trim(string(kst_tab_sl_pt.fila_1p)) + "/" &
									 + trim(string(kst_tab_sl_pt.fila_2p)) + ") " &
									 + "e Pian.Lavoraz. (F1p/2p=" &
									 + trim(string(kst_tab_barcode.fila_1p)) + "/" &
									 + trim(string(kst_tab_barcode.fila_2p)) + ") "
//				k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli permutati diversi tra SL-PT (F1p/2p=" &
			end if	
		end if	
	end if
	if kst_tab_sl_pt.tipo_cicli <> kkg_sl_pt_tipo_cicli_norm_1 then
		if kst_tab_sl_pt.fila_2 <> kst_tab_barcode.fila_2 then
			kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
			kst_tab_barcode.note_lav_fin += "Impostati Cicli diversi tra SL-PT (F2="  & 
										 + trim(string(kst_tab_sl_pt.fila_2)) + ") " &
										 + "e P.Lavoraz. (F2=" &
										 + trim(string(kst_tab_barcode.fila_2)) + ") "
//			k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli diversi tra SL-PT (F2=" &
		end if
		if kst_tab_sl_pt.fila_2p <> kst_tab_barcode.fila_2p then
			kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
			kst_tab_barcode.note_lav_fin += "Impostati Cicli permutati diversi tra SL-PT (F2p="  & 
										 + trim(string(kst_tab_sl_pt.fila_2p)) + ") " &
										 + "e P.Lavoraz. (F2p=" &
										 + trim(string(kst_tab_barcode.fila_2p)) + ") "
//			k_barcode_esito_txt = k_barcode_esito_txt + "Impostati Cicli permutati diversi tra SL-PT (F2p=" &
		end if
	end if

//--- Se Barcode senza cicli pianificati le reperisco dal sl-pt
	if kst_tab_barcode.fila_1 = 0 and kst_tab_barcode.fila_2 = 0 &
		and kst_tab_barcode.fila_1p = 0 and kst_tab_barcode.fila_2p = 0 then
		kst_tab_barcode.note_lav_fin += "Cicli letti dal SL-PT - " 
//		k_barcode_esito_txt = k_barcode_esito_txt + "Cicli letti dal SL-PT - " 
		kst_tab_barcode.fila_1 = kst_tab_sl_pt.fila_1  
		kst_tab_barcode.fila_2 = kst_tab_sl_pt.fila_2 
		kst_tab_barcode.fila_1p = kst_tab_sl_pt.fila_1p  
		kst_tab_barcode.fila_2p = kst_tab_sl_pt.fila_2p 
	end if
end if
					
//--- Finalmente!! controllo se Cicli trattati uguali a quelli Pianificati	nel barcode	
if kst_tab_barcode.fila_1 = kst_tab_barcode.lav_fila_1 &
	and kst_tab_barcode.fila_2 = kst_tab_barcode.lav_fila_2  &
	and kst_tab_barcode.fila_1p = kst_tab_barcode.lav_fila_1p &
	and kst_tab_barcode.fila_2p = kst_tab_barcode.lav_fila_2p  &
	then
	
	kst_tab_barcode.note_lav_fin +="Verifica Cicli Corretta. - "
//	k_barcode_esito_txt = k_barcode_esito_txt + "Verifica Cicli Corretta. - "
						
else
	if k_barcode_esito = kkg_esito_ok then
		kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
//		k_barcode_esito = "2"
	end if
	
	kst_tab_barcode.note_lav_fin = "Cicli pianificati: F1=" &
								  + string(kst_tab_barcode.fila_1) &
								  + "+" + string(kst_tab_barcode.fila_1p) &
								  + ",  F2=" + string(kst_tab_barcode.fila_2) &
								  + "+" + string(kst_tab_barcode.fila_2p) &
								  + " - " + trim(kst_tab_barcode.note_lav_fin)
//	k_barcode_esito_txt = "Cicli pianificati: F1=" &
end if
			
//--- controllo se PL presente			
if isnull(kst_tab_barcode.pl_barcode) or kst_tab_barcode.pl_barcode = 0 then
	kst_tab_barcode.pl_barcode = 0
	kst_tab_barcode.err_lav_fin = ki_err_lav_fin_ko
//	if trim(tab_1.tabpage_1.dw_1.getitemstring(1, "err_pl")) = "1" then
//		k_barcode_esito = "3"
//	else
//		k_barcode_esito = "2"
//	end if
	kst_tab_barcode.note_lav_fin = "Barcode senza Piano di Lavoro"  &
								 + " - " + trim(kst_tab_barcode.note_lav_fin)
//	k_barcode_esito_txt = "Barcode senza Piano di Lavoro" &
end if

//k_colli_trattati = 0
//k_num_certif = 0
//if k_flag_esponi_gia_lavorato = "0" then
////--- legge tab ARTR x prendere cod colli trattati 
//	kst_tab_artr = kst_tab_artr_vuota
//	kst_tab_artr.id_armo = kst_tab_barcode.id_armo
//	kst_esito = kuf1_artr.leggi(1, kst_tab_artr)
//	k_colli_trattati = kst_tab_artr.colli
//	if isnull(k_colli_trattati) then
//		k_colli_trattati = 0
//	end if
//
////--- legge tab CERTIF x prendere cod Num. Certif 
//	if kst_tab_armo.num_int > 0 then
//		kst_tab_certif = kst_tab_certif_vuota
//		kst_tab_certif.num_certif = 0
//		kst_tab_certif.id_meca = kst_tab_armo.id_meca
//		kst_esito = kuf1_certif.leggi(1, kst_tab_certif)
//		k_num_certif = kst_tab_certif.num_certif
//		if isnull(k_num_certif) then
//			k_num_certif = 0
//		end if
//	end if
//end if
				
destroy kuf1_armo
destroy kuf1_sl_pt 
//destroy kuf1_artr
//destroy kuf1_certif


end subroutine

public subroutine togli_pl_barcode_non_chiuso (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Toglie dal BARCODE i dati di P.L. 
//=== 
//=== Input: Passare il BARCODE 
//===
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

string k_return = "0 "
st_esito kst_esito
uo_exception kuo_exception				  





select distinct data_lav_ini, data_lav_fin, data_lav_ok 
	into  :kst_tab_barcode.data_lav_ini
		  ,:kst_tab_barcode.data_lav_fin
		  ,:kst_tab_barcode.data_lav_ok
	from barcode
	where barcode = :kst_tab_barcode.barcode
	using sqlca;

if sqlca.sqlcode <> 0 then

	kuo_exception = create uo_exception				  
	kuo_exception.set_tipo (kuo_exception.KK_st_uo_exception_tipo_db_ko)
	kst_esito.nome_oggetto = this.classname()
	kst_esito.esito = kkg_esito_db_ko
	kst_esito.sqlcode = sqlca.sqlcode

	if sqlca.sqlcode = 100 then
		kst_esito.sqlerrtext = "Barcode " + trim(kst_tab_barcode.barcode) + " non Trovato. Operazione non eseguita.  ~n~r"  + trim(sqlca.sqlerrtext)
	else
		kst_esito.sqlerrtext = "Errore durante la Ricerca x la rimozione del Barcode " + trim(kst_tab_barcode.barcode) + " dal P.L.  ~n~r"  + trim(sqlca.sqlerrtext)
	end if
	
	kuo_exception.set_esito (kst_esito )
	throw kuo_exception
	
else
	
	choose case true
	
		case &
			  kst_tab_barcode.data_lav_ok > date(0) 
			
			kuo_exception = create uo_exception				  
			kuo_exception.set_tipo (kuo_exception.KK_st_uo_exception_tipo_dati_anomali)
			kuo_exception.setmessage ( "BARCODE "+ trim(kst_tab_barcode.barcode) +" già Convalidato il " + string(kst_tab_barcode.data_lav_ok, "dd/mm/yyyy")  )
			throw kuo_exception
									
		case  &
			  kst_tab_barcode.data_lav_fin > date(0) 
			  
			kuo_exception = create uo_exception				  
			kuo_exception.set_tipo (kuo_exception.KK_st_uo_exception_tipo_dati_anomali)
			kuo_exception.setmessage ( "BARCODE "+ trim(kst_tab_barcode.barcode) +" già trattato, lavorazione conclusa il " + string(kst_tab_barcode.data_lav_fin, "dd/mm/yyyy")  )
			throw kuo_exception
			
	end choose
	
	
	kst_tab_barcode.data_lav_ini = date(0)
	update barcode 
		set 
			pl_barcode = 0, 
			data_lav_ini = :kst_tab_barcode.data_lav_ini
	
		where barcode = :kst_tab_barcode.barcode
		using sqlca;
		
	if sqlca.sqlcode = 0 then
		commit using sqlca;
	else
		kuo_exception = create uo_exception				  
		kuo_exception.set_tipo (kuo_exception.KK_st_uo_exception_tipo_db_ko)
		kst_esito.nome_oggetto = this.classname()
		kst_esito.esito = kkg_esito_db_ko
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Errore durante rimozione del Barcode " + trim(kst_tab_barcode.barcode) + " dal P.L.  ~n~r"  + trim(sqlca.sqlerrtext)
		kuo_exception.set_esito (kst_esito )
		throw kuo_exception
	end if
	
end if

end subroutine

public function boolean if_barcode_trattato (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode gia' con fine Lavorazione
//=== 
//=== Ritorna: TRUE gia' trattato
//===              FALSE non ha finito il trattamento
//===                                   
//====================================================================
boolean k_return = false
long k_ctr
uo_exception kuo_exception
st_esito kst_esito 


	
	
	kst_esito.esito = "0"
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if not isnull(kst_tab_barcode.barcode) &
		and LenA(trim(kst_tab_barcode.barcode)) > 0 then

		select count(*)
				into :k_ctr
				from barcode 
				where barcode.barcode = :kst_tab_barcode.barcode
						and data_lav_fin > date(0)
				using sqlca;
						
		if sqlca.sqlcode < 0 then
			kst_esito.esito = "1"
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.sqlerrtext = "Errore durante lettura Barcode " + trim(kst_tab_barcode.barcode) &
							+ " non trovato (Errore=" &
						  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
			
		else													  

			if k_ctr > 0 then
				k_return = true
			else
				k_return = false
			end if
		end if
	end if

return k_return

end function

public function st_esito anteprima (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode);//
//=== 
//====================================================================
//=== Operazione di Anteprima 
//===
//=== Par. Inut:  
//===               datastore su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
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
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
//kuf_utility kuf1_utility


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_anteprima
kst_open_w.id_programma = kkg_id_programma_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = "100"

else

	if LenA(trim(kst_tab_barcode.barcode)) > 0 then

		kdw_anteprima.dataobject = "d_barcode"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_barcode.barcode)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Barcode da visualizzare: ~n~r" + "nessun codice barcode indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function st_esito anteprima_elenco (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode);//
//=== 
//====================================================================
//=== Operazione di Anteprima (elenco Barcode x Lotto)
//===
//=== Par. Inut:  
//===               datastore su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
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
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
//kuf_utility kuf1_utility


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_anteprima
kst_open_w.id_programma = kkg_id_programma_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_not_fnd

else

	if (kst_tab_barcode.id_meca) > 0 then

		kdw_anteprima.dataobject = "d_barcode_l_2"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_barcode.id_meca)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Barcode da visualizzare: ~n~r" + "nessun codice barcode indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function boolean if_barcode_in_pl_chiuso (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode gia' in Piano di Lavorazione Chiuso 
//=== 
//=== Ritorna: TRUE gia' in PL chiuso
//===              FALSE non in PL chiuso
//===                                   
//====================================================================
boolean k_return = false
long k_ctr
uo_exception kuo_exception
st_esito kst_esito 


	
	
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if not isnull(kst_tab_barcode.barcode) &
		and LenA(trim(kst_tab_barcode.barcode)) > 0 then

		select count(*)
				into :k_ctr
				from barcode inner join pl_barcode on barcode.pl_barcode = pl_barcode.codice 
				where barcode.barcode = :kst_tab_barcode.barcode
						and pl_barcode.data_chiuso > '01.01.1990' 
				using sqlca;
						
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito_db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.sqlerrtext = "Errore durante lettura Barcode " + trim(kst_tab_barcode.barcode) &
							+ " non trovato (Errore=" &
						  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
			
		else													  

			if k_ctr > 0 then
				k_return = true
			else
				k_return = false
			end if
		end if
	else
		kst_esito.esito = kkg_esito_err_logico
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Manca il Barcode, parametro non passato al controllo "
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
	end if

return k_return

end function

public function st_esito if_essere_barcode_padre (ref st_tab_barcode kst_tab_barcode_figlio, ref st_tab_barcode kst_tab_barcode_padre) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode puo' diventare Padre
//=== 
//=== 
//=== Input:  kst_tab_barcode_figlio     con i campi Barcode e File del figlio valorizzate
//=== 	       kst_tab_barcode_padre    con il solo campo Barcode padre valorizzato
//=== 
//=== 
//=== 
//=== 
//=== Ritorna: st_esito
//===              
//===                                   
//====================================================================
long k_ctr
string k_causale_non_trattare
uo_exception kuo_exception
st_esito kst_esito 


	
	
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_causale_non_trattare = ki_causale_non_trattare

try
	
	if not isnull(kst_tab_barcode_padre.barcode) &
		and LenA(trim(kst_tab_barcode_padre.barcode)) > 0 then


//--- barcode filgio e padre uguali? 
		if kst_tab_barcode_figlio.barcode =  kst_tab_barcode_padre.barcode then
			kst_esito.esito = kkg_esito_err_logico
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.sqlerrtext = "Barcode " + trim(kst_tab_barcode_figlio.barcode) +" e' lo stesso del Padre. "
		else

//--- barcode padre già in piano chiuso? 
			if if_barcode_in_pl_chiuso (kst_tab_barcode_padre) then
				kst_esito.esito = kkg_esito_err_logico
				kst_esito.sqlcode = sqlca.sqlcode
				kst_esito.sqlerrtext = "Barcode Padre già Pianificato: " + trim(kst_tab_barcode_padre.barcode) 
				
			else
//--- leggo il barcode			
				kst_esito = select_barcode(kst_tab_barcode_padre)
				if kst_esito.esito <> kkg_esito_ok then
					kst_esito.esito = kkg_esito_err_logico
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.sqlerrtext = "Errore durante lettura Barcode " + trim(kst_tab_barcode_padre.barcode) &
								+ " non trovato (Errore=" &
							  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
					
				else
					if LenA(trim(kst_tab_barcode_padre.barcode_lav)) > 0 then
						kst_esito.esito = kkg_esito_err_logico
						kst_esito.sqlcode = sqlca.sqlcode
						kst_esito.sqlerrtext = "Barcode " + trim(kst_tab_barcode_padre.barcode) + " è già figlio del Barcode " + trim(kst_tab_barcode_padre.barcode_lav)
					else
						if kst_tab_barcode_padre.data_stampa <= date(0) or isnull(kst_tab_barcode_padre.data_stampa) then
						else
							if kst_tab_barcode_padre.data_sosp > date(0) then
							else
								if kst_tab_barcode_padre.causale <> ki_causale_non_trattare then
								else
									if (kst_tab_barcode_padre.fila_1 <> kst_tab_barcode_figlio.fila_1) &
										or (kst_tab_barcode_padre.fila_1p <> kst_tab_barcode_figlio.fila_1p) &
										or (kst_tab_barcode_padre.fila_2 <> kst_tab_barcode_figlio.fila_2)  &
										or (kst_tab_barcode_padre.fila_2p <> kst_tab_barcode_figlio.fila_2p) then
									else
										kst_esito.esito = kkg_esito_ok //--- OK IL BARCODE PUO' DIVENTARE PADRE
									end if
								end if
							end if
						end if
					end if
				end if
			end if
		end if
	else
		kst_esito.esito = kkg_esito_err_logico
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Barcode da controllare se puo' essere 'padre' non indicato "
		
	end if

catch (uo_exception kuo_exceptio)
	throw kuo_exception
	
end try
			
			
return kst_esito

end function

public function boolean if_barcode_in_pl (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode gia' in Piano di Lavorazione  
//=== 
//=== Ritorna: TRUE gia' in PL 
//===              FALSE non in PL 
//===                                   
//====================================================================
boolean k_return = false
long k_ctr
uo_exception kuo_exception
st_esito kst_esito 


	
	
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if not isnull(kst_tab_barcode.barcode) &
		and LenA(trim(kst_tab_barcode.barcode)) > 0 then

		select count(*)
				into :k_ctr
				from barcode inner join pl_barcode on barcode.pl_barcode = pl_barcode.codice 
				where barcode.barcode = :kst_tab_barcode.barcode
				using sqlca;
						
		if sqlca.sqlcode < 0 then
			kst_esito.esito = kkg_esito_db_ko
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.sqlerrtext = "Errore durante lettura Barcode " + trim(kst_tab_barcode.barcode) &
							+ " non trovato (Errore=" &
						  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
			
		else													  

			if k_ctr > 0 then
				k_return = true
			else
				k_return = false
			end if
		end if
	else
		kst_esito.esito = kkg_esito_err_logico
		kst_esito.sqlcode = 0
		kst_esito.sqlerrtext = "Manca il Barcode, parametro non passato al controllo "
		kuo_exception = create uo_exception
		kuo_exception.set_esito(kst_esito)
		throw kuo_exception
	end if

return k_return

end function

public function st_esito select_barcode_trattamento (ref st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Select rek Barcode
//=== 
//=== Ritorna tab. ST_ESITO, Esiti: 0=OK; 100=not found
//===                                     1=errore grave
//===                                     2=errore > 0
//=== 
//====================================================================
//

string k_return = "0 "
st_esito kst_esito


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	select 
	       	 barcode_lav,
			 id_armo,
			 pl_barcode,
			 fila_1,
			 fila_2,
			 fila_1p,
			 fila_2p,
			 lav_fila_1,
			 lav_fila_2,
			 lav_fila_1p,
			 lav_fila_2p
		into
	          :kst_tab_barcode.barcode_lav,
			 :kst_tab_barcode.id_armo,
			 :kst_tab_barcode.pl_barcode,
			 :kst_tab_barcode.fila_1,
			 :kst_tab_barcode.fila_2,
			 :kst_tab_barcode.fila_1p,
			 :kst_tab_barcode.fila_2p,
			 :kst_tab_barcode.lav_fila_1,
			 :kst_tab_barcode.lav_fila_2,
			 :kst_tab_barcode.lav_fila_1p,
			 :kst_tab_barcode.lav_fila_2p
		from barcode
		where barcode = :kst_tab_barcode.barcode
		using sqlca;


	if sqlca.sqlcode <> 0 then
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
		if sqlca.sqlcode = 100 then
			kst_esito.esito = kkg_esito_not_fnd
		else
			kst_esito.esito = kkg_esito_db_ko
		end if
	end if


return kst_esito
end function

public function st_esito if_essere_barcode_figlio (ref st_tab_barcode kst_tab_barcode_figlio, ref st_tab_barcode kst_tab_barcode_padre) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode puo' diventare Figlio
//=== 
//=== 
//=== Input:  kst_tab_barcode_padre    con i campi Barcode e File valorizzate
//=== 	       kst_tab_barcode_figlio      con il solo campo Barcode valorizzato
//=== 
//=== 
//=== 
//=== 
//=== Ritorna: st_esito
//===              
//===                                   
//====================================================================
long k_ctr
string k_causale_non_trattare
uo_exception kuo_exception
st_esito kst_esito 


	
	
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	k_causale_non_trattare = ki_causale_non_trattare

try
	
	if not isnull(kst_tab_barcode_figlio.barcode) &
		and LenA(trim(kst_tab_barcode_figlio.barcode)) > 0 then

//--- barcode filgio e padre uguali? 
		if kst_tab_barcode_figlio.barcode =  kst_tab_barcode_padre.barcode then
			kst_esito.esito = kkg_esito_err_logico
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.sqlerrtext = "Barcode Figio e Padre uguali (" + trim(kst_tab_barcode_figlio.barcode) +"). "
		else

//--- barcode padre già in piano di lav? 
//			if if_barcode_in_pl (kst_tab_barcode_figlio) then
//				kst_esito.esito = kkg_esito_err_logico
//				kst_esito.sqlcode = sqlca.sqlcode
//				kst_esito.sqlerrtext = "Barcode già Pianificato: " + trim(kst_tab_barcode_figlio.barcode) 
//				
//			else
//--- leggo il barcode			
				kst_esito = select_barcode(kst_tab_barcode_figlio)
				if kst_esito.esito <> kkg_esito_ok then
					kst_esito.esito = kkg_esito_err_logico
					kst_esito.sqlcode = sqlca.sqlcode
					kst_esito.sqlerrtext = "Errore durante lettura Barcode " + trim(kst_tab_barcode_figlio.barcode) &
								+ " non trovato (Errore=" &
							  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
					
				else
					if LenA(trim(kst_tab_barcode_figlio.barcode_lav)) > 0 then
						if trim(kst_tab_barcode_figlio.barcode_lav) <> trim(kst_tab_barcode_padre.barcode) then
							kst_esito.esito = kkg_esito_db_wrn
							kst_esito.sqlcode = 0
							kst_esito.sqlerrtext = "Barcode " + trim(kst_tab_barcode_figlio.barcode) + " è già figlio del Barcode " + trim(kst_tab_barcode_figlio.barcode_lav)
						else
							if kst_tab_barcode_figlio.data_stampa <= date(0) or isnull(kst_tab_barcode_figlio.data_stampa) then
								kst_esito.esito = kkg_esito_err_logico
								kst_esito.sqlcode = 0
								kst_esito.sqlerrtext = "Barcode " + trim(kst_tab_barcode_figlio.barcode) + " non ancora stampato. " 
							else
								if kst_tab_barcode_figlio.data_sosp > date(0) then
									kst_esito.esito = kkg_esito_err_logico
									kst_esito.sqlcode = 0
									kst_esito.sqlerrtext = "Barcode " + trim(kst_tab_barcode_figlio.barcode) + " sospeso. " 
								else
									if kst_tab_barcode_figlio.causale = ki_causale_non_trattare then
										kst_esito.esito = kkg_esito_err_logico
										kst_esito.sqlcode = 0
										kst_esito.sqlerrtext = "Barcode " + trim(kst_tab_barcode_figlio.barcode) + " da 'non trattare'. " 
									else
										if (kst_tab_barcode_padre.fila_1 <> kst_tab_barcode_figlio.fila_1) &
											or (kst_tab_barcode_padre.fila_1p <> kst_tab_barcode_figlio.fila_1p) &
											or (kst_tab_barcode_padre.fila_2 <> kst_tab_barcode_figlio.fila_2)  &
											or (kst_tab_barcode_padre.fila_2p <> kst_tab_barcode_figlio.fila_2p) then
										else
											kst_esito.esito = kkg_esito_ok //--- OK IL BARCODE PUO' DIVENTARE FIGLIO
										end if
									end if
								end if
							end if
						end if
					end if
				end if
//			end if
		end if
	else
		kst_esito.esito = kkg_esito_err_logico
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.sqlerrtext = "Barcode 'figlio' non indicato "
		
	end if

catch (uo_exception kuo_exceptio)
	throw kuo_exception
	
end try
			
			
return kst_esito

end function

public function st_esito tb_aggiungi_figlio (st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Aggiunge  un figlio al Barcode
//=== 
//=== Input:  st_tab_barcode con campo Barcode il figlio e Barcode_Lav il Padre 
//===
//=== Ritorna tab. ST_ESITO, come da standard
//=== 
//====================================================================

st_esito kst_esito 
kuf_base kuf1_base
st_tab_barcode kst_tab_barcode_padre


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 


	if LenA(trim(kst_tab_barcode.barcode)) > 0 &
		and LenA(trim(kst_tab_barcode.barcode_lav)) > 0 then
	
		kst_tab_barcode_padre.barcode = trim(kst_tab_barcode.barcode_lav)
		select_barcode_trattamento (kst_tab_barcode_padre)
		if isnull(kst_tab_barcode_padre.pl_barcode) then
			kst_tab_barcode_padre.pl_barcode = 0
		end if
	
		kst_tab_barcode.x_datins = kuf1_data_base.prendi_x_datins()
		kst_tab_barcode.x_utente = kuf1_data_base.prendi_x_utente()

		kst_tab_barcode.groupage = ki_barcode_groupage_SI
				
		update barcode set 	 
						 groupage = :kst_tab_barcode.groupage,
						 barcode_lav = :kst_tab_barcode.barcode_lav,
						 pl_barcode = :kst_tab_barcode_padre.pl_barcode,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using sqlca;

	
		if sqlca.sqlcode >= 0 then
			if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
				kst_esito = kuf1_data_base.db_commit_1()
			end if
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = "2"
				kst_esito.sqlcode = SQLCA.sqlcode
				kst_esito.sqlerrtext = "tab.Barcode: " + trim(SQLCA.SQLErrText)
				if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
					kst_esito = kuf1_data_base.db_rollback_1()
				end if
			end if
		end if

	end if



return kst_esito


end function

public function st_esito tb_togli_figlio (st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Toglie il PADRE al Barcode
//=== 
//=== Input:  st_tab_barcode con campo Barcode al quale togliere il Padre
//===
//=== Ritorna tab. ST_ESITO, come da standard
//=== 
//====================================================================

st_esito kst_esito 
kuf_base kuf1_base



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 

	if LenA(trim(kst_tab_barcode.barcode)) > 0 then
	
		kst_tab_barcode.x_datins = kuf1_data_base.prendi_x_datins()
		kst_tab_barcode.x_utente = kuf1_data_base.prendi_x_utente()

		kst_tab_barcode.groupage = ki_barcode_groupage_NO
		kst_tab_barcode.barcode_lav = ""		
		kst_tab_barcode.pl_barcode = 0
		kst_tab_barcode.data_lav_ini = date(0)
				
				
		update barcode set 	 
						 groupage = :kst_tab_barcode.groupage,
						 barcode_lav = :kst_tab_barcode.barcode_lav,
						 pl_barcode = :kst_tab_barcode.pl_barcode,
						 data_lav_ini = :kst_tab_barcode.data_lav_ini, 
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using sqlca;

	
		if sqlca.sqlcode >= 0 then
			if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
				kst_esito = kuf1_data_base.db_commit_1()
			end if
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = "2"
				kst_esito.sqlcode = SQLCA.sqlcode
				kst_esito.sqlerrtext = "tab.Barcode: " + trim(SQLCA.SQLErrText)
				if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
					kst_esito = kuf1_data_base.db_rollback_1()
				end if
			end if
		end if

	end if





return kst_esito


end function

public function st_esito anteprima_elenco_figli (ref datastore kdw_anteprima, st_tab_barcode kst_tab_barcode);//
//=== 
//====================================================================
//=== Operazione di Anteprima (elenco Figli Barcode)
//===
//=== Par. Inut:  
//===               datastore su cui fare l'anteprima
//===               dati tabella per estrazione dell'anteprima
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
boolean k_return
st_open_w kst_open_w
st_esito kst_esito
kuf_sicurezza kuf1_sicurezza
//kuf_utility kuf1_utility


kst_esito.esito = "0"
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

kst_open_w = kst_open_w
kst_open_w.flag_modalita = kkg_flag_modalita_anteprima
kst_open_w.id_programma = kkg_id_programma_barcode

//--- controlla se utente autorizzato alla funzione in atto
kuf1_sicurezza = create kuf_sicurezza
k_return = kuf1_sicurezza.autorizza_funzione(kst_open_w)
destroy kuf1_sicurezza

if not k_return then

	kst_esito.sqlcode = sqlca.sqlcode
	kst_esito.SQLErrText = "Anteprima non Autorizzata: ~n~r" + "La funzione richiesta non e' stata abilitata"
	kst_esito.esito = kkg_esito_not_fnd

else

	if LenA(trim(kst_tab_barcode.barcode)) > 0 then

		kdw_anteprima.dataobject = "d_barcode_l_figli"		
		kdw_anteprima.settransobject(sqlca)


		kdw_anteprima.reset()	
//--- retrive dell'attestato 
		k_rc=kdw_anteprima.retrieve(kst_tab_barcode.barcode)

	else
		kst_esito.sqlcode = 0
		kst_esito.SQLErrText = "Nessun Barcode da visualizzare: ~n~r" + "nessun codice barcode indicato"
		kst_esito.esito = "1"
		
	end if
end if


return kst_esito

end function

public function long get_conta_figli (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero figli x Barcode richiesto
//=== 
//=== Input: st_tab_barcode.barcode
//=== Output: long con il contatore
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT count(*) into :k_return
		 FROM barcode
		WHERE (barcode_lav = :kst_tab_barcode.barcode) 
		using sqlca;


	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito_db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if


return k_return

end function

public function st_esito tb_togli_figli_tutti (st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Toglie  il Barcode Padre da tutti i Figli ad esso associato
//=== 
//=== Input:  st_tab_barcode con campo Barcode Padre
//===
//=== Ritorna tab. ST_ESITO, come da standard
//=== 
//====================================================================

st_esito kst_esito 
kuf_base kuf1_base



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 

	if LenA(trim(kst_tab_barcode.barcode)) > 0  then
	
		kst_tab_barcode.x_datins = kuf1_data_base.prendi_x_datins()
		kst_tab_barcode.x_utente = kuf1_data_base.prendi_x_utente()

		kst_tab_barcode.groupage = ki_barcode_groupage_NO
		kst_tab_barcode.barcode_lav = ""		
		kst_tab_barcode.pl_barcode = 0
		kst_tab_barcode.data_lav_ini = date(0)
				
		update barcode set 	 
						 groupage = :kst_tab_barcode.groupage,
						 barcode_lav = :kst_tab_barcode.barcode_lav,
						 pl_barcode = :kst_tab_barcode.pl_barcode,
						 data_lav_ini = :kst_tab_barcode.data_lav_ini, 
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode_lav = :kst_tab_barcode.barcode
					using sqlca;

	
		if sqlca.sqlcode >= 0 then
			if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
				kst_esito = kuf1_data_base.db_commit_1()
			end if
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = "2"
				kst_esito.sqlcode = SQLCA.sqlcode
				kst_esito.sqlerrtext = "tab.Barcode: " + trim(SQLCA.SQLErrText)
				if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
					kst_esito = kuf1_data_base.db_rollback_1()
				end if
			end if
		end if

	end if





return kst_esito


end function

public function st_esito tb_delete (ref st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Cancella il rek dalla tabella BARCODE
//=== 
//=== Ritorna 1 char : 0=OK; 1=errore grave non eliminato; 
//===           		: 2=Altro errore 
//===   dal 2 char in poi descrizione dell'errore
//====================================================================

st_esito kst_esito



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 

	kst_tab_barcode.barcode = trim(kst_tab_barcode.barcode)
	
	delete from barcode
		where barcode = :kst_tab_barcode.barcode
		using sqlca;

	if sqlca.sqlcode >= 0 then

		kst_esito = tb_togli_figli_tutti(kst_tab_barcode)  //toglie i figli da questo barcode
		if kst_esito.esito = kkg_esito_db_ko  then
//			k_return = "1" + kst_esito.sqlerrtext
			
			if kst_tab_barcode.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_barcode.st_tab_g_0.esegui_commit) then
				kuf1_data_base.db_rollback_1( )
			end if
		else
			
			if kst_tab_barcode.st_tab_g_0.esegui_commit <> "N" or isnull(kst_tab_barcode.st_tab_g_0.esegui_commit) then
				kuf1_data_base.db_commit_1( )
			end if
			
		end if
	else
		kst_esito.esito = kkg_esito_db_ko
		kst_esito.sqlerrtext = "Errore durante cancellazione Barcode: " + trim( SQLCA.SQLErrText	) 
	end if



return kst_esito
end function

public function datastore get_figli_barcode (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Torna elenco figli x Barcode richiesto
//=== 
//=== Input: st_tab_barcode.barcode
//=== Output: datastore ds_barcode_figli_elenco
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
int k_rc
datastore kds_1
st_esito kst_esito


kst_esito.esito = kkg_esito_ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

if isvalid(kds_1) then destroy kds_1

kds_1 = create datastore
kds_1.dataobject = ki_ds_barcode_figli_elenco
kds_1.settransobject( sqlca)

if LenA(trim(kst_tab_barcode.barcode)) > 0 then
	k_rc = kds_1.retrieve(kst_tab_barcode.barcode)

	if k_rc < 0 then
		kst_esito.sqlcode = k_rc
		kst_esito.SQLErrText = "Elenco Figli da tab.Barcode (datastore: " + trim(kds_1.dataobject ) + ") "
		kst_esito.esito = kkg_esito_db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
end if

return kds_1

end function

public function boolean if_barcode_figlio (st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Controlla se Barcode è figlio
//=== 
//=== Ritorna: TRUE gia' trattato
//===              FALSE non ha finito il trattamento
//===                                   
//====================================================================
boolean k_return = false
long k_ctr
uo_exception kuo_exception
st_esito kst_esito 


	
	
	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()


	if not isnull(kst_tab_barcode.barcode) &
		and LenA(trim(kst_tab_barcode.barcode)) > 0 then

//		kst_tab_barcode.groupage = ki_barcode_groupage_SI

		select count(*)
				into :k_ctr
				from barcode 
				where barcode.barcode = :kst_tab_barcode.barcode
						and barcode.barcode_lav is not null and barcode.barcode_lav <> ''
//						and groupage = :kst_tab_barcode.groupage
				using sqlca;
						
		if sqlca.sqlcode < 0 then
			kst_esito.esito = "1"
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.sqlerrtext = "Errore durante lettura Barcode " + trim(kst_tab_barcode.barcode) &
							+ " non trovato (Errore=" &
						  + string (sqlca.sqlcode, "#####") + " " + trim(sqlca.sqlerrtext) + ")"
			kuo_exception = create uo_exception
			kuo_exception.set_esito(kst_esito)
			throw kuo_exception
			
		else													  

			if k_ctr > 0 then
				k_return = true
			else
				k_return = false
			end if
		end if
	end if

return k_return

end function

public function boolean get_padre (ref st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Torna il Padre di un Barcode (se c'e' ovviamante!)
//=== 
//=== Input: st_tab_barcode.barcode
//=== Output: st_tab_barcode.barcode_lav
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
boolean k_return=false
st_esito kst_esito


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT barcode_lav into :kst_tab_barcode.barcode_lav
		 FROM barcode
		WHERE (barcode = :kst_tab_barcode.barcode) 
		using sqlca;


	if sqlca.sqlcode >= 0 then
		k_return = true
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito_db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if


return k_return

end function

public function st_esito tb_set_padre (st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Imposta il flag di Groupage sul Barcode 'PADRE'
//=== 
//=== Input:  st_tab_barcode con campo Barcode Padre 
//===
//=== Ritorna tab. ST_ESITO, come da standard
//=== 
//====================================================================

st_esito kst_esito 
kuf_base kuf1_base



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 

	if LenA(trim(kst_tab_barcode.barcode)) > 0 &
		then
	
		kst_tab_barcode.x_datins = kuf1_data_base.prendi_x_datins()
		kst_tab_barcode.x_utente = kuf1_data_base.prendi_x_utente()

		kst_tab_barcode.groupage = ki_barcode_groupage_SI
				
		update barcode set 	 
						 groupage = :kst_tab_barcode.groupage,
						 x_datins = :kst_tab_barcode.x_datins,
						 x_utente = :kst_tab_barcode.x_utente
					where barcode = :kst_tab_barcode.barcode
					using sqlca;

	
		if sqlca.sqlcode >= 0 then
			if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
				kst_esito = kuf1_data_base.db_commit_1()
			end if
		else
			if sqlca.sqlcode <> 0 then
				kst_esito.esito = "2"
				kst_esito.sqlcode = SQLCA.sqlcode
				kst_esito.sqlerrtext = "tab.Barcode: " + trim(SQLCA.SQLErrText)
				if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
					kst_esito = kuf1_data_base.db_rollback_1()
				end if
			end if
		end if

	end if



return kst_esito


end function

public function st_esito tb_togli_figlio_al_padre (st_tab_barcode kst_tab_barcode);//
//====================================================================
//=== Toglie al PADRE il legame con il Figlio (ovvero se non + figli allora resetta il flag groupage)  
//=== 
//=== Input:  st_tab_barcode con campo Barcode Padre
//===
//=== Ritorna tab. ST_ESITO, come da standard
//=== 
//====================================================================
long k_ctr
st_esito kst_esito 
kuf_base kuf1_base



	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()
	kst_esito.st_tab_g_0 = kst_tab_barcode.st_tab_g_0 

	if LenA(trim(kst_tab_barcode.barcode)) > 0 then

//--- conta i fligli rimasti	
		try
			k_ctr = get_conta_figli(kst_tab_barcode)


//--- se padre senza figli allora....	
			if k_ctr = 0 then
				
				kst_tab_barcode.x_datins = kuf1_data_base.prendi_x_datins()
				kst_tab_barcode.x_utente = kuf1_data_base.prendi_x_utente()
		
				kst_tab_barcode.groupage = ki_barcode_groupage_NO
						
				update barcode set 	 
								 groupage = :kst_tab_barcode.groupage,
								 x_datins = :kst_tab_barcode.x_datins,
								 x_utente = :kst_tab_barcode.x_utente
							where barcode = :kst_tab_barcode.barcode
							using sqlca;
		
			
				if sqlca.sqlcode >= 0 then
					if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
						kst_esito = kuf1_data_base.db_commit_1()
					end if
				else
					if sqlca.sqlcode <> 0 then
						kst_esito.esito = "2"
						kst_esito.sqlcode = SQLCA.sqlcode
						kst_esito.sqlerrtext = "tab.Barcode: " + trim(SQLCA.SQLErrText)
						if kst_esito.st_tab_g_0.esegui_commit <> "N" or isnull(kst_esito.st_tab_g_0.esegui_commit) then
							kst_esito = kuf1_data_base.db_rollback_1()
						end if
					end if
					
				end if
			end if
				
		catch (uo_exception kuo_exception)
			kst_esito = kuo_exception.get_st_esito()
		end try
			
	end if





return kst_esito


end function

public function long get_conta_barcode_x_id_armo_fine_lav (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero dei Barcode  FINE TRATTAMENTO  per codice PL e il ID_ARMO
//=== 
//=== Input: st_tab_barcode.id_armo e pl_barcode
//=== Output: long con il contatore
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT count(*) into :k_return
		 FROM barcode
		WHERE (id_armo = :kst_tab_barcode.id_armo and pl_barcode = :kst_tab_barcode.pl_barcode
		            and data_lav_fin > '01.01.2000' ) 
		using sqlca;


	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito_db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if
	
	if isnull(k_return) then
		k_return = 0
	end if



return k_return

end function

public function long get_conta_barcode_x_id_armo_in_lav (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero dei Barcode  CHE SONO STATI MESSI IN PL x codice PL e il ID_ARMO
//=== 
//=== Input: st_tab_barcode.id_armo e pl_barcode
//=== Output: long con il contatore
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
long k_return=0
st_esito kst_esito


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT count(*) into :k_return
		 FROM barcode
		WHERE (id_armo = :kst_tab_barcode.id_armo and pl_barcode = :kst_tab_barcode.pl_barcode)
		using sqlca;
//		            and data_lav_ini > date(0) ) 


	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito_db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

	if isnull(k_return) then
		k_return = 0
	end if

return k_return

end function

public function long get_conta_barcode_groupage_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Conta il numero dei Barcode  IN GROUPAGE COME FIGLI CHE SONO STATI MESSI IN PL 
//=== per codice PL e il ID_ARMO
//=== 
//=== Input: st_tab_barcode.id_armo e pl_barcode
//=== Output: long con il contatore
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
long k_return
st_esito kst_esito


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	SELECT count(*) into :k_return
		 FROM barcode
		WHERE (id_armo = :kst_tab_barcode.id_armo and pl_barcode = :kst_tab_barcode.pl_barcode
		             and barcode_lav <> ' ' and barcode_lav is not null) 
		using sqlca;
//and data_lav_ini > date(0)		


	if sqlca.sqlcode >= 0 then
		if sqlca.sqlcode > 0 then
			k_return = 0
		end if
	else
		kst_esito.sqlcode = sqlca.sqlcode
		kst_esito.SQLErrText = "Tab.Barcode: " + trim(sqlca.SQLErrText)
		kst_esito.esito = kkg_esito_db_ko
		kguo_exception.set_esito (kst_esito)
		throw kguo_exception
	end if

	if isnull(k_return) then
		k_return = 0
	end if


return k_return

end function

public function date get_data_lav_ini_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Estrae data di inizio lav piu' vecchia per id_armo  
//=== 
//=== Input: la struttura st_tab_barcode con data id_armo ed eventalmente pl_parcode
//=== Output: la struttura st_tab_barcode con la DATA_lav_ini valorizzata
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
string k_dataoggi_x
kuf_base kuf1_base
st_esito kst_esito
st_tab_barcode kst_tab_barcode1


	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_barcode.pl_barcode > 0 then
		select distinct
					min(data_lav_ini)
			into
				 :kst_tab_barcode1.data_lav_ini
			from barcode
			where id_armo = :kst_tab_barcode.id_armo 
				and pl_barcode =  :kst_tab_barcode.pl_barcode 
				and data_lav_ini > '01.01.2000'
			using sqlca;
	else
		select distinct
					min(data_lav_ini)
			into
				 :kst_tab_barcode1.data_lav_ini
			from barcode
			where id_armo = :kst_tab_barcode.id_armo 
				and data_lav_ini > '01.01.2000'
			using sqlca;
	end if			

	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode > 0 then
			kst_tab_barcode1.data_lav_ini = date(0)
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura tab.Barcode: " + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito_db_ko
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if

return kst_tab_barcode1.data_lav_ini


end function

public function date get_data_lav_fin_x_id_armo (readonly st_tab_barcode kst_tab_barcode) throws uo_exception;//
//====================================================================
//=== Estrae data di inizio lav piu' vecchia per id_armo  
//=== 
//=== Input: la struttura st_tab_barcode con data id_armo ed eventalmente pl_parcode
//=== Output: la struttura st_tab_barcode con la data_lav_fin valorizzata
//===             
//===             
//=== Lancia un ECCEZIONE se Errore grave
//====================================================================
//
string k_dataoggi_x
kuf_base kuf1_base
st_esito kst_esito
st_tab_barcode kst_tab_barcode1

	kst_esito.esito = kkg_esito_ok
	kst_esito.sqlcode = 0
	kst_esito.SQLErrText = ""
	kst_esito.nome_oggetto = this.classname()

	if kst_tab_barcode.pl_barcode > 0 then
		select distinct
					max(data_lav_fin)
			into
				 :kst_tab_barcode1.data_lav_fin
			from barcode
			where id_armo = :kst_tab_barcode.id_armo 
				and pl_barcode =  :kst_tab_barcode.pl_barcode 
			using sqlca;
	else
		select distinct
					max(data_lav_fin)
			into
				 :kst_tab_barcode1.data_lav_fin
			from barcode
			where id_armo = :kst_tab_barcode.id_armo 
			using sqlca;
	end if			

	if sqlca.sqlcode <> 0 then
		if sqlca.sqlcode > 0 then
			kst_tab_barcode1.data_lav_fin = date(0)
		else
			kst_esito.sqlcode = sqlca.sqlcode
			kst_esito.SQLErrText = "Lettura tab.Barcode: " + trim(sqlca.SQLErrText)
			kst_esito.esito = kkg_esito_db_ko
			kguo_exception.set_esito (kst_esito)
			throw kguo_exception
		end if
	end if

return kst_tab_barcode1.data_lav_fin


end function

on kuf_barcode.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_barcode.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

