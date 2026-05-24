const express = require("express");
const router = express.Router();

router.get("/BS", (req, res) => {

  const key = req.query.key;

  // 🔐 مفتاح خاص للجيم جاردن
  if (key !== "gg123") {
    return res.send("BS");
  }

  res.type("text/plain").send(
    'gg.alert("اسكربت الجامع\\nقريباً!")'
  );

});

module.exports = router;
