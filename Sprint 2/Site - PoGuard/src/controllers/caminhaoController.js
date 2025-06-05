var caminhaoModel = require("../models/caminhaoModel")

function obterDados(req, res) {
    var fkCaminhao = req.query.fkCaminhao
    console.log({
        "obterDados":fkCaminhao
    })


    caminhaoModel.obterDados(fkCaminhao)

        .then(
            function (resultado) {
                res.json(resultado)
            }
        ).catch(
            function (erro) {
                console.log(erro)
                console.log(
                    "\n Houve um erro ao buscar a dadosSensor! Erro: "
                );
                res.status(500).json(erro.sqlMessage)
            }
        )
}

function atualizarDados(req, res) {
    console.log(req.query)
    var fkCaminhao = req.query.fkCaminhao
    console.log({"atualizarDados":fkCaminhao})


    caminhaoModel.atualizarDados(fkCaminhao) .then(
            function (resultado) {
                res.json(resultado)
            }
        ).catch(
            function (erro) {
                console.log(erro)
                console.log(
                    "\n Houve um erro ao buscar a dadosSensor! Erro: "
                );
                res.status(500).json(erro.sqlMessage)
            }
        )
}

function listarCaminhoes(req, res) {
    var fkEmpresa = req.query.fkEmpresa

    caminhaoModel.listarCaminhao(fkEmpresa).then(
        function (resultado) {
            res.json(resultado)
        }
    ).catch(
        function (erro) {
            console.log(erro)
            console.log(
                "\n Houve um erro ao buscar a dadosSensor! Erro: "
            );
            res.status(500).json(erro.sqlMessage)
        }
    )
}

module.exports = {
    obterDados,
    atualizarDados,
    listarCaminhoes
}