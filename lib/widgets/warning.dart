import 'package:flutter/material.dart';

class WarningSafetyCase extends StatefulWidget {
  @override
  _WarningSafetyCaseState createState() => _WarningSafetyCaseState();
}

class _WarningSafetyCaseState extends State<WarningSafetyCase> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation:3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
        child: ListTile(
            onTap: () {},
            //leading: Icon(Icons.warning,size:50,  color: Color(0xffed1650)),
            title: Text('A LATAM Cargo Brasil está  autorizada a implementar um Sistema de Gerenciamento do Risco da Fadiga (SGRF) nas combinações de rotas com as seguintes características: rotas com tripulação de revezamento, com mais de 16h e menos de 18h de jornada, número máximo de 3 pousos e cruzamento de até 3 fusos horários. Para maiores detalhes, por gentileza consultar o Manual do Sistema de Gerenciamento do Risco da Fadiga SGRF - Cargo.',

              //'Você pode consultar as rotas safety case no Manual do Sistema de Gerenciamento do Risco da Fadiga SGRF - Cargo',
              textAlign:TextAlign.justify,
              style: TextStyle(color: Color(0xff00005a),fontFamily: 'TREBUC'),
            ),
        ),
      ),
          ),
    );
  }
}
