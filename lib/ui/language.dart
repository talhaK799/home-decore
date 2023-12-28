import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          ///
          /// intial Screen
          ///
          'onbordingTitle': 'Find your spouse with \nCalaf',
          'onbordingDescription':
              'Users are going through a vetting process to ensure that they never \nmatch with bots.',
          'crtAccount': 'Create an account',
          'signIn': 'Sign In',

          ///
          /// Sign Up Screen
          ///
          'signUp': 'Sign Up',
          'signUpEmailPassword': 'Sign Up with Email and Password',
          'signupGoogle': 'Sign up with Google',
          'signupFbk': 'Sign up with Facebook',

          'orSignUpWith': 'or Sign Up with',
          'signUpPolicy': 'By continuing, you agree with to our ',
          'terms': 'Terms',
          'and': ' and ',
          'privacyPolicy': ' Privacy Policy',
          'signUpEmail': 'Sign up with Email',
          'alrdyAccount': 'Already have an Account? ',

          ///
          ///
          "vaildEmail": "Please Enter a Valid Email",
          'signupApple': 'Sign up with Apple',
          "enterPassword": "Please enter your password",
          "password_must_8_characters": "Password must include 8 characters",
          "password_does_not_matched": "Password does not matched",
          "enter_phone_number": "Enter Phone Number",
          "phone_number": "Phone number",
          "seconds": "Seconds",
          "please_enter_OTP": "Please enter OTP",
          "please_enter_valid_OTP": "Please enter valid OTP",
          "invalid_OTP": "Invalid OTP",

          ///
          /// Sign Up with Email and Password
          ///
          'email': 'Email',
          'password': 'Password',
          'confmPasword': 'Confirm Password',
          'signInwithEmailAndPaswrd': 'Sign In with your email and password',
          'dnotHaveAnAccount': 'Don’t have an Account? ',
          'signInWithIn': 'or Sign In with',

          ///
          /// Email OTP Verification
          ///
          'entrOTP': 'Enter the OTP send to',
          'verifyCode': 'Verification Code',
          'dnotRecieveCode': 'Don’t recive code? ',
          'sendAgein': "Send Again",
          'confirm': 'Confirm',
          "orSignInWith": "or Sign In With",

          ///
          /// Phone OTP Verification
          ///
          'cmuntySafe': 'Lets keep our community safe',
          'calfConfirmPhNo':
              'Please help keep Calaf Space by confirming your phone number',
          'phNoOTP': 'OTP will sent to your phone',
          'cnfmPhNo': 'confirm phone number',

          ///
          /// welcome screen
          ///
          'wlcmCalaf': 'Welcome to calaf',
          'crtProfile': 'Let’s create your profile',
          'buildProfile':
              'Let’s build your profile so we can start showing you to other great muslims signles!',
          'tellYourSelf':
              'Tell us about youself and inshahallah we will show you great muslims nearby',
          'createProfile': 'Create profile',

          ///
          /// Name Photo Screen
          ///
          'introYourSelf': 'Introduce yourself',
          'userName': 'Name',
          'buttonContinue': 'Continue',
          'save': 'Save',
          "name": "Name",

          ///
          /// D-O-B
          ///
          'whrBorn': 'When were you born ?',
          'youare': 'You are ',
          'yearOld': 'years old',

          ///
          /// gender
          ///
          'whtsYurGnder': 'What’s you gender ?',
          'whereLive': 'Where do you live ?',
          'city': 'City',
          'stateProvince': 'State / Province',
          'country': 'Country',

          ///
          /// Proffesion
          ///
          'whtsYurProfession': 'What is your profession ?',
          'searchHere': 'Search here',
          'chef': 'Chef',
          'farmer': 'Farmer',
          'acountant': 'Accountant',
          'profession': 'Profession',

          ///
          /// education screen
          ///
          'yrEducation': 'What’s your education ?',
          'schol': 'High school',
          'diploma': 'Diploma',
          'bchlrDegree': 'Bachelor Degree',
          'mastrDegre': 'Masters degree',
          'decorate': 'Doctorate',
          'other': 'Other',
          'edu_car': 'Education and Career',

          ///
          /// marital status screen
          ///
          'mtrlStatus': 'Whats your marital status ?',
          'neverMarried': 'Never married',
          'divorce': 'Divorced',
          'widow': 'Widow',
          'married': 'Married',

          ///
          /// childern screen
          ///
          'doHaveChildren': 'Do you have childern ?',
          'yes': 'Yes',
          'no': 'No',
          'whatYrHeight': 'Whats your height ?',

          ///
          /// body Type Screen
          ///
          'whatYrBodyType': 'Whats your body type ?',
          'slim': 'Slim ',
          'normal': 'Normal',
          'atheletic': 'Atheletic',
          'bodybuilder': 'Bodybuilder',
          'chubby': 'Chubby',
          'bt': 'Body type',

          /// height

          'what_your_height': 'Whats your height?',
          'select_height': 'Select height ',
          "cm": " Cm",

          ///
          /// personality screen
          ///
          'whatYrPersonality': 'Whats your personality ?',
          'shy': 'Shy',
          'social': 'Social',
          'funny': 'Funny',
          'caring': 'Caring',
          'sensitive': 'Sensitive',
          'outgoing': 'Outgoing',
          'personality': 'Personality',

          ///
          /// interest screen
          ///
          'whtsYrInterest': 'What are your interests ?',
          'art': 'Art',
          'racing': 'Racing',
          'cooking': 'Cooking',
          'traveling': 'Traveling',
          'boating': 'Boating',
          'swimming': 'Swimming',
          'photography': 'Photography',
          'videoGames': 'Video games',
          'interests': 'Interests',

          ///
          /// All Successfull messages
          ///
          'profUpdateSucessfully': 'Profile Updated Successfully',
          'otpSendEmail': 'OTP Will send to your gmail',

          ///
          /// Notification screen
          ///
          'notification': 'Notification',
          'notificationFound': 'Notification not found',

          ///
          ///  Filter screen
          ///
          'ageRange': 'Age range',
          'height': 'Height',

          ///
          /// Matches Screen
          ///
          'matches': 'Matches',
          'likeMatchesPeple': 'People who have liked you and your matches.',
          'matched': 'Matched',
          'pending': 'Pending',
          'matchNotFound': 'Matches not found',
          'reqstNotFound': 'Request not found',

          ///
          /// Messages screen
          ///
          'Messages': 'Messages',
          'conversationFound': 'Conversation not found',
          'youmatch': 'You Matched',
          'writMsg': 'Write a message',

          ///
          /// Setting Screen
          ///
          'setting': 'Settings',
          'payment': 'Payment',
          'PrivacyPolicy': 'Privacy policy',
          'termsPrivacy': 'Terms of service',
          'aboutUs': 'About us',
          'logout': 'Logout',
          'aboutme': 'About Me',

          ///
          /// Payment Screen
          ///
          'findPremium': 'Find your spaous faster \nwith premium ',
          'feature': 'Features',
          'unlimitedSwipes': 'Unlimited swipes',
          'seeWhoLike': 'See who likes you',
          'chatPeopleLike': 'Chat to people who likes you',
          'callMatches': 'Call to your matches',
          'offers': 'Offers',
          'goPremium': 'Go Premium',
          'history': 'History',

          ///
          /// Home Screen
          ///
          'userNotFind': 'User not found',
        },

        ///
        ///
        ///
        /// ************** Somali Language  **********************
        ///
        ///
        ///
        'sm_SO': {
          ///
          /// OnBoarding Screen
          ///
          'onbordingTitle': 'Hel xaaskaaga Calaf',

          'onbordingDescription':
              'Isticmaalayaashu waxay marayaan nidaam kala-shaandhayn si ay u hubiyaan inaanay waligood la mid ahayn bots.',
          'crtAccount': 'Samee xisaab',
          'alrdyAccount': 'Horeba akoon ma u leedahay?',
          'signIn': 'Soo gal',

          ///
          /// Sign Up Screen
          ///
          'signUp': 'Isdiiwaangeli',
          'signUpEmailPassword': 'Ku biir Emailka iyo Password-ka',
          'signupGoogle': 'Ku gal Google',
          'signupFbk': 'Facebook-ga ku gal',
          'orSignUpWith': 'ama lasoco',
          'signUpEmail': 'Ku biir Emailka',

          'signUpPolicy': 'Markaad sii waddo, waad ogolaatay annaga ',
          'terms': ' shuruudaha',
          'and': ' viyo',
          'privacyPolicy': ' Qaanuunka Arrimaha Khaaska ah ',
          "orSignInWith": "ama La gal",

          ///
          /// Sign Up with Email and Password
          ///
          'email': 'iimaylka',
          'password': 'Furaha',
          'confmPasword': 'Xaqiiji erayga sirta ah',
          'signInwithEmailAndPaswrd':
              'Ku gal emailkaaga iyo eraygaaga sirta ah',
          'dnotHaveAnAccount': 'Akoon ma lihi?',
          'signInWithIn': 'ama la soo gal',

          ///
          ///
          ///

          "vaildEmail": "Fadlan Geli iimaylka Saxda ah",
          'signupApple': 'Ku biir Apple',
          "enterPassword": "Fadlan geli eraygaaga sirta ah",
          "password_must_8_characters":
              "Furaha waa in uu ka kooban yahay 8 xaraf",
          "password_does_not_matched": "Erayga sirta ah isma lahayn",
          "enter_phone_number": "Geli lambarka taleefanka",
          "phone_number": "Lambarka taleefanka",
          "seconds": "Ilbiriqsi",
          "please_enter_OTP": "Fadlan gali OTP",
          "please_enter_valid_OTP": "Fadlan gali OTP sax ah",
          "invalid_OTP": "OTP aan sax ahayn",
          "name": "Magaca",

          ///
          /// Email OTP Verification
          ///
          'entrOTP': 'Geli OTP u dir',
          'verifyCode': 'Koodhka Xaqiijinta',
          'dnotRecieveCode': 'ko’od ma helaysid ? ',
          'sendAgein': "Dib u dir",
          'confirm': 'Xaqiiji',

          ///
          /// Phone OTP Verification
          ///
          'cmuntySafe': 'Aynu ilaalino bulshadeena',
          'calfConfirmPhNo':
              'Fadlan ku caawi Calaf Space adoo xaqiijinaya lambarkaaga taleefanka',
          'phNoOTP': 'OTP ayaa lagu soo diri doonaa taleefankaaga',
          'cnfmPhNo': 'Xaqiiji lambarka taleefanka',

          ///
          /// welcome screen
          ///
          'wlcmCalaf': 'ku soo dhawoow calaf',
          'crtProfile': 'aan abuurno profile kaaga',
          'buildProfile':
              'aynu u dhisno profile aad si aan u bilaabi kartaa in ay ku tusin kali Muslim kale oo weyn!',
          'tellYourSelf':
              'Naftaada noo sheeg inshaa allaah waan ku tusi doonaa muslimiin weyn oo dhow',
          'createProfile': 'abuur profile',

          ///
          /// Name Photo Screen
          ///
          'introYourSelf': 'is baro',
          'userName': 'magac',
          'buttonContinue': 'sii wad',
          'save': 'badbaadi',

          ///
          /// D-O-B
          ///
          'whrBorn': 'goormaad dhalatay?',

          'youare': 'waxaad tahay',
          'yearOld': 'sano jir',

          ///
          /// gender
          ///
          'whtsYurGnder': 'waa maxay jinsigaagu?',
          'whereLive': 'xagee ku nooshahay ?',
          'city': 'magaalada',
          'stateProvince': 'gobolka/gobolka',
          'country': 'dalka',

          ///
          /// Proffesion
          ///
          'whtsYurProfession': 'Waa maxay xirfadaada?',
          'searchHere': 'halkan ka raadi',
          'chef': 'cunto kariye',
          'farmer': 'beeralay',
          'acountant': 'xisaabiye',
          'profession': 'Xirfad',

          ///
          ///  Education Screen
          ///
          'yrEducation': 'waa maxay waxbarashadaadu?',
          'schol': 'Dugsi sare',
          'diploma': 'dibloomada',
          'bchlrDegree': 'shahaadada koowaad ee jaamacadda',
          'mastrDegre': 'shahaadada masters-ka',
          'decorate': 'doctorate',
          'other': 'kale',
          'edu_car': 'Heerka aqooneed',

          ///
          /// marital status screen
          ///
          'mtrlStatus': 'waa sidee xaaladaada guur ?',
          'neverMarried': 'waligiis guursan',
          'divorce': 'la furay',
          'widow': 'carmal',
          'married': 'guursaday',

          ///
          /// childern screen
          ///
          'doHaveChildren': 'caruur ma leedahay?',
          'yes': 'Haa',
          'no': 'Maya',
          'whatYrHeight': 'waa maxay jooggaagu?',

          /// height
          'what_your_height': 'Whats your height?',
          'select_height': 'Select height ',
          "cm": " Cm",

          ///
          /// body Type Screen
          ///
          'whatYrBodyType': 'waa maxay nooca jidhkaagu?',
          'slim': 'Caato ah',
          'normal': 'caadi',
          'atheletic': 'ciyaaraha fudud',
          'bodybuilder': 'dhise',
          'chubby': 'qaylo badan',
          'bt': 'nooca jidhka',

          ///
          /// personality screen
          ///
          'whatYrPersonality': 'Waa maxay shakhsiyaddaadu?',
          'shy': 'Xishood',
          'social': 'bulsho',
          'funny': 'qosol badan',
          'caring': 'daryeelid',
          'sensitive': 'xasaasi ah',
          'outgoing': 'baxaysa',
          'personality': 'Shakhsiyada',

          ///
          /// interest screen
          ///
          'whtsYrInterest': 'waa maxay dantaadu?',
          'art': 'fanka',
          'racing': 'tartanka',
          'cooking': 'karinta',
          'traveling': 'socdaalka',
          'boating': 'doon doon',
          'swimming': 'dabaasha',
          'photography': 'sawir qaade',
          'videoGames': 'ciyaaraha fiidiyowga',
          'interest': 'Xiisaha',

          ///
          /// All Successfull messages
          ///
          'profUpdateSucessfully': 'Si guul leh ayaa loo cusboonaysiiyay xogta',
          'otpSendEmail': 'OTP waxay kuu soo diri doontaa gmailkaaga',

          ///
          /// Notification screen
          ///
          'notification': 'ogeysiin',
          'notificationFound': 'ogeysiis lama helin',

          ///
          /// filter screen
          ///
          'ageRange': 'da’da kala duwan',
          'height': 'dhererka',

          ///
          /// Matches Screen
          ///
          'matches': 'Tartamada',
          'likeMatchesPeple': 'Dadka ku jeclaa adiga iyo kulammadaada.',
          'matched': 'isku beegay',
          'pending': 'la sugayo',
          'matchNotFound': 'kulan lama helin',
          'reqstNotFound': 'codsiga lama helin',

          ///
          /// Messages screen
          ///
          'Messages': 'Fariimaha',
          'conversationFound': 'Wadahadal lama helin',
          'youmatch': 'Wad is waafaqdeen ',
          'writeMsg': 'Qor fariin ',

          ///
          /// Setting Screen
          ///
          'setting': 'Dejinta',
          'payment': 'Lacag bixinta',
          'PrivacyPolicy': 'Qaanuunka Arrimaha Khaaska ah',
          'termsPrivacy': 'shuruudaha adeegga',
          'aboutUs': 'nagu saabsan',
          'logout': 'ka bax',
          'aboutme': 'Igu saabsan',

          ///
          /// Payment Screen
          ///
          'findPremium': 'Si dhakhso leh u hel meelahaaga bannaan oo qiimo leh',
          'feature': 'Astaamaha',
          'unlimitedSwipes': 'dharbaaxo aan xad lahayn',
          'seeWhoLike': 'arag qofka ku jecel',
          'chatPeopleLike': 'la hadal dadka ku jecel',
          'callMatches': 'wac kulammadaada',
          'offers': 'soo bandhigo',
          'goPremium': 'Qaado Premium',

          'history': 'Taariikhda',

          ///
          /// Home Screen
          ///
          'userNotFind': 'Isticmaalaha lama helin',
        }
      };
}
