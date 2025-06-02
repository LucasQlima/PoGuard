var database = require("../database/config");

function frotaAtiva(fkEmpresa, idUsuario) {
    console.log("ACESSEI O CAMINHAO MODEL \n \n\t\t >> Se aqui der erro de 'Error: connect ECONNREFUSED',\n \t\t >> verifique suas credenciais de acesso ao banco\n \t\t >> e se o servidor de seu BD está rodando corretamente. \n\n function frotaAtiva(): ")

    var instrucaoSql = `
        SELECT 
		    COUNT(v.idVeiculo) as frota,
            (
			    select
				    COUNT(hs.fkVeiculo)
			    FROM
				    TBL_EMPRESA es JOIN TBL_VEICULO vs
					    ON es.idEmpresa = vs.fkEmpresa
				    JOIN TBL_HISTORICO hs
					    ON vs.idVeiculo = hs.fkVeiculo
			    WHERE
				    hs.dataFim is null AND
                    hs.fkEmpresa = ${fkEmpresa}
            ) as ativo
	    FROM
		    TBL_USUARIO u JOIN TBL_EMPRESA e
			    ON e.idEmpresa = u.fkEmpresa
		    JOIN TBL_VEICULO v
			    ON e.idEmpresa = v.fkEmpresa
		    LEFT JOIN TBL_HISTORICO h
			    ON v.idVeiculo = h.fkVeiculo
	    WHERE 
		    v.fkEmpresa = ${fkEmpresa} AND u.idUsuario = ${idUsuario}; `;
    
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    frotaAtiva
}