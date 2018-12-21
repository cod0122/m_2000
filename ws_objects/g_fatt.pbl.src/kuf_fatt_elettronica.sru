$PBExportHeader$kuf_fatt_elettronica.sru
forward
global type kuf_fatt_elettronica from nonvisualobject
end type
end forward

global type kuf_fatt_elettronica from nonvisualobject
end type
global kuf_fatt_elettronica kuf_fatt_elettronica

type variables
//

private kuf_fatt kiuf_fatt
private kuf_clienti kiuf_clienti	
private st_tab_arfa ki_st_tab_arfa

end variables

forward prototypes
public function boolean u_open () throws uo_exception
private function integer ufo_v12_nodo1_1 (ref st_fatt_elettronica ast_fatt_elettronica, pbdom_element apbdom_element_padre) throws uo_exception
public function integer esporta_fatt (ref st_fatt_elettronica ast_fatt_elettronica) throws uo_exception
end prototypes

public function boolean u_open () throws uo_exception;//---
//--- Apre file XML x scrivere la fattura elettronica
//---
//--- out boolean TRUE=ok 
//---
boolean k_return = false


return k_return

end function

private function integer ufo_v12_nodo1_1 (ref st_fatt_elettronica ast_fatt_elettronica, pbdom_element apbdom_element_padre) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Fatture XML formato Fattura Elettronica V.1.2 nodo 1.1 <DatiTrasmissione>
//--- 
//--- Input: numero+data fattura da... a... + nome_file = path dove salvare il file delle fatture elettroniche (formato XML)
//--- out: nome_file (l'ultimo)
//--- Rit: numero fatture scritte sul file 
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
int k_return=0
int k_pos, k_pos_1
boolean k_rc=true
long k_riga, k_righe, k_ind, k_filenum, k_byte, k_nr_fatt=0
string k_nome_file, k_path, k_modpag, k_file_xml="", k_record=""
decimal{4} k_aliq_iva,	k_imponibile, k_imposta, k_tot_doc 
st_tab_arfa kst_tab_arfa
st_fattura_scadenze kst_fattura_scadenze
st_fatt_elettronica kst_fatt_elettronica[]
kuf_utility kuf1_utility
st_esito kst_esito
datastore kds_fatt_elett_testa, kds_fatt_elett_righe, kds_rag_soc, kds_fatt_elett_iva
PBDOM_Document kpbdom_doc
PBDOM_Element kpbdom_el_node_1, kpbdom_el_node_2, kpbdom_el_node_3
PBDOM_PROCESSINGINSTRUCTION kpbdom_proc

	
setpointer(kkg.pointer_attesa)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

	kpbdom_el_node_1 = create PBDOM_Element
	kpbdom_el_node_2 = create PBDOM_Element
	kpbdom_el_node_3 = create PBDOM_Element

	//  "<DatiTrasmissione>"
	kpbdom_el_node_1.setname("DatiTrasmissione")
			
	//  "<IdTrasmittente>"
		kpbdom_el_node_2.setname("IdTrasmittente")
		kpbdom_el_node_1.addcontent(kpbdom_el_node_2)
		//      "<IdPaese>" 
			kpbdom_el_node_3.setname("IdPaese")
			kpbdom_el_node_3.addcontent("IT")
			kpbdom_el_node_2.addcontent(kpbdom_el_node_3)
			//      "<IdCodice>" 
			destroy kpbdom_el_node_3; kpbdom_el_node_3 = create PBDOM_Element
			kpbdom_el_node_3.setname("IdCodice")
			kpbdom_el_node_3.addcontent(trim(kds_rag_soc.getitemstring(1, "cf")))
			kpbdom_el_node_2.addcontent(kpbdom_el_node_3)

		//    "<ProgressivoInvio>" 
		kpbdom_el_node_2.setname("ProgressivoInvio")
		kpbdom_el_node_2.addcontent(string(kds_fatt_elett_testa.getitemnumber(k_riga, "arfa_testa_id_fattura")))
		kpbdom_el_node_1.addcontent(kpbdom_el_node_2)
		
		//    "<FormatoTrasmissione>"
		destroy kpbdom_el_node_2; kpbdom_el_node_2 = create PBDOM_Element
		kpbdom_el_node_2.setname("FormatoTrasmissione")
		kpbdom_el_node_2.addcontent("FPA12")
		kpbdom_el_node_1.addcontent(kpbdom_el_node_2)

		//    "<CodiceDestinatario>" 
		destroy kpbdom_el_node_2; kpbdom_el_node_2 = create PBDOM_Element
		kpbdom_el_node_2.setname("CodiceDestinatario")
		kpbdom_el_node_2.addcontent(trim(kds_fatt_elett_testa.getitemstring(k_riga, "codice_ipa")))
		kpbdom_el_node_1.addcontent(kpbdom_el_node_2)

		//    "<ContattiTrasmittente>"
		destroy kpbdom_el_node_2; kpbdom_el_node_2 = create PBDOM_Element
		kpbdom_el_node_2.setname("ContattiTrasmittente")
		kpbdom_el_node_1.addcontent(kpbdom_el_node_2)
			//      "<Telefono>" 
			destroy kpbdom_el_node_3; kpbdom_el_node_3 = create PBDOM_Element
			kpbdom_el_node_3.setname("Telefono")
			kpbdom_el_node_3.addcontent(trim(kds_rag_soc.getitemstring(1, "telefono")))
			kpbdom_el_node_2.addcontent(kpbdom_el_node_3)
			//      "<Email>"
			destroy kpbdom_el_node_3; kpbdom_el_node_3 = create PBDOM_Element
			kpbdom_el_node_3.setname("Email")
			kpbdom_el_node_3.addcontent(trim(kds_rag_soc.getitemstring(1, "e_mail")))
			kpbdom_el_node_2.addcontent(kpbdom_el_node_3)

	apbdom_element_padre.addcontent(kpbdom_el_node_1)

CATCH ( PBDOM_Exception pbde )
	kguo_exception.inizializza( )
	kguo_exception.setmessage( "Errore durante Generazione XML", pbde.getmessage() )
	throw kguo_exception
	
catch (uo_exception kuo_exception) 
	throw kuo_exception
	
finally
	if isvalid(kpbdom_el_node_1) then destroy kpbdom_el_node_1
	if isvalid(kpbdom_el_node_2) then destroy kpbdom_el_node_2
	if isvalid(kpbdom_el_node_3) then destroy kpbdom_el_node_3

end try

return k_return


end function

public function integer esporta_fatt (ref st_fatt_elettronica ast_fatt_elettronica) throws uo_exception;//
//--------------------------------------------------------------------------------------------------------------
//--- Esporta Fatture nel formato XML (formato PA fattura elettronica V.1.2 dal 1/1/2017)
//--- 
//--- Input: numero+data fattura da... a... + nome_file = path dove salvare il file delle fatture elettroniche (formato XML)
//--- out: nome_file (l'ultimo)
//--- Rit: numero fatture scritte sul file 
//--- Lancia EXCEPTION se errori gravi 
//--- 
//--------------------------------------------------------------------------------------------------------------
int k_return=0
int k_pos, k_pos_1
boolean k_rc=true
long k_riga, k_righe, k_ind, k_filenum, k_byte, k_nr_fatt=0
string k_nome_file, k_path, k_modpag, k_file_xml="", k_record="", k_namespace
decimal{4} k_aliq_iva,	k_imponibile, k_imposta, k_tot_doc 
st_tab_arfa kst_tab_arfa
st_fattura_scadenze kst_fattura_scadenze
st_fatt_elettronica kst_fatt_elettronica[]
kuf_utility kuf1_utility
st_esito kst_esito
datastore kds_fatt_elett_testa, kds_fatt_elett_righe, kds_rag_soc, kds_fatt_elett_iva
PBDOM_Document kpbdom_doc
PBDOM_Element kpbdom_el_root, kpbdom_el_node1, kpbdom_el_node11, kpbdom_el_node111, kpbdom_el_node1111, kpbdom_el_node11111
PBDOM_PROCESSINGINSTRUCTION kpbdom_proc

	
setpointer(kkg.pointer_attesa)

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

try

//--- definizione datastore x estrazione dati
	kds_fatt_elett_testa = create datastore
	kds_fatt_elett_testa.dataobject = "ds_arfa_testata"  // dati testata + anagrafica Cliente (PA) della Fattura
	kds_fatt_elett_testa.settransobject( kguo_sqlca_db_magazzino )
	kds_fatt_elett_righe = create datastore
	kds_fatt_elett_righe.dataobject = "ds_arfa_righe"  // righe fattura
	kds_fatt_elett_righe.settransobject( kguo_sqlca_db_magazzino )
	kds_fatt_elett_iva = create datastore
	kds_fatt_elett_iva.dataobject = "ds_arfa_tot_iva"  // totali IVA x Aliq/Natuta della fattura
	kds_fatt_elett_iva.settransobject( kguo_sqlca_db_magazzino )
	kds_rag_soc = create datastore
	kds_rag_soc.dataobject = "ds_base_ragsoc"  // dati base azienda 
	kds_rag_soc.settransobject( kguo_sqlca_db_magazzino )

	kuf1_utility = create kuf_utility  // ultility generiche

//--- lancia estrazione fatture 
	k_righe = kds_fatt_elett_testa.retrieve(ast_fatt_elettronica.num_fattura_da, ast_fatt_elettronica.data_fattura_da, ast_fatt_elettronica.num_fattura_a,  ast_fatt_elettronica.data_fattura_a ) 
	
	if k_righe = 0 then

		kst_esito.esito = kkg_esito.no_esecuzione
		kst_esito.sqlerrtext = "Nessuna Fattura/N.C. trovata da esportare nel formato XML "
		kguo_exception.inizializza( )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception

	else

//		k_nome_file = kuf1_utility.u_get_nome_file(ast_fatt_elettronica.nome_file )
//		k_path = kuf1_utility.u_get_path_file(ast_fatt_elettronica.nome_file)
		k_path = ast_fatt_elettronica.nome_file
		if len(k_path) > 0 then
			kguo_path.u_drectory_create(k_path)
		end if
		
//--- get dati Azienda
		kds_rag_soc.retrieve()

		for k_riga = 1 to k_righe
			
			kst_tab_arfa.id_fattura = kds_fatt_elett_testa.getitemnumber(k_riga, "arfa_testa_id_fattura")
			kst_tab_arfa.clie_3 = kds_fatt_elett_testa.getitemnumber(k_riga, "clienti_codice")
			kst_tab_arfa.num_fatt = kds_fatt_elett_testa.getitemnumber(k_riga, "num_fatt")
			kst_tab_arfa.data_fatt = kds_fatt_elett_testa.getitemdate(k_riga, "data_fatt")
			kds_fatt_elett_righe.retrieve(kst_tab_arfa.id_fattura)   // leggo dettaglio righe
			kds_fatt_elett_iva.retrieve(kst_tab_arfa.id_fattura)   // leggo i totali IVA
			kst_esito = kiuf_fatt.get_scadenze(kst_tab_arfa, kst_fattura_scadenze)  // legge scadenze
			if kst_esito.esito <> kkg_esito.ok and kst_esito.esito <> kkg_esito.db_wrn then
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
			k_nome_file = "IT" + trim(kds_rag_soc.getitemstring(1, "p_iva")) + "_"  + string(kst_tab_arfa.id_fattura, "00000") + ".xml"
			
			kpbdom_doc = CREATE PBDOM_Document
			kpbdom_proc = create PBDOM_PROCESSINGINSTRUCTION
			kpbdom_el_node1 = create PBDOM_Element
			kpbdom_el_node11 = create PBDOM_Element
			kpbdom_el_node111 = create PBDOM_Element
			kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node11111 = create PBDOM_Element
			
			kpbdom_doc.newdocument("FatturaElettronica")
//<?xml-stylesheet type="text/xsl" href="fatturapa_v1.1.xsl"?> 			
//			kpbdom_proc.set  ("stylesheet")
//			kpbdom_proc.setvalue("type", "text/xsl")
//			kpbdom_proc.setvalue("href", "fatturapa_v1.1.xsl")
////			kpbdom_doc.addcontent(kpbdom_proc)
//			destroy kpbdom_proc; kpbdom_proc = create PBDOM_PROCESSINGINSTRUCTION
			kpbdom_proc.setname("xml")
			kpbdom_proc.setvalue("version", "1.0")
			kpbdom_proc.setvalue("encoding", "UTF-8")
			kpbdom_doc.addcontent(kpbdom_proc)
			kpbdom_el_root = kpbdom_doc.getrootelement( )
			kpbdom_el_root.setattribute("versione", "FPA12")
			k_namespace = "http://ivaservizi.agenziaentrate.gov.it/docs/xsd/fatture/v1.2"
			kpbdom_el_root.setnamespace( "p", k_namespace, false)  // mette la p: davanti alla <FatturaElettronica>
			kpbdom_el_root.addnamespacedeclaration( "ds", "http://www.w3.org/2000/09/xmldsig#")
			kpbdom_el_root.addnamespacedeclaration( "p", k_namespace)
			kpbdom_el_root.addnamespacedeclaration( "xsi", "http://www.w3.org/2001/XMLSchema-instance")

			kpbdom_el_node1.setname("FatturaElettronicaHeader")
			kpbdom_el_root.addcontent(kpbdom_el_node1)
			//  "<FatturaElettronicaHeader>"
			
			kpbdom_el_node11.setname("DatiTrasmissione")
			kpbdom_el_node1.addcontent(kpbdom_el_node11)
			//  "<DatiTrasmissione>"
			
			kpbdom_el_node111.setname("IdTrasmittente")
			kpbdom_el_node11.addcontent(kpbdom_el_node111)
			//    "<IdTrasmittente>"
			kpbdom_el_node1111.setname("IdPaese")
			kpbdom_el_node1111.addcontent("IT")
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<IdPaese>" + "IT" + "</IdPaese>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("IdCodice")
			////////kpbdom_el_node1111.addcontent("00307110379")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "cf")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<IdCodice>" + trim(kds_rag_soc.getitemstring(1, "p_iva")) + "</IdCodice>"
			//    "</IdTrasmittente>"
			destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
			kpbdom_el_node111.setname("ProgressivoInvio")
			kpbdom_el_node111.addcontent(string(kds_fatt_elett_testa.getitemnumber(k_riga, "arfa_testa_id_fattura")))
			kpbdom_el_node11.addcontent(kpbdom_el_node111)
			//    "<ProgressivoInvio>" + string(kds_fatt_elett_testa.getitemnumber(k_riga, "arfa_testa_id_fattura")) + "</ProgressivoInvio>"
			destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
			kpbdom_el_node111.setname("FormatoTrasmissione")
			kpbdom_el_node111.addcontent("FPA12")
			kpbdom_el_node11.addcontent(kpbdom_el_node111)
			//    "<FormatoTrasmissione>" + "SDI11" + "</FormatoTrasmissione>"
			destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
			kpbdom_el_node111.setname("CodiceDestinatario")
			kpbdom_el_node111.addcontent(trim(kds_fatt_elett_testa.getitemstring(k_riga, "codice_ipa")))
			kpbdom_el_node11.addcontent(kpbdom_el_node111)
			//    "<CodiceDestinatario>" + trim(kds_fatt_elett_testa.getitemstring(k_riga, "codice_ipa")) + "</CodiceDestinatario>"
			destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
			kpbdom_el_node111.setname("ContattiTrasmittente")
			kpbdom_el_node11.addcontent(kpbdom_el_node111)
			//    "<ContattiTrasmittente>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Telefono")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "telefono")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Telefono>" + trim(kds_rag_soc.getitemstring(1, "telefono")) + "</Telefono>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Email")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "e_mail")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Email>" + trim(kds_rag_soc.getitemstring(1, "e_mail")) + "</Email>"
			//    "</ContattiTrasmittente>"
			//  "</DatiTrasmissione>"
			
			destroy kpbdom_el_node11; kpbdom_el_node11 = create PBDOM_Element
			kpbdom_el_node11.setname("CedentePrestatore")
			kpbdom_el_node1.addcontent(kpbdom_el_node11)
			//  "<CedentePrestatore>"
			destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
			kpbdom_el_node111.setname("DatiAnagrafici")
			kpbdom_el_node11.addcontent(kpbdom_el_node111)
			//    "<DatiAnagrafici>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("IdFiscaleIVA")
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<IdFiscaleIVA>"
			destroy kpbdom_el_node11111; kpbdom_el_node11111 = create PBDOM_Element
			kpbdom_el_node11111.setname("IdPaese")
			kpbdom_el_node11111.addcontent("IT")
			kpbdom_el_node1111.addcontent(kpbdom_el_node11111)
			//        "<IdPaese>" + "IT" + "</IdPaese>"
			destroy kpbdom_el_node11111; kpbdom_el_node11111 = create PBDOM_Element
			kpbdom_el_node11111.setname("IdCodice")
			kpbdom_el_node11111.addcontent(trim(kds_rag_soc.getitemstring(1, "p_iva")))
			kpbdom_el_node1111.addcontent(kpbdom_el_node11111)
			//        "<IdCodice>" + trim(kds_rag_soc.getitemstring(1, "p_iva")) + "</IdCodice>"
			//      "</IdFiscaleIVA>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("CodiceFiscale")
			//////kpbdom_el_node1111.addcontent("00307110379")
			if trim(kds_rag_soc.getitemstring(1, "cf")) > " " then  // se manca il CF mette la p.iva
				kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "cf")))
			else
				kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "p_iva")))
			end if
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<CodiceFiscale>" + trim(kds_rag_soc.getitemstring(1, "p_iva")) + "</CodiceFiscale>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Anagrafica")
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Anagrafica>"
			destroy kpbdom_el_node11111; kpbdom_el_node11111 = create PBDOM_Element
			kpbdom_el_node11111.setname("Denominazione")
			kpbdom_el_node11111.addcontent(trim(kds_rag_soc.getitemstring(1, "rag_soc_1")) + ' ' + trim(kds_rag_soc.getitemstring(1, "rag_soc_2")))
			kpbdom_el_node1111.addcontent(kpbdom_el_node11111)
			//        "<Denominazione>" + trim(kds_rag_soc.getitemstring(1, "rag_soc_1")) + ' ' + trim(kds_rag_soc.getitemstring(1, "rag_soc_2")) + "</Denominazione>"
			//      "</Anagrafica>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("RegimeFiscale")
			kpbdom_el_node1111.addcontent("RF01")
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<RegimeFiscale>" + "RF01" + "</RegimeFiscale>"
			//    "</DatiAnagrafici>"
			destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
			kpbdom_el_node111.setname("Sede")
			kpbdom_el_node11.addcontent(kpbdom_el_node111)
			//    "<Sede>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Indirizzo")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "indi")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Indirizzo>" + trim(kds_rag_soc.getitemstring(1, "indi")) + "</Indirizzo>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("CAP")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "cap")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<CAP>" + trim(kds_rag_soc.getitemstring(1, "cap")) + "</CAP>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Comune")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "loc")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Comune>" + trim(kds_rag_soc.getitemstring(1, "loc")) + "</Comune>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Provincia")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "prov")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Provincia>" + trim(kds_rag_soc.getitemstring(1, "prov")) + "</Provincia>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Nazione")
			kpbdom_el_node1111.addcontent("IT")
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Nazione>" + "IT" + "</Nazione>"
			//    "</Sede>"
			destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
			kpbdom_el_node111.setname("IscrizioneREA")
			kpbdom_el_node11.addcontent(kpbdom_el_node111)
			//    "<IscrizioneREA>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Ufficio")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "rea_ufficio")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Ufficio>" + trim(kds_rag_soc.getitemstring(1, "rea_ufficio")) + "</Ufficio>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("NumeroREA")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "rea_numero")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<NumeroREA>" + trim(kds_rag_soc.getitemstring(1, "rea_numero")) + "</NumeroREA>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("CapitaleSociale")
			kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(kds_rag_soc.getitemnumber(1, "capitale_sociale"),"#0.00")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<CapitaleSociale>" + kuf1_utility.u_num_itatousa(string(kds_rag_soc.getitemnumber(1, "capitale_sociale"),"#0.00")) + "</CapitaleSociale>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("SocioUnico")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "socio_unico")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<SocioUnico>" + trim(kds_rag_soc.getitemstring(1, "socio_unico")) + "</SocioUnico>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("StatoLiquidazione")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "stato_liquidazione")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<StatoLiquidazione>" + trim(kds_rag_soc.getitemstring(1, "stato_liquidazione")) + "</StatoLiquidazione>"
			//    "</IscrizioneREA>"
			destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
			kpbdom_el_node111.setname("Contatti")
			kpbdom_el_node11.addcontent(kpbdom_el_node111)
			//    "<Contatti>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Telefono")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "telefono")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Telefono>" + trim(kds_rag_soc.getitemstring(1, "telefono")) + "</Telefono>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Fax")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "fax")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Fax>" + trim(kds_rag_soc.getitemstring(1, "fax")) + "</Fax>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Email")
			kpbdom_el_node1111.addcontent(trim(kds_rag_soc.getitemstring(1, "e_mail")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Email>" + trim(kds_rag_soc.getitemstring(1, "e_mail")) + "</Email>"
			//    "</Contatti>"
			//  "</CedentePrestatore>"

			destroy kpbdom_el_node11; kpbdom_el_node11 = create PBDOM_Element
			kpbdom_el_node11.setname("CessionarioCommittente")
			kpbdom_el_node1.addcontent(kpbdom_el_node11)
			//  "<CessionarioCommittente>"
			destroy kpbdom_el_node111;kpbdom_el_node111 = create PBDOM_Element
			kpbdom_el_node111.setname("DatiAnagrafici")
			kpbdom_el_node11.addcontent(kpbdom_el_node111)
			///      "<DatiAnagrafici>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("IdFiscaleIVA")
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<IdFiscaleIVA>"
			destroy kpbdom_el_node11111; kpbdom_el_node11111 = create PBDOM_Element
			kpbdom_el_node11111.setname("IdPaese")
			kpbdom_el_node11111.addcontent("IT")
			kpbdom_el_node1111.addcontent(kpbdom_el_node11111)
			//        "<IdPaese>" + "IT" + "</IdPaese>"
			destroy kpbdom_el_node11111; kpbdom_el_node11111 = create PBDOM_Element
			kpbdom_el_node11111.setname("IdCodice")
			kpbdom_el_node11111.addcontent(trim(kds_fatt_elett_testa.getitemstring(k_riga, "p_iva")))
			kpbdom_el_node1111.addcontent(kpbdom_el_node11111)
			//        "<IdCodice>" + trim(kds_fatt_elett_testa.getitemstring(k_riga, "p_iva")) + "</IdCodice>"
			//      "</IdFiscaleIVA>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("CodiceFiscale")
			if trim(kds_fatt_elett_testa.getitemstring(k_riga, "cf")) > " " then 
				kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_testa.getitemstring(k_riga, "cf")))
			else		
				kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_testa.getitemstring(k_riga, "p_iva")))
			end if
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<CodiceFiscale>" + trim(kds_fatt_elett_testa.getitemstring(k_riga, "p_iva")) + "</CodiceFiscale>"
			destroy kpbdom_el_node1111;kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Anagrafica")
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			///      "<Anagrafica>"
			destroy kpbdom_el_node11111; kpbdom_el_node11111 = create PBDOM_Element
			kpbdom_el_node11111.setname("Denominazione")
			kpbdom_el_node11111.addcontent(trim(kds_fatt_elett_testa.getitemstring(k_riga, "rag_soc_1")) + " " + trim(kds_fatt_elett_testa.getitemstring(k_riga, "rag_soc_2")))
			kpbdom_el_node1111.addcontent(kpbdom_el_node11111)
			//        "<Denominazione>" + trim(kds_fatt_elett_testa.getitemstring(k_riga, "rag_soc_1")) + trim(kds_fatt_elett_testa.getitemstring(k_riga, "rag_soc_2")) + "</Denominazione>"
			//      "</Anagrafica>"
			//    "</DatiAnagrafici>"
			
			destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
			kpbdom_el_node111.setname("Sede")
			kpbdom_el_node11.addcontent(kpbdom_el_node111)
			//    "<Sede>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Indirizzo")
			kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_testa.getitemstring(k_riga, "indi")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Indirizzo>" + trim(kds_fatt_elett_testa.getitemstring(k_riga, "indi")) + "</Indirizzo>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("CAP")
			kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_testa.getitemstring(k_riga, "cap")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<CAP>" + trim(kds_fatt_elett_testa.getitemstring(k_riga, "cap")) + "</CAP>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Comune")
			kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_testa.getitemstring(k_riga, "loc")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Comune>" + trim(kds_fatt_elett_testa.getitemstring(k_riga, "loc")) + "</Comune>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Provincia")
			kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_testa.getitemstring(k_riga, "prov")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Provincia>" + trim(kds_fatt_elett_testa.getitemstring(k_riga, "prov")) + "</Provincia>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Nazione")
			kpbdom_el_node1111.addcontent("IT")
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Nazione>" + "IT" + "</Nazione>"
			//    "</Sede>"
			//  "</CessionarioCommittente>"
			//  "</FatturaElettronicaHeader>"
			
			destroy kpbdom_el_node1; kpbdom_el_node1 = create PBDOM_Element
			kpbdom_el_node1.setname("FatturaElettronicaBody")
			kpbdom_el_root.addcontent(kpbdom_el_node1)
			//  "<FatturaElettronicaBody>"
			
			destroy kpbdom_el_node11; kpbdom_el_node11 = create PBDOM_Element
			kpbdom_el_node11.setname("DatiGenerali")
			kpbdom_el_node1.addcontent(kpbdom_el_node11)
			//  "<DatiGenerali>"
			
			destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
			kpbdom_el_node111.setname("DatiGeneraliDocumento")
			kpbdom_el_node11.addcontent(kpbdom_el_node111)
			//    "<DatiGeneraliDocumento>"
			if trim(kds_fatt_elett_testa.getitemstring(k_riga, "tipo_doc")) = kiuf_fatt.kki_tipo_doc_nota_di_credito then
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("TipoDocumento")
				kpbdom_el_node1111.addcontent("TD04")
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<TipoDocumento>" + "TD04" + "</TipoDocumento>"
			else
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("TipoDocumento")
				kpbdom_el_node1111.addcontent("TD01")
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<TipoDocumento>" + "TD01" + "</TipoDocumento>"
			end if
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Divisa")
			kpbdom_el_node1111.addcontent("EUR")
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Divisa>" + "EUR" + "</Divisa>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Data")
			kpbdom_el_node1111.addcontent(string(kds_fatt_elett_testa.getitemdate(k_riga, "data_fatt"), "YYYY-MM-DD"))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Data>" + string(kds_fatt_elett_testa.getitemdate(k_riga, "data_fatt"), "YYYY-MM-DD") + "</Data>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("Numero")
			kpbdom_el_node1111.addcontent(string(kds_fatt_elett_testa.getitemnumber(k_riga, "num_fatt")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<Numero>" + string(kds_fatt_elett_testa.getitemnumber(k_riga, "num_fatt")) + "</Numero>"
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
//-- calolo totale documento
			kpbdom_el_node1111.setname("ImportoTotaleDocumento")
			k_tot_doc = 0.00
			for k_ind = 1 to kds_fatt_elett_iva.rowcount( )
				if kds_fatt_elett_iva.getitemnumber(k_ind, "iva_aliq") > 0 then
					k_aliq_iva = kds_fatt_elett_iva.getitemnumber(k_ind, "iva_aliq")
					k_imponibile = kds_fatt_elett_iva.getitemnumber(k_ind, "prezzo_t")
					k_imposta = round((k_imponibile * (k_aliq_iva / 100)), 2)
				else
					k_imponibile = kds_fatt_elett_iva.getitemnumber(k_ind, "prezzo_t")
					if k_imponibile > 0 then
					else
						k_imponibile = 0.00
					end if
					k_imposta = 0.00
				end if
				k_tot_doc += k_imponibile + k_imposta
			next
			kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(k_tot_doc,"#0.00")))
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<ImportoTotaleDocumento>" 
			if trim(kds_fatt_elett_testa.getitemstring(k_riga, "note")) > " " then
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("Causale")
				kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_testa.getitemstring(k_riga, "note")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<Causale>" + trim(kds_fatt_elett_testa.getitemstring(k_riga, "note")) + "</Causale>"
			end if
			//    "</DatiGeneraliDocumento>"

			for k_ind = 1 to kds_fatt_elett_righe.rowcount( )
				if trim(kds_fatt_elett_righe.getitemstring(k_ind, "mc_co")) > " " or trim(kds_fatt_elett_righe.getitemstring(k_ind, "codice_cig")) > " "  &
						or trim(kds_fatt_elett_righe.getitemstring(k_ind, "codice_cup")) > " " or trim(kds_fatt_elett_righe.getitemstring(k_ind, "ordineacquisto_id")) > " "  then
					destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
					if  trim(kds_fatt_elett_righe.getitemstring(k_ind, "ordineacquisto_id")) > " "  then
						kpbdom_el_node111.setname("DatiOrdineAcquisto")
					else
						kpbdom_el_node111.setname("DatiContratto")
					end if
					kpbdom_el_node11.addcontent(kpbdom_el_node111)
					//    "<DatiContratto>" o <DatiOrdineAcquisto>
					destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
					kpbdom_el_node1111.setname("RiferimentoNumeroLinea")
					kpbdom_el_node1111.addcontent(string(kds_fatt_elett_righe.getitemnumber(k_ind, "nriga")))
					kpbdom_el_node111.addcontent(kpbdom_el_node1111)
					//      "<RiferimentoNumeroLinea>" + string(kds_fatt_elett_righe.getitemnumber(k_ind, "nriga")) + "</RiferimentoNumeroLinea>"
					if trim(kds_fatt_elett_righe.getitemstring(k_ind, "mc_co")) > " "  or trim(kds_fatt_elett_righe.getitemstring(k_ind, "ordineacquisto_id")) > " " then
						destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
						kpbdom_el_node1111.setname("IdDocumento")
						if trim(kds_fatt_elett_righe.getitemstring(k_ind, "ordineacquisto_id")) > " " then
							kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_righe.getitemstring(k_ind, "ordineacquisto_id")))
						else
							kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_righe.getitemstring(k_ind, "mc_co")))
						end if
						kpbdom_el_node111.addcontent(kpbdom_el_node1111)
						//      "<IdDocumento>" 
						if trim(kds_fatt_elett_righe.getitemstring(k_ind, "ordineacquisto_id")) > " " then
							if kds_fatt_elett_righe.getitemdate(k_ind, "ordineacquisto_data") > date(0) then
								destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
								kpbdom_el_node1111.setname("Data")
								kpbdom_el_node1111.addcontent(string(kds_fatt_elett_righe.getitemdate(k_ind, "ordineacquisto_data"), "YYYY-MM-DD"))
								kpbdom_el_node111.addcontent(kpbdom_el_node1111)
							end if
						else
							destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
							kpbdom_el_node1111.setname("Data")
							kpbdom_el_node1111.addcontent(string(kds_fatt_elett_righe.getitemdate(k_ind, "contratti_data"), "YYYY-MM-DD"))
							kpbdom_el_node111.addcontent(kpbdom_el_node1111)
						end if
						//      "<Data>" 
					else
						destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
						kpbdom_el_node1111.setname("IdDocumento")
						kpbdom_el_node1111.addcontent("non-indicato")
						kpbdom_el_node111.addcontent(kpbdom_el_node1111)
					end if
					if trim(kds_fatt_elett_righe.getitemstring(k_ind, "ordineacquisto_commessa")) > " "  then
						destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
						kpbdom_el_node1111.setname("CodiceCommessaConvenzione")
						kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_righe.getitemstring(k_ind, "ordineacquisto_commessa")))
						kpbdom_el_node111.addcontent(kpbdom_el_node1111)
						//      "<CodiceCommessaConvenzione>"
					end if
					if trim(kds_fatt_elett_righe.getitemstring(k_ind, "codice_cup")) > " "  then
						destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
						kpbdom_el_node1111.setname("CodiceCUP")
						kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_righe.getitemstring(k_ind, "codice_cup")))
						kpbdom_el_node111.addcontent(kpbdom_el_node1111)
						//      "<CodiceCUP>" 
					end if
					if trim(kds_fatt_elett_righe.getitemstring(k_ind, "codice_cig")) > " "  then
						destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
						kpbdom_el_node1111.setname("CodiceCIG")
						kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_righe.getitemstring(k_ind, "codice_cig")))
						kpbdom_el_node111.addcontent(kpbdom_el_node1111)
						//      "<CodiceCIG>"
					end if
					//    "</DatiContratto>"
				end if
			next
			for k_ind = 1 to kds_fatt_elett_righe.rowcount( )
				if kds_fatt_elett_righe.getitemnumber(k_ind, "num_bolla_out") > 0 then
					destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
					kpbdom_el_node111.setname("DatiDDT")
					kpbdom_el_node11.addcontent(kpbdom_el_node111)
					//    "<DatiDDT>"
					destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
					kpbdom_el_node1111.setname("NumeroDDT")
					kpbdom_el_node1111.addcontent(string(kds_fatt_elett_righe.getitemnumber(k_ind, "num_bolla_out")))
					kpbdom_el_node111.addcontent(kpbdom_el_node1111)
					//      "<NumeroDDT>" + string(kds_fatt_elett_righe.getitemnumber(k_ind, "num_bolla_out")) + "</NumeroDDT>"
					destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
					kpbdom_el_node1111.setname("DataDDT")
					kpbdom_el_node1111.addcontent(string(kds_fatt_elett_righe.getitemdate(k_ind, "data_bolla_out"), "YYYY-MM-DD"))
					kpbdom_el_node111.addcontent(kpbdom_el_node1111)
					//      "<DataDDT>" + string(kds_fatt_elett_righe.getitemnumber(k_ind, "data_bolla_out")) + "</DataDDT>"
					destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
					kpbdom_el_node1111.setname("RiferimentoNumeroLinea")
					kpbdom_el_node1111.addcontent(string(kds_fatt_elett_righe.getitemnumber(k_ind, "nriga")))
					kpbdom_el_node111.addcontent(kpbdom_el_node1111)
					//      "<RiferimentoNumeroLinea>" + string(kds_fatt_elett_righe.getitemnumber(k_ind, "nriga")) + "</RiferimentoNumeroLinea>"
					//    "</DatiDDT>"
				end if
			next

			//  "</DatiGenerali>"
			
			destroy kpbdom_el_node11; kpbdom_el_node11 = create PBDOM_Element
			kpbdom_el_node11.setname("DatiBeniServizi")
			kpbdom_el_node1.addcontent(kpbdom_el_node11)
			//    "<DatiBeniServizi>"
			for k_ind = 1 to kds_fatt_elett_righe.rowcount( )
				destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
				kpbdom_el_node111.setname("DettaglioLinee")
				kpbdom_el_node11.addcontent(kpbdom_el_node111)
				//    "<DettaglioLinee>"
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("NumeroLinea")
				kpbdom_el_node1111.addcontent(string(kds_fatt_elett_righe.getitemnumber(k_ind, "nriga")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<NumeroLinea>" + string(kds_fatt_elett_righe.getitemnumber(k_ind, "nriga")) + "</NumeroLinea>"
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("Descrizione")
				kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_righe.getitemstring(k_ind, "art"))  + " " + trim(kds_fatt_elett_righe.getitemstring(k_ind, "des")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<Descrizione>" + trim(kds_fatt_elett_righe.getitemstring(k_ind, "art"))  + " " + trim(kds_fatt_elett_righe.getitemstring(k_ind, "des")) + "</Descrizione>"
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("Quantita")
				kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(kds_fatt_elett_righe.getitemnumber(k_ind, "colli_out"),"#0.00")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<Quantita>" + kuf1_utility.u_num_itatousa(string(kds_fatt_elett_righe.getitemnumber(k_ind, "colli_out"),"#0.00"))  +  "</Quantita>"
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("UnitaMisura")
				kpbdom_el_node1111.addcontent("N.")
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<UnitaMisura>" + "N."  +  "</UnitaMisura>"
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("PrezzoUnitario")
				kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(kds_fatt_elett_righe.getitemnumber(k_ind, "prezzo_u"),"#0.00")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<PrezzoUnitario>" + kuf1_utility.u_num_itatousa(string(kds_fatt_elett_righe.getitemnumber(k_ind, "prezzo_u"),"#0.00"))  +  "</PrezzoUnitario>"
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("PrezzoTotale")
				kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(kds_fatt_elett_righe.getitemnumber(k_ind, "prezzo_t"),"#0.00")) )
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<PrezzoTotale>" + kuf1_utility.u_num_itatousa(string(kds_fatt_elett_righe.getitemnumber(k_ind, "prezzo_t"),"#0.00"))  +  "</PrezzoTotale>"
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("AliquotaIVA")
				kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(kds_fatt_elett_righe.getitemnumber(k_ind, "iva_aliq"),"#0.00")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<AliquotaIVA>" + kuf1_utility.u_num_itatousa(string(kds_fatt_elett_righe.getitemnumber(k_ind, "iva_aliq"),"#0.00"))  +  "</AliquotaIVA>"
				if trim(kds_fatt_elett_righe.getitemstring(k_ind, "iva_natura")) > " " then
					destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
					kpbdom_el_node1111.setname("Natura")
					kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_righe.getitemstring(k_ind, "iva_natura")))
					kpbdom_el_node111.addcontent(kpbdom_el_node1111)
					//      "<Natura>" + trim(kds_fatt_elett_righe.getitemstring(k_ind, "iva_natura"))  +  "</Natura>"
				end if
			next
			//    "</DettaglioLinee>"


			for k_ind = 1 to kds_fatt_elett_iva.rowcount( )
				destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
				kpbdom_el_node111.setname("DatiRiepilogo")
				kpbdom_el_node11.addcontent(kpbdom_el_node111)
				//    "<DatiRiepilogo>"
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("AliquotaIVA")
				kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(kds_fatt_elett_iva.getitemnumber(k_ind, "iva_aliq"),"#0.00")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<AliquotaIVA>" + kuf1_utility.u_num_itatousa(string(kds_fatt_elett_iva.getitemnumber(k_ind, "iva_aliq"),"#0.00"))  +  "</AliquotaIVA>"
				if trim(kds_fatt_elett_iva.getitemstring(k_ind, "iva_natura")) > " " then
					destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
					kpbdom_el_node1111.setname("Natura")
					kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_iva.getitemstring(k_ind, "iva_natura")))
					kpbdom_el_node111.addcontent(kpbdom_el_node1111)
					//      "<Natura>" + trim(kds_fatt_elett_iva.getitemstring(k_ind, "iva_natura"))  +  "</Natura>"
				end if
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("ImponibileImporto")
				kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(kds_fatt_elett_iva.getitemnumber(k_ind, "prezzo_t"),"#0.00")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<ImponibileImporto>" + kuf1_utility.u_num_itatousa(string(kds_fatt_elett_iva.getitemnumber(k_ind, "prezzo_t"),"#0.00"))  +  "</ImponibileImporto>"
				if kds_fatt_elett_iva.getitemnumber(k_ind, "iva_aliq") > 0 then
					k_aliq_iva = kds_fatt_elett_iva.getitemnumber(k_ind, "iva_aliq")
					k_imponibile = kds_fatt_elett_iva.getitemnumber(k_ind, "prezzo_t")
					k_imposta = round((k_imponibile * (k_aliq_iva / 100)), 2)
				else
					k_imposta = 0
				end if
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("Imposta")
				kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(k_imposta,"#0.00")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<Imposta>" + kuf1_utility.u_num_itatousa(string(k_imposta,"#0.00"))  +  "</Imposta>"
				if trim(kds_fatt_elett_iva.getitemstring(k_ind, "iva_f_splitpayment")) = "S" then
					destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
					kpbdom_el_node1111.setname("EsigibilitaIVA")
					kpbdom_el_node1111.addcontent("S")
					kpbdom_el_node111.addcontent(kpbdom_el_node1111)
					//      "<EsigibilitaIVA>" + "S"  +  "</EsigibilitaIVA>"
				else
					destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
					kpbdom_el_node1111.setname("EsigibilitaIVA")
					kpbdom_el_node1111.addcontent("I")
					kpbdom_el_node111.addcontent(kpbdom_el_node1111)
					//      "<EsigibilitaIVA>" + "I"  +  "</EsigibilitaIVA>"
				end if
				if trim(kds_fatt_elett_iva.getitemstring(k_ind, "iva_natura")) > " " then
					destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
					kpbdom_el_node1111.setname("RiferimentoNormativo")
					kpbdom_el_node1111.addcontent(trim(kds_fatt_elett_iva.getitemstring(k_ind, "iva_des")))
					kpbdom_el_node111.addcontent(kpbdom_el_node1111)
					//      "<RiferimentoNormativo>" + trim(kds_fatt_elett_iva.getitemstring(k_ind, "iva_des"))  +  "</RiferimentoNormativo>"
				end if
				//    "</DatiRiepilogo>"
			next
			//    "</DatiBeniServizi>"
			
			destroy kpbdom_el_node11; kpbdom_el_node11 = create PBDOM_Element
			kpbdom_el_node11.setname("DatiPagamento")
			kpbdom_el_node1.addcontent(kpbdom_el_node11)
			//    "<DatiPagamento>"
			if kst_fattura_scadenze.importo_2 > 0 then
				destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
				kpbdom_el_node111.setname("CondizioniPagamento")
				kpbdom_el_node111.addcontent("TP01")
				kpbdom_el_node11.addcontent(kpbdom_el_node111)
				//      "<CondizioniPagamento>" + "TP01"  +  "</CondizioniPagamento>"
			else
				destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
				kpbdom_el_node111.setname("CondizioniPagamento")
				kpbdom_el_node111.addcontent("TP02")
				kpbdom_el_node11.addcontent(kpbdom_el_node111)
				//      "<CondizioniPagamento>" + "TP02"  +  "</CondizioniPagamento>"
			end if
			destroy kpbdom_el_node111; kpbdom_el_node111 = create PBDOM_Element
			kpbdom_el_node111.setname("DettaglioPagamento")
			kpbdom_el_node11.addcontent(kpbdom_el_node111)
			//       "<DettaglioPagamento>"
//			for k_ind = 1 to 5
//				k_record +=        "<Imposta>" + kuf1_utility.u_num_itatousa(string(kst_ricevute_scadenze.importo_1,"#0.00"))  +  "</Imposta>"
//			next
			choose case trim(kds_fatt_elett_testa.getitemstring(k_riga, "pagam_tipo"))
				case "0"
					k_modpag = "MP01"  
				case "2"
					k_modpag = "MP12"  
				case "3"
					k_modpag = "MP05"  
				case "4"
					k_modpag = "MP13"  
			end choose
			destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
			kpbdom_el_node1111.setname("ModalitaPagamento")
			kpbdom_el_node1111.addcontent(k_modpag)
			kpbdom_el_node111.addcontent(kpbdom_el_node1111)
			//      "<ModalitaPagamento>" + k_modpag  +  "</ModalitaPagamento>"
			if kst_fattura_scadenze.importo_1 > 0 then
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("DataScadenzaPagamento")
				kpbdom_el_node1111.addcontent(string(kst_fattura_scadenze.data_1, "YYYY-MM-DD"))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<DataScadenzaPagamento>" + string(kst_fattura_scadenze.data_1, "YYYY-MM-DD") + "</DataScadenzaPagamento>"
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("ImportoPagamento")
				kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(kst_fattura_scadenze.importo_1, "#0.00")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<ImportoPagamento>" + kuf1_utility.u_num_itatousa(string(kst_fattura_scadenze.importo_1, "#0.00")) + "</ImportoPagamento>"
			end if
			if kst_fattura_scadenze.importo_2 > 0 then
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("DataScadenzaPagamento")
				kpbdom_el_node1111.addcontent(string(kst_fattura_scadenze.data_2, "YYYY-MM-DD"))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<DataScadenzaPagamento>" + string(kst_fattura_scadenze.data_2, "YYYY-MM-DD") + "</DataScadenzaPagamento>"
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("ImportoPagamento")
				kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(kst_fattura_scadenze.importo_2, "#0.00")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<ImportoPagamento>" + kuf1_utility.u_num_itatousa(string(kst_fattura_scadenze.importo_2, "#0.00")) + "</ImportoPagamento>"
			end if
			if kst_fattura_scadenze.importo_3 > 0 then
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("DataScadenzaPagamento")
				kpbdom_el_node1111.addcontent(string(kst_fattura_scadenze.data_3, "YYYY-MM-DD"))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<DataScadenzaPagamento>" + string(kst_fattura_scadenze.data_3, "YYYY-MM-DD") + "</DataScadenzaPagamento>"
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("ImportoPagamento")
				kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(kst_fattura_scadenze.importo_3, "#0.00")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<ImportoPagamento>" + kuf1_utility.u_num_itatousa(string(kst_fattura_scadenze.importo_3, "#0.00")) + "</ImportoPagamento>"
			end if
			if kst_fattura_scadenze.importo_4 > 0 then
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("DataScadenzaPagamento")
				kpbdom_el_node1111.addcontent(string(kst_fattura_scadenze.data_4, "YYYY-MM-DD"))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<DataScadenzaPagamento>" + string(kst_fattura_scadenze.data_4, "YYYY-MM-DD") + "</DataScadenzaPagamento>"
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("ImportoPagamento")
				kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(kst_fattura_scadenze.importo_4, "#0.00")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<ImportoPagamento>" + kuf1_utility.u_num_itatousa(string(kst_fattura_scadenze.importo_4, "#0.00")) + "</ImportoPagamento>"
			end if
			if kst_fattura_scadenze.importo_5 > 0 then
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("DataScadenzaPagamento")
				kpbdom_el_node1111.addcontent(string(kst_fattura_scadenze.data_5, "YYYY-MM-DD"))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<DataScadenzaPagamento>" + string(kst_fattura_scadenze.data_5, "YYYY-MM-DD") + "</DataScadenzaPagamento>"
				destroy kpbdom_el_node1111; kpbdom_el_node1111 = create PBDOM_Element
				kpbdom_el_node1111.setname("ImportoPagamento")
				kpbdom_el_node1111.addcontent(kuf1_utility.u_num_itatousa(string(kst_fattura_scadenze.importo_5, "#0.00")))
				kpbdom_el_node111.addcontent(kpbdom_el_node1111)
				//      "<ImportoPagamento>" + kuf1_utility.u_num_itatousa(string(kst_fattura_scadenze.importo_5, "#0.00")) + "</ImportoPagamento>"
			end if
			//       "</DettaglioPagamento>"

			//    "</DatiPagamento>"

			//  "</FatturaElettronicaBody>"

			//  "</FatturaElettronica>"

			//k_rc = kpbdom_doc.SaveDocument(k_path + kkg.path_sep + k_nome_file)
			
//--- Salva l'intero documento su stringa x fare il file TXT			
			k_file_xml = kpbdom_doc.SaveDocumentIntoString() //k_path + kkg.path_sep + k_nome_file)
			//if not k_rc then 
			if k_file_xml > " " then
			else
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Errore durante esportazione della Fattura/N.C. Elettronica (formato XML) n. " + string(kds_fatt_elett_testa.getitemnumber(k_riga, "num_fatt")) &
				                   + ", per fare il file: " + trim(k_path + kkg.path_sep + k_nome_file) + " "
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
			k_filenum = FileOpen(k_path + kkg.path_sep + k_nome_file, TextMode!, Write!, LockWrite!, Replace!, EncodingUTF8!)
			
			if k_filenum <= 0 then
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Errore Fattura/N.C. Elettronica (formato XML)  n. " + string(kds_fatt_elett_testa.getitemnumber(k_riga, "num_fatt")) &
				                    + ", in apertura file: " + trim(k_path + kkg.path_sep + k_nome_file) + " "
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
//--- cattura e scrive: <?xml version="1.0" encoding="utf-8"?>  x scriverlo x prima 			
			k_pos = pos(k_file_xml, "<?xml")
			k_pos_1 = pos(k_file_xml, "?>", k_pos)  + 1 // mi posiziono sul '>'
			k_record = mid(k_file_xml, k_pos,  k_pos_1 - k_pos + 1)  
			k_byte = FileWriteEx(k_FileNum, k_record)
//--- scrive il tag del foglio di stile			
			if k_byte > 0 then
				k_record = "<?xml-stylesheet type=~"text/xsl~" href=~"fatturapa_v1.2.xsl~"?>"      // richiama lo stylsheet
				k_byte = FileWriteEx(k_FileNum, k_record)
			end if		
//--- scrive il documento XML			
			if k_byte > 0 then
				k_byte = FileWriteEx(k_FileNum, mid(k_file_xml,k_pos_1 + 1))  // scrive il resto del XML
			end if		
			
			if k_byte > 0 then
			else
				kst_esito.esito = kkg_esito.no_esecuzione
				kst_esito.sqlerrtext = "Errore Fattura/N.C. Elettronica (formato XML) n. " + string(kds_fatt_elett_testa.getitemnumber(k_riga, "num_fatt")) &
				                                +  " in scrittura sul file: " + trim(k_path + kkg.path_sep + k_nome_file) + " "
				kguo_exception.inizializza( )
				kguo_exception.set_esito(kst_esito)
				throw kguo_exception
			end if
			
			FileClose(k_FileNum)
			
			if k_byte > 0 then
				k_nr_fatt ++
			end if
	
		end for
		
		if k_nr_fatt > 0 then
			ast_fatt_elettronica.nome_file = trim(k_path + kkg.path_sep + k_nome_file) 
		end if
		
		k_return = k_nr_fatt
		
	end if
	

CATCH ( PBDOM_Exception pbde )
	kguo_exception.inizializza( )
	kguo_exception.setmessage( "Errore durante Generazione XML", pbde.getmessage() )
	throw kguo_exception
	
catch (uo_exception kuo_exception) 
	throw kuo_exception
	
finally
	FileClose(k_FileNum)
	if isvalid(kuf1_utility) then destroy kuf1_utility
	if isvalid(kds_rag_soc) then destroy kds_rag_soc
	if isvalid(kds_fatt_elett_testa) then destroy kds_fatt_elett_testa
	if isvalid(kds_fatt_elett_righe) then destroy kds_fatt_elett_righe
	if isvalid(kds_fatt_elett_iva) then destroy kds_fatt_elett_iva
	if isvalid(kpbdom_doc) then destroy kpbdom_doc
	if isvalid(kpbdom_el_node1) then destroy kpbdom_el_node1
	if isvalid(kpbdom_el_node11) then destroy kpbdom_el_node11
	if isvalid(kpbdom_el_node111) then destroy kpbdom_el_node111
	if isvalid(kpbdom_el_node1111) then destroy kpbdom_el_node1111
	if isvalid(kpbdom_el_node11111) then destroy kpbdom_el_node11111

	setpointer(kkg.pointer_default)

end try

return k_return


end function

on kuf_fatt_elettronica.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_fatt_elettronica.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
kiuf_fatt = create kuf_fatt
kiuf_clienti = create kuf_clienti

end event

event destructor;//
if isvalid(kiuf_fatt) then destroy kiuf_fatt
if isvalid(kiuf_clienti) then destroy kiuf_clienti

end event

