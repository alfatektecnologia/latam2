import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:latam/utilitarios/utilitarios.dart';

class TerminoSobreaviso extends StatefulWidget {
  @override
  _TerminoSobreavisoState createState() => _TerminoSobreavisoState();
}

class _TerminoSobreavisoState extends State<TerminoSobreaviso> {
  String _dataTerminoSobreaviso = 'Término do sobreaviso';
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        color: Color(0xff00005a),
        onPressed: () {
          DatePicker.showTimePicker(context,
          showSecondsColumn:false,
              showTitleActions: true,
              theme: DatePickerTheme(cancelStyle: TextStyle(color: Colors.white70,fontFamily:'TREBUC',fontSize:18 ),
                        headerColor: Color(0xffed1650),
                        backgroundColor: Color(0xffFFFFFF),
                        itemStyle: TextStyle(
                            color: Color(0xff00005a),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                        doneStyle: TextStyle(color: Colors.white,fontFamily:'TREBUC',fontSize: 18)),
              onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            print('confirm $date');
            //print(DateFormat.yMMMd().format( DateTime.now()));
            print(formatDate(date, [dd, '-', mm, '-', yyyy]));
            String newFormatedDate =
                (formatDate(date, [HH, ':', nn])).toString();

            setState(() {
              _dataTerminoSobreaviso = 'Término =  ' + newFormatedDate;
              Util.horarioTerminoSobreaviso = date;
            });
          }, currentTime: DateTime.now(), locale: LocaleType.pt);
        },
        child: Text(
          _dataTerminoSobreaviso,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ));
  }
}
