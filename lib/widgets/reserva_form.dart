import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:latam/utilitarios/utilitarios.dart';

class ReservaForm extends StatefulWidget {
  @override
  _ReservaFormState createState() => _ReservaFormState();
}

class _ReservaFormState extends State<ReservaForm> {
  String _dataReserva = 'DD/MM/AA';
  String _horaReserva = 'HH:MM';
  String newFormatedDate;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    setState(() {
      //Util.tipoAcionamentoSobreaviso = '';//reseto qualquer informação  de acionamento anterior
    });
  }

  @override
  Widget build(BuildContext context) {
    var timeSelected;
    String newFormatedDate;

    getTime() {
      setState(() {
        //getTime();
        Util.horaReserva = timeSelected;
        Util.horaApresentacaoReserva = _horaReserva;
        Util.hasHoraInicio = true;
        Util.horaVooIdaDecolagem = timeSelected;

        print(Util.horaVooIdaDecolagem.toString() + '  horavooida');
      });
    }

    //hora da reserva
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
                        initialDateTime: DateTime(
                            Util.dataReserva.year,
                            Util.dataReserva.month,
                            Util.dataReserva.day,
                            12,
                            0,
                            0),
                        onDateTimeChanged: (date) {
                          setState(() {
                            newFormatedDate =
                                (formatDate(date, [HH, ':', nn])).toString();
                            _horaReserva = newFormatedDate;
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

    //data da reserva

    selectDate(BuildContext context) async {
      var selectDate = await showRoundedDatePicker(
        textPositiveButton: "OK" ,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2018),
        lastDate: DateTime(2030),
        
        theme: ThemeData(
        
            primarySwatch: Util.colorCustom, accentColor: Color(0xffed1650)),
        
      );

      setState(() {
        newFormatedDate =
            (formatDate(selectDate, [dd, '/', mm, '/', yyyy])).toString();

        // Util.dataInicioJornada = selectDate;
        _dataReserva = newFormatedDate;
        Util.dataReserva = selectDate;
        Util.dataVooIdaDecolagem = Util.dataReserva;
        Util.hasDataInicio = true;
        Util.dataApresentacaoReserva = _dataReserva;
        print(newFormatedDate);
      });
    }

    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Data da reserva:',
              style: TextStyle(color: Color(0xff858585)),
            ),
            RaisedButton(
                //color: Color(0xff00005a),
                onPressed: () {
                  Util.hasTipoTripDefined = false;//reset
                  selectDate(context);
                },
                child: Text(
                  _dataReserva,
                  style: TextStyle(fontSize: 20, color: Color(0xff00005a)),
                )),
            SizedBox(
              height: 8,
            ),
            Text('Horário de início da reserva:',
                style: TextStyle(color: Color(0xff858585))),
            RaisedButton(
                //color: Color(0xff00005a),
                onPressed: () {
                  Util.hasTipoTripDefined = false;//reset

                  calendario(context);
                },
                child: Text(
                  _horaReserva,
                  style: TextStyle(fontSize: 20, color: Color(0xff00005a)),
                ))
          ],
        ),
      ),
    );
  }
}
