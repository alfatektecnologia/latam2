import 'package:flutter/material.dart';
import 'package:latam/pages/rbac_home.dart';
import 'package:latam/widgets/texto_rotas.dart';

class RotaHelp extends StatelessWidget {

   gotoPagina(BuildContext context, Widget pagina) {
    Route route = MaterialPageRoute(builder: (context) => pagina);
    Navigator.pushReplacement(context, route);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff1b0088), Color(0xffed1650)],
              begin: FractionalOffset.topLeft,
              end: FractionalOffset.bottomRight,
              stops: [0, 1],
              tileMode: TileMode.clamp),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top:80.0,left: 20,right: 20),
          child: Column(
            children: <Widget>[
              Container(
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
                          TextoRotas(),
                          Divider(height: 5,color: Color(0xff858585),),
                          SizedBox(
                            height: 16,
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
                                    
                                    gotoPagina(context, RbacHome());
                                    //Util.gotoScreen(RbacHome(), context);
                                  })),
                                  SizedBox(height: 8
                                  ,),
                        ]),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}