const express = require("express");
const router = express.Router();

router.get("/BS", (req, res) => {

  const ua = req.headers["user-agent"] || "";

  if (ua.includes("Mozilla")) {
    return res.send("BS");
  }

  res.type("text/plain").send(
    'gg.alert("اسكربت الجامع\\nقريباً!")'
  );

});

module.exports = router;
