import 'dart:io';

import 'package:latam/pages/checa_user.dart';
import 'package:latam/pages/emails_liberados.dart';
import 'package:latam/pages/pdf_home.dart';
import 'package:latam/pages/rbac_home.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:flutter/material.dart';



final util = Util();

class MenuBar extends StatelessWidget {
  final bool isAdmin;
  final context;

  const MenuBar({Key key, this.isAdmin, this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isAdmin ? menuAdmin() : menuGeral();
  }

  Widget menuGeral() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xff00005a),
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage(
                    'assets/images/latam.png'
                  ),fit: BoxFit.scaleDown),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          /* ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              Navigator.of(context).pop();
              Util.gotoScreen(HomePage(), context);
            },
          ), */

          ListTile(
            leading: Image.asset('assets/images/calculo.png',height:40),
            title: Text(
              "Calcular jornada",
              style: TextStyle(fontSize: 20,color: Color(0xff858585)),
            ),
            onTap: () {
             
              Navigator.of(context).pop();
              Util.gotoScreen(RbacHome(), context);
            },
          ),
          ListTile(
            leading: Image.asset(
                'assets/images/doc_logo.png',height:40), //(Icons.picture_as_pdf),
            title: Text(
              "RBAC 117",
              style: TextStyle(fontSize: 20,color: Color(0xff858585)),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Util.gotoScreen(PdfHome(), context);
            },
          ),
          Util.userEmail=='camila.leme@latam.com' 
          || Util.userEmail=='emanoel_oliveira@hotmail.com'
          || Util.userEmail=='lhidalgo@hotmail.com'
          ?  ListTile(
            leading: Image.asset(
                'assets/images/usuario2.png',height:40),
            title: Text("Checar liberação",style: TextStyle(fontSize: 20,color: Color(0xff858585))),
            onTap: () {
              Navigator.of(context).pop();
              Util.gotoScreen(ChecaUser(), context);
            },
          ):Container(),
          Util.userEmail=='emanoel_oliveira@hotmail.com'
          ? 
           ListTile(
            leading: Icon(Icons.contacts,size: 50,color: Color(0xffed1650),),
            title: Text("Liberados",style: TextStyle(fontSize: 20,color: Color(0xff858585))),
            onTap: () {
              Navigator.of(context).pop();
              Util.gotoScreen(EmailsLiberados(), context);
            },
          )
          :Container(),
          ListTile(
            leading: Image.asset('assets/images/exit.png',height:40),
            title: Text(
              "Logout",
              style: TextStyle(fontSize: 20,color: Color(0xff858585)),
            ),
            onTap: () => exit(0),
          ),
        ],
      ),
    );
  }

  Widget menuAdmin() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage(
                    'assets/images/latam.png',
                  )),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'oliveiraemanoel.br@gmail.com',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.restaurant_menu),
            title: Text("Menu"),
            onTap: () {
              Navigator.of(context).pop();
              //Util.gotoScreen(HomePage(Util.isAdmin), context);
            },
          ),
          /* ListTile(
            leading: Icon(Icons.assignment),
            title: Text("Meus pedidos"),
            onTap: () {
              Navigator.of(context).pop();
              Util.gotoScreen(Pedidos(), context);
            },
          ), */
          ListTile(
            leading: Icon(Icons.mood),
            title: Text("Batepapo"),
            onTap: () {
              Navigator.of(context).pop();
              // Util.gotoScreen(ChatHome(), context);
            },
          ),
          ListTile(
            leading: Icon(Icons.event),
            title: Text("Eventos"),
            onTap: () {
              Navigator.of(context).pop();
              //Util.gotoScreen(Eventos(), context);
            },
          ),
          /* ListTile(
            leading: Icon(Icons.motorcycle),
            title: Text("Delivery"),
            onTap: () {
              Navigator.of(context).pop();
              Util.gotoScreen(Delivery(), context);
            },
          ), */
          ListTile(
            leading: Icon(Icons.local_offer),
            title: Text("Promoções"),
            onTap: () {
              Navigator.of(context).pop();
              //Util.gotoScreen(Promotion(), context);
            },
          ),
          ListTile(
            leading: Icon(Icons.close),
            title: Text("Sair"),
            onTap: () => exit(0),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child:
                Text('Administração', style: TextStyle(color: Colors.white38)),
          ),
          ListTile(
            leading: Icon(Icons.playlist_add),
            title: Text("Cadastros"),
            onTap: () {
              Navigator.of(context)
                  .pop(); //close the menu before going to another page
              //Util.gotoScreen(CadastroHome(tabIndex: 0,produtoFromHomePage: null,), context);
            },
          ),
          ListTile(
            leading: Icon(Icons.list),
            title: Text("Marmitex"),
            onTap: () {
              Navigator.of(context).pop();
              //Util.gotoScreen(Marmitex(), context);
            },
          ),
        ],
      ),
    );
  }
}
