<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="EnhancePack" version="2.0" date="11/28/2009">
		<Author name="Pinco" email="advertsign@guain.it" />
		<Dependencies>
			<Dependency name="CustomSettings" />
		</Dependencies>
		<Files>
			<File name="CreaturesDB.lua" />
			<File name="SlayersDB.lua" />
			<File name="Loader.lua" />
			<File name="ScreenshotHelper.lua" />
			<File name="ServerLine.lua" />
			<File name="KnownAreas.lua" />
			<File name="Waypoints.lua" />
      <File name="EnhancePack.lua" />
      <File name="TextParsing.lua" />
			<File name="ItemPropertiesEvaluator.lua" />
			<File name="ArtifactsDB.lua" />
			<File name="SpellsInfo.lua" />
			<File name="ItemsInfo.lua" />
			<File name="LootDB.lua" />
			<File name="ExtraIcons.lua" />
			<File name="CustomSounds.lua" />
			<File name="Organizer.lua" />
		</Files>
		<SavedVariables>
			<SavedVariable name="EnhancePack.Setting" />
		</SavedVariables>
		<OnInitialize>
			<CallFunction name="EnhancePack.Initialize" />
			<CallFunction name="ExtraIcons.Initialize" />
			<CallFunction name="CreaturesDB.Initialize" />
		</OnInitialize>
		<OnShutdown>
			<CallFunction name="EnhancePack.Shutdown" />
		</OnShutdown>
	</UiMod>
</ModuleFile>
