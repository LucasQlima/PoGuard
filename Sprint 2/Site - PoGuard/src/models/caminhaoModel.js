var database = require("../database/config");

function obterDados(fkCaminhao) {
    console.log("ACESSEI O CAMINHAO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function encontrarEmpresaPeloCodigo(): ")

    var instrucaoSql = `
        SELECT 
            s.localSensor AS sensor,
            IFNULL(ROUND(d.temperatura, 2), 'N/A') AS temperatura,
            IFNULL(DATE_FORMAT(d.dataHora, '%H:%i'), 'N/A') AS horario_leitura,
            d.idDado AS idDado
        FROM 
            (SELECT DISTINCT localSensor FROM TBL_SENSOR WHERE fkVeiculo = ${fkCaminhao}) s
        LEFT JOIN (
            SELECT 
                d.*,
                s.localSensor,
                ROW_NUMBER() OVER (PARTITION BY s.localSensor ORDER BY d.dataHora DESC) AS row_num
            FROM 
                TBL_DADO d
            JOIN 
                TBL_SENSOR s ON d.fkSensor = s.idSensor
            WHERE 
                s.fkVeiculo = ${fkCaminhao}
        ) d ON s.localSensor = d.localSensor AND d.row_num <= 10
        ORDER BY 
            s.localSensor,
            d.dataHora ASC;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function atualizarDados(fkCaminhao) {
    console.log("ACESSEI O CAMINHAO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function encontrarEmpresaPeloCodigo(): ")

    var instrucaoSql = `
        SELECT 
            s.localSensor AS sensor,
            ROUND(d.temperatura, 2) AS temperatura,
            DATE_FORMAT(d.dataHora, '%H:%i') AS horario_leitura,
            d.idDado AS idDado
        FROM 
            TBL_DADO d
        JOIN 
            TBL_SENSOR s ON d.fkSensor = s.idSensor
        WHERE 
            s.fkVeiculo = 1  -- ID do caminhão desejado
            AND d.idDado IN (
                SELECT MAX(d2.idDado)
                FROM TBL_DADO d2
                JOIN TBL_SENSOR s2 ON d2.fkSensor = s2.idSensor
                WHERE s2.fkVeiculo = ${fkCaminhao}
                GROUP BY s2.localSensor
            )
        ORDER BY 
            CASE s.localSensor
                WHEN 'Porta' THEN 1
                WHEN 'Centro' THEN 2
                WHEN 'Fundo' THEN 3
            END;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    obterDados,
    atualizarDados
}