; Script generated with the Venis Install Wizard

!define BUILD_NUMBER "20"
;!define BUILD_FULL
!define BUILD_REPAIR

; Define your application name
!define APP_NAME "CTeX"
!define APP_COMPANY "CTEX.ORG"
!define APP_COPYRIGHT "Copyright (C) 2009 ${APP_COMPANY}"
!define APP_VERSION "2.7.0"
!define APP_BUILD "${APP_VERSION}.${BUILD_NUMBER}"

; Main Install settings
Name "${APP_NAME} ${APP_VERSION}"
BrandingText "${APP_NAME} ${APP_BUILD} (C) ${APP_COMPANY}"
!ifndef BUILD_REPAIR
	InstallDir "C:\CTEX"
!ifndef BUILD_FULL
	OutFile "CTeX ${APP_BUILD}.exe"
!else
	OutFile "CTeX ${APP_BUILD} Full.exe"
!endif
!else
	InstallDir "$EXEDIR"
  OutFile "Repair.exe"
!endif

; Other settings
ShowInstDetails nevershow
ShowUninstDetails nevershow
RequestExecutionLevel admin

; Use compression
SetCompressor /SOLID LZMA
SetCompressorDictSize 128

; Functions and Macros
!include "CTeX_Setup.nsh"

; Modern interface settings
!include "MUI2.nsh"

!define MUI_ABORTWARNING
!define MUI_ICON "CTeX.ico"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE $(license)
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; Set languages (first is default language)
!insertmacro MUI_LANGUAGE "SimpChinese"
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_RESERVEFILE_LANGDLL

; Language strings
LicenseLangString license ${LANG_SIMPCHINESE} License-zh.txt
LicenseLangString license ${LANG_ENGLISH} License-en.txt

LangString Desc_MiKTeX ${LANG_SIMPCHINESE} "Windows下最好用的TeX系统之一，它带有一个很优秀的DVI预览器Yap。"
LangString Desc_MiKTeX ${LANG_ENGLISH} "One of the best TeX system on Windows platform, with an excellent DVI previewer Yap."
LangString Desc_Addons ${LANG_SIMPCHINESE} "中文TeX组件，包括CJK/CCT/TY和相应的字体设置，以及一些中文LaTeX宏包。"
LangString Desc_Addons ${LANG_ENGLISH} "Chinese TeX addons, including CJK/CCT/TY and their Chinese font settings, and several Chinese LaTeX packages."
LangString Desc_Ghostscript ${LANG_SIMPCHINESE} "PS (PostScript)语言和PDF文件的解释器，可在非PS打印机上打印它们。可以将PS文件和PDF文件相互转换。"
LangString Desc_Ghostscript ${LANG_ENGLISH} "PS (PostScript) and PDF interpreter."
LangString Desc_GSview ${LANG_SIMPCHINESE} "GSview是Ghostscript的图形界面程序，通过Ghostscript的支持，可以很方便地浏览和修改PS文件。"
LangString Desc_GSview ${LANG_ENGLISH} "GSview is the frontend GUI of Ghostscript, used with Ghostscript to view and edit PS (PostScript) file."
LangString Desc_WinEdt ${LANG_SIMPCHINESE} "WinEdt是一个编辑器，它内置了对TeX的良好支持。在它的菜单上和按钮上可以直接调用TeX程序，包括编译、预览等。WinEdt还能帮助你迅速输入各种TeX命令和符号，省去你记忆大量命令的烦恼。"
LangString Desc_WinEdt ${LANG_ENGLISH} "WinEdt a well designed text editor with full support to edit and compile TeX file."

LangString Desc_File ${LANG_SIMPCHINESE} "文档"
LangString Desc_File ${LANG_ENGLISH} "File"

; Components information
!define dMiKTeX "MiKTeX"
!define vMiKTeX "2.7"
!define dAddons "CTeX"
!define dGhostscript "Ghostscript"
!define vGhostscript "8.64"
!define dGSview "GSview"
!define vGSview "4.9"
!define dWinEdt "WinEdt"
!define vWinEdt "5.5"


!ifdef BUILD_REPAIR
Var OLDINSTDIR

Section -RepairSection

	ReadRegStr $OLDINSTDIR HKLM "Software\${APP_NAME}" ""

SectionEnd
!endif

Section "MiKTeX" Section_MiKTeX

	SetOverwrite on
	SetOutPath "$INSTDIR\${dMiKTeX}"

!ifndef BUILD_REPAIR
!ifndef BUILD_FULL
	File /r MiKTeX.basic\*.*
!else
	File /r MiKTeX.full\*.*
!endif
!endif

!ifdef BUILD_REPAIR
	${If} $OLDINSTDIR != ""
		!insertmacro Repair_Reg_MiKTeX "$OLDINSTDIR\${dMiKTeX}" "${vMiKTeX}"
	${EndIf}
!endif

	!insertmacro Install_Reg_MiKTeX "$INSTDIR\${dMiKTeX}" "${vMiKTeX}"
	!insertmacro Install_Link_MiKTeX "$INSTDIR\${dMiKTeX}" "${vMiKTeX}"

SectionEnd

Section "CTeX Addons" Section_Addons

	SetOverwrite On
	SetOutPath "$INSTDIR\${dAddons}"

!ifndef BUILD_REPAIR
	File /r Addons\CTeX\*.*
	File /r Addons\CJK\*.*
	File /r Addons\CCT\*.*
	File /r Addons\TY\*.*
!endif

!ifdef BUILD_REPAIR
	${If} $OLDINSTDIR != ""
		!insertmacro Repair_Reg_Addons "$OLDINSTDIR\${dAddons}" "${vMiKTeX}"
	${EndIf}
!endif

	!insertmacro Install_Reg_Addons "$INSTDIR\${dAddons}" "${vMiKTeX}"

SectionEnd

Section "Ghostscript" Section_Ghostscript

	SetOverwrite on
	SetOutPath "$INSTDIR\${dGhostscript}"

!ifndef BUILD_REPAIR
	File /r Ghostscript\*.*
!endif

!ifdef BUILD_REPAIR
	${If} $OLDINSTDIR != ""
		!insertmacro Repair_Reg_Ghostscript "$OLDINSTDIR\${dGhostscript}" "${vGhostscript}"
	${EndIf}
!endif

	!insertmacro Install_Reg_Ghostscript "$INSTDIR\${dGhostscript}" "${vGhostscript}"
	!insertmacro Install_Link_Ghostscript "$INSTDIR\${dGhostscript}" "${vGhostscript}"

SectionEnd

Section "GSview" Section_GSview

	SetOverwrite on
	SetOutPath "$INSTDIR\${dGSview}"

!ifndef BUILD_REPAIR
	File /r GSview\*.*
!endif

!ifdef BUILD_REPAIR
	${If} $OLDINSTDIR != ""
		!insertmacro Repair_Reg_GSview "$OLDINSTDIR\${dGSview}" "${vGSview}"
	${EndIf}
!endif

	!insertmacro Install_Reg_GSview "$INSTDIR\${dGSview}" "${vGSview}"
	!insertmacro Install_Link_GSview "$INSTDIR\${dGSview}" "${vGSview}"

SectionEnd

Section "WinEdt" Section_WinEdt

	SetOverwrite on
	SetOutPath "$INSTDIR\${dWinEdt}"

!ifndef BUILD_REPAIR
	File /r WinEdt\*.*
!endif

!ifdef BUILD_REPAIR
	${If} $OLDINSTDIR != ""
		!insertmacro Repair_Reg_WinEdt "$OLDINSTDIR\${dWinEdt}" "${vWinEdt}"
	${EndIf}
!endif

	!insertmacro Install_Reg_WinEdt "$INSTDIR\${dWinEdt}" "${vWinEdt}"
	!insertmacro Install_Link_WinEdt "$INSTDIR\${dWinEdt}" "${vWinEdt}"

	SectionGetFlags ${Section_MiKTeX} $R0
	IntOp $R0 $R0 & ${SF_SELECTED}
	${If} $R0 == ${SF_SELECTED}
		!insertmacro Associate_WinEdt_MiKTeX "$INSTDIR\${dWinEdt}" "${vMiKTeX}" 
	${EndIf}

SectionEnd

Section -FinishSection

	SetOverwrite on
	SetOutPath $INSTDIR

!ifndef BUILD_REPAIR
	File Readme.txt
	File Changes.txt
	File Repair.exe
!endif

	WriteRegStr HKLM "Software\${APP_NAME}" "" "$INSTDIR"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayName" "${APP_NAME}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayVersion" "${APP_BUILD}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "Publisher" "${APP_COMPANY}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "Readme" "$INSTDIR\Readme.txt"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "HelpLink" "http://bbs.ctex.org"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "URLInfoAbout" "http://www.ctex.org"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
	WriteUninstaller "$INSTDIR\Uninstall.exe"
	CreateDirectory "$SMPROGRAMS\CTeX"
	CreateShortCut "$SMPROGRAMS\CTeX\Uninstall CTeX.lnk" "$INSTDIR\Uninstall.exe"

	!insertmacro UPDATEFILEASSOC

	ExecWait "$INSTDIR\${dMiKTeX}\miktex\bin\mpm.exe --register-components --quiet"
	ExecWait "$INSTDIR\${dMiKTeX}\miktex\bin\initexmf.exe --force --mklinks --quiet"
	ExecWait "$INSTDIR\${dMiKTeX}\miktex\bin\initexmf.exe --update-fndb --quiet"
	ExecWait "$INSTDIR\${dMiKTeX}\miktex\bin\initexmf.exe --mkmaps --quiet"

SectionEnd

; Modern install component descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_MiKTeX} $(Desc_MiKTeX)
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_Addons} $(Desc_Addons)
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_Ghostscript} $(Desc_Ghostscript)
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_GSview} $(Desc_GSview)
	!insertmacro MUI_DESCRIPTION_TEXT ${Section_WinEdt} $(Desc_WinEdt)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;Uninstall section
Section Uninstall

	;Remove from registry...
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
	DeleteRegKey HKLM "Software\${APP_NAME}"

	ExecWait "$INSTDIR\${dMiKTeX}\miktex\bin\mpm.exe --unregister-components --quiet"

	!insertmacro Uninstall_Reg_MiKTeX "$INSTDIR\${dMiKTeX}" "${vMiKTeX}"
	!insertmacro Uninstall_Reg_Addons "$INSTDIR\${dAddons}" "${vMiKTeX}"
	!insertmacro Uninstall_Reg_Ghostscript "$INSTDIR\${dGhostscript}" "${vGhostscript}"
	!insertmacro Uninstall_Reg_GSview "$INSTDIR\${dGSview}" "${vGSview}"
	!insertmacro Uninstall_Reg_WinEdt "$INSTDIR\${dWinEdt}" "${vWinEdt}"

	; Delete self
	Delete "$INSTDIR\Uninstall.exe"

	; Delete Shortcuts
	RMDir /r "$SMPROGRAMS\CTeX"

	; Clean up CTeX
	RMDir /r $INSTDIR

	; Remove remaining directories

	!insertmacro UPDATEFILEASSOC

SectionEnd

; On initialization
Function .onInit

	!insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "ProductName" "${APP_NAME}"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "CompanyName" "${APP_COMPANY}"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileDescription" "中文TeX套装"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileVersion" "${APP_BUILD}"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "LegalCopyright" "${APP_COPYRIGHT}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "${APP_NAME}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "${APP_COMPANY}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "Chinese TeX Suite"
VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${APP_BUILD}"
VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "${APP_COPYRIGHT}"
VIProductVersion "${APP_BUILD}"

; eof