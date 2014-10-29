<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="Hourglass" version="1.0" date="02/10/2010">
		<Author name="Pinco" email="advertsign@guain.it" />
		<Dependencies>
			<Dependency name="EnhancePack" />
		</Dependencies>
		<Files>
			<File name="Loader.lua" />
			<File name="Hourglass.lua" />
		</Files>
		
		<OnInitialize>
			<CreateWindow name="Hourglass" show="true"/>
			<CallFunction name="Hourglass.Initialize" />
		</OnInitialize>
	</UiMod>
</ModuleFile>
