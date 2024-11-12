class SymptomsDataRequest {
  List<String>? sintomas;

  SymptomsDataRequest({this.sintomas});

  SymptomsDataRequest.fromJson(Map<String, dynamic> json) {
    sintomas = json['sintomas'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sintomas'] = this.sintomas;
    return data;
  }
}
