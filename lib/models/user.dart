class  Auser {
  String _name;
  String _username;
  String _password;
  String _flaglogged;

  Auser(
    this._name,
    this._username,
    this._password,
    this._flaglogged,
  );

  Auser.map(dynamic obj) {
    this._name = obj['name'];
    this._username = obj['username'];
    this._password = obj['password'];
    this._flaglogged = obj['password'];
  }

  String get name => _name;
  String get username => _username;
  String get password => _password;
  String get flaglogged => _flaglogged;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["username"] = _username;
    map["password"] = _password;
    map["flaglogged"] = _flaglogged;

    return map;
  }
}
