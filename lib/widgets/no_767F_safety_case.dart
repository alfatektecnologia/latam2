import 'package:flutter/material.dart';
import 'package:latam/widgets/calcular_button.dart';
import 'package:latam/widgets/dates/data_inicio_jornada2.dart';
import 'package:latam/widgets/times/hora_apresentacao2.dart';



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

  DataInicioJornada2(),
  HoraApresentacao2(),
  CalcularButton(),
],
          ),
                ),
        ),
      ),
      
    );
  }
}