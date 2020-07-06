import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:latam/widgets/calcular_button.dart';
import 'package:latam/widgets/dates/data_inicio_jornada2.dart';
import 'package:latam/widgets/dates/data_inicio_jornada3.dart';
import 'package:latam/widgets/dates/data_inicio_jornada4.dart';

import 'package:latam/widgets/dates/data_pouso2.dart';
import 'package:latam/widgets/dates/data_pouso3.dart';
import 'package:latam/widgets/fusos.dart';

import 'package:latam/widgets/times/hora_apresentacao2.dart';
import 'package:latam/widgets/times/hora_apresentacao4.dart';

import 'package:latam/widgets/times/hora_last_pouso2.dart';
import 'package:latam/widgets/times/hora_lastpouso3.dart';
import 'package:latam/widgets/tipo_funcao.dart';
import 'package:provider/provider.dart';

import 'fusos2.dart';
import 'times/hora_apresentacao3.dart';

class TripulacaoComposta extends StatefulWidget {
  @override
  _TripulacaoCompostaState createState() => _TripulacaoCompostaState();
}

class _TripulacaoCompostaState extends State<TripulacaoComposta> {
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

    return ChangeNotifierProvider<Util>(
      create: (_) => Util(),
      child: Consumer<Util>(
        builder: (context, util, _) => Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Util.tipoVoo == 'Doméstico' ? Fusos2() : Fusos(),
                  SizedBox(
                    height: 8,
                  ),
                  !Util.is767FSafety ? TipoFuncao() : Container(),
                  SizedBox(
                    height: 8,
                  ),
                  Util.hasVooVolta
                      ? Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Voo de ida',
                            style: TextStyle(
                                fontSize: 20, color: Color(0xffed1650)),
                          ),
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
                  /* SizedBox(
                  height: 16,
                ), */
                  Util.hasVooVolta ? TripCompostaVolta() : Container(),
                ]),
          ),
        ),
      ),
    );
  }
}

class TripCompostaVolta extends StatefulWidget {
  @override
  _TripCompostaVoltaState createState() => _TripCompostaVoltaState();
}

class _TripCompostaVoltaState extends State<TripCompostaVolta> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text('Voo de volta',
                style: TextStyle(fontSize: 20, color: Color(0xffed1650))),
          ),
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
