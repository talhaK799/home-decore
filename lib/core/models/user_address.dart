class UserAddress {
  String? addressId;
  String? userId;
  String? name;
  String? countryCode;
  String? phone;
  String? country;
  String? city = 'Dhaka';
  String? address;
  String? postalCode;
  DateTime? createdAt;

  UserAddress({
    this.addressId,
    this.userId,
    this.name,
    this.countryCode = '+88',
    this.phone,
    this.country = 'Bangladesh',
    this.city,
    this.address,
    this.postalCode,
    this.createdAt,
  });

  toJson() => {
        'id': this.addressId,
        'user_id': this.userId,
        'name': this.name,
        'country_code': this.countryCode,
        'phone': this.phone,
        'country': this.country,
        'city': this.city,
        'address': this.address,
        'postal_code': this.postalCode,
        'created_at': this.createdAt,
      };

  UserAddress.fromJson(json, this.addressId) {
    try {
      this.userId = json['user_id'];
      this.name = json['name'];
      this.countryCode = json['country_code'];
      this.phone = json['phone'];
      this.country = json['country'];
      this.city = json['city'];
      this.address = json['address'];
      this.postalCode = json['postal_code'];
      this.createdAt =
          json['created_at'] != null ? json['created_at'].toDate() : null;
    } catch (e, s) {
      print('Exception @productCart.fromJson: $e');
      print('$s');
    }
  }
}
