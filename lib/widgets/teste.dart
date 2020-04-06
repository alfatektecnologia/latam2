import 'package:flutter/material.dart';
import 'package:latam/models/jornada.dart';

class TesteCard extends StatefulWidget {
  @override
  _TesteCardState createState() => _TesteCardState();
}

class _TesteCardState extends State<TesteCard> {
  int horaJornada, horaVoo;
  var _equipamentos = ['A32F', 'A350', 'B767', 'B767F', 'B777', 'Selecione...'];
  var _rota = ['Safety case', 'Demais rotas', 'Selecione'];
  String _currentEquipamento = 'Selecione...';
  String _currentRota = "Selecione";
  bool sobreaviso = false;
  bool showRotaSafetyCase = false;
  bool showTripEscolha = false;
  bool showWarning = false;

  List<Jornada> myList = List();


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
               Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(children: <Widget>[
                          Text(
                            "Equipamento:",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xffed1650),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 64.0),
                            child: Text(
                              "Rota:",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xffed1650),
                              ),
                            ),
                          ),
                          IconButton(icon: Icon(Icons.help,color: Color(0xff00005a),), onPressed: () {})
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
//seleção do equipamento==============================================================================
                              DropdownButton<String>(
                                items: _equipamentos
                                    .map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(
                                        dropDownStringItem,
                                        style: TextStyle(
                                            color: Color(0xff858585),
                                            fontSize: 20),
                                      ));
                                }).toList(),
                                icon: Icon(
                                  Icons.airplanemode_active,
                                  size: 30,
                                ),
                                onChanged: (String newSelectedEquipamento) {
                                  setState(() {
                                    _currentEquipamento = newSelectedEquipamento;
                                    if (_currentEquipamento != 'B767F' &&
                                        _currentRota == 'Demais rotas') {
                                      sobreaviso =
                                          true; //mostra a pergunta sobre sobreaviso

                                      showTripEscolha = true;
                                      showRotaSafetyCase = false;
                                    } else if (_currentEquipamento == 'B767F' &&
                                        _currentRota == 'Demais rotas') {
                                      sobreaviso = true;
                                      showTripEscolha = true;
                                    } else if (_currentEquipamento == 'B767F' &&
                                        _currentRota != 'Demais rotas') {
                                      //mostrar warning
                                      //mostrar sobreaviso
                                      showTripEscolha = true;
                                      showWarning = true;
                                      sobreaviso = true;
                                    } else if (_currentEquipamento == 'B767F' &&
                                        _currentRota == 'Safety case') {
                                      //mostrar rota safetyCase
                                      showRotaSafetyCase = true;
                                      sobreaviso = false;
                                      showTripEscolha = false;
                                      showWarning = false;
                                    } else if (_currentEquipamento != 'B767F' &&
                                        _currentRota == 'Safety case') {
                                      showRotaSafetyCase = true;
                                      sobreaviso = false;
                                      showTripEscolha = false;
                                    }
                                  });
                                },
                                value: _currentEquipamento,
                              ),
//seleção da rota==============================================================================
                              DropdownButton<String>(
                                items: _rota.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Text(
                                        dropDownStringItem,
                                        style: TextStyle(
                                            color: Color(0xff858585),
                                            fontSize: 20),
                                      ));
                                }).toList(),
                                onChanged: (String newSelectedRota) {
                                  setState(() {
                                    _currentRota = newSelectedRota;
                                    //
                                    if (_currentEquipamento != 'B767F' &&
                                        _currentRota == 'Demais rotas') {
                                      sobreaviso =
                                          true; //mostra a pergunta sobre sobreaviso

                                      showTripEscolha = true;
                                      showRotaSafetyCase = false;
                                    } else if (_currentEquipamento == 'B767F' &&
                                        _currentRota == 'Demais rotas') {
                                      sobreaviso = true;
                                      showTripEscolha = true;
                                    } else if (_currentEquipamento == 'B767F' &&
                                        _currentRota != 'Demais rotas') {
                                      //mostrar warning
                                      //mostrar sobreaviso
                                      showTripEscolha = true;
                                      showWarning = true;
                                      sobreaviso = true;
                                    } else if (_currentEquipamento == 'B767F' &&
                                        _currentRota == 'Safety case') {
                                      //mostrar rota safetyCase
                                      showRotaSafetyCase = true;
                                      sobreaviso = false;
                                      showTripEscolha = false;
                                      showWarning = false;
                                    } else if (_currentEquipamento != 'B767F' &&
                                        _currentRota == 'Safety case') {
                                      showRotaSafetyCase = true;
                                      sobreaviso = false;
                                      showTripEscolha = false;
                                    }
                                  });
                                },
                                value: _currentRota,
                              ),
                            ]),
                      ),

          ],


        ),
      ),
      
    );
  }
}