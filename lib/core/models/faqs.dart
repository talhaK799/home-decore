class Faqs {
  String? id;
  String? queston;
  String? answer;
  DateTime? createdAt;

  Faqs({
    this.id,
    this.queston,
    this.answer,
    this.createdAt,
  });

  Faqs.formJson(json, this.id) {
    queston = json['question'];
    answer = json['answer'];
    createdAt = json['createdAt'].toDate() ?? DateTime.now();
  }

  toJson() {
    return {
      'question': queston,
      'answer': answer,
      'createdAt': createdAt,
    };
  }
}
