var database = require("../database/config");

function obterAlertasRecentes(fkEmpresa) {
    console.log("ACESSEI O CAMINHAO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function encontrarEmpresaPeloCodigo(): ")

    var instrucaoSql = `
        SELECT
        veiculo.idVeiculo AS id_veiculo,
        veiculo.placa,
        alerta.dtAlerta,
        CONCAT('Há ', TIMESTAMPDIFF(MINUTE, alerta.dtAlerta, NOW()) , 'minutos Atrás') AS 'tempo',
        (
            SELECT dadoPorta.temperatura
            FROM TBL_ALERTA AS alertaPorta
            JOIN TBL_DADO AS dadoPorta ON alertaPorta.fkDado = dadoPorta.idDado
            JOIN TBL_SENSOR AS sensorPorta ON dadoPorta.fkSensor = sensorPorta.idSensor
            JOIN TBL_VEICULO AS veiculoPorta ON sensorPorta.fkVeiculo = veiculoPorta.idVeiculo
            WHERE
                veiculoPorta.idVeiculo = veiculo.idVeiculo -- referindo-se ao veículo externo
                AND sensorPorta.localSensor = 'Porta'
                AND alertaPorta.dtAlerta = alerta.dtAlerta -- referindo-se à data externa
        ) AS Porta,
        (
            SELECT dadoCentro.temperatura
            FROM TBL_ALERTA AS alertaCentro
            JOIN TBL_DADO AS dadoCentro ON alertaCentro.fkDado = dadoCentro.idDado
            JOIN TBL_SENSOR AS sensorCentro ON dadoCentro.fkSensor = sensorCentro.idSensor
            JOIN TBL_VEICULO AS veiculoCentro ON sensorCentro.fkVeiculo = veiculoCentro.idVeiculo
            WHERE
                veiculoCentro.idVeiculo = veiculo.idVeiculo -- referindo-se ao veículo externo
                AND sensorCentro.localSensor = 'Centro'
                AND alertaCentro.dtAlerta = alerta.dtAlerta -- referindo-se à data externa
        ) AS Centro,
        (
            SELECT dadoFundo.temperatura
            FROM TBL_ALERTA AS alertaSub
            JOIN TBL_DADO AS dadoFundo ON alertaSub.fkDado = dadoFundo.idDado
            JOIN TBL_SENSOR AS sensorFundo ON dadoFundo.fkSensor = sensorFundo.idSensor
            JOIN TBL_VEICULO AS veiculoFundo ON sensorFundo.fkVeiculo = veiculoFundo.idVeiculo
            WHERE
                veiculoFundo.idVeiculo = veiculo.idVeiculo -- referindo-se ao veículo externo
                AND sensorFundo.localSensor = 'Fundo'
                AND alertaSub.dtAlerta = alerta.dtAlerta -- referindo-se à data externa
        ) AS Fundo,
        (
            SELECT TRUNCATE(AVG(dadoFundo.temperatura),2)
            FROM TBL_ALERTA AS alertaSub
            JOIN TBL_DADO AS dadoFundo ON alertaSub.fkDado = dadoFundo.idDado
            JOIN TBL_SENSOR AS sensorFundo ON dadoFundo.fkSensor = sensorFundo.idSensor
            JOIN TBL_VEICULO AS veiculoFundo ON sensorFundo.fkVeiculo = veiculoFundo.idVeiculo
            WHERE
                veiculoFundo.idVeiculo = veiculo.idVeiculo -- referindo-se ao veículo externo
                AND alertaSub.dtAlerta = alerta.dtAlerta -- referindo-se à data externa
        ) AS Media,
        (
            SELECT
            CASE
                        WHEN TRUNCATE(AVG(dadoFundo.temperatura), 2) > -14 THEN 'Crítico'
                        WHEN TRUNCATE(AVG(dadoFundo.temperatura), 2) >= -16 AND TRUNCATE(AVG(dadoFundo.temperatura), 2) <= -12 THEN 'Alerta'
                    ELSE 'Normal'
                    END
            FROM TBL_ALERTA AS alertaSub
            JOIN TBL_DADO AS dadoFundo ON alertaSub.fkDado = dadoFundo.idDado
            JOIN TBL_SENSOR AS sensorFundo ON dadoFundo.fkSensor = sensorFundo.idSensor
            JOIN TBL_VEICULO AS veiculoFundo ON sensorFundo.fkVeiculo = veiculoFundo.idVeiculo
            WHERE
                veiculoFundo.idVeiculo = veiculo.idVeiculo -- referindo-se ao veículo externo
                AND alertaSub.dtAlerta = alerta.dtAlerta -- referindo-se à data externa
        ) AS Status_alerta

        FROM
            TBL_ALERTA AS alerta
        JOIN TBL_DADO AS dado ON dado.idDado = alerta.fkDado
        JOIN TBL_SENSOR AS sensor ON sensor.idSensor = dado.fkSensor
        JOIN TBL_VEICULO AS veiculo ON veiculo.idVeiculo = sensor.fkVeiculo
        WHERE fkEmpresa = ${fkEmpresa}
        GROUP BY veiculo.idVeiculo, alerta.dtAlerta
        ORDER BY alerta.dtAlerta DESC LIMIT 3;`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}



module.exports = {
    obterAlertasRecentes
}