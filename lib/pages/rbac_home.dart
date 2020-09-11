import 'package:flutter/material.dart';
import 'package:latam/models/jornada.dart';
import 'package:latam/utilitarios/utilitarios.dart';
import 'package:latam/widgets/acionado_reserva.dart';
import 'package:latam/widgets/background_widget.dart';
import 'package:latam/widgets/escolhe_tipo_trip.dart';
import 'package:latam/widgets/menu_bar.dart';
import 'package:latam/widgets/new_sobre_aviso_form.dart';
import 'package:latam/widgets/no_767F_safety_case.dart';
import 'package:latam/widgets/rota_help.dart';
import 'package:latam/widgets/rota_safety_case.dart';
import 'package:latam/widgets/sobre_aviso.dart';
import 'package:latam/widgets/tipo_voo.dart';
import 'package:latam/widgets/tripulacao.dart';
import 'package:latam/widgets/warning.dart';
import 'package:provider/provider.dart';

class RbacHome extends StatefulWidget {
  @override
  _RbacHomeState createState() => _RbacHomeState();
}

class _RbacHomeState extends State<RbacHome> {
  int horaJornada, horaVoo;
  var _equipamentos = [
    'A32F',
    'A350',
    'B767',
    'B767F',
    'B777',
    'Selecione    '
  ];
  var _rota = ['Safety case', 'Demais rotas', 'Selecione'];
  String _currentEquipamento = 'Selecione    ';
  String _currentRota = "Selecione";
  bool _sobreaviso = false;
  bool _reserva = false;

  bool showTripEscolha = false;
  bool showWarning = false;

  List<Jornada> myList = List();

  @override
  void initState() {
    super.initState();
    setState(() {
      // Util.resetarVariaveis();
      Util.showRotaSafetyCase = false;
      _sobreaviso = false;
      _reserva = false;
      showTripEscolha = false;
      showWarning = false;
      util.setSobreaviso(false);
      util.setReserva(false);
      Util.radioValueSobreAviso = -1;
      Util.radioValueReserva = -1;
      showTripEscolha = false;
      Util.hasTipoTripDefined = false;
      Util.no767FSafety = false;
      Util.hasVooVolta = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  what2show(String equipamento, String rota, context) {
    //Util.resetarVariaveis();

    if (_currentEquipamento != 'B767F' &&
        _currentEquipamento != 'Selecione    ' &&
        _currentRota == 'Demais rotas') {
      setState(() {
        Util.radioValueSobreAviso = -1; //reseto o valor do radio
        Util.radioValueReserva = -1;
        Util.hasReserva = false;
        showWarning = false;
        Util.isSobreAviso = false; //apaga o form de sobreaviso
        Util.isReserva = false;
        showTripEscolha = true;
        Util.showLastro = true;
        Util.tripTTonly = false;
        Util.is767FSafety = false;
        Util.showRotaSafetyCase = false;
        Util.no767FSafety = false;
        Util.hasVooVolta = false;
        _sobreaviso = true; //mostra a pergunta sobre sobreaviso
        _reserva = true;
      });
    } else if (_currentEquipamento == 'B767F' &&
        _currentRota == 'Demais rotas') {
      setState(() {
        Util.radioValueSobreAviso = -1; //reseto o valor do radio
        Util.radioValueReserva = -1;
        _sobreaviso = true;
        Util.hasReserva = false;
        Util.isSobreAviso = false; //apaga o form de sobreaviso
        //Util.isReserva = false;
        showTripEscolha = true;
        Util.showRotaSafetyCase = false;
        Util.showLastro = true;
        showWarning = false;
        Util.tripTTonly = true;
        Util.no767FSafety = false;
        Util.hasVooVolta = false;
      });
    } else if (_currentEquipamento == 'B767F' &&
        _currentRota == 'Safety case') {
      //mostrar rota
      setState(() {
        Util.radioValueSobreAviso = -1; //reseto o valor do radio
        Util.radioValueReserva = -1;
        Util.showRotaSafetyCase = false;
        _sobreaviso = false;
        _reserva = false;
        Util.hasReserva = false;
        Util.isSobreAviso = false; //apaga o form de sobreaviso
        Util.isReserva = false;
        showTripEscolha = false;
        Util.is767FSafety = false;
        showWarning = true;
        Util.hasTipoTripDefined = false;
        Util.showLastro = false;
        Util.no767FSafety = false;
        Util.hasVooVolta = false;
      });
    } else if (_currentEquipamento != 'B767F' &&
        _currentEquipamento != 'Selecione    ' &&
        _currentRota == 'Safety case') {
      setState(() {
        Util.radioValueSobreAviso = -1; //reseto o valor do radio
        Util.radioValueReserva = -1;
        _sobreaviso = true;
        _reserva = true;
        Util.showRotaSafetyCase = true;
        Util.showLastro = false;
        Util.hasReserva = false;
        Util.isReserva = false;
        Util.isSobreAviso = false; //apaga o form de sobreaviso
        showTripEscolha = false;
        Util.is767FSafety = false;
        showWarning = false;
        Util.no767FSafety = true;
        Util.hasTipoTripDefined = false;
        Util.hasVooVolta = false;
      });
    } else if (_currentEquipamento == 'Selecione    ' ||
        _currentRota == 'Selecione') {
      setState(() {
        Util.radioValueSobreAviso = -1; //reseto o valor do radio
        Util.radioValueReserva = -1;
        Util.showRotaSafetyCase = false;
        _sobreaviso = false;
        _reserva = false;
        Util.hasReserva = false;
        Util.isReserva = false;
        Util.isSobreAviso = false; //apaga o form de sobreaviso
        Util.tripTTonly = false;
        showTripEscolha = false;
        showWarning = false;
        util.setSobreaviso(false);
        util.setReserva(false);
        Util.is767FSafety = false;
        showTripEscolha = false;
        Util.hasTipoTripDefined = false;
        Util.no767FSafety = false;
        Util.hasVooVolta = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Calcular Jornada',
        ),
        actions: <Widget>[
          IconButton(
              icon: const Icon(
                Icons.backspace,
                color: Colors.white,
              ),
              onPressed: () {
                resetPage(context);
              })
        ],
        backgroundColor: const Color(0xff00005a),
        centerTitle: true,
      ),
      drawer: MenuBar(
        isAdmin: false,
        context: context,
      ),
      body: BackgroundWidget(
        child: ChangeNotifierProvider<Util>(
          create: (_) => Util(),
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: Consumer<Util>(
                  builder: (context, util, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text(
                                  "Equipamento:",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xffed1650),
                                  ),
                                ),
                                DropdownButton<String>(
                                  items: _equipamentos
                                      .map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Text(
                                          dropDownStringItem,
                                          style: const TextStyle(
                                              color: const Color(0xff858585),
                                              fontSize: 20),
                                        ));
                                  }).toList(),
                                  icon: const Icon(
                                    Icons.airplanemode_active,
                                    size: 30,
                                  ),
                                  onTap: () {
                                      Util.showRotaSafetyCase = false;
                                      _sobreaviso = false;
                                      _reserva = false;
                                      Util.isReserva = false;
                                      Util.hasReserva = false;
                                      Util.isSobreAviso =
                                          false; //apaga o form de sobreaviso
                                      Util.tripTTonly = false;
                                      showTripEscolha = false;
                                      showWarning = false;
                                      util.setSobreaviso(false);
                                      util.setReserva(false);
                                      Util.is767FSafety = false;
                                      showTripEscolha = false;
                                      Util.hasTipoTripDefined = false;
                                      Util.no767FSafety = false;
                                      Util.hasVooVolta = false;
                                      Util.resetarVariaveis();
                                    },
                                  onChanged: (String newSelectedEquipamento) {
                                    setState(() {
                                      _currentEquipamento =
                                          newSelectedEquipamento;
                                      Util.equipamento = _currentEquipamento;
                                      //Util.resetarVariaveis();
                                      // resetPage(context);
                                      what2show(_currentEquipamento,
                                          _currentRota, context);
                                      print(Util.isSobreAviso);
                                    });
                                  },
                                  value: _currentEquipamento,
                                ),
                              ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                        ),
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Rota:",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xffed1650),
                                          ),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              Util.gotoScreen(
                                                  RotaHelp(), context);
                                            },
                                            child: Image.asset(
                                              'assets/images/info.png',
                                              height: 40,
                                            )),
                                      ],
                                    ),
                                  ),
                                  DropdownButton<String>(
                                    items:
                                        _rota.map((String dropDownStringItem) {
                                      return DropdownMenuItem<String>(
                                          value: dropDownStringItem,
                                          child: Text(
                                            dropDownStringItem,
                                            style: const TextStyle(
                                                color: Color(0xff858585),
                                                fontSize: 20),
                                          ));
                                    }).toList(),
                                    onTap: () {
                                      Util.showRotaSafetyCase = false;
                                      _sobreaviso = false;
                                      _reserva = false;
                                      Util.isReserva = false;
                                      Util.hasReserva = false;
                                      Util.isSobreAviso =
                                          false; //apaga o form de sobreaviso
                                      Util.tripTTonly = false;
                                      showTripEscolha = false;
                                      showWarning = false;
                                      util.setSobreaviso(false);
                                      util.setReserva(false);
                                      Util.is767FSafety = false;
                                      showTripEscolha = false;
                                      Util.hasTipoTripDefined = false;
                                      Util.no767FSafety = false;
                                      Util.hasVooVolta = false;
                                      Util.resetarVariaveis();
                                    },
                                    onChanged: (String newSelectedRota) {
                                      setState(() {
                                        _currentRota = newSelectedRota;
                                        if (_currentRota == 'Safety case') {
                                          Util.safetyCase = '1';
                                        } else if (_currentRota ==
                                            'Demais rotas') {
                                          Util.safetyCase = '0';
                                        }
                                        what2show(_currentEquipamento,
                                            _currentRota, context);
                                        print(Util.isSobreAviso);
                                      });
                                    },
                                    value: _currentRota,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      showWarning ? WarningSafetyCase() : Container(),

                      _sobreaviso ? SobreAviso() : Container(),
                      //de acordo com a seleção anterior, mostra sobreaviso form
                      //util.isSobreAviso ? SobreAvisoForm() : Container(),
                      Util.isSobreAviso ? NewSobreAviso() : Container(),
                      _reserva ? Reserva() : Container(),

                      //mostrar rota safetyCase?
                      Util.showRotaSafetyCase ? RotaSafetyCase() : Container(),
                      Util.no767FSafety ? No767FSafetyCase() : Container(),
                      showTripEscolha ? TipoVoo() : Container(),
                      showTripEscolha ? TipoTripulacao() : Container(),

                      Util.hasTipoTripDefined
                          ? EscolheTipoTrip(
                              tipo: Util.tipoTripulacao,
                            )
                          : Container(),
                      /*  Divider(
              height: 5,
              color: Colors.greenAccent,
            ), */
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void resetPage(BuildContext context) {
    return setState(() {
      Util.gotoScreen(RbacHome(), context); //reinicia a propria pagina
      Util.resetarDataHora();
      Util.resetarVariaveis(); //reseta as variaveis ao estado inicial
    });
  }
}
