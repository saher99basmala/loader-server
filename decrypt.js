const fs = require("fs");

// فك Base64
function decodeBase64(data) {
  try {
    return Buffer.from(data, "base64").toString("utf-8");
  } catch (e) {
    return "ERROR";
  }
}

// قراءة ملف
const inputFile = "encrypted.lua"; // الملف المشفر
const outputFile = "decoded.lua"; // الناتج

if (!fs.existsSync(inputFile)) {
  console.log("❌ الملف غير موجود");
  process.exit();
}

const content = fs.readFileSync(inputFile, "utf-8");

// فك التشفير
const decoded = decodeBase64(content);

// حفظ الناتج
fs.writeFileSync(outputFile, decoded);

console.log("✅ تم فك التشفير وحفظه في decoded.lua");
