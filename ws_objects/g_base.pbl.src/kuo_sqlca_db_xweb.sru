$PBExportHeader$kuo_sqlca_db_xweb.sru
forward
global type kuo_sqlca_db_xweb from kuo_sqlca_db_0
end type
end forward

global type kuo_sqlca_db_xweb from kuo_sqlca_db_0
end type
global kuo_sqlca_db_xweb kuo_sqlca_db_xweb

type variables

end variables

forward prototypes
public function boolean db_connetti () throws uo_exception
public subroutine u_crea_schema () throws uo_exception
public function boolean if_connessione_bloccata () throws uo_exception
end prototypes

public function boolean db_connetti () throws uo_exception;//---
//--- Effettua la connessione al DB "esterno" leggendo i parametri da TAB
//---
boolean k_return=false
st_tab_db_cfg kst_tab_db_cfg
st_esito kst_esito
datastore kds_tab_db_cfg
kuf_db_cfg kuf1_db_cfg

kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""
kst_esito.nome_oggetto = this.classname()

	
try
	kuf1_db_cfg = create kuf_db_cfg
	
//--- piglia i dati di connessione dal DB	
	kst_tab_db_cfg.codice = kuf1_db_cfg.kki_codice_xweb
	kuf1_db_cfg.get_profilo_db(kst_tab_db_cfg)   // recupera i dati delprofilo di connessione

	k_return = db_connetti(kst_tab_db_cfg)
	
catch (uo_exception kuo_exception)	
	throw kuo_exception
	
finally
	destroy kuf1_db_cfg
	

end try

return k_return
end function

public subroutine u_crea_schema () throws uo_exception;//----------------------------------------------------------------------------------------------------------------------------
//--- 
//--- CANCELLA/CREA TABLE WEB UTENTI ESTERNA 
//---
//--- Lancia EXCEPTION
//---   
//----------------------------------------------------------------------------------------------------------------------------
//boolean k_return = false
string k_sql
st_esito kst_esito
st_errori_gestione kst_errori_gestione


kst_esito.esito = kkg_esito.ok
kst_esito.sqlcode = 0
kst_esito.SQLErrText = ""


	db_connetti( )

//--- Cancello e ricreo la tabella
	EXECUTE IMMEDIATE  "DROP TABLE IF EXISTS `utenti`; " using this ;
	db_commit()
	
k_sql = "  CREATE TABLE  `utenti` (`idUtente` int(11) NOT NULL , " &
+ "	  `Username` varchar(15) NOT NULL,  " &
+ "	  `Password` varchar(255) NOT NULL DEFAULT '',  " &
+ "	  `Email` varchar(40) NOT NULL DEFAULT '',  " &
+ "	  `Stato` char(1) NOT NULL DEFAULT '1',  " &
+ "	  `DataInserimento` varchar(80) NOT NULL,  " &
+ "	  `idCliente` varchar(5) NOT NULL ,  " &
+ "	  `RagioneSociale` varchar(255) NOT NULL,  " &
+ "	  `Indirizzo` varchar(255) NOT NULL,  " &
+ "	  `Cap` varchar(10) NOT NULL,  " &
+ "	  `Localita` varchar(50) NOT NULL,  " &
+ "	  `Provincia` varchar(2) NOT NULL,  " &
+ "	  `Nazione` varchar(2) NOT NULL,  " &
+ "	  `Note` text NOT NULL,  " &
+ "	  `Email1` varchar(150) NOT NULL DEFAULT '',  " &
+ "	  `Email2` varchar(150) NOT NULL DEFAULT '',  " &
+ "	  `idruolo` int(10) unsigned DEFAULT NULL,  " &
+ "	  PRIMARY KEY (`idUtente`) 	) ENGINE=MyISAM AUTO_INCREMENT=1028 DEFAULT CHARSET=latin1;  "  
	EXECUTE IMMEDIATE :k_sql using this;
//+ "	  `x_datins` datetime DEFAULT NULL,  " &
//+ "	  `x_utente` char(12) DEFAULT 'batch',  " &

	kst_esito.sqlerrtext = "Generazione terminata correttamente "
	if this.sqlcode <> 0 then
		if this.sqlcode > 0 then
		else
			kst_esito.esito = kkg_esito.db_ko
			kst_esito.sqlcode = this.sqlcode
			kst_esito.sqlerrtext = "Generazione Tabella esterna Web Utenti non riuscita: " + trim(this.SQLErrText)
		end if
		db_rollback( )

//--- scrive l'errore su LOG
		kst_errori_gestione.nome_oggetto = this.classname()
		kst_errori_gestione.sqlsyntax = trim(kst_esito.sqlerrtext)
		kst_errori_gestione.sqlerrtext = trim(this.SQLErrText)
		kst_errori_gestione.sqldbcode = this.sqlcode
		kst_errori_gestione.sqlca = this
		kGuf_data_base.errori_gestione(kst_errori_gestione)

//--- Lancia EXCEPTION
		if kst_esito.esito = kkg_esito.db_ko then
			kguo_exception.inizializza( )
			kguo_exception.set_esito(kst_esito)
			throw kguo_exception
		end if

	else
		db_commit( )
		
//		k_return = TRUE
		
	end if


//return k_return
end subroutine

public function boolean if_connessione_bloccata () throws uo_exception;//
//---	Torna FALSE=connessione OK, TRUE=connessione BLOCCATA
//--- da personalizzare
//
boolean k_return = false
st_tab_db_cfg kst_tab_db_cfg
kuf_db_cfg kuf1_db_cfg


	kuf1_db_cfg = create kuf_db_cfg
		
	kst_tab_db_cfg.codice = kuf1_db_cfg.kki_codice_xweb
	if kuf1_db_cfg.if_connessione_bloccata(kst_tab_db_cfg) then    // Connessione bloccata?? speriamo di no
		k_return = true
	end if
	
return k_return
end function

on kuo_sqlca_db_xweb.create
call super::create
end on

on kuo_sqlca_db_xweb.destroy
call super::destroy
end on

event constructor;call super::constructor;//
 ki_db_descrizione = "DB di scambio dati con il WEB (SMART)"
end event

