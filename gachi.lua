--------Auto Update--------
local SCRIPT_FILE_NAME = GetScriptName();
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/D4rkM6stery/AW_Gachi.lua/main/gachi.lua";
local BUILD_FILE_ADDR = "https://raw.githubusercontent.com/D4rkM6stery/AW_Gachi.lua/main/Version.txt";
local BUILD_NUMBER = "1";
local build_check_done = false;
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
		draw.Text(7 - 650 + fadein, 7, "GigachadAlert's");
		draw.Color(225,225,225,255 - fadeout);
		draw.Text(7 + draw.GetTextSize("GigachadAlert's ") - 650 + fadein, 7, "Script");
		draw.Color(0,180,255,255 - fadeout);
		draw.Text(7 + draw.GetTextSize("GigachadAlert's Script  ") - 650 + fadein, 7, "\\");
		spacing = draw.GetTextSize("GigachadAlert's Script  \\  ");
		draw.SetFont(updaterfont2);
		draw.Color(225,225,225,255 - fadeout);
	end

    if (update_available and not update_downloaded) then
		draw.Text(7 + spacing - 650 + fadein, 9, "Downloading latest build.");
        local new_build_content = http.Get(SCRIPT_FILE_ADDR);
        local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        old_script:Write(new_build_content);
        old_script:Close();
        update_available = false;
        update_downloaded = true;
	end
	
    if (update_downloaded) and updateframes < 5.5 then
		draw.Text(7 + spacing - 650 + fadein, 9, "Update available, please reload the script.");
    end

    if (not build_check_done) then
        build_check_done = true;
		local build = http.Get(BUILD_FILE_ADDR);
		build = string.gsub(build, "\n", "");
		if (build ~= BUILD_NUMBER) then
            update_available = true;
		else 
			up_to_date = true;
		end
	end
	
	if up_to_date and updateframes < 5.5 then
		draw.Text(7 + spacing - 650 + fadein, 9, "Successfully loaded latest build: build num. " .. BUILD_NUMBER);
	end
end)

local btCurWpn = 10
local btWpnClassInt = 0

local function getCurWpn()
    if entities.GetLocalPlayer() ~= nil then
        local player = entities.GetLocalPlayer()
		if player:GetWeaponID() ~= nil then
        	btCurWpn = player:GetWeaponID()
		end
        if btCurWpn == 2 or btCurWpn == 3 or btCurWpn == 4 or btCurWpn == 30 or btCurWpn == 32 or btCurWpn == 36 or btCurWpn == 61 or btCurWpn == 63 then
            btWpnClassInt = 1
        elseif btCurWpn == 1 then
            btWpnClassInt = 2
        elseif btCurWpn == 7 or btCurWpn == 8 or btCurWpn == 10 or btCurWpn == 13 or btCurWpn == 16 or btCurWpn == 39 or btCurWpn == 61 then
            btWpnClassInt = 3
        elseif btCurWpn == 40 then
            btWpnClassInt = 4
        elseif btCurWpn == 9 then
            btWpnClassInt = 5
        elseif btCurWpn == 38 or btCurWpn == 11 then
            btWpnClassInt = 6
        elseif btCurWpn == 17 or btCurWpn == 19 or btCurWpn == 23 or btCurWpn == 24 or btCurWpn == 26 or btCurWpn == 33 or btCurWpn == 34 then
            btWpnClassInt = 7
        elseif btCurWpn == 25 or btCurWpn == 27 or btCurWpn == 29 or btCurWpn == 35 then
            btWpnClassInt = 8
        elseif btCurWpn == 28 or btCurWpn == 14 then
            btWpnClassInt = 9
        else
            btWpnClassInt = 10
        end
    end
end

local eventInitList = {
	"player_radio",
	"weapon_fire",
	"bomb_planted",
	"bomb_exploded",
	"player_radio",
	"round_start",
	"inspect_weapon"
}

for i=1, #eventInitList do
	client.AllowListener(eventInitList[i])
end

local function for_weapon_fire(event)
	if event:GetName() ~= "weapon_fire" then return end

	if client.GetPlayerIndexByUserID( event:GetInt('userid') ) ~= client.GetLocalPlayerIndex() then
		return
	end

	local wep = event:GetString('weapon')
	if (wep == "negev" or wep == "m249") then
		client.Command("play gachi/lmg.wav", false)
	end

end

callbacks.Register("FireGameEvent", for_weapon_fire)