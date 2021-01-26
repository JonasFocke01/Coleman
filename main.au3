#RequireAdmin
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
#include <WinAPIRes.au3>

Global Const $sourcePath = '\\Tigerly\Allgemeine Daten\Sonstiges\Installer\'
Global Const $installerPath = '\\Tigerly\Allgemeine Daten\Sonstiges\Installer\Installer\'
Global Const $cursorPath = '\\Tigerly\Allgemeine Daten\Sonstiges\Installer\Cursor\'
Global Const $minecraftPath = '\\Tigerly\Allgemeine Daten\Sonstiges\Installer\Minecraft'

Func _Coleman ()
    Local Const $iguiheight = ((UBound(_FileListToArray($installerPath, Default, 1)) * 20) + 9) / 2

    ;create GUI
    $hgui = GUICreate("Coleman", 600, $iguiheight, @DeskTopWidth - 620)
    GUISetIcon("icon.ico")

    ;create GUI content storage
    Local $aInstallerCheckboxen[0]
    Local $aOptions[0];content: install, activatewindows, setwallpaper, cleartaskbar, showstartup, showupdatepage

    ;fill $aInstallerCheckboxen
    $index = 5
    For $entry in _FileListToArray($installerPath, Default, 1)
        If NOT IsInt($entry) Then
            If $index < $iguiheight - 10 Then
                _ArrayAdd($aInstallerCheckboxen, GUICtrlCreateCheckbox($entry, 10, $index))
            Else
                _ArrayAdd($aInstallerCheckboxen, GUICtrlCreateCheckbox($entry, 210, ($index - $iguiheight) + 4))
            EndIf;todo: scale this right
            $index = $index + 20
        EndIf
    Next
    
    ;create GUI content
    _ArrayAdd($aOptions, GUICtrlCreateButton("Programme installieren",      400,   2, 200, 30))
    _ArrayAdd($aOptions, GUICtrlCreateButton("Windows aktivieren",          400,  34, 200, 30))
    _ArrayAdd($aOptions, GUICtrlCreateButton("Setze Hintergrundbild",       400,  66, 200, 30))
    _ArrayAdd($aOptions, GUICtrlCreateButton("start/ taskbar aufräumen",    400,  98, 200, 30))
    _ArrayAdd($aOptions, GUICtrlCreateButton("Zeige Autostart",             400, 130, 200, 30))
    _ArrayAdd($aOptions, GUICtrlCreateButton("Zeige Updates",               400, 162, 200, 30))

    ;setze stati
    For $entry in $aOptions;set red
        GUICtrlSetBkColor($entry,0xFF0000)
    Next
    For $entry in $aOptions;check if done already
        If False Then GUICtrlSetBkColor($entry,0x00FF00)
    Next

    ;create progress bar
    $hbar = GUICtrlCreateProgress(410, 245, 180, 10)
    $hlblbartext = GUICtrlCreateLabel("", 410, 259, 400, 15)

    ;create and fill cursor combo
    $hlblcursor = GUICtrlCreateLabel("Cursor Schema:", 480, 203, 112, 20)
    $hcursor = GUICtrlCreateCombo("default", 480, 215, 112, 30)
    For $entry in _FileListToArray($cursorPath, Default, 1)
        If NOT IsInt($entry) Then
            GUICTRLSetData($hcursor, $entry)
        EndIf
    Next

    ;create light and darkmode radio
    $hlightmode = GUICtrlCreateRadio("Lightmode", 400, 200)
    GUICtrlSetState($hlightmode, True)
    $hdarkmode =  GUICtrlCreateRadio("Darkmode", 400, 220)

    ;GUI
    GUISetState(@SW_SHOW, $hGUI)
    While 1
        If NOT True And IsActivated() Then 
            GUICtrlSetBkColor($aOptions[1],0x00FF00);set green
        EndIf
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                ExitLoop
            Case $aOptions[0];install
                $progress = 0
                GUICtrlSetBkColor($aOptions[0],0x00FF00)
                For $entry in $aInstallerCheckboxen
                    GUICtrlSetData($hbar, $progress)
                    GUICtrlSetData($hlblbartext, "Installiere " & GUICtrlRead($entry, 1) & "...")
                    If GUICtrlRead($entry) == 1 And StringInStr(GUICtrlRead($entry, 1), "Cinebench") > 0 Then
                        FileCopy($installerPath & "Cinebench", @DesktopDir);bug!!!!!!!!
                    ElseIf GUICtrlRead($entry) == 1 Then
                        If StringInStr(GUICtrlRead($entry, 1), "7zip") > 0 Then;check for silent installer
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1), "/S")
                        ElseIf StringInStr(GUICtrlRead($entry, 1), "aida64") > 0 Then 
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1), "/SILENT")
                        ElseIf StringInStr(GUICtrlRead($entry, 1), "Audacity") > 0 Then 
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1), "/VERYSILENT")
                        ElseIf StringInStr(GUICtrlRead($entry, 1), "Discord") > 0 Then 
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1), "/s")
                        ElseIf StringInStr(GUICtrlRead($entry, 1), "Git") > 0 Then 
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1), "/SILENT")
                        ElseIf StringInStr(GUICtrlRead($entry, 1), "Greenshot") > 0 Then 
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1), "/VERYSILENT")
                        ElseIf StringInStr(GUICtrlRead($entry, 1), "Java") > 0 Then 
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1), "/s")
                        ElseIf StringInStr(GUICtrlRead($entry, 1), "notepad++") > 0 Then 
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1), "/S")
                        ElseIf StringInStr(GUICtrlRead($entry, 1), "PDF24") > 0 Then 
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1), "/SILENT")
                        ElseIf StringInStr(GUICtrlRead($entry, 1), "Spotify") > 0 Then 
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1), "/Silent")
                        ElseIf StringInStr(GUICtrlRead($entry, 1), "Teams") > 0 Then 
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1), "-s")
                        ElseIf StringInStr(GUICtrlRead($entry, 1), "Teamspeak") > 0 Then 
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1), "/S")
                        ElseIf StringInStr(GUICtrlRead($entry, 1), "vlc") > 0 Then 
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1), "/S")
                        Else
                            ShellExecuteWait($installerPath & GUICtrlRead($entry, 1))
                        EndIf
                        If StringInStr(GUICtrlRead($entry, 1), "Steam") > 0 Then
                            Sleep(2000)
                            ShellExecuteWait(@UserProfileDir & "\Downloads\SteamSetup.exe")
                        ElseIf StringInStr(GUICtrlRead($entry, 1), "Java") > 0 Then
                            minecraft()
                        EndIf
                    EndIf
                    $progress = $progress + (100 / UBound($aInstallerCheckboxen))
                Next
                GUICtrlSetData($hbar, 100)
                GUICtrlSetData($hlblbartext, "Installation fertig")
            Case $aOptions[2];setwallpaper
                GUICtrlSetBkColor($aOptions[2],0x00FF00)
                _setwallpaper($sourcePath & "autoinstaller\Standard Wallpaper.bmp")
            Case $hcursor
                Local $sCursorInstallPath = "C:\Windows\Cursors\"
                UnZip($cursorPath & GUICtrlRead($hcursor), $sCursorInstallPath)
                RunWait(@ComSpec & " /c start ms-settings:mousetouchpad")
                ;MsgBox(0, "", $sCursorInstallPath & StringLeft(GUICtrlRead($hcursor, 1), StringinStr(GUICtrlRead($hcursor, 1), ".")-1) & "\sdfg.cur")
                ;_WinAPI_SetSystemCursor(_WinAPI_LoadCursorFromFile($sCursorInstallPath & StringLeft(GUICtrlRead($hcursor, 1), StringinStr(GUICtrlRead($hcursor, 1), ".")-1) & "\sdfg.cur"),$OCR_NORMAL, True)
            Case $aOptions[1];activatewindows
                GUICtrlSetBkColor($aOptions[1],0x00FF00)
                RunWait(@ComSpec & " /c start ms-settings:activation")
                ShellExecute("chrome.exe", "https://www.gamers-outlet.net/buy-windows-10-professional-retail-microsoft-global-cd-key.html?search=Windows%2010%20pro&limit=7 --new-window")
            Case $hlightmode
                RunWait("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 1")
            Case $hdarkmode
                RunWait("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0")
            Case $aOptions[3];cleartaskbar
                GUICtrlSetBkColor($aOptions[3],0x00FF00)
                RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband","Favorites","REG_BINARY","0xFF")
                RegDelete("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband","FavoritesResolve")
                processclose("explorer.exe")
            Case $aOptions[5];showupdatepage
                GUICtrlSetBkColor($aOptions[5],0x00FF00)
                RunWait(@ComSpec & " /c start ms-settings:windowsupdate")
            Case $aOptions[4];showstartup
                GUICtrlSetBkColor($aOptions[4],0x00FF00)
                RunWait(@ComSpec & " /c start ms-settings:startupapps")
        EndSwitch
    WEnd
EndFunc ;==>_GUI

Func minecraft()
    $minecraftInstallPath = @UserProfileDir & "\Documents\Minecraft"
    DirCreate($minecraftInstallPath)
    FileCopy($minecraftPath & "\Minecraft.exe", $minecraftInstallPath & "\Minecraft.exe")
    FileCopy($minecraftPath & "\Serverstart.bat", $minecraftInstallPath & "\Serverstart.bat")
    FileCopy($minecraftPath & "\Wie starte ich den Server.txt", $minecraftInstallPath & "\Wie starte ich den Server.txt")
    FileCopy($minecraftPath & "\server.jar", $minecraftInstallPath & "\server.jar")
    FileCreateShortcut($minecraftInstallPath & "\Minecraft.exe", @DesktopDir & "Minecraft")
    ShellExecuteWait($minecraftInstallPath & "\Minecraft.exe")
EndFunc ;==>minecraft()

Func IsActivated()
    $oWMIService = ObjGet("winmgmts:\\.\root\cimv2")
    If IsObj($oWMIService) Then
     $oCollection = $oWMIService.ExecQuery("SELECT Description, LicenseStatus, GracePeriodRemaining FROM SoftwareLicensingProduct WHERE PartialProductKey <> null")
     If IsObj($oCollection) Then
      For $oItem In $oCollection
       If $oItem.LicenseStatus == 1 Then
          Return True
       EndIf
      Next
     EndIf
    EndIf
EndFunc ;==>IsActivated()

Func UnZip($sZipFile, $sDestFolder)
  If Not FileExists($sZipFile) Then Return SetError (1) ; source file does not exists
  If Not FileExists($sDestFolder) Then
    If Not DirCreate($sDestFolder) Then Return SetError (2) ; unable to create destination
  Else
    If Not StringInStr(FileGetAttrib($sDestFolder), "D") Then Return SetError (3) ; destination not folder
  EndIf
  Local $oShell = ObjCreate("shell.application")
  Local $oZip = $oShell.NameSpace($sZipFile)
  Local $iZipFileCount = $oZip.items.Count
  If Not $iZipFileCount Then Return SetError (4) ; zip file empty
  For $oFile In $oZip.items
    $oShell.NameSpace($sDestFolder).copyhere($ofile)
  Next
EndFunc   ;==>UnZip

Func _setwallpaper($pic, $style = 0, $warn = 1)
    if $warn = 1 then
    $m1 = @DesktopHeight/2
    $m2 = @DeskTopWidth/2
   EndIf
   If Not FileExists($pic) Then Return -1
   
   $s = StringSplit ( $pic, '.', 1 )
if $s[2] = 'bmp' Then
    $bmp = 'true'
Else
    $bmp = 'false'
EndIf   

If $bmp = 'false' then
    $text = StringReplace($pic, ".jpg", ".bmp")
    _GDIPlus_Startup ()
    $hImage = _GDIPlus_ImageLoadFromFile($pic)
    $sCLSID = _GDIPlus_EncodersGetCLSID ("BMP")
    _GDIPlus_ImageSaveToFileEx($hImage, $text, $sCLSID)
    _GDIPlus_ShutDown()
    $pic = $text
    EndIf
       Local $SPI_SETDESKWALLPAPER = 20
       Local $SPIF_UPDATEINIFILE = 1
       Local $SPIF_SENDCHANGE = 2
       Local $REG_DESKTOP= "HKEY_CURRENT_USER\\Control Panel\\Desktop"
       if $style = 1 then 
       RegWrite($REG_DESKTOP, "TileWallPaper", "REG_SZ", 1)
       RegWrite($REG_DESKTOP, "WallpaperStyle", "REG_SZ", 0)
    Else
       RegWrite($REG_DESKTOP, "TileWallPaper", "REG_SZ", 0)
       RegWrite($REG_DESKTOP, "WallpaperStyle", "REG_SZ", $style)
    EndIf
    
       DllCall("user32.dll", "int", "SystemParametersInfo", _
             "int", $SPI_SETDESKWALLPAPER, _
             "int", 0, _
             "str", $pic, _
             "int", BitOR($SPIF_UPDATEINIFILE, $SPIF_SENDCHANGE))
       Return 0
       if $warn = 1 then
       sleep ( 2000 )
       EndIf
EndFunc ;==>_setwallpaper

_Coleman()