// criaremos uma classe para manipular os dados json

class Dados {
  String ra;
  String data;
  String lat;
  String log;

  Dados(this.ra, this.data, this.lat, this.log);

  // metodos para json
  // toJson e fromJson

  Map toJson() => {'ra': ra, 'data': data, 'lat': lat, 'log': log};

  factory Dados.fromJson(dynamic json) {
    if (json['lat'] == null) json['lat'] = '';
    if (json['log'] == null) json['log'] = '';
    return Dados(json['ra'], json['data'], json['lat'], json['log']);
  }

  @override
  String toString() {
    return '{${this.ra},${this.data},${this.lat},${this.log}}';
  }
}
