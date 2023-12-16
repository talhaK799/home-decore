class ContactUs{
  String? title;
  String? message;
  String? user_id;
  DateTime? createdAt;


  ContactUs({this.createdAt, this.message, this.title, this.user_id});



  toJson(){
    return {
      "title": this.title,
      "message": this.message,
      "createdAt": this.createdAt,
      "user_id": this.user_id,
    };
  }
}
