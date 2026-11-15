-- IT HUB by Riki v6 | Pembuat: sayangtalon_56
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local VIM = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local TS = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local lp = Players.LocalPlayer
local cam = workspace.CurrentCamera

-- Isi kalau punya gambar IT Indonesia, contoh: "rbxassetid://123456"
local LOGO_ASSET = ""
-- Simpan script ini dengan nama ini di folder workspace executor supaya tombol Lihat Coding bisa menampilkan kode
local SELF_FILE = "IT_Hub_by_Riki_v6.lua"

local parent = (gethui and gethui()) or (pcall(function() return game.CoreGui.Name end) and game.CoreGui) or lp:WaitForChild("PlayerGui")
pcall(function() parent:FindFirstChild("IT_Hub"):Destroy() end)

-- ===================== SANDI MASUK =====================
local PASSWORD = "IT2026"
local KEYFILE = "IT_HUB_key.txt"
local function hash(s) local h = 5381 for i = 1, #s do h = (h * 33 + string.byte(s, i)) % 4294967296 end return tostring(h) end
local function savedOk()
	local ok, res = pcall(function() return isfile and isfile(KEYFILE) and readfile(KEYFILE) end)
	return ok and res == hash(PASSWORD)
end
local function saveOk() pcall(function() if writefile then writefile(KEYFILE, hash(PASSWORD)) end end) end

local startHub
local function login()
	local lg = Instance.new("ScreenGui")
	lg.Name = "IT_Hub_Login" lg.ResetOnSpawn = false lg.Parent = parent
	local f = Instance.new("Frame")
	f.Size = UDim2.fromOffset(260, 160) f.Position = UDim2.new(0.5, -130, 0.5, -80)
	f.BackgroundColor3 = Color3.fromRGB(10, 10, 10) f.Parent = lg
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 14)
	local st = Instance.new("UIStroke", f) st.Color = Color3.fromRGB(60, 60, 60) st.Thickness = 2
	local function lab(t, y, sz, col)
		local l = Instance.new("TextLabel")
		l.Size = UDim2.new(1, 0, 0, 20) l.Position = UDim2.fromOffset(0, y) l.BackgroundTransparency = 1
		l.Text = t l.TextColor3 = col l.Font = Enum.Font.GothamBold l.TextSize = sz l.Parent = f
		return l
	end
	lab("IT HUB", 10, 18, Color3.new(1, 1, 1))
	lab("Masukkan sandi", 34, 12, Color3.fromRGB(150, 150, 150))
	local tb = Instance.new("TextBox")
	tb.Size = UDim2.new(1, -30, 0, 32) tb.Position = UDim2.fromOffset(15, 60) tb.Text = ""
	tb.PlaceholderText = "sandi" tb.BackgroundColor3 = Color3.fromRGB(28, 28, 28) tb.TextColor3 = Color3.new(1, 1, 1)
	tb.Font = Enum.Font.Gotham tb.TextSize = 13 tb.ClearTextOnFocus = false tb.Parent = f
	Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 16)
	local err = lab("", 132, 11, Color3.fromRGB(255, 90, 90))
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -30, 0, 28) b.Position = UDim2.fromOffset(15, 98) b.Text = "Masuk"
	b.BackgroundColor3 = Color3.fromRGB(0, 170, 210) b.TextColor3 = Color3.new(1, 1, 1)
	b.Font = Enum.Font.GothamBold b.TextSize = 13 b.Parent = f
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 14)
	local function try()
		if tb.Text == PASSWORD then
			saveOk()
			_G.IT_HUB_OK = true
			lg:Destroy()
			startHub()
		else
			err.Text = "Sandi salah"
		end
	end
	b.MouseButton1Click:Connect(try)
	tb.FocusLost:Connect(function(enter) if enter then try() end end)
end

startHub = function()
local ACC = Color3.fromRGB(0, 200, 255)
local BG = Color3.fromRGB(10, 10, 10)
local PANEL = Color3.fromRGB(15, 15, 15)
local LINE = Color3.fromRGB(48, 48, 48)
local SUB = Color3.fromRGB(150, 150, 150)
local WHITE = Color3.new(1, 1, 1)
local OFFC = Color3.fromRGB(60, 60, 60)
local SELC = Color3.fromRGB(42, 42, 42)
local RED = Color3.fromRGB(255, 90, 90)
local F = Enum.Font

local conns, alive = {}, true
local function bind(sig, fn) local c = sig:Connect(fn) conns[#conns + 1] = c return c end
local function mk(c, p, par)
	local o = Instance.new(c)
	for k, v in pairs(p) do o[k] = v end
	o.Parent = par
	return o
end
local function round(o, r) mk("UICorner", {CornerRadius = UDim.new(0, r or 8)}, o) end
local function isPress(i) return i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch end
local function isMove(i) return i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch end
local function drag(handle, target)
	local d, start, orig
	bind(handle.InputBegan, function(i)
		if isPress(i) then d, start, orig = true, i.Position, target.Position end
	end)
	bind(UIS.InputChanged, function(i)
		if d and isMove(i) then
			local dl = i.Position - start
			target.Position = UDim2.new(orig.X.Scale, orig.X.Offset + dl.X, orig.Y.Scale, orig.Y.Offset + dl.Y)
		end
	end)
	bind(UIS.InputEnded, function(i) if isPress(i) then d = false end end)
end
local function hrp() local c = lp.Character return c and c:FindFirstChild("HumanoidRootPart") end
local function hum() local c = lp.Character return c and c:FindFirstChildOfClass("Humanoid") end

local gui = mk("ScreenGui", {Name = "IT_Hub", ResetOnSpawn = false}, parent)

local function emblem(par, size)
	if LOGO_ASSET ~= "" then
		local img = mk("ImageLabel", {Size = UDim2.fromOffset(size, size), BackgroundTransparency = 1, Image = LOGO_ASSET}, par)
		round(img, size / 2)
		return img
	end
	local red, white = Color3.fromRGB(230, 30, 40), Color3.fromRGB(255, 255, 255)
	local e = mk("Frame", {Size = UDim2.fromOffset(size, size), BackgroundColor3 = white}, par)
	round(e, size / 2)
	mk("UIGradient", {Rotation = 90, Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, red), ColorSequenceKeypoint.new(0.5, red),
		ColorSequenceKeypoint.new(0.501, white), ColorSequenceKeypoint.new(1, white)})}, e)
	mk("UIStroke", {Color = ACC, Thickness = 2}, e)
	mk("TextLabel", {Size = UDim2.fromScale(1, 1), BackgroundTransparency = 1, Text = "IT",
		TextColor3 = Color3.fromRGB(20, 20, 30), Font = F.GothamBlack, TextSize = math.floor(size * 0.4)}, e)
	return e
end

---------------------------------------------------------------- Tombol bulat IT
local logo = mk("TextButton", {Size = UDim2.fromOffset(48, 48), Position = UDim2.new(0, 20, 0.5, -24),
	BackgroundColor3 = BG, Text = "IT", TextColor3 = WHITE, Font = F.GothamBlack, TextSize = 20, AutoButtonColor = false}, gui)
round(logo, 24)
mk("UIStroke", {Color = LINE, Thickness = 2}, logo)
drag(logo, logo)

---------------------------------------------------------------- Jendela utama
local main = mk("Frame", {Size = UDim2.fromOffset(500, 280), Position = UDim2.new(0.5, -250, 0.5, -140),
	BackgroundColor3 = BG, Visible = false}, gui)
round(main, 14)
mk("UIStroke", {Color = LINE, Thickness = 2}, main)
bind(logo.MouseButton1Click, function() main.Visible = not main.Visible end)

-- Header: logo, judul, search, grip geser
local header = mk("Frame", {Size = UDim2.new(1, 0, 0, 58), BackgroundTransparency = 1}, main)
drag(header, main)
local hl = emblem(header, 44) hl.Position = UDim2.fromOffset(8, 7)
local title = mk("TextLabel", {Size = UDim2.new(1, -300, 0, 24), Position = UDim2.fromOffset(62, 8), BackgroundTransparency = 1,
	Text = "IT", TextColor3 = WHITE, Font = F.GothamBold, TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left}, header)
local sub = mk("TextLabel", {Size = UDim2.new(1, -300, 0, 18), Position = UDim2.fromOffset(62, 32), BackgroundTransparency = 1,
	Text = "", TextColor3 = WHITE, Font = F.GothamBold, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left}, header)
local search = mk("TextBox", {Size = UDim2.fromOffset(150, 32), AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -48, 0, 29),
	BackgroundColor3 = Color3.fromRGB(22, 22, 22), Text = "", PlaceholderText = "Search..", PlaceholderColor3 = SUB,
	TextColor3 = WHITE, Font = F.GothamMedium, TextSize = 13, ClearTextOnFocus = false}, header)
round(search, 16)
mk("UIStroke", {Color = LINE, Thickness = 1.2}, search)
mk("UIPadding", {PaddingLeft = UDim.new(0, 12)}, search)
mk("TextLabel", {Size = UDim2.fromOffset(28, 28), AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0, 29),
	BackgroundTransparency = 1, Text = "≡", TextColor3 = SUB, Font = F.GothamBold, TextSize = 22}, header)
mk("Frame", {Size = UDim2.new(1, 0, 0, 1), Position = UDim2.fromOffset(0, 58), BackgroundColor3 = LINE, BorderSizePixel = 0}, main)

-- Sidebar ikon
local sidebar = mk("Frame", {Size = UDim2.new(0, 56, 1, -83), Position = UDim2.fromOffset(0, 59), BackgroundTransparency = 1}, main)
mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6), HorizontalAlignment = Enum.HorizontalAlignment.Center}, sidebar)
mk("UIPadding", {PaddingTop = UDim.new(0, 8)}, sidebar)
mk("Frame", {Size = UDim2.new(0, 1, 1, -83), Position = UDim2.fromOffset(56, 59), BackgroundColor3 = LINE, BorderSizePixel = 0}, main)

-- Area isi
local content = mk("Frame", {Size = UDim2.new(1, -57, 1, -83), Position = UDim2.fromOffset(57, 59), BackgroundTransparency = 1}, main)

-- Footer + resize
mk("Frame", {Size = UDim2.new(1, 0, 0, 1), AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, -24), BackgroundColor3 = LINE, BorderSizePixel = 0}, main)
mk("TextLabel", {Size = UDim2.new(1, -30, 0, 22), Position = UDim2.new(0, 0, 1, -23), BackgroundTransparency = 1,
	Text = "IT HUB | IT Indonesia | sayangtalon_56", TextColor3 = SUB, Font = F.GothamBold, TextSize = 12}, main)
local rz = mk("TextButton", {Size = UDim2.fromOffset(24, 22), AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -4, 1, -1),
	BackgroundTransparency = 1, Text = "◢", TextColor3 = SUB, Font = F.GothamBold, TextSize = 14}, main)
local rd, rs0, ro
bind(rz.InputBegan, function(i) if isPress(i) then rd, rs0, ro = true, i.Position, main.AbsoluteSize end end)
bind(UIS.InputChanged, function(i)
	if rd and isMove(i) then
		local d = i.Position - rs0
		main.Size = UDim2.fromOffset(math.clamp(ro.X + d.X, 400, 720), math.clamp(ro.Y + d.Y, 230, 420))
	end
end)
bind(UIS.InputEnded, function(i) if isPress(i) then rd = false end end)

---------------------------------------------------------------- Library UI kecil
local pages, outsides = {}, {}
local curPage, selectPage
local function hideOutsides() for _, o in ipairs(outsides) do o.Visible = false end end
local function showOut(f) local v = not f.Visible hideOutsides() f.Visible = v end
local function applyFilter()
	if not curPage then return end
	local q = search.Text:lower()
	for _, c in ipairs(curPage.cards) do c.any = false end
	for _, r in ipairs(curPage.rows) do
		local v = q == "" or r.t:lower():find(q, 1, true) ~= nil
		r.f.Visible = v
		if v then r.c.any = true end
	end
	for _, c in ipairs(curPage.cards) do c.f.Visible = (q == "") or c.any end
end
bind(search:GetPropertyChangedSignal("Text"), applyFilter)

local function newPage(name, icon, subtitle)
	local fr = mk("ScrollingFrame", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Visible = false, BorderSizePixel = 0,
		ScrollBarThickness = 3, ScrollBarImageColor3 = Color3.fromRGB(90, 90, 90), CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y}, content)
	mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 10)}, fr)
	mk("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 10)}, fr)
	local pg = {frame = fr, rows = {}, cards = {}, name = name, sub = subtitle}
	pages[#pages + 1] = pg
	pg.btn = mk("TextButton", {Size = UDim2.fromOffset(44, 44), BackgroundColor3 = SELC, BackgroundTransparency = 1, Text = icon,
		TextColor3 = SUB, Font = F.GothamBold, TextSize = 20, AutoButtonColor = false}, sidebar)
	round(pg.btn, 8)
	bind(pg.btn.MouseButton1Click, function() selectPage(pg) end)
	return pg
end
selectPage = function(pg)
	curPage = pg
	for _, p in ipairs(pages) do
		p.frame.Visible = p == pg
		p.btn.BackgroundTransparency = (p == pg) and 0 or 1
		p.btn.TextColor3 = (p == pg) and WHITE or SUB
	end
	title.Text = pg.name
	sub.Text = pg.sub
	hideOutsides()
	applyFilter()
end

local function card(pg, name)
	local f = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = PANEL}, pg.frame)
	round(f, 10)
	mk("UIStroke", {Color = LINE, Thickness = 1.2}, f)
	mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder}, f)
	local head = mk("TextButton", {Size = UDim2.new(1, 0, 0, 38), BackgroundTransparency = 1, Text = "", LayoutOrder = 1}, f)
	mk("TextLabel", {Size = UDim2.new(1, -50, 1, 0), Position = UDim2.fromOffset(12, 0), BackgroundTransparency = 1, Text = name,
		TextColor3 = WHITE, Font = F.GothamBold, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left}, head)
	local chev = mk("TextLabel", {Size = UDim2.fromOffset(30, 38), Position = UDim2.new(1, -36, 0, 0), BackgroundTransparency = 1,
		Text = "v", TextColor3 = WHITE, Font = F.GothamBold, TextSize = 14}, head)
	local sep = mk("Frame", {Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = LINE, BorderSizePixel = 0, LayoutOrder = 2}, f)
	local body = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = 3}, f)
	mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder}, body)
	local obj = {f = f, body = body, page = pg, any = false}
	bind(head.MouseButton1Click, function()
		local v = not body.Visible
		body.Visible = v sep.Visible = v
		chev.Text = v and "v" or ">"
	end)
	pg.cards[#pg.cards + 1] = obj
	return obj
end

local function rowFrame(body, text)
	local par = type(body) == "table" and body.body or body
	local f = mk("Frame", {Size = UDim2.new(1, 0, 0, 36), BackgroundTransparency = 1}, par)
	local l = mk("TextLabel", {Size = UDim2.new(1, -100, 1, 0), Position = UDim2.fromOffset(12, 0), BackgroundTransparency = 1, Text = text,
		TextColor3 = SUB, Font = F.GothamMedium, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, f)
	if type(body) == "table" then body.page.rows[#body.page.rows + 1] = {f = f, t = text, c = body} end
	return f, l
end
local function labelRow(body, text)
	local f, l = rowFrame(body, text)
	l.Size = UDim2.new(1, -20, 1, 0)
	return f, l
end
local function toggleRow(body, text, cb)
	local f = rowFrame(body, text)
	local sw = mk("TextButton", {Size = UDim2.fromOffset(44, 22), Position = UDim2.new(1, -54, 0.5, -11), BackgroundColor3 = OFFC,
		Text = "", AutoButtonColor = false}, f)
	round(sw, 11)
	local knob = mk("Frame", {Size = UDim2.fromOffset(18, 18), Position = UDim2.fromOffset(2, 2), BackgroundColor3 = WHITE}, sw)
	round(knob, 9)
	local on = false
	bind(sw.MouseButton1Click, function()
		on = not on
		sw.BackgroundColor3 = on and ACC or OFFC
		knob.Position = on and UDim2.fromOffset(24, 2) or UDim2.fromOffset(2, 2)
		cb(on)
	end)
end
local function buttonRow(body, text, cb, right, color)
	local f, l = rowFrame(body, text)
	local b = mk("TextButton", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "", ZIndex = 2}, f)
	mk("TextLabel", {Size = UDim2.fromOffset(80, 36), Position = UDim2.new(1, -86, 0, 0), BackgroundTransparency = 1, Text = right or ">",
		TextColor3 = color or ACC, Font = F.GothamBold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Right}, f)
	if color then l.TextColor3 = color end
	bind(b.MouseButton1Click, function() cb() end)
	return f, l
end
local function inputRow(body, text, def, cb)
	local f = rowFrame(body, text)
	local t = mk("TextBox", {Size = UDim2.fromOffset(88, 24), Position = UDim2.new(1, -98, 0.5, -12), BackgroundColor3 = Color3.fromRGB(28, 28, 28),
		Text = tostring(def), PlaceholderText = "", TextColor3 = WHITE, Font = F.Gotham, TextSize = 13, ClearTextOnFocus = false}, f)
	round(t, 12)
	bind(t.FocusLost, function()
		local r = cb(t.Text)
		if r ~= nil then t.Text = tostring(r) end
	end)
	return t
end

-- Kotak samping di luar jendela utama (bisa digeser lewat judulnya)
local function panel(name, w, h)
	local f = mk("Frame", {Size = UDim2.fromOffset(w, h), Position = UDim2.new(1, 8, 0, 58), BackgroundColor3 = BG, Visible = false}, main)
	round(f, 12)
	mk("UIStroke", {Color = LINE, Thickness = 1.5}, f)
	local t = mk("TextLabel", {Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1, Text = name, TextColor3 = WHITE,
		Font = F.GothamBold, TextSize = 14}, f)
	drag(t, f)
	local body = mk("ScrollingFrame", {Size = UDim2.new(1, -8, 1, -36), Position = UDim2.fromOffset(4, 32), BackgroundTransparency = 1,
		BorderSizePixel = 0, ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y}, f)
	mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 2)}, body)
	outsides[#outsides + 1] = f
	return f, body
end

---------------------------------------------------------------- State fitur
local aim = {on = false, range = 500}
local ac, acc = false, 0
local noclip = false
local ws = {on = false, v = 50, orig = 16}
local fly = {on = false, speed = 50, f = 0, b = 0, l = 0, r = 0}
local esp = {on = false, color = Color3.fromRGB(255, 0, 0), dist = 500, thin = false}
local saved, selP
local bv, bg

---------------------------------------------------------------- Pad fly (di luar jendela, dekat tombol IT)
local pad = mk("Frame", {Size = UDim2.fromOffset(128, 90), Position = UDim2.new(0, 14, 0.5, 38), BackgroundColor3 = BG, Visible = false}, gui)
round(pad, 12)
mk("UIStroke", {Color = LINE, Thickness = 2}, pad)
drag(pad, pad)
local function padBtn(txt, x, y, key)
	local b = mk("TextButton", {Size = UDim2.fromOffset(38, 38), Position = UDim2.fromOffset(x, y), BackgroundColor3 = SELC,
		Text = txt, TextColor3 = WHITE, Font = F.SourceSansBold, TextSize = 24}, pad)
	round(b, 10)
	bind(b.InputBegan, function(i) if isPress(i) then fly[key] = 1 end end)
	bind(b.InputEnded, function(i) if isPress(i) then fly[key] = 0 end end)
end
padBtn("^", 45, 4, "f")
padBtn("<", 4, 48, "l")
padBtn("↓", 45, 48, "b")
padBtn(">", 86, 48, "r")
local function stopFly()
	if bv then bv:Destroy() bv = nil end
	if bg then bg:Destroy() bg = nil end
	local h = hum()
	if h then h.PlatformStand = false end
	pad.Visible = false
end
local function startFly()
	local r = hrp()
	if not r then return end
	if bv then bv:Destroy() end
	if bg then bg:Destroy() end
	bv = mk("BodyVelocity", {MaxForce = Vector3.new(9e9, 9e9, 9e9), Velocity = Vector3.zero}, r)
	bg = mk("BodyGyro", {MaxTorque = Vector3.new(9e9, 9e9, 9e9), P = 9e4, CFrame = r.CFrame}, r)
	local h = hum()
	if h then h.PlatformStand = true end
	pad.Visible = true
end

---------------------------------------------------------------- Kotak samping
-- Coding
local codeW, codeBody = panel("Coding IT HUB", 270, 250)
local cscroll = mk("ScrollingFrame", {Size = UDim2.new(1, 0, 0, 160), BackgroundColor3 = Color3.fromRGB(6, 6, 6), BorderSizePixel = 0,
	ScrollBarThickness = 4, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.XY,
	ScrollingDirection = Enum.ScrollingDirection.XY, LayoutOrder = 1}, codeBody)
round(cscroll, 8)
local ctext = mk("TextLabel", {Size = UDim2.fromOffset(0, 0), AutomaticSize = Enum.AutomaticSize.XY, BackgroundTransparency = 1, Text = "",
	TextColor3 = Color3.fromRGB(150, 255, 170), Font = F.Code, TextSize = 11, TextXAlignment = Enum.TextXAlignment.Left,
	TextYAlignment = Enum.TextYAlignment.Top}, cscroll)
mk("UIPadding", {PaddingLeft = UDim.new(0, 4), PaddingTop = UDim.new(0, 4)}, ctext)
local pgLbl = mk("TextLabel", {Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1, Text = "", TextColor3 = SUB, Font = F.Gotham,
	TextSize = 11, LayoutOrder = 2}, codeBody)
local crow = mk("Frame", {Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 1, LayoutOrder = 3}, codeBody)
mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 4)}, crow)
local srcText, lines, page, PER = nil, nil, 1, 40
local function getSource()
	local src
	pcall(function() if getgenv and getgenv().IT_HUB_SRC then src = getgenv().IT_HUB_SRC end end)
	if not src then pcall(function() if isfile and isfile(SELF_FILE) then src = readfile(SELF_FILE) end end) end
	return src
end
local function renderCode()
	if not lines then
		ctext.Text = "Source tidak ditemukan.\nSimpan script sebagai\n" .. SELF_FILE .. "\ndi folder workspace executor."
		pgLbl.Text = ""
		return
	end
	local total = math.max(1, math.ceil(#lines / PER))
	page = math.clamp(page, 1, total)
	local out = {}
	for i = (page - 1) * PER + 1, math.min(#lines, page * PER) do
		out[#out + 1] = string.format("%3d  %s", i, (lines[i]:gsub("\t", "  ")))
	end
	ctext.Text = table.concat(out, "\n")
	pgLbl.Text = "Hal " .. page .. "/" .. total .. " (" .. #lines .. " baris)"
	cscroll.CanvasPosition = Vector2.zero
end
local function loadCode()
	if not lines then
		srcText = getSource()
		if srcText then lines = string.split(srcText, "\n") end
	end
	renderCode()
end
local function cBtn(t, cb)
	local b = mk("TextButton", {Size = UDim2.new(0.333, -3, 1, 0), BackgroundColor3 = SELC, Text = t, TextColor3 = WHITE, Font = F.GothamMedium, TextSize = 12}, crow)
	round(b, 14)
	bind(b.MouseButton1Click, cb)
end
cBtn("< Prev", function() page -= 1 renderCode() end)
cBtn("Next >", function() page += 1 renderCode() end)
cBtn("Copy", function()
	if srcText then pcall(function() setclipboard(srcText) end) pgLbl.Text = "Kode disalin" end
end)

-- Speed jalan 1 - 1000
local wsW, wsB = panel("Speed 1 - 1000", 190, 110)
inputRow(wsB, "Speed", 50, function(t)
	ws.v = math.clamp(math.floor(tonumber(t) or 50), 1, 1000)
	return ws.v
end)
toggleRow(wsB, "Aktif", function(v)
	ws.on = v
	local h = hum()
	if v then
		if h then ws.orig = h.WalkSpeed end
	elseif h then
		h.WalkSpeed = ws.orig
	end
end)

-- Speed fly 1 - 10000
local fsW, fsB = panel("Speed Fly 1 - 10000", 200, 110)
local fsVal, fsOn = 50, false
local function applyFs() fly.speed = fsOn and fsVal or 50 end
inputRow(fsB, "Speed", 50, function(t)
	fsVal = math.clamp(math.floor(tonumber(t) or 50), 1, 10000)
	applyFs()
	return fsVal
end)
toggleRow(fsB, "Aktif", function(v) fsOn = v applyFs() end)

-- Teleport save
local tpW, tpB = panel("Teleport", 200, 130)
local _, tpl = labelRow(tpB, "Posisi: belum disimpan")
buttonRow(tpB, "Save Posisi", function()
	local r = hrp()
	if r then saved = r.CFrame tpl.Text = "Posisi: tersimpan" end
end, "OK")
buttonRow(tpB, "Teleport ke Save", function()
	local r = hrp()
	if r and saved then r.CFrame = saved end
end, "GO")

-- Teleport Survival (pilih pemain)
local svW, svB = panel("Pilih Survival", 200, 230)
local list = mk("ScrollingFrame", {Size = UDim2.new(1, 0, 0, 120), BackgroundColor3 = PANEL, BorderSizePixel = 0, ScrollBarThickness = 3,
	CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, LayoutOrder = 1}, svB)
round(list, 8)
mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 3)}, list)
local function refresh()
	for _, c in ipairs(list:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= lp then
			local b = mk("TextButton", {Size = UDim2.new(1, -6, 0, 26), BackgroundColor3 = (selP == p) and ACC or SELC, Text = p.DisplayName,
				TextColor3 = (selP == p) and Color3.new(0, 0, 0) or WHITE, Font = F.GothamMedium, TextSize = 12, TextTruncate = Enum.TextTruncate.AtEnd}, list)
			round(b, 13)
			b.MouseButton1Click:Connect(function() selP = p refresh() end)
		end
	end
end
bind(Players.PlayerRemoving, function(p) if selP == p then selP = nil end task.defer(refresh) end)
bind(Players.PlayerAdded, function() task.defer(refresh) end)
local srow = mk("Frame", {Size = UDim2.new(1, 0, 0, 32), BackgroundTransparency = 1, LayoutOrder = 2}, svB)
mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6)}, srow)
local function sBtn(t, col, cb)
	local b = mk("TextButton", {Size = UDim2.new(0.5, -3, 1, 0), BackgroundColor3 = col, Text = t, TextColor3 = WHITE, Font = F.GothamBold, TextSize = 12}, srow)
	round(b, 16)
	bind(b.MouseButton1Click, cb)
end
sBtn("Refresh", SELC, refresh)
sBtn("Teleport", Color3.fromRGB(0, 140, 190), function()
	local r = hrp()
	local c = selP and selP.Character
	local t = c and c:FindFirstChild("HumanoidRootPart")
	if r and t then r.CFrame = t.CFrame * CFrame.new(0, 0, 3) end
end)

-- Warna ESP
local colW, colB = panel("Warna ESP", 160, 230)
local colors = {
	{"Merah", Color3.fromRGB(255, 0, 0)}, {"Hijau", Color3.fromRGB(0, 255, 0)}, {"Biru", Color3.fromRGB(0, 120, 255)},
	{"Kuning", Color3.fromRGB(255, 255, 0)}, {"Putih", Color3.fromRGB(255, 255, 255)}, {"Ungu", Color3.fromRGB(170, 0, 255)},
	{"Pink", Color3.fromRGB(255, 105, 180)}, {"Cyan", Color3.fromRGB(0, 255, 255)}, {"Oranye", Color3.fromRGB(255, 140, 0)},
}
for _, c in ipairs(colors) do
	local f, l = buttonRow(colB, c[1], function() esp.color = c[2] end, "●", c[2])
	l.TextColor3 = WHITE
end

-- Jarak ESP
local dsW, dsB = panel("Jarak ESP", 200, 170)
local dInput
dInput = inputRow(dsB, "Stud", 500, function(t)
	esp.dist = math.clamp(math.floor(tonumber(t) or 500), 100, 1000)
	return esp.dist
end)
for _, n in ipairs({100, 500, 1000}) do
	buttonRow(dsB, tostring(n) .. " stud", function() esp.dist = n dInput.Text = tostring(n) end, "SET")
end

---------------------------------------------------------------- Halaman IT
local pIT = newPage("IT", "IT", "IT Indonesia")
local cIT = card(pIT, "Tentang IT HUB")
buttonRow(cIT, "Lihat Coding", function() loadCode() showOut(codeW) end)
local ew = mk("Frame", {Size = UDim2.new(1, 0, 0, 80), BackgroundTransparency = 1}, cIT.body)
local em = emblem(ew, 62)
em.AnchorPoint = Vector2.new(0.5, 0)
em.Position = UDim2.new(0.5, 0, 0, 8)
labelRow(cIT, "IT INDONESIA").TextXAlignment = Enum.TextXAlignment.Left
labelRow(cIT, "Pembuat: sayangtalon_56")
labelRow(cIT, "by Riki")

---------------------------------------------------------------- Halaman Player
local pP = newPage("Player", "👤", "Fitur pemain")
local cC = card(pP, "Combat")
toggleRow(cC, "Auto Lock", function(v) aim.on = v end)
toggleRow(cC, "Auto Click 60", function(v) ac = v acc = 0 end)
local cM = card(pP, "Gerak")
toggleRow(cM, "Noclip", function(v) noclip = v end)
toggleRow(cM, "Fly", function(v)
	fly.on = v
	if v then startFly() else stopFly() end
end)
buttonRow(cM, "Speed 1 - 1000", function() showOut(wsW) end)
buttonRow(cM, "Speed Fly 1 - 10000", function() showOut(fsW) end)
local cT = card(pP, "Teleport")
buttonRow(cT, "Teleport (Save dan Teleport)", function() showOut(tpW) end)
buttonRow(cT, "Teleport Survival", function() refresh() showOut(svW) end)

---------------------------------------------------------------- Halaman ESP
local pE = newPage("ESP", "👁", "Lihat pemain")
local cE = card(pE, "ESP")
toggleRow(cE, "ESP", function(v) esp.on = v end)
toggleRow(cE, "Tembus Tipis", function(v) esp.thin = v end)
buttonRow(cE, "Pilih Warna", function() showOut(colW) end)
buttonRow(cE, "Atur Jarak 100 - 1000", function() showOut(dsW) end)

---------------------------------------------------------------- Halaman Setting
local pS = newPage("Setting", "⚙", "FPS, server, dan script")
local store = {fx = {}, parts = {}, post = {}}
local fxKeys, gfxKeys = {}, {}
local FXC = {"ParticleEmitter", "Trail", "Beam", "Fire", "Smoke", "Sparkles"}
local function isFx(o) for _, c in ipairs(FXC) do if o:IsA(c) then return true end end return false end
local fxConn
local function fxApply(on)
	if on then
		for _, o in ipairs(workspace:GetDescendants()) do
			if isFx(o) and o.Enabled then store.fx[o] = true o.Enabled = false end
		end
		fxConn = workspace.DescendantAdded:Connect(function(o)
			if isFx(o) then task.defer(function() pcall(function() o.Enabled = false end) end) end
		end)
	else
		if fxConn then fxConn:Disconnect() fxConn = nil end
		for o in pairs(store.fx) do pcall(function() o.Enabled = true end) end
		store.fx = {}
	end
end
local function setFx(k, on)
	fxKeys[k] = on or nil
	local any = next(fxKeys) ~= nil
	if any and not fxConn then fxApply(true) elseif not any and fxConn then fxApply(false) end
end
local gfxOn = false
local function gfxApply(on)
	gfxOn = on
	if on then
		store.shadows = Lighting.GlobalShadows
		Lighting.GlobalShadows = false
		for _, e in ipairs(Lighting:GetChildren()) do
			if e:IsA("PostEffect") and e.Enabled then store.post[e] = true e.Enabled = false end
		end
		pcall(function() store.q = settings().Rendering.QualityLevel settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
		pcall(function() local t = workspace.Terrain store.water = {t.WaterWaveSize, t.WaterReflectance} t.WaterWaveSize = 0 t.WaterReflectance = 0 end)
		task.spawn(function()
			local n = 0
			for _, p in ipairs(workspace:GetDescendants()) do
				if not gfxOn or not alive then break end
				if p:IsA("BasePart") and not p:IsA("Terrain") and p.Material ~= Enum.Material.SmoothPlastic then
					store.parts[p] = {p.Material, p.CastShadow, p.Reflectance}
					p.Material = Enum.Material.SmoothPlastic
					p.CastShadow = false
					p.Reflectance = 0
				end
				n += 1
				if n % 400 == 0 then task.wait() end
			end
		end)
	else
		if store.shadows ~= nil then Lighting.GlobalShadows = store.shadows end
		for e in pairs(store.post) do pcall(function() e.Enabled = true end) end
		store.post = {}
		pcall(function() if store.q then settings().Rendering.QualityLevel = store.q end end)
		pcall(function() if store.water then local t = workspace.Terrain t.WaterWaveSize = store.water[1] t.WaterReflectance = store.water[2] end end)
		for p, v in pairs(store.parts) do pcall(function() p.Material = v[1] p.CastShadow = v[2] p.Reflectance = v[3] end) end
		store.parts = {}
	end
end
local function setGfx(k, on)
	gfxKeys[k] = on or nil
	local any = next(gfxKeys) ~= nil
	if any and not gfxOn then gfxApply(true) elseif not any and gfxOn then gfxApply(false) end
end

local cP = card(pS, "Performa")
local _, fpsLbl = labelRow(cP, "FPS: -   Ping: -")
fpsLbl.TextColor3 = ACC
toggleRow(cP, "FPS Game", function(v)
	pcall(function() if setfpscap then setfpscap(v and 999 or 60) end end)
	setFx("boost", v)
end)
toggleRow(cP, "Jaringan Jelek", function(v) setGfx("net", v) setFx("net", v) end)
toggleRow(cP, "Low Grafik", function(v) setGfx("gfx", v) end)

local cSv = card(pS, "Server")
local _, stLbl = labelRow(cSv, "Status: siap")
stLbl.TextColor3 = ACC
local function say(t) stLbl.Text = "Status: " .. t end
labelRow(cSv, "ID Roblox: " .. lp.UserId)
buttonRow(cSv, "Copy ID Roblox", function() pcall(function() setclipboard(tostring(lp.UserId)) end) say("ID disalin") end, "COPY")
buttonRow(cSv, "Copy ID Server", function() pcall(function() setclipboard(game.JobId) end) say("ID server disalin") end, "COPY")
local function rejoin()
	say("rejoin...")
	pcall(function()
		if #Players:GetPlayers() <= 1 then TS:Teleport(game.PlaceId, lp)
		else TS:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp) end
	end)
end
local function serverBaru()
	say("mencari server baru...")
	task.spawn(function()
		local target
		pcall(function()
			local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
			local data = HttpService:JSONDecode(game:HttpGet(url))
			local pool = {}
			for _, s in ipairs(data.data or {}) do
				if s.id ~= game.JobId and s.playing < s.maxPlayers then pool[#pool + 1] = s.id end
			end
			if #pool > 0 then target = pool[math.random(1, #pool)] end
		end)
		if target then
			say("pindah server baru...")
			pcall(function() TS:TeleportToPlaceInstance(game.PlaceId, target, lp) end)
		else
			say("masuk server acak...")
			pcall(function() TS:Teleport(game.PlaceId, lp) end)
		end
	end)
end
buttonRow(cSv, "Rejoin", rejoin, "GO")
buttonRow(cSv, "Cari Server Baru", serverBaru, "GO")
local jobId = ""
inputRow(cSv, "ID Server", "", function(t) jobId = t:gsub("%s", "") return nil end)
buttonRow(cSv, "Join ID Server", function()
	if jobId == "" then say("isi ID server dulu") return end
	say("join ID server...")
	pcall(function() TS:TeleportToPlaceInstance(game.PlaceId, jobId, lp) end)
end, "GO")
local autoRJ = false
toggleRow(cSv, "Auto Rejoin", function(v) autoRJ = v end)
pcall(function()
	local overlay = game:GetService("CoreGui").RobloxPromptGui.promptOverlay
	bind(overlay.ChildAdded, function(c)
		if autoRJ and c.Name == "ErrorPrompt" then task.wait(1.5) serverBaru() end
	end)
end)

local cScr = card(pS, "Script")
local function unload()
	alive = false
	aim.on, fly.on, noclip, ac, esp.on = false, false, false, false, false
	stopFly()
	local h = hum()
	if ws.on and h then h.WalkSpeed = ws.orig end
	ws.on = false
	for k in pairs(fxKeys) do fxKeys[k] = nil end
	for k in pairs(gfxKeys) do gfxKeys[k] = nil end
	if fxConn then fxApply(false) end
	if gfxOn then gfxApply(false) end
	for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
	gui:Destroy()
end
buttonRow(cScr, "Out Script IT HUB", unload, "KELUAR", RED)

---------------------------------------------------------------- LOOP (ringan)
local function click()
	local m = UIS:GetMouseLocation()
	if UIS.TouchEnabled and not UIS.MouseEnabled then m = cam.ViewportSize / 2 end
	pcall(function()
		VIM:SendMouseButtonEvent(m.X, m.Y, 0, true, game, 0)
		VIM:SendMouseButtonEvent(m.X, m.Y, 0, false, game, 0)
	end)
end
local fpsAcc, fpsN = 0, 0
bind(RS.Heartbeat, function(dt)
	if ws.on then
		local h = hum()
		if h then h.WalkSpeed = ws.v end
	end
	if ac then
		acc = math.min(acc + dt, 0.05)
		while acc >= 1 / 60 do click() acc -= 1 / 60 end
	end
	fpsAcc += dt
	fpsN += 1
end)
bind(RS.Stepped, function()
	if noclip and lp.Character then
		for _, p in ipairs(lp.Character:GetDescendants()) do
			if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
		end
	end
end)
bind(RS.RenderStepped, function()
	if aim.on then
		local best, bd = nil, math.huge
		local center = cam.ViewportSize / 2
		local r = hrp()
		if r then
			for _, p in ipairs(Players:GetPlayers()) do
				local c = p ~= lp and p.Character
				local h = c and c:FindFirstChild("Head")
				local hm = c and c:FindFirstChildOfClass("Humanoid")
				if h and hm and hm.Health > 0 and (h.Position - r.Position).Magnitude <= aim.range then
					local pos, vis = cam:WorldToViewportPoint(h.Position)
					if vis then
						local d = (Vector2.new(pos.X, pos.Y) - center).Magnitude
						if d < bd then bd, best = d, h end
					end
				end
			end
		end
		if best then cam.CFrame = CFrame.new(cam.CFrame.Position, best.Position) end
	end
	if fly.on then
		if not bv or not bv.Parent then startFly() end
		if bv and bg then
			bv.Velocity = (cam.CFrame.LookVector * (fly.f - fly.b) + cam.CFrame.RightVector * (fly.r - fly.l)) * fly.speed
			bg.CFrame = cam.CFrame
		end
	end
end)

local hlt = {}
local function clearHL(p) if hlt[p] then hlt[p]:Destroy() hlt[p] = nil end end
bind(Players.PlayerRemoving, clearHL)
task.spawn(function()
	local n = 0
	while alive do
		task.wait(0.1)
		local r = hrp()
		for _, p in ipairs(Players:GetPlayers()) do
			if p ~= lp then
				local c = p.Character
				local pr = c and c:FindFirstChild("HumanoidRootPart")
				if esp.on and r and pr and (pr.Position - r.Position).Magnitude <= esp.dist then
					if not hlt[p] or hlt[p].Adornee ~= c then
						clearHL(p)
						hlt[p] = mk("Highlight", {Adornee = c, DepthMode = Enum.HighlightDepthMode.AlwaysOnTop}, gui)
					end
					hlt[p].OutlineColor = esp.color
					hlt[p].FillColor = esp.color
					hlt[p].FillTransparency = esp.thin and 1 or 0.5
				else
					clearHL(p)
				end
			end
		end
		n += 1
		if n % 5 == 0 and main.Visible and fpsAcc > 0 then
			local fps = math.floor(fpsN / fpsAcc + 0.5)
			fpsAcc, fpsN = 0, 0
			local ping = 0
			pcall(function() ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
			fpsLbl.Text = "FPS: " .. fps .. "   Ping: " .. ping .. "ms"
		end
	end
end)

selectPage(pIT)
end

if _G.IT_HUB_OK or savedOk() then startHub() else login() end
