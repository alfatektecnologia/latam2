import 'package:latam/models/acesso.dart';
import 'package:latam/models/jornada.dart';

import 'package:latam/models/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Util with ChangeNotifier {
  //dados usuario
  static String userID = 'null ';
  static String userEmail = 'null';
  static bool isAdmin = false;
  static bool mostraTelaAviso = true;
  static int qdadeCadastros = 0;
  static String docIdLiberado;
  static bool userAcessoLiberado = false;
  static bool showRotaSafetyCase = false;

  //input data
  static bool hasDataInicio = false;
  static bool hasHoraInicio = false;
  static bool hasDataInicio2 = false;
  static bool hasHoraInicio2 = false;
  static bool hasEtapa = false;
  static bool hasDataPouso = false;
  static bool hasHoraPouso = false;
  static bool hasDataPouso2 = false;
  static bool hasHoraPouso2 = false;
  static bool hasFuso = false;
  static bool hasFuncao = false;
  static bool hasSobreAviso = false;

  static bool isInputDataValidated = false;

  //calculo Lisias

  static String equipamento;
  static String tripulacao;
  static String etapas = "";
  static String funcao = "";
  static String fusos = "";
  static String safetyCase = "";
  static String sobreaviso = "";
  static String acionado = "";
  static String destino = "";
  static String rotaSafetyCase = "";
  static DateTime horarioInicioSobreaviso;
  static DateTime horarioTerminoSobreaviso;
  static DateTime dataReserva;
  static DateTime horaReserva;
  static DateTime dataVooIdaDecolagem; //data inicio jornada
  static DateTime horaVooIdaDecolagem; //hora apresentação
  static DateTime dataVooIdaPouso; //data pouso
  static DateTime horaVooIdaPouso; //hora ultimo pouso
  static DateTime dataVooVoltaDecolagem; //data inicio jornada/voo 2
  static DateTime horaVooVoltaDecolatem; //hora apresentação voo2
  static DateTime dataVooVoltaPouso; //data pouso voo2
  static DateTime horaVooVoltaPouso; //hora voltapouso voo2

  //end

  static bool isSobreAviso =
      false; //true if resposta de sobreaviso for sim em SobreAviso.
  static int radioValueSobreAviso = -1;
  static bool showLastro = true;
  static bool is767FSafety = false;
  static bool tripTTonly = false;
  static String tipoFuncao;
  static String tipoTripulacao;
  static String tipoVoo;
  static String horaApresentacaoReserva = 'HH:MM';
  static String dataApresentacaoReserva = 'DD/MM/AA';
  static bool no767FSafety = false;
  static String tipoAcionamentoSobreaviso;
  static bool hasTipoTripDefined =
      false; //true if type of tripulation is defined
  static String faixaHorariaJornada;
  static bool hasFaixaHoraria = false; //used to validate imput and calculate
  static String faixaEtapa;
  static bool hasFaixaEtapa = false; //used to validate input and calculate
  static var dataInicioJornada;
  static var dataInicioJornada2;
  static var dataLimiteJornada;
  static var dataLimiteJornada2;
  static var horaInicioJornada;
  static var horaInicioJornada2;
  static var horaLimiteJornada;
  static var horaLimiteJornada2;
  static var horaLastPouso;
  static var horaLastPouso2;
  static var hasVooVolta = false;
  static var jornada;
  static var voo;
  static bool lastroNegativo = false;
  static bool lastro2Negativo = false;

  //static bool appStarted = true;

  static final Firestore firestore = Firestore.instance;

  static final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  //navegar para outra pÃ¡gina (used inside an onclick button event)
  static void gotoScreen(Widget pagina, context) {
    Route route = MaterialPageRoute(builder: (context) => pagina);
    Navigator.push(context, route);
  }

  static resetarDataHora() {
    if (!(Util.tipoAcionamentoSobreaviso == 'Reserva + voo')) {
      hasDataInicio = false;
      hasDataInicio2 = false;
      hasDataPouso = false;
      hasDataPouso2 = false;
      hasHoraInicio = false;
      hasHoraInicio2 = false;
      hasHoraPouso = false;
      hasHoraPouso2 = false;
    } else {
      // hasDataInicio = false;
      hasDataInicio2 = false;
      hasDataPouso = false;
      hasDataPouso2 = false;
      //hasHoraInicio = false;
      hasHoraInicio2 = false;
      hasHoraPouso = false;
      hasHoraPouso2 = false;
    }
  }

  static resetarVariaveis() {
    //input data
    hasDataInicio = false;
    hasHoraInicio = false;
    hasDataInicio2 = false;
    hasHoraInicio2 = false;
    hasEtapa = false;
    hasDataPouso = false;
    hasHoraPouso = false;
    hasDataPouso2 = false;
    hasHoraPouso2 = false;
    hasFuso = false;
    hasFuncao = false;

    isInputDataValidated = false;

    horarioInicioSobreaviso = null;
    horarioTerminoSobreaviso = null;
    dataReserva = null;
    horaReserva = null;
    dataVooIdaDecolagem = null; //data inicio jornada
    horaVooIdaDecolagem = null; //hora apresentação
    dataVooIdaPouso = null; //data pouso
    horaVooIdaPouso = null; //hora ultimo pouso
    dataVooVoltaDecolagem = null; //data inicio jornada/voo 2
    horaVooVoltaDecolatem = null; //hora apresentação voo2
    dataVooVoltaPouso = null; //data pouso voo2
    horaVooVoltaPouso = null; //hora voltapouso voo2
  }

  //estado do sobreaviso (SobreAviso.dart e RbacHome.dart)
  setSobreaviso(bool x) {
    isSobreAviso = x;

    notifyListeners();
  }

  setRotaSafetyCase(String rota) {
    rotaSafetyCase = rota;
    notifyListeners();
  }

  setVoltaTripComposta(bool v) {
    hasVooVolta = v;
    notifyListeners();
  }

  setJornadaVoo(var j, var v) {
    jornada = j;
    voo = v;
    notifyListeners();
  }

  setTipoTripulacao(String tipo) {
    tipoTripulacao = tipo;
    notifyListeners();
  }

  setTipoVoo(String tipo) {
    tipoVoo = tipo;
    print(tipoVoo);
    notifyListeners();
  }

  setTipoAcionamento(String tipo) {
    tipoAcionamentoSobreaviso = tipo;
    notifyListeners();
  }

  setFaixaEtapas(String etapa) {
    int x;

    if (etapa == '1 ou 2') {
      x = 1;
    }

    if (etapa == '3 ou 4') {
      x = 2;
    }

    if (etapa == '5') {
      x = 3;
    }

    if (etapa == '6') {
      x = 4;
    }

    if (etapa == '7 +') {
      x = 5;
    }

    switch (x) {
      case 1:
        {
          faixaEtapa = 'Etapa1';
          hasFaixaEtapa = true;
          notifyListeners();
        }

        break;

      case 2:
        {
          faixaEtapa = 'Etapa2';
          hasFaixaEtapa = true;
          notifyListeners();
        }
        break;
      case 3:
        {
          faixaEtapa = 'Etapa3';
          hasFaixaEtapa = true;
          notifyListeners();
        }
        break;
      case 4:
        {
          faixaEtapa = 'Etapa4';
          hasFaixaEtapa = true;
          notifyListeners();
        }
        break;
      case 5:
        {
          faixaEtapa = 'Etapa5';
          hasFaixaEtapa = true;
          notifyListeners();
        }
        break;

      default:
        //faixaHorariaJornada = 'Hora1';
        hasFaixaEtapa = false;
      //notifyListeners();
    }
  }

  setFaixaHorariaJornada(int hora) {
    int x;

    if (hora == 6) {
      x = 6;
    }

    if (hora == 7) {
      x = 7;
    }

    if (hora > 7 && hora < 12) {
      x = 8;
    }

    if (hora > 11 && hora < 14) {
      x = 12;
    }

    if (hora > 13 && hora < 16) {
      x = 14;
    }

    if (hora > 15 && hora < 18) {
      x = 16;
    }

    if (hora > 17) {
      x = 18;
    }

    if (hora < 6) {
      x = 18;
    }

    switch (x) {
      case 6:
        {
          //hora1
          print(1);
          faixaHorariaJornada = 'Hora1';
          hasFaixaHoraria = true;
          notifyListeners();
        }

        break;

      case 7:
        {
          //hora2
          print(2);
          faixaHorariaJornada = 'Hora2';
          hasFaixaHoraria = true;
          notifyListeners();
        }
        break;
      case 8:
        {
          //
          print(3);
          faixaHorariaJornada = 'Hora3';
          hasFaixaHoraria = true;
          notifyListeners();
        }
        break;
      case 12:
        {
          //hora4
          print(4);
          faixaHorariaJornada = 'Hora4';
          hasFaixaHoraria = true;
          notifyListeners();
        }
        break;
      case 14:
        {
          //hora5
          print(5);
          faixaHorariaJornada = 'Hora5';
          hasFaixaHoraria = true;
          notifyListeners();
        }
        break;
      case 16:
        {
          //hora6
          print(6);
          faixaHorariaJornada = 'Hora6';
          hasFaixaHoraria = true;
          notifyListeners();
        }
        break;
      case 18:
        {
          //hora7
          print(7);
          faixaHorariaJornada = 'Hora7';
          hasFaixaHoraria = true;
          notifyListeners();
        }
        break;
      default:
        //faixaHorariaJornada = 'Hora1';
        hasFaixaHoraria = false;
      //notifyListeners();
    }
  }

  //check if exist a logged user
  static Future<Map<dynamic, dynamic>> getCurrentUserStatus() async {
    var userData = Map();
    bool result = false;
    List<Acesso> _liberado = List();
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser user = await auth.currentUser(); //checa se existe user logado
    userData['user'] = user;
    if (user != null) {
      userID = user.uid;
      userEmail = user.email;
      try {
        userData['liberado'] =
            _liberado = await getAcessoByEmail(userEmail.toLowerCase());
        getUserByEmail(userEmail); //used to get mostraaviso..
      } catch (e) {
        print(e.toString() + 'erro getting userByemail in getcurrent user ');
      }
    }

    if (_liberado.length > 0) {
      userAcessoLiberado = true;
      result = await userIsAdmin(user.uid);
      userData['admin'] = result;

      //return true or false;
    } else {
      //user==null
      // return false;
      userData['admin'] = result;
    }

    _liberado.length > 0 ? print(_liberado[0].email) : print(Null);
    print(Util.userAcessoLiberado);
    return userData;
  }

  //check if user is admin
  static Future<bool> userIsAdmin(userID) async {
    //bool isAdmin = false;//if null at database it becomes false too
    Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot = await db
        .collection("usuarios")
        .where("id", isEqualTo: userID)
        .getDocuments();

    {
      if (querySnapshot.documents.isEmpty) {
        isAdmin = false;
      } else {
        for (DocumentSnapshot item in querySnapshot.documents) {
          var dados = item.data;
          if (dados["isAdmin"]) {
            isAdmin = true;

            // return isAdmin;
          }
        }
      }
    }
    return isAdmin;
  }

  //salvar dados
  static Future salvarDados(String collection, String uid, Map dados) async {
    firestore.collection(collection).document(uid).setData(dados).then((value) {
      //print('dados salvos com sucesso');
    }).catchError((e) {});
  }

  //salvar dados cadastro
  static Future salvarDadosEmailsLiberados(String collection, Map dados) async {
    firestore.collection(collection).add(dados).then((value) {
      //print('dados salvos com sucesso');
    }).catchError((e) {
      print(e);
    });
  }

  //salvar os erros do app e dar suporte se necessário
  static Future salvarErros(Map dadosErro) async {
    firestore.collection('suporte').add(dadosErro);
  }

  //atualizar dados
  static Future atualizarDados(String collection, String uid, Map dados) async {
    firestore
        .collection(collection)
        .document(uid)
        .updateData(dados)
        .then((value) {
      print('dados salvos com sucesso');
    }).catchError((e) {
      print(e);
    });
  }

  //atualizar dados
  static Future atualizarDadosCadastro(
      String collection, String key, Map dados) async {
    firestore
        .collection(collection)
        .document(key)
        .updateData(dados)
        .then((value) {
      print('dados salvos com sucesso');
    }).catchError((e) {
      print(e);
    });
  }

  static Future<List<Jornada>> getJornada(
      String faixaHoraria, String etapa) async {
    QuerySnapshot querySnapshot = await firestore
        .collection('jornada_simples')
        .document(faixaHoraria.toLowerCase())
        .collection(etapa.toLowerCase())
        .getDocuments();

    List<Jornada> listJornada = List();

    for (DocumentSnapshot item in querySnapshot.documents) {
      var dados = item.data; //dados recebe um Map<String,dynamic>

      //if (dados['id'] == userID)
      // continue; //se a condição é verdadeira, não inclue o usuario na lista

      Jornada _jornada = Jornada(
        jornadaMaxima: dados['jornada'],
        tempoVoo: dados['voo'],
      );

      print(dados['jornada']);

      listJornada.add(_jornada);
    }
    return listJornada;
  }

  //recuperar contato por email
  static Future<List<Acesso>> getAcessoByEmail(String email) async {
    //retorna um snapShot do usuario, se existir
    QuerySnapshot querySnapshot = await firestore
        .collection('liberados')
        //.orderBy('email')
        .where('email', isEqualTo: email)
        .getDocuments();

    List<Acesso> liberado =
        List(); //preparo uma lista para receber o usuario do snapShot

    for (DocumentSnapshot item in querySnapshot.documents) {
      var dados = item.data; //dados recebe um Map<String,dynamic>
      Util.docIdLiberado = item.documentID; //documentId
      Acesso acesso = Acesso(email: dados['email']);

      try {
        if (item.data['installed'] == null) {
          Util.qdadeCadastros = 1;
        } else {
          Util.qdadeCadastros = item.data['installed'];
        }
      } catch (e) {
        print('Erro lendo liberados');
      }

      liberado.add(acesso);
    }
    return liberado;
  }

  //recuperar contato por email
  static Future<List<Usuario>> getUserByEmail(String email) async {
    //retorna um snapShot do usuario, se existir
    QuerySnapshot querySnapshot = await firestore
        .collection('usuarios')
        //.orderBy('email')
        .where('email', isEqualTo: email)
        .getDocuments();

    List<Usuario> listUsuarios =
        List(); //preparo uma lista para receber o usuario do snapShot

    for (DocumentSnapshot item in querySnapshot.documents) {
      var dados = item.data; //dados recebe um Map<String,dynamic>

      Usuario usuario = Usuario(
          email: dados['email'],
          id: dados['id'],
          mostraAviso: dados['mostraAviso'],
          isAdmin: dados[
              'isAdmin']); //esses campos estão como requeridos na classe Usuario
      //se usuario não for true nas 3 perguntas, ele não participa do chat

      usuario.isAtivo = dados['isAtivo'];

      if (usuario.mostraAviso) mostraTelaAviso = false;

      listUsuarios.add(usuario);
    }
    return listUsuarios;
  }

  //grava as mensagens digitadas pelos usuarios do batepapo
  static Future gravarMensagem(Map map, String idContato, bool isPapo) async {
    String colecao;

    isPapo ? colecao = 'conversas' : colecao = "mensagens";

    if (isPapo) {
      colecao = 'conversas';
      //saving in the userID folder
      await firestore
          .collection(colecao)
          .document(userID)
          .collection('ultima_conversa')
          .document(idContato)
          .setData(map);
      //saving in the IdContato folder
      await firestore
          .collection(colecao)
          .document(idContato)
          .collection('ultima_conversa')
          .document(userID)
          .setData(map);
    } else {
      colecao = 'mensagens';
      //saving in the userID folder
      await firestore
          .collection(colecao)
          .document(userID)
          .collection(idContato)
          .add(map);
      //saving in the IdContato folder
      await firestore
          .collection(colecao)
          .document(idContato)
          .collection(userID)
          .add(map); //todo: add or setdata?

    }
  }

  //recuperar mensagens gravadas ordenadas por data
  static Stream<QuerySnapshot> getMensagens(idContato, _controller) {
    //retorna um snapShot de todas mensagens
    Stream<QuerySnapshot> querySnapshot = firestore
        .collection('mensagens')
        .document(userID)
        .collection(idContato)
        .orderBy('dataMessage')
        .snapshots();

    querySnapshot.listen((dados) {
      _controller.add(dados);
    });

    return querySnapshot;
  }

  //show message like snackbar
  static showFlushbar(BuildContext context, String mensagem) {
    Flushbar(
      message: mensagem,
      backgroundColor: Color(0xff00005a),
      duration: Duration(seconds: 3),
      leftBarIndicatorColor: Color(0xffed1650),
    )..show(context);
  }

  static validate(String tipoTripulacao, String tipoSobreaviso, context) {
    switch (tipoTripulacao) {
      case 'Simples':
        if (!hasDataInicio) {
          showFlushbar(context, 'Preencher a data de início da jornada!');
        } else if (!hasHoraInicio) {
          showFlushbar(context, 'Preencher o horário de início da jornada!');
        } else if (!hasEtapa && !showRotaSafetyCase) {
          showFlushbar(context, 'Escolher n° de etapas!');
        } else if (!hasDataPouso) {
          showFlushbar(context, 'Preencher a data do pouso!');
        } else if (!hasHoraPouso) {
          showFlushbar(context, 'Preencher o horário previsto do pouso!');
        } else {
          isInputDataValidated = true;
        }

        break;
      case 'Composta': //função??? apagar dados
        if (!hasDataInicio) {
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher a data de início da jornada!');
        } else if (!hasHoraInicio) {
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher o horário de início da jornada!');
        } else if (!hasDataPouso) {
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher a data do pouso!');
        } else if (!hasHoraPouso){
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher o horário previsto do pouso!');
        } else if (!hasFuso) {
          isInputDataValidated = false;
          showFlushbar(context, 'Escolher qdade de fusos!');
        } else if (!hasFuncao) {
          isInputDataValidated = false;
          showFlushbar(context, 'Escolher tipo de função!');
        } else if (!hasDataInicio2 && hasVooVolta) {
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher a data de volta da jornada!');
        } else if (!hasHoraInicio2 && hasVooVolta) {
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher o horário de volta da jornada!');
        } else if (!hasDataPouso2 && hasVooVolta) {
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher a data prevista do pouso de volta!');
        } else if (!hasHoraPouso2 && hasVooVolta) {
          isInputDataValidated = false;
          showFlushbar(
              context, 'Preencher o horário previsto do pouso de volta!');
        } else {
          isInputDataValidated = true;
        }

        break;
      case 'Revezamento':
        if (!hasDataInicio) {
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher a data de início da jornada!');
        } else if (!hasHoraInicio) {
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher o horário de início da jornada!');
        } else if (!hasDataPouso) {
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher a data prevista do pouso!');
        } else if (!hasHoraPouso) {
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher o horário previsto do pouso!');
        } else if (!hasFuso) {
          isInputDataValidated = false;
          showFlushbar(context, 'Escolher qdade de fusos!');
        } else if (!hasFuncao) {
          isInputDataValidated = false;
          showFlushbar(context, 'Escolher tipo de função!');
        } else if (!hasDataInicio2 && hasVooVolta) {
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher a data de volta da jornada!');
        } else if (!hasHoraInicio2 && hasVooVolta) {
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher o horário de volta da jornada!');
        } else if (!hasDataPouso2 && hasVooVolta) {
          isInputDataValidated = false;
          showFlushbar(context, 'Preencher a data prevista do pouso de volta!');
        } else if (!hasHoraPouso2 && hasVooVolta) {
          isInputDataValidated = false;
          showFlushbar(
              context, 'Preencher o horário previsto do pouso de volta!');
        } else {
          isInputDataValidated = true;
        }

        break;
      default:
        if (Util.showRotaSafetyCase) {
          if (!hasDataInicio) {
            isInputDataValidated = false;
            showFlushbar(context, 'Preencher a data de início da jornada!');
          } else if (!hasHoraInicio) {
            isInputDataValidated = false;
            showFlushbar(context, 'Preencher o horário de início da jornada!');
          } else {
            isInputDataValidated = true;
          }
        }

      //isInputDataValidated = false;

    }
    if (hasSobreAviso) {
      //isInputDataValidated = true;
    } else {
      showFlushbar(context, 'Acionado no sobreaviso?');
      isInputDataValidated = false;
    }

   /* if (hasFuncao) {//????
      isInputDataValidated = true;
    } else {
      showFlushbar(context, 'Acionado em sobreaviso?');
      isInputDataValidated = false;
    }*/
  }

//color custom
  static Map<int, Color> color = {
    50: Color.fromRGBO(0, 0, 90, .1),
    100: Color.fromRGBO(0, 0, 90, .2),
    200: Color.fromRGBO(0, 0, 90, .3),
    300: Color.fromRGBO(0, 0, 90, .4),
    400: Color.fromRGBO(0, 0, 90, .5),
    500: Color.fromRGBO(0, 0, 90, .6),
    600: Color.fromRGBO(0, 0, 90, .7),
    700: Color.fromRGBO(0, 0, 90, .8),
    800: Color.fromRGBO(0, 0, 90, .9),
    900: Color.fromRGBO(0, 0, 90, 1),
  };
  static MaterialColor colorCustom = MaterialColor(0xFF00005a, color);
}
