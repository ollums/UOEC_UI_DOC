<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="DiabloHealth" version="1.2" date="11/28/2009">
		<Author name="Illandril" email="illandril@modders-exchange.net" />
		<Description text="http://uo.modders-exchange.net" />

    <Dependencies>
      <Dependency name="EnhancePack" />
    </Dependencies>
    
		<Files>
			<File name="Loader.lua" />
			<File name="DiabloHealth.lua" />
		</Files>
		
		<OnInitialize>
      <CallFunction name="DiabloHealth.Initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>
