
----------------------------------------------------------------
-- Global Variables
----------------------------------------------------------------

SkillsInfo = {}
SkillsInfo.DisplaySkill = 1

----------------------------------------------------------------
-- Local Variables
----------------------------------------------------------------

OFFSET_TITLE	= 1
OFFSET_DESC	= 2
OFFSET_REQ	= 3
OFFSET_DIRECT	= 4
OFFSET_INTER	= 5
OFFSET_AUTO	= 6
OFFSET_MORE	= 7

TID_WINDOW_NAME	= 1078584
TID_REQUIRES	= 1078597
TID_DIRECT	= 1078598
TID_INTERACTIVE	= 1078599
TID_AUTOMATIC	= 1078600
TID_MORE	= 1078601
TID_REQ_NOTHING = 1078611

BIG_SPACER	= 8
SMALL_SPACER	= 4
WIDE_SPACER	= 10
WINDOW_WIDTH	= 580

-- Title, Description, Requires, Direct, Interactive, Automatic, More
local skill01 = {1002000, 1078612, 1078613, 0, 1078614, 1078615, 1078616}	-- Alchemy
local skill02 = {1002004, 1078623, 0, 1078624, 0, 1078625, 1078626}		-- Anatomy
local skill03 = {1002007, 1078627, 0, 1078628, 0, 1078629, 1078630}		-- Animal Lore
local skill04 = {1002010, 1078631, 0, 1078632, 0, 0, 1078633}			-- Animal Taming
local skill05 = {1002029, 1078634, 1078635, 0, 1078636, 0, 1078637}		-- Archery
local skill06 = {1002034, 1078638, 0, 1078639, 0, 1078640, 1078641}		-- Arms Lore
local skill07 = {1002040, 1078642, 0, 1078643, 0, 0, 1078644}			-- Begging
local skill08 = {1044296, 1078645, 1078646, 0, 1078647, 0, 1078648}		-- Blacksmithy
local skill09 = {1044112, 1078649, 1078650, 0, 1078651, 0, 1078652}		-- Bushido
local skill10 = {1002050, 1078653, 1078654, 0, 1078655, 0, 1078656}		-- Camping
local skill11 = {1002054, 1078657, 1078658, 0, 1078659, 0, 1078660}		-- Carpentry
local skill12 = {1002057, 1078661, 1078662, 0, 1078663, 0, 1078664}		-- Cartography
local skill13 = {1044111, 1078665, 1078666, 0, 1078667, 0, 1078668}		-- Chivalry
local skill14 = {1002063, 1078669, 1078670, 0, 1078671, 0, 1078672}		-- Cooking
local skill15 = {1002065, 1078673, 0, 1078674, 0, 0, 1078675}			-- Detecting Hidden
local skill16 = {1044075, 1078676, 1078677, 1078678, 0, 0, 1078679}		-- Discordance
local skill17 = {1044076, 1078680, 0, 1078681, 0, 1078682, 1078683}		-- Evaluating Intelligence
local skill18 = {1002073, 1002074, 1078685, 0, 1078686, 0, 1078687}		-- Fencing
local skill19 = {1002076, 1078692, 1078693, 0, 1078694, 0, 1078695}		-- Fishing
local skill20 = {1015156, 1078688, 1078689, 0, 1078690, 0, 1078691}		-- Fletching
local skill21 = {1044110, 1078696, 0, 0, 0, 1078697, 1078698}			-- Focus
local skill22 = {1002078, 1078699, 0, 1078700, 0, 0, 1078701}			-- Forensic Evaluation
local skill23 = {1002082, 1078702, 0, 0, 1078703, 0, 1078704}			-- Healing
local skill24 = {1002086, 1078705, 1078706, 0, 1078707, 0, 1078708}		-- Herding
local skill25 = {1002088, 1078709, 0, 1078710, 0, 0, 1078711}			-- Hiding
local skill26 =	{1079712, 1079715, 1095248, 0, 1079720, 0, 1079723}		-- Imbuing
local skill27 = {1002090, 1078712, 1078713, 1078714, 1078715, 1078716, 1078717}	-- Inscription
local skill28 = {1002094, 1078718, 0, 1078719, 0, 0, 1078720}			-- Item Identification
local skill29 = {1002097, 1078721, 1078722, 0, 1078723, 0, 1078724}		-- Lockpicking
local skill30 = {1002100, 1078725, 1078726, 0, 1078727, 1078728, 1078729}	-- Lumberjacking
local skill31 = {1002102, 1078730, 1078731, 0, 1078732, 0, 1078733}		-- Mace Fighting
local skill32 = {1002106, 1078734, 1078735, 0, 1078736, 0, 1078737}		-- Magery
local skill33 = {1044086, 1078742, 0, 0, 0, 1078743, 1078744}			-- Resisting Spells
local skill34 = {1044106, 1078738, 0, 1078739, 0, 1078740, 1078741}		-- Meditation
local skill35 = {1002111, 1078745, 1078746, 0, 1078747, 0, 1078748}		-- Mining
local skill36 = {1002116, 1078749, 1078750, 0, 1078751, 0, 1078752}		-- Musicianship
local skill37 = {1079711, 1079714, 1095247, 0, 1079719, 0, 1079722}		-- Mysticism
local skill38 = {1044109, 1078753, 1078754, 0, 1078755, 0, 1078756}		-- Necromancy
local skill39 = {1044113, 1078757, 1078758, 0, 1078759, 0, 1078760}		-- Ninjitsu
local skill40 = {1002118, 1078761, 1078762, 0, 1078763, 0, 1078764}		-- Parrying
local skill41 = {1002120, 1078765, 1078766, 1078767, 0, 0, 1078768}		-- Peacemaking
local skill42 = {1002122, 1078769, 1078770, 1078771, 0, 1078772, 1078773}	-- Poisoning
local skill43 = {1002125, 1078774, 1078775, 1078776, 0, 0, 1078777}		-- Provocation
local skill44 = {1002136, 1078778, 0, 1078779, 0, 0, 1078780}			-- Remove Trap
local skill45 = {1002138, 1078781, 0, 0, 1078782, 0, 1078783}			-- Snooping
local skill46 = {1044114, 1078784, 1078785, 0, 1078786, 0, 1078787}		-- Spellweaving
local skill47 = {1002140, 1078788, 0, 1078789, 0, 1078790, 1078791}		-- Spirit Speak
local skill48 = {1002142, 1078792, 0, 1078793, 0, 0, 1078794}			-- Stealing
local skill49 = {1044107, 1078795, 1078856, 1078796, 0, 1078805, 1078797}	-- Stealth
local skill50 = {1002151, 1078798, 1078799, 0, 1078800, 0, 1078801}		-- Swordsmanship
local skill51 = {1044087, 1078802, 0, 0, 0, 1078803, 1078804}			-- Tactics
local skill52 = {1002155, 1078806, 1078807, 0, 1078808, 0, 1078809}		-- Tailoring
local skill53 = {1002160, 1078810, 0, 1078811, 0, 0, 1078812}			-- Taste Identification
local skill54 = {1079713, 1079716, 1095249, 0, 1079721, 0, 1079724}		-- Throwing
local skill55 = {1002162, 1078813, 1078814, 0, 1078815, 0, 1078816}		-- Tinkering
local skill56 = {1002165, 1078817, 0, 1078818, 0, 0, 1078819}			-- Tracking
local skill57 = {1002167, 1078820, 1078821, 0, 1078822, 0, 1078823}		-- Veterinary
local skill58 = {1002169, 1078824, 0, 0, 1078825, 0, 1078826}			-- Wrestling


local skillInfo = {
	skill01,
	skill02,
	skill03,
	skill04,
	skill05,
	skill06,
	skill07,
	skill08,
	skill09,
	skill10,
	skill11,
	skill12,
	skill13,
	skill14,
	skill15,
	skill16,
	skill17,
	skill18,
	skill19,
	skill20,
	skill21,
	skill22,
	skill23,
	skill24,
	skill25,
	skill26,
	skill27,
	skill28,
	skill29,
	skill30,
	skill31,
	skill32,
	skill33,
	skill34,
	skill35,
	skill36,
	skill37,
	skill38,
	skill39,
	skill40,
	skill41,
	skill42,
	skill43,
	skill44,
	skill45,
	skill46,
	skill47,
	skill48,
	skill49,
	skill50,
	skill51,
	skill52,
	skill53,
	skill54,
	skill55,
	skill56,
	skill57,
	skill58
}


----------------------------------------------------------------
-- Functions
----------------------------------------------------------------

function SkillsInfo.Initialize()
	SkillsInfo.UpdateGump(SkillsInfo.DisplaySkill)
end

function SkillsInfo.ClearGump()
	local this = "SkillsInfo"
	
	LabelSetText(this.."Title", L"")
	LabelSetText(this.."Description", L"")
	LabelSetText(this.."Direct", L"")
	LabelSetText(this.."DirectEntry", L"")
	LabelSetText(this.."Interactive", L"")
	LabelSetText(this.."InteractiveEntry", L"")
	LabelSetText(this.."Automatic", L"")
	LabelSetText(this.."AutomaticEntry", L"")
	LabelSetText(this.."More", L"")
	LabelSetText(this.."MoreEntry", L"")
end

function SkillsInfo.UpdateGump(DisplaySkill)
	SkillsInfo.ClearGump()

	local this = "SkillsInfo"

	local index = DisplaySkill
	-- Sanity check the skill index
	if (index < 1) or (index > 58) then
		index = 1
	end

	local info = skillInfo[index]
	local title = info[OFFSET_TITLE]
	local desc = info[OFFSET_DESC]
	local req = info[OFFSET_REQ]
	local direct = info[OFFSET_DIRECT]
	local inter = info[OFFSET_INTER]
	local auto = info[OFFSET_AUTO]
	local more = info[OFFSET_MORE]

	local x, y, dump, offset = 20, 55, 0, 0

	-- *** Set all the text with valid TIDs ***
	-- *** Placement depends on the height of previous TIDs ***
	LabelSetText(this.."Title", WindowUtils.translateMarkup( GetStringFromTid(TID_WINDOW_NAME) )..L" - "..WindowUtils.translateMarkup( GetStringFromTid(title)) )
	LabelSetText(this.."Description", WindowUtils.translateMarkup( GetStringFromTid(desc)) )

	-- "Requires"
	LabelSetText(this.."Requires", WindowUtils.translateMarkup( GetStringFromTid(TID_REQUIRES)) )
	if req == 0 then
		req = TID_REQ_NOTHING
	end
	LabelSetText(this.."RequiresEntry", WindowUtils.translateMarkup( GetStringFromTid(req)) )

	dump, offset = LabelGetTextDimensions(this.."Description")
	y = y + offset + BIG_SPACER
	
	WindowClearAnchors(this.."Requires")
	WindowAddAnchor(this.."Requires", "topleft", this, "topleft", x, y)
	
	dump, offset = LabelGetTextDimensions(this.."Requires")
	y = y + offset + SMALL_SPACER

	WindowClearAnchors(this.."RequiresEntry")
	WindowAddAnchor(this.."RequiresEntry", "topleft", this, "topleft", x + WIDE_SPACER, y)

	dump, offset = LabelGetTextDimensions(this.."RequiresEntry")
	y = y + offset + BIG_SPACER

	-- "Direct Usage" (Optional)
	if direct ~= 0 then
		LabelSetText(this.."Direct", WindowUtils.translateMarkup( GetStringFromTid(TID_DIRECT)) )
		LabelSetText(this.."DirectEntry", WindowUtils.translateMarkup( GetStringFromTid(direct)) )

		WindowClearAnchors(this.."Direct")
		WindowAddAnchor(this.."Direct", "topleft", this, "topleft", x, y)

		dump, offset = LabelGetTextDimensions(this.."Direct")
		y = y + offset + SMALL_SPACER

		WindowClearAnchors(this.."DirectEntry")
		WindowAddAnchor(this.."DirectEntry", "topleft", this, "topleft", x + WIDE_SPACER, y)

		dump, offset = LabelGetTextDimensions(this.."DirectEntry")
		y = y + offset + BIG_SPACER
	end

	-- "Interactive Usage" (Optional)
	if inter ~= 0 then
		LabelSetText(this.."Interactive", WindowUtils.translateMarkup( GetStringFromTid(TID_INTERACTIVE)) )
		LabelSetText(this.."InteractiveEntry", WindowUtils.translateMarkup( GetStringFromTid(inter)) )

		WindowClearAnchors(this.."Interactive")
		WindowAddAnchor(this.."Interactive", "topleft", this, "topleft", x, y)

		dump, offset = LabelGetTextDimensions(this.."Interactive")
		y = y + offset + SMALL_SPACER

		WindowClearAnchors(this.."InteractiveEntry")
		WindowAddAnchor(this.."InteractiveEntry", "topleft", this, "topleft", x + WIDE_SPACER, y)

		dump, offset = LabelGetTextDimensions(this.."InteractiveEntry")
		y = y + offset + BIG_SPACER
	end

	-- "Automatic Usage" (Optional)
	if auto ~= 0 then
		LabelSetText(this.."Automatic", WindowUtils.translateMarkup( GetStringFromTid(TID_AUTOMATIC)) )
		LabelSetText(this.."AutomaticEntry", WindowUtils.translateMarkup( GetStringFromTid(auto)) )

		WindowClearAnchors(this.."Automatic")
		WindowAddAnchor(this.."Automatic", "topleft", this, "topleft", x, y)

		dump, offset = LabelGetTextDimensions(this.."Automatic")
		y = y + offset + SMALL_SPACER

		WindowClearAnchors(this.."AutomaticEntry")
		WindowAddAnchor(this.."AutomaticEntry", "topleft", this, "topleft", x + WIDE_SPACER, y)

		dump, offset = LabelGetTextDimensions(this.."AutomaticEntry")
		y = y + offset + BIG_SPACER
	end

	-- "More" (Optional)
	if more ~= 0 then
		LabelSetText(this.."More", WindowUtils.translateMarkup( GetStringFromTid(TID_MORE)) )
		LabelSetText(this.."MoreEntry", WindowUtils.translateMarkup( GetStringFromTid(more)) )

		WindowClearAnchors(this.."More")
		WindowAddAnchor(this.."More", "topleft", this, "topleft", x, y)

		dump, offset = LabelGetTextDimensions(this.."More")
		y = y + offset + SMALL_SPACER

		WindowClearAnchors(this.."MoreEntry")
		WindowAddAnchor(this.."MoreEntry", "topleft", this, "topleft", x + WIDE_SPACER, y)

		dump, offset = LabelGetTextDimensions(this.."MoreEntry")
		y = y + offset + BIG_SPACER
	end

	WindowSetDimensions(this, WINDOW_WIDTH, y + BIG_SPACER)
end