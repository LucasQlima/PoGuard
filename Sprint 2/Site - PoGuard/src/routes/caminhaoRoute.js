var express = require("express");
var router = express.Router();

var caminhaoController = require("../controllers/caminhaoController")

router.get("/obterDados", function (req, res) {
    caminhaoController.obterDados(req, res)
})

router.get("/atualizarDados", function (req, res) {
    caminhaoController.atualizarDados(req, res)
})

module.exports = router