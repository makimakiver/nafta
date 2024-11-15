const express = require("express");
const app = express();
const port = 3000;
const moralis = require("moralis").default;
const cors = require("cors");

require("dotenv").config({path: ".env"});
app.use(cors());
app.use(express.json());
const MORALIS_API_KEY = process.env.MORALIS_API_KEY;

moralis.start({
    apiKey: MORALIS_API_KEY,    
}).then(() => {
    console.log("Moralis started");
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});