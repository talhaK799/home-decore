class HelpLine {
  String? number;
  String? id;
  HelpLine({this.number, this.id});

  HelpLine.fromJson(json, this.id) {
    this.number = json['number'] ?? '+8801309007585';
  }
}
