const express = require("express");

const app = express();

const SECRET = "MY_SECRET_123";

app.get("/script", (req, res) => {

if (
req.query.key !== "12345" ||
req.headers["x-secret"] !== SECRET
) {

return res.send("basmala");

}

res.type("text/plain").send(
'gg.alert("اسكربت الجامع\\nقريباً!")'
);

});

app.listen(3000);
