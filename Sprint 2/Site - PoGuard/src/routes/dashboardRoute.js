var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController")

router.post("/frotaAtiva", function (req, res) {
    dashboardController.frotaAtiva(req, res)
})

module.exports = router