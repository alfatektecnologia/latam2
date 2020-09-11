import 'package:intl/intl.dart';
import 'dart:math';

import 'package:latam/utilitarios/utilitarios.dart';

class Resultado {
  double jornada;
  String voo;
  String horarioLimiteCorteMotor;
  String horarioLimiteTerminoJornada;
  String lastro;
  bool lastroNegativo;
  double jornada2;
  String voo2;
  String horarioLimiteCorteMotor2;
  String horarioLimiteTerminoJornada2;
  String lastro2;
  bool lastro2Negativo;
  String aclimatacao;
  String jornadaFormatada() {
    if (jornada == -1) {
      return 'Preencha os campos';
    } else {
      return formatTime(jornada) + ' horas';
    }
  }

  String jornada2Formatada() {
    if (jornada2 == -1) {
      return 'Preencha os campos';
    } else {
      return formatTime(jornada2) + ' horas';
    }
  }

  Resultado({this.jornada, this.voo});

  double dp(double val, int places) {
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  double getDecimal(double number) {
    int inteiro = number.toInt();

    return dp((number - inteiro), 2);
  }

  int getMinutesFromDecimal(double number) {
    return (number * 60).round();
  }

  String formatTime(double number) {
    String hora = number.toInt().toString();
    String minuto = getMinutesFromDecimal(getDecimal(number)).toString();

    if (minuto.length == 1) minuto = '0' + minuto;

    return hora + ':' + minuto;
  }
}

class Calculo {
  Resultado calcular(
      String equipamento,
      String tripulacao,
      String etapas,
      String funcao,
      String fusos,
      String safetyCase,
      String sobreaviso,
      String acionado,
      String destino,
      String rotaSafetyCase,
      DateTime horarioInicioSobreaviso,
      DateTime horarioTerminoSobreaviso,
      DateTime dataReserva,
      DateTime horaReserva,
      DateTime dataVooIdaDecolagem,
      DateTime horaVooIdaDecolagem,
      DateTime dataVooIdaPouso,
      DateTime horaVooIdaPouso,
      DateTime dataVooVoltaDecolagem,
      DateTime horaVooVoltaDecolagem,
      DateTime dataVooVoltaPouso,
      DateTime horaVooVoltaPouso) {
    Resultado res;
    Resultado res2;

    bool faltaDados = false;

    if (((dataVooIdaDecolagem == null || dataVooIdaPouso == null) &&
            safetyCase == '0') ||
        ((dataVooIdaDecolagem == null || dataVooIdaPouso == null) &&
            safetyCase == '1' &&
            equipamento == 'B767F') ||
        (dataVooIdaDecolagem == null &&
            safetyCase == '1' &&
            equipamento != 'B767F')) {
              faltaDados = true;
    }
/*
    if(horaVooIdaDecolagem == null || horaVooIdaPouso == null){
      faltaDados = true;
    }

    if(dataVooVoltaDecolagem!=null && horaVooVoltaDecolagem==null){
      faltaDados = true;
    }
    if(dataVooVoltaPouso!=null && horaVooVoltaPouso==null){
      faltaDados = true;
    }
*/
    if(faltaDados){
      res = new Resultado(jornada: -1, voo: 'Preencha os campos');
      res.horarioLimiteCorteMotor = 'Preencha os campos';
      res.horarioLimiteCorteMotor2 = 'Preencha os campos';
      res.horarioLimiteTerminoJornada = 'Preencha os campos';
      res.horarioLimiteTerminoJornada2 = 'Preencha os campos';
      res.lastro = 'Preencha os campos';
      res.lastro2 = 'Preencha os campos';
      res.jornada2 = -1;
      res.voo2 = 'Preencha os campos';
      res.aclimatacao = 'Preencha os campos';
      return res;
    }

    if (dataVooIdaDecolagem != null && horaVooIdaDecolagem != null) {
      dataVooIdaDecolagem = new DateTime(
          dataVooIdaDecolagem.year,
          dataVooIdaDecolagem.month,
          dataVooIdaDecolagem.day,
          horaVooIdaDecolagem.hour,
          horaVooIdaDecolagem.minute,
          horaVooIdaDecolagem.second,
          horaVooIdaDecolagem.millisecond);
    }

    if (dataVooIdaPouso != null && horaVooIdaPouso != null) {
      dataVooIdaPouso = new DateTime(
          dataVooIdaPouso.year,
          dataVooIdaPouso.month,
          dataVooIdaPouso.day,
          horaVooIdaPouso.hour,
          horaVooIdaPouso.minute,
          horaVooIdaPouso.second,
          horaVooIdaPouso.millisecond);
    }

    if (dataReserva != null && horaReserva != null) {
      dataReserva = new DateTime(
          dataReserva.year,
          dataReserva.month,
          dataReserva.day,
          horaReserva.hour,
          horaReserva.minute,
          horaReserva.second,
          horaReserva.millisecond);
    }

    if (dataVooVoltaDecolagem != null && horaVooVoltaDecolagem != null) {
      dataVooVoltaDecolagem = new DateTime(
          dataVooVoltaDecolagem.year,
          dataVooVoltaDecolagem.month,
          dataVooVoltaDecolagem.day,
          horaVooVoltaDecolagem.hour,
          horaVooVoltaDecolagem.minute,
          horaVooVoltaDecolagem.second,
          horaVooVoltaDecolagem.millisecond);
    }

    if (dataVooVoltaPouso != null && horaVooVoltaPouso != null) {
      dataVooVoltaPouso = new DateTime(
          dataVooVoltaPouso.year,
          dataVooVoltaPouso.month,
          dataVooVoltaPouso.day,
          horaVooVoltaPouso.hour,
          horaVooVoltaPouso.minute,
          horaVooVoltaPouso.second,
          horaVooVoltaPouso.millisecond);
    }

    if (equipamento != 'B767F' && safetyCase == '1') {
      //pax e safety case
      res = new Resultado(
          jornada: 17,
          voo: rotaSafetyCase == '0' ? '14:00 horas' : '16:00 horas');
      if (dataVooIdaDecolagem != null) {
        DateTime d = dataVooIdaDecolagem.add(new Duration(hours: 17));

        res.horarioLimiteTerminoJornada =
            DateFormat('HH:mm').format(d) + ' horas';
        res.horarioLimiteCorteMotor =
            DateFormat('HH:mm').format(d.add(new Duration(minutes: -45))) +
                ' horas';
      }
      if (res.horarioLimiteCorteMotor == null)
        res.horarioLimiteCorteMotor = 'Preencha os campos';
      if (res.horarioLimiteTerminoJornada == null)
        res.horarioLimiteTerminoJornada = 'Preencha os campos';
      if (res.lastro == null) res.lastro = 'Preencha os campos';
      if (res.aclimatacao == null) res.aclimatacao = 'Preencha os campos';
      res.horarioLimiteCorteMotor2 = 'Preencha os campos';
      res.horarioLimiteTerminoJornada2 = 'Preencha os campos';
      res.lastro2 = 'Preencha os campos';
      res.jornada2 = -1;
      res.voo2 = 'Preencha os campos';
      return res;
    } else {
      res = performQuery(equipamento, tripulacao, etapas, funcao, fusos,
          safetyCase, dataVooIdaDecolagem.hour);

      //os casos M3 safety case, tripulacao simples, teriam 1 hora de adicao à jornada
      //os casos M3 safety case, tripulacao composta ou revezamento, teriam 2 horas de adicao a jornada
      if (equipamento == 'B767F' && safetyCase == '1') {
        if (tripulacao == 'SIMPLES') {
          res.jornada = res.jornada + 1;
          if (res.jornada > 12) res.jornada = 12;
          //a jornada nao pode passar de 12
        } else if (tripulacao == 'REVEZAMENTO') {
          res.jornada = res.jornada + 2;
          if (res.jornada > 18) res.jornada = 18;
          String hora = res.voo.substring(0, res.voo.indexOf(':'));
          String minuto = res.voo.substring(res.voo.indexOf(':') + 1);
          int horaint = int.parse(hora) + 1;
          hora = horaint.toString();
          if (hora.length == 1) {
            hora = '0' + hora;
          }
          res.voo = hora + ':' + minuto;
          //res.voo = hora;
          //tem que aumentar 1 hora no voo
          //a jornada nao pode passar de 18
        }
      }

      Duration tempoSobreAviso;
      int sobreavisoQueSupera8Horas = 0;
      if (horarioInicioSobreaviso != null && horarioTerminoSobreaviso != null) {
        if (horarioInicioSobreaviso.compareTo(horarioTerminoSobreaviso) > 0) {
          horarioTerminoSobreaviso =
              horarioTerminoSobreaviso.add(Duration(days: 1));
        }
        tempoSobreAviso =
            horarioTerminoSobreaviso.difference(horarioInicioSobreaviso);
        //print('tempoSobreAviso: ' + tempoSobreAviso.toString());
      } else {
        tempoSobreAviso = new Duration(minutes: 0);
      }

      if (sobreaviso == '1') {
        //esta de sobreaviso
        if (acionado == '0' || acionado == '1') {
          //para voo ou voo + reserva
          if (tripulacao == 'SIMPLES') {
            //res.jornada = ((16 * 60) - tempoSobreAviso.inMinutes) / 60;
            res.jornada = 16; //calcular o tempo de sobre aviso, fazer 16- isso
          } else {
            //tripulacao composta ou revezamento
            sobreavisoQueSupera8Horas = tempoSobreAviso.inMinutes - (8 * 60);
            //if (sobreavisoQueSupera8Horas > 0) {

            //res.jornada = ((res.jornada * 60) - sobreavisoQueSupera8Horas) /
            //  60; //verificar
            //}
          }
        }
      }

      DateTime horarioLimiteJornada = dataVooIdaDecolagem
          .add(new Duration(minutes: (res.jornada * 60).toInt()));

      if (sobreaviso == '1' && tripulacao == 'SIMPLES') {
        horarioLimiteJornada = dataVooIdaDecolagem.add(
            new Duration(minutes: (res.jornada * 60).toInt()) -
                tempoSobreAviso);
      }
      if (sobreavisoQueSupera8Horas > 0) {
        horarioLimiteJornada = dataVooIdaDecolagem.add(
            new Duration(minutes: (res.jornada * 60).toInt()) -
                Duration(minutes: sobreavisoQueSupera8Horas));
      }

      Duration timeBetweenPousoELimite =
          horarioLimiteJornada.add(new Duration(minutes: destino == 'DOM' ? -30 : -45)).difference(dataVooIdaPouso);
      
      
      int lastroNegativo = 0;
      int lastroEmMinutos = 0;

      if (timeBetweenPousoELimite.inMicroseconds < 0) {
        lastroNegativo = 1;
        timeBetweenPousoELimite = timeBetweenPousoELimite * -1;

        lastroEmMinutos =
            timeBetweenPousoELimite.inMinutes;// + (destino == 'DOM' ? 30 : 45);
      } else {
        lastroEmMinutos =
            timeBetweenPousoELimite.inMinutes; //- (destino == 'DOM' ? 30 : 45);
      }

      DateTime lastroTemp = new DateTime(DateTime.now().year, 1, 1, 0, 0, 0, 0);
      lastroTemp = lastroTemp.add(new Duration(minutes: lastroEmMinutos));

      res.horarioLimiteTerminoJornada =
          DateFormat('HH:mm').format(horarioLimiteJornada);
      res.horarioLimiteCorteMotor = DateFormat('HH:mm').format(
          horarioLimiteJornada
              .add(new Duration(minutes: destino == 'DOM' ? -30 : -45)));
      res.lastro = DateFormat('HH:mm').format(lastroTemp);
      if (lastroNegativo == 1) {
        res.lastro = '-' + DateFormat('HH:mm').format(lastroTemp);
      Util.lastroNegativo=true;
      }else {Util.lastroNegativo=false;}
      res.lastroNegativo = lastroNegativo == 1;

      if (tripulacao == 'SIMPLES' || fusos == 'MENOS') {
        res.horarioLimiteTerminoJornada2 = '00:00';
        res.horarioLimiteCorteMotor2 = '00:00';
        res.lastro2 = '00:00';
      } else {
        if (dataVooVoltaDecolagem == null || dataVooVoltaPouso == null) {
          res.horarioLimiteTerminoJornada2 = 'Preencha os campos';
          res.horarioLimiteCorteMotor2 = 'Preencha os campos';
          res.lastro2 = 'Preencha os campos';
        } else {
          //tripulacao composta com fusos maior ou igual a 3
          res2 = performQuery(equipamento, tripulacao, etapas, funcao, fusos,
              safetyCase, dataVooVoltaDecolagem.hour);

          res.jornada2 = res2.jornada;
          res.voo2 = res2.voo;

          if (dataVooIdaDecolagem != null && dataVooVoltaDecolagem != null) {
            if (dataVooVoltaDecolagem.difference(dataVooIdaDecolagem).inHours >
                36) {
              res.aclimatacao = 'Estado desconhecido de aclimatação';
              res2.jornada = res2.jornada - 1;
              res.jornada2 = res.jornada2 - 1;
            } else {
              res.aclimatacao = 'Aclimatado';
            }
          } else {
            res.aclimatacao = 'Preencha os campos';
          }

          DateTime horarioLimiteJornada2 = dataVooVoltaDecolagem
              .add(new Duration(minutes: res2.jornada.toInt() * 60));

          Duration timeBetweenPousoELimite2 =
              horarioLimiteJornada2.add(new Duration(minutes: destino == 'DOM' ? -30 : -45)).difference(dataVooVoltaPouso);

          int lastroNegativo2 = 0;
          int lastroEmMinutos2 = 0;

          if (timeBetweenPousoELimite2.inMicroseconds < 0) {
            lastroNegativo2 = 1;
            timeBetweenPousoELimite2 = timeBetweenPousoELimite2 * -1;

            lastroEmMinutos2 = timeBetweenPousoELimite2.inMinutes;// + (destino == 'DOM' ? 30 : 45);
          } else {
            lastroEmMinutos2 = timeBetweenPousoELimite2.inMinutes;// - (destino == 'DOM' ? 30 : 45);
          }

          DateTime lastroTemp2 =
              new DateTime(DateTime.now().year, 1, 1, 0, 0, 0, 0);
          lastroTemp2 =
              lastroTemp2.add(new Duration(minutes: lastroEmMinutos2));

          res.horarioLimiteTerminoJornada2 =
              DateFormat('HH:mm').format(horarioLimiteJornada2);
          res.horarioLimiteCorteMotor2 = DateFormat('HH:mm').format(
              horarioLimiteJornada2
                  .add(new Duration(minutes: destino == 'DOM' ? -30 : -45)));
          res.lastro2 = DateFormat('HH:mm').format(lastroTemp2);
          if (lastroNegativo2 == 1) {
            res.lastro2 = '-' + DateFormat('HH:mm').format(lastroTemp2);
          Util.lastro2Negativo=true;
          }else {Util.lastro2Negativo=false;}
          res.lastro2Negativo = lastroNegativo2 == 1;
        }
      }

      if (res.horarioLimiteCorteMotor == null)
        res.horarioLimiteCorteMotor = 'Preencha os campos';
      if (res.horarioLimiteTerminoJornada == null)
        res.horarioLimiteTerminoJornada = 'Preencha os campos';
      if (res.lastro == null) res.lastro = 'Preencha os campos';
      if (res.aclimatacao == null) res.aclimatacao = 'Preencha os campos';
      if (res.horarioLimiteCorteMotor2 == null)
        res.horarioLimiteCorteMotor2 = 'Preencha os campos';
      if (res.horarioLimiteTerminoJornada2 == null)
        res.horarioLimiteTerminoJornada2 = 'Preencha os campos';
      if (res.lastro2 == null) res.lastro2 = 'Preencha os campos';
      if (res.voo2 == null) res.voo2 = 'Preencha os campos';
      if (res.jornada2 == null) res.jornada2 = -1;

      res.voo = res.voo + ' horas';
      res.horarioLimiteCorteMotor = res.horarioLimiteCorteMotor + ' horas';
      res.horarioLimiteTerminoJornada =
          res.horarioLimiteTerminoJornada + ' horas';
      res.lastro = res.lastro + ' horas';
      res.voo2 = res.voo2 + ' horas';
      res.horarioLimiteCorteMotor2 = res.horarioLimiteCorteMotor2 + ' horas';
      res.horarioLimiteTerminoJornada2 =
          res.horarioLimiteTerminoJornada2 + ' horas';
      res.lastro2 = res.lastro2 + ' horas';

      return res;
    }
  }

  Resultado performQuery(String equipamento, String tripulacao, String etapas,
      String funcao, String fusos, String safetyCase, int hora) {
    if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 12, voo: '10:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 12, voo: '10:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '10:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '10:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '10:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '10:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 18, voo: '16:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 15, voo: '13:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 17, voo: '15:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 12, voo: '10:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MENOS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 12, voo: '10:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'COMPOSTA' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'A32F' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 13, voo: '11:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'A350' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TT' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B777' &&
        tripulacao == 'REVEZAMENTO' &&
        funcao == 'TC' &&
        fusos == 'MAIS' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MENOS' &&
        safetyCase == '1' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'COMPOSTA' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 14, voo: '12:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'REVEZAMENTO' &&
        fusos == 'MAIS' &&
        safetyCase == '1' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 16, voo: '14:30' '');
    }
    if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '1' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '1' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '1' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '1' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '1' &&
        hora >= 0 &&
        hora < 6) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '1' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '1' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '1' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '1' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '1' &&
        hora >= 6 &&
        hora < 7) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '1' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '1' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '1' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '1' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '1' &&
        hora >= 7 &&
        hora < 8) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '10:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '1' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '1' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '10:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '1' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '1' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '1' &&
        hora >= 8 &&
        hora < 12) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '1' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 12, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '1' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 12, voo: '9:30' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '1' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '1' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '1' &&
        hora >= 12 &&
        hora < 14) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '1' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '1' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 11, voo: '9:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '1' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '1' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '1' &&
        hora >= 14 &&
        hora < 16) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '1' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '1' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 10, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '1' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '1' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '1' &&
        hora >= 16 &&
        hora < 18) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '0' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '3 OU 4' &&
        safetyCase == '1' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '1 OU 2' &&
        safetyCase == '1' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '8:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '5' &&
        safetyCase == '1' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '6' &&
        safetyCase == '1' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else if (equipamento == 'B767F' &&
        tripulacao == 'SIMPLES' &&
        etapas == '7 +' &&
        safetyCase == '1' &&
        hora >= 18 &&
        hora < 24) {
      return new Resultado(jornada: 9, voo: '7:00' '');
    } else {
      return new Resultado(jornada: 0, voo: '00:00');
    }
  }
}
