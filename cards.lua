-- BS Cards Sender - GameGuardian Lua
-- Server must expose /api/cards/analyze and /api/cards/send-all

local SERVER = "https://soft-flower-4528.alklharq40.workers.dev"
local ANALYZE = SERVER .. "/api/cards/analyze"
local SEND = SERVER .. "/api/cards/send-all"
local XML_PATH = "/storage/emulated/0/.pmtemp/my.xml"

local function readFile(path)
    local f, err = io.open(path, "rb")
    if not f then return nil, err end
    local s = f:read("*a")
    f:close()
    return s
end

local function writeFile(path, data)
    local f, err = io.open(path, "wb")
    if not f then return false, err end
    f:write(data)
    f:close()
    return true
end

local function jsonEscape(s)
    s = tostring(s or "")
    s = s:gsub("\\", "\\\\")
    s = s:gsub('"', '\\"')
    s = s:gsub("\b", "\\b")
    s = s:gsub("\f", "\\f")
    s = s:gsub("\n", "\\n")
    s = s:gsub("\r", "\\r")
    s = s:gsub("\t", "\\t")
    return '"' .. s .. '"'
end

local function jsonEncode(v)
    local t = type(v)
    if t == "nil" then return "null" end
    if t == "boolean" then return v and "true" or "false" end
    if t == "number" then return tostring(v) end
    if t == "string" then return jsonEscape(v) end
    if t == "table" then
        local isArray = true
        local n = 0
        for k,_ in pairs(v) do
            if type(k) ~= "number" then isArray = false break end
            if k > n then n = k end
        end
        if isArray then
            local a = {}
            for i=1,n do a[#a+1] = jsonEncode(v[i]) end
            return "[" .. table.concat(a, ",") .. "]"
        end
        local a = {}
        for k,val in pairs(v) do
            a[#a+1] = jsonEscape(k) .. ":" .. jsonEncode(val)
        end
        return "{" .. table.concat(a, ",") .. "}"
    end
    error("unsupported json type: " .. t)
end

local function jsonDecode(str)
    local pos = 1
    local function skip()
        while pos <= #str and str:sub(pos,pos):match("%s") do pos = pos + 1 end
    end
    local parseValue
    local function parseString()
        pos = pos + 1
        local out = {}
        while pos <= #str do
            local c = str:sub(pos,pos)
            if c == '"' then pos = pos + 1; return table.concat(out) end
            if c == "\\" then
                pos = pos + 1
                local e = str:sub(pos,pos)
                local map = {['"']='"',['\\']='\\',['/']='/',b='\b',f='\f',n='\n',r='\r',t='\t'}
                if map[e] then out[#out+1] = map[e]
                elseif e == "u" then
                    local h = str:sub(pos+1,pos+4)
                    local code = tonumber(h,16)
                    if code then
                        if code < 128 then out[#out+1] = string.char(code)
                        elseif code < 2048 then out[#out+1] = string.char(192+math.floor(code/64),128+(code%64))
                        else out[#out+1] = string.char(224+math.floor(code/4096),128+(math.floor(code/64)%64),128+(code%64)) end
                    end
                    pos = pos + 4
                end
            else out[#out+1] = c end
            pos = pos + 1
        end
        error("unterminated string")
    end
    local function parseNumber()
        local start = pos
        while pos <= #str and str:sub(pos,pos):match("[%d%+%-%e%E%.]") do pos = pos + 1 end
        return tonumber(str:sub(start,pos-1))
    end
    local function parseArray()
        pos = pos + 1
        local a = {}
        skip()
        if str:sub(pos,pos) == ']' then pos=pos+1; return a end
        while true do
            a[#a+1] = parseValue()
            skip()
            local c = str:sub(pos,pos)
            if c == ']' then pos=pos+1; return a end
            if c ~= ',' then error("bad array") end
            pos=pos+1; skip()
        end
    end
    local function parseObject()
        pos = pos + 1
        local o = {}
        skip()
        if str:sub(pos,pos) == '}' then pos=pos+1; return o end
        while true do
            skip()
            local k = parseString()
            skip()
            if str:sub(pos,pos) ~= ':' then error("bad object") end
            pos=pos+1; skip()
            o[k] = parseValue()
            skip()
            local c = str:sub(pos,pos)
            if c == '}' then pos=pos+1; return o end
            if c ~= ',' then error("bad object") end
            pos=pos+1
        end
    end
    parseValue = function()
        skip()
        local c = str:sub(pos,pos)
        if c == '"' then return parseString() end
        if c == '{' then return parseObject() end
        if c == '[' then return parseArray() end
        if str:sub(pos,pos+3) == "true" then pos=pos+4; return true end
        if str:sub(pos,pos+4) == "false" then pos=pos+5; return false end
        if str:sub(pos,pos+3) == "null" then pos=pos+4; return nil end
        return parseNumber()
    end
    return parseValue()
end

local function request(url, body)
    local r = gg.makeRequest(url, {
        method = "POST",
        headers = { ["Content-Type"] = "application/json" },
        body = body
    })
    if not r then return nil, "No response" end
    return r
end

local function main()
    local xml, err = readFile(XML_PATH)
    if not xml then gg.alert("فشل قراءة XML:\n" .. tostring(err)); return end

    gg.toast("جاري قراءة البطاقات والأصدقاء...")
    local r = request(ANALYZE, jsonEncode({xml=xml}))
    if not r then gg.alert("فشل الاتصال بالسيرفر"); return end
    if r.code ~= 200 then gg.alert("Analyze HTTP " .. tostring(r.code) .. "\n" .. tostring(r.content)); return end

    local data = jsonDecode(r.content or "{}")
    if not data.ok then gg.alert("خطأ:\n" .. tostring(data.error)); return end

    local friends = data.friends or {}
    if #friends == 0 then
        gg.alert("لم يتم العثور على أصدقاء في XML")
        return
    end

    local menu = {}
    for i,f in ipairs(friends) do
        menu[i] = tostring(f.name or "") .. " | " .. tostring(f.id or "")
    end
    local pick = gg.choice(menu, nil, "اختر الصديق")
    if not pick then return end
    local friend = friends[pick]

    local ok = gg.choice({"إرسال كل البطاقات المتاحة", "إلغاء"}, nil, "الصديق: " .. tostring(friend.name or friend.id))
    if ok ~= 1 then return end

    gg.toast("جاري إرسال " .. tostring(data.distinctCards or 0) .. " بطاقة...")
    local body = jsonEncode({
        xml = xml,
        friend = { id=friend.id, name=friend.name or "", pic=friend.pic or "" }
    })
    local sr = request(SEND, body)
    if not sr then gg.alert("فشل الاتصال أثناء الإرسال"); return end

    local result = jsonDecode(sr.content or "{}")
    if result.ok then
        gg.alert(
            "تم الإرسال\n\n" ..
            "البطاقات: " .. tostring(result.totalCards or 0) .. "\n" ..
            "تم قبولها: " .. tostring(result.sentCards or 0) .. "\n" ..
            "فشل: " .. tostring(result.failed or 0) .. "\n" ..
            "Counter قبل: " .. tostring(result.totalSendCardsBefore or 0) .. "\n" ..
            "Counter بعد: " .. tostring(result.totalSendCardsAfter or 0)
        )
    else
        local msg = "الإرسال لم يكتمل\n\nتم قبول: " .. tostring(result.sentCards or 0) .. "\nفشل: " .. tostring(result.failed or 0)
        if result.error then msg = msg .. "\n" .. tostring(result.error) end
        gg.alert(msg)
    end
end

main()
