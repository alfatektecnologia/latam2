import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';

class HoraApresentacao3 extends StatefulWidget {
  @override
  _HoraApresentacao3State createState() => _HoraApresentacao3State();
}

class _HoraApresentacao3State extends State<HoraApresentacao3> {
  String _horaApresentacao = 'HH:MM';
  @override
  Widget build(BuildContext context) {
    var timeSelected;
    String newFormatedDate;

    getTime() {
      setState(() {
        //getTime();
        Util.horaVooVoltaDecolatem = timeSelected;
        Util.hasHoraInicio2 = true;

        print(Util.horaVooIdaDecolagem.toString() + '  horavooida');
      });
    }

    Future<DateTime> calendario(context) async {
      showModalBottomSheet(
          context: context,
          useRootNavigator: true,
          builder: (BuildContext builder) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  color: Color(0xffed1650),
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 32.0, right: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancelar',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'TREBUC',
                                  color: Colors.white)),
                        ),
                        GestureDetector(
                          onTap: () {
                            timeSelected != null
                                ? Navigator.of(context).pop()
                                : Util.showFlushbar(
                                    context, 'Selecione um horário');
                          },
                          child: Text('OK',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'TREBUC',
                                  color: Colors.white)),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).copyWith().size.height / 3,
                  child: CupertinoTheme(
                    data: CupertinoThemeData.raw(
                        Brightness.light,
                        Color(0xff00ffff),
                        Color(0xff858585),
                        CupertinoTextThemeData(
                            dateTimePickerTextStyle: TextStyle(
                              fontFamily: 'TREBUC',
                              fontSize: 27,
                              color: Color(0xff00005a),
                            ),
                            pickerTextStyle: TextStyle(
                              fontFamily: 'TREBUC',
                              color: Colors.deepOrange,
                            ),
                            textStyle: TextStyle(
                              fontFamily: 'TREBUC',
                              color: Colors.deepOrange,
                            ),
                            primaryColor: Color(0xffff005a)),
                        Color(0xffffffff),
                        Color(0xffff0000)),
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.time,
                        //backgroundColor: Colors.grey,
                        use24hFormat: true,
                        initialDateTime: DateTime(2020, 3, 1, 12, 0, 0),
                        onDateTimeChanged: (date) {
                          setState(() {
                            newFormatedDate =
                                (formatDate(date, [HH, ':', nn])).toString();
                            _horaApresentacao = newFormatedDate;
                            timeSelected = date;
                            getTime();
                          });
                        }),
                  ),
                ),
              ],
            );
          });
      return timeSelected;
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Horário da apresentação:',
              style: TextStyle(color: Color(0xff858585))),
          RaisedButton(
              //color: Color(0xff00005a),
              onPressed: () => calendario(context),
              child: Text(
                _horaApresentacao,
                style: TextStyle(color: Color(0xff00005a), fontSize: 20),
              )),
        ],
      ),
    );
  }
}
