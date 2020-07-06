import 'dart:io';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latam/models/acesso.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:latam/widgets/alerta.dart';
import 'package:latam/widgets/background_widget.dart';

class Login extends StatefulWidget {
  final Map dadosUsuario; //email, uid,

  Login(this.dadosUsuario);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseUser user;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  bool hasUser = false;
  bool isAdmin = false;
  bool isLogin = false;

  bool hadErrorOnValidate = false;
  String textoBotao = 'Login';

  //Util util;

  String messageError;
  // List<Acesso> acesso = List();
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
      checarUserByEmail();
    } else {
      hadErrorOnValidate = true;
    }
  }

  void checarUserByEmail()async {
    await Util.getAcessoByEmail(_emailController.text).then((value) {
      if (value.length == 0) {
        print('Não liberado');
        showMessage('Acesso não liberado!');
        hadErrorOnValidate = true;
       // exit(1);
      } else {
        showMessage('Acesso liberado!');
        print('Liberado');
        hasUser == true
            ? signIn(_emailController.text, _senhaController.text)
            : createUser(_emailController.text, _senhaController.text);
      }
    }).catchError((e) {
      showMessage('Acesso não liberado!');
      hadErrorOnValidate = true;
    });
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
      Acesso acesso = Acesso(email: email, installed: Util.qdadeCadastros);

      Util.atualizarDadosCadastro(
          'liberados', Util.docIdLiberado, acesso.toMap());
      gotoPagina(context, Alerta());
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
    validateDataAndSave();
    if (!hadErrorOnValidate) {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha)
          .then((value) {
        messageError = 'Criado e Autenticado com sucesso';
        //show snackbar
        showMessage(messageError);

        gotoPagina(context, Alerta()); //mostrar aviso=>rbac page
      }).catchError((e) {
        PlatformException erro = e;

        if (erro.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          /*estou considerando que a senha nunca poderá estar errada, pois ainda não foi cadastrada */
          messageError = 'Erro no cadastramento. E-mail já cadastrado em ' +
              Util.qdadeCadastros.toString() +
              ' dispositivo(s)!';

          // Util.showFlushbar(context, messageError);

          setState(() {
            hasUser = true; //para mudar texto do botão
            Util.qdadeCadastros = Util.qdadeCadastros + 1;
          });
          signIn(email, senha);

          print('Falha na criação' + e.toString());
        }
      });
    } else {
      showMessage('Acesso não liberado!');
    }
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
        messageError = 'Verifique se o e-mail inserido está correto!';
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
    _senhaController.dispose();
  }

  @override
  void initState() {
    super.initState();
    hasInternet();
    setState(() {
      //check if exist a user throw the email sent by Main method
      if (widget.dadosUsuario['user'] != null) {
        user = widget.dadosUsuario['user']; //firebaseUser
        _emailController.text = user.email;
        isAdmin = widget.dadosUsuario['admin']; //false or true
        hasUser = true;
        isLogin = true;
      }
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
      //backgroundColor: Color(0xffed1650),//deepPurple[200],
      //bottomNavigationBar: BottomNavigationBar(items: null) ,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: BackgroundWidget(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
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
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 8),
                  child: Text(
                    'Senha de acesso:',
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
                        color: Color(0xffffffff)), //(0xff801935)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: TextFormField(
                        style: TextStyle(
                          color: Color(0xff00005a),
                          fontSize: 16,
                        ),
                        keyboardType: TextInputType.text,
                        controller: _senhaController,
                        validator: (value) => value.isEmpty || value.length < 6
                            ? 'Senha inválida!'
                            : null,
                        obscureText: true,
                        onTap: () {
                          if (hadErrorOnValidate) {
                            _formKey.currentState.reset();
                            hadErrorOnValidate = false;
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Sua senha com no mínimo 6 dígitos',
                            //labelText: 'Sua senha com no mínimo 6 dígitos',
                            errorStyle: TextStyle(
                                color: Color(0xffbb002f), fontSize: 12),
                            labelStyle: TextStyle(color: Color(0xff00005a))),
                      ),
                    ),
                  ),
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
                              textoBotao,
                              style: TextStyle(
                                  color: Colors.white, //(0xff801935),
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          onPressed: () async {
                            if (textoBotao == 'Cadastrar') {
                              createUser(
                                  _emailController.text, _senhaController.text);
                            } else {
                              validateDataAndSave();
                            }
                          },
                        ))),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: sendEmailWithPass,
                      child: Image.asset(
                        'assets/images/click.png',
                        height: 35,
                      ),
                    ),
                    FlatButton(
                        onPressed: sendEmailWithPass,
                        child: Text(
                          ' Esqueci a senha.',
                          style: TextStyle(color: Color(0xffffffff)),
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment:CrossAxisAlignment.stretch,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            //mudar botão de login

                            textoBotao = 'Cadastrar';
                          });
                        },
                        child: Image.asset(
                          'assets/images/usuario.png',
                          height: 35,
                        )),
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            //mudar botão de login

                            textoBotao = 'Cadastrar';
                          });
                        },

                        //setarTextoBotao('Cadastrar'.toUpperCase()),

                        child: Text(
                          " Primeiro acesso?",
                          style: TextStyle(color: Color(0xffffffff)),
                        )),
                  ],
                ),
                //(0xff801935)),))
              ],
            ),
          ),
        ),
      ),
    );
  }

//check if has a valid internet connection
  Future hasInternet() async {
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    // returns a bool

    // We can also get an enum value instead of a bool
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    // prints either DataConnectionStatus.connected
    // or DataConnectionStatus.disconnected

    // This returns the last results from the last call
    // to either hasConnection or connectionStatus
    print("Last results: ${DataConnectionChecker().lastTryResults}");

    // actively listen for status updates
    // this will cause DataConnectionChecker to check periodically
    // with the interval specified in DataConnectionChecker().checkInterval
    // until listener.cancel() is called
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Data connection is available.');
          break;
        case DataConnectionStatus.disconnected:
          print('You are disconnected from the internet.');
          mostrarAlerta('Verifique sua conexão com a internet!', context);

          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
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
