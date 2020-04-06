

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latam/models/acesso.dart';
import 'package:latam/utilitarios/utilitarios.dart';

import 'background_widget.dart';

class ChecaUser extends StatefulWidget {
  @override
  _ChecaUserState createState() => _ChecaUserState();
}

class _ChecaUserState extends State<ChecaUser> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;
  TextEditingController _emailController = TextEditingController();
  
  bool hasUser = false;
  bool isAdmin = false;
  bool isLogin = false;
  bool hadErrorOnValidate = false;
  String textoBotao = 'Login';

  //Util util;

  String messageError;
  List<Acesso> acesso = List();
  var result;
  var listener;
  final _formKey =
      GlobalKey<FormState>(); //used to access Form and can validate TextForm
  final scaffoldKey =
      GlobalKey<ScaffoldState>(); //used to access to scaffold to use a snackbar

  void validateDataAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      print('Data is valid');

      //checar se email esta na lista de liberados

      Util.getAcessoByEmail(_emailController.text).then((value) {
        if (value.length == 0) {
          print('Não liberado');
          showMessage('Acesso não liberado!');
          
        } else{
          showMessage('Acesso liberado!');
          print('Liberado');

        }
      }).catchError((e) {
        showMessage('Acesso não liberado!');
        
      });
    } else {
      hadErrorOnValidate = true;
    }
  }

  //Show a message using a SnackBar
  void showMessage(String message) {
    SnackBar snackbar = SnackBar(
      backgroundColor: Color(0xff858585),
      content: Text(
        message,
        style: TextStyle(fontFamily: 'TREBUC'),
      ),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  //Doing Authentication
  Future signIn(String email, String senha) async {
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((firebaseuser) {
      messageError = 'Autenticado com sucesso';
      //show snackbar
      showMessage(messageError);
      //userIsAdmin(user.uid);
     // gotoPagina(context, Alerta());
    }).catchError((e) {
      PlatformException error = e;
      if (error.code == 'ERROR_WRONG_PASSWORD') {
        messageError = 'Senha inválida!';
        //show snackbar
        showMessage(messageError);
      } else if (error.code == 'ERROR_INVALID_EMAIL' ||
          error.code == 'ERROR_USER_NOT_FOUND') {
        messageError = 'Email/usuário não cadastrado!';
        //show snackbar
        showMessage(messageError);
      }
    });
  }

  //Creating new general user
  Future createUser(String email, String senha) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((value) {
      messageError = 'Criado e Autenticado com sucesso';
      //show snackbar
      showMessage(messageError);

      //gotoPagina(context, Alerta()); //mostrar aviso=>rbac page
    }).catchError((e) {
      PlatformException erro = e;

      if (erro.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        /*estou considerando que a senha nunca poderá estar errada, pois ainda não foi cadastrada */
        messageError = 'Erro no cadastramento. E-mail já cadastrado!';
        //show snackbar
        showMessage(messageError);
        setState(() {
          hasUser = true; //para mudar texto do botão
        });
        //signIn(email, senha);

        print('Falha na criação' + e.toString());
      }
    });
  }

  //send email if user has forgotten password
  void sendEmailWithPass() {
    try {
      _firebaseAuth
          .sendPasswordResetEmail(email: _emailController.text)
          .then((value) {
        messageError = 'Senha enviada para seu e-mail';
        showMessage(messageError);
        setState(() {
          //textoBotao = 'Login';
        });
      }).catchError((e) {
        messageError = 'Falha no re-envio de senha!';
        showMessage(messageError);
      });
    } catch (e) {
      messageError = 'Usuário não cadastrado';
      showMessage(messageError);
    }
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    
  }

  @override
  void initState() {
    super.initState();
    //hasInternet();
    setState(() {

    });
  }

  gotoPagina(BuildContext context, Widget pagina) {
    Route route = MaterialPageRoute(builder: (context) => pagina);
    Navigator.pushReplacement(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      
      appBar: AppBar(
        title: Text('Checar liberação'),centerTitle: true,
      ),
      backgroundColor:Color(0xff00005a),
     
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: BackgroundWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
//Fachada(),
                Image.asset(
                  'assets/images/logo.png',
                  height: 70,
                ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                  child: Text(
                    'E-mail:',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'TREBUC',
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffffffff)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        style:
                            TextStyle(color: Color(0xff00005a), fontSize: 16),
                        onTap: () {
                          if (hadErrorOnValidate) {
                            _formKey.currentState.reset();
                            hadErrorOnValidate = false;
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) =>
                            value.isEmpty || !value.contains('@')
                                ? 'E-mail inválido!'
                                : null,
                        decoration: InputDecoration(
                            hintText: 'Seu e-mail corporativo',
                            border: InputBorder.none,
                            //labelText: 'Seu e-mail corporativo',
                            errorStyle: TextStyle(
                                color: Color(0xffbb002f), fontSize: 12),
                            labelStyle: TextStyle(color: Color(0xffffffff))),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.purple[900],
                      ), //(0xff801935)),
                      child: FlatButton(
                          child: Center(
                            child: Text(
                              'Checar liberação',
                              style: TextStyle(
                                  color: Colors.white, //(0xff801935),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: validateDataAndSave)),
                ),
                SizedBox(
                  height: 16,
                ),

                  ],
                ),
                //(0xff801935)),))
              
            ),
          ),
        ),
      
    );
  }


  mostrarAlerta(String message, context) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                'Alerta',
                style: TextStyle(color: Colors.black, fontSize: 40),
              ),
              content: Text(
                message,
                style: TextStyle(color: Colors.black),
              ),
              actions: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: FlatButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      exit(0);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
              elevation: 16,
              backgroundColor: Colors.white,
              //shape: CircleBorder(),
            ));
  }
}