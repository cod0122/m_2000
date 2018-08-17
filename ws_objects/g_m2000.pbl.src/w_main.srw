$PBExportHeader$w_main.srw
$PBExportComments$windows principale di apertura
forward
global type w_main from w_main_0
end type
end forward

global type w_main from w_main_0
integer width = 2825
integer height = 1816
integer animationtime = 300
end type
global w_main w_main

on w_main.create
call super::create
end on

on w_main.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

