$PBExportHeader$w_g_tab_1.srw
forward
global type w_g_tab_1 from Window
end type
type st_parametri from statictext within w_g_tab_1
end type
type cb_duplica from commandbutton within w_g_tab_1
end type
type cb_ritorna from commandbutton within w_g_tab_1
end type
type cb_cancella from commandbutton within w_g_tab_1
end type
type cb_aggiorna from commandbutton within w_g_tab_1
end type
type cb_inserisci from commandbutton within w_g_tab_1
end type
type dw_dett_1 from datawindow within w_g_tab_1
end type
end forward

global type w_g_tab_1 from Window
int X=0
int Y=0
int Width=2789
int Height=1648
boolean TitleBar=true
string Title="Anagrafica Modelli"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowType WindowType=child!
event ue_menu pbm_custom01
st_parametri st_parametri
cb_duplica cb_duplica
cb_ritorna cb_ritorna
cb_cancella cb_cancella
cb_aggiorna cb_aggiorna
cb_inserisci cb_inserisci
dw_dett_1 dw_dett_1
end type
global w_g_tab_1 w_g_tab_1

type variables
string ki_record_base
st_open_w ki_st_open_w
end variables
forward prototypes
protected function string aggiorna ()
protected function string aggiorna_dati ()
protected function string check_dati ()
protected function integer attiva_tasti ()
protected function string tb_insert ()
protected function integer cancella ()
protected function integer conferma ()
protected function string dati_modif ()
protected function integer inserisci ()
public function string tb_update ()
protected function integer ritorna ()
public function string smista_funz (string k_par_in)
protected subroutine liste_varie ()
private subroutine duplica ()
protected function integer check_esiste ()
protected function string inizializza ()
end prototypes

event ue_menu;//
smista_funz(this.tag)

end event

protected function string aggiorna ();//
//======================================================================
//=== Aggiorna tabelle Modelli, Composizioni, Listini
//=== Ritorna 1 chr : 0=tutto OK; 1=errore grave I-O;
//=== 				  : 2=
//===					  : 3=Commit fallita
//===		dal char 2 in poi spiegazione dell'errore
//======================================================================

string k_return="- ", k_errore="0 ", k_errore1="0 "


//if dw_dett_0.update() <> 1 then

//=== Gli aggiornamenti ritornano: 0=OK; 1=errore grave 2=errore non grave
if dw_dett_1.getitemstatus(1, 0, primary!) = newmodified! then

	k_return = tb_insert()  

else

	if dw_dett_1.getitemstatus(1, 0, primary!) = datamodified! then
	
		k_return = tb_update()
	end if
end if


if left(k_return, 1) <> "-" then //potrei non avere elaborato nulla
	if left(k_return, 1)  = "1" then  //errore grave

		k_return = "1" + mid(k_return, 2) 
		k_errore1 = kuf1_data_base.db_rollback()
	else
//=== faccio la COMMIT		
		k_errore1 = kuf1_data_base.db_commit()
		
		if left(k_errore1, 1) <> "0" then
			k_return = "3" + "Fallito aggiornamento archivi !!"

		end if
	end if
else
	k_return = "0 "

end if



//=== errore : 0=tutto OK o NON RICHIESTA; 1=errore tab Modelli;
//=== 		 : 2=
//===			 : 3=Commit fallita

if left(k_return, 1) = "1" then
	messagebox("Operazione di Aggiornamento Non Eseguita !!", &
		mid(k_return, 2))
else
	if left(k_return, 1) = "2" then
		messagebox("Aggiornamento Parziale degli Archivi !!", &
			mid(k_return, 2))
	else
		if left(k_return, 1) = "3" then
			messagebox("Registrazione dati : problemi nella 'Commit' !!", &
				"Consiglio : chiudere e ripetere le operazioni eseguite")
		end if
	end if
end if


return k_return

end function

protected function string aggiorna_dati ();//
//=== Completa gestione aggiornamento tabelle : Check dati + Update
//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=

string k_return="0 "
string k_errore= "0 ", k_errore1 = "0 ", k_errore_dati = "0 "
string k_id_modello
long k_riga, k_ctr


dw_dett_1.accepttext()


////=== Pulisco eventuali righe rimaste vuote e aggiusto campi a NULL
//k_riga = dw_dett_1.rowcount ( )
//for k_ctr = k_riga to 1 -1
//
//	k_id_modello = dw_dett_1.getitemstring(k_ctr, "modelli_id_modello") 
// 	if isnull(k_id_modello) or len(k_id_modello) = 0 then
//		dw_dett_1.deleterow(k_ctr)
//	else
//
//		if isnull(dw_dett_1.getitemstring(k_ctr, "modelli_des_ita")) then
//		   dw_dett_1.setitem(k_riga, "modelli_des_ita", " ")
//		end if
//
//	end if
//next

k_riga = dw_dett_1.rowcount ( )

if k_riga = 0 then

	cb_ritorna.triggerevent(clicked!)

else

//=== Controllo congruenza dei dati caricati. 
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
	k_errore_dati = check_dati()

	choose case left(k_errore_dati,1)

		case "1" 
			messagebox("Digitati dati incongruenti, operazione non eseguita~n~r", &
			     mid(k_errore_dati, 2))
			k_return="1" + mid(k_errore_dati, 2)
		case "2"
			messagebox("Inseriti dati non validi, operazione non eseguita~n~n", & 
			     mid(k_errore_dati, 2))
			k_return="1" + mid(k_errore_dati, 2)
		case "3"
			messagebox("Dati insufficienti, operazione non eseguita~n~r", & 
			     mid(k_errore_dati, 2))
			k_return="1" + mid(k_errore_dati, 2)
		case "4", "0"

//=== k_errore : 0=tutto OK o NON RICHIESTA; 1=errore grave I-O;
//=== 			: 2=LIBERA
//===				: 3=Commit fallita
			k_errore = aggiorna()		

			if left(k_errore, 1) = "1" or left(k_errore, 1) = "3" then
				k_return="1" + mid(k_errore, 2)
			else
				if left(k_errore, 1) = "0" then

					if left(k_errore_dati, 1) = "4" then
						messagebox("Ho rilevato alcune incongruenze.", &
							"I dati SONO stati caricati. ~n~r" + &
							mid(k_errore_dati, 2)) 		
						k_return="2" + mid(k_errore_dati, 2)
					else
						k_return = "0"
					end if
               
	//				close(w_modelli)

				end if

			end if

	end choose


end if

return k_return

end function

protected function string check_dati ();//
//======================================================================
//=== Controllo formale e logico dei dati inseriti
//=== Ritorna 1 char : 0=tutto OK; 1=errore logico; 2=errore formale;
//===			         : 3=dati insufficienti; 4=OK con degli avvertimenti
//===      il resto della stringa contiene la descrizione dell'errore   
//======================================================================

string k_return = " "
char k_errore = "0"
//int k_riga
//int k_nr_errori
//string k_id_modello
//string k_des_ita, k_des_est
//
//
//k_nr_errori = 1
//k_riga = 1
//
////=== Legge la prima riga modificata
//k_riga = dw_dett_1.GetNextModified(k_riga, Primary!)
//
//do while k_riga <> 0 and k_nr_errori < 10
//
//	k_id_modello = dw_dett_1.getitemstring ( k_riga, "modelli_id_modello") 
//
//	if trim(k_id_modello) = "" then
//		k_return = "Manca il codice modello"
//		k_errore = "3"
//		k_nr_errori++
//	else
//		k_des_ita = dw_dett_1.getitemstring ( k_riga, "des_ita")
//		if trim(k_des_ita) = "" then
//			k_return = "Manca la Descrizione italiana ~n~r" 
//			k_errore = "3"
//			k_nr_errori++
//		end if
//	end if
//
////		if k_errore = "0" and dw_dett_1.getitemnumber ( k_riga, "aliquota") > 30 and &
////			dw_dett_1.getitemnumber ( 1, "scad_mm") = 0	then
////			k_return = "Nr. mesi non puo' essere a 0 se ci sono delle rate ~n~r"
////			k_errore = "1"
////		end if
//
//	if k_errore = "0" then
//		if long(dw_dett_1.describe("modelli_id_iva.d_c_iva.aliquota")) = 0 then 
//			k_return = "Attenzione il codice IVA Esente  ~n~r"
//			k_errore = "4"
//		end if
//
//		if	len(dw_dett_1.getitemstring(k_riga, "modelli_um")) = 0 then
//			k_return = "Manca l'unita' di misura. ~n~r"
//			k_errore = "4"
//		end if
//
//		if	len(dw_dett_1.getitemstring(k_riga, "modelli_id_taglia")) = 0 then
//			k_return = "Manca la taglia. ~n~r"
//			k_errore = "4"
//		end if
//
//		if	len(dw_dett_1.getitemstring(k_riga, "modelli_id_fornitore")) = 0 then
//			k_return = "Manca il fornitore. ~n~r"
//			k_errore = "4"
//		end if
//
//	end if
//
//	if k_errore <> "0" then
//		k_return = k_return + "(" + k_des_ita + ") ~n~r"
//		k_nr_errori++
//	end if
////=== Legge la successiva riga modificata
//	k_riga = dw_dett_1.GetNextModified(k_riga, Primary!)
//
//
//loop
//
//
return k_errore + k_return


end function

protected function integer attiva_tasti ();//
//=========================================================================
//=== Controlla se codice modificato
//=== Attiva/Disattiva i tasti a seconda delle funzioni e dei campi 
//=== impostati
//=========================================================================

long k_nr_righe
string k_null



cb_inserisci.enabled = true
cb_ritorna.enabled = true
cb_aggiorna.enabled = false
cb_aggiorna.default = false

//=== Nr righe ne DW lista
if dw_dett_1.getrow ( ) <= 0 then
	cb_inserisci.enabled = true
	cb_inserisci.default = true
	cb_cancella.enabled = false
	cb_aggiorna.enabled = false
	cb_duplica.enabled = false
else
	cb_aggiorna.enabled = true
	cb_duplica.enabled = true
end if
            

return (0)
end function

protected function string tb_insert ();//
//=== Inserimento nelle tab. CLIENTI e CLIENTI_SPED
//
string k_return="0 "
//long k_errore=0
//string k_id_modello, k_id_modello_rit
//string k_des_ita, k_des_est
//string k_um, k_ass_colori
//char k_id_taglia
//int k_id_iva
//long k_id_fornitore
//long k_listino_1, k_listino_2, k_listino_3, k_listino_4, k_listino_5
//string k_composizione, k_id_merce, k_stagione
//
//kuf_modelli   kuf1_modelli
//
//
//k_id_modello = dw_dett_1.getitemstring(1, "modelli_id_modello")   
//k_des_ita = dw_dett_1.getitemstring(1, "modelli_des_ita")   
//k_des_est = dw_dett_1.getitemstring(1, "modelli_des_est")   
//k_um = dw_dett_1.getitemstring(1, "modelli_um")   
//k_ass_colori = dw_dett_1.getitemstring(1, "modelli_ass_colori")   
//k_id_taglia = dw_dett_1.getitemstring(1, "modelli_id_taglia")   
//k_id_iva = dw_dett_1.getitemnumber(1, "modelli_id_iva")   
//k_id_fornitore = dw_dett_1.getitemnumber(1, "modelli_id_fornitore")   
//k_id_merce = dw_dett_1.getitemstring(1, "modelli_id_merce")   
//k_stagione = dw_dett_1.getitemstring(1, "modelli_stagione")   
//
//k_listino_1 = dw_dett_1.getitemnumber(1, "listini_listino_1")   
//k_listino_2 = dw_dett_1.getitemnumber(1, "listini_listino_2")   
//k_listino_3 = dw_dett_1.getitemnumber(1, "listini_listino_3")   
//k_listino_4 = dw_dett_1.getitemnumber(1, "listini_listino_4")   
//k_listino_5 = dw_dett_1.getitemnumber(1, "listini_listino_5")   
//
//k_composizione = dw_dett_1.getitemstring(1, "composizioni_composizione")   
//
//
//INSERT INTO "modelli"  
//         ( "id_modello",   
//           "des_ita",   
//           "des_est",   
//           "um",   
//           "ass_colori",   
//           "id_taglia",   
//           "id_iva",   
//           "id_fornitore",
//			  "id_merce",
//			  "stagione" )  
//  VALUES ( :k_id_modello,   
//           :k_des_ita,   
//           :k_des_est,   
//           :k_um,   
//           :k_ass_colori,   
//           :k_id_taglia,   
//           :k_id_iva,   
//           :k_id_fornitore,
//			  :k_id_merce,
//			  :k_stagione )  ;
//
//k_errore = sqlca.sqlcode
//if k_errore <> 0 then
//	k_return = "1" + "Modello gia' in archivio !! ~r~n"+ &
//				trim(sqlca.sqlerrtext) + " (" + string(sqlca.sqldbcode, "#####") + ") "
//else
////=== Insert della tabella dei Listini
//	if dw_dett_1.getitemstatus(1, "listini_listino_1", primary!) = datamodified! or &
//		dw_dett_1.getitemstatus(1, "listini_listino_2", primary!) = datamodified! or &
//		dw_dett_1.getitemstatus(1, "listini_listino_3", primary!) = datamodified! or &
//		dw_dett_1.getitemstatus(1, "listini_listino_4", primary!) = datamodified! or &
//		dw_dett_1.getitemstatus(1, "listini_listino_5", primary!) = datamodified! &
//		then
//
//   	INSERT INTO "listini"  
//         ( "id_modello",   
//           "listino_1",   
//           "listino_2",   
//           "listino_3",   
//           "listino_4",   
//           "listino_5" )  
//  			VALUES (
//					:k_id_modello, 
//					:k_listino_1,  
//	            :k_listino_2,
//   	         :k_listino_3,
//      	      :k_listino_4,
//         	   :k_listino_5
//		         )  	;
//
//		k_errore = sqlca.sqlcode
//		if k_errore <> 0 then
//			k_return = "2" + "Listino Prezzi non registrato, riprova. ~r~n"+ &
//					trim(sqlca.sqlerrtext) + " (" + string(sqlca.sqldbcode, "#####") + ") "
//		end if
//	end if
//
////=== Insert della tabella Composizione
//	if dw_dett_1.getitemstatus(1, "composizioni_composizione", primary!) = datamodified!  &
//		then
//
//   	INSERT INTO "composizioni"  
//         ( "id_modello",   
//           "composizione"   
//         )  
//  			VALUES (
//				 :k_id_modello,
//    	       :k_composizione
//         )  ;
//
//		k_errore = sqlca.sqlcode
//		if k_errore <> 0 then
//			if left(k_return, 1) = "0" then
//				k_return = "2" 
//			end if
//			k_return = k_return + "Composizione Tessuto non registrata, riprova. ~r~n"+ &
//					trim(sqlca.sqlerrtext) + " (" + string(sqlca.sqldbcode, "#####") + ") "
//		end if
//
//
//	end if
//end if
//
////=== resetta i buffer primary e delete
//dw_dett_1.ResetUpdate( )	

return (k_return)
end function

protected function integer cancella ();////
//
//string k_des_ita, k_des_est
//string k_id_modello
//string k_errore = "0 ", k_errore1 = "0 "
//long k_riga
//kuf_modelli  kuf1_modelli
//
//
////=== Controllo se sul dettaglio c'e' qualche cosa
//k_riga = dw_dett_1.getrow()	
//if k_riga > 0 then
//	k_id_modello = dw_dett_1.getitemstring(k_riga, "modelli_id_modello")
//	k_des_ita = dw_dett_1.getitemstring(k_riga, "modelli_des_ita")
//	k_des_est = dw_dett_1.getitemstring(k_riga, "modelli_des_est")
//
//	if (isnull(k_des_ita) = true or trim(k_des_ita) = "") and & 
//		(isnull(k_des_ita) = true or trim(k_des_ita) = "") then
//		k_des_ita = "Modello senza descrizione" 
//	end if
//	
////=== Richiesta di conferma della eliminazione del rek
//
//	if messagebox("Elimina Modello", "Sei sicuro di voler Cancellare : ~n~r" + trim(k_des_ita), &
//				question!, yesno!, 1) = 1 then
// 
////=== Creo l'oggetto che ha la funzione x cancellare la tabella
//		kuf1_modelli = create kuf_modelli
//		
////=== Cancella la riga dal data windows di lista
//		k_errore = kuf1_modelli.tb_delete(k_id_modello) 
//		if left(k_errore, 1) = "0" then
//
//			k_errore = kuf1_data_base.db_commit()
//			if left(k_errore, 1) <> "0" then
//				messagebox("Problemi durante la Cancellazione !!", &
//						"Controllare i dati. " + mid(k_errore, 2))
//
//			else
//				
////=== Parametri passati con il WITHPARM alla chiamata della window
//		//		k_id_cliente = message.stringparm
//		//		if isnull(k_id_cliente) = true then
//		//			k_id_cliente = " "
//		//		end if
//			//	inizializza(k_id_cliente) //Reimposta i tasti e fa la retrieve di lista
//	
//				dw_dett_1.reset()
//				dw_dett_1.resetupdate()				
//			end if
//
//			dw_dett_1.setfocus()
//
//		else
//			k_errore1 = k_errore
//			k_errore = kuf1_data_base.db_rollback()
//
//			messagebox("Problemi durante Cancellazione - Operazione fallita !!", &
//							mid(k_errore1, 2) ) 	
//			if left(k_errore, 1) <> "0" then
//				messagebox("Problemi durante il recupero dell'errore !!", &
//					"Controllare i dati. " + mid(k_errore, 2))
//			end if
//	
//
//		end if
//
////=== Distruggo l'oggetto che ha avuto la funzione x cancellare la tabella
//		destroy kuf1_modelli
//
//	else
//		messagebox("Elimina Modelli", "Operazione Annullata !!")
//	end if
//
//	dw_dett_1.setcolumn(1)
//
//end if
//
//
//attiva_tasti()
//
return(0)
end function

protected function integer conferma ();//
//=== Aggiornamento dei dati inseriti/modificati
string k_errore = "0 "

//
//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=
//===      il resto della stringa contiene la descrizione dell'errore   
k_errore = aggiorna_dati()

return (0)
end function

protected function string dati_modif ();//
//=== Controllo se ci sono state modifiche di dati sui DW
string k_return="0 "
int k_msgbox


dw_dett_1.accepttext()

if dw_dett_1.getrow() > 0 then
	if dw_dett_1.getnextmodified(0, primary!) > 0 then
		k_msgbox = messagebox("Dati Modificati", "Vuoi Salvare gli Aggiornamenti ?", &
				question!, yesnocancel!, 1) 
		if k_msgbox = 1 then
			k_return = "1Dati Modificati"		
		else
   	   if k_msgbox = 3 then
				k_return = "3Operazione Annullata"		
			end if
		end if
	end if

end if



return k_return
end function

protected function integer inserisci ();//
string k_errore="0 ", k_modif


//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
k_modif = dati_modif()
if left(k_modif, 1) = "1" then //Richisto Aggiornamento

//=== Controllo congruenza dei dati caricati e Aggiornamento  
//=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
//===                : 2=errore non grave dati aggiornati;
//===			         : 3=LIBERO
//===      il resto della stringa contiene la descrizione dell'errore   
	k_errore = aggiorna_dati()
	
end if


if left(k_modif, 1) <> "3" then //Diverso da ANNULLA OPERAZIONE

	if left(k_errore, 1) = "0" then

//=== Disabilito il pulsante e il default al puls. aggiorna
//	this.enabled = false
//	cb_aggiorna.enabled = true	
//	cb_aggiorna.default = true

//=== Pulizia dei campi
		attiva_tasti()


//=== Aggiunge una riga al data windows
		dw_dett_1.reset()
		dw_dett_1.insertrow(0)

//=== Valori di default
//	dw_dett_1.setitem(1, "modelli_ass_colori", "0")
//	dw_dett_1.setitem(1, "modelli_id_taglia", mid(ki_record_base, 428, 1))
//	dw_dett_1.setitem(1, "modelli_id_iva", long(mid(ki_record_base, 429, 2)))
//	dw_dett_1.setitem(1, "modelli_id_fornitore", long(mid(ki_record_base, 431, 5)))
//	dw_dett_1.setitem(1, "modelli_um", mid(ki_record_base, 436, 3))
//	dw_dett_1.setitem(1, "modelli_stagione", mid(ki_record_base, 440, 5))
//	dw_dett_1.setitem(1, "modelli_id_merce", mid(ki_record_base, 439, 1))
//
//=== Resetto lo status della riga
		dw_dett_1.setitemstatus(1, 0, primary!, notmodified!)

//=== Posiziona il cursore sul Data Windows
		dw_dett_1.setfocus() 
	end if
end if

return (0)
end function

public function string tb_update ();//
//=== Inserimento nelle tab. CLIENTI e CLIENTI_SPED
//
string k_return="0 "
//long k_errore=0
//int  k_ctr=0
//kuf_modelli kuf1_modelli
//
//string k_id_modello, k_id_modello_old, k_id_modello_1, k_id_modello_2
//string k_des_ita, k_des_est
//string k_um, k_ass_colori
//char k_id_taglia
//long k_id_iva
//long k_id_fornitore
//long k_listino_1, k_listino_2, k_listino_3, k_listino_4, k_listino_5
//string k_composizione, k_stagione, k_id_merce
//
//
//k_id_modello_old = dw_dett_1.getitemstring(1, "modelli_id_modello",primary!, true)   
//k_id_modello = dw_dett_1.getitemstring(1, "modelli_id_modello")   
//k_des_ita = dw_dett_1.getitemstring(1, "modelli_des_ita")   
//k_des_est = dw_dett_1.getitemstring(1, "modelli_des_est")   
//k_um = dw_dett_1.getitemstring(1, "modelli_um")   
//k_ass_colori = dw_dett_1.getitemstring(1, "modelli_ass_colori")   
//k_id_taglia = dw_dett_1.getitemstring(1, "modelli_id_taglia")   
//k_id_iva = dw_dett_1.getitemnumber(1, "modelli_id_iva")   
//k_id_fornitore = dw_dett_1.getitemnumber(1, "modelli_id_fornitore")   
//k_id_merce = dw_dett_1.getitemstring(1, "modelli_id_merce")   
//k_stagione = dw_dett_1.getitemstring(1, "modelli_stagione")   
//
//k_listino_1 = dw_dett_1.getitemnumber(1, "listini_listino_1")   
//k_listino_2 = dw_dett_1.getitemnumber(1, "listini_listino_2")   
//k_listino_3 = dw_dett_1.getitemnumber(1, "listini_listino_3")   
//k_listino_4 = dw_dett_1.getitemnumber(1, "listini_listino_4")   
//k_listino_5 = dw_dett_1.getitemnumber(1, "listini_listino_5")   
//
//k_composizione = dw_dett_1.getitemstring(1, "composizioni_composizione")   
//
//
////=== declare dei cursori per l'aggiornamento sulle tabelle complementari
//
//	DECLARE modelli_listini CURSOR FOR  
//		SELECT "listini"."id_modello"  
//    	FROM "listini"  
//   	WHERE "listini"."id_modello" = :k_id_modello or
//				"listini"."id_modello" = :k_id_modello_old ;
//
//
//	DECLARE modelli_composizioni CURSOR FOR  
//		SELECT "composizioni"."id_modello"  
//    	FROM "composizioni"  
//   	WHERE "composizioni"."id_modello" = :k_id_modello or
//				"composizioni"."id_modello" = :k_id_modello_old ;
//
////==================================================================
//
//
//
//if dw_dett_1.getitemstatus(1, 0, primary!) = datamodified! then
//
//  UPDATE "modelli"  
//     SET "id_modello" = :k_id_modello,   
//         "des_ita" = :k_des_ita,   
//         "des_est" = :k_des_est,   
//         "um" = :k_um,   
//         "ass_colori" = :k_ass_colori,   
//         "id_taglia" = :k_id_taglia,   
//         "id_iva" = :k_id_iva,   
//         "id_fornitore" = :k_id_fornitore,
//         "id_merce" = :k_id_merce,  
//         "stagione" = :k_stagione  
//		where "id_modello" = :k_id_modello_old ;
//
//	k_errore = sqlca.sqlcode
//	if k_errore <> 0 then
//		k_return = "1" + "Se e' stato modificato il codice, Modello gia' in archivio ~n~r" + &
//			trim(sqlca.sqlerrtext) + " (" + string(sqlca.sqlcode, "#####") + ") "
//	end if
//end if
//
//if k_errore = 0 then
//
//	if dw_dett_1.getitemstatus(1, "listini_listino_1", primary!) = datamodified! or &
//		dw_dett_1.getitemstatus(1, "listini_listino_2", primary!) = datamodified! or &
//		dw_dett_1.getitemstatus(1, "listini_listino_3", primary!) = datamodified! or &
//		dw_dett_1.getitemstatus(1, "listini_listino_4", primary!) = datamodified! or &
//		dw_dett_1.getitemstatus(1, "listini_listino_5", primary!) = datamodified! or &
//		dw_dett_1.getitemstatus(1, "modelli_id_modello", primary!) = datamodified! &
//		then
//		
////=== 
////=== Leggo il listino-modello : nuovo e attuale
////=== 
//		k_ctr = 0	
//		open modelli_listini  ;
//		if sqlca.sqlcode = 0 then
//			fetch modelli_listini into :k_id_modello_1 ;
//			if sqlca.sqlcode = 0 then
//				k_ctr++
//				fetch modelli_listini into :k_id_modello_2 ;
//				if sqlca.sqlcode = 0 then
//					k_ctr++
//				end if
//			end if		
//			close modelli_listini  ;
//		end if
//		
////=== Se ci sono 2 rek sicuramente esiste gia' il rek modelli_listini per il nuovo id  
////=== allora cancello il vecchio
//		if k_ctr = 2 or &
//			(k_id_modello <> k_id_modello_old and &
//		 	 k_ctr = 1 and k_id_modello = k_id_modello_1) then
//			kuf1_modelli = create kuf_modelli
//			kuf1_modelli.tb_delete_list(k_id_modello)
//			kuf1_data_base.db_commit()
//			k_ctr = 0
//		end if
//
//
////=== Insert della tabella dei Listini
//		if k_ctr = 0 then //Fare la INSERT
//
//	   	INSERT INTO "listini"  
//      		   (  "id_modello",   
//           			"listino_1",   
//			  			"listino_2",   
//           			"listino_3",   
//           			"listino_4",   
//           			"listino_5" )  
//		  			VALUES (
//						:k_id_modello, 
//						:k_listino_1,  
//	            	:k_listino_2,
//   	         	:k_listino_3,
//      	      	:k_listino_4,
//         	   	:k_listino_5
//		         	)  	;
//
//			k_errore = sqlca.sqlcode
//			if k_errore <> 0 then
//				k_return = "2" + "Listino Prezzi non registrato, riprova. ~r~n"+ &
//				trim(sqlca.sqlerrtext) + " (" + string(sqlca.sqldbcode, "#####") + ") "
//			end if
//
//
//		else   //fare la update
//	
//			UPDATE "listini"  
//    				  SET "id_modello" = :k_id_modello,   
//       			 		"listino_1" = :k_listino_1,   
//       			 		"listino_2" = :k_listino_2,   
//       			 		"listino_3" = :k_listino_3,   
//       			 		"listino_4" = :k_listino_4,   
//       			 		"listino_5" = :k_listino_5
//						where "id_modello" = :k_id_modello_old ;
//
//	
//			if sqlca.sqlcode <> 0 then
//					k_return = "2" + "Listino Prezzi non aggiornato, riprova. ~r~n"+ &
//					trim(sqlca.sqlerrtext) + " (" + string(sqlca.sqldbcode, "#####") + ") "
//			end if
//
//		end if
//
//	end if //Chiudo aggiornamenti Listini
//
////=== Faccio aggiornamenti sulla composizione
//	if dw_dett_1.getitemstatus(1, "composizioni_composizione", primary!) = datamodified!  &
//		then
//
//		
////=== 
////=== Leggo le composizioni : nuova e attuale
////=== 
//		k_ctr = 0	
//		open modelli_composizioni ;
//		if sqlca.sqlcode = 0 then
//			fetch modelli_composizioni into :k_id_modello_1 ;
//			if sqlca.sqlcode = 0 then
//				k_ctr++
//				fetch modelli_composizioni into :k_id_modello_2 ;
//				if sqlca.sqlcode = 0 then
//					k_ctr++
//				end if
//			end if		
//			close modelli_composizioni ;
//		end if
//		
////=== Se ci sono 2 rek sicuramente esiste gia' il rek modelli_listini per il nuovo id  
////=== allora cancello il vecchio
////=== Se 1 rek solo allora controllo che non sia x il codice nuovo 
////=== allora cancello il vecchio e inserisco il nuovo
//		if k_ctr = 2 or &
//			(k_id_modello <> k_id_modello_old and &
//			 k_ctr = 1 and k_id_modello = k_id_modello_1) then
//			kuf1_modelli = create kuf_modelli
//			kuf1_modelli.tb_delete_comp(k_id_modello)
//			kuf1_data_base.db_commit()
//			k_ctr = 0
//		end if
//
//
////=== Insert della tabella dei Composizioni
//		if k_ctr = 0 then //Fare la INSERT
//
//		  	INSERT INTO "composizioni"  
//      		   (  "id_modello",   
//           			"composizione"   
//           		)  
//		  			VALUES (
//						:k_id_modello, 
//						:k_composizione  
//		         	)  	;
//
//			k_errore = sqlca.sqlcode
//			if k_errore <> 0 then
//				if left(k_return, 1) = "0" then
//					k_return = "2" 
//				end if
//				k_return = k_return + "Composizione Tessuto non registrata, riprova. ~r~n"+ &
//						trim(sqlca.sqlerrtext) + " (" + string(sqlca.sqldbcode, "#####") + ") "
//			end if
//
//
//		else   //fare la update
//	
//			UPDATE "composizioni"  
//    				  SET "id_modello" = :k_id_modello,   
//       			 		"composizione" = :k_composizione   
//						where "id_modello" = :k_id_modello_old ;
//
//	
//			if sqlca.sqlcode <> 0 then
//				if left(k_return, 1) = "0" then
//					k_return = "2" 
//				end if
//				k_return = k_return + "Composizione Tessuto non aggiornata, riprova. ~r~n"+ &
//					 trim(sqlca.sqlerrtext) + " (" + string(sqlca.sqlcode, "#####") + ") "
//			end if
//
//		end if
//	end if
//
////=== Se il codice e' stato modificato allora aggiorno gli archivi complementari	
//	if k_id_modello <> k_id_modello_old then	
//
//		UPDATE "r_ordini"  
//    				  SET "id_modello" = :k_id_modello
//						where "id_modello" = :k_id_modello_old ;
//
//		UPDATE "r_sped"  
//    				  SET "id_modello" = :k_id_modello  
//						where "id_modello" = :k_id_modello_old ;
//
//		UPDATE "consumi"  
//    				  SET "id_modello" = :k_id_modello
//						where "id_modello" = :k_id_modello_old ;
//
//		UPDATE "r_fatt"  
//   				  SET "id_modello" = :k_id_modello 
//						where "id_modello" = :k_id_modello_old ;
//
//	end if
//end if
//
//
////=== resetta i buffer primary e delete
//dw_dett_1.ResetUpdate( )	

return (k_return)
end function

protected function integer ritorna ();//
string k_errore="0 "
string k_modif="0"


//=== Controllo se ho modificato dei dati nella DW DETTAGLIO
k_modif = left(dati_modif(), 1) 
if k_modif = "1" then //Fare gli aggiornamenti

//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
	k_errore = aggiorna_dati()		

else
	if k_modif = "3" then //Operazione annullata
		k_errore = "3"		
	end if

end if


return integer(left(k_errore, 1))

end function

public function string smista_funz (string k_par_in);//===
//=== Smista le chiamate esterne alla window a seconda delle funzionalita'
//=== richieste
//=== Usata per esempio dal menu popup
//=== Par. input : k_par_in stringa
//=== Ritorna ...: 0=tutto OK; 1=Errore
//===
string k_return="0 "


choose case left(k_par_in, 2) 

	case "ag"		// le liste di supporto (dddw)
		liste_varie()

	case "in"		//richiesta inserimento
		k_return = char(inserisci())

	case "ca"		//richiesta cancellazione
		k_return = char(cancella())

	case "co"		//richiesta conferma
		k_return = aggiorna_dati()

	case "st" 	//Stampa 
		kuf1_data_base.stampa_dw(dw_dett_1,"Procedura ECO", 0)

	case "ri"		//richiesta uscita
		cb_ritorna.triggerevent(clicked!)

end choose


return k_return



end function

protected subroutine liste_varie ();////
//datawindowchild  kdwc_iva, kdwc_taglie, kdwc_fornitori, kdwc_merce
//
//
////=== catturo gli handle dei drop_data_windows
//	dw_dett_1.getchild("modelli_id_iva", kdwc_iva)
//	dw_dett_1.getchild("modelli_id_taglia", kdwc_taglie)
//	dw_dett_1.getchild("modelli_id_fornitore", kdwc_fornitori)
//	dw_dett_1.getchild("modelli_id_merce", kdwc_merce)
////=== per evitare la richiesta del Argument_retrieval 
//	kdwc_iva.settransobject ( sqlca )
//	kdwc_taglie.settransobject ( sqlca )
//	kdwc_fornitori.settransobject ( sqlca )
//	kdwc_merce.settransobject ( sqlca )
//
//	kdwc_iva.retrieve(0)
//	kdwc_taglie.retrieve(" ")
//	kdwc_fornitori.retrieve(" ")
//	kdwc_merce.retrieve(" ")
//
//	kdwc_iva.insertrow(0)
//	kdwc_taglie.insertrow(0)
//	kdwc_fornitori.insertrow(0)
//	kdwc_merce.insertrow(0)
//
end subroutine

private subroutine duplica ();////
//string k_errore="0 "
//string k_id_modello
//long k_listino
//
//
////=== Controllo se ho modificato dei dati nella DW DETTAGLIO
//if left(dati_modif(), 1) = "1" then //Richisto Aggiornamento
//
////=== Controllo congruenza dei dati caricati e Aggiornamento  
////=== Ritorna 1 char : 0=tutto OK; 1=errore grave;
////===                : 2=errore non grave dati aggiornati;
////===			         : 3=LIBERO
////===      il resto della stringa contiene la descrizione dell'errore   
//	k_errore = aggiorna_dati()
//
//end if
//
//
//if left(k_errore, 1) = "0" then
//
////=== Disabilito il pulsante e il default al puls. aggiorna
////	this.enabled = false
////	cb_aggiorna.enabled = true	
////	cb_aggiorna.default = true
//
////=== Pulizia dei campi
//	attiva_tasti()
//
//
////=== Ripulisce i campi da non duplicare
//	setnull(k_listino)
//	dw_dett_1.setitem(1, "modelli_id_modello", "")
//	dw_dett_1.setitem(1, "listini_listino_1", k_listino)
//	dw_dett_1.setitem(1, "listini_listino_2", k_listino)
//	dw_dett_1.setitem(1, "listini_listino_3", k_listino)
//	dw_dett_1.setitem(1, "listini_listino_4", k_listino)
//	dw_dett_1.setitem(1, "listini_listino_5", k_listino)
//	
////=== Per "l'effetto" duplica
//	dw_dett_1.insertrow(0)
//	dw_dett_1.scrolltorow(2)
//	dw_dett_1.deleterow(2)
//
////=== Resetto lo status della riga
//	dw_dett_1.setitemstatus(1, 0, primary!, newmodified!)
//
////=== Posiziona il cursore sul Data Windows
//	dw_dett_1.setfocus() 
//
//end if
//
//
end subroutine

protected function integer check_esiste ();//
int k_return = 0
//string k_id_modello, k_id_modello_1, k_id_modello_old
//string k_des_ita
//
//
//dw_dett_1.accepttext()
//k_id_modello = trim(dw_dett_1.getitemstring(dw_dett_1.getrow(), "modelli_id_modello"))
//
//if len(k_id_modello) > 0 and &
//	dw_dett_1.getitemstatus(dw_dett_1.getrow(), "modelli_id_modello", primary!) = datamodified! then
//
//
//	SELECT "modelli"."id_modello",   
//          "modelli"."des_ita"  
//   	 INTO :k_id_modello_1,   
//      	   :k_des_ita  
//    	FROM "modelli"  
//   	WHERE "modelli"."id_modello" = :k_id_modello   ;
//
//	if k_id_modello = k_id_modello_1 then
//		if messagebox("Modello Trovato in Archivio", "Vuoi modificare il modello:~n~r"+ &
//				trim(k_des_ita), question!, yesno!, 2) = 1 then
//			inizializza(k_id_modello)
//			cb_cancella.enabled = true
//
//			dw_dett_1.setitemstatus(dw_dett_1.getrow(), "modelli_id_modello", &
//					primary!, notmodified!)
//		else
//			k_id_modello_old = dw_dett_1.getitemstring(dw_dett_1.getrow(), &
//						"modelli_id_modello", primary!, true) 
//			
//			if k_id_modello_old = k_id_modello then
//				setnull(k_id_modello_old)
//			end if
//			dw_dett_1.setitem(dw_dett_1.getrow(), "modelli_id_modello", &
//			  						k_id_modello_old)
//			cb_cancella.enabled = false
//		end if
//	end if  
//
//
//end if
//
//
return k_return

end function

protected function string inizializza ();//
//======================================================================
//=== Inizializzazione della Windows
//=== Ripristino DW; tasti; e retrieve liste
//=== Parametro IN : k_id_cliente
//=== Ritorna 1 chr : 0=Retrieve OK; 1=Retrieve fallita
//===    Dal 2 char in poi spiegazione errore
//======================================================================
//
string k_return="0 "
//long k_id_iva
//char k_id_taglia
//long k_id_fornitore
//
//
//	if isnull(k_id_modello) then
//		messagebox("Nessun Modello da ricercare", &
//			"Codice non Impostato. Ripetere la ricerca ~n~r" )
//		k_return = "1Nessun codice impostato"
//	else
//
//
////=== legge dw degli anagrafici
//		if dw_dett_1.retrieve(k_id_modello) > 0 then
//			k_return = "0 "
//
//
//		else
//			dw_dett_1.reset()
//		
//			k_return = "1Modello richiesto non in archivio "
//
//			messagebox("Modello richiesto non in archivio", &
//				"Codice non Trovato per la richiesta fatta ~n~r" + &
//				"(codice recercato :" + trim(k_id_modello) + ")~n~r" )
//			
//		end if
//	end if
//
// if left(k_return, 1) <> "0" then
//		cb_ritorna.postevent(clicked!)
//	else
//		attiva_tasti()
//	end if
//		
//
//
return k_return



end function

event open;//
//string k_id_modello
string k_scelta

//=== Mostra Finestra (maximizzata 61472)
send(handle(this), 274, 61728, 0)
//this.windowstate = maximized!

//=== Parametri passati con il WITHPARM
ki_st_open_w = message.powerobjectparm

k_scelta = trim(ki_st_open_w.flag_modalita)

//=== set transobject per il datawindows di dettaglio
dw_dett_1.settransobject ( sqlca )

//=== Posiziona window all'interno MDI 
//this.width = dw_dett_1.width + 40
//this.height = dw_dett_1.height + 105
if w_main.width > this.width then
	this.x = (w_main.width - this.width) / 4
else
	this.x = 1
end if
if w_main.height > this.height then
	this.y = (w_main.height - this.height) / 6
else
	this.y = 1
end if

//if trim(k_id_modello) <> "" and k_scelta = "in" then 
//
//	SELECT "modelli"."id_modello"  
//   	 INTO :k_id_modello   
//    	FROM "modelli"  
//   	WHERE "modelli"."id_modello" = :k_id_modello   ;
//
//	if sqlca.SQLCode = 0 then
//		k_scelta = "mo"
//	End If
//
//end if

//=== Fa le liste di supporto (dddw)
post liste_varie()

//=== Inizializzazione tasti e retrieve della Lista
if k_scelta = "in" then       //richiesta inserimento
	post inserisci()
else									//richiesta modifica
	cb_cancella.enabled = true
	post inizializza() 
end if

post attiva_tasti()

if dw_dett_1.visible = true then
	dw_dett_1.setrow(1)
	dw_dett_1.setcolumn(1)
	dw_dett_1.setfocus()
end if
//dw_dett_0.setrowfocusindicator ( Hand! )

end event
event rbuttondown;//
string k_stringa=""
long k_riga=0
string k_tag_old=""
string k_tag=""
m_popup m_menu



//=== Se sono sulla lista con il mouse allora posiziono il punt sul rek puntato
//k_stringa = dw_dett_0.GetObjectAtPointer()
//if k_stringa <> "" then
//	k_riga = long(right(k_stringa, len(k_stringa) - pos(k_stringa, "~t")))

//	if k_riga > 0 then 
		dw_dett_1.setrow(k_riga)
		dw_dett_1.setcolumn(1)

//=== Salvo il Tag attuale per reimpostarlo a fine routine
		k_tag_old = this.tag

//=== Creo menu Popup 
		m_menu = create m_popup

		m_menu.m_agglista.visible = true
		m_menu.m_t_agglista.visible = true
		m_menu.m_inserisci.visible = cb_inserisci.visible
		m_menu.m_inserisci.enabled = cb_inserisci.enabled
		m_menu.m_modifica.enabled = cb_aggiorna.visible
		m_menu.m_modifica.visible = cb_aggiorna.enabled
		m_menu.m_t_modifica.visible = true
		m_menu.m_cancella.visible = cb_cancella.visible
		m_menu.m_cancella.enabled = cb_cancella.enabled
		m_menu.m_t_cancella.visible = true
		m_menu.m_stampa.enabled = true
		m_menu.m_t_stampa.visible = true
		m_menu.m_conferma.visible = cb_aggiorna.visible
		m_menu.m_conferma.enabled = cb_aggiorna.enabled
		m_menu.m_ritorna.visible = true

//=== Attivo il menu Popup
		m_menu.visible = true
		m_menu.popmenu(this.x + pointerx(), this.y + pointery())
		m_menu.visible = false

		destroy m_menu

		k_tag = this.tag 

		this.tag = k_tag_old 


		if trim(k_tag) <> "" then
			smista_funz(k_tag)
		end if
		
//	end if
//end if


end event

event close;//
window k_window
//kuf_data_base kuf1_data_base

//kuf1_data_base = create kuf_data_base
k_window = kuf1_data_base.prendi_win_prec()

//=== per evitare che la windows a cui ritorna venga maximizzata
if isnull(k_window) = false then
	send(handle(this), 274, 61728, 0)

	k_window.windowstate = normal!
end if

//destroy kuf1_data_base

end event

event closequery;//
//=== Controllo prima della chiusura della Windows
int k_errore

	cb_ritorna.enabled = false

//=== Ritorna 1 char: 0=Tutto OK; 1=Errore grave; 
//===	              : 2=Errore Non grave dati aggiornati
//===               : 3=
	k_errore = ritorna()

	if k_errore <> 0 then
		attiva_tasti()
		return(1)  
	end if

	
end event

on w_g_tab_1.create
this.st_parametri=create st_parametri
this.cb_duplica=create cb_duplica
this.cb_ritorna=create cb_ritorna
this.cb_cancella=create cb_cancella
this.cb_aggiorna=create cb_aggiorna
this.cb_inserisci=create cb_inserisci
this.dw_dett_1=create dw_dett_1
this.Control[]={this.st_parametri,&
this.cb_duplica,&
this.cb_ritorna,&
this.cb_cancella,&
this.cb_aggiorna,&
this.cb_inserisci,&
this.dw_dett_1}
end on

on w_g_tab_1.destroy
destroy(this.st_parametri)
destroy(this.cb_duplica)
destroy(this.cb_ritorna)
destroy(this.cb_cancella)
destroy(this.cb_aggiorna)
destroy(this.cb_inserisci)
destroy(this.dw_dett_1)
end on

type st_parametri from statictext within w_g_tab_1
int X=1385
int Y=1448
int Width=247
int Height=72
boolean Visible=false
boolean Enabled=false
string Text="none"
boolean FocusRectangle=false
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_duplica from commandbutton within w_g_tab_1
int X=507
int Y=1400
int Width=343
int Height=96
int TabOrder=40
boolean Enabled=false
string Text="&Duplica"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//
duplica()
end event

type cb_ritorna from commandbutton within w_g_tab_1
int X=2304
int Y=1400
int Width=343
int Height=96
int TabOrder=30
string Text="&Ritorna"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//
close(parent)
end on

type cb_cancella from commandbutton within w_g_tab_1
int X=1591
int Y=1400
int Width=343
int Height=96
int TabOrder=20
boolean Enabled=false
string Text="&Elimina"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//
cancella()
end on

type cb_aggiorna from commandbutton within w_g_tab_1
int X=942
int Y=1400
int Width=343
int Height=96
int TabOrder=50
boolean Enabled=false
string Text="&Conferma"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//
aggiorna_dati()
end on

type cb_inserisci from commandbutton within w_g_tab_1
int X=78
int Y=1400
int Width=343
int Height=96
int TabOrder=60
string Text="&Nuovo"
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//
inserisci()
end on

type dw_dett_1 from datawindow within w_g_tab_1
event uevent_keydown pbm_dwnkey
int X=5
int Width=2894
int Height=1200
int TabOrder=10
boolean Border=false
boolean LiveScroll=true
end type

on uevent_keydown;//
//=== Controllo quale tasto da tastiera ha premuto


//if keydown(keyenter!) then
//	setactioncode(1)
//else
	if keydown(keyescape!) then
		close(parent)
	else
//=== se tasto delete allora: NULL sul campo in cui sono
		if keydown(keydelete!) then

			string k_tipo_campo

			k_tipo_campo = left(This.Describe(This.GetColumnName( ) + ".Coltype"), 3)

			CHOOSE CASE k_tipo_campo

				CASE "num", "dec" 
					int  k_null_num
					SetNull(k_null_num)
					This.SetItem(This.GetRow( ), This.GetColumn( ), k_null_num)

				CASE "dat" 
					date  k_null_date
					SetNull(k_null_date)
					This.SetItem(This.GetRow( ), This.GetColumn( ), k_null_date)

				CASE "str", "chr" 
					string k_null_string
					SetNull(k_null_string)
					This.SetItem(This.GetRow( ), This.GetColumn( ), k_null_string)

				CASE else
					string k_null_altro
					SetNull(k_null_altro)
					This.SetItem(This.GetRow( ), This.GetColumn( ), k_null_altro)

			END CHOOSE

		end if
	end if
//end if


end on

on rbuttondown;//
parent.triggerevent(rbuttondown!)

end on

event itemfocuschanged;//
int k_return=0


k_return = check_esiste() 
attiva_tasti()

if k_return = 1 then
	return 2
end if
end event

event dberror;//
CHOOSE CASE sqldbcode

	CASE -01,-02 
		MessageBox("Problemi sul DataBase",  &
			"Collegamento con il DataBase fallito.~n~r" &
			+ "Prego, provare a fare File-Apri DB dal menu")

	CASE -04
		MessageBox("Altri Utenti su questi dati",  &
			"Dati non piu' congruenti.~n~r" &
			+ "Modificati, poco fa, da altro utente !!")

END CHOOSE

kuf1_data_base.errori_db("W", "Cod.:" + string(sqldbcode) + &
									", " + SQLErrText )
//									" Utente : " + UserID)

RETURN 1 // Do not display system error message

end event

event losefocus;////
// Va in Loop su questo EVENTO
//
//int k_return=0
//
//
//k_return = check_esiste() 
//attiva_tasti()
//
//if k_return = 1 then
//	return 2
//end if
end event

