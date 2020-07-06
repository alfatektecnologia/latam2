import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:latam/widgets/calcular_button.dart';
import 'package:latam/widgets/dates/data_inicio_jornada2.dart';
import 'package:latam/widgets/dates/data_inicio_jornada4.dart';

import 'package:latam/widgets/dates/data_pouso2.dart';
import 'package:latam/widgets/times/hora_apresentacao2.dart';
import 'package:latam/widgets/times/hora_apresentacao4.dart';

import 'package:latam/widgets/times/hora_last_pouso2.dart';

import 'etapas.dart';

class TripulacaoSimples extends StatefulWidget {
  @override
  _TripulacaoSimplesState createState() => _TripulacaoSimplesState();
}

class _TripulacaoSimplesState extends State<TripulacaoSimples> {
  @override
  void initState() {
    //Util.resetarVariaveis();
    Util.resetarDataHora();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Util util = Provider.of<Util>(context);

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
