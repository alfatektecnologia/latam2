import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';

class DataInicioJornada4 extends StatefulWidget {
  @override
  _DataInicioJornada4State createState() => _DataInicioJornada4State();
}

class _DataInicioJornada4State extends State<DataInicioJornada4> {
  String _dataInicioJornada = 'DD/MM/AA';
  String newFormatedDate;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    
    super.initState();

if (Util.tipoAcionamentoSobreaviso == 'Reserva + voo' && Util.dataReserva!=null) {
      setState(() {
        Util.dataApresentacaoReserva = _dataInicioJornada =
            (formatDate(Util.dataReserva, [dd, '/', mm, '/', yyyy])).toString();
        Util.dataVooIdaDecolagem = Util.dataReserva;
        print('reserva' + _dataInicioJornada);
      });
    }

  }

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
                  height: MediaQuery.of(context).size.height *0.8,
                  //height: 500,
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

        DateTime testeData = DateTime(2020, 2, 29);

        if ((selectDate.compareTo(testeData) < 0)) {
          Util.showFlushbar(
              context, 'Alerta! Data anterior à vigência do RBAC 117.');
          //_dataPouso = 'DD/MM/AA';

        } else {
          Util.dataVooIdaDecolagem = selectDate;
        }

        //Util.dataVooIdaDecolagem = selectDate;
        _dataInicioJornada = newFormatedDate;
        Util.dataInicioJornada = _dataInicioJornada;

        print(testeData.toString());
        print(selectDate);
      });
      //}
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
                Util.tipoAcionamentoSobreaviso == 'Reserva + voo'
                    ? Util.dataApresentacaoReserva
                    : _dataInicioJornada,
                style: TextStyle(fontSize: 20, color: Color(0xff00005a)),
              ),
              onPressed: () {
                //selectDate(context);

/*                 setState(() {
                  _dataInicioJornada = newFormatedDate;
                }); */
              })
        ],
      ),
    );
  }
}
