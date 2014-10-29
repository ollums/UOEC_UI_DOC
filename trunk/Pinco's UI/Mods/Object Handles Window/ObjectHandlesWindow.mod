<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="ObjectHandlesWindow" version="1.0" date="07/26/2010">

		<Author name="Lucitus" email="info@lucitus.de" />
		<Description text="With this Window you can switch the Objecthandle display fast" />
    <Dependencies>
      <Dependency name="CustomSettings" />
      <Dependency name="EnhancePack" />
    </Dependencies>

		<Files>
			<File name="Loader.lua" />
		</Files>
        
		<OnInitialize>
      <CreateWindow name="ObjectHandleToggleWindow" show="false"/>
			<CallFunction name="ObjectHandleToggleWindow.Initialize" />
		</OnInitialize>		
	</UiMod>
</ModuleFile>
