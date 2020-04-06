import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';

class DataPouso3 extends StatefulWidget {
  @override
  _DataPouso3State createState() => _DataPouso3State();
}

class _DataPouso3State extends State<DataPouso3> {
  String _dataPouso = 'DD/MM/AA';
  String newFormatedDate;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    selectDate(BuildContext context) async {
      var selectDate = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  //height: 480,
                  child: child,
                )
              ],
            ),
          );
        },
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
      );

      setState(() {
        newFormatedDate =
            (formatDate(selectDate, [dd, '/', mm, '/', yyyy])).toString();

        int diaPouso = selectDate.day.compareTo(Util.dataVooVoltaDecolagem.day);
        int mesPouso =
            selectDate.month.compareTo(Util.dataVooVoltaDecolagem.month);
        int anoPouso =
            selectDate.year.compareTo(Util.dataVooVoltaDecolagem.year);

        DateTime testeData = DateTime(2020, 2, 29);

        if ((diaPouso + mesPouso + anoPouso) < 0) {
          Util.showFlushbar(context,
              'Erro! Data do pouso menor que data de início da jornada.');
          _dataPouso = 'DD/MM/AA';
          return;
        } else if ((selectDate.compareTo(testeData) < 0)) {
          Util.showFlushbar(
              context, 'Alerta! Data anterior à vigência do RBAC 117.');
          //_dataPouso = 'DD/MM/AA';

        } else {
          Util.dataVooVoltaPouso = selectDate;
          Util.hasDataPouso2 = true;//used to validade input
        }

        // Util.dataInicioJornada = selectDate;
        _dataPouso = newFormatedDate;
        //Util.dataVooVoltaPouso = selectDate;

        print(newFormatedDate);
      });
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Data do pouso:', style: TextStyle(color: Color(0xff858585))),
          RaisedButton(
              child: Text(
                _dataPouso,
                style: TextStyle(fontSize: 20, color: Color(0xff00005a)),
              ),
              onPressed: () {
                selectDate(context);

                /* setState(() {
                  _dataPouso = newFormatedDate;
                }); */
              })
        ],
      ),
    );
  }
}
