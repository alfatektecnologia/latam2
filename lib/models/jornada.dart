class Jornada {
  var jornadaMaxima;
  var tempoVoo;

  Jornada({this.jornadaMaxima, this.tempoVoo});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "jornada": this.jornadaMaxima,
      "voo": this.tempoVoo,
    };
    return map;
  }
}
