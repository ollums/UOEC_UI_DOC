----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

BookTemplate = {}

BookTemplate.OpenBooks = {}

BookTemplate.TempBooks = {}
BookTemplate.LOG = "Book"
BookTemplate.LOG_LOCATION = "logs/books.txt"

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function BookTemplate.Initialize()
	local bookId = WindowData.Book.ObjectId
	local bookWindowName = SystemData.ActiveWindow.name
	WindowSetScale(bookWindowName, 0.85)
 	BookTemplate.OpenBooks[bookId] = {}
	BookTemplate.OpenBooks[bookId]["pageNums"] = {0,1}
	BookTemplate.OpenBooks[bookId].canEdit = WindowData.Book.CanEdit
	BookTemplate.OpenBooks[bookId].numPages = WindowData.Book.NumPages
	BookTemplate.OpenBooks[bookId].author = WindowData.Book.Author
	BookTemplate.OpenBooks[bookId].title = WindowData.Book.Title

	WindowRegisterEventHandler(bookWindowName, SystemData.Events.BOOK_PAGE_DATA_RECIEVED, "BookTemplate.UpdatePageText")
	Interface.DestroyWindowOnClose[bookWindowName] = true
    WindowSetId (bookWindowName, WindowData.Book.ObjectId)

    WindowUtils.SetWindowTitle(bookWindowName, WindowData.Book.Title)

    local titlePageWindowName = bookWindowName.."TitlePage"
    CreateWindowFromTemplate( titlePageWindowName, "TitlePageTemplate", bookWindowName )
	
	local texture = 510
		
		local xSize, ySize
		local scale = 1.3
		texture, xSize, ySize = RequestGumpArt( texture )
		local textureSize = xSize
		
		if (textureSize < ySize) then
			textureSize = ySize
		end
WindowSetDimensions(  bookWindowName, xSize * scale, ySize * scale )
		WindowSetDimensions(  bookWindowName.."LegacyBook", xSize * scale, ySize * scale )
		DynamicImageSetTexture( bookWindowName.."LegacyBook", texture, 0, 0 )
		DynamicImageSetTextureScale( bookWindowName.."LegacyBook", scale )
		
		texture = 511

		texture, xSize, ySize = RequestGumpArt( texture )
		local textureSize = xSize
		xSize = xSize -1
		ySize = ySize - 2
		if (textureSize < ySize) then
			textureSize = ySize
		end

		WindowSetDimensions(  bookWindowName.."PageDownButton", xSize * scale, ySize * scale )
		ButtonSetTexture( bookWindowName.."PageDownButton", Button.ButtonState.NORMAL, texture, 0, 0 )
		ButtonSetTexture( bookWindowName.."PageDownButton", Button.ButtonState.HIGHLIGHTED, texture, 0, 0 )
		ButtonSetTexture( bookWindowName.."PageDownButton", Button.ButtonState.PRESSED, texture, 0, 0 )
		ButtonSetTexture( bookWindowName.."PageDownButton", Button.ButtonState.PRESSED_HIGHLIGHTED, texture, 0, 0 )
		
		texture = 512

		texture, xSize, ySize = RequestGumpArt( texture )
		local textureSize = xSize
		xSize = xSize 
		ySize = ySize - 4
		if (textureSize < ySize) then
			textureSize = ySize
		end

		WindowSetDimensions(  bookWindowName.."PageUpButton", xSize * scale, ySize * scale )
		ButtonSetTexture( bookWindowName.."PageUpButton", Button.ButtonState.NORMAL, texture, 0, 0 )
		ButtonSetTexture( bookWindowName.."PageUpButton", Button.ButtonState.HIGHLIGHTED, texture, 0, 0 )
		ButtonSetTexture( bookWindowName.."PageUpButton", Button.ButtonState.PRESSED, texture, 0, 0 )
		ButtonSetTexture( bookWindowName.."PageUpButton", Button.ButtonState.PRESSED_HIGHLIGHTED, texture, 0, 0 )
		
		WindowAddAnchor( bookWindowName.."LegacyBook", "topleft", bookWindowName, "topleft", 0, 0)
		WindowSetShowing( bookWindowName.."LegacyBook", true )
		WindowSetShowing( bookWindowName.."Chrome", false )

	if (WindowData.Book.CanEdit) then
		WindowSetShowing(titlePageWindowName.."Title", false)
		TextEditBoxSetText(titlePageWindowName.."EditTitle", WindowData.Book.Title)
		WindowAssignFocus(titlePageWindowName.."EditTitle",true)
		
		WindowSetShowing(titlePageWindowName.."Author", false)
		TextEditBoxSetText(titlePageWindowName.."EditAuthor", WindowData.Book.Author)
		
		WindowSetShowing(bookWindowName.."Page1Text", false)
		WindowSetShowing(bookWindowName.."Page2Text", false)
	else
		WindowSetShowing(titlePageWindowName.."EditTitle", false)
		LabelSetText(titlePageWindowName.."Title", WindowData.Book.Title)
		
		WindowSetShowing(titlePageWindowName.."EditAuthor", false)
		LabelSetText(titlePageWindowName.."Author", WindowData.Book.Author)
		
		WindowSetShowing(bookWindowName.."Page1EditText", false)
		WindowSetShowing(bookWindowName.."Page2EditText", false)
	end

	--LabelSetText(titlePageWindowName.."Author", BookTemplate.OpenBooks[bookId].author)
	LabelSetText(bookWindowName.."Page2Number", L"1")
	
	TextEditBoxSetTextColor(bookWindowName.."Page1EditText",0,0,0)
	TextEditBoxSetTextColor(bookWindowName.."Page2EditText",0,0,0)
	TextEditBoxSetTextColor(titlePageWindowName.."EditTitle",0,0,0)
	TextEditBoxSetTextColor(titlePageWindowName.."EditAuthor",0,0,0)
	LabelSetTextColor (bookWindowName.."Page1Text", 0, 0, 0)
	LabelSetTextColor (bookWindowName.."Page2Text", 0, 0, 0)

	WindowSetShowing(bookWindowName.."PageDownButton", false)
	WindowSetShowing(bookWindowName.."PageUpButton", false)

    if (BookTemplate.OpenBooks[bookId].numPages > 1) then
        WindowSetShowing(bookWindowName.."PageUpButton", true)
    end

	
    GumpManagerRequestBookPages(bookId, {1})
    
     if (EnhancePack.BookLog) then
		local NumPages = WindowData.Book.NumPages
	    
		if (not BookTemplate.TempBooks[bookId]) then
			BookTemplate.LOG = "Book" .. bookId
			TextLogCreate( BookTemplate.LOG, 1 )
			local bookTitle = WStringToString(WindowData.Book.Title)
			bookTitle = string.gsub(bookTitle, "[/]", " ")
			bookTitle = string.gsub(bookTitle, "[\\]", " ")
			bookTitle = string.gsub(bookTitle, ":", " ")
			bookTitle = string.gsub(bookTitle, "[*]", " ")
			bookTitle = string.gsub(bookTitle, "?", " ")
			bookTitle = string.gsub(bookTitle, "[\"]", " ")
			bookTitle = string.gsub(bookTitle, "<", " ")
			bookTitle = string.gsub(bookTitle, "[>]", " ")
			bookTitle = string.gsub(bookTitle, "[|]", " ")
			
			if( EnhancePack.Clock.h < 10) then
				clockhstr = "0"..tostring(EnhancePack.Clock.h)
			else
				clockhstr = tostring(EnhancePack.Clock.h)
			end
			if( EnhancePack.Clock.m < 10) then
				clockmstr = "0"..tostring(EnhancePack.Clock.m)
			else
				clockmstr = tostring(EnhancePack.Clock.m)
			end
			if( EnhancePack.Clock.s < 10) then
				clocksstr = "0"..tostring(EnhancePack.Clock.s)
			else
				clocksstr = tostring(EnhancePack.Clock.s)
			end
			local clockstring = clockhstr.."."..clockmstr.."."..clocksstr
			
			BookTemplate.LOG_LOCATION = "logs/" .. "[" .. bookId .. " - " .. clockstring .. "] " .. bookTitle .. ".txt"
			TextLogSetIncrementalSaving( BookTemplate.LOG, true, BookTemplate.LOG_LOCATION )


		    
			TextLogSetEnabled( BookTemplate.LOG, true )
			
			BookTemplate.TempBooks[bookId] = {}
			BookTemplate.TempBooks[bookId].text = "\r\n" ..WStringToString( WindowData.Book.Title) .. "\r\nby " .. WStringToString(WindowData.Book.Author) .. "\r\n\r\n"
			BookTemplate.TempBooks[bookId].pages = {}
		end
	end
end

function BookTemplate.Shutdown()
	local bookId = WindowGetId(SystemData.ActiveWindow.name)
	if (EnhancePack.BookLog) then
		if (BookTemplate.TempBooks[bookId].text) then
			
			local text = BookTemplate.TempBooks[bookId].text
			for i =1, #BookTemplate.TempBooks[bookId].pages do
				text = text .. "\r\n" .. BookTemplate.TempBooks[bookId].pages[i]
			end
			TextLogAddEntry( BookTemplate.LOG, 1,  StringToWString(text) )
		end
		TextLogSetEnabled(BookTemplate.LOG, false)
		TextLogDestroy(BookTemplate.LOG)
		BookTemplate.TempBooks[bookId] = nil
	end
    
    
    if( BookTemplate.OpenBooks[bookId].canEdit ) then
        BookTemplate.StoreText()
    end
    
    BookTemplate.OpenBooks[bookId] = nil
end

function BookTemplate.PageUp()

    local bookId = WindowGetId(WindowUtils.GetActiveDialog())
    local bookWindowName = WindowUtils.GetActiveDialog()
    local requestPages = {}

    WindowSetShowing(bookWindowName.."PageUpButton", false)
    WindowSetShowing(bookWindowName.."TitlePage", false)

	if (BookTemplate.OpenBooks[bookId]["pageNums"][1] + 2 <= BookTemplate.OpenBooks[bookId].numPages) then

		-- If previously at title page, show PageDownButton
	    if (BookTemplate.OpenBooks[bookId]["pageNums"][1] == 0) then
	        BookTemplate.EnterTitle()
			WindowSetShowing(bookWindowName.."PageDownButton", true)
    	end

		WindowSetShowing(bookWindowName.."Page1EditText", true)
    	-- If left page is last page
    	if (BookTemplate.OpenBooks[bookId]["pageNums"][1] + 2 == BookTemplate.OpenBooks[bookId].numPages) then
    	    requestPages[1] = BookTemplate.OpenBooks[bookId]["pageNums"][1] + 2
    	    
    	-- If both right and left pages contain text
    	else
    	    requestPages[1] = BookTemplate.OpenBooks[bookId]["pageNums"][1] + 2
    	    requestPages[2] = BookTemplate.OpenBooks[bookId]["pageNums"][2] + 2
		end
		
		if (BookTemplate.OpenBooks[bookId].canEdit) then
      		BookTemplate.StoreText()
    	end

        BookTemplate.OpenBooks[bookId]["pageNums"][1] = BookTemplate.OpenBooks[bookId]["pageNums"][1] + 2
        BookTemplate.OpenBooks[bookId]["pageNums"][2] = BookTemplate.OpenBooks[bookId]["pageNums"][2] + 2

        -- If there are more pages
		if (BookTemplate.OpenBooks[bookId]["pageNums"][1] + 2 <= BookTemplate.OpenBooks[bookId].numPages) then
		    WindowSetShowing(bookWindowName.."PageUpButton", true)
		end

        BookTemplate.UpdatePageNumbers()
    	GumpManagerRequestBookPages(bookId, requestPages)
    	
    end
end

function BookTemplate.PageDown()
    local bookId = WindowGetId(WindowUtils.GetActiveDialog())
    local bookWindowName = WindowUtils.GetActiveDialog()
    local requestPages = {}

	if (BookTemplate.OpenBooks[bookId]["pageNums"][1] - 2 >= 0) then

		-- If going to title page, hide PageDownButton
	    if (BookTemplate.OpenBooks[bookId]["pageNums"][1] - 2 == 0) then
			WindowSetShowing(bookWindowName.."PageDownButton", false)
			
			WindowSetShowing(bookWindowName.."Page1EditText", false)
    	    requestPages[1] = BookTemplate.OpenBooks[bookId]["pageNums"][2] - 2

    	-- If both right and left pages contain text
    	else
    		WindowSetShowing(bookWindowName.."Page1EditText", true)
			requestPages[1] = BookTemplate.OpenBooks[bookId]["pageNums"][1] - 2
    	    requestPages[2] = BookTemplate.OpenBooks[bookId]["pageNums"][2] - 2
		end
		
  		if (BookTemplate.OpenBooks[bookId].canEdit) then
      		BookTemplate.StoreText()
    	end

        BookTemplate.OpenBooks[bookId]["pageNums"][1] = BookTemplate.OpenBooks[bookId]["pageNums"][1] - 2
        BookTemplate.OpenBooks[bookId]["pageNums"][2] = BookTemplate.OpenBooks[bookId]["pageNums"][2] - 2

        -- If there are more pages
		if (BookTemplate.OpenBooks[bookId]["pageNums"][2] <= BookTemplate.OpenBooks[bookId].numPages) then
		    WindowSetShowing(bookWindowName.."PageUpButton", true)
		end

        BookTemplate.UpdatePageNumbers()
    	GumpManagerRequestBookPages(bookId, requestPages)
    end
end

function BookTemplate.Commalines(str)
  local t = {}
  local function helper(line) table.insert(t, line) return "" end
  helper((str:gsub("(.-)\n", helper)))
  return t
end

function BookTemplate.FormatProperly(str, bookId)
	if str == L"" then
		return str
	end
	str = wstring.gsub(str,wstring.char(13),L"\r\n")
	str = wstring.gsub(str,wstring.char(10),L"\r\n")
	return str

end

function BookTemplate.EditBoxFormat(str, bookId)
	if str == L"" then
		return L""
	end
	local lgt = wstring.len(str)
	str = wstring.gsub(str,L"\r\n",L"\n")
	str = wstring.gsub(str,L"<BR>",L"\n")
	str = wstring.gsub(str,wstring.char(13),L"\n")
	str = wstring.gsub(str,wstring.char(10),L"\n")
	
	local lines = BookTemplate.Commalines(WStringToString(str))
	
	local newLines = {}
	
	for i=1, #lines do
		local str = StringToWString(lines[i])
		if ( wstring.len(str) > 24) then
			for j= 0, wstring.len(str), 24 do
				table.insert(newLines, wstring.sub(str, j, j+23))
			end
		else
			table.insert(newLines, StringToWString(lines[i]))
		end
	end
	
	str = L""
	for i=1, #newLines do
		str = str .. newLines[i] .. L"\n"
	end
	
	return str
	
end

BookTemplate.Updating = false


function BookTemplate.UpdatePageText()
	BookTemplate.Updating = true
    local bookWindowName = WindowUtils.GetActiveDialog()
    local bookId = WindowGetId(bookWindowName)
    local updateId = WindowData.Book.ObjectId
    local page1Set = false
    local page2Set = false
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		TextEditBoxSetFont(bookWindowName.."Page1EditText",  "UO_book_ASIA")
	end
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(bookWindowName.."Page1Text",  "UO_book_ASIA", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		TextEditBoxSetFont(bookWindowName.."Page2EditText",  "UO_book_ASIA")
	end
	if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
		LabelSetFont(bookWindowName.."Page2Text",  "UO_book_ASIA", WindowUtils.FONT_DEFAULT_TEXT_LINESPACING)
	end
					
    if( bookId == updateId and BookTemplate.OpenBooks[bookId] ~= nil ) then
        for index,pageNum in ipairs(WindowData.Book.PageNums) do
            if( BookTemplate.OpenBooks[bookId]["pageNums"][1] ~= nil and BookTemplate.OpenBooks[bookId]["pageNums"][1] == pageNum ) then
				WindowClearAnchors(bookWindowName.."Page1Text")
				WindowAddAnchor(bookWindowName.."Page1Text", "topright" , bookWindowName.."Page1", "topright", -20, 40)
				WindowClearAnchors(bookWindowName.."Page1EditText")
				WindowAddAnchor(bookWindowName.."Page1EditText", "topright" , bookWindowName.."Page1", "topright", -10, 30)
				
				local text = BookTemplate.FormatProperly(WindowData.Book.Pages[index], bookId)
                if (BookTemplate.OpenBooks[bookId].canEdit) then
					
                    TextEditBoxSetText(bookWindowName.."Page1EditText", text)
				else
					
					LabelSetText(bookWindowName.."Page1Text", text)
				end
				if (EnhancePack.BookLog) then
					text = tostring(WindowData.Book.Pages[index])

					text = string.gsub(text,"#######################################################\n#######################################################", "")
					text = string.gsub(text,string.char(10),"\r\n")
				
					BookTemplate.TempBooks[bookId].pages[pageNum] =  text
				end
                page1Set = true
            elseif( BookTemplate.OpenBooks[bookId]["pageNums"][1] ~= nil and BookTemplate.OpenBooks[bookId]["pageNums"][2] == pageNum ) then
				WindowClearAnchors(bookWindowName.."Page2Text")
				WindowAddAnchor(bookWindowName.."Page2Text", "topleft" , bookWindowName.."Page2", "topleft", 20, 40)
				WindowClearAnchors(bookWindowName.."Page2EditText")
				WindowAddAnchor(bookWindowName.."Page2EditText", "topleft" , bookWindowName.."Page2", "topleft", 10, 30)
				local text = BookTemplate.FormatProperly(WindowData.Book.Pages[index], bookId)

                if (BookTemplate.OpenBooks[bookId].canEdit) then
					
                    TextEditBoxSetText(bookWindowName.."Page2EditText", text)
				else
					
					LabelSetText(bookWindowName.."Page2Text", text)
				end
				if (EnhancePack.BookLog) then
					text =tostring(WindowData.Book.Pages[index])

					text = string.gsub(text,"#######################################################\n#######################################################", "")
					text = string.gsub(text,string.char(10),"\r\n")
				

					BookTemplate.TempBooks[bookId].pages[pageNum] =  text
				end
                page2Set = true
            end
        end

        if (BookTemplate.OpenBooks[bookId]["pageNums"][1]  == 0) then
        
            LabelSetText(bookWindowName.."Page1Text", L"")
            local titlePageWindowName = bookWindowName.."TitlePage"
            WindowSetShowing(titlePageWindowName, true)

            if (BookTemplate.OpenBooks[bookId].canEdit) then
				if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
					TextEditBoxSetFont(titlePageWindowName.."EditTitle",  "UO_book_ASIA")
				end
				if (SystemData.Settings.Language.type ~= SystemData.Settings.Language.LANGUAGE_ENU) then
					TextEditBoxSetFont(titlePageWindowName.."EditAuthor",  "UO_book_ASIA")
				end
				TextEditBoxSetText(titlePageWindowName.."EditTitle", BookTemplate.OpenBooks[bookId].title)
				WindowAssignFocus(titlePageWindowName.."EditTitle",true)
				TextEditBoxSetText(titlePageWindowName.."EditAuthor", BookTemplate.OpenBooks[bookId].author)
			end

        elseif( BookTemplate.OpenBooks[bookId]["pageNums"][1] == BookTemplate.OpenBooks[bookId].numPages) then
            LabelSetText(bookWindowName.."Page2Text", L"")

        elseif( BookTemplate.OpenBooks[bookId]["pageNums"][1]  ~= 0) then
            WindowSetShowing(bookWindowName.."TitlePage", false)
        end

    end
    
   
	BookTemplate.Updating = false
end

function BookTemplate.UpdatePageNumbers()
	local bookId = WindowGetId(WindowUtils.GetActiveDialog())
    local bookWindowName = WindowUtils.GetActiveDialog()
    
	if (BookTemplate.OpenBooks[bookId]["pageNums"][1]) then
		WindowClearAnchors(bookWindowName.."Page1Number")
		WindowAddAnchor(bookWindowName.."Page1Number", "bottom", bookWindowName.."Page1", "bottom", 0, -33)
		if (BookTemplate.OpenBooks[bookId]["pageNums"][1] == 0) then
			LabelSetText(bookWindowName.."Page1Number", L"")	
		else
			LabelSetText(bookWindowName.."Page1Number", StringToWString(tostring(BookTemplate.OpenBooks[bookId]["pageNums"][1])))
		end
	end
	if (BookTemplate.OpenBooks[bookId]["pageNums"][2]) then
		WindowClearAnchors(bookWindowName.."Page2Number")
		WindowAddAnchor(bookWindowName.."Page2Number", "bottom", bookWindowName.."Page2", "bottom", -20, -33)
		LabelSetText(bookWindowName.."Page2Number", StringToWString(tostring(BookTemplate.OpenBooks[bookId]["pageNums"][2])))
	end
end

function BookTemplate.EnterTitle()
	local bookWindowName = WindowUtils.GetActiveDialog()
    local bookId = WindowGetId(bookWindowName)
    local bookTitleEditBoxName = bookWindowName.."TitlePageEditTitle"
    
    BookTemplate.OpenBooks[bookId].title = TextEditBoxGetText(bookTitleEditBoxName)

    if (BookTemplate.OpenBooks[bookId].title) then
    	WindowAssignFocus(bookWindowName.."TitlePageEditTitle",false)
		GumpManagerSendAuthorTitle(bookId, BookTemplate.OpenBooks[bookId].title, BookTemplate.OpenBooks[bookId].author)
		WindowUtils.SetWindowTitle(bookWindowName, BookTemplate.OpenBooks[bookId].title)
	end
end

function BookTemplate.EnterAuthor()
	local bookWindowName = WindowUtils.GetActiveDialog()
    local bookId = WindowGetId(bookWindowName)
    local bookAuthorEditBoxName = bookWindowName.."TitlePageEditAuthor"
    
    BookTemplate.OpenBooks[bookId].author = TextEditBoxGetText(bookAuthorEditBoxName)

    if (BookTemplate.OpenBooks[bookId].author) then
    	WindowAssignFocus(bookWindowName.."TitlePageEditAuthor",false)
		GumpManagerSendAuthorTitle(bookId, BookTemplate.OpenBooks[bookId].title, BookTemplate.OpenBooks[bookId].author)
	end
end

function BookTemplate.StoreText()
    local bookWindowName = WindowUtils.GetActiveDialog()
    local bookId = WindowGetId(bookWindowName)
    local page1Text = BookTemplate.EditBoxFormat(TextEditBoxGetText(bookWindowName.."Page1EditText"), bookId)
	local page2Text = BookTemplate.EditBoxFormat(TextEditBoxGetText(bookWindowName.."Page2EditText"), bookId)

    pageText = {}
    pageNums = {}
    if( BookTemplate.OpenBooks[bookId]["pageNums"][1]  == 0) then
        pageNums[1] = BookTemplate.OpenBooks[bookId]["pageNums"][2]
        pageText[1] = page2Text
        --Debug.Print("Page "..tostring(pageNums[1])..", "..tostring(pageText[1]))
    else
        pageNums[1] = BookTemplate.OpenBooks[bookId]["pageNums"][1]
        pageNums[2] = BookTemplate.OpenBooks[bookId]["pageNums"][2]
        pageText[1] = page1Text
        pageText[2] = page2Text
        --Debug.Print("Page "..tostring(pageNums[1])..", "..tostring(pageText[1]))
        --Debug.Print("Page "..tostring(pageNums[2])..", "..tostring(pageText[2]))
    end
    
	GumpManagerSendBookPages(bookId, pageNums, pageText )
end