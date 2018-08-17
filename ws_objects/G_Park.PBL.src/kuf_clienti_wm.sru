$PBExportHeader$kuf_clienti_wm.sru
forward
global type kuf_clienti_wm from kuf_parent
end type
end forward

global type kuf_clienti_wm from kuf_parent
end type
global kuf_clienti_wm kuf_clienti_wm

type variables
//
//
private kuo_sqlca_db_magazzino kiuo_sqlca_db_magazzino
private st_clienti_wm istClientiWM

end variables

forward prototypes
private subroutine get_connect () throws uo_exception
public subroutine set_id_cliente (long lid_cliente)
public function st_clienti_wm get_cliente ()
end prototypes

private subroutine get_connect () throws uo_exception;//
kuf_db kuf1_db


 kiuo_sqlca_db_magazzino = create Transaction //kuo_sqlca_db_magazzino

	kiuo_sqlca_db_magazzino.DBMS = "I10 INFORMIX-10.0"
	kiuo_sqlca_db_magazzino.DBParm = "Client_Locale='en_us.CP1252',DB_Locale='en_us.CP1252'"
	kiuo_sqlca_db_magazzino.Database = "gammarad"
	kiuo_sqlca_db_magazzino.UserId = "informix"
	kiuo_sqlca_db_magazzino.DBPass =  "infoxgamma"
	kiuo_sqlca_db_magazzino.LogPass =  "infoxgamma"
	kiuo_sqlca_db_magazzino.LogId = "informix"
	kiuo_sqlca_db_magazzino.ServerName = "AT-PIV34@gammarad_at1"

if not isvalid(kiuo_sqlca_db_magazzino) then

	kuf1_db = create kuf_db
	
	try
		kuf1_db.db_connect(kiuo_sqlca_db_magazzino)
		
	catch (uo_exception kuo_exception)
		throw (kuo_exception)

	finally
		destroy kuf1_db

	end try
		
end if


end subroutine

public subroutine set_id_cliente (long lid_cliente);//
istClientiWM.id_cliente = lid_cliente



end subroutine

public function st_clienti_wm get_cliente ();//



	try
		get_connect( )
	
		select rag_soc_10, loc_1, indi_1, cap_1, nazione_1 
			into :istClientiWM.nome
			, :istClientiWM.localita
			, :istClientiWM.indirizzo
			, :istClientiWM.cap
			, :istClientiWM.nazione
			from clienti
			where codice = :istClientiWM.id_cliente
			using kiuo_sqlca_db_magazzino;



	catch (uo_exception kuo_exceprion)
		
		
		
		
	finally
		
	end try
	
	


return istClientiWM


end function

on kuf_clienti_wm.create
call super::create
end on

on kuf_clienti_wm.destroy
call super::destroy
end on

event constructor;call super::constructor;//
kiuo_sqlca_db_magazzino = create Transaction //kuo_sqlca_db_magazzino

	kiuo_sqlca_db_magazzino.DBMS = "I10 INFORMIX-10.0"
	kiuo_sqlca_db_magazzino.DBParm = "Client_Locale='en_us.CP1252',DB_Locale='en_us.CP1252'"
	kiuo_sqlca_db_magazzino.Database = "gammarad"
	kiuo_sqlca_db_magazzino.UserId = "informix"
	kiuo_sqlca_db_magazzino.DBPass =  "infoxgamma"
	kiuo_sqlca_db_magazzino.LogPass =  "infoxgamma"
	kiuo_sqlca_db_magazzino.LogId = "informix"
	kiuo_sqlca_db_magazzino.ServerName = "AT-PIV34@gammarad_at1"

istClientiWM.id_cliente=0
istClientiWM.cap=""
istClientiWM.indirizzo=""
istClientiWM.localita=""
istClientiWM.nazione=""
istClientiWM.nome=""
istClientiWM.prov=""

end event

event destructor;call super::destructor;//
destroy kiuo_sqlca_db_magazzino
end event

