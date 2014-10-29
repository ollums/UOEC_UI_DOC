----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------
-- v 0.9.4

ItemPropertiesEvaluator = {}

ItemPropertiesEvaluator.LOW_INTENSITY = {r=255,g=32,b=32} -- residue
ItemPropertiesEvaluator.MED_INTENSITY = {r=0,g=255,b=64} -- essence
ItemPropertiesEvaluator.HIGH_INTENSITY = {r=182,g=175,b=179} -- relic

ItemPropertiesEvaluator.orderShield = GetStringFromTid(1027108)-- Order shield
ItemPropertiesEvaluator.chaosShield = GetStringFromTid(1027107)-- Chaos shield

ItemPropertiesEvaluator.escape =  L" ~1_val~%%"
ItemPropertiesEvaluator.escape0Bis = L" ~1_val~%%"
ItemPropertiesEvaluator.escape0Tris = L" ~1_val~%%"
ItemPropertiesEvaluator.escape1 = L" %+~1_val~"
ItemPropertiesEvaluator.escape2 = L" ~1_val~"
ItemPropertiesEvaluator.escape2bis = L" ~1_val~"
ItemPropertiesEvaluator.escape3 = L" ~1_val~ %- ~2_val~"

if (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_ENU) then
	ItemPropertiesEvaluator.orderShield = wstring.lower(ItemPropertiesEvaluator.orderShield)
	ItemPropertiesEvaluator.chaosShield =  wstring.lower(ItemPropertiesEvaluator.chaosShield)
elseif (SystemData.Settings.Language.type == SystemData.Settings.Language.LANGUAGE_JPN) then
	ItemPropertiesEvaluator.escape3 = L" ~1_val~%-~2_val~"
	ItemPropertiesEvaluator.escape0Bis = L" %+~1_val~%%"
	ItemPropertiesEvaluator.escape0Tris = L" -~1_val~%%"
	ItemPropertiesEvaluator.escape2bis = L" %+~1_val~"
end


ItemPropertiesEvaluator.MaterialNames = {
[GetStringFromTid(1061118)] = L"spined",
[GetStringFromTid(1061117)] = L"horned",
[GetStringFromTid(1061116)] = L"barbed",

[GetStringFromTid(1053108)] = L"dull copper",
[GetStringFromTid(1053107)] = L"shadow iron",
[GetStringFromTid(1053106)] = L"copper",
[GetStringFromTid(1053105)] = L"bronze",
[GetStringFromTid(1053104)] = L"golden",
[GetStringFromTid(1053103)] = L"agapite",
[GetStringFromTid(1053102)] = L"verite",
[GetStringFromTid(1053101)] = L"valorite",

[GetStringFromTid(1072533)] = L"oak",
[GetStringFromTid(1072534)] = L"ash",
[GetStringFromTid(1072535)] = L"yew",
[GetStringFromTid(1072536)] = L"heartwood",
[GetStringFromTid(1072538)] = L"bloodwood",
[GetStringFromTid(1072539)] = L"frostwood",
}

ItemPropertiesEvaluator.SuperSlayers = {
[L"repond slayer"] = true;
[L"reptile slayer"] = true;
[L"arachnid slayer"] = true;
[L"elemental slayer"] = true;
[L"undead slayer"] = true;
[L"demon slayer"] = true;
[L"fey slayer"] = true;
}
ItemPropertiesEvaluator.BodRewards = {
	[GetStringFromTid(1045125)] = {des = 0}; -- shovel
	[GetStringFromTid(1045126)] = {des = 0}; -- L"pickaxe"
	[GetStringFromTid(1045122)] = {des = 0}; -- L"gloves+1"
	[GetStringFromTid(1049065)] = {des = 0}; -- L"prospector"
	[GetStringFromTid(1017411)] = {des = 0}; -- L"gargoyle"
	[GetStringFromTid(1045123)] = {des = 0}; -- L"gloves+3"
	[GetStringFromTid(1045124)] = {des = 0}; -- L"gloves+5"
	[GetStringFromTid(1049082)] = {des = 1000}; -- L"POF"
	[GetStringFromTid(1049020)] = {des = 100}; -- L"dull"
	[GetStringFromTid(1049021)] = {des = 100}; -- L"shadow"
	[GetStringFromTid(1049022)] = {des = 100}; -- L"copper"
	[GetStringFromTid(1049023)] = {des = 100}; -- L"bronze"
	[GetStringFromTid(1049024)] = {des = 100}; -- L"golden"
	[GetStringFromTid(1049025)] = {des = 100}; -- L"agapite"
	[GetStringFromTid(1049026)] = {des = 100}; -- L"verite"
	[GetStringFromTid(1049027)] = {des = 100}; -- L"valorite"
	[GetStringFromTid(1049639)] = {des = 0}; -- L"PS105"
	[GetStringFromTid(1049640)] = {des = 0}; -- L"PS110"
	[GetStringFromTid(1049641)] = {des = 0}; -- L"PS115"
	[GetStringFromTid(1049642)] = {des = 50}; -- L"PS120"
	[GetStringFromTid(1024015)] = {des = 0}; -- L"anvil"
	[GetStringFromTid(1049028)] = {des = 100}; -- L"ASH10"
	[GetStringFromTid(1049029)] = {des = 100}; -- L"ASH15"
	[GetStringFromTid(1049030)] = {des = 100}; -- L"ASH30"
	[GetStringFromTid(1049031)] = {des = 100}; -- L"ASH60"
	[GetStringFromTid(1044286) .. L" 1"] = {des = 0}; -- L"cloth"
	[GetStringFromTid(1044286) .. L" 2"] = {des = 0};
	[GetStringFromTid(1044286) .. L" 3"] = {des = 0};
	[GetStringFromTid(1044286) .. L" 4"] = {des = 50};
	[GetStringFromTid(1015289)] = {des = 0}; -- L"sandals"
	[GetStringFromTid(1024201)] = {des = 0}; -- L"hide"
	[GetStringFromTid(1023754)] = {des = 0}; -- L"tapestry"
	[GetStringFromTid(1022729)] = {des = 0}; -- rug
	[GetStringFromTid(1041008)] = {des = 100}; -- L"CBD"
	[wstring.gsub(GetStringFromTid(1061119), L"~1_LEATHER_TYPE~" , GetStringFromTid(1061118))] = {des = 100}; -- L"spined"  
	[wstring.gsub(GetStringFromTid(1061119), L"~1_LEATHER_TYPE~" , GetStringFromTid(1061117))] = {des = 100}; -- horned
	[wstring.gsub(GetStringFromTid(1061119), L"~1_LEATHER_TYPE~" , GetStringFromTid(1061116))] = {des = 100}; -- L"barbed"
	
}

ItemPropertiesEvaluator.ItemToMatAmount = {
	[GetStringFromTid(1027026)] = 12; -- bronze shield
	[GetStringFromTid(1027027)] = 10; -- buckler
	[GetStringFromTid(1027028)] = 16; -- metal kite shield
	[GetStringFromTid(1027030)] = 18; -- heater shield
	[GetStringFromTid(1027032)] = 8; -- tear kite shield
	[GetStringFromTid(1027035)] = 14; -- metal shield
	
	[GetStringFromTid(1015041)] = 15; -- norse helm
	[GetStringFromTid(1025128)] = 15; -- close helmet
	[GetStringFromTid(1015040)] = 15; -- bascinet
	[GetStringFromTid(1025130)] = 15; -- helmet
	
	[GetStringFromTid(1025136)] = 18; -- platemail arms
	[GetStringFromTid(1025137)] = 20; -- platemail legs
	[GetStringFromTid(1025138)] = 15; -- plate helm
	[GetStringFromTid(1025139)] = 10; -- platemail gorget
	[GetStringFromTid(1025140)] = 12; -- platemail gloves
	[GetStringFromTid(1025141)] = 25; -- platemail tunic
	[GetStringFromTid(1027172)] = 20; -- female plate
	
	[GetStringFromTid(1025104)] = 16; -- ringmail leggings
	[GetStringFromTid(1025100)] = 18; -- ringmail tunic
	[GetStringFromTid(1025097)] = 14; -- ringmail sleeves
	[GetStringFromTid(1025099)] = 10; -- ringmail gloves
	
	[GetStringFromTid(1025051)] = 10; -- chainmail coif
	[GetStringFromTid(1025052)] = 18; -- chainmail leggings
	[GetStringFromTid(1025053)] = 20; -- chainmail tunic
	
	[GetStringFromTid(1015068)] = 18; -- bardiche
	[GetStringFromTid(1015069)] = 20; -- halberd
	
	[GetStringFromTid(1015050)] = 3; -- dagger
	[GetStringFromTid(1015053)] = 8; -- kryss
	[GetStringFromTid(1025124)] = 12; -- war fork
	[GetStringFromTid(1025122)] = 6; -- short spear
	[GetStringFromTid(1029594)] = 12; -- spear
	
	[GetStringFromTid(1015063)] = 12; -- large battle axe
	[GetStringFromTid(1023915)] = 12; -- double axe
	[GetStringFromTid(1015058)] = 14; -- battle axe
	[GetStringFromTid(1015061)] = 16; -- two handed axe
	[GetStringFromTid(1015059)] = 14; -- axe
	[GetStringFromTid(1023909)] = 14; -- executioner's axe
	
	[GetStringFromTid(1025184)] = 8; -- cutlass
	[GetStringFromTid(1015057)] = 14; -- viking sword
	[GetStringFromTid(1015056)] = 12; -- longsword
	[GetStringFromTid(1015054)] = 10; -- scimitar
	[GetStringFromTid(1015055)] = 10; -- broadsword
	[GetStringFromTid(1025118)] = 8; -- katana
	
	
	[GetStringFromTid(1015071)] = 10; -- maul
	[GetStringFromTid(1015072)] = 14; -- war mace
	[GetStringFromTid(1015073)] = 16; -- war hammer
	[GetStringFromTid(1015074)] = 16; -- hammer pick
	[GetStringFromTid(1015064)] = 16; -- war axe
	[GetStringFromTid(1015070)] = 6; -- mace
	
	[GetStringFromTid(1015301)] = 6; -- studded gorget
	[GetStringFromTid(1015302)] = 8; -- studded gloves
	[GetStringFromTid(1015303)] = 10; -- studded sleeves
	[GetStringFromTid(1015304)] = 12; -- studded leggings
	[GetStringFromTid(1015305)] = 14; -- studded tunic
	
	[GetStringFromTid(1025201)] = 4; -- bone helmet
	[GetStringFromTid(1025202)] = 10; -- bone leggings
	[GetStringFromTid(1025203)] = 8; -- bone arms
	[GetStringFromTid(1025204)] = 12; -- bone armor
	[GetStringFromTid(1025205)] = 6; -- bone gloves
	
	[GetStringFromTid(1015295)] = 2; -- leather cap
	[GetStringFromTid(1015296)] = 3; -- leather gloves
	[GetStringFromTid(1015297)] = 4; -- leather sleeves
	[GetStringFromTid(1015298)] = 10; -- leather leggings
	[GetStringFromTid(1015299)] = 12; -- leather tunic
	[GetStringFromTid(1015294)] = 4; -- leather gorget
	
	[GetStringFromTid(1015307)] = 8; -- leather shorts
	[GetStringFromTid(1015308)] = 6; -- leather skirt
	[GetStringFromTid(1015309)] = 6; -- leather bustier
	[GetStringFromTid(1015310)] = 8; -- studded bustier
	[GetStringFromTid(1015311)] = 8; -- female leather armor
	[GetStringFromTid(1015300)] = 10; -- Studded Armor
	
	[GetStringFromTid(1015289)] = 4; -- sandals
	[GetStringFromTid(1015290)] = 6; -- shoes
	[GetStringFromTid(1015291)] = 8; -- boots
	[GetStringFromTid(1015292)] = 10; -- thigh boots
	
	[GetStringFromTid(1015261)] = 11; -- cap
	[GetStringFromTid(1015262)] = 13; -- tall straw hat
	[GetStringFromTid(1015260)] = 12; -- wide-brim hat
	[GetStringFromTid(1025915)] = 12; -- tricorne hat
	
	[GetStringFromTid(1015258)] = 2; -- bandana
	[GetStringFromTid(1015271)] = 8; -- shirt
	[GetStringFromTid(1015282)] = 10; -- skirt
	
	[GetStringFromTid(1015257)] = 2; -- skullcap
	[GetStringFromTid(1015270)] = 8; -- doublet
	[GetStringFromTid(1015281)] = 8; -- kilt

	
	[GetStringFromTid(1025916)] = 15; -- jester hat
	[GetStringFromTid(1015278)] = 24; -- jester suit
	[GetStringFromTid(1015276)] = 14; -- cloak

	
	[GetStringFromTid(1015263)] = 10; -- straw hat
	[GetStringFromTid(1015033)] = 12; -- tunic
	[GetStringFromTid(1015280)] = 8; -- long pants

	
	[GetStringFromTid(1015264)] = 15; -- wizard's hat
	[GetStringFromTid(1015284)] = 4; -- body sash
	[GetStringFromTid(1027939)] = 16; -- robe

	
	[GetStringFromTid(1015259)] = 11; -- floppy hat
	[GetStringFromTid(1015286)] = 10; -- full apron
	[GetStringFromTid(1027937)] = 10; -- plain dress

	
	[GetStringFromTid(1015265)] = 11; -- bonnet
	[GetStringFromTid(1015285)] = 6; -- half apron
	[GetStringFromTid(1027935)] = 12; -- fancy dress

	
	[GetStringFromTid(1015266)] = 12; -- feathered hat
	[GetStringFromTid(1015273)] = 14; -- surcoat
	[GetStringFromTid(1027933)] = 8; -- fancy shirt
	[GetStringFromTid(1025422)] = 6; -- short pants
}


ItemPropertiesEvaluator.SmallToLarge = {
	[GetStringFromTid(1025136)] = L"platemail"; -- platemail arms
	[GetStringFromTid(1025137)] = L"platemail"; -- platemail legs
	[GetStringFromTid(1025138)] = L"platemail"; -- plate helm
	[GetStringFromTid(1025139)] = L"platemail"; -- platemail gorget
	[GetStringFromTid(1025140)] = L"platemail"; -- platemail gloves
	[GetStringFromTid(1025141)] = L"platemail"; -- platemail tunic
	
	[GetStringFromTid(1025104)] = L"ringmail"; -- ringmail leggings
	[GetStringFromTid(1025100)] = L"ringmail"; -- ringmail tunic
	[GetStringFromTid(1025097)] = L"ringmail"; -- ringmail sleeves
	[GetStringFromTid(1025099)] = L"ringmail"; -- ringmail gloves
	
	[GetStringFromTid(1025051)] = L"chainmail"; -- chainmail coif
	[GetStringFromTid(1025052)] = L"chainmail"; -- chainmail leggings
	[GetStringFromTid(1025053)] = L"chainmail"; -- chainmail tunic
	
	[GetStringFromTid(1015068)] = L"polearm"; -- bardiche
	[GetStringFromTid(1015069)] = L"polearm"; -- halberd
	
	[GetStringFromTid(1015050)] = L"fencing"; -- dagger
	[GetStringFromTid(1015053)] = L"fencing"; -- kryss
	[GetStringFromTid(1025124)] = L"fencing"; -- war fork
	[GetStringFromTid(1025122)] = L"fencing"; -- short spear
	[GetStringFromTid(1029594)] = L"fencing"; -- spear
	
	[GetStringFromTid(1015063)] = L"6pieceweapon"; -- large battle axe
	[GetStringFromTid(1023915)] = L"6pieceweapon"; -- double axe
	[GetStringFromTid(1015058)] = L"6pieceweapon"; -- battle axe
	[GetStringFromTid(1015061)] = L"6pieceweapon"; -- two handed axe
	[GetStringFromTid(1015059)] = L"6pieceweapon"; -- axe
	[GetStringFromTid(1023909)] = L"6pieceweapon"; -- executioner's axe
	
	[GetStringFromTid(1025184)] = L"6pieceweapon"; -- cutlass
	[GetStringFromTid(1015057)] = L"6pieceweapon"; -- viking sword
	[GetStringFromTid(1015056)] = L"6pieceweapon"; -- longsword
	[GetStringFromTid(1015054)] = L"6pieceweapon"; -- scimitar
	[GetStringFromTid(1015055)] = L"6pieceweapon"; -- broadsword
	[GetStringFromTid(1025118)] = L"6pieceweapon"; -- katana
	
	
	[GetStringFromTid(1015071)] = L"6pieceweapon"; -- maul
	[GetStringFromTid(1015072)] = L"6pieceweapon"; -- war mace
	[GetStringFromTid(1015073)] = L"6pieceweapon"; -- war hammer
	[GetStringFromTid(1015074)] = L"6pieceweapon"; -- hammer pick
	[GetStringFromTid(1015064)] = L"6pieceweapon"; -- war axe
	[GetStringFromTid(1015070)] = L"6pieceweapon"; -- mace
	
	[GetStringFromTid(1015301)] = L"5piece"; -- studded gorget
	[GetStringFromTid(1015302)] = L"5piece"; -- studded gloves
	[GetStringFromTid(1015303)] = L"5piece"; -- studded sleeves
	[GetStringFromTid(1015304)] = L"5piece"; -- studded leggings
	[GetStringFromTid(1015305)] = L"5piece"; -- studded tunic
	
	[GetStringFromTid(1025201)] = L"5piece"; -- bone helmet
	[GetStringFromTid(1025202)] = L"5piece"; -- bone leggings
	[GetStringFromTid(1025203)] = L"5piece"; -- bone arms
	[GetStringFromTid(1025204)] = L"5piece"; -- bone armor
	[GetStringFromTid(1025205)] = L"5piece"; -- bone gloves
	
	[GetStringFromTid(1015295)] = L"6piece"; -- leather cap
	[GetStringFromTid(1015296)] = L"6piece"; -- leather gloves
	[GetStringFromTid(1015297)] = L"6piece"; -- leather sleeves
	[GetStringFromTid(1015298)] = L"6piece"; -- leather leggings
	[GetStringFromTid(1015299)] = L"6piece"; -- leather tunic
	[GetStringFromTid(1015294)] = L"6piece"; -- leather gorget
	
	[GetStringFromTid(1015307)] = L"6piece"; -- leather shorts
	[GetStringFromTid(1015308)] = L"6piece"; -- leather skirt
	[GetStringFromTid(1015309)] = L"6piece"; -- leather bustier
	[GetStringFromTid(1015310)] = L"6piece"; -- studded bustier
	[GetStringFromTid(1015311)] = L"6piece"; -- female leather armor
	[GetStringFromTid(1015300)] = L"6piece"; -- Studded Armor
	
	[GetStringFromTid(1015289)] = L"4piece"; -- sandals
	[GetStringFromTid(1015290)] = L"4piece"; -- shoes
	[GetStringFromTid(1015291)] = L"4piece"; -- boots
	[GetStringFromTid(1015292)] = {L"4piece", L"5piece"}; -- thigh boots
	
	[GetStringFromTid(1015261)] = L"4piece"; -- cap
	[GetStringFromTid(1015262)] = L"4piece"; -- tall straw hat
	[GetStringFromTid(1015260)] = L"4piece"; -- wide-brim hat
	[GetStringFromTid(1025915)] = L"4piece"; -- tricorne hat
	
	[GetStringFromTid(1015258)] = L"4piece"; -- bandana
	[GetStringFromTid(1015271)] = L"4piece"; -- shirt
	[GetStringFromTid(1015282)] = L"4piece"; -- skirt
	
	[GetStringFromTid(1015257)] = L"4piece"; -- skullcap
	[GetStringFromTid(1015270)] = L"4piece"; -- doublet
	[GetStringFromTid(1015281)] = L"4piece"; -- kilt

	
	[GetStringFromTid(1025916)] = L"4piece"; -- jester hat
	[GetStringFromTid(1015278)] = L"4piece"; -- jester suit
	[GetStringFromTid(1015276)] = L"4piece"; -- cloak

	
	[GetStringFromTid(1015263)] = L"4piece"; -- straw hat
	[GetStringFromTid(1015033)] = L"4piece"; -- tunic
	[GetStringFromTid(1015280)] = L"4piece"; -- long pants

	
	[GetStringFromTid(1015264)] = L"4piece"; -- wizard's hat
	[GetStringFromTid(1015284)] = L"4piece"; -- body sash
	[GetStringFromTid(1027939)] = L"4piece"; -- robe

	
	[GetStringFromTid(1015259)] = L"4piece"; -- floppy hat
	[GetStringFromTid(1015286)] = L"4piece"; -- full apron
	[GetStringFromTid(1027937)] = L"4piece"; -- plain dress

	
	[GetStringFromTid(1015265)] = L"4piece"; -- bonnet
	[GetStringFromTid(1015285)] = L"4piece"; -- half apron
	[GetStringFromTid(1027935)] = L"4piece"; -- fancy dress

	
	[GetStringFromTid(1015266)] = L"5piece"; -- feathered hat
	[GetStringFromTid(1015273)] = L"5piece"; -- surcoat
	[GetStringFromTid(1027933)] = L"5piece"; -- fancy shirt
	[GetStringFromTid(1025422)] = L"5piece"; -- short pants
}

ItemPropertiesEvaluator.TYPE_ANY = 255
ItemPropertiesEvaluator.TYPE_JEWEL = 1
ItemPropertiesEvaluator.TYPE_WEAPON = 2
ItemPropertiesEvaluator.TYPE_ARMOR = 3
ItemPropertiesEvaluator.TYPE_SHIELD = 4
ItemPropertiesEvaluator.TYPE_HAT = 5
ItemPropertiesEvaluator.TYPE_PET = 6
ItemPropertiesEvaluator.TYPE_WEARABLE = 7
ItemPropertiesEvaluator.TYPE_BOD = 999
ItemPropertiesEvaluator.TYPE_SKIP = 0
ItemPropertiesEvaluator.TYPE_SKILL = 998

ItemPropertiesEvaluator.MATERIAL_METAL = 1
ItemPropertiesEvaluator.MATERIAL_LEATHER = 2
ItemPropertiesEvaluator.MATERIAL_SCALES = 3
ItemPropertiesEvaluator.MATERIAL_WOOD = 4

ItemPropertiesEvaluator.RACE_HUMAN = 1
ItemPropertiesEvaluator.RACE_ELF = 2
ItemPropertiesEvaluator.RACE_GARGOYLE = 3


ItemPropertiesEvaluator.Wearables = {
	[GetStringFromTid(1095256)] = {layer=1079914, objectType="16384, 16385";}; -- gargish robe
	[GetStringFromTid(1095258)] = {layer=1079914, objectType="16386, 16387";}; -- gargish fancy robe
	[GetStringFromTid(1027938)] = {layer=1079914, objectType="7937, 7938";}; -- plain dress
	[GetStringFromTid(1029851)] = {layer=1079914, objectType="7935, 7936";}; -- fancy dress
	[GetStringFromTid(1027939)] = {layer=1079914, objectType="7939, 7940, 9902";}; -- robe
	[GetStringFromTid(1028973)] = {layer=1079914, objectType="8973, 8974";}; -- gilded dress
	[GetStringFromTid(1030137)] = {layer=1079914, objectType="10137";}; -- kamishimo
	[GetStringFromTid(1030140)] = {layer=1079914, objectType="10140";}; -- hakama-shita
	[GetStringFromTid(1030189)] = {layer=1079914, objectType="10114";}; -- male kimono
	[GetStringFromTid(1030190)] = {layer=1079914, objectType="10115";}; -- female kimono
	[GetStringFromTid(1032217)] = {layer=1079914, objectType="12217";}; -- elven robe
	[GetStringFromTid(1032218)] = {layer=1079914, objectType="12218";}; -- female elven robe
	
	[GetStringFromTid(1028060)] = {layer=1079912, objectType="8059, 8060";}; -- doublet
	[GetStringFromTid(1028097)] = {layer=1079912, objectType="8097, 8098";}; -- tunic
	[GetStringFromTid(1028189)] = {layer=1079912, objectType="8189, 8190";}; -- surcoat
	[GetStringFromTid(1028095)] = {layer=1079912, objectType="8095, 8096";}; -- jester suit
	[GetStringFromTid(1028975)] = {layer=1079912, objectType="8975, 8976";}; -- formal shirt
	[GetStringFromTid(1030220)] = {layer=1079912, objectType="10145";}; -- jin-baori
	[GetStringFromTid(1025437)] = {layer=1079912, objectType="5437, 5438";}; -- full apron
	[GetStringFromTid(1025442)] = {layer=1079912, objectType="5441, 5442";}; -- body sash
	[GetStringFromTid(1096962)] = {layer=1079912, objectType="18100, 18101";}; -- gargish sash
	
	[GetStringFromTid(1025400)] = {layer=1079910, objectType="5399, 5400";}; -- shirt
	[GetStringFromTid(1027933)] = {layer=1079910, objectType="7933, 7934";}; -- fancy shirt
	[GetStringFromTid(1032219)] = {layer=1079910, objectType="12661, 12662";}; -- elven shirt
	
	[GetStringFromTid(1028969)] = {layer=1079913, objectType="8969, 8970";}; -- fur cape
	[GetStringFromTid(1025397)] = {layer=1079913, objectType="5397, 5424, 9901";}; -- cloak
	[GetStringFromTid(1032215)] = {layer=1079913, objectType="12215, 11010";}; -- elven quiver
	
	[GetStringFromTid(1115376)] = {layer=1115376, objectType="17790, 17791";}; -- wing armor
	[GetStringFromTid(1115393)] = {layer=1115376, objectType="17828";}; -- cloth wing armor
	
	[GetStringFromTid(1025432)] = {layer=1079915, objectType="5431, 5432";}; -- kilt
	[GetStringFromTid(1025425)] = {layer=1079915, objectType="5398, 5425";}; -- skirt
	[GetStringFromTid(1028971)] = {layer=1079915, objectType="8971, 8972";}; -- fur sarong
	[GetStringFromTid(1030138)] = {layer=1079915, objectType="10138";}; -- hakama
	
	[GetStringFromTid(1030132)] = {layer=1079904, objectType="10132";}; -- cloth ninja jacket
	
	[GetStringFromTid(1025423)] = {layer=1079902, objectType="5422, 5423";}; -- short pants
	[GetStringFromTid(1025434)] = {layer=1079902, objectType="5433, 5434";}; -- long pants
	[GetStringFromTid(1030139)] = {layer=1079902, objectType="10139";}; -- tattsuke-hakama
	[GetStringFromTid(1032227)] = {layer=1079902, objectType="12227";}; -- elven pants
	
	[GetStringFromTid(1032639)] = {layer=1079911, objectType="11112";}; -- woodland belt
	[GetStringFromTid(1025436)] = {layer=1079911, objectType="5435, 5436";}; -- half apron
	[GetStringFromTid(1099568)] = {layer=1079911, objectType="20696, 20697";}; -- gargish half apron
	[GetStringFromTid(1030219)] = {layer=1079911, objectType="10144";}; -- obi
	
	[GetStringFromTid(1095728)] = {layer=1115377, objectType="16856, 16857";}; -- gargish leahter talons
	
	[GetStringFromTid(1072902)] = {layer=1079909, objectType="12228";}; -- elven boots
	[GetStringFromTid(1028968)] = {layer=1079909, objectType="8967, 8968";}; -- fur boots
	[GetStringFromTid(1030135)] = {layer=1079909, objectType="10135";}; -- ninja tabi
	[GetStringFromTid(1030134)] = {layer=1079909, objectType="10134";}; -- waraji and tabi
	[GetStringFromTid(1025902)] = {layer=1079909, objectType="5901, 5902";}; -- sandals
	[GetStringFromTid(1025903)] = {layer=1079909, objectType="5903, 5904";}; -- shoes
	[GetStringFromTid(1025900)] = {layer=1079909, objectType="5899, 5900";}; -- boots
	[GetStringFromTid(1025905)] = {layer=1079909, objectType="5906, 5905, 9903";}; -- thigh boots
	
	[GetStringFromTid(1032120)] = {layer=1079908, objectType="12120, 12121, 12122, 12123, 4246";}; -- talisman
	
	[GetStringFromTid(1023643)] = {layer=1, objectType="8787, 8786, 11677, 3834, 11600";}; -- spellbook
	[GetStringFromTid(1011406)] = {layer=2, objectType="3519, 3520";}; -- Fishing Pole
	
	[GetStringFromTid(1027943)] = {layer=1079903, objectType="4231, 7943";}; -- Earrings
}

ItemPropertiesEvaluator.Rings = {
	[GetStringFromTid(1027945) .. L"$"] = true; -- L"ring$"
	[GetStringFromTid(1061102)] = true; -- L"Ring Of The Vile"
	[GetStringFromTid(1061104)] = true; -- L"Ring Of The Elements"
	[GetStringFromTid(1075096)] = true; -- L"Crystalline Ring"
	[GetStringFromTid(1115776)] = true; -- Petrified Matriarch's Tongue
	[GetStringFromTid(1114790)] = true; -- L"Burning Amber"
	[GetStringFromTid(1113651)] = true; -- L"Demon Bridle Ring"
	[GetStringFromTid(1116624)] = true; -- L"Ring Of The Soulbinder"
	[GetStringFromTid(1072935)] = true; -- L"Essence Of Battle"
	[GetStringFromTid(1094927)] = true; -- Djinni's Ring [Replica]
	[GetStringFromTid(1153288)] = true; -- Compassion's Eye 
}

ItemPropertiesEvaluator.Bracelets = {
	[GetStringFromTid(1027942)] = true; -- L"bracelet"
	[GetStringFromTid(1061103)] = true; -- L"Bracelet Of Health"
	[GetStringFromTid(1070638)] = true; -- L"Alchemist's Bauble"
	[GetStringFromTid(1113652)] = true; -- L"Token Of Holy Favor"
	[GetStringFromTid(1116624)] = true; -- L"Enchanted Coral Bracelet"
	[GetStringFromTid(1072933)] = true; -- L"Resillient Bracer"
	[GetStringFromTid(1112407)] = true; -- Jade Armband [Replica]
	[GetStringFromTid(1114783)] = true; -- Venom
	[GetStringFromTid(1152730)] = true; -- Bracelet of Protection
}



-- All the names for various items?

ItemPropertiesEvaluator.JewelryNames = {
	[GetStringFromTid(1027945) .. L"$"] = {objectType="4234, 7945, 16914";}; -- L"ring$";
	[GetStringFromTid(1027942)] = {objectType="4230, 7942, 16913";}; -- L"bracelet"
	[GetStringFromTid(1061102)] = {}; -- L"Ring Of The Vile"
	[GetStringFromTid(1061103)] = {}; -- L"Bracelet Of Health"
	[GetStringFromTid(1061104)] = {}; -- L"Ring Of The Elements"
	[GetStringFromTid(1070638)] = {}; -- L"Alchemist's Bauble"
	[GetStringFromTid(1075096)] = {}; -- L"Crystalline Ring"
	[GetStringFromTid(1115776)] = {}; -- Petrified Matriarch's Tongue
	[GetStringFromTid(1114790)] = {}; -- L"Burning Amber"
	[GetStringFromTid(1113651)] = {}; -- L"Demon Bridle Ring"
	[GetStringFromTid(1113652)] = {}; -- L"Token Of Holy Favor"
	[GetStringFromTid(1116624)] = {}; -- L"Enchanted Coral Bracelet"
	[GetStringFromTid(1116624)] = {}; -- L"Ring Of The Soulbinder"
	[GetStringFromTid(1072935)] = {}; -- L"Essence Of Battle"
	[GetStringFromTid(1072933)] = {}; -- L"Resillient Bracer"
	[GetStringFromTid(1114783)] = {}; -- Venom
	[GetStringFromTid(1112407)] = {}; -- Jade Armband [Replica]
	[GetStringFromTid(1094927)] = {}; -- Djinni's Ring [Replica]
}
ItemPropertiesEvaluator.IgnoreNames = {
	GetStringFromTid(1030245); -- bamboo flute
	GetStringFromTid(1015114); -- Lap Harp
	GetStringFromTid(1015115); -- Standing Harp
	GetStringFromTid(1015116); -- Drum
	GetStringFromTid(1015117); -- Lute
	GetStringFromTid(1015118); -- Tambourine
	GetStringFromTid(1095315); -- aud-char
	GetStringFromTid(1115389); -- gargish leather wing armor
	GetStringFromTid(1115393); -- gargish cloth wing armor
	GetStringFromTid(1115394); -- gargish plate wing armor
	GetStringFromTid(1115396); -- gargish stone wing armor
	GetStringFromTid(1023971); -- Executioner's cap
	GetStringFromTid(1033042); -- pedestal

	
	GetStringFromTid(1075034); -- L"Bloodwood Spirit"
	GetStringFromTid(1075035); -- L"Totem Of The Void"
	GetStringFromTid(1075042); -- L"Robe Of The Equinox"
	GetStringFromTid(1075048); -- L"Pads Of The Cu Sidhe"
	GetStringFromTid(1075038); -- L"Quiver Of Rage"
	GetStringFromTid(1075043); -- L"Crimson Cincture"
	GetStringFromTid(1113867); -- L"Fallen Mystic's Spellbook"
	GetStringFromTid(1113703); -- L"Shroud Of The Condemned"
	GetStringFromTid(1114782); -- L"Slither"
	GetStringFromTid(1114784); -- L"Tangle"
	GetStringFromTid(1149781); -- L"Corgul's Enchanted Sash"
	GetStringFromTid(1149779); -- L"Corgul's Handbook On Mysticism"
	GetStringFromTid(1149780); -- L"Corgul's Handbook On The Undead"
	GetStringFromTid(1072940); -- L"Scrapper's Compendium"
	GetStringFromTid(1070927); -- L"Flute Of Renewal"
	GetStringFromTid(1070934); -- L"Tome Of Enlightenment"
	GetStringFromTid(1070971); -- L"Tome Of lost knowledge"
	GetStringFromTid(1116231); -- L"Runed Sash of Warding"
	GetStringFromTid(1116230); -- Mana Phasing Orb	
	GetStringFromTid(1063480); -- Gwenno's Harp
	GetStringFromTid(1063479); -- Iolo's Lute
	GetStringFromTid(1075199); -- Ossian Grimoire
	GetStringFromTid(1114052); -- Conjurer's Garb
	GetStringFromTid(1094799); -- Conjurer's Grimoire
	GetStringFromTid(1094800); -- Conjurer's Trinket
	GetStringFromTid(1115514); -- Ranger's Cloak of Augmentation
	GetStringFromTid(1115515); -- Warden's Armor of Augmentation
	GetStringFromTid(1115516); -- Frostguard Talisman
	GetStringFromTid(1115647); -- Jade Snake Head
	GetStringFromTid(1080524); -- L"Melissa's Cloak" 
	GetStringFromTid(1073262); -- Clainin's Spellbook - Museum of Vesper Replica
	GetStringFromTid(1073353); -- Library Talisman - Treatise on Alchemy
	GetStringFromTid(1073354); -- Library Talisman - A Primer on Arms
	GetStringFromTid(1073355); -- Library Talisman - My Book
	GetStringFromTid(1073356); -- Library Talisman - Talking to Wisps
	GetStringFromTid(1073357); -- Library Talisman - Dimensional Travel
	GetStringFromTid(1073358); -- Library Talisman - a Grammar of Orchish (Summoner)
	GetStringFromTid(1073359); -- Library Talisman - Birds of Britannia
	GetStringFromTid(1073360); -- Library Talisman - The Life of a Traveling Minstrel

	GetStringFromTid(1112406); -- Obi di Ense [Replica]
	GetStringFromTid(1112409); -- Royal Guard Investigator [Replica]
	GetStringFromTid(1095236); -- Acid-Proof Robe [Replica]
	GetStringFromTid(1094893); -- The Most Knowledge Person [Replica]
	GetStringFromTid(1094894); -- Legendary Detective of the Royal Guard [Replica]
	GetStringFromTid(1094895); -- Elder Detective of the Royal Guard [Replica]
	GetStringFromTid(1094896); -- Mythical Detective of the Royal Guard [Replica]
	GetStringFromTid(1094901); -- Embroidered Oak Leaf Cloak [Replica]
	GetStringFromTid(1094910); -- Lieutenant of the Britannian Royal Guard [Replica]
	GetStringFromTid(1094913); -- A Necromancer Shroud [Replica]
	GetStringFromTid(1094926); -- Good Samaritan of Britannia [Replica]
	GetStringFromTid(1094931); -- The Robe of Britannia "Ari" [Replica]
	wstring.lower(GetStringFromTid(1094934)); -- transcendence
	wstring.lower(GetStringFromTid(1078604)); -- alacrity
}
ItemPropertiesEvaluator.WeaponNames = {
	-- GARGISH
	[GetStringFromTid(1022304)]={m="m"; objectType="2304";}; -- L"stone war sword"
	[GetStringFromTid(1022316)]={m="m"; objectType="2316";}; -- L"glass sword"
	[GetStringFromTid(1022309)]={m="m"; objectType="2309";}; -- L"glass staff"
	[GetStringFromTid(1022301)]={m="m"; objectType="2301";}; -- L"dual short axes"
	[GetStringFromTid(1022315)]={m="m"; objectType="2315";}; -- L"dread sword"
	[GetStringFromTid(1022312)]={m="m"; objectType="2312";}; -- L"talwar"
	[GetStringFromTid(1022308)]={m="m"; objectType="2308";}; -- L"dual pointed spear"
	[GetStringFromTid(1022306)]={m="m"; objectType="2306";}; -- L"gargish dagger"
	[GetStringFromTid(1022302)]={m="m"; objectType="2302";}; -- L"bloodblade"
	[GetStringFromTid(1022311)]={m="m"; objectType="2311";}; -- L"shortblade"
	[GetStringFromTid(1022307)]={m="m"; objectType="2307";}; -- L"disk mace"
	[GetStringFromTid(1022310)]={m="m"; objectType="2310";}; -- L"serpentstone staff"
	[GetStringFromTid(1097478)]={m="m"; objectType="18606, 18607";}; -- gargish cleaver
	[GetStringFromTid(1097480)]={m="m"; objectType="18608, 18609";}; -- gargish battle axe
	[GetStringFromTid(1097482)]={m="m"; objectType="18610, 18611";}; -- gargish axe
	[GetStringFromTid(1097484)]={m="m"; objectType="18612, 18613";}; -- gargish bardiche
	[GetStringFromTid(1097486)]={m="m"; objectType="18614, 18615";}; -- gargish butcher's knife
	[GetStringFromTid(1097488)]={m="m"; objectType="18616, 18617";}; -- gargish gnarled staff
	[GetStringFromTid(1097490)]={m="m"; objectType="18618, 18619";}; -- gargish katana
	[GetStringFromTid(1097492)]={m="m"; objectType="18620, 18621";}; -- gargish kryss
	[GetStringFromTid(1097494)]={m="m"; objectType="18622, 18623";}; -- gargish war fork
	[GetStringFromTid(1097496)]={m="m"; objectType="18624, 18625";}; -- gargish war hammer
	[GetStringFromTid(1097498)]={m="m"; objectType="18626, 18627";}; -- gargish maul
	[GetStringFromTid(1097500)]={m="m"; objectType="18628, 18629";}; -- gargish scythe
	[GetStringFromTid(1097502)]={m="m"; objectType="18630, 18631";}; -- gargish bone harvester
	[GetStringFromTid(1097504)]={m="m"; objectType="18632, 18633";}; -- gargish pike
	[GetStringFromTid(1097506)]={m="m"; objectType="18634, 18635";}; -- gargish lance
	[GetStringFromTid(1097508)]={m="m"; objectType="18636, 18637";}; -- gargish tessen
	[GetStringFromTid(1097510)]={m="m"; objectType="18638, 18639";}; -- gargish tekagi
	[GetStringFromTid(1097512)]={m="m"; objectType="18640, 18641";}; -- gargish daisho
	[GetStringFromTid(1022303)]={m="m";isBow=true;isBoomerang=true; objectType="2303, 16487";}; -- L"boomerang"
	[GetStringFromTid(1022305)]={m="m";isBow=true;isBoomerang=true; objectType="2305, 16492";}; -- L"cyclone"
	[GetStringFromTid(1022314)]={m="m";isBow=true;isBoomerang=true; objectType="2314, 16491";}; -- L"soul glaive"

	-- CLASSIC
	[GetStringFromTid(1015061)]={m="m"; objectType="5186, 5187";}; -- L"two handed axe"
	[GetStringFromTid(1015068)]={m="m"; objectType="3917, 3918";}; -- L"bardiche"
	[GetStringFromTid(1015058)]={m="m"; objectType="3911, 3912";}; -- L"battle axe"
	[GetStringFromTid(1029917)]={m="m"; objectType="9917, 9927";}; -- L"bladed staff"
    [GetStringFromTid(1029915)]={m="m"; objectType="9915, 9924";}; -- L"bone harvester"
    [GetStringFromTid(1015055)]={m="m"; objectType="3934, 3935";}; -- L"broadsword"
    [GetStringFromTid(1011174)]={m="m"; objectType="5110, 5111";}; -- L"butcher knife"
    [GetStringFromTid(1029921)]={m="m"; objectType="9921, 9931";}; -- L"crescent blade"
    [GetStringFromTid(1015051)]={m="m"; objectType="5184, 5185";}; -- L"cutlass"
    [GetStringFromTid(1015062)]={m="m"; objectType="3915, 3916";}; -- L"double axe"
    [GetStringFromTid(1015060)]={m="m"; objectType="3909, 3910";}; -- L"executioner's axe"
    [GetStringFromTid(1015069)]={m="m"; objectType="5182, 5183";}; -- L"halberd"
    [GetStringFromTid(1011179)]={m="m"; objectType="3907, 3908";}; -- L"hatchet"
    [GetStringFromTid(1015052)]={m="m"; objectType="5118, 5119";}; -- L"katana"
    [GetStringFromTid(1015063)]={m="m"; objectType="5114, 5115";}; -- L"large battle axe"
    [GetStringFromTid(1015056)]={m="m"; objectType="3936, 3937";}; -- L"longsword"
    [GetStringFromTid(1025047)]={m="m"; objectType="5047, 5048";}; -- L"long sword"
    [GetStringFromTid(1011189)]={m="m"; objectType="3717, 3718";}; -- L"pickaxe"
    [GetStringFromTid(1015054)]={m="m"; objectType="5045, 5046";}; -- L"scimitar"
    [GetStringFromTid(1029914)]={m="m"; objectType="9914, 9924";}; -- L"scythe"
    [GetStringFromTid(1011220)]={m="m"; objectType="3780, 3781";}; -- L"skinning knife"
    [GetStringFromTid(1015057)]={m="m"; objectType="5049, 5050";}; -- L"viking sword"
    [GetStringFromTid(1030152)]={m="w"; objectType="10152";}; -- L"bokuto"
    [GetStringFromTid(1030146)]={m="m"; objectType="10146";}; -- L"no-dachi"
    [GetStringFromTid(1030148)]={m="m"; objectType="10148";}; -- L"wakizashi"
    [GetStringFromTid(1030153)]={m="m"; objectType="10153";}; -- L"daisho"
    [GetStringFromTid(1031561)]={m="m"; objectType="11561, 11573";}; -- L"elven machete"
    [GetStringFromTid(1031560)]={m="m"; objectType="11560, 11572";}; -- L"ornate axe"
    [GetStringFromTid(1031559)]={m="m"; objectType="11559, 11571";}; -- L"radiant scimitar"
    [GetStringFromTid(1031558)]={m="m"; objectType="11558, 11570";}; -- L"rune blade"
    [GetStringFromTid(1023568)]={m="w"; objectType="3568, 3569";}; -- L"black staff"
    [GetStringFromTid(1025043)]={m="w"; objectType="5043, 5044";}; -- L"club"
    [GetStringFromTid(1025112)]={m="w"; objectType="5112, 5113";}; -- L"gnarled staff"
    [GetStringFromTid(1015074)]={m="m"; objectType="5180, 5181";}; -- L"hammer pick"
    [GetStringFromTid(1023570)]={m="m"; objectType="3570, 3571, 3572, 3573";}; -- L"magic wand"
    [GetStringFromTid(1015071)]={m="m"; objectType="5178, 5179";}; -- L"maul"
    [GetStringFromTid(1023721)]={m="w"; objectType="3721, 3722";}; -- L"quarter staff"
    [GetStringFromTid(1029926)]={m="m"; objectType="9916, 9926";}; -- L"scepter"
    [GetStringFromTid(1023713)]={m="w"; objectType="3713, 3714";}; -- L"shepherd's crook"
    [GetStringFromTid(1025108)]={m="w"; objectType="5108, 5109";}; -- L"shepherd's crook"
    [GetStringFromTid(1011225)]={m="m"; objectType="4020, 4021";}; -- L"sledge hammer"
    [GetStringFromTid(1011186)]={m="m"; objectType="5091, 5092";}; -- L"smith's hammer"
    [GetStringFromTid(1015064)]={m="m"; objectType="5039, 5040";}; -- L"war axe"
    [GetStringFromTid(1015073)]={m="m"; objectType="5176, 5177";}; -- L"war hammer"
    [GetStringFromTid(1015072)]={m="m"; objectType="5126, 5127";}; -- L"war mace"
    [GetStringFromTid(1030158)]={m="m"; objectType="10158";}; -- L"nunchaku"
    [GetStringFromTid(1030147)]={m="m"; objectType="10147";}; -- L"tessen"
    [GetStringFromTid(1030150)]={m="w"; objectType="10150";}; -- L"tetsubo"
    [GetStringFromTid(1031556)]={m="m"; objectType="11556, 11568";}; -- L"diamond mace"
    [GetStringFromTid(1031557)]={m="w"; objectType="11557, 11569";}; -- L"wild staff"
    [GetStringFromTid(1029919)]={m="m"; objectType="9919, 9929";}; -- L"double bladed staff"
    [GetStringFromTid(1015053)]={m="m"; objectType="5120, 5121";}; -- L"kryss"
    [GetStringFromTid(1029920)]={m="m"; objectType="9920, 9930";}; -- L"lance"
    [GetStringFromTid(1029918)]={m="m"; objectType="9918, 9928";}; -- L"pike"
    [GetStringFromTid(1023719)]={m="m"; objectType="3719, 3720";}; -- L"pitchfork"
    [GetStringFromTid(1015065)]={m="m"; objectType="5122, 5123";}; -- L"short spear"
    [GetStringFromTid(1015066)]={m="m"; objectType="3938, 3939";}; -- L"spear"
    [GetStringFromTid(1025124)]={m="m"; objectType="5124, 5125";}; -- L"war fork"
    [GetStringFromTid(1030151)]={m="m"; objectType="10151";}; -- L"lajatang"
    [GetStringFromTid(1030155)]={m="m"; objectType="10155";}; -- L"tekagi"
    [GetStringFromTid(1030157)]={m="m"; objectType="10157";}; -- L"kama"
    [GetStringFromTid(1030159)]={m="m"; objectType="10159";}; -- L"sai"
    [GetStringFromTid(1031553)]={m="m"; objectType="11553, 11565";}; -- L"assassin spike"
    [GetStringFromTid(1031552)]={m="m"; objectType="11552, 11564";}; -- L"elven spellblade"
    [GetStringFromTid(1031554)]={m="m"; objectType="11554, 11566";}; -- L"leafblade"
    [GetStringFromTid(1031555)]={m="m"; objectType="11555, 11567";}; -- L"war cleaver"
    [GetStringFromTid(1015070)]={m="m"; objectType="3932, 3933";}; -- L"mace"
    [GetStringFromTid(1015059)]={m="m"; objectType="3913, 3914";}; -- L"axe"
    [GetStringFromTid(1015050)]={m="m"; objectType="3921, 3922";}; -- L"dagger"
    [GetStringFromTid(1011204)]={m="m"; objectType="3778, 3779";}; -- L"cleaver"
    [GetStringFromTid(1029934)]={m="w"; objectType="9934, 9935";};	-- L"paladin sword"
    [GetStringFromTid(1025116)]={m="w";isBow=true; objectType="5116, 5117";}; -- L"heavy crossbow"
    [GetStringFromTid(1029933)]={m="w";isBow=true; objectType="9923, 9933";}; -- L"repeating crossbow"
    [GetStringFromTid(1030149)]={m="w";isBow=true; objectType="10149";}; -- L"yumi"
    [GetStringFromTid(1031550)]={m="w";isBow=true; objectType="11550, 11562";}; -- L"elven composite longbow"
    [GetStringFromTid(1031551)]={m="w";isBow=true; objectType="11551, 11563";}; -- L"magical shortbow"
    [GetStringFromTid(1023919)]={m="w";isBow=true; objectType="3919, 3920";}; -- L"crossbow"
    [GetStringFromTid(1029922)]={m="w";isBow=true; objectType="9922, 9932";}; -- L"composite bow"
    [GetStringFromTid(1025041)]={m="w";isBow=true; objectType="5041, 5042";};	-- L"bow"
    
    [GetStringFromTid(1061601)] ={m="m";}; -- L"Serpent's Fang"
    [GetStringFromTid(1061600)] ={m="w";}; -- L"Staff Of The Magi"
    [GetStringFromTid(1061088)] ={m="w";}; -- L"Blade Of Insanity"
    [GetStringFromTid(1061106)] ={m="m";}; -- L"Axe Of The Heavens"
    [GetStringFromTid(1061107)] ={m="m";}; -- Blade of the Righteous
    [GetStringFromTid(1061108)] ={m="m";}; -- L"The Berserker's Maul"
    [GetStringFromTid(1061109)] ={m="m";}; -- L"Breath Of The Dead"
    [GetStringFromTid(1061110)] ={m="m";}; -- L"The Taskmaster"
    [GetStringFromTid(1061111)] ={m="m";}; -- L"Frostbringer"
    [GetStringFromTid(1061596)] ={m="m";}; -- L"Bone Crusher"
    [GetStringFromTid(1061248)] ={m="m";}; -- L"The Dragon Slayer"
    [GetStringFromTid(1060860)] ={m="m";}; -- L"Legacy Of The Dread Lord"
    [GetStringFromTid(1060024)] ={m="m";}; -- Titan's Hammer
    [GetStringFromTid(1061593)] ={m="m";}; -- Zyronic Claw
    [GetStringFromTid(1070853)] ={m="w";}; -- L"Wrath Of The Dryad" 
    [GetStringFromTid(1070692)] ={m="w";}; -- L"Staff Of Power"
	[GetStringFromTid(1070854)] ={m="m";}; -- L"Pixie Swatter"
	[GetStringFromTid(1070636)] ={m="w";isBow=true};  -- L"Bow Of The Juka King"
	[GetStringFromTid(1070818)] ={m="m";}; -- L"Cold Blood"
	[GetStringFromTid(1063474)] ={m="m";}; -- L"Captain Quacklebush's Cutlass"
	[GetStringFromTid(1063481)] ={m="m";}; -- L"Arctic Death Dealer"
	[GetStringFromTid(1063486)] ={m="m";}; -- L"Blaze Of Death"
	[GetStringFromTid(1063482)] ={m="m";}; -- L"Enchanted Titan Leg Bone"
	[GetStringFromTid(1063472)] ={m="m";}; -- L"Cavorting Club"
	[GetStringFromTid(1063475)] ={m="m";}; -- L"Night's Kiss"
	[GetStringFromTid(1063485)] ={m="w";isBow=true};  -- L"Nox Ranger's Heavy Crossbow"
	[GetStringFromTid(1063469)] ={m="m";}; -- L"Luna Lance"
    [GetStringFromTid(1061090)] ={m="w";isBow=true}; -- L"The Dryad Bow"
    [GetStringFromTid(1075032)] ={m="w";}; -- L"Boomstick"
    [GetStringFromTid(1075044)] ={m="w";isBow=true}; -- L"Wildfire Bow"
    [GetStringFromTid(1075031)] ={m="w";isBow=true}; -- L"Windsong"
    [GetStringFromTid(1075033)] ={m="m";}; -- L"Blade Dance"
    [GetStringFromTid(1075030)] ={m="m";}; -- L"Bonesmasher"
    [GetStringFromTid(1075045)] ={m="m";}; -- L"Flesh Ripper"
    [GetStringFromTid(1075036)] ={m="m";}; -- L"Raed's Glory"
    [GetStringFromTid(1075049)] ={m="m";}; -- L"Righteous Anger"
    [GetStringFromTid(1075046)] ={m="m";}; -- L"Soul Seeker"
    [GetStringFromTid(1075029)] ={m="m";}; -- L"Talon Bite"
    [GetStringFromTid(1072080)] ={m="m";}; -- L"Scepter Of The Chief"
    [GetStringFromTid(1072092)] ={m="m";}; -- L"Dread's Revenge"
    [GetStringFromTid(1072115)] ={m="m";}; -- L"Melisande's Corroded Hatchet"
    
    [GetStringFromTid(1070917)] ={m="m";}; -- L"Demon Forks"
    [GetStringFromTid(1070915)] ={m="m";}; -- L"The Destroyer"
    [GetStringFromTid(1070914)] ={m="m";}; -- L"Dragon Nunchaku"
    [GetStringFromTid(1070913)] ={m="m";}; -- L"Exiler"
    [GetStringFromTid(1070918)] ={m="w";isBow=true}; -- L"Hanzo's Bow"
    [GetStringFromTid(1070912)] ={m="w";}; -- L"Peasant's Bokuto"
    [GetStringFromTid(1070916)] ={m="m";}; -- L"Pilfered Dancer Fans"
    [GetStringFromTid(1070966)] ={m="m";}; -- L"Darkened Sky"
    [GetStringFromTid(1070964)] ={m="m";}; -- L"Sword Of The Stampede"
    [GetStringFromTid(1070963)] ={m="m";}; -- L"Sword Of The Stampede"
    [GetStringFromTid(1070967)] ={m="w";isBow=true}; -- L"Hanzo's Bow"
    [GetStringFromTid(1070965)] ={m="m";}; -- L"Wind's Edge"
    [GetStringFromTid(1113520)] ={m="m";}; -- L"Abyssal Blade"
    [GetStringFromTid(1113863)] ={m="m";}; -- L"Axe Of Abandon"
    [GetStringFromTid(1113517)] ={m="m";}; -- L"Axes Of Fury"
    [GetStringFromTid(1113529)] ={m="m";isBow=true}; -- L"Banshee's Call"
    [GetStringFromTid(1113525)] ={m="m";}; -- L"Blade Of Battle"
    [GetStringFromTid(1115446)] ={m="m";}; -- L"Cavalry's Folly"
    [GetStringFromTid(1113518)] ={m="g";}; --  L"Channeler's Defender"
    [GetStringFromTid(1113758)] ={m="m";}; -- Claws Of The Berserker
    [GetStringFromTid(1113526)] ={m="m";}; -- L"Death's Head"
    [GetStringFromTid(1113864)] ={m="m";}; -- L"Demon Hunter's Standard"
    [GetStringFromTid(1114789)] ={m="m";}; -- L"Draconi's Wrath"
    [GetStringFromTid(1112443)] ={m="w";}; -- L"Eternal Guardian Staff"
    [GetStringFromTid(1113759)] ={m="w";isBow=true}; -- L"Ironwood Composite Bow"
    [GetStringFromTid(1115445)] ={m="m";}; -- L"Jade War Axe"
    [GetStringFromTid(1113519)] ={m="m";}; -- L"Legacy of Despair"
    [GetStringFromTid(1113524)] ={m="m";}; -- L"Life Syphon"
    [GetStringFromTid(1114842)] ={m="m";}; -- L"Mangler"
    [GetStringFromTid(1113528)] ={m="m";}; -- L"Petrified Snake"
    [GetStringFromTid(1112394)] ={m="m";isBow=true}; -- L"Raptor Claw"
    [GetStringFromTid(1113757)] ={m="w";}; -- L"Resonant Staff Of Enlightenment"
    [GetStringFromTid(1113522)] ={m="m";}; -- L"Standard Of Chaos"
    [GetStringFromTid(1112771)] ={m="g";}; -- L"Staff Of Shattered Dreams"
    [GetStringFromTid(1113527)] ={m="g";}; -- L"Staff Of Resonance"
    [GetStringFromTid(1113523)] ={m="m";}; -- L"Stone Dragon's Tooth"
    [GetStringFromTid(1112393)] ={m="m";isBow=true}; -- L"Stone Slith Claw"
    [GetStringFromTid(1113530)] ={m="m";isBow=true}; -- L"Storm Caller"
    [GetStringFromTid(1112770)] ={m="g";}; -- L"Sword Of Shattered Hopes"
    [GetStringFromTid(1113822)] ={m="m";}; -- L"The Impaler's Pick"
    [GetStringFromTid(1113873)] ={m="m";}; -- L"Vampiric Essence"
    [GetStringFromTid(1116623)] ={m="m";}; -- L"Illustrious Wand Of Thundering Glory"
    [GetStringFromTid(1116622)] ={m="w";}; -- L"Rune Engraved Peg Leg"
    [GetStringFromTid(1116628)] ={m="w";}; -- L"Smiling Moon Blade"
    [GetStringFromTid(1116630)] ={m="w";}; -- L"The Culling Blade"
    [GetStringFromTid(1149961)] ={m="w";isBow=true}; -- L"Runed Driftwood Bow" 
    [GetStringFromTid(1072916)] ={m="m";}; -- L"Cold Forged Blade" 
    [GetStringFromTid(1072922)] ={m="m";}; -- L"Luminous Rune Blade"
    [GetStringFromTid(1072920)] ={m="m";}; -- L"Overseer Sundered Blade"
    [GetStringFromTid(1072915)] ={m="m";}; -- L"Rune Carving Knife"
    [GetStringFromTid(1072918)] ={m="m";}; -- L"Shard Thrasher"
    [GetStringFromTid(1072919)] ={m="w";}; -- L"Phantom Staff"
    [GetStringFromTid(1072907)] ={m="w";isBow=true}; -- L"Blight Gripped Longbow"
    [GetStringFromTid(1072908)] ={m="w";isBow=true}; -- L"Faerie Fire"
    [GetStringFromTid(1072955)] ={m="w";isBow=true}; -- L"Silvani's Feywood Bow"
    [GetStringFromTid(1072912)] ={m="w";isBow=true}; -- L"The Night Reaper"
    [GetStringFromTid(1072910)] ={m="w";isBow=true}; -- L"Mischief Maker"
    [GetStringFromTid(1079837)] ={m="m";}; -- L"Berserker's Scythe"
    [GetStringFromTid(1079836)] ={m="m";}; -- L"Vorpal Blade"
    [GetStringFromTid(1077442)] ={m="m";}; -- L"The Redeemer"
    [GetStringFromTid(1079835)] ={m="w";}; -- L"Staff Of Pyros"
    [L"Inavlis's Burchete"] ={m="m";};
    [L"Berserker's Bardiche"] ={m="m";};
    [GetStringFromTid(1150060)] ={m="m";}; -- L"Defiler Of Virtue" 
    [GetStringFromTid(1150358)] ={m="m";isBow=true}; -- L"Wind of Corruption" 
    
    [GetStringFromTid(1073260)] ={m="m";}; -- Blackthorn's Kryss - Museum of Vesper Replica
    [GetStringFromTid(1073261)] ={m="m";}; -- Sword of Justice - Museum of Vesper Replica
    [GetStringFromTid(1073263)] ={m="m";}; -- Geoffrey's Axe - Museum of Vesper Replica
    
    [GetStringFromTid(1094892)] ={m="m";}; -- Fang of Ractus [Replica]
    [GetStringFromTid(1094909)] ={m="m";}; -- Brave Knight of The Britannia [Replica]
    [GetStringFromTid(1094915)] ={m="m";}; -- Calm [Replica]
    [GetStringFromTid(1094916)] ={m="m";}; -- Oblivion's Needle [Replica]
    [GetStringFromTid(1094918)] ={m="m";}; -- Royal Guard Survival Knife [Replica]
    [GetStringFromTid(1094928)] ={m="m";}; -- Quell [Replica]
    [GetStringFromTid(1094929)] ={m="m";}; -- Pacify [Replica]
    [GetStringFromTid(1094930)] ={m="m";}; -- Subdue [Replica]
	}
ItemPropertiesEvaluator.ArmorNames = {
	[GetStringFromTid(1031121)]={m="w";[L"physical resist"]=5;[L"fire resist"]=1;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5; layer=1079897; objectType="11121";}; -- L"raven helm"
	[GetStringFromTid(1031122)]={m="w";[L"physical resist"]=5;[L"fire resist"]=1;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5; layer=1079897; objectType="11122";}; -- L"vulture helm"
	[GetStringFromTid(1031123)]={m="w";[L"physical resist"]=5;[L"fire resist"]=1;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5; layer=1079897; objectType="11123";}; -- L"winged helm"
	
	[GetStringFromTid(1025130)]={m="m";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079897; objectType="5130, 5131";}; -- L"helmet"
	[GetStringFromTid(1025129)]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079897; objectType="5129, 5128";}; -- L"closed helm"
	[GetStringFromTid(1025132)]={m="m";[L"physical resist"]=7;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=2; layer=1079897; objectType="5132, 5133";}; -- L"bascinet"
	[GetStringFromTid(1025134)]={m="m";[L"physical resist"]=4;[L"fire resist"]=1;[L"cold resist"]=4;[L"poison resist"]=4;[L"energy resist"]=2; layer=1079897; objectType="5134, 5135";}; -- L"norse helm"
	
	[GetStringFromTid(1027947)]={m="l";[L"physical resist"]=3;[L"fire resist"]=1;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=5; layer=1079897; objectType="7947, 7948";}; -- orc helm
	
	[GetStringFromTid(1031124)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079904; objectType="11124";}; -- hide tunic
	[GetStringFromTid(1031125)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079907; objectType="11125";}; -- hide gloves
	[GetStringFromTid(1031126)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079898; objectType="11126";}; -- hide gorget
	[GetStringFromTid(1031127)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079899; objectType="11127";}; -- hide pauldrons
	[GetStringFromTid(1031128)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079902; objectType="11128";}; -- hide pants
	
	[GetStringFromTid(1031111)]={m="w";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079904; objectType="11111";}; -- woodland chest
	[GetStringFromTid(1031113)]={m="w";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079898; objectType="11113";}; -- woodland gorget
	[GetStringFromTid(1031114)]={m="w";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079907; objectType="11114";}; -- woodland gauntlets
	[GetStringFromTid(1031115)]={m="w";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079902; objectType="11115";}; -- woodland leggings
	[GetStringFromTid(1031116)]={m="w";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079899; objectType="11116";}; -- woodland arms
	
	[GetStringFromTid(1073481)]={m="w";[L"physical resist"]=8;[L"fire resist"]=5;[L"cold resist"]=5;[L"poison resist"]=7;[L"energy resist"]=5; layer=1079897;}; -- Darkwood Crown
	[GetStringFromTid(1073482)]={m="w";[L"physical resist"]=8;[L"fire resist"]=5;[L"cold resist"]=5;[L"poison resist"]=7;[L"energy resist"]=5; layer=1079904;}; -- Darkwood Chest
	[GetStringFromTid(1073483)]={m="w";[L"physical resist"]=8;[L"fire resist"]=5;[L"cold resist"]=5;[L"poison resist"]=7;[L"energy resist"]=5; layer=1079898;}; -- Darkwood Gorget
	[GetStringFromTid(1073484)]={m="w";[L"physical resist"]=8;[L"fire resist"]=5;[L"cold resist"]=5;[L"poison resist"]=7;[L"energy resist"]=5; layer=1079902;}; -- Darkwood Leggings
	[GetStringFromTid(1073485)]={m="w";[L"physical resist"]=8;[L"fire resist"]=5;[L"cold resist"]=5;[L"poison resist"]=7;[L"energy resist"]=5; layer=1079899;}; -- Darkwood Pauldrons
	[GetStringFromTid(1073486)]={m="w";[L"physical resist"]=8;[L"fire resist"]=5;[L"cold resist"]=5;[L"poison resist"]=7;[L"energy resist"]=5; layer=1079907;}; -- Darkwood Gauntlets

	[GetStringFromTid(1025198)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4; layer=1079899; objectType="5198, 5203";}; -- bone arms
	[GetStringFromTid(1025199)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4; layer=1079904; objectType="5199, 5204";}; -- bone armor
	[GetStringFromTid(1025200)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4; layer=1079907; objectType="5200, 5205";}; -- bone gloves
	[GetStringFromTid(1025201)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4; layer=1079897; objectType="5201, 5206";}; -- bone helmet
	[GetStringFromTid(1025202)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4; layer=1079902; objectType="5202, 5207";}; -- bone leggings

	[GetStringFromTid(1029793)]={m="s";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079904; objectType="9793, 9794";}; -- dragon breastplate
	[GetStringFromTid(1029795)]={m="s";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079907; objectType="9795, 9796";}; -- dragon gloves
	[GetStringFromTid(1029797)]={m="s";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079897; objectType="9797, 9798";}; -- dragon helm
	[GetStringFromTid(1029799)]={m="s";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079902; objectType="9799, 9800";}; -- dragon leggings
	[GetStringFromTid(1029815)]={m="s";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079899; objectType="9715, 9716";}; -- dragon sleeves
	
	[GetStringFromTid(1025076)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079899; objectType="5076, 5084";}; -- studded sleeves
	[GetStringFromTid(1025077)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079907; objectType="5077, 5085";}; -- studded gloves
	[GetStringFromTid(1025078)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079898; objectType="5078";}; -- studded gorget
	[GetStringFromTid(1025080)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079902; objectType="5082, 5089";}; -- studded leggings
	[GetStringFromTid(1025081)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079904; objectType="5083, 5090";}; -- studded tunic
	[GetStringFromTid(1027170)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079904; objectType="7170, 7171";}; -- studded armor
	[GetStringFromTid(1027180)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079904; objectType="7180, 7181";}; -- studded bustier
	
	[GetStringFromTid(1025104)]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=1;[L"poison resist"]=5;[L"energy resist"]=3; layer=1079902; objectType="5104, 5105";}; -- ringmail leggings
	[GetStringFromTid(1025095)]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=1;[L"poison resist"]=5;[L"energy resist"]=3; layer=1079904; objectType="5100, 5101";}; -- ringmail armor
	[GetStringFromTid(1025097)]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=1;[L"poison resist"]=5;[L"energy resist"]=3; layer=1079899; objectType="5102, 5103";}; -- ringmail sleeves
	[GetStringFromTid(1025099)]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=1;[L"poison resist"]=5;[L"energy resist"]=3; layer=1079907; objectType="5099, 5106";}; -- ringmail gloves
	[GetStringFromTid(1025100)]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=1;[L"poison resist"]=5;[L"energy resist"]=3; layer=1079904; objectType="5100, 5101";}; -- ringmail tunic
	
	[GetStringFromTid(1025051)]={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2; layer=1079897; objectType="5051, 5056";}; -- chainmail coif
	[GetStringFromTid(1025052)]={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2; layer=1079902; objectType="5054, 5059";}; -- chainmail leggings
	[GetStringFromTid(1025053)]={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2; layer=1079904; objectType="5055, 5060";}; -- chainmail tunic
	
	[GetStringFromTid(1015038)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079904; objectType="7172, 7173";}; -- female plate
	[GetStringFromTid(1025136)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079899; objectType="5136, 5143";}; -- platemail arms
	[GetStringFromTid(1025137)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079902; objectType="5137, 5146";}; -- platemail legs
	[GetStringFromTid(1025138)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079897; objectType="5138, 5145";}; -- plate helm
	[GetStringFromTid(1025139)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079898; objectType="5139";}; -- platemail gorget
	[GetStringFromTid(1025140)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079907; objectType="5140, 5144";}; -- platemail gloves
	[GetStringFromTid(1025141)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079904; objectType="5141, 5142";}; -- platemail tunic
	[GetStringFromTid(1025143)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079899; objectType="5136, 5143";}; -- platemail arms
	
	[GetStringFromTid(1030100)]={m="m";[L"physical resist"]=5;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=4; layer=1079897; objectType="10100";}; -- chainmail hatsuburi
	[GetStringFromTid(1030101)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3; layer=1079897; objectType="10101";}; -- platemail hatsuburi
	[GetStringFromTid(1030103)]={m="m";[L"physical resist"]=7;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=2; layer=1079897; objectType="10103";}; -- heavy platemail jingasa
	[GetStringFromTid(1030104)]={m="m";[L"physical resist"]=6;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3; layer=1079897; objectType="10104";}; -- decorative platemail kabuto
	[GetStringFromTid(1030113)]={m="m";[L"physical resist"]=7;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=2; layer=1079897; objectType="10113";}; -- light platemail jingasa
	[GetStringFromTid(1030116)]={m="m";[L"physical resist"]=7;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=2; layer=1079897; objectType="10116";}; -- small platemail jingasa
	[GetStringFromTid(1030117)]={m="m";[L"physical resist"]=6;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3; layer=1079897; objectType="10117";}; -- platemail battle kabuto
	[GetStringFromTid(1030121)]={m="m";[L"physical resist"]=6;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3; layer=1079897; objectType="10121";}; -- standard platemail kabuto
	[GetStringFromTid(1062923)]={m="m";[L"physical resist"]=6;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3; layer=1079897; objectType="9068";}; -- ancient samurai helm
	
	[GetStringFromTid(1030105)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079898; objectType="10105";}; -- platemail mempo
	[GetStringFromTid(1030109)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079904; objectType="10109";}; -- platemail do
	[GetStringFromTid(1030112)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079899; objectType="10112";}; -- platemail hiro sode
	[GetStringFromTid(1030120)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079902; objectType="10120";}; -- platemail suneate
	[GetStringFromTid(1030125)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079902; objectType="10125";}; -- platemail haidate
	
	[GetStringFromTid(1030141)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079898; objectType="10141";}; -- studded mempo
	[GetStringFromTid(1030108)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079904; objectType="10108";}; -- studded do
	[GetStringFromTid(1030111)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079899; objectType="10111";}; -- studded hiro sode
	[GetStringFromTid(1030119)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079902; objectType="10119";}; -- studded suneate
	[GetStringFromTid(1030123)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079902; objectType="10123";}; -- studded haidate
	
	[GetStringFromTid(1031118)]={m="m";[L"physical resist"]=1;[L"fire resist"]=5;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5; layer=1079897; objectType="11118";}; -- L"circlet"
	[GetStringFromTid(1031119)]={m="m";[L"physical resist"]=1;[L"fire resist"]=5;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5; layer=1079897; objectType="11119";}; -- royal circlet
	[GetStringFromTid(1031120)]={m="m";[L"physical resist"]=1;[L"fire resist"]=5;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5; layer=1079897; objectType="11120";}; -- gemmed circlet
	
	[GetStringFromTid(1011209)] ={m="m";[L"physical resist"]=0;[L"fire resist"]=0;[L"cold resist"]=0;[L"poison resist"]=0;[L"energy resist"]=0; layer=1079898; objectType="4229, 4232, 4233, 7944";}; -- L"Necklace"
	
	[GetStringFromTid(1032229)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4; layer=1079904; objectType="12229";}; -- leaf tunic
	[GetStringFromTid(1032230)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4; layer=1079907; objectType="12230";}; -- leaf gloves
	[GetStringFromTid(1032231)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4; layer=1079898; objectType="12231";}; -- leaf gorget
	[GetStringFromTid(1032232)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4; layer=1079899; objectType="12232";}; -- leaf arms
	[GetStringFromTid(1032233)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4; layer=1079902; objectType="12233";}; -- leaf leggings
	[GetStringFromTid(1032234)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4; layer=1079902; objectType="12234";}; -- leaf tonlet
	
	[GetStringFromTid(1025061)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079899; objectType="5061, 5069";}; -- leather sleeves
	[GetStringFromTid(1025062)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079907; objectType="5062, 5070";}; -- leather gloves
	[GetStringFromTid(1025063)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079898; objectType="5063";}; -- leather gorget
	[GetStringFromTid(1025064)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079899; objectType="5061, 5069";}; -- leather sleeves
	[GetStringFromTid(1025065)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079902; objectType="5067, 5074";}; -- leather leggings
	[GetStringFromTid(1025066)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079904; objectType="5068, 5075";}; -- leather tunic
	[GetStringFromTid(1015295)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079897; objectType="7109, 7110";}; -- leather cap
	[GetStringFromTid(1027168)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079902; objectType="7168, 7169";}; -- leather shorts
	[GetStringFromTid(1027174)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079904; objectType="7174, 7175";}; -- female leather armor
	[GetStringFromTid(1027176)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079902; objectType="7176, 7177";}; -- leather skirt
	[GetStringFromTid(1027178)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079904; objectType="7178, 7179";}; -- leather bustier
	
	[GetStringFromTid(1030102)]={m="l";[L"physical resist"]=4;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=2;[L"energy resist"]=3; layer=1079897; objectType="10102";}; -- leather jingasa
	
	[GetStringFromTid(1030106)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079898; objectType="10106";}; -- leather mempo
	[GetStringFromTid(1030107)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079904; objectType="10107";}; -- leather do
	[GetStringFromTid(1030110)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079899; objectType="10110";}; -- leather hiro sode
	[GetStringFromTid(1030118)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079902; objectType="10118";}; -- leather suneate
	[GetStringFromTid(1030122)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079902; objectType="10122";}; -- leather haidate
	
	[GetStringFromTid(1030126)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079897; objectType="10126";}; -- leather ninja hood
	[GetStringFromTid(1030129)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079902; objectType="10129";}; -- leather ninja pants
	[GetStringFromTid(1030130)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079907; objectType="10130";}; -- leather ninja mitts
	[GetStringFromTid(1030131)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079904; objectType="10131";}; -- leather ninja jacket
	
	[GetStringFromTid(1113762)]={m="m";[L"physical resist"]=1;[L"fire resist"]=5;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5; layer=1079897;}; -- L"Crown of Arcane Temperament"	
	[GetStringFromTid(1061598)] ={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079902;}; -- L"Shadow Dancer Leggings"
	[GetStringFromTid(1061094)] ={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079898;}; -- L"Voice Of The Fallen King"
	[GetStringFromTid(1070690)] ={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079907;}; -- L"Gloves Of The Pugilist"
	
	[GetStringFromTid(1075037)] ={m="m";[L"physical resist"]=6;[L"fire resist"]=5;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=8; layer=1079897;}; -- L"Helm Of Swiftness"
	[GetStringFromTid(1075047)] ={m="m";[L"physical resist"]=1;[L"fire resist"]=5;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5; layer=1079897;}; -- L"Aegis Of Grace"
	[GetStringFromTid(1079525)] ={m="m";[L"physical resist"]=0;[L"fire resist"]=0;[L"cold resist"]=0;[L"poison resist"]=0;[L"energy resist"]=0; layer=1079898;}; -- L"Ankh Pendant"
	
	[GetStringFromTid(1070921)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079899;}; -- L"Arms Of Tactical Excellence"
	[GetStringFromTid(1070924)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079907;}; -- L"Gloves Of The Sun"
	[GetStringFromTid(1070970)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079907;}; -- L"Stormgrip"
	[GetStringFromTid(1114843)]={m="m";[L"physical resist"]=0;[L"fire resist"]=0;[L"cold resist"]=0;[L"poison resist"]=0;[L"energy resist"]=0; layer=1079898;}; -- L"Lavaliere"
	[GetStringFromTid(1113761)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079904;}; -- L"Protector Of The Battle Mage"
	
	[GetStringFromTid(1116619)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079899;}; -- L"Leviathan Hide Bracers"
	[GetStringFromTid(1149957)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079904;}; -- L"Bronzed Armor Of The Valkyrie"
	[GetStringFromTid(1149960)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079902;}; -- L"Enchanted Kelp Woven Leggings"
	
	[GetStringFromTid(1072931)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4; layer=1079899;}; -- L"Song Woven Mantle"
	[GetStringFromTid(1072929)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4; layer=1079902;}; -- L"Spell Woven Britches"
	[GetStringFromTid(1072932)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4; layer=1079907;}; -- L"Stitcher's Mittens"
	[GetStringFromTid(1072937)] ={m="m";[L"physical resist"]=0;[L"fire resist"]=0;[L"cold resist"]=0;[L"poison resist"]=0;[L"energy resist"]=0; layer=1079898;}; -- L"Pendant Of The Magi"
	[GetStringFromTid(1071460)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079898;}; -- L"Leurocian's Mempo Of Fortune"
		
	[GetStringFromTid(1061594)] ={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079898;}; -- L"Jackal's Collar"
	[GetStringFromTid(1061097)] ={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079904;}; -- L"Holy Knight's Breastplate"
	[GetStringFromTid(1061092)] ={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=1;[L"poison resist"]=5;[L"energy resist"]=3; layer=1079907;}; -- L"Gauntlets Of Nobility"
	[GetStringFromTid(1061093)] ={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4; layer=1079899;}; -- L"Midnight Bracers"
	[GetStringFromTid(1061095)] ={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4; layer=1079897;}; -- L"Ornate Crown Of The Harrower"
	[GetStringFromTid(1061096)] ={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079897;}; -- L"Helm Of Insight"
	[GetStringFromTid(1061098)] ={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079904;}; -- L"Armor Of Fortune"
	[GetStringFromTid(1061099)] ={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2; layer=1079904;}; -- L"Tunic Of Fire"
	[GetStringFromTid(1061100)] ={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2; layer=1079902;}; -- L"Leggings Of Bane"
	[GetStringFromTid(1060206)] ={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079907;}; -- The Inquisitor's Resolution
	[GetStringFromTid(1063471)] ={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079904;}; -- L"Violet Courage"
	[GetStringFromTid(1070817)] ={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079904;}; -- L"Heart Of The Lion"
	[GetStringFromTid(1027947)] ={m="l";[L"physical resist"]=3;[L"fire resist"]=1;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=5; layer=1079897;}; -- L"Orcish Visage"
	[GetStringFromTid(1075041)] ={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2; layer=1079902;}; -- L"Fey Leggings"
	
	[GetStringFromTid(1070926)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079904;}; -- L"Ancient Samurai Do"
	[GetStringFromTid(1070920)]={m="m";[L"physical resist"]=6;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3; layer=1079897;}; -- L"Daimyo's Helm"
	[GetStringFromTid(1070923)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079902;}; -- L"Legs Of Stability"
	[GetStringFromTid(1070968)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079904;}; -- L"Rune Beetle Carapace"
	
	[GetStringFromTid(1113760)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079902;}; -- L"Animated Legs Of The Insane Tinker"
	[GetStringFromTid(1115444)]={m="s";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3; layer=1079904;}; -- L"Basilisk Hide Breastplate"
	
	[GetStringFromTid(1025134)]={m="m";[L"physical resist"]=4;[L"fire resist"]=1;[L"cold resist"]=4;[L"poison resist"]=4;[L"energy resist"]=2; layer=1079897;}; -- L"Helm Of Vengeance"
	
	[GetStringFromTid(1073257)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4; layer=1079904;}; -- Minax's Armor - Museum of Vesper Replica
	
	[GetStringFromTid(1073264)]={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2; layer=1079904;}; -- Keeonean's Chain Mail - Museum of Vesper Replica
	
	[GetStringFromTid(1073222)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- Leather Armor of the Britannia Royal Zoo
	[GetStringFromTid(1073223)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- Studded Armor of the Britannia Royal Zoo
	[GetStringFromTid(1073224)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- Platemail Armor of the Britannia Royal Zoo
	
	[GetStringFromTid(1094902)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079907;}; -- Gauntlets of Anger [Replica]
	[GetStringFromTid(1094914)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4; layer=1079904;}; -- Shroud of Deceit [Replica]
	[GetStringFromTid(1094917)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079898;}; -- Gladiator's Collar [Replica]
	[GetStringFromTid(1094924)]={m="l";[L"physical resist"]=3;[L"fire resist"]=1;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=5; layer=1079897;}; -- Orc Chieftain Helm [Replica]
	
	[GetStringFromTid(1153523)] ={m="l";[L"physical resist"]=10;[L"fire resist"]=8;[L"cold resist"]=8;[L"poison resist"]=8;[L"energy resist"]=8; layer=1079899;}; -- Bracers of Alchemical Devastation [Replica]
	
	[GetStringFromTid(1075191)] ={m="l";[L"physical resist"]=8;[L"fire resist"]=11;[L"cold resist"]=6;[L"poison resist"]=8;[L"energy resist"]=7; layer=1079899;}; -- Arms of compassion
	[GetStringFromTid(1075189)] ={m="l";[L"physical resist"]=7;[L"fire resist"]=7;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=7; layer=1079898;}; -- gorget of honesty
	[GetStringFromTid(1075190)] ={m="l";[L"physical resist"]=10;[L"fire resist"]=7;[L"cold resist"]=8;[L"poison resist"]=7;[L"energy resist"]=8; layer=1079904;}; -- Breastplate of Justice
	[GetStringFromTid(1075238)] ={m="l";[L"physical resist"]=8;[L"fire resist"]=11;[L"cold resist"]=6;[L"poison resist"]=8;[L"energy resist"]=7; layer=1079907;}; -- Gauntlets of Valor
	[GetStringFromTid(1075237)] ={m="l";[L"physical resist"]=8;[L"fire resist"]=8;[L"cold resist"]=7;[L"poison resist"]=9;[L"energy resist"]=8; layer=1079897;}; -- Helm of Spirituality
	[GetStringFromTid(1075237)] ={m="l";[L"physical resist"]=8;[L"fire resist"]=7;[L"cold resist"]=10;[L"poison resist"]=7;[L"energy resist"]=8; layer=1079902;}; -- Legs of Honor
	
	[GetStringFromTid(1153536)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079902;}; -- Clockwork Leggings
}

ItemPropertiesEvaluator.GargArmorNames = {	
	[GetStringFromTid(1020775)]={m="m";[L"physical resist"]=8;[L"fire resist"]=6;[L"cold resist"]=5;[L"poison resist"]=6;[L"energy resist"]=5; layer=1079899; objectType="775, 776";}; -- gargish platemail arms
	[GetStringFromTid(1020777)]={m="m";[L"physical resist"]=8;[L"fire resist"]=6;[L"cold resist"]=5;[L"poison resist"]=6;[L"energy resist"]=5; layer=1079904; objectType="777, 778";};  -- gargish platemail chest
	[GetStringFromTid(1020779)]={m="m";[L"physical resist"]=8;[L"fire resist"]=6;[L"cold resist"]=5;[L"poison resist"]=6;[L"energy resist"]=5; layer=1115375; objectType="779, 780";};  -- gargish platemail kilt
	[GetStringFromTid(1020781)]={m="m";[L"physical resist"]=8;[L"fire resist"]=6;[L"cold resist"]=5;[L"poison resist"]=6;[L"energy resist"]=5; layer=1079902; objectType="781, 782";};  -- gargish platemail leggings	
	
	[GetStringFromTid(1095343)]={m="m";[L"physical resist"]=6;[L"fire resist"]=6;[L"cold resist"]=4;[L"poison resist"]=8;[L"energy resist"]=6; layer=1079899; objectType="643, 644";}; -- gargish stone arms
	[GetStringFromTid(1095345)]={m="m";[L"physical resist"]=6;[L"fire resist"]=6;[L"cold resist"]=4;[L"poison resist"]=8;[L"energy resist"]=6; layer=1079904; objectType="645, 646";}; -- gargish stone chest
	[GetStringFromTid(1095347)]={m="m";[L"physical resist"]=6;[L"fire resist"]=6;[L"cold resist"]=4;[L"poison resist"]=8;[L"energy resist"]=6; layer=1115375; objectType="647, 648";}; -- gargish stone kilt
	[GetStringFromTid(1095349)]={m="m";[L"physical resist"]=6;[L"fire resist"]=6;[L"cold resist"]=4;[L"poison resist"]=8;[L"energy resist"]=6; layer=1079902; objectType="649, 650";}; -- gargish stone leggings
	
	[GetStringFromTid(1020769)]={m="l";[L"physical resist"]=5;[L"fire resist"]=6;[L"cold resist"]=7;[L"poison resist"]=6;[L"energy resist"]=6; layer=1079899; objectType="16455, 16456";}; -- gargish leather arms
	[GetStringFromTid(1020771)]={m="l";[L"physical resist"]=5;[L"fire resist"]=6;[L"cold resist"]=7;[L"poison resist"]=6;[L"energy resist"]=6; layer=1079904; objectType="16457, 16458";}; -- gargish leather chest
	[GetStringFromTid(1020773)]={m="l";[L"physical resist"]=5;[L"fire resist"]=6;[L"cold resist"]=7;[L"poison resist"]=6;[L"energy resist"]=6; layer=1079902; objectType="16461, 16462";}; -- gargish leather leggings
	[GetStringFromTid(1020784)]={m="l";[L"physical resist"]=5;[L"fire resist"]=6;[L"cold resist"]=7;[L"poison resist"]=6;[L"energy resist"]=6; layer=1115375; objectType="16459, 16460";}; -- gargish leather kilt
	
	[GetStringFromTid(1095351)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6; layer=1079899; objectType="16479, 16480";}; -- gargish cloth arms
	[GetStringFromTid(1095353)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6; layer=1079904; objectType="16481, 16482";}; -- gargish cloth chest
	[GetStringFromTid(1095355)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6; layer=1115375; objectType="16483, 16484";}; -- gargish cloth kilt
	[GetStringFromTid(1095357)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6; layer=1079902; objectType="16485, 16486";}; -- gargish cloth leggings
	
	[GetStringFromTid(1095787)]={m="m";[L"physical resist"]=1;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3; layer=1079897; objectType="16915";}; -- gargish earrings
	[GetStringFromTid(1095784)] ={m="m";[L"physical resist"]=1;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3; layer=1079898; objectType="16912";}; -- L"gargish necklace"
	
	[GetStringFromTid(1098595)] ={m="m";[L"physical resist"]=1;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3; layer=1079898; objectType="19723";}; -- L"gargish amulet"
	[GetStringFromTid(1098594)] ={m="m";[L"physical resist"]=1;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3; layer=1079898; objectType="19723";}; -- L"gargish stone amulet"
	
	[GetStringFromTid(1113720)]={m="m";[L"physical resist"]=1;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3; layer=1079897;}; -- L"Dragon Jade Earrings"
	[GetStringFromTid(1113820)]={m="m";[L"physical resist"]=1;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3; layer=1079897;}; -- L"Obsidian Earrings"
	
	[GetStringFromTid(1113538)]={m="l";[L"physical resist"]=5;[L"fire resist"]=6;[L"cold resist"]=7;[L"poison resist"]=6;[L"energy resist"]=6; layer=1079899;}; -- L"Cast-Off Zombie Skin"
	[GetStringFromTid(1113819)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6; layer=1079904;}; -- L"Mantle Of The Fallen"
	[GetStringFromTid(1113865)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6; layer=1079899;}; -- L"Spined Bloodworm Bracers"
	[GetStringFromTid(1113540)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6; layer=1115375;}; -- L"Summoner's Kilt"
	
	[GetStringFromTid(1113721)] ={m="m";[L"physical resist"]=0;[L"fire resist"]=0;[L"cold resist"]=0;[L"poison resist"]=0;[L"energy resist"]=0; layer=1079898;}; -- L"Torc Of the Guardians"	
	
	[GetStringFromTid(1113539)]={m="m";[L"physical resist"]=8;[L"fire resist"]=6;[L"cold resist"]=5;[L"poison resist"]=6;[L"energy resist"]=5; layer=1079904;};  -- L"Breastplate Of The Berserker"
	[GetStringFromTid(1113537)]={m="m";[L"physical resist"]=6;[L"fire resist"]=6;[L"cold resist"]=4;[L"poison resist"]=8;[L"energy resist"]=6; layer=1079902;}; -- L"Giant Steps"
	[GetStringFromTid(1113868)]={m="m";[L"physical resist"]=8;[L"fire resist"]=6;[L"cold resist"]=5;[L"poison resist"]=6;[L"energy resist"]=5; layer=1115375;};  -- L"Void Infused Kilt"
}

ItemPropertiesEvaluator.MArmorNames = {
	
	[GetStringFromTid(1031118)]={m="m";[L"physical resist"]=1;[L"fire resist"]=5;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5}; -- L"circlet"
	[GetStringFromTid(1031119)]={m="m";[L"physical resist"]=1;[L"fire resist"]=5;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5}; -- royal circlet
	[GetStringFromTid(1031120)]={m="m";[L"physical resist"]=1;[L"fire resist"]=5;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5}; -- gemmed circlet
	
	[GetStringFromTid(1032229)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4}; -- leaf tunic
	[GetStringFromTid(1032230)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4}; -- leaf gloves
	[GetStringFromTid(1032231)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4}; -- leaf gorget
	[GetStringFromTid(1032232)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4}; -- leaf arms
	[GetStringFromTid(1032233)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4}; -- leaf leggings
	[GetStringFromTid(1032234)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4}; -- leaf tonlet
	
	[GetStringFromTid(1025061)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather sleeves
	[GetStringFromTid(1025062)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather gloves
	[GetStringFromTid(1025063)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather gorget
	[GetStringFromTid(1025064)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather sleeves
	[GetStringFromTid(1025065)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather leggings
	[GetStringFromTid(1025066)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather tunic
	[GetStringFromTid(1015295)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather cap
	[GetStringFromTid(1027168)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather shorts
	[GetStringFromTid(1027174)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- female leather armor
	[GetStringFromTid(1027176)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather skirt
	[GetStringFromTid(1027178)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather bustier
	
	[GetStringFromTid(1030102)]={m="l";[L"physical resist"]=4;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=2;[L"energy resist"]=3}; -- leather jingasa
	
	[GetStringFromTid(1030106)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather mempo
	[GetStringFromTid(1030107)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather do
	[GetStringFromTid(1030110)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather hiro sode
	[GetStringFromTid(1030118)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather suneate
	[GetStringFromTid(1030122)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather haidate
	
	[GetStringFromTid(1030126)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather ninja hood
	[GetStringFromTid(1030129)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather ninja pants
	[GetStringFromTid(1030130)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather ninja mitts
	[GetStringFromTid(1030131)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- leather ninja jacket
	
	[GetStringFromTid(1113762)]={m="m";[L"physical resist"]=1;[L"fire resist"]=5;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5}; -- L"Crown of Arcane Temperament"
	[GetStringFromTid(1061598)] ={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- L"Shadow Dancer Leggings"
	[GetStringFromTid(1061094)] ={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- L"Voice Of The Fallen King"
	[GetStringFromTid(1070690)] ={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- L"Gloves Of The Pugilist"
	
	[GetStringFromTid(1075037)] ={m="m";[L"physical resist"]=6;[L"fire resist"]=5;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=8}; -- L"Helm Of Swiftness"
	[GetStringFromTid(1075047)] ={m="m";[L"physical resist"]=1;[L"fire resist"]=5;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5}; -- L"Aegis Of Grace"
	[GetStringFromTid(1079525)] ={m="m";[L"physical resist"]=0;[L"fire resist"]=0;[L"cold resist"]=0;[L"poison resist"]=0;[L"energy resist"]=0}; -- L"Ankh Pendant"
	
	[GetStringFromTid(1070921)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- L"Arms Of Tactical Excellence"
	[GetStringFromTid(1070924)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- L"Gloves Of The Sun"
	[GetStringFromTid(1070970)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- L"Stormgrip"
	[GetStringFromTid(1114843)] ={m="m";[L"physical resist"]=0;[L"fire resist"]=0;[L"cold resist"]=0;[L"poison resist"]=0;[L"energy resist"]=0}; -- L"Lavaliere"
	[GetStringFromTid(1113761)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- L"Protector Of The Battle Mage"
	
	[GetStringFromTid(1116619)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- L"Leviathan Hide Bracers"
	[GetStringFromTid(1149957)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- L"Bronzed Armor Of The Valkyrie"
	[GetStringFromTid(1149960)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- L"Enchanted Kelp Woven Leggings"
	
	[GetStringFromTid(1072931)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4}; -- L"Song Woven Mantle"
	[GetStringFromTid(1072929)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4}; -- L"Spell Woven Britches"
	[GetStringFromTid(1072932)]={m="l";[L"physical resist"]=2;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=4;[L"energy resist"]=4}; -- L"Stitcher's Mittens"
	[GetStringFromTid(1072937)] ={m="m";[L"physical resist"]=0;[L"fire resist"]=0;[L"cold resist"]=0;[L"poison resist"]=0;[L"energy resist"]=0}; -- L"Pendant Of The Magi"
	[GetStringFromTid(1071460)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- L"Leurocian's Mempo Of Fortune"
	
	[GetStringFromTid(1073222)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- Leather Armor of the Britannia Royal Zoo
}

ItemPropertiesEvaluator.GargMArmorNames = {
		
	[GetStringFromTid(1020769)]={m="l";[L"physical resist"]=5;[L"fire resist"]=6;[L"cold resist"]=7;[L"poison resist"]=6;[L"energy resist"]=6}; -- gargish leather arms
	[GetStringFromTid(1020771)]={m="l";[L"physical resist"]=5;[L"fire resist"]=6;[L"cold resist"]=7;[L"poison resist"]=6;[L"energy resist"]=6}; -- gargish leather chest
	[GetStringFromTid(1020773)]={m="l";[L"physical resist"]=5;[L"fire resist"]=6;[L"cold resist"]=7;[L"poison resist"]=6;[L"energy resist"]=6}; -- gargish leather leggings
	[GetStringFromTid(1020784)]={m="l";[L"physical resist"]=5;[L"fire resist"]=6;[L"cold resist"]=7;[L"poison resist"]=6;[L"energy resist"]=6}; -- gargish leather kilt
	
	[GetStringFromTid(1095351)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6}; -- gargish cloth arms
	[GetStringFromTid(1095353)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6}; -- gargish cloth chest
	[GetStringFromTid(1095355)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6}; -- gargish cloth kilt
	[GetStringFromTid(1095357)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6}; -- gargish cloth leggings
	
	[GetStringFromTid(1095787)]={m="m";[L"physical resist"]=1;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3}; -- gargish earrings
	[GetStringFromTid(1113720)]={m="m";[L"physical resist"]=1;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3}; -- L"Dragon Jade Earrings"
	[GetStringFromTid(1113820)]={m="m";[L"physical resist"]=1;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3}; -- L"Obsidian Earrings"
	
	[GetStringFromTid(1113538)]={m="l";[L"physical resist"]=5;[L"fire resist"]=6;[L"cold resist"]=7;[L"poison resist"]=6;[L"energy resist"]=6}; -- L"Cast-Off Zombie Skin"
	[GetStringFromTid(1113819)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6}; -- L"Mantle Of The Fallen"
	[GetStringFromTid(1113865)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6}; -- L"Spined Bloodworm Bracers"
	[GetStringFromTid(1113540)]={m="c";[L"physical resist"]=5;[L"fire resist"]=7;[L"cold resist"]=6;[L"poison resist"]=6;[L"energy resist"]=6}; -- L"Summoner's Kilt"
	
	[GetStringFromTid(1113721)] ={m="m";[L"physical resist"]=0;[L"fire resist"]=0;[L"cold resist"]=0;[L"poison resist"]=0;[L"energy resist"]=0}; -- L"Torc Of the Guardians"
	
	[GetStringFromTid(1153536)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079902;}; -- Clockwork Leggings
}

ItemPropertiesEvaluator.NMArmorNames = {
	[GetStringFromTid(1031121)]={m="w";[L"physical resist"]=5;[L"fire resist"]=1;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5}; -- L"raven helm"
	[GetStringFromTid(1031122)]={m="w";[L"physical resist"]=5;[L"fire resist"]=1;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5}; -- L"vulture helm"
	[GetStringFromTid(1031123)]={m="w";[L"physical resist"]=5;[L"fire resist"]=1;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=5}; -- L"winged helm"
	
	[GetStringFromTid(1025130)]={m="m";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=3;[L"energy resist"]=2}; -- L"helmet"
	[GetStringFromTid(1025129)]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- L"closed helm"
	[GetStringFromTid(1025132)]={m="m";[L"physical resist"]=7;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=2}; -- L"bascinet"
	[GetStringFromTid(1025134)]={m="m";[L"physical resist"]=4;[L"fire resist"]=1;[L"cold resist"]=4;[L"poison resist"]=4;[L"energy resist"]=2}; -- L"norse helm"
	
	[GetStringFromTid(1027947)]={m="l";[L"physical resist"]=3;[L"fire resist"]=1;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=5}; -- orc helm
	
	[GetStringFromTid(1031124)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=3;[L"energy resist"]=2}; -- hide tunic
	[GetStringFromTid(1031125)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=3;[L"energy resist"]=2}; -- hide gloves
	[GetStringFromTid(1031126)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=3;[L"energy resist"]=2}; -- hide gorget
	[GetStringFromTid(1031127)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=3;[L"energy resist"]=2}; -- hide pauldrons
	[GetStringFromTid(1031128)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=3;[L"energy resist"]=2}; -- hide pants
	
	[GetStringFromTid(1031111)]={m="w";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- woodland chest
	[GetStringFromTid(1031113)]={m="w";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- woodland gorget
	[GetStringFromTid(1031114)]={m="w";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- woodland gauntlets
	[GetStringFromTid(1031115)]={m="w";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- woodland leggings
	[GetStringFromTid(1031116)]={m="w";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- woodland arms
	
	[GetStringFromTid(1073481)]={m="w";[L"physical resist"]=8;[L"fire resist"]=5;[L"cold resist"]=5;[L"poison resist"]=7;[L"energy resist"]=5}; -- Darkwood Crown
	[GetStringFromTid(1073482)]={m="w";[L"physical resist"]=8;[L"fire resist"]=5;[L"cold resist"]=5;[L"poison resist"]=7;[L"energy resist"]=5}; -- Darkwood Chest
	[GetStringFromTid(1073483)]={m="w";[L"physical resist"]=8;[L"fire resist"]=5;[L"cold resist"]=5;[L"poison resist"]=7;[L"energy resist"]=5}; -- Darkwood Gorget
	[GetStringFromTid(1073484)]={m="w";[L"physical resist"]=8;[L"fire resist"]=5;[L"cold resist"]=5;[L"poison resist"]=7;[L"energy resist"]=5}; -- Darkwood Leggings
	[GetStringFromTid(1073485)]={m="w";[L"physical resist"]=8;[L"fire resist"]=5;[L"cold resist"]=5;[L"poison resist"]=7;[L"energy resist"]=5}; -- Darkwood Pauldrons
	[GetStringFromTid(1073486)]={m="w";[L"physical resist"]=8;[L"fire resist"]=5;[L"cold resist"]=5;[L"poison resist"]=7;[L"energy resist"]=5}; -- Darkwood Gauntlets

	[GetStringFromTid(1025198)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4}; -- bone arms
	[GetStringFromTid(1025199)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4}; -- bone armor
	[GetStringFromTid(1025200)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4}; -- bone gloves
	[GetStringFromTid(1025201)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4}; -- bone helmet
	[GetStringFromTid(1025202)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4}; -- bone leggings
	
	[GetStringFromTid(1025076)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- studded sleeves
	[GetStringFromTid(1025077)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- studded gloves
	[GetStringFromTid(1025078)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- studded gorget
	[GetStringFromTid(1025080)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- studded leggings
	[GetStringFromTid(1025081)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- studded tunic
	[GetStringFromTid(1027170)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- studded armor
	[GetStringFromTid(1027180)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- studded bustier
	
	[GetStringFromTid(1025104)]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=1;[L"poison resist"]=5;[L"energy resist"]=3}; -- ringmail leggings
	[GetStringFromTid(1025095)]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=1;[L"poison resist"]=5;[L"energy resist"]=3}; -- ringmail armor
	[GetStringFromTid(1025097)]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=1;[L"poison resist"]=5;[L"energy resist"]=3}; -- ringmail sleeves
	[GetStringFromTid(1025099)]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=1;[L"poison resist"]=5;[L"energy resist"]=3}; -- ringmail gloves
	[GetStringFromTid(1025100)]={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=1;[L"poison resist"]=5;[L"energy resist"]=3}; -- ringmail tunic
	
	[GetStringFromTid(1025051)]={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2}; -- chainmail coif
	[GetStringFromTid(1025052)]={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2}; -- chainmail leggings
	[GetStringFromTid(1025053)]={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2}; -- chainmail tunic
	
	[GetStringFromTid(1015038)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- female plate
	[GetStringFromTid(1025136)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- platemail arms
	[GetStringFromTid(1025137)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- platemail legs
	[GetStringFromTid(1025138)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- plate helm
	[GetStringFromTid(1025139)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- platemail gorget
	[GetStringFromTid(1025140)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- platemail gloves
	[GetStringFromTid(1025141)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- platemail tunic
	[GetStringFromTid(1025143)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- platemail arms
	
	[GetStringFromTid(1030100)]={m="m";[L"physical resist"]=5;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=4}; -- chainmail hatsuburi
	[GetStringFromTid(1030101)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3}; -- platemail hatsuburi
	[GetStringFromTid(1030103)]={m="m";[L"physical resist"]=7;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=2}; -- heavy platemail jingasa
	[GetStringFromTid(1030104)]={m="m";[L"physical resist"]=6;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3}; -- decorative platemail kabuto
	[GetStringFromTid(1030113)]={m="m";[L"physical resist"]=7;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=2}; -- light platemail jingasa
	[GetStringFromTid(1030116)]={m="m";[L"physical resist"]=7;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=2}; -- small platemail jingasa
	[GetStringFromTid(1030117)]={m="m";[L"physical resist"]=6;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3}; -- platemail battle kabuto
	[GetStringFromTid(1030121)]={m="m";[L"physical resist"]=6;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3}; -- standard platemail kabuto
	
	[GetStringFromTid(1030105)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- platemail mempo
	[GetStringFromTid(1030109)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- platemail do
	[GetStringFromTid(1030112)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- platemail hiro sode
	[GetStringFromTid(1030120)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- platemail suneate
	[GetStringFromTid(1030125)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- platemail haidate
	
	[GetStringFromTid(1030141)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- studded mempo
	[GetStringFromTid(1030108)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- studded do
	[GetStringFromTid(1030111)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- studded hiro sode
	[GetStringFromTid(1030119)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- studded suneate
	[GetStringFromTid(1030123)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- studded haidate
	
	[GetStringFromTid(1061594)] ={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- L"Jackal's Collar"
	[GetStringFromTid(1061097)] ={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- L"Holy Knight's Breastplate"
	[GetStringFromTid(1061092)] ={m="m";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=1;[L"poison resist"]=5;[L"energy resist"]=3}; -- L"Gauntlets Of Nobility"
	[GetStringFromTid(1061093)] ={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4}; -- L"Midnight Bracers"
	[GetStringFromTid(1061095)] ={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4}; -- L"Ornate Crown Of The Harrower"
	[GetStringFromTid(1061096)] ={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- L"Helm Of Insight"
	[GetStringFromTid(1061098)] ={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- L"Armor Of Fortune"
	[GetStringFromTid(1061099)] ={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2}; -- L"Tunic Of Fire"
	[GetStringFromTid(1061100)] ={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2}; -- L"Leggings Of Bane"
	[GetStringFromTid(1060206)] ={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- The Inquisitor's Resolution
	[GetStringFromTid(1063471)] ={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- L"Violet Courage"
	[GetStringFromTid(1070817)] ={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- L"Heart Of The Lion"
	[GetStringFromTid(1027947)] ={m="l";[L"physical resist"]=3;[L"fire resist"]=1;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=5}; -- L"Orcish Visage"
	[GetStringFromTid(1075041)] ={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2}; -- L"Fey Leggings"
	
	[GetStringFromTid(1070926)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- L"Ancient Samurai Do"
	[GetStringFromTid(1070920)]={m="m";[L"physical resist"]=6;[L"fire resist"]=2;[L"cold resist"]=2;[L"poison resist"]=2;[L"energy resist"]=3}; -- L"Daimyo's Helm"
	[GetStringFromTid(1070923)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- L"Legs Of Stability"
	[GetStringFromTid(1070968)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- L"Rune Beetle Carapace"
	
	[GetStringFromTid(1113760)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- L"Animated Legs Of The Insane Tinker"
	[GetStringFromTid(1115444)]={m="s";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- L"Basilisk Hide Breastplate"
	
	[GetStringFromTid(1025134)]={m="m";[L"physical resist"]=4;[L"fire resist"]=1;[L"cold resist"]=4;[L"poison resist"]=4;[L"energy resist"]=2}; -- L"Helm Of Vengeance"
	
	[GetStringFromTid(1073257)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- Minax's Armor - Museum of Vesper Replica
	
	[GetStringFromTid(1073264)]={m="m";[L"physical resist"]=4;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=1;[L"energy resist"]=2}; -- Keeonean's Chain Mail - Museum of Vesper Replica
	
	[GetStringFromTid(1073223)]={m="l";[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=4}; -- Studded Armor of the Britannia Royal Zoo
	[GetStringFromTid(1073224)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- Platemail Armor of the Britannia Royal Zoo
	
	[GetStringFromTid(1094902)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- Gauntlets of Anger [Replica]
	[GetStringFromTid(1094914)]={m="l";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=4;[L"poison resist"]=2;[L"energy resist"]=4}; -- Shroud of Deceit [Replica]
	[GetStringFromTid(1094917)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2}; -- Gladiator's Collar [Replica]
	[GetStringFromTid(1094924)]={m="l";[L"physical resist"]=3;[L"fire resist"]=1;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=5}; -- Orc Chieftain Helm [Replica]
	
	[GetStringFromTid(1075191)] ={m="l";[L"physical resist"]=8;[L"fire resist"]=11;[L"cold resist"]=6;[L"poison resist"]=8;[L"energy resist"]=7}; -- Arms of compassion
	[GetStringFromTid(1075189)] ={m="l";[L"physical resist"]=7;[L"fire resist"]=7;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=7}; -- gorget of honesty
	[GetStringFromTid(1075190)] ={m="l";[L"physical resist"]=10;[L"fire resist"]=7;[L"cold resist"]=8;[L"poison resist"]=7;[L"energy resist"]=8}; -- Breastplate of Justice
	[GetStringFromTid(1075238)] ={m="l";[L"physical resist"]=8;[L"fire resist"]=11;[L"cold resist"]=6;[L"poison resist"]=8;[L"energy resist"]=7}; -- Gauntlets of Valor
	[GetStringFromTid(1075237)] ={m="l";[L"physical resist"]=8;[L"fire resist"]=8;[L"cold resist"]=7;[L"poison resist"]=9;[L"energy resist"]=8}; -- Helm of Spirituality
	[GetStringFromTid(1075237)] ={m="l";[L"physical resist"]=8;[L"fire resist"]=7;[L"cold resist"]=10;[L"poison resist"]=7;[L"energy resist"]=8}; -- Legs of Honor
	
	[GetStringFromTid(1153536)]={m="m";[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=2;[L"poison resist"]=3;[L"energy resist"]=2; layer=1079902;}; -- Clockwork Leggings
}
ItemPropertiesEvaluator.DragonArmorNames = {
	[GetStringFromTid(1029793)]={m="s";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- dragon breastplate
	[GetStringFromTid(1029795)]={m="s";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- dragon gloves
	[GetStringFromTid(1029797)]={m="s";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- dragon helm
	[GetStringFromTid(1029799)]={m="s";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- dragon leggings
	[GetStringFromTid(1029815)]={m="s";[L"physical resist"]=3;[L"fire resist"]=3;[L"cold resist"]=3;[L"poison resist"]=3;[L"energy resist"]=3}; -- dragon sleeves
}

ItemPropertiesEvaluator.GargNMArmorNames = {
	[GetStringFromTid(1020775)]={m="m";[L"physical resist"]=8;[L"fire resist"]=6;[L"cold resist"]=5;[L"poison resist"]=6;[L"energy resist"]=5}; -- gargish platemail arms
	[GetStringFromTid(1020777)]={m="m";[L"physical resist"]=8;[L"fire resist"]=6;[L"cold resist"]=5;[L"poison resist"]=6;[L"energy resist"]=5};  -- gargish platemail chest
	[GetStringFromTid(1020779)]={m="m";[L"physical resist"]=8;[L"fire resist"]=6;[L"cold resist"]=5;[L"poison resist"]=6;[L"energy resist"]=5};  -- gargish platemail kilt
	[GetStringFromTid(1020781)]={m="m";[L"physical resist"]=8;[L"fire resist"]=6;[L"cold resist"]=5;[L"poison resist"]=6;[L"energy resist"]=5};  -- gargish platemail leggings
	
	[GetStringFromTid(1095343)]={m="m";[L"physical resist"]=6;[L"fire resist"]=6;[L"cold resist"]=8;[L"poison resist"]=4;[L"energy resist"]=6}; -- gargish stone arms
	[GetStringFromTid(1095345)]={m="m";[L"physical resist"]=6;[L"fire resist"]=6;[L"cold resist"]=8;[L"poison resist"]=4;[L"energy resist"]=6}; -- gargish stone chest
	[GetStringFromTid(1095347)]={m="m";[L"physical resist"]=6;[L"fire resist"]=6;[L"cold resist"]=8;[L"poison resist"]=4;[L"energy resist"]=6}; -- gargish stone kilt
	[GetStringFromTid(1095349)]={m="m";[L"physical resist"]=6;[L"fire resist"]=6;[L"cold resist"]=8;[L"poison resist"]=4;[L"energy resist"]=6}; -- gargish stone leggings
	
	[GetStringFromTid(1113539)]={m="m";[L"physical resist"]=8;[L"fire resist"]=6;[L"cold resist"]=5;[L"poison resist"]=6;[L"energy resist"]=5};  -- L"Breastplate Of The Berserker"
	[GetStringFromTid(1113537)]={m="m";[L"physical resist"]=6;[L"fire resist"]=6;[L"cold resist"]=4;[L"poison resist"]=8;[L"energy resist"]=6}; -- L"Giant Steps"
	[GetStringFromTid(1113868)]={m="m";[L"physical resist"]=8;[L"fire resist"]=6;[L"cold resist"]=5;[L"poison resist"]=6;[L"energy resist"]=5};  -- L"Void Infused Kilt"
}

ItemPropertiesEvaluator.ShieldNames = {
	[GetStringFromTid(1027033)]={m="m";[L"energy resist"]=1; objectType="7032, 7033";}; -- tear kite shield
	[GetStringFromTid(1095768)]={m="m";[L"energy resist"]=1; objectType="16897, 16902";}; -- gargish kite shield
	[GetStringFromTid(1095769)]={m="m";[L"energy resist"]=1; objectType="16896, 16903";}; -- gargish wooden shield
	[GetStringFromTid(1027027)]={m="m";[L"cold resist"]=1; objectType="7027";}; -- buckler 
	[GetStringFromTid(1095773)]={m="m";[L"cold resist"]=1; objectType="16901, 16907";}; -- large stone shield
	[GetStringFromTid(1027034)]={m="w";[L"energy resist"]=1; objectType="7034";}; -- wooden shield
	[GetStringFromTid(1027026)]={m="m";[L"poison resist"]=1; objectType="7026";}; -- bronze shield
	[GetStringFromTid(1095778)]={m="m";[L"poison resist"]=1; objectType="16898";}; -- small plate shield
	[GetStringFromTid(1027028)]={m="m";[L"energy resist"]=1; objectType="7028, 7029";}; -- metal kite shield
	[GetStringFromTid(1027030)]={m="m";[L"fire resist"]=1; objectType="7030, 7031";}; -- heater shield
	[GetStringFromTid(1095772)]={m="m";[L"fire resist"]=1; objectType="16900, 16904";}; -- large plate shield
	[GetStringFromTid(1095771)]={m="m";[L"fire resist"]=1; objectType="16899, 16905";}; -- medium plate shield
	[GetStringFromTid(1027035)]={m="m";[L"fire resist"]=1; objectType="7035";}; -- metal shield
	[ItemPropertiesEvaluator.orderShield]={m="m";[L"physical resist"]=1; objectType="7108, 7109";}; -- Order shield
	[ItemPropertiesEvaluator.chaosShield]={m="m";[L"physical resist"]=1; objectType="7107";}; -- Chaos shield
	[wstring.lower(GetStringFromTid(1095810))]={m="m";[L"physical resist"]=1; objectType="16938, 16940";}; -- gargish order shield
	[wstring.lower(GetStringFromTid(1095809))]={m="m";[L"physical resist"]=1; objectType="16936, 16937";}; -- gargish chaos shield
	
	[GetStringFromTid(1061602)] ={m="m";[L"fire resist"]=1;}; -- L"Ægis"
	[GetStringFromTid(1061101)] ={m="m";[L"energy resist"]=1}; -- L"Arcane Shield"
	[GetStringFromTid(1070693)] ={m="m";[L"physical resist"]=1;}; -- L"Shield Of Invulnerability"
	[GetStringFromTid(1079792)] ={m="m";[L"physical resist"]=1;}; -- L"Sentinel's Guard"
	[GetStringFromTid(1079793)] ={m="m";[L"physical resist"]=1;}; -- L"Lord Blackthorn's Exemplar"
	[GetStringFromTid(1150357)]={m="m";[L"poison resist"]=1;}; -- Resonant Shield of Vengeance
	[GetStringFromTid(1116232)]={m="m";[L"poison resist"]=1;}; -- Surge Shield
	[GetStringFromTid(1113534)] ={m="m";[L"physical resist"]=1;}; -- L"Sign Of Order"
	[GetStringFromTid(1113535)] ={m="m";[L"physical resist"]=1;}; -- L"Sign Of Chaos"
	[GetStringFromTid(1113532)]={m="m";[L"energy resist"]=1}; -- L"Dragon Hide Shield"
	[GetStringFromTid(1112361)]={m="m";[L"energy resist"]=1}; -- L"boura tail"
	[GetStringFromTid(1113722)]={m="m";[L"fire resist"]=1;}; -- Wall of Hungry Mouths
	[GetStringFromTid(1113851)]={m="m";[L"fire resist"]=1;}; -- L"Defender Of The Magus"
	[GetStringFromTid(1113536)]={m="m";[L"poison resist"]=1;}; -- Mystic's Guard
	[GetStringFromTid(1113533)]={m="m";[L"cold resist"]=1;}; -- L"Pillar Of Strength"
	
	[GetStringFromTid(1073258)]={m="m";[L"physical resist"]=1;}; -- Order Shield - Museum of Vesper Replica
	[GetStringFromTid(1073259)]={m="m";[L"physical resist"]=1;}; -- Chaos Shield - Museum of Vesper Replica
	
	[GetStringFromTid(1112399)]={m="m";[L"fire resist"]=1;}; -- Light's Rampart [Replica]
	[GetStringFromTid(1112405)]={m="m";[L"energy resist"]=1}; -- Tongue of the Beast [Replica]
	
	[GetStringFromTid(1152722)]={m="m";[L"energy resist"]=1}; -- Hephaestus
	[GetStringFromTid(1079792)]={m="m";[L"energy resist"]=1}; -- L"Sentinel's Guard"
	[GetStringFromTid(1079793)]={m="m";[L"energy resist"]=1}; -- L"Lord Blackthorn's Exemplar"
}

ItemPropertiesEvaluator.HatNames = {
	[GetStringFromTid(1025445)]={[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=8;[L"poison resist"]=4;[L"energy resist"]=4; objectType="5445, 5446";}; -- bear mask
	[GetStringFromTid(1025447)]={[L"physical resist"]=2;[L"fire resist"]=6;[L"cold resist"]=8;[L"poison resist"]=1;[L"energy resist"]=7; objectType="5447, 5448";}; -- deer mask
	[GetStringFromTid(1025147)]={[L"physical resist"]=1;[L"fire resist"]=1;[L"cold resist"]=7;[L"poison resist"]=7;[L"energy resist"]=8; objectType="5147, 5148";}; -- L"orc mask" 
	[GetStringFromTid(1025449)]={[L"physical resist"]=6;[L"fire resist"]=9;[L"cold resist"]=6;[L"poison resist"]=10;[L"energy resist"]=5; objectType="5449, 5450, 5451, 5452";}; -- this one is the max from both tribal mask
	[GetStringFromTid(1015257)]={[L"physical resist"]=0;[L"fire resist"]=3;[L"cold resist"]=5;[L"poison resist"]=8;[L"energy resist"]=8; objectType="5443, 5444";}; -- skullcap
	[GetStringFromTid(1015258)]={[L"physical resist"]=0;[L"fire resist"]=3;[L"cold resist"]=5;[L"poison resist"]=8;[L"energy resist"]=8; objectType="5439, 5440";}; -- bandana
	[GetStringFromTid(1015259)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5; objectType="5907";}; -- floppy hat
	[GetStringFromTid(1015260)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5; objectType="5908";}; -- wide-brim hat
	[GetStringFromTid(1015263)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5; objectType="5911";}; -- straw hat
	[GetStringFromTid(1015262)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5; objectType="5910";}; -- tall straw hat
	[GetStringFromTid(1015264)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5; objectType="5912";}; -- wizard's hat
	[GetStringFromTid(1015265)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5; objectType="5913";}; -- bonnet
	[GetStringFromTid(1011380)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5; objectType="5909";}; -- cap
	[GetStringFromTid(1015266)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5; objectType="5914";}; -- feathered hat
	[GetStringFromTid(1025915)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5; objectType="5915";}; -- tricorne hat
	[GetStringFromTid(1025916)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5; objectType="5916";}; -- jester hat
	[GetStringFromTid(1028965)]={[L"physical resist"]=0;[L"fire resist"]=3;[L"cold resist"]=5;[L"poison resist"]=8;[L"energy resist"]=8; objectType="8965, 8966";}; -- flower garland
	[GetStringFromTid(1030127)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5; objectType="10127";}; -- L"cloth ninja hood"
	[GetStringFromTid(1030136)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5; objectType="10136";}; -- kasa
	[GetStringFromTid(1032216)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2; objectType="12216, 17988";}; -- elven glasses
	
	[GetStringFromTid(1061599)] ={[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=8;[L"poison resist"]=4;[L"energy resist"]=4}; -- L"Spirit Of The Totem"
	[GetStringFromTid(1061597)] ={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5}; -- L"Hat Of The Magi"
	[GetStringFromTid(1061595)] ={[L"physical resist"]=2;[L"fire resist"]=6;[L"cold resist"]=8;[L"poison resist"]=1;[L"energy resist"]=7}; -- L"Hunter's Headdress"
	[GetStringFromTid(1061289)] ={[L"physical resist"]=6;[L"fire resist"]=9;[L"cold resist"]=6;[L"poison resist"]=10;[L"energy resist"]=5}; -- L"Divine Countenance"
	[GetStringFromTid(1063467)] ={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5}; -- L"Dread Pirate Hat"
	[GetStringFromTid(1070637)] ={[L"physical resist"]=5;[L"fire resist"]=3;[L"cold resist"]=8;[L"poison resist"]=4;[L"energy resist"]=4}; -- L"Polar Bear Mask"
	[GetStringFromTid(1063473)] ={[L"physical resist"]=0;[L"fire resist"]=3;[L"cold resist"]=5;[L"poison resist"]=8;[L"energy resist"]=8}; -- L"Burglar's Bandana"
	
	[GetStringFromTid(1063473)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=4;[L"poison resist"]=3;[L"energy resist"]=2}; -- L"Brightsight Lenses"
	[GetStringFromTid(1072125)] ={[L"physical resist"]=6;[L"fire resist"]=9;[L"cold resist"]=6;[L"poison resist"]=10;[L"energy resist"]=5}; -- L"Mark Of Travesty"
	[GetStringFromTid(1070922)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5}; -- L"Ancient Farmer's Kasa"
	[GetStringFromTid(1070919)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5}; -- L"Black Lotus Hood"
	[GetStringFromTid(1070969)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5}; -- L"Kasa Of The Raj-In"
	
	[GetStringFromTid(1114785)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- L"Night Eyes"
	
	[GetStringFromTid(1073254)]={[L"physical resist"]=0;[L"fire resist"]=3;[L"cold resist"]=5;[L"poison resist"]=8;[L"energy resist"]=8}; -- Gypsy Headdress - Museum of Vesper Replica
	[GetStringFromTid(1073255)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5}; -- Nystul's Wizard's Hat - Museum of Vesper Replica
	[GetStringFromTid(1073256)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5}; -- Jester Hat of Chuckles - Museum of Vesper Replica
	
	[GetStringFromTid(1073362)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- Reading Glasses of the Trades
	[GetStringFromTid(1073363)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- Reading Glasses of the Arts
	[GetStringFromTid(1073364)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- Maritime Reading Glasses
	[GetStringFromTid(1073373)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- Treasures and Trinkets Reading Glasses
	[GetStringFromTid(1073374)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- Wizard's Crystal Reading Glasses
	[GetStringFromTid(1073376)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- Poisoned Reading Glasses
	[GetStringFromTid(1073377)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- Necromantic Reading Glasses
	[GetStringFromTid(1073378)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- Light of Way Reading Glasses
	[GetStringFromTid(1073379)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- Anthropomorphist Reading Glasses
	[GetStringFromTid(1073380)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- Folded Steel Reading Glasses
	[GetStringFromTid(1073381)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- Mace and Shield Reading Glasses
	[GetStringFromTid(1073382)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- Lyrical Reading Glasses
	[GetStringFromTid(1152716)] ={[L"physical resist"]=2;[L"fire resist"]=4;[L"cold resist"]=3;[L"poison resist"]=4;[L"energy resist"]=2}; -- Prismatic Lenses 
	
	[GetStringFromTid(1094903)]={[L"physical resist"]=0;[L"fire resist"]=3;[L"cold resist"]=5;[L"poison resist"]=8;[L"energy resist"]=8}; -- Crown of Tal'Keesh [Replica]
	[GetStringFromTid(1094911)]={[L"physical resist"]=0;[L"fire resist"]=5;[L"cold resist"]=9;[L"poison resist"]=5;[L"energy resist"]=5}; -- Captain John's Hat [Replica]
}

ItemPropertiesEvaluator.Enhancements = {}	
ItemPropertiesEvaluator.Enhancements[ItemPropertiesEvaluator.TYPE_ARMOR] = {
	[ItemPropertiesEvaluator.MATERIAL_METAL] = {
		{en = GetStringFromTid(1018332); q = 1.02; p = {wstring.gsub(GetStringFromTid(1060435), ItemPropertiesEvaluator.escape0Tris, L"");}; b = 20;}; -- Dull Copper
		{en = GetStringFromTid(1018333); q = 1.03}; -- L"Shadow Iron"
		{en = GetStringFromTid(1018334); q = 1.04}; -- L"Copper"
		{en = GetStringFromTid(1018335); q = 1.05}; -- L"Bronze"
		{en = GetStringFromTid(1018336); q = 1.07; p = {wstring.gsub(GetStringFromTid(1060435), ItemPropertiesEvaluator.escape0Tris, L"");wstring.gsub(GetStringFromTid(1060436), ItemPropertiesEvaluator.escape2, L"");}; b = 70;}; -- L"Gold"
		{en = GetStringFromTid(1018337); q = 1.09}; -- L"Agapite"
		{en = GetStringFromTid(1018338); q = 1.12}; -- L"Verite"
		{en = GetStringFromTid(1018339); q = 1.20}; -- L"Valorite"
		};
	[ItemPropertiesEvaluator.MATERIAL_LEATHER] = {
		{en = GetStringFromTid(1049354); q=1.01}; -- L"Spined Leather"
		{en = GetStringFromTid(1049355); q=1.02}; -- L"Horned Leather"
		{en = GetStringFromTid(1049356); q=1.04}; -- L"Barbed Leather"
		};
	[ItemPropertiesEvaluator.MATERIAL_WOOD] = {
		{en = GetStringFromTid(1071428); q = 1.01; p = {wstring.gsub(GetStringFromTid(1060436), ItemPropertiesEvaluator.escape2, L"");}; b = 40}; -- L"Oak"
		{en = GetStringFromTid(1071429); q = 1.03; p = {wstring.gsub(GetStringFromTid(1060435), ItemPropertiesEvaluator.escape0Tris, L"");}; b = 20;}; -- L"Ash"
		{en = GetStringFromTid(1071430); q = 1.07; p = {wstring.gsub(GetStringFromTid(1060444), ItemPropertiesEvaluator.escape2, L"");}; b = 50;}; -- L"Yew"
		{en = GetStringFromTid(1071431); q = 1.10; p = {wstring.gsub(GetStringFromTid(1060444), ItemPropertiesEvaluator.escape2, L"");}; b = 100;}; -- L"Bloodwood"
		{en = GetStringFromTid(1071433); q = 1.20}; -- L"Frostwood"
		{en = GetStringFromTid(1071432); q = 1.15; p = {L"dummy"}; b = 100}	 --L"Heartwood?"
		};
	}

ItemPropertiesEvaluator.Enhancements[ItemPropertiesEvaluator.TYPE_SHIELD] = {
	[ItemPropertiesEvaluator.MATERIAL_METAL] = {
		{en = GetStringFromTid(1018332); q = 1.02; p = {wstring.gsub(GetStringFromTid(1060435), ItemPropertiesEvaluator.escape0Tris, L"");}; b = 20;}; -- L"Dull Copper"
		{en = GetStringFromTid(1018333); q = 1.03}; -- L"Shadow Iron"
		{en = GetStringFromTid(1018334); q = 1.04}; -- L"Copper"
		{en = GetStringFromTid(1018335); q = 1.05}; -- L"Bronze"
		{en = GetStringFromTid(1018336); q = 1.07; p = {wstring.gsub(GetStringFromTid(1060435), ItemPropertiesEvaluator.escape0Tris, L"");wstring.gsub(GetStringFromTid(1060436), ItemPropertiesEvaluator.escape2, L"");}; b = 70;}; -- L"Gold"
		{en = GetStringFromTid(1018337); q = 1.09}; -- L"Agapite"
		{en = GetStringFromTid(1018338); q = 1.12}; -- L"Verite"
		{en = GetStringFromTid(1018339); q = 1.20}; -- L"Valorite"
		};
	[ItemPropertiesEvaluator.MATERIAL_WOOD] = {
		{en = GetStringFromTid(1071428); q = 1.01;}; -- L"Oak"
		{en = GetStringFromTid(1071429); q = 1.03; p = {wstring.gsub(GetStringFromTid(1060435), ItemPropertiesEvaluator.escape0Tris, L"");}; b = 20;}; -- L"Ash"
		{en = GetStringFromTid(1071430); q = 1.07; p = {wstring.gsub(GetStringFromTid(1060444), ItemPropertiesEvaluator.escape2, L"");}; b = 50;};  -- L"Yew"
		{en = GetStringFromTid(1071431); q = 1.10; p = {wstring.gsub(GetStringFromTid(1060444), ItemPropertiesEvaluator.escape2, L"");wstring.gsub(GetStringFromTid(1060436), ItemPropertiesEvaluator.escape2, L"")}; b = 140;}; -- L"Bloodwood"
		{en = GetStringFromTid(1071433); q = 1.20; p = {GetStringFromTid(1060482);}; b = 100}; -- L"Frostwood"
		{en = GetStringFromTid(1071432); q = 1.15; p = {L"dummy"}; b = 100}	  -- L"Heartwood?"
		};
	}

ItemPropertiesEvaluator.Enhancements[ItemPropertiesEvaluator.TYPE_WEAPON] = {
	[ItemPropertiesEvaluator.MATERIAL_METAL] = {
		{en = GetStringFromTid(1018332); q = 1.02; p = {wstring.gsub(GetStringFromTid(1060435), ItemPropertiesEvaluator.escape0Tris, L"");}; b = 20;}; -- L"Dull Copper"
		{en = GetStringFromTid(1018333); q = 1.03}; -- L"Shadow Iron"
		{en = GetStringFromTid(1018334); q = 1.04}; -- L"Copper"
		{en = GetStringFromTid(1018335); q = 1.05}; -- L"Bronze"
		{en = GetStringFromTid(1018336); q = 1.07; p = {wstring.gsub(GetStringFromTid(1060435), ItemPropertiesEvaluator.escape0Tris, L"");wstring.gsub(GetStringFromTid(1060436), ItemPropertiesEvaluator.escape2, L"");}; b = 70;}; -- L"Gold"
		{en = GetStringFromTid(1018337); q = 1.09}; -- L"Agapite"
		{en = GetStringFromTid(1018338); q = 1.12}; -- L"Verite"
		{en = GetStringFromTid(1018339); q = 1.20}; -- L"Valorite"
		};
	[ItemPropertiesEvaluator.MATERIAL_WOOD] = {
		{en = GetStringFromTid(1071428); q = 1.01; p = {wstring.gsub(GetStringFromTid(1060436), ItemPropertiesEvaluator.escape2, L"");L"damage increase"}; b = 50}; -- L"Oak"
		{en = GetStringFromTid(1071429); q = 1.03; p = {wstring.gsub(GetStringFromTid(1060435), ItemPropertiesEvaluator.escape0Tris, L"");L"swing speed increase";}; b = 53.333;}; -- L"Ash"
		{en = GetStringFromTid(1071430); q = 1.07; p = {wstring.gsub(GetStringFromTid(1060415), ItemPropertiesEvaluator.escape0Bis, L"");L"damage increase";}; b = 53.333;};  -- L"Yew"
		{en = GetStringFromTid(1071431); q = 1.10; p = {wstring.gsub(GetStringFromTid(1060444), ItemPropertiesEvaluator.escape2, L"");wstring.gsub(GetStringFromTid(1060422), ItemPropertiesEvaluator.escape, L"")}; b = 132;}; -- L"Bloodwood"
		{en = GetStringFromTid(1071433); q = 1.20; p = {L"damage increase";}; b = 24}; -- L"Frostwood"
		{en = GetStringFromTid(1071432); q = 1.15; p = {L"dummy"}; b = 50}	 -- L"Heartwood?"
		};
	}
ItemPropertiesEvaluator.MaterialBonus = {
[L"spined"] = 1.01,
[L"horned"] = 1.02,
[L"barbed"] = 1.04,
[L"dull copper"] = 1.02,
[L"shadow iron"] = 1.03,
[L"copper"] = 1.04,
[L"bronze"] = 1.05,
[L"golden"] = 1.07,
[L"agapite"] = 1.09,
[L"verite"] = 1.21,
[L"valorite"] = 1.20,
[L"oak"] = 1.01,
[L"ash"] = 1.03,
[L"yew"] = 1.07,
[L"heartwood"] = 1.10,
[L"bloodwood"] = 1.15,
[L"frostwood"] = 1.20,
[L"scales"] = 1.03,
}


-- mods should have a range and a weight to judge their value
ItemPropertiesEvaluator.Mods = {
-- resists
	[wstring.gsub(GetStringFromTid(1060448), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"physical resist"; materials="Magical Residue|Diamond|Boura Pelt"; intensity = 0; range = 15; weight = 1; func = "RESIST";}; -- 
	[wstring.gsub(GetStringFromTid(1060447), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"fire resist"; materials="Magical Residue|Ruby|Boura Pelt";  intensity = 0; range = 15; weight = 1;func = "RESIST"; }; -- 
	[wstring.gsub(GetStringFromTid(1060445), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"cold resist"; materials="Magical Residue|Sapphire|Boura Pelt"; intensity = 0; range = 15; weight = 1; func = "RESIST";}; -- 
	[wstring.gsub(GetStringFromTid(1060449), ItemPropertiesEvaluator.escape, L"")] =		{iw=1;  en = L"poison resist"; materials="Magical Residue|Emerald|Boura Pelt"; intensity = 0; range = 15; weight = 1; func = "RESIST";}; -- 
	[wstring.gsub(GetStringFromTid(1060446), ItemPropertiesEvaluator.escape, L"")] =		{iw=1;  en = L"energy resist"; materials="Magical Residue|Amethyst|Boura Pelt"; intensity = 0; range = 15; weight = 1; func = "RESIST";}; -- 
-- damage types
	[wstring.gsub(GetStringFromTid(1060405), ItemPropertiesEvaluator.escape, L"")] =		{iw=0; type = ItemPropertiesEvaluator.TYPE_SKIP;  en = L"fire damage"; intensity = 0; range = 100; weight = 0;}; --
--	[L"physical damage"] = {intensity = 0; range = 100; weight = 0;};
	[wstring.gsub(GetStringFromTid(1060406), ItemPropertiesEvaluator.escape, L"")] =		{iw=0; type = ItemPropertiesEvaluator.TYPE_SKIP;  en = L"poison damage"; intensity = 0; range = 100; weight = 0; groups = {"POISON_ONLY"}}; 
	[wstring.gsub(GetStringFromTid(1060404), ItemPropertiesEvaluator.escape, L"")] =		{iw=0; type = ItemPropertiesEvaluator.TYPE_SKIP;  en = L"cold damage"; intensity = 0; range = 100; weight = 0;}; --
	[wstring.gsub(GetStringFromTid(1060407), ItemPropertiesEvaluator.escape, L"")] =		{iw=0; type = ItemPropertiesEvaluator.TYPE_SKIP;  en = L"energy damage"; intensity = 0; range = 100; weight = 0;}; --
	[wstring.gsub(GetStringFromTid(1072846), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; type = ItemPropertiesEvaluator.TYPE_SKIP;  en = L"chaos damage"; intensity = 0; range = 100; weight = 0; }; --
	[wstring.lower(GetStringFromTid(1150018))] =											{iw=1; en = L"focused"; intensity = 0; range = ""; weight = 0;};
-- stat bonuses
	[wstring.gsub(GetStringFromTid(1060485), ItemPropertiesEvaluator.escape2, L"")] =		{iw=1; en = L"strength bonus"; materials="Enchanted Essence|Diamond|Fire Ruby"; intensity = 0; range = 8; weight = 1.1; };
	[wstring.gsub(GetStringFromTid(1060409), ItemPropertiesEvaluator.escape2, L"")] =		{iw=1; en = L"dexterity bonus"; materials="Enchanted Essence|Ruby|Blue Diamond"; intensity = 0; range = 8; weight = 1.1; };
	[wstring.gsub(GetStringFromTid(1060432), ItemPropertiesEvaluator.escape2, L"")] =		{iw=1; en = L"intelligence bonus";  materials="Enchanted Essence|Tourmaline|Turquoise"; intensity = 0; range = 8; weight = 1.1; };
	[wstring.gsub(GetStringFromTid(1060431), ItemPropertiesEvaluator.escape2bis, L"")] =	{iw=1; en = L"hit point increase";  materials="Enchanted Essence|Ruby|Luminescent Fungi"; intensity = 0; range = 5; weight = 1.1; };
	[wstring.gsub(GetStringFromTid(1060484), ItemPropertiesEvaluator.escape2bis, L"")] =	{iw=1; en = L"stamina increase"; materials="Enchanted Essence|Diamond|Luminescent Fungi"; intensity = 0; range = 8; weight = 1.1;};
	[wstring.gsub(GetStringFromTid(1060439), ItemPropertiesEvaluator.escape2bis, L"")] =	{iw=1; en = L"mana increase"; materials="Enchanted Essence|Sapphire|Luminescent Fungi"; intensity = 0; range = 8; weight = 1.1;};
-- regen
	[wstring.gsub(GetStringFromTid(1060443), ItemPropertiesEvaluator.escape2, L"")] =		{iw=1; en = L"stamina regeneration"; materials="Enchanted Essence|Diamond|Seed of Renewal"; intensity = 0; range = 3; weight = 1;};
	[wstring.gsub(GetStringFromTid(1060440), ItemPropertiesEvaluator.escape2, L"")] =		{iw=1; en = L"mana regeneration"; materials="Enchanted Essence|Sapphire|Seed of Renewal"; intensity = 0; range = 2; weight = 1; };
	[wstring.gsub(GetStringFromTid(1060444), ItemPropertiesEvaluator.escape2, L"")] =		{iw=1; en = L"hit point regeneration"; materials="Enchanted Essence|Tourmaline|Seed of Renewal"; intensity = 0; range = 2; weight = 1; };
-- leeches
	[wstring.gsub(GetStringFromTid(1060422), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit life leech"; materials="Magical Residue|Ruby|Void Orb"; intensity = 0; range = 100; weight = 1.1; func="LEECH_RANGE"; }; -- "LEECH"; "SWING_LEECH"; "LEECH_EFFECT"
	[wstring.gsub(GetStringFromTid(1060427), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit mana leech"; materials="Magical Residue|Sapphire|Void Orb"; intensity = 0; range = 100; weight = 1.1; func="LEECH_RANGE"; };
	[wstring.gsub(GetStringFromTid(1060430), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit stamina leech"; materials="Magical Residue|Diamond|Void Orb"; intensity = 0; range = 50; weight = 1;};
-- hit effects
	[wstring.gsub(GetStringFromTid(1060424), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit lower attack"; materials="Enchanted Essence|Emerald|Parasitic Plant"; intensity = 0; range = 50; weight = 1.1; };
	[wstring.gsub(GetStringFromTid(1060425), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit lower defense"; materials="Enchanted Essence|Tourmaline|Parasitic Plant"; intensity = 0; range = 50; weight = 1.3; };
	
	[wstring.gsub(GetStringFromTid(1060417), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit dispel"; materials="Magical Residue|Amber|Slith Tongue"; intensity = 0; range = 50; weight = 1;}; -- "LEECH_EFFECT"
	
	[wstring.gsub(GetStringFromTid(1060420), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit fireball"; materials="Enchanted Essence|Ruby|Fire Ruby"; intensity = 0; range = 50; weight = 1.4; }; -- "SWING_EFFECT"; "LEECH_EFFECT";
	[wstring.gsub(GetStringFromTid(1060421), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit harm";  materials="Enchanted Essence|Emerald|Parasitic Plant"; intensity = 0; range = 50; weight = 1.1; }; -- "SWING_EFFECT"; "LEECH_EFFECT";
	[wstring.gsub(GetStringFromTid(1060423), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit lightning"; materials="Relic Fragment|Amethyst|Essence of Passion"; intensity = 0; range = 50; weight = 1.4; }; -- "SWING_EFFECT"; "LEECH_EFFECT";
	[wstring.gsub(GetStringFromTid(1060426), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit magic arrow";  materials="Relic Fragment|Amber|Essence of Feeling"; intensity = 0; range = 50; weight = 1.2; }; -- "SWING_EFFECT";
	[wstring.gsub(wstring.lower(GetStringFromTid(1072793)), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"velocity";  materials="Relic Fragment|Tourmaline|Essence of Direction";  intensity = 0; range = 50; weight = 1.3; }; -- "SWING_EFFECT";
	[wstring.gsub(wstring.lower(GetStringFromTid(1113699)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"hit mana drain"; intensity = 0; range = 50; weight = 1.25; };
	[wstring.gsub(wstring.lower(GetStringFromTid(1113700)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"hit fatigue"; intensity = 0; range = 50; weight = 1.25; };

-- hit area effects
	[wstring.gsub(GetStringFromTid(1060416), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit cold area"; materials="Magical Residue|Sapphire|Raptor Teeth"; intensity = 0; range = 50; weight = 1; };
	[wstring.gsub(GetStringFromTid(1060418), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit energy area"; materials="Magical Residue|Amethyst|Raptor Teeth"; intensity = 0; range = 50; weight = 1; };
	[wstring.gsub(GetStringFromTid(1060419), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit fire area"; materials="Magical Residue|Ruby|Raptor Teeth"; intensity = 0; range = 50; weight = 1; };
	[wstring.gsub(GetStringFromTid(1060428), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit physical area"; materials="Magical Residue|Diamond|Raptor Teeth"; intensity = 0; range = 50; weight = 1; };
	[wstring.gsub(GetStringFromTid(1060429), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"hit poison area"; materials="Magical Residue|Emerald|Raptor Teeth"; intensity = 0; range = 50; weight = 1; };
-- combat related
	[L"damage increase"] =																	{iw=1; en = L"damage increase"; materials="Enchanted Essence|Citrine|Crystal Shards"; intensity = 0; range = 50; weight = 1; jewelrange = 25; func = "DI"; }; -- Forced english for japanese compatibility
	[wstring.gsub(GetStringFromTid(1060408), ItemPropertiesEvaluator.escape0Bis, L"")] =	{iw=1; en = L"defense chance increase";  materials="Relic Fragment|Tourmaline|Essence of Singularity"; materials_ranged="Relic Fragment|Tourmaline|Brilliant Amber"; intensity = 0; range = 15; bowrange = 25; weight = 1.1; groups = {"HCI_DCI"; "HCI_DCI_HLD_HLA"} };
	[wstring.gsub(GetStringFromTid(1060415), ItemPropertiesEvaluator.escape0Bis, L"")] =	{iw=1; en = L"hit chance increase"; materials="Relic Fragment|Amber|Essence of Precision";  materials_ranged="Relic Fragment|Amber|Luminescent Fungi"; intensity = 0; range = 15; bowrange = 25; weight = 1.3; groups = {"HCI_DCI"; "HCI_DCI_HLD_HLA"} };
	[L"swing speed increase"] =																{iw=1; en = L"swing speed increase"; materials="Relic Fragment|Tourmaline|Essence of Control"; intensity = 0; range = 30; jewelrange = 30;  weight = 1.1; }; -- Forced english for japanese compatibility "SWING_LEECH"; "SWING_EFFECT"
	[GetStringFromTid(1060400)] =															{iw=1; en = L"use best weapon skill"; materials="Enchanted Essence|Amber|Delicate Scales"; intensity = 0; range = ""; weight = 1.5; };
	[wstring.gsub(GetStringFromTid(1061168), ItemPropertiesEvaluator.escape3, L"")] =		{iw=0; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"weapon damage"; intensity = 0; range = ""; weight = 0; groups = {"DPS"}; func = "DPS"};
	[wstring.gsub(GetStringFromTid(1061167), ItemPropertiesEvaluator.escape2, L"")] =		{iw=0; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"weapon speed"; intensity = 0; range = "-5"; weight = 1; func = "WEAPON_SPEED" }; -- "SWING_EFFECT"; "SWING_LEECH"
	
	[wstring.lower(GetStringFromTid(1113710))] =											{iw=1; en = L"battle lust"; intensity = 0; range = ""; weight = 1; };
	[wstring.lower(GetStringFromTid(1113591))] =											{iw=1; en = L"blood drinker"; intensity = 0; range = ""; weight = 1; };
	[wstring.gsub(GetStringFromTid(1112857), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"splintering weapon"; intensity = 0; range = ""; weight = 1.5; };
	[GetStringFromTid(1112364)] =															{iw=1; en = L"reactive paralyze"; intensity = 0; range = ""; weight = 1.4; };
	
-- potions related
	[wstring.lower(GetStringFromTid(1072792))] =											{iw=1; en = L"balanced";  materials="Relic Fragment|Amber|Essence of Balance"; intensity = 0; range = ""; weight = 1.5; groups = {BAL_EP} };
	[wstring.gsub(GetStringFromTid(1060411), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"enhance potions"; materials="Enchanted Essence|Citrine|Crushed Glass"; intensity = 0; range = 25; weight = 1; groups = {BAL_EP} };

-- magery

	[wstring.gsub(GetStringFromTid(1060412), ItemPropertiesEvaluator.escape2, L"")] =		{iw=1; en = L"faster cast recovery"; materials="Relic Fragment|Amethyst|Essence of Diligence"; intensity = 0; range = 3; weight = 1.2; };
	[L"faster casting"] =																	{iw=1; en = L"faster casting"; materials="Relic Fragment|Ruby|Essence of Achievement"; intensity = 0; range = 1; weight = 1.4; }; -- Forced english for chinese compatibility
	[wstring.gsub(GetStringFromTid(1060433), ItemPropertiesEvaluator.escape0Tris, L"")] =	{iw=1; en = L"lower mana cost"; materials="Relic Fragment|Tourmaline|Essence of Order"; intensity = 0; range = 8; weight = 1.1; };
	[wstring.gsub(GetStringFromTid(1060434), ItemPropertiesEvaluator.escape0Tris, L"")] =	{iw=1; en = L"lower reagent cost"; materials="Magical Residue|Amber|Fairy Dust"; intensity = 0; range = 20; weight = 1; };
	[GetStringFromTid(1060437)] =															{iw=1; en = L"mage armor"; materials="Enchanted Essence|Diamond|Abyssal Cloth"; intensity = 0; range = ""; weight = 1.4; };
	[GetStringFromTid(1062755)] =															{iw=1; en = L"mage weapon"; materials="Enchanted Essence|Emerald|Arcanic Rune Stone"; intensity = 0; range = "-30"; weight = 1; func = "MAGE_WEAPON" };
	[GetStringFromTid(1060482)] =															{iw=1; en = L"spell channeling"; materials="Magical Residue|Diamond|Silver Snake Skin"; intensity = 0; range = ""; weight = 1; };
	[L"sdi"] =																				{iw=1; en = L"spell damage increase"; materials="Enchanted Essence|Emerald|Crystal Shards"; intensity = 0; range = 12; weight = 1; };
	
	[wstring.gsub(wstring.lower(GetStringFromTid(1113630)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"soul charge"; intensity = 0; range = 20; weight = 1; };
	[wstring.gsub(wstring.lower(GetStringFromTid(1113696)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"casting focus"; intensity = 0; range = 4; weight = 1.2; };

-- eaters
	[wstring.gsub(wstring.lower(GetStringFromTid(1113597)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"kinetic eater"; intensity = 0; range = 15; weight = 0.9; };
	[wstring.gsub(wstring.lower(GetStringFromTid(1113593)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"fire eater"; intensity = 0; range = 15; weight = 0.9; };
	[wstring.gsub(wstring.lower(GetStringFromTid(1113594)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"cold eater"; intensity = 0; range = 15; weight = 0.9; };
	[wstring.gsub(wstring.lower(GetStringFromTid(1113595)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"poison eater"; intensity = 0; range = 15; weight = 0.9; };
	[wstring.gsub(wstring.lower(GetStringFromTid(1113596)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"energy eater"; intensity = 0; range = 15; weight = 0.9; };
	[wstring.gsub(wstring.lower(GetStringFromTid(1113598)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"damage eater"; intensity = 0; range = 6; weight = 0.9; };
	
-- resonance
	[wstring.gsub(wstring.lower(GetStringFromTid(1113695)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"kinetic resonance"; intensity = 0; range = 20; weight = 1; };
	[wstring.gsub(wstring.lower(GetStringFromTid(1113691)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"fire resonance"; intensity = 0; range = 20; weight = 1; };
	[wstring.gsub(wstring.lower(GetStringFromTid(1113692)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"cold resonance"; intensity = 0; range = 20; weight = 1; };
	[wstring.gsub(wstring.lower(GetStringFromTid(1113693)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"poison resonance"; intensity = 0; range = 20; weight = 1; };
	[wstring.gsub(wstring.lower(GetStringFromTid(1113694)), ItemPropertiesEvaluator.escape, L"")] =	{iw=1; en = L"energy resonance"; intensity = 0; range = 20; weight = 1; };

-- other
	[wstring.gsub(GetStringFromTid(1060410), ItemPropertiesEvaluator.escape0Bis, L"")] =	{iw=1; en = L"durability"; intensity = 0; range = 100; weight = 0; func = "DURABILITY"};
	[wstring.gsub(GetStringFromTid(1060435), ItemPropertiesEvaluator.escape0Tris, L"")] =	{iw=1; en = L"lower requirements"; intensity = 0; range = 100; weight = 1; func = "LOWER_REQ"};
	[wstring.gsub(GetStringFromTid(1060436), ItemPropertiesEvaluator.escape2, L"")] =		{iw=1; en = L"luck"; materials="Enchanted Essence|Citrine|Ecru Citrine"; materials_jewel="Magical Residue|Citrine|Chaga Mushrooms"; intensity = 0; range = 100; bowrange = 120; weight = 1; };
	[GetStringFromTid(1060441)] =															{iw=1; en = L"night sight"; materials="Magical Residue|Tourmaline|Bottle of Ichor"; intensity = 0; range = ""; weight = 1; };
	[wstring.gsub(GetStringFromTid(1060442), ItemPropertiesEvaluator.escape, L"")] =		{iw=1; en = L"reflect physical damage"; materials="Magical Residue|Citrine|Reflective Wolf Eye"; intensity = 0; range = 15; weight = 1; };
	[GetStringFromTid(1070928)] =															{iw=0; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"replenish charges"; intensity = 0; range = ""; weight = 0; };
	[wstring.gsub(GetStringFromTid(1060450), ItemPropertiesEvaluator.escape2, L"")] =		{iw=0; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"self repair"; intensity = 0; range = 5; weight = 1;};
	[GetStringFromTid(1049643)] =															{iw=0; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"cursed"; intensity = 0; range = ""; weight = -2.5;};

-- skill bonuses (non-talisman)
	[GetStringFromTid(1042348) .. L" +"] =													{iw=1; grp = 4; en = L"anatomy"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042349) .. L" +"] =													{iw=1; grp = 3; en = L"animal lore"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1049472) .. L" +"] =													{iw=1; grp = 2; en = L"animal taming"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1043090) .. L" +"] =													{iw=1; grp = 5; en = L"archery"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1062935) .. L" +"] =													{iw=1; grp = 4; en = L"bushido"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1061615) .. L" +"] =													{iw=1; grp = 5; en = L"chivalry"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042362) .. L" +"] =													{iw=1; grp = 3; en = L"discordance"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042363) .. L" +"] =													{iw=1; grp = 4; en = L"evaluate intelligence"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042389) .. L" +"] =													{iw=1; grp = 1; en = L"fencing"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1061613) .. L" +"] =													{iw=1; grp = 3; en = L"focus"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042364) .. L" +"] =													{iw=1; grp = 5; en = L"healing"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1049470) .. L" +"] =													{iw=1; grp = 1; en = L"mace fighting"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042372) .. L" +"] =													{iw=1; grp = 1; en = L"magery"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042393) .. L" +"] =													{iw=1; grp = 3; en = L"meditation"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042376) .. L" +"] =													{iw=1; grp = 1; en = L"musicianship"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1112544) .. L" +"] =													{iw=1; grp = 4; en = L"mysticism"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1060842) .. L" +"] =													{iw=1; grp = 4; en = L"necromancy"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1062936) .. L" +"] =													{iw=1; grp = 5; en = L"ninjitsu"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4;};
	[GetStringFromTid(1042352) .. L" +"] =													{iw=1; grp = 3; en = L"parrying"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042356) .. L" +"] =													{iw=1; grp = 5; en = L"peacemaking"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1049473) .. L" +"] =													{iw=1; grp = 2; en = L"provocation"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1049471) .. L" +"] =													{iw=1; grp = 5; en = L"resisting spells"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042379) .. L" +"] =													{iw=1; grp = 2; en = L"spirit speak"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042380) .. L" +"] =													{iw=1; grp = 4; en = L"stealing"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042394) .. L" +"] =													{iw=1; grp = 3; en = L"stealth"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042387) .. L" +"] =													{iw=1; grp = 1; en = L"swordsmanship"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042374) .. L" +"] =													{iw=1; grp = 2; en = L"tactics"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1112553) .. L" +"] =													{iw=1; grp = 5; en = L"throwing"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4;};
	[GetStringFromTid(1042386) .. L" +"] =													{iw=1; grp = 4; en = L"veterinary"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	[GetStringFromTid(1042390) .. L" +"] =													{iw=1; grp = 2; en = L"wrestling"; materials="Enchanted Essence|Star Sapphire|Crystalline Blackrock"; intensity = 0; range = 15; weight = 1.4; };
	
	[GetStringFromTid(1042354) .. L" +"] =													{iw=1;  type = ItemPropertiesEvaluator.TYPE_SKILL; en = L"blacksmith"; intensity = 0; range = ""; weight = 0; };
	[GetStringFromTid(1042375) .. L" +"] =													{iw=1;  type = ItemPropertiesEvaluator.TYPE_SKILL; en = L"snooping"; intensity = 0; range = 15; weight = 1.4;  };



-- slayer properties 

	[GetStringFromTid(1060457)] =															{iw=1; en = L"air elemental slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060458)] =															{iw=1; en = L"arachnid slayer";  materials="Relic Fragment|Ruby|Spider Carapace"; intensity = 0; range = ""; weight = 1.1; };
	[GetStringFromTid(1060459)] =															{iw=1; en = L"blood elemental slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1; };
	[GetStringFromTid(1060460)] =															{iw=1; en = L"demon slayer";  materials="Relic Fragment|Ruby|Daemon Claw"; intensity = 0; range = ""; weight = 1.1; };
	[GetStringFromTid(1060462)] =															{iw=1; en = L"dragon slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1; };
	[GetStringFromTid(1060463)] =															{iw=1; en = L"earth elemental slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060464)] =															{iw=1; en = L"elemental slayer";  materials="Relic Fragment|Ruby|Vial of Vitriol"; intensity = 0; range = ""; weight = 1.1; };
	[GetStringFromTid(1070855)] =															{iw=1; en = L"fey slayer"; materials=""; intensity = 0; range = ""; weight = 1.1; };
	[GetStringFromTid(1060465)] =															{iw=1; en = L"fire elemental slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060466)] =															{iw=1; en = L"gargoyle slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060467)] =															{iw=1; en = L"lizardman slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060468)] =															{iw=1; en = L"ogre slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060469)] =															{iw=1; en = L"ophidian slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060470)] =															{iw=1; en = L"orc slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060471)] =															{iw=1; en = L"poison elemental slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060472)] =															{iw=1; en = L"repond slayer";  materials="Relic Fragment|Ruby|Goblin Blood"; intensity = 0; range = ""; weight = 1.1; };
	[GetStringFromTid(1060473)] =															{iw=1; en = L"reptile slayer"; materials="Relic Fragment|Ruby|Lava Serpent Crust"; intensity = 0; range = ""; weight = 1.1; };
	[GetStringFromTid(1060474)] =															{iw=1; en = L"scorpion slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1; };
	[GetStringFromTid(1060475)] =															{iw=1; en = L"snake slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060476)] =															{iw=1; en = L"snow elemental slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060477)] =															{iw=1; en = L"spider slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060478)] =															{iw=1; en = L"terathan slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060480)] =															{iw=1; en = L"troll slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	[GetStringFromTid(1060479)] =															{iw=1; en = L"undead slayer"; materials="Relic Fragment|Ruby|Undying Flesh"; intensity = 0; range = ""; weight = 1.1; };
	[GetStringFromTid(1060481)] =															{iw=1; en = L"water elemental slayer"; materials="Magical Residue|Emerald|White Pearl"; intensity = 0; range = ""; weight = 1.1;};
	
	[wstring.lower(GetStringFromTid(1017396))] =															{iw=1; en = L"balron damnation"; materials=""; intensity = 0; range = ""; weight = 1.1;}; -- obsolete

-- other slayers
	[wstring.lower(GetStringFromTid(1072504))] =															{iw=1; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"bear slayer"; intensity = 0; range = ""; weight = 0.6;};
	[wstring.lower(GetStringFromTid(1072506))] =															{iw=1; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"bat slayer"; intensity = 0; range = ""; weight = 0.5;};
	[wstring.lower(GetStringFromTid(1072508))] =															{iw=1; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"beetle slayer"; intensity = 0; range = ""; weight = 1; };
	[wstring.lower(GetStringFromTid(1072509))] =															{iw=1; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"bird slayer"; intensity = 0; range = ""; weight = 1; };
	[wstring.lower(GetStringFromTid(1072512))] =															{iw=1; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"bovine slayer"; intensity = 0; range = ""; weight = 1; };
	[wstring.lower(GetStringFromTid(1072511))] =															{iw=1; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"flame slayer"; intensity = 0; range = ""; weight = 1; };
	[wstring.lower(GetStringFromTid(1072510))] =															{iw=1; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"ice slayer"; intensity = 0; range = ""; weight = 1; };
	[wstring.lower(GetStringFromTid(1072507))] =															{iw=1; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"mage slayer"; intensity = 0; range = ""; weight = 0.8;};
	[wstring.lower(GetStringFromTid(1072505))] =															{iw=1; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"vermin slayer"; intensity = 0; range = ""; weight = 1;};
	[wstring.lower(GetStringFromTid(1075462))] =															{iw=1; type = ItemPropertiesEvaluator.TYPE_SKIP; en = L"wolf slayer"; intensity = 0; range = ""; weight = 1;};
	}








