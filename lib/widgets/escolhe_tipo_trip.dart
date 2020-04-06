import 'package:flutter/material.dart';

import 'package:latam/widgets/trip_composta.dart';
import 'package:latam/widgets/trip_revesamento.dart';
import 'package:latam/widgets/trip_simples.dart';

class EscolheTipoTrip extends StatelessWidget {
  final String tipo;

  const EscolheTipoTrip({Key key, this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tipo == 'Simples') {
      return TripulacaoSimples();
    } else if (tipo == 'Composta') {
      return TripulacaoComposta();
    } else {
      return TripulacaoRevezamento();
    }
  }
}
