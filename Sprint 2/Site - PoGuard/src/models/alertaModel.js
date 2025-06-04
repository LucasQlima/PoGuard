var database = require("../database/config");

function obterAlertasRecentes(fkEmpresa) {
    console.log("ACESSEI O CAMINHAO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function encontrarEmpresaPeloCodigo(): ")

    var instrucaoSql = `
    SELECT
    veiculo.idVeiculo AS id_veiculo,
    veiculo.placa,
    alerta.dtAlerta,
    CONCAT('Há ', TIMESTAMPDIFF(MINUTE, alerta.dtAlerta, NOW()), ' minutos atrás') AS tempo,
    dadoPorta.temperatura AS Porta,
    dadoCentro.temperatura AS Centro,
    dadoFundo.temperatura AS Fundo,
    TRUNCATE((
        dadoPorta.temperatura +
        dadoCentro.temperatura +
        dadoFundo.temperatura
    ) / 3, 2) AS Media,
    CASE
        WHEN TRUNCATE((
            dadoPorta.temperatura +
            dadoCentro.temperatura +
            dadoFundo.temperatura
        ) / 3, 2) > -14 THEN 'Crítico'

        WHEN TRUNCATE((
            dadoPorta.temperatura +
            dadoCentro.temperatura +
            dadoFundo.temperatura
        ) / 3, 2) > -16 AND TRUNCATE((
            dadoPorta.temperatura +
            dadoCentro.temperatura +
            dadoFundo.temperatura
        ) / 3, 2) <= -14 THEN 'Alerta'
        ELSE 'Ideal'
    END AS Status_alerta
FROM
    TBL_ALERTA AS alerta
JOIN TBL_DADO AS dadoPorta ON dadoPorta.idDado = alerta.fkDadoPorta
JOIN TBL_SENSOR AS sensorPorta ON sensorPorta.idSensor = dadoPorta.fkSensor
JOIN TBL_DADO AS dadoCentro ON dadoCentro.idDado = alerta.fkDadoCentro
JOIN TBL_SENSOR AS sensorCentro ON sensorCentro.idSensor = dadoCentro.fkSensor
JOIN TBL_DADO AS dadoFundo ON dadoFundo.idDado = alerta.fkDadoFundo
JOIN TBL_SENSOR AS sensorFundo ON sensorFundo.idSensor = dadoFundo.fkSensor
JOIN TBL_VEICULO AS veiculo ON veiculo.idVeiculo = sensorPorta.fkVeiculo
WHERE
    veiculo.fkEmpresa = ${fkEmpresa}
GROUP BY
    veiculo.idVeiculo, veiculo.placa, alerta.dtAlerta,
    dadoPorta.temperatura, dadoCentro.temperatura, dadoFundo.temperatura
ORDER BY
    alerta.dtAlerta DESC
LIMIT 3;
    `

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function todosAlertas(fkEmpresa) {
    console.log("ACESSEI O CAMINHAO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function encontrarEmpresaPeloCodigo(): ")

    var instrucaoSql = `
        SELECT
        veiculo.idVeiculo AS id_veiculo,
        veiculo.placa,
        alerta.dtAlerta,
        CONCAT('Há ', TIMESTAMPDIFF(MINUTE, alerta.dtAlerta, NOW()), ' minutos atrás') AS tempo,
        dadoPorta.temperatura AS Porta,
        dadoCentro.temperatura AS Centro,
        dadoFundo.temperatura AS Fundo,
        TRUNCATE((
            dadoPorta.temperatura +
            dadoCentro.temperatura +
            dadoFundo.temperatura
        ) / 3, 2) AS Media,
        CASE
            WHEN TRUNCATE((
                dadoPorta.temperatura +
                dadoCentro.temperatura +
                dadoFundo.temperatura
            ) / 3, 2) > -14 THEN 'Crítico'

            WHEN TRUNCATE((
                dadoPorta.temperatura +
                dadoCentro.temperatura +
                dadoFundo.temperatura
            ) / 3, 2) > -16 AND TRUNCATE((
                dadoPorta.temperatura +
                dadoCentro.temperatura +
                dadoFundo.temperatura
            ) / 3, 2) <= -14 THEN 'Alerta'
            ELSE 'Ideal'
        END AS Status_alerta
        FROM
        TBL_ALERTA AS alerta
        JOIN TBL_DADO AS dadoPorta ON dadoPorta.idDado = alerta.fkDadoPorta
        JOIN TBL_SENSOR AS sensorPorta ON sensorPorta.idSensor = dadoPorta.fkSensor
        JOIN TBL_DADO AS dadoCentro ON dadoCentro.idDado = alerta.fkDadoCentro
        JOIN TBL_SENSOR AS sensorCentro ON sensorCentro.idSensor = dadoCentro.fkSensor
        JOIN TBL_DADO AS dadoFundo ON dadoFundo.idDado = alerta.fkDadoFundo
        JOIN TBL_SENSOR AS sensorFundo ON sensorFundo.idSensor = dadoFundo.fkSensor
        JOIN TBL_VEICULO AS veiculo ON veiculo.idVeiculo = sensorPorta.fkVeiculo
        WHERE
        veiculo.fkEmpresa = ${fkEmpresa}
        GROUP BY
        veiculo.idVeiculo, veiculo.placa, alerta.dtAlerta,
        dadoPorta.temperatura, dadoCentro.temperatura, dadoFundo.temperatura
        ORDER BY
        alerta.dtAlerta DESC LIMIT 100;`

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function alertasCriticosAtuais(fkEmpresa) {
    console.log("ACESSEI O CAMINHAO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function encontrarEmpresaPeloCodigo(): ")

    var instrucaoSql = `
      SELECT 
            E.nome AS nome_empresa,
            COUNT(A.idAlerta) AS total_alertas,
            SUM(
                CASE
                    WHEN ((DP.temperatura + DC.temperatura + DF.temperatura) / 3) > -14 THEN 1
                    ELSE 0
                END
            ) AS total_vermelhos
        FROM 
            TBL_ALERTA A
        JOIN TBL_DADO DP ON A.fkDadoPorta = DP.idDado
        JOIN TBL_DADO DC ON A.fkDadoCentro = DC.idDado
        JOIN TBL_DADO DF ON A.fkDadoFundo = DF.idDado
        JOIN TBL_SENSOR SP ON DP.fkSensor = SP.idSensor
        JOIN TBL_VEICULO V ON SP.fkVeiculo = V.idVeiculo
        JOIN TBL_EMPRESA E ON V.fkEmpresa = E.idEmpresa
        WHERE 
            E.idEmpresa = ${fkEmpresa}  
            AND DATE(A.dtAlerta) = DATE(NOW())
        GROUP BY 
            E.nome;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    obterAlertasRecentes,
    todosAlertas,
    alertasCriticosAtuais
}