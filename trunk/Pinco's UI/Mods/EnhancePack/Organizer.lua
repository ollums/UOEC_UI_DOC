----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

Organizer = {}

Organizer.Organizers = 1
Organizer.Undresses = 1
Organizer.Restocks = 1
Organizer.Buys = 1
Organizer.Sells = 1
Organizer.Scavengers = 1

Organizer.ActiveOrganizer = 1
Organizer.ActiveUndress = 1
Organizer.ActiveRestock = 1
Organizer.ActiveBuy = 1
Organizer.ActiveSell = 1
Organizer.ActiveScavenger = 1

Organizer.Organizers_Items = {} -- number of items of every organizer
Organizer.Undresses_Items = {}
Organizer.Restocks_Items = {}
Organizer.Buys_Items = {}
Organizer.Sells_Items = {}
Organizer.Scavengers_Items = {}

Organizer.Organizers_Desc = {} -- custom name
Organizer.Undresses_Desc = {}
Organizer.Restocks_Desc = {}
Organizer.Buys_Desc = {}
Organizer.Sells_Desc = {}
Organizer.Scavengers_Desc = {}

Organizer.Organizers_Cont = {} -- default container
Organizer.Organizers_CloseCont = {} --close container flag
Organizer.Undresses_Cont = {}
Organizer.Restocks_Cont = {}
Organizer.Scavengers_Cont = {}



Organizer.Organizer = {} -- each item: { name=L"", type=NNNN, hue=NNNN, id=NNNN }
Organizer.Undress = {} -- each item: { name=L"", type=NNNN, hue=NNNN, id="id value" }
Organizer.Restock = {} -- each item: { name=L"", type=NNNN, hue=NNNN, id="id value" }
Organizer.Buy = {} -- each item: { name=L"", type=NNNN, hue=NNNN, id="id value" }
Organizer.Sell = {} -- each item: { name=L"", type=NNNN, hue=NNNN, id="id value" }
Organizer.Scavenger = {} -- each item: { name=L"", type=NNNN, hue=NNNN, id="id value" }

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------


function Organizer.Initialize()
	Organizer.Organizers = CustomSettings.LoadNumber( "OrganizerOrganizers" , 1 )
	Organizer.Undresses = CustomSettings.LoadNumber( "OrganizerUndresses" , 1 )
	Organizer.Restocks = CustomSettings.LoadNumber( "OrganizerRestocks" , 1 )
	Organizer.Buys = CustomSettings.LoadNumber( "OrganizerBuys" , 1 )
	Organizer.Sells = CustomSettings.LoadNumber( "OrganizerSells" , 1 )
	Organizer.Scavengers = CustomSettings.LoadNumber( "OrganizerScavengers" , 1 )
	
	Organizer.ActiveOrganizer = CustomSettings.LoadNumber( "OrganizerActiveOrganizer" , 1 )
	Organizer.ActiveUndress = CustomSettings.LoadNumber( "OrganizerActiveUndress" , 1 )
	Organizer.ActiveRestock = CustomSettings.LoadNumber( "OrganizerActiveRestock" , 1 )
	Organizer.ActiveBuy = CustomSettings.LoadNumber( "OrganizerActiveBuy" , 1 )
	Organizer.ActiveSell = CustomSettings.LoadNumber( "OrganizerActiveSell" , 1 )
	Organizer.ActiveScavenger = CustomSettings.LoadNumber( "OrganizerActiveScavenger" , 1 )

	for i=1, Organizer.Organizers do
		Organizer.Organizers_Items[i] =  CustomSettings.LoadNumber( "OrganizerOrganizers_Items" .. i , 0 )
		Organizer.Organizers_Desc[i] = CustomSettings.LoadWString( "OrganizerOrganizers_Desc" .. i , L"" )
		Organizer.Organizers_Cont[i] =  CustomSettings.LoadNumber( "OrganizerOrganizers_Cont" .. i , 0 )
		Organizer.Organizers_CloseCont[i] =  CustomSettings.LoadBoolean( "OrganizerOrganizers_CloseCont" .. i , false )
		if not Organizer.Organizer[i] then
			Organizer.Organizer[i] = {}
		end
		if (Organizer.Organizers_Items[i] > 0) then
			for j=1,  Organizer.Organizers_Items[i] do
				local item = {name="", type=0, hue=0, id=0}
				item.name = CustomSettings.LoadString( "Organizer" .. i .. "it" .. j .. "Name" , "Unnamed" )
				item.type = CustomSettings.LoadNumber( "Organizer" .. i .. "it" .. j .. "Type" , 0 )
				item.hue = CustomSettings.LoadNumber( "Organizer" .. i .. "it" .. j .. "Hue" , 0 )
				item.id = CustomSettings.LoadNumber( "Organizer" .. i .. "it" .. j .. "Id" , 0 )
				
				if not Organizer.Organizer[i][j] then
					Organizer.Organizer[i][j] = {}
				end
				Organizer.Organizer[i][j] = item
			end
		end
	end

	for i=1, Organizer.Undresses do
		Organizer.Undresses_Items[i] =  CustomSettings.LoadNumber( "OrganizerUndresses_Items" .. i , 0 )
		Organizer.Undresses_Desc[i] =  CustomSettings.LoadWString( "OrganizerUndresses_Desc" .. i , L"" )
		Organizer.Undresses_Cont[i] =  CustomSettings.LoadNumber( "OrganizerUndresses_Cont" .. i , 0 )
		if not Organizer.Undress[i] then
			Organizer.Undress[i] = {}
		end
		if (Organizer.Undresses_Items[i] > 0) then
			for j=1,  Organizer.Undresses_Items[i] do
				local item = {name="", type=0, hue=0, id=0}
				item.name = CustomSettings.LoadString( "Undress" .. i .. "it" .. j .. "Name" , "Unnamed" )
				item.type = CustomSettings.LoadNumber( "Undress" .. i .. "it" .. j .. "Type" , 0 )
				item.hue = CustomSettings.LoadNumber( "Undress" .. i .. "it" .. j .. "Hue" , 0 )
				item.id = CustomSettings.LoadNumber( "Undress" .. i .. "it" .. j .. "Id" , 0 )
				if not Organizer.Undress[i][j] then
					Organizer.Undress[i][j] = {}
				end
				Organizer.Undress[i][j] = item
			end
		end
	end

	for i=1, Organizer.Restocks do
		Organizer.Restocks_Items[i] =  CustomSettings.LoadNumber( "OrganizerRestocks_Items" .. i , 0 )
		Organizer.Restocks_Desc[i] =  CustomSettings.LoadWString( "OrganizerRestocks_Desc" .. i , L"" )
		Organizer.Restocks_Cont[i] =  CustomSettings.LoadNumber( "OrganizerRestocks_Cont" .. i , 0 )
		if not Organizer.Restock[i] then
			Organizer.Restock[i] = {}
		end
		if (Organizer.Restocks_Items[i] > 0) then
			for j=1 , Organizer.Restocks_Items[i] do
				local item = {name="", type=0, hue=0, qta=0}
				item.name = CustomSettings.LoadString( "Restock" .. i .. "it" .. j .. "Name" , "Unnamed" )
				item.type = CustomSettings.LoadNumber( "Restock" .. i .. "it" .. j .. "Type" , 0 )
				item.hue = CustomSettings.LoadNumber( "Restock" .. i .. "it" .. j .. "Hue" , 0 )
				item.qta = CustomSettings.LoadNumber( "Restock" .. i .. "it" .. j .. "Qta" , 0 )
				
				if not Organizer.Restock[i][j] then
					Organizer.Restock[i][j] = {}
				end
				Organizer.Restock[i][j] = item
			end
		end
	end

	for i=1, Organizer.Buys do
		Organizer.Buys_Items[i] =  CustomSettings.LoadNumber( "OrganizerBuys_Items" .. i , 0 )
		Organizer.Buys_Desc[i] =  CustomSettings.LoadWString( "OrganizerBuys_Desc" .. i , L"" )
		if not Organizer.Buy[i] then
			Organizer.Buy[i] = {}
		end
		if (Organizer.Buys_Items[i] > 0) then
			for j=1 , Organizer.Buys_Items[i] do
				local item = {name="", type=0, hue=0, qta=0}
				item.name = CustomSettings.LoadString( "Buy" .. i .. "it" .. j .. "Name" , "Unnamed" )
				item.type = CustomSettings.LoadNumber( "Buy" .. i .. "it" .. j .. "Type" , 0 )
				item.hue = CustomSettings.LoadNumber( "Buy" .. i .. "it" .. j .. "Hue" , 0 )
				item.qta = CustomSettings.LoadNumber( "Buy" .. i .. "it" .. j .. "Qta" , 0 )
				
				if not Organizer.Buy[i][j] then
					Organizer.Buy[i][j] = {}
				end
				Organizer.Buy[i][j] = item
			end
		end
	end

	for i=1, Organizer.Sells do
		Organizer.Sells_Items[i] =  CustomSettings.LoadNumber( "OrganizerSells_Items" .. i , 0 )
		Organizer.Sells_Desc[i] =  CustomSettings.LoadWString( "OrganizerSells_Desc" .. i , L"" )
		if not Organizer.Sell[i] then
			Organizer.Sell[i] = {}
		end
		if (Organizer.Sells_Items[i] > 0) then
			for j=1 , Organizer.Sells_Items[i] do
				local item = {name="", type=0, hue=0, qta=0}
				item.name = CustomSettings.LoadString( "Sell" .. i .. "it" .. j .. "Name" , "Unnamed" )
				item.type = CustomSettings.LoadNumber( "Sell" .. i .. "it" .. j .. "Type" , 0 )
				item.hue = CustomSettings.LoadNumber( "Sell" .. i .. "it" .. j .. "Hue" , 0 )
				item.qta = CustomSettings.LoadNumber( "Sell" .. i .. "it" .. j .. "Qta" , 0 )
				
				if not Organizer.Sell[i][j] then
					Organizer.Sell[i][j] = {}
				end
				Organizer.Sell[i][j] = item
			end
		end
	end
	
	for i=1, Organizer.Scavengers do
		Organizer.Scavengers_Items[i] =  CustomSettings.LoadNumber( "OrganizerScavengers_Items" .. i , 0 )
		Organizer.Scavengers_Desc[i] =  CustomSettings.LoadWString( "OrganizerScavengers_Desc" .. i , L"" )
		Organizer.Scavengers_Cont[i] =  CustomSettings.LoadNumber( "OrganizerScavengers_Cont" .. i , 0 )
		if not Organizer.Scavenger[i] then
			Organizer.Scavenger[i] = {}
		end
		if (Organizer.Scavengers_Items[i] > 0) then
			for j=1 , Organizer.Scavengers_Items[i] do
				local item = {name="", type=0, hue=0, qta=0}
				item.name = CustomSettings.LoadString( "Scavenger" .. i .. "it" .. j .. "Name" , "Unnamed" )
				item.type = CustomSettings.LoadNumber( "Scavenger" .. i .. "it" .. j .. "Type" , 0 )
				item.hue = CustomSettings.LoadNumber( "Scavenger" .. i .. "it" .. j .. "Hue" , 0 )
				item.qta = CustomSettings.LoadNumber( "Scavenger" .. i .. "it" .. j .. "Qta" , 0 )
				
				if not Organizer.Scavenger[i][j] then
					Organizer.Scavenger[i][j] = {}
				end
				Organizer.Scavenger[i][j] = item
			end
		end
	end
end