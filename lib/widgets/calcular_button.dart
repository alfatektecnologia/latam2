import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latam/models/jornada.dart';

import 'package:latam/pages/resultado2.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:latam/widgets/alerta_lastro_negativo.dart';

class CalcularButton extends StatefulWidget {
  @override
  _CalcularButtonState createState() => _CalcularButtonState();
}

class _CalcularButtonState extends State<CalcularButton> {
  List<Jornada> myList = List();
  bool alertaWasRead = false;
  
  //dialog
  showAlertDialog1(BuildContext context, String title, Widget content) {
    // configura o button
    Widget okButton = FlatButton(
      child:
          Text("OK", style: TextStyle(fontSize: 20, color: Color(0xff00005a))),
      onPressed: () {
        setState(() {
          alertaWasRead = true;
        });

        Navigator.of(context).pop();
        /* Route route = MaterialPageRoute(builder: (context) => Resultado2());
    Navigator.pushReplacement(context, route); */
        /* Util.gotoScreen(Resultado2(), context);  */
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title:
          Text(title, style: TextStyle(
            fontStyle: FontStyle.normal,
            fontSize: 20, 
            color: Color(0xff00005a))),
      contentPadding: EdgeInsets.fromLTRB(16, 24, 16, 24),
      content: content,
      actions: [
        okButton,
      ],
    );
    // exibe o dialog
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        
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
              'Calcular',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            onPressed: () {
              //resetar isInputDataValidated
              Util.isInputDataValidated = false;
              
              //validar entradas
              Util.validate(Util.tipoTripulacao,Util.sobreaviso, context);

              if (Util.isInputDataValidated) {
                // resultadoCalculo.lastro;
                alertaWasRead
                    ? Util.gotoScreen(Resultado2(), context)
                    : Container();
                if (Util.lastroNegativo || Util.lastro2Negativo) {
                  showAlertDialog1(context, 'ALERTA', AlertaLastroNegativo());
                 
                } else {
                  Util.gotoScreen(Resultado2(), context);
                }
              }
            }),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
