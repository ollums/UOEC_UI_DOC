<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="LegacyRunebook" version="1.0" date="07/26/2010">

		<Author name="Lucitus, Gildar" email="info@lucitus.de" />
		<Description text="Leagacy Runebook by Gildar modded by Lucitus" />
		 
		<Files>
			<File name="Loader.lua" />
			<File name="LegacyRunebookLoader.lua" />
		</Files>
		
		<OnInitialize>
			<CallFunction name="LegacyRunebookLoader.Initialize" />
		</OnInitialize>		
        
	</UiMod>
</ModuleFile>
