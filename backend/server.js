require("dotenv").config({
    path: "../.env",
});
const cors = require("cors");
const express = require("express");

const app = express();
const port = 3000;

app.use(express.json());
app.use(cors());

app.post("/PhamiValo/playerInfo", async (req, res) => {
    const playerNameAndTag = req.body.input.split("#");

    const playerName = playerNameAndTag[0];
    const playerTag = playerNameAndTag[1];

    const responsePlayerInfo = await fetch(`https://api.henrikdev.xyz/valorant/v1/account/${playerName}/${playerTag}`, { headers: { Authorization: process.env.VL_API } });
    const resForPlayerInfo = await responsePlayerInfo.json();
    try {
        res.status(200).json({ res: resForPlayerInfo });
    } catch (error) {
        res.status(400).json({ msg: error.message });
    }
});

app.post("/PhamiValo/playerRank", async (req, res) => {
    const playerNameAndTag = req.body.input.split("#");

    const playerName = playerNameAndTag[0];
    const playerTag = playerNameAndTag[1];

    const responsePlayerRank = await fetch(`https://api.henrikdev.xyz/valorant/v2/mmr/eu/${playerName}/${playerTag}`, { headers: { Authorization: process.env.VL_API } });
    const resForPlayerRank = await responsePlayerRank.json();
    try {
        res.status(200).json({ res: resForPlayerRank });
    } catch (error) {
        res.status(400).json({ msg: error.message });
    }
});

app.post("/PhamiValo/getMatches", async (req, res) => {
    const playerNameAndTag = req.body.input.split("#");

    const playerName = playerNameAndTag[0];
    const playerTag = playerNameAndTag[1];

    const responseForMatches = await fetch(`https://api.henrikdev.xyz/valorant/v3/matches/eu/${playerName}/${playerTag}?mode=competitive&size=5`, { headers: { Authorization: process.env.VL_API } });
    const resForMatches = await responseForMatches.json();
    try {
        res.status(200).json({ res: resForMatches });
    } catch (error) {
        res.status(400).json({ msg: error.message });
    }
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});
