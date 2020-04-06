import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';


class HoraApresentacao4 extends StatefulWidget {
  @override
  _HoraApresentacao4State createState() => _HoraApresentacao4State();
}

class _HoraApresentacao4State extends State<HoraApresentacao4> {
  String _horaApresentacao = 'HH:MM';

  @override
  void initState() {
    
    super.initState();

    if (Util.tipoAcionamentoSobreaviso == 'Reserva + voo' && Util.horaReserva!=null) {
      setState(() {
        Util.horaApresentacaoReserva = _horaApresentacao =
            (formatDate(Util.horaReserva, [HH, ':', nn])).toString();
        Util.horaVooIdaDecolagem = Util.horaReserva;
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    String _horaApresentacao = 'HH:MM';
  var timeSelected;
  String newFormatedDate;

    getTime() {

      setState(() {
      //getTime();
      Util.horaVooIdaDecolagem = timeSelected;

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
                            Navigator.of(context).pop();
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
              onPressed: () {
                               /*  Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return InfinityTimer();
                })); */

              },
              child: Text(
                Util.tipoAcionamentoSobreaviso == 'Reserva + voo'
                    ? Util.horaApresentacaoReserva
                    : _horaApresentacao,
                style: TextStyle(color: Color(0xff00005a), fontSize: 20),
              )),
        ],
      ),
    );
  }
}


