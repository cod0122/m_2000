$PBExportHeader$kuf_wm_dll_m2000utility.sru
forward
global type kuf_wm_dll_m2000utility from nonvisualobject
end type
end forward

global type kuf_wm_dll_m2000utility from nonvisualobject descriptor "PB_ObjectCodeAssistants" = "{BB0DD547-B36E-11D1-BB47-000086095DDA}" 
end type
global kuf_wm_dll_m2000utility kuf_wm_dll_m2000utility

type prototypes

//--- piglia il nome del computer
//FUNCTION string M2000Utility(ref string barcode) LIBRARY "C:\gammarad\progetto_WM\PAOLO\M2000utility\bin\Debug\M2000utility.dll" alias for "M2000Utility;Ansi"

end prototypes

type variables
//
//--- Oggetto di call a dll .NET
//--- 
/*
--- Per fare un oggetto .NET richiamabile dobbiamo costruire un "COM Callable Wrapper (CCW)"
 
1) in C# Express nei param di compilazione
fleggare "Make assembly COM-visible" da Proprietà->Applicazioni->Informazioni Assembly 
e sempre da Proprietà scegliere Firma e "Choose a strong name key file" che è poi il riferimento all'oggetto
che si usa qui in PB
2) poi lanciare il REGASM per generare il .REG, ad esempio:
C:\Windows\Microsoft.NET\Framework\v2.0.50727\regasm M2000utility.dll /regfile:M2000utility.reg
3) poi lanciare la registrazione come AMMINISTRATORE con GACUTIL, ad esempio:
C:\"Program Files"\Microsoft.NET\SDK\v2.0\Bin\gacutil /i "C:\gammarad\progetto_WM\PAOLO\M2000utility\bin\Debug\M2000utility.dll"
4) doppio clic sul .REG regitrato prima per caricarlo nel registro di sistema
5) l'oggetto è pronto x essere utilizzato ad esempio:
oleobject kidll_M2000utility
kidll_M2000utility = create  oleobject
k_rc = kdll_M2000utility.ConnectToNewObject("M2000Utility.M2000Utility")

*/
//---
//---
//---
//---
//---

//---
//

private string ki_m2000_dll_nome = "M2000Utility.M2000Utility"
private string ki_user = "M2000"
private string ki_pwd = "M2000"

private oleobject kidll_M2000utility

end variables

forward prototypes
public subroutine login () throws uo_exception
public subroutine caricopilota (string k_barcode) throws uo_exception
public subroutine scaricopilota (string k_barcode) throws uo_exception
public subroutine logout () throws uo_exception
public function boolean check ()
public subroutine crea_object () throws uo_exception
end prototypes

public subroutine login () throws uo_exception;//
//--- Connessione al DLL di .NET
//---
st_esito kst_esito


kst_esito.sqlerrtext = kidll_M2000utility.Login(ki_user, ki_pwd)
//--- Se ERRORE ovvero <> ""
if len(trim(kst_esito.sqlerrtext)) > 0 then
	
	kst_esito.esito = kkg_esito.db_ko
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()

	kguo_exception.inizializza( )
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
end if


end subroutine

public subroutine caricopilota (string k_barcode) throws uo_exception;//---
//--- Informa il Pilota che il barcode è in trattamento
//---
st_esito kst_esito

kst_esito.sqlerrtext = kidll_M2000utility.CaricoPilota(k_barcode)
//--- Se ERRORE ovvero <> ""
if len(trim(kst_esito.sqlerrtext)) > 0 then
	
	kst_esito.esito = kkg_esito.db_ko
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()

	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
end if


end subroutine

public subroutine scaricopilota (string k_barcode) throws uo_exception;//---
//--- Informa il Pilota che il barcode è a fine trattamento
//---
st_esito kst_esito


kst_esito.sqlerrtext = kidll_M2000utility.ScaricoPilota(k_barcode)
//--- Se ERRORE ovvero <> ""
if len(trim(kst_esito.sqlerrtext)) > 0 then
	
	kst_esito.esito = kkg_esito.db_ko
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()

	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
	
end if


end subroutine

public subroutine logout () throws uo_exception;//
//--- LogOut dal DLL di .NET
//---
st_esito kst_esito

if isvalid(kidll_M2000utility) then
	kst_esito.sqlerrtext = kidll_M2000utility.Logout()
	//--- Se ERRORE ovvero <> ""
	if len(trim(kst_esito.sqlerrtext)) > 0 then
		
		kst_esito.esito = kkg_esito.db_ko
		kst_esito.sqlcode = 0
		kst_esito.nome_oggetto = this.classname()
	
		kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_db_ko )
		kguo_exception.set_esito(kst_esito)
		throw kguo_exception
		
	end if
end if

end subroutine

public function boolean check ();//------------------------------------------------------------------------------------------------------------------------------------
//--- Controlla la presenza della DLL fornita da WM
//---
//--- Ritorna:  TRUE = ok / FALSE = controllo fallito
//---
//------------------------------------------------------------------------------------------------------------------------------------
//
boolean k_return = false

	try 
		crea_object()
		login( )
		logout( )
		
		k_return = true 
		
	catch (uo_exception kuo10_exception)
		k_return = false			
		
	end try


return k_return

end function

public subroutine crea_object () throws uo_exception;//
integer k_rc
st_esito kst_esito


kidll_M2000utility = create  oleobject
k_rc = kidll_M2000utility.ConnectToNewObject(ki_m2000_dll_nome)

if k_rc < 0 then

	kst_esito.esito = kkg_esito.no_esecuzione
	kst_esito.sqlcode = 0
	kst_esito.nome_oggetto = this.classname()

	choose case k_rc
		case -1
				kst_esito.sqlerrtext = "Fallito Create oggetto kuf_wm_dll_m2000utility: " + string(k_rc) +" Invalid Call: the argument is the Object property of a control"
		case -2
				kst_esito.sqlerrtext = "Fallito Create oggetto kuf_wm_dll_m2000utility:  " + string(k_rc) +" Class name not found"
		case -3
				kst_esito.sqlerrtext = "Fallito Create oggetto kuf_wm_dll_m2000utility:  " + string(k_rc) +" Object could not be created"
		case -4
				kst_esito.sqlerrtext = "Fallito Create oggetto kuf_wm_dll_m2000utility:  " + string(k_rc) +" Could not connect to object"
		case -9
				kst_esito.sqlerrtext = "Fallito Create oggetto kuf_wm_dll_m2000utility:  " + string(k_rc) +" Other error"
		case -15
				kst_esito.sqlerrtext = "Fallito Create oggetto kuf_wm_dll_m2000utility:  " + string(k_rc) +" COM+ is not loaded on this computer"
		case -16
				kst_esito.sqlerrtext = "Fallito Create oggetto kuf_wm_dll_m2000utility:  " + string(k_rc) +" Invalid Call: this function not applicable"
		case else
				kst_esito.sqlerrtext = "Fallito Create oggetto kuf_wm_dll_m2000utility:  " + string(k_rc) +" "
	end choose
	kguo_exception.inizializza( )
	kguo_exception.set_tipo( kguo_exception.kk_st_uo_exception_tipo_err_int )
	kguo_exception.set_esito(kst_esito)
	throw kguo_exception
end if


end subroutine

on kuf_wm_dll_m2000utility.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_wm_dll_m2000utility.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//
if isvalid(kidll_M2000utility) then destroy kidll_M2000utility

end event

