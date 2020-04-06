import 'package:flutter/material.dart';

class TextoRotas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SizedBox(
            height: 24,
          ),
          
          Divider(height: 5,color: Color(0xff858585),),
          SizedBox(height: 16,),
          Text(
            'Safety case:',
            style: TextStyle(
              fontWeight:FontWeight.bold,
              decoration: TextDecoration.none,
              decorationColor: Color(0xff00005a),
              
              fontFamily: 'TREBUC',
              fontSize: 18,
              color: Color(0xff00005a),
              //letterSpacing: 3,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Estudo científico para mensurar os níveis cognitivos de alerta dos tripulantes técnicos e cabine, quando os limites prescritivos apresentados nas tabelas B2 e B3 do apêndice B do RBAC 117 são extrapolados.',
              textAlign:TextAlign.justify,
              style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'TREBUC',
              fontSize: 16,
              fontWeight:FontWeight.normal,
              color: Color(0xff858585),
              //letterSpacing: 3,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Demais rotas:',
            
            style: TextStyle(
              fontWeight:FontWeight.bold,
              decoration: TextDecoration.none,
              decorationColor: Color(0xff00005a),
              
              fontFamily: 'TREBUC',
              fontSize: 18,
              color: Color(0xff00005a),
              //letterSpacing: 3,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            
            'Rotas nas quais não se faz necessário desenvolver um estudo científico, porque seguem as tabelas B1, B2 e B3 do apêndice B do RBAC 117, com relação ao limite da jornada de trabalho.',
            //softWrap:true,
            textAlign:TextAlign.justify,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'TREBUC',
              fontWeight:FontWeight.normal,
              fontSize: 16,
              color: Color(0xff858585),
              //letterSpacing: 3,
            ),
          ),
          SizedBox(
            height: 16,
          ),
        ],
      
    );
  }
}