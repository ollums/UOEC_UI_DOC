<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="AnimalLore" version="1.0" date="03/06/2011">

		<Author name="Sarphus, Pinco" email="advertsign@guain.it" />
    <Dependencies>
      <Dependency name="EnhancePack" />
    </Dependencies>
		<Files>
			<File name="Loader.lua" />
      <File name="AnimalLore.lua" />
		</Files>
    <OnInitialize>
      <CallFunction name="AnimalLore.Initialized" />
    </OnInitialize>
  </UiMod>
</ModuleFile>
