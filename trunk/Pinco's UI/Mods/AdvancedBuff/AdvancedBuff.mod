<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="AdvancedBuff" version="1.0" date="07/11/2010">

		<Author name="Pinco" email="advertsign@guain.it" />
    <Dependencies>
      <Dependency name="CustomSettings" />
      <Dependency name="EnhancePack" />
    </Dependencies>
		<Files>
			<File name="Loader.lua" />
		</Files>

    <OnInitialize>
      <CallFunction name="AdvancedBuff.Initialize" />
    </OnInitialize>
  </UiMod>
</ModuleFile>
