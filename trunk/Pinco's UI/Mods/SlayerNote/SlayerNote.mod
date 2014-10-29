<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="SlayerNote" version="1.0" date="07/07/2011">

		<Author name="Pinco" email="advertsign@guain.it" />

    <Dependencies>
      <Dependency name="EnhancePack" />
    </Dependencies>
    
		<Files>
			<File name="Loader.lua" />
		</Files>
        
		<OnInitialize>
      			<CreateWindow name="SlayerNote" show="false"/>
			<CallFunction name="SlayerNote.Initialize" />
		</OnInitialize>		
	</UiMod>
</ModuleFile>
