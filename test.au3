#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icon.ico
#AutoIt3Wrapper_Outfile_x64=..\_Installer.Exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <File.au3>
#include <GDIPlus.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include <GuiScrollBars.au3>
#include <Constants.au3>
#include <WinAPI.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>


GUICreate("test")

GUICtrlCreatePic("Standard Wallpaper.bmp", 0, 0)

GUISetState(@SW_SHOW)

while 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            ExitLoop
    EndSwitch
WEnd