import 'package:flutter/material.dart';
import 'package:latam/models/jornada.dart';

import 'package:latam/pages/resultado2.dart';
import 'package:latam/utilitarios/utilitarios.dart';

class CalcularButton extends StatefulWidget {
  @override
  _CalcularButtonState createState() => _CalcularButtonState();
}

class _CalcularButtonState extends State<CalcularButton> {
  List<Jornada> myList = List();
  Util util;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        /*  Divider(
          height: 5,
          color: Color(0xff858585),
        ), */
        SizedBox(
          height: 20,
        ),
        RaisedButton(
            padding: EdgeInsets.only(
              top: 16,
              bottom: 16,
            ),
            color: Color(0xffed1650),
            child: Text(
              'Calcular'.toUpperCase(),
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            onPressed: () {
              //resetar isInputDataValidated
              Util.isInputDataValidated = false;

              //validar entradas
              Util.validate(Util.tipoTripulacao, context);
              //Util.getJornada(util.faixaHorariaJornada, util.faixaEtapa);
              //teste();
              Util.isInputDataValidated
                  ? Util.gotoScreen(Resultado2(), context)
                  : Container();
            }),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
