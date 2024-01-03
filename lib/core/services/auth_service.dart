import 'package:f2_base_project/core/models/app_user.dart';
import 'package:f2_base_project/core/models/categories.dart';
import 'package:f2_base_project/core/models/custom_auth_result.dart';
import 'package:f2_base_project/core/models/helpline.dart';
import 'package:f2_base_project/core/models/offers.dart';
import 'package:f2_base_project/core/models/order.dart';
import 'package:f2_base_project/core/models/products.dart';
import 'package:f2_base_project/ui/dialogs/request_failed_dialog.dart';
import 'package:f2_base_project/ui/screens/auth_signup/otp/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_exception_service.dart';
import 'database_service.dart';
import 'package:firebase_auth/firebase_auth.dart' as fba;

class AuthService extends ChangeNotifier {
  final _dbService = DatabaseService();
  final _auth = FirebaseAuth.instance;
  CustomAuthResult customAuthResult = CustomAuthResult();
  User? user;
  bool isLogin = false;
  AppUser appUser = AppUser();
  // final _facebookSignIn = FacebookAuth.instance;
  List<Categories> categories = [];
  String fbaPhoneVerificationId = '';
  bool isPhoneVerified = false;
  List<Product> latestProducts = [];
  List<Product> allProducts = [];
  List<Product> topRatedProducts = [];
  List<String> banners = [];
  List<Offers> offers = [];
  List<Orders> cartProducts = [];
  List<AppUser> appUsers = [];
  Orders order = Orders();
  HelpLine helpline = HelpLine();
  GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthService() {
    init();
  }
  init() async {
    user = _auth.currentUser;
    if (user != null) {
      isLogin = true;
      appUser = (await _dbService.getAppUser(user!.uid));
      if (appUser.id == null) {
        await logout();
      } else {
        await getCartProducts();
      }
    } else {
      isLogin = false;
    }
  }

  getCartProducts() async {
    if (appUser.id != null) {
      Orders? order = await _dbService.getCartProducts(appUser.id!);
      if (order != null) {
        this.order = order;
      }
    }
  }

  // signupWithFacebook() async {
  //   //Todo: Do settings in the Google cloud for 0Auth Credentials
  //   try {
  //     final LoginResult result = await _facebookSignIn.login();
  //     print('Facebook login => ${result.message}');
  //     if (result.status == LoginStatus.success) {
  //       print('Facebook login result success');
  //       final AccessToken accessToken = result.accessToken!;
  //       print("AccessToken::FaceAuth => ${accessToken.token}");
  //       final firebaseAuthCred =
  //           FacebookAuthProvider.credential(accessToken.token);
  //       final loginResult =
  //           await FirebaseAuth.instance.signInWithCredential(firebaseAuthCred);
  //       final userData = await FacebookAuth.instance.getUserData();
  //       this.appUser = AppUser();

  //       /// Get user data
  //       appUser.id = loginResult.user!.uid;
  //       appUser.name = userData['name'];
  //       appUser.email = userData['email'];
  //       appUser.imageUrl = userData['picture']['data']['url'];
  //       print('facebookUserImageUrl => ${userData['picture']['data']['url']}');
  //       print('facebook login => ${appUser.name}');
  //       customAuthResult.status = true;
  //       customAuthResult.user = appUser;
  //       isLogin = true;
  //       bool isUserExist = await _dbService.checkUser(appUser);
  //       if (isUserExist) {
  //         appUser = await _dbService.getAppUser(appUser.id);
  //       } else {
  //         await _dbService.registerAppUser(appUser);
  //       }

  //       // Todo: Create Account in Database
  //     } else {
  //       customAuthResult.status = false;
  //       customAuthResult.errorMessage = 'An undefined error happened.';
  //     }
  //   } catch (e) {
  //     print('Exception @sighupWithFacebook: $e');
  //     customAuthResult.status = false;
  //     // customAuthResult.errorMessage =
  //     //     AuthExceptionsService.generateExceptionMessage(e);
  //   }
  //   return customAuthResult;
  // }

  ///
  /// Google SignIn
  ///
  Future<CustomAuthResult> loginWithGoogle() async {
    //Todo: Do settings in the Google cloud for 0Auth Credentials
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);
      print('register user => ${authResult.user!.uid}');

      if (authResult.user!.uid != null) {
        customAuthResult.status = true;
        appUser = AppUser();
        customAuthResult.user = authResult.user;
        appUser.id = authResult.user!.uid;
        appUser.email = authResult.user!.email;
        appUser.name = authResult.user!.displayName ?? '';
        print('Google sign in AppUser username => ${appUser.name}');
        isLogin = true;
        bool isUserExist = await _dbService.checkUser(appUser);
        if (isUserExist) {
          final newToken = await FirebaseMessaging.instance.getToken();
          await _dbService.updateUserFcm(newToken, appUser.id);
          appUser = await _dbService.getAppUser(appUser.id);
        } else {
          final newToken = await FirebaseMessaging.instance.getToken();
          appUser.fcmToken = newToken;
          await _dbService.registerAppUser(appUser);
        }

        //Todo: Create Account in Database
      } else {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined error happened.';
      }
    } catch (e) {
      print('Exception @sighupWithGoogle: $e');
      customAuthResult.status = false;
      // customAuthResult.errorMessage =
      //     AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  /// [SignUp] with email and password function
  ///
  Future<CustomAuthResult> signUpWithEmailPassword(AppUser appUser) async {
    debugPrint('@services/singUpWithEmailPassword');
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: appUser.email!, password: appUser.password!);

      /// If user signup fails without any exception and error code
      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
        return customAuthResult;
      }

      if (credentials.user != null) {
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
        appUser.id = credentials.user!.uid;

        final newToken = await FirebaseMessaging.instance.getToken();
        appUser.fcmToken = newToken;
        this.appUser = appUser;

        await _dbService.registerAppUser(appUser);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Exception @sighupWithEmailPassword: $e');
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  /// [Login] with email and password function
  ///
  Future<CustomAuthResult> loginWithEmailPassword({email, password}) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print('credentiallllssss  ...............$credentials');
      if (credentials.user == null) {
        customAuthResult.status = false;
        customAuthResult.errorMessage = 'An undefined Error happened.';
      }

      ///
      /// If firebase auth is successful:
      ///
      if (credentials.user != null) {
        this.appUser = await _dbService.getAppUser(credentials.user!.uid);
        final newToken = await FirebaseMessaging.instance.getToken();
        await _dbService.updateUserFcm(newToken, this.appUser.id);
        customAuthResult.status = true;
        customAuthResult.user = credentials.user;
      }
    } catch (e) {
      customAuthResult.status = false;
      customAuthResult.errorMessage =
          AuthExceptionsService.generateExceptionMessage(e);
    }
    return customAuthResult;
  }

  ///
  ///
  ///
  ///This function will send otp to the user input phone Number
  ///
  ///
  ///
  Future<void> sendCodeToPhone({required phoneNumber}) async {
    print("@sendOTPtoPhoneNumber========>$phoneNumber");
    fbaPhoneVerificationId = '';

    final fba.PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {};
    final fba.PhoneCodeSent smsCodeSent = (String verId, int? forceCodeResent) {
      print('**************@sendingVerificationCodeSent*********');
      Get.to(() => EnterOtpScreen());
      fbaPhoneVerificationId = verId;
    };
    final fba.PhoneVerificationCompleted _verifiedSuccess =
        (fba.AuthCredential auth) async {
      appUser.mobileNo = phoneNumber;
      print('**************@sendingVerificationCodeSuccess*********');
      Get.to(() => EnterOtpScreen());
    };
    final fba.PhoneVerificationFailed _verifyFailed =
        (fba.FirebaseAuthException e) {
      print(
          "Firebase Exception -============>OTP verification ====>${e.message}");

      Get.to(RequestFailedDialog(errorMessage: e.message));
    };
    print('**************sendingVerificationCodeSuccess*********');
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 30),
      verificationCompleted: _verifiedSuccess,
      verificationFailed: _verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

////
  ///This function will verify the phone
  ///
  Future<void> verifyPhone(String smsCode, phoneNo) async {
    print("@verifyPhoneNumber====>$smsCode");
    try {
      final fba.AuthCredential credential = fba.PhoneAuthProvider.credential(
          verificationId: fbaPhoneVerificationId, smsCode: smsCode);
      final credentials =
          await fba.FirebaseAuth.instance.signInWithCredential(credential);
      print('credentialID => ${credentials.user!.uid}');
      appUser.id = credentials.user!.uid;
      appUser.mobileNo = phoneNo;
      final newToken = await FirebaseMessaging.instance.getToken();
      appUser.fcmToken = newToken;
      await _dbService.registerAppUser(appUser);
      isPhoneVerified = true;
    } catch (e) {
      isPhoneVerified = false;
      Get.dialog(RequestFailedDialog(errorMessage: e.toString()));
    }
  }

  Future<void> logout({id}) async {
    this.appUser.fcmToken = null;
    await _dbService.updateUserFcm(this.appUser.fcmToken, this.appUser.id);
    await _auth.signOut();
    this.appUser = AppUser();
    this.isLogin = false;
    this.user = null;
  }
}
