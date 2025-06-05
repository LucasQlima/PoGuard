var usuarioModel = require("../models/usuarioModel")
var empresaModel = require("../models/empresaModel")

//Cadastrar
function cadastrar(req, res) {
    var nome = req.body.nomeServer
    var email = req.body.emailServer
    var senha = req.body.senhaServer
    var codigoEmpresa = req.body.codigoEmpresaServer
    var cargo = 'funcionario'

    empresaModel.encontrarEmpresaPeloCodigo(codigoEmpresa)
        .then(
            function (resultadoEmpresa) {
                console.log(resultadoEmpresa)
                if (resultadoEmpresa.length == 0) {
                    return res.status(400).json()
                }

                usuarioModel.cadastrar(nome, email, senha, cargo, resultadoEmpresa[0].idEmpresa)
                    .then(
                        function (resultado) {
                            return res.json(resultado)
                        }
                    ).catch(
                        function (erro) {
                            console.log(erro)
                            console.log(
                                "\n Houve um erro ao realizar o cadastro! Erro: "
                            );
                            return res.status(401).json()
                        }
                    )
            }
        )

    // TO-DO: verificar código de ativação da empresa se for valido

}

//Autenticar
function autenticar(req, res) {
    var email = req.body.emailServer;
    var senha = req.body.senhaServer;

    if (!email || !senha) {
        return res.status(400).json({ erro: "Preencha todos os campos!" });
    }

    usuarioModel.autenticar(email, senha)
        .then(function (resultado) {
            if (resultado.length == 1) {
                res.json({
                    idUsuario: resultado[0].idUsuario,
                    nome: resultado[0].nome,
                    email: resultado[0].email,
                    senha: resultado[0].senha,
                    empresa: resultado[0].empresa,
                    fkEmpresa: resultado[0].fkEmpresa
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
    cadastrar,
    autenticar
}