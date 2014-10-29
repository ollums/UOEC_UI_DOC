MapIcons = {}

MapIcons.prefix = "MapIcons_"
MapIcons.textures = { "Customs", "Leather", "Stairs", "Eye", "X", "Teleporter", "Serpent_Pillar", "Cemetery", "Dock", "Gate", "Waves", "Party", "Sink", "Boat", "Target", "Mark"}

function MapIcons.Initialize()
	local last = table.getn(UserWaypointWindow.Icons)
    for i,v in pairs( MapIcons.textures ) do
		last = last + 1
		local name = string.gsub(v, "_", " ")
        local record = { id =MapIcons.prefix..v, name=StringToWString(name)}
        table.insert(UserWaypointWindow.Icons, last, record)
    end
end
