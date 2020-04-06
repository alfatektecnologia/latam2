import 'package:flutter/material.dart';
import 'package:latam/models/jornada.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:latam/widgets/lista_resultado.dart';
import 'package:provider/provider.dart';

class Resultado extends StatefulWidget {
  @override
  _ResultadoState createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider<Util>(
      create: (_)=>Util(),
          child: Scaffold(
           // backgroundColor: Color(0xff5831b9),
        appBar: AppBar(
         backgroundColor:Color(0xff00005a),
          centerTitle: true,
          title: Text('Resultado',style: TextStyle(fontSize:25),),
        ),
        body: SingleChildScrollView(
                  child: Container(
            decoration: BoxDecoration(
              gradient:LinearGradient(colors:[Color(0xff1b0088),Color(0xffed1650)],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              stops: [0,1],
              tileMode: TileMode.clamp
              ),
            ),
            child: Consumer<Util>(
              builder: (context, util, _) => Container(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: FutureBuilder<List<Jornada>>(
                      future:
                          Util.getJornada(Util.faixaHorariaJornada, Util.faixaEtapa),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Carregando os dados...',
                                    style: TextStyle(fontSize: 20,color:Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CircularProgressIndicator(),
                                ],
                              ),
                            );
                            break;
                          case ConnectionState.active:

                          case ConnectionState.done:
                            //todo:checar erros

                            //listProdutos = appState.listProdutos;

                            if (snapshot.hasData) {
                              return ListaResultado(
                                snapshot: snapshot,
                                //snapshot: snapshot,
                              );
                            } else {
                              return Center(
                                child: Container(
                                  child: Text(
                                    'Faltam dados para o cálculo!',
                                    style: TextStyle(fontSize: 20,color: Colors.white),
                                  ),
                                ),
                              );
                            }

                            break;
                        }
                        return Container();
                      }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* Column(
             // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Text('Jornada: '+Util.jornada.toString(),style: TextStyle(fontSize:24),),
                SizedBox(height: 16),
                Text('Voo: '+Util.voo.toString(),style: TextStyle(fontSize:24),)

              ],
            ), */
