const { MongoClient } = require("mongodb");

const client = new MongoClient(process.env.MONGO_URI);

let db;

async function getDB() {
  if (!db) {
    await client.connect();
    db = client.db("BS");
  }
  return db;
}

module.exports = getDB;
