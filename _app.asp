<%
'**********************************************
'**********************************************
'               _ _                 
'      /\      | (_)                
'     /  \   __| |_  __ _ _ __  ___ 
'    / /\ \ / _` | |/ _` | '_ \/ __|
'   / ____ \ (_| | | (_| | | | \__ \
'  /_/    \_\__,_| |\__,_|_| |_|___/
'               _/ | Digital Agency
'              |__/ 
' 
'* Project  : RabbitCMS
'* Developer: <Anthony Burak DURSUN>
'* E-Mail   : badursun@adjans.com.tr
'* Corp     : https://adjans.com.tr
'**********************************************
' LAST UPDATE: 28.10.2022 15:33 @badursun
'**********************************************


Class rabbitcms_database_migrator_plugin
	Private PLUGIN_CODE, PLUGIN_DB_NAME, PLUGIN_NAME, PLUGIN_VERSION, PLUGIN_CREDITS, PLUGIN_GIT, PLUGIN_DEV_URL, PLUGIN_FILES_ROOT, PLUGIN_ICON, PLUGIN_REMOVABLE, PLUGIN_ROOT, PLUGIN_FOLDER_NAME, PLUGIN_AUTOLOAD

	'---------------------------------------------------------------
	' Register Class
	'---------------------------------------------------------------
	Public Property Get class_register()
		DebugTimer ""& PLUGIN_CODE &" class_register() Start"
		
		' Check Register
		'------------------------------
		If CheckSettings("PLUGIN:"& PLUGIN_CODE &"") = True Then 
			DebugTimer ""& PLUGIN_CODE &" class_registered"
			Exit Property
		End If

		' Check And Create Table
		'------------------------------
		' Dim PluginTableName
		' 	PluginTableName = "tbl_plugin_" & PLUGIN_DB_NAME
    	
  '   	If TableExist(PluginTableName) = False Then
		' 	DebugTimer ""& PLUGIN_CODE &" table creating"
    		
  '   		Conn.Execute("SET NAMES utf8mb4;") 
  '   		Conn.Execute("SET FOREIGN_KEY_CHECKS = 0;") 
    		
  '   		Conn.Execute("DROP TABLE IF EXISTS `"& PluginTableName &"`")

  '   		q="CREATE TABLE `"& PluginTableName &"` ( "
  '   		q=q+"  `ID` int(11) NOT NULL AUTO_INCREMENT, "
  '   		q=q+"  `FILENAME` varchar(255) DEFAULT NULL, "
  '   		q=q+"  `FULL_PATH` varchar(255) DEFAULT NULL, "
  '   		q=q+"  `COMPRESS_DATE` datetime DEFAULT NULL, "
  '   		q=q+"  `COMPRESS_RATIO` double(255,0) DEFAULT NULL, "
  '   		q=q+"  `ORIGINAL_FILE_SIZE` bigint(20) DEFAULT 0, "
  '   		q=q+"  `COMPRESSED_FILE_SIZE` bigint(20) DEFAULT 0, "
  '   		q=q+"  `EARNED_SIZE` bigint(20) DEFAULT 0, "
  '   		q=q+"  `ORIGINAL_PROTECTED` int(1) DEFAULT 0, "
  '   		q=q+"  PRIMARY KEY (`ID`), "
  '   		q=q+"  KEY `IND1` (`FILENAME`) "
  '   		q=q+") ENGINE=MyISAM DEFAULT CHARSET=utf8; "
		' 	Conn.Execute(q) : q = ""

  '   		Conn.Execute("SET FOREIGN_KEY_CHECKS = 1;") 

		' 	' Create Log
		' 	'------------------------------
  '   		Call PanelLog(""& PLUGIN_CODE &" i??in "& PluginTableName &" tablosu olu??turuldu", 0, ""& PLUGIN_CODE &"", 0)
			
		' 	DebugTimer ""& PLUGIN_CODE &" "& PluginTableName &" table created"
  '   	End If

		' Register Settings
		'------------------------------
		a=GetSettings("PLUGIN:"& PLUGIN_CODE &"", PLUGIN_CODE)
		a=GetSettings(""&PLUGIN_CODE&"_PLUGIN_NAME", PLUGIN_NAME)
		a=GetSettings(""&PLUGIN_CODE&"_CLASS", "rabbitcms_database_migrator_plugin")
		a=GetSettings(""&PLUGIN_CODE&"_REGISTERED", ""& Now() &"")
		a=GetSettings(""&PLUGIN_CODE&"_CODENO", "55")
		a=GetSettings(""&PLUGIN_CODE&"_ACTIVE", "0")
		a=GetSettings(""&PLUGIN_CODE&"_FOLDER", PLUGIN_FOLDER_NAME)

		' Register Settings
		'------------------------------
		DebugTimer ""& PLUGIN_CODE &" class_register() End"
	End Property
	'---------------------------------------------------------------
	' Register Class
	'---------------------------------------------------------------

	'---------------------------------------------------------------
	' Plugin Admin Panel Extention
	'---------------------------------------------------------------
	Public sub LoadPanel()
		'--------------------------------------------------------
		' Sub Page 
		'--------------------------------------------------------
		If Query.Data("Page") = "SHOW:CachedFiles" Then
			Call PluginPage("Header")

			Call PluginPage("Footer")
			Call SystemTeardown("destroy")
		End If

		'--------------------------------------------------------
		' Main Page
		'--------------------------------------------------------
		With Response
			'------------------------------------------------------------------------------------------
				PLUGIN_PANEL_MASTER_HEADER This()
			'------------------------------------------------------------------------------------------
			.Write "<div class=""row"">"
			.Write "    <div class=""col-lg-6 col-sm-12"">"
			.Write 			QuickSettings("select", ""& PLUGIN_CODE &"_OPTION_1", "Buraya Title", "0#Se??enek 1|1#Se??enek 2|2#Se??enek 3", TO_DB)
			.Write "    </div>"
			.Write "    <div class=""col-lg-6 col-sm-12"">"
			.Write 			QuickSettings("number", ""& PLUGIN_CODE &"_OPTION_2", "Buraya Title", "", TO_DB)
			.Write "    </div>"
			.Write "    <div class=""col-lg-12 col-sm-12"">"
			.Write 			QuickSettings("tag", ""& PLUGIN_CODE &"_OPTION_3", "Buraya Title", "", TO_DB)
			.Write "    </div>"
			.Write "</div>"
			.Write "<div class=""row"">"
			.Write "    <div class=""col-lg-12 col-sm-12"">"
			.Write "        <a open-iframe href=""ajax.asp?Cmd=PluginSettings&PluginName="& PLUGIN_CODE &"&Page=SHOW:CachedFiles"" class=""btn btn-sm btn-primary"">"
			.Write "        	??nbelleklenmi?? Dosyalar?? G??ster"
			.Write "        </a>"
			.Write "        <a open-iframe href=""ajax.asp?Cmd=PluginSettings&PluginName="& PLUGIN_CODE &"&Page=DELETE:CachedFiles"" class=""btn btn-sm btn-danger"">"
			.Write "        	T??m ??nbelle??i Temizle"
			.Write "        </a>"
			.Write "    </div>"
			.Write "</div>"
		End With
	End Sub
	'---------------------------------------------------------------
	'
	'---------------------------------------------------------------

	'---------------------------------------------------------------
	' Class First Init
	'---------------------------------------------------------------
	Private Sub class_initialize()
    	'-------------------------------------------------------------------------------------
    	' PluginTemplate Main Variables
    	'-------------------------------------------------------------------------------------
    	PLUGIN_NAME 			= "RabbitCMS Database Migrate Plugin"
    	PLUGIN_CODE  			= "DBMIGRATOR"
    	PLUGIN_DB_NAME 			= "dbmigrator_log"
    	PLUGIN_VERSION 			= "1.0.0"
    	PLUGIN_CREDITS 			= "@badursun Anthony Burak DURSUN"
    	PLUGIN_GIT 				= "https://github.com/RabbitCMS-Hub/Rabbitcms-Database-Migrator-Plugin"
    	PLUGIN_DEV_URL 			= "https://adjans.com.tr"
    	PLUGIN_ICON 			= "zmdi-pin-help"
    	PLUGIN_REMOVABLE 		= True
    	PLUGIN_AUTOLOAD 		= False
    	PLUGIN_ROOT 			= PLUGIN_DIST_FOLDER_PATH(This)
    	PLUGIN_FILES_ROOT 		= PLUGIN_VIRTUAL_FOLDER(This)
    	'-------------------------------------------------------------------------------------
    	' PluginTemplate Main Variables
    	'-------------------------------------------------------------------------------------


    	'-------------------------------------------------------------------------------------
    	' PluginTemplate Register App
    	'-------------------------------------------------------------------------------------
    	class_register()

    	'-------------------------------------------------------------------------------------
    	' Hook Auto Load Plugin
    	'-------------------------------------------------------------------------------------
    	If PLUGIN_AUTOLOAD_AT("WEB") = True Then 

    	End If
	End Sub
	'---------------------------------------------------------------
	' Class First Init
	'---------------------------------------------------------------


	'---------------------------------------------------------------
	' Class Terminate
	'---------------------------------------------------------------
	Private sub class_terminate()

	End Sub
	'---------------------------------------------------------------
	' Class Terminate
	'---------------------------------------------------------------


	'---------------------------------------------------------------
	' Plugin Defines
	'---------------------------------------------------------------
	Public Property Get PluginCode() 		: PluginCode = PLUGIN_CODE 					: End Property
	Public Property Get PluginName() 		: PluginName = PLUGIN_NAME 					: End Property
	Public Property Get PluginVersion() 	: PluginVersion = PLUGIN_VERSION 			: End Property
	Public Property Get PluginGit() 		: PluginGit = PLUGIN_GIT 					: End Property
	Public Property Get PluginDevURL() 		: PluginDevURL = PLUGIN_DEV_URL 			: End Property
	Public Property Get PluginFolder() 		: PluginFolder = PLUGIN_FILES_ROOT 			: End Property
	Public Property Get PluginIcon() 		: PluginIcon = PLUGIN_ICON 					: End Property
	Public Property Get PluginRemovable() 	: PluginRemovable = PLUGIN_REMOVABLE 		: End Property
	Public Property Get PluginCredits() 	: PluginCredits = PLUGIN_CREDITS 			: End Property
	Public Property Get PluginRoot() 		: PluginRoot = PLUGIN_ROOT 					: End Property
	Public Property Get PluginFolderName() 	: PluginFolderName = PLUGIN_FOLDER_NAME 	: End Property
	Public Property Get PluginDBTable() 	: PluginDBTable = IIf(Len(PLUGIN_DB_NAME)>2, "tbl_plugin_"&PLUGIN_DB_NAME, "") 	: End Property
	Public Property Get PluginAutoload() 	: PluginAutoload = PLUGIN_AUTOLOAD 			: End Property

	Private Property Get This()
		This = Array(PluginCode, PluginName, PluginVersion, PluginGit, PluginDevURL, PluginFolder, PluginIcon, PluginRemovable, PluginCredits, PluginRoot, PluginFolderName, PluginDBTable, PluginAutoload)
	End Property
	'---------------------------------------------------------------
	' Plugin Defines
	'---------------------------------------------------------------
End Class 
%>
