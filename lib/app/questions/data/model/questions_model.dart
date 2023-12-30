class QuestionModel {
  Simuladoquest? simuladoquest;

  QuestionModel({this.simuladoquest});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    simuladoquest = json['simuladoquest'] != null
        ? Simuladoquest.fromJson(json['simuladoquest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (simuladoquest != null) {
      data['simuladoquest'] = simuladoquest!.toJson();
    }
    return data;
  }

  static List<QuestionModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => QuestionModel.fromJson(item)).toList();
  }
}

class Simuladoquest {
  String? title;
  List<Respostas>? respostas;

  Simuladoquest({this.title, this.respostas});

  Simuladoquest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['respostas'] != null) {
      respostas = <Respostas>[];
      json['respostas'].forEach((v) {
        respostas!.add(Respostas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (respostas != null) {
      data['respostas'] = respostas!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Respostas {
  bool? correta;
  String? texto;

  Respostas({this.correta, this.texto});

  Respostas.fromJson(Map<String, dynamic> json) {
    correta = json['correta'];
    texto = json['texto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['correta'] = correta;
    data['texto'] = texto;
    return data;
  }
}
