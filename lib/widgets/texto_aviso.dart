import 'package:flutter/material.dart';

class TextoAviso extends StatefulWidget {
  @override
  _TextoAvisoState createState() => _TextoAvisoState();
}

class _TextoAvisoState extends State<TextoAviso> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        SizedBox(
          height: 24,
        ),
        Divider(height: 5, color: Color(0xff858585)),
        SizedBox(height: 16,),
        Text(
          'Bem-vindo tripulante,',
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: 'TREBUC',
            fontSize: 18,
            fontWeight:FontWeight.normal,
            color: Color(0xff858585),
            //letterSpacing: 3,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'Este aplicativo foi desenvolvido para que você consiga consultar, de forma fácil e prática, o limite da sua jornada de acordo com o RBAC 117.',
textAlign:TextAlign.justify,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: 'TREBUC',
            fontSize: 18,
            fontWeight:FontWeight.normal,
            color: Color(0xff858585),
            //letterSpacing: 3,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'A ferramenta não contempla as regras referente à interrupção de jornada, reprogramação, cancelamento ou atraso de voo antes da apresentação.',
          textAlign:TextAlign.justify,
          style: TextStyle(
            decoration: TextDecoration.none,
            fontFamily: 'TREBUC',
            fontSize: 18,
            fontWeight:FontWeight.normal,
            color: Color(0xff858585),
            //letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}
