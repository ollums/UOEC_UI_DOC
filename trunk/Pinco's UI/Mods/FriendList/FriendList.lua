----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

FriendList = {}

FriendList.VisibleItems = 0
FriendList.List = {}


-- OnInitialize Handler
function FriendList.Initialize()
	WindowUtils.RestoreWindowPosition("FriendList", false)
	
	WindowUtils.SetWindowTitle("FriendList", UI.GetCliloc(SystemData.Settings.Language.type, 852))
	WindowSetShowing("FriendList", false)
   
	WindowSetDimensions("FriendList", 1330, 450)
	ButtonSetText("FriendListAddFriendButton", UI.GetCliloc(SystemData.Settings.Language.type, 854))
    ButtonSetDisabledFlag( "FriendListAddFriendButton", false )
    CreateWindowFromTemplate( "FriendListHeader", "FriendGridHeaderTemplate", "FriendList" )
    WindowAddAnchor("FriendListHeader", "topleft", "FriendList", "topleft", 30, 20)

    LabelSetText("FriendListHeaderNAMELabel", L"NAME")

    LabelSetText("FriendListHeaderIDLabel", L"ID")

    LabelSetText("FriendListHeaderICQLabel", L"ICQ")

    LabelSetText("FriendListHeaderEMAILLabel", L"e-Mail")

    LabelSetText("FriendListHeaderTWITTERLabel", L"Twitter")

    LabelSetText("FriendListHeaderFACEBOOKLabel", L"Facebook")

    FriendList.LoadList()
end

function FriendList.Shutdown()
	WindowUtils.SaveWindowPosition("FriendList", false)
	WindowSetShowing("FriendList", false)   
end


function FriendList.OnAddFriendButton()
	RequestTargetInfo()
	EnhancePack.SendOverheadText(UI.GetCliloc(SystemData.Settings.Language.type, 853), 1152, true)
	WindowRegisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT, "FriendList.OnAddFriendTargetInfoReceived")
end

function FriendList.IsFriend(mobileId)
	for k=1, table.getn(FriendList.List) do
		if (FriendList.List[k].id == mobileId) then
			return true
		end
	end
	return false
end

function FriendList.LoadList()
	local num = CustomSettings.LoadNumber( "FriendListNum" , 0 )
	for i = 1, num do
		local item = {id = CustomSettings.LoadNumber( "FriendListID" .. i, 0   ) , name = CustomSettings.LoadWString( "FriendListName" .. i, L""   ) , icq = CustomSettings.LoadWString( "FriendListIcq" .. i, L""   ) , email = CustomSettings.LoadWString( "FriendListEmail" .. i, L""   ) , twitter = CustomSettings.LoadWString( "FriendListTwitter" .. i, L""   ) , facebook = CustomSettings.LoadWString( "FriendListFacebook" .. i, L""   )}
		table.insert(FriendList.List, item)
	end
	FriendList.UpdateList()
end

function FriendList.OnAddFriendTargetInfoReceived()
	WindowUnregisterEventHandler("Root", SystemData.Events.TARGET_SEND_ID_CLIENT)
	local mobileId = SystemData.RequestInfo.ObjectId 
	if (not mobileId or not IsMobile(mobileId) or mobileId == WindowData.PlayerStatus.PlayerId) then
		return
	end
	for k=1, table.getn(FriendList.List) do
		if (FriendList.List[k].id == mobileId) then
			return
		end
	end
	RegisterWindowData(WindowData.MobileName.Type, mobileId)
	local item = {name = WindowData.MobileName[mobileId].MobName, id = mobileId, icq= L"", email= L"", twitter= L"", facebook= L""}
	table.insert(FriendList.List, item)
	FriendList.UpdateList()
	CustomSettings.SaveNumber( "FriendListNum" , FriendList.VisibleItems )
	CustomSettings.SaveNumber( "FriendListID" .. FriendList.VisibleItems  , mobileId )
	CustomSettings.SaveWString( "FriendListName" .. FriendList.VisibleItems  , item.name )
	CustomSettings.SaveWString( "FriendListIcq" .. FriendList.VisibleItems  , L"" )
	CustomSettings.SaveWString( "FriendListEmail" .. FriendList.VisibleItems  , L"" )
	CustomSettings.SaveWString( "FriendListTwitter" .. FriendList.VisibleItems  , L"" )
	CustomSettings.SaveWString( "FriendListFacebook" .. FriendList.VisibleItems  , L"" )
	UnregisterWindowData(WindowData.MobileName.Type, mobileId)
end

function FriendList.Context()
	local this = SystemData.ActiveWindow.name
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5015),0,"REMOVE",this,false)
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5011),0,"ICQ",this,false)
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5012),0,"EMAIL",this,false)
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5013),0,"TWITTER",this,false)
	ContextMenu.CreateLuaContextMenuItemWithString(UI.GetCliloc(SystemData.Settings.Language.type, 5014),0,"FACEBOOK",this,false)
	
	ContextMenu.ActivateLuaContextMenu(FriendList.ContextMenuCallback)
end

function FriendList.ContextMenuCallback( returnCode, param )
	if (returnCode == "REMOVE") then
		FriendList.RemoveItem(param)
	elseif (returnCode == "ICQ") then
		local j = WindowGetId(WindowGetParent(param))
		local rdata = {title=UI.GetCliloc(SystemData.Settings.Language.type ,643) .. L" " .. towstring(returnCode), subtitle=GetStringFromTid(1062300), callfunction=FriendList.EditICQ, id=j}
		RenameWindow.Create(rdata)
	elseif (returnCode == "EMAIL") then
		local j = WindowGetId(WindowGetParent(param))
		local rdata = {title=UI.GetCliloc(SystemData.Settings.Language.type ,643) .. L" " .. towstring(returnCode), subtitle=GetStringFromTid(1062300), callfunction=FriendList.EditEMAIL, id=j}
		RenameWindow.Create(rdata)
	elseif (returnCode == "TWITTER") then
		local j = WindowGetId(WindowGetParent(param))
		local rdata = {title=UI.GetCliloc(SystemData.Settings.Language.type ,643) .. L" " .. towstring(returnCode), subtitle=GetStringFromTid(1062300), callfunction=FriendList.EditTWITTER, id=j}
		RenameWindow.Create(rdata)
	elseif (returnCode == "FACEBOOK") then
		local j = WindowGetId(WindowGetParent(param))
		local rdata = {title=UI.GetCliloc(SystemData.Settings.Language.type ,643) .. L" " .. towstring(returnCode), subtitle=GetStringFromTid(1062300), callfunction=FriendList.EditFACEBOOK, id=j}
		RenameWindow.Create(rdata)
	end
end

function FriendList.EditICQ(id, value)
	FriendList.List[id].icq = towstring(value)
	CustomSettings.SaveWString( "FriendListIcq" .. id  , towstring(value) )
	FriendList.UpdateList()
end

function FriendList.EditEMAIL(id, value)
	FriendList.List[id].email = value
	CustomSettings.SaveWString( "FriendListEmail" .. id  , towstring(value) )
	FriendList.UpdateList()
end

function FriendList.EditTWITTER(id, value)
	FriendList.List[id].twitter = value
	CustomSettings.SaveWString( "FriendListTwitter" .. id  , towstring(value) )
	FriendList.UpdateList()
end

function FriendList.EditFACEBOOK(id, value)
	FriendList.List[id].facebook = value
	CustomSettings.SaveWString( "FriendListFacebook" .. id  , towstring(value) )
	FriendList.UpdateList()
end

function FriendList.OpenLink()
	local this = SystemData.ActiveWindow.name
	local value = tostring(LabelGetText(this .. "Label"))
	if string.find(this, "ICQ") then
		WebCall("http://www.icq.com/people/" .. value)
	elseif string.find(this, "EMAIL") then
		WebCall("mailto:" .. value)
	elseif string.find(this, "TWITTER") then	
		WebCall("https://twitter.com/#!/" .. value)
	elseif string.find(this, "FACEBOOK") then	
		WebCall("http://www.facebook.com/search.php?q=" .. value)
	end
end

function FriendList.RemoveItem(this)
	--local this = SystemData.ActiveWindow.name
	local okayButton = { textTid=1011036, callback=function()FriendList.ExeRemoveItem(this)end }
	local cancelButton = { textTid=UO_StandardDialog.TID_CANCEL}
	local DestroyConfirmWindow = 
				{
					windowName = "RemoveItem",
					title =  UI.GetCliloc(SystemData.Settings.Language.type, 618),
					body =  UI.GetCliloc(SystemData.Settings.Language.type, 855),
					buttons = { okayButton, cancelButton }
				}
	UO_StandardDialog.CreateDialog(DestroyConfirmWindow)
end

function FriendList.ExeRemoveItem(windowName)
	local this = windowName
	local j = WindowGetId(WindowGetParent(this))
	
	CustomSettings.DeleteStringSetting( "FriendListNum"  )
	for k=1, table.getn(FriendList.List) do
		
		CustomSettings.DeleteSetting( "FriendListID" .. k   )
		CustomSettings.DeleteSetting( "FriendListName" .. k   )
	end
	table.remove(FriendList.List,j)
	for k=1, table.getn(FriendList.List) do
		local item = FriendList.List[k]
		CustomSettings.SaveNumber( "FriendListID" .. k  , item.id )
		CustomSettings.SaveWString( "FriendListName" .. k  , item.name )
	end
	CustomSettings.SaveNumber( "FriendListNum" ,  table.getn(FriendList.List)  )
	FriendList.UpdateList()
end

function FriendList.LinkMouseOver()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)

	LabelSetTextColor(this .. "Label",0,160,230)

end

function FriendList.ItemMouseOver()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	LabelSetTextColor(parent .. "NAMELabel",255,0,0)
	LabelSetTextColor(parent .. "IDLabel",255,0,0)
	LabelSetTextColor(parent .. "ICQLabel",255,0,0)
	LabelSetTextColor(parent .. "EMAILLabel",255,0,0)
	LabelSetTextColor(parent .. "TWITTERLabel",255,0,0)
	LabelSetTextColor(parent .. "FACEBOOKLabel",255,0,0)
end

function FriendList.ClearMouseOverItem()
	local this = SystemData.ActiveWindow.name
	local parent = WindowGetParent(this)
	LabelSetTextColor(parent .. "NAMELabel",255,255,255)
	LabelSetTextColor(parent .. "IDLabel",255,255,255)
	LabelSetTextColor(parent .. "ICQLabel",255,255,255)
	LabelSetTextColor(parent .. "EMAILLabel",2255,255,255)
	LabelSetTextColor(parent .. "TWITTERLabel",255,255,255)
	LabelSetTextColor(parent .. "FACEBOOKLabel",255,255,255)
end

function FriendList.ClearList()
	for j=1, FriendList.VisibleItems do
		if (DoesWindowNameExist("Item" .. j)) then
			DestroyWindow("Item" .. j)
		end
	end
end

function FriendList.UpdateList()
	FriendList.ClearList()

	local last = 0
	local scrollChild = "FriendListListScrollWindowScrollChild"
	for i=1, table.getn(FriendList.List) do

		local item = FriendList.List[i]
		CreateWindowFromTemplate( "Item" .. i, "FriendGridTemplate", scrollChild )
		--WindowSetDimensions("Item" .. i, 680, 25)
		WindowSetId("Item"..i, i)
		WindowSetShowing("Item" .. i, true)
		LabelSetText("Item" .. i .. "NAMELabel", towstring(item.name) )
		LabelSetText("Item" .. i .. "IDLabel", towstring(item.id) )
		LabelSetText("Item" .. i .. "ICQLabel", towstring(item.icq) )
		LabelSetText("Item" .. i .. "EMAILLabel", towstring(item.email) )
		LabelSetText("Item" .. i .. "TWITTERLabel", towstring(item.twitter) )
		LabelSetText("Item" .. i .. "FACEBOOKLabel", towstring(item.facebook) )

		WindowClearAnchors("Item" .. i)
		if (i <= 1) then
			WindowAddAnchor("Item" .. i, "topleft", scrollChild, "topleft", 0, -15)
		else
			WindowAddAnchor("Item" .. i, "bottomleft", "Item" .. i-1, "topleft", 0, 0)
		end
		last = i
	end

	if last > 0 then
		local ySize = 20 + (40 * last)
		WindowSetDimensions(scrollChild,1270, ySize)
	end
	FriendList.VisibleItems = last
	ScrollWindowSetOffset( "FriendListListScrollWindow", 0 )
	ScrollWindowUpdateScrollRect("FriendListListScrollWindow" )


end