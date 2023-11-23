class Fcm {
  String? fcmToken;
  String? deviceId;

  Fcm({
    this.fcmToken,
    this.deviceId,
  });

  toJson() => {
        'fcm_token': this.fcmToken,
        'device_id': this.deviceId,
      };
}
