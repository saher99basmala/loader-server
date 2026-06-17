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
 "✦✧▬▭رفع المستوى عن طريق القَمح▭▬✧✦",
  "✦✧▬▭رفع المستوى عن طريق اي زرع▭▬✧✦",
 "✦✧▬▭فتح التصريح▭▬✧✦", 
 "✦✧▬▭توسيع الارض دفعه واحده▭▬✧✦",  
 "✦✧▬▭استعادة الهديةca▭▬✧✦", 
 "✦✧▬▭إستعادة الهدية نطاقات اخيرة▭▬✧✦", 
 "✦✧▬▭تبديل الهدية▭▬✧✦", 
 "✦✧▬▭تصفير الجزر▭▬✧✦", 
 "✦✧▬▭تطوير كامل▭▬✧✦", 
 "✦✧▬▭السباق▭▬✧✦", 
 "✦✧▬▭لايــك▭▬✧✦", 
 "✦✧▬▭تبديل التصريح▭▬✧✦", 
 "✦✧▬▭اكاديمية الصناعة▭▬✧✦", 
 "✦✧▬▭قطارات▭▬✧✦", 
 "✦✧▬▭مطار▭▬✧✦", 
 "✦✧▬▭زيادة الكروت▭▬✧✦", 
"✦✧▬▭ارسال الكروت▭▬✧✦", 
"✦✧▬▭استعادة جميع هدايا التصريح ▭▬✧✦",  
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
if SMB == 17 then SMB17() end
if SMB == 18 then SMB18() end
if SMB == 19 then EXIT() end
end
THSH = -1
end

function SMB1()
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
function SMB2()
--رفع مستوى اي زرعه--
gg.searchNumber("16842755X36", gg.TYPE_DWORD)
gg.getResults(1000)
gg.refineNumber("16842753", gg.TYPE_DWORD)
tas = gg.getResults(1000)

local input = gg.prompt(
    {"🌱إدخل نسبة الاكس بي🌱"},
    {0},
    {"number"}
)
if input == nil then
    gg.toast("لم يتم إدخال قيم. العملية ألغيت.")
    return
end

local saveList = {}

for i = 1, #tas do
    local address = tas[i].address

    -- 🔍 قراءة القيم عند -120 و -116
    local checkVals = gg.getValues({
        {address = address - 96, flags = gg.TYPE_DWORD},
        {address = address - 92, flags = gg.TYPE_DWORD}
    })

    local v120 = checkVals[1].value
    local v116 = checkVals[2].value

    -- ✅ شرط التحقق
    if
        math.abs(v120) > 500000 and
        math.abs(v116) > 500000 and
        (v120 * v116 > 0) and
        math.abs(v120 - v116) < 100
    then

        local t1 = {{
            address = address - 104,
            flags = gg.TYPE_DWORD,
            value = 2,
            freeze = true
        }}
        gg.setValues(t1)
        table.insert(saveList, t1[1])

        local t2 = {{
            address = address - 100,
            flags = gg.TYPE_DWORD,
            value = 2,
            freeze = true
        }}
        gg.setValues(t2)
        table.insert(saveList, t2[1])

        local t3 = {{
            address = address - 88,
            flags = gg.TYPE_DWORD,
            value = 0,
            freeze = true
        }}
        gg.setValues(t3)
        table.insert(saveList, t3[1])

        local t4 = {{
            address = address - 84,
            flags = gg.TYPE_DWORD,
            value = input[1],
            freeze = true
        }}
        gg.setValues(t4)
        table.insert(saveList, t4[1])

    end
end

gg.setValues(saveList)
gg.addListItems(saveList)
gg.clearResults()
gg.toast("✨💗 اللهم صل على  םבםב 💗✨")
end

function SMB3()
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

function SMB4()
--توسيع الارض دفعه واحده--
gg.alert("🍥ملحوظة ♡عند الانتهاء من البحث الرجاء الانتظار  ثلاث دقائق لفتح الاࢪاضي🍥")

gg.searchNumber("1886938386;1886938386;1113878113;31093;4;1:289", gg.TYPE_DWORD)
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

function SMB5()
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

function SMB6()
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

function SMB7()
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
    name = "𓊆 ★ᯓصاروخ المنجمᯓ★ 𓊇",
    value24 = 17,
   pointerValues = {1147097171, 1768384361, 1917871982,1969843557 , 109}, noInput32 = true}, 
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
    name = "𓊆 ★ᯓ مثقاب صاروخ داخل الحدثᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1867002733, 1870293362,1818326126 , 1701734732}
}, 
{
    name = "𓊆 ★ᯓ ثقل داخل الحدثᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1700148077, 1667855474,1766616161,25966}
}, 
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
    directValues = {1110666508, 6450543, 0}   
},
 {
    name = "𓊆 ★ᯓبلورة الالوان خارج الحدثᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1632777069,1868721769,1818313335,1699479660,1936483702}
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
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
----الاطارات---
local bs1Data = {
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
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
-- الشارات--
local bs2Data ={
	{
    name = "𓊆 ★ᯓ الاولى ᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1734631778,825253733,1935762015,101},noInput32 = true},
    {
    name = "𓊆 ★ᯓ الثانيةᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1734631778,825253733,1634887519,25710},noInput32 = true},
    {
    name = "𓊆 ★ᯓ الثالثةᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1734631778, 825253733, 1597142623,1702060386},noInput32 = true}, 
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
   ---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--الالقاب--
local bs3Data ={
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
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
    --لافتات
local bs4Data = {

{
    name = "𓊆 ★ᯓ لافتة مدينة روك ᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402547,1953063775,1769168761,1918856807,1600873327,1852270963},noInput32 = true},

{
    name = "𓊆 ★ᯓ لافتة العلكة للجميع ᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1852402547,1953063775,1769168761,1918856807,1852403061,1601465953,1751343469,6647401},noInput32 = true},

{
    name = "?? ★ᯓ لافتة وحش مطاطيᯓ★ 𓊇",
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
    name = "𓊆 ★ᯓ لافتة مدينة بطابع خيالي ᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402547,1953063775,1769168761,1633644135,1768055154,1769168739,28263},noInput32 = true},
{
    name = "𓊆 ★ᯓ لافتة التقاليد القديمة ᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402547,1953063775,1769168761,1633644135,1851877747,1734964063,110},noInput32 = true},
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
{
    name = "𓊆 ★ᯓ لافتة أعياد الربيعᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1702130529,1769168754,721448551},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ لافتة مدينة القراصنة ᯓ★ 𓊇",
    value24 = 32,
    pointerValues = {1852402547,1953063775,1769168761,1918856807,1952540517,845111668,1596993585,1852270963},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ علامة المدينة الخفيةᯓ★ 𓊇",
    value24 = 37,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1684369528,1869182057,1597190766;808464946;1734964063;110,41},noInput32 = true}, 
{
    name = "𓊆 ★ᯓلافتة المدينة الخارقه للطبيعةᯓ★ 𓊇",
    value24 = 37,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1684369528,1869182057,1597190766,1597190766;808464946;1734964063;110,41},noInput32 = true},
{
    name = "𓊆 ★ᯓ لافتة مدينة كثوتونᯓ★ 𓊇",
    value24 = 37,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1684369528,1869182057,1597256302,808465202;1734964063;110,41},noInput32 = true},  
{
    name = "𓊆 ★ᯓ لافتة مدينة العطلاتᯓ★ 𓊇",
    value24 = 37,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1684369528,1869182057,1597321838,808465202;1734964063;110,41},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ لافتة المدينة الشتويةᯓ★ 𓊇",
    value24 = 32,
    pointerValues = {1852402547,1953063775,1769168761,1918856807,1952540517,845111668,1596993587,1852270963,1852270963},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ لافتة مدينة خارج كوكب الارضᯓ★ 𓊇",
    value24 = 37,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1684369528,1869182057,1597387374,808465458,1734964063,110,41},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ لافتة المدينة الشبحيةᯓ★ 𓊇",
    value24 = 37,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1684369528,1869182057,1597452910,808465458,1734964063,110,41},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ لافتة المدينة القرمزيهᯓ★ 𓊇",
    value24 = 32,
    pointerValues = {1852402547,1953063775,1769168761,1918856807,1952540517,845111668,1596993588,1852270963,41},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ لافتة المدينة الصحراويةᯓ★ 𓊇",
    value24 = 37,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1684369528,1869182057,1597518446,808465714,1734964063,110,41},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ لافتة مدينة راعي البقرᯓ★ 𓊇",
    value24 = 37,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1684369528,1869182057,1597583982,808465714;1734964063;110,41},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ لافتة مدينة قوة الاجدادᯓ★ 𓊇",
    value24 = 37,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1684369528,1869182057,1596994414,808465970;1734964063;110,41},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓلافتة مدينة اطلانتسᯓ★ 𓊇",
    value24 = 37,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1684369528,1869182057,1597059950,808465970;1734964063;110,41},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ لافتة مدينة بطابع الحديقة الذكيةᯓ★ 𓊇",
    value24 = 37,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1684369528,1869182057,1597125486,808466226;1734964063;110,41,37},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ لافتة مدينة بتصميم حلوىᯓ★ 𓊇",
    value24 = 37,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1684369528,1869182057,1597191022,808466226,1734964063,110,41},noInput32 = true}, 
{
    name = "𓊆 ★ᯓلافتة مدينة منتجع البطاريقᯓ★ 𓊇",
    value24 = 37,
    pointerValues = {1852402547,1953063775,1769168761,1700752999,1684369528,1869182057,1597387630,808466738,1734964063,110,41},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ علامة هالوين كبيرهᯓ★ 𓊇",
    value24 = 32,
    pointerValues = {1852402547,1953063775,1769168761,1918856807,1952540517,861888884,1596993584,1852270963,41},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ لافتة بلدة العجائب الشتويةᯓ★ 𓊇",
    value24 = 32,
    pointerValues = {1852402547,1953063775,1769168761,1918856807,1952540517,861888884,1596993585,1852270963,41},noInput32 = true}, 
}
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--الملصقاات
local bs5Data = {
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
{ name = "?? ★ᯓ فرخة الاستعراض ᯓ★ 𓊇", directValues = {1869440276,1935632746,3290740},noInput32 = true },
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
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--الصور
local bs6Data = {
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
{ name = "𓊆 ★ᯓ ام قبعه ᯓ★ 𓊇", directValues = {1635148044,3487283,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ الشريره ᯓ★ 𓊇", directValues = {1635148044,3618355,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ الراجل ابو ريشه ᯓ★ 𓊇", directValues = {1635148044,3225395,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ بنت تاكل جاتوه ᯓ★ 𓊇", directValues = {1635148044,3290931,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ فتاة المزرعة ᯓ★ 𓊇", directValues = {1635148044,3225907,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ الحصان ᯓ★ 𓊇", directValues = {1635148044,3160371,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ الملثم ᯓ★ 𓊇", directValues = {1635148044,3749939,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ المغامرة الأسطورية ᯓ★ 𓊇", directValues = {1635148044,3618099,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ هالوين مخيف ᯓ★ 𓊇", directValues = {1635148044,3420978,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ المغامرة الاسطورية ᯓ★ 𓊇", directValues = {1635148044,3683891,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ كنوز أطلانتس ᯓ★ 𓊇", directValues = {1635148044,3159347,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ مهرجان الفوانيس ᯓ★ 𓊇", directValues = {1635148044,3158835,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ مغامرة الغابة ᯓ★ 𓊇", directValues = {1635148044,3682611,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ الغرب الامريكي الجامح ᯓ★ 𓊇", directValues = {1635148044,3421491,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ العاب تجسس ᯓ★ 𓊇", directValues = {1635148044,3224627,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ عالم قديم ᯓ★ 𓊇", directValues = {1635148044,3748659,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ مهرجان الروك أند رول ᯓ★ 𓊇", directValues = {1635148044,3486515,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ مغامرة عيد الفصح ᯓ★ 𓊇", directValues = {1635148044,3420979,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ كرنفال برازيلي ᯓ★ 𓊇", directValues = {1635148044,3551795,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ معجزات الكريسماس ᯓ★ 𓊇", directValues = {1635148044,3224115,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ عيد ميلاد سعيد ᯓ★ 𓊇", directValues = {1635148044,3158323,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ قصص المحققين ᯓ★ 𓊇", directValues = {1635148044,3485747,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ نداء الغابة ᯓ★ 𓊇", directValues = {1635148044,3616819,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ عالم الفايكنج ᯓ★ 𓊇", directValues = {1635148044,3289139,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ المملكة الخيالية ᯓ★ 𓊇", directValues = {1635148044,3158067,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ متعة عيد الفصح ᯓ★ 𓊇", directValues = {1635148044,3225906,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ مغامرة مريخية ᯓ★ 𓊇", directValues = {1635148044,3488050,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ ماراثون رياضي ᯓ★ 𓊇", directValues = {1635148044,3160370,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ حمى الحب ᯓ★ 𓊇", directValues = {1635148044,3618866,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ مهرجان الفوانيس ᯓ★ 𓊇", directValues = {1635148044,3553330,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ العيد الفرنسي ᯓ★ 𓊇", directValues = {1635148044,3748914,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ مهرجان سينمائي ᯓ★ 𓊇", directValues = {1635148044,3225394,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ دقات الروك ᯓ★ 𓊇", directValues = {1635148044,3683634,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ الحكايات العربية ᯓ★ 𓊇", directValues = {1635148044,3159346,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ متعة عيد الفصح ᯓ★ 𓊇", directValues = {1635148044,3224882,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ منزل الكهف ᯓ★ 𓊇", directValues = {1635148044,3421746,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ العرض الاول للمسرحية ᯓ★ 𓊇", directValues = {1635148044,3684146,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ حفل زفاف لاينسى ᯓ★ 𓊇", directValues = {1635148044,3749426,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ انهيار بريدي ᯓ★ 𓊇", directValues = {1635148044,3160114,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ لعنة الفرعون ᯓ★ 𓊇", directValues = {1635148044,3553586,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ المغامرة المصرية ᯓ★ 𓊇", directValues = {1635148044,3749427,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ صورة سباق اليخوت ᯓ★ 𓊇", directValues = {1635148044,3159859,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ أفعى خضراᯓ★ 𓊇", directValues = {1635148044,3291187,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ الرحلة الاستكشافيةᯓ★ 𓊇", directValues = {1635148044,3619122,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ بناء متجر استبدال الادوات ᯓ★ 𓊇", directValues = {1635148044,3618353,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ أنقد الموعد ᯓ★ 𓊇", directValues = {1635148044,3158578,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ المغامرة الاسطورية ᯓ★ 𓊇", directValues = {1635148044,3683123,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ تحقيق في قاعدة سرية ᯓ★ 𓊇", directValues = {1635148044,3421235,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ مهرجان الشاطئ ᯓ★ 𓊇", directValues = {1635148044,3159091,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ عيد إيطالي ᯓ★ 𓊇", directValues = {1635148044,3683635,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ العطلة الشاطئية ᯓ★ 𓊇", directValues = {1635148044,3487027,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ أخوية الفرسان ᯓ★ 𓊇", directValues = {1635148044,3617843,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ هدية للعام الثامن ᯓ★ 𓊇", directValues = {1635148044,3683122,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ حدث جولة العيد ᯓ★ 𓊇", directValues = {1635148044,3552306,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ حمى الجواهر 1ᯓ★ 𓊇", directValues = {1635148044,3487282,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ حمى الجواهر2 ᯓ★ 𓊇", directValues = {1635148044,3356722,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ حمى الجواهر3 ᯓ★ 𓊇", directValues = {1635148044,3618610,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ حدث عيد ميلاد سعيد ᯓ★ 𓊇", directValues = {1635148044,3356211,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ الهالوين المخيف ᯓ★ 𓊇", directValues = {1635148044,3552819,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ بابا نويل من متجر سباق الزوارق ᯓ★ 𓊇", directValues = {1635148044,3356467,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ مغامرة القراصنة ᯓ★ 𓊇", directValues = {1635148044,3422003,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ الكريسماس السحري ᯓ★ 𓊇", directValues = {1635148044,3225651,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ رحلة الكهف الاستكشافية ᯓ★ 𓊇", directValues = {1635148044,3749171,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ مصنع الشوكولاتة ᯓ★ 𓊇", directValues = {1635148044,3421747,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ المغامرة الأسطورية ᯓ★ 𓊇", directValues = {1635148044,3159603,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ حدث الغزو الفضائي ᯓ★ 𓊇", directValues = {1635148044,3356723,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ المغامرة الأسطورية ᯓ★ 𓊇", directValues = {1635148044,3422259,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ لغز جريمووتر ᯓ★ 𓊇", directValues = {1635148044,3487795,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ المغامرة الاسطورية في الرحلة الاستكشافية ᯓ★ 𓊇", directValues = {1635148044,3553331,0}, noInput32 = true },
{ name = "𓊆 ★ᯓ بطوط مغرور ᯓ★ 𓊇", directValues = {1635148042,13879;0}, noInput32 = true },
}
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--الجزيرة--
local bs7Data = {
{
 name = "𓊆 ★ᯓ حصن القراصنةᯓ★ 𓊇",
 value24 = 21,
 pointerValues = {1852402515, 1919895135,1936028276 , 1766874995 , 1702125938, 51},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ مسكن الجزيرةᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515, 1919895135,1936028276,1632067443,2036495220,1768489011},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ قلعة الساحرةᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402515,1919895135,1936028276,1632132979,2003790956,846095717,1597059632,1862271027},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓ باريس الصغيرةᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1852402515, 1919895135, 1936028276 , 1634754419,7563634},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ القلعة الجليديةᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515,1919895135,1936028276,1749245811,1953720690,7561581},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ قرية عيد الفصحᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515 , 1919895135 , 1936028276,1634033523,1919251571},noInput32 = true}, 
{
    name = "𓊆 ★ᯓجزيرة الانسان البدائي ᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402515,1919895135,1936028276,1919967091,1936287845,1769107316,858980451},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ جزيرة الآزتك ᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515, 1919895135,1936028276,2053201779,1935893876},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ جزيرة العطلات ᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1852402515,1919895135,1936028276,1751342963,1953720690,1601397101,808464947},noInput32 = true}, 
}
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--محطة القطار--
local bs8Data = {
{
    name = "𓊆 ★ᯓ بوابة القطار السريعᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515,1634882655,1951624809,1869182049,1347641198,50},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ  محطة الاشباحᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515,1634882655,1951624809,1869182049,1347641198,53},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ محطة الديسكوᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515,1634882655,1951624809,1869182049,1347641198,56},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ محطة الفضاءᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515,1634882655,1951624809,1869182049,1634557806,29554},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ محطة رعاة البقر ᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1702322030, 1919251571, 110},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ محطة الكريسماسᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1751342958, 1953720690, 7561581},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ محطة عيد الفصحᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1634033518, 1919251571},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ مستوطنة قديمةᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1919967086, 1936287845, 1769107316, 99},noInput32 = true},
{
    name = "𓊆 ★ᯓ محطة مسرحيةᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1752457070, 1920229733, 1818321769, 28160},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ محطة صينيةᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1970036590, 1316118894, 842019417, 50},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ معسكر تدريبᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1869766510, 1215195490, 6582127},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ مركز التسجيل ᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1869766510, 1919839075, 7105647},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ محطة القلعةᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1852530542, 1952999273},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ محطة رومانيةᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1953062766, 846818401, 3420720},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ محطة الهالوينᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1634230126, 2003790956, 846095717, 3420720},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ محطةعيد الميلادᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1751342958, 1953720690, 846422381, 3420720},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ محطة الزهور ᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1701207918, 1986622579, 27745},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ المحطة الاسطوريةᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1701338990, 1935764588, 892481586},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ محطة غاتسبيᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1632067438, 2036495220},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ المحطة الفرنسيةᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515, 1634882655, 1951624809, 1869182049, 1919311726, 1701015137, 3683935},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمحطة المشاهيرᯓ★ 𓊇",
    value24 = 30,
    pointerValues = {1852402515, 1634882655,1951624809,1869182049,1701011310,1919051116,1601795177, 13111},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمحطة المستقبلᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515,1634882655,1951624809,1869182049,1969643374,1701999988,3553119},noInput32 = true}, 
}
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
 --مظهر قطار --
local bs9Data = {
{
    name = "𓊆 ★ᯓقطار فائق السرعةᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1852402515, 1634882655, 1398763113, 842674768,1824819456},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓقطار الاشباحᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1852402515,1634882655,1398763113,13648},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓقطار الديسكو ᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1852402515,1634882655,1398763113,14416},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ قطار رعاة البقرᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515,1634882655,2002742889,1702130533,1845522034},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ قطار الكريسماسᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515,1634882655,1667198569, 1936290408 ,1935764852, 875704370},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ قطار عيد الفصحᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1852402515, 1634882655,1700753001,1702130529,114},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ قطار بدائي سريعᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515, 1634882655,1885302377,1768449394,1919906931,1811964777},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ قطار مسرحي سريعᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515 , 1634882655,1952411241,1952540008,1633905010,1814364268},noInput32 = true},
{
    name = "𓊆 ★ᯓ قطار التنينᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515, 1634882655,1818193513,1918987893,808606030,1828729394},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ مسبار المريخᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1852402515, 1634882655,1834970729,7565921},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ قطار العربة الخشبيةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515, 1634882655,1918856809,1852400239,1685024584},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ قطار الموسيقى السريع ᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515, 1634882655,1918856809,1852531567,1819045746},noInput32 = true}, 
{
    name = "𓊆 ★ᯓقطار الفرسانᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1852402515, 1634882655,1801416297,1751607662,116},noInput32 = true}, 
{
    name = "𓊆 ★ᯓقطار الترام السريعᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515 , 1634882655,1767861865,2037145972,875704370},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ قطار الهالوينᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515, 1634882655, 1751084649, 1869376609, 1852138871, 875704370},noInput32 = true}, 
{
    name = "𓊆 ★ᯓقطار عيد الميلادᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515, 1634882655, 1667198569, 1936290408, 1935764852, 875704370},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ قطار الزهور ᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1852402515, 1634882655,1717530217,1769239397,7102838},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ القطار الاسطوريᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515 , 1634882655 , 1751084649 , 1634495589 , 842019443,1814364213},noInput32 = true}, 
{
    name = "𓊆 ★ᯓقطار غاتسبيᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1852402515, 1634882655,1197436521,1651733601,121},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ القطار الفرنسي ᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515, 1634882655,1717530217,1668178290,943087461},noInput32 = true}, 
{
    name = "𓊆 ★ᯓقطار المشاهير ᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515, 1634882655,1667198569,1650814053,2037672306,3356511},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓقطار المستقبل ᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515,1634882655,1717530217,1920300149,909598565},noInput32 = true}, 
}
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
 --مهبط الهيلو--
local bs10Data = {
{
    name = "𓊆 ★ᯓ محطة رسو السفن  ᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1651462751,1811969135},noInput32 = true}, 
{
    name = "𓊆 ★ᯓموقف المزلقةᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1701598047,6842217},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ مهبط خاصᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1952532319,7955059},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ المهبط النباتيᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1918978143,1953719670},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ قصر السلطانᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1634877791,6515042},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ مهبط خمس نجومᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1936020063,7631471},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ ميناء المتجولينᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1634882655,7103862},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ مهبط رياضيᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1869632351,1862300786},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ القصر الملكي ᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1852400479,1701995876,6384748},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ البرج المسكون ᯓ★ 𓊇",
    value24 = 34,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1818323039,1702326124,808611429,13106},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ منصة الكرنفالᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1634886239,7104890},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ مهبط الفصحᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1935762783,846357876,3420720},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ قصر الاعماقᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1819566431,1769238113,115},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ مهبط القراصنةᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1919512671,845509729,3420720},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ مهبط الطائرة الاحتفالية ᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,2037277535,892481586},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ مهبط قاعة الرقصᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1935764831,1919251825,6644833},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ مهبط الديسكوᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1936286815,989884259},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ مهبط الفضاءᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1918987615,842019443,53},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ مهبط الروك اند رولᯓ★ 𓊇",
    value24 = 34,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1919500895,1633970292,808607609,13618},noInput32 = true},
{
    name = "𓊆 ★ᯓ مهبط الكريسماس ᯓ★ 𓊇",
    value24 = 33,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1919443807,1836348265,912225121,55,41},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ مهبط الربيع ᯓ★ 𓊇",
    value24 = 33,
    pointerValues = {1852402515,1818576991,1886348137,1349674356,1701011820,1953849951,1718773108,929003884,49,41},noInput32 = true}, 
{
  name = "𓊆 ★ᯓ المهبط الايطاليᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1852402515, 1818576991, 1886348137,1349674356,1701011820,1635019103,1851877740,3487583},noInput32 = true}, 
}
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--طائرة هيلو--
local bs11Data = {
{
    name =  "𓊆 ★ᯓطبق تربوᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,980379221,1936588850},noInput32 = true}, 
{
    name = "𓊆 ★ᯓموصل آليᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1868722002,1029963892},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ مزلقة سانتاᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515, 1818576991, 1886348137, 1601332596, 1768254547, 842688615},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓطائرة هليوكبتر خاصةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1937006919,1761638754},noInput32 = true}, 
{
    name = "𓊆 ★ᯓطائرة هليوكبتر باذنجانةᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515, 1818576991, 1886348137, 1601332596, 1987207496, 7631717},noInput32 = true}, 
{
    name = "𓊆 ★ᯓبساط طائر ᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1650553409,570450793},noInput32 = true}, 
{
    name = "𓊆 ★ᯓطائرة على شكل أريكة ᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1869833554,755004530},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓالسفينة الطائرةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515,1818576991,1886348137,1601332596, 1986097748,1677749349},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ هليوكبتر دراجةᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515,1818576991, 1886348137, 1601332596,1919905875,1627390068},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓهليوكبتر قرع العسلᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1684957539,1818587749,1811964268},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ المرجل الطائر ᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1819042152,1701148527,842019438,51},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ طائرة ريشيةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515, 1818576991, 1886348137;1601332596;2053206626,570453097},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ قطاعة البيضᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1953718629,808612453,13362},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ غواصة الاعماقᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1634497633,1936290926,1936028672},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ هيلوكبتر القراصنةᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1634888048,808609140,1694512178},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ هيلو كبتر الاحتفاليةᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,846818915,3486256,25},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ هيلوكبتر قاعة الرقصᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1903386989,1634887029,100689252},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ هيلوكبتر الديسكوᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515,1818576991,1886348137,1601332596 , 1668508004,1635188847},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓ هيلوكبتر الفضاءᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1936875885,892481586,1852795136},noInput32 = true},
{
    name = "𓊆 ★ᯓ هيلوكبتر روك اند رولᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1953655106,2036425832,842019423,151650357},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ مروحية الكريسماس ᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1769105507,1634563187,926310259},noInput32 = true},  
{
  name = "𓊆 ★ᯓ مروحية الربيعᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1852402515,1818576991,1886348137,1601332596,1953789282,1818653285,825712505},noInput32 = true},  
{
 name = "𓊆 ★ᯓمروحية إيطاليةᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515,1818576991,1886348137,1601332596, 1818326121, 1601069417,13623},noInput32 = true}, 
}
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--مظاهر الميناء--
local bs12Data = {
{
 name = "𓊆 ★ᯓ ميناء القرصانᯓ★ 𓊇",
 value24 = 15,
 pointerValues = {1852402515,1918978143,1601335138,3232851},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ ميناء استوائيᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1852402515,1918978143,1601335138,3756115},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓميناء جميل ᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1852402515,1918978143,1601335138,1769103728,1827209331},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓرصيف اللوردᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515,1918978143,1601335138,1768842614,1811965283},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓميناء الاهوالᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402515, 1918978143, 1601335138, 1819042152, 1701148527, 842019438, 1031012402, 573976866},noInput32 = true}, 
{
    name = "𓊆 ★ᯓميناء الرومانسيةᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402515, 1918978143, 1601335138, 1701601654, 1852404846, 1631875941, 32112761},noInput32 = true}, 
{
    name = "𓊆 ★ᯓميناء الفايكينجᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515, 1918978143,1601335138,1685221230,1866949481,1845821540},noInput32 = true}, 
{
    name = "𓊆 ★ᯓميناء الغابةᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515, 1918978143,1601335138,1735292266,1845519724},noInput32 = true}, 
{
    name = "𓊆 ★ᯓميناء الكريسماسᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402515, 1918978143, 1601335138, 1769105507, 1634563187, 842019443, 51 },noInput32 = true}, 
{
 name = "𓊆 ★ᯓ ميناء الفوانيسᯓ★ 𓊇",
 value24 = 15,
 pointerValues = {1852402515, 1918978143,1601335138,5852739},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ ميناء قديمᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515, 1918978143,1601335138,1819043176,536900449},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓصالون على الماءᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515, 1918978143, 1601335138, 1684826487, 1953719671, 875704370},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓميناء الحلوىᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515, 1918978143, 1601335138, 1953655138, 2036425832, 875704370},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ الميناء ذو الطابع المصريᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1852402515, 1918978143,1601335138,1887004517,842006644},noInput32 = true}, 
{
    name = "𓊆 ★ᯓميناء القطب الشماليᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515,1918978143,1601335138,1952674401,167797609},noInput32 = true}, 
{
    name = "𓊆 ★ᯓميناء العطلةᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1852402515, 1918978143, 1601335138, 1768713313, 1970037614, 1702259059, 892481586 ,3486208},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ ميناء يابانيᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1852402515, 1918978143,1601335138,1634754922,1130430574,1416520044},noInput32 = true}, 
{
    name = "𓊆 ★ᯓميناء الفارسᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515,1918978143,1601335138,1734962763,1124103272},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ ميناء بورداويᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515, 1918978143, 1601335138, 1634693730, 2036430692, 3749471},noInput32 = true}, 
{
    name = "𓊆 ★ᯓميناء عيد الفصحᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515,1918978143,1601335138,1953718629,929002085,1822490674},noInput32 = true}, 
}
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--مظاهر السفن--
local bs13Data = {
{
 name = "𓊆 ★ᯓ سفينة القرصانᯓ★ 𓊇",
 value24 = 13,
 pointerValues = {1852402515,1768444767,1414750064,49},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓسفينة سياحيةᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1852402515,1768444767,1347641200,57},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓعبارة كرواسونᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1852402515,1768444767,1634754416,7563634},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓجندولᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1852402515,1768444767,1702256496,1701013870},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓسفينة الاشباحᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515, 1768444767, 1634230128, 2003790956, 846095717, 3289648},noInput32 = true}, 
{
    name = "𓊆 ★ᯓقارب الحبᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515, 1768444767, 1635147632, 1953391980, 1936027241, 7954756},noInput32 = true}, 
{
    name = "𓊆 ★ᯓسفينة قويةᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1852402515, 1768444767,1869504368,1667851378,6582087},noInput32 = true}, 
{
    name = "𓊆 ★ᯓسفينة سياحيهᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1852402515, 1768444767,1969905520,1701603182},noInput32 = true}, 
{
    name = "𓊆 ★ᯓقارب الهداياᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515, 1768444767, 1751342960, 1953720690, 846422381, 3355184 },noInput32 = true}, 
{
 name = "𓊆 ★ᯓ قارب التنينᯓ★ 𓊇",
 value24 = 13,
 pointerValues = {1852402515, 1768444767,1313038192,1860501593},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓسفينة يونانيهᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1852402515, 1768444767,1701338992,1935764588},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓباخرة نهريةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515, 1768444767,1769430896,1702323308,808612979,1946170418},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓقارب الحلوىᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515, 1768444767,1768054640,1684567154,808614241,1124086834},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓسفينة ذات الطابع المصريᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1852402515, 1768444767,1734696816,7630969},noInput32 = true}, 
{
    name = "𓊆 ★ᯓسفينة القطب الشماليᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1852402515, 1768444767,1918984048,1667855459},noInput32 = true}, 
{
    name = "𓊆 ★ᯓسفينة العطلةᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515, 1768444767, 1818320752, 1668180332, 1769174380, 808609142},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ السفينة اليابانيهᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1852402515 , 1768444767,1634361200,7233904},noInput32 = true}, 
{
    name = "𓊆 ★ᯓسفينة الفارسᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1852402515, 1768444767,1850433392,1952999273},noInput32 = true}, 
{
    name = "𓊆 ★ᯓسفينة برودوايᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515, 1768444767,1919049584,2003067247,912226657,57},noInput32 = true}, 
{
    name = "𓊆 ★ᯓسفينة عيد الفصحᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1852402515, 1768444767,1634033520,1919251571,3290975},noInput32 = true}, 
}
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--مظهر المطار --
local bs14Data = {
{
 name = "𓊆 ★ᯓالبوابة الجويةᯓ★ 𓊇",
 value24 = 16,
 pointerValues = {1852402515,1919500639,1953656688,860902239},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمطار المهرجانᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1852402515,1919500639,1953656688,928011103},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمطار استوائي ᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1852402515,1919500639,1953656688,961565535},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓمطار الاشباحᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515, 1919500639, 1953656688, 1818323039, 1702326124, 808611429, 1845506354},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓميناء فضائي ᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515, 1919500639,1953656688, 1634759519 ,251684195},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمطار روكᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1852402515, 1919500639,1953656688,1668248159,697892971},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمطار سينمائيᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515, 1919500639,1953656688,1987013983,25961},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمسكن سانتاᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515, 1919500639, 1953656688, 1919443807, 1836348265, 808612705, 1694511666},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمطار الفصحᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515, 1919500639, 1953656688, 1935762783, 846357876, 3355184 },noInput32 = true}, 
{
 name = "𓊆 ★ᯓمطار الحلوىᯓ★ 𓊇",
 value24 = 18,
 pointerValues = {1852402515, 1919500639,1953656688,1702327135,29797},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمركز التزلجᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515, 1919500639, 1953656688, 1852405599, 1400006004, 1953656688},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمطار قوس قزحᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515, 1919500639,1953656688,1701996895,1684955500},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓقاعدة سريةᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1852402515, 1919500639,1953656688,2037412703},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمطار خمس نجومᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402515, 1919500639, 1953656688, 1819042143, 1818455657, 1986622325,101},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمطار السيمفونيةᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402515, 1919500639, 1953656688, 1634493279, 1667855219, 1769174381,825688163},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمطار الموضةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515,1919500639,1953656688,1935763039,1852795240},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمطار دراكولاᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515, 1919500639, 1953656688, 1818314847, 1702326124, 808611429, 838874418},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمطار الكرنڤالᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515,1919500639,1953656688,1918985055,1635150190,808935276},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمطار الطهيᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515,1919500639,1953656688,1819632479,1918987881,876044153},noInput32 = true}, 
}
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--مظهر الطائرة--
local bs15Data = {
{
 name = "𓊆 ★ᯓطائرة فائقةᯓ★ 𓊇",
 value24 = 17,
 pointerValues = {1852402515,1919500639,1851878512,1347641189,6619187},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓتنين خارقᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1852402515,1919500639,1851878512,1347641189,3291703},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓطائرة استوائيةᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1852402515,1919500639,1851878512,1347641189,57},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓطائرة الاشباحᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1852402515, 1919500639, 1851878512, 1634230117, 2003790956, 846095717, 976302640,50},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمركبة إطلاقᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1852402515, 1919500639 ,1851878512, 1886609253 ,6644577},noInput32 = true}, 
{
    name = "𓊆 ★ᯓطائرة روكᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515, 1919500639,1851878512,1869766501,1879075683},noInput32 = true}, 
{
    name = "𓊆 ★ᯓطائرة النجومᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1852402515, 1919500639,1851878512,1869438821,6646134},noInput32 = true}, 
{
    name = "𓊆 ★ᯓطائرة الاعيادᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515, 1919500639, 1851878512, 1751342949, 1953720690, 846422381, 3289648},noInput32 = true}, 
{
    name = "𓊆 ★ᯓطائرة على شكل طائر ᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515, 1919500639, 1851878512, 1634033509, 1919251571, 858927154 },noInput32 = true}, 
{
 name = "𓊆 ★ᯓطائرة الإكلير ᯓ★ 𓊇",
 value24 = 19,
 pointerValues = {1852402515, 1919500639, 1851878512,2004049765,7628133},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓزلاجة هوائيةᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402515, 1919500639, 1851878512, 1769430885, 1919251566, 1919905875, 1953628276},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓطائرة الحظᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515, 1919500639,1851878512,1919508325,1851878501,1701576804},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓطائرة الشبحᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1852402515, 1919500639,1851878512,1886609253,7536761},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓطائرة مائيةᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515, 1919500639, 1851878512, 1818320741, 1668180332, 1769174380, 1811965302},noInput32 = true}, 
{
    name = "𓊆 ★ᯓطائرة السيمفونيةᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515, 1919500639, 1851878512, 1818451813, 1769173857, 1937075555, 25449},noInput32 = true}, 
{
    name = "𓊆 ★ᯓطائرة الموضةᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515, 1919500639,1851878512,1634099045,1869178995,110},noInput32 = true}, 
{
    name = "𓊆 ★ᯓطائرة مصاص الدماءᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515,1919500639,1851878512,1632132965,2003790956,846095717,3486256},noInput32 = true}, 
{
    name = "𓊆 ★ᯓطائرة الكرنڤالᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402515,1919500639,1851878512,1633902437,1986621042,929000545,48},noInput32 = true}, 
{
 name = "𓊆 ★ᯓطائرة  الطهيᯓ★ 𓊇",
  value24 = 25,
   pointerValues = {1852402515,1919500639,1851878512,1969446757,1634625900,929003890},noInput32 = true}, 
}
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--مظهر البقره--
local bs16Data = {
{
 name = "𓊆 ★ᯓبقرة سينمائيةᯓ★ 𓊇",
 value24 = 14,
 pointerValues = {1852402515,2003780447,1987013983,1392534889,1953653108},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالبقرة القزمةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515,2003780447,1919443807,1836348265,808612705,12850},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓبقرة مغازلةᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515,2003780447,1818326623,1769238117,25966},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓالبقرة رائدة الفضاءᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1852402515,2003780447,1918987615,878641267},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓبقرة الاحتفالاتᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515, 2003780447 ,1919509087, 1633970292 ,842019449 , 1719271476},noInput32 = true}, 
{
    name = "𓊆 ★ᯓالبقرة صانعة الحلويات ᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1852402515, 2003780447 , 1702327135 , 3306597},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمو سفيراتوᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515, 2003780447,1818323039,1702326124,808611429,1711289138},noInput32 = true}, 
{
    name = "𓊆 ★ᯓبقرة جبليةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515, 2003780447,1852405599,1400006004,1953656688,1719278336},noInput32 = true}, 
{
    name = "𓊆 ★ᯓبقرة احتفاليةᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1852402515,2003780447,1498301279,859255296},noInput32 = true}, 
{
 name = "𓊆 ★ᯓبقرة الفصح ᯓ★ 𓊇",
 value24 = 19,
 pointerValues = {1852402515, 2003780447,1935762783,846357876,3420720},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓبقرة جاسوسةᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1852402515, 2003780447,2037412703,942956288},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓملكة اطلنتسᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1852402515, 2003780447,1819566431,1769238113,7536755},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓبقرة أنيقةᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515, 2003780447,1635019103,808614252,1996502066},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓبقرة أحتفاليةᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515, 2003780447,1919509087,1633970292,842019449,1701076788,25459},noInput32 = true}, 
{
    name = "𓊆 ★ᯓبقرة القراصنة المعتمدينᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1852402515, 2003780447,1919512671,845509729,3420720},noInput32 = true}, 
{
    name = "𓊆 ★ᯓبقرة القطب الشماليᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1852402515, 2003780447,1668440415,6515060},noInput32 = true}, 
{
    name = "𓊆 ★ᯓبقرة السيمفونيةᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515, 2003780447,1634493279,1667855219,1769174381,125829219},noInput32 = true}, 
{
    name = "𓊆 ★ᯓبقرة الزهورᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1852402515 , 2003780447,1936025183,1635150196,285343852},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓالبقرة اليابانيةᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1852402515 , 2003780447 , 1885432415 , 536899169},noInput32 = true}, 
{
    name = "𓊆 ★ᯓنظارات شمسية الروك اند رولᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515 , 2003780447,1919500895,1633970292,808607609,13618},noInput32 = true}, 
{
    name = "𓊆 ★ᯓالبقرة الفرنسيةᯓ★ ??",
    value24 = 18,
    pointerValues = {1852402515, 2003780447,1634887263,1600480110,14390},noInput32 = true}, 
{
    name = "𓊆 ★ᯓبقرة الكرنڤالᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402515, 2003780447,1918985055,1635150190,808935276},noInput32 = true}, 
{
    name = "𓊆 ★ᯓبقرة المشاهير ᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515, 2003780447,1818583903,1769103973,929003892,1779236915},noInput32 = true}, 
{
    name = "𓊆 ★ᯓبقرة المستقبل ᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515, 2003780447,1953850975,1600483957,1811953207},noInput32 = true}, 
}
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--مظهر الدجاج--
local bs17Data = {
{
 name = "𓊆 ★ᯓدجاجة  طيارهᯓ★ 𓊇",
 value24 = 19,
 pointerValues = {1852402515,1768440671,1852140387,1634890847,7103862},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓدجاجة المهرجᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515,1768440671,1852140387,1701344351,1769108577,7102819},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓدجاجة مشجعهᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515,1768440671,1852140387,1869640543,805336178,12850},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓالدجاجة الخياليةᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515,1768440671,1852140387,1852400479,1701995876,6384748},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالدجاجة المستكشفةᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1852402515, 1768440671 , 1852140.387,1853188703, 6646887},noInput32 = true}, 
{
    name = "𓊆 ★ᯓدجاجة عيد الميلاد ᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515, 1768440671,1852140387,1702327135,29797},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمساعد سانتا الصغيرᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515,1768440671,1852140387,1919443807,1836348265,808612705,13106},noInput32 = true}, 
{
    name = "𓊆 ★ᯓدجاجة جنيةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515, 1768440671,1852140387,1701996895,1684955500},noInput32 = true}, 
{
    name = "𓊆 ★ᯓدجاجة بثوب يونانيᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1852402515, 1768440671,1852140387,1818585183,7561580},noInput32 = true}, 
{
 name = "𓊆 ★ᯓدجاجة في أجازةᯓ★ 𓊇",
 value24 = 25,
 pointerValues = {1852402515,1768440671,1852140387,1819042143,1818455657,1986622325,2037645413,13133},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓدجاجة احتفاليةᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402515,1768440671,1852140387,1919509087,1633970292,842019449,1702101044,7628115},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓدجاجة الحفلاتᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515,1768440671,1852140387,1919509087,1633970292,842019449,2030068532,13133},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓدجاجة الهالوينᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515,1768440671,1852140387,1818323039,1702326124,808611429,2030056498,13133},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالدجاجة الاحتفاليةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515, 1768440671,1852140387,2037277535,892481586},noInput32 = true}, 
{
    name = "𓊆 ★ᯓدجاجة الموضةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515, 1768440671,1852140387,1935763039,1852795240,1696711680},noInput32 = true}, 
{
    name = "𓊆 ★ᯓدجاجة الديسكوᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1852402515, 1768440671,1852140387,1936286815,28515},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓدجاجة الفضاءᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515, 1768440671,1852140387,1918987615,842019443,1696661557},noInput32 = true}, 
   { 
name = "𓊆 ★ᯓنظارات شمسية الروك اند رولᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515,1768440671,1852140387,1919500895,1633970292,808607609,7550258},noInput32 = true}, 
{
    name = "𓊆 ★ᯓدجاجة الروك اند رولᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1852402515,1768440671,1852140387,1919500895,1633970292,808607609,13618},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓدجاجة الفارسᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1852402515, 1768440671,1852140387,1768835935,7628903},noInput32 = true}, 
{
    name = "𓊆 ★ᯓدجاجة الكريسماسᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1852402515,1768440671,1852140387,1919443807,1836348265,912225121,55},noInput32 = true}, 
{
    name = "𓊆 ★ᯓدجاجة برودوايᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515,1768440671,1852140387,1869767263,1635214433,959864697},noInput32 = true}, 
{
    name = "𓊆 ★ᯓدجاجة عيد الفصحᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515, 1768440671,1852140387,1935762783,1601332596,2080387639},noInput32 = true}, 
{
    name = "𓊆 ★ᯓدجاجة الطهيᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515,1768440671,1852140387,1819632479,1918987881,876044153},noInput32 = true}, 
} 
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--مظهر الخراف--
local bs18Data = {
{
 name = "𓊆 ★ᯓالنعجة الساحرةᯓ★ 𓊇",
 value24 = 24,
 pointerValues = {1852402515,1701335903,1751085157,1869376609,1852138871,842149938},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓنعجة مهرجان الرببعᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1852402515,1701335903,1818194021,1918987893,808606030,1811952178},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓنعجة الفصحᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515,1701335903,1700753509,1702130529,842019442,1701642291},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓخروف شماليᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515,1701335903,1851748453,1768190575,1685014371},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالخروف المحققᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515, 1701335903 , 1683976293 , 1667593317 , 1702259060},noInput32 = true}, 
{
    name = "𓊆 ★ᯓخروف عيد الميلاد ᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1852402515,1701335903,1935634533,1952802167,6841088},noInput32 = true}, 
{
    name = "𓊆 ★ᯓبانديت النبيلةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515 , 1701335903 , 1918857317 , 1852400239 , 1685024584 , 7237376},noInput32 = true}, 
{
    name = "𓊆 ★ᯓخروف السامباᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1852402515, 1701335903,1650421861,1769628018,1936261228,6579560},noInput32 = true}, 
{
    name = "𓊆 ★ᯓخروف الروك اند رولᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1852402515, 1701335903,1918857317,1852531567,1819045746,25600},noInput32 = true}, 
{
 name = "𓊆 ★ᯓالخروف المقاتل ᯓ★ 𓊇",
 value24 = 17,
 pointerValues = {1852402515, 1701335903,1801416805,1751607662,1631846516,121},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓعصابة الخرفانᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515,1701335903,2002743397,2003070057,846492517,3420720},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓبيلي بونكاᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515,1701335903,1650421861,1752461929,846815588,3420720},noInput32 = true}, 
 {
   name = "𓊆 ★ᯓخروف أحتفاليᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515,1701335903,1650421861,1752461929,846815588,1932800560},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالخراف المصريةᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1852402515, 1701335903,1700753509,1953528167,6581760},noInput32 = true}, 
{
    name = "𓊆 ★ᯓخروف العيد ميلاد 2ᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515,1701335903,1667199077,1936290408,1935764852,875704370},noInput32 = true}, 
{
    name = "𓊆 ★ᯓخراف قاعة الرقصᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515, 1701335903,1834971237,1970369377,1684107877,101},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓخروف  غاتسبيᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1852402515, 1701335903,1197437029,1651733601,6815865},noInput32 = true}, 
   { 
name = "𓊆 ★ᯓخروف مصاص الدماءᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515,1701335903,1214214245,1869376609,1852138871,892481586},noInput32 = true}, 
{
    name = "𓊆 ★ᯓنظارات شمسية الروك اند رولᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1852402515,1701335903,1113550949,1752461929,1601790308,892481586},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓالخروف الاسطوريᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515, 1701335903, 1751085157,1634495589,842019443,1027407925},noInput32 = true}, 
{
    name = "𓊆 ★ᯓخروف العطلةᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1852402515,1701335903,1633644645,1852402796,1937075299,845510249,3486256},noInput32 = true}, 
{
    name = "𓊆 ★ᯓخروف نجم الروكᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515,1701335903,1650421861,1752461929,846815588,3486256},noInput32 = true}, 
{
    name = "𓊆 ★ᯓخروف الربيعᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1852402515,1701335903,1650421861,1702130805,2037147250,3225439,25},noInput32 = true}, 
{
    name = "𓊆 ★ᯓالخروف الايطاليᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1852402515,1701335903,1767862373,1768710516,929001057,3342389},noInput32 = true}, 
}
--مظهر خنزير--
local bs19Data = {
{
 name = "𓊆 ★ᯓخنزير الكيوبيدᯓ★ 𓊇",
 value24 = 22,
 pointerValues = {1852402515,1734955103,1818326623,1769238117,1148413294,31073},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓخنزير الاحتفاليᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1852402515,1734955103,1498301279},noInput32 = true}, 
}

---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--الديكورات
local bs20Data = {
    {
        name = "𓊆 ★ᯓ أبطال الحديقة الساحرة ᯓ★ ??",
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
        name = "𓊆 ★ᯓ المعرض الزراعي ᯓ★ ??",
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
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
--زينات--
local bs21Data = {
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
    pointerValues = {1667592275,1114399081,1953849701,1918132089,1916953957,1868784495,-1459590804,111},noInput32 = true}, 
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
 name = "𓊆 ★ᯓ ضفدع النقودᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1667592275,1114399081,1953849701,1917214585,1951623023,1702196321,7300608},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ نافورة الشايᯓ★ 𓊇",
  value24 = 34,
pointerValues = {1667592275,1114399081,1953849701,1868980089,1635020405,1918856809,1869902693,1851880053,25972},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ أمير على حصان أبيضᯓ★ 𓊇",
  value24 = 23,
pointerValues = {1701601622,1852404846,1953718117,1702196321,1769107551,6644590},noInput32 = true}, 
{
 name = "𓊆 ★ᯓالتخييمᯓ★ 𓊇",
  value24 = 24,
pointerValues = {1667592275,1114399081,1953849701,1953718137,1702196321,1734963295},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ فوانيس ورقيهᯓ★ 𓊇",
  value24 = 27,
pointerValues = {1667592275,1114399081,1953849701,1749245817,1600220777,1953390956,7238245},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ برج المياةᯓ★ 𓊇",
  value24 = 24,
pointerValues = {1667592275 , 1114399081, 1953849701, 1633116025,1416783220,1919252335},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ البرج المغمور ᯓ★ 𓊇",
  value24 = 27,
pointerValues = {1667592275 , 1114399081, 1953849701,1818648441,1701080943,1869897572,7497079},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ جولة الاقلاعᯓ★ 𓊇",
  value24 = 24,
pointerValues = {1667592275, 1114399081,1953849701,2001952633,1348955753,1701732716},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ طاووس عاشقᯓ★ 𓊇",
  value24 = 24,
pointerValues = {1701601622,1852404846,1701863269,1668244321,1852399467,1702260588},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ قريباᯓ★ 𓊇",
  value24 = 24,
pointerValues = {1634625862,2003128940,1600418401,1685217639,1766026853,1634559342},noInput32 = true}, 
{
 name = "𓊆 ★ᯓملعب جزيرة الكنز  ᯓ★ 𓊇",
  value24 = 24,
pointerValues = {1768711496, 1836403320,1918132080,1970495845,1934189938,1684955500,1969516288,574452835},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ منزل مقلوبᯓ★ 𓊇",
  value24 = 24,
pointerValues = {1769173109,1866753380,1867017847,1600484213,1735292258,2003790945},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ ممارسة البيسبولᯓ★ 𓊇",
  value24 = 24,
pointerValues = {1836674127, 1600350576,1702060354,1819042146,1767993972,1735289198,1701998336,808526397},noInput32 = true}, 
{
 name = "𓊆 ★ᯓ شاليه مريحᯓ★ 𓊇",
  value24 = 24,
pointerValues = {1853189965,1852399988,1818323011,1130329189,1215920751,1702065519,570451200,1040199991},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ بيت العصر الحجريᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1969317218,1885305204,1768449394,1919906931,1751081833,1702065519},noInput32 = true}, 
{
    name = "𓊆 ★ᯓكرة بلازماᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1969317218,1700755828,1919250552,1852140905,1819303796,1634562913},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ منحوتة الحب الابدي ᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1701601622,1852404846,1701338981,1601466977,1701078384, 1818326131},noInput32 = true}, 
{
    name = "𓊆 ★ᯓحوض سمك يوناني ᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1635086657,1836411250,1634497601,1667855470,1668178271,1953391977},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ عربية ممتلئة بالهداياᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275,1114399081,1953849701,1631936377,1919251571,1651341651,27759},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓتمثال الارنب الموهوبᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275,1114399081,1953849701,1631936377,1919251571,1650614610,29801},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ مصباح الاشباحᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275,1114399081,1953849701,1632395129,1919251566,1869105006,29811},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ الديك الناريᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1667592275,1114399081,1953849701,1768316793,1869768050,1702130543,114},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓعجلة قرع العسل ᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275,1114399081,1953849701,1968201593,1768648813,1701336942,27749},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓعربة المطاردةᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275,1114399081,1953849701,1867014009,1919906418,1936879432,29541},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓتمثال زنجبيل الخبز ᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1769105475,1634563187,1766285171,1919248238,1634038370,1851870564},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓشجرة شبكة العنكبوتᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1667592275,1114399081,1953849701,1884512121,1919247465,1701147220},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ الثور الآليᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1667592275,1114399081,1953849701,1699569529,1851877475,1818321769,1701080914, 111},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالبرج الفلكيᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1667592275,1114399081,1953849701,1933664121,1819243124,1919248239,1702326100,114},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمنطاد القبعة الطاهيᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275,1114399081,1953849701,1751342969,1650419301,1869376609,28271},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓبالون عيد مدينة سعيدᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1667592275,1114399081,1953849701,1768054649,1684567154, 1650424161, 1869376609,548864110},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ الحانةᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1667592275,1114399081,1953849701, 1699569529, 1986357604,1632922729,1852990838,97},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓمدينة راعي البقر ᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1667592275,1114399081, 1953849701, 1750359929,1214604658,1702065519,115},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓموقع التخيمᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1667592275,1114399081,1953849701,1866620793, 1919510126, 1835090789,112},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ العربة الملكيةᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1667592275,1114399081,1953849701, 1699569529;1986357604,1631808617,1734963826,101},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالصندوق المقدسᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275, 1114399081,1953849701,1666146169,1970302836,1701331827,29811},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓسفينة أديسيوسᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1969317218,1935636852,1433430376,1936947564,1633645413,1701405550, 29806},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ دوامة خيل الاعيادᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1769105475,1634563187,1918976883,1702065519,72876140},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ حوض سمك اطلنطي ᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1969317218,1633646964,1851878516,1601399156,1635086689,1836411250},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓ كيوبيدᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1701601622, 1852404846,1951620965,1702196321,1600548703,1768977763,100},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓتوبيار شاعريᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1701601622, 1852404846,1869897573,1918986608,1701339001,1937011297},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓنافورة الغرامᯓ★ 𓊇",
    value24 = 30,
    pointerValues = {1701601622, 1852404846,1868980069,1635020405,1700753001,1852990836,1869376609,25974},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓحانة القراصنةᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275, 1114399081,1953849701,1766875001,1702125938,1702256980,28274},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ استراحة اطلنطيهᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1969317218, 1633646964,1851878516,1601399156,1819635554,1918989925,100 },noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ جهاز عرض ثلاثي الابعادᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1969317218, 1700755828,1919250552,1852140905,1919967092,1667590767,7499636},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ مركز أبحاثᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1969317218, 1700755828,1919250552,1852140905,1634492276,1634889570,2037542772},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمقهى آيس كريمᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1667592275, 1114399081,1953849701,1667850105,1919115109,1601003877,1701208419},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ جسر الفاكههᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1667592275, 1114399081,1953849701,1917214585,1114925429,1734633842,101},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمشتل ازهار ع شكل طاووسᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1667592275, 1114399081,1953849701,1766023033,1631877492,1634754425,1852402806},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓتوبياري عيد الفصحᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1667592275, 1114399081,1953849701,1631936377,1919251571,1768976212,7959137},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓشجرة عيد الفصحᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1667592275, 1114399081,1953849701,1631936377,1919251571,1935754591,1416783220,6645106},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓحانة الكمثرىᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1667592275, 1114399081,1953849701,1917214585,1265920373,1802727273},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓصياد محظوظᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1667592275,1114399081,1953849701,1951620985,1702196321,1752394054,1634562661,110},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ لوحة الغواصᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1969317218, 1147107700,1852.405353,2003784807,1868526181,1886222700,6578537,111},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓ قط الحظᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275, 1114399081,1953849701,1749245817,1600220777,1701732717,-1459590805, 111},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓ بيت التوابلᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1851877492, 1768387435,1735289206,1734702687,1650553957,1867015532,6648693,111},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓالتنين الاحمرᯓ★ 𓊇",
    value24 = 30,
    pointerValues = {1667592275, 1114399081,1953849701,1751342969,1600220777,1734439524,808611439,14129},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓتوباري البيضᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1667592275, 1114399081,1953849701,1869897593,1918986608,1734696825,-1447952281, 111},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓشجرة المصباحᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1667592275,1114399081,1953849701,1749245817,1600220777,1751607660,1701991540, 101},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓطائره تجريبيهᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1969317218, 1885305204,1701732716,1970239071,1601464423,859255158,-1448234752},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓقبو مخيفᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1969317218, 1751087476,1869376609,1852138871,1633907551,1667201394,1953528178},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ يخت عالقᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1667592275, 1114399081,1953849701,1816223609,1920229730,1332966255,1634681454,116},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓبيضة فابرجيᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1667592275, 1114399081,1953849701,1631936377,1919251571,1650542175,1701278309,6776645,131330},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓعرش صاحب الجلالةᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1667592275, 1114399081,1953849701,1766547321,1416849262,1852797544,-1445068699, 111},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓنموذج غواصة الاعماقᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1667592275, 1114399081,1953849701,1631739769,1937336436,1752195427, 1702259012},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ اصدقاء متمارسون بالطيرانᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1667592275, 1114399081,1953849701,1968332665, 2036430702 , 1886546241 , 1701732716},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ الغواصᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1667592275, 1114399081,1953849701,1819303801, 1701277301 , 1986610290 , -1442709403, 111},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓلعبة جهاز الطيرانᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1667592275 , 1114399081, 1953849701 , 1900109689 , 1769234805 , 1952795235 , 1801675120},noInput32 = true},   
   {
    name = "𓊆 ★ᯓالطاهيᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1667592275, 1114399081, 1953849701, 1951620985 , 1702196321 , 1750361679 , 1869562725 , 107},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓدوامة خيل تحت الماءᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1667592275 , 1114399081, 1953849701 , 1699962745 , 1918976865 , 1702065519 , -1442774932, 111},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ البرج المغمور ᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1667592275 , 1114399081, 1953849701 , 1818648441 , 1701080943 , 1869897572 , 7497079,111},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓقرية الغابةᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1969317218,1784641908, 1818717813 , 1769103205 , 1752327542 , 1702065519},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ بيتسي رائدة الفضاءᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1969317218 , 1935636852, 1701011824 , 1936679775 , 1634627437 , 1667200117 , 30575},noInput32 = true},
 {
    name = "𓊆 ★ᯓحديقة مائية قطبيةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1969317218, 1767864692,1700947299;1885300594,1969712741,151023209},noInput32 = true},  
 {
    name = "𓊆 ★ᯓأفيال سعيدةᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1969317218,1700755828,1752196460, 1937010273,1885956096},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓقوس بالون الحبᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1969317218,1633646964,1600676722,1819042146,7237487},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓسهم كيوبيدᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1701601622, 1852404846,1967349605,1935960432,1869771329,-419757961},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓسياج عيد الفصحᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1953718597, 1717531237,1701015141},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ ارجوحة عيد الفصحᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1953718629 , 1632137829 , 1668246893 , 413204587,930897750},noInput32 = true},
  {
    name = "𓊆 ★ᯓ أرجوحه دوارةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701601622, 1852404846,2001952613,1600613993,1702260588,1744860018},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ طائرة برمائيةᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1667592275,1114399081,1953849701,1819303801,1097166433,1768452205,1851877730},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ لعبة السيارات الاصتداميةᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1667592275,1114399081,1953849701,1983995769,1950445428,1667330676,1852795252},noInput32 = true},
{
    name = "𓊆 ★ᯓمنزل صيادᯓ★ 𓊇",
    value24 = 30,
    pointerValues = {1667592275,1114399081,1953849701,1768316793,1919248499,1936613741,1970235487,25971},noInput32 = true},
{
    name = "𓊆 ★ᯓبطولة الجرافيتيᯓ★ 𓊇",
    value24 = 27,
    pointerValues = {1969317218,1734310260,1717985650,1600746601,1886220131,1953068133,7237481},noInput32 = true},
{
    name = "𓊆 ★ᯓ كوخ صانع الطعومᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1969317218,1935636852,1869111653,1600484213,1868784996,1769234802,28271},noInput32 = true},
{
    name = "𓊆 ★ᯓالمنطقة الاستوائية المريحةᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1868787555,1098151278,1751346546,1601333601,1735292258,2003790945},noInput32 = true},
{
    name = "𓊆 ★ᯓ لعبة الشلالᯓ★ 𓊇",
    value24 = 29,
    pointerValues = {1702125943,1818322546,1869438828,1635020405,1935634025,1768321653,1919248238,115},noInput32 = true},
{
    name = "𓊆 ★ᯓملعب جزيرة الكنز ᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1768711496,1836403320,1918132080,1970495845,1934189938,1684955500},noInput32 = true},
{
    name = "𓊆 ★ᯓ منزل هاسكي ᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1853189965,1852399988,1818323011,1214215269,2037085045,1937076040,101},noInput32 = true},
{
    name = "𓊆 ★ᯓشاليه ثلجي مريحᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1853189965,1852399988,1818323011,1130329189,1215920751,1702065519},noInput32 = true},
{
    name = "𓊆 ★ᯓ السيد كعك الزنجبيل ᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1735289159,1919054437,1298424165,1867017825,1869103988,1634496355,25972},noInput32 = true},
{
    name = "𓊆 ★ᯓ متجر هدايا الاعيادᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {808465457,1919435615,1836348265,1147106145,1919902565,1869182049,110},noInput32 = true},
{
    name = "𓊆 ★ᯓ أخطبوط قابل للنفخᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1667592275,1114399081,1953849701,1818648441,1952665465,1937076335},noInput32 = true},
{
    name = "𓊆 ★ᯓ بطريق قابل للنفخᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1667592275,1114399081,1953849701,1818648441,1852133497,1852405095},noInput32 = true},
{
    name = "𓊆 ★ᯓفراشة قابلة للنفخᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275,1114399081,1953849701,1818648441,1953841785,1718773108,31084},noInput32 = true},
 {
    name = "𓊆 ★ᯓحديقة المغامرةᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1868784964,1918132082,1867015525,6648693},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓسينما خارجيهᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1701999731, 1766028389,1634559342,1801544543,1869116261,545914992},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ حوض أسماك سعيدᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1886413128, 1900109689,1769103733,1342205301,7041633},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓزقاق سحري ᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1769105475,1634563187,1920229235,7235937},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓجسر لشخصينᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1769105475,1634563187,1634882675,1113550441,1734633842,1593835621},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓمتجر الاعيادᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1769105475,1634563187,1632001907,29289},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓالينابيع الساخنهᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1601466184,1853189958,1852399988},noInput32 = true}, 
     {
    name = "𓊆 ★ᯓمسار الحبالᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1868784964,1867669362,1634755952,27506},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓالكريسماس في القطار ᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1769105475,1634563187,1631805299,25958},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓزينه الفرعونᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1937076040,2036811109,1634301040,110},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓ زينة المصرين  ᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1936288627,1601662787,1836674159,1684105584,6647296},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓسفينة الكنزᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1634888048,1750295924,1952411753,1935762802,6648437},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓرمح اطلنطي ثلاثي ᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1969317218,1633646964,1935764596,1851877471,855638116},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓالكرلنجᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1819440483,1600613993,1852732786,29285},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓ اطلال اطلانطسᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1969317218,1633646964,1851878516,1601399156,1852405106,7798899},noInput32 = true},
 {
    name = "𓊆 ★ᯓحارس الكنز ᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1751344493,1734439492,1834970735,1701405797,7102838},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓالتابوت الحجريᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1969317218,1683978612,1936682601,7501153},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓصندوق الكنز ᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1969317218,1952414068,1935762802,1600483957,1936025699,934805620},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓحارس فائقᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1634888048,1951622516,1702196321,1701999711,1920299873,6619237},noInput32 = true}, 
     {
    name = "𓊆 ★ᯓمنجم الذهبᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1684827975,1734952031,1936876903},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓحارس الثروةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1734439524,1935634031,1970561396,1347641189,808466527},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓالقطة المحبوبةᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1701601622,1852404846,1819303781,1600680821,7627107},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓأرنب محشوᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1701601622,1852404846,1967284069,7958126},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓمقعد المحبينᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701601622,1852404846,1869373285,1936876918,1852138079,822110307},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓمشتل ازهار الملائكةᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1701601622,1852404846,1816551269,1919252335,6579554},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓدب كيوتᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1701601622,1852404846,1700028261,1601791076,1918985570},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓشجرة مجذبهᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1701601622,1852404846,1867800421,1918986608,2029650041},noInput32 = true},
 {
    name = "𓊆 ★ᯓقلب احمر ᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1701601622,1852404846,1818648421,1919252335,6579554},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓزينة عيد الحب وحيد القرنᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1937075312,1768838504,1852993379,1818326623,1769238117,2130732398},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓقلب عيد الحب ᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1918985576,1701991540,1635147621,1953391980,6647401},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓخروف مرسال الحب ᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1701601622,1852404846,1869635429,1752396915,7365989},noInput32 = true}, 
     {
    name = "𓊆 ★ᯓتمثال اللحن الغرامي ᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1701601622,1852404846,1702059877,1634624882,1090544996},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓمنطقة صور زوجين رائعةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1953458288,1635013487,1985963118,1852140641,1701734772},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓحمام عاشقᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701601622,1852404846,1768972133,1852794215,1869373299,905995638},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓعربة نقلᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1701601622,1852404846,1869373285,1936876918,1918985055,828309620},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓمركبة حربيةᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1634561906,1751342958,1869181537,116},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓقلب عيد الحبᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701601622,1852404846,1701338981,1232368225,1851869294,352351076},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓقلوب طائرةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1450798182,1852140641,1701734772,1819042114,1936617327},noInput32 = true},
 {
    name = "𓊆 ★ᯓمتزوجون حديثاًᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1701601622,1852404846,1969905509,1632466035,1701409394,2102657124},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓكيوبيد عين النسر ᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1450798182,1852140641,1701734772,1768977731,848494692},noInput32 = true}, 
     {
    name = "𓊆 ★ᯓقوس الحب ᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1701601622,1852404846,1869373285,1918985590,2030069859},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓورشة عمل عيد الفصحᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1953718629,1717531237,1869898593,1174436210},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓمتاهة عيد الفصحᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {2036490604,1953393010,1634033512,1919251571},noInput32 = true}, 
     {
    name = "𓊆 ★ᯓمتعة عيد الفصحᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1953718629,1869116005,1600484213,1701147252},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓسياج مرجاني ᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1634497601,1936290926,1852139103,25955},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓمدرسة السحر ᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1819042120,1701148527,825242222,1667580983,29295},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓفزاعةᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1751344493,1634890835,1851878775},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓمحطة قطبية ᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1969317218,1885305204,1918987375,1952543827,7237481},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓمتجر الورق البردي ᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1717662307,1634562932,1919899502,1735289195,2036819295,1442870384},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓتمثال بوسيدونᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1969317218,1885305204,1768256367,7237476},noInput32 = true},
  {
    name = "𓊆 ★ᯓمباراة الشطرنجᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1936025699,1918984051,1667850849},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓالواحةᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1650553441,1868522345,1936290657},noInput32 = true}, 
     {
    name = "𓊆 ★ᯓمستكشفو الاعماقᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1969317218,1935636852,1918853477,1634038629,1701340018,1694528370},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓتمثال الفرعونᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1887004485,1634226292,1752129906,1952543827,1107322229,7627119},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓرامي القرصᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1668508004,1750365045,1702326130,1851875186,1852139875,1261502580},noInput32 = true}, 
     {
    name = "𓊆 ★ᯓراية الطبخ الرائعة ᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1667592275,1114399081,1953849701,1631739769,1919250030},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓمصعد التزلجᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1969317218,1918859636,1701736053,1633902450,1667591266,29281},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓغرفة الرعب ᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1819042152,1701148527,1970102126,1836410227},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓرقم 3ᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1969317218,861895028,1818321503,7237484},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓمنزل طائر  ᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1969317218,1717533044,1867020652,6648693},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓكلب قابل للنفخᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1969317218,1683978612,1650419567,1869376609,1869086830},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓشجرة قابلة للنفخᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1969317218,1952414068,1600480626,1819042146,855666287},noInput32 = true},
    {
    name = "𓊆 ★ᯓعنكبوت آليᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1667592275,1114399081,1953849701,1634754425,1752132469,1577084015},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓطائرةᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1667592275,1114399081,1953849701,1768054649,1634496623,1679884398},noInput32 = true}, 
     {
    name = "𓊆 ★ᯓطاحونة الشكولاتةᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1668245571,1952541807,1667319397,2037542772,1868784964,1433010290},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓخنزير قابل للنفخᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1667592275,1114399081,1953849701,1818648441,1734955129},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓخروف قابل للنفخᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1667592275,1114399081,1953849701,1818648441,1701335929,167800933},noInput32 = true}, 
     {
    name = "𓊆 ★ᯓنافورة الرقم القياسي الجديدᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1969317218,1331657076,1886222700,1866883945,1635020405,1342205545},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ مفتاح القلب ᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1701601622,1852404846,1701535589,121},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓ معسكر القراصنةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1969317218,1885305204,2037674593,1919512671,1936028769},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓعيد الربيعᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1953718629,1767010917,1852793442,7209075},noInput32 = true}, 
    {
    name = "𓊆 ★ᯓمشتل الازهار ᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1701601622,1852404846,1816551269,1919252335,6579554},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓبيت الارنب ᯓ★ 𓊇",
    value24 = 11,
    pointerValues = {1953718597,1951625829,7368053},noInput32 = true},
  {
    name = "𓊆 ★ᯓ مزرعة العنب ᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1953718597,1767273061,1635345774,167797874},noInput32 = true}, 
{
    name = "𓊆 ★ᯓسكة حديد عيد الفصحᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1953718629,1632793189,1869769833,1459643489},noInput32 = true},
{
    name = "𓊆 ★ᯓبحيرة زهور الزنبق الاحمر ᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1281647986,1701407849,1852788851,2014904420},noInput32 = true}, 
{
    name = "𓊆 ★ᯓالعرش القديمᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1869768820,1632134510,1834970220,1701405797,7102838},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمعرض الازياءᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1752392006,1601073001,1953853250,1702195561},noInput32 = true}, 
{
    name = "𓊆 ★ᯓبستان التفاحᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1819308097,1632067429,1852138610},noInput32 = true}, 
{
    name = "𓊆 ★ᯓالسوق المتنقل ᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1768058701,1298097516,1701540449,116},noInput32 = true},  
{
    name = "𓊆 ★ᯓ مقهى المكوكᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1969317218,1935636852,1701011824,1969779551,1701606516,3716864},noInput32 = true}, 
{
    name = "𓊆 ★ᯓحصان طروادهᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1785688692,1867017825,1600484210,1768124001,7630437},noInput32 = true}, 
{
    name = "𓊆 ★ᯓجذع عيش الغرابᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1969317218,1700755828,1702130529,1953718130,7368053},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمنزل الاقزامᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1969317218,1700755828,1751082604,1702065519,1845519616},noInput32 = true}, 
{
    name = "𓊆 ★ᯓسوق رصيف الصيدᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1969317218,1717533044,1600680809,1802658157,29797},noInput32 = true},
 {
    name = "𓊆 ★ᯓشجرة الجزر ᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1851877492 , 1768387435,1735289206,1918976863, 1416916850, 6645106},noInput32 = true},
 {
    name = "𓊆 ★ᯓ الطاحونة المائيةᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1667592275,1114399081,1953849701,1633116025,1299342708,7105641},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمقدمة قرصان السفينةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1969317218, 1885305204, 1952543337,1752391525,1650421865,1862301551},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ جسر لشخصين ᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1769105475,1634563187,1634882675,1113550441,1734633842,1752170597},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓلعبة الاخطبوط الدوارةᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1869766979,1818588021,1952665439,1937076335},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓسياج عيد الميلادᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1769105475, 1634563187,1701207923,6644590},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالعجلة الدوارة ᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1869767011, 1818588021,1853190751,7497070},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمصابيح عائمةᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1283026022, 1702129249, 1935634034,1635020385,1852796416},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓوردة خياليةᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {2003790950 , 1851093605, 1215456612,6582127},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓشجرة عيد الميلادᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1769105475 , 1634563187,1918197619,1601069410, 1701147252,6644736},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓالمصباح السحريᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1650553441 , 1784636265,1818193513,7368033},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓقلعة الجليدᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1969317218 , 1767864692,1667196259,1819571041,1868955749},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓتمثال الشمس ᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1667592275 , 1114399081,1953849701,1968398201,1679229038},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓنافورة جنية مزهريةᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1919508806 , 1866882937, 1635020405, 1946185321,29295},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالنحلة الطائرةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1667592275 , 1114399081,1953849701, 1698848633,1818841189,29807},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓسفينة مسكونةᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1969317218, 1734310260, 1953722216,1768452959,2125463664},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓسحر السينماᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1835821414 , 1768644973, 1952409454,1935762802,6648437},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓثمثال جليدي حيوان الرنهᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1969317218,1767864692,1698981219,1493201509,943368753},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓنافورة شجرة الحياةᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1853189990,1852399988,1701999711,101},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓالكرة الثلجيةᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {2037867854, 1198678373,1700949868,169594880},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ الحدائق المعلقةᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1685217639, 1601400421,1650553441,25449},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓبوابة الزهور ᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1969317218 , 1180662132,1702326124,1634164594,7562612},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓسياج الزهورᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {2003790950 , 1717531237,1701015141},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ الحب الخالدᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701601622 , 1852404846,1701338981,1232368225,1851869294, 29540},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓنافورة الربيعᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1953718597 , 1717531237,1953396079,7235937},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمرساة الامبرياليةᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1667592275,1114399081,1953849701,1851875193,7499619},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓكتاب الطبيعةᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1802465122, 1701147220,1853188703,6646887},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ السفينة الطائرةᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1769565286, 1750296430,1952411753,1935762802,6648437},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓبحيرة الطبيعة الامᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1684959088,1953459551,1601332584,1953653093,104},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓشجيرة مشدّبةᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1701601622 , 1852404846,1867800421,1918986608,1320747129},noInput32 = true},
  { 
 name = "𓊆 ★ᯓمكتب سانتاᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1953390931,1699897185,1953523043,7237481},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓكوخ رجل الثلجᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1851877703,1850957684,1634563951,110},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓجوقة الاعيادᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1769105475,1634563187,1749245811,1937076847,7300608},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓ محطة الاتصالات ᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1852731203,1601463141,1952543827,7237481},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓسيف في حجر ᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1667592275,1114399081,1953849701,2017812345,1768710499,7501154},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ حورية البحرᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1667592275 , 1114399081,1953849701,1701666681,1767992690,1040187492},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالجسر الزجاجي ᯓ★ 𓊇",
    value24 = 11,
    pointerValues = {1935764551 , 1769095795,6645604},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ نافورة الفيلمᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1969317218, 1298102644,1701410415,1853189958,1852399988},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ جنيّة الماءᯓ★ 𓊇",
    value24 = 11,
    pointerValues = {1919508838,1635213177,7497076,2197209},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالبوابة الجليديةᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1097163625 , 1600676722,1952674401,1442866025,13960537},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ المدينة الغارقةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1751347809 , 1819239777,1601791855, 1634497633,1936290926},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ الماموث المتجمدᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1835884909 , 1600681071,1668571501,13160},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓجسر فينيسي ᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1818323282 , 1113550708,1734633842,7274597},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالنافورة التفاعليةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1869377379 , 1970226802,1767994478,1634557806,862479220},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓشرفة الشلال ᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1701208387 , 1952536415,1634103909,27756},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓبركة سمك الشبوطᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1684959088 , 1953068895,1633902440,28786},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓزيارة الدلافينᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1969317218 , 1683978612,1752198255,7564905},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ فندق اطلنطسᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1969317218 , 1633646964,1851878516,1601399156,1702129512,828702828},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ حوض سمك المدينة ᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1667592275 , 1114399081,1953849701,1900109689, 1769103733, 855666037},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓدليل البحر ᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1835820392 , 1666151525, 1970302836, 1851875187,1852139875,583729268},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓمنطقة تصوير الزوجين الرائعينᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1953458288, 1635013487,1985963118,1852140641,1701734772},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓكيوبيد عين النسر ᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1450798182,1852140641,1701734772,1768977731,824967268},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓفتاة الربيعᯓ★ 𓊇",
    value24 = 31,
    pointerValues = {1667592275,1114399081,1953849701,1631936377,1919251571,1919963999,1197960809,7107177},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓعربة الزهورᯓ★ 𓊇",
    value24 = 34,
    pointerValues = {1667592275,1114399081,1953849701,1633050489,1953391980,1600482921,2003790950,1633907301,29810},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ بركة بها أوز ᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1701601622,1852404846,1867538277,2002740334,1600681065,1851881331,458867},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ الشراع الذهبيᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1835100259,1852795248,1886741343,1664970240},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمطعم البيتزا ف الهواء الطلقᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1969317218,1885305204,1702525545,1600219506,1953718640,1701642337},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓانشطة شتويةᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1735288176,1231972725,1869112675,2019517804,846422381,3289648},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓساحة الكريسماس ᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1769105507,1634563187,1634488435,2019517795,846422381,3289648},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ دوامة خيل طائرةᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1869767011,1818588021,1818585183,1744861289},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ حفل شاطئيᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1735550285,1698968165,1634889571,1852795252,1073754417},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓموسم الاعيادᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1769105507,1634563187,1836008307,6778473},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ متجر الاعيادᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1769105475, 1634563187, 1632001907,29289},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمنزل  السانتاᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1769105475 , 1634563187,1632853875,1600222318,1937076040,198246501},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓمنزل البحيرةᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1969317218 , 1818196340,1600482145,1937076072,713359461},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓرجل الثلجᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1769105475 , 1634563187,1850957683,1634563951,621871214},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓسياج البحر ᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1180788051 , 1701015141,1852139103,25955},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ الجعرانᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1918985075 , 1700749921,1953528167,286383360},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓهرم خوفوᯓ★ 𓊇",
    value24 = 12,
    pointerValues = {1887004485 , 1920553076,1684630881},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓخنزير يابانيᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1852401731 , 1315271525,1768972121,1635013479,6649204},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓفرس البحرᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1667592275 , 1114399081,1953849701,1702059897,1919903841,25971},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓورشة النحاتᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1819632499,1919906928,1668178271,1953391977,1868983808},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓخيمة الجنةᯓ★ 𓊇",
    value24 = 11,
    pointerValues = {1769169263 , 1734696819,7630969,65280},noInput32 = true}, 
     {
    name = "𓊆 ★ᯓمينوتورᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1869506925 , 1920295284,1668178271,1953391977,49344512},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓشارع الحلوىᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1969317218,1667201396,1635021935,1751082343,7238255},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓرقصة التنينᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1969317218 , 1683978612,1869046130,1633967982,6644590},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓحلبة التزلج على الجليدᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1969317218 , 1935636852,1836543854, 1935634017, 1702125931,16842866},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓتمثال بطل العالمᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1969317218 , 1180662132,1651797871, 1147956321,1124099951},noInput32 = true}, 
{
    name = "𓊆 ★ᯓحارس مرمى منهكᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1969317218,1197439348,1802264943,1701864805,1886322802},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓمتزلجونᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1969317218,1398765940,1702126955,1685221218,1667329104,41943141},noInput32 = true},
 {
    name = "𓊆 ★ᯓمتجر الذكرياتᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1969317218, 1935636852,1702262127,1601333614,1886349427,65280},noInput32 = true},  
  {
    name = "𓊆 ★ᯓمنحدر بلا نهايةᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {2003791475,1918988130,1970429796,1919250030},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓتمثال النصر ᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1936288627,1601662787,1836674159,1684105584,6647296},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ المضمار المنزلجᯓ★ 𓊇",
    value24 = 13,
    pointerValues = {1935830850,1734960492,1667322472,101},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ حلبة الهوكي ᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1801678696, 1766226277,1600416869,1852732786,1845523045,7497070},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓمنزل الحلوىᯓ★ 𓊇",
    value24 = 18,
    pointerValues = {1969317218,1667201396,2036624993,1970235487,1711302003,111},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓجسر الحلوىᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1969317218, 1667201396,2036624993,1769103967,6645604,111},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓجبل الحلوى ᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1969317218, 1935636852,1952802167,1818847327},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ الغواصةᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1969317218 , 1935636852 , 1634558581,1701734770,7300608},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓشجرة الورديةᯓ★ 𓊇",
    value24 = 19,
    pointerValues = {1969317218, 1918859636,1868853096,1684956516,7237490},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓشجرة نبات الوسترياᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1969317218 , 2002745716,1702130537,6383986},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓشجرة البونسياناᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1969317218, 1683978612,1852796005,30825},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓشجرة الارجوانيᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1969317218, 1633646964,1969709426,2036690529},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ نخيل البلحᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1969317218, 1717533044,1667853929,1818325087,958201965},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓشجرة الصنوبر الياباني ᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1969317218, 1885305204,1600482921,1701147252,7237376},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓشجرة السكويةᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1969317218, 1935636852,1869967717,24937},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓتمثال المحبينᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1701601622 , 1852404846,1951620965,1702196321,1987005535,7565925},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓ الكشك الرومانسيᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1701601622,1852404846,1632067429,1868719482,1987013727,7565925},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓأفضل تمثال عمدة 9ᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1953655138,2036425832,1701734766,1868784964,1769234802,1694527087},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓشجرة احتفاليةᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1769105507 , 1.634563187, 1701991539,1836605285,808612705,-654298574},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓحلبة تزلج السناجبᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1969711462, 1800627570,1852404833,1836605287,808612705,-671075790},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ الفيلا المائيةᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1702125911,1853178482,1869373799,961565559},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓخيمة ملونةᯓ★ 𓊇",
    value24 = 11,
    pointerValues = {1650553409,1415537513,7630437},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓمركب ورق البردي ᯓ★ 𓊇",
    value24 = 16,
    pointerValues = {1887004485,1885425780,1937076857,1952542530},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ الجسر الاحمر  ᯓ★ 𓊇",
    value24 = 23,
    pointerValues = {1667592275 , 1114399081,1953849701,1701994361,1769095780,6645604},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓالاسد الصيني ᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275,1114399081,1953849701,1749245817,1600220777 ,1734439524,1711304303},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓوعاء الثروةᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1667592275, 1114399081,1953849701,1702322041,1752460385,2003788383,-660144020},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓتمثال القردᯓ★ 𓊇",
    value24 = 26,
    pointerValues = {1667592275, 1114399081,1953849701,1749245817,1600220777,1802399597,1929410917},noInput32 = true},
  {
    name = "𓊆 ★ᯓالسمكة الذهبيةᯓ★ 𓊇",
    value24 = 24,
    pointerValues = {1667592275,1114399081,1953849701,1749245817,1600220777,1752394086,1701013760},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓالمنزل الصيني ᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1667592275, 1114399081,1953849701,1749245817,1600220777,1937076072,841744485},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓحلبة التزلج على الجليدᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1969317218, 1935636852,1836543854,1935634017,1702125931,8126578},noInput32 = true},
 {
    name = "𓊆 ★ᯓقرية الفاكههᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1769304678,1918980212,1852530539,6645353},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓعربة الاشباحᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1936681063,1132031092,1769108065,6645601},noInput32 = true},  
 {
    name = "𓊆 ★ᯓمحارة اللؤلؤةᯓ★ 𓊇",
    value24 = 25,
    pointerValues = {1667592275,1114399081,1953849701,1868783481,1701604195,1818585203,6815852},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓركوب البحر الجامحᯓ★ 𓊇",
    value24 = 21,
    pointerValues = {1885956211,1920234561,1769235297,1885302383,1952543337,572784741},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمكتب المأمورᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701869637, 1769236836,1698983535,1634889571,1852795252,14131},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓنادي الجاز ᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1701869637, 1769236836, 1698983535,1634889571,1852795252,14387},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓحارس الثروةᯓ★ 𓊇",
    value24 = 20,
    pointerValues = {1734439524, 1935634031, 1970561396,1347641189,808466527},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓنافورة البرتقالᯓ★ 𓊇",
    value24 = 14,
    pointerValues = {1667855722,1868980069,1635020405,28265},noInput32 = true}, 
   {
    name = "𓊆 ★ᯓساحة رقص زهريهᯓ★ 𓊇",
    value24 = 17,
    pointerValues = {1667327330 , 1633967976 , 1600480110 , 1869573222 , 1768226930 , 7628903},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓمقهى عصير شجر النخيل ᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1667327330, 1634754408,1601795186,7496034},noInput32 = true}, 
  {
    name = "𓊆 ★ᯓنادي الغواصه الصفراءᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1667327330 , 1702453096 , 2003790956 , 1651864415 , 1769103725 , 1929405806},noInput32 = true},
 {
    name = "𓊆 ★ᯓتشكيلة فواكهةᯓ★ 𓊇",
    value24 = 15,
    pointerValues = {1667327330, 1919311720,1601464693,7891309},noInput32 = true},  
 {
    name = "𓊆 ★ᯓمركز أبحاثᯓ★ 𓊇",
    value24 = 28,
    pointerValues = {1969317218 , 1700755828,1919250552,1852140905,1634492276,1634889570,2037542772},noInput32 = true}, 
 {
    name = "𓊆 ★ᯓ النهر الجليديᯓ★ 𓊇",
    value24 = 22,
    pointerValues = {1969317218,1767864692,1700947299,1885300594,1969712741},noInput32 = true}, 
  
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
{ 
 name = "𓊆 ★ᯓ الرقم السحري ᯓ★ ??",
    directValues = {2003127824,1634031967,114},noInput32 = true},
{
  name = "𓊆 ★ᯓ طيار عاشق ᯓ★ 𓊇",
    directValues = {1987013650,1852397413,29543}, noInput32 = true}, 
{
    name = "𓊆 ★ᯓ نفق الغرام ᯓ★ 𓊇",
    directValues = {1987005460,1853183077,7103854}, noInput32 = true},
{
    name = "𓊆 ★ᯓكتكوت مغرمᯓ★ 𓊇",
    directValues = {1768448786, 1751346019,27497},noInput32 = true},
{
    name = "𓊆 ★ᯓثلاثي يعزفونᯓ★ 𓊇",
    directValues = {1769100296,111,0},noInput32 = true},
{
    name = "𓊆 ★ᯓكلب أليفᯓ★ 𓊇",
    directValues = {1768440596, 1702061422,6778692},noInput32 = true},
{
    name = "𓊆 ★ᯓشجرة السكرᯓ★ 𓊇",
    directValues = {1702318868, 1415541861,6645106},noInput32 = true},
{
    name = "𓊆 ★ᯓمرجل سحريᯓ★ 𓊇",
    directValues = {1953060624, 1867540579,116},noInput32 = true},
{
    name = "𓊆 ★ᯓمتجر عيد الفصحᯓ★ 𓊇",
    directValues = {1819230994, 1163883119,-1107269785},noInput32 = true},
{
    name = "𓊆 ★ᯓمتجر الكتبᯓ★ 𓊇",
    directValues = {1869562388, 1951620971,6648431},noInput32 = true},
{
    name = "𓊆 ★ᯓورشة سانتاᯓ★ 𓊇",
    directValues = {1987003156, 1197437541,7628393},noInput32 = true},
{
    name = "𓊆 ★ᯓلحن غرامي لا نهاية لهᯓ★ 𓊇",
    directValues = {1987013650, 2003784805,-1308593563},noInput32 = true},
{
    name = "𓊆 ★ᯓzooديكورᯓ★ 𓊇",
    directValues = {1869576722, 1667589215,29295},noInput32 = true},
{
    name = "𓊆 ★ᯓبيت الثلجᯓ★ 𓊇",
    directValues = {1818716424, -1106050955,-1215944588},noInput32 = true},
{
    name = "𓊆 ★ᯓمقهى الكوب الساخنᯓ★ 𓊇",
    directValues = {1717650192, 1651856485, -1534263195},noInput32 = true},
{
    name = "𓊆 ★ᯓلافتة الخمس اعوامᯓ★ 𓊇",
    directValues = {1702442252 , 7565921,-1772026876},noInput32 = true},
{
    name = "𓊆 ★ᯓمنطقة التخفضياتᯓ★ 𓊇",
    directValues = {1818317588 , 1970361189,6648417},noInput32 = true},
{
    name = "𓊆 ★ᯓملاذ الكهفᯓ★ 𓊇",
    directValues = {1986085652 , 1817206629,6644577},noInput32 = true},
{
    name = "𓊆 ★ᯓحديقة الديناصوراتᯓ★ 𓊇",
    directValues = {1852392466 , 1632853871,-1644141210},noInput32 = true},
{
    name = "𓊆 ★ᯓقاعة المشاهير ᯓ★ 𓊇",
    directValues = {1818314770 , 1632001900,-1644141203},noInput32 = true},
{
    name = "𓊆 ★ᯓبرج المراقبةᯓ★ 𓊇",
    directValues = {1952536340 , 1869899875,7497079},noInput32 = true},
{
    name = "𓊆 ★ᯓ طاهي السلطعون ᯓ★ 𓊇",
    directValues = {1634878226,1866686306,27503},noInput32 = true},
{
    name = "𓊆 ★ᯓ زلاجة النعجات ᯓ★ 𓊇",
    directValues = {1701335828,1817407589,6644841},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ ركن القراصنة ᯓ★ 𓊇",
    directValues = {2003784722,1632001902,29289},noInput32 = true}, 
{
    name = "𓊆 ★ᯓ متجر الساحرة ᯓ★ 𓊇",
    directValues = {1634488340,1398762350,7368552},noInput32 = true},
{
    name = "𓊆 ★ᯓتنين الجليدᯓ★ 𓊇",
    directValues = {1701013778,1734439492,28271},noInput32 = true}, 
{
    name = "𓊆 ★ᯓمعدات الرياضات الشتويةᯓ★ 𓊇",
    directValues = {1768641296, 1869108063,1130299504},noInput32 = true},
{
 name = "𓊆 ★ᯓبحيرة متجمدةᯓ★ 𓊇",
 directValues = {1701013774,1701536076,-1296281856},noInput32 = true}, 
} 
---🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋🦋----
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
  "✦✧▬▭إطارات▭▬✧✦",
  "✦✧▬▭شارات▭▬✧✦",
    "✦✧▬▭الالقاب▭▬✧✦",
    "✦✧▬▭لافتات▭▬✧✦",
 "✦✧▬▭الملصقات ▭▬✧✦",
 "✦✧▬▭الصور▭▬✧✦",
    "✦✧▬▭الجزيرة ▭▬✧✦",
    "✦✧▬▭محطة القطار ▭▬✧✦",
    "✦✧▬▭مظهر القطار▭▬✧✦",
    "✦✧▬▭مهبط هيلوكبتر ▭▬✧✦",
    "✦✧▬▭مظهر الهيلو▭▬✧✦",
    "✦✧▬▭مظهر الميناء▭▬✧✦",
    "✦✧▬▭مظهر السفينة▭▬✧✦",
    "✦✧▬▭مظهر المطار▭▬✧✦",
    "✦✧▬▭مظهر الطائرة▭▬✧✦",
    "✦✧▬▭مظهر الابقار▭▬✧✦",
    "✦✧▬▭مظهر دجاج▭▬✧✦",
    "✦✧▬▭مظهر خراف▭▬✧✦",
    "✦✧▬▭مظهر خنازير▭▬✧✦",
  "✦✧▬▭ديكورات▭▬✧✦",
    "✦✧▬▭زينات▭▬✧✦",
"🔥ᖇETᑌᖇᑎ TO TᕼE ᗰEᑎᑌ🔥",
        }

         local c = gg.choice(menu, nil, "ʚϊɞ╭⊱ꕥ🅂🄰🄷🄴🅁ꕥ⊱╮ ʚϊɞ".. getTime()) 
             if not c then
            return
        elseif c == 1 then
showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ "..getTime(), shonaData)
   elseif c == 2 then
    showSubMenu("Ⓑ━╬٨ـﮩﮩ??٨ـﮩﮩـ╬━ⓢ".. getTime(), bs1Data) 
     elseif c == 3 then
    showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs2Data) 
    elseif c == 4 then
    showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs3Data) 
    elseif c == 5 then
    showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs4Data) 
     elseif c == 6 then
    showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs5Data) 
     elseif c == 7 then
     showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs6Data) 
     elseif c == 8 then
    showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs7Data) 
     elseif c == 9 then
     showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs8Data) 
     elseif c == 10 then
     showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs9Data) 
     elseif c == 11 then
     showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs10Data) 
     elseif c == 12 then
     showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs11Data) 
     elseif c == 13 then
     showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs12Data) 
     elseif c == 14 then
     showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs13Data) 
   elseif c == 15 then
     showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs14Data) 
  elseif c == 16 then
     showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs15Data) 
  elseif c == 17 then
     showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs16Data) 
  elseif c == 18 then
     showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs17Data) 
  elseif c == 19 then
     showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs18Data) 
elseif c == 20 then
   showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs19Data) 
   elseif c == 21 then
   showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs20Data) 
elseif c == 22 then
   showSubMenu("Ⓑ━╬٨ـﮩﮩ💜٨ـﮩﮩـ╬━ⓢ".. getTime(), bs21Data) 
  elseif c == 23 then
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
function SMB8()
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

function SMB9()
--تطوير شامل--
Sbb = gg.multiChoice({
"𓊆 ★ᯓ تصفير الكاتب الأول ᯓ★ 𓊇",
"?? ★ᯓ فتح المباني الاجتماعية ᯓ★ 𓊇",
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
"𓊆 ★ᯓ زيادة عمق المنجم ᯓ★ ??",
"𓊆 ★ᯓ زيادة أيام المعززات بالمختبر ᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير الطلب بالتعاون ᯓ★ 𓊇",
"𓊆 ★ᯓ طلب المنتجات بالتعاونᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير طلبات الهيلو ᯓ★ 𓊇",
"𓊆 ★ᯓ فتح إنجازات التعاون ᯓ★ 𓊇",
"𓊆 ★ᯓ زيادة المنتج بالمصنع والشونة ᯓ★ 𓊇",
"𓊆 ★ᯓ تصفير بائع السوق ᯓ★ 𓊇",
"𓊆 ★ᯓ زيادة منتجات البائع ᯓ★ 𓊇",
"𓊆 ★ᯓ فتح المباني الاجتماعية تكبيس ᯓ★ 𓊇", 
"𓊆 ★ᯓ المطابقة الثلاثية ᯓ★ 𓊇", 
"𓊆 ★ᯓ توسيع الاراضيᯓ★ 𓊇",
" 👽☠b͢a͢c͢k͢ ☠👽 ",
  }, nil, "ʚïɞ╭⊱ꕥ🅂🄰🄷🄴🅁ꕥ⊱╮ʚïɞ".. getTime()) 
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
    gg.alert("زود صناديق براحتك??")
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
local beso = gg.getResults(100)
    for i = 1, #beso do 
    beso[i].flags = gg.TYPE_DWORD
      beso[i].value = 0
         beso[i].freeze = true
        
        end

gg.setValues(beso)
gg.addListItems(beso)
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
local beso = gg.getResults(100)
    for i = 1, #beso do 
    beso[i].flags = gg.TYPE_DWORD
      beso[i].value = 0
         beso[i].freeze = true
        
        end

gg.setValues(beso)
gg.addListItems(beso)
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
local beso = gg.getResults(100)
    for i = 1, #beso do 
    beso[i].flags = gg.TYPE_DWORD
      beso[i].value = 0
         beso[i].freeze = true
        
        end

gg.setValues(beso)
gg.addListItems(beso)
gg.clearResults()
gg.toas("✨?? اللهم صل على  םבםב ??✨")

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
        {" 🎀 ادخل العمق المطلوب للمنجم ??"},
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
local beso = gg.getResults(100)
local input = gg.prompt(
        {"🎀 ادخل الوقت المطلوب 🎀"},
        {0},
        {"number"}
    )
    if input == nil then
        gg.toast("لم يتم إدخال قيم. العملية ألغيت.")
        return
    end
    for i = 1, #beso do 
    beso[i].flags = gg.TYPE_DWORD
      beso[i].value = input[1]
         beso[i].freeze = true
        
        end

gg.setValues(beso)
gg.addListItems(beso)
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

local beso = gg.getResults(100)
for i = 1, #beso do 
    beso[i].flags = gg.TYPE_DWORD
    beso[i].value = 0
    beso[i].freeze = true
end

gg.setValues(beso)
gg.addListItems(beso)
gg.clearResults()
gg.toast("🌸 تم تصفير طلب التعاون 🌸")

gg.setRanges(gg.REGION_C_ALLOC)
end  

function Sbb17()
--طلب المنتجات بالتعاون--
gg.searchNumber("16842752~16842777X36", gg.TYPE_DWORD)
gg.getResults(100000)
gg.refineNumber("16842753", gg.TYPE_DWORD)
local tas = gg.getResults(100000)

local input = gg.prompt({"🌱إدخل الرقم🌱"}, {0}, {"number"})
if not input then return end

local saveList = {}

for i = 1, #tas do
    local addr = tas[i].address

    -- قراءة القيم قبل التعديل
    local check = gg.getValues({
        {address = addr - 4, flags = gg.TYPE_DWORD},
        {address = addr - 8, flags = gg.TYPE_DWORD}
    })

    local v1 = tonumber(check[1].value)
    local v2 = tonumber(check[2].value)

    -- شرط أكبر من 500000 بالسالب أو الموجب
    local bigEnough = math.abs(v1) > 500000 and math.abs(v2) > 500000

    -- شرط التشابه النسبي (فرق أقل من 100000)
    local similar = math.abs(v1 - v2) < 100000

    if bigEnough and similar then
        local edits = {
            {address = addr - 4, flags = gg.TYPE_DWORD, value = input[1], freeze = true},
            {address = addr - 8, flags = gg.TYPE_DWORD, value = 0, freeze = true}
        }

        gg.setValues(edits)

        for _, e in ipairs(edits) do
            table.insert(saveList, e)
        end
    end
end

gg.addListItems(saveList)
gg.clearResults()
gg.toast("✨💗 تم تعديل القيم المطابقة فقط 💗✨")
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
    gg.searchNumber("65537;2;65539;347158862:153", gg.TYPE_DWORD)
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
            address = result[1].address -8,
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

function SMB10()
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

function SMB11()
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

function SMB12()
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

function SMB13()
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
    local choice = gg.choice(menuOptions, nil, "ʚϊɞ╭⊱ꕥ🅂🄰🄷🄴🅁ꕥ⊱╮ ʚϊɞ".. getTime()) 
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

function SMB14()
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
        local offsets = {0,  -268, -464, -660, -856, -1052,} 
        local types = {gg.TYPE_FLOAT, gg.TYPE_DWORD, gg.TYPE_DWORD, gg.TYPE_DWORD, gg.TYPE_DWORD, gg.TYPE_DWORD}
        
local checks = gg.getValues({
            {address = address  - 1048, flags = gg.TYPE_DWORD},
            {address = address  - 1044, flags = gg.TYPE_DWORD}
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
local values = {
    15900, 15300, 15000, 15600, 14400,
    16200, 16500, 16800, 17100, 17400,
    17700, 18000, 14700, 14100, 13800,
    13500, 13200, 12900, 12600, 12300
}
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
 -252, -448, -644, -840, -1036,    
--قيم عدد المنتج
-280 ,-284, -476, -480, -672, -676, -868, -872, -1064, -1068,
--تعديل المنتج الى قمح
-292, -296,  -488, -492, -684, -688, -880,-884,-1076,-1080,   
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
            [-252]=1,
--صندوق ثاني              
            [-448]=1,
--صندوق ثالث              
            [-644]=1,
--صندوق رابع            
            [-840]=1,  
--صندوق خامس                  
            [-1036]=1,
            
            
--قيم عدد المنج  

--صندوق اول              
            [-280]=1,
            [-284]=0,
--صندوق ثاني              
            [-476]=1,
            [-480]=0,  
--صندوق ثالث                               
            [-672]=1,
            [-676]=0, 
--صندوق رابع                      
            [-868]=1,
            [-872]=0,  
                
--صندوق خامس                       
            [-1064]=1,
            [-1068]=0,            
            
---تعديل المنتج الى قمح  
--صندوق اول          
            [-292]=29793,
            [-296]=1701345034,
            
--صندوق ثاني           
            [-488]=29793,
            [-492]=1701345034,
            
--صندوق ثالث            
            [-684]=29793,
            [-688]=1701345034,
            
--صندوق رابع            
            [-880]=29793,
            [-884]=1701345034,
   
--صندوق خامس
            [-1076]=29793,
            [-1080]=1701345034,
            
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
        local modifyOnlyOffsets = { -268, -464, -660, -856, -1052,}
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
            {address = address  - 1048, flags = gg.TYPE_DWORD},
            {address = address  - 1044, flags = gg.TYPE_DWORD}
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
    17700, 18000, 14700, 14100, 13800,
    13500, 13200, 12900, 12600, 12300
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
 -252, -448, -644, -840, -1036,    
--قيم عدد المنتج
-280 ,-284, -476, -480, -672, -676, -868, -872, -1064, -1068,
--تعديل المنتج الى قمح
-292, -296,  -488, -492, -684, -688, -880,-884,-1076,-1080,   
--البرسيم
-184, -380, -576, -772, -968,
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

            [-252]=1,
--صندوق ثاني              
            [-448]=1,
--صندوق ثالث              
            [-644]=1,
--صندوق رابع            
            [-840]=1,  
--صندوق خامس                  
            [-1036]=1,
            
            
--قيم عدد المنج  

--صندوق اول              
            [-280]=1,
            [-284]=0,
--صندوق ثاني              
            [-476]=1,
            [-480]=0,  
--صندوق ثالث                               
            [-672]=1,
            [-676]=0, 
--صندوق رابع                      
            [-868]=1,
            [-872]=0,  
                
--صندوق خامس                       
            [-1064]=1,
            [-1068]=0,            
            
            
---تعديل المنتج الى قمح  
--صندوق اول          
            [-292]=29793,
            [-296]=1701345034,
            
--صندوق ثاني           
            [-488]=29793,
            [-492]=1701345034,
            
--صندوق ثالث            
            [-684]=29793,
            [-688]=1701345034,
            
--صندوق رابع            
            [-880]=29793,
            [-884]=1701345034,
   
--صندوق خامس
            [-1076]=29793,
            [-1080]=1701345034,
           
--البرسيم

    -- صندوق أول
    [-184] = 0,

    -- صندوق ثاني
    [-380] = 0,

    -- صندوق ثالث
    [-576] = 0,

    -- صندوق رابع
    [-772] = 0,

    -- صندوق خامس
    [-968] = 0,
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
        local modifyOnlyOffsets = { -268, -464, -660, -856, -1052,}
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
          {address = address  - 1048, flags = gg.TYPE_DWORD},
            {address = address  - 1044, flags = gg.TYPE_DWORD}
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
    17700, 18000, 14700, 14100, 13800,
    13500, 13200, 12900, 12600, 12300
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
 -252, -448, -644, -840, -1036,    
--قيم عدد المنتج
-280 ,-284, -476, -480, -672, -676, -868, -872, -1064, -1068,
--تعديل المنتج الى جزر
-292, -296,  -488, -492, -684, -688, -880,-884,-1076,-1080,
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

            [-252]=1,
--صندوق ثاني              
            [-448]=1,
--صندوق ثالث              
            [-644]=1,
--صندوق رابع            
            [-840]=1,  
--صندوق خامس                  
            [-1036]=1,
            
            
            
            
--قيم عدد المنج  

--صندوق اول              
            [-280]=9999,
            [-284]=0,
--صندوق ثاني              
            [-476]=9999,
            [-480]=0,  
--صندوق ثالث                               
            [-672]=9999,
            [-676]=0, 
--صندوق رابع                      
            [-868]=9999,
            [-872]=0,  
                
--صندوق خامس                       
            [-1064]=9999,
            [-1068]=0,            
            
            
--تعديل المنتج الى جزر     
--صندوق اول          
            [-292]=7630706,
            [-296]=1918984972,
            
--صندوق ثاني           
            [-488]=7630706,
            [-492]=1918984972,
            
--صندوق ثالث            
            [-684]=7630706,
            [-688]=1918984972,
            
--صندوق رابع            
            [-880]=7630706,
            [-884]=1918984972,
            
--صندوق خامس
            [-1076]=7630706,
            [-1080]=1918984972,
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
        local modifyOnlyOffsets = { -268, -464, -660, -856, -1052,}
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
                {address = address  - 1048, flags = gg.TYPE_DWORD},
            {address = address  - 1044, flags = gg.TYPE_DWORD}
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
    17700, 18000, 14700, 14100, 13800,
    13500, 13200, 12900, 12600, 12300
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
 -252, -448, -644, -840, -1036,    
--قيم عدد المنتج
-280 ,-284, -476, -480, -672, -676, -868, -872, -1064, -1068,
--تعديل المنتج الى تاج
-292, -296,  -488, -492, -684, -688, -880,-884,-1076,-1080,   
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

            [-252]=1,
--صندوق ثاني              
            [-448]=1,
--صندوق ثالث              
            [-644]=1,
--صندوق رابع            
            [-840]=1,  
--صندوق خامس                  
            [-1036]=1,
            
    
--قيم عدد المنج  

--صندوق اول              
            [-280]=50,
            [-284]=0,
--صندوق ثاني              
            [-476]=50,
            [-480]=0,  
--صندوق ثالث                               
            [-672]=50,
            [-676]=0, 
--صندوق رابع                      
            [-868]=50,
            [-872]=0,  
                
--صندوق خامس                       
            [-1064]=50,
            [-1068]=0,            
            
            
---تعديل المنتج الى تاج
--صندوق اول          
            [-292]=7169380,
            [-296]=1634296844,
            
--صندوق ثاني           
            [-488]=7169380,
            [-492]=1634296844,
            
--صندوق ثالث            
            [-684]=7169380,
            [-688]=1634296844,
            
--صندوق رابع            
            [-880]=7169380,
            [-884]=1634296844,
   
--صندوق خامس
            [-1076]=7169380,
            [-1080]=1634296844,
            
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
        local modifyOnlyOffsets ={ -268, -464, -660, -856, -1052,}
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
             {address = address  - 1048, flags = gg.TYPE_DWORD},
            {address = address  - 1044, flags = gg.TYPE_DWORD}
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
    17700, 18000, 14700, 14100, 13800,
    13500, 13200, 12900, 12600, 12300
}

for i = 1, #values do
    SSbb5(values[i])


gg.toast("🎯 البحث اكتمل بنجاح!")
end
end
function SMB15()
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

function SMB16()
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
 
function SMB17()
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
    
gg.searchNumber("1701274988;1918985326;121::9", gg.TYPE_DWORD)
    gg.getResults(1000)
        gg.refineNumber("1701274988", gg.TYPE_DWORD)
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
        
     
        local t2 = {}
        t2[1] = {}
        t2[1].address = address + 4
        t2[1].flags = gg.TYPE_DWORD
        t2[1].value = 0
        t2[1].freeze = true
        gg.setValues(t2)
        table.insert(saveList, t2[1])


        local t3 = {}
        t3[1] = {}
        t3[1].address = address + 8
        t3[1].flags = gg.TYPE_DWORD
        t3[1].value = 0
        t3[1].freeze = true
        gg.setValues(t3)
        table.insert(saveList, t3[1])
        end
    gg.clearResults()
    gg.alert("🌸تم تحويل الكروت الاسطورية بنجاح🌸")
   
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
function SMB18()
--استعادة جميع هدايا التصريح--
gg.clearResults()
    gg.searchNumber("7374730Eh;65726F63h;00626104h", gg.TYPE_DWORD)
    gg.refineNumber("00626104h", gg.TYPE_DWORD)
    local results = gg.getResults(1000000)
    if #results == 0 then
        gg.alert("❌ لا توجد نتائج بعد الصقل.")
        return
    end
    local modifyList = {}
    local freezeList = {}
    for i = 1, #results do
        local base = results[i].address
        local offsetsMain = {28,40}
        for _, mainOff in ipairs(offsetsMain) do
            local ptr1 = gg.getValues({
                {address = base + mainOff, flags = gg.TYPE_DWORD}
            })[1].value
            if ptr1 and ptr1 ~= 0 then
                local subOffsets = {0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80, 84, 88, 92, 96, 100, 104, 108, 112, 116, 120}
                for _, subOff in ipairs(subOffsets) do
                    local ptr2 = gg.getValues({
                        {address = ptr1 + subOff, flags = gg.TYPE_DWORD}
                    })[1].value
                    if ptr2 and ptr2 ~= 0 then
                        local editOffsets = {8, 12, 4}
                        for _, edit in ipairs(editOffsets) do
                         local addr = ptr2 + edit                          
                            table.insert(modifyList, {
                                address = addr,
                                flags = gg.TYPE_DWORD,
                                value = 0
                            })                            -- تجهيز التجميد
                            table.insert(freezeList, {
                                address = addr,
                                flags = gg.TYPE_DWORD,
                                value = 0,
                                freeze = true
                            })

                        end
                    end
                end
            end
        end
    end

    -- تنفيذ التعديلات
    if #modifyList > 0 then
        gg.setValues(modifyList)
        gg.addListItems(modifyList)
    end

    -- تنفيذ التجميد الدائم
    if #freezeList > 0 then
        gg.addListItems(freezeList)
    end

    gg.clearResults()

    gg.alert("🍉 تم تعديل وتجميد القيم بنجاح 🍉")
    gg.toast("🎀ʚïɞ BASMALA FREEZE DONE ʚïɞ🎀")

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


