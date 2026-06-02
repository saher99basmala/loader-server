const express = require("express");
const router = express.Router();
const fs = require("fs");

const ADMIN_USER = "admin";
const ADMIN_PASS = "123456";

function getKeys() {
  try {
    return JSON.parse(fs.readFileSync("./keys.json", "utf8"));
  } catch {
    return [];
  }
}

function isLogged(req) {
  return req.session && req.session.admin;
}

router.get("/", (req, res) => {
  res.redirect("/admin");
});

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
margin:0;
height:100vh;
display:flex;
justify-content:center;
align-items:center;
background:#f3f4f6;
font-family:Tahoma;
}

.box{
background:white;
padding:30px;
width:350px;
border-radius:20px;
box-shadow:0 5px 20px rgba(0,0,0,.1);
}

h2{
text-align:center;
margin-bottom:20px;
}

input{
width:100%;
padding:12px;
margin-top:10px;
border:1px solid #ddd;
border-radius:10px;
box-sizing:border-box;
}

button{
width:100%;
padding:12px;
margin-top:15px;
border:none;
background:#14b8a6;
color:white;
font-size:18px;
border-radius:10px;
cursor:pointer;
}

</style>
</head>

<body>

<div class="box">

<h2>BS Admin Login</h2>

<form method="POST" action="/admin/login">

<input
name="username"
placeholder="اسم المستخدم"
required>

<input
name="password"
type="password"
placeholder="كلمة المرور"
required>

<button type="submit">
دخول
</button>

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

  res.send("بيانات الدخول غير صحيحة");
});

router.get("/logout", (req, res) => {
  req.session.destroy(() => {
    res.redirect("/admin/login");
  });
});

router.get("/admin", (req, res) => {

  if (!isLogged(req)) {
    return res.redirect("/admin/login");
  }

  const keys = getKeys();

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

  res.send(`
<!DOCTYPE html>
<html dir="rtl">
<head>
<meta charset="UTF-8">
<title>BS Dashboard</title>

<style>

body{
margin:0;
padding:20px;
background:#f3f4f6;
font-family:Tahoma;
}

.header{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:20px;
}

.logout{
background:#f59e0b;
padding:10px 15px;
border-radius:10px;
color:white;
text-decoration:none;
}

.card{
background:white;
padding:20px;
margin-bottom:15px;
border-radius:15px;
font-size:22px;
font-weight:bold;
box-shadow:0 2px 10px rgba(0,0,0,.05);
}

.blue{
border-right:6px solid #2196f3;
}

.green{
border-right:6px solid #14b8a6;
}

.orange{
border-right:6px solid #f59e0b;
}

.red{
border-right:6px solid #ef4444;
}

</style>
</head>

<body>

<div class="header">
<h1>BS Admin Panel</h1>
<a class="logout" href="/logout">تسجيل خروج</a>
</div>

<div class="card blue">
إجمالي المفاتيح: ${total}
</div>

<div class="card green">
المفاتيح النشطة: ${active}
</div>

<div class="card orange">
المفاتيح المنتهية: ${expired}
</div>

<div class="card red">
المفاتيح المحظورة: ${banned}
</div>

</body>
</html>
`);
});

module.exports = router;
