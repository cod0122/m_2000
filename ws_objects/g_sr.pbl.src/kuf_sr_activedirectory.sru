$PBExportHeader$kuf_sr_activedirectory.sru
forward
global type kuf_sr_activedirectory from nonvisualobject
end type
end forward

global type kuf_sr_activedirectory from nonvisualobject
end type
global kuf_sr_activedirectory kuf_sr_activedirectory

type prototypes
//--- funzioni x l'accesso al AD di Windows per verificare pwd e utente di Windows
Function Long WNetGetUser (Ref String lpName, Ref String lpUserName, Ref Long lpnLength) Library "mpr" Alias For "WNetGetUserA;Ansi"
Function boolean LogonUser (string lpszUsername, string lpszDomain, string lpszPassword, ulong dwLogonType, ulong dwLogonProvider, ref ulong phToken) Library "advapi32.dll" Alias For "LogonUserA;Ansi"
Function boolean CloseHandle (ulong hObject) Library "kernel32.dll"

end prototypes

type variables
private:
//--- Tipo Modalita operativa su cui opera la windows carattere funzione
constant string ki_ELENCO="e"         
constant string ki_INSERIMENTO="i"     
constant string ki_MODIFICA="m"       
constant string ki_CANCELLAZIONE="c"   
constant string ki_VISUALIZZAZIONE="v"
constant string ki_INTERROGAZIONE="q" 
constant string ki_STAMPA="s" 
constant string ki_CHIUDI_PL="p"      
constant string ki_AUTORIZZATO="a"      
constant string ki_NAVIGATORE="n" 
constant string ki_ANTEPRIMA="v" //"t" 
constant string ki_BATCH="b" 

end variables

forward prototypes
public function string get_utente ()
public function boolean check_pwd (string a_username, string a_password)
end prototypes

public function string get_utente ();//
//
//--- Torna l'utente di AD di connessione
//
string k_return = '', ls_nullString
long ll_l

setnull(ls_nullString)

WNetGetUser(ls_nullString, k_return, ll_l) //gs_windows_user_name is current login user


return k_return

end function

public function boolean check_pwd (string a_username, string a_password);//
//
//--- Torna l'utente di AD di connessione
//
String ls_domain
ULong lul_token
boolean k_return=false
Constant ULong LOGON32_LOGON_NETWORK = 3
Constant ULong LOGON32_PROVIDER_DEFAULT = 0

ls_domain   = ""

k_return = LogonUser(a_username, ls_domain,a_password,LOGON32_LOGON_NETWORK,LOGON32_PROVIDER_DEFAULT, lul_token )

If not k_return Then
	CloseHandle(lul_token)
end if

return k_return

end function

on kuf_sr_activedirectory.create
call super::create
TriggerEvent( this, "constructor" )
end on

on kuf_sr_activedirectory.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

