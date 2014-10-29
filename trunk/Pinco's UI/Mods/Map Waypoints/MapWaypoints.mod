<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="MapWaypoints" version="1.0" date="02/10/2010">
		<Author name="Pinco" email="advertsign@guain.it" />
		<Dependencies>
			<Dependency name="EnhancePack" />
		</Dependencies>
		<Files>
      <File name="Loader.lua" />
			<File name="MapWaypoints.lua" />
		</Files>
		
		<OnInitialize>
			<CreateWindow name="MapWaypoints" show="false"/>
			<CallFunction name="MapWaypoints.Initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>
