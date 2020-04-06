import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latam/models/jornada.dart';
import 'package:latam/utilitarios/utilitarios.dart';

class ListaResultado extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const ListaResultado({Key key, this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Jornada> myList = snapshot.data;
    var horaLimiteJornada =
        Util.horaInicioJornada.add(Duration(hours: myList[0].jornadaMaxima));
    var horaCorteMotorDomestico =
        horaLimiteJornada.subtract(Duration(minutes: 30));
    var horaCorteMotorInternacional =
        horaLimiteJornada.subtract(Duration(minutes: 45));
    //var lastro = horaLimiteJornada.difference(Util.horaLastPouso);
    //print(lastro.toString());
    var lastroDomestico = (horaLimiteJornada.add(Duration(minutes: 30))).difference(Util.horaLastPouso);
    var lastroInternacional =(horaLimiteJornada.add(Duration(minutes: 45))).difference(Util.horaLastPouso);
    String newFormatedDia =
        (formatDate(horaLimiteJornada, [dd, '/', mm, '/', yyyy]));
    String newFormatedTime =
        (formatDate(horaLimiteJornada, [HH, ':', nn])).toString();

    String newFormatedDiaCorteDom =
        (formatDate(horaCorteMotorDomestico, [dd, '/', mm, '/', yyyy]));
    String newFormatedTimeCorteDom =
        (formatDate(horaCorteMotorDomestico, [HH, ':', nn])).toString();

    String newFormatedDiaCorteInt =
        (formatDate(horaCorteMotorInternacional, [dd, '-', mm, '-', yyyy]));
    String newFormatedTimeCorteInt =
        (formatDate(horaCorteMotorInternacional, [HH, ':', nn])).toString();

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      //color: Color(0xff5831b9),
      child: Center(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Util.hasVooVolta? Text('Voo de ida', style: TextStyle(color: Color(0xffed1650)),):Container(),
            Card(
             // color: Color(0xff5831b9),
              child: ListTile(
                  title: Text('Duração máxima da jornada:',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff00005a),
                      )),
                  subtitle: Center(
                    child: Text(myList[0].jornadaMaxima.toString() + ':00' + ' Horas',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        )),
                  )),
            ),
            SizedBox(height: 16,),
            Card(
              child: ListTile(
                title: Text('Tempo máximo de voo:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00005a),
                    )),
                subtitle: myList[0].tempoVoo != 9.5
                    ? Center(
                      child: Text(myList[0].tempoVoo.toString() +':00' +' Horas',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          )),
                    )
                    : Center(
                      child: Text('9:30' + ' Horas',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
              ),
            ),
            /* horario limite termino jornada - 30m de tipovoo=domestico
            ou -45m se tipo voo = internacional

            */
            SizedBox(height: 16,),
            Card(
              child: ListTile(
                title: Text('Horário limite de corte do motor:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00005a),
                    )),
                subtitle: Util.tipoVoo == 'Doméstico'
                    ? Center(
                      child: Text(
                          newFormatedDiaCorteDom + ' as ' + newFormatedTimeCorteDom,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          )),
                    )
                    : Center(
                      child: Text(
                          newFormatedDiaCorteInt + ' as ' + newFormatedTimeCorteInt,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
              ),
            ),
            SizedBox(height: 16,),
            Card(
              child: ListTile(
                title: Text('Horário limite de término da jornada:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00005a),
                    )),
                subtitle: Center(
                  child: Text(newFormatedDia + ' as ' + newFormatedTime,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
            ),
            /*horario limite do termino da jornada - horario do pouso
            +30 m se tipo voo= domestico ou 45m se internacional*/
            SizedBox(height: 16,),
            Card(
              child: ListTile(
                //contentPadding: EdgeInsets.all(16),
                title: Text('Lastro:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00005a),
                    )),
                subtitle: Util.tipoVoo == 'Doméstico'
                    ? Center(
                      child: Text(lastroDomestico.inHours.toString()+ ':'+ lastroDomestico.inMinutes.remainder(60).toString()+' Horas',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      )),
                    )
                    : Center(
                      child: Text(lastroInternacional.inHours.toString() + ':'+ lastroInternacional.inMinutes.remainder(60).toString()+' Horas',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
              ),

            ),
Util.hasVooVolta? CalcularVolta():Container(),
          ],
        ),
      ),
    );
  }
}

class CalcularVolta extends StatefulWidget {
  final AsyncSnapshot snapshot;

  const CalcularVolta({Key key, this.snapshot}) : super(key: key);
  @override
  _CalcularVoltaState createState() => _CalcularVoltaState();
}

class _CalcularVoltaState extends State<CalcularVolta> {


  @override
  Widget build(BuildContext context) {
    List<Jornada> myList = widget.snapshot.data;

    
    var horaLimiteJornada =
        Util.horaInicioJornada.add(Duration(hours: myList[0].jornadaMaxima));
    var horaCorteMotorDomestico =
        horaLimiteJornada.subtract(Duration(minutes: 30));
    var horaCorteMotorInternacional =
        horaLimiteJornada.subtract(Duration(minutes: 45));
    //var lastro = horaLimiteJornada.difference(Util.horaLastPouso);
    //print(lastro.toString());
    var lastroDomestico = (horaLimiteJornada.add(Duration(minutes: 30))).difference(Util.horaLastPouso);
    var lastroInternacional =(horaLimiteJornada.add(Duration(minutes: 45))).difference(Util.horaLastPouso);
    String newFormatedDia =
        (formatDate(horaLimiteJornada, [dd, '/', mm, '/', yyyy]));
    String newFormatedTime =
        (formatDate(horaLimiteJornada, [HH, ':', nn])).toString();

    String newFormatedDiaCorteDom =
        (formatDate(horaCorteMotorDomestico, [dd, '/', mm, '/', yyyy]));
    String newFormatedTimeCorteDom =
        (formatDate(horaCorteMotorDomestico, [HH, ':', nn])).toString();

    String newFormatedDiaCorteInt =
        (formatDate(horaCorteMotorInternacional, [dd, '-', mm, '-', yyyy]));
    String newFormatedTimeCorteInt =
        (formatDate(horaCorteMotorInternacional, [HH, ':', nn])).toString();
    return Container(
      child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Card(
             // color: Color(0xff5831b9),
              child: ListTile(
                  title: Text('Duração máxima da jornada:',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff00005a),
                      )),
                  subtitle: Center(
                    child: Text(myList[0].jornadaMaxima.toString() + ':00' + ' Horas',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        )),
                  )),
            ),
            SizedBox(height: 16,),
            Card(
              child: ListTile(
                title: Text('Tempo máximo de voo:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00005a),
                    )),
                subtitle: myList[0].tempoVoo != 9.5
                    ? Center(
                      child: Text(myList[0].tempoVoo.toString() +':00' +' Horas',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          )),
                    )
                    : Center(
                      child: Text('9:30' + ' Horas',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
              ),
            ),
            /* horario limite termino jornada - 30m de tipovoo=domestico
            ou -45m se tipo voo = internacional

            */
            SizedBox(height: 16,),
            Card(
              child: ListTile(
                title: Text('Horário limite de corte do motor:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00005a),
                    )),
                subtitle: Util.tipoVoo == 'Doméstico'
                    ? Center(
                      child: Text(
                          newFormatedDiaCorteDom + ' as ' + newFormatedTimeCorteDom,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          )),
                    )
                    : Center(
                      child: Text(
                          newFormatedDiaCorteInt + ' as ' + newFormatedTimeCorteInt,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
              ),
            ),
            SizedBox(height: 16,),
            Card(
              child: ListTile(
                title: Text('Horário limite de término da jornada:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00005a),
                    )),
                subtitle: Center(
                  child: Text(newFormatedDia + ' as ' + newFormatedTime,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
            ),
            /*horario limite do termino da jornada - horario do pouso
            +30 m se tipo voo= domestico ou 45m se internacional*/
            SizedBox(height: 16,),
            Card(
              child: ListTile(
                //contentPadding: EdgeInsets.all(16),
                title: Text('Lastro:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00005a),
                    )),
                subtitle: Util.tipoVoo == 'Doméstico'
                    ? Center(
                      child: Text(lastroDomestico.inHours.toString()+ ':'+ lastroDomestico.inMinutes.remainder(60).toString()+' Horas',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      )),
                    )
                    : Center(
                      child: Text(lastroInternacional.inHours.toString() + ':'+ lastroInternacional.inMinutes.remainder(60).toString()+' Horas',style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
              ),

            ),
          ],
        ),
      
    );
  }
}