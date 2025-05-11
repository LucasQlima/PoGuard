var database = require("../database/config");

function encontrarEmpresaPeloCodigo(codigoEmpresa) {
    console.log("ACESSEI O EMPRESA MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function encontrarEmpresaPeloCodigo(): ")
    
    var instrucaoSql = `
        SELECT * FROM TBL_EMPRESA WHERE codigoEmpresa = '${codigoEmpresa}';`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    encontrarEmpresaPeloCodigo
}