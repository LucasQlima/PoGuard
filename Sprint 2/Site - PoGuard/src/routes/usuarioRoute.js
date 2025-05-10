var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController")

//Cadastrar
router.post("/cadastrar", function (req, res) {
    usuarioController.cadastrar(req, res)
})

//Autenticar
router.post("/autenticar", function (req, res) {
    usuarioController.autenticar(req, res)
})

module.exports = router