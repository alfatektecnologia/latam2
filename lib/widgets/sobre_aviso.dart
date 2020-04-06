import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:provider/provider.dart';

class SobreAviso extends StatefulWidget {
  @override
  _SobreAvisoState createState() => _SobreAvisoState();
}

class _SobreAvisoState extends State<SobreAviso> {


 

  @override
  Widget build(BuildContext context) {
    Util util = Provider.of<Util>(context);

    return Center(
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: <Widget>[
            Center(
              child: Text(
                'Você foi acionado no sobreaviso?',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xffed1650),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
              children: <Widget>[
                Row(
                  //mainAxisAlignment: MainAxisAlignment.center, 
                  children: <Widget>[
              Radio(
                value: 0,
                groupValue: Util.radioValueSobreAviso,
                onChanged: (newValue) {
                  setState(() {
                    Util.tipoAcionamentoSobreaviso = '';//reseto qualquer informação  de acionamento anterior
                    Util.radioValueSobreAviso = newValue;
                    util.setSobreaviso(true);
                    Util.sobreaviso = '1';
                  });

                  print(newValue);
                },
              ),
              Text(
                'Sim',
                style: TextStyle(fontSize: 16.0, color: Color(0xff858585)),
              ),
              
              
            ]),
            
            
            Row(
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: Util.radioValueSobreAviso,
                onChanged: (newValue) {
                  setState(() {
                    Util.radioValueSobreAviso = newValue;
                    util.setSobreaviso(false);
                    Util.sobreaviso = '0';
                  });

                  print(newValue);
                },
              ),
              Text(
                'Não',
                style: TextStyle(fontSize: 16.0, color: Color(0xff858585)),
              ),
            ],
            ),
              ],
            ),
        ]
          ),),),);}}      
