script_name('Admin-Tools by AlanButler')
script_author('Alan_Butler') -- vk.com/tamerlankar

require 'lib.sampfuncs'
require 'lib.moonloader'

local dlstatus = require('moonloader').download_status
local hook = require 'lib.samp.events'
local inicfg = require "inicfg"
local keys = require "vkeys"
local imgui = require "imgui"
local rkeys = require 'rkeys'
local memory = require 'memory'
local fa = require 'faIcons'
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
local ffi = require 'ffi'
local encoding = require("encoding")
encoding.default = 'CP1251'
u8 = encoding.UTF8
local notf = import 'imgui_notf.lua'
local imadd = require 'imgui_addons'

local themes = import "resource/imgui_themes.lua"

-- бла-бла-бла
-- бла-бла-бла
-- бла-бла-бла
-- бла-бла-бла



local style = imgui.GetStyle()
local colors = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4

local directIni = "moonloader\\AdminTools\\settings.ini"

local mainIni = inicfg.load(nil, directIni)
--local stateIni = inicfg.save(mainIni, directIni)



local inifolderpath = 'moonloader//AdminTools'
if not doesDirectoryExist(inifolderpath) then
    createDirectory(inifolderpath) 
end

if not doesFileExist("moonloader\\AdminTools\\settings.ini") then
    local f = io.open("moonloader\\AdminTools\\settings.ini", "a")
    f:write(
[[[config]
toggle_auto_write_adm_password=false
show_pass=false
agm_status=false
hide_password_adm=true
pass=none
colorConnection=123
auto_login_adm_pass=false
lovlya_gg=false
zapros_box_status=false
hide_pass=false
spawn_az=false
show_admpass=false
wh_status=true
log_connect_status=true
passadm=none
trac_status=false
pass_status=false
mentionSk=false
spec_capt=false
skAfter=2
vneKv=false
vneKvAfter=5
tag=none
lvl_admin=0
show_update=true
theme=2
getban=false
sendban=false
getwarn=false
sendwarn=false
getbanip=false
sendbanip=false
getmute=false
sendmute=false
getjail=false
sendjail=false
getkick=false
sendkick=false
getskick=false
sendskick=false
getaad=false
sendaad=false
geto=false
sendo=false
getfreeze=false
sendfreeze=false
getunfreeze=false
sendunfreeze=false
getrmute=false
sendrmute=false
getgivegun=false
sendgivegun=false
getsethp=false
sendsethp=false
getuval=false
senduval=false
getsetskin=false
sendsetskin=false]]
    )
    f:close()
end

imgui.Process = false

imgui.ToggleButton = require('imgui_addons').ToggleButton
imgui.HotKey = require('imgui_addons').HotKey
imgui.Spinner = require('imgui_addons').Spinner
imgui.BufferingBar = require('imgui_addons').BufferingBar

local buttons                 = {u8'1. Как получить админку? Ответ: По заявкам в группе VK; Выиграть на МП; Купить через /donaterub', u8'2. Как получить хелперку? Ответ: По заявкам в группе VK; Выиграть на МП; Купить через /donaterub', u8'3. Какие лидерки свободны? Ответ: /buylead', u8'4. Куда можно написать жалобу? Ответ: В свободную группу: vk.com/russia_sv', u8'5. Группа VK по гетто? Ответ: vk.com/grrp04', u8'6. Группа VK по мафиям? Ответ: vk.com/mrrp04', u8'7. Группа VK по гос? Ответ: vk.com/gosrrp04', u8'8. Увольте Ответ: Обратитесь к Лидеру/Заместителю / На метке в мэрии / /leave'}

local text_for_buttons = {
	u8"По заявкам в группе VK; Выиграть на МП; Купить через /donaterub",
	u8"По заявкам в группе VK; Выиграть на МП; Купить через /donaterub",
	u8"/buylead",
	u8"В свободную группу: vk.com/russia_sv",
	u8"vk.com/grrp04",
	u8"vk.com/mrrp04",
	u8"vk.com/gosrrp04",
	u8"Обратитесь к Лидеру/Заместителю / На метке в мэрии / /leave"
}


local gangs = {"Ballas", "Grove", "Vagos", "Aztec", "Rifa"}
local msgsToAll = {"/aad", "/o"}


local getBan = imgui.ImBool(mainIni.config.getban)
local sendBan = imgui.ImBool(mainIni.config.sendban)

local getWarn = imgui.ImBool(mainIni.config.getwarn)
local sendWarn = imgui.ImBool(mainIni.config.sendwarn)

local getBanip = imgui.ImBool(mainIni.config.getbanip)
local sendBanip = imgui.ImBool(mainIni.config.sendbanip)

local getMute = imgui.ImBool(mainIni.config.getmute)
local sendMute = imgui.ImBool(mainIni.config.sendmute)

local getJail = imgui.ImBool(mainIni.config.getjail)
local sendJail = imgui.ImBool(mainIni.config.sendjail)

local getKick = imgui.ImBool(mainIni.config.getkick)
local sendKick = imgui.ImBool(mainIni.config.sendkick)

local getSkick = imgui.ImBool(mainIni.config.getskick)
local sendSkick = imgui.ImBool(mainIni.config.sendskick)

local getAad = imgui.ImBool(mainIni.config.getaad)
local sendAad = imgui.ImBool(mainIni.config.sendaad)

local getO = imgui.ImBool(mainIni.config.geto)
local sendO = imgui.ImBool(mainIni.config.sendo)

local getFreeze = imgui.ImBool(mainIni.config.getfreeze)
local sendFreeze = imgui.ImBool(mainIni.config.sendfreeze)

local getUnfreeze = imgui.ImBool(mainIni.config.getunfreeze)
local sendUnfreeze = imgui.ImBool(mainIni.config.sendunfreeze)

local getRmute = imgui.ImBool(mainIni.config.getrmute)
local sendRmute = imgui.ImBool(mainIni.config.sendrmute)

local getGivegun = imgui.ImBool(mainIni.config.getgivegun)
local sendGivegun = imgui.ImBool(mainIni.config.sendgivegun)

local getSethp = imgui.ImBool(mainIni.config.getsethp)
local sendSethp = imgui.ImBool(mainIni.config.sendsethp)

local getUval = imgui.ImBool(mainIni.config.getuval)
local sendUval = imgui.ImBool(mainIni.config.senduval)

local getSetskin = imgui.ImBool(mainIni.config.getsetskin)
local sendSetskin = imgui.ImBool(mainIni.config.sendsetskin)

-- Combo

tmembers = {}
tplayer = {}
status = false

arr_get = {
	getBan.v,
	getWarn.v,
	getBanip.v,
	getMute.v,
	getJail.v,
	getKick.v,
	getSkick.v,
	getAad.v,
	getO.v,
	getFreeze.v,
	getUnfreeze.v,
	getRmute.v,
	getGivegun.v,
	getSethp.v,
	getUval.v,
	getSetskin.v
}

arr_send = {
	sendBan.v,
	sendWarn.v,
	sendBanip.v,
	sendMute.v,
	sendJail.v,
	sendKick.v,
	sendSkick.v,
	sendAad.v,
	sendO.v,
	sendFreeze.v,
	sendUnfreeze.v,
	sendRmute.v,
	sendGivegun.v,
	sendSethp.v,
	sendUval.v,
	sendSetskin.v
}

arr_getmainIni = {
	mainIni.config.getban,
	mainIni.config.getwarn,
	mainIni.config.getbanip,
	mainIni.config.getmute,
	mainIni.config.getjail,
	mainIni.config.getkick,
	mainIni.config.getskick,
	mainIni.config.getaad,
	mainIni.config.geto,
	mainIni.config.getfreeze,
	mainIni.config.getunfreeze,
	mainIni.config.getrmute,
	mainIni.config.getgivegun,
	mainIni.config.getsethp,
	mainIni.config.getuval,
	mainIni.config.getsetskin
}

local answers = {}

-- ProgressBar



-- locals for imgui windows

local ot_window = imgui.ImBool(false)
local amenu_window = imgui.ImBool(false)
local window_recon = imgui.ImBool(false)
local lvl_menu = imgui.ImBool(false)
local veh_create = imgui.ImBool(false)
local templeader_menu = imgui.ImBool(false)
local capt_menu = imgui.ImBool(false)
local aspawncars = imgui.ImBool(false)
local punish_menu = imgui.ImBool(false)
local warn_punish = imgui.ImBool(false)
local jail_punish = imgui.ImBool(false)
local mute_punish = imgui.ImBool(false)
local ban_punish = imgui.ImBool(false)
local kick_punish = imgui.ImBool(false)
local update = imgui.ImBool(false)

-- RadioButtons

local changer_imgui_themes = imgui.ImInt(mainIni.config.theme)

--  Buffers

local report_text_buff = imgui.ImBuffer(256)
local find_ask = imgui.ImBuffer(256)
local password_adm = imgui.ImBuffer(tostring(mainIni.config.passadm),256)
local pass = imgui.ImBuffer(tostring(mainIni.config.pass),256)
local finder = imgui.ImBuffer(256)
local skAfter = imgui.ImBuffer(tostring(mainIni.config.skAfter), 256)
local vneKvAfter = imgui.ImBuffer(tostring(mainIni.config.vneKvAfter), 256)
local time_to_aspawncars = imgui.ImBuffer(256)
local tag = imgui.ImBuffer(tostring(mainIni.config.tag),256)
local lvl_admin = imgui.ImBuffer(tostring(mainIni.config.lvl_admin), 256)

-- ToggleButton

local toggle_gg_lovlya = imgui.ImBool(false)
local toggle_auto_write_adm_password = imgui.ImBool(false)
local toggle_spawn_az = imgui.ImBool(false)
local toggle_agm = imgui.ImBool(false)
local toggle_pass = imgui.ImBool(false)
local toggle_wh = imgui.ImBool(false)
local toggle_trac = imgui.ImBool(false)
local toggle_gm = imgui.ImBool(false)


--[[
	local time_capt = 0
	while time_capt ~= 600 then
		time_capt ++ 1
	end

]]

-- CheckBox

local log_connect = imgui.ImBool(false)
local zapros_box = imgui.ImBool(false)
local keep_skin = imgui.ImBool(false)
local mention_sk = imgui.ImBool(false)
local mention_vneKv = imgui.ImBool(false)
local spec_capt = imgui.ImBool(false)



-- ban, warn, banip, mute, jail, kick, skick, aad, o, freeze, unfreeze, rmute, givegun, sethp, uval, setskin

arr_cmd = {
	"ban",
	"warn",
	"banip",
	"mute",
	"jail",
	"kick",
	"skick",
	"aad",
	"o",
	"freeze",
	"unfreeze",
	"rmute",
	"givegun",
	"sethp",
	"uval",
	"setskin"
}


local first_gang = imgui.ImInt(0)
local second_gang = imgui.ImInt(0)
local choosemsgs = imgui.ImInt(0)
local choosemsgs_aspawncars = imgui.ImInt(0)

local mem = require 'memory'

local BulletSync = {lastId = 0, maxLines = 15} -- 'maxLines = ' сколько макс.трейсеров
for i = 1, BulletSync.maxLines do
    BulletSync[i] = {enable = false, o = {x, y, z}, t = {x, y, z}, time = 0, tType = 0, pid = nil}
end


traicers = mainIni.config.trac_status
mention_sk.v = mainIni.config.mentionSk
spec_capt.v = mainIni.config.spec_capt
mention_vneKv.v = mainIni.config.vneKv
tag.v = mainIni.config.tag

stop = 0
started = 0
prinato = 0
active_report = 0
active_report2 = 0
local ToScreen = convertGameScreenCoordsToWindowScreenCoords
amenu = 1

findReport = false
reportActive = false

input_rabotaet = false

ffi.cdef[[
struct stKillEntry
{
	char					szKiller[25];
	char					szVictim[25];
	uint32_t				clKillerColor; // D3DCOLOR
	uint32_t				clVictimColor; // D3DCOLOR
	uint8_t					byteType;
} __attribute__ ((packed));

struct stKillInfo
{
	int						iEnabled;
	struct stKillEntry		killEntry[5];
	int 					iLongestNickLength;
  	int 					iOffsetX;
  	int 					iOffsetY;
	void			    	*pD3DFont; // ID3DXFont
	void		    		*pWeaponFont1; // ID3DXFont
	void		   	    	*pWeaponFont2; // ID3DXFont
	void					*pSprite;
	void					*pD3DDevice;
	int 					iAuxFontInited;
    void 		    		*pAuxFont1; // ID3DXFont
    void 			    	*pAuxFont2; // ID3DXFont
} __attribute__ ((packed));
 void keybd_event(int keycode, int scancode, int flags, int extra);
]]

function cmd_testtest()
	sampAddChatMessage("I don't know how did you run this function",-1)
end

function EmulateKey(key, isDown)
    if not isDown then
        ffi.C.keybd_event(key, 0, 2, 0)
    else
        ffi.C.keybd_event(key, 0, 0, 0)
    end
end

function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
        font_config.MergeMode = true
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
    end
end

function imgui.CenterTextColoredRGB(text)
    local width = imgui.GetWindowWidth()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local textsize = w:gsub('{.-}', '')
            local text_width = imgui.CalcTextSize(u8(textsize))
            imgui.SetCursorPosX( width / 2 - text_width .x / 2 )
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else
                imgui.Text(u8(w))
            end
        end
    end
    render_text(text)
end

function main()
	if not isSampLoaded() and not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(0) end
	imgui.Process = false
	imgui.ShowCursor = false

	adress,  port = sampGetCurrentServerAddress()
	ip = string.format('%s:%s', adress, port)
	if ip == '62.122.213.28:7777' or ip == '45.138.72.74:2244' then
		sampAddChatMessage("{00FF00}[Admin-Tools]{FFFFFF} Активирован", -1)
	else
			sampAddChatMessage("{FF0000}[Admin-Tools]{FFFFFF} РАБОТАЕТ ТОЛЬКО НА RUSSIA RP EKATERINBURG", -1)
			lua_thread.create(function()
				wait(1000)
				thisScript:unload()
			end)
	end
	autoupdate("https://raw.githubusercontent.com/edisondorado/admmtools/main/admintools", '['..string.upper(thisScript().name)..']: ', "vk.com/rrp_admtools")

	forrun_aspawncars = lua_thread.create_suspended(thread_aspawncars)

	sampAddChatMessage("{00FF00}[Admin-Tools] {FFFFFF}Чтобы отобразить/скрыть курсор, нажмите на клавишу M",-1)

	imgui.SwitchContext()
	themes.SwitchColorTheme(mainIni.config.theme)
	sampRegisterChatCommand('ot', cmd_ot)
	sampRegisterChatCommand('amenu', cmd_amenu)
	sampRegisterChatCommand('re', cmd_recon)
	sampRegisterChatCommand('reoff', cmd_reoff)
	sampRegisterChatCommand('zagon', cmd_zagon)
	sampRegisterChatCommand("nabor", cmd_nabor)
	sampRegisterChatCommand("templeader", cmd_templeader)
	sampRegisterChatCommand("meuval", cmd_meuval)
	sampRegisterChatCommand("capt", cmd_capt)
	sampRegisterChatCommand("aspawncars", cmd_aspawncars)
	sampRegisterChatCommand("ladmins", cmd_ladmins)
	kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())
	while true do
		wait(0)
		if isKeyDown(71) then
		while isKeyDown(71) do wait(0) end
			if(active_report == 2) then
					lua_thread.create(function()
					sampSendChat("/"..cmd.." "..paramssss)
					status("true", 1)
					wait(1000)
					sampSendChat("/a [Forma] +")
					wait(1000)
					sampSendChat("/a [Forma] Выполнено по просьбе "..admin_nick)--[[
					wait(1000)
					sampSendChat("/time")
					wait(500)
					makeScreenshot()]]
					active_report2 = 1
				end)
			end
		end
		_, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
		nick = sampGetPlayerNickname(id)
		punish_menu.v = window_recon.v
		if isKeyJustPressed(VK_M) and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() and not isSampfuncsConsoleActive() then
			if checkcursor then
				checkcursor = false
				imgui.ShowCursor = false
			else
				checkcursor = true
				imgui.ShowCursor = true
			end
		end
		if mainIni.config.wh_status then
			nameTagOn()
		else
			nameTagOff()
		end
		local oTime = os.time()
        if mainIni.config.trac_status then
            for i = 1, BulletSync.maxLines do
                if BulletSync[i].enable == true and BulletSync[i].time >= oTime then
                    local sx, sy, sz = calcScreenCoors(BulletSync[i].o.x, BulletSync[i].o.y, BulletSync[i].o.z)
                    local fx, fy, fz = calcScreenCoors(BulletSync[i].t.x, BulletSync[i].t.y, BulletSync[i].t.z)

                    local color_ = sampGetPlayerColor(BulletSync.pid)
                    local aa, rr, gg, bb = explode_argb(color_)
                    local color_rgb = join_argb(255, rr, gg, bb)

                    if sz > 1 and fz > 1 then
                        renderDrawLine(sx, sy, fx, fy, 1, color_rgb)
                        renderDrawPolygon(fx, fy-1, 3, 3, 4.0, 10, color_rgb)
                    end
                end
            end
		end --  трейсера
		if mainIni.config.show_update then
			update.v = true
			mainIni.config.show_update = false
		end
	end
end

function autoupdate(json_url, prefix, url)
	local dlstatus = require('moonloader').download_status
	local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
	if doesFileExist(json) then os.remove(json) end
	downloadUrlToFile(json_url, json,
	  function(id, status, p1, p2)
		if status == dlstatus.STATUSEX_ENDDOWNLOAD then
		  if doesFileExist(json) then
			local f = io.open(json, 'r')
			if f then
			  local info = decodeJson(f:read('*a'))
			  updatelink = info.updateurl
			  updateversion = info.latest
			  f:close()
			  os.remove(json)
			  if updateversion ~= thisScript().version then
				lua_thread.create(function(prefix)
				  local dlstatus = require('moonloader').download_status
				  local color = -1
				  sampAddChatMessage(('{00FF00}[Admin-Tools]{FFFFFF}Обнаружено обновление. Узнать статус обновления можно в консоли\"` \ ё \ ~\"', color)
				  wait(250)
				  downloadUrlToFile(updatelink, thisScript().path,
					function(id3, status1, p13, p23)
					  if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
						print(string.format('Загружено %d из %d.', p13, p23))
					  elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
						print('Загрузка обновления завершена.')
						sampAddChatMessage(('{00FF00}[Admin-Tools]{FFFFFF}Обновление завершено!'), color)
						goupdatestatus = true
						lua_thread.create(function() wait(500) thisScript():reload() end)
					  end
					  if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
						if goupdatestatus == nil then
						  sampAddChatMessage(('{00FF00}[Admin-Tools]{FFFFFF}Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
						  update = false
						end
					  end
					end
				  )
				  end, prefix
				)
			  else
				update = false
				print('v'..thisScript().version..': Обновление не требуется.')
			  end
			end
		  else
			print('v'..thisScript().version..': Не могу проверить обновление. Проверьте самостоятельно на '..url)
			update = false
		  end
		end
	  end
	)
	while update ~= false do wait(100) end
end

function cmd_aspawncars()
	time_to_aspawncars.v = "15"
	aspawncars.v = not aspawncars.v
	imgui.Process = aspawncars.v
end

function cmd_capt()
	if captStatus then
		capt_menu.v = not capt_menu.v
		imgui.Process = capt_menu.v
	else
		sampAddChatMessage("{FF0000}[Admin-Tools]{FFFFFF} В данный момент капт неактивен!",-1)
	end
end

function status(parsasm, ggbc)
	if parsasm == "true" then
	active_report2 = 1
	prikoll = "false"
		if ggbc == 5 then
		active_report2 = 0
		started = 0
		end
		active_report = 1
		printStyledString("Admin form accepted", 5000, 5)
		bbstart = -1
	else
	bbstart = -1
	bbstart = bbstart + ggbc
	if bbstart == 0 then
	active_report = 2
	end
		if active_report2 == 0 then
		wait(1000)
		printStyledString('Admin form '..ggbc.." wait", 1000, 5)
		end
	end
end

function cmd_meuval()
	sampSendChat("/uval "..id.." 1")
end

function cmd_templeader()
	templeader_menu.v = not templeader_menu.v
	imgui.Process = templeader_menu.v
end

function cmd_nabor()
	lua_thread.create(function()
	sampSendChat("/a z /o")
	wait(1000)
	sampSendChat("/o INFO || Лидеры/Заместители, проводим наборы в Ваши организации")
	wait(1000)
	sampSendChat("/a o /o")
	end)
end

function cmd_zagon()
	lua_thread.create(function()
	sampSendChat("/a /RE /PM /DEFINE -- РАБОТАЕМ АДМИНИСТРАТОРЫ")
	wait(1000)
	sampSendChat("/a /RE /PM /DEFINE -- РАБОТАЕМ АДМИНИСТРАТОРЫ")
	wait(1000)
	sampSendChat("/a /RE /PM /DEFINE -- РАБОТАЕМ АДМИНИСТРАТОРЫ")
	wait(1000)
	sampSendChat("/c /PM /DEFINE -- РАБОТАЕМ ХЕЛПЕРЫ")
	wait(1000)
	sampSendChat("/c /PM /DEFINE -- РАБОТАЕМ ХЕЛПЕРЫ")
	wait(1000)
	sampSendChat("/c /PM /DEFINE -- РАБОТАЕМ ХЕЛПЕРЫ")
	end)
end

function cmd_recon(args)
	id_recon = args
	sampSendChat('/re ' .. args)
	window_recon.v = true
	imgui.Process = window_recon.v
	sampAddChatMessage('{FF0000}[Admin-Tools]{FFFFFF} Чтобы показать%/скрыть курсор нажмите на M', -1)
end

function cmd_veh()
	veh_create.v = not veh_create.v
	imgui.Process = veh_create.v
end

function cmd_ot()
	if findReport then
		findReport = false
		notf.addNotification("Поиск репорта отключен!", 5)
	else
		findReport = true
		notf.addNotification("Поиск репорта активен!", 5)
	end
end

function cmd_reoff(args)
	window_recon.v = false
	imgui.Process = window_recon.v
	sampSendChat('/re off')
end
function cmd_amenu()
	amenu_window.v = not amenu_window.v
	imgui.Process = amenu_window.v
end

function makeScreenshot(disable) -- если передать true, интерфейс и чат будут скрыты
    if disable then displayHud(false) sampSetChatDisplayMode(0) end
    require('memory').setuint8(sampGetBase() + 0x119CBC, 1)
    if disable then displayHud(true) sampSetChatDisplayMode(2) end
end



function thread_aspawncars()
	if choosemsgs_aspawncars.v == 0 then -- /aad
		wait_for_aspawncars = time_to_aspawncars.v .. "000"
		sampSendChat("/aad INFO || Через "..time_to_aspawncars.v.." секунд произойдет тех.респавн транспорта!")
		wait(wait_for_aspawncars)
		sampSendChat("/spawncars")
	elseif choosemsgs_aspawncars.v == 1 then -- /o
		wait_for_aspawncars = time_to_aspawncars.v .. "000"
		sampSendChat("/o INFO || Через "..time_to_aspawncars.v.." секунд произойдет тех.респавн транспорта!")
		wait(wait_for_aspawncars)
		sampSendChat("/spawncars")
	end
end

function imgui.OnDrawFrame()
	if update.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(400, 400), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'Обновление!', nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		imgui.CenterTextColoredRGB("Обновление 4.1 (7)")
		imgui.Text(u8[[- Добавлено окно с описанием всех новых обновлений
- Добавлена панель с быстрой выдачей наказанией в реконе
- Пофикшен баг с автоответчиком(ник теперь индивидуальный)
- Частично изменена система принятии форм]])
		imgui.SetCursorPosX((imgui.GetWindowWidth() - 215));
		if imgui.Button(u8"Закрыть") then
			update.v = false
			mainIni.config.show_update = false
		end
		imgui.End()
	end
	if jail_punish.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(200, 400), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'JAIL', jail_punish, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		if imgui.Button(u8"\t\t\t\t\t  DM", imgui.ImVec2(192,40)) then --10 minute
			sampSendChat("/jail " ..id_recon.." 10 ДМ")
			jail_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t  DM in ZZ", imgui.ImVec2(192,40)) then --
			sampSendChat("/jail " ..id_recon.." 15 ДМ в зз")
			jail_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\tЧиты", imgui.ImVec2(192,40)) then --
			sampSendChat("/jail " ..id_recon.." 30 Читы")
			jail_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\t  DB", imgui.ImVec2(192,40)) then --
			sampSendChat("/jail " ..id_recon.." 10 ДБ")
			jail_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\t  SK", imgui.ImVec2(192,40)) then --
			sampSendChat("/jail " ..id_recon.." 15 СК")
			jail_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\t  TK", imgui.ImVec2(192,40)) then --
			sampSendChat("/jail " ..id_recon.." 10 ТК")
			jail_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\t  PG", imgui.ImVec2(192,40)) then --
			sampSendChat("/jail " ..id_recon.." 10 ПГ")
			jail_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\t  RK", imgui.ImVec2(192,40)) then --
			sampSendChat("/jail " ..id_recon.." 7 РК")
			jail_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t  Багоюз", imgui.ImVec2(192,40)) then --
			sampSendChat("/jail " ..id_recon.." 15 Багоюз")
			jail_punish.v = false
		end
		if imgui.Button(u8"\t\t   Читы во фракц.", imgui.ImVec2(192,40)) then --
			sampSendChat("/jail " ..id_recon.." 15 Читы во фракции")
			lua_thread.create(function()wait(1000)end)
			sampSendChat("/uval "..id_recon.." Читы во фракции")
			jail_punish.v = false
		end
		if imgui.Button(u8"\t\t\t Помеха капту", imgui.ImVec2(192,40)) then --
			sampSendChat("/jail " ..id_recon.." 7 Помеха капту")
			jail_punish.v = false
		end
		if imgui.Button(u8"\t\t Уход от ареста(RP)", imgui.ImVec2(192,40)) then --
			sampSendChat("/jail " ..id_recon.." 10 Уход от РП")
			jail_punish.v = false
		end
		imgui.End()
	end
	if mute_punish.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(200, 400), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'MUTE', mute_punish, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		if imgui.Button(u8"\t\t\t\t\t  MG", imgui.ImVec2(192,40)) then -- 5 minute
			sampSendChat("/mute " ..id_recon.." 5 Мг")
			mute_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\tFlood", imgui.ImVec2(192,40)) then -- 10 minute
			sampSendChat("/mute " ..id_recon.." 10 Флуд")
			mute_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\tНеадекват", imgui.ImVec2(192,40)) then
			sampSetChatInputEnabled(true)
			lua_thread.create(function()wait(50)end)
			sampSetChatInputText('/mute '..id_recon..' 15/30 Неадекватное поведение')
			sampAddChatMessage("{00FF00}[Admin-Tools]{FFFFFF} Мера наказания выдаётся относительно тяжести нарушения(15-30 минут)",-1)
			mute_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t Транслит", imgui.ImVec2(192,40)) then -- 7 minute
			sampSendChat("/mute " ..id_recon.." 7 Транслит")
			mute_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\t Капс", imgui.ImVec2(192,40)) then -- 5 minute
			sampSendChat("/mute " ..id_recon.." 5 Капс")
			mute_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\t /vad", imgui.ImVec2(192,40)) then -- 10 minute
			sampSendChat("/mute " ..id_recon.." 10 /vad")
			mute_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\t /gov", imgui.ImVec2(192,40)) then -- 10 minute
			sampSendChat("/mute " ..id_recon.." 10 /gov")
			mute_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\tМаты", imgui.ImVec2(192,40)) then -- 5-10 minute
			sampSetChatInputEnabled(true)
			lua_thread.create(function()wait(50)end)
			sampSetChatInputText('/mute '..id_recon..' 5/10 Нец.Лексика')
			sampAddChatMessage("{00FF00}[Admin-Tools]{FFFFFF} Мера наказания выдаётся относительно тяжести нарушения(5-10 минут)",-1)
			mute_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\t О.И", imgui.ImVec2(192,40)) then -- 15 минут
			sampSendChat("/mute " ..id_recon.." 15 О.И")
			mute_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\t О.А", imgui.ImVec2(192,40)) then -- 20 минут
			sampSendChat("/mute " ..id_recon.." 20 О.А")
			mute_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\t О.Р", imgui.ImVec2(192,40)) then -- 60 минут
			sampSendChat("/mute " ..id_recon.." 60 О.Р")
			mute_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\t У.Р", imgui.ImVec2(192,40)) then -- 30-60 минут
			sampSetChatInputEnabled(true)
			lua_thread.create(function()wait(50)end)
			sampSetChatInputText('/mute '..id_recon..' 30/60 У.Р')
			sampAddChatMessage("{00FF00}[Admin-Tools]{FFFFFF} Мера наказания выдаётся относительно тяжести нарушения(30-60 минут)",-1)
			mute_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t Реклама", imgui.ImVec2(192,40)) then -- 60 минут
			sampSendChat("/mute " ..id_recon.." 60 Реклама")
			mute_punish.v = false
		end
		imgui.End()
	end
	if ban_punish.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(200, 400), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'BAN', ban_punish, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		if imgui.Button(u8"\t\t\t\t\tВред", imgui.ImVec2(192,40)) then 
			sampSendChat("/iban " ..id_recon.." Вред")
			ban_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\tЧиты в дмг", imgui.ImVec2(192,40)) then 
			sampSendChat("/ban " ..id_recon.." 2 Читы в ДМГ")
			ban_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t\tСлив", imgui.ImVec2(192,40)) then 
			sampSendChat("/iban " ..id_recon.." Слив")
			ban_punish.v = false
		end
		if imgui.Button(u8"\t\t\t   Обход дмг", imgui.ImVec2(192,40)) then 
			sampSendChat("/ban " ..id_recon.." 5 Обход ДМГ")
			ban_punish.v = false
		end
		imgui.End()
	end
	if kick_punish.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(200, 400), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'KICK', kick_punish, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		if imgui.Button(u8"\t\t\t\t  Помеха", imgui.ImVec2(192,40)) then 
			sampSendChat("/kick " ..id_recon.." Помеха")
			kick_punish.v = false
		end
		if imgui.Button(u8"\t\t\t    Тихий кик", imgui.ImVec2(192,40)) then 
			sampSendChat("/skick " ..id_recon.." 1")
			kick_punish.v = false
		end
		imgui.End()
	end
	if warn_punish.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(200, 400), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'WARN', warn_punish, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		if imgui.Button(u8"\t\t\t   Коп в гетто", imgui.ImVec2(192,40)) then 
			sampSendChat("/warn " ..id_recon.." Коп в гетто")
			warn_punish.v = false
		end
		if imgui.Button(u8"\t\t\t\t  Багоюз", imgui.ImVec2(192,40)) then 
			sampSendChat("/warn " ..id_recon.." Багоюз")
			warn_punish.v = false
		end
		if imgui.Button(u8"\t\t\t Помеха капту", imgui.ImVec2(192,40)) then 
			sampSendChat("/warn " ..id_recon.." Помеха капту")
			warn_punish.v = false
		end
		imgui.End()
	end
	if punish_menu.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(150, 224), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 1.1), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'Быстрая выдача наказаний', nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar)
		if imgui.Button(u8"\t\t\t    JAIL",imgui.ImVec2(149, 40)) then
			jail_punish.v = true 
		end
		if imgui.Button(u8"\t\t\t   MUTE",imgui.ImVec2(149, 40)) then
			mute_punish.v = true
		end
		if imgui.Button(u8"\t\t\t    KICK",imgui.ImVec2(149, 40)) then
			kick_punish.v = true
		end
		if imgui.Button(u8"\t\t\t    BAN",imgui.ImVec2(149, 40)) then
			ban_punish.v = true
		end
		if imgui.Button(u8"\t\t\t   WARN",imgui.ImVec2(149, 40)) then
			warn_punish.v = true
		end
		imgui.End()
	end
	if aspawncars.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(400, 105), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'Спавн транспорта', nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		imgui.PushItemWidth(25)
		imgui.InputText(u8"Через сколько секунд произойдет респавн?", time_to_aspawncars)
		imgui.PushItemWidth(100)
		imgui.Combo("##choosemsgs_aspawncars", choosemsgs_aspawncars, msgsToAll, #msgsToAll)
		imgui.Separator()
		imgui.SetCursorPosX((imgui.GetWindowWidth() - 225));
		if imgui.Button(u8"Начать") then
			forrun_aspawncars:run()
		end
		imgui.End()
	end
	if capt_menu.v then
		mainIni.config.spec_capt = spec_capt.v
		mainIni.config.mentionSk = mention_sk.v
		mainIni.config.skAfter = skAfter.v 
		mainIni.config.vneKv = mention_vneKv.v 
		mainIni.config.vneKvAfter = vneKvAfter.v
		mainIni.config.choosemsgs = choosemsgs.v
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(400, 200), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'Капт Меню', nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		imgui.Text(u8'Враждующие банды ')
		imgui.SameLine()
		imgui.PushItemWidth(100)
		imgui.Combo('##1st_gang', first_gang, gangs, #gangs)
		imgui.SameLine()
		imgui.Text(u8' и ')
		imgui.SameLine()
		imgui.PushItemWidth(100)
		imgui.Combo('##2nd_gang', second_gang, gangs, #gangs)
		imgui.Separator()
		imgui.Checkbox(u8"Предупредить об слежки за каптом",spec_capt)
		if mainIni.config.spec_capt then
			imgui.PushItemWidth(50)
			imgui.Combo('##choosemsgs', choosemsgs, msgsToAll, #msgsToAll)
		end
		imgui.Checkbox(u8"Напомнить об разрешении SK", mention_sk)
		if mainIni.config.mentionSk then
			imgui.InputText(u8"После какой минуты?", skAfter)
		end
		imgui.Checkbox(u8"Напомнить об разрешение слива вне кв", mention_vneKv)
		if mainIni.config.vneKv then
			imgui.InputText(u8"После какой минуты?", vneKvAfter)
		end
		imgui.Separator()
		imgui.SetCursorPosX((imgui.GetWindowWidth() - 250));
		if imgui.Button(u8"Начать слежку")then
			spec_at_the_capture = true 
			if mainIni.config.spec_capt then
				if choosemsgs.v == 0 then -- /aad
					sampSendChat("/aad Capture || Начал слежку за каптом между "..gangs[first_gang.v + 1].." и "..gangs[second_gang.v + 1])
				elseif choosemsgs.v == 1 then -- /o 
					sampSendChat("/o Capture || Начал слежку за каптом между "..gangs[first_gang.v + 1].." и "..gangs[second_gang.v + 1])
				end
			end
		end
		imgui.End()
	end	
	if templeader_menu.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(200, 600), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 1.5), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'Временный пост лидера', templeader_menu.v, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoMove) --+ imgui.WindowFlags.NoTitleBar)
		imgui.Checkbox(u8"Оставлять свой скин", keep_skin)
		imgui.CenterTextColoredRGB("Банды")
		if imgui.Button(u8"• Ballas", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 12")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• Vagos", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 13")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• Aztec", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 17")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• Rifa", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 18")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• Grove", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 15")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		imgui.CenterTextColoredRGB("Мафии")
		if imgui.Button(u8"• Russian Mafia", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 14")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• LCN", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 5")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• Yakuza", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 6")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• Hitmans", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 23")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• Street Racers", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 24")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• Казино Четыре Дракона", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 27")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• Казино Калигула", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 28")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		imgui.CenterTextColoredRGB("Гос.Организации")
		if imgui.Button(u8"• Мэрия", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 7")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• SFPD", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 10")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• Инструкторы", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 11")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• LSPD", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 1")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• FBI", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 2")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• Армия Авианосец(SFA)", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 3")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• МЧС", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 4")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• SA News", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 16")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• Армия Зона 51(LVA)", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 19")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• LVPD", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 21")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• SWAT", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 25")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		if imgui.Button(u8"• Правительство", imgui.ImVec2(192, 30)) then
			sampSendChat("/templeader 26")
			if keep_skin.v then
				skin = getCharModel(PLAYER_PED)
				lua_thread.create(function()
					wait(1000)
					sampSendChat("/skin "..skin)
				end)
			end
			templeader_menu.v = not templeader_menu.v
		end
		imgui.End()
	end
	if window_recon.v then
		local sw, sh = getScreenResolution()
		sampTextdrawDelete(2153)
		sampTextdrawDelete(2152)
		imgui.SetNextWindowSize(imgui.ImVec2(470, 55), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 1.1), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin('Recon', window_recon, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar)
		if imgui.Button(u8"Слапнуть") then
			sampSendChat('/slap ' .. id_recon)
		end
		imgui.SameLine()
		if imgui.Button(u8"Статистика") then
			sampSendChat('/getstats ' .. id_recon)
		end
		imgui.SameLine()
		if imgui.Button(u8"Заспавнить") then
			sampSendChat('/sp ' .. id_recon)
		end
		imgui.SameLine()
		if imgui.Button(u8"Тп к себе") then
			sampSendChat('/gethere ' .. id_recon)
		end
		imgui.SameLine()
		if imgui.Button(u8"/iwep") then
			sampSendChat('/iwep ' .. id_recon)
		end
		imgui.SameLine()
		if imgui.Button(u8"Тп к игроку") then
			lua_thread.create(function()
			sampSendChat('/re off')
			window_recon.v = false
			imgui.Process = window_recon.v
			wait(1000)
			sampSendChat('/goto ' .. id_recon)
			end)
		end
		imgui.SameLine()
		if imgui.Button(u8"Вы тут?") then
			sampSendChat('/pm ' .. id_recon .. ' Вы тут? Ответ в чат, либо /b')
		end
		imgui.SetCursorPosX((imgui.GetWindowWidth() - 405));
		if imgui.Button(u8"Зафризить") then
			sampSendChat('/freeze ' .. id_recon)
		end
		imgui.SameLine()
		imgui.SetCursorPosX((imgui.GetWindowWidth() - 330));
		if imgui.Button(u8"Разфризить") then
			sampSendChat('/unfreeze ' .. id_recon)
		end
		imgui.SameLine()
		imgui.SetCursorPosX((imgui.GetWindowWidth() - 249));
		if imgui.Button(u8"Написать в /pm") then
			sampSetChatInputEnabled(true)
			lua_thread.create(function()wait(50)end)
			sampSetChatInputText('/pm '..id_recon..' ')
		end
		imgui.SameLine()
		imgui.SetCursorPosX((imgui.GetWindowWidth() - 148));
		if imgui.Button(u8"/sethp") then
			sampSetChatInputEnabled(true)
			lua_thread.create(function()wait(50)end)
			sampSetChatInputText('/sethp '..id_recon..' ')
		--	sampSendChat('/sethp ' .. id_recon .. " 100")
		end
		imgui.SameLine()
		imgui.SetCursorPosX((imgui.GetWindowWidth() - 100));
		if imgui.Button(u8"Выйти") then
			window_recon.v = false
			imgui.Process = window_recon.v
			sampSendChat('/re off')
		end
		imgui.End()
	end
	if lvl_menu.v then
		local sw, sh = getScreenResolution()
		imgui.SetNextWindowSize(imgui.ImVec2(1200, 800), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.Begin(u8'Часто задаваемые вопросы', lvl_menu, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		imgui.PushItemWidth(1195)
		imgui.InputText(u8"", finder)
		if finder.v:len() ~= 0 then
			for i = 1, #buttons do
				if string.find(buttons[i], finder.v) then
					if imgui.Button(buttons[i], imgui.ImVec2(1195, 25)) then
						lvl_menu.v = not lvl_menu.v
						report_text_buff.v = text_for_buttons[i]
						finder.v = ""
					end
				end
			end
    	end

		if finder.v == "" then
	    if imgui.Button(buttons[1], imgui.ImVec2(1195, 25)) then
				lvl_menu.v = not lvl_menu.v
				report_text_buff.v = u8"По заявкам в группе VK; Выиграть на МП; Купить через /donaterub"
	    end
	    if imgui.Button(buttons[2], imgui.ImVec2(1195, 25)) then
				lvl_menu.v = not lvl_menu.v
				report_text_buff.v = u8"По заявкам в группе VK; Выиграть на МП; Купить через /donaterub"
	    end
			if imgui.Button(buttons[3], imgui.ImVec2(1195, 25)) then
				lvl_menu.v = not lvl_menu.v
				report_text_buff.v = u8"/buylead"
	    end
			if imgui.Button(buttons[4], imgui.ImVec2(1195, 25)) then
				lvl_menu.v = not lvl_menu.v
				report_text_buff.v = u8"В свободную группу: vk.com/russia_sv"
	    end
			if imgui.Button(buttons[5], imgui.ImVec2(1195, 25)) then
				lvl_menu.v = not lvl_menu.v
				report_text_buff.v = u8"vk.com/grrp04"
	    end
			if imgui.Button(buttons[6], imgui.ImVec2(1195, 25)) then
				lvl_menu.v = not lvl_menu.v
				report_text_buff.v = u8"vk.com/mrrp04"
	    end
			if imgui.Button(buttons[7], imgui.ImVec2(1195, 25)) then
				lvl_menu.v = not lvl_menu.v
				report_text_buff.v = u8"vk.com/gosrrp04"
	    end
			if imgui.Button(buttons[8], imgui.ImVec2(1195, 25)) then
				lvl_menu.v = not lvl_menu.v
				report_text_buff.v = u8"Обратитесь к Лидеру/Заместителю / На метке в мэрии / /leave"
	    end
		end
		imgui.End()
	end
	if ot_window.v then
			local sw, sh = getScreenResolution()
			imgui.SetNextWindowSize(imgui.ImVec2(400, 200), imgui.Cond.FirstUseEver)
			imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.Begin(u8'Жалоба/Вопрос', nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
			imgui.Text(u8'Жалоба от: '..nickReport.."["..idReport.."]")
			imgui.Separator()
			imgui.Text(u8(reportText))
			imgui.Separator()
			imgui.PushItemWidth(399)
			imgui.InputText(u8"", report_text_buff)
			imgui.Separator()
			if imgui.Button(u8"Слежу за наруш", imgui.ImVec2(125, 0)) then
				sampSendChat("/pm "..idReport.." Уважаемый игрок, начал слежку за нарушителем!")
				lua_thread.create(function()
					wait(1000)
				local idInReport = reportText:match('(%d+)')

				sampSendChat('/re ' .. idInReport)
				window_recon.v = true
				imgui.Process = window_recon.v
				sampAddChatMessage('{FF0000}[Admin-Tools]{FFFFFF} Чтобы показать%/скрыть курсор нажмите на M', -1)
				if amenu_window or window_recon or lvl_menu or veh_create then
					ot_window.v = not ot_window.v
					findReport = false
					reportActive = false
					report_text_buff.v = ""
				else
					ot_window.v = not ot_window.v
					imgui.Process = ot_window.v
					findReport = false
					reportActive = false
					report_text_buff.v = ""
				end
				end)
			end
			imgui.SameLine()
			if imgui.Button(u8"Помочь автору", imgui.ImVec2(125, 0)) then
				sampSendChat("/pm "..idReport.." Уважаемый игрок, сейчас попробую Вам помочь.")
				lua_thread.create(function()
					wait(1500)

				sampSendChat('/re ' .. idReport)
				window_recon.v = true
				imgui.Process = window_recon.v
				sampAddChatMessage('{FF0000}[Admin-Tools]{FFFFFF} Чтобы показать%/скрыть курсор нажмите на M', -1)
				if amenu_window or window_recon or lvl_menu or veh_create then
					ot_window.v = not ot_window.v
					findReport = false
					reportActive = false
					report_text_buff.v = ""
				else
					ot_window.v = not ot_window.v
					imgui.Process = ot_window.v
					findReport = false
					reportActive = false
					report_text_buff.v = ""
				end
				end)
			end
			imgui.SameLine()
			if imgui.Button(u8"Переслать в /a чат", imgui.ImVec2(125, 0)) then
				sampSendChat("/a << REPORT >> Жалоба/Вопрос от "..nickReport.."["..idReport.."]: "..reportText)
			end
			if imgui.Button(u8"Помощь по GPS", imgui.ImVec2(125, 0)) then
				sampAddChatMessage("{FF6347}Временно не работает!", -1)
			end
			imgui.SameLine()
			if imgui.Button(u8"Приятной игры", imgui.ImVec2(125, 0)) then
				sampSendChat("/pm "..idReport.." Приятной игры на Russia RP Ekaterinburg")
				if amenu_window or window_recon or lvl_menu or veh_create then
					ot_window.v = not ot_window.v
					findReport = true
					reportActive = false
					report_text_buff.v = ""
				else
					ot_window.v = not ot_window.v
					imgui.Process = ot_window.v
					findReport = true
					reportActive = false
					report_text_buff.v = ""
				end
			end
			imgui.SameLine()
			if imgui.Button(u8"Передать адм реп", imgui.ImVec2(125, 0)) then
				sampSendChat("/a << REPORT >> Жалоба/Вопрос от "..nickReport.."["..idReport.."]: "..reportText)
				lua_thread.create(function()
					wait(1500)
				sampSendChat("/pm "..idReport.." Передал Ваш репорт Администратору.")
				if amenu_window or window_recon or lvl_menu or veh_create then
					ot_window.v = not ot_window.v
					findReport = true
					reportActive = false
					report_text_buff.v = ""
				else
					ot_window.v = not ot_window.v
					imgui.Process = ot_window.v
					findReport = true
					reportActive = false
					report_text_buff.v = ""
				end
				end)
			end
			if imgui.Button(u8"Популярные вопросы", imgui.ImVec2(125, 0)) then
				lvl_menu.v = not lvl_menu.v
			end
			imgui.SameLine()
			imgui.SetCursorPosX((imgui.GetWindowWidth() - 137));
			if imgui.Button(u8"Жалобу в СГ", imgui.ImVec2(125, 0)) then
				sampSendChat("/pm "..idReport.." Hапишите жалобу в свободную группу vk.com/russia_sv")
				if amenu_window or window_recon or lvl_menu or veh_create then
					ot_window.v = not ot_window.v
					findReport = true
					reportActive = false
					report_text_buff.v = ""
				else
					ot_window.v = not ot_window.v
					imgui.Process = ot_window.v
					findReport = true
					reportActive = false
					report_text_buff.v = ""
				end
			end
			if imgui.Button(u8"Отменить", imgui.ImVec2(125, 0)) then
				if amenu_window or window_recon or lvl_menu or veh_create then
					ot_window.v = not ot_window.v
					findReport = false
					reportActive = false
					report_text_buff.v = ""
				else
					ot_window.v = not ot_window.v
					imgui.Process = ot_window.v
					findReport = false
					rreportActive = false
					report_text_buff.v = ""
				end
			end
			imgui.SameLine()
			imgui.SetCursorPosX((imgui.GetWindowWidth() - 137));
			if imgui.Button(u8"Отправить", imgui.ImVec2(125, 0)) then
				sampSendChat("/pm "..idReport.." "..u8:decode(report_text_buff.v))
				if amenu_window or window_recon or lvl_menu or veh_create then
					ot_window.v = not ot_window.v
					findReport = true
					reportActive = false
					report_text_buff.v = ""
				else
					ot_window.v = not ot_window.v
					imgui.Process = ot_window.v
					findReport = true
					reportActive = false
					report_text_buff.v = ""
				end
			end
			imgui.End()
	end
	if amenu_window.v then
		amenu_window_function()
	end
end

function amenu_window_function()
	-- ban, warn, banip, mute, jail, kick, skick, aad, o, freeze, unfreeze, rmute, givegun, sethp, uval, setskin
	toggle_auto_write_adm_password.v = mainIni.config.auto_login_adm_pass
	toggle_gg_lovlya.v = mainIni.config.lovlya_gg
	mainIni.config.auto_login_adm_pass = toggle_auto_write_adm_password.v
	toggle_spawn_az.v = mainIni.config.spawn_az
	toggle_agm.v = mainIni.config.agm_status
	toggle_pass.v = mainIni.config.pass_status
	log_connect.v = mainIni.config.log_connect_status
	zapros_box.v = mainIni.config.zapros_box_status
	toggle_wh.v = mainIni.config.wh_status
	toggle_trac.v = mainIni.config.trac_status
	mainIni.config.getban = getBan.v
	mainIni.config.getwarn = getWarn.v
	mainIni.config.getbanip = getBanip.v
	mainIni.config.getmute = getMute.v
	mainIni.config.getjail = getJail.v
	mainIni.config.getkick = getKick.v
	mainIni.config.getskick = getSkick.v
	mainIni.config.getaad = getAad.v
	mainIni.config.geto = getO.v
	mainIni.config.getfreeze = getFreeze.v
	mainIni.config.getunfreeze = getUnfreeze.v
	mainIni.config.getrmute = getRmute.v
	mainIni.config.getgivegun = getGivegun.v
	mainIni.config.getsethp = getSethp.v
	mainIni.config.getuval = getUval.v
	mainIni.config.getsetskin = getSetskin.v

	mainIni.config.sendban = sendBan.v
	mainIni.config.sendwarn = sendWarn.v
	mainIni.config.sendbanip = sendBanip.v
	mainIni.config.sendmute = sendMute.v
	mainIni.config.sendjail = sendJail.v
	mainIni.config.sendkick = sendKick.v
	mainIni.config.sendskick = sendSkick.v
	mainIni.config.sendaad = sendAad.v
	mainIni.config.sendo = sendO.v
	mainIni.config.sendfreeze = sendFreeze.v
	mainIni.config.sendunfreeze = sendUnfreeze.v
	mainIni.config.sendrmute = sendRmute.v
	mainIni.config.sendgivegun = sendGivegun.v
	mainIni.config.sendsethp = sendSethp.v
	mainIni.config.senduval = sendUval.v
	mainIni.config.sendsetskin = sendSetskin.v

	mainIni.config.tag = tag.v
	mainIni.config.lvl_admin = lvl_admin.v
	local sw, sh = getScreenResolution()
	imgui.SetNextWindowSize(imgui.ImVec2(800, 600), imgui.Cond.FirstUseEver)
	imgui.SetNextWindowPos(imgui.ImVec2((sw / 2), sh / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
	imgui.Begin(u8"Admin-Menu", nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
	imgui.BeginChild("navigator", imgui.ImVec2(150, 570), true)
	if imgui.Button('   ' .. fa.ICON_POWER_OFF, imgui.ImVec2(44,25)) then
		amenu_window.v = not amenu_window.v
		imgui.Process = amenu_window.v
		lua_thread.create(function()
			wait(1000)
			thisScript():unload()
		end)
	end
	imgui.SameLine()
	if imgui.Button('   ' .. fa.ICON_REFRESH, imgui.ImVec2(44,25)) then
		reloadScripts()
	end
	imgui.SameLine()
	if imgui.Button('   ' .. fa.ICON_VK, imgui.ImVec2(44,25)) then
		os.execute('explorer "https://vk.com/tamerlankar"')
	end
	imgui.Separator()
	if imgui.Button('\t\t' .. fa.ICON_COG .. u8" Основное", imgui.ImVec2(142, 40)) then
		amenu = 1
	end
	if imgui.Button("\t\t  " .. fa.ICON_CUBES .. u8" Читы", imgui.ImVec2(142, 40)) then
		amenu = 2
	end
	if imgui.Button("\t  " .. fa.ICON_RSS .. u8" Админ-формы", imgui.ImVec2(142, 40)) then
		amenu = 3
	end
	if imgui.Button("\t\t  " .. fa.ICON_TINT .. u8" Цвета", imgui.ImVec2(142, 40)) then
		amenu = 4
	end
	imgui.Separator(10)
	imgui.EndChild()
	imgui.SameLine()
	imgui.BeginChild("menu1", imgui.ImVec2(635, 570), true)
	if amenu == 1 then
		if imgui.ToggleButton(u8"Пароль от Аккаунта ", toggle_pass)then
			pass_status = toggle_pass.v
			mainIni.config.pass_status = toggle_pass.v
			if inicfg.save(mainIni, directIni)then
					sampAddChatMessage("",-1)
			end
		end
		imgui.SameLine()
		imgui.Text(u8"Пароль от Аккаунта")
		imgui.SameLine()
		imgui.TextDisabled(u8"(?)")
		if imgui.IsItemHovered() then
			imgui.BeginTooltip();
			imgui.TextUnformatted(u8"Автоматически вводит пароль от Вашего Аккаунта\nВводить по желанию, пароли никуда не уходят");
			imgui.EndTooltip();
		end
		if toggle_pass.v then
			imgui.PushItemWidth(100)
			if mainIni.config.hide_pass then
				imgui.InputText(u8"##1", pass, imgui.InputTextFlags.Password)
			else
				imgui.InputText(u8"##1", pass)
			end
			imgui.PopItemWidth()
			imgui.SameLine()
			if mainIni.config.hide_pass then
				if imgui.Button(u8"Скрывать пароль##1") then
					mainIni.config.hide_pass = false
				end
			elseif not mainIni.config.hide_pass then
				if imgui.Button(u8"Отображать пароль##1") then
					mainIni.config.hide_pass = true
				end
			end
			if imgui.Button(u8"Указать##1") then
				mainIni.config.pass = u8:decode(pass.v)
				if inicfg.save(mainIni, directIni) then
					notf.addNotification("Пароль от аккаунта сохранен ", 5)
				end
			end
		end
		if imgui.ToggleButton(u8"##toggle_auto_write_adm_password", toggle_auto_write_adm_password) then
			for_autologin_admpass = toggle_auto_write_adm_password.v
			mainIni.config.auto_login_adm_pass = for_autologin_admpass
			if inicfg.save(mainIni, directIni)then
					sampAddChatMessage("",-1)
			end
		end
		imgui.SameLine()
		imgui.Text(u8"Админ-Пароль")
		imgui.SameLine()
		imgui.TextDisabled(u8"(?)")
		if imgui.IsItemHovered() then
			imgui.BeginTooltip();
			imgui.TextUnformatted(u8"Автоматически вводит пароль от Вашей админки\nВводить по желанию, пароли никуда не уходят");
			imgui.EndTooltip();
		end
		if toggle_auto_write_adm_password.v then
			imgui.PushItemWidth(100)
			if mainIni.config.hide_password_adm then
				imgui.InputText(u8"##2", password_adm, imgui.InputTextFlags.Password)
			else
				imgui.InputText(u8"##2", password_adm)
			end
			imgui.PopItemWidth()
			imgui.SameLine()
			if mainIni.config.hide_password_adm then
				if imgui.Button(u8"Скрывать пароль##2") then
					mainIni.config.hide_password_adm = false
				end
			elseif not mainIni.config.hide_password_adm then
				if imgui.Button(u8"Отображать пароль##2") then
					mainIni.config.hide_password_adm = true
				end
			end
			if imgui.Button(u8"Указать##2") then
				mainIni.config.passadm = u8:decode(password_adm.v)
				if inicfg.save(mainIni, directIni) then
					notf.addNotification("Пароль от админки сохранен", 5)
				end
			end
		end
			if imgui.ToggleButton(u8"##toggle_gg_lovlya", toggle_gg_lovlya) then
			lovlya_gg = toggle_gg_lovlya.v
			mainIni.config.lovlya_gg = lovlya_gg
			if inicfg.save(mainIni, directIni) then
				if toggle_gg_lovlya.v then
					notf.addNotification("Ловля команды включена", 5)
				else
					notf.addNotification("Ловля команды выключена", 5)
				end
			end
		end
		imgui.SameLine()
		imgui.Text(u8"Включить ловлю /gg")
		if imgui.ToggleButton("##toggle_spawn_az", toggle_spawn_az) then
			spawn_az = toggle_spawn_az.v
			mainIni.config.spawn_az = spawn_az
			if inicfg.save(mainIni, directIni) then
				if toggle_spawn_az.v then
					notf.addNotification("Автоматический спавн в AZ включен", 5)
				else
					notf.addNotification("Автоматический спавн в AZ выключен", 5)
				end
			end
		end
		imgui.SameLine()
		imgui.Text(u8"Спавн в AZ при заходе")
		if imgui.ToggleButton("##toggle_agm", toggle_agm) then
			agm_status = toggle_agm.v
			mainIni.config.agm_status = agm_status
			if inicfg.save(mainIni, directIni) then
				if toggle_agm.v then
					notf.addNotification("Ввод /agm при заходе включен!", 5)
				else
					notf.addNotification("Ввод /agm при заходе выключен!", 5)
				end
			end
		end
		imgui.SameLine()
		imgui.Text(u8"/agm при заходе")
		imgui.Checkbox(u8"Автоматическое выключение лога подключения игроков", log_connect)
		mainIni.config.log_connect_status = log_connect.v
		inicfg.save(mainIni, directIni)
		imgui.PushItemWidth(90)
		imgui.InputText(u8"Тег",tag)
		imgui.SameLine()
		imgui.TextDisabled(u8"(?)")
		if imgui.IsItemHovered() then
			imgui.BeginTooltip();
			imgui.TextUnformatted(u8"Тег для форм в админ чат, пример:\n/a /kick id reason // A.Butler - Ваш тег\n\n*Вводить обязательно");
			imgui.EndTooltip();
		end
		imgui.PushItemWidth(20)
		imgui.InputText(u8"Уровень админ прав", lvl_admin)
	elseif amenu == 2 then
		if imgui.ToggleButton("##toggle_wh", toggle_wh) then
			wh_status = toggle_wh.v
			mainIni.config.wh_status = wh_status
			if inicfg.save(mainIni, directIni) then
				if toggle_wh.v then
					notf.addNotification("ВХ включено!", 5)
					nameTagOn()
				else
					notf.addNotification("ВХ выключено!", 5)
					nameTagOff()
				end
			end
		end
		imgui.SameLine()
		imgui.Text(u8"WallHack")
		if imgui.ToggleButton("##toggle_trac", toggle_trac) then
			traicers = toggle_trac.v
			mainIni.config.trac_status = traicers
			if inicfg.save(mainIni, directIni) then
				if toggle_trac.v then
					notf.addNotification("Трейсера Пуль включены!", 5)
					traicers = true
				else
					notf.addNotification("Трейсера Пуль выключены!", 5)
					traicers = false
				end
			end
		end
		imgui.SameLine()
		imgui.Text(u8"Трейсера Пуль")
	elseif amenu == 3 then
		imgui.Checkbox(u8"Принимать формы из Адм. чата", zapros_box)
		mainIni.config.zapros_box_status = zapros_box.v
		inicfg.save(mainIni, directIni)
		imgui.SameLine()
		imgui.TextDisabled(u8"(?)")
		if imgui.IsItemHovered() then
			imgui.BeginTooltip();
			imgui.TextUnformatted(u8"Если Администратор отправит в Админ Чат запрос на выдачу наказания, пример:\n/a /jail 228 10 DM, то при нажатии на клавишу G. Вы примите его форму");
			imgui.EndTooltip();
		end
		imgui.Button(u8"Автоматически по уровню")
		imgui.Separator()
		imgui.Columns(3, "Формы", false)
		imgui.Text(u8"Команда")
		imgui.NextColumn()
		imgui.Text(u8"Принятие")
		imgui.NextColumn()
		imgui.Text(u8"Отправка")
		imgui.NextColumn()
		imgui.Text("")
		imgui.NextColumn()
		imgui.Text("")
		imgui.NextColumn()
		imgui.Text("")
		imgui.NextColumn()
		imgui.Text("/ban")
		imgui.NextColumn()
		imgui.Checkbox("##zgBan", getBan)
		imgui.NextColumn()
		imgui.Checkbox("##zsBan", sendBan)
		imgui.NextColumn()
		imgui.Text("/warn")
		imgui.NextColumn()
		imgui.Checkbox("##zgWarn", getWarn)
		imgui.NextColumn()
		imgui.Checkbox("##zsWarn", sendWarn)
		imgui.NextColumn()
		imgui.Text("/banip")
		imgui.NextColumn()
		imgui.Checkbox("##zgBanip", getBanip)
		imgui.NextColumn()
		imgui.Checkbox("##zsBanip", sendBanip)
		imgui.NextColumn()
		imgui.Text("/mute")
		imgui.NextColumn()
		imgui.Checkbox("##zgMute", getMute)
		imgui.NextColumn()
		imgui.Checkbox("##zsMute", sendMute)
		imgui.NextColumn()
		imgui.Text("/jail")
		imgui.NextColumn()
		imgui.Checkbox("##zgJail", getJail)
		imgui.NextColumn()
		imgui.Checkbox("##zsJail", sendJail)
		imgui.NextColumn()
		imgui.Text("/kick")
		imgui.NextColumn()
		imgui.Checkbox("##zgKick", getKick)
		imgui.NextColumn()
		imgui.Checkbox("##zsKick", sendKick)
		imgui.NextColumn()
		imgui.Text("/skick")
		imgui.NextColumn()
		imgui.Checkbox("##zgSkick", getSkick)
		imgui.NextColumn()
		imgui.Checkbox("##zsSkick", sendSkick)
		imgui.NextColumn()
		imgui.Text("/aad")
		imgui.NextColumn()
		imgui.Checkbox("##zgAad", getAad)
		imgui.NextColumn()
		imgui.Checkbox("##zsAad", sendAad)
		imgui.NextColumn()
		imgui.Text("/o")
		imgui.NextColumn()
		imgui.Checkbox("##zgO", getO)
		imgui.NextColumn()
		imgui.Checkbox("##zsO", sendO)
		imgui.NextColumn()
		imgui.Text("/freeze")
		imgui.NextColumn()
		imgui.Checkbox("##zgFreeze", getFreeze)
		imgui.NextColumn()
		imgui.Checkbox("##zsFreeze", sendFreeze)
		imgui.NextColumn()
		imgui.Text("/unfreeze")
		imgui.NextColumn()
		imgui.Checkbox("##zgUnfreeze", getUnfreeze)
		imgui.NextColumn()
		imgui.Checkbox("##zsUnfreeze", sendUnfreeze)
		imgui.NextColumn()
		imgui.Text("/rmute")
		imgui.NextColumn()
		imgui.Checkbox("##zgRmute", getRmute)
		imgui.NextColumn()
		imgui.Checkbox("##zsRmute", sendRmute)
		imgui.NextColumn()
		imgui.Text("/givegun")
		imgui.NextColumn()
		imgui.Checkbox("##zgGivegun", getGivegun)
		imgui.NextColumn()
		imgui.Checkbox("##zsGivegun", sendGivegun)
		imgui.NextColumn()
		imgui.Text("/sethp")
		imgui.NextColumn()
		imgui.Checkbox("##zgSethp", getSethp)
		imgui.NextColumn()
		imgui.Checkbox("##zsSethp", sendSethp)
		imgui.NextColumn()
		imgui.Text("/uval")
		imgui.NextColumn()
		imgui.Checkbox("##zgUval", getUval)
		imgui.NextColumn()
		imgui.Checkbox("##zsUval", sendUval)
		imgui.NextColumn()
		imgui.Text("/setskin")
		imgui.NextColumn()
		imgui.Checkbox("##zgSetskin", getSetskin)
		imgui.NextColumn()
		imgui.Checkbox("##zsSetskin", sendSetskin)
		-- ban, warn, banip, mute, jail, kick, skick, aad, o, freeze, unfreeze, rmute, givegun, sethp, uval, setskin
	elseif amenu == 4 then
		for i, value in ipairs(themes.colorThemes) do
			if imgui.RadioButton(value, changer_imgui_themes, i) then
				themes.SwitchColorTheme(i)
				mainIni.config.theme = i
				inicfg.save(mainIni, directIni)
			end
		end
	end
	imgui.EndChild()
	imgui.End()
end

function hook.onServerMessage(color, text)
	local reasons = {"kick", "mute", "jail", "jail", "sethp", "sban", "banoff", "mute", "offban", "sp", "slap", "unjail", "uval", "spcar", "ban", "o", "warn", "skick", "setskin", "aad", "unban", "unwarn", "setskin", "skick", "banip", "offban", "offwarn", "sban", "ptp", "o", "aad", "givegun", "avig", "aunvig", "givedonate", "spawncars",
	"mpwin", "prefix", "asellhouse", "delacc", "asellbiz", "money", "test", 'iban'}

	for k,v in ipairs(reasons) do
		if text:match("%[.*%] (.+_.+)%[(%d+)%]%: /"..v.."%s") then -- 1
			admin_id, cmd_zapros = text:match("%[.*%] (.+_.+)%[(%d+)%]%: /"..v.."%s(.*)")
			for i = 1, #arr_cmd do
				if v == arr_cmd[i] then
					if arr_getmainIni[i] == true then
						if mainIni.config.zapros_box_status then -- 2
							started = started + 1
								if started < 2 then
									prikoll = "true"
									admin_nick, admin_id, other = text:match("%[.*%] (.+_.+)%[(%d+)%]%: /"..v.."%s(.*)")
									cmd = v
									paramssss = other
									if admin_nick == nick then
										return false
									end
									if stop == 0 then
										lua_thread.create(function()
											for i = 0, 5 do
												if active_report2 == 0 then
													status("false", i)
												else
													status("true", i)
												end
											end
											if prikoll == "true" then
												wait(550)
												printStyledString("You missed form", 1000, 5)
												active_report = 1
												active_report2 = 0
												started = 0
												bbstart = -1
											end
										end)
								end
							end
						end
					end
				end
			end
		end -- 1
	end
	if string.find(text, 'Жалоба от .+%[%d+%]: {FFCD00}.+')then
		lua_thread.create(function()
		wait(500) end)
		nickReport, idReport, reportText = string.match(text, 'Жалоба от (.+)%[(%d+)%]: {FFCD00}(.+)')
			if reportText == "04" or reportText == "04top" or reportText == "04love" or reportText == "ekaterinburg" or reportText == "04TOP" or reportText == "04LOVE" or reportText == "EKATERINBURG" then
				lua_thread.create(function()wait(500) end)
				sampSendChat('/pm ' .. idReport .. ' Желаю Вам приятной игры!')
			elseif findReport then
				if not reportActive then
					ot_window.v = true
					imgui.Process = true
					reportActive = true
				end
			elseif not findReport or reportActive then
				notf.addNotification("Обнаружен новый репорт от "..nickReport.."["..idReport.."]", 5)
			end
		end
	if text:match('Администрация в сети%:') then
		status = true
		if text:find('.+%[%d+%]%(%d+ .+%)') then
			local nick, id, rankint, rank = text:match('(.+)%[(%d+)%]%((%d+) (.+)%)')
			table.insert(tmembers, tplayer:new(nick, id, rankint, rank))
		end
	end
	if string.find(text, "{AFAFAF}Инструкция по строчкам внизу:") or string.find(text, "{AFAFAF}Строка {FFFF00}'A'{AFAFAF} — возможные читеры с AirBrake/Fly") or string.find(text, "{AFAFAF}Строка {B22222}'S'{AFAFAF} — возможные читеры с SpeedHack/DGun") then
		if mainIni.config.spawn_az then
			lua_thread.create(function()
			sampSendChat("/tp")
			wait(100)
			EmulateKey(VK_RETURN, true)
			wait(50)
			EmulateKey(VK_RETURN, false)
			wait(500)
			end)
		end
		if mainIni.config.agm_status then
			lua_thread.create(function()
			sampSendChat("/hp")
			wait(1000)
			sampSendChat("/agm")
			wait(1000)
			end)
		end
		if log_connect.v then
			sampSendChat("/connect")
		end
	end
	if string.find(text, "БАНКОВСКИЙ ЧЕК.") then
		if mainIni.config.lovlya_gg then
			sampSendChat('/gg')
			lua_thread.create(function()
				wait(1000)
					notf.addNotification("Ловля команды включена, поэтому команда была введена автоматически", 5)
			end)
		end
	end
	if string.find(text, "Игрок не вступил в игру") then
		lua_thread.create(function()
			wait(500)
			window_recon.v = false
			imgui.Process = window_recon.v
			sampSendChat('/re off')
		end)
	end
	if string.find(text, ".+ (.+) спровоцировал(а) захват территории банды .+" ) --[[Eazy_Scrazzy (Vagos Gang) спровоцировал(а) захват территории банды Aztecas Gang.]] then
		captStatus = true
		local timer_capt = 0
		local minute_timer_capt = 0
		sampAddChatMessage("--------------------------------------------------------------------------------------------",-1)
		sampAddChatMessage("{FF0000}[Admin-Tools]{FFFFFF} Начался Капт. Чтобы начать следить за ним, введите \"/capt\"",-1)
		sampAddChatMessage("{FF0000}[Admin-Tools]{FFFFFF} Начался Капт. Чтобы начать следить за ним, введите \"/capt\"",-1)
		sampAddChatMessage("{FF0000}[Admin-Tools]{FFFFFF} Начался Капт. Чтобы начать следить за ним, введите \"/capt\"",-1)
		sampAddChatMessage("{FF0000}[Admin-Tools]{FFFFFF} Начался Капт. Чтобы начать следить за ним, введите \"/capt\"",-1)
		sampAddChatMessage("--------------------------------------------------------------------------------------------",-1)
		sampSendChat("/a [Admin-Tools] Внимание! Начался капт")
		lua_thread.create(function()
		while minute_timer_capt ~= 10 do
			wait(1000)
			timer_capt = timer_capt + 1
			if timer_capt == 60 then
				minute_timer_capt = minute_timer_capt + 1
				timer_capt = 0
				--sampAddChatMessage(minute_timer_capt..":"..timer_capt, -1)
			end
			if minute_timer_capt == mainIni.config.vneKvAfter then
				if spec_at_the_capture then
					if mainIni.config.vneKv then
						if choosemsgs.v == 0 then --/aad
							sampSendChat("/aad Capture || Разрешается убийства вне квадрата.")
						end
						if choosemsgs.v == 1 then --/o
							sampSendChat("/o Capture || Разрешается убийства вне квадрата.")
						end
					end
				end
			end
			if minute_timer_capt == mainIni.config.skAfter then
				if spec_at_the_capture then
					if mainIni.config.mention_sk then
						if choosemsgs.v == 0 then --/aad
							sampSendChat("/aad Capture || Разрешается СК вне инты.")
						end
						if choosemsgs.v == 1 then --/o
							sampSendChat("/o Capture || Разрешается СК вне инты.")
						end
					end
				end
			end		
		end
		spec_at_the_capture = false
		sampSendChat("/a [Admin-Tools] Капт был закончен.")
		end)
	end
	if string.find(text, "Не флуди!") then
		return false
	end
end


function hook.onShowDialog(id, style, title, button1, button2, text)
    if string.match(title, 'Админ авторизация') then
				if mainIni.config.auto_login_adm_pass == true then
					id_auto_loginadm = sampGetCurrentDialogId()
			  	sampSendDialogResponse(id_auto_loginadm, 1, listitem, mainIni.config.passadm)
					lua_thread.create(function()
						wait(100)
						sampCloseCurrentDialogWithButton(1)
					end)
				end
    end
		if string.match(title, 'Авторизация аккаунта') then
			if mainIni.config.pass_status then
				id_login_pass = sampGetCurrentDialogId()
				sampSendDialogResponse(id_login_pass, 1, listitem, mainIni.config.pass)
				lua_thread.create(function()
					wait(100)
					sampCloseCurrentDialogWithButton(1)
				end)
			end
		end
end


function nameTagOn()
	local pStSet = sampGetServerSettingsPtr()
	NTdist = memory.getfloat(pStSet + 39) -- дальность
	NTwalls = memory.getint8(pStSet + 43) -- видимость через стены
	NTshow = memory.getint8(pStSet + 55) -- видимость тегов
	memory.setfloat(pStSet + 39, 1488.0)
	memory.setint8(pStSet + 47, 0)
	memory.setint8(pStSet + 56, 1)
end

function nameTagOff()
	local pStSet = sampGetServerSettingsPtr()
	memory.setfloat(pStSet + 39, NTdist)
	memory.setint8(pStSet + 47, NTwalls)
	memory.setint8(pStSet + 56, NTshow)
end


function calcScreenCoors(fX,fY,fZ)
    local dwM = 0xB6FA2C

    local m_11 = mem.getfloat(dwM + 0*4)
    local m_12 = mem.getfloat(dwM + 1*4)
    local m_13 = mem.getfloat(dwM + 2*4)
    local m_21 = mem.getfloat(dwM + 4*4)
    local m_22 = mem.getfloat(dwM + 5*4)
    local m_23 = mem.getfloat(dwM + 6*4)
    local m_31 = mem.getfloat(dwM + 8*4)
    local m_32 = mem.getfloat(dwM + 9*4)
    local m_33 = mem.getfloat(dwM + 10*4)
    local m_41 = mem.getfloat(dwM + 12*4)
    local m_42 = mem.getfloat(dwM + 13*4)
    local m_43 = mem.getfloat(dwM + 14*4)

    local dwLenX = mem.read(0xC17044, 4)
    local dwLenY = mem.read(0xC17048, 4)

    frX = fZ * m_31 + fY * m_21 + fX * m_11 + m_41
    frY = fZ * m_32 + fY * m_22 + fX * m_12 + m_42
    frZ = fZ * m_33 + fY * m_23 + fX * m_13 + m_43

    fRecip = 1.0/frZ
    frX = frX * (fRecip * dwLenX)
    frY = frY * (fRecip * dwLenY)

    if(frX<=dwLenX and frY<=dwLenY and frZ>1)then
        return frX, frY, frZ
    else
        return -1, -1, -1
    end
end


function hook.onBulletSync(playerid, data)
    if traicers == true  then
        BulletSync.pid = playerid
        if data.target.x == -1 or data.target.y == -1 or data.target.z == -1 then
            return true
                end
                BulletSync.lastId = BulletSync.lastId + 1
                if BulletSync.lastId < 1 or BulletSync.lastId > BulletSync.maxLines then
                    BulletSync.lastId = 1
                end
                local id = BulletSync.lastId
                BulletSync[id].enable = true
                BulletSync[id].tType = data.targetType
                BulletSync[id].time = os.time() + 15
                BulletSync[id].o.x, BulletSync[id].o.y, BulletSync[id].o.z = data.origin.x, data.origin.y, data.origin.z
                BulletSync[id].t.x, BulletSync[id].t.y, BulletSync[id].t.z = data.target.x, data.target.y, data.target.z
            end
        end

function join_argb(a, r, g, b)
  local argb = b  -- b
  argb = bit.bor(argb, bit.lshift(g, 8))  -- g
  argb = bit.bor(argb, bit.lshift(r, 16)) -- r
  argb = bit.bor(argb, bit.lshift(a, 24)) -- a
  return argb
end

function explode_argb(argb)
  local a = bit.band(bit.rshift(argb, 24), 0xFF)
  local r = bit.band(bit.rshift(argb, 16), 0xFF)
  local g = bit.band(bit.rshift(argb, 8), 0xFF)
  local b = bit.band(argb, 0xFF)
  return a, r, g, b
end




function hook.onPlayerDeathNotification(killerId, killedId, reason)
	local kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())
	local _, myid = sampGetPlayerIdByCharHandle(playerPed)

	local n_killer = ( sampIsPlayerConnected(killerId) or killerId == myid ) and sampGetPlayerNickname(killerId) or nil
	local n_killed = ( sampIsPlayerConnected(killedId) or killedId == myid ) and sampGetPlayerNickname(killedId) or nil
	lua_thread.create(function()
		wait(0)
		if n_killer then kill.killEntry[4].szKiller = ffi.new('char[25]', ( n_killer .. '[' .. killerId .. ']' ):sub(1, 24) ) end
		if n_killed then kill.killEntry[4].szVictim = ffi.new('char[25]', ( n_killed .. '[' .. killedId .. ']' ):sub(1, 24) ) end
	end)
end
