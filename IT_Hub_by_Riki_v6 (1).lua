--[[
    IT HUB by Riki v7 | Pembuat: sayangtalon_56
    SANDI: IT2026
]]

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

local LOGO_ASSET = ""
local SELF_FILE = "IT_Hub_by_Riki_v7.lua"

local parent = (gethui and gethui()) or (pcall(function() return game.CoreGui.Name end) and game.CoreGui) or lp:WaitForChild("PlayerGui")
pcall(function() parent:FindFirstChild("IT_Hub"):Destroy() end)

-- ===================== LOGIN =====================
local PASSWORD = "IT2026"
local KEYFILE = "IT_HUB_key.txt"
local function hash(s) local h = 5381 for i = 1, #s do h = (h * 33 + string.byte(s, i)) % 4294967296 end return tostring(h) end
local function savedOk() local ok, res = pcall(function() return isfile and isfile(KEYFILE) and readfile(KEYFILE) end) return ok and res == hash(PASSWORD) end
local function saveOk() pcall(function() if writefile then writefile(KEYFILE, hash(PASSWORD)) end end) end

local startHub
local function login()
    local lg = Instance.new("ScreenGui") lg.Name = "IT_Hub_Login" lg.ResetOnSpawn = false lg.Parent = parent
    local f = Instance.new("Frame") f.Size = UDim2.fromOffset(260, 160) f.Position = UDim2.new(0.5, -130, 0.5, -80) f.BackgroundColor3 = Color3.fromRGB(10, 10, 10) f.Parent = lg
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 14)
    local st = Instance.new("UIStroke", f) st.Color = Color3.fromRGB(60, 60, 60) st.Thickness = 2
    local function lab(t, y, sz, col)
        local l = Instance.new("TextLabel") l.Size = UDim2.new(1, 0, 0, 20) l.Position = UDim2.fromOffset(0, y) l.BackgroundTransparency = 1 l.Text = t l.TextColor3 = col l.Font = Enum.Font.GothamBold l.TextSize = sz l.Parent = f return l
    end
    lab("IT HUB", 10, 18, Color3.new(1, 1, 1)) lab("Masukkan sandi", 34, 12, Color3.fromRGB(150, 150, 150))
    local tb = Instance.new("TextBox") tb.Size = UDim2.new(1, -30, 0, 32) tb.Position = UDim2.fromOffset(15, 60) tb.PlaceholderText = "sandi" tb.BackgroundColor3 = Color3.fromRGB(28, 28, 28) tb.TextColor3 = Color3.new(1, 1, 1) tb.Font = Enum.Font.Gotham tb.TextSize = 13 tb.ClearTextOnFocus = false tb.Parent = f
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 16)
    local err = lab("", 132, 11, Color3.fromRGB(255, 90, 90))
    local b = Instance.new("TextButton") b.Size = UDim2.new(1, -30, 0, 28) b.Position = UDim2.fromOffset(15, 98) b.Text = "Masuk" b.BackgroundColor3 = Color3.fromRGB(0, 170, 210) b.TextColor3 = Color3.new(1, 1, 1) b.Font = Enum.Font.GothamBold b.TextSize = 13 b.Parent = f
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 14)
    local function try()
        if tb.Text == PASSWORD then saveOk() _G.IT_HUB_OK = true lg:Destroy() startHub() else err.Text = "Sandi salah" end
    end
    b.MouseButton1Click:Connect(try) tb.FocusLost:Connect(function(enter) if enter then try() end end)
end

startHub = function()
local ACC = Color3.fromRGB(0, 200, 255) local BG = Color3.fromRGB(10, 10, 10) local PANEL = Color3.fromRGB(15, 15, 15) local LINE = Color3.fromRGB(48, 48, 48) local SUB = Color3.fromRGB(150, 150, 150) local WHITE = Color3.new(1, 1, 1) local OFFC = Color3.fromRGB(60, 60, 60) local SELC = Color3.fromRGB(42, 42, 42) local RED = Color3.fromRGB(255, 90, 90) local F = Enum.Font

local conns, alive = {}, true
local function bind(sig, fn) local c = sig:Connect(fn) conns[#conns + 1] = c return c end
local function mk(c, p, par) local o = Instance.new(c) for k, v in pairs(p) do o[k] = v end o.Parent = par return o end
local function round(o, r) mk("UICorner", {CornerRadius = UDim.new(0, r or 8)}, o) end
local function isPress(i) return i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch end
local function isMove(i) return i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch end
local function drag(handle, target)
    local d, start, orig
    bind(handle.InputBegan, function(i) if isPress(i) then d, start, orig = true, i.Position, target.Position end end)
    bind(UIS.InputChanged, function(i) if d and isMove(i) then local dl = i.Position - start target.Position = UDim2.new(orig.X.Scale, orig.X.Offset + dl.X, orig.Y.Scale, orig.Y.Offset + dl.Y) end end)
    bind(UIS.InputEnded, function(i) if isPress(i) then d = false end end)
end
local function hrp() local c = lp.Character return c and c:FindFirstChild("HumanoidRootPart") end
local function hum() local c = lp.Character return c and c:FindFirstChildOfClass("Humanoid") end

local gui = mk("ScreenGui", {Name = "IT_Hub", ResetOnSpawn = false}, parent)

local logo = mk("TextButton", {Size = UDim2.fromOffset(48, 48), Position = UDim2.new(0, 20, 0.5, -24), BackgroundColor3 = BG, Text = "IT", TextColor3 = WHITE, Font = F.GothamBlack, TextSize = 20, AutoButtonColor = false}, gui) 
round(logo, 24) 
mk("UIStroke", {Color = LINE, Thickness = 2}, logo) 
drag(logo, logo)

local main = mk("Frame", {Size = UDim2.fromOffset(520, 300), Position = UDim2.new(0.5, -260, 0.5, -150), BackgroundColor3 = BG, Visible = false}, gui) 
round(main, 14) 
mk("UIStroke", {Color = LINE, Thickness = 2}, main) 
bind(logo.MouseButton1Click, function() main.Visible = not main.Visible end)

local header = mk("Frame", {Size = UDim2.new(1, 0, 0, 58), BackgroundTransparency = 1}, main) drag(header, main)
local title = mk("TextLabel", {Size = UDim2.new(1, -300, 0, 24), Position = UDim2.fromOffset(62, 8), BackgroundTransparency = 1, Text = "IT", TextColor3 = WHITE, Font = F.GothamBold, TextSize = 18, TextXAlignment = Enum.TextXAlignment.Left}, header)
local sub = mk("TextLabel", {Size = UDim2.new(1, -300, 0, 18), Position = UDim2.fromOffset(62, 32), BackgroundTransparency = 1, Text = "", TextColor3 = WHITE, Font = F.GothamBold, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left}, header)

local sidebar = mk("Frame", {Size = UDim2.new(0, 56, 1, -83), Position = UDim2.fromOffset(0, 59), BackgroundTransparency = 1}, main)
mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6), HorizontalAlignment = Enum.HorizontalAlignment.Center}, sidebar) 
mk("UIPadding", {PaddingTop = UDim.new(0, 8)}, sidebar)
mk("Frame", {Size = UDim2.new(0, 1, 1, -83), Position = UDim2.fromOffset(56, 59), BackgroundColor3 = LINE, BorderSizePixel = 0}, main)
local content = mk("Frame", {Size = UDim2.new(1, -57, 1, -83), Position = UDim2.fromOffset(57, 59), BackgroundTransparency = 1}, main)
mk("Frame", {Size = UDim2.new(1, 0, 0, 1), AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, -24), BackgroundColor3 = LINE, BorderSizePixel = 0}, main)
mk("TextLabel", {Size = UDim2.new(1, -30, 0, 22), Position = UDim2.new(0, 0, 1, -23), BackgroundTransparency = 1, Text = "IT HUB v7 | IT Indonesia | sayangtalon_56", TextColor3 = SUB, Font = F.GothamBold, TextSize = 12}, main)

local pages, outsides = {}, {}
local curPage, selectPage
local function hideOutsides() for _, o in ipairs(outsides) do o.Visible = false end end
local function showOut(f) local v = not f.Visible hideOutsides() f.Visible = v end

local function newPage(name, icon, subtitle)
    local fr = mk("ScrollingFrame", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Visible = false, BorderSizePixel = 0, ScrollBarThickness = 3, ScrollBarImageColor3 = Color3.fromRGB(90, 90, 90), CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y}, content)
    mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 10)}, fr)
    mk("UIPadding", {PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 10)}, fr)
    local pg = {frame = fr, cards = {}, name = name, sub = subtitle} pages[#pages + 1] = pg
    pg.btn = mk("TextButton", {Size = UDim2.fromOffset(44, 44), BackgroundColor3 = SELC, BackgroundTransparency = 1, Text = icon, TextColor3 = SUB, Font = F.GothamBold, TextSize = 20, AutoButtonColor = false}, sidebar)
    round(pg.btn, 8) bind(pg.btn.MouseButton1Click, function() selectPage(pg) end)
    return pg
end
selectPage = function(pg)
    curPage = pg
    for _, p in ipairs(pages) do p.frame.Visible = p == pg p.btn.BackgroundTransparency = (p == pg) and 0 or 1 p.btn.TextColor3 = (p == pg) and WHITE or SUB end
    title.Text = pg.name sub.Text = pg.sub hideOutsides() 
end

local function card(pg, name)
    local f = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = PANEL}, pg.frame) round(f, 10) mk("UIStroke", {Color = LINE, Thickness = 1.2}, f) mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder}, f)
    local head = mk("TextButton", {Size = UDim2.new(1, 0, 0, 38), BackgroundTransparency = 1, Text = "", LayoutOrder = 1}, f)
    mk("TextLabel", {Size = UDim2.new(1, -50, 1, 0), Position = UDim2.fromOffset(12, 0), BackgroundTransparency = 1, Text = name, TextColor3 = WHITE, Font = F.GothamBold, TextSize = 15, TextXAlignment = Enum.TextXAlignment.Left}, head)
    local chev = mk("TextLabel", {Size = UDim2.fromOffset(30, 38), Position = UDim2.new(1, -36, 0, 0), BackgroundTransparency = 1, Text = "v", TextColor3 = WHITE, Font = F.GothamBold, TextSize = 14}, head)
    local sep = mk("Frame", {Size = UDim2.new(1, 0, 0, 1), BackgroundColor3 = LINE, BorderSizePixel = 0, LayoutOrder = 2}, f)
    local body = mk("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, LayoutOrder = 3}, f) mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder}, body)
    local obj = {f = f, body = body, page = pg}
    bind(head.MouseButton1Click, function() local v = not body.Visible body.Visible = v sep.Visible = v chev.Text = v and "v" or ">" end)
    pg.cards[#pg.cards + 1] = obj return obj
end

local function rowFrame(body, text)
    local par = type(body) == "table" and body.body or body
    local f = mk("Frame", {Size = UDim2.new(1, 0, 0, 36), BackgroundTransparency = 1}, par)
    local l = mk("TextLabel", {Size = UDim2.new(1, -100, 1, 0), Position = UDim2.fromOffset(12, 0), BackgroundTransparency = 1, Text = text, TextColor3 = SUB, Font = F.GothamMedium, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd}, f)
    return f, l
end
local function labelRow(body, text) local f, l = rowFrame(body, text) l.Size = UDim2.new(1, -20, 1, 0) return f, l end
local function toggleRow(body, text, cb)
    local f = rowFrame(body, text)
    local sw = mk("TextButton", {Size = UDim2.fromOffset(44, 22), Position = UDim2.new(1, -54, 0.5, -11), BackgroundColor3 = OFFC, Text = "", AutoButtonColor = false}, f) round(sw, 11)
    local knob = mk("Frame", {Size = UDim2.fromOffset(18, 18), Position = UDim2.fromOffset(2, 2), BackgroundColor3 = WHITE}, sw) round(knob, 9)
    local on = false
    bind(sw.MouseButton1Click, function() on = not on sw.BackgroundColor3 = on and ACC or OFFC knob.Position = on and UDim2.fromOffset(24, 2) or UDim2.fromOffset(2, 2) cb(on) end)
end
local function buttonRow(body, text, cb, right, color)
    local f, l = rowFrame(body, text)
    local b = mk("TextButton", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "", ZIndex = 2}, f)
    mk("TextLabel", {Size = UDim2.fromOffset(80, 36), Position = UDim2.new(1, -86, 0, 0), BackgroundTransparency = 1, Text = right or ">", TextColor3 = color or ACC, Font = F.GothamBold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Right}, f)
    if color then l.TextColor3 = color end
    bind(b.MouseButton1Click, function() cb() end) return f, l
end
local function inputRow(body, text, def, cb)
    local f = rowFrame(body, text)
    local t = mk("TextBox", {Size = UDim2.fromOffset(88, 24), Position = UDim2.new(1, -98, 0.5, -12), BackgroundColor3 = Color3.fromRGB(28, 28, 28), Text = tostring(def), PlaceholderText = "", TextColor3 = WHITE, Font = F.Gotham, TextSize = 13, ClearTextOnFocus = false}, f) round(t, 12)
    bind(t.FocusLost, function() local r = cb(t.Text) if r ~= nil then t.Text = tostring(r) end end) return t
end

-- Panel Samping + Tombol X
local function panel(name, w, h)
    local f = mk("Frame", {Size = UDim2.fromOffset(w, h), Position = UDim2.new(1, 10, 0, 58), BackgroundColor3 = BG, Visible = false}, main) round(f, 12) mk("UIStroke", {Color = LINE, Thickness = 1.5}, f)
    local top = mk("Frame", {Size = UDim2.new(1, 0, 0, 30), BackgroundTransparency = 1}, f)
    local t = mk("TextLabel", {Size = UDim2.new(1, -30, 1, 0), Position = UDim2.fromOffset(10, 0), BackgroundTransparency = 1, Text = name, TextColor3 = WHITE, Font = F.GothamBold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left}, top) drag(t, f)
    local cls = mk("TextButton", {Size = UDim2.fromOffset(24, 24), Position = UDim2.new(1, -28, 0, 3), BackgroundColor3 = Color3.fromRGB(40, 40, 40), Text = "X", TextColor3 = RED, Font = F.GothamBold, TextSize = 12}, top) round(cls, 6)
    bind(cls.MouseButton1Click, function() f.Visible = false end)
    local body = mk("ScrollingFrame", {Size = UDim2.new(1, -8, 1, -36), Position = UDim2.fromOffset(4, 32), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y}, f)
    mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 2)}, body)
    outsides[#outsides + 1] = f
    return f, body
end

-- State Variables
local noclip = false
local infJump = false
local invis = false
local ws = {on = false, v = 50, orig = 16}
local fly = {on = false, speed = 50, f = 0, b = 0, l = 0, r = 0}
local esp = {on = false, color = Color3.fromRGB(255, 0, 0), thin = false}
local aim = {on = false, target = nil}
local savedPos = nil
local bv, bg, laser

-- Fly Pad
local pad = mk("Frame", {Size = UDim2.fromOffset(128, 90), Position = UDim2.new(0, 14, 0.5, 38), BackgroundColor3 = BG, Visible = false}, gui) round(pad, 12) mk("UIStroke", {Color = LINE, Thickness = 2}, pad) drag(pad, pad)
local function padBtn(txt, x, y, key)
    local b = mk("TextButton", {Size = UDim2.fromOffset(38, 38), Position = UDim2.fromOffset(x, y), BackgroundColor3 = SELC, Text = txt, TextColor3 = WHITE, Font = F.SourceSansBold, TextSize = 24}, pad) round(b, 10)
    bind(b.InputBegan, function(i) if isPress(i) then fly[key] = 1 end end) bind(b.InputEnded, function(i) if isPress(i) then fly[key] = 0 end end)
end
padBtn("^", 45, 4, "f") padBtn("<", 4, 48, "l") padBtn("↓", 45, 48, "b") padBtn(">", 86, 48, "r")
local function stopFly()
    if bv then bv:Destroy() bv = nil end if bg then bg:Destroy() bg = nil end
    local h = hum() if h then h.PlatformStand = false end pad.Visible = false
end
local function startFly()
    local r = hrp() if not r then return end
    if bv then bv:Destroy() end if bg then bg:Destroy() end
    bv = mk("BodyVelocity", {MaxForce = Vector3.new(9e9, 9e9, 9e9), Velocity = Vector3.zero}, r)
    bg = mk("BodyGyro", {MaxTorque = Vector3.new(9e9, 9e9, 9e9), P = 9e4, CFrame = r.CFrame}, r)
    local h = hum() if h then h.PlatformStand = true end pad.Visible = true
end

-- ================= HALAMAN INTI =================
local pInti = newPage("Inti", "IT", "IT Indonesia")
local cInfo = card(pInti, "Tentang IT HUB")
labelRow(cInfo, "Pembuat: sayangtalon_56")
labelRow(cInfo, "by Riki")

-- ================= HALAMAN PLAYER =================
local pPlayer = newPage("Player", "👤", "Fitur Karakter")
local cPlayer = card(pPlayer, "Mods & Teleport")

local speedW, speedB = panel("Speed & Noclip", 190, 120)
inputRow(speedB, "Speed", 50, function(t) ws.v = math.clamp(math.floor(tonumber(t) or 50), 1, 1000) return ws.v end)
toggleRow(speedB, "Speed On", function(v) ws.on = v local h = hum() if v then if h then ws.orig = h.WalkSpeed end elseif h then h.WalkSpeed = ws.orig end end)
toggleRow(speedB, "Tembus Tembok", function(v) noclip = v end)

toggleRow(cPlayer, "Speed On/Off", function(v) ws.on = v local h = hum() if v then if h then ws.orig = h.WalkSpeed end elseif h then h.WalkSpeed = ws.orig end end)
buttonRow(cPlayer, "Atur Speed & Tembus Tembok", function() showOut(speedW) end)

toggleRow(cPlayer, "Save Posisi", function(v) if v then local r = hrp() if r then savedPos = r.CFrame end end end)
buttonRow(cPlayer, "Teleport ke Save", function() local r = hrp() if r and savedPos then r.CFrame = savedPos end end, "GO")

local tpPW, tpPB = panel("Teleport Player", 180, 220)
local tpList = mk("ScrollingFrame", {Size = UDim2.new(1, 0, 0, 140), BackgroundColor3 = PANEL, BorderSizePixel = 0, ScrollBarThickness = 3, CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, LayoutOrder = 1}, tpPB) round(tpList, 8)
mk("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 2)}, tpList)
local selTpTarget = nil
local function refreshTp()
    for _, c in ipairs(tpList:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= lp then
            local b = mk("TextButton", {Size = UDim2.new(1, -4, 0, 26), BackgroundColor3 = (selTpTarget == p) and ACC or SELC, Text = p.Name, TextColor3 = (selTpTarget == p) and Color3.new(0,0,0) or WHITE, Font = F.Gotham, TextSize = 12}, tpList) round(b, 6)
            bind(b.MouseButton1Click, function() selTpTarget = p refreshTp() end)
        end
    end
end
buttonRow(tpPB, "Pilih Pemain", function() refreshTp() end, "REFRESH")
local btnTp = mk("TextButton", {Size = UDim2.new(1, 0, 0, 28), Position = UDim2.fromOffset(0, 175), BackgroundColor3 = ACC, Text = "TELEPORT", TextColor3 = WHITE, Font = F.GothamBold, TextSize = 13}, tpPB) round(btnTp, 8)
bind(btnTp.MouseButton1Click, function() 
    if selTpTarget and selTpTarget.Character then 
        local r = hrp() local t = selTpTarget.Character:FindFirstChild("HumanoidRootPart")
        if r and t then r.CFrame = t.CFrame * CFrame.new(0, 0, 3) end 
    end 
end)

buttonRow(cPlayer, "Teleport ke Player Lain", function() refreshTp() showOut(tpPW) end)

toggleRow(cPlayer, "Fly (Tombol Panah)", function(v) fly.on = v if v then startFly() else stopFly() end)
toggleRow(cPlayer, "Visual Good Mode (HD)", function(v) 
    if v then Lighting.GlobalShadows = true for _, e in ipairs(Lighting:GetChildren()) do if e:IsA("PostEffect") then e.Enabled = true end end
    else Lighting.GlobalShadows = false end
end)
toggleRow(cPlayer, "Invisible Visual", function(v) 
    invis = v
    task.spawn(function() while invis and alive do task.wait(0.1) if lp.Character then for _, p in ipairs(lp.Character:GetDescendants()) do if p:IsA("BasePart") or p:IsA("Decal") then p.LocalTransparencyModifier = 1 end end end end end)
end)
toggleRow(cPlayer, "Infinite Jump", function(v) infJump = v end)

-- ================= HALAMAN ESP & COMBAT =================
local pESP = newPage("ESP", "👁", "Visual & Combat")
local cESP = card(pESP, "ESP Settings")
local colW, colB = panel("Warna ESP", 160, 200)
local colors = {{"Merah", Color3.fromRGB(255, 0, 0)},{"Hijau", Color3.fromRGB(0, 255, 0)},{"Biru", Color3.fromRGB(0, 120, 255)},{"Kuning", Color3.fromRGB(255, 255, 0)},{"Putih", Color3.fromRGB(255, 255, 255)},{"Ungu", Color3.fromRGB(170, 0, 255)},{"Cyan", Color3.fromRGB(0, 255, 255)}}
for _, c in ipairs(colors) do local f, l = buttonRow(colB, c[1], function() esp.color = c[2] end, "●", c[2]) l.TextColor3 = WHITE end

toggleRow(cESP, "ESP Player", function(v) esp.on = v end)
toggleRow(cESP, "ESP Tipis (Garis)", function(v) esp.thin = v end)
buttonRow(cESP, "Pilih Warna", function() showOut(colW) end)

-- Fitur Combat yang digabung ke sini
local cCombat = card(pESP, "Combat (Auto Aim)")
local aimPW, aimPB = panel("Pilih Target", 180, 220)
local aimList = mk("ScrollingFrame", {Size = UDim2.new(1, 0, 0, 140),
