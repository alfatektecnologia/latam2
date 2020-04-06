import 'package:flutter/material.dart';

class Usuario {
  //não usar para funcionarios

  String email;
  String id;
  bool mostraAviso;
  bool isAdmin;
  bool isAtivo;

  Usuario({
    @required this.email,
    @required this.id,
    @required this.isAdmin,
    this.mostraAviso,
    this.isAtivo = true,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "email": this.email,
      "id": this.id,
      "isAdmin": this.isAdmin,
      'mostraAviso':this.mostraAviso,
      'isAtivo': this.isAtivo,
    };
    return map;
  }
}
