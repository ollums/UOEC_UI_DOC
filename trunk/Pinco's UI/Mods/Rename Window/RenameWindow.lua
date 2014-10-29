----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

RenameWindow = {}
RenameWindow.TextEntered = nil
RenameWindow.id = nil
RenameWindow.max = nil
RenameWindow.min = nil
RenameWindow.Callfunction = nil
----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------


----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function RenameWindow.Initialize()
	local WindowName = "RenameWindow"

	WindowUtils.SetWindowTitle(WindowName,L"")
	
	local submitButtonName = GGManager.translateTID(1077787)		-- "Submit"
	local clearButtonName = GGManager.translateTID(3000154)		-- "Clear"
	local cancelButtonName = GGManager.translateTID(GGManager.CANCEL_TID)

	ButtonSetText(WindowName.."SubmitButton", submitButtonName )
	ButtonSetText(WindowName.."ClearButton", clearButtonName )
	ButtonSetText(WindowName.."CancelButton", cancelButtonName )


	
end

function RenameWindow.Create(rdata)
	local WindowName = "RenameWindow"
	-- rdata.title: Line under the title
	-- rdata.subtitle: Line under the title
	-- rdata.text: Text in the rename Window
	-- rdata.callfunction: function to call after submit 
	-- rdata.id: id if need to convert
	-- Reset the Error Messages
	LabelSetText (WindowName.."Subtitle2",L"")
	WindowSetShowing("RenameWindow", true)
	WindowUtils.SetWindowTitle(WindowName,L"")
	if (rdata.title ~= nil) then
		WindowUtils.SetWindowTitle(WindowName,rdata.title)
	end
	if (rdata.subtitle ~= nil) then
		LabelSetText(WindowName.."Subtitle1", rdata.subtitle)
	end
	if (rdata.text ~= nil) then
		TextEditBoxSetText( WindowName.."TextEntryBox", rdata.text )
	else
		TextEditBoxSetText( WindowName.."TextEntryBox", L"" )
	end
	if (rdata.callfunction == nil) then
		Debug.Print("No call function")
	end
	if (rdata.id ~= nil) then
		RenameWindow.id = rdata.id
	end
	if (rdata.max ~= nil) then
		RenameWindow.max = rdata.max
	end
	if (rdata.min ~= nil) then
		RenameWindow.min = rdata.min
	end
	RenameWindow.Callfunction = rdata.callfunction 
	WindowAssignFocus(WindowName.."TextEntryBox", true)
	--Debug.Print("RENAME WINDOWS SHOWN")
end

function RenameWindow.OnClear()
	TextEditBoxSetText( "RenameWindowTextEntryBox", L"" )
	WindowAssignFocus("RenameWindowTextEntryBox", true)
end

function RenameWindow.OnKeyCancel()
	MainMenuWindow.notnow = true
	RenameWindow.OnCancel()
end

function RenameWindow.OnCancel()
	WindowSetShowing("RenameWindow", false)
end

function RenameWindow.OnSubmit()
	-- Global Variables 
	-- RenameWindow.TextEntered 
	-- RenameWindow.id 
	-- RenameWindow.Callfunction 
	
	local WindowName = "RenameWindow"
	local text_entered = TextEditBoxGetText( WindowName.."TextEntryBox" )
	if (text_entered ~= nil and text_entered ~= L"") then
		-- make sure there are no unicode chars in the string
		--local ValidString = SingleLineTextEntry.CheckForUnicodeChars (text_entered)
		--if (ValidString == true) then
			RenameWindow.TextEntered = text_entered
			RenameWindow.Callfunction(RenameWindow.id, RenameWindow.TextEntered, RenameWindow.max, RenameWindow.min)
			RenameWindow.OnCancel()
		--else
			-- tell player the string contained illegal characters and to try again
		--	LabelSetText (WindowName.."Subtitle2",GetStringFromTid(1079165))
		--	WindowAssignFocus(WindowName.."TextEntryBox", true)
			
		--end
	else
		-- tell player the string contained illegal characters and to try again
		LabelSetText (WindowName.."Subtitle2",GetStringFromTid(1079165))
		WindowAssignFocus(WindowName.."TextEntryBox", true)
	end
	

	
end


function RenameWindow.Shutdown()
	WindowSetShowing("RenameWindow", false)
end