-- ZAYN HUB loader v8.2 (daftar script + info pembuat)
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

local HUB_NAME = "ZAYN-ALL"   -- ganti nama hub di sini
local VERSION = "v8.2"

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
local main = mk("Frame", {Size = UDim2.fromOffset(500, 280), Position = UDim2.new(0.5, -250, 0.5, -140), BackgroundColor3 = BG, Visible = false}, gui)
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
local side = mk("Frame", {Size = UDim2.new(0, 52, 1, -53), Position = UDim2.fromOffset(0, 53), BackgroundTransparency = 1}, main)
mk("Frame", {Size = UDim2.new(0, 1, 1, -53), Position = UDim2.fromOffset(52, 53), BackgroundColor3 = LINE, BorderSizePixel = 0}, main)
local zBtn = mk("TextButton", {Size = UDim2.fromOffset(38, 38), AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 8),
	BackgroundColor3 = SELC, Text = letter, TextColor3 = WHITE, Font = F.GothamBlack, TextSize = 18, AutoButtonColor = false}, side)
round(zBtn, 8)
-- Logo di bawah sidebar (ganti foto profil): tekan untuk membuka informasi 2 bahasa
local infoLogo = mk("TextButton", {Size = UDim2.fromOffset(38, 38), AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -8),
	BackgroundColor3 = SELC, Text = letter, TextColor3 = WHITE, Font = F.GothamBlack, TextSize = 18, AutoButtonColor = false}, side)
round(infoLogo, 19)
mk("UIStroke", {Color = ACC, Thickness = 1.5}, infoLogo)
local badge = mk("TextLabel", {Size = UDim2.fromOffset(14, 14), Position = UDim2.new(1, -9, 0, -3), BackgroundColor3 = ACC, Text = "i",
	TextColor3 = Color3.fromRGB(10, 10, 10), Font = F.GothamBold, TextSize = 10}, infoLogo)
round(badge, 7)

-- Kotak versi (muncul di bawah kiri saat ikon Z ditekan)
local verBox = mk("Frame", {Size = UDim2.fromOffset(230, 66), Position = UDim2.new(0, 0, 1, 8), BackgroundColor3 = BG, Visible = false}, main)
round(verBox, 10)
mk("UIStroke", {Color = LINE, Thickness = 1.5}, verBox)
mk("TextLabel", {Size = UDim2.new(1, -20, 0, 30), Position = UDim2.fromOffset(10, 6), BackgroundTransparency = 1,
	Text = "Anda sedang memakai versi " .. VERSION, TextColor3 = WHITE, Font = F.GothamBold, TextSize = 13, TextWrapped = true,
	TextXAlignment = Enum.TextXAlignment.Left}, verBox)
mk("TextLabel", {Size = UDim2.new(1, -20, 0, 20), Position = UDim2.fromOffset(10, 38), BackgroundTransparency = 1,
	Text = "Update setiap minggu", TextColor3 = ACC, Font = F.GothamMedium, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left}, verBox)

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

bind(zBtn.MouseButton1Click, function() local v = not verBox.Visible msgBox.Visible = false verBox.Visible = v end)
bind(infoLogo.MouseButton1Click, function() local v = not msgBox.Visible verBox.Visible = false msgBox.Visible = v end)

-- Daftar script (bisa di-scroll)
local list = mk("ScrollingFrame", {Size = UDim2.new(1, -53, 1, -53), Position = UDim2.fromOffset(53, 53), BackgroundTransparency = 1,
	BorderSizePixel = 0, ScrollBarThickness = 5, ScrollBarImageColor3 = Color3.fromRGB(110, 110, 110), CanvasSize = UDim2.new(),
	AutomaticCanvasSize = Enum.AutomaticSize.Y}, main)
mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8)}, list)
mk("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 12)}, list)

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

bind(search:GetPropertyChangedSignal("Text"), function()
	local q = search.Text:lower()
	for _, r in ipairs(rows) do r.f.Visible = q == "" or r.t:find(q, 1, true) ~= nil end
end)

-- X = keluar dari script (Out)
bind(xb.MouseButton1Click, function()
	for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
	gui:Destroy()
end)
