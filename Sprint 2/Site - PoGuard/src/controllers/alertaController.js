var alertaModel = require("../models/alertaModel")

function alertasRecentes(req, res) {

    var fkEmpresa = req.params.fkEmpresa

    alertaModel.obterAlertasRecentes(fkEmpresa).then((alertas) => {

        res.status(200).json({
            alertas: alertas
        })
    })

}

module.exports = {
    alertasRecentes
}