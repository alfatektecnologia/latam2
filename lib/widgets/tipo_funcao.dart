import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';

class TipoFuncao extends StatefulWidget {
  @override
  _TipoFuncaoState createState() => _TipoFuncaoState();
}

class _TipoFuncaoState extends State<TipoFuncao> {
  var _funcao = ['Tripulante técnico', 'Tripulante cabine', 'Selecione'];
  var _funcao767 = ['Tripulante técnico', 'Selecione'];
  String _currentFuncao = 'Selecione';
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Função:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xffed1650),
                    )),
                SizedBox(width: 16),
                DropdownButton<String>(
                  items: !Util.tripTTonly
                      ? _funcao.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xff858585)),
                              ));
                        }).toList()
                      : _funcao767.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xff858585)),
                              ));
                        }).toList(),
                  onChanged: (String newSelectedEtapa) {
                    setState(() {
                      _currentFuncao = newSelectedEtapa;

                      if (newSelectedEtapa == 'Tripulante técnico') {
                        Util.funcao = 'TT';
                        Util.hasFuncao = true;
                      } else if (newSelectedEtapa == 'Tripulante cabine') {
                        Util.funcao = 'TC';
                        Util.hasFuncao = true;
                      } else {
                        Util.hasFuncao = false;
                      }
                    });
                  },
                  value: _currentFuncao,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
