import 'package:flutter/material.dart';

class TextoGeralResultado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xff00005a),
      elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text('As informações acima levam em consideração os dados preenchidos na tela anterior e o RBAC 117.',
              textAlign:TextAlign.justify,
              style: TextStyle(color: Color(0xffffffff),fontSize: 18),)
        
      ),
          ),
    );
  }
}