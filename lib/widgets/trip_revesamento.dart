import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:latam/widgets/calcular_button.dart';
import 'package:latam/widgets/dates/data_inicio_jornada2.dart';
import 'package:latam/widgets/dates/data_inicio_jornada4.dart';
import 'package:latam/widgets/dates/data_pouso3.dart';
import 'package:latam/widgets/fusos.dart';
import 'package:latam/widgets/times/hora_apresentacao2.dart';
import 'package:latam/widgets/times/hora_apresentacao3.dart';
import 'package:latam/widgets/times/hora_apresentacao4.dart';
import 'package:latam/widgets/times/hora_last_pouso2.dart';
import 'package:latam/widgets/times/hora_lastpouso3.dart';
import 'package:latam/widgets/tipo_funcao.dart';

import 'dates/data_inicio_jornada3.dart';
import 'dates/data_pouso2.dart';
import 'fusos2.dart';

class TripulacaoRevezamento extends StatefulWidget {
  @override
  _TripulacaoRevezamentoState createState() => _TripulacaoRevezamentoState();
}

class _TripulacaoRevezamentoState extends State<TripulacaoRevezamento> {
  bool isReservaVoo = false;

  @override
  void initState() {
    // Util.resetarVariaveis();
    Util.resetarDataHora();

    Util.hasEtapa = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Util util = Provider.of<Util>(context);

    setState(() {
      if (Util.tipoAcionamentoSobreaviso == 'Reserva + voo') {
        setState(() {
          isReservaVoo = true;
        });
      }
    });

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              /* Center(
                child: Text(
                  'Voo',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffed1650),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _radioValue1,
                      onChanged: (newValue) {
                        setState(() {
                          _radioValue1 = newValue;
                          util.setTipoVoo('Doméstico');
                          Util.destino = ('DOM');
                        });

                        print(newValue);
                      },
                    ),
                    Text(
                      'Doméstico',
                      style: TextStyle(fontSize: 16, color: Color(0xff858585)),
                    ),
                    Radio(
                      value: 1,
                      groupValue: _radioValue1,
                      onChanged: (newValue) {
                        setState(() {
                          _radioValue1 = newValue;
                          util.setTipoVoo('Internacional');
                          Util.destino = ('INT');
                        });

                        print(newValue);
                      },
                    ),
                    Text(
                      'Internacional',
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xff858585)),
                    ),
                  ]),
              SizedBox(
                height: 8,
              ), */
              /* Divider(
                height: 5,
                color: Color(0xff858585),
              ), */
              SizedBox(
                height: 8,
              ),
              Util.tipoVoo == 'Doméstico' ? Fusos2() : Fusos(),
              SizedBox(
                height: 8,
              ),
              !Util.is767FSafety ? TipoFuncao() : Container(),
              SizedBox(
                height: 8,
              ),
              Util.hasVooVolta
                  ? Text(
                      'Voo de ida',
                      style: TextStyle(color: Color(0xffed1650), fontSize: 20),
                    )
                  : Container(),

              Util.tipoAcionamentoSobreaviso == 'Reserva + voo'
                  ? DataInicioJornada4()
                  : DataInicioJornada2(), //dataVooIdaDecolagem
              SizedBox(
                height: 8,
              ),
              Util.tipoAcionamentoSobreaviso == 'Reserva + voo'
                  ? HoraApresentacao4()
                  : HoraApresentacao2(),
              SizedBox(
                height: 8,
              ),
              DataPouso2(),
              SizedBox(
                height: 8,
              ),
              HoraLastPouso2(),
              SizedBox(
                height: 8,
              ),
              Util.hasVooVolta ? Container() : CalcularButton(),
              //CalcularButton(),
              /* SizedBox(
                height: 16,
              ), */
              Util.hasVooVolta ? TripRevesamentoVolta() : Container(),
            ]),
      ),
    );
  }
}

class TripRevesamentoVolta extends StatefulWidget {
  @override
  _TripRevesamentoVoltaState createState() => _TripRevesamentoVoltaState();
}

class _TripRevesamentoVoltaState extends State<TripRevesamentoVolta> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Align(
              alignment: Alignment.centerLeft,
              child: Text('Voo de volta',
                  style: TextStyle(color: Color(0xffed1650), fontSize: 20))),
          DataInicioJornada3(),
          SizedBox(
            height: 8,
          ),
          HoraApresentacao3(),
          SizedBox(
            height: 8,
          ),
          DataPouso3(),
          SizedBox(
            height: 8,
          ),
          HoraLastPouso3(),
          SizedBox(
            height: 8,
          ),
          CalcularButton(),
        ],
      ),
    );
  }
}
