import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:provider/provider.dart';

class Fusos2 extends StatefulWidget {
  @override
  _Fusos2State createState() => _Fusos2State();
}

class _Fusos2State extends State<Fusos2> {
  var _fusos = ['Menor que 3', 'Selecione'];

  String _currentFuso = 'Selecione';
  @override
  Widget build(BuildContext context) {
    Util util = Provider.of<Util>(context);
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Fusos:   ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xffed1650),
                    )),
                SizedBox(width: 16),
                DropdownButton<String>(
                  items: _fusos.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem,
                          style:
                              TextStyle(fontSize: 20, color: Color(0xff858585)),
                        ));
                  }).toList(),
                  onChanged: (String newSelectedEtapa) {
                    setState(() {
                      _currentFuso = newSelectedEtapa;

                      print('Equipamento: ' + Util.equipamento);
                      print('Tipo Voo: ' + Util.tipoVoo);
                      print('Tipo tripulação: ' + Util.tipoTripulacao);

                      if (_currentFuso != 'Selecione') {
                        Util.fusos = 'MENOS';
                        util.setVoltaTripComposta(false);
                        Util.hasVooVolta = false;
                        print(Util.hasVooVolta);
                        Util.hasFuso = true;
                      } else {
                        Util.hasFuso = false;
                      }
                    });
                  },
                  value: _currentFuso,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
