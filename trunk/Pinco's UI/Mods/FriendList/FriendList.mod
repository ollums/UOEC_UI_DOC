<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="FriendList" version="1.0" date="27/12/2011">

		<Author name="Pinco" email="advertsign@guain.it" />
    <Dependencies>
      <Dependency name="CustomSettings" />
      <Dependency name="EnhancePack" />
    </Dependencies>
		<Files>
			<File name="Loader.lua" />
		</Files>
    <OnInitialize>
      <CreateWindow name="FriendList" show="true"/>
    </OnInitialize>
  </UiMod>
</ModuleFile>
