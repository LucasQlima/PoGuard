var dashboardModel = require("../models/dashboardModel")

function frotaAtiva(req, res) {
    var fkEmpresa = Number(req.body.fkEmpresa)
    var idUsuario = Number(req.body.idUsuario)
    console.log({fkEmpresa
,idUsuario})
    dashboardModel.frotaAtiva(fkEmpresa, idUsuario)
        .then(function (resultado) {
            if (resultado.length == 1) {
                res.json({
                    frota: resultado[0].frota,
                    ativo: resultado[0].ativo
                });
            } else {
                res.status(403).json({ erro: "Email e/ou senha inválidos!" });
            }
        })
        .catch(function (erro) {
            console.error("Erro ao autenticar:", erro);
            res.status(500).json({ erro: "Erro interno no servidor." });
        });
}

module.exports = {
    frotaAtiva
}