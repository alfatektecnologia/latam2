import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:provider/provider.dart';

class RotaSafetyCase extends StatefulWidget {
  @override
  _RotaSafetyCaseState createState() => _RotaSafetyCaseState();
}

class _RotaSafetyCaseState extends State<RotaSafetyCase> {
  var _radioValue1 = -1;
  @override
  Widget build(BuildContext context) {
    Util util = Provider.of<Util>(context);

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Center(
            child: Text(
              'Rota Safety Case',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xffed1650),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Radio(
              value: 0,
              groupValue: _radioValue1,
              onChanged: (newValue) {
                setState(() {
                  _radioValue1 = newValue;
                  Util.resetarDataHora();
                  
                  Util.tipoTripulacao = " "; //just in case previous selected
                  util.setRotaSafetyCase('GRU - MXP');
                  Util.rotaSafetyCase = '0';
                });

                print(newValue);
              },
            ),
            Text(
              'GRU - MXP',
              style: TextStyle(fontSize: 16, color: Color(0xff858585)),
            ),
            Radio(
              value: 1,
              groupValue: _radioValue1,
              onChanged: (newValue) {
                setState(() {
                  _radioValue1 = newValue;
                  Util.resetarDataHora();
                  
                   Util.tipoTripulacao = " "; //just in case previous selected
                  util.setRotaSafetyCase('MXP - GRU');
                  Util.rotaSafetyCase = '1';
                });

                print(newValue);
              },
            ),
            Text('MXP - GRU',
                style: TextStyle(fontSize: 16, color: Color(0xff858585))),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 5,
              color: Color(0xff858585),
            ),
          ]),
        ]),
      ),
    );
  }
}
