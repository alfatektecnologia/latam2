import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:latam/utilitarios/utilitarios.dart';

class InicioSobreaviso extends StatefulWidget {
  @override
  _InicioSobreavisoState createState() => _InicioSobreavisoState();
}

class _InicioSobreavisoState extends State<InicioSobreaviso> {
  String _dataInicioSobreaviso = 'Início do Sobreaviso';
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: Color(0xff00005a),
        onPressed: () {
          DatePicker.showTimePicker(context,
              showTitleActions: true,
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
            String newFormatedDate =
                (formatDate(date, [HH, ':', nn])).toString();
             //If(date.isBefore(other))   

            setState(() {
              _dataInicioSobreaviso = 'Início =  ' + newFormatedDate;
              Util.horarioInicioSobreaviso = date;
            });
          }, currentTime: DateTime.now(), locale: LocaleType.pt);
        },
        child: Text(
          _dataInicioSobreaviso,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ));
  }
}
