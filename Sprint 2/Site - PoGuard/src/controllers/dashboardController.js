var dashboardModel = require("../models/dashboardModel")

function frotaAtiva(req, res) {

    var fkEmpresa = req.params.fkEmpresa

    dashboardModel.frotaAtiva(fkEmpresa)
        .then((alertas) => {

            res.status(200).json({
                alertas: alertas
            })
        })

}

module.exports = {
    frotaAtiva
}