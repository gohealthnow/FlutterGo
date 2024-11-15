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

class DiagnosticDataRequest {
  final String title;
  final String description;
  final String score;

  DiagnosticDataRequest({required this.title, required this.description, required this.score});

  factory DiagnosticDataRequest.fromJson(Map<String, dynamic> json) {
    return DiagnosticDataRequest(
      title: json['title'],
      description: json['description'],
      score: json['score'],
    );
  }
}