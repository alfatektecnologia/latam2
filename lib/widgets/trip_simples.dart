import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:latam/widgets/calcular_button.dart';
import 'package:latam/widgets/data_inicio_jornada2.dart';
import 'package:latam/widgets/data_inicio_jornada4.dart';

import 'package:latam/widgets/data_pouso2.dart';
import 'package:latam/widgets/hora_apresentacao2.dart';
import 'package:latam/widgets/hora_apresentacao4.dart';

import 'package:latam/widgets/hora_last_pouso2.dart';
import 'package:provider/provider.dart';

import 'etapas.dart';

class TripulacaoSimples extends StatefulWidget {
  @override
  _TripulacaoSimplesState createState() => _TripulacaoSimplesState();
}

class _TripulacaoSimplesState extends State<TripulacaoSimples> {
  var _radioValue1 = -1;

  @override
  void initState() {
    Util.resetarVariaveis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Util util = Provider.of<Util>(context);

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
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
                      style:
                          TextStyle(fontSize: 16.0, color: Color(0xff858585)),
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
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Color(0xff858585),
                      ),
                    ),
                  ]),
              SizedBox(
                height: 8,
              ),

              SizedBox(
                height: 8,
              ),
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
              Etapas(),
              SizedBox(
                height: 8,
              ),
              DataPouso2(), //dataVooVoltaDecolagem
              SizedBox(
                height: 8,
              ),
              HoraLastPouso2(),
              SizedBox(
                height: 8,
              ),
              CalcularButton(),
            ]),
      ),
    );
  }
}
