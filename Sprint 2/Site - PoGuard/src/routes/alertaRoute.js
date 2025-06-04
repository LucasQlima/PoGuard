const express = require("express")

const alertaController = require("../controllers/alertaController")

const router = express.Router()

router.get("/alertasRecentes/:fkEmpresa", function (req, res) {
    alertaController.alertasRecentes(req, res)
})

router.get("/todosAlertas/:fkEmpresa", function (req, res) {
    alertaController.todosAlertas(req, res)
})

router.get("/alertasCriticosAtuais/:fkEmpresa", function (req, res) {
    alertaController.alertasCriticosAtuais(req, res)
})

module.exports = router