if gg.PACKAGE == "com.ssssbbbb" then
--------------------------------------------------
-- 📁 المسارات
--------------------------------------------------
local SAVE_ID_FILE     = "/sdcard/.gg_install_id.txt"
local SAVE_TIME_FILE   = "/sdcard/.gg_activate_time.txt"
local SAVE_LAST_FILE   = "/sdcard/.gg_last_run.txt"
local SAVE_FIRST_RUN   = "/sdcard/.gg_first_run.txt"
local SAVE_WARN_FILE   = "/sdcard/.gg_warned.txt"

--------------------------------------------------
-- ⏳ الإعدادات
--------------------------------------------------
local EXPIRE_DAYS = 10
local EXPIRE_SECONDS = EXPIRE_DAYS * 86400
local TIME_MARGIN = 3600 -- ساعة سماح
local function hiddenSecret()
  local enc = {23,20,6,24,20,31,20,10,6,20,29,16,7,10,14,16,2,10,105,106,105,110}
  local key = 85
  local s = {}
  for i = 1, #enc do
    s[i] = string.char(bit32.bxor(enc[i], key))
  end
  return table.concat(s)
end

local BASE_SECRET = hiddenSecret()

--------------------------------------------------
-- 🔑 SECRET ديناميكي (يتغير كل 20 يوم)
--------------------------------------------------
local function getDynamicSecret()
  local cycle = math.floor(os.time() / EXPIRE_SECONDS)
  return BASE_SECRET .. "_" .. cycle
end

--------------------------------------------------
-- 🔢 Hash (مطابق لأداة التوليد)
--------------------------------------------------
function simpleHash(text)
  local hash = 5381

  for i = 1, #text do
    local c = string.byte(text, i)
    hash = ((hash * 33) ~ c + (c << 5)) % 2147483647
  end

  hash = (hash ~ (hash >> 16)) * 2246822519
  hash = hash % 1000000007

  return tostring(math.abs(hash))
end

--------------------------------------------------
-- 🆔 توليد ID
--------------------------------------------------
function randomID()
  local t = {}
  for i = 1, 16 do
    t[i] = string.format("%x", math.random(0, 15))
  end
  return table.concat(t)
end

--------------------------------------------------
-- ♻️ إعادة ضبط كاملة (كود جديد)
--------------------------------------------------
local function fullReset(msg)
  os.remove(SAVE_TIME_FILE)
  os.remove(SAVE_LAST_FILE)
  os.remove(SAVE_FIRST_RUN)
  os.remove(SAVE_WARN_FILE)
  gg.alert(msg .. "\n\n🔁 تم إنشاء معرف جديد\n📋 انسخه واطلب كودًا جديدًا")
end

--------------------------------------------------
-- 🔒 فحص التلاعب بالتاريخ
--------------------------------------------------
local function checkTimeIntegrity()
  local now = os.time()
  local f = io.open(SAVE_LAST_FILE, "r")

  if f then
    local last = tonumber(f:read("*l"))
    f:close()
    if last and now + TIME_MARGIN < last then
      fullReset("⛔ تم اكتشاف إرجاع التاريخ للخلف")
      os.exit()
    end
  end

  f = io.open(SAVE_LAST_FILE, "w")
  f:write(now)
  f:close()
end

checkTimeIntegrity()

--------------------------------------------------
-- 🆔 Install ID (جهاز فقط)
--------------------------------------------------
local function getInstallID()
  local f = io.open(SAVE_ID_FILE, "r")
  if f then
    local id = f:read("*l")
    f:close()
    return id
  end
  math.randomseed(os.time())
  local id = randomID()
  f = io.open(SAVE_ID_FILE, "w")
  f:write(id)
  f:close()
  return id
end

--------------------------------------------------
-- 💾 وقت التفعيل
--------------------------------------------------
local function saveActivationTime()
  local f = io.open(SAVE_TIME_FILE, "w")
  f:write(os.time())
  f:close()
end

local function getActivationTime()
  local f = io.open(SAVE_TIME_FILE, "r")
  if not f then return nil end
  local t = tonumber(f:read("*l"))
  f:close()
  return t
end

--------------------------------------------------
-- ⛔ فحص الانتهاء
--------------------------------------------------
local function checkExpire()
  local start = getActivationTime()
  if not start then return false end

  local now = os.time()

  if now + TIME_MARGIN < start then
    fullReset("⛔ تم التلاعب بتاريخ الجهاز")
    os.exit()
  end

  if (now - start) > EXPIRE_SECONDS then
    fullReset("⏳ انتهت مدة التفعيل (10يوم)")
    return false
  end

  return true
end

--------------------------------------------------
-- ⏱️ حساب الوقت المتبقي
--------------------------------------------------
local function getRemainingTimeFull()
  local start = getActivationTime()
  if not start then return 0,0,0 end

  local remaining = EXPIRE_SECONDS - (os.time() - start)
  if remaining < 0 then remaining = 0 end

  local d = math.floor(remaining / 86400)
  remaining = remaining % 86400
  local h = math.floor(remaining / 3600)
  remaining = remaining % 3600
  local m = math.floor(remaining / 60)

  return d, h, m
end

--------------------------------------------------
-- 🔍 فحص أولي
--------------------------------------------------
local activated = checkExpire()

--------------------------------------------------
-- 🆔 USER ID (ثابت لكل البرامج)
--------------------------------------------------
local DEVICE_ID = getInstallID()

--------------------------------------------------
-- 🔐 EXPECTED CODE
--------------------------------------------------
local SECRET = getDynamicSecret()
local EXPECTED_CODE = simpleHash(DEVICE_ID .. SECRET)

--------------------------------------------------
-- 🔐 نظام التفعيل
--------------------------------------------------
if not activated then
  gg.setVisible(true)
  while true do
    if gg.isVisible(true) then
      gg.setVisible(false)

      local c = gg.choice({
        "📋 نسخ USER ID",
        "🔑 إدخال كود التفعيل",
        "❌ خروج"
      }, nil,
      "🔐 نظام التفعيل")

      if c == 3 then os.exit() end

      if c == 1 then
        gg.copyText(DEVICE_ID)
        gg.toast("📋 تم نسخ المعرف")

      elseif c == 2 then
        local i = gg.prompt({"🌸تواصل مع الادمن:"},{""},{"text"})
        if i then
          if i[1]:gsub("%s+", "") == EXPECTED_CODE then
            saveActivationTime()
            local f = io.open(SAVE_FIRST_RUN, "w")
            f:write("1")
            f:close()
            gg.toast("✅ تم التفعيل بنجاح")
            break
          else
            gg.alert("❌ كود غير صحيح")
          end
        end
      end
    end
    gg.sleep(200)
  end
end

--------------------------------------------------
-- ⏳ عرض العداد كل تشغيل
--------------------------------------------------
local d, h, m = getRemainingTimeFull()
gg.alert(
  "⏳ الوقت المتبقي:\n\n" ..
  "🗓 " .. d .. " يوم\n" ..
  "⏰ " .. h .. " ساعة\n" ..
  "⏱ " .. m .. " دقيقة"
)

--------------------------------------------------
-- ⚠️ تنبيه عند بقاء يوم واحد
--------------------------------------------------
local warned = io.open(SAVE_WARN_FILE, "r")
if d == 1 and not warned then
  local wf = io.open(SAVE_WARN_FILE, "w")
  wf:write("1")
  wf:close()

  gg.alert(
    "⚠️ تنبيه هام\n\n" ..
    "لم يتبقَّ لكم سوى يوم واحد ⏳\n\n" ..
    "📢 تفاعلوا على منشورات الفيسبوك\n" ..
    "لكي تحصلوا على الرمز الجديد"
  )
end
if warned then warned:close() end

--------------------------------------------------
-- ✅ انتهى نظام التفعيل والحماية
--------------------------------------------------


----------------------------------------------------------------
-- 🔥🔥🔥 هنا تضع سكربتك الخاص 🔥🔥🔥
----------------------------------------------------------------

-- التاريخ فقط
local function getDate()
    return os.date("%Y-%m-%d")
end

-- الوقت فقط (نظام 12 ساعة + رموز)
local function getTime()
    local hour24 = tonumber(os.date("%H")) -- 00 - 23
    local hour12 = tonumber(os.date("%I")) -- 01 - 12
    local min    = os.date("%M")

    local icon
    if hour24 >= 6 and hour24 < 18 then
        icon = "☀️"
    else
        icon = "🌙"
    end

    return string.format("%s %02d:%02d", icon, hour12, min)
end

-- كل أيام الأسبوع بالعربي
local function getDay()
    local days = {
        ["Sunday"]    = "الأحد",
        ["Monday"]    = "الإثنين",
        ["Tuesday"]   = "الثلاثاء",
        ["Wednesday"] = "الأربعاء",
        ["Thursday"]  = "الخميس",
        ["Friday"]    = "الجمعة",
        ["Saturday"]  = "السبت"
    }

    local dayEn = os.date("%A")
    return days[dayEn] or dayEn
end
-- شاشة الترحيب
local function welcome()
    local text = [[
┌─────────────────────
│⚜️ DAY     :☆ ]] .. getDay() .. [[ 
│📅DATE    :☆ ]] .. getDate() .. [[  
│⏰ TIME    :☆ ]] .. getTime() .. [[  
└─────────────────────
 ┏┳┳┓┏━┓─────────┏━━┓┏━┓
 ┃┃┃┃┃━┫┏┓─┏━┓┏━┓┃┃┃┃┃━┫
 ┃┃┃┃┃━┫┃┣┓┃┣┫┃╋┃┃┃┃┃┃━┫
 ┗━━┛┗━┛┗━┛┗━┛┗━┛┗┻┻┛┗━┛
⟣────────§a̶h̶e̶r̶─────────⟢]]

 local c = gg.choice({"🚀 ᑕOᑎTIᑎᑌE", "❌ 乇乂丨ㄒ"}, nil, text)
    if c == 2 then os.exit() end
end
welcome()

basmala = 1 
function basmala()
gg.toast("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ")
SMB = gg.choice({
 "✦✧▬▭فتح التصريح▭▬✧✦", 
 "✦✧▬▭استعادة الهدية▭▬✧✦", 
"✦✧▬▭رفع المستوى عن طريق القَمح▭▬✧✦", 
"✦✧▬▭تبديل الهدية▭▬✧✦", 
"✦✧▬▭تطوير كامل▭▬✧✦", 
"✦✧▬▭تبديل التصريح▭▬✧✦", 
"✦✧▬▭السباق▭▬✧✦", 
"✦✧▬▭اكاديمية الصناعة▭▬✧✦", 
"✦✧▬▭لايــك▭▬✧✦", 
"✦✧▬▭قطارات▭▬✧✦", 
"✦✧▬▭مطار▭▬✧✦", 
"✦✧▬▭زيادة الكروت▭▬✧✦", 
"✦✧▬▭ارسال الكروت▭▬✧✦", 
"✦✧▬▭تصفير الجزر▭▬✧✦", 
"✦✧▬▭إستعادة الهدية نطاقات اخرى▭▬✧✦", 
"✦✧▬▭توسيع الارض دفعه واحده▭▬✧✦",  


"✦✧▬▭❌ 乇乂丨ㄒ❌▭▬✧✦", 

}, nil, " ʚϊɞ╭⊱ꕥ🅂🄰🄷🄴🅁ꕥ⊱╮ ʚϊɞ" .. getTime())
if SMB == nil then else
if SMB == 1 then SMB1() end
if SMB == 2 then SMB2() end
if SMB == 3 then SMB3() end
if SMB == 4 then SMB4() end
if SMB == 5 then SMB5() end
if SMB == 6 then SMB6() end
if SMB == 7 then SMB7() end
if SMB == 8 then SMB8() end
if SMB == 9 then SMB9() end
if SMB == 10 then SMB10() end
if SMB == 11 then SMB11() end
if SMB == 12 then SMB12() end
if SMB == 13 then SMB13() end
if SMB == 14 then SMB14() end
if SMB == 15 then SMB15() end
if SMB == 16 then SMB16() end
if SMB == 17 then EXIT() end
end
THSH = -1
end
function SMB1()
--تصريح--
gg.searchNumber("7374730Eh;65726F63h;00626104h", gg.TYPE_DWORD)
    gg.getResults(10)
    gg.sleep(3000)
    gg.refineNumber("00626104h", gg.TYPE_DWORD)
    tas = gg.getResults(1000)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address + 68
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 1
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])


        local t2 = {}
        t2[1] = {}
        t2[1].address = address +56
        t2[1].flags = gg.TYPE_DWORD
        t2[1].value = 1000
        t2[1].freeze = true
        gg.setValues(t2)
        table.insert(saveList, t2[1])


        local t3 = {}
        t3[1] = {}
        t3[1].address = address +52
        t3[1].flags = gg.TYPE_DWORD
        t3[1].value = 0
        t3[1].freeze = true
        gg.setValues(t3)
        table.insert(saveList, t3[1])
        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("🌘تم فتح التصريح بنجاح🌒")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
  
end

function SMB2()
--إستعادة الهدية--
gg.searchNumber("1935762184;104;65537;1295215888;1701604449;116:329", gg.TYPE_DWORD)
gg.getResults(1000)
gg.sleep(3000)
    gg.refineNumber("1295215888", gg.TYPE_DWORD)
local results = gg.getResults(100)
 
local saveList = {}
for i = 1, #results do
    local addr = results[i].address
 
    -- قراءة القيم المجاورة
    local checkValues = {
        {address = addr - 4, flags = gg.TYPE_DWORD},
        {address = addr - 8, flags = gg.TYPE_DWORD},
        {address = addr - 12, flags = gg.TYPE_DWORD}
    }
 
    checkValues = gg.getValues(checkValues)
 
    local valMinus4 = checkValues[1].value
    local valMinus8 = checkValues[2].value
    local valMinus12 = checkValues[3].value
 
    -- تحقق من الشروط: +8 أقل من 100000، +12 و +16 أكبر من مليار سواء بالسالب أو الموجب
    if valMinus4 < 100000 and math.abs(valMinus8) > 100000000 and math.abs(valMinus12) > 100000000 then
        -- إنشاء العناصر للتعديل والتجميد
        local toFreeze = {
            {address = addr - 4, flags = gg.TYPE_DWORD, value = 0, freeze = true},
            {address = addr - 8, flags = gg.TYPE_DWORD, value = 0, freeze = true},
            {address = addr - 12, flags = gg.TYPE_DWORD, value = 0, freeze = true}
        }
 
        -- تطبيق التعديلات والتجميد
        gg.setValues(toFreeze)
 
        -- إضافة إلى القائمة للحفظ
        for _, item in ipairs(toFreeze) do
            table.insert(saveList, item)
        end
    end
end
 
-- النتيجة النهائية
if #saveList > 0 then
    gg.addListItems(saveList)
    gg.alert("🌘تم إستعادة الهدية بنجاح🌒")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
else
    gg.alert("❌ لم يتم العثور على قيم تطابق الشروط ❌")
        gg.clearResults()
end
end

function SMB3()
--رفع المستوى عن طريق القمح--
gg.searchNumber("6568770Ah;00000019h;42F00000h;00000001h:73", gg.TYPE_DWORD)
    gg.getResults(10)
    gg.sleep(3000)
    gg.refineNumber("1", gg.TYPE_DWORD)
    tas = gg.getResults(10)
 local input = gg.prompt(
        {"🎀ادخل نسبة الاكس بي 🎀"},
        {0},
        {"number"}
    )
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address - 4
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])


        local t2 = {}
        t2[1] = {}
        t2[1].address = address + 12
        t2[1].flags = gg.TYPE_DWORD
        t2[1].value = 0
        gg.setValues(t2)
        table.insert(saveList, t2[1])


        local t3 = {}
        t3[1] = {}
        t3[1].address = address + 16
        t3[1].flags = gg.TYPE_DWORD
        t3[1].value = input[1]
        gg.setValues(t3)
        table.insert(saveList, t3[1])
        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("🌾احصد واحدة فقط🌾")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
 
end

function SMB4()
--تبديل الهدية--
--------------------------------------------------
-- ▶️ البحث الأول
--------------------------------------------------
gg.clearResults()
gg.searchNumber("1295215883X296", gg.TYPE_DWORD)
gg.getResults(100)
gg.sleep(3000)
gg.toast("✅ البحث اكتمل")

--------------------------------------------------
-- ⚙️ دالة التعديل الأساسية (نفس منطقك + إضافة)
--------------------------------------------------
function applyPointer(codeData, manual32)
    local r = gg.getResults(1)
    if #r == 0 then
        gg.alert("❌ لم يتم العثور على المؤشر")
        return
    end

    local base = r[1].address

    -- حفظ القيم الأصلية
    local stored = gg.getValues({
        {address = base - 32, flags = gg.TYPE_DWORD},
    })
    local v32 = stored[1].value

    -- التعديل قبل الانتقال بالمؤشر
    gg.setValues({
        {address = base + 16, flags = gg.TYPE_DWORD, value = codeData.v16 or 25},
        {address = base + 20, flags = gg.TYPE_DWORD, value = codeData.value24 or 0},
        {address = base + 24, flags = gg.TYPE_DWORD, value = v32},
        {address = base + 28, flags = gg.TYPE_DWORD, value = codeData.v28 or 0},
        {address = base + 32, flags = gg.TYPE_DWORD, value = manual32}, -- 👈 إنبوت يدوي
    })

    -- الانتقال من المؤشر
    local pointer = gg.getValues({
        {address = base  + 24, flags = gg.TYPE_DWORD}
    })[1].value

    -- التعديل داخل المؤشر (إن وجد)
    if codeData.pointerValues then
        local edits = {}
        for i = 1, #codeData.pointerValues do
            table.insert(edits, {
                address = pointer + (i - 1) * 4,
                flags = gg.TYPE_DWORD,
                value = codeData.pointerValues[i]
            })
        end
        gg.setValues(edits)
    end

    -- تعديل مباشر بدون مؤشر (إن وجد)
    if codeData.directValues then
        local offsets = {16,20,24,28}
        local edits = {}
        for i = 1, #codeData.directValues do
            table.insert(edits, {
                address = base + offsets[i],
                flags = gg.TYPE_DWORD,
                value = codeData.directValues[i]
            })
        end
        gg.setValues(edits)
    end

    gg.alert("✨🌸إستلم الهديـة27🌸✨")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
    gg.sleep(15000)
end

--------------------------------------------------
-- 📦 البيانات (كما هي)
--------------------------------------------------
local shonaData = {
{
    name = "𓊆 ★ᯓ زيادة نسبة الشونة ᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1113542739,1953722223,1919906899,1130719073,1667330145,7959657,0}
},
{
    name = "𓊆 ★ᯓ تصفير وقت البناءᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1113542739,1953722223,1701146707,1114658148,1684826485,1936158313,0}
},
{
    name = "𓊆 ★ᯓ تصفير وقت الزراعةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1113542739,1953722223,1701146707,1215321444,1702261345,1694528627}
},
{
    name = "𓊆 ★ᯓ تصفير وقت الطائرةᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1113542739,1953722223,1701146707,1097880932,29289}
},
{
    name = "𓊆 ★ᯓ قسـائم التوسيعᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1701147238,1634760773,1869181806,110}
},
{
    name = "𓊆 ★ᯓ قسـائم الدعـمᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1886744387, 1867279983, 1918133345, 1097754977, 1869640297, 1660974194, 1819626752,1919895156}
},
{
    name = "𓊆 ★ᯓ قسـائم السـوقᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1886744387, 1766354543,1698981234,1919249505}
},
{
    name = "𓊆 ★ᯓ قسـائم الشـونةᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1701147238,1633840449,1668172146,6845184}
},
{
    name = "𓊆 ★ᯓ قـسائم ترقيـة المصـانعᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1886744387,1884647023,1684107879,1667319397,2037542772,1912632320,1684889460}
},
{
    name = "𓊆 ★ᯓ قـسائم ترقيـة الجـزرᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1886744387,1884647023,1684107879,1819494757,6581857,1919906915,1090519161}
},
{
    name = "𓊆 ★ᯓ قـسائم ترقيـة القطـاراتᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1886744387,1884647023,1684107879,1634882661,1224765033,7300718}
},
{
    name = "𓊆 ★ᯓ سـبيكة ذهـبᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1684827975,1819047234,1131310953,1953396079,1811968613,1735289188}
},
{
    name = "𓊆 ★ᯓ سـبيكة فضـةᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1986816339,1967288933,1869180012,110}
},
{
    name = "𓊆 ★ᯓ سـبيكةنحاسᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852797506,1967285626,1869180012,1970226030,1919251566}
},
{
    name = "𓊆 ★ᯓ سـبيكة بلاتينᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1952541776,1836412521,1819047234,1131310953,1953396079,570454629}
},
{
    name = "𓊆 ★ᯓ حزمة الكروت🟣ᯓ★ 𓊇",
    value24 = 11,
    pointerValues = {1685217603,1632657219,3500899}
},
{
    name = "𓊆 ★ᯓ الكاشᯓ★ 𓊇",
    directValues = {1935762184,104, 0,0}
},
{
    name = "𓊆 ★ᯓ جواهر حمراءᯓ★ 𓊇",
    directValues = {1835362056,51, 0,0}
},
{
    name = "𓊆 ★ᯓ جواهر صفراءᯓ★ 𓊇",
    directValues = {1835362056, 49, 0,0}
},
{
    name = "𓊆 ★ᯓ جواهر خضراءᯓ★ 𓊇",
    directValues = {1835362056, 50, 0,0}
},
{
    name = "𓊆 ★ᯓ معولᯓ★ 𓊇",
    directValues = {3304708, 0, 0,0}
},
{
    name = "𓊆 ★ᯓ ديناميتᯓ★ 𓊇",
    directValues = {3370244, 0, 0,0}
},
{
    name = "𓊆 ★ᯓ متفجراتᯓ★ 𓊇",
    directValues = {3239172, 0, 0,0}
},
{
        name = "𓊆 ★ᯓ خام نحاس ᯓ★ 𓊇",
        directValues = {3239684,0,0}
    },   
    
    {
        name = "𓊆 ★ᯓ خام فضه ᯓ★ 𓊇",
        directValues = {3370756,0,0}
    },    
    
     {
        name = "𓊆 ★ᯓ خام الذهب ᯓ★ 𓊇",
        directValues = {3305220,0,0}
    },   
    
    {
        name = "𓊆 ★ᯓ خام بلاتين ᯓ★ 𓊇",
        directValues = {3436292,0,0}
    },    
    {
        name = "𓊆 ★ᯓ الطين ᯓ★ 𓊇",
        directValues = {1634493206,1970226041,1919251566} },
{
    name = "𓊆 ★ᯓ مروحـة داخل الحدثᯓ★ 𓊇",
    directValues = {1379101974, 1969779557 , 1701602918}
},
{
    name = "𓊆 ★ᯓ مطرقة ثاقبة داخل الحدثᯓ★ 𓊇",
    directValues = {1295215888, 1701604449 , 116}
},
{
    name = "𓊆 ★ᯓ صاروخ خارج الحدثᯓ★ 𓊇",
    directValues = {1278438668, 6647401, 0}
},
{
    name = "𓊆 ★ᯓ ديناميت خارج الحدثᯓ★ 𓊇",
    directValues = {1110666508, 6450543, 0,0}
},
{
    name = "𓊆 ★ᯓ ضعف نقاط الحدث ᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1701669204, 1953383780, 1383691369,1918990181,1819626852,842492276,1702101040}
},
{
    name = "𓊆 ★ᯓ عملات الحدث ᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1734439492, 1699638895,1867805811, 7234923}
},
{
    name = "𓊆 ★ᯓ الكاتب الاول  ᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1952543859, 2002740597,1702127986,1769144434},noInput32 = true},
{
    name = "𓊆 ★ᯓخرز حدث الازهار  ᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1767993940, 1970227822,2036690546, 1701539668,7536750}},
} 
--الملصقاات
local bs1Data = {
{ name = "𓊆 ★ᯓ بطة البوسه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3486324} ,noInput32 = true},
{ name = "𓊆 ★ᯓ بطة العضلات ᯓ★ 𓊇", directValues = {1869440276,1935632746,3486068},noInput32 = true },
{ name = "𓊆 ★ᯓ بطة هالوين بوسه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3290228} ,noInput32 = true},
{ name = "𓊆 ★ᯓ بطة السيلفي ᯓ★ 𓊇", directValues = {1869440274,1935632746,14704} ,noInput32 = true},
{ name = "𓊆 ★ᯓ بطة القراصنه تطلق النار ᯓ★ 𓊇", directValues = {1869440274,1935632746,12660} ,noInput32 = true},
{ name = "𓊆 ★ᯓ بطة تعلن الاستسلام ᯓ★ 𓊇", directValues = {1869440274,1935632746,14196},noInput32 = true }, 
{ name = "𓊆 ★ᯓ البطة المتنكره ᯓ★ 𓊇", directValues = {1869440276, 1935632746,3355508}, noInput32 = true  },
{ name = "𓊆 ★ᯓ بطتين عيد الحب ᯓ★ 𓊇", directValues = {1869440272,1985964394,50}, noInput32 = true },
{ name = "𓊆 ★ᯓ بطة مسترخيه ᯓ★ 𓊇", directValues = {1869440276, 1935632746,303170}, noInput32 = true },
{ name = "𓊆 ★ᯓ بطة مصاصة الدماء ᯓ★ 𓊇", directValues = {1869440276, 1935632746,3354992}, noInput32 = true },


{ name = "𓊆 ★ᯓ النحلة الراقصه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3223924},noInput32 = true },
{ name = "𓊆 ★ᯓ نحلة الكريسماس ᯓ★ 𓊇", directValues = {1869440276,1935632746,3551604} ,noInput32 = true},
{ name = "𓊆 ★ᯓ النحلة الماهره ᯓ★ 𓊇", directValues = {1869440276,1935632746,3551860} ,noInput32 = true},
{ name = "𓊆 ★ᯓ نحلة عيد الفصح ᯓ★ 𓊇", directValues = {1869440276,1935632746,3158900} ,noInput32 = true},
{ name = "𓊆 ★ᯓ نحلة هالوين ᯓ★ 𓊇", directValues = {1869440276,1935632746,3355764} ,noInput32 = true},
{ name = "𓊆 ★ᯓ النحله الضاحكه ᯓ★ 𓊇", directValues = {1869440274,1935632746,13936} ,noInput32 = true},

-- قسم الفرخة + قسم البقرة (العدد الكلي: 37)

{ name = "𓊆 ★ᯓ الفرخه المشعوذه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3422068} ,noInput32 = true},
{ name = "𓊆 ★ᯓ الفرخه في استراحه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3159924} ,noInput32 = true},
{ name = "𓊆 ★ᯓ الفرخه الساحره ᯓ★ 𓊇", directValues = {1869440276,1935632746,3158388} ,noInput32 = true},
{ name = "𓊆 ★ᯓ فرخه تتزلج على الجليد ᯓ★ 𓊇", directValues = {1869440276,1935632746,3682676} ,noInput32 = true},
{ name = "𓊆 ★ᯓ الفرخه الخبازه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3420788},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخه تسمع الموسيقى ᯓ★ 𓊇", directValues = {1869440276,1935632746,3683188},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخه تودع ᯓ★ 𓊇", directValues = {1869440276,1935632746,3224692},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخه رياضيه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3683444},noInput32 = true },
{ name = "𓊆 ★ᯓ الفرخه الجنيه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3224948},noInput32 = true },
{ name = "𓊆 ★ᯓ الفرخه غمزه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3421556},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخه الحفل ᯓ★ 𓊇", directValues = {1869440276,1935632746,3683700},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخة الاستعراض ᯓ★ 𓊇", directValues = {1869440276,1935632746,3290740},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخه تعزف على اله موسيقيه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3487348},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخه صينيه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3684212},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخة اوكيتو وغمزه ᯓ★ 𓊇", directValues = {1869440274,1935632746,13424},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخة سكرانه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3617392},noInput32 = true },


{ name = "𓊆 ★ᯓ بقرة القراصنه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3487604},noInput32 = true },
{ name = "𓊆 ★ᯓ البقرة على دراجه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3225460},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة تحمل سلة الخضار ᯓ★ 𓊇", directValues = {1869440276,1935632746,3354996},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة في الفضاء ᯓ★ 𓊇", directValues = {1869440276,1935632746,3289716},noInput32 = true },
{ name = "𓊆 ★ᯓ البقرة المغنيه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3224436},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة تشغل النار ᯓ★ 𓊇", directValues = {1869440276,1935632746,3552116},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة مصاص الدماء تاكل فوشار ᯓ★ 𓊇", directValues = {1869440276,1935632746,3159156},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة الكريسماس ᯓ★ 𓊇", directValues = {1869440276,1935632746,3486836},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة القلوب ᯓ★ 𓊇", directValues = {1869440276,1935632746,3617908},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة على المريخ ᯓ★ 𓊇", directValues = {1869440276,1935632746,3159412},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة تحضر الكيك ᯓ★ 𓊇", directValues = {1869440276,1935632746,3487092},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة مصاص الدماء خفاش ᯓ★ ??", directValues = {1869440276,1935632746,3552628},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة على لوح تزلج ᯓ★ 𓊇", directValues = {1869440276,1935632746,3749236},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة عيد الفصح ᯓ★ 𓊇", directValues = {1869440276,1935632746,3356276},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة اعلاميه تصور ᯓ★ 𓊇", directValues = {1869440276,1935632746,3552884},noInput32 = true },
{ name = "𓊆 ★ᯓ البقره الملكه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3683956},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة تشرب الشاي ᯓ★ 𓊇", directValues = {1869440276,1935632746,3618676},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة تعليم الموسيقى ᯓ★ 𓊇", directValues = {1869440276,1935632746,3749748},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة بوسات ᯓ★ 𓊇", directValues = {1869440274,1935632746,12912},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة في السينمه تاكل الفوشار ᯓ★ 𓊇", directValues = {1869440274,1935632746,14192},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة ببرميل قراصنه ᯓ★ 𓊇", directValues = {1869440274,1935632746,3158644},noInput32 = true },
{ name = "𓊆 ★ᯓثلاثي العلكةᯓ★ 𓊇", directValues = {1869440294,1632659818, 1650420579}, noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة الفشار المتنكره ᯓ★ 𓊇", directValues = {1869440276, 1935632746,3159156}, noInput32 = true },
-- قسم الخروف + قسم كلب البحر (العدد الكلي: 26)

{ name = "𓊆 ★ᯓ خروف الهارب ᯓ★ 𓊇", directValues = {1869440276,1935632746,3553140},noInput32 = true },
{ name = "𓊆 ★ᯓ الخروف المصري ᯓ★ 𓊇", directValues = {1869440276,1935632746,3422068},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف الهديه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3290996},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف بالثلج ᯓ★ 𓊇", directValues = {1869440276,1935632746,3617140},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف العازف ᯓ★ 𓊇", directValues = {1869440276,1935632746,3617396},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف يضرب التلفاز ᯓ★ 𓊇", directValues = {1869440276,1935632746,3486580},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف مقلب التنين ᯓ★ 𓊇", directValues = {1869440276,1935632746,3552372},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف مقلب الذئب ᯓ★ 𓊇", directValues = {1869440276,1935632746,3289460},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف بلباس الارنب ᯓ★ 𓊇", directValues = {1869440276,1935632746,3748980},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف ملك ᯓ★ 𓊇", directValues = {1869440276,1935632746,3290484},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف المحقق ᯓ★ 𓊇", directValues = {1869440276,1935632746,3356020},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف الرمايه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3618164},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف على شكل مهرج ᯓ★ 𓊇", directValues = {1869440276,1935632746,3159668},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف يعزف على الجيتار ᯓ★ 𓊇", directValues = {1869440276,1935632746,3421812},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف الفارس ᯓ★ 𓊇", directValues = {1869440276,1935632746,3618420},noInput32 = true },
{ name = "𓊆 ★ᯓ الخروف بوسه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3749492},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف تسريحة الشعر ᯓ★ 𓊇", directValues = {1869440276,1935632746,3160180},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف مفاجأه ᯓ★ 𓊇", directValues = {1869440274,1935632746,12656},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف يقدم العصير ᯓ★ 𓊇", directValues = {1869440274,1935632746,13428},noInput32 = true },


{ name = "𓊆 ★ᯓ كلب البحر مصباح علاء الدين ᯓ★ 𓊇", directValues = {1869440276,1935632746,3682932},noInput32 = true },
{ name = "𓊆 ★ᯓ كلب البحر المطبل ᯓ★ 𓊇", directValues = {1869440276,1935632746,3289972},noInput32 = true },
{ name = "𓊆 ★ᯓ كلب البحر على المسرح ᯓ★ 𓊇", directValues = {1869440276,1935632746,3421300},noInput32 = true },
{ name = "𓊆 ★ᯓ كلب البحر شيطان ᯓ★ 𓊇", directValues = {1869440274,1935632746,13168},noInput32 = true },
{ name = "𓊆 ★ᯓ كلب البحر يضرب راسه ᯓ★ 𓊇", directValues = {1869440274,1935632746,14448},noInput32 = true },
{ name = "𓊆 ★ᯓ كلب البحر يلعب بالنقود ᯓ★ 𓊇", directValues = {1869440274,1935632746,14708},noInput32 = true}, 
{ name = "𓊆 ★ᯓ كلب البحر الودودᯓ★ 𓊇", directValues = {1869440276, 1935632746,3421300},noInput32 = true }, 
{ name = "𓊆 ★ᯓ كلب البحر في عطلةᯓ★ 𓊇", directValues = {1869440276, 1935632746,3551856},noInput32 = true }, 
-- قسم الخنزير (عدد العناصر: 8)


{ name = "𓊆 ★ᯓ خنزير اوكيتو ᯓ★ 𓊇", directValues = {1869440276,1935632746,3420532},noInput32 = true },
{ name = "𓊆 ★ᯓ خنزير على صاروخ ᯓ★ 𓊇", directValues = {1869440276,1935632746,3355252},noInput32 = true },
{ name = "𓊆 ★ᯓ خنزير على القارب ᯓ★ 𓊇", directValues = {1869440276,1935632746,3421044},noInput32 = true },
{ name = "𓊆 ★ᯓ خنزيره تفوز بالجائزه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3748724},noInput32 = true },
{ name = "𓊆 ★ᯓ خنزير يشرب القهوه ᯓ★ 𓊇", directValues = {1869440276,1935632746,3225204},noInput32 = true },
{ name = "𓊆 ★ᯓ خنزير يشم الزهور ᯓ★ 𓊇", directValues = {1869440274,1935632746,13680},noInput32 = true },
{ name = "𓊆 ★ᯓ خنزير المراقبه ᯓ★ 𓊇", directValues = {1869440274,1935632746,3158900},noInput32 = true },
{ name = "𓊆 ★ᯓ خنزير يلعب بالحبل ᯓ★ 𓊇", directValues = {1869440274,1935632746,14452},noInput32 = true }, 
{ name = "𓊆 ★ᯓ خنزير الكونفو ᯓ★ 𓊇", directValues = {1869440276,1935632746,3223920}, noInput32 = true },
{ name = "𓊆 ★ᯓ خنزير ياباني ᯓ★ 𓊇", directValues = {1869440276, 1935632746,3158640}, noInput32 = true },
}
--الصور
local bs2Data = {
    { name = "𓊆 ★ᯓ صوره بروفايل 1 عام ᯓ★ 𓊇", directValues = {1635148044,3748145,0},noInput32 = true },
    { name = "𓊆 ★ᯓ صوره بروفايل 2 عام ᯓ★ 𓊇", directValues = {1635148044,3158577,0},noInput32 = true },
    { name = "𓊆 ★ᯓ صوره بروفايل 3 عام ᯓ★ 𓊇", directValues = {1635148044,3224113,0},noInput32 = true },
    { name = "𓊆 ★ᯓ صوره بروفايل 4 عام ᯓ★ 𓊇", directValues = {1635148044,3289649,0},noInput32 = true },
    { name = "𓊆 ★ᯓ صوره بروفايل 5 عام ᯓ★ 𓊇", directValues = {1635148044,3355185,0},noInput32 = true },
    { name = "𓊆 ★ᯓ صوره بروفايل 6 عام ᯓ★ 𓊇", directValues = {1635148044,3421489,0},noInput32 = true },
    { name = "𓊆 ★ᯓ صوره بروفايل 7 عام ᯓ★ 𓊇", directValues = {1635148044,3225905,0},noInput32 = true},
    { name = "𓊆 ★ᯓ صوره بروفايل 8 عام ᯓ★ 𓊇", directValues = {1635148044,3748658,0},noInput32 = true },
    { name = "𓊆 ★ᯓ صوره بروفايل 9 عام ᯓ★ 𓊇", directValues = {1635148044,3225650,0},noInput32 = true },
    { name = "𓊆 ★ᯓ صوره بروفايل 10 عام ᯓ★ 𓊇", directValues = {1635148044,3354931,0},noInput32 = true },
    { name = "𓊆 ★ᯓ صوره بروفايل 11 عام ᯓ★ 𓊇", directValues = {1635148044,3290675,0},noInput32 = true },

{ name = "𓊆 ★ᯓ صورة بغبغاء ᯓ★ 𓊇", directValues = {1635148044,3617074,0},noInput32 = true },
{ name = "𓊆 ★ᯓ بطة تلقي التحية ᯓ★ 𓊇", directValues = {1635148044,3487537,0},noInput32 = true },
{ name = "𓊆 ★ᯓ كلب يحمل بخاخ ᯓ★ 𓊇", directValues = {1635148044,3422001,0},noInput32 = true },
{ name = "𓊆 ★ᯓ فأر يحمل كيك ᯓ★ 𓊇", directValues = {1635148044,3750193,0},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخة عاملة ᯓ★ 𓊇", directValues = {1635148044,3160113,0},noInput32 = true },
{ name = "𓊆 ★ᯓ حدث الأفعوانية ᯓ★ 𓊇", directValues = {1635148044,3684657,0},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف يحمل خيزرانة ᯓ★ 𓊇", directValues = {1635148044,3684145,0},noInput32 = true },
{ name = "𓊆 ★ᯓ أرنبة ترسم على البيض ᯓ★ 𓊇", directValues = {1635148044,3551538,0},noInput32 = true },
{ name = "𓊆 ★ᯓ أرنبة تضحك ᯓ★ 𓊇", directValues = {1635148044,3224370,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ حمار يضحك ᯓ★ 𓊇", directValues = {1635148044,3289906,0},noInput32 = true },
{ name = "𓊆 ★ᯓ خنزير يأكل 🍭 ᯓ★ 𓊇", directValues = {1635148044,3551794,0},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف عيد الميلاد ᯓ★ 𓊇", directValues = {1635148044,3355953,0},noInput32 = true },
{ name = "𓊆 ★ᯓ ختيار الديسكو ᯓ★ 𓊇", directValues = {1635148044,3224371,0},noInput32 = true },
{ name = "𓊆 ★ᯓ بطة ترتدي معطف ᯓ★ 𓊇", directValues = {1635148044,3617331,0},noInput32 = true },
{ name = "𓊆 ★ᯓ رجل رياضي ᯓ★ 𓊇", directValues = {1635148044,3289651,0},noInput32 = true },
{ name = "𓊆 ★ᯓ شاب يحمل يقطين ᯓ★ 𓊇", directValues = {1635148044,3420467,0},noInput32 = true },
{ name = "𓊆 ★ᯓ امرأة طباخة ᯓ★ 𓊇", directValues = {1635148044,3747891,0},noInput32 = true },
{ name = "𓊆 ★ᯓ كلب فوق رأسه فرخة ᯓ★ 𓊇", directValues = {1635148044,3420211,0},noInput32 = true },
{ name = "𓊆 ★ᯓ شاب احتفال صيني ᯓ★ 𓊇", directValues = {1635148044,3684658,0},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخة صيفية تشرب العصير ᯓ★ 𓊇", directValues = {1635148044,3487027,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ خروف فارس ᯓ★ 𓊇", directValues = {1635148044,3617843,0},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة بالزي الرسمي ᯓ★ 𓊇", directValues = {1635148044,3224627,0},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخة تأكل العنب ᯓ★ 𓊇", directValues = {1635148044,3748659,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ خروف الديسكو ᯓ★ 𓊇", directValues = {1635148044,3486515,0},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة عيد الفصح ᯓ★ 𓊇", directValues = {1635148044,3420979,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ فرخة إيرلندية تحمل برسيم ᯓ★ 𓊇", directValues = {1635148044,3355443,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ خنزير الفوانيس ᯓ★ 𓊇", directValues = {1635148044,3158835,0},noInput32 = true},
{ name = "𓊆 ★ᯓ بغبغاء بعجلة ᯓ★ 𓊇", directValues = {1635148044,3355186,0},noInput32 = true },
{ name = "𓊆 ★ᯓ مهرجان العلكة ᯓ★ 𓊇", directValues = {1635148044,3486258,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ شاب يحمل ميدالية ᯓ★ 𓊇", directValues = {1635148044,3290162,0},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف أنيق ᯓ★ 𓊇", directValues = {1635148044,3158834,0,} ,noInput32 = true},
{ name = "𓊆 ★ᯓ ختيار يحمل بطاقات ᯓ★ 𓊇", directValues = {1635148044,3159858,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ بقرة حمى الحب ᯓ★ 𓊇", directValues = {1635148044,3618866,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ دجاجة رياضية ᯓ★ 𓊇", directValues = {1635148044,3160370,0},noInput32 = true },
{ name = "𓊆 ★ᯓ صقر ᯓ★ 𓊇", directValues = {1635148044,3422258,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ امرأة قرصانة ᯓ★ 𓊇", directValues = {1635148044,3684402,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ بغبغاء آخر ᯓ★ 𓊇", directValues = {1635148044,3749938,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ بنت تحمل دمية لطيفة ᯓ★ 𓊇", directValues = {1635148044,3289907,0},noInput32 = true },
{ name = "𓊆 ★ᯓ رجل رحلة التخييم ᯓ★ 𓊇", directValues = {1635148044,3552051,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ بنت تشرب العصير ᯓ★ 𓊇", directValues = {1635148044,3159091,0},noInput32 = true },
{ name = "𓊆 ★ᯓ ولد إيطالي يأكل البيتزا ᯓ★ 𓊇", directValues = {1635148044,3552307,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ خنزير يشرب العصير ᯓ★ 𓊇", directValues = {1635148044,3355442,0} ,noInput32 = true},
{ name = "𓊆 ★ᯓ بقرة دراكولا ᯓ★ 𓊇", directValues = {1635148044,3159090,0},noInput32 = true },
{ name = "𓊆 ★ᯓ ولد يحمل السمك ᯓ★ 𓊇", directValues = {1635148044,3421234,0},noInput32 = true },
{ name = "𓊆 ★ᯓ ضيف غامض ᯓ★ 𓊇", directValues = {1635148044,3683378,0},noInput32 = true },
{ name = "𓊆 ★ᯓ حمامة الحب ᯓ★ 𓊇", directValues = {1635148044,3290418,0},noInput32 = true },
{ name = "𓊆 ★ᯓ قزم يحمل هدية ᯓ★ 𓊇", directValues = {1635148044,3354673,0},noInput32 = true },
{ name = "𓊆 ★ᯓ عجوز أنيقة ᯓ★ 𓊇", directValues = {1635148044,3682866,0},noInput32 = true },
{ name = "𓊆 ★ᯓ بنت ترتدي قبعة ᯓ★ 𓊇", directValues = {1635148044,3748402,0},noInput32 = true},
{ name = "𓊆 ★ᯓ ولد مصاص دماء ᯓ★ 𓊇", directValues = {1635148044,3420978,0},noInput32 = true },
{ name = "𓊆 ★ᯓ رجل يحمل القمح ᯓ★ 𓊇", directValues = {1635148044,3224626,0},noInput32 = true },
{ name = "𓊆 ★ᯓ بنت تحدي الفضاء ᯓ★ 𓊇", directValues = {1635148044,3486770,0},noInput32 = true },
{ name = "𓊆 ★ᯓ ولد الكريسماس ᯓ★ 𓊇", directValues = {1635148044,3355698,0},noInput32 = true },
{ name = "𓊆 ★ᯓ رجل فرنسي ᯓ★ 𓊇", directValues = {1635148044,3748914,0},noInput32 = true },
{ name = "𓊆 ★ᯓ ملك عربي ᯓ★ 𓊇", directValues = {1635148044,3159346,0},noInput32 = true },
{ name = "𓊆 ★ᯓ بنت عيد الفصح ᯓ★ 𓊇", directValues = {1635148044,3224882,0},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة الشتاء الرياضي ᯓ★ 𓊇", directValues = {1635148044,3486259,0},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف برازيلي ᯓ★ 𓊇", directValues = {1635148044,3551795,0},noInput32 = true},
{ name = "𓊆 ★ᯓ صورة كائن فضائي ᯓ★ 𓊇", directValues = {1635148044,3552563,0},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة أطلانتس ᯓ★ 𓊇", directValues = {1635148044,3159347,0},noInput32 = true },
{ name = "𓊆 ★ᯓ رجل قرصان ᯓ★ 𓊇", directValues = {1635148044,3289394,0},noInput32 = true },
{ name = "𓊆 ★ᯓ خفاش 🦇 ᯓ★ 𓊇", directValues = {1635148044,3749169,0},noInput32 = true },
{ name = "𓊆 ★ᯓ بقرة مهرجان العلكة ᯓ★ 𓊇", directValues = {1635148044,3159601,0},noInput32 = true },
{ name = "𓊆 ★ᯓ ولد استكشاف الجزيرة المفقودة ᯓ★ 𓊇", directValues = {1635148044,3682355,0},noInput32 = true },
{ name = "𓊆 ★ᯓ حيوان أليف ركب الجليد ᯓ★ 𓊇", directValues = {1635148044,3224114,0},noInput32 = true},
{ name = "𓊆 ★ᯓ بنت المكياج ᯓ★ 𓊇", directValues = {1635148044,3422514,0},noInput32 = true },
{ name = "𓊆 ★ᯓ ثعلب يأكل العشب ᯓ★ 𓊇", directValues = {1635148044,3553073,0},noInput32 = true },
{ name = "𓊆 ★ᯓ بنت رسامة ᯓ★ 𓊇", directValues = {1635148044,3618098,0},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخة تحمل فانوس ᯓ★ 𓊇", directValues = {1635148044,3616819,0},noInput32 = true },
{ name = "𓊆 ★ᯓ تمساح صيفي ᯓ★ 𓊇", directValues = {1635148044,3356210,0},noInput32 = true },
{ name = "𓊆 ★ᯓ فرخة مسرحية ᯓ★ 𓊇", directValues = {1635148044,3684146,0,},noInput32 = true },
{ name = "𓊆 ★ᯓ غزالة كريسماس ᯓ★ 𓊇", directValues = {1635148044,3748401,0},noInput32 = true },
{ name = "𓊆 ★ᯓ حيوان أليف كريسماس ᯓ★ 𓊇", directValues = {1635148044,3158833,0},noInput32 = true },
{ name = "𓊆 ★ᯓ حيوان أليف يرتدي معطف ᯓ★ 𓊇", directValues = {1635148044,3224369,0},noInput32 = true },
{ name = "𓊆 ★ᯓ ولد غواص ᯓ★ 𓊇", directValues = {1635148044,3289905,0},noInput32 = true },
{ name = "𓊆 ★ᯓ احتفال الذكرى السنوية العاشرة ᯓ★ 𓊇", directValues = {1635148044,3289395,0},noInput32 = true },
{ name = "𓊆 ★ᯓ خروف بالزي الرسمي ᯓ★ 𓊇", directValues = {1635148044,3354675,0},noInput32 = true },
{ name = "𓊆 ★ᯓ دب رومانسي يعزف ᯓ★ 𓊇", directValues = {1635148044,3422002,0},noInput32 = true },
}

--الديكورات
local bs3Data = {
    {
        name = "𓊆 ★ᯓ أبطال الحديقة الساحرة ᯓ★ 𓊇",
        value24 = 26,
    pointerValues = {1701869637,1769236836,1698983535,1634889571,1852795252,1918988323,12660},noInput32 = true},
    {
        name = "𓊆 ★ᯓ أبطال الحديقة الولد ᯓ★ 𓊇",
        value24 = 26,
    pointerValues = {1701869637,1769236836,1698983535,1634889571,1852795252,1918988323,12916},noInput32 = true },
    {
        name = "𓊆 ★ᯓ أبطال الحديقة البنت ᯓ★ 𓊇",
        value24 = 27,
    pointerValues = {1701869637,1769236836,1698983535,1634889571,1852795252,1935761955,101,0},noInput32 = true },
    {
        name = "𓊆 ★ᯓ ملكة جزيرة السلحفاه ᯓ★ 𓊇",
        value24 = 27,
    pointerValues = {1701869637,1769236836,1698983535,1634889571,1852795252,1634738994,3372146},noInput32 = true },
    {
        name = "𓊆 ★ᯓ حارث الشمال ᯓ★ 𓊇",
        value24 = 27,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1634738995,3241074},noInput32 = true},
    {
        name = "𓊆 ★ᯓ أوديسة القراصنة ᯓ★ 𓊇",
        value24 = 27,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1634738996,3241074} ,noInput32 = true},
    {
        name = "𓊆 ★ᯓ ميجالوث الوحش الثلجي ᯓ★ 𓊇",
        value24 = 27,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1634738997,3241074},noInput32 = true},
    {
        name = "𓊆 ★ᯓ منتجع فندقي أسرار كليوباترا ᯓ★ 𓊇",
        value24 = 27,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1634738998,3241074},noInput32 = true},
    {
        name = "𓊆 ★ᯓ متنزه ترفيهي نباتي ᯓ★ 𓊇",
        value24 = 27,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1634738999,3241074},noInput32 = true},
    {
        name = "𓊆 ★ᯓ متحف مملكة بوسيدون ᯓ★ 𓊇",
        value24 = 27,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1634739000,3241074},noInput32 = true},
    {
        name = "𓊆 ★ᯓ مركز أبحاث الحالات الشاذة الطبيعية ᯓ★ 𓊇",
        value24 = 27,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1634739001,3241074},noInput32 = true},
    -- قصر ذكي
    {
        name = "𓊆 ★ᯓ قصر ذكي ᯓ★ 𓊇",
        value24 = 28,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1881354289,829715041},noInput32 = true},
    -- منزل الغزال الذهبي الريفي
    {
        name = "𓊆 ★ᯓ منزل الغزال الذهبي الريفي ᯓ★ 𓊇",
        value24 = 28,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1881354545,829715041,1818847232},noInput32 = true},
    -- نافورة اللوتس المجمدة
    {
        name = "𓊆 ★ᯓ نافورة اللوتس المجمدة ᯓ★ 𓊇",
        value24 = 28,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1881354801,829715041,1818847232},noInput32 = true},
    -- مسرح باندورا القديم
    {
        name = "𓊆 ★ᯓ مسرح باندورا القديم ᯓ★ 𓊇",
        value24 = 28,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1881355057,829715041},noInput32 = true},
    -- صوبة ملكة الدبابير
    {
        name = "𓊆 ★ᯓ صوبة ملكة الدبابير ᯓ★ 𓊇",
        value24 = 28,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1881355313,829715041},noInput32 = true},
    -- منشأة أبحاث فضائية
    {
        name = "𓊆 ★ᯓ منشأة أبحاث فضائية ᯓ★ 𓊇",
        value24 = 28,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1881355569,829715041},noInput32 = true },
    -- مكتبة الشجرة
    {
        name = "𓊆 ★ᯓ مكتبة الشجرة ᯓ★ 𓊇",
        value24 = 28,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1881355825,829715041},noInput32 = true},
    -- قاعدة التخييم وسط الطبيعة
    {
        name = "𓊆 ★ᯓ قاعدة التخييم وسط الطبيعة ᯓ★ 𓊇",
        value24 = 28,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1881356081,829715041},noInput32 = true},
    -- مقهى كوني
    {
        name = "𓊆 ★ᯓ مقهى كوني ᯓ★ 𓊇",
        value24 = 28,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1881356337,829715041},noInput32 = true},
    -- حديقة أرض القرود المائية
    {
        name = "𓊆 ★ᯓ حديقة أرض القرود المائية ᯓ★ 𓊇",
        value24 = 28,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1881356593,829715041},noInput32 = true},
    -- ملاذ جبلي
    {
        name = "𓊆 ★ᯓ ملاذ جبلي ᯓ★ 𓊇",
        value24 = 28,
    pointerValues  = {1701869637,1769236836,1698983535,1634889571,1852795252,1881354290,829715041},noInput32 = true},
    -- حديقة ترفيهية رائعة
    {
        name = "𓊆 ★ᯓ حديقة ترفيهية رائعة ᯓ★ 𓊇",
        value24 = 28,
    pointerValues = {1701869637,1769236836,1698983535,1634889571,1852795252,1881354546,829715041},noInput32 = true}, 
    {
        name = "𓊆 ★ᯓ سنترال بارك ᯓ★ 𓊇",
        value24 = 23,
    pointerValues   = {1735550285,1698968165,1634889571,1852795252,1634738993,3372146},noInput32 = true},
    -- مركز المجتمع الصيني
    {
        name = "𓊆 ★ᯓ مركز المجتمع الصيني ᯓ★ 𓊇",
        value24 = 23,
    pointerValues   = {1735550285,1698968165,1634889571,1852795252,1634738994,3372146},noInput32 = true},
    -- حديقة بيئية بطابع قوس قزح
    {
        name = "𓊆 ★ᯓ حديقة بيئية بطابع قوس قزح ᯓ★ 𓊇",
        value24 = 23,
    pointerValues   = {1735550285,1698968165,1634889571,1852795252,1634738995,3372146},noInput32 = true},
    -- جولة الزواقة
    {
        name = "𓊆 ★ᯓ جولة الزواقة ᯓ★ 𓊇",
        value24 = 23,
    pointerValues   = {1735550285,1698968165,1634889571,1852795252,1634738996,3372146},noInput32 = true },
    -- المعرض الزراعي
    {
        name = "𓊆 ★ᯓ المعرض الزراعي ᯓ★ 𓊇",
        value24 = 23,
    pointerValues  = {1735550285,1698968165,1634889571,1852795252,1634738997,3306610} ,noInput32 = true },
    -- مجمع رياضي
    {
        name = "𓊆 ★ᯓ مجمع رياضي ᯓ★ 𓊇",
        value24 = 23,
    pointerValues   = {1735550285,1698968165,1634889571,1852795252,1634738998,3306610} ,noInput32 = true  },
    -- عالم البطاريق
    {
        name = "𓊆 ★ᯓ عالم البطاريق ᯓ★ 𓊇",
        value24 = 23,
    pointerValues   = {1735550285,1698968165,1634889571,1852795252,1634738999,3306610},noInput32 = true},
    -- صالة ديسكو كلاسيكية
    {
        name = "𓊆 ★ᯓ صالة ديسكو كلاسيكية ᯓ★ 𓊇",
        value24 = 23,
    pointerValues   = {1735550285,1698968165,1634889571,1852795252,1634739000,3241074},noInput32 = true },
    -- معرض الفنون والحرف اليدوية
    {
        name = "𓊆 ★ᯓ معرض الفنون والحرف اليدوية ᯓ★ 𓊇",
        value24 = 23,
    pointerValues  = {1735550285,1698968165,1634889571,1852795252,1634739001,3241074},noInput32 = true },
    -- موقع مخيم مريح
    {
        name = "𓊆 ★ᯓ موقع مخيم مريح ᯓ★ 𓊇",
        value24 = 24,
    pointerValues   = {1735550285,1698968165,1634889571,1852795252,1881354289,829715041},noInput32 = true},
    -- حفل شاطئي
    {
        name = "𓊆 ★ᯓ حفل شاطئي ᯓ★ 𓊇",
        value24 = 24,
    pointerValues   = {1735550285,1698968165,1634889571,1852795252,1881354545,829715041},noInput32 = true },
    -- قلب إيطاليا
    {
        name = "𓊆 ★ᯓ قلب إيطاليا ᯓ★ 𓊇",
        value24 = 24,
    pointerValues   = {1735550285,1698968165,1634889571,1852795252,1881354801,829715041},noInput32 = true }

}

----الاطارات---

local bs4Data = {
	{
    name = "𓊆 ★ᯓ 🌸الاسم الوردي ᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1348423763, 1768320882,1951622508,1600482425,1953719654,1818326633,980641024},noInput32 = true},
    {
    name = "𓊆 ★ᯓ 🐇اسم عيد الفصح ᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1348423763,1768320882,1951622508,1600482425,1953718629,29285},noInput32 = true},
    	{
    name = "𓊆 ★ᯓ 🔥 الاسم الناري ᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1348423763, 1768320882,1951622508,1600482425,1802465123,6778473},noInput32 = true},
      {
    name = "𓊆 ★ᯓ 💌الاسم النيون ᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1348423763 , 1768320882,1951622508,1600482425,1852794222},noInput32 = true},
    {
    name = "𓊆 ★ᯓ 🌸الإطار الورديᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1348423763,1768320882,1917216108,1600482657,1953719654,1818326633,2019914752,116},noInput32 = true},
 {
        name = "𓊆 ★ᯓ✨ إطار الثروة المتجمدة ᯓ★ 𓊇",
        value24 = 24,
    pointerValues   = {1348423763,1768320882,1917216108,1600482657,1835102822,825253733},noInput32 = true }, 

    {
        name = "𓊆 ★ᯓ🏂 الاطار الجليدي ᯓ★ 𓊇",
        value24 = 24,
    pointerValues   = {1348423763, 1768320882,1917216108,1600482657,1835102822,842030949},noInput32 = true }, 

    {
        name = "𓊆 ★ᯓ🐲إطار التنينᯓ★ 𓊇",
        value24 = 24,
    pointerValues   = {1348423763 , 1768320882,1917216108, 1600482657,1835102822, 858808165},noInput32 = true }, 
{
        name = "𓊆 ★ᯓ 🐇إطار عيد الفصحᯓ★ 𓊇",
        value24 = 24,
    pointerValues   = {1348423763, 1768320882,1917216108,1600482657,1835102822,892362597},noInput32 = true }, 
{
        name = "𓊆 ★ᯓ 🦋إطار الفراشاتᯓ★ 𓊇",
        value24 = 24,
    pointerValues   = {1348423763,1768320882,1917216108,1600482657,1835102822,875585381},noInput32 = true }, 
    {
        name = "𓊆 ★ᯓ🔥إطار ناريᯓ★ 𓊇",
        value24 = 24,
    pointerValues   = {1348423763,1768320882,1917216108,1600482657,1835102822,909139813},noInput32 = true }, 
{
        name = "𓊆 ★ᯓ🎮إطار الالعابᯓ★ 𓊇",
        value24 = 24,
    pointerValues   = {1348423763, 1768320882,1917216108,1600482657,1835102822,925917029},noInput32 = true }, 
}

-- الشارات--
local bs5Data ={
	{
    name = "𓊆 ★ᯓ الاولى ᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1734631778,825253733,1935762015,101},noInput32 = true},
    {
    name = "𓊆 ★ᯓ الثانيةᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1734631778,825253733,1634887519,25710},noInput32 = true},
    {
       name = "𓊆 ★ᯓ جرس1ᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1734631778, 842030949,1634887519,25710},noInput32 = true},
    {
       name = "𓊆 ★ᯓ جرس2ᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1734631778, 842030949,1935762015,101},noInput32 = true},
    {
       name = "𓊆 ★ᯓ بوصلة1 ᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1734631778,858808165,1935762015,101},noInput32 = true},
    {
       name = "𓊆 ★ᯓ بوصلة2ᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1734631778,858808165,1634887519,25710},noInput32 = true},
    {
       name = "𓊆 ★ᯓ الوردة الصفراءᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1734631778, 875585381,1935762015,1726742629},noInput32 = true},
    {
       name = "𓊆 ★ᯓ الوردة الحمراء ᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1734631778, 875585381,1634887519,25710},noInput32 = true},
     {
       name = "𓊆 ★ᯓفلفل اصفر ᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1734631778 , 892362597,1935762015,1073741925},noInput32 = true},
     {
       name = "𓊆 ★ᯓفلفل احمرᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1734631778 , 892362597,1634887519,25710},noInput32 = true},
   } 
--الالقاب--
local bs6Data ={
   {
       name = "𓊆 ★ᯓ سحلية ذهبية ᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1599100997, 1802395986,1597387871,1702060386,1759489792},noInput32 = true},
   {
       name = "𓊆 ★ᯓسفينة ذهبيةᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1599100997, 1802395986,1597453407,1702060386},noInput32 = true},
    {
       name = "𓊆 ★ᯓ سحلية بنفسجية ᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1599100997 , 1802395986,1597453407, 1851880039,100},noInput32 = true},
   {
       name = "𓊆 ★ᯓ سفينة بنفسجيةᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1599100997,1802395986,1597387871,1851880039,983140},noInput32 = true},
    {
       name = "𓊆 ★ᯓخفاش ذهبيᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1599100997, 1802395986, 1597518943,1702060386},noInput32 = true},
{
       name = "𓊆 ★ᯓخفاش بنفسجيᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1599100997 , 1802395986, 1597518943,1851880039,100},noInput32 = true},
    {
       name = "𓊆 ★ᯓسيوف ذهبيةᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1599100997 , 1802395986,1597584479, 1702060386},noInput32 = true},
    {
       name = "𓊆 ★ᯓسيوف بنفسجيةᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1599100997, 1802395986,1597584479,1851880039,1624768612},noInput32 = true},
 {
    name = "𓊆 ★ᯓ قطار ذهبيᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1599100997,1802395986,1596994911,1702060386},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ قطار بنفسجيᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1599100997,1802395986,1596994911,1851880039,2125987940},noInput32 = true}, 
{
    name = "𓊆 ★ᯓالعاصفة الذهبيةᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1599100997,1802395986,1597060447,1702060386},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالعاصفة البنفسجيةᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1599100997,1802395986,1597060447,1851880039,2124152932},noInput32 = true}, 
 }
--لافتات
local bs7Data = {

{
    name = "𓊆 ★ᯓ لافتة مدينة روك ᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402547,1953063775,1769168761,1918856807,1600873327,1852270963},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة العلكة للجميع ᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1852402547,1953063775,1769168761,1918856807,1852403061,1601465953,1751343469,6647401},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة وحش مطاطية ᯓ★ 𓊇",
    value24 = 30,
    pointerValues = {1852402547,1953063775,1769168761,1717530215,1802396018,1818323039,1702326124,28261},noInput32 = true},

{
    name = "𓊆 ★ᯓ علامة المدينة في عيد الميلاد ᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402547,1953063775,1769168761,1667198567,1936290408,1935764852,1734964063,110},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة بطابع عيد الميلاد ᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402547,1953063775,1769168761,1398763111,959930192,1769168688,28263},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة الذكرى السنوية للمدينة ᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1852402547,1953063775,1769168761,1650421351,1752461929,1601790308,1702441009,7565921},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة مزرعة قديمة رائعة ᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402547,1953063775,1769168761,1667198567,1935636335,7235433},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة كشك المشروبات ᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1852402547,1953063775,1769168761,1935634023,1953460077,1650813288,1935635041,7235433},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة تزلج على الجليد للمدينة ᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402547,1953063775,1769168761,1935634023,1651994478,1685217647,1734964063,110},noInput32 = true},

{
    name = "𓊆 ★ᯓ السيد بسكويت الزنجبيل ᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1735289159,1919054437,1298424165,1867017825,1869103988,1634496355,25972},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة مدينة التفاحة الكبيرة ᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402547,1953063775,1769168761,1751084647,1702261345,1935635571,7235433},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة المدينة التي لا تنام ᯓ★ 𓊇",
    value24 = 30,
    pointerValues = {1852402547,1953063775,1769168761,1683975783,1868788585,1953063775,1769168761,28263},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة مدينة ميكانيكية ᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1852402547,1953063775,1769168761,1834970727,1634231141,1600350574,1852270963},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة مدينة بطابع خيالي ᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402547,1953063775,1769168761,1633644135,1768055154,1769168739,28263},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة مدينة ذات مطحنة ᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402547,1953063775,1769168761,1298099815,1399614569,7235433},noInput32 = true},
{
    name = "𓊆 ★ᯓ علامة المدينة الحجرية ᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402547,1953063775,1769168761,1935634023,1701736308,1734964063,110},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة التقاليد القديمة ᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402547,1953063775,1769168761,1633644135,1851877747,1734964063,110},noInput32 = true},

{
    name = "𓊆 ★ᯓ علامة مدينة الأحلام ᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402547,1953063775,1769168761,1767861863,1702260588,1734964063,110},noInput32 = true},

{
    name = "𓊆 ★ᯓ علامة مدينة الأضواء ᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402547,1953063775,1769168761,1985965671,1935763301,1734964063,110},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة مزرعة مريحة ᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402547,1953063775,1769168761,1717530215,1601008225,1852270963},noInput32 = true},

{
    name = "𓊆 ★ᯓ شعار عيد مدينة ᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1852402547,1953063775,1769168761,1650421351,1752461929,1601790308,1852270963},noInput32 = true},

{
    name = "𓊆 ★ᯓ علامة هالوين كبيرة ᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402547,1953063775,1769168761,1751084647,1869376609,1852138871,1734964063,110},noInput32 = true},

{
    name = "𓊆 ★ᯓ علامة مدينة الغرب البري ᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402547,1953063775,1769168761,2002742887,1600416873,1953719671,1734964063,110},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة نيون للمدينة ᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402547,1953063775,1769168761,1851747943,1601072997,1852270963},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة إعلانية ᯓ★ 𓊇",
    value24 = 30,
    pointerValues = {1852402547,1953063775,1769168761,1818193511,1601203553,1918988130,1769168740,28263},noInput32 = true},

{
    name = "𓊆 ★ᯓ علامة المدينة الموسيقية ᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402547,1953063775,1769168761,1834970727,1667855221,1734964063,110},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة المدينة الرائعة ᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402547,1953063775,1769168761,2002742887,1701080943,1769168750,28263},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة المدينة الزهرية ᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402547,1953063775,1769168761,1717530215,1702326124,1684365938,1734964063,110},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة المدينة الفنية ᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402547,1953063775,1769168761,1230990951,1131310962,1400468585,7235433},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة صبار للمدينة ᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402547,1953063775,1769168761,1667198567,1970561889,1769168755,28263},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة طيران للمدينة ᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402547,1953063775,1769168761,2002742887,1701277289,1769168740,28263},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة تحية للمدينة ᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402547,1953063775,1769168761,1885302375,1601006689,1701147252,115},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة معكم على الهواء مباشرة ᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402547,1953063775,1769168761,1415540327,1768120150,1935636852,7235433},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة رائعة للمدينة ᯓ★ 𓊇",
    value24 = 30,
    pointerValues = {1852402547,1953063775,1769168761,1834970727,1769239417,1600938339,1852143205,29556},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة وحش مطاطية ᯓ★ 𓊇",
    value24 = 30,
    pointerValues = {1852402547,1953063775,1769168761,1717530215,1802396018,1818323039,1702326124,28261},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة تزلج على الجليد للمدينة ᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402547,1953063775,1769168761,1935634023,1651994478,1685217647,1734964063,110},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة منزل مريح ᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402547,1953063775,1769168761,1717530215,1768845941,1701999988,1734964063,110},noInput32 = true}, 

}
--زينات--
local bs8Data = {
{
    name = "𓊆 ★ᯓ شجرة الضوء  ᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1852401731,1315271525,1701991513,101},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ نافورة الاصدقاءᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275,1114399081,1953849701,1851875193,1818324329,2003792991,29285},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ قاعة اوديسة القراصنةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701869637,1769236836,1698983535,1634889571,1852795252},noInput32 = true}, 
    {
 name = "𓊆 ★ᯓ بوابة الفايكينجᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701869637,1769236836,1698983535,1634889571,1852795252,12340},noInput32 = true}, 
    {
 name = "𓊆 ★ᯓ شجرة البروكلي ᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275,1114399081,1953849701,1918132089,1916953957},noInput32 = true}, 
    {
 name = "𓊆 ★ᯓ منطاد قبعة الطاهي ᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275,1114399081,1953849701,1751342969,1650419301,1869376609},noInput32 = true}, 
    {
 name = "𓊆 ★ᯓ مذبح باستيت ᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701869637, 1769236836,1698983535,1634889571,1852795252,13364},noInput32 = true}, 
    {
 name = "𓊆 ★ᯓ شجرة الحصادᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1667592275,1114399081,1953849701,1634230137,1936029298,1768316788,1701999975},noInput32 = true},
{
 name = "𓊆 ★ᯓ نافورة المياة المالحةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701869637,1769236836,1698983535,1634889571,1852795252,14132},noInput32 = true}, 
    
{
 name = "𓊆 ★ᯓ منطقة تصوير القراصنةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701869637,1769236836,1698983535,1634889571,1852795252,14644},noInput32 = true}, 
    
{
 name = "𓊆 ★ᯓ مسرح خارجيᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701869637,1769236836,1698983535,1634889571,1852795252,14388},noInput32 = true}, 
    
{
 name = "𓊆 ★ᯓ زيادة أبطال المدينةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1701869637,1769236836,1698983535,1634889571,1852795252},noInput32 = true}, 
    
{
 name = "𓊆 ★ᯓ زيادة تمثال السلحفاهᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701869637,1769236836,1698983535,1634889571,1852795252,268435506},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ زيادة تمثال ابو سيوفᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1701869637,1769236836,1698983535,1634889571,1852795252,13363},noInput32 = true}, 
    
}
--------------------------------------------------
-- 📋 دوال القوائم الفرعية (إضافة الإنبوت فقط)
--------------------------------------------------
function showSubMenu(title, data)
    local menu = {}
    for i,v in ipairs(data) do
        table.insert(menu, v.name)
    end
    table.insert(menu, "👽☠b͢a͢c͢k͢ ☠👽 ")

    local c = gg.choice(menu, nil, title)
    if not c or c > #data then return end

    local manualValue

    if data[c].noInput32 then
        manualValue = 0
    else
        local input = gg.prompt(
            {"🔥اكتب العدد المطلوب استلامه🔥"},
            nil,
            {"number"}
        )
        if input == nil then return end
        manualValue = input[1]
    end

    applyPointer(data[c], manualValue)
    showSubMenu(title, data)
end
--------------------------------------------------
-- 📋 القائمة الرئيسية (كما هي)
--------------------------------------------------
function showMainMenu()
    while true do
        local menu = {
            "✦✧▬▭التبديل ▭▬✧✦",
 "✦✧▬▭الملصقات ▭▬✧✦",
 "✦✧▬▭الصور▭▬✧✦",
  "✦✧▬▭ديكورات▭▬✧✦",
  "✦✧▬▭إطارات▭▬✧✦",
  "✦✧▬▭شارات▭▬✧✦",
    "✦✧▬▭الالقاب▭▬✧✦",
    "✦✧▬▭لافتات▭▬✧✦",
    "✦✧▬▭زينات▭▬✧✦",
  
"🔥ᖇETᑌᖇᑎ TO TᕼE ᗰEᑎᑌ🔥",
        }

         local c = gg.choice(menu, nil, " ʚϊɞ╭⊱ꕥ🅂🄰🄷🄴🅁ꕥ⊱╮ ʚϊɞ".. getTime()) 
             if not c then
            return
        elseif c == 1 then
showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ "..getTime(), shonaData)
   elseif c == 2 then
    showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs1Data) 
     elseif c == 3 then
    showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs2Data) 
    elseif c == 4 then
    showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs3Data) 
      elseif c == 5 then
    showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs4Data) 
       elseif c == 6then
     showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs5Data) 
     elseif c == 7then
       showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs6Data) 
     elseif c == 8then
       showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs7Data) 
     elseif c == 9then
       showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs8Data) 
      elseif c == 10 then
            gg.toast("👋 العودة إلى القائمة الرئيسية")
            basmala()  -- هنا بيرجع للقائمة الرئيسية
            return      -- بيوقف showMainMenu() مؤقتًا
            
        end
    end
end
--------------------------------------------------
-- ▶️ الحلقة الرئيسية لمراقبة GARDEN
--------------------------------------------------
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        showMainMenu()
    end
    gg.sleep(100)
end

gg.toast("ઇଓ تـم الرجـوع للقـائمـة ઇଓ")
end

function SMB5() 
--تطوير شامل--
Sbb = gg.multiChoice({
"𓊆 ★ᯓ تصفير الكاتب الأول ᯓ★ 𓊇",
"𓊆 ★ᯓ فتح المباني الاجتماعية ᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير عدد السكان ᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير أرض الحديقة ᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير طلبات الحديقة ᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير برسيم بيت الحظ ᯓ★ 𓊇",
"𓊆 ★ᯓ زيادة صناديق السوق ᯓ★ ??",
"𓊆 ★ᯓ زيادة صناديق المصانع ᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير مصنع العلف ᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير إطعام البقر وخلافه ᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير مغذي البط ᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير إطعام كلاب البحر ᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير المسبك ᯓ★ 𓊇",
"𓊆 ★ᯓ زيادة عمق المنجم ᯓ★ 𓊇",
"𓊆 ★ᯓ زيادة أيام المعززات بالمختبر ᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير الطلب بالتعاون ᯓ★ 𓊇",
"𓊆 ★ᯓ طلب الزرع بالتعاونᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير طلبات الهيلو ᯓ★ 𓊇",
"𓊆 ★ᯓ فتح إنجازات التعاون ᯓ★ 𓊇",
"𓊆 ★ᯓ زيادة المنتج بالمصنع والشونة ᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير بائع السوق ᯓ★ 𓊇",
"𓊆 ★ᯓ زيادة منتجات البائع ᯓ★ 𓊇",
"𓊆 ★ᯓ فتح المباني الاجتماعية تكبيس ᯓ★ 𓊇", 
"𓊆 ★ᯓ المطابقة الثلاثية ᯓ★ 𓊇", 
"𓊆 ★ᯓ توسيع الاراضيᯓ★ 𓊇",
" 👽☠b͢a͢c͢k͢ ☠👽 ",
  }, nil, " ʚϊɞ╭⊱ꕥ🅂🄰🄷🄴🅁ꕥ⊱╮ ʚϊɞ".. getTime()) 
if Sbb == nil then else
if Sbb[1] == true then Sbb1() end
if Sbb[2] == true then Sbb2() end
if Sbb[3] == true then Sbb3() end
if Sbb[4] == true then Sbb4() end
if Sbb[5] == true then Sbb5() end
if Sbb[6] == true then Sbb6() end
if Sbb[7] == true then Sbb7() end
if Sbb[8] == true then Sbb8() end
if Sbb[9] == true then Sbb9() end
if Sbb[10] == true then Sbb10() end
if Sbb[11] == true then Sbb11() end
if Sbb[12] == true then Sbb12() end
if Sbb[13] == true then Sbb13() end
if Sbb[14] == true then Sbb14() end
if Sbb[15] == true then Sbb15() end
if Sbb[16] == true then Sbb16() end
if Sbb[17] == true then Sbb17() end
if Sbb[18] == true then Sbb18() end
if Sbb[19] == true then Sbb19() end
if Sbb[20] == true then Sbb20() end
if Sbb[21] == true then Sbb21() end
if Sbb[22] == true then Sbb22() end
if Sbb[23] == true then Sbb23() end
if Sbb[24] == true then Sbb24() end
if Sbb[25] == true then Sbb25() end
if Sbb[26] == true then basmala() end
end
THSH = -1
end

function Sbb1()
--تصفير الكاتب الاول--
gg.setVisible(false) 
gg.alert('انتظر قليلا للبحث') 
gg.searchNumber('1900000' .. 'x4' , gg.TYPE_DWORD) 


    gg.getResults(1)
    
    gg.editAll("0", gg.TYPE_DWORD)

local foor = gg.getResults(5) 
if #foor == 0 then
        gg.alert("لم يتم العثور على نتائج.")
      return
    end

local saveList = {}
    for i = 1, #foor do


local t = {}
t[1] = {}
t[1].address = foor[1].address 
t[1].flags = gg.TYPE_DWORD
t[1].value = 0
gg.setValues(t)
gg.addListItems(t)

local t = {}
t[1] = {}
t[1].address = foor[1].address - 4
t[1].flags = gg.TYPE_DWORD
t[1].value = 0
gg.setValues(t)
gg.addListItems(t)
end
gg.alert("اذهب واشتر الكاتب الأول أكثر من مرة ثم اغلق اللعبة وارجع بع منه 🅱️")
gg.clearResults()
gg.toast("✨💗 اللهم صل على  םבםב 💗✨")

gg.clearResults()
end

function Sbb2()
--فتح المباني الاجتماعيه--
gg.searchNumber("696E756Dh;00007974h;00000002h", gg.TYPE_DWORD)
    gg.getResults(1000)
    gg.refineNumber("00000002h", gg.TYPE_DWORD)
    tas = gg.getResults(1000)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address 
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 5
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])

        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("🌹أغلق اللعبة وافتح من جديد🌹")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
   
end

function Sbb3()
--تصفير عدد السكان--
gg. setVisible(false) 
local input = gg.prompt(
        {"🎀 ادخل عدد السكان 🎀"},
        {0},
        {"number"}
    )
    if input == nil then
        gg.toast("لم يتم إدخال قيم. العملية ألغيت.")
        return
    end

gg.searchNumber('616D5312h;704F6C6Ch' .. ';' .. input[1] , gg.TYPE_DWORD) 
gg. refineNumber(input[1], gg.TYPE_DWORD) 
    tas = gg.getResults(10)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address 
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])


        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("🍄 اذهب لفتح جميع الاراضي 🍄 ")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
    
end

function Sbb4()
--تصفير ارض الحديقة--

gg.searchNumber("616D5312h;704F6C6Ch;00006E65h;61593114h ;2D577755h:81", gg.TYPE_DWORD)
    gg.getResults(10)
    gg.sleep(3000)
    gg.refineNumber("616D5312h", gg.TYPE_DWORD)
    tas = gg.getResults(10)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address +72
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])


        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("🌼اذهب لفتح جميع الاراضي🌼 ")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
    
end

function Sbb5()
--تصفير طلبات الحديقة--
gg.searchNumber("40C51800h", gg.TYPE_DWORD)
    gg.getResults(100)
    gg.sleep(3000)
    gg.refineNumber("40C51800h", gg.TYPE_DWORD)
    tas = gg.getResults(100)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address 
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])

end

gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("تم تصفير وقت طلبات حديقة الحيوانات 🦚")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
    
    end
    
function Sbb6()
--تصفير البرسيم--
gg.searchNumber("6F6C630Eh;73726576h;6F6C6312h;42726576h", gg.TYPE_DWORD)
    gg.getResults(100)
    gg.sleep(3000)
    gg.refineNumber("6F6C6312h", gg.TYPE_DWORD)
    tas = gg.getResults(10)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address - 4
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])


        local t2 = {}
        t2[1] = {}
        t2[1].address = address - 8
        t2[1].flags = gg.TYPE_DWORD
        t2[1].value = 0
        t2[1].freeze = true
        gg.setValues(t2)
        table.insert(saveList, t2[1])
        
        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("🍀تم تصفير البرسيم🍀")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
    
end

function Sbb7()
--زيادة عدد صناديق السوق--

gg.searchNumber("3109502975X4", gg.TYPE_DWORD)
    gg.getResults(10)
    gg.sleep(3000)
    gg.refineNumber("1185464320", gg.TYPE_DWORD)
    tas = gg.getResults(10)
  local input = gg.prompt(
        {"🎀ادخل عدد الصناديق🎀"},
        {0},
        {"number"}
    )
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address -92
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = input[1]
        gg.setValues(t1)
        table.insert(saveList, t1[1])


        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("🌷لا تنسى الصلاة على النبيﷺ🌷")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
    
end
function Sbb8() 
--زياده عدد صناديق المصانع--
gg.searchNumber("256;6;28;3080193;65793;65537:1581", gg.TYPE_DWORD)
    gg.getResults(100)
    gg.sleep(3000)
    gg.refineNumber("6" , gg.TYPE_DWORD)
    tas = gg.getResults(10)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address -4
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])


        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("زود صناديق براحتك😉")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
    
end

function Sbb9()
--تصفير مصنع العلف ومنتجاته--

gg.searchNumber("43960000h;44160000h;44960000h;44E10000h;45160000h;453B8000h:433", gg.TYPE_DWORD)
    gg.getResults(1000)
   
    tas = gg.getResults(1000)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address 
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])


        local t2 = {}
        t2[1] = {}
        t2[1].address = address + 12
        t2[1].flags = gg.TYPE_DWORD
        t2[1].value = 0
        t2[1].freeze = true
        gg.setValues(t2)
        table.insert(saveList, t2[1])
        
        local t3 = {}
        t3[1] = {}
        t3[1].address = address + 16
        t3[1].flags = gg.TYPE_DWORD
        t3[1].value = 0
        t3[1].freeze = true
        gg.setValues(t3)
        table.insert(saveList, t3[1])
        
        local t4 = {}
        t4[1] = {}
        t4[1].address = address + 20
        t4[1].flags = gg.TYPE_DWORD
        t4[1].value = 0
        t4[1].freeze = true
        gg.setValues(t4)
        table.insert(saveList, t4[1])
        
        local t5 = {}
        t5[1] = {}
        t5[1].address = address + 24
        t5[1].flags = gg.TYPE_DWORD
        t5[1].value = 0
        t5[1].freeze = true
        gg.setValues(t5)
        table.insert(saveList, t5[1])
        
       
       end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("🍯تم تصفير وقت العلف والمنتجات🍯")
    gg.toast("ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━")
        
end

function Sbb10()
--تصفير حظائر البقر والدجاج والخراف--
gg.clearResults()
gg.setVisible(false)
gg.toast("✨💗 اللهم صل على  םבםב 💗✨")

gg.searchNumber("44960000h;44960000h;45610000h;46610000h;46C4E000h;46A8C000h;468CA000h::801", gg.TYPE_DWORD) 
gg.toast("ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━")
local soso = gg.getResults(100)
    for i = 1, #soso do 
    soso[i].flags = gg.TYPE_DWORD
      soso[i].value = 0
         soso[i].freeze = true
        
        end

gg.setValues(soso)
gg.addListItems(soso)
gg.clearResults()
gg.toast("ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━")

end

function Sbb11()
--تصفير مغذي البط--
gg.clearResults()
gg.setVisible(false)
gg.toast("✨💗 اللهم صل على  םבםב 💗✨")

gg.searchNumber("45A8C000h;45610000h;44E10000h::385", gg.TYPE_DWORD) 
gg.toast("ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━")
local soso = gg.getResults(100)
    for i = 1, #soso do 
    soso[i].flags = gg.TYPE_DWORD
      soso[i].value = 0
         soso[i].freeze = true
        
        end

gg.setValues(soso)
gg.addListItems(soso)
gg.clearResults()
gg.toas("✨💗 اللهم صل على  םבםב 💗✨")

end

function Sbb12()
--تصفير اطعام الكلاب--
gg.clearResults()
gg.setVisible(false)
gg.toast("✨💗 اللهم صل على  םבםב 💗✨")

gg.searchNumber("467D2000h;46610000h;4628C000h::513", gg.TYPE_DWORD) 
gg.toast(" ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━")
local soso = gg.getResults(100)
    for i = 1, #soso do 
    soso[i].flags = gg.TYPE_DWORD
      soso[i].value = 0
         soso[i].freeze = true
        
        end

gg.setValues(soso)
gg.addListItems(soso)
gg.clearResults()
gg.toas("✨?? اللهم صل على  םבםב 💗✨")

end
function Sbb13()
--تصفير المسبك--
gg.searchNumber("45610000h;45E10000h;4628C000h;46610000h::241", gg.TYPE_DWORD)
    gg.getResults(10)
    gg.sleep(3000)
    gg.refineNumber("45610000h", gg.TYPE_DWORD)
    tas = gg.getResults(10)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address 
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])


        local t2 = {}
        t2[1] = {}
        t2[1].address = address + 12
        t2[1].flags = gg.TYPE_DWORD
        t2[1].value = 0
        t2[1].freeze = true
        gg.setValues(t2)
        table.insert(saveList, t2[1])


        local t3 = {}
        t3[1] = {}
        t3[1].address = address + 16
        t3[1].flags = gg.TYPE_DWORD
        t3[1].value = 0
        t3[1].freeze = true
        gg.setValues(t3)
        table.insert(saveList, t3[1])
        
        local t4 = {}
        t4[1] = {}
        t4[1].address = address + 20
        t4[1].flags = gg.TYPE_DWORD
        t4[1].value = 0
        t4[1].freeze = true
        gg.setValues(t4)
        table.insert(saveList, t4[1])
        
        local t5 = {}
        t5[1] = {}
        t5[1].address = address + 48
        t5[1].flags = gg.TYPE_DWORD
        t5[1].value = 0
        t5[1].freeze = true
        gg.setValues(t5)
        table.insert(saveList, t5[1])
        
        local t6 = {}
        t6[1] = {}
        t6[1].address = address + 60
        t6[1].flags = gg.TYPE_DWORD
        t6[1].value = 0
        t6[1].freeze = true
        gg.setValues(t6)
        table.insert(saveList, t6[1])
        
        local t7 = {}
        t7[1] = {}
        t7[1].address = address + 64
        t7[1].flags = gg.TYPE_DWORD
        t7[1].value = 0
        t7[1].freeze = true
        gg.setValues(t7)
        table.insert(saveList, t7[1])
        
        
        local t8 = {}
        t8[1] = {}
        t8[1].address = address + 68
        t8[1].flags = gg.TYPE_DWORD
        t8[1].value = 0
        t8[1].freeze = true
        gg.setValues(t8)
        table.insert(saveList, t8[1])
        
        
        local t9 = {}
        t9[1] = {}
        t9[1].address = address + 96
        t9[1].flags = gg.TYPE_DWORD
        t9[1].value = 0
        t9[1].freeze = true
        gg.setValues(t9)
        table.insert(saveList, t9[1])
        
        local t10 = {}
        t10[1] = {}
        t10[1].address = address + 108
        t10[1].flags = gg.TYPE_DWORD
        t10[1].value = 0
        t10[1].freeze = true
        gg.setValues(t10)
        table.insert(saveList, t10[1])
        
        local t11 = {}
        t11[1] = {}
        t11[1].address = address + 112
        t11[1].flags = gg.TYPE_DWORD
        t11[1].value = 0
        t11[1].freeze = true
        gg.setValues(t11)
        table.insert(saveList, t11[1])
        
        
        local t12 = {}
        t12[1] = {}
        t12[1].address = address + 116
        t12[1].flags = gg.TYPE_DWORD
        t12[1].value = 0
        t12[1].freeze = true
        gg.setValues(t12)
        table.insert(saveList, t12[1])
        
        
        local t13 = {}
        t13[1] = {}
        t13[1].address = address + 144
        t13[1].flags = gg.TYPE_DWORD
        t13[1].value = 0
        t13[1].freeze = true
        gg.setValues(t13)
        table.insert(saveList, t13[1])
        
        local t14 = {}
        t14[1] = {}
        t14[1].address = address + 156
        t14[1].flags = gg.TYPE_DWORD
        t14[1].value = 0
        t14[1].freeze = true
        gg.setValues(t14)
        table.insert(saveList, t14[1])
        
       local t15 = {}
        t15[1] = {}
        t15[1].address = address + 160
        t15[1].flags = gg.TYPE_DWORD
        t15[1].value = 0
        t15[1].freeze = true
        gg.setValues(t15)
        table.insert(saveList, t15[1])
        
        
        local t16 = {}
        t16[1] = {}
        t16[1].address = address + 164
        t16[1].flags = gg.TYPE_DWORD
        t16[1].value = 0
        t16[1].freeze = true
        gg.setValues(t16)
        table.insert(saveList, t16[1])
        
        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("🍇 تم تصفير المسبك بدون الحاجة لخام 🍇")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
    
end

function Sbb14()
--زيادة عمق المنجم--
gg.setVisible(false)
gg.alert('🌺 اللهم صل وسلم وزد وبارك على سيدنا محمد 🌺')
gg.searchNumber("0000000Ah;00000002h;67696414h;676E6967h:41", gg.TYPE_DWORD)
gg.getResults(10)
gg.toast("🌹 saher 🌹") 
gg.sleep("3000")
gg.toast("ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━") 
gg.refineNumber("0000000Ah", gg.TYPE_DWORD)
r = gg.getResults(4)
local input = gg.prompt(
        {" 🎀 ادخل العمق المطلوب للمنجم 🎀"},
        {0},
        {"number"}
    )
    if input == nil then
        gg.toast("لم يتم إدخال قيم. العملية ألغيت.")
        return
    end
local t = {}
t[1] = {}
t[1].address = r[1].address - 4
t[1].flags = gg.TYPE_DWORD
t[1].value = input[1]
gg.setValues(t)
gg.addListItems(t)

gg.clearResults()
gg.alert('🍒 سبحان الله وبحمده سبحان الله العظيم 🍒')



gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
end

function Sbb15()
--زيادة ايام المعززات--
gg.clearResults()
gg.setVisible(false)
gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
gg.searchNumber("0002A300h;0003F480h;00015180h;00001C20h:793",gg.TYPE_DWORD)
gg.toast("🌷 اللهم لك الحمد كما ينبغي لجلال وجهك وعظيم سلطانك 🌷")
local soso = gg.getResults(100)
local input = gg.prompt(
        {"🎀 ادخل الوقت المطلوب 🎀"},
        {0},
        {"number"}
    )
    if input == nil then
        gg.toast("لم يتم إدخال قيم. العملية ألغيت.")
        return
    end
    for i = 1, #soso do 
    soso[i].flags = gg.TYPE_DWORD
      soso[i].value = input[1]
         soso[i].freeze = true
        
        end

gg.setValues(soso)
gg.addListItems(soso)
gg.clearResults()
gg.toast("🍒 اللهم صل وسلم على نبينا محمد وعلى اله واصحابه اجمعين 🍒")

end

function Sbb16()
--تصفير الطلب بالتعاون--
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_CODE_APP)
gg.toast("✨💗 اللهم صل على  םבםב 💗✨")                                
gg.searchNumber("10800;86400", gg.TYPE_DWORD) 
gg.toast("💗 اللهم صل وسلم وبارك على سيدنا محمد 💗")

local soso = gg.getResults(100)
for i = 1, #soso do 
    soso[i].flags = gg.TYPE_DWORD
    soso[i].value = 0
    soso[i].freeze = true
end

gg.setValues(soso)
gg.addListItems(soso)
gg.clearResults()
gg.toast("🌸 تم تصفير طلب التعاون 🌸")

gg.setRanges(gg.REGION_C_ALLOC)
end  

function Sbb17()
--طلب الزرع بالتعاون--
gg.searchNumber("16842755X36", gg.TYPE_DWORD)
gg.getResults(1000)
gg.refineNumber("16842753", gg.TYPE_DWORD)
local tas = gg.getResults(1000)

local input = gg.prompt({"🌱إدخل الرقم🌱"}, {0}, {"number"})
if not input then return end

local saveList = {}

for i = 1, #tas do
    local addr = tas[i].address

    local edits = {
        {address = addr - 4, flags = gg.TYPE_DWORD, value = input[1], freeze = true},
        {address = addr - 8, flags = gg.TYPE_DWORD, value = 0,        freeze = true}
    }

    gg.setValues(edits)
    for _, e in ipairs(edits) do
        table.insert(saveList, e)
    end
end

gg.addListItems(saveList)
gg.clearResults()
gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
end 

function Sbb18()
--تصفير طلبات الهيلو--
gg.searchNumber("00000001h;01010000h;00000064h:25", gg.TYPE_DWORD)
    gg.getResults(100)
    gg.sleep(3000)
    gg.refineNumber("01010000h", gg.TYPE_DWORD)
    tas = gg.getResults(100)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address - 8
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])


        local t2 = {}
        t2[1] = {}
        t2[1].address = address - 4
        t2[1].flags = gg.TYPE_DWORD
        t2[1].value = 0
        t2[1].freeze = true
        gg.setValues(t2)
        table.insert(saveList, t2[1])


        local t3 = {}
        t3[1] = {}
        t3[1].address = address 
        t3[1].flags = gg.TYPE_DWORD
        t3[1].value = 0
        t3[1].freeze = true
        gg.setValues(t3)
        table.insert(saveList, t3[1])
        
        local t4 = {}
        t4[1] = {}
        t4[1].address = address + 4
        t4[1].flags = gg.TYPE_DWORD
        t4[1].value = 0
        t4[1].freeze = true
        gg.setValues(t4)
        table.insert(saveList, t4[1])
        
        
        local t5 = {}
        t5[1] = {}
        t5[1].address = address + 8
        t5[1].flags = gg.TYPE_DWORD
        t5[1].value = 0
        t5[1].freeze = true
        gg.setValues(t5)
        table.insert(saveList, t5[1])
        
        
        local t6 = {}
        t6[1] = {}
        t6[1].address = address + 12
        t6[1].flags = gg.TYPE_DWORD
        t6[1].value = 0
        t6[1].freeze = true
        gg.setValues(t6)
        table.insert(saveList, t6[1])
       
        
         local t7 = {}
        t7[1] = {}
        t7[1].address = address + 16
        t7[1].flags = gg.TYPE_DWORD
        t7[1].value = 0
        t7[1].freeze = true
        gg.setValues(t7)
        table.insert(saveList, t7[1])
         
        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("🪁 تم تصفير جميع طلبات الهيلو قم بحذف الطلبات الحاليه وتجديدها")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
    
end

function Sbb19() 
--انجازات التعاون--
gg.alert("🌸قبل البحث تاكد من انجاز مهمه من كل اشعار🌸")
gg.setVisible(false)

-- القيم المسموح تعديلها
local allowed = {
    [300]=true,
    [400]=true,
    [500]=true,
    [1000]=true,
    [5000]=true,
    [10000]=true
}

-- دالة البحث + التصفية + التعديل فقط
function SearchFilterEdit(pattern)
    gg.clearResults()
    gg.searchNumber(pattern, gg.TYPE_DWORD)

    local results = gg.getResults(10000)
    if #results == 0 then
        return
    end

    local edits = {}

    for i, v in ipairs(results) do
        if allowed[v.value] then
            v.value = 1
            v.flags = gg.TYPE_DWORD
            table.insert(edits, v)
        end
    end

    if #edits > 0 then
        gg.setValues(edits) -- تعديل فقط
    end
end

-- أنماط البحث
local searches = {
    "17;34;300;8:13",
    "18;35;500;2:13",
    "19;36;500;3:13",
    "20;37;400;4:13",
    "21;38;400;5:13",
    "22;39;300::9",
    "23;40;500;9:13",
    "24;41;400;7:13",
    "16;33;500::9",
    "15;32;5000;1:13",
    "14;31;1000;6:13",
    "11;28;10000::9"
}

-- تنفيذ جميع الأبحاث
for i = 1, #searches do
    SearchFilterEdit(searches[i])
end
gg.alert("🌸تم فتح جميع انجازات التعاون🌸")
gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
end

function Sbb20()
--زياده المنتج بالمصنع والشونه--
function editCodesWithX24()
    gg.setVisible(false)

    local codes = {
        "631603722", "620782090", "555369734", "893494792",
        "551199242", "570450442", "713056790", "905563408",
        "687828232", "570844422", "688813832", "684173330"
    }

    for _, code in ipairs(codes) do
        gg.clearResults()
        gg.searchNumber(code .. "x12", gg.TYPE_DWORD)
        local results = gg.getResults(gg.getResultsCount())
        if #results > 0 then
            for i = 1, #results do
                results[i].value = 1
                results[i].freeze = false
            end
            gg.setValues(results)
        end
    end
end

function applyOffsets(address, inputValue)
    local offsets = {
        [4]  = 0,
        [8]  = inputValue,
        [12] = 0,
        [16] = 0,
        [20] = 0,
    }

    local values = {}
    for offset, value in pairs(offsets) do
        table.insert(values, {
            address = address + offset,
            flags = gg.TYPE_DWORD,
            value = value
        })
    end
    gg.setValues(values)
end

function Sbb20(searchValue, inputValue)
    gg.clearResults()
    gg.searchNumber(searchValue, gg.TYPE_FLOAT)
    local results = gg.getResults(gg.getResultsCount())
    if #results == 0 then return end

    for i = 1, #results do
        local addr = results[i].address
        local checks = gg.getValues({
            {address = addr + 4,  flags = gg.TYPE_DWORD},
            {address = addr + 8,  flags = gg.TYPE_DWORD},
        })

        local v1, v2 = checks[1].value, checks[2].value

        -- ✅ التحقق الجديد:
        -- |v1| > 500000 و |v2| > 500000
        -- الفرق بينهم <= 100
        if (math.abs(v1) > 500000 and math.abs(v2) > 500000)
        and (math.abs(v1 - v2) <= 100) then
            gg.setValues({
                {address = addr, flags = gg.TYPE_FLOAT, value = 1.0}
            })
            applyOffsets(addr, inputValue)
        end
    end

    gg.clearResults()
end

function main()
    gg.setVisible(false)
    local input = gg.prompt({"ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ℒℴѵℯ"}, {""}, {"🎰اكتب العدد🎰"})
    if input == nil or tonumber(input[1]) == nil then
        os.exit()
    end
    local inputValue = tonumber(input[1])

    editCodesWithX24()

    local values = {
        300, 600, 900, 1200, 1500, 1800, 2400, 2700, 3000, 3600, 4200, 4500,
        4800, 5400, 6000, 6300, 7200, 8100, 8400, 9000, 9600, 9900,
        10200, 10800, 11400, 12000, 12600, 14400, 16200, 18000, 21600
    }

    for i = 1, #values do
        Sbb20(values[i], inputValue)
    end
    gg.alert("🌺تم تصفير جميع المنتجات🌺")
    gg.toast("ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━")
end
main()
end

function Sbb21()
--تصفير بائع السوق--
gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_CODE_APP)
gg.searchNumber("3600;86400", gg.TYPE_DWORD)
    gg.getResults(100)
    gg.sleep(3000)
    gg.refineNumber("3600", gg.TYPE_DWORD)
    tas = gg.getResults(100)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address 
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])
        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("🍅أُطلب منتجات من البائع على كيفك🥦")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
    gg.setRanges(gg.REGION_C_ALLOC)
end  

function Sbb22()
    -- زيادة منتجات البائع --
    gg.clearResults()

    -- 1️⃣ البحث
    local first = gg.prompt(
        {"🥑اكتب عدد المنتج للبحث 🥑"},
        nil,
        {"number"}
    )
    if not first then
        gg.toast("تم الإلغاء")
        return
    end
    gg.searchNumber(first[1], gg.TYPE_DWORD)
    gg.toast("🌸 يبحث الآن 🌸")

    -- ⏳ انتظر 15 ثانية بعد البحث
    gg.sleep(15000)

    -- 2️⃣ الصقل الأول
    local second = gg.prompt(
        {"🥑اكتب عدد المنتج للصقل الأول 🥑"},
        nil,
        {"number"}
    )
    if not second then
        gg.toast("تم الإلغاء")
        return
    end
    gg.refineNumber(second[1], gg.TYPE_DWORD)
    gg.toast("🥑 تم الصقل الأول 🥑")

    -- ⏳ انتظر 15 ثانية بعد الصقل الأول
    gg.sleep(15000)

    -- 3️⃣ الصقل الثاني
    local third = gg.prompt(
        {"🥑اكتب عدد المنتج للصقل الثاني 🥑"},
        nil,
        {"number"}
    )
    if not third then
        gg.toast("تم الإلغاء")
        return
    end
    gg.refineNumber(third[1], gg.TYPE_DWORD)
    gg.toast("?? تم الصقل الثاني 🥑")

    -- 4️⃣ القيمة المطلوبة
    local valueInput = gg.prompt(
        {"🥑اكتب العدد الذي تريد استلامه 🥑"},
        {1},
        {"number"}
    )
    if not valueInput then
        gg.toast("تم الإلغاء")
        return
    end
    local mainValue = valueInput[1]

    -- 5️⃣ جلب النتائج
    local count = gg.getResultsCount()
    if count == 0 then
        gg.alert("❌ لا توجد نتائج")
        return
    end

    local results = gg.getResults(count)

    -- 🔥 تحديد أكبر قيمة (موجبة أو سالبة)
    local maxAbs = 0
    for _, v in ipairs(results) do
        if math.abs(v.value) > maxAbs then
            maxAbs = math.abs(v.value)
        end
    end

    local freezeList = {}

    -- 6️⃣ تعديل + تجميد أكبر قيمة فقط
    for _, v in ipairs(results) do
        if math.abs(v.value) == maxAbs then
            table.insert(freezeList, {
                address = v.address,
                flags   = gg.TYPE_DWORD,
                value   = mainValue,
                freeze  = true
            })

            table.insert(freezeList, {
                address = v.address - 4,
                flags   = gg.TYPE_DWORD,
                value   = 0,
                freeze  = true
            })
        end
    end

    gg.setValues(freezeList)
    gg.addListItems(freezeList)
    gg.toast("ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━")
    gg.toast("✨💗 استلم منتجات براحتك💗✨")
end

function Sbb23()
-- المباني الاجتماعيه تكبيس --

        gg.clearResults()
    gg.searchNumber("1;1836016402;1768846701;31092:65", gg.TYPE_DWORD)
    gg.refineNumber("1", gg.TYPE_DWORD)

    gg.toast("⏳ انتظري 10 ثواني لاكتشاف القيمة الصحيحة...")
    gg.sleep(10000)

    local results = gg.getResults(1000)
    if #results == 0 then
        gg.alert("❌ لم يتم العثور على أي نتائج")
        return
    end

    local target = nil

    for i, v in ipairs(results) do
        local check = gg.getValues({{address = v.address, flags = gg.TYPE_DWORD}})[1].value
        if check == 0 then
            target = v.address
            break
        end
    end

    if not target then
        gg.alert("❌ لم يتم العثور على قيمة تحولت إلى 0")
        return
    end

    gg.toast("✅ تم العثور على العنوان الصحيح")

    local edits = {
        {address = target + 4, flags = gg.TYPE_DWORD, value = 0, freeze = true},
        {address = target + 8, flags = gg.TYPE_DWORD, value = 0, freeze = true},
        {address = target + 12, flags = gg.TYPE_DWORD, value = 0, freeze = true},
    }

    gg.setValues(edits)
    gg.addListItems(edits)

    gg.alert("✨🌀اكبس على المباني الاجتماعيه لفتحها 🌀✨")

end
function Sbb24()
--المطابقة الثلاثية--
-- البحث
    gg.clearResults()
    gg.searchNumber("65537;296;17;2;65539:129", gg.TYPE_DWORD)
    gg.refineNumber("65539", gg.TYPE_DWORD)

    -- أول نتيجة
    local result = gg.getResults(1)
    if #result == 0 then
        gg.alert("❌ لم يتم العثور على نتيجة")
        return
    end

    -- انبوت القيمة اللي هتتعدل
    local input = gg.prompt(
    {"🎯أدخل العدد الذي تريده🎯"}, 
        {""},
        {"number"}
    )
    if not input then return end

    local newValue = tonumber(input[1])
    if not newValue then
        gg.alert("❌ الرقم غير صحيح")
        return
    end

  
    gg.setValues({
        {
            address = result[1].address -12,
            flags = gg.TYPE_DWORD,
            value = newValue
        }
    })

    gg.toast("✨العب مره اخرى الحدث لتثبيت العدد✨")
end

function Sbb25()
--توسيع الاراضي--
    gg.clearResults()
    gg.searchNumber("1;382;383;384;385;386:27721", gg.TYPE_DWORD)
    gg.refineNumber("386", gg.TYPE_DWORD)

    local results = gg.getResults(50000)
    if #results == 0 then
        gg.alert("❌ لم يتم العثور على نتائج")
        return
    end

    local editOffsets = {4,8,12,16,20,24,28,32,36,40}

    for _, res in ipairs(results) do

        local base386 = res.address

        -- ✅ شرط أساسي: -72 يجب أن تكون 385 حصراً
        local check385 = gg.getValues({
            {address = base386 - 56, flags = gg.TYPE_DWORD}
        })[1].value

        if check385 == 385 then

            local currentBase = base386
            local expectedValue = 386

            while expectedValue >= 1 do

                local valueCheck = gg.getValues({
                    {address = currentBase, flags = gg.TYPE_DWORD}
                })[1].value

                if valueCheck ~= expectedValue then
                    break
                end

                -- التعديل
                local edits = {}
                for _, off in ipairs(editOffsets) do
                    table.insert(edits, {
                        address = currentBase + off,
                        flags = gg.TYPE_DWORD,
                        value = 0
                    })
                end

                gg.setValues(edits)

                -- نصعد -72
                currentBase = currentBase - 56
                expectedValue = expectedValue - 1
            end

        end
    end

    gg.toast("⚡إذهب ووسع جميع الاراضي ⚡")
end

function SMB6()
--تبديل التصريح--
local input = gg.prompt({"🎀 ادخل رقم التصريح القادم 🎀"}, {0}, {"number"})
    
    if not input then
        gg.toast("لم يتم إدخال قيم. العملية ألغيت.")
        return
    end

    gg.clearResults()
    gg.searchNumber("7374730Eh;65726F63h;00626104h;" .. input[1], gg.TYPE_DWORD)
    gg.refineNumber("65726F63h", gg.TYPE_DWORD)
    local results = gg.getResults(100)

    if #results == 0 then
        gg.alert("لا توجد نتائج، يرجى إعادة تشغيل اللعبة والمحاولة مجدداً.")
        return
    end

    local savedValues = {}

    for i, v in ipairs(results) do
        local address = v.address
        for offset = 8, 164, 4 do
            local temp = {}
            temp.address = address + offset
            temp.flags = gg.TYPE_DWORD
            table.insert(savedValues, gg.getValues({temp})[1])
        end
    end

    gg.toast("🎀 القيم تم حفظها بنجاح 🎀")
    
    local input2 = gg.prompt({"🎀 ادخل رقم التصريح الحالي 🎀"}, {0}, {"number"})
    
    if not input2 then
        gg.toast("لم يتم إدخال قيم. العملية ألغيت.")
        return
    end

    gg.clearResults()
    gg.searchNumber("7374730Eh;65726F63h;00626104h;" .. input2[1], gg.TYPE_DWORD)
    gg.refineNumber("65726F63h", gg.TYPE_DWORD)
    local currentResults = gg.getResults(100)

    if #currentResults == 0 then
        gg.alert("لا توجد نتائج، يرجى إعادة تشغيل اللعبة والمحاولة مجدداً.")
        return
    end

    local modifiedValues = {}

    for i, v in ipairs(currentResults) do
        local address = v.address
        for j, val in ipairs(savedValues) do
            local temp = {}
            temp.address = address + (j - 1) * 4 + 8
            temp.flags = gg.TYPE_DWORD
            temp.value = val.value
            table.insert(modifiedValues, temp)
        end
    end

  
     gg.setValues(modifiedValues)
     gg.alert("🌘تم تبديل التصريح بنجاح🌒")
     gg.clearResults()
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
end

 function SMB7()
--السباق--
gg.clearResults()
gg.searchNumber("65538;7200:200", gg.TYPE_DWORD)
gg.refineNumber("65538", gg.TYPE_DWORD)
local results = gg.getResults(10000)

local saveList = {}

for i = 1, #results do
    local res = results[i]

    local val68 = gg.getValues({{address = res.address + 68, flags = gg.TYPE_DWORD}})[1].value
    local val72 = gg.getValues({{address = res.address + 72, flags = gg.TYPE_DWORD}})[1].value

    -- تحقق من الشرط: متشابهات كلياً
    if val68 == val72 then

        -- تعديل +24
        local t1 = {}
        t1[1] = {}
        t1[1].address = res.address + 108
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])

        -- تعديل +28
        local t2 = {}
        t2[1] = {}
        t2[1].address = res.address + 112
        t2[1].flags = gg.TYPE_DWORD
        t2[1].value = 0
        t2[1].freeze = true
        gg.setValues(t2)
        table.insert(saveList, t2[1])

        -- تعديل pointer بعد +352
        local baseAddr = res.address + 200
        local pointerValue = gg.getValues({{address = baseAddr, flags = gg.TYPE_QWORD}})[1].value
        gg.setValues({
            {address = pointerValue, flags = gg.TYPE_DWORD, value = 0},
            {address = pointerValue + 4, flags = gg.TYPE_DWORD, value = 150}
        })
    end
end

if #saveList > 0 then
    gg.addListItems(saveList)
    gg.alert("💯  اذهب للوحه وخذ المهمه 0💯")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
else
    gg.alert("❌ لا توجد نتائج تحقق الشروط.")
end

gg.clearResults()
end

function SMB8()
--اكاديميه الصناعه--
-- جدول مرتب: اسم المستوى بالإيموجي → الكود الخاص به
local levels = {
    ["▄︻〔②〕══━一"] = "32162031",
    ["▄︻〔③〕══━一"] = "32162030",
    ["▄︻〔④〕══━一"] = "32162025",
    ["▄︻〔⑤〕══━一"] = "32162024",
    ["▄︻〔⑥〕══━一"] = "32162027",
    ["▄︻〔⑦〕══━一"] = "32162026",
    ["▄︻〔⑧〕══━一"] = "32162021",
    ["▄︻〔⑨〕══━一"] = "32162020",
    ["▄︻〔⑩〕══━一"] = "32162023",
    ["▄︻〔⑪〕══━一"] = "32162022",
    ["▄︻〔⑫〕══━一"] = "32162017",
    ["▄︻〔⑬〕══━一"] = "32162016",
    ["▄︻〔⑭〕══━一"] = "32162019",
    ["▄︻〔⑮〕══━一"] = "32162018",
    ["▄︻〔⑯〕══━一"] = "32162045",
    ["▄︻〔⑰〕══━一"] = "32162044",
    ["▄︻〔⑱〕══━一"] = "32162047",
    ["▄︻〔⑲〕══━一"] = "32162046",
    ["▄︻〔⑳〕══━一"] = "32162041",
    ["▄︻〔㉑〕══━一"] = "32162040",
    ["▄︻〔㉒〕══━一"] = "32162043",
    ["▄︻〔㉓〕══━一"] = "32162042",
    ["▄︻〔㉔〕══━一"] = "32162037",
    ["▄︻〔㉕〕══━一"] = "32162036",
    ["▄︻〔㉖〕══━一"] = "32162039",
    ["▄︻〔㉗〕══━一"] = "32162038",
    ["▄︻〔㉘〕══━一"] = "32162033",
    ["▄︻〔㉙〕══━一"] = "32162032",
    ["▄︻〔㉚〕══━一"] = "32162035",
    ["▄︻〔㉛〕══━一"] = "32162034",
    ["▄︻〔㉜〕══━一"] = "32161997",
    ["▄︻〔㉝〕══━一"] = "32161996",
    ["▄︻〔㉞〕══━一"] = "32161999",
    ["▄︻〔㉟〕══━一"] = "32161998",
    ["▄︻〔㊱〕══━一"] = "32161993",
    ["▄︻〔㊲〕══━一"] = "32161992",
    ["▄︻〔㊳〕══━一"] = "32161995",
    ["▄︻〔㊴〕══━一"] = "32161994",
    ["▄︻〔㊵〕══━一"] = "32161989",
    ["▄︻〔㊶〕══━一"] = "32161988",
    ["▄︻〔㊷〕══━一"] = "32161991",
    ["▄︻〔㊸〕══━一"] = "32161990",
    ["▄︻〔㊹〕══━一"] = "32161985",
    ["▄︻〔㊺〕══━一"] = "32161984",
    ["▄︻〔㊻〕══━一"] = "32161987",
    ["▄︻〔㊼〕══━一"] = "32161986",
    ["▄︻〔㊽〕══━一"] = "32162013",
    ["▄︻〔㊾〕══━一"] = "32162012",
    ["▄︻〔㊿〕══━一"] = "32162015",
    ["▄︻〔51〕══━一"] = "32162014",
    ["▄︻〔52〕══━一"] = "32162009",
    ["▄︻〔53〕══━一"] = "32162008",
}
-- ترتيب المستوى كما في الجدول الأصلي
local levelOrder = {
    "▄︻〔②〕══━一",
    "▄︻〔③〕══━一",
    "▄︻〔④〕══━一",
    "▄︻〔⑤〕══━一",
    "▄︻〔⑥〕══━一",
    "▄︻〔⑦〕══━一",
    "▄︻〔⑧〕══━一",
    "▄︻〔⑨〕══━一",
    "▄︻〔⑩〕══━一",
    "▄︻〔⑪〕══━一",
    "▄︻〔⑫〕══━一",
    "▄︻〔⑬〕══━一",
    "▄︻〔⑭〕══━一",
    "▄︻〔⑮〕══━一",
    "▄︻〔⑯〕══━一",
    "▄︻〔⑰〕══━一",
    "▄︻〔⑱〕══━一",
    "▄︻〔⑲〕══━一",
    "▄︻〔⑳〕══━一",
    "▄︻〔㉑〕══━一",
    "▄︻〔㉒〕══━一",
    "▄︻〔㉓〕══━一",
    "▄︻〔㉔〕══━一",
    "▄︻〔㉕〕══━一",
    "▄︻〔㉖〕══━一",
    "▄︻〔㉗〕══━一",
    "▄︻〔㉘〕══━一",
    "▄︻〔㉙〕══━一",
    "▄︻〔㉚〕══━一",
    "▄︻〔㉛〕══━一",
    "▄︻〔㉜〕══━一",
    "▄︻〔㉝〕══━一",
    "▄︻〔㉞〕══━一",
    "▄︻〔㉟〕══━一",
    "▄︻〔㊱〕══━一",
    "▄︻〔㊲〕══━一",
    "▄︻〔㊳〕══━一",
    "▄︻〔㊴〕══━一",
    "▄︻〔㊵〕══━一",
    "▄︻〔㊶〕══━一",
    "▄︻〔㊷〕══━一",
    "▄︻〔㊸〕══━一",
    "▄︻〔㊹〕══━一",
    "▄︻〔㊺〕══━一",
    "▄︻〔㊻〕══━一",
    "▄︻〔㊼〕══━一",
    "▄︻〔㊽〕══━一",
    "▄︻〔㊾〕══━一",
    "▄︻〔㊿〕══━一",
    "▄︻〔51〕══━一",
    "▄︻〔52〕══━一",
    "▄︻〔53〕══━一"
}
-- القائمة الرئيسية
function mainMenu()
    -- إعداد القائمة
    local menuOptions = {}
    for i, v in ipairs(levelOrder) do
        table.insert(menuOptions, v)  -- أضف كل المستويات أولاً
    end
    table.insert(menuOptions, "🔥ᖇETᑌᖇᑎ TO TᕼE ᗰEᑎᑌ🔥")  -- خيار الرجوع في آخر القائمة

    -- عرض القائمة
    local choice = gg.choice(menuOptions, nil, " ʚϊɞ╭⊱ꕥ🅂🄰🄷🄴🅁ꕥ⊱╮ ʚϊɞ".. getTime()) 
    if choice == nil then
        gg.toast("❌ تم الإلغاء.")
        return
    end

    -- التحقق من خيار الرجوع
    if choice == #menuOptions then  -- آخر عنصر في القائمة
        gg.toast("🔥ᖇETᑌᖇᑎ TO TᕼE ᗰEᑎᑌ🔥")
        basmala()  -- ترجع لدالة basmala
        return
    end

    -- التعامل مع اختيار مستوى
    local selectedName = levelOrder[choice]  -- هنا الاختيار مباشر بدون -1
    local selectedCode = levels[selectedName]
    modifyCode(selectedName, selectedCode)
end

-- دالة التعديل
function modifyCode(levelName, code)
    gg.setVisible(false)
    gg.clearResults()
    gg.searchNumber(code .. 'x4', gg.TYPE_DWORD)
    local tas = gg.getResults(1000)

    local input = gg.prompt(
        {"⌛ أدخل نسبة تقليل الوقت لـ " .. levelName},
        {0},
        {"number"}
    )
    if input == nil then
        return
    end

    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {{address = address + 20, flags = gg.TYPE_DWORD, value = 0}}
        local t2 = {{address = address + 24, flags = gg.TYPE_DWORD, value = input[1]}}

        gg.setValues(t1)
        gg.setValues(t2)

        table.insert(saveList, t1[1])
        table.insert(saveList, t2[1])
    end

    gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("✅ تم تعديل " .. levelName)
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
end

-- تشغيل القائمة
mainMenu()
end

function SMB9()
    -- لايك --
    gg.setVisible(false)
    gg.setRanges(gg.REGION_OTHER)

    gg.searchNumber("600;1800;33;27:97", gg.TYPE_DWORD)
    gg.getResults(10)
    gg.sleep(3000)
    gg.refineNumber("600", gg.TYPE_DWORD)

    local tas = gg.getResults(1000)
    if #tas == 0 then
        gg.alert("❌ لم يتم العثور على نتائج")
        return
    end

    local saveList = {}

    for i = 1, #tas do
        local address = tas[i].address

        -- أوفست -44
        table.insert(saveList, {
            address = address - 44,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        })

        -- أوفست -40
        table.insert(saveList, {
            address = address - 40,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        })
        
    end

    gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()

    gg.alert("🌀 ادخل أي مدينة واعملها لايك 🌀")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
    gg.setRanges(    gg.REGION_C_ALLOC  )
end
 function SMB10()
--قطارات--
SSbb= gg.multiChoice({
"🚄تصفيرصناديق القطار🚄",
"🚄طلب مساعدة القمح🚄",
"🚄إرسال البرسيم بعدد لا نهائي🚄",
"🚄طلب دعم🚄",
"🚄طلب تاج🚄",
" 👽☠b͢a͢c͢k͢ ☠👽 ",
  }, nil, "ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ℒℴѵℯ".. getTime()) 
if SSbb == nil then else
if SSbb[1] == true then SSbb1() end
if SSbb[2] == true then SSbb2() end
if SSbb[3] == true then SSbb3() end
if SSbb[4] == true then SSbb4() end
if SSbb[5] == true then SSbb5() end
if SSbb[6] == true then basmala() end
end
THSH = -1
end

function SSbb1()
--تصفير صناديق القطار--
gg.setVisible(false) -- إخفاء الواجهة عند تشغيل السكربت

function SSbb1(value)
    gg.clearResults() 
    gg.searchNumber(value, gg.TYPE_FLOAT)   
    local tas = gg.getResults(100)
    
    if #tas == 0 then
        
        return
    end

    local saveList = {}

    for i = 1, #tas do
        local address = tas[i].address
        local offsets = {0,  -264, -456, -648, -840, -1032,} 
        local types = {gg.TYPE_FLOAT, gg.TYPE_DWORD, gg.TYPE_DWORD, gg.TYPE_DWORD, gg.TYPE_DWORD, gg.TYPE_DWORD}
        
local checks = gg.getValues({
            {address = address  - 1028, flags = gg.TYPE_DWORD},
            {address = address  - 1024, flags = gg.TYPE_DWORD}
        })

        if checks[1].value == 25 and checks[2].value > 18 then
            for j = 1, #offsets do
                local t = {}
                t.address = address + offsets[j]
                t.flags = types[j]
                t.value = 1
                t.freeze = true
                
                gg.setValues({t})
                table.insert(saveList, t)
            end
        end
    end

    gg.clearResults()
    gg.addListItems(saveList)
    
end

-- تشغيل الدالة مباشرة عند بدء السكربت لكل القيم المحددة
local values = {15900, 15300, 15000, 15600, 14400, 16200, 16500, 16800, 17100, 17400, 17700, 18000, 14700,}
for i = 1, #values do
    SSbb1(values[i])
end
gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
gg.alert("🎯 البحث اكتمل!")
end


function SSbb2()
--طلب مساعدة القمح--
function SSbb2(value)
    -- فحص احتياطي
    if value == nil then
        gg.toast("SSbb2 تمرير قيمة صحيحة للدالة SSbb2")
        return
    end

    gg.setVisible(false)
    gg.toast("🔍 جاري البحث...")

    local function freezeOffsets(address)
        local saveList = {}

        local offsetsToFreeze = {
-- دول تبع اعادة القطار بدون ادوات
 -4,-8,-12,-16,-20,-24,-28,-32,-36,-40,-44,-48,-52,-56,-60,-64,-68,-72,-76,-80,-84,-88,-92,-96,-100,
-- قيم الطلب بالقطار--
 -248, -440, -632, -824, -1016,    
--قيم عدد المنتج
-276 ,-280, -468, -472, -660, -664, -852, -856, -1044, -1048,
--تعديل المنتج الى قمح
-288, -292,  -480, -484, -672, -676, -864,-868,-1056,-1060,   
        }

        local customValues = {
        	--اعاده تعين القطار بلا ادوات--
            [-4]=0,
            [-8]=0,
            [-12]=0,
            [-16]=0,
            [-20]=0,
            [-24]=0,
            [-28]=0,
            [-32]=0,
            [-36]=0,
            [-40]=0,
            [-44]=0,
            [-48]=0,
            [-52]=0,
            [-56]=0,
            [-60]=0,
            [-64]=0,
            [-68]=0,
            [-72]=0,
            [-76]=0,
            [-80]=0,
            [-84]=0,
            [-88]=0,
            [-92]=0,
            [-96]=0,
            [-100]=0, 
-- قيم الطلب بالقطار 

--صندوق اول     
            [-248]=1,
--صندوق ثاني              
            [-440]=1,
--صندوق ثالث              
            [-632]=1,
--صندوق رابع            
            [-824]=1,  
--صندوق خامس                  
            [-1016]=1,
            
            
--قيم عدد المنج  

--صندوق اول              
            [-276]=1,
            [-280]=0,
--صندوق ثاني              
            [-468]=1,
            [-472]=0,  
--صندوق ثالث                               
            [-660]=1,
            [-664]=0, 
--صندوق رابع                      
            [-852]=1,
            [-856]=0,  
                
--صندوق خامس                       
            [-1044]=1,
            [-1048]=0,            
            
---تعديل المنتج الى قمح  
--صندوق اول          
            [-288]=29793,
            [-292]=1701345034,
            
--صندوق ثاني           
            [-480]=29793,
            [-484]=1701345034,
            
--صندوق ثالث            
            [-672]=29793,
            [-676]=1701345034,
            
--صندوق رابع            
            [-864]=29793,
            [-868]=1701345034,
   
--صندوق خامس
            [-1056]=29793,
            [-1060]=1701345034,
            
        }

        -- تجميد الأوفستات الرئيسية
        for i = 1, #offsetsToFreeze do
            local offset = offsetsToFreeze[i]
            local addr   = address + offset
            local val    = customValues[offset]
            if val ~= nil then
                local item = {
                    address    = addr,
                    flags      = gg.TYPE_DWORD,
                    value      = val,
                    freeze     = true,
                    freezeType = gg.FREEZE_NORMAL
                }
                gg.setValues({item})
                table.insert(saveList, item)
            end
        end
        -- أوفستات تُعدَّل مرة واحدة فقط
        local modifyOnlyOffsets = { -264, -456, -648, -840, -1032,}
        for i = 1, #modifyOnlyOffsets do
            local addr = address + modifyOnlyOffsets[i]
            gg.setValues({
                {
                    address = addr,
                    flags   = gg.TYPE_DWORD,
                    value   = 1
                }
            })
        end

        return saveList
    end

    -- البحث عن القيمة
    gg.clearResults()
    gg.searchNumber(value, gg.TYPE_FLOAT)
    local results = gg.getResults(100)

    if #results == 0 then
        gg.toast("⚠️ لم يتم العثور على أي قيم لـ " .. value)
        return
    end

    local saveList = {}

    for i = 1, #results do
        local address = results[i].address

local checks = gg.getValues({
            {address = address  - 1008, flags = gg.TYPE_DWORD},
            {address = address  - 1004, flags = gg.TYPE_DWORD}
        })

        if checks[1].value == 25 and checks[2].value > 18 then
            -- تجميد القيمة الأساسية
             local t = {
                address    = address,
                flags      = gg.TYPE_FLOAT,
                value      = 1.0,
                freeze     = true,
                freezeType = gg.FREEZE_NORMAL
            }
            gg.setValues({t})
            table.insert(saveList, t)

            -- تجميد بقية الأوفستات المرتبطة
            local frozen = freezeOffsets(address)
            for j = 1, #frozen do
                table.insert(saveList, frozen[j])
            end
        end
    end

    gg.clearResults()
    gg.addListItems(saveList)
    gg.toast("✅ تم التعديل والتجميد بنجاح!")
end

-- قائمة القيم المطلوب البحث عنها وتطبيق التعديلات عليها
local values = {
    15900, 15300, 15000, 15600, 14400,
    16200, 16500, 16800, 17100, 17400,
    17700, 18000, 14700
}

for i = 1, #values do
    SSbb2(values[i])


gg.toast("🎯 البحث اكتمل بنجاح!")
end
end


function SSbb3() 
--ارسال البرسيم قطارات--
function SSbb3(value)
    -- فحص احتياطي
    if value == nil then
        gg.toast("SSbb3تمرير قيمة صحيحة للدالة SSbb3")
        return
    end

    gg.setVisible(false)
    gg.toast("🔍 جاري البحث...")

    local function freezeOffsets(address)
        local saveList = {}

        local offsetsToFreeze = {
-- دول تبع اعادة القطار بدون ادوات
 -4,-8,-12,-16,-20,-24,-28,-32,-36,-40,-44,-48,-52,-56,-60,-64,-68,-72,-76,-80,-84,-88,-92,-96,-100,-104,
-- قيم الطلب بالقطار--
 -248, -440, -632, -824, -1016,    
--قيم عدد المنتج
-276 ,-280, -468, -472, -660, -664, -852, -856, -1044, -1048,
--تعديل المنتج الى قمح
-288, -292,  -480, -484, -672, -676, -864,-868,-1056,-1060,   
--البرسيم
-180, -372, -564, -756, -948,
}

           local customValues = {
 -- دول تبع اعادة القطار بدون ادوات       
            [-4]=0,
            [-8]=0,
            [-12]=0,
            [-16]=0,
            [-20]=0,
            [-24]=0,
            [-28]=0,
            [-32]=0,
            [-36]=0,
            [-40]=0,
            [-44]=0,
            [-48]=0,
            [-52]=0,
            [-56]=0,
            [-60]=0,
            [-64]=0,
            [-68]=0,
            [-72]=0,
            [-76]=0,
            [-80]=0,
            [-84]=0,
            [-88]=0,
            [-92]=0,
            [-96]=0,
            [-100]=0,  
            [-104]=0,  

            
            
            
-- قيم الطلب بالقطار 

--صندوق اول     
            [-248]=1,
--صندوق ثاني              
            [-440]=1,
--صندوق ثالث              
            [-632]=1,
--صندوق رابع            
            [-824]=1,  
--صندوق خامس                  
            [-1016]=1,
            
            
--قيم عدد المنج  

--صندوق اول              
            [-276]=1,
            [-280]=0,
--صندوق ثاني              
            [-468]=1,
            [-472]=0,  
--صندوق ثالث                               
            [-660]=1,
            [-664]=0, 
--صندوق رابع                      
            [-852]=1,
            [-856]=0,  
                
--صندوق خامس                       
            [-1044]=1,
            [-1048]=0,            
            
---تعديل المنتج الى قمح  
--صندوق اول          
            [-288]=29793,
            [-292]=1701345034,
            
--صندوق ثاني           
            [-480]=29793,
            [-484]=1701345034,
            
--صندوق ثالث            
            [-672]=29793,
            [-676]=1701345034,
            
--صندوق رابع            
            [-864]=29793,
            [-868]=1701345034,
   
--صندوق خامس
            [-1056]=29793,
            [-1060]=1701345034,
           
--البرسيم

    -- صندوق أول
    [-180] = 0,

    -- صندوق ثاني
    [-372] = 0,

    -- صندوق ثالث
    [-564] = 0,

    -- صندوق رابع
    [-756] = 0,

    -- صندوق خامس
    [-948] = 0,
}

        -- تجميد الأوفستات الرئيسية
        for i = 1, #offsetsToFreeze do
            local offset = offsetsToFreeze[i]
            local addr   = address + offset
            local val    = customValues[offset]
            if val ~= nil then
                local item = {
                    address    = addr,
                    flags      = gg.TYPE_DWORD,
                    value      = val,
                    freeze     = true,
                    freezeType = gg.FREEZE_NORMAL
                }
                gg.setValues({item})
                table.insert(saveList, item)
            end
        end

        -- أوفستات تُعدَّل مرة واحدة فقط
        local modifyOnlyOffsets = { -264, -456, -648, -840, -1032,}
        for i = 1, #modifyOnlyOffsets do
            local addr = address + modifyOnlyOffsets[i]
            gg.setValues({
                {
                    address = addr,
                    flags   = gg.TYPE_DWORD,
                    value   = 1
                }
            })
        end

        return saveList
    end

    -- البحث عن القيمة
    gg.clearResults()
    gg.searchNumber(value, gg.TYPE_FLOAT)
    local results = gg.getResults(100)

    if #results == 0 then
        gg.toast("⚠️ لم يتم العثور على أي قيم لـ " .. value)
        return
    end

    local saveList = {}

    for i = 1, #results do
        local address = results[i].address

local checks = gg.getValues({
          {address = address  - 1028, flags = gg.TYPE_DWORD},
            {address = address  - 1024, flags = gg.TYPE_DWORD}
        })

        if checks[1].value == 25 and checks[2].value > 18 then
            -- تجميد القيمة الأساسية
            local t = {
                address    = address,
                flags      = gg.TYPE_FLOAT,
                value      = 1.0,
                freeze     = true,
                freezeType = gg.FREEZE_NORMAL
            }
            gg.setValues({t})
            table.insert(saveList, t)

            -- تجميد بقية الأوفستات المرتبطة
            local frozen = freezeOffsets(address)
            for j = 1, #frozen do
                table.insert(saveList, frozen[j])
            end
        end
    end

    gg.clearResults()
    gg.addListItems(saveList)
    gg.toast("✅ تم التعديل والتجميد بنجاح!")
end

-- قائمة القيم المطلوب البحث عنها وتطبيق التعديلات عليها
local values = {
    15900, 15300, 15000, 15600, 14400,
    16200, 16500, 16800, 17100, 17400,
    17700, 18000, 14700
}

for i = 1, #values do
    SSbb3(values[i])

gg.toast("🌱😉ارسل برسيم براحتك😌🌱")
end
end


function SSbb4()
--طلب مساعده الجزر--
function SSbb4(value)
    -- فحص احتياطي
    if value == nil then
        gg.toast("SSbb4 تمرير قيمة صحيحة للدالة SSbb4")
        return
    end

    gg.setVisible(false)
    gg.toast("🔍 جاري البحث...")

    local function freezeOffsets(address)
        local saveList = {}

        local offsetsToFreeze = {
-- دول تبع اعادة القطار بدون ادوات
 -4,-8,-12,-16,-20,-24,-28,-32,-36,-40,-44,-48,-52,-56,-60,-64,-68,-72,-76,-80,-84,-88,-92,-96,-100,-104,
-- قيم الطلب بالقطار--
 -248, -440, -632, -824, -1016,    
--قيم عدد المنتج
-276 ,-280, -468, -472, -660, -664, -852, -856, -1044, -1048,
--تعديل المنتج الى جزر 
-288, -292,  -480, -484, -672, -676, -864,-868,-1056,-1060,}
              local customValues = {
 -- دول تبع اعادة القطار بدون ادوات       
            [-4]=0,
            [-8]=0,
            [-12]=0,
            [-16]=0,
            [-20]=0,
            [-24]=0,
            [-28]=0,
            [-32]=0,
            [-36]=0,
            [-40]=0,
            [-44]=0,
            [-48]=0,
            [-52]=0,
            [-56]=0,
            [-60]=0,
            [-64]=0,
            [-68]=0,
            [-72]=0,
            [-76]=0,
            [-80]=0,
            [-84]=0,
            [-88]=0,
            [-92]=0,
            [-96]=0,
            [-100]=0,
            [-104]=0,
            

            
-- قيم الطلب بالقطار 

--صندوق اول     
            [-248]=1,
--صندوق ثاني              
            [-440]=1,
--صندوق ثالث              
            [-632]=1,
--صندوق رابع            
            [-824]=1,  
--صندوق خامس                  
            [-1016]=1,
            
            
--قيم عدد المنج  

--صندوق اول              
            [-276]=9999,
            [-280]=0,
--صندوق ثاني              
            [-468]=9999,
            [-472]=0,  
--صندوق ثالث                               
            [-660]=9999,
            [-664]=0, 
--صندوق رابع                      
            [-852]=9999,
            [-856]=0,  
                
--صندوق خامس                       
            [-1044]=9999,
            [-1048]=0,            
            
            
--تعديل المنتج الى جزر     
--صندوق اول          
            [-288]=7630706,
            [-292]=1918984972,
            
--صندوق ثاني           
            [-480]=7630706,
            [-484]=1918984972,
            
--صندوق ثالث            
            [-672]=7630706,
            [-676]=1918984972,
            
--صندوق رابع            
            [-864]=7630706,
            [-868]=1918984972,
            
--صندوق خامس
            [-1056]=7630706,
            [-1060]=1918984972,
        }


        -- تجميد الأوفستات الرئيسية
        for i = 1, #offsetsToFreeze do
            local offset = offsetsToFreeze[i]
            local addr   = address + offset
            local val    = customValues[offset]
            if val ~= nil then
                local item = {
                    address    = addr,
                    flags      = gg.TYPE_DWORD,
                    value      = val,
                    freeze     = true,
                    freezeType = gg.FREEZE_NORMAL
                }
                gg.setValues({item})
                table.insert(saveList, item)
            end
        end

        -- أوفستات تُعدَّل مرة واحدة فقط
        local modifyOnlyOffsets = { -264, -456, -648, -840, -1032,}
        for i = 1, #modifyOnlyOffsets do
            local addr = address + modifyOnlyOffsets[i]
            gg.setValues({
                {
                    address = addr,
                    flags   = gg.TYPE_DWORD,
                    value   = 1
                }
            })
        end

        return saveList
    end

    -- البحث عن القيمة
    gg.clearResults()
    gg.searchNumber(value, gg.TYPE_FLOAT)
    local results = gg.getResults(100)

    if #results == 0 then
        gg.toast("⚠️ لم يتم العثور على أي قيم لـ " .. value)
        return
    end

    local saveList = {}

    for i = 1, #results do
        local address = results[i].address

local checks = gg.getValues({
                {address = address  - 1028, flags = gg.TYPE_DWORD},
            {address = address  - 1024, flags = gg.TYPE_DWORD}
        })

        if checks[1].value == 25 and checks[2].value > 18 then
            -- تجميد القيمة الأساسية
            local t = {
                address    = address,
                flags      = gg.TYPE_FLOAT,
                value      = 1.0,
                freeze     = true,
                freezeType = gg.FREEZE_NORMAL
            }
            gg.setValues({t})
            table.insert(saveList, t)

            -- تجميد بقية الأوفستات المرتبطة
            local frozen = freezeOffsets(address)
            for j = 1, #frozen do
                table.insert(saveList, frozen[j])
            end
        end
    end

    gg.clearResults()
    gg.addListItems(saveList)
    gg.toast("✅ تم التعديل والتجميد بنجاح!")
end

-- قائمة القيم المطلوب البحث عنها وتطبيق التعديلات عليها
local values = {
    15900, 15300, 15000, 15600, 14400,
    16200, 16500, 16800, 17100, 17400,
    17700, 18000, 14700
}

for i = 1, #values do
    SSbb4(values[i])


gg.toast("🎯 البحث اكتمل بنجاح!")
end
end

function SSbb5()
--طلب تاج--
function SSbb5(value)
    -- فحص احتياطي
    if value == nil then
        gg.toast("SSbb5 تمرير قيمة صحيحة للدالة SSbb5")
        return
    end

    gg.setVisible(false)
    gg.toast("🔍 جاري البحث...")

    local function freezeOffsets(address)
        local saveList = {}

        local offsetsToFreeze = {
-- دول تبع اعادة القطار بدون ادوات
 -4,-8,-12,-16,-20,-24,-28,-32,-36,-40,-44,-48,-52,-56,-60,-64,-68,-72,-76,-80,-84,-88,-92,-96,-100,
-- قيم الطلب بالقطار--
 -248, -440, -632, -824, -1016,    
--قيم عدد المنتج
-276 ,-280, -468, -472, -660, -664, -852, -856, -1044, -1048,
--تعديل المنتج الى تاج
-288, -292,  -480, -484, -672, -676, -864,-868,-1056,-1060,   
        }

        local customValues = {
        	--اعاده تعين القطار بلا ادوات--
            [-4]=0,
            [-8]=0,
            [-12]=0,
            [-16]=0,
            [-20]=0,
            [-24]=0,
            [-28]=0,
            [-32]=0,
            [-36]=0,
            [-40]=0,
            [-44]=0,
            [-48]=0,
            [-52]=0,
            [-56]=0,
            [-60]=0,
            [-64]=0,
            [-68]=0,
            [-72]=0,
            [-76]=0,
            [-80]=0,
            [-84]=0,
            [-88]=0,
            [-92]=0,
            [-96]=0,
            [-100]=0, 
-- قيم الطلب بالقطار 

--صندوق اول     
            [-248]=1,
--صندوق ثاني              
            [-440]=1,
--صندوق ثالث              
            [-632]=1,
--صندوق رابع            
            [-824]=1,  
--صندوق خامس                  
            [-1016]=1,
            
            
--قيم عدد المنج  

--صندوق اول              
            [-276]=500,
            [-280]=0,
--صندوق ثاني              
            [-468]=500,
            [-472]=0,  
--صندوق ثالث                               
            [-660]=500,
            [-664]=0, 
--صندوق رابع                      
            [-852]=500,
            [-856]=0,  
                
--صندوق خامس                       
            [-1044]=500,
            [-1048]=0,            
            
            
---تعديل المنتج الى تاج
--صندوق اول          
            [-288]=7169380,
            [-292]=1634296844,
            
--صندوق ثاني           
            [-480]=7169380,
            [-484]=1634296844,
            
--صندوق ثالث            
            [-672]=7169380,
            [-676]=1634296844,
            
--صندوق رابع            
            [-864]=7169380,
            [-868]=1634296844,
   
--صندوق خامس
            [-1056]=7169380,
            [-1060]=1634296844,
            
        }

        -- تجميد الأوفستات الرئيسية
        for i = 1, #offsetsToFreeze do
            local offset = offsetsToFreeze[i]
            local addr   = address + offset
            local val    = customValues[offset]
            if val ~= nil then
                local item = {
                    address    = addr,
                    flags      = gg.TYPE_DWORD,
                    value      = val,
                    freeze     = true,
                    freezeType = gg.FREEZE_NORMAL
                }
                gg.setValues({item})
                table.insert(saveList, item)
            end
        end
        -- أوفستات تُعدَّل مرة واحدة فقط
        local modifyOnlyOffsets ={ -264, -456, -648, -840, -1032,}
        for i = 1, #modifyOnlyOffsets do
            local addr = address + modifyOnlyOffsets[i]
            gg.setValues({
                {
                    address = addr,
                    flags   = gg.TYPE_DWORD,
                    value   = 1
                }
            })
        end

        return saveList
    end

    -- البحث عن القيمة
    gg.clearResults()
    gg.searchNumber(value, gg.TYPE_FLOAT)
    local results = gg.getResults(100)

    if #results == 0 then
        gg.toast("⚠️ لم يتم العثور على أي قيم لـ " .. value)
        return
    end

    local saveList = {}

    for i = 1, #results do
        local address = results[i].address

local checks = gg.getValues({
             {address = address  - 1028, flags = gg.TYPE_DWORD},
            {address = address  - 1024, flags = gg.TYPE_DWORD}
        })

        if checks[1].value == 25 and checks[2].value > 18 then
            -- تجميد القيمة الأساسية
             local t = {
                address    = address,
                flags      = gg.TYPE_FLOAT,
                value      = 1.0,
                freeze     = true,
                freezeType = gg.FREEZE_NORMAL
            }
            gg.setValues({t})
            table.insert(saveList, t)

            -- تجميد بقية الأوفستات المرتبطة
            local frozen = freezeOffsets(address)
            for j = 1, #frozen do
                table.insert(saveList, frozen[j])
            end
        end
    end

    gg.clearResults()
    gg.addListItems(saveList)
    gg.toast("✅ تم التعديل والتجميد بنجاح!")
end

-- قائمة القيم المطلوب البحث عنها وتطبيق التعديلات عليها
local values = {
    15900, 15300, 15000, 15600, 14400,
    16200, 16500, 16800, 17100, 17400,
    17700, 18000, 14700
}

for i = 1, #values do
    SSbb5(values[i])


gg.toast("🎯 البحث اكتمل بنجاح!")
end
end


 function SMB11()
--مطار--
SSbm= gg.multiChoice({
"🚅تصفير صناديق المطار 🚅",
"🚅طلب مساعدة القمح🚅",
"🚅إرسال البرسيم بعدد لا نهائي 🚅",
"🚅طلب دعم🚅",
" 👽☠b͢a͢c͢k͢ ☠👽 ",
  }, nil, "ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ℒℴѵℯ".. getTime()) 
if SSbm == nil then else
if SSbm[1] == true then SSbm1() end
if SSbm[2] == true then SSbm2() end
if SSbm[3] == true then SSbm3() end
if SSbm[4] == true then SSbm4() end
if SSbm[5] == true then basmala() end
end
THSH = -1
end

 function SSbm1()
  --تصفير صناديق المطار--
gg.searchNumber("00004650h;0000D2F0h:5", gg.TYPE_DWORD)
    gg.getResults(1000)
    gg.sleep(3000)
    gg.refineNumber("00004650h", gg.TYPE_DWORD)
    tas = gg.getResults(1000)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address - 4
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])

        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("✨ تم تصفير منتجات الطائرة بنجاح ✨")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
    
end

 function SSbm2()
--طلب مساعدة قمح--
gg.setVisible(false) 
local input = gg.prompt(
    {"🌸 أدخل عدد المنتجات بالمطار 🌸"},
    {0},
    {"number"}
)

if input == nil then
    gg.toast("لم يتم إدخال قيم. العملية ألغيت.")
    return
end

gg.alert("🍉🍇أنتظر انتهاء البحث🍇🍉")
gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
gg.clearResults()
gg.searchNumber('65540;25;19;' .. input[1], gg.TYPE_DWORD)
gg.refineNumber("65540", gg.TYPE_DWORD)
local r = gg.getResults(1000)

if not r or #r == 0 then
    gg.alert("❌ لم يتم العثور على نتائج.")
    return
end

-- ✅ التعديل على كل النتائج
for i, res in ipairs(r) do
    local address = res.address

    local values = {
        {offset = 8, value = 1},
        {offset = 12, value = 1701345034},
        {offset = 16, value = 29793},
        {offset = 20, value = 0},
    }

    for _, v in ipairs(values) do
        local t = {}
        t[1] = {
            address = address + v.offset,
            flags = gg.TYPE_DWORD,
            value = v.value
        }
        gg.setValues(t)
        gg.addListItems(t)
    end
end

gg.clearResults()
gg.searchNumber("25;19;65537", gg.TYPE_DWORD)
gg.refineNumber("25", gg.TYPE_DWORD)
local r = gg.getResults(30000000)

-- 🔍 دالة تحقق الشروط
function checkCondition(addr)
    local vals = gg.getValues({
        {address = addr + 4, flags = gg.TYPE_DWORD},   -- +4
        {address = addr + 8, flags = gg.TYPE_DWORD},   -- +8
        {address = addr + 12, flags = gg.TYPE_DWORD},  -- +12
        {address = addr + 16, flags = gg.TYPE_DWORD},  -- +16
        {address = addr - 84, flags = gg.TYPE_DWORD},  -- -84
    })

    local v4  = vals[1].value
    local v8  = vals[2].value
    local v12 = vals[3].value
    local v16 = vals[4].value
    local vm84 = vals[5].value

    if v4 == 19
    and math.abs(v8)  > 50000000
    and math.abs(v12) > 50000000
    and v16 == 0
    and (vm84 == 65537 or vm84 == 65538) then
        return true
    end
    return false
end

-- ✅ التعديل بعد التحقق
for i, res in ipairs(r) do
    if checkCondition(res.address) then
        local t1 = {}
        t1[1] = {
            address = res.address - 12,
            flags = gg.TYPE_DWORD,
            value = 1
        }
        gg.setValues(t1)
        gg.addListItems(t1)
    end
  end
  
gg.clearResults()
gg.alert ("🌼 تم طلب المساعدة 🌼 ") 
gg.toast ("✨💗 اللهم صل على  םבםב 💗✨")
end

 function SSbm3()
--إرسال البرسيم بعدد لا نهائي --
gg.searchNumber("25;19;65537", gg.TYPE_DWORD)
gg.refineNumber("25", gg.TYPE_DWORD)
local r = gg.getResults(30000000)

-- 🔍 دالة تحقق الشروط (بدون أي تعديل عليها)
function checkCondition(addr)
    local vals = gg.getValues({
        {address = addr + 4, flags = gg.TYPE_DWORD},   -- +4
        {address = addr + 8, flags = gg.TYPE_DWORD},   -- +8
        {address = addr + 12, flags = gg.TYPE_DWORD},  -- +12
        {address = addr + 16, flags = gg.TYPE_DWORD},  -- +16
        {address = addr - 84, flags = gg.TYPE_DWORD},  -- -84
    })

    local v4  = vals[1].value
    local v8  = vals[2].value
    local v12 = vals[3].value
    local v16 = vals[4].value
    local vm84 = vals[5].value

    if v4 == 19
    and math.abs(v8)  > 50000000
    and math.abs(v12) > 50000000
    and v16 == 0
    and (vm84 == 65537 or vm84 == 65538) then
        return true
    end
    return false
end

-- ✅ التعديل بعد التحقق
for i, res in ipairs(r) do
    if checkCondition(res.address) then

        -- ❌ تمت إزالة تعديل -12 بالكامل
        --تعديل 76لصفر تجميد--
        local freezeItem = {
            address = res.address - 76,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        }
        gg.setValues({freezeItem})
        gg.addListItems({freezeItem})

    end
    end

gg.clearResults()
gg.alert ("🌱😉ارسل برسيم براحتك??🌱")
gg.toast ("✨💗 اللهم صل على םבםב 💗✨")
end

 function SSbm4()
--طلب مساعدة جزر--
gg.setVisible(false) 
local input = gg.prompt(
    {"?? أدخل عدد المنتجات بالمطار 🌸"},
    {0},
    {"number"}
)

if input == nil then
    gg.toast("لم يتم إدخال قيم. العملية ألغيت.")
    return
end

gg.alert("🍉🍇أنتظر انتهاء البحث🍇🍉")
gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
gg.clearResults()
gg.searchNumber('65540;25;19;' .. input[1], gg.TYPE_DWORD)
gg.refineNumber("65540", gg.TYPE_DWORD)
local r = gg.getResults(1000)

if not r or #r == 0 then
    gg.alert("❌ لم يتم العثور على نتائج.")
    return
end

-- ✅ التعديل على كل النتائج
for i, res in ipairs(r) do
    local address = res.address

    local values = {
        {offset = 8, value = 9999},
        {offset = 12, value = 1918984972},
        {offset = 16, value = 7630706},
        {offset = 20, value = 0},
    }

    for _, v in ipairs(values) do
        local t = {}
        t[1] = {
            address = address + v.offset,
            flags = gg.TYPE_DWORD,
            value = v.value
        }
        gg.setValues(t)
        gg.addListItems(t)
    end
end

gg.clearResults()
gg.searchNumber("25;19;65537", gg.TYPE_DWORD)
gg.refineNumber("25", gg.TYPE_DWORD)
local r = gg.getResults(30000000)

-- 🔍 دالة تحقق الشروط
function checkCondition(addr)
    local vals = gg.getValues({
        {address = addr + 4, flags = gg.TYPE_DWORD},   -- +4
        {address = addr + 8, flags = gg.TYPE_DWORD},   -- +8
        {address = addr + 12, flags = gg.TYPE_DWORD},  -- +12
        {address = addr + 16, flags = gg.TYPE_DWORD},  -- +16
        {address = addr - 84, flags = gg.TYPE_DWORD},  -- -84
    })

    local v4  = vals[1].value
    local v8  = vals[2].value
    local v12 = vals[3].value
    local v16 = vals[4].value
    local vm84 = vals[5].value

    if v4 == 19
    and math.abs(v8)  > 50000000
    and math.abs(v12) > 50000000
    and v16 == 0
    and (vm84 == 65537 or vm84 == 65538) then
        return true
    end
    return false
end

-- ✅ التعديل بعد التحقق
for i, res in ipairs(r) do
    if checkCondition(res.address) then
        local t1 = {}
        t1[1] = {
            address = res.address - 12,
            flags = gg.TYPE_DWORD,
            value = 1
        }
        gg.setValues(t1)
        gg.addListItems(t1)
    end
  end
  
gg.clearResults()
gg.alert ("🌼 تم طلب المساعدة 🌼 ") 
gg.toast ("✨💗 اللهم صل على  םבםב 💗✨")
end

function SMB12() 
--زيادة الكروت--
gg.setVisible(false)

gg.searchNumber("1918984974;1918984976", gg.TYPE_DWORD)
local r = gg.getResults(30000)

local input = gg.prompt(
 {"♡اكتب العدد♡"} , 
    {0},
    {"number"}
)

if input == nil then
    gg.toast("🌹لم يتم إدخال قيم. العملية ألغيت.🌹")
    return
end

for i, v in ipairs(r) do
    -- قراءة قيمة +28
    local read = gg.getValues({
        {
            address = v.address + 16,  -- +28
            flags = gg.TYPE_DWORD
        }
    })

    local val = read[1].value

    -- الشرط الجديد:
    -- لا يعدل إذا كانت القيمة سالبة
    -- لا يعدل إذا كانت أكبر من أو تساوي 10
    -- يعدل فقط إذا كانت القيمة  من 1 إلى 9
    if val >= 1 and val < 10 then
        local edit = {
            {
                address = v.address + 16, -- تعديل +28
                flags = gg.TYPE_DWORD,
                value = input[1]
            }
        }

        gg.setValues(edit)
        gg.addListItems(edit)
    end
end

gg.clearResults()
gg.alert("✨💗 اللهم صل على  םבםב 💗✨")
gg.toast("ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━")
 end
 
function SMB13()
--ارسال الكروت--    
gg.searchNumber("4;1684828007;6;1819240822:37", gg.TYPE_DWORD)
    gg.getResults(1000)
        gg.refineNumber("1684828007", gg.TYPE_DWORD)
    tas = gg.getResults(100)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])
    gg.clearResults()
    gg.alert("🌸تم تحويل الكروت لسيلفر🌸")
    gg.toast("ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━")
    
gg.searchNumber("983041;65535;256;86400;50:105", gg.TYPE_DWORD)
    gg.getResults(1000)
            gg.refineNumber("86400", gg.TYPE_DWORD)
    tas = gg.getResults(100)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address + 24
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 0
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])


        local t2 = {}
        t2[1] = {}
        t2[1].address = address + 28
        t2[1].flags = gg.TYPE_DWORD
        t2[1].value = 0
        t2[1].freeze = true
        gg.setValues(t2)
        table.insert(saveList, t2[1])


        local t3 = {}
        t3[1] = {}
        t3[1].address = address + 32
        t3[1].flags = gg.TYPE_DWORD
        t3[1].value = 0
        t3[1].freeze = true
        gg.setValues(t3)
        table.insert(saveList, t3[1])
        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("🌸ارسل الكروت براحتك🌸")
    gg.toast("ꗟaher━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━")
   
end
end

function SMB14()
--تصفير الجزر--
-- إدخال قيمة الصقل
local input = gg.prompt(
    {"🔥أدخل مستوى الجزيره🔥"},
    {""},
    {"number"}
)
if not input or not input[1] then return end

local refineValue = tonumber(input[1])
if not refineValue then return end

-- البحث عن العنوان
gg.clearResults()
gg.searchNumber(
    "65537;1;41;2;35;3;52;4;67",
    gg.TYPE_DWORD,
    false,
    gg.SIGN_EQUAL,
    0,
    -1
)

-- صقل العنوان
gg.refineNumber(refineValue, gg.TYPE_DWORD)

-- جلب أول نتيجة (العنوان)
local base = gg.getResults(1)
if #base == 0 then
    gg.clearResults()
    gg.toast("❌ العنوان غير موجود")
    return
end

local baseAddr = base[1].address

-- تحديد 12 سطر تحت العنوان
local edits = {}
for i = 1, 12 do
    table.insert(edits, {
        address = baseAddr + (i * 4), -- DWORD = 4 بايت
        flags = gg.TYPE_DWORD,
        value = 0
    })
end

-- تنفيذ التعديل
gg.setValues(edits)
gg.clearResults()
gg.toast("😎 افتح الجزر 😎")
end

function SMB15()
--إستعادة الهديةxa--
gg.searchNumber("1163536;65537;1295215888;1701604449;116:45", gg.TYPE_DWORD)
gg.getResults(1000)
gg.sleep(3000)
    gg.refineNumber("1295215888", gg.TYPE_DWORD)
local results = gg.getResults(100)
 
local saveList = {}
for i = 1, #results do
    local addr = results[i].address
 
    -- قراءة القيم المجاورة
    local checkValues = {
        {address = addr - 4, flags = gg.TYPE_DWORD},
        {address = addr - 8, flags = gg.TYPE_DWORD},
        {address = addr - 12, flags = gg.TYPE_DWORD}
    }
 
    checkValues = gg.getValues(checkValues)
 
    local valMinus4 = checkValues[1].value
    local valMinus8 = checkValues[2].value
    local valMinus12 = checkValues[3].value
 
    -- تحقق من الشروط: +8 أقل من 100000، +12 و +16 أكبر من مليار سواء بالسالب أو الموجب
    if valMinus4 < 100000 and math.abs(valMinus8) > 100000000 and math.abs(valMinus12) > 100000000 then
        -- إنشاء العناصر للتعديل والتجميد
        local toFreeze = {
            {address = addr - 4, flags = gg.TYPE_DWORD, value = 0, freeze = true},
            {address = addr - 8, flags = gg.TYPE_DWORD, value = 0, freeze = true},
            {address = addr - 12, flags = gg.TYPE_DWORD, value = 0, freeze = true}
        }
 
        -- تطبيق التعديلات والتجميد
        gg.setValues(toFreeze)
 
        -- إضافة إلى القائمة للحفظ
        for _, item in ipairs(toFreeze) do
            table.insert(saveList, item)
        end
    end
end
 
-- النتيجة النهائية
if #saveList > 0 then
    gg.addListItems(saveList)
    gg.alert("🌘تم إستعادة الهدية بنجاح🌒")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
else
    gg.alert("❌ لم يتم العثور على قيم تطابق الشروط ❌")
        gg.clearResults()
end
end

function SMB16()
--توسيع الارض دفعه واحده--

gg.searchNumber("1886938386;1113878113;31093;1", gg.TYPE_DWORD)
    gg.getResults(100000)
    gg.sleep(3000)
    gg.refineNumber("1", gg.TYPE_DWORD)
    tas = gg.getResults(1000000)
 
    local saveList = {}
    for i = 1, #tas do
        local address = tas[i].address

        local t1 = {}
        t1[1] = {}
        t1[1].address = address 
        t1[1].flags = gg.TYPE_DWORD
        t1[1].value = 6
        t1[1].freeze = true
        gg.setValues(t1)
        table.insert(saveList, t1[1])


        
        end
        gg.setValues(saveList)
    gg.addListItems(saveList)
    gg.clearResults()
    gg.alert("🍉Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ")
    gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
    
    
end  

function EXIT()
    print("".. getTime())
 print("♛━─━─━─『ɢᴏᴏᴅ ʙʏᴇ』─━─━─♛") 
  gg.alert([[
██████╗ ███████╗
██╔══██╗██╔════╝
██████╔╝███████╗
██╔══██╗╚════██║
██████╔╝███████║
╚═════╝ ╚══════╝
      🌸     🌸     🌸      🌸
━━━━━━━━━━━━━━━━
✦ BASMALA SCRIPT ✦
━━━━━━━━━━━━━━━━
✓ Script Finished
✓ Thanks For Using

「 See You Again ♡ 」
━━━━━━━━━━━━━━━━
]])
gg.skipRestoreState()
gg.setVisible(true)
os.exit()
end
while true do
  if gg.isVisible(true) then
THSH = 1
gg.setVisible(false)
  end
if THSH == 1 then
basmala()
  end 
end
else
	gg.alert('🎲قم بتحميل الجاردن الخاص بكروب سنه اولى تطوير 🎲')
end