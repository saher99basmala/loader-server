const express = require("express");
const router = express.Router();
const { supabase } = require("./supabase");

const ADMIN_USER = "BS2973";
const ADMIN_PASS = "BS9237";

function isLogged(req) {
  return req.session && req.session.admin;
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
  const name = req.body.name || "";
const deviceid = req.body.deviceid || "";

  const created = new Date();
  const expire = new Date();

  expire.setDate(expire.getDate() + days);

  const { error } = await supabase
    .from("keys")
.insert([
{
  name: name,
  deviceid: deviceid,
  key: generateKey(),
  createdat: formatDate(created),
  expireat: formatDate(expire),
  status: "active"
}
]);

  if (error) {
    return res.send(error.message);
  }

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

router.get("/admin/ban/:key", async (req, res) => {

  if (!isLogged(req)) {
    return res.redirect("/admin/login");
  }

  const { error } = await supabase
    .from("keys")
    .update({ status: "banned" })
    .eq("key", req.params.key);

  if (error) {
    return res.send(error.message);
  }

  res.redirect("/admin");
});

/* UNBAN */

router.get("/admin/unban/:key", async (req, res) => {

  if (!isLogged(req)) {
    return res.redirect("/admin/login");
  }

  const { error } = await supabase
    .from("keys")
    .update({ status: "active" })
    .eq("key", req.params.key);

  if (error) {
    return res.send(error.message);
  }

  res.redirect("/admin");
});
/* EXTEND */

router.post("/admin/extend/:key", async (req, res) => {

  if (!isLogged(req)) {
    return res.redirect("/admin/login");
  }

  const days = parseInt(req.body.days || "30");

  const { data, error } = await supabase
    .from("keys")
    .select("expireat,status")
    .eq("key", req.params.key)
    .single();

  if (error) {
    return res.send(error.message);
  }

  const expire = new Date(data.expireat);

  expire.setDate(expire.getDate() + days);

  const { error: updateError } = await supabase
    .from("keys")
.update({
  expireat: formatDate(expire),
  status: "active"
})
    .eq("key", req.params.key);

  if (updateError) {
    return res.send(updateError.message);
  }

  res.redirect("/admin");
});

/* DASHBOARD */

router.get("/admin", async (req, res) => {

  if (!isLogged(req)) {
    return res.redirect("/admin/login");
  }

  console.log("SUPABASE =", supabase);

  const { data: keys, error } = await supabase
    .from("keys")
    .select("*")
    .order("id", { ascending: false });

  if (error) {
    return res.send(error.message);
  }

  const total = keys.length;
  const active = keys.filter(k => k.status === "active").length;
  const banned = keys.filter(k => k.status === "banned").length;
  const expired = keys.filter(k => k.status === "expired").length;

  let rows = "";

  keys.forEach(k => {

rows += `
<tr>

<td>${k.name || "-"}</td>

<td>${k.deviceid || "-"}</td>

<td>
${k.key}
<br><br>
<button
type="button"
onclick="copyKey('${k.key}')">
📋 نسخ
</button>
</td>

<td>${k.expireat}</td>

<td>${k.status}</td>

<td>

<form method="POST" action="/admin/extend/${k.key}" style="display:inline;">

<input
type="number"
name="days"
value="30"
min="1"
style="width:70px;padding:4px;margin-left:5px;">

<button type="submit">
تمديد
</button>

</form>

|

${k.status === "banned"
? `<a href="/admin/unban/${k.key}">فك الحظر</a>`
: `<a href="/admin/ban/${k.key}">حظر</a>`}

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
color:#fff;
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
type="text"
name="name"
placeholder="اسم العميل"
required>

<input
type="text"
name="deviceid"
placeholder="Install ID"
required>

<input
type="number"
name="days"
value="30"
min="1"
placeholder="عدد الأيام">

<button>
توليد مفتاح
</button>

</form>

</div>

<table>

<tr>
<th>الاسم</th>
<th>Install ID</th>
<th>المفتاح</th>
<th>الانتهاء</th>
<th>الحالة</th>
<th>الإجراءات</th>
</tr>

${rows}

</table>

<script>

function copyKey(key){

    navigator.clipboard.writeText(key);

    alert("✅ تم نسخ المفتاح");

}

</script>

</body>
</html>
`);
});

module.exports = router;
