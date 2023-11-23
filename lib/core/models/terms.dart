class Terms {
  String? terms;
  Terms({
    this.terms,
  });

  Terms.fromJson(json) {
    terms = json['terms'];
  }
}