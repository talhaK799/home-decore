class FeedBack {
  double? rating;
  String? comment;

  FeedBack({this.rating, this.comment});

  toJson() => {
        'rate': this.rating,
        'comment': this.comment,
      };
}
