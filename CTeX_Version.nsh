﻿
!include "CTeX_Build.nsh"

; Application information
!define APP_NAME "CTeX"
!define APP_COMPANY "CTEX.ORG"
!define APP_COPYRIGHT "Copyright (C) 2000-2022 ${APP_COMPANY}"
!define APP_VERSION "3.0"
!define APP_STAGE "0" ; 0 - alpha, 1 - beta, 2 - release
!define APP_BUILD "${APP_VERSION}.${BUILD_NUMBER}.${APP_STAGE}"

; Components information
!define MiKTeX_Dir          "MiKTeX"
!define MiKTeX_Version      "2.9"
!define Addons_Dir          "CTeX"
!define Ghostscript_Dir     "Ghostscript"
!define Ghostscript_Version "9.05"
!define GSview_Dir          "GSview"
!define GSview_Version      "5.0"
!define WinEdt_Dir          "WinEdt"
!define WinEdt_Version      "7.0"
!define Logs_Dir            "Logs"
!define UserData_Dir        "UserData"


!if ${APP_STAGE} == "0"
	!define APP_VERSION_STAGE "${APP_VERSION}-alpha"
!else if ${APP_STAGE} == "1"
	!define APP_VERSION_STAGE "${APP_VERSION}-beta"
!else
	!define APP_VERSION_STAGE "${APP_VERSION}"
!endif

!macro Set_Version_Information
	VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "ProductName" "${APP_NAME}"
	VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "ProductVersion" "${APP_VERSION_STAGE}"
	VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "CompanyName" "${APP_COMPANY}"
	VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileDescription" "中文TeX套装"
	VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileVersion" "${APP_BUILD}"
	VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "LegalCopyright" "${APP_COPYRIGHT}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "${APP_NAME}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductVersion" "${APP_VERSION_STAGE}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "${APP_COMPANY}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "Chinese TeX Suite"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${APP_BUILD}"
	VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "${APP_COPYRIGHT}"
	VIProductVersion "${APP_BUILD}"
!macroend

!macro Check_Obsolete_Version
	ReadRegStr $R0 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\{7AB19E08-582F-4996-BB5D-7287222D25ED}" "UninstallString"
	${If} $R0 != ""
		MessageBox MB_OK|MB_ICONSTOP "$(Msg_ObsoleteVersion)"
		Abort
	${EndIf}

	ReadRegStr $R0 HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString"
	${If} $R0 != ""
		${If} $UN_INSTDIR == ""
		${OrIf} $UN_Version == ""
			MessageBox MB_OK|MB_ICONSTOP "$(Msg_ObsoleteVersion)"
			Abort
		${EndIf}
	${EndIf}
!macroend

!macro Check_Update_Version
	${If} $UN_INSTDIR != ""
!ifdef BUILD_REPAIR
		${If} $UN_Version != ${APP_BUILD}
			MessageBox MB_YESNO|MB_ICONEXCLAMATION "$(Msg_WrongVersion)" /SD IDYES IDYES +2
			Abort
		${EndIf}
!else
		${If} $UN_Version != ""
			${VersionCompare} $UN_Version ${APP_BUILD} $1
			${If} $1 == "1"
				MessageBox MB_YESNO|MB_ICONEXCLAMATION "$(Msg_Downgrade)" /SD IDNO IDYES +2
				Abort
			${EndIf}
		${EndIf}
		StrCpy $INSTDIR $UN_INSTDIR
!endif
	${EndIf}
!macroend
