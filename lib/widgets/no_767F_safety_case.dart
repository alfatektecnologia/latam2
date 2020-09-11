import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:latam/widgets/calcular_button.dart';
import 'package:latam/widgets/dates/data_inicio_jornada2.dart';
import 'package:latam/widgets/times/hora_apresentacao2.dart';
import 'package:latam/widgets/times/hora_apresentacao4.dart';

import 'dates/data_inicio_jornada4.dart';



class No767FSafetyCase extends StatefulWidget {
  @override
  _No767FSafetyCaseState createState() => _No767FSafetyCaseState();
}

class _No767FSafetyCaseState extends State<No767FSafetyCase> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top:0.0),
        child: Card(
          elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
children: <Widget>[

              Util.tipoAcionamentoSobreaviso == 'Reserva + voo'
                  ? DataInicioJornada4()
                  : DataInicioJornada2(), //dataVooIdaDecolagem
             // SizedBox(
             //   height: 8,
            //  ),
              Util.tipoAcionamentoSobreaviso == 'Reserva + voo'
                  ? HoraApresentacao4()
                  : HoraApresentacao2(),
 // DataInicioJornada2(),
 // HoraApresentacao2(),
  CalcularButton(),
],
          ),
                ),
        ),
      ),
      
    );
  }
}