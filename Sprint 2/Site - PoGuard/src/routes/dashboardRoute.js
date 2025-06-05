var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController")

router.get("/frotaAtiva/:fkEmpresa", function (req, res) {
    dashboardController.frotaAtiva(req, res)
})

router.get("/ativaStatus/:fkEmpresa", function (req, res) {
    dashboardController.ativaStatus(req, res)
})

module.exports = router