<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="Clock" version="1.0" date="07/24/2010">

		<Author name="Lucitus" email="info@lucitus.de" />
		<Description text="Lucis Clock" />
	 
		<Dependencies>
			<Dependency name="EnhancePack" />
		</Dependencies>	
		<Files>
			<File name="Loader.lua" />
			<File name="ClockWindowLoader.lua" />
		</Files>
        
		<OnInitialize>
			<CallFunction name="ClockWindowLoader.Initialize" />
		</OnInitialize>	
		<OnUpdate>
			<CallFunction name="ClockWindow.Update" />
		</OnUpdate>
	</UiMod>
</ModuleFile>
