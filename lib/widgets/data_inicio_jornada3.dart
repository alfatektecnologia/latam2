import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';

class DataInicioJornada3 extends StatefulWidget {
  @override
  _DataInicioJornada3State createState() => _DataInicioJornada3State();
}

class _DataInicioJornada3State extends State<DataInicioJornada3> {
  String _dataInicioJornada2 = 'DD/MM/AA';
  String newFormatedDate;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Future<void> selectDate(BuildContext context) async {
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

/*       if (selectDate.isBefore(selectedDate)) {
        String message = "Data inválida";
        Util.showFlushbar(context, message);
        return;
      } else { */
      setState(() {
        newFormatedDate =
            (formatDate(selectDate, [dd, '/', mm, '/', yyyy])).toString();

        DateTime testeData = DateTime(2020, 2, 29);

        if ((selectDate.compareTo(testeData) < 0)) {
          Util.showFlushbar(
              context, 'Alerta! Data anterior à vigência do RBAC 117.');
          //_dataPouso = 'DD/MM/AA';

        } else {
          Util.dataVooVoltaDecolagem = selectDate;
          _dataInicioJornada2 = newFormatedDate;
          Util.hasDataInicio2 = true;
        }
        print(newFormatedDate);
      });
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Data de início da jornada:',
            style: TextStyle(color: Color(0xff858585)),
          ),
          RaisedButton(
              child: Text(
                _dataInicioJornada2,
                style: TextStyle(fontSize: 20, color: Color(0xff00005a)),
              ),
              onPressed: () {
                selectDate(context);

/*                 setState(() {
                  _dataInicioJornada = newFormatedDate;
                }); */
              })
        ],
      ),
    );
  }
}
