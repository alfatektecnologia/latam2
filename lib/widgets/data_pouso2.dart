import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';

class DataPouso2 extends StatefulWidget {
  @override
  _DataPouso2State createState() => _DataPouso2State();
}

class _DataPouso2State extends State<DataPouso2> {
  String _dataPouso = 'DD/MM/AA';
  String newFormatedDate;
  DateTime selectedDate = DateTime.now();

  // Theme newTheme = Theme.of(context).accentTextTheme.

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
                  // height: 480,
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

      /* if (selectDate.isBefore(Util.dataVooIdaDecolagem)) {
        String message = "Data inválida: menor que a data de decolagem";
        Util.showFlushbar(context, message);
        return;
      } else { */
      setState(() {
        newFormatedDate =
            (formatDate(selectDate, [dd, '/', mm, '/', yyyy])).toString();
        
        int diaPouso = selectDate.day.compareTo(Util.dataVooIdaDecolagem.day);
        int mesPouso =
            selectDate.month.compareTo(Util.dataVooIdaDecolagem.month);
        int anoPouso = selectDate.year.compareTo(Util.dataVooIdaDecolagem.year);

        DateTime testeData = DateTime(2020, 2, 29);

        if ((diaPouso + mesPouso + anoPouso) < 0) {
          Util.showFlushbar(context,
              'Erro! Data do pouso menor que data de início da jornada.');
          _dataPouso = 'DD/MM/AA';
          return;
        } else if ((selectDate.compareTo(testeData) < 0)) {
          Util.showFlushbar(
              context, 'Alerta! Data anterior à vigência do RBAC 117.');


        } else {
          Util.dataVooIdaPouso = selectDate;
          Util.hasDataPouso = true;
          
        }

        _dataPouso = newFormatedDate;

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
/* String _dataPouso = 'Data do pouso';
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        color: Color(0xff00005a),
        onPressed: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(2020, 1, 1),
              maxTime: DateTime(2020, 12, 7),
              theme: DatePickerTheme(
                  headerColor: Colors.orange,
                  backgroundColor: Colors.blue,
                  itemStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
              onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            print('confirm $date');
            //print(DateFormat.yMMMd().format( DateTime.now()));
            print(formatDate(date, [dd, '-', mm, '-', yyyy]));
            String newFormatedDate =(formatDate(date, [dd, '-', mm, '-', yyyy])).toString();


            setState(() {
              _dataPouso = newFormatedDate;
            });
          }, currentTime: DateTime.now(), locale: LocaleType.pt);
        },
        child: Text(
          _dataPouso,
          style: TextStyle(color: Colors.white,fontSize:20),
        ));
  } */
