import 'package:flutter/material.dart';
import 'package:latam/widgets/menu_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey myKey = GlobalKey();
    var largura = MediaQuery.of(context).size.width;
    var altura = MediaQuery.of(context).size.height;
    String url = 'https://picsum.photos/' +
        largura.toStringAsFixed(0) +
        '/' +
        altura.toStringAsFixed(0);

    /* showAviso() {
      showDialog<void>(
        
        context: context,
        builder: (BuildContext context) {
          
          return AlertDialog(key: myKey,
            title: Text('Aviso'),
            content: const Text('Bem vindo, tripulante! '),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  //Util.appStarted = false;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } */

    return Scaffold(
      key: myKey,
      appBar: AppBar(
        backgroundColor: Color(0xff00005a),
          title: Image.asset(
            'assets/images/logo.png',
            height: 50,
          ),
          centerTitle: true),
      drawer: MenuBar(
        isAdmin: false,
        context: context,
      ),
      body: Container(
        width: largura,
        child:Image.network(
                url,
                fit: BoxFit.fill,
              ),
      ),
    );
  }
}
