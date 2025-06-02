const express = require("express")

const alertaController = require("../controllers/alertaController")

const router = express.Router()

router.get("/alertasRecentes/:fkEmpresa", function (req, res) {
    alertaController.alertasRecentes(req, res)
})


module.exports = router