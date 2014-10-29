<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <UiMod name="NewChatWindow" version="1.0" date="14/09/2011">

    <Author name="Pinco" email="advertsign@guain.it" />

    <Dependencies>
      <Dependency name="CustomSettings" />
      <Dependency name="EnhancePack" />
    </Dependencies>
    <Files>
      <File name="Loader.lua" />
    </Files>
    <SavedVariables>
      <SavedVariable name="NewChatWindow.Settings" />
    </SavedVariables>
    <OnInitialize>
      <CreateWindow name="NewChatOptionsWindow" show="false"/>
      <CreateWindow name="NewChatWindow" show="false"/>
      <CallFunction name="NewChatOptionsWindow.Initialize" />
      <CallFunction name="NewChatWindow.Initialize" />

    </OnInitialize>
  </UiMod>
</ModuleFile>
