import 'package:flutter/material.dart';
import 'package:latam/models/usuario.dart';
import 'package:latam/pages/rbac_home.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:latam/widgets/texto_aviso.dart';

class Alerta extends StatefulWidget {
  @override
  _AlertaState createState() => _AlertaState();
}

class _AlertaState extends State<Alerta> {
  bool _noShowAgain = false;
  @override
  void initState() {
    super.initState();
  }

  gotoPagina(BuildContext context, Widget pagina) {
    Route route = MaterialPageRoute(builder: (context) => pagina);
    Navigator.pushReplacement(context, route);
  }

  @override
  Widget build(BuildContext context) {
    var altura = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: altura,
        
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff1b0088), Color(0xffed1650)],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              stops: [0, 1],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          children: <Widget>[
            Padding(
      padding: const EdgeInsets.only(top:80,left: 20,right: 20),
      child: Container(
  
               // padding: EdgeInsets.only(right: 20,left: 20),          
  
                  decoration: BoxDecoration(
  
                    color: Colors.white,
  
                    border: Border.all(
  
                      color: Colors.white,
  
                    ),
  
                    borderRadius: BorderRadius.all(Radius.circular(16)),
  
                  ),
  
                  child: Padding(
  
                    padding: const EdgeInsets.only(left: 24, right: 24),
  
                    child: Column(
  
                        crossAxisAlignment: CrossAxisAlignment.start,
  
                        children: <Widget>[
//Divider(height: 5,color: Color(0xff858585),),
  
                          TextoAviso(),
  
                          Row(
  
                            mainAxisAlignment: MainAxisAlignment.start,
  
                            children: <Widget>[
  
                              Card(
  
                                elevation: 0,
  
                                child: Checkbox(
  
                                    value: _noShowAgain,
  
                                    onChanged: (value) {
  
                                      setState(() {
  
                                        _noShowAgain = value;
  
                                      });
  
                                    }),
  
                              ),
  
                              Text(
  
                                'Não exibir novamente.',
  
                                style: TextStyle(
  
                                  decoration: TextDecoration.none,
  
                                  fontFamily: 'TREBUC',
                                  fontWeight:FontWeight.normal,
  
                                  fontSize: 18,
  
                                  color: Color(0xff858585),
  
                                  //letterSpacing: 3,
  
                                ),
  
                              )
  
                            ],
  
                          ),
                          Divider(height: 5,color: Color(0xff858585),),
  
                          SizedBox(
  
                            height: 8,
  
                          ),
  
                          Align(
  
                              alignment: Alignment.bottomRight,
  
                              child: RaisedButton(
  
                                  color: Color(0xffed1650),
  
                                  child: Text('OK',
  
                                      style: TextStyle(
  
                                        decoration: TextDecoration.none,
  
                                        fontFamily: 'TREBUC',
  
                                        fontSize: 18,
  
                                        color: Color(0xffffffff),
  
                                        //letterSpacing: 3,
  
                                      )),
  
                                  onPressed: () {

                                    Util.getCurrentUserStatus().then((value){

                                      Usuario usuario = Usuario(
  
                                        email: Util.userEmail,
  
                                        id: Util.userID,
  
                                        isAdmin: false,
  
                                        mostraAviso: _noShowAgain);

                                        Util.salvarDados('usuarios', Util.userID, usuario.toMap());


                                    });
  
                                   // gotoPagina(context, RbacHome());
  
                                    Util.gotoScreen(RbacHome(), context);
  
                                  })),
                                  SizedBox(height: 8),
  
                        ]),
  
                  )),
    ),
],
        ),
      ),
    );
  }
}
