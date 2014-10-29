<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="Compass" version="1.0" date="16/03/2013">

		<Author name="Pinco" email="advertsign@guain.it" />

    <Dependencies>
      <Dependency name="EnhancePack" />
    </Dependencies>
    
		<Files>
			<File name="Loader.lua" />
		</Files>
        
		<OnInitialize>
      			<CreateWindow name="Compass" show="false"/>
			<CallFunction name="Compass.Initialize" />
		</OnInitialize>		
	</UiMod>
</ModuleFile>
