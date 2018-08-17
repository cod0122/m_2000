$PBExportHeader$kuf_wm_dll_xml_pkl_web.sru
forward
global type kuf_wm_dll_xml_pkl_web from nonvisualobject
end type
end forward

global type kuf_wm_dll_xml_pkl_web from nonvisualobject
end type
global kuf_wm_dll_xml_pkl_web kuf_wm_dll_xml_pkl_web

type variables
//
private oleobject  ole_xml_document, ole_xml_element, ole_xml_node, ole_xml_vettore_nodi, ole_xml_prova
private string ki_dll_nome = "MSXML2.DOMDocument.3.0" //"Microsoft.XMLDOM"

end variables

forward prototypes
public subroutine crea_object ()
public subroutine set_xml (string ls_filename) throws uo_exception
public function string get_valore () throws uo_exception
public function boolean get_figlio () throws uo_exception
public function boolean set_root () throws uo_exception
public function string get_tag (integer k_ind) throws uo_exception
public function integer get_nr_tag () throws uo_exception
public function string get_attributo (string k_nome) throws uo_exception
end prototypes

public subroutine crea_object ();//
integer k_rc
st_esito kst_esito


ole_xml_element = CREATE oleobject 
ole_xml_node = CREATE oleobject 
ole_xml_vettore_nodi = create oleobject

ole_xml_document = CREATE oleobject 
k_rc = ole_xml_document.ConnectToNewObject(ki_dll_nome) 

if k_rc < 0 then

	kst_esito.esito = kkg_esito_no_esecuzione
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()

	choose case k_rc
		case -1
				kst_esito.sqlerrtext = "Fallito Create oggetto  " + this.classname() + ": " + string(k_rc) +" Invalid Call: the argument is the Object property of a control"
		case -2
				kst_esito.sqlerrtext = "Fallito Create oggetto  " + this.classname() + ":  " + string(k_rc) +" Class name not found"
		case -3
				kst_esito.sqlerrtext = "Fallito Create oggetto  " + this.classname() + ":  " + string(k_rc) +" Object could not be created"
		case -4
				kst_esito.sqlerrtext = "Fallito Create oggetto  " + this.classname() + ":  " + string(k_rc) +" Could not connect to object"
		case -9
				kst_esito.sqlerrtext = "Fallito Create oggetto  " + this.classname() + ":  " + string(k_rc) +" Other error"
		case -15
				kst_esito.sqlerrtext = "Fallito Create oggetto  " + this.classname() + ":  " + string(k_rc) +" COM+ is not loaded on this computer"
		case -16
				kst_esito.sqlerrtext = "Fallito Create oggetto  " + this.classname() + ":  " + string(k_rc) +" Invalid Call: this function not applicable"
		case else		
				kst_esito.sqlerrtext = "Fallito Create oggetto  " + this.classname() + ":  " + string(k_rc) +" "
	end choose
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
	kguo_exception.set_esito(kst_esito)
	
end if



end subroutine

public subroutine set_xml (string ls_filename) throws uo_exception;//---
//--- Legge il flusso XML
//---
boolean lb_test=true
st_esito kst_esito


//string k_prova =  "<?xml version=~"1.0~"?><primo><secondo>uno</secondo></primo>" 
lb_test=ole_xml_document.load(ls_filename)
//lb_test=ole_xml_document.load(ls_filename)

//--- se c'e' un problema nel parser.... 
IF not lb_test THEN

	kst_esito.esito = kkg_esito_no_esecuzione
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()

		
	kst_esito.sqlerrtext = "Carico del file XML Fallito. Errore: " + string(ole_xml_document.parseError.ErrorCode)+ "~n~r" &
		  + "FilePosition: " +string(ole_xml_document.parseError.Filepos)+ "~n~r" &
		  + "Line: " +string(ole_xml_document.parseError.Line)+ "~n~r" &
		  + "LinePosition: " +string(ole_xml_document.parseError.Linepos)+ "~n~r" &
		  + "Reason: " +string(ole_xml_document.parseError.Reason)+ "~n~r" &
		  + "SourceText: " +string(ole_xml_document.parseError.SrcText)

	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
	
end if
end subroutine

public function string get_valore () throws uo_exception;//---
//--- Torna il valore dell'elemento tag su cui è (prima chiamare il get_tag(index))
//---
string k_return=""
st_esito kst_esito


k_return = ole_xml_vettore_nodi.text //ole_xml_node.text
	
	

return k_return
end function

public function boolean get_figlio () throws uo_exception;//---
//--- ???????
//---
boolean k_return=false
st_esito kst_esito

string k_elemento


//--- se c'e' un problema nel parser.... 
IF isvalid(ole_xml_element) THEN
	
	if ole_xml_element.nodeTypeString = "element" then
		k_return = true
	
//		while ole_xml_element.hasChildNodes() 
//			ole_xml_element.nextNode(
//		end while
		
//		 	k_elemento = ole_xml_element.childNodes()
//		 end if 

	end if
	
else
	kst_esito.esito = kkg_esito_no_esecuzione
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()

		
	kst_esito.sqlerrtext = "Posizionamento sul file XML Fallito. Errore: " + string(ole_xml_document.parseError.ErrorCode)+ "~n~r" &
		  + "FilePosition: " +string(ole_xml_document.parseError.Filepos)+ "~n~r" &
		  + "Line: " +string(ole_xml_document.parseError.Line)+ "~n~r" &
		  + "LinePosition: " +string(ole_xml_document.parseError.Linepos)+ "~n~r" &
		  + "Reason: " +string(ole_xml_document.parseError.Reason)+ "~n~r" &
		  + "SourceText: " +string(ole_xml_document.parseError.SrcText)

	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
	
end if

return k_return


end function

public function boolean set_root () throws uo_exception;//---
//--- Posizione sul root del doc xml
//--- out: true=ok da elaborare, false=nulla
//---
boolean k_return =false
st_esito kst_esito


if isvalid(ole_xml_document) then

	ole_xml_element=ole_xml_document.documentElement
	
	ole_xml_prova = create oleobject
	ole_xml_prova = ole_xml_document.getElementsByTagName("pkl").nextNode


	
	
	ole_xml_vettore_nodi = ole_xml_element.childNodes 
//	ole_xml_element=ole_xml_document.GetFirstChild
	if get_nr_tag() > 0 then
//	if string(ole_xml_element.childNodes.item(1).parentNode.nodeName) = "pkl" then //sono sulla radice
//		if len(trim(ole_xml_element.childNodes.item(1).parentNode.text)) > 0 then // e c'e' qualcosa dentro
		k_return = true

//		ole_xml_node = ole_xml_element.childNodes.item(1).FirstChild
		
//		end if
	end if

else
//--- se c'e' un problema nel parser.... 

	kst_esito.esito = kkg_esito_no_esecuzione
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()

		
	kst_esito.sqlerrtext = "Posizionamento sul file XML Fallito. Errore: " + string(ole_xml_document.parseError.ErrorCode)+ "~n~r" &
		  + "FilePosition: " +string(ole_xml_document.parseError.Filepos)+ "~n~r" &
		  + "Line: " +string(ole_xml_document.parseError.Line)+ "~n~r" &
		  + "LinePosition: " +string(ole_xml_document.parseError.Linepos)+ "~n~r" &
		  + "Reason: " +string(ole_xml_document.parseError.Reason)+ "~n~r" &
		  + "SourceText: " +string(ole_xml_document.parseError.SrcText)

	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
	
end if

return k_return

end function

public function string get_tag (integer k_ind) throws uo_exception;//---
//--- Torna il nome del TAG
//---
string k_return=""
st_esito kst_esito

int k_ind1

if ole_xml_element.hasChildNodes then
	//k_elemento = ole_xml_node.text
	//k_elemento = ole_xml_node.NodeName //#text

	ole_xml_prova = ole_xml_document.SelectSingleNode('//pkl/id_cliente')
	IF IsValid (ole_xml_prova) THEN  k_return = String (ole_xml_prova.Text)
	
	ole_xml_prova = ole_xml_document.SelectSingleNode('//pkl/capitolato_fornitura')
	IF IsValid (ole_xml_prova) THEN  k_return = String (ole_xml_prova.Text)


//	k_ind1 = ole_xml_prova.childNodes(k_ind).childNodes.Item(0).text
//	k_return = ole_xml_prova.childNodes(k_ind).childnodes.Item(k_ind1).nodeName
//	k_return = ole_xml_prova.childNodes(k_ind).childNodes.Item(k_ind1).text	




	ole_xml_node = ole_xml_vettore_nodi.item(k_ind)
	k_return = ole_xml_node.parentNode.NodeName // nome del tag
	
	
//	ole_xml_element=ole_xml_document.GetFirstChild
	k_return = string(ole_xml_element.childNodes.item(k_ind).parentNode.nodeName) // nome del tag
	k_return = trim(ole_xml_element.childNodes.item(k_ind).parentNode.gatvalue)  // Valore del Tag

//		ole_xml_node = ole_xml_element.childNodes.item(1).FirstChild
	
	
//	else
//		k_return = ""
//	end if
	
end if


return k_return
end function

public function integer get_nr_tag () throws uo_exception;//---
//--- Torna il numero di TAG presenti nel documento
//---
int k_return=0
st_esito kst_esito


//if ole_xml_element.hasChildNodes then

//	k_return=ole_xml_element.childNodes.length
if isvalid(ole_xml_vettore_nodi) then
	k_return=ole_xml_vettore_nodi.length
	
end if


return k_return
end function

public function string get_attributo (string k_nome) throws uo_exception;//---
//--- Torna il valore dell'attributo indicato
//---
string k_return=""
st_esito kst_esito


	k_return = ole_xml_node.parentNode.getAttribute(k_nome) 


return k_return
end function

on kuf_wm_dll_xml_pkl_web.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_wm_dll_xml_pkl_web.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
if isvalid(ole_xml_document) then destroy ole_xml_document
if isvalid(ole_xml_element) then destroy ole_xml_element
if isvalid(ole_xml_node) then destroy ole_xml_node



end event

