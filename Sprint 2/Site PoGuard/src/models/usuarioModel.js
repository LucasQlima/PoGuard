var database = require("../database/config")

//Cadastrar
function cadastrar(nome, email, senha, cargo, fkEmpresa) { // TO-DO: implementar código de ativação
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)

    var instrucaoSql = `
        INSERT INTO TBL_USUARIO (nome, email, senha, cargo, fkEmpresa) VALUES ('${nome}', '${email}', '${senha}', '${cargo}', '${fkEmpresa}');`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

//Autenticar
function autenticar(email, senha) {
    console.log("ACESSEI O USUARIO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function entrar(): ", email, senha)

    var instrucaoSql = `
        SELECT idUsuario, u.nome AS 'nome', u.email AS 'email', u.senha AS 'senha',e.nome AS 'empresa', e.idEmpresa AS 'fkEmpresa' FROM TBL_USUARIO AS u JOIN TBL_EMPRESA AS e ON e.idEmpresa = u.fkEmpresa WHERE u.email = '${email}' AND senha = '${senha}';`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    cadastrar,
    autenticar
}