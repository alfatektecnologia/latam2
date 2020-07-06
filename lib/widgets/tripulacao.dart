import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:provider/provider.dart';

class TipoTripulacao extends StatefulWidget {
  @override
  _TipoTripulacaoState createState() => _TipoTripulacaoState();
}

class _TipoTripulacaoState extends State<TipoTripulacao> {
  var _radioValue1 = -1;
  @override
  Widget build(BuildContext context) {
    Util util = Provider.of<Util>(context);

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: <Widget>[
          Center(
            child: Text(
              'Tipo tripulação:',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xffed1650),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 0,
                groupValue: _radioValue1,
                onChanged: (newValue) {
                  setState(() {
                    _radioValue1 = newValue;
                    // Util.resetarVariaveis();
                    util.setTipoTripulacao('Simples');
                    Util.tripulacao = ("SIMPLES");
                    Util.resetarDataHora();
                    Util.hasFuncao = false;
                    Util.hasFuso = false;
                    Util.hasVooVolta = false; //sera?
                    Util.hasTipoTripDefined = true;
                  });

                  print(newValue);
                },
              ),
              Text(
                'Simples',
                style: TextStyle(fontSize: 16.0, color: Color(0xff858585)),
              ),
            ],
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: _radioValue1,
                onChanged: (newValue) {
                  setState(() {
                    _radioValue1 = newValue;
                    // Util.resetarVariaveis();
                    util.setTipoTripulacao('Composta');
                    Util.tripulacao = ("COMPOSTA");
                    Util.hasEtapa = false;
                    Util.resetarDataHora();
                    Util.hasTipoTripDefined = true;
                  });

                  print(newValue);
                },
              ),
              Text(
                'Composta',
                style: TextStyle(fontSize: 16.0, color: Color(0xff858585)),
              ),
            ],
          ),

          //if tipo voo equal domestic do not show
          Util.destino == ('DOM')
              ? Container()
              : Row(
                  children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: _radioValue1,
                      onChanged: (newValue) {
                        setState(() {
                          _radioValue1 = newValue;
                          // Util.resetarVariaveis();
                          util.setTipoTripulacao('Revezamento');
                          Util.resetarDataHora();

                          Util.hasTipoTripDefined = true;
                          Util.hasEtapa = false;
                          Util.tripulacao = ('REVEZAMENTO');
                        });

                        print(newValue);
                      },
                    ),
                    Text(
                      'Revezamento',
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xff858585)),
                    ),
                  ],
                ),
          /* Divider(
            height: 5,
            color: Color(0xff858585),
        ), */
        ]),
      ),
    );
  }
}
