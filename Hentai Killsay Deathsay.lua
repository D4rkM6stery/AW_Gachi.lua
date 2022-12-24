--------Auto Update-------- https://aimware.net/forum/thread/151605
local SCRIPT_FILE_NAME = GetScriptName();
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/Hentai%20Killsay%20Deathsay.lua";
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/OwlMan42069/Aimware-Luas/main/Versions/Hentai%20Killsay%20Deathsay%20Version.txt";
local VERSION_NUMBER = "2.8";
local version_check_done = false;
local update_downloaded = false;
local update_available = false;
local up_to_date = false;
local updaterfont1 = draw.CreateFont("Bahnschrift", 18);
local updaterfont2 = draw.CreateFont("Bahnschrift", 14);
local updateframes = 0;
local fadeout = 0;
local spacing = 0;
local fadein = 0;

callbacks.Register( "Draw", "handleUpdates", function()
	if updateframes < 5.5 then
		if up_to_date or updateframes < 0.25 then
			updateframes = updateframes + globals.AbsoluteFrameTime();
			if updateframes > 5 then
				fadeout = ((updateframes - 5) * 510);
			end
			if updateframes > 0.1 and updateframes < 0.25 then
				fadein = (updateframes - 0.1) * 4500;
			end
			if fadein < 0 then fadein = 0 end
			if fadein > 650 then fadein = 650 end
			if fadeout < 0 then fadeout = 0 end
			if fadeout > 255 then fadeout = 255 end
		end
		if updateframes >= 0.25 then fadein = 650 end
		for i = 0, 600 do
			local alpha = 200-i/3 - fadeout;
			if alpha < 0 then alpha = 0 end
			draw.Color(15,15,15,alpha);
			draw.FilledRect(i - 650 + fadein, 0, i+1 - 650 + fadein, 30);
			draw.Color(0, 180, 255,alpha);
			draw.FilledRect(i - 650 + fadein, 30, i+1 - 650 + fadein, 31);
		end
		draw.SetFont(updaterfont1);
		draw.Color(0,180,255,255 - fadeout);
		draw.Text(7 - 650 + fadein, 7, "RetardAlert's");
		draw.Color(225,225,225,255 - fadeout);
		draw.Text(7 + draw.GetTextSize("RetardAlert's ") - 650 + fadein, 7, "Script");
		draw.Color(0,180,255,255 - fadeout);
		draw.Text(7 + draw.GetTextSize("RetardAlert's Script  ") - 650 + fadein, 7, "\\");
		spacing = draw.GetTextSize("RetardAlert's Script  \\  ");
		draw.SetFont(updaterfont2);
		draw.Color(225,225,225,255 - fadeout);
	end

    if (update_available and not update_downloaded) then
		draw.Text(7 + spacing - 650 + fadein, 9, "Downloading latest version.");
        local new_version_content = http.Get(SCRIPT_FILE_ADDR);
        local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        old_script:Write(new_version_content);
        old_script:Close();
        update_available = false;
        update_downloaded = true;
	end
	
    if (update_downloaded) and updateframes < 5.5 then
		draw.Text(7 + spacing - 650 + fadein, 9, "Update available, please reload the script.");
    end

    if (not version_check_done) then
        version_check_done = true;
		local version = http.Get(VERSION_FILE_ADDR);
		version = string.gsub(version, "\n", "");
		if (version ~= VERSION_NUMBER) then
            update_available = true;
		else 
			up_to_date = true;
		end
	end
	
	if up_to_date and updateframes < 5.5 then
		draw.Text(7 + spacing - 650 + fadein, 9, "Successfully loaded latest version: v" .. VERSION_NUMBER);
	end
end)

--------GUI Stuff--------
local misc_ref = gui.Reference("Misc")
local tab = gui.Tab(misc_ref, "RetardAlert", ("ThighHighs.club v" .. VERSION_NUMBER))

local left_tab = gui.Groupbox(tab, "Killsay / Deathsay", 10, 15, 310, 400)
--local left_tab2 = gui.Groupbox(tab, "Clantags", 10, 210, 310, 400)
local left_tab3 = gui.Groupbox(tab, "Misc", 10, 210, 310, 400)
local right_tab = gui.Groupbox(tab, "Game-Chat", 325, 15, 305, 400)

local enable_killsays = gui.Checkbox(left_tab, "enable.killsays", "Enable Killsay Deathsay", true)
local killsay_mode = gui.Combobox(left_tab, "killsay.mode", "Select Killsay Mode", "Hentai", "Lewd", "Apologetic", "Edgy", "EZfrags", "AFK")
local killsay_speed = gui.Slider(left_tab, "killsay.speed", "Killsay / Deathsay Delay", 0, 0, 5)

--[[
local enable_clantags = gui.Checkbox(left_tab2, "enable.clantags", "Enable Premade Clantags", false)
local clantag_mode = gui.Combobox(left_tab2, "clantag.mode", "Select clantag", "Sussy Baka", "UwU Rawr xD!", "Sorry Not Sorry", "No Lives Matter", "EZFrags.co.uk")
local set_clantag = ffi.cast('int(__fastcall*)(const char*, const char*)', mem.FindPattern("engine.dll", "53 56 57 8B DA 8B F9 FF 15"))
local clantagset = 0
--]]

local EngineRadar = gui.Checkbox(left_tab3, "engine.radar", "Engine Radar", true)
local ForceCrosshair = gui.Checkbox(left_tab3, "force.crosshair", "Force Crosshair", true)
local RecoilCrosshair = gui.Checkbox(left_tab3, "recoil.crosshair", "Recoil Crosshair", false)

local enable_chatcmds = gui.Checkbox(right_tab, "enable.chatcmds", "Enable Chat Commands", true)
local chat_commands = gui.Multibox(right_tab, "Select Chat Commands")
local enable_ranks = gui.Checkbox(chat_commands, "enable.ranks", "!ranks", true)
local enable_roll = gui.Checkbox(chat_commands, "enable.roll", "!roll", true)
local enable_8ball = gui.Checkbox(chat_commands, "enable.8ball", "!8ball", true)
local enable_gaydar = gui.Checkbox(chat_commands, "enable.gaydar", "!gay", true)
local enable_coin_flip = gui.Checkbox(chat_commands, "enable.flip", "!flip", true)
local enable_anime = gui.Checkbox(chat_commands, "enable.anime", "!anime", true)
local ranks_mode = gui.Combobox(right_tab, "ranks.mode", "Select Chat Mode (Ranks)", "Team Chat", "All Chat")

local enable_throwsay = gui.Checkbox(right_tab, "enable.throwsay", "Enable Grenade Throwsay", true)
local grenade_throwsay = gui.Multibox(right_tab, "Select Grenades")
local enable_hegrenade = gui.Checkbox(grenade_throwsay, "enable.hegrenade", "HE Grenade", true)
local enable_flashbang = gui.Checkbox(grenade_throwsay, "enable.flashbang", "Flashbang", true)
local enable_smokegrenade = gui.Checkbox(grenade_throwsay, "enable.smokegrenade", "Smoke", true)
local enable_molotov = gui.Checkbox(grenade_throwsay, "senable.molotov", "Molotov/Incendiary", true)
local throwsay_speed = gui.Slider(right_tab, "throwsay.speed", "Grenade Throwsay Delay", 0, 0, 5)

local enable_msgevents = gui.Checkbox(right_tab, "enable.msgevents", "Enable Message Events", false)
local msgevents_mode = gui.Combobox(right_tab, "msgevents.mode", "Select Message Mode", "Copy Player Messages", "Chat Breaker")
local msgevents_speed = gui.Slider(right_tab, "msgevents.speed", "Message Events Delay", 0, 0, 5)


--------Draw Image--------
local function OnUnload()
client.Command("toggleconsole", true)

	client.Command('echo "⠄⠄⠄⢰⣧⣼⣯⠄⣸⣠⣶⣶⣦⣾⠄⠄⠄⠄⡀⠄⢀⣿⣿⠄⠄⠄⢸⡇⠄⠄"', true)
	client.Command('echo "⠄⠄⠄⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄"', true)
	client.Command('echo "⠄⠄⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄"', true)
	client.Command('echo "⠄⠄⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄"', true)
	client.Command('echo "⠄⢀⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰"', true)
	client.Command('echo "⠄⣼⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤"', true)
	client.Command('echo "⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗"', true)
	client.Command('echo "⢀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄"', true)
	client.Command('echo "⢸⣿⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠄"', true)
	client.Command('echo "⠘⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃⠄"', true)
	client.Command('echo "⠄⠘⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃⠄⠄"', true)
	client.Command('echo "⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁⠄⠄⠄"', true)
	client.Command('echo "⠄⠄⠄⠄⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁⠄⠄⠄⠄⠄"', true)
	client.Command('echo "⠄⠄⠄⠄⠄⠄⠄⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁⠄⠄⠄⠄⠄⢀⣠⣴"', true)
	client.Command('echo "⣿⣿⣿⣶⣶⣮⣥⣒⠲⢮⣝⡿⣿⣿⡆⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⣠⣴⣿⣿⣿"', true)

	if clantagset == 1 then
		set_clantag("", "")
	end
end

--------Miscellaneous--------
client.Command("+right", true)
client.Command("+left", true)
client.Command("snd_menumusic_volume 0", true)
client.Command("cl_timeout 0 0 0 7", true)

--------Engine Radar--------
callbacks.Register('CreateMove', function()
	local isEngineRadarOn = EngineRadar:GetValue() and 1 or 0

	for _, Player in ipairs(entities.FindByClass('CCSPlayer')) do
		Player:SetProp('m_bSpotted', isEngineRadarOn)
	end
end)

--------Force Crosshair--------
client.AllowListener('item_equip')
callbacks.Register('FireGameEvent', function(e)
	if not ForceCrosshair:GetValue() or e:GetName() ~= 'item_equip' then
		if not client.GetConVar('weapon_debug_spread_show') == '3' then
			client.SetConVar('weapon_debug_spread_show', 0, true)
		end
		return
	end

	local LocalPlayerIndex = client.GetLocalPlayerIndex()
	local PlayerIndex = client.GetPlayerIndexByUserID( e:GetInt('userid') )
	local WeaponType = e:GetInt('weptype')

	if LocalPlayerIndex == PlayerIndex then
		if WeaponType == 5 then
			client.SetConVar('weapon_debug_spread_show', 3, true)
		end
	end
end)

--------Recoil Crosshair--------
local function CrosshairRecoil()
	if RecoilCrosshair:GetValue() and not gui.GetValue("rbot.master") then
		client.SetConVar("cl_crosshair_recoil", 1, true)
	else
		client.SetConVar("cl_crosshair_recoil", 0, true)
	end
end

--------Inventory Unlocker--------
local function UnlockInventory()
	panorama.RunScript('LoadoutAPI.IsLoadoutAllowed = () => true');
end

--------Message Events--------
local ranks = {"S1","S2","S3","S4","SE","SEM","GN1","GN2","GN3","GNM","MG1","MG2","MGE","DMG","LE","LEM","SMFC","GE",}
local numbers = {"1","2","3","4","5","6",}
local responses = {"Да - определенно.","Это явно так.","Без сомнения.","Ответ туманный, попробуй еще раз.","Спроси позже.","Лучше не говорить тебе сейчас.","Мои источники говорят, что нет.","Перспективы не очень.","Очень сомнительно.",}
local results = {"выиграл койнфлип!","проиграл койнфлип!",}
local gaydar = {"гей!","не гей!",}
local anime = {
    {
        "⠄⠄⠄⢰⣧⣼⣯⠄⣸⣠⣶⣶⣦⣾⠄⠄⠄⠄⡀⠄⢀⣿⣿⠄⠄⠄⢸⡇⠄⠄",
        "⠄⠄⠄⣾⣿⠿⠿⠶⠿⢿⣿⣿⣿⣿⣦⣤⣄⢀⡅⢠⣾⣛⡉⠄⠄⠄⠸⢀⣿⠄",
        "⠄⠄⢀⡋⣡⣴⣶⣶⡀⠄⠄⠙⢿⣿⣿⣿⣿⣿⣴⣿⣿⣿⢃⣤⣄⣀⣥⣿⣿⠄",
        "⠄⠄⢸⣇⠻⣿⣿⣿⣧⣀⢀⣠⡌⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠿⠿⣿⣿⣿⠄",
        "⠄⢀⢸⣿⣷⣤⣤⣤⣬⣙⣛⢿⣿⣿⣿⣿⣿⣿⡿⣿⣿⡍⠄⠄⢀⣤⣄⠉⠋⣰",
        "⠄⣼⣖⣿⣿⣿⣿⣿⣿⣿⣿⣿⢿⣿⣿⣿⣿⣿⢇⣿⣿⡷⠶⠶⢿⣿⣿⠇⢀⣤",
        "⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⣿⣿⡇⣿⣿⣿⣿⣿⣿⣷⣶⣥⣴⣿⡗",
        "⢀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠄",
        "⢸⣿⣦⣌⣛⣻⣿⣿⣧⠙⠛⠛⡭⠅⠒⠦⠭⣭⡻⣿⣿⣿⣿⣿⣿⣿⣿⡿⠃⠄",
        "⠘⣿⣿⣿⣿⣿⣿⣿⣿⡆⠄⠄⠄⠄⠄⠄⠄⠄⠹⠈⢋⣽⣿⣿⣿⣿⣵⣾⠃⠄",
        "⠄⠘⣿⣿⣿⣿⣿⣿⣿⣿⠄⣴⣿⣶⣄⠄⣴⣶⠄⢀⣾⣿⣿⣿⣿⣿⣿⠃⠄⠄",
        "⠄⠄⠈⠻⣿⣿⣿⣿⣿⣿⡄⢻⣿⣿⣿⠄⣿⣿⡀⣾⣿⣿⣿⣿⣛⠛⠁⠄⠄⠄",
        "⠄⠄⠄⠄⠈⠛⢿⣿⣿⣿⠁⠞⢿⣿⣿⡄⢿⣿⡇⣸⣿⣿⠿⠛⠁⠄⠄⠄⠄⠄",
        "⠄⠄⠄⠄⠄⠄⠄⠉⠻⣿⣿⣾⣦⡙⠻⣷⣾⣿⠃⠿⠋⠁⠄⠄⠄⠄⠄⢀⣠⣴",
        "⣿⣿⣿⣶⣶⣮⣥⣒⠲⢮⣝⡿⣿⣿⡆⣿⡿⠃⠄⠄⠄⠄⠄⠄⠄⣠⣴⣿⣿⣿",
    },
    {
        "⡿⠋⠄⣀⣀⣤⣴⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣌⠻⣿⣿",
        "⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠹⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠹",
        "⣿⣿⡟⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡛⢿⣿⣿⣿⣮⠛⣿⣿⣿⣿⣿⣿⡆",
        "⡟⢻⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣣⠄⡀⢬⣭⣻⣷⡌⢿⣿⣿⣿⣿⣿",
        "⠃⣸⡀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠈⣆⢹⣿⣿⣿⡈⢿⣿⣿⣿⣿",
        "⠄⢻⡇⠄⢛⣛⣻⣿⣿⣿⣿⣿⣿⣿⣿⡆⠹⣿⣆⠸⣆⠙⠛⠛⠃⠘⣿⣿⣿⣿",
        "⠄⠸⣡⠄⡈⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠁⣠⣉⣤⣴⣿⣿⠿⠿⠿⡇⢸⣿⣿⣿",
        "⠄⡄⢿⣆⠰⡘⢿⣿⠿⢛⣉⣥⣴⣶⣿⣿⣿⣿⣻⠟⣉⣤⣶⣶⣾⣿⡄⣿⡿⢸",
        "⠄⢰⠸⣿⠄⢳⣠⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣿⣿⣿⣿⣿⡇⢻⡇⢸",
        "⢷⡈⢣⣡⣶⠿⠟⠛⠓⣚⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢸⠇⠘",
        "⡀⣌⠄⠻⣧⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠛⠛⢿⣿⣿⣿⣿⣿⡟⠘⠄⠄",
        "⣷⡘⣷⡀⠘⣿⣿⣿⣿⣿⣿⣿⣿⡋⢀⣠⣤⣶⣶⣾⡆⣿⣿⣿⠟⠁⠄⠄⠄⠄",
        "⣿⣷⡘⣿⡀⢻⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣿⣿⣿⣿⣷⡿⠟⠉⠄⠄⠄⠄⡄⢀",
        "⣿⣿⣷⡈⢷⡀⠙⠛⠻⠿⠿⠿⠿⠿⠷⠾⠿⠟⣛⣋⣥⣶⣄⠄⢀⣄⠹⣦⢹⣿",
    },
    {
        "⠄⠄⠄⢀⣤⣾⣿⡟⠋⠄⠄⠄⣀⡿⠄⠊⠄⠄⠄⠄⠄⠄⢸⠇⠄⢀⠃⠙⣿⣿",
        "⣤⠒⠛⠛⠛⠛⠛⠛⠉⠉⠉⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠸⠄⢀⠊⠄⠄⠈⢿",
        "⣿⣠⠤⠴⠶⠒⠶⠶⠤⠤⣤⣀⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⠃⠄⠂⣀⣀⣀⡀⠄",
        "⡏⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠈⠙⠂⠄⠄⠄⠄⠄⠄⢀⢎⠐⠛⠋⠉⠉⠉⠉⠛",
        "⡇⠄⠄⠄⣀⡀⠄⠄⠄⢀⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠎⠁⠄⠄⠄⠄⠄⠄⠄⠄",
        "⡧⠶⣿⣿⣿⣿⣿⣿⠲⠦⣭⡃⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⡀⠄⠄⠄⠄⠄⠄",
        "⡇⠄⣿⣿⣿⣿⣿⣿⡄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢰⣾⣿⣿⣿⡟⠛⠶⠄",
        "⡇⠄⣿⣿⣿⣿⣿⣿⡇⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣼⣿⣿⣿⣿⡇⠄⠄⢀",
        "⡇⠄⢿⣿⣿⣿⣿⣷⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣿⣿⣿⣿⣿⡇⠄⠄⢊",
        "⢠⠄⠈⠛⠛⠛⠛⠋⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢿⣿⣿⣿⡦⠁⠄⠄⣼",
        "⢸⠄⠈⠉⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠉⠉⠄⠄⠄⠄⢰⣿",
        "⢸⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠁⠉⠄⢸⣿",
        "⠄⣆⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⢸⣿",
        "⠄⢿⣷⣶⣄⡀⠄⠄⠄⠄⠄⠄⠉⠉⠉⠉⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⢀⣴⣿⣿",
        "⠄⢸⣿⣿⣿⣿⣷⣦⣤⣀⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣀⣠⣤⣶⣿⣿⣿⣿⣿",
    },
    {
        "⣿⠟⣽⣿⣿⣿⣿⣿⢣⠟⠋⡜⠄⢸⣿⣿⡟⣬⢁⠠⠁⣤⠄⢰⠄⠇⢻⢸",
        "⢏⣾⣿⣿⣿⠿⣟⢁⡴⡀⡜⣠⣶⢸⣿⣿⢃⡇⠂⢁⣶⣦⣅⠈⠇⠄⢸⢸",
        "⣹⣿⣿⣿⡗⣾⡟⡜⣵⠃⣴⣿⣿⢸⣿⣿⢸⠘⢰⣿⣿⣿⣿⡀⢱⠄⠨⢸",
        "⣿⣿⣿⣿⡇⣿⢁⣾⣿⣾⣿⣿⣿⣿⣸⣿⡎⠐⠒⠚⠛⠛⠿⢧⠄⠄⢠⣼",
        "⣿⣿⣿⣿⠃⠿⢸⡿⠭⠭⢽⣿⣿⣿⢂⣿⠃⣤⠄⠄⠄⠄⠄⠄⠄⠄⣿⡾",
        "⣼⠏⣿⡏⠄⠄⢠⣤⣶⣶⣾⣿⣿⣟⣾⣾⣼⣿⠒⠄⠄⠄⡠⣴⡄⢠⣿⣵",
        "⣳⠄⣿⠄⠄⢣⠸⣹⣿⡟⣻⣿⣿⣿⣿⣿⣿⡿⡻⡖⠦⢤⣔⣯⡅⣼⡿⣹",
        "⡿⣼⢸⠄⠄⣷⣷⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣕⡜⡌⡝⡸⠙⣼⠟⢱⠏",
        "⡇⣿⣧⡰⡄⣿⣿⣿⣿⡿⠿⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣋⣪⣥⢠⠏⠄",
        "⣧⢻⣿⣷⣧⢻⣿⣿⣿⡇⠄⢀⣀⣀⡙⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠂⠄⠄",
        "⢹⣼⣿⣿⣿⣧⡻⣿⣿⣇⣴⣿⣿⣿⣷⢸⣿⣿⣿⣿⣿⣿⣿⣿⣰⠄⠄⠄",
        "⣼⡟⡟⣿⢸⣿⣿⣝⢿⣿⣾⣿⣿⣿⢟⣾⣿⣿⣿⣿⣿⣿⣿⣿⠟⠄⡀⡀",
        "⣿⢰⣿⢹⢸⣿⣿⣿⣷⣝⢿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠉⠄⠄⣸⢰⡇",
        "⣿⣾⣹⣏⢸⣿⣿⣿⣿⣿⣷⣍⡻⣛⣛⣛⡉⠁⠄⠄⠄⠄⠄⠄⢀⢇⡏⠄",
    },
    {
        "⢀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⣠⣤⣶⣶",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⢰⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣀⣀⣾⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⡏⠉⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⣿",
        "⣿⣿⣿⣿⣿⣿⠀⠀⠀⠈⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⠉⠁⠀⣿",
        "⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠙⠿⠿⠿⠻⠿⠿⠟⠿⠛⠉⠀⠀⠀⠀⠀⣸⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣷⣄⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠠⣴⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⢰⣹⡆⠀⠀⠀⠀⠀⠀⣭⣷⠀⠀⠀⠸⣿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠈⠉⠀⠀⠤⠄⠀⠀⠀⠉⠁⠀⠀⠀⠀⢿⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⢾⣿⣷⠀⠀⠀⠀⡠⠤⢄⠀⠀⠀⠠⣿⣿⣷⠀⢸⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⡀⠉⠀⠀⠀⠀⠀⢄⠀⢀⠀⠀⠀⠀⠉⠉⠁⠀⠀⣿⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⣿",
        "⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿",
    },
    {
        "⣿⡇⣿⣿⣿⠛⠁⣴⣿⡿⠿⠧⠹⠿⠘⣿⣿⣿⡇⢸⡻⣿⣿⣿⣿⣿⣿⣿",
        "⢹⡇⣿⣿⣿⠄⣞⣯⣷⣾⣿⣿⣧⡹⡆⡀⠉⢹⡌⠐⢿⣿⣿⣿⡞⣿⣿⣿",
        "⣾⡇⣿⣿⡇⣾⣿⣿⣿⣿⣿⣿⣿⣿⣄⢻⣦⡀⠁⢸⡌⠻⣿⣿⣿⡽⣿⣿",
        "⡇⣿⠹⣿⡇⡟⠛⣉⠁⠉⠉⠻⡿⣿⣿⣿⣿⣿⣦⣄⡉⠂⠈⠙⢿⣿⣝⣿",
        "⠤⢿⡄⠹⣧⣷⣸⡇⠄⠄⠲⢰⣌⣾⣿⣿⣿⣿⣿⣿⣶⣤⣤⡀⠄⠈⠻⢮",
        "⠄⢸⣧⠄⢘⢻⣿⡇⢀⣀⠄⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠄⢀",
        "⠄⠈⣿⡆⢸⣿⣿⣿⣬⣭⣴⣿⣿⣿⣿⣿⣿⣿⣯⠝⠛⠛⠙⢿⡿⠃⠄⢸",
        "⠄⠄⢿⣿⡀⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣿⣿⣿⣿⡾⠁⢠⡇⢀",
        "⠄⠄⢸⣿⡇⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⣫⣻⡟⢀⠄⣿⣷⣾",
        "⠄⠄⢸⣿⡇⠄⠈⠙⠿⣿⣿⣿⣮⣿⣿⣿⣿⣿⣿⣿⣿⡿⢠⠊⢀⡇⣿⣿",
        "⠒⠤⠄⣿⡇⢀⡲⠄⠄⠈⠙⠻⢿⣿⣿⠿⠿⠟⠛⠋⠁⣰⠇⠄⢸⣿⣿⣿",
        "⠄⠄⠄⣿⡇⢬⡻⡇⡄⠄⠄⠄⡰⢖⠔⠉⠄⠄⠄⠄⣼⠏⠄⠄⢸⣿⣿⣿",
        "⠄⠄⠄⣿⡇⠄⠙⢌⢷⣆⡀⡾⡣⠃⠄⠄⠄⠄⠄⣼⡟⠄⠄⠄⠄⢿⣿⣿",
    },
    {
        "⣿⢸⣿⣿⣿⣿⣿⢹⣿⣿⣿⣿⣿⢿⣿⡇⡇⣿⣿⡇⢹⣿⣿⣿⣿⣿⣿⠄⢸⣿",
        "⡟⢸⣿⣿⣭⣭⡭⣼⣶⣿⣿⣿⣿⢸⣧⣇⠇⢸⣿⣿⠈⣿⣿⣿⣿⣿⣿⡆⠘⣿",
        "⡇⢸⣿⣿⣿⣿⡇⣻⡿⣿⣿⡟⣿⢸⣿⣿⠇⡆⣝⠿⡌⣸⣿⣿⣿⣿⣿⡇⠄⣿",
        "⢣⢾⣾⣷⣾⣽⣻⣿⣇⣿⣿⣧⣿⢸⣿⣿⡆⢸⣹⣿⣆⢥⢛⡿⣿⣿⣿⡇⠄⣿",
        "⣛⡓⣉⠉⠙⠻⢿⣿⣿⣟⣻⠿⣹⡏⣿⣿⣧⢸⣧⣿⣿⣨⡟⣿⣿⣿⣿⡇⠄⣿",
        "⠸⣷⣹⣿⠄⠄⠄⠄⠘⢿⣿⣿⣯⣳⣿⣭⣽⢼⣿⣜⣿⣇⣷⡹⣿⣿⣿⠁⢰⣿",
        "⠄⢻⣷⣿⡄⢈⠿⠇⢸⣿⣿⣿⣿⣿⣿⣟⠛⠲⢯⣿⣒⡾⣼⣷⡹⣿⣿⠄⣼⣿",
        "⡄⢸⣿⣿⣷⣬⣽⣯⣾⣿⣿⣿⣿⣿⣿⣿⣿⡀⠄⢀⠉⠙⠛⠛⠳⠽⠿⢠⣿⣿",
        "⡇⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⢄⣹⡿⠃⠄⠄⣰⠎⡈⣾⣿⣿",
        "⡇⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣾⣭⣽⣖⣄⣴⣯⣾⢷⣿⣿⣿",
        "⣧⠸⣿⣿⣿⣿⣿⣿⠯⠊⠙⢻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣏⣾⣿⣿⣿",
        "⣿⣦⠹⣿⣿⣿⣿⣿⠄⢀⣴⢾⣼⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⣾⣿⣿⣿⣿",
        "⣿⣿⣇⢽⣿⣿⣿⡏⣿⣿⣿⣿⣿⡇⣿⣿⣿⣿⡿⣿⣛⣻⠿⣟⣼⣿⣿⣿⣿⢃",
        "⣿⣿⣿⡎⣷⣽⠻⣇⣿⣿⣿⡿⣟⣵⣿⣟⣽⣾⣿⣿⣿⣿⢯⣾⣿⣿⣿⠟⠱⡟",
        "⣿⣿⣿⣿⢹⣿⣿⢮⣚⡛⠒⠛⢛⣋⣶⣿⣿⣿⣿⣿⣟⣱⠿⣿⣿⠟⣡⣺⢿",
    }
}

local timer = timer or {}
local timers = {}

function timer.Create(name, delay, times, func)
    table.insert(timers, {["name"] = name, ["delay"] = delay, ["times"] = times, ["func"] = func, ["lastTime"] = globals.RealTime()})
end

function timer.Remove(name)
    for k,v in pairs(timers or {}) do
        if (name == v["name"]) then table.remove(timers, k) end
    end
end

callbacks.Register("DispatchUserMessage", function(msg)
    if msg:GetID() == 6 then
        local index = msg:GetInt(1)
		local message = msg:GetString(4,1)
        local message2 = msg:GetString(4,1):lower()
        local m = string.match
        local ec = enable_chatcmds:GetValue()
        local ecf = enable_coin_flip:GetValue()

        local player_name = client.GetPlayerNameByIndex(index)
        local lp = entities.GetLocalPlayer()
        local lp_name = client.GetPlayerInfo( lp:GetIndex() )[ "Name" ]
        local number = numbers[math.random(#numbers)]
        local response = responses[math.random(#responses)]
        local result = results[math.random(#results)]
        local thingy = gaydar[math.random(#gaydar)]
		
		if enable_msgevents:GetValue() and msgevents_mode:GetValue() == 0 then
			if player_name ~= lp_name then
				timer.Create("message_delay", msgevents_speed:GetValue(), 1, function()
					client.ChatSay(message)
				end)
			end
		elseif enable_msgevents:GetValue() and msgevents_mode:GetValue() == 1 then
			if player_name ~= lp_name then
				timer.Create("message_delay", msgevents_speed:GetValue(), 1, function()
					client.ChatSay("﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽﷽ ﷽﷽")
				end)
			end
		end

        if m(message2, "!roll") and enable_chatcmds:GetValue() and enable_roll:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                msg = ('%s выкинул %s'):format(player_name, number)
                client.ChatSay(msg)
            end)
        end

        if m(message2, "!8ball") and enable_chatcmds:GetValue() and enable_8ball:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                client.ChatSay("❽: " .. response)
            end)
        end

        if m(message2, "!gay") and enable_chatcmds:GetValue() and enable_gaydar:GetValue() then
            timer.Create("message_delay", 0.7, 1, function()
                msg = ('%s %s'):format(player_name, thingy)
                client.ChatSay(msg)
            end)
        end

        if m(message2, "!cf") and ec and ecf or m(message2, "!flip") and ec and ecf or m(message2, "!coin flip") and ec and ecf or m(message2, "!coinflip") and ec and ecf then
            timer.Create("message_delay", 0.7, 1, function()
                msg = ('%s %s'):format(player_name, result)
                client.ChatSay(msg)
            end)
        end

        if m(message, "!anime") and ec and enable_anime:GetValue() then
            random = math.random(1, #anime)
            for i=1, #anime[random] do
                timer.Create("message_delay", 0.7, i, function()
                    client.ChatSay(anime[random][i])
                end)
            end
        end

        if m(message, "!ranks") and ec and enable_ranks:GetValue() then
            for i, v in next, entities.FindByClass("CCSPlayer") do
                if v:GetName() ~= "GOTV" and entities.GetPlayerResources():GetPropInt("m_iPing", v:GetIndex()) ~= 0 then
                    local index = v:GetIndex()
                    local rank_index = entities.GetPlayerResources():GetPropInt("m_iCompetitiveRanking", index)
                    local wins = entities.GetPlayerResources():GetPropInt("m_iCompetitiveWins", index)
                    local rank = ranks[rank_index] or "нет ранга"
                    if ranks_mode:GetValue() == 0 then 
                        timer.Create("message_delay", 0.7, i, function()
                            client.ChatTeamSay("У " .. v:GetName() .. wins .. " побед " .. "(" .. rank .. ")")
                        end)

                    elseif ranks_mode:GetValue() == 1 then 
                        timer.Create("message_delay", 0.7, i, function()
                            client.ChatSay("У " .. v:GetName() .. wins .. " побед " .. "(" .. rank .. ")")
                        end)
                    end
                end
            end
        end
    end
end)

callbacks.Register("Draw", function()
    for k,v in pairs(timers or {}) do
  
        if (v["times"] <= 0) then table.remove(timers, k) end
      
        if (v["lastTime"] + v["delay"] <= globals.RealTime()) then
            timers[k]["lastTime"] = globals.RealTime()
            timers[k]["times"] = timers[k]["times"] - 1
            v["func"]()
        end  
    end
end)


--Throwsays
local ThrowSays = {
	hegrenade = {
		'Лови додик!',
		'Головы поднимаем!',
		'Это будет больно.',
	},

	flashbang = {
		'Смотрите, птичка!',
		'Смотрите, самолёт!',
		'ФЛЕШКА ЕБАТЬ!',
		'Банг, банг, на чьей-то хате рейд.',
	},

	molotov = {
		'Горячая штучка додик!',
		'ГОРИ ЕБАНАШКА, ГОРИ!',
	},

	incgrenade = {
		'Горячая штучка додик!',
		'ГОРИ ЕБАНАШКА, ГОРИ!',
	},

	smokegrenade = {
		'Я... Ниндзя',
		'Очень скрытный чел',
		'НИНДЗЯ ДЕФУЗ!',
	},
}

local function for_throwsay(e)
	if not enable_throwsay:GetValue() then
		return
	end

	if e:GetName() ~= 'grenade_thrown' then
		return
	end

	if client.GetPlayerIndexByUserID( e:GetInt('userid') ) ~= client.GetLocalPlayerIndex() then
		return
	end

	local wep = e:GetString('weapon')
	local says = ThrowSays[wep]
	local say_msg =
	   (wep == 'hegrenade' and enable_hegrenade:GetValue()) or 
	   (wep == 'flashbang' and enable_flashbang:GetValue()) or
	   ((wep == 'molotov' or wep == 'incgrenade') and enable_molotov:GetValue()) or
	   (wep == 'smokegrenade' and enable_smokegrenade:GetValue())

	if say_msg then
        timer.Create("message_delay", throwsay_speed:GetValue(), 1, function()
            client.ChatSay( says[math.random(#says)] )
        end)
	end
end

--[[
--ClanTags
local ClanTags = {
	['Sussy Baka'] = {
		"                  ",
		"S                 ",
		"S^                ",
		"Su                ",
		"Su|               ",
		"Su                ",
		"Sus               ",
		"Suss              ",
		"Suss(>ω<)         ",
		"Sussy             ",
		"Sussy |           ",
		"Sussy             ",
		"Sussy B           ",
		"Sussy B@          ",
		"Sussy Ba          ",
		"Sussy Ba(>ω<)     ",
		"Sussy Bak         ",
		"Sussy Baka        ",
		"Sussy Baka|       ",
		"Sussy Baka        ",
		"Sussy Baka|       ",
		"Sussy Baka        ",
		"Sussy Baka|       ",
		"Sussy Baka        ",
		"Sussy Bak         ",
		"Sussy Ba^         ",
		"Sussy Ba          ",
		"Sussy B@          ",
		"Sussy B           ",
		"Sussy |           ",
		"Sussy             ",
		"Sussy |           ",
		"Sussy             ",
		"Sussy|            ",
		"Sussy             ",
		"Suss(>ω<)         ",
		"Suss              ",
		"Sus|              ",
		"Sus               ",
		"Su                ",
		"S^                ",
		"S|                ",
		"S                 ",
		"|                 "
	},

	['UwU Rawr xD!'] = {
		"                  ",
		"U                 ",
		"Uw                ",
		"UwU               ",
		"(>ω<)             ",
		"UwU R             ",
		"UwU Ra            ",
		"UwU Raw           ",
		"UwU Rawr          ",
		"UwU Rawr x        ",
		"UwU Rawr xD       ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD!      ",
		"UwU Rawr xD       ",
		"UwU Rawr x        ",
		"UwU Rawr          ",
		"UwU Raw           ",
		"UwU Ra            ",
		"UwU R             ",
		"(>ω<)             ",
		"UwU               ",
		"Uw                ",
		"U                 ",
		"                  ",
		"                  "
	},

	['Sorry Not Sorry'] = {
		"                  ",
		"$                 ",
		"S                 ",
		"So                ",
		"Sor               ",
		"Sorr              ",
		"Sorry             ",
		"Sorry N           ",
		"Sorry No          ",
		"Sorry No^         ",
		"Sorry Not         ",
		"Sorry Not $       ",
		"Sorry Not S@      ",
		"Sorry Not So      ",
		"Sorry Not Sor     ",
		"Sorry Not Sorr    ",
		"Sorry Not Sorr^   ",
		"Sorry Not Sorry   ",
		"Sorry Not Sorry   ",
		"$@rry Not $@rry   ",
		"Sorry Not Sorry   ",
		"Sorry Not Sorry   ",
		"Sorry Not Sorr^   ",
		"Sorry Not Sorr    ",
		"Sorry Not Sor     ",
		"Sorry Not So      ",
		"Sorry Not S@      ",
		"Sorry Not $       ",
		"Sorry Not         ",
		"Sorry No^         ",
		"Sorry No          ",
		"Sorry N           ",
		"Sorry             ",
		"Sorr              ",
		"Sor               ",
		"So                ",
		"S                 ",
		"$                 ",
		"                  "
	},

	['No Lives Matter'] = {
		"                  ",
		"N                 ",
		"No                ",
		"No L              ",
		"No Li             ",
		"No Liv            ",
		"No Live           ",
		"No Lives          ",
		"No Lives M        ",
		"No Lives Ma       ",
		"No Lives Mat      ",
		"No Lives Matt     ",
		"No Lives Matte    ",
		"No Lives Matter   ",
		"No Lives Matter   ",
		"No Lives Matter   ",
		"No Lives Matter   ",
		"o Lives Matter    ",
		"Lives Matter      ",
		"ives Matter       ",
		"ves Matter        ",
		"es Matter         ",
		"s Matter          ",
		"Matter            ",
		"atter             ",
		"tter              ",
		"ter               ",
		"er                ",
		"r                 ",
		"                  "
	},

	['EZFrags.co.uk'] = {
		"                  ",
		"E                 ",
		"EZ                ",
		"EZf               ",
		"EZfr              ",
		"EZfra             ",
		"EZfrag            ",
		"EZfrags           ",
		"EZfrags.          ",
		"EZfrags.c         ",
		"EZfrags.co        ",
		"EZfrags.co.       ",
		"EZfrags.co.u      ",
		"EZfrags.co.uk     ",
		"EZfrags.co.uk     ",
		"EZfrags.co.uk     ",
		"EZfrags.co.uk     ",
		"EZfrags.co.uk     ",
		"EZfrags.co.u      ",
		"EZfrags.co.       ",
		"EZfrags.co.       ",
		"EZfrags.co        ",
		"EZfrags.c         ",
		"EZfrags.          ",
		"EZfrags           ",
		"EZfrag            ",
		"EZfra             ",
		"EZfr              ",
		"EZf               ",
		"EZ                ",
		"E                 ",
		"                  "
	},
}


local function for_clantags()
	if not enable_clantags:GetValue() then
		if clantagset == 1 then
			set_clantag("", "")
			clantagset = 0
		end

		return
	end

	local mode = clantag_mode:GetString()
	local tag = ClanTags[mode]
	local curtime = math.floor(globals.CurTime() * 2.3)

	if old_time ~= curtime then
		local t = tag[curtime % #tag+1]
		set_clantag(t, t)
	end

	old_time = curtime
	clantagset = 1
end
--]]

-- KillSays
local KillSays = {
	Hentai = {
		Kill = {
			"П-прости онии-чан п-пожалуйста б-будь жестче ;w;",
			"Т-теперь я вся мокрая, сэмпай!",
			"Н-не прикасайся ко мне там, сэмпай",
			"П-пожалуйста, л-люби меня сильнее, ониичан, ох, грх, аааа~!",
			"Дай мне всю свою сперму, сэмпай, аааа~",
			"Трахни меня сильнее, чан!",
			"Боже мой, я так сильно тебя ненавижу, сэмпай, но, пожалуйста, продолжай трахать меня сильнее! ааа~",
			"Т-Тебе нравится, когда мои полосатые трусики намокают от тебя и твоего твердого члена? иууу хозяин, ты такой пошлый ^0^~",
			"Кун, твой милый маленький член между губами моей киски выглядит очень мило, я краснею",
			"Х-хозяин, тебе приятно, когда я скользю сиськами вверх и вниз по твоей милой мужской части?",
			"О-оничан, мои пальцы ног такие теплые от твоей спермы на них uwu~",
			"Давай уже снимем этот купальник <3 я выпью твой неведомый талый сок",
			"П-прекрати сэмпай, если мы продолжим издавать эти непристойные звуки, я кончу~~",
			"Ты такой извращенец, что наполнил меня своим детским тестом, сэмпай.~~",
			"Наполни мою детскую комнату своей спермой-куном. ^-^",
			"Х-хозяин, не шлепайте мою маленькую попку так сильно, аааа~~~ я м-мокну из-за этого~",
			"Сэмпай, твой член уже пульсирует от моих огромных сисек~",
			"Эй, кун, можно мне немного спермы??",
			"М-моя детская комната переполнена твоей спермой х-хозяин",
			"Наполни мою горловую киску своей спермой-куном.",
			"Это не гейски, если вы носите по высокие бедра х-хозяин",
			"М-мне нужно где-то высосать мою порцию спермы. Могу я одолжить твой автобус?",
			"А-ах, дерьмо... Т-твой член большой и в моей заднице -- уже~?!",
			"Я проглочу твою липкую сущность вместе с тобой~!",
			"Б-Бака, пожалуйста, позволь мне быть твоей фембойской сисси-шлюшкой!",
			"Это пенис UwU ты сказав мне, что ты девчуля!!",
			"Аааа... Это похоже на сбывшуюся мечту... Я засуну свой член тебе в задницу...!",
			"Эй, кто хочет кусок этой пухлой киски 19-летнего мальчика? Один файл, мальчики, приходите, пока горячо!",
			"Х-хозяин, если ты продолжишь так сильно толкать, мои сиськи отвалятся!",
			"Когда ты хочешь встретиться снова? Мне действительно понравился твой член! (,,◠∇◠) Я хочу, чтобы ты и только ты каждый день трахал им мою киску! (≧∇≦)",
			"Почему я делал это кроссплей? Потому что я чувствовала, что это может быть весело ... Но теперь я просто маленькая девочка, которая кончает от больших членов!",
			"Н-не поймите неправильно!!! Я не хочу, чтобы ты трахал мою к-киску, потому что я л-люблю тебя или что-то в этом роде! т-точно нет!",
			"Я-я знаю, я говорила, что ты можешь быть настолько грубым, насколько захочешь... Но фистинг-сюрприз был не тем, что я имела в виду!!",
			"П-почему в последнее время... Т-ты не играл с моей задницей!!?",
		},

		Death = {
			"Хе-хе, не трогай меня там Онии-чанн UwU",
			"Твоя сперма на моем мокром клиторе х-хозяин",
			"Такое ощущение, что ты бьешь меня силой тысячи солнц, сэмпай.",
			"Д-Да прямо там С-Сэмпай ура",
			"П-пожалуйста, продолжайте наполнять мою детскую комнату С-сэмпай",
			"Б-братик, мне было так хорошо, когда ты вошел в мою киску",
			"П-пожалуйста, братик, продолжай наполнять мою детскую комнату своим тающим соком.",
			"Б-братик, ты всего один выстрел в мою детскую комнату",
			"Я-я не что иное, как трах-игрушечная шлюха для твоего м-монстрического траха!",
			"Доминируй над моими яичниками своими злобными пловцами!",
			"Т-твой мясной скипетр проник в мою тугую мальчишечью дырочку",
			"Мнн БЫСТРЕЕ... СИЛЬНЕЕ! Преврати меня в свою фембойскую шлюху~!",
			"Мммм- успокой меня, приласкай меня, Трахни меня, размножай меня!",
			"Вонзай свой толстый, мокрый, пульсирующий член все глубже и глубже в мою киску~!!",
			"Хья! Не мои уши! Ах... щекотно! Ах!",
			"Кота... Не могу поверить, насколько он БОЛЬШОЙ... Подожди! Забудь об этом!! Неужели Нюу-чан действительно трахала его сиськами!?",
			"Сенпай засунь свой пенис поглубже в м-мою киску (>ω<) пожалуйста",
			"Я кончаю от того, что ты трахаешь мою жопу мммммм!",
			"П-пожалуйста, будь нежнее, С-сэмпай!",
			"Н-не поймите неправильно!! Я не отказалась от своей жизненной силы ради тебя, потому что ты мне нравишься или что-то в этом роде!!",
			"Позволь мне попробовать твой фута-член моей киской~",
		}
	},

	Lewd = {
		Kill = {
			"О, ты хочешь есть? Хочешь принять ванну? Или... ты хочешь меня!?",
			"Это не гейски, если ты проглотишь улики!",
			"Это пенис UwU ты сказав мне, что ты девочка!!",
			"Приглашаем тебя трахнуть мою задницу!",
			"Хватай их, сжимай, щипай, тяни, облизывай, кусай, соси!",
			"Такое ощущение, что твой член скользит в слизистую кучу макарон!",
			"Это петушиная полиция! Держи так, чтобы я видел!",
			"Оооо, ты кончила от кримпая? Какая ты похотливая сука!",
			"Я дрочил каждый божий день... Рожал бесчисленное количество улиток... Все время фантазируя о том дне, когда я трахну тебя!",
			"Ты смотришь порно, вместо этого ты мог бы использовать свою младшую сестру!",
			"Ммм... Не хочу показаться грубым, но ты принимала ванну? Твои трусики кажутся немного желтыми...",
			"Папа ты лжец! Как ты мог сказать такое, имея такую ​​ОГРОМНУЮ эрекцию.",
			"Я-я просто хочу одолжить твой член...",
			"Если мужчина вставит свой шланг в черную дыру другого мужчины, смогут ли они родить ребенка?",
			"У-у меня был зуд там внизу... и мне просто нужно было что-то вставить туда!",
			"У тебя аппетитно выглядящие трусики...",
			"Ты мое личное ведро со спермой!!",
			"Я-я кончаю, я кончаю, кончай со мной!",
			"То что ты сопротивляешься только делает мой пенис тверже!",
			"Кончи, непослушный член! Сделай это! Сделай это! СДЕЛАЙ ЭТО!!!",
			"Мальчики просто не могут считать себя взрослыми... Пока им не довелось кончить вместе с женским пахом.",
			"Мы оба будем трахать твою киску одновременно!",
			"Когда все разошлись по домам, а класс пуст, у тебя нет другого выбора, кроме как разоблачить себя и подрочить, верно?",
		},

		Death = {
			"Доминируй над моими яичниками своими злобными пловцами!",
			"Оплодотворите меня своими вирусными генами!",
			"М-мое тело жаждет твоего сладкого молока",
			"Мои соски затвердели",
			"Проникай в меня, пока я не лопну!",
			"Мммм- успокой меня, приласкай меня, Трахни меня, размножай меня!",
			"Я твое личное ведро со спермой!!",
			"Ты действительно можешь винить меня за то, что я встал после того, как увидел это?",
			"Мы вдвоем покроем мою сестру своей спермой!",
			"Это... Это почти как... как будто я его насилую!",
			"Ты оплодотворяешь мои яйца!?",
			"Если бы ты не был извращенцем, тебе бы не нравилось, что девушка делает тебе в твоей заднице, не так ли?",
			"Ну-ну... Какой ты милашка! Я претендую на твою девственность!",
			"О, да! Ты хочешь потрахаться?",
			"Я хорни прямо сейчас!",
		}
	},

	Apologetic = {
		Sorry = {"расстроен потому что","чувствую себя грустно потому что","огорчен потому что","злюсь на себя потому что","был диагностирован с депрессией потому что","разбит сердцем потому что","извиняюсь потому что","хотел бы извиниться, потому что","очень раскаиваюсь, потому что","чувствую себя стыдливо, потому что"},
		Kill = {"убил","уничтожил","окончил","закончил","истребил","завершил","устранил","казнил","вырезал","зарезал","выстрелил и убил"},
		Regret = {":(","Пожалуйста, прости меня","Я не хотел.","Я ничтожество","Я буду полегче с тобою в следующий раз.","Это была моя вина","Пожалуйста, извини за мое поведение"}
	},

	Edgy = {
		Kill = {
			"Пускай мой K/D говорит",
			"бесится птмчт плох",
			"Нет АВ, Нет разговора",
			"КФГ иссуе, юзер забанен, закрыто.",
			"IQ иссуе",
			"Я причина, по которой твой отец гей, педик",
			"Как твоя мама поживает после прошлой ночи? Попа не болит?",
			"Мертвые люди не могут говорить, nn",
			"Теплота, любовь и нежность. Это то, что я забрал у тебя.",
			"Я заключил контракт с дьяволом, поэтому я не могу дружить с богом.",
			"Трупы хороши. Они не болтают.",
			"Слабым суждено лежать под сапогами сильных.",
			"Настройки -> Как играть",
			"Мир был бы лучше без тебя",
			"Жизнь - это бесконечные страдания...",
			"Я просто убиваю пауков, чтобы спасти бабочек.",
			"Страх создает порядок.",
			"Сколько бы ты ни плакал, я не остановлюсь.",
			"Удален",
			"*DEAD*",
			"Re:Solved",
			"Уни_чтожен",
			"Если бы Б-Г хотел, чтобы ты жил, он бы не создал меня.",
			"Заработал свое проклятие",
			"Месть это я",
			"Если с первого раза не получится... пробуй, пробуй еще раз.",
			"Следи за своей головой",
			"Когда будешь готов, позвони мне",
			"Я стал смертоносным разрушителем миров",
			"Легко пришло, легко ушло",
			"Я стою - ты идешь",
			"Конец линии для тебя",
			"Может быть завтра.",
			"Я блять непобедим.",
			"Увидимся через пару минут.",
			"Ты сильный ребенок, но я выше понятия сил",
		},

		Death = {
			"Ты убил меня только потому, что у меня кончилось здоровье...",
			"Бьюсь об заклад, с мертвыми легче ладить.",
			"Настоящий ад находится внутри человека.",
			"Те, кто убивает, должны быть готовы к тому, что их убьют.",
			"Я отдал тебе этот",
			"Поздравляем! Теперь ты есть в ТАБе.",
			"Эмоции - это психическое расстройство",
			"Carpe Diem",
			"Ушел, но не забыт",
			"I'll be back",
			"Применение ответных мер...",
			"Нет концов, только новые начала",
		}
	},

	EZfrags = {
		Kill = {
			"Visit www.EZfrags.co.uk for the finest public & private CS:GO cheats",
			"Stop being a noob! Get good with www.EZfrags.co.uk",
			"I'm not using www.EZfrags.co.uk, you're just bad",
			"You just got pwned by EZfrags, the #1 CS:GO cheat",
			"If I was cheating, I'd use www.EZfrags.co.uk",
			"Think you could do better? Not without www.EZfrags.co.uk",
		},

		Death = {
			"You only killed me because I'm not using www.EZfrags.co.uk",
			"You're lucky I'm not using www.EZfrags.co.uk",
			"I would have destroyed you if I was using www.EZfrags.co.uk",
			"You only killed me because you're using www.EZfrags.co.uk the finest public & private CS:GO cheat",
		}
	},

    AFK = {
        AfkSorry = {"Извини",},
        Kill = {"Я АФК. Это бот. Ты умер от ",}, 
        Death = {"Ты убил меня только потому что я в АФК.",}
    },
}


local function for_chatsay(e)
	if not enable_killsays:GetValue() then
		return
	end

	if e:GetName() ~= 'player_death' then
		return
	end

	local mode = killsay_mode:GetString()
	local lp = client.GetLocalPlayerIndex()
	local victim = client.GetPlayerIndexByUserID(e:GetInt('userid'))
	local attacker = client.GetPlayerIndexByUserID(e:GetInt('attacker'))
	local say = KillSays[mode]

	if attacker == lp and victim ~= lp then
		local msg = say.Kill[math.random(#say.Kill)]

		if mode == 'Apologetic' then
			local victim_name = client.GetPlayerNameByIndex(victim)

			local sry1 = say.Sorry[ math.random(#say.Sorry) ]
			local sry3 = say.Regret[ math.random(#say.Regret) ]

			msg = ('%s, я %s я %s тебя. %s'):format(victim_name, sry1, msg, sry3)
		end

        if mode == 'AFK' then
            local victim_name = client.GetPlayerNameByIndex(victim)
            local attacker_weapon = e:GetString('weapon')

            local afk1 = say.AfkSorry[ math.random(#say.AfkSorry) ]

            msg = ('%s %s, %s %s.'):format(afk1, victim_name, msg, attacker_weapon)
        end

        timer.Create("message_delay", killsay_speed:GetValue(), 1, function()
            client.ChatSay( msg )
        end)
	elseif attacker ~= lp and victim == lp then
		if say.Death then
            timer.Create("message_delay", msgevents_speed:GetValue(), 1, function()
                client.ChatSay( say.Death[math.random(#say.Death)] )
			end)
		end
	end
end


--------Lua Callbacks & Listeners--------
client.AllowListener('player_death')
client.AllowListener('grenade_thrown')
callbacks.Register('FireGameEvent', for_chatsay)
callbacks.Register('FireGameEvent', for_throwsay)
--callbacks.Register('Draw', for_clantags)
callbacks.Register('CreateMove', CrosshairRecoil)
callbacks.Register("Draw", UnlockInventory)
callbacks.Register("Unload", OnUnload)
