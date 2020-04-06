class Acesso {
  String email;
  int installed;

  Acesso({this.email,this.installed});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"email": this.email,'installed':this.installed,};

    return map;
  }
}
