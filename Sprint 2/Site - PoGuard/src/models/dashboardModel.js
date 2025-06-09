var database = require("../database/config");

function frotaAtiva(fkEmpresa) {
	console.log("ACESSEI O CAMINHAO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function frotaAtiva(): ")

	var instrucaoSql = `
	    SELECT 
		    v.idVeiculo,
		    v.placa,
		    recentes.temperatura_porta,
		    recentes.datahora_porta,
		    recentes.temperatura_centro,
		    recentes.datahora_centro,
		    recentes.temperatura_fundo,
		    recentes.datahora_fundo,
		    CASE 
		        WHEN recentes.idVeiculo IS NOT NULL THEN 'Ativo'
		        ELSE 'Inativo'
		    END AS status
		FROM
		    TBL_VEICULO v
		LEFT JOIN (
		    SELECT 
		        v.idVeiculo,
		        MAX(CASE WHEN s.localSensor = 'Porta' THEN d.temperatura END) AS temperatura_porta,
		        MAX(CASE WHEN s.localSensor = 'Porta' THEN d.dataHora END) AS datahora_porta,
		        MAX(CASE WHEN s.localSensor = 'Centro' THEN d.temperatura END) AS temperatura_centro,
		        MAX(CASE WHEN s.localSensor = 'Centro' THEN d.dataHora END) AS datahora_centro,
		        MAX(CASE WHEN s.localSensor = 'Fundo' THEN d.temperatura END) AS temperatura_fundo,
		        MAX(CASE WHEN s.localSensor = 'Fundo' THEN d.dataHora END) AS datahora_fundo
		    FROM
		        TBL_VEICULO v
		        JOIN TBL_SENSOR s ON v.idVeiculo = s.fkVeiculo
		        JOIN TBL_DADO d ON s.idSensor = d.fkSensor
		    WHERE
		        DATE(d.dataHora) = DATE(NOW())
		        AND v.fkEmpresa = ${fkEmpresa}
		        AND d.dataHora >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
		        AND (s.fkVeiculo, s.localSensor, d.dataHora) IN (
		            SELECT 
		                s2.fkVeiculo, 
		                s2.localSensor, 
		                MAX(d2.dataHora)
		            FROM
		                TBL_SENSOR s2
		                JOIN TBL_DADO d2 ON s2.idSensor = d2.fkSensor
		            WHERE
		                DATE(d2.dataHora) = DATE(NOW())
		                AND d2.dataHora >= DATE_SUB(NOW(), INTERVAL 5 MINUTE)
		            GROUP BY s2.fkVeiculo, s2.localSensor
		        )
		    GROUP BY v.idVeiculo
		) recentes ON v.idVeiculo = recentes.idVeiculo
		WHERE
		    v.fkEmpresa = ${fkEmpresa}
		ORDER BY 
		    status DESC,
		    v.placa;`;

	console.log("Executando a instrução SQL: \n" + instrucaoSql);
	return database.executar(instrucaoSql);
}

function ativaStatus(fkEmpresa) {
	console.log("ACESSEI O CAMINHAO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function frotaAtiva(): ")

	var instrucaoSql = `
		SELECT
		v.idVeiculo,
		v.placa,
		MAX(CASE WHEN s.localSensor = 'Porta' THEN d.temperatura END) AS temperatura_porta,
		MAX(CASE WHEN s.localSensor = 'Porta' THEN d.dataHora END) AS datahora_porta,
		MAX(CASE WHEN s.localSensor = 'Centro' THEN d.temperatura END) AS temperatura_centro,
		MAX(CASE WHEN s.localSensor = 'Centro' THEN d.dataHora END) AS datahora_centro,
		MAX(CASE WHEN s.localSensor = 'Fundo' THEN d.temperatura END) AS temperatura_fundo,
		MAX(CASE WHEN s.localSensor = 'Fundo' THEN d.dataHora END) AS datahora_fundo,
		'Ativo' AS status
	FROM
		TBL_VEICULO v
	JOIN
		TBL_SENSOR s ON v.idVeiculo = s.fkVeiculo
	JOIN
		TBL_DADO d ON s.idSensor = d.fkSensor
	WHERE
		v.fkEmpresa = ${fkEmpresa}
		AND DATE(d.dataHora) = DATE(NOW())
		AND d.dataHora >= DATE_SUB(NOW(), INTERVAL 7 SECOND)
	GROUP BY
		v.idVeiculo, v.placa
	ORDER BY
		v.placa;`;

	console.log("Executando a instrução SQL: \n" + instrucaoSql);
	return database.executar(instrucaoSql);
}

module.exports = {
	frotaAtiva,
	ativaStatus
}