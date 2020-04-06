import 'package:flutter/material.dart';

class TextoNo767F extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff00005a),
      elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text('Para maiores informações, consultar o Manual do Sistema de Gerenciamento do Risco da Fadiga SGRF - MXP.',
              textAlign:TextAlign.justify,
              style: TextStyle(color: Color(0xffffffff),fontSize: 18),)
        
      ),
          ),
    );
  }
}