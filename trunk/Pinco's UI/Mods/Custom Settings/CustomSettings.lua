-------------------------------------------------------------------------------
-- Title: Custom Settings
-- Authors: Ash, Illandril
-- Version: 0.2.1 (Untested!)
-- Date: August 14, 2008
-- Description:
--     This collection of functions allows for the saving of custom settings
--     by using bogus window positions.
-- Usage:
--     CustomSettings.Save<Type>( settingName, settingValue )
--         Saves the value of type <Type> with the name settingName
--     CustomSettings.Load<Type>( settingName, defaultValue )
--         Loads a saved value of type <Type> with the name settingName
--         Returns the defaultValue if the setting wasn't previously saved
--         properly as the specified Type
--
-- Supported Types:
--     Boolean - true or false
--     Number - Any number, integer or double
--     Color - A table with 'r', 'g', 'b', and (optionally) 'a' values.
-------------------------------------------------------------------------------

CustomSettings = {}

-- Values to use for saving boolean values
CustomSettings.BooleanTrue = 1
CustomSettings.BooleanFalse = 0

-- Values to use for special values
CustomSettings.IsNil = -9

-- A cache to speed things up
CustomSettings.IndexCache = {}

-- Values to store in the WindowPosition table when creating a new entry
CustomSettings.DefaultPosX = CustomSettings.IsNil
CustomSettings.DefaultPosY = CustomSettings.IsNil
CustomSettings.DefaultWidth = CustomSettings.IsNil
CustomSettings.DefaultHeight = CustomSettings.IsNil

-- A prefix to be added to custom settings (to avoid collisions with actual window names)
CustomSettings.SettingPrefix = "CustomSetting___"

-- Ascii table for converting ints to ascii values
CustomSettings.ExtraSettingsPerString=5
CustomSettings.AsciiStartIndex = 32
CustomSettings.AsciiSize = 128
CustomSettings.AsciiPerSetting = 3
CustomSettings.Ascii = 
{
 " ","!","\"","#","$","%","&","'","(",")","*","+",",","-",".","/",
 "0","1","2","3","4","5","6","7","8","9",
 ":",";","<","=",">","?","@",
 "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z",
 "[","\\","]","^","_","`",
 "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",
 "{","|","}","~"
}
CustomSettings.WAscii = 
{
 L" ",L"!",L"\"",L"#",L"$",L"%",L"&",L"'",L"(",L")",L"*",L"+",L",",L"-",L".",L"/",
 L"0",L"1",L"2",L"3",L"4",L"5",L"6",L"7",L"8",L"9",
 L":",L";",L"<",L"=",L">",L"?",L"@",
 L"A",L"B",L"C",L"D",L"E",L"F",L"G",L"H",L"I",L"J",L"K",L"L",L"M",L"N",L"O",L"P",L"Q",L"R",L"S",L"T",L"U",L"V",L"W",L"X",L"Y",L"Z",
 L"[",L"\\",L"]",L"^",L"_",L"`",
 L"a",L"b",L"c",L"d",L"e",L"f",L"g",L"h",L"i",L"j",L"k",L"l",L"m",L"n",L"o",L"p",L"q",L"r",L"s",L"t",L"u",L"v",L"w",L"x",L"y",L"z",
 L"{",L"|",L"}",L"~"
}

-------------------------------------------------------------------------------
-- CustomSettings.SaveBoolean
-- Description:
--     Saves a boolean value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-- Returns:
--     True if the setting was saved, false if it failed
-------------------------------------------------------------------------------
function CustomSettings.SaveBoolean( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "CustomSettings.SaveBoolean: settingName must be a string" )
		return false
	end
	if type( settingValue ) ~= type( true ) then
		Debug.Print( "CustomSettings.SaveBoolean: settingValue must be a boolean" )
		return false
	end

	-- Add the prefix to the name (to avoid collisions with actual window names)
	settingName = CustomSettings.SettingPrefix .. settingName

	local y = CustomSettings.BooleanFalse
	if settingValue then
		y = CustomSettings.BooleanTrue
	end

	-- Find the index for the setting in the window positions table
	local windowPositions = SystemData.Settings.Interface.WindowPositions
	local index = nil
	for i, windowName in pairs(windowPositions.Names) do
		if( settingName == windowName ) then
			index = i
			break
		end
	end

	-- If it doesnt exist yet then add it
	if( index == nil ) then
		index = table.getn(windowPositions.Names) + 1
		windowPositions.Names[index] = settingName
	end	
	
	-- Save the value
	CustomSettings.ClearSettingAtIndex( index )
	windowPositions.WindowPosY[index] = y
	CustomSettings.SaveChanges(settingName)
end

-------------------------------------------------------------------------------
-- CustomSettings.SaveNumber
-- Description:
--     Saves a numeric value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-- Returns:
--     True if the setting was saved, false if it failed
-------------------------------------------------------------------------------
function CustomSettings.SaveNumber( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "CustomSettings.SaveNumber: settingName must be a string" )
		return false
	end
	if type( settingValue ) ~= type( 0 ) then
		Debug.Print( "CustomSettings.SaveNumber: settingValue must be a number" )
		return false
	end
	
	-- Add the prefix to the name (to avoid collisions with actual window names)
	settingName = CustomSettings.SettingPrefix .. settingName

	-- Find the index for the setting in the window positions table
	local index = CustomSettings.GetOrCreateSettingIndex( settingName )
	
	-- Save the value
	CustomSettings.ClearSettingAtIndex( index )
	SystemData.Settings.Interface.WindowPositions.WindowPosX[index] = settingValue
	CustomSettings.SaveChanges(settingName)
end


-------------------------------------------------------------------------------
-- CustomSettings.SaveString
-- Description:
--     Saves a string value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-- Returns:
--     True if the setting was saved, false if it failed
-------------------------------------------------------------------------------
function CustomSettings.SaveString( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "CustomSettings.SaveString: settingName must be a string" )
		return false
	end
	if type( settingValue ) ~= type( "" ) then
		Debug.Print( "CustomSettings.SaveString: settingValue must be a string" )
		return false
	end
	
	if (string.len(settingValue) > 72) then
		Debug.Print( "CustomSettings.SaveString: the string is longer than 72 characters and will be trimmed." )
	end
	
	-- Add the prefix to the name (to avoid collisions with actual window names)
	settingName = CustomSettings.SettingPrefix .. settingName

	-- Find the index for the setting in the window positions table
	local index = CustomSettings.GetOrCreateSettingIndex( settingName )
	
	-- Save the value
	CustomSettings.ClearSettingAtIndex( index )
	
	function PackBytes(...)
        return arg
    end
	
	local stringBytes = PackBytes( string.byte( settingValue, 1, string.len( settingValue  ) ) )
    local xywh = {}
    local idx = 0
    for i,v in ipairs( stringBytes ) do
        local iMod = (i-1) % CustomSettings.AsciiPerSetting
        if iMod == 0 then
            idx = idx + 1
            xywh[idx] = 0
        end
        v = v * ( CustomSettings.AsciiSize ^ iMod )
        xywh[idx] = xywh[idx] + v
    end
    
	-- Save the value
	if xywh[1] == nil then
		xywh[1] = 0
	end
	SystemData.Settings.Interface.WindowPositions.WindowPosX[index] = xywh[1]
	if xywh[2] == nil then
		xywh[2] = 0
	end
    SystemData.Settings.Interface.WindowPositions.WindowPosY[index] = xywh[2]
    if xywh[3] == nil then
		xywh[3] = 0
	end
    SystemData.Settings.Interface.WindowPositions.WindowWidth[index] = xywh[3]
    if xywh[4] == nil then
		xywh[4] = 0
	end
    SystemData.Settings.Interface.WindowPositions.WindowHeight[index] = xywh[4]
    
    for i=1,CustomSettings.ExtraSettingsPerString do
		index = CustomSettings.GetOrCreateSettingIndex( settingName .."_"..i )
		if xywh[1 + i*4] == nil then
			xywh[1 + i*4] = 0
		end
		SystemData.Settings.Interface.WindowPositions.WindowPosX[index] = xywh[1 + i*4]
		if xywh[2 + i*4] == nil then
			xywh[2 + i*4] = 0
		end
		SystemData.Settings.Interface.WindowPositions.WindowPosY[index] = xywh[2 + i*4]
		if xywh[3 + i*4] == nil then
			xywh[3 + i*4] = 0
		end
		SystemData.Settings.Interface.WindowPositions.WindowWidth[index] = xywh[3 + i*4]
		if xywh[4 + i*4] == nil then
			xywh[4 + i*4] = 0
		end
		SystemData.Settings.Interface.WindowPositions.WindowHeight[index] =  xywh[4 + i*4]
		 
    end

	CustomSettings.SaveChanges(settingName)
end

-------------------------------------------------------------------------------
-- CustomSettings.SaveWString
-- Description:
--     Saves a wstring value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved
-- Returns:
--     True if the setting was saved, false if it failed
-------------------------------------------------------------------------------
function CustomSettings.SaveWString( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "CustomSettings.SaveString: settingName must be a string" )
		return false
	end
	if type( settingValue ) ~= type( L"" ) then
		Debug.Print( "CustomSettings.SaveString: settingValue must be a wstring" )
		return false
	end
	
	if (wstring.len(settingValue) > 72) then
		Debug.Print( "CustomSettings.SaveString: the string is longer than 72 characters and will be trimmed." )
	end
	
	-- Add the prefix to the name (to avoid collisions with actual window names)
	settingName = CustomSettings.SettingPrefix .. settingName

	-- Find the index for the setting in the window positions table
	local index = CustomSettings.GetOrCreateSettingIndex( settingName )
	
	-- Save the value
	CustomSettings.ClearSettingAtIndex( index )
	
	function PackBytes(...)
        return arg
    end
	
	local stringBytes = PackBytes( wstring.byte( settingValue, 1, wstring.len( settingValue  ) ) )
    local xywh = {}
    local idx = 0
    for i,v in ipairs( stringBytes ) do
        local iMod = (i-1) % CustomSettings.AsciiPerSetting
        if iMod == 0 then
            idx = idx + 1
            xywh[idx] = 0
        end
        v = v * ( CustomSettings.AsciiSize ^ iMod )
        xywh[idx] = xywh[idx] + v
    end
    
	-- Save the value
	if xywh[1] == nil then
		xywh[1] = 0
	end
	SystemData.Settings.Interface.WindowPositions.WindowPosX[index] = xywh[1]
	if xywh[2] == nil then
		xywh[2] = 0
	end
    SystemData.Settings.Interface.WindowPositions.WindowPosY[index] = xywh[2]
    if xywh[3] == nil then
		xywh[3] = 0
	end
    SystemData.Settings.Interface.WindowPositions.WindowWidth[index] = xywh[3]
    if xywh[4] == nil then
		xywh[4] = 0
	end
    SystemData.Settings.Interface.WindowPositions.WindowHeight[index] = xywh[4]
    
    for i=1,CustomSettings.ExtraSettingsPerString do
		index = CustomSettings.GetOrCreateSettingIndex( settingName .."_"..i )
		if xywh[1 + i*4] == nil then
			xywh[1 + i*4] = 0
		end
		SystemData.Settings.Interface.WindowPositions.WindowPosX[index] = xywh[1 + i*4]
		if xywh[2 + i*4] == nil then
			xywh[2 + i*4] = 0
		end
		SystemData.Settings.Interface.WindowPositions.WindowPosY[index] = xywh[2 + i*4]
		if xywh[3 + i*4] == nil then
			xywh[3 + i*4] = 0
		end
		SystemData.Settings.Interface.WindowPositions.WindowWidth[index] = xywh[3 + i*4]
		if xywh[4 + i*4] == nil then
			xywh[4 + i*4] = 0
		end
		SystemData.Settings.Interface.WindowPositions.WindowHeight[index] =  xywh[4 + i*4]
		 
    end

	CustomSettings.SaveChanges(settingName)
end

-------------------------------------------------------------------------------
-- CustomSettings.SaveColor
-- Description:
--     Saves a color value for a setting
-- Parameters:
--     settingName - the name of the setting to be saved
--     settingValue - the value to be saved 
--                    (table {r=(0-255),g=(0-255),b=(0-255)[,a=(0-255)]})
-- Returns:
--     True if the setting was saved, false if it failed
-------------------------------------------------------------------------------
function CustomSettings.SaveColor( settingName, settingValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "CustomSettings.SaveColor: settingName must be a string" )
		return false
	end
	--Debug.Print("Checking Color: " .. settingName)
	if not CustomSettings.CheckColor( settingValue, "CustomSettings.SaveColor" ) then
		-- Debug printing in CheckColor function
		return false
	end

	-- Add the prefix to the name (to avoid collisions with actual window names)
	settingName = CustomSettings.SettingPrefix .. settingName

	local r = settingValue.r
	local g = settingValue.g
	local b = settingValue.b
	local a = settingValue.a

	-- Find the index for the setting in the window positions table
	local index = CustomSettings.GetOrCreateSettingIndex( settingName )

	-- Save the value
	CustomSettings.ClearSettingAtIndex( index )
	SystemData.Settings.Interface.WindowPositions.WindowPosX[index] = r
	SystemData.Settings.Interface.WindowPositions.WindowPosY[index] = g
	SystemData.Settings.Interface.WindowPositions.WindowWidth[index] = b
	SystemData.Settings.Interface.WindowPositions.WindowHeight[index] = a

	CustomSettings.SaveChanges(settingName)
end

-------------------------------------------------------------------------------
-- CustomSettings.GetOrCreateSettingIndex
-- Description:
--     Gets the index of a setting, creating a new entry if it doesn't exist 
-- Parameters:
--     settingName - the name of the setting (with the prefix)
-- Returns:
--     The index of for the setting
-------------------------------------------------------------------------------
function CustomSettings.GetOrCreateSettingIndex( settingName )
	local index = CustomSettings.GetSettingIndex( settingName )

	-- If it doesnt exist yet then add it
	if( index == nil ) then
		index = table.getn(SystemData.Settings.Interface.WindowPositions.Names) + 1
		SystemData.Settings.Interface.WindowPositions.Names[index] = settingName
		CustomSettings.ClearSettingAtIndex( index )
	end

	return index
end

-------------------------------------------------------------------------------
-- CustomSettings.DeleteSetting
-- Description:
--     Delete an existing setting
-- Parameters:
--     settingName - the name of the setting (with the prefix)
-- Returns:
--     nothing
-------------------------------------------------------------------------------

function CustomSettings.DeleteSetting( settingName )
	CustomSettings.IndexCache[settingName] = nil
	WindowUtils.ClearWindowPosition(CustomSettings.SettingPrefix .. settingName )
end

function CustomSettings.DeleteStringSetting( settingName )
	CustomSettings.IndexCache[settingName] = nil
	WindowUtils.ClearWindowPosition(CustomSettings.SettingPrefix .. settingName )
	for i=1,CustomSettings.ExtraSettingsPerString do
		WindowUtils.ClearWindowPosition(CustomSettings.SettingPrefix .. settingName.."_"..i )
    end
end


-------------------------------------------------------------------------------
-- CustomSettings.GetSettingIndex
-- Description:
--     Gets the index of a setting
-- Parameters:
--     settingName - the name of the setting (with the prefix)
-- Returns:
--     The index of for the setting, or nil if it doesn't exist yet
-------------------------------------------------------------------------------
function CustomSettings.GetSettingIndex( settingName )
	-- Find the index for the setting in the window positions table
	local index = nil
	if CustomSettings.IndexCache[settingName] ~= nil then
		index = CustomSettings.IndexCache[settingName]
	else
		for i, windowName in pairs(SystemData.Settings.Interface.WindowPositions.Names) do
			if( settingName == windowName ) then
				index = i
				--CustomSettings.IndexCache[settingName] = index
				break
			end
		end
	end
	return index
end

-------------------------------------------------------------------------------
-- CustomSettings.ClearSettingAtIndex
-- Description:
--     Clears the setting with the specified index
-- Parameters:
--     settingIndex - the index of the setting
-------------------------------------------------------------------------------
function CustomSettings.ClearSettingAtIndex( settingIndex )
	if( settingIndex ~= nil ) then
		SystemData.Settings.Interface.WindowPositions.WindowPosX[settingIndex] = CustomSettings.DefaultPosX
		SystemData.Settings.Interface.WindowPositions.WindowPosY[settingIndex] = CustomSettings.DefaultPosY
		SystemData.Settings.Interface.WindowPositions.WindowWidth[settingIndex] = CustomSettings.DefaultWidth
		SystemData.Settings.Interface.WindowPositions.WindowHeight[settingIndex] = CustomSettings.DefaultHeight
	end	
end

-------------------------------------------------------------------------------
-- CustomSettings.CheckColor
-- Description:
--     Checks to see if an argument is a valid color table
-- Parameters:
--     color - the argument to check
--     rootFunction - the name of the function to use in the debug messages
--                    no logging is done if this is nil
-- Returns:
--     True if it is a valid color, false otherwise
-------------------------------------------------------------------------------
function CustomSettings.CheckColor( color, rootFunction )
	local good = true
	if type( color ) ~= type( {} ) then
		good = false
	elseif type( color.r ) ~= type( 0 ) or color.r < 0 or color.r > 255 then
		good = false
	elseif type( color.g ) ~= type( 0 ) or color.g < 0 or color.g > 255 then
		good = false
	elseif type( color.b ) ~= type( 0 ) or color.b < 0 or color.b > 255 then
		good = false
	elseif color.a ~= nil and type( color.a ) ~= type( 0 ) then
		if (color.a < 0 or color.a > 255 ) then
			good = false
		end
	end
	if not good and rootFunction ~= nil then
		Debug.Print( rootFunction .. ": color must be a table with r, g, and b values between 0 and 255 (with an option a value between 0 and 255)" )
	end
	return good
end

-------------------------------------------------------------------------------
-- CustomSettings.LoadBoolean
-- Description:
--     Gets the boolean value of a setting 
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function CustomSettings.LoadBoolean( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "CustomSettings.LoadBoolean: settingName must be a string" )
		return false
	end

	-- Add the prefix to the name (to avoid collisions with actual window names)
	settingName = CustomSettings.SettingPrefix .. settingName	

	-- Get the saved X value, if it was saved
	local index = CustomSettings.GetSettingIndex( settingName )
	local y = CustomSettings.IsNil
	if index ~= nil then
			y = SystemData.Settings.Interface.WindowPositions.WindowPosY[index]
	end

	-- Check the X to see what the boolean equivalent is
	if y == CustomSettings.BooleanTrue then
		return true
	elseif y == CustomSettings.BooleanFalse then
		return false
	else
		return defaultValue
	end
end

-------------------------------------------------------------------------------
-- CustomSettings.LoadNumber
-- Description:
--     Gets the numeric value of a setting 
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function CustomSettings.LoadNumber( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "CustomSettings.LoadNumber: settingName must be a string" )
		return defaultValue
	end

	-- Add the prefix to the name (to avoid collisions with actual window names)
	settingName = CustomSettings.SettingPrefix .. settingName	

	-- Get the saved X value, if it was saved
	local index = CustomSettings.GetSettingIndex( settingName )
	local x = CustomSettings.IsNil
	if index ~= nil then
		x = SystemData.Settings.Interface.WindowPositions.WindowPosX[index]
	end
	-- Check the X to make sure it isn't CustomSettings.IsNil
	if x == CustomSettings.IsNil or x == nil then
		return defaultValue
	else
		return x
	end
end

-------------------------------------------------------------------------------
-- CustomSettings.LoadColor
-- Description:
--     Gets the color value of a setting 
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-- Returns:
--     The value of the setting if it was saved properly, the default value if
--     it wasn't saved properly, or nil if it wasn't saved properly and no
--     default value was provided
-------------------------------------------------------------------------------
function CustomSettings.LoadColor( settingName, defaultValue )
	-- Check the types of the arguments
	if type( settingName ) ~= type( "" ) then
		Debug.Print( "CustomSettings.LoadColor: settingName must be a string" )
		return false
	end

	-- Add the prefix to the name (to avoid collisions with actual window names)
	settingName = CustomSettings.SettingPrefix .. settingName	

	-- Get the saved color value, if it was saved
	local index = CustomSettings.GetSettingIndex( settingName )
	local color = nil
	if index ~= nil then
			local r = SystemData.Settings.Interface.WindowPositions.WindowPosX[index]
			local g = SystemData.Settings.Interface.WindowPositions.WindowPosY[index]
			local b = SystemData.Settings.Interface.WindowPositions.WindowWidth[index]
			local a = SystemData.Settings.Interface.WindowPositions.WindowHeight[index]
			if a == CustomSettings.IsNil then
				a = nil
			end
			color = { r=r, g=g, b=b, a=a }
	end

	-- Check the color to make sure it's valid
	
	if not CustomSettings.CheckColor( color ) then
		return defaultValue
	else
		return color
	end
end

-------------------------------------------------------------------------------
-- CustomSettings.LoadStringValue
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-------------------------------------------------------------------------------
function CustomSettings.LoadString( settingName, defaultValue )
    local value = ""

    -- Get the raw saved values
    settingName = CustomSettings.SettingPrefix .. settingName
    local index = CustomSettings.GetSettingIndex( settingName )

    local xywh = {}
	if index ~= nil then
			local x = SystemData.Settings.Interface.WindowPositions.WindowPosX[index]
			local y = SystemData.Settings.Interface.WindowPositions.WindowPosY[index]
			local w = SystemData.Settings.Interface.WindowPositions.WindowWidth[index]
			local h = SystemData.Settings.Interface.WindowPositions.WindowHeight[index]
			xywh[1] =  x
			xywh[2] =  y
			xywh[3] =  w
			xywh[4] =  h 
	end
	
    
    
    for i=1,CustomSettings.ExtraSettingsPerString do
        local index = CustomSettings.GetSettingIndex( settingName.."_"..i )
		if index ~= nil then
				local x = SystemData.Settings.Interface.WindowPositions.WindowPosX[index]
				local y = SystemData.Settings.Interface.WindowPositions.WindowPosY[index]
				local w = SystemData.Settings.Interface.WindowPositions.WindowWidth[index]
				local h = SystemData.Settings.Interface.WindowPositions.WindowHeight[index]
				xywh[i*4 + 1] = x
				xywh[i*4 + 2] = y
				xywh[i*4 + 3] = w
				xywh[i*4 + 4] = h
		end
    end
    -- Convert the raw values into a string
    local offset = CustomSettings.AsciiStartIndex - 1
    for i,v in ipairs( xywh ) do
        local done = false
        while v > 0 and not done do
            local i = math.floor( v / CustomSettings.AsciiSize )
            local d = v % CustomSettings.AsciiSize
            v = i;
            d = d - offset
            if d > 0 then
                value = value..CustomSettings.Ascii[d]
            elseif d == -offset then
                done = true
                break
            else
                -- An invalid character was saved
                Debug.Print("CustomSettings.LoadString: An invalid character was found - "..tostring(d))
                done = true
                value = nil
                break
            end
        end
        if done then
            break
        end
    end

    -- Check to make sure we at least got one letter
    if value == "" or value == nil then
        value = defaultValue
    end

    -- Return the value
    return value
end

-------------------------------------------------------------------------------
-- CustomSettings.LoadWStringValue
-- Parameters:
--     settingName - the name of the setting
--     defaultValue - a value to use as a default if it wasn't saved properly
-------------------------------------------------------------------------------
function CustomSettings.LoadWString( settingName, defaultValue )
    local value = L""

    -- Get the raw saved values
    settingName = CustomSettings.SettingPrefix .. settingName
    local index = CustomSettings.GetSettingIndex( settingName )

    local xywh = {}
	if index ~= nil then
			local x = SystemData.Settings.Interface.WindowPositions.WindowPosX[index]
			local y = SystemData.Settings.Interface.WindowPositions.WindowPosY[index]
			local w = SystemData.Settings.Interface.WindowPositions.WindowWidth[index]
			local h = SystemData.Settings.Interface.WindowPositions.WindowHeight[index]
			xywh[1] =  x
			xywh[2] =  y
			xywh[3] =  w
			xywh[4] =  h 
	end
	
    
    
    for i=1,CustomSettings.ExtraSettingsPerString do
        local index = CustomSettings.GetSettingIndex( settingName.."_"..i )
		if index ~= nil then
				local x = SystemData.Settings.Interface.WindowPositions.WindowPosX[index]
				local y = SystemData.Settings.Interface.WindowPositions.WindowPosY[index]
				local w = SystemData.Settings.Interface.WindowPositions.WindowWidth[index]
				local h = SystemData.Settings.Interface.WindowPositions.WindowHeight[index]
				xywh[i*4 + 1] = x
				xywh[i*4 + 2] = y
				xywh[i*4 + 3] = w
				xywh[i*4 + 4] = h
		end
    end
    -- Convert the raw values into a string
    local offset = CustomSettings.AsciiStartIndex - 1
    for i,v in ipairs( xywh ) do
        local done = false
        while v > 0 and not done do
            local i = math.floor( v / CustomSettings.AsciiSize )
            local d = v % CustomSettings.AsciiSize
            v = i;
            d = d - offset
            if d > 0 then
                value = value..CustomSettings.WAscii[d]
            elseif d == -offset then
                done = true
                break
            else
                -- An invalid character was saved
                Debug.Print("CustomSettings.LoadString: An invalid character was found - "..d)
                done = true
                value = nil
                break
            end
        end
        if done then
            break
        end
    end

    -- Check to make sure we at least got one letter
    if value == L"" or value == nil then
        value = defaultValue
    end

    -- Return the value
    return value
end

-------------------------------------------------------------------------------
-- CustomSettings.SaveChanges
-- Description:
--     Raises the event that causes the client to actually save the window data
--     where the custom settings are stored
-------------------------------------------------------------------------------
function CustomSettings.SaveChanges(prop)
	--BroadcastEvent( SystemData.Events.USER_SETTINGS_CHANGED )
	-- No longer neccessary with the Enhanced Client
	--Debug.Print("Save " .. prop)
	--UserSettingsChanged()
end


