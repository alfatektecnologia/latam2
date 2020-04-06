import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:provider/provider.dart';

class Etapas extends StatefulWidget {
  @override
  _EtapasState createState() => _EtapasState();
}

class _EtapasState extends State<Etapas> {
  TextStyle fonteComum =
      TextStyle(fontFamily: 'TREBUC', fontSize: 20, color: Color(0xff858585));
  var _etapas = ['1 ou 2', '3 ou 4', '5', '6', '7 +', 'Selecione'];
  String _currentEtapa = 'Selecione';
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
                Text('Etapas:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xffed1650),
                    )),
                SizedBox(width: 16),
                DropdownButton<String>(
                  items: _etapas.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem,
                          style: fonteComum,
                        ));
                  }).toList(),
                  
                  onChanged: (String newSelectedEtapa) {

                    setState(() {
                      _currentEtapa = newSelectedEtapa;
                      Util.hasEtapa = true;
                      _currentEtapa != 'Selecione'
                          ? Util.etapas = newSelectedEtapa.toUpperCase()
                          : Util.hasEtapa=false;//reseto caso a seleção seja 'Selecione'
                      Util.hasVooVolta = false;
                    });
                  },
                  value: _currentEtapa,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
