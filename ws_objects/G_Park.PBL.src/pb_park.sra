$PBExportHeader$pb_park.sra
$PBExportComments$Generated Application Object
forward
global type pb_park from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type pb_park from application
string appname = "pb_park"
end type
global pb_park pb_park

on pb_park.create
appname = "pb_park"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on pb_park.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

