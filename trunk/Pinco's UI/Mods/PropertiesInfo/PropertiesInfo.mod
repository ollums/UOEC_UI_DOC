<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="PropertiesInfo" version="1.0" date="12/3/2012">

		<Author name="Pinco" email="advertsign@guain.it" />
    <Dependencies>
      <Dependency name="CustomSettings" />
      <Dependency name="EnhancePack" />
    </Dependencies>
		<Files>
			<File name="Loader.lua" />
		</Files>
        
		<OnInitialize>
			<CreateWindow name="PropertiesInfoWindow" show="false"/>
		</OnInitialize>


	</UiMod>
</ModuleFile>
