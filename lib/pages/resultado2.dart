import 'package:flutter/material.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:latam/widgets/background_widget.dart';
import 'package:latam/widgets/Calculo.dart';
import 'package:latam/widgets/textoGeralResultado.dart';
import 'package:latam/widgets/textoNO767fresultado.dart';

class Resultado2 extends StatefulWidget {
  @override
  _Resultado2State createState() => _Resultado2State();
}

class _Resultado2State extends State<Resultado2> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor:Color(0xff00005a),
          centerTitle: true,
          title: Text('Resultado'),
        ),
          body: SingleChildScrollView(
            child: Container(
              child: Center(
          child: BackgroundWidget(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView(
               // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 8,),
                  Util.hasVooVolta? Center(
                    child: Card(color: Color(0xff858585),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text('Voo de ida'.toUpperCase(), style: TextStyle(fontSize:20,
                          color: Color(0xffffffff)),),
                                            ),
                                          ),
                    ),
                  ):Container(),
                  SizedBox(height: 8,),
                  Card(
                   // color: Color(0xff5831b9),
                    child: ListTile(
                            title: ((Util.sobreaviso=='1') && (Util.tipoTripulacao=='Simples'))
                                 ?Text('Duração máxima da jornada + sobreaviso:',style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff00005a),))
                                 :Text('Duração máxima da jornada:',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xff00005a),
                                )),
                            subtitle: Center(
                              child: Text(Calculo().calcular(
                                Util.equipamento, 
                                Util.tripulacao, 
                                Util.etapas, 
                                Util.funcao, 
                                Util.fusos, 
                                Util.safetyCase, 
                                Util.sobreaviso, 
                                Util.acionado, 
                                Util.destino, 
                                Util.rotaSafetyCase, 
                                Util.horarioInicioSobreaviso, 
                                Util.horarioTerminoSobreaviso, 
                                Util.dataReserva,
                                Util.horaReserva,
                                Util.dataVooIdaDecolagem,
                                Util.horaVooIdaDecolagem,
                                Util.dataVooIdaPouso,
                                Util.horaVooIdaPouso,
                                Util.dataVooVoltaDecolagem,
                                Util.horaVooVoltaDecolatem,
                                Util.dataVooVoltaPouso,
                                Util.horaVooVoltaPouso).jornadaFormatada(),
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
                      subtitle: Center(
                                child: Text(Calculo().calcular(
                                Util.equipamento, 
                                Util.tripulacao, 
                                Util.etapas, 
                                Util.funcao, 
                                Util.fusos, 
                                Util.safetyCase, 
                                Util.sobreaviso, 
                                Util.acionado, 
                                Util.destino, 
                                Util.rotaSafetyCase, 
                                Util.horarioInicioSobreaviso, 
                                Util.horarioTerminoSobreaviso, 
                                Util.dataReserva,
                                Util.horaReserva,
                                Util.dataVooIdaDecolagem,
                                Util.horaVooIdaDecolagem,
                                Util.dataVooIdaPouso,
                                Util.horaVooIdaPouso,
                                Util.dataVooVoltaDecolagem,
                                Util.horaVooVoltaDecolatem,
                                Util.dataVooVoltaPouso,
                                Util.horaVooVoltaPouso).voo,
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
                      title: Text('Horário limite de corte do motor:',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff00005a),
                              )),
                      subtitle: Center(
                                child: Text(Calculo().calcular(
                                Util.equipamento, 
                                Util.tripulacao, 
                                Util.etapas, 
                                Util.funcao, 
                                Util.fusos, 
                                Util.safetyCase, 
                                Util.sobreaviso, 
                                Util.acionado, 
                                Util.destino, 
                                Util.rotaSafetyCase, 
                                Util.horarioInicioSobreaviso, 
                                Util.horarioTerminoSobreaviso, 
                                Util.dataReserva,
                                Util.horaReserva,
                                Util.dataVooIdaDecolagem,
                                Util.horaVooIdaDecolagem,
                                Util.dataVooIdaPouso,
                                Util.horaVooIdaPouso,
                                Util.dataVooVoltaDecolagem,
                                Util.horaVooVoltaDecolatem,
                                Util.dataVooVoltaPouso,
                                Util.horaVooVoltaPouso).horarioLimiteCorteMotor,
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
                            child: Text(Calculo().calcular(
                                Util.equipamento, 
                                Util.tripulacao, 
                                Util.etapas, 
                                Util.funcao, 
                                Util.fusos, 
                                Util.safetyCase, 
                                Util.sobreaviso, 
                                Util.acionado, 
                                Util.destino, 
                                Util.rotaSafetyCase, 
                                Util.horarioInicioSobreaviso, 
                                Util.horarioTerminoSobreaviso, 
                                Util.dataReserva,
                                Util.horaReserva,
                                Util.dataVooIdaDecolagem,
                                Util.horaVooIdaDecolagem,
                                Util.dataVooIdaPouso,
                                Util.horaVooIdaPouso,
                                Util.dataVooVoltaDecolagem,
                                Util.horaVooVoltaDecolatem,
                                Util.dataVooVoltaPouso,
                                Util.horaVooVoltaPouso).horarioLimiteTerminoJornada,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                )),
                      ),
                    ),
                  ),

                  SizedBox(height: 16,),
                  Util.showLastro?Card(
                    child: ListTile(
                      //contentPadding: EdgeInsets.all(16),
                      title: Text('Lastro:',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff00005a),
                              )),
                      subtitle: Center(
                                child: Text(Calculo().calcular(
                                Util.equipamento, 
                                Util.tripulacao, 
                                Util.etapas, 
                                Util.funcao, 
                                Util.fusos, 
                                Util.safetyCase, 
                                Util.sobreaviso, 
                                Util.acionado, 
                                Util.destino, 
                                Util.rotaSafetyCase, 
                                Util.horarioInicioSobreaviso, 
                                Util.horarioTerminoSobreaviso, 
                                Util.dataReserva,
                                Util.horaReserva,
                                Util.dataVooIdaDecolagem,
                                Util.horaVooIdaDecolagem,
                                Util.dataVooIdaPouso,
                                Util.horaVooIdaPouso,
                                Util.dataVooVoltaDecolagem,
                                Util.horaVooVoltaDecolatem,
                                Util.dataVooVoltaPouso,
                                Util.horaVooVoltaPouso).lastro,style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                )),
                              ),
                    ),

                  ):Container(),
                  SizedBox(height: 16,),
                  //
                  (!Util.hasVooVolta && Util.no767FSafety)? TextoNo767F():Container(),
                  (!Util.hasVooVolta && !Util.is767FSafety && !Util.no767FSafety)? TextoGeralResultado():Container(),

                    //message safety
                  
                  Util.hasVooVolta? CalcularVolta():Container(),
                ]),
                        ),
          )),
            )),
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
    
    return Container(
      child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16,),
            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8),
              child: Card(
                margin: EdgeInsets.symmetric(),
                child:
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Util.fusos=='MAIS'? Text((Calculo().calcular(
                                Util.equipamento, 
                                Util.tripulacao, 
                                Util.etapas, 
                                Util.funcao, 
                                Util.fusos, 
                                Util.safetyCase, 
                                Util.sobreaviso, 
                                Util.acionado, 
                                Util.destino, 
                                Util.rotaSafetyCase, 
                                Util.horarioInicioSobreaviso, 
                                Util.horarioTerminoSobreaviso, 
                                Util.dataReserva,
                                Util.horaReserva,
                                Util.dataVooIdaDecolagem,
                                Util.horaVooIdaDecolagem,
                                Util.dataVooIdaPouso,
                                Util.horaVooIdaPouso,
                                Util.dataVooVoltaDecolagem,
                                Util.horaVooVoltaDecolatem,
                                Util.dataVooVoltaPouso,
                                Util.horaVooVoltaPouso).aclimatacao).toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500,
                                    )):Container(),
                ),
                color:(Calculo().calcular(
                              Util.equipamento, 
                              Util.tripulacao, 
                              Util.etapas, 
                              Util.funcao, 
                              Util.fusos, 
                              Util.safetyCase, 
                              Util.sobreaviso, 
                              Util.acionado, 
                              Util.destino, 
                              Util.rotaSafetyCase, 
                              Util.horarioInicioSobreaviso, 
                              Util.horarioTerminoSobreaviso, 
                              Util.dataReserva,
                              Util.horaReserva,
                              Util.dataVooIdaDecolagem,
                              Util.horaVooIdaDecolagem,
                              Util.dataVooIdaPouso,
                              Util.horaVooIdaPouso,
                              Util.dataVooVoltaDecolagem,
                              Util.horaVooVoltaDecolatem,
                              Util.dataVooVoltaPouso,
                              Util.horaVooVoltaPouso).aclimatacao)=="Aclimatado"?Color(0xff99cc33):Color(0xffed1650),

              ),
            ),
            SizedBox(height: 24,),
            Card(color: Color(0xff858585),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text('Voo de volta'.toUpperCase(), style: TextStyle(fontSize:20,
                      color: Color(0xffffffff)),),
                            ),
                          ),
            ),
                    SizedBox(height: 8,),
            Card(
             // color: Color(0xff5831b9),
              child: ListTile(
                  title: Text('Duração máxima da jornada:',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xff00005a),
                      )),
                  subtitle: Center(
                    child: Text(Calculo().calcular(
                            Util.equipamento, 
                            Util.tripulacao, 
                            Util.etapas, 
                            Util.funcao, 
                            Util.fusos, 
                            Util.safetyCase, 
                            Util.sobreaviso, 
                            Util.acionado, 
                            Util.destino, 
                            Util.rotaSafetyCase, 
                            Util.horarioInicioSobreaviso, 
                            Util.horarioTerminoSobreaviso, 
                            Util.dataReserva,
                            Util.horaReserva,
                            Util.dataVooIdaDecolagem,
                            Util.horaVooIdaDecolagem,
                            Util.dataVooIdaPouso,
                            Util.horaVooIdaPouso,
                            Util.dataVooVoltaDecolagem,
                            Util.horaVooVoltaDecolatem,
                            Util.dataVooVoltaPouso,
                            Util.horaVooVoltaPouso).jornada2Formatada(),
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
                subtitle: Center(
                      child: Text(Calculo().calcular(
                            Util.equipamento, 
                            Util.tripulacao, 
                            Util.etapas, 
                            Util.funcao, 
                            Util.fusos, 
                            Util.safetyCase, 
                            Util.sobreaviso, 
                            Util.acionado, 
                            Util.destino, 
                            Util.rotaSafetyCase, 
                            Util.horarioInicioSobreaviso, 
                            Util.horarioTerminoSobreaviso, 
                            Util.dataReserva,
                            Util.horaReserva,
                            Util.dataVooIdaDecolagem,
                            Util.horaVooIdaDecolagem,
                            Util.dataVooIdaPouso,
                            Util.horaVooIdaPouso,
                            Util.dataVooVoltaDecolagem,
                            Util.horaVooVoltaDecolatem,
                            Util.dataVooVoltaPouso,
                            Util.horaVooVoltaPouso).voo2,
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
                title: Text('Horário limite de corte do motor:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00005a),
                    )),
                subtitle:  Center(
                      child: Text(Calculo().calcular(
                            Util.equipamento, 
                            Util.tripulacao, 
                            Util.etapas, 
                            Util.funcao, 
                            Util.fusos, 
                            Util.safetyCase, 
                            Util.sobreaviso, 
                            Util.acionado, 
                            Util.destino, 
                            Util.rotaSafetyCase, 
                            Util.horarioInicioSobreaviso, 
                            Util.horarioTerminoSobreaviso, 
                            Util.dataReserva,
                            Util.horaReserva,
                            Util.dataVooIdaDecolagem,
                            Util.horaVooIdaDecolagem,
                            Util.dataVooIdaPouso,
                            Util.horaVooIdaPouso,
                            Util.dataVooVoltaDecolagem,
                            Util.horaVooVoltaDecolatem,
                            Util.dataVooVoltaPouso,
                            Util.horaVooVoltaPouso).horarioLimiteCorteMotor2,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                ),)
                          
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
                  child: Text(Calculo().calcular(
                            Util.equipamento, 
                            Util.tripulacao, 
                            Util.etapas, 
                            Util.funcao, 
                            Util.fusos, 
                            Util.safetyCase, 
                            Util.sobreaviso, 
                            Util.acionado, 
                            Util.destino, 
                            Util.rotaSafetyCase, 
                            Util.horarioInicioSobreaviso, 
                            Util.horarioTerminoSobreaviso, 
                            Util.dataReserva,
                            Util.horaReserva,
                            Util.dataVooIdaDecolagem,
                            Util.horaVooIdaDecolagem,
                            Util.dataVooIdaPouso,
                            Util.horaVooIdaPouso,
                            Util.dataVooVoltaDecolagem,
                            Util.horaVooVoltaDecolatem,
                            Util.dataVooVoltaPouso,
                            Util.horaVooVoltaPouso).horarioLimiteTerminoJornada2,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                )),
                ),
              ),
            ),

            SizedBox(height: 16,),
              Util.showLastro?Card(
              child: ListTile(
                //contentPadding: EdgeInsets.all(16),
                title: Text('Lastro:',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff00005a),
                    )),
                subtitle: Center(
                      child: Text(Calculo().calcular(
                            Util.equipamento, 
                            Util.tripulacao, 
                            Util.etapas, 
                            Util.funcao, 
                            Util.fusos, 
                            Util.safetyCase, 
                            Util.sobreaviso, 
                            Util.acionado, 
                            Util.destino, 
                            Util.rotaSafetyCase, 
                            Util.horarioInicioSobreaviso, 
                            Util.horarioTerminoSobreaviso, 
                            Util.dataReserva,
                            Util.horaReserva,
                            Util.dataVooIdaDecolagem,
                            Util.horaVooIdaDecolagem,
                            Util.dataVooIdaPouso,
                            Util.horaVooIdaPouso,
                            Util.dataVooVoltaDecolagem,
                            Util.horaVooVoltaDecolatem,
                            Util.dataVooVoltaPouso,
                            Util.horaVooVoltaPouso).lastro2,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                )),
                    ),
              ),

            ):Container(),
            SizedBox(height: 16,),
           Util.no767FSafety ?TextoNo767F():Container(),
(!Util.no767FSafety && !Util.is767FSafety && !Util.no767FSafety)? TextoGeralResultado():Container(),
            SizedBox(height: 100,),
          ],
        ),
      
    );
  }
}