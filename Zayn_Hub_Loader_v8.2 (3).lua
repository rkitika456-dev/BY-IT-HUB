-- ZAYN HUB loader v8.2 (daftar script + info pembuat)
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RS = game:GetService("RunService")
local lp = Players.LocalPlayer

local HUB_NAME = "ZAYN-ALL"   -- ganti nama hub di sini
local VERSION = "v8.2"
-- Isi dengan URL webhook Discord supaya laporan bug terkirim otomatis. Kosong = laporan disalin ke clipboard
local BUG_WEBHOOK = ""

-- Daftar script: tambah baris baru untuk script lain
local SCRIPTS = {
	{
		name = "Steal an Egg", by = "foxname",
		url = "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/Fn-stealanegg.lua",
		info = "By foxname",
	},
	{
		name = "Zentaz Hub", infoName = "Zentaz Hub - Distrik Kekerasan", by = "zentaz",
		url = "https://raw.githubusercontent.com/zentazhubnew/ZentazHub/refs/heads/main/ZentazHub.lua.txt",
		key = "ZENTAZNEWERA2026a",
		info = "By zentaz\n\nGame: Distrik Kekerasan\n\nSandi script: ZENTAZNEWERA2026a\n\nScript ini tidak mendapat update lagi.",
	},
	{
		name = "Leenz Hub", infoName = "Leenz Hub - Distrik Kekerasan", by = "Leenz",
		url = "https://raw.githubusercontent.com/leenz66/LeenzTzy/refs/heads/main/loader",
		info = "By Leenz\n\nGame: Distrik Kekerasan\n\nUpdate: bisa tiap minggu atau di waktu tertentu.",
	},
}

local parent = (gethui and gethui()) or (pcall(function() return game.CoreGui.Name end) and game.CoreGui) or lp:WaitForChild("PlayerGui")
pcall(function() parent:FindFirstChild("Zayn_Hub"):Destroy() end)

local ACC = Color3.fromRGB(0, 200, 255)
local BG = Color3.fromRGB(10, 10, 10)
local PANEL = Color3.fromRGB(15, 15, 15)
local LINE = Color3.fromRGB(48, 48, 48)
local SUB = Color3.fromRGB(150, 150, 150)
local WHITE = Color3.new(1, 1, 1)
local SELC = Color3.fromRGB(42, 42, 42)
local F = Enum.Font

local conns = {}
local function bind(sig, fn) local c = sig:Connect(fn) conns[#conns + 1] = c return c end
local function mk(c, p, par)
	local o = Instance.new(c)
	for k, v in pairs(p) do o[k] = v end
	o.Parent = par
	return o
end
local function round(o, r) mk("UICorner", {CornerRadius = UDim.new(0, r or 8)}, o) end
local function isPress(i) return i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch end
local function drag(handle, target)
	local d, start, orig
	bind(handle.InputBegan, function(i)
		if isPress(i) then d, start, orig = true, i.Position, target.Position end
	end)
	bind(UIS.InputChanged, function(i)
		if d and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
			local dl = i.Position - start
			target.Position = UDim2.new(orig.X.Scale, orig.X.Offset + dl.X, orig.Y.Scale, orig.Y.Offset + dl.Y)
		end
	end)
	bind(UIS.InputEnded, function(i) if isPress(i) then d = false end end)
end

local gui = mk("ScreenGui", {Name = "Zayn_Hub", ResetOnSpawn = false}, parent)
local letter = HUB_NAME:sub(1, 1):upper()

-- Tombol bulat untuk buka/tutup panel (bisa digeser)
local logo = mk("TextButton", {Size = UDim2.fromOffset(48, 48), Position = UDim2.new(0, 20, 0.5, -24), BackgroundColor3 = BG,
	Text = letter, TextColor3 = WHITE, Font = F.GothamBlack, TextSize = 22, AutoButtonColor = false}, gui)
round(logo, 24)
mk("UIStroke", {Color = LINE, Thickness = 2}, logo)
drag(logo, logo)

-- Jendela utama
local main = mk("Frame", {Size = UDim2.fromOffset(500, 260), Position = UDim2.new(0.5, -250, 0.5, -130), BackgroundColor3 = BG, Visible = false}, gui)
round(main, 14)
mk("UIStroke", {Color = LINE, Thickness = 2}, main)
bind(logo.MouseButton1Click, function() main.Visible = not main.Visible end)

-- Header: logo Z, nama hub, search, X (keluar)
local header = mk("Frame", {Size = UDim2.new(1, 0, 0, 52), BackgroundTransparency = 1}, main)
drag(header, main)
local hl = mk("TextLabel", {Size = UDim2.fromOffset(40, 40), Position = UDim2.fromOffset(6, 6), BackgroundColor3 = PANEL, Text = letter,
	TextColor3 = WHITE, Font = F.GothamBlack, TextSize = 22}, header)
round(hl, 8)
mk("UIStroke", {Color = LINE, Thickness = 1.5}, hl)
mk("TextLabel", {Size = UDim2.new(1, -300, 0, 22), Position = UDim2.fromOffset(56, 6), BackgroundTransparency = 1, Text = HUB_NAME,
	TextColor3 = WHITE, Font = F.GothamBold, TextSize = 17, TextXAlignment = Enum.TextXAlignment.Left}, header)
local status = mk("TextLabel", {Size = UDim2.new(1, -300, 0, 16), Position = UDim2.fromOffset(56, 28), BackgroundTransparency = 1,
	Text = "Pilih script lalu tekan >", TextColor3 = SUB, Font = F.GothamMedium, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
	TextTruncate = Enum.TextTruncate.AtEnd}, header)
local search = mk("TextBox", {Size = UDim2.fromOffset(150, 30), AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -46, 0, 26),
	BackgroundColor3 = Color3.fromRGB(22, 22, 22), Text = "", PlaceholderText = "Search..", PlaceholderColor3 = SUB, TextColor3 = WHITE,
	Font = F.GothamMedium, TextSize = 13, ClearTextOnFocus = false}, header)
round(search, 15)
mk("UIStroke", {Color = LINE, Thickness = 1.2}, search)
mk("UIPadding", {PaddingLeft = UDim.new(0, 12)}, search)
local xb = mk("TextButton", {Size = UDim2.fromOffset(30, 30), AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0, 26),
	BackgroundTransparency = 1, Text = "X", TextColor3 = WHITE, Font = F.GothamBold, TextSize = 16}, header)
mk("Frame", {Size = UDim2.new(1, 0, 0, 1), Position = UDim2.fromOffset(0, 52), BackgroundColor3 = LINE, BorderSizePixel = 0}, main)

-- Sidebar: ikon Z (info versi) dan profil di bawah
local side = mk("ScrollingFrame", {Size = UDim2.new(0, 52, 1, -53), Position = UDim2.fromOffset(0, 53), BackgroundTransparency = 1,
	BorderSizePixel = 0, ScrollBarThickness = 2, ScrollBarImageColor3 = Color3.fromRGB(110, 110, 110), CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y}, main)
mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8), HorizontalAlignment = Enum.HorizontalAlignment.Center}, side)
mk("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8)}, side)
mk("Frame", {Size = UDim2.new(0, 1, 1, -53), Position = UDim2.fromOffset(52, 53), BackgroundColor3 = LINE, BorderSizePixel = 0}, main)
local zBtn = mk("TextButton", {Size = UDim2.fromOffset(38, 38), LayoutOrder = 1,
	BackgroundColor3 = SELC, Text = letter, TextColor3 = WHITE, Font = F.GothamBlack, TextSize = 18, AutoButtonColor = false}, side)
round(zBtn, 8)
mk("Frame", {Size = UDim2.fromOffset(38, 24), BackgroundTransparency = 1, LayoutOrder = 9}, side)
-- Logo di bawah sidebar (ganti foto profil): tekan untuk membuka informasi 2 bahasa
local infoLogo = mk("TextButton", {Size = UDim2.fromOffset(38, 38), LayoutOrder = 10,
	BackgroundColor3 = SELC, Text = letter, TextColor3 = WHITE, Font = F.GothamBlack, TextSize = 18, AutoButtonColor = false}, side)
round(infoLogo, 19)
mk("UIStroke", {Color = ACC, Thickness = 1.5}, infoLogo)
local badge = mk("TextLabel", {Size = UDim2.fromOffset(14, 14), Position = UDim2.new(1, -9, 0, -3), BackgroundColor3 = ACC, Text = "i",
	TextColor3 = Color3.fromRGB(10, 10, 10), Font = F.GothamBold, TextSize = 10}, infoLogo)
round(badge, 7)

-- Kotak versi (muncul di bawah kiri saat ikon Z ditekan)
local verBox = mk("Frame", {Size = UDim2.fromOffset(230, 106), Position = UDim2.new(0, 0, 1, 8), BackgroundColor3 = BG, Visible = false}, main)
round(verBox, 10)
mk("UIStroke", {Color = LINE, Thickness = 1.5}, verBox)
mk("TextLabel", {Size = UDim2.new(1, -20, 0, 30), Position = UDim2.fromOffset(10, 6), BackgroundTransparency = 1,
	Text = "Anda sedang memakai versi " .. VERSION, TextColor3 = WHITE, Font = F.GothamBold, TextSize = 13, TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left}, verBox)
mk("TextLabel", {Size = UDim2.new(1, -20, 0, 20), Position = UDim2.fromOffset(10, 38), BackgroundTransparency = 1,
	Text = "Update setiap minggu", TextColor3 = ACC, Font = F.GothamMedium, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left}, verBox)
local reportBtn = mk("TextButton", {Size = UDim2.new(1, -20, 0, 28), Position = UDim2.fromOffset(10, 68), BackgroundColor3 = SELC,
	Text = "Report a bug", TextColor3 = WHITE, Font = F.GothamBold, TextSize = 12}, verBox)
round(reportBtn, 14)
mk("UIStroke", {Color = ACC, Thickness = 1}, reportBtn)

-- Kotak informasi 2 bahasa (Indonesia dan English)
local msgBox = mk("Frame", {Size = UDim2.fromOffset(290, 176), Position = UDim2.new(0, 0, 1, 8), BackgroundColor3 = BG, Visible = false}, main)
round(msgBox, 10)
mk("UIStroke", {Color = LINE, Thickness = 1.5}, msgBox)
local function mt(text, y, h, col, font, size)
	return mk("TextLabel", {Size = UDim2.new(1, -24, 0, h), Position = UDim2.fromOffset(12, y), BackgroundTransparency = 1, Text = text,
		TextColor3 = col, Font = font, TextSize = size, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = Enum.TextYAlignment.Top}, msgBox)
end
mt("Informasi / Information  |  V8.2", 8, 18, WHITE, F.GothamBold, 13)
mt("Indonesia", 32, 14, ACC, F.GothamBold, 11)
mt("Maaf kalau ada bug dan lainnya. Saya akan terus memperbagus dan memperbarui yang terbaik. Silakan nikmati.", 46, 46, Color3.fromRGB(215, 215, 215), F.GothamMedium, 12)
mt("English", 98, 14, ACC, F.GothamBold, 11)
mt("Sorry if there are any bugs and other issues. I will keep improving and updating it to be the best. Please enjoy.", 112, 56, Color3.fromRGB(215, 215, 215), F.GothamMedium, 12)

-- Report a bug (dibuka dari kotak versi)
local bugBox = mk("Frame", {Size = UDim2.fromOffset(290, 172), Position = UDim2.new(0, 0, 1, 8), BackgroundColor3 = BG, Visible = false}, main)
round(bugBox, 10)
mk("UIStroke", {Color = LINE, Thickness = 1.5}, bugBox)
mk("TextLabel", {Size = UDim2.new(1, -24, 0, 18), Position = UDim2.fromOffset(12, 8), BackgroundTransparency = 1, Text = "Report a bug",
	TextColor3 = WHITE, Font = F.GothamBold, TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left}, bugBox)
local bugText = mk("TextBox", {Size = UDim2.new(1, -24, 0, 68), Position = UDim2.fromOffset(12, 32), BackgroundColor3 = Color3.fromRGB(22, 22, 22),
	Text = "", PlaceholderText = "Describe the bug...", PlaceholderColor3 = SUB, TextColor3 = WHITE, Font = F.Gotham, TextSize = 12,
	TextWrapped = true, MultiLine = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
	ClearTextOnFocus = false}, bugBox)
round(bugText, 8)
mk("UIPadding", {PaddingLeft = UDim.new(0, 8), PaddingTop = UDim.new(0, 6), PaddingRight = UDim.new(0, 8)}, bugText)
local bugStatus = mk("TextLabel", {Size = UDim2.new(1, -24, 0, 16), Position = UDim2.fromOffset(12, 104), BackgroundTransparency = 1, Text = "",
	TextColor3 = ACC, Font = F.GothamMedium, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left}, bugBox)
local bugSend = mk("TextButton", {Size = UDim2.new(1, -24, 0, 32), Position = UDim2.fromOffset(12, 128), BackgroundColor3 = ACC,
	Text = "Send report", TextColor3 = Color3.fromRGB(10, 10, 10), Font = F.GothamBold, TextSize = 13}, bugBox)
round(bugSend, 16)
bind(bugSend.MouseButton1Click, function()
	local msg = bugText.Text
	if msg:gsub("%s", "") == "" then bugStatus.Text = "Please describe the bug first" return end
	local report = string.format("[%s %s] Bug report\nPlayer: %s (@%s) ID %d\nGame: %d | Server: %s\nMessage: %s",
		HUB_NAME, VERSION, lp.DisplayName, lp.Name, lp.UserId, game.PlaceId, game.JobId, msg)
	local sent = false
	if BUG_WEBHOOK ~= "" then
		local req = (syn and syn.request) or (http and http.request) or http_request or request
		if req then
			sent = pcall(function()
				req({Url = BUG_WEBHOOK, Method = "POST", Headers = {["Content-Type"] = "application/json"},
					Body = HttpService:JSONEncode({content = report})})
			end)
		end
	end
	if sent then
		bugStatus.Text = "Report sent. Thank you!"
		bugText.Text = ""
	else
		pcall(function() setclipboard(report) end)
		bugStatus.Text = "Report copied. Please send it to the developer."
	end
end)

local function hideBoxes() verBox.Visible = false msgBox.Visible = false bugBox.Visible = false end
bind(zBtn.MouseButton1Click, function() local v = not verBox.Visible hideBoxes() verBox.Visible = v end)
bind(infoLogo.MouseButton1Click, function() local v = not msgBox.Visible hideBoxes() msgBox.Visible = v end)
bind(reportBtn.MouseButton1Click, function() hideBoxes() bugBox.Visible = true end)

-- Daftar script (bisa di-scroll)
local list = mk("ScrollingFrame", {Size = UDim2.new(1, -53, 1, -53), Position = UDim2.fromOffset(53, 53), BackgroundTransparency = 1,
	BorderSizePixel = 0, ScrollBarThickness = 5, ScrollBarImageColor3 = Color3.fromRGB(110, 110, 110), CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y}, main)
mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8)}, list)
mk("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 12)}, list)

-- Halaman Fitur (ON/OFF), dibuka dari tombol FX di bawah ikon Z
local featList = mk("ScrollingFrame", {Size = UDim2.new(1, -53, 1, -53), Position = UDim2.fromOffset(53, 53), BackgroundTransparency = 1,
	BorderSizePixel = 0, ScrollBarThickness = 5, ScrollBarImageColor3 = Color3.fromRGB(110, 110, 110), CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y, Visible = false}, main)
mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8)}, featList)
mk("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 12)}, featList)

local function tabBtn(txt, order)
	local b = mk("TextButton", {Size = UDim2.fromOffset(38, 38), LayoutOrder = order,
		BackgroundColor3 = SELC, Text = txt, TextColor3 = SUB, Font = F.GothamBold, TextSize = 12, AutoButtonColor = false}, side)
	round(b, 8)
	return b
end
local scBtn = tabBtn("SC", 2)
local fxBtn = tabBtn("FX", 3)
local function showPage(p)
	list.Visible = p == "sc"
	featList.Visible = p == "fx"
	scBtn.TextColor3 = p == "sc" and WHITE or SUB
	fxBtn.TextColor3 = p == "fx" and WHITE or SUB
	scBtn.BackgroundTransparency = p == "sc" and 0 or 0.6
	fxBtn.BackgroundTransparency = p == "fx" and 0 or 0.6
end
bind(scBtn.MouseButton1Click, function() showPage("sc") end)
bind(fxBtn.MouseButton1Click, function() showPage("fx") end)
showPage("sc")

-- Panel info pembuat (muncul di samping jendela)
local infoP = mk("Frame", {Size = UDim2.fromOffset(250, 210), Position = UDim2.new(1, 8, 0, 52), BackgroundColor3 = BG, Visible = false}, main)
round(infoP, 12)
mk("UIStroke", {Color = LINE, Thickness = 1.5}, infoP)
local infoT = mk("TextLabel", {Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, Text = "", TextColor3 = WHITE, Font = F.GothamBold, TextSize = 13}, infoP)
drag(infoT, infoP)
local infoB = mk("TextLabel", {Size = UDim2.new(1, -24, 1, -82), Position = UDim2.fromOffset(12, 32), BackgroundTransparency = 1, Text = "",
	TextColor3 = Color3.fromRGB(210, 210, 210), Font = F.GothamMedium, TextSize = 13, TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top}, infoP)
local infoRow = mk("Frame", {Size = UDim2.new(1, -24, 0, 32), Position = UDim2.new(0, 12, 1, -42), BackgroundTransparency = 1}, infoP)
mk("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6)}, infoRow)
local function pill(t, w, col, txtCol)
	local b = mk("TextButton", {Size = UDim2.new(w, -3, 1, 0), BackgroundColor3 = col, Text = t, TextColor3 = txtCol or WHITE,
		Font = F.GothamBold, TextSize = 12}, infoRow)
	round(b, 16)
	return b
end
local copyB = pill("Salin Sandi", 0.5, ACC, Color3.fromRGB(10, 10, 10))
local closeB = pill("Tutup", 0.5, SELC)
local infoCur
bind(closeB.MouseButton1Click, function() infoP.Visible = false infoCur = nil end)
bind(copyB.MouseButton1Click, function()
	if infoCur and infoCur.key then
		pcall(function() setclipboard(infoCur.key) end)
		copyB.Text = "Tersalin"
		task.delay(1.2, function() copyB.Text = "Salin Sandi" end)
	end
end)
local function showInfo(s)
	if infoP.Visible and infoCur == s then infoP.Visible = false infoCur = nil return end
	infoCur = s
	infoT.Text = s.infoName or s.name
	infoB.Text = s.info
	copyB.Visible = s.key ~= nil
	closeB.Size = s.key and UDim2.new(0.5, -3, 1, 0) or UDim2.new(1, 0, 1, 0)
	infoP.Visible = true
end

local function setStatus(t) status.Text = t end
local function run(s)
	setStatus("Menjalankan " .. s.name .. "...")
	task.spawn(function()
		local ok, err = pcall(function() loadstring(game:HttpGet(s.url))() end)
		if ok then
			setStatus(s.name .. " berjalan")
		else
			setStatus("Gagal: " .. tostring(err):sub(1, 60))
		end
	end)
end

local rows = {}
for i, s in ipairs(SCRIPTS) do
	local r = mk("Frame", {Size = UDim2.new(1, 0, 0, 54), BackgroundColor3 = PANEL, LayoutOrder = i}, list)
	round(r, 10)
	mk("UIStroke", {Color = LINE, Thickness = 1.2}, r)
	mk("TextLabel", {Size = UDim2.new(1, -110, 0, 24), Position = UDim2.fromOffset(12, 7), BackgroundTransparency = 1, Text = s.name,
		TextColor3 = WHITE, Font = F.GothamBold, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, r)
	mk("TextLabel", {Size = UDim2.new(1, -110, 0, 16), Position = UDim2.fromOffset(12, 30), BackgroundTransparency = 1, Text = "by " .. s.by,
		TextColor3 = SUB, Font = F.GothamMedium, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left}, r)
	local function small(t, x, col, txtCol)
		local b = mk("TextButton", {Size = UDim2.fromOffset(40, 32), Position = UDim2.new(1, x, 0.5, -16), BackgroundColor3 = col, Text = t,
			TextColor3 = txtCol or WHITE, Font = F.GothamBold, TextSize = 16}, r)
		round(b, 8)
		return b
	end
	local infoBtn = small("i", -96, SELC)
	local runBtn = small(">", -50, ACC, Color3.fromRGB(10, 10, 10))
	bind(infoBtn.MouseButton1Click, function() showInfo(s) end)
	bind(runBtn.MouseButton1Click, function() run(s) end)
	rows[#rows + 1] = {f = r, t = (s.name .. " " .. s.by):lower()}
end

-- ===== Bagian Fitur (di bawah daftar script) =====
mk("TextLabel", {Size = UDim2.new(1, 0, 0, 22), BackgroundTransparency = 1, Text = "Fitur ON / OFF", TextColor3 = ACC, Font = F.GothamBold,
	TextSize = 13, TextXAlignment = Enum.TextXAlignment.Left, LayoutOrder = 100}, featList)

local function featureRow(order, title, subtitle, s, actionText, onAction, toggle)
	local r = mk("Frame", {Size = UDim2.new(1, 0, 0, 54), BackgroundColor3 = PANEL, LayoutOrder = order}, featList)
	round(r, 10)
	mk("UIStroke", {Color = LINE, Thickness = 1.2}, r)
	mk("TextLabel", {Size = UDim2.new(1, -120, 0, 24), Position = UDim2.fromOffset(12, 7), BackgroundTransparency = 1, Text = title,
		TextColor3 = WHITE, Font = F.GothamBold, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, r)
	mk("TextLabel", {Size = UDim2.new(1, -120, 0, 16), Position = UDim2.fromOffset(12, 30), BackgroundTransparency = 1, Text = subtitle,
		TextColor3 = SUB, Font = F.GothamMedium, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, r)
	local ib = mk("TextButton", {Size = UDim2.fromOffset(36, 32), Position = UDim2.new(1, -102, 0.5, -16), BackgroundColor3 = SELC, Text = "i",
		TextColor3 = WHITE, Font = F.GothamBold, TextSize = 16}, r)
	round(ib, 8)
	local ab = mk("TextButton", {Size = UDim2.fromOffset(50, 32), Position = UDim2.new(1, -58, 0.5, -16),
		BackgroundColor3 = toggle and SELC or ACC, Text = actionText, TextColor3 = toggle and WHITE or Color3.fromRGB(10, 10, 10),
		Font = F.GothamBold, TextSize = 13}, r)
	round(ab, 8)
	bind(ib.MouseButton1Click, function() showInfo(s) end)
	bind(ab.MouseButton1Click, function() onAction(ab) end)
	rows[#rows + 1] = {f = r, t = (title .. " " .. subtitle):lower()}
end

-- 1. Tembus Dinding (noclip)
local noclip = false
featureRow(101, "Noclip", "tembus dinding dan apa pun",
	{name = "Noclip", info = "Karakter menembus dinding dan semua benda padat.\n\nKalau menembus lantai, karakter bisa jatuh. Nyalakan Fly v2 supaya tetap melayang.\n\nTekan ON untuk menyalakan, OFF untuk mematikan."},
	"OFF", function(b)
		noclip = not noclip
		b.Text = noclip and "ON" or "OFF"
		b.BackgroundColor3 = noclip and ACC or SELC
		b.TextColor3 = noclip and Color3.fromRGB(10, 10, 10) or WHITE
		setStatus(noclip and "Noclip aktif" or "Noclip mati")
	end, true)
bind(RS.Stepped, function()
	if noclip and lp.Character then
		for _, p in ipairs(lp.Character:GetDescendants()) do
			if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
		end
	end
end)

-- 2. Fly v2 (script)
local flyS = {name = "Fly v2", by = "Universal Script", url = "https://scriptblox.com/raw/Universal-Script-Flyv2-30617",
	info = "Universal Fly v2 (script dari scriptblox).\n\nON menjalankan script, tombol terbang muncul dari script itu. OFF menutup tampilannya dan melepas gaya terbang.\n\nOFF bekerja sebisanya, tergantung isi script-nya."}
local flyOn, flyGuis = false, {}
featureRow(102, "Fly v2", "script terbang universal", flyS, "OFF", function(b)
	flyOn = not flyOn
	b.Text = flyOn and "ON" or "OFF"
	b.BackgroundColor3 = flyOn and ACC or SELC
	b.TextColor3 = flyOn and Color3.fromRGB(10, 10, 10) or WHITE
	local roots = {}
	pcall(function() roots[#roots + 1] = parent end)
	pcall(function() roots[#roots + 1] = lp:FindFirstChildOfClass("PlayerGui") end)
	if flyOn then
		local before = {}
		for _, rt in ipairs(roots) do
			pcall(function() for _, c in ipairs(rt:GetChildren()) do before[c] = true end end)
		end
		run(flyS)
		task.delay(2.5, function()
			for _, rt in ipairs(roots) do
				pcall(function()
					for _, c in ipairs(rt:GetChildren()) do
						if not before[c] and c ~= gui and c:IsA("ScreenGui") then flyGuis[#flyGuis + 1] = c end
					end
				end)
			end
		end)
	else
		for _, g in ipairs(flyGuis) do pcall(function() g:Destroy() end) end
		flyGuis = {}
		local ch = lp.Character
		if ch then
			for _, d in ipairs(ch:GetDescendants()) do
				if d:IsA("BodyVelocity") or d:IsA("BodyGyro") or d:IsA("BodyPosition") then pcall(function() d:Destroy() end) end
			end
			local h = ch:FindFirstChildOfClass("Humanoid")
			if h then h.PlatformStand = false end
		end
		setStatus("Fly v2 dimatikan")
	end
end, true)

-- 3 dan 4. Save Teleport dan Teleport
local savedCF
local function myRoot()
	local c = lp.Character
	return c and c:FindFirstChild("HumanoidRootPart")
end
featureRow(103, "Save Teleport", "simpan posisi sekarang",
	{name = "Save Teleport", info = "Menyimpan posisimu saat ini.\n\nSetelah itu tekan GO di baris Teleport untuk kembali ke posisi ini."},
	"SAVE", function()
		local r = myRoot()
		if r then savedCF = r.CFrame setStatus("Posisi disimpan") else setStatus("Karakter tidak ditemukan") end
	end)
featureRow(104, "Teleport", "ke posisi yang disimpan",
	{name = "Teleport", info = "Pindah ke posisi yang disimpan lewat Save Teleport."},
	"GO", function()
		local r = myRoot()
		if not savedCF then setStatus("Belum ada posisi, tekan SAVE dulu") return end
		if r then r.CFrame = savedCF setStatus("Teleport berhasil") end
	end)

bind(search:GetPropertyChangedSignal("Text"), function()
	local q = search.Text:lower()
	for _, r in ipairs(rows) do r.f.Visible = q == "" or r.t:find(q, 1, true) ~= nil end
end)

-- X = keluar dari script (Out)
bind(xb.MouseButton1Click, function()
	for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
	gui:Destroy()
end)
