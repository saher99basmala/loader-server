const express = require("express");
const app = express();

app.use(express.json());

// اختبار فقط
app.get("/", (req, res) => {
    res.send("Crypto Server Running ✅");
});

app.listen(3000, () => {
    console.log("Server started on port 3000");
});
