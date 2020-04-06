import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:provider/provider.dart';

class Fusos extends StatefulWidget {
  @override
  _FusosState createState() => _FusosState();
}

class _FusosState extends State<Fusos> {
  var _fusos = ['Menor que 3', 'Maior/igual a 3', 'Selecione'];
  var _fusos2 = ['Menor que 3', 'Selecione']; //para voos domesticos e outros...
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
                  items: (Util.equipamento == 'A32F' &&
                              (Util.tipoTripulacao == 'Composta' ||
                                  Util.tipoTripulacao == 'Revezamento') ||
                          Util.tipoVoo == 'Doméstico')
                      ? _fusos2.map((String dropDownStringItem) {
                          return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xff858585)),
                              ));
                        }).toList()
                      : _fusos.map((String dropDownStringItem) {
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
                      _currentFuso = newSelectedEtapa;

                      print('Equipamento: ' + Util.equipamento);
                      print('Tipo Voo: ' + Util.tipoVoo);
                      print('Tipo tripulação: ' + Util.tipoTripulacao);

                      if (_currentFuso == 'Maior/igual a 3') {
                        Util.fusos = 'MAIS';
                        Util.hasFuso = true;
                        util.setVoltaTripComposta(true);
                        print(Util.hasVooVolta);
                      } else if (_currentFuso == 'Menor que 3') {
                        Util.fusos = 'MENOS';
                        Util.hasFuso = true;
                        util.setVoltaTripComposta(false);
                        Util.hasVooVolta = false;
                        print(Util.hasVooVolta);
                      } else {
                        Util.hasFuso = false;//if value = 'Selecione' reseto hasfuso para validate
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
