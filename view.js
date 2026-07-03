const express = require("express");
const router = express.Router();
const { supabase } = require("./supabase");

const ADMIN_USER = "basmala";
const ADMIN_PASS = "BSBSBS";

function isLogged(req) {
  return req.session && req.session.admin;
}

function readKeys() {
  try {
    return JSON.parse(fs.readFileSync("./keys.json", "utf8"));
  } catch {
    return [];
  }
}

function saveKeys(data) {
  fs.writeFileSync(
    "./keys.json",
    JSON.stringify(data, null, 2)
  );
}

function generateKey() {
  const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

  let result = "BS-";

  for (let i = 0; i < 8; i++) {
    result += chars[Math.floor(Math.random() * chars.length)];
  }

  return result;
}

function formatDate(date) {
  return date.toISOString().split("T")[0];
}

router.get("/", (req, res) => {
  res.redirect("/admin");
});

/* LOGIN */

router.get("/admin/login", (req, res) => {

  if (isLogged(req)) {
    return res.redirect("/admin");
  }

  res.send(`
<!DOCTYPE html>
<html dir="rtl">
<head>
<meta charset="UTF-8">
<title>BS Admin</title>

<style>
body{
font-family:Tahoma;
background:#f3f4f6;
display:flex;
justify-content:center;
align-items:center;
height:100vh;
margin:0;
}

.box{
background:white;
padding:30px;
width:350px;
border-radius:20px;
box-shadow:0 5px 25px rgba(0,0,0,.1);
}

input{
width:100%;
padding:12px;
margin-top:10px;
box-sizing:border-box;
border:1px solid #ddd;
border-radius:10px;
}

button{
width:100%;
padding:12px;
margin-top:15px;
border:none;
background:#14b8a6;
color:white;
border-radius:10px;
font-size:18px;
cursor:pointer;
}
</style>

</head>
<body>

<div class="box">
<h2>BS Admin Login</h2>

<form method="POST" action="/admin/login">
<input name="username" placeholder="اسم المستخدم">
<input type="password" name="password" placeholder="كلمة المرور">
<button>دخول</button>
</form>

</div>

</body>
</html>
`);
});

router.post("/admin/login", (req, res) => {

  const { username, password } = req.body;

  if (
    username === ADMIN_USER &&
    password === ADMIN_PASS
  ) {
    req.session.admin = true;
    return res.redirect("/admin");
  }

  res.send("بيانات غير صحيحة");
});

router.get("/logout", (req, res) => {

  req.session.destroy(() => {
    res.redirect("/admin/login");
  });

});

/* CREATE KEY */

router.post("/admin/create", async (req, res) => {

  if (!isLogged(req)) {
    return res.redirect("/admin/login");
  }

  const days = parseInt(req.body.days || "30");

  const created = new Date();

  const expire = new Date();

  expire.setDate(expire.getDate() + days);

await supabase.from("keys").insert([
  {
    key: generateKey(),
    createdAt: formatDate(created),
    expireAt: formatDate(expire),
    status: "active",
    deviceId: null
  }
]);

  res.redirect("/admin");
});

/* DELETE */

router.get("/admin/delete/:key", async (req, res) => {

  if (!isLogged(req)) {
    return res.redirect("/admin/login");
  }

const { error } = await supabase
  .from("keys")
  .delete()
  .eq("key", req.params.key);

if (error) {
  return res.send(error.message);
}

  res.redirect("/admin");
});

/* BAN */

router.get("/admin/ban/:key", (req, res) => {

  if (!isLogged(req)) {
    return res.redirect("/admin/login");
  }

  const keys = readKeys();

  const item = keys.find(
    k => k.key === req.params.key
  );

  if (item) {
    item.status = "banned";
  }

  saveKeys(keys);

  res.redirect("/admin");
});

/* UNBAN */

router.get("/admin/unban/:key", (req, res) => {

  if (!isLogged(req)) {
    return res.redirect("/admin/login");
  }

  const keys = readKeys();

  const item = keys.find(
    k => k.key === req.params.key
  );

  if (item) {
    item.status = "active";
  }

  saveKeys(keys);

  res.redirect("/admin");
});

/* EXTEND */

router.post("/admin/extend/:key", (req, res) => {

  if (!isLogged(req)) {
    return res.redirect("/admin/login");
  }

  const days = parseInt(req.body.days || "30");

  const keys = readKeys();

  const item = keys.find(
    k => k.key === req.params.key
  );

  if (item) {

    const expire = new Date(item.expireAt);

    expire.setDate(
      expire.getDate() + days
    );

    item.expireAt = formatDate(expire);

    if (item.status === "expired") {
      item.status = "active";
    }
  }

  saveKeys(keys);

  res.redirect("/admin");
});
/* DASHBOARD */

router.get("/admin", async (req, res) => {

  if (!isLogged(req)) {
    return res.redirect("/admin/login");
  }

 const { data: keys, error } = await supabase
  .from("keys")
  .select("*");

if (error) {
  return res.send(error.message);
}

  const total = keys.length;

  const active = keys.filter(
    k => k.status === "active"
  ).length;

  const banned = keys.filter(
    k => k.status === "banned"
  ).length;

  const expired = keys.filter(
    k => k.status === "expired"
  ).length;

  let rows = "";

  keys.forEach(k => {

    rows += `
    <tr>
      <td>${k.key}</td>
      <td>${k.expireAt}</td>
      <td>${k.status}</td>

      <td>

<form
method="POST"
action="/admin/extend/${k.key}"
style="display:inline;">

<input
type="number"
name="days"
value="30"
min="1"
style="
width:70px;
padding:4px;
margin-left:5px;
">

<button type="submit">
تمديد
</button>

</form>

|

${
k.status === "banned"
? `<a href="/admin/unban/${k.key}">فك الحظر</a>`
: `<a href="/admin/ban/${k.key}">حظر</a>`
}

|

<a href="/admin/delete/${k.key}">
حذف
</a>

</td>
    </tr>
    `;
  });

  res.send(`
<!DOCTYPE html>
<html dir="rtl">
<head>
<meta charset="UTF-8">
<title>BS Admin</title>

<style>

body{
font-family:Tahoma;
background:#f3f4f6;
padding:20px;
margin:0;
}

.header{
display:flex;
justify-content:space-between;
align-items:center;
}

.logout{
background:#f59e0b;
color:white;
padding:10px 15px;
border-radius:10px;
text-decoration:none;
}

.card{
background:white;
padding:20px;
margin-top:15px;
border-radius:15px;
box-shadow:0 2px 10px rgba(0,0,0,.05);
}

.stats{
font-size:20px;
margin-bottom:10px;
}

form input{
padding:10px;
border:1px solid #ddd;
border-radius:10px;
}

form button{
padding:10px 15px;
border:none;
background:#14b8a6;
color:white;
border-radius:10px;
cursor:pointer;
}

table{
width:100%;
background:white;
margin-top:20px;
border-collapse:collapse;
}

th,td{
padding:12px;
border:1px solid #ddd;
text-align:center;
}

th{
background:#14b8a6;
color:white;
}

a{
text-decoration:none;
}

</style>

</head>

<body>

<div class="header">
<h1>BS Admin Panel</h1>
<a class="logout" href="/logout">خروج</a>
</div>

<div class="card">
<div class="stats">إجمالي المفاتيح: ${total}</div>
<div class="stats">النشطة: ${active}</div>
<div class="stats">المحظورة: ${banned}</div>
<div class="stats">المنتهية: ${expired}</div>
</div>

<div class="card">

<h3>إنشاء مفتاح جديد</h3>

<form method="POST" action="/admin/create">

<input
type="number"
name="days"
value="30"
min="1">

<button>
توليد مفتاح
</button>

</form>

</div>

<table>

<tr>
<th>المفتاح</th>
<th>الانتهاء</th>
<th>الحالة</th>
<th>الإجراءات</th>
</tr>

${rows}

</table>

</body>
</html>
`);
});

module.exports = router;
