$PBExportHeader$kuf_wm_pbdom_xml_pkl_web.sru
forward
global type kuf_wm_pbdom_xml_pkl_web from nonvisualobject
end type
end forward

global type kuf_wm_pbdom_xml_pkl_web from nonvisualobject
end type
global kuf_wm_pbdom_xml_pkl_web kuf_wm_pbdom_xml_pkl_web

type variables
//
private PBDOM_Builder lpbdom_Builder
private PBDOM_Document lpbdom_Doc
private PBDOM_Object lpbdom_Obj[], lpbdom_Obj_liv1[], lpbdom_Obj_liv2[]
private PBDOM_Element lpbdom_Element
private PBDOM_Attribute lpbdom_Attr[]
end variables

forward prototypes
public subroutine set_xml (string ls_filename) throws uo_exception
public function boolean set_root () throws uo_exception
public subroutine crea_object ()
public function boolean set_figlio_liv1 () throws uo_exception
public function boolean set_figlio_root () throws uo_exception
public function boolean set_figlio_liv2 () throws uo_exception
public function string get_valore_liv1 (long k_ind)
public function string get_tag_liv1 (long k_ind)
public function long get_nr_tag_liv1 ()
public function long get_nr_tag_liv2 ()
public function long get_nr_tag_root ()
public function string get_tag_liv2 (long k_ind)
public function string get_tag_root (long k_ind)
public function string get_valore_liv2 (long k_ind)
public function string get_valore_root (long k_ind)
public function string get_attributo (string k_nome, long k_ind)
public subroutine _doc_xml ()
end prototypes

public subroutine set_xml (string ls_filename) throws uo_exception;//---
//--- Legge il flusso XML
//---
boolean lb_test=true
st_esito kst_esito


try

	if trim(ls_filename) > " " then
		if FileExists(ls_filename) then
			if isvalid(lpbdom_Builder) then
				lpbdom_Doc = lpbdom_Builder.BuildFromFile(ls_filename)
			else
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlcode = 0
				kst_esito.nome_oggetto = this.classname()
				kst_esito.sqlerrtext = "Acquisizione non riuscita del file: " + trim(ls_filename) &
				      + "~n~r"  + "Errore: oggetto programma non 'pronto' per questa operazione. " + "~n~r" &
					  + "Prego riprovare.  "
				kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
		else
			kst_esito.esito = kkg_esito.no_esecuzione
			kst_esito.sqlcode = 0
			kst_esito.nome_oggetto = this.classname()
			kst_esito.sqlerrtext = "Acquisizione non riuscita, file non trovato: " + trim(ls_filename) &
				+ "~n~r"  + "Controllare manualmente l'esistenza nel file server (con Esplora Risorse). " 
			kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if
	else
		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlcode = 0
		kst_esito.nome_oggetto = this.classname()
		kst_esito.sqlerrtext = "Il file da Acquisire non Indicatto " &
					+ "~n~r"  &
				    + "Prego riprovare.  "
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
	end if

//--- se c'e' un problema nel parser.... 
catch (PBDOM_Exception lpbdom_Except)

	kst_esito.esito = kkg_esito.no_esecuzione
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()

	kst_esito.sqlerrtext = "Carico del file XML Fallito (parser). Errore: " + string(lpbdom_Except.getexceptioncode( ))+ "~n~r" &
		  + "descrizione: " +trim(lpbdom_Except.text)+ "~n~r" &
		  + "File: " +string(ls_filename)

	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception

catch (uo_exception kuo_exception)
	kst_esito.esito = kkg_esito.no_esecuzione
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()

	kst_esito.sqlerrtext = "Carico del file XML genericamente Fallito. ~n~r" &
		  + "File: " +string(ls_filename)

	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
	kguo_exception.set_esito(kst_esito)
	throw kuo_exception
	

	
end try

end subroutine

public function boolean set_root () throws uo_exception;//---
//--- Posizione sul root del doc xml
//--- out: true=ok da elaborare, false=nulla
//---
long li_max, li_counter
boolean k_return =false
st_esito kst_esito


if isvalid(lpbdom_Doc) then //lpbdom_Doc rappresenta il documento xml

	lpbdom_Doc.GetContent( lpbdom_Obj ) //lpbdom_Obj riempie oggetto con i nodi del documento

	if UpperBound( lpbdom_Obj ) > 0 then
		k_return = true

	end if

else
//--- se c'e' un problema nel parser.... 

	kst_esito.esito = kkg_esito.no_esecuzione
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()

		
	kst_esito.sqlerrtext = "Posizionamento sulla root del file XML Fallito. "

	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
	
end if

return k_return

end function

public subroutine crea_object ();
end subroutine

public function boolean set_figlio_liv1 () throws uo_exception;//---
//--- Posizione sul root del doc xml
//--- out: true=ok da elaborare, false=nulla
//---
boolean k_return =false
st_esito kst_esito


if isvalid(lpbdom_Element) then //lpbdom_Doc rappresenta il documento xml

//	lpbdom_doc.GetContent(lpbdom_Obj_liv1) // mi posiziono sull'elemento
	lpbdom_Element.GetContent(lpbdom_Obj_liv1) // mi posiziono sull'elemento

	if UpperBound( lpbdom_Obj_liv1 ) > 0 then
		k_return = true
	end if

else
//--- se c'e' un problema nel parser.... 

	kst_esito.esito = kkg_esito.no_esecuzione
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()
		
	kst_esito.sqlerrtext = "Posizionamento sull'Elemento del file XML Fallito. " 

	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
	
end if

return k_return

end function

public function boolean set_figlio_root () throws uo_exception;//---
//--- Posizione sul root del doc xml
//--- out: true=ok da elaborare, false=nulla
//---
boolean k_return =false
st_esito kst_esito


//if isvalid(lpbdom_Element) then //lpbdom_Doc rappresenta il documento xml
if isvalid(lpbdom_doc) then //lpbdom_Doc rappresenta il documento xml

	lpbdom_doc.GetContent(lpbdom_Obj) // mi posiziono sull'elemento

	if UpperBound( lpbdom_Obj ) > 0 then
		
		k_return = true
		pbdom_Element = lpbdom_Obj[1]	
		
	end if

else
//--- se c'e' un problema nel parser.... 

	kst_esito.esito = kkg_esito.no_esecuzione
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()
		
	kst_esito.sqlerrtext = "Posizionamento sull'Elemento del file XML Fallito. " 

	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
	
end if

return k_return

end function

public function boolean set_figlio_liv2 () throws uo_exception;//---
//--- Posizione sul root del doc xml
//--- out: true=ok da elaborare, false=nulla
//---
boolean k_return =false
st_esito kst_esito


if isvalid(lpbdom_Element) then 

	lpbdom_Element.GetContent(lpbdom_Obj_liv2) // mi posiziono sull'elemento

	if UpperBound( lpbdom_Obj_liv2 ) > 0 then
		k_return = true
	end if

else
//--- se c'e' un problema nel parser.... 

	kst_esito.esito = kkg_esito.no_esecuzione
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()
		
	kst_esito.sqlerrtext = "Posizionamento sull'Elemento del file XML Fallito. " 

	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
	
end if

return k_return

end function

public function string get_valore_liv1 (long k_ind);//---
//--- Torna il valore dell'elemento tag su cui è (prima chiamare il get_tag(index))
//---
string k_return=""
st_esito kst_esito
//pbdom_PROCESSINGINSTRUCTION kpbdom_PROCESSINGINSTRUCTION


//lpbdom_Element = lpbdom_Obj[k_ind
//k_return = lower(lpbdom_Obj_liv1[k_ind].GetTextTrim())
k_return = lpbdom_Obj_liv1[k_ind].GetTextTrim()
if isnull(k_return) then
	k_return = ""
end if

//CHOOSE CASE lpbdom_Obj[k_ind].GetObjectClassString()
//	
//	CASE "pbdom_processinginstruction"
////		kpbdom_PROCESSINGINSTRUCTION = lpbdom_Obj[k_ind].GetObjectClass()
////		k_return = kpbdom_PROCESSINGINSTRUCTION.GetData()
//		k_return = lpbdom_Obj[k_ind].GetText()
//	
//	CASE "pbdom_text"
//		k_return = lpbdom_Obj[k_ind].GetText()
//
//	CASE "pbdom_element"		
//		k_return = ""
//		
//	CASE ELSE	
//		k_return = lpbdom_Obj[k_ind].GetText()
//		
//end choose
	

return k_return
end function

public function string get_tag_liv1 (long k_ind);//---
//--- Torna il nome del TAG
//---
string k_return=""
st_esito kst_esito



if k_ind > 0 and k_ind <= get_nr_tag_liv1() then
	
		k_return = lpbdom_Obj_liv1[k_ind].GetName( )
		lpbdom_Element = lpbdom_Obj_liv1[k_ind]
	
else
	k_return = ""
	
end if


return k_return
end function

public function long get_nr_tag_liv1 ();//---
//--- Torna il numero di TAG presenti nel documento
//---
long k_return=0
st_esito kst_esito


k_return = UpperBound( lpbdom_Obj_liv1 )

if isnull(k_return) then
	
	k_return = 0

end if


return k_return
end function

public function long get_nr_tag_liv2 ();//---
//--- Torna il numero di TAG presenti nel documento
//---
long k_return=0
st_esito kst_esito


k_return = UpperBound( lpbdom_Obj_liv2 )

if isnull(k_return) then
	
	k_return = 0

end if


return k_return
end function

public function long get_nr_tag_root ();//---
//--- Torna il numero di TAG presenti nel documento
//---
long k_return=0
st_esito kst_esito


k_return = UpperBound( lpbdom_Obj )

if isnull(k_return) then
	
	k_return = 0

end if


return k_return
end function

public function string get_tag_liv2 (long k_ind);//---
//--- Torna il nome del TAG
//---
string k_return=""
st_esito kst_esito



if k_ind > 0 and k_ind <= get_nr_tag_liv2() then
	
	k_return = lpbdom_Obj_liv2[k_ind].GetName( )
	lpbdom_Element = lpbdom_Obj_liv2[k_ind]
	
else
	k_return = ""
	
end if


return k_return
end function

public function string get_tag_root (long k_ind);//---
//--- Torna il nome del TAG
//---
string k_return=""
st_esito kst_esito



if k_ind > 0 and k_ind <= get_nr_tag_root() then
	
	k_return = lpbdom_Obj[k_ind].GetName( )
	lpbdom_Element = lpbdom_Obj[k_ind]

	
else
	k_return = ""
	
end if


return k_return
end function

public function string get_valore_liv2 (long k_ind);//---
//--- Torna il valore dell'elemento tag su cui è (prima chiamare il get_tag(index))
//---
string k_return="" 
st_esito kst_esito
//pbdom_PROCESSINGINSTRUCTION kpbdom_PROCESSINGINSTRUCTION


//lpbdom_Element = lpbdom_Obj[k_ind
k_return = (lpbdom_Obj_liv2[k_ind].GetTextTrim())
if isnull(k_return) then
	k_return = ""
end if

//CHOOSE CASE lpbdom_Obj[k_ind].GetObjectClassString()
//	
//	CASE "pbdom_processinginstruction"
////		kpbdom_PROCESSINGINSTRUCTION = lpbdom_Obj[k_ind].GetObjectClass()
////		k_return = kpbdom_PROCESSINGINSTRUCTION.GetData()
//		k_return = lpbdom_Obj[k_ind].GetText()
//	
//	CASE "pbdom_text"
//		k_return = lpbdom_Obj[k_ind].GetText()
//
//	CASE "pbdom_element"		
//		k_return = ""
//		
//	CASE ELSE	
//		k_return = lpbdom_Obj[k_ind].GetText()
//		
//end choose
	

return k_return
end function

public function string get_valore_root (long k_ind);//---
//--- Torna il valore dell'elemento tag su cui è (prima chiamare il get_tag(index))
//---
string k_return=""
st_esito kst_esito
//pbdom_PROCESSINGINSTRUCTION kpbdom_PROCESSINGINSTRUCTION


//lpbdom_Element = lpbdom_Obj[k_ind
k_return = lower(lpbdom_Obj[k_ind].GetTextTrim())
if isnull(k_return) then
	k_return = ""
end if

//CHOOSE CASE lpbdom_Obj[k_ind].GetObjectClassString()
//	
//	CASE "pbdom_processinginstruction"
////		kpbdom_PROCESSINGINSTRUCTION = lpbdom_Obj[k_ind].GetObjectClass()
////		k_return = kpbdom_PROCESSINGINSTRUCTION.GetData()
//		k_return = lpbdom_Obj[k_ind].GetText()
//	
//	CASE "pbdom_text"
//		k_return = lpbdom_Obj[k_ind].GetText()
//
//	CASE "pbdom_element"		
//		k_return = ""
//		
//	CASE ELSE	
//		k_return = lpbdom_Obj[k_ind].GetText()
//		
//end choose
	

return k_return
end function

public function string get_attributo (string k_nome, long k_ind);//---
//--- Torna il valore dell'attributo indicato
//---
string k_return=""
st_esito kst_esito
pbdom_Element kpbdom_Element


kpbdom_Element = lpbdom_Obj[k_ind]	

IF kpbdom_Element.HasAttributes() THEN
	k_return = kpbdom_Element.GetAttributeValue (k_nome)
end if

if isnull(k_return) then
	k_return = ""
end if


return k_return
end function

public subroutine _doc_xml ();//I tag riportati in rosso sono obbligatori, si veda per chiarimenti la tabella esplicativa riportata più avanti in questo documento.
//
//<?xml version="1.0" encoding="utf-8"?>
//<pkl id="1">
//	<tipo_invio>FTP</tipo_invio>    (testo 'FTP' fisso x tutte le pk-list)
//	<id_cliente>460</id_cliente>
//	<mandante>460</mandante>
//	<id_contratto></id_contratto>
//	<data_invio>18-03-2009</data_invio>
//	<ora_invio>15:57</ora_invio>
//	<contratto_commerciale>38/2009</contratto_commerciale>
//	<capitolato_fornitura>59/00</capitolato_fornitura>
//	<id_utente></id_utente>
//	<ragione_sociale_utente>ARAN PACKAGING</ragione_sociale_utente>
//	<indirizzo_utente></indirizzo_utente>
//	<cap_utente></cap_utente>
//	<localita_utente></localita_utente>
//	<provincia_utente></provincia_utente>
//	<nazione_utente></nazione_utente>
//	<email_utente></email_utente>
//	<email1_utente></email1_utente>
//	<email2_utente></email2_utente>
//	<nr_ddt>A90039</nr_ddt>
//	<data_ddt>18-03-2009</data_ddt>
//	<nr_tot_colli>6</nr_tot_colli>
//	<ricevente_merce>460</ricevente_merce>
//	<ricevente_fattura>460</ricevente_fattura>
//	<codice_lotto>H902256_2</codice_lotto>    (questo dato ha la precedenza sul tag <barcode_lotto> )
//	<note_lotto>ALGOFLON</note_lotto>
//	<deperibile>N</deperibile>
//	
//	<pkl_etichette id="1">
//		<barcode>M901625</barcode>
//		<barcode_lotto>110005020</barcode_lotto>
//		<barcode_note>5LT L8SL3-A ASEPT.PLAST BAGS</barcode_note>
//		<barcode_ peso netto>354.70</barcode_ peso netto>
//		<barcode_ peso lordo>371.00</barcode_ peso lordo>
//		<barcode_ qta_pezzi>18</barcode_ qta_pezzi>
//	</pkl_etichette>
//
//	<pkl_etichette id="2">
//		<barcode>M901637</barcode>
//		<barcode_lotto>110005020</barcode_lotto>
//		<barcode_note>5LT L8SL3-A ASEPT.PLAST BAGS</barcode_note>
//		<barcode_ peso netto>354.50</barcode_ peso netto>
//		<barcode_ peso lordo>371.00</barcode_ peso lordo>
//		<barcode_ qta_pezzi>18</barcode_ qta_pezzi>
//	</pkl_etichette>
//
//	<pkl_etichette id="3">
//		<barcode>M901642</barcode>
//		<barcode_lotto>110005020</barcode_lotto>
//		<barcode_note>5LT L8SL3-A ASEPT.PLAST BAGS</barcode_note>
//		<barcode_ peso netto>354.50</barcode_ peso netto>
//		<barcode_ peso lordo>371.00</barcode_ peso lordo>
//		<barcode_ qta_pezzi>18</barcode_ qta_pezzi>
//	</pkl_etichette>
//
//	<pkl_etichette id="4">
//		<barcode>M901643</barcode>
//		<barcode_lotto>110005020</barcode_lotto>
//		<barcode_note>5LT L8SL3-A ASEPT.PLAST BAGS</barcode_note>
//		<barcode_ peso netto>354.50</barcode_ peso netto>
//		<barcode_ peso lordo>371.00</barcode_ peso lordo>
//		<barcode_ qta_pezzi>18</barcode_ qta_pezzi>
//	</pkl_etichette>
//
//	<pkl_etichette id="5">
//		<barcode>M901656</barcode>
//		<barcode_lotto>110005020</barcode_lotto>
//		<barcode_note>5LT L8SL3-A ASEPT.PLAST BAGS</barcode_note>
//		<barcode_ peso netto>354.50</barcode_ peso netto>
//		<barcode_ peso lordo>371.00</barcode_ peso lordo>
//		<barcode_ qta_pezzi>18</barcode_ qta_pezzi>
//	</pkl_etichette>
//
//	<pkl_etichette id="6">
//		<barcode>M901617</barcode>
//		<barcode_lotto>110005020</barcode_lotto>
//		<barcode_note>5LT L8SL3-A ASEPT.PLAST BAGS</barcode_note>
//		<barcode_peso_netto>341.50</barcode_peso_netto>
//		<barcode_peso_lordo>358.00</barcode_peso_lordo>
//		<barcode_qta_pezzi>18</barcode_qta_pezzi>
//	</pkl_etichette>
//
//</pkl>
//
//
//
//
//
//Vediamo in dettaglio il significato di ogni singolo tag.
//Vediamo in dettaglio il                                                                                
//                                                                                                       
//nome tag                Valore in esempio      Obbligatorio                                            descrizione                                                                    
//tipo_invio              FTP                     Si                                                      Deve essere sempre FTP. Utile x riconoscere il tipo di invio effettuato        
//id_cliente                                  460 Si, se manca il tag mandante                            ID cliente assegnato da Gammarad 
//(formato numerico)                           
//mandante                                    460 Si, se manca il tag id_cliente                          Il codice di riconoscimento di chi invia  il d.d.t..
//Indicare uno dei seguenti 
//ricevente_merce                             460 No, se è uguale al tag mandante                         Il codice di riconoscimento di chi riceve la merce dopo il trattamento.
//Indicar
//ricevente_fattura                           460 No, se è uguale al tag mandante                         Il codice di riconoscimento di chi riceve la fattura.
//Indicare uno dei seguenti
//data_invio              03-02-2009              No                                                      Data di invio di questo documento                                              
//ora_invio               15:57                   No                                                      Ora di invio di questo documento                                               
//id_contratto                                    Si, se manca il tag                                     Codice del Contratto assegnato da Gammarad che associa il Commerciale con il Ca
//contratto_commerciale   38/2009                 Si, se manca il tag                                     Codice del Contratto Commerciale attivo con Gammarad                           
//capitolato_fornitura    059/00                  No, ma richiesto                                        Codice del Contratto del Capitolato attivo con Gammarad                        
//id_utente                                       No                                                      ID utente Web, assegnato da Gammarad                                           
//ragione_sociale_utente  ARAN PACKAGING          No. In presenza del tag id_utente non è preso in consiod Ragione sociale di chi invia il packing-list, nel tag nazione_utente indicare i
//indirizzo_utente                                No. In presenza del tag id_utente non è preso in consiod Ragione sociale di chi invia il packing-list, nel tag nazione_utente indicare i
//cap_utente                                      No. In presenza del tag id_utente non è preso in consiod Ragione sociale di chi invia il packing-list, nel tag nazione_utente indicare i
//localita_utente                                 No. In presenza del tag id_utente non è preso in consiod Ragione sociale di chi invia il packing-list, nel tag nazione_utente indicare i
//provincia_utente                                No. In presenza del tag id_utente non è preso in consiod Ragione sociale di chi invia il packing-list, nel tag nazione_utente indicare i
//nazione_utente                                  No. In presenza del tag id_utente non è preso in consiod Ragione sociale di chi invia il packing-list, nel tag nazione_utente indicare i
//email_utente                                    No. In presenza del tag id_utente non è preso in consiod Ragione sociale di chi invia il packing-list, nel tag nazione_utente indicare i
//email_utente1                                   No. In presenza del tag id_utente non è preso in consiod Ragione sociale di chi invia il packing-list, nel tag nazione_utente indicare i
//email_utente2                                   No. In presenza del tag id_utente non è preso in consiod Ragione sociale di chi invia il packing-list, nel tag nazione_utente indicare i
//nr_ddt                  A90039                  Si                                                      Numero della bolla di spedizione                                               
//data_ddt                               03/02/09 Si                                                      Data della bolla di spedizione (formato dd-mm-yyyy)
//nr_tot_colli                                 22 Si                                                      Numero dei colli in bolla di spedizione(formato numerico intero)              
//codice_lotto            H902256_2               No – Consigliato                                        Codice del lotto assegnato dal cliente; può essere utilizzato in futuro per tra
//note_lotto              ALGOFLON                No                                                      Note descrittive assegnate dal cliente poi stampate in automatico nel “Attestat
//deperibile               N                               No                                                 Informazione se il lotto contiene beni deperibili 
//pkl_etichette           1 (Attrib.)             Si                                                      L'attributo id identifica il numero progressivo dell'etichetta del collo       
//barcode                 M901625                 Si                                                      Il codice del barcode presente in etichetta attaccata al collo                 
//barcode_item                          110005020 No                                                      Codice lotto associato al singolo collo; dato arbitrario a cura del cliente    
//barcode_lotto                         110005020 No - obsoleto                                           Codice lotto; dato arbitrario a cura del cliente – Alternativo al tag <codice_l
//barcode_note            5LT L8SL3-A ASEPT.PLAST No                                                      Note descrittive associate al singolo collo; dato arbitrario a cura del cliente
//barcode_ peso_netto                   355.10.00 No                                                      Peso netto del singolo collo, inteso senza imballo; dato arbitrario a cura del 
//barcode_ peso_lordo                   371.00.00 No                                                      Peso lordo del singolo collo, inteso comprensivo di imballo; dato arbitrario a 
//barcode_ qta_pezzi                           18 No                                                      Numero delle scatole che compongono il collo; dato arbitrario a cura del client
//
end subroutine

on kuf_wm_pbdom_xml_pkl_web.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_wm_pbdom_xml_pkl_web.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
if isvalid(lpbdom_Builder) then destroy lpbdom_Builder
if isvalid(lpbdom_Doc) then destroy lpbdom_Doc
if isvalid(lpbdom_Element) then destroy lpbdom_Element


end event

event constructor;//
lpbdom_Builder = CREATE PBDOM_BUILDER

end event

