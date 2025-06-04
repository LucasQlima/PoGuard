// importa os bibliotecas necessários
const serialport = require("serialport");
const express = require("express");
const mysql = require("mysql2");

// constantes para configurações
const SERIAL_BAUD_RATE = 9600;
const SERVIDOR_PORTA = 3300;

// habilita ou desabilita a inserção de dados no banco de dados
const HABILITAR_OPERACAO_INSERIR = true;

// função para comunicação serial
const serial = async (valoresSensorAnalogico) => {
  let poolBancoDados = mysql
    .createPool({
      host: "10.18.32.122",
      user: "poguard",
      password: "sptech#123",
      database: "PoGuard",
      port: 3306,
    })
    .promise();

  // let poolBancoDados = mysql
  //   .createPool({
  //     host: "localhost",
  //     user: "henry",
  //     password: "sptech@2025",
  //     database: "poguard",
  //     port: 3306,
  //   })
  //   .promise();

  // lista as portas seriais disponíveis e procura pelo Arduino
  const portas = await serialport.SerialPort.list();
  const portaArduino = portas.find(
    (porta) => porta.vendorId == 2341 && porta.productId == 43
  );
  if (!portaArduino) {
    throw new Error("O arduino não foi encontrado em nenhuma porta serial");
  }

  // configura a porta serial com o baud rate especificado
  const arduino = new serialport.SerialPort({
    path: portaArduino.path,
    baudRate: SERIAL_BAUD_RATE,
  });

  // evento quando a porta serial é aberta
  arduino.on("open", () => {
    console.log(
      `A leitura do arduino foi iniciada na porta ${portaArduino.path} utilizando Baud Rate de ${SERIAL_BAUD_RATE}`
    );
  });

  // processa os dados recebidos do Arduino
  arduino
    .pipe(new serialport.ReadlineParser({ delimiter: "\r\n" }))
    .on("data", async (data) => {
      const temperaturas = data.split(";")

      // caminhão 1
      const temperatura1 = temperaturas[0]
      const temperatura2 = temperaturas[1]
      const temperatura3 = temperaturas[2]

      // caminhão 2
      const temperatura4 = temperaturas[3]
      const temperatura5 = temperaturas[4]
      const temperatura6 = temperaturas[5]


      // caminhão 3
      const temperatura7 = temperaturas[6]
      const temperatura8 = temperaturas[7]
      const temperatura9 = temperaturas[8]


      var sensor = {
        idSensorPorta: 1,
        idSensorCentro: 2,
        idSensorFundo: 3
      }



      console.log(`Temperatura 1 ${temperatura1}, Temperatura 2 ${temperatura2} Temperatura 3 ${temperatura3}   `)
      // insere os dados no banco de dados (se habilitado)
      if (HABILITAR_OPERACAO_INSERIR && temperatura1 && temperatura2 && temperatura3 && temperatura4 && temperatura5 && temperatura6 && temperatura7 && temperatura8 && temperatura9) {
        // este insert irá inserir os dados na tabela "medida"
        // CAMINÃO 1
        var insercaoDoDado1 = await poolBancoDados.execute(
          "INSERT INTO TBL_DADO (temperatura, fkSensor) VALUES (?, ?)",
          [temperatura1, sensor.idSensorPorta]
        );

        var insercaoDoDado2 = await poolBancoDados.execute(
          "INSERT INTO TBL_DADO (temperatura, fkSensor) VALUES (?, ?)",
          [temperatura2, sensor.idSensorCentro]
        );

        var insercaoDoDado3 = await poolBancoDados.execute(
          "INSERT INTO TBL_DADO (temperatura, fkSensor) VALUES (?, ?)",
          [temperatura3, sensor.idSensorFundo]
        );

        var temperaturaMedia = (Number(temperatura1) + Number(temperatura2) + Number(temperatura3)) / 3
        if (temperaturaMedia >= -999999) {

          var dado = {
            dadoIdPorta: Number(insercaoDoDado1[0].insertId), dadoIdCentro: Number(insercaoDoDado2[0].insertId), dadoIdFundo: Number(insercaoDoDado3[0].insertId)
          }

          await inserirAlerta(sensor, dado, temperaturaMedia)

        }


        sensor = {
          idSensorPorta: 4,
          idSensorCentro: 5,
          idSensorFundo: 6
        }


        // CAMINÃO 2
        insercaoDoDado1 = await poolBancoDados.execute(
          "INSERT INTO TBL_DADO (temperatura, fkSensor) VALUES (?, ?)",
          [temperatura4, sensor.idSensorPorta]
        );

        insercaoDoDado2 = await poolBancoDados.execute(
          "INSERT INTO TBL_DADO (temperatura, fkSensor) VALUES (?, ?)",
          [temperatura5, sensor.idSensorCentro]
        );

        insercaoDoDado3 = await poolBancoDados.execute(
          "INSERT INTO TBL_DADO (temperatura, fkSensor) VALUES (?, ?)",
          [temperatura6, sensor.idSensorFundo]
        );

        temperaturaMedia = (Number(temperatura4) + Number(temperatura5) + Number(temperatura6)) / 3
        if (temperaturaMedia >= -999999) {

          var dado = {
            dadoIdPorta: Number(insercaoDoDado1[0].insertId), dadoIdCentro: Number(insercaoDoDado2[0].insertId), dadoIdFundo: Number(insercaoDoDado3[0].insertId)
          }

          await inserirAlerta(sensor, dado, temperaturaMedia)
        }



        sensor = {
          idSensorPorta: 7,
          idSensorCentro: 8,
          idSensorFundo: 9
        }


        // CAMINÃO 2
        insercaoDoDado1 = await poolBancoDados.execute(
          "INSERT INTO TBL_DADO (temperatura, fkSensor) VALUES (?, ?)",
          [temperatura7, sensor.idSensorPorta]
        );

        insercaoDoDado2 = await poolBancoDados.execute(
          "INSERT INTO TBL_DADO (temperatura, fkSensor) VALUES (?, ?)",
          [temperatura8, sensor.idSensorCentro]
        );

        insercaoDoDado3 = await poolBancoDados.execute(
          "INSERT INTO TBL_DADO (temperatura, fkSensor) VALUES (?, ?)",
          [temperatura9, sensor.idSensorFundo]
        );

        temperaturaMedia = (Number(temperatura7) + Number(temperatura8) + Number(temperatura9)) / 3
        if (temperaturaMedia >= -999999) {

          var dado = {
            dadoIdPorta: Number(insercaoDoDado1[0].insertId), dadoIdCentro: Number(insercaoDoDado2[0].insertId), dadoIdFundo: Number(insercaoDoDado3[0].insertId)
          }

          await inserirAlerta(sensor, dado, temperaturaMedia)
        }


      }
    });

  // evento para lidar com erros na comunicação serial
  arduino.on("error", (mensagem) => {
    console.error(`Erro no arduino (Mensagem: ${mensagem}`);
  });
};

// função para criar e configurar o servidor web
const servidor = (valoresSensorAnalogico) => {
  const app = express();

  // configurações de requisição e resposta
  app.use((request, response, next) => {
    response.header("Access-Control-Allow-Origin", "*");
    response.header(
      "Access-Control-Allow-Headers",
      "Origin, Content-Type, Accept"
    );
    next();
  });

  // inicia o servidor na porta especificada
  app.listen(SERVIDOR_PORTA, () => {
    console.log(`API executada com sucesso na porta ${SERVIDOR_PORTA}`);
  });

  // define os endpoints da API para cada tipo de sensor
  app.get("/sensores/analogico", (_, response) => {
    return response.json(valoresSensorAnalogico);
  });
};

// função principal assíncrona para iniciar a comunicação serial e o servidor web
(async () => {
  // arrays para armazenar os valores dos sensores
  const valoresSensorAnalogico = [];

  // inicia a comunicação serial
  await serial(valoresSensorAnalogico);

  // inicia o servidor web
  servidor(valoresSensorAnalogico);
})();



// perfeito estado -> não gera alertas
// com problema na porta ->  somente portas negativo
// com medía está horrivel -> alertas constantes 


async function inserirAlerta(sensor, dado, temperaturaMedia) {

  let poolBancoDados = mysql
    .createPool({
      host: "10.18.32.122",
      user: "poguard",
      password: "sptech#123",
      database: "PoGuard",
      port: 3306,
    })
    .promise();

  var consultaDoUltimoAlert = `
            SELECT
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
            veiculo.fkEmpresa = 1 AND
            sensorPorta.idSensor = ${sensor.idSensorPorta} AND
            sensorCentro.idSensor = ${sensor.idSensorCentro} AND
            sensorFundo.idSensor = ${sensor.idSensorFundo}
        GROUP BY
            veiculo.idVeiculo, veiculo.placa, alerta.dtAlerta,
            dadoPorta.temperatura, dadoCentro.temperatura, dadoFundo.temperatura
        ORDER BY
            alerta.dtAlerta DESC
            LIMIT 1;
          `
  var alerta = await poolBancoDados.execute(consultaDoUltimoAlert);
  var ultimoAlerta = alerta[0][0]; // Pega o primeiro resultado, se existir

  var alertaDoStatus = ultimoAlerta ? ultimoAlerta.Status_alerta : null;
  var status = "Ideal"
  if (temperaturaMedia > -14) {
    status = "Crítico"
  } else if (temperaturaMedia > -16) {
    status = "Alerta"
  }

  if (status !== alertaDoStatus) {
    await poolBancoDados.execute(
      "INSERT INTO TBL_ALERTA VALUES (DEFAULT, DEFAULT, NULL, ?, ?, ?)",
      [dado.dadoIdPorta, dado.dadoIdCentro, dado.dadoIdFundo]
    );
    console.log(`🚨 ALERTA GERADO - Status: ${status}, Média: ${temperaturaMedia}`);
  } else {
    console.log(`🔍 Status mantido em ${status} - Sem novo alerta`);
  }
  await poolBancoDados.end()
}