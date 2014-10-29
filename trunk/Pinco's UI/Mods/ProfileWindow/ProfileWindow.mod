<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="ProfileWindow" version="1.0" date="19/03/2011">

		<Author name="Pinco" email="advertsign@guain.it" />

		<Files>
			<File name="Loader.lua" />
		</Files>
        
		<OnInitialize>
      		<CreateWindow name="ProfileWindow" show="false"/>
			<CallFunction name="ProfileWindow.Initialize" />
		</OnInitialize>		
	</UiMod>
</ModuleFile>
