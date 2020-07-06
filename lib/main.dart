import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:latam/pages/login.dart';
import 'package:latam/pages/rbac_home.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:latam/widgets/alerta.dart';

import 'package:provider/provider.dart';

void main() async {
  /* Error -32601 received from application: Method not found
  * esse erro acontece quando o main() tem um processo async
  * e não é executado corretamente.
  * esse comando resolve o problema: WidgetsFlutterBinding.ensureInitialized();*/

  WidgetsFlutterBinding.ensureInitialized();

  //hive
  //final appDocumentDirectory =
  //  await path_provider.getApplicationDocumentsDirectory();

  //Hive.init(appDocumentDirectory.path);

  var resultFromGetUser = await Util.getCurrentUserStatus();

  /*fixar a orientação em modo portrait */
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp(resultFromGetUser));
  });

  //final latam_hive = await Hive.openBox('latam');
}

class MyApp extends StatefulWidget {
  final Map usuario;

  MyApp(this.usuario);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<int, Color> color = {
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

  var initialPage; //defines initial page to home:
  @override
  void initState() {
    super.initState();
    initialPage = checaUser();
  }

  @override
  Widget build(BuildContext context) {
    //final latamBox = Hive.box('latam');
    MaterialColor colorCustom = MaterialColor(0xFF00005a, color);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Util>(
          create: (_) => Util(),
        ),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('pt'),
        ],

        debugShowCheckedModeBanner: false,
        title: 'Latam',
       
        theme: ThemeData(
          // Define the default brightness and colors.
         
          primarySwatch:colorCustom,
          primaryColor: Color(0xff00005a),
          primaryColorDark: Color(0xff00005a),
          primaryColorLight: Color(0xff5831b9),
         
          primaryTextTheme:TextTheme(),
          accentColor: Color(0xffed1650),
          
          cupertinoOverrideTheme:CupertinoThemeData(
            primaryColor: Color(0xff00005a),
            textTheme:CupertinoTextThemeData(
              textStyle:TextStyle(
                fontFamily: 'TREBUC',
                //color: Color(0xff00ffff)
              ),
            ),
          ),
          

          // Define the default font family.
          fontFamily: 'TREBUC',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'TREBUC',color:Colors.yellowAccent),
           
            headline5: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold,),
            headline6: TextStyle(fontSize: 26.0, fontStyle: FontStyle.italic),
            bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'TREBUC', color:Color(0xff858585)),
            //subhead:TextStyle(fontSize: 14.0, fontFamily: 'TREBUC',color:Colors.yellowAccent),
            
          ),
        ),

        home: initialPage, //checa user
        //home: Login(),
      ),
    );
  }

  Widget checaUser() {
    //if user is Admin must login
    Widget result = Login(
        widget.usuario); //seta como default a pagina de login para user admin
    if (widget.usuario['user'] != null) {
      //checa se existe usuario autenticado
      if (!widget.usuario['admin']) {
        Util.mostraTelaAviso
            ? result = Alerta()
            : result = RbacHome(); // RbacHome(); //HomePage();
        return result;
      }
    } else {
      result = Login(widget.usuario);
      return result;
    }
    return result;
  }
}
