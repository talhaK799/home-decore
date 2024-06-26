import 'dart:io';

Future<bool> checkInternetConnectivity() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      return true;
    }
    return true;
  } on SocketException catch (_) {
    print('not connected');
    return false;
  }
}
