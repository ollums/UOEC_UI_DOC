----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

SlayersDB = {
[GetStringFromTid(1060472)] = {opposite=GetStringFromTid(1060479), super=true}; -- REPOND
[GetStringFromTid(1060470)] = {opposite=GetStringFromTid(1060479), super=false}; -- orc
[GetStringFromTid(1060468)] = {opposite=GetStringFromTid(1060479), super=false}; -- ogre
[GetStringFromTid(1060480)] = {opposite=GetStringFromTid(1060479), super=false}; -- troll
[wstring.lower(GetStringFromTid(1095010))] = {opposite=GetStringFromTid(1060479), super=false}; -- goblin

[GetStringFromTid(1060473)] = {opposite=GetStringFromTid(1060458), super=true}; -- Reptile
[GetStringFromTid(1060462)] = {opposite=GetStringFromTid(1060458), super=false}; -- Dragon
[GetStringFromTid(1060467)] = {opposite=GetStringFromTid(1060458), super=false}; -- Lizardman
[GetStringFromTid(1060469)] = {opposite=GetStringFromTid(1060458), super=false}; -- Ophidian
[GetStringFromTid(1060475)] = {opposite=GetStringFromTid(1060458), super=false}; -- Snake

[GetStringFromTid(1060460)] = {opposite=GetStringFromTid(1060464), opposite2=GetStringFromTid(1070855), super=true}; -- Demon
[GetStringFromTid(1060466)] = {opposite=GetStringFromTid(1060464), super=false}; -- Gargoyle
[wstring.lower(GetStringFromTid(1017396))] = {opposite=GetStringFromTid(1060464), super=false}; -- Balron Damnation (obsolete)

[GetStringFromTid(1060464)] = {opposite=GetStringFromTid(1060460), super=true}; -- Elemental
[GetStringFromTid(1060457)] = {opposite=GetStringFromTid(1060460), super=false}; -- Air Elemental
[GetStringFromTid(1060459)] = {opposite=GetStringFromTid(1060460), super=false}; -- Blood Elemental
[GetStringFromTid(1060463)] = {opposite=GetStringFromTid(1060460), super=false}; -- Earth Elemental
[GetStringFromTid(1060465)] = {opposite=GetStringFromTid(1060460), super=false}; -- Fire Elemental
[GetStringFromTid(1060471)] = {opposite=GetStringFromTid(1060460), super=false}; -- Poison Elemental
[GetStringFromTid(1060476)] = {opposite=GetStringFromTid(1060460), super=false}; -- Snow Elemental
[GetStringFromTid(1060481)] = {opposite=GetStringFromTid(1060460), super=false}; -- Water Elemental

[GetStringFromTid(1060479)] = {opposite=GetStringFromTid(1060472), super=true}; -- Undead

[GetStringFromTid(1060458)] = {opposite=GetStringFromTid(1060473), super=true}; -- Arachnid
[GetStringFromTid(1060474)] = {opposite=GetStringFromTid(1060473), super=false}; -- Scorpion
[GetStringFromTid(1060477)] = {opposite=GetStringFromTid(1060473), super=false}; -- Spider
[GetStringFromTid(1060478)] = {opposite=GetStringFromTid(1060473), super=false}; -- Terathan

[GetStringFromTid(1070855)] = {opposite=GetStringFromTid(1060460), super=true}; -- Fey
 
[wstring.lower(GetStringFromTid(1072505))] = {opposite=L"", super=true}; -- Vermin
[wstring.lower(GetStringFromTid(1072509))] = {opposite=L"", super=true}; -- Bird
[wstring.lower(GetStringFromTid(1072512))] = {opposite=L"", super=true}; -- Bovine 
[wstring.lower(GetStringFromTid(1072506))] = {opposite=L"", super=true}; -- Bat 
[wstring.lower(GetStringFromTid(1072508))] = {opposite=L"", super=true}; -- Beetle 
[wstring.lower(GetStringFromTid(1072511))] = {opposite=L"", super=true}; -- Flame 
[wstring.lower(GetStringFromTid(1072510))] = {opposite=L"", super=true}; -- Ice 
[wstring.lower(GetStringFromTid(1072504))] = {opposite=L"", super=true}; -- Bear 
[wstring.lower(GetStringFromTid(1072505))] = {opposite=L"", super=true}; -- Mage 
[wstring.lower(GetStringFromTid(1075462))] = {opposite=L"", super=true}; -- Wolf
}
