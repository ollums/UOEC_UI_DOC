<?xml version="1.0" encoding="UTF-8"?>
<ModuleFile xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
	<UiMod name="CraftingTool" version="1.0" date="12/03/2013">

		<Author name="Pinco" email="advertsign@guain.it" />
    <Dependencies>
      <Dependency name="CustomSettings" />
      <Dependency name="EnhancePack" />
    </Dependencies>
		<Files>
			<File name="Loader.lua" />
		</Files>
		<SavedVariables>
			<SavedVariable name="CraftingTool.CurrentMaterialsTid" />
			<SavedVariable name="CraftingTool.CurrentMaterialsColorTid" />
			<SavedVariable name="CraftingTool.LoadedToolsID" />
			<SavedVariable name="CraftingTool.MaterialsContainer" />
			<SavedVariable name="CraftingTool.CraftContainer" />
			<SavedVariable name="CraftingTool.LastSkill" />
			<SavedVariable name="CraftingTool.CurrentRunic" />
			<SavedVariable name="CraftingTool.SearchSettings" />
			<SavedVariable name="CraftingTool.LatestItems" />
			<!--<SavedVariable name="CraftingTool.ENUCliloc" />-->
		</SavedVariables>
		<OnInitialize>
			<CreateWindow name="CraftingToolWindow" show="false"/>
		</OnInitialize>


	</UiMod>
</ModuleFile>
