import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['ko', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? koText = '',
    String? enText = '',
  }) =>
      [koText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // LoginPage
  {
    'x5zb4l34': {
      'ko': '건축학  인증 프로그램',
      'en': '',
    },
    'q1cokdo1': {
      'ko': '포트폴리오를 편하고 쉽게 ',
      'en': '',
    },
    'sxyxj39q': {
      'ko': '쉽고, 편하게 모든 자료를 관리할 수 있습니다.',
      'en': '',
    },
    'cthvx446': {
      'ko': 'Welcome Back to Archiverse',
      'en': '',
    },
    'wtrspffg': {
      'ko': 'Sign in your account',
      'en': '',
    },
    'bysr27tp': {
      'ko': 'Your Type',
      'en': '',
    },
    'tbdvzrek': {
      'ko': '학부생',
      'en': '',
    },
    'nzupuj53': {
      'ko': '교수님',
      'en': '',
    },
    'zw7lsvcn': {
      'ko': 'Your Email',
      'en': '',
    },
    '5mp45bit': {
      'ko': '이메일을 입력해주세요',
      'en': '',
    },
    'xnexo6gw': {
      'ko': 'Your Email',
      'en': '',
    },
    '9x6kwl58': {
      'ko': 'Password',
      'en': '',
    },
    'lsxrcmwb': {
      'ko': '비밀번호를 입력해주세요',
      'en': '',
    },
    '82gsr9rt': {
      'ko': 'Password',
      'en': '',
    },
    'wwf2etx1': {
      'ko': 'Remember Me',
      'en': '',
    },
    '0btwfi00': {
      'ko': 'Forgot Password?',
      'en': '',
    },
    'vc4wp7et': {
      'ko': 'Login',
      'en': '',
    },
    'dmpq0p56': {
      'ko': 'Don’t have any acount?  ',
      'en': '',
    },
    'ynb6z7xi': {
      'ko': 'Register',
      'en': '',
    },
    'ctbdtmfx': {
      'ko': '이메일을 입력해주세요.',
      'en': '',
    },
    'axn2q6t4': {
      'ko': 'Please choose an option from the dropdown',
      'en': '',
    },
    '8v2oy2os': {
      'ko': '비밀번호를 입력해주세요',
      'en': '',
    },
    '4yomyjdy': {
      'ko': 'Please choose an option from the dropdown',
      'en': '',
    },
    'r4qagkvx': {
      'ko': 'Home',
      'en': '',
    },
  },
  // ResetPassword
  {
    '0pibw41n': {
      'ko': 'Find your sweet home',
      'en': '',
    },
    'jm3h41cc': {
      'ko': 'Schedule visit in just a few clicks visits in just a few clicks',
      'en': '',
    },
    'f35tlzvq': {
      'ko': 'Free Consultation',
      'en': '',
    },
    'ov8wl91y': {
      'ko':
          'Let your connect with the agent in our in-build-chat system to connect agent',
      'en': '',
    },
    'iqy3gfnx': {
      'ko': 'View Detail with AR',
      'en': '',
    },
    '6d4bm402': {
      'ko': 'You can view interior details with our built-in AR system',
      'en': '',
    },
    '5qucihzb': {
      'ko': 'ForgotPassword',
      'en': '',
    },
    'a3wi2383': {
      'ko': 'Forgot Password',
      'en': '',
    },
    'iwq7crfw': {
      'ko': 'Enter your email account to reset your password',
      'en': '',
    },
    'r0x0314y': {
      'ko': 'Your Email',
      'en': '',
    },
    '9e789a48': {
      'ko': 'Your Email',
      'en': '',
    },
    '134u4v6a': {
      'ko': 'Reset Password',
      'en': '',
    },
    'nwyq8x8a': {
      'ko': 'Field is required',
      'en': '',
    },
    'gg4odiyf': {
      'ko': 'Please choose an option from the dropdown',
      'en': '',
    },
    'nqxxfrbb': {
      'ko': 'Home',
      'en': '',
    },
  },
  // RegisterPage
  {
    '6x57jyqh': {
      'ko': '포트폴리오를 편하고 쉽게 ',
      'en': '',
    },
    '1j0gjmav': {
      'ko': '쉽고, 편하게 모든 자료를 관리할 수 있습니다.',
      'en': '',
    },
    'rx4say3r': {
      'ko': '건축학  인증 프로그램',
      'en': '',
    },
    '9nqu69o5': {
      'ko': 'Create your Account',
      'en': '',
    },
    'ychl1k2v': {
      'ko': '정보를 입력해주세요',
      'en': '',
    },
    'w1vmbpks': {
      'ko': '대학교 ',
      'en': '',
    },
    '7cq19w10': {
      'ko': '순천향대학교',
      'en': '',
    },
    '31kujulg': {
      'ko': '소속학교선택',
      'en': '',
    },
    '9czdkjjb': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'r9y6a88o': {
      'ko': '순천향대학교',
      'en': '',
    },
    'dyzzilp4': {
      'ko': '교수/학생 타입 선택',
      'en': '',
    },
    'zrw48wem': {
      'ko': '교수',
      'en': '',
    },
    'zxuwyk4a': {
      'ko': '교수',
      'en': '',
    },
    'q7ivtonq': {
      'ko': '학생',
      'en': '',
    },
    'jxnc7z05': {
      'ko': '학번',
      'en': '',
    },
    '98vaoluz': {
      'ko': '학번을 입력해주세요',
      'en': '',
    },
    'f6ii3p76': {
      'ko': '핸드폰 번호',
      'en': '',
    },
    '2oqzpv59': {
      'ko': '핸드폰 번호를 입력해주세요',
      'en': '',
    },
    'woq1dtqp': {
      'ko': '이름',
      'en': '',
    },
    'u96im523': {
      'ko': '이름을 입력해주세요',
      'en': '',
    },
    'hxrpvwc8': {
      'ko': 'Email',
      'en': '',
    },
    'jat18paj': {
      'ko': '이메일을 입력해주세요',
      'en': '',
    },
    'v23w7oo6': {
      'ko': 'Password',
      'en': '',
    },
    'd9v63340': {
      'ko': '비밀번호',
      'en': '',
    },
    'qhiv34vb': {
      'ko': 'Password Verification',
      'en': '',
    },
    'ypugbp2h': {
      'ko': '비밀번호 확인',
      'en': '',
    },
    'e82mypyr': {
      'ko': 'I agree to archiverse ',
      'en': '',
    },
    'bnkmcd9e': {
      'ko': 'Terms of Service ',
      'en': '',
    },
    'l9gec2kr': {
      'ko': 'and ',
      'en': '',
    },
    'gbzd6o08': {
      'ko': 'Privacy Policy ',
      'en': '',
    },
    'u58rque0': {
      'ko': 'Get Started',
      'en': '',
    },
    'bevldfsq': {
      'ko': 'I have an acount? ',
      'en': '',
    },
    'na0ctbr4': {
      'ko': 'Login',
      'en': '',
    },
    'zzc2h6me': {
      'ko': '학번을 적어주세요 is required',
      'en': '',
    },
    '54vb68s5': {
      'ko': 'Please choose an option from the dropdown',
      'en': '',
    },
    'srf9aklb': {
      'ko': '핸드폰 번호를 입력해주세요 is required',
      'en': '',
    },
    'iajqqmp9': {
      'ko': '핸드폰 번호를 화인해주세요',
      'en': '',
    },
    'qptdvbex': {
      'ko': 'Please choose an option from the dropdown',
      'en': '',
    },
    'g5z08bth': {
      'ko': 'Full Name is required',
      'en': '',
    },
    '1lcqhan7': {
      'ko': 'Please choose an option from the dropdown',
      'en': '',
    },
    'rjhlu7c6': {
      'ko': 'Field is required',
      'en': '',
    },
    'syyumiyk': {
      'ko': '최소 8자리 이상 입력해주세요',
      'en': '',
    },
    '754pmoxr': {
      'ko': '이메일을 확인해주세요',
      'en': '',
    },
    '5hy9lh5l': {
      'ko': 'Please choose an option from the dropdown',
      'en': '',
    },
    'xftq4m1o': {
      'ko': 'Field is required',
      'en': '',
    },
    '20ttn93i': {
      'ko': '최소 8자리 이상 입력해주세요',
      'en': '',
    },
    'a58zrk2j': {
      'ko': '최소 대문자 1개, 특수문자 1개 필요합니다.',
      'en': '',
    },
    'pzqrua1w': {
      'ko': 'Please choose an option from the dropdown',
      'en': '',
    },
    'q73pt39m': {
      'ko': '비밀번호 확인 is required',
      'en': '',
    },
    '5bd4txkp': {
      'ko': '최소 8자리 이상 입력해주세요',
      'en': '',
    },
    'm1zqkij4': {
      'ko': '최소 대문자 1개, 특수문자 1개 필요합니다.',
      'en': '',
    },
    'aaqkh9oq': {
      'ko': 'Please choose an option from the dropdown',
      'en': '',
    },
    '7twsbj84': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Message
  {
    '7cx76md7': {
      'ko': 'New',
      'en': '',
    },
    'ylm7swbe': {
      'ko': 'Search Message',
      'en': '',
    },
    '7o4svoy1': {
      'ko': 'Cameron Williamson',
      'en': '',
    },
    'lo76n4vt': {
      'ko': 'Online',
      'en': '',
    },
    'twgbjffm': {
      'ko': 'Write message down here ...',
      'en': '',
    },
    'y9caripn': {
      'ko': 'Home',
      'en': '',
    },
  },
  // EditProfile
  {
    '7x85u51e': {
      'ko': 'Photo Profile',
      'en': '',
    },
    'rloz0isc': {
      'ko': 'Change photo profile use',
      'en': '',
    },
    'rnu1c2yz': {
      'ko': 'Upload New Photo',
      'en': '',
    },
    '6klky3l0': {
      'ko': 'Max 2 mb',
      'en': '',
    },
    'cijpxs6x': {
      'ko': 'Full Name',
      'en': '',
    },
    '90ohhbwu': {
      'ko': 'Your Full Name',
      'en': '',
    },
    'z8wyg0s6': {
      'ko': 'Input name user',
      'en': '',
    },
    'qtmls9xw': {
      'ko': 'Max 25 character',
      'en': '',
    },
    'qf2bck0l': {
      'ko': 'Address',
      'en': '',
    },
    'bjtsokag': {
      'ko': 'Your Address',
      'en': '',
    },
    '3rgfupnz': {
      'ko': 'Input Address',
      'en': '',
    },
    'mwvuha18': {
      'ko': 'Email',
      'en': '',
    },
    'z3btwb6r': {
      'ko': 'Email Address',
      'en': '',
    },
    'oo5q3opo': {
      'ko': 'Input Email',
      'en': '',
    },
    'i7i6yy4s': {
      'ko': 'Phone',
      'en': '',
    },
    'dk4ce6jv': {
      'ko': 'Phone Number',
      'en': '',
    },
    '6nswz1r5': {
      'ko': 'Input Phone Number',
      'en': '',
    },
    'qo6709y4': {
      'ko': 'Save Change',
      'en': '',
    },
    'epkknkb5': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Setting
  {
    '37gzae05': {
      'ko': 'Language',
      'en': '',
    },
    '5zen0svm': {
      'ko': 'Select Language',
      'en': '',
    },
    '73i0ovlo': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'wkpdgyp2': {
      'ko': 'English',
      'en': '',
    },
    'k7gg1c7u': {
      'ko': 'French',
      'en': '',
    },
    'p1xblqfj': {
      'ko': 'Chinese',
      'en': '',
    },
    'zmkaubim': {
      'ko': 'Timezone',
      'en': '',
    },
    's20q1217': {
      'ko': 'Select Timezone',
      'en': '',
    },
    'o0hqi2jd': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'ty48a3ci': {
      'ko': 'US',
      'en': '',
    },
    'mltmtjz8': {
      'ko': 'Canada',
      'en': '',
    },
    'uwz7j2ay': {
      'ko': 'UK',
      'en': '',
    },
    'xcxgn6m0': {
      'ko': 'Time Format',
      'en': '',
    },
    'fkgj2b1l': {
      'ko': '24 Hourd',
      'en': '',
    },
    '3almc4y7': {
      'ko': '12 Hours',
      'en': '',
    },
    '4gr93p7g': {
      'ko': 'Notification',
      'en': '',
    },
    'xt7e83ud': {
      'ko': 'Select Notification',
      'en': '',
    },
    'tfjifdh7': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'ysize651': {
      'ko': 'Active for all activity',
      'en': '',
    },
    'ouk6zfuc': {
      'ko': 'Active for all activity 2',
      'en': '',
    },
    '2tldeiew': {
      'ko': 'Active for all activity 3',
      'en': '',
    },
    '6zi6i9wv': {
      'ko': 'Location',
      'en': '',
    },
    '0i9iga7m': {
      'ko': 'Select Location',
      'en': '',
    },
    'pu41mxox': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'nacwqp7h': {
      'ko': 'Active when the app is used',
      'en': '',
    },
    'g87gdp6x': {
      'ko': 'Active when the app is used 2',
      'en': '',
    },
    'zpyf92jy': {
      'ko': 'Active when the app is used 3',
      'en': '',
    },
    'duyeuyud': {
      'ko': 'Save Change',
      'en': '',
    },
    'fv5a8a0i': {
      'ko': 'Home',
      'en': '',
    },
  },
  // chat
  {
    'llh204cq': {
      'ko': 'Page Title',
      'en': '',
    },
    '09x7jnos': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Dahsboard_Master
  {
    'f52rsex1': {
      'ko': '년도 선택',
      'en': '',
    },
    'fgjuw3jk': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'yz3jxhka': {
      'ko': '2025학년도',
      'en': '',
    },
    'hv97o5y0': {
      'ko': '2024학년도',
      'en': '',
    },
    'eniz2iwq': {
      'ko': '2023학년도',
      'en': '',
    },
    'ocilklls': {
      'ko': '학기 선택',
      'en': '',
    },
    'jneqf9p0': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '2w9d0nlu': {
      'ko': '1학기',
      'en': '',
    },
    '320re40y': {
      'ko': '2학기',
      'en': '',
    },
    'cjf88bab': {
      'ko': '여름학기',
      'en': '',
    },
    '9mqm2bsm': {
      'ko': '겨울학기',
      'en': '',
    },
    'ilfwgx22': {
      'ko': '2024년 2학기',
      'en': '',
    },
    '9i7zbevy': {
      'ko': 'test 페이지임',
      'en': '',
    },
    '1h61lw6i': {
      'ko': '년도 선택',
      'en': '',
    },
    '6l9pdjxf': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'bvcnnq1z': {
      'ko': '2025학년도',
      'en': '',
    },
    'mkg3rcc0': {
      'ko': '2024학년도',
      'en': '',
    },
    '7bcparns': {
      'ko': '2023학년도',
      'en': '',
    },
    '34acbt3p': {
      'ko': '학기 선택',
      'en': '',
    },
    '5i9eou6e': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '9kztsut5': {
      'ko': '1학기',
      'en': '',
    },
    '5z5pe07e': {
      'ko': '2학기',
      'en': '',
    },
    '625fpudf': {
      'ko': '여름학기',
      'en': '',
    },
    '7ukhpu6r': {
      'ko': '겨울학기',
      'en': '',
    },
    'svttmr1d': {
      'ko': '2024년 2학기',
      'en': '',
    },
    'odc2zsxh': {
      'ko': '전체 자료 다운로드',
      'en': '',
    },
    'arfmemzs': {
      'ko': '1학년 담당과목',
      'en': '',
    },
    'uupy3mwx': {
      'ko': '2학년 담당과목',
      'en': '',
    },
    '9auz2o86': {
      'ko': '3학년 담당과목',
      'en': '',
    },
    'a2fpfhsz': {
      'ko': '4학년 담당과목',
      'en': '',
    },
    '1bidl5jr': {
      'ko': '5학년 담당과목',
      'en': '',
    },
    '8ovrvi2i': {
      'ko': '건축 설계 x\n(캡스톤 디자인)',
      'en': '',
    },
    '8911nl9d': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'wfi3n9al': {
      'ko': '1분반',
      'en': '',
    },
    '9vkc0dsp': {
      'ko': '김승 교수님',
      'en': '',
    },
    'vzgve74t': {
      'ko': '바로가기',
      'en': '',
    },
    'hf2fu8l3': {
      'ko': '2분반',
      'en': '',
    },
    'g3dp0unw': {
      'ko': '윤석현 교수님',
      'en': '',
    },
    'x16ai539': {
      'ko': '바로가기',
      'en': '',
    },
    '4tcfo2d4': {
      'ko': '3분반',
      'en': '',
    },
    '1kchqa1b': {
      'ko': '정미소 교수님',
      'en': '',
    },
    'elm7naj6': {
      'ko': '바로가기',
      'en': '',
    },
    't2n2h5ld': {
      'ko': '서양 건축사',
      'en': '',
    },
    '56sbbqoh': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'w9celr92': {
      'ko': '황선희 교수님',
      'en': '',
    },
    'abgzie1q': {
      'ko': '바로가기',
      'en': '',
    },
    '6anrqjkb': {
      'ko': '건축 기획',
      'en': '',
    },
    '85tjcip3': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'vcxs12jn': {
      'ko': '홍길동 교수님',
      'en': '',
    },
    'l019x8zh': {
      'ko': '바로가기',
      'en': '',
    },
    'k0c5wnc2': {
      'ko': '건축 구조',
      'en': '',
    },
    'wvw5rx0g': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    '0o2owgd0': {
      'ko': '안정환 교수님',
      'en': '',
    },
    '2z1c53gx': {
      'ko': '바로가기',
      'en': '',
    },
    'tg4dznvi': {
      'ko': '학년별 과목선택',
      'en': '',
    },
    'xej1me0s': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '9p6bq1kl': {
      'ko': '1학년 담당과목',
      'en': '',
    },
    'z6tr7vxg': {
      'ko': '2학년 담당과목',
      'en': '',
    },
    'qrazqv9x': {
      'ko': '3학년 담당과목',
      'en': '',
    },
    '8mmwtoxl': {
      'ko': '4학년 담당과목',
      'en': '',
    },
    'b8pdl9fo': {
      'ko': '5학년 담당과목',
      'en': '',
    },
    '5wv4qrrr': {
      'ko': '건축 설계 x\n(캡스톤 디자인)',
      'en': '',
    },
    '1lrr5xak': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'akq3oeeq': {
      'ko': '1분반',
      'en': '',
    },
    'x2xwcwic': {
      'ko': '김승 교수님',
      'en': '',
    },
    'd54f4kd7': {
      'ko': '바로가기',
      'en': '',
    },
    'pb0pwf4n': {
      'ko': '2분반',
      'en': '',
    },
    '5f2j7ajk': {
      'ko': '천준호 교수님',
      'en': '',
    },
    'jwwrq6qq': {
      'ko': '바로가기',
      'en': '',
    },
    'tk14kyle': {
      'ko': '3분반',
      'en': '',
    },
    '7579c9r2': {
      'ko': '이태희 교수님',
      'en': '',
    },
    'yd1dgcqo': {
      'ko': '바로가기',
      'en': '',
    },
    '1zvkzg1c': {
      'ko': '서양 건축사',
      'en': '',
    },
    '5hf17jbt': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'zv80ybo8': {
      'ko': '황선희 교수님',
      'en': '',
    },
    '876axfon': {
      'ko': '바로가기',
      'en': '',
    },
    '3t6g15b7': {
      'ko': '건축 기획',
      'en': '',
    },
    '93zqijkr': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'tdomjjwk': {
      'ko': '홍길동 교수님',
      'en': '',
    },
    'wdm0cbpb': {
      'ko': '바로가기',
      'en': '',
    },
    'urm32kz3': {
      'ko': '건축 구조',
      'en': '',
    },
    'g91ixlwz': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'jb01ppxm': {
      'ko': '윤석현 교수님',
      'en': '',
    },
    'icidmifb': {
      'ko': '바로가기',
      'en': '',
    },
    'pe3qkdy4': {
      'ko': '과목 진행사항을 조회 할 수 있습니다',
      'en': '',
    },
    '0hqdqjz4': {
      'ko': '건축 설계 x (캡스톤 디자인)',
      'en': '',
    },
    't97oc1fo': {
      'ko': '총 진행사항',
      'en': '',
    },
    '0nzr4ptx': {
      'ko': '0%',
      'en': '',
    },
    'bl3mzb8o': {
      'ko': '100%',
      'en': '',
    },
    'wqbf4awl': {
      'ko': '1분반',
      'en': '',
    },
    '7rle7f0m': {
      'ko': '김승 교수님',
      'en': '',
    },
    'ns1dx5oh': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'bh19hwxs': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'l9v1s9ze': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'w9nhi90g': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'nblmsn3x': {
      'ko': '학부생 등록 여부',
      'en': '',
    },
    'vbxe0usn': {
      'ko': ' ▶',
      'en': '',
    },
    '8r6wnxvq': {
      'ko': '등록되어있지  않습니다.',
      'en': '',
    },
    'l9qv6tfn': {
      'ko': '수업계획서',
      'en': '',
    },
    'zsnr35gu': {
      'ko': ' ▶',
      'en': '',
    },
    '7vrw2ant': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    't9keizae': {
      'ko': '강의 자료실',
      'en': '',
    },
    'k4j2gxus': {
      'ko': ' ▶',
      'en': '',
    },
    '2ovv7hwo': {
      'ko': '등록되어있지  않습니다.',
      'en': '',
    },
    '150m3kkl': {
      'ko': '학생작품 평가표',
      'en': '',
    },
    'h0hrs9cu': {
      'ko': ' ▶',
      'en': '',
    },
    'yx2z3wmy': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'pi47kixr': {
      'ko': '출석부',
      'en': '',
    },
    'q1ggp9dn': {
      'ko': ' ▶',
      'en': '',
    },
    '0j67rc2z': {
      'ko': '등록되어있지  않습니다.',
      'en': '',
    },
    'n4kqpadb': {
      'ko': '성적기록표',
      'en': '',
    },
    'r4so6k84': {
      'ko': ' ▶',
      'en': '',
    },
    'mj0n857p': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'i0udfrc0': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'juyvt1yo': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'ztsovq0e': {
      'ko': '미제출 조회',
      'en': '',
    },
    'b1pzoj4v': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'bnq15sin': {
      'ko': '미제출 조회',
      'en': '',
    },
    'kr1df7yd': {
      'ko': '2분반',
      'en': '',
    },
    '12mak5yp': {
      'ko': '윤석현 교수님',
      'en': '',
    },
    '0pcs5zws': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'ucz0mono': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'rbavtjdw': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'mmrpcz81': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'd2idzk11': {
      'ko': '학부생 등록 여부',
      'en': '',
    },
    'mntn9wai': {
      'ko': ' ▶',
      'en': '',
    },
    'x2uhlewe': {
      'ko': '등록되어있지  않습니다.',
      'en': '',
    },
    'muchvvat': {
      'ko': '수업계획서',
      'en': '',
    },
    '1e9hubny': {
      'ko': ' ▶',
      'en': '',
    },
    'np23el9j': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'v7o3wioh': {
      'ko': '강의 자료실',
      'en': '',
    },
    '2ewdnbb4': {
      'ko': ' ▶',
      'en': '',
    },
    'teipr8ez': {
      'ko': '등록되어있지  않습니다.',
      'en': '',
    },
    'dld0e110': {
      'ko': '학생작품 평가표',
      'en': '',
    },
    '0vtlmnfn': {
      'ko': ' ▶',
      'en': '',
    },
    'amoaz3aa': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '5aanapem': {
      'ko': '출석부',
      'en': '',
    },
    'idt174n1': {
      'ko': ' ▶',
      'en': '',
    },
    'jjqovmt0': {
      'ko': '등록되어있지  않습니다.',
      'en': '',
    },
    'e28fm08h': {
      'ko': '성적기록표',
      'en': '',
    },
    'd5jliuop': {
      'ko': ' ▶',
      'en': '',
    },
    's7v0tk4i': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'dhjvidcp': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'kqzn8mda': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'tfu9pwi6': {
      'ko': '미제출 조회',
      'en': '',
    },
    'ow1ngvn4': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'ozgx05ud': {
      'ko': '미제출 조회',
      'en': '',
    },
    'hqxtwzzj': {
      'ko': '1분반',
      'en': '',
    },
    'dng6cxs5': {
      'ko': '정미소 교수님',
      'en': '',
    },
    'tk1qu0xr': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '9m3o3429': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'jsif98ps': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'l2bmg0pj': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'wao8m1oa': {
      'ko': '학부생 등록 여부',
      'en': '',
    },
    'n04725z4': {
      'ko': ' ▶',
      'en': '',
    },
    'c0856q2i': {
      'ko': '등록되어있지  않습니다.',
      'en': '',
    },
    'cohz4n7e': {
      'ko': '수업계획서',
      'en': '',
    },
    '2thp4x5w': {
      'ko': ' ▶',
      'en': '',
    },
    'gz4j1jgm': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '09p7elfh': {
      'ko': '강의 자료실',
      'en': '',
    },
    'gokmci3j': {
      'ko': ' ▶',
      'en': '',
    },
    'v3ue05l1': {
      'ko': '등록되어있지  않습니다.',
      'en': '',
    },
    's4p8kfvx': {
      'ko': '학생작품 평가표',
      'en': '',
    },
    '6xq1x5ky': {
      'ko': ' ▶',
      'en': '',
    },
    'f0ma27wz': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'tfi6tkre': {
      'ko': '출석부',
      'en': '',
    },
    'ty5vbrme': {
      'ko': ' ▶',
      'en': '',
    },
    'bzuug9vq': {
      'ko': '등록되어있지  않습니다.',
      'en': '',
    },
    'jbriebhk': {
      'ko': '성적기록표',
      'en': '',
    },
    'j4bf2wtu': {
      'ko': ' ▶',
      'en': '',
    },
    '8h26jbka': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'p9j2m7ma': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'sxzgi2tg': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'plpvqw4h': {
      'ko': '미제출 조회',
      'en': '',
    },
    'e152lp7u': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    '40dz573y': {
      'ko': '미제출 조회',
      'en': '',
    },
    'bzshdf7s': {
      'ko': 'Hello World',
      'en': '',
    },
    'xiivoij9': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Dahsboard_General
  {
    'hzyt4ael': {
      'ko': '년도 선택',
      'en': '',
    },
    'hmhuvv9u': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '6q8bsa8i': {
      'ko': '학기 선택',
      'en': '',
    },
    'fd580zis': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '7f6zdrpt': {
      'ko': '년',
      'en': '',
    },
    'ecshxk47': {
      'ko': '1학년 담당과목',
      'en': '',
    },
    '3lmc9i66': {
      'ko': '2학년 담당과목',
      'en': '',
    },
    'p1pi8cbm': {
      'ko': '3학년 담당과목',
      'en': '',
    },
    'qjsxjjka': {
      'ko': '4학년 담당과목',
      'en': '',
    },
    'zq7bdz3b': {
      'ko': '5학년 담당과목',
      'en': '',
    },
    '48ve3zdq': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'w2cew0dz': {
      'ko': '교수님',
      'en': '',
    },
    'zwk5ocj9': {
      'ko': '바로가기',
      'en': '',
    },
    'cc2ukbx0': {
      'ko': '전체반',
      'en': '',
    },
    'n5yw8brr': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'opr8ruku': {
      'ko': '총 진행사항',
      'en': '',
    },
    'he05rbwx': {
      'ko': '0%',
      'en': '',
    },
    '3zqohnpp': {
      'ko': '100%',
      'en': '',
    },
    'gamcyzvy': {
      'ko': '학부생 등록 여부',
      'en': '',
    },
    'pkvbvg2u': {
      'ko': ' ▶',
      'en': '',
    },
    '7wjapd47': {
      'ko': '등록되어있지  않습니다.',
      'en': '',
    },
    'd5dgm5l3': {
      'ko': '수업계획서',
      'en': '',
    },
    'inonkgs8': {
      'ko': ' ▶',
      'en': '',
    },
    'w0oom8vz': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'y9fn0gwx': {
      'ko': '강의 자료실',
      'en': '',
    },
    'qzhyyngy': {
      'ko': ' ▶',
      'en': '',
    },
    '1a19ds7r': {
      'ko': '등록되어있지  않습니다.',
      'en': '',
    },
    'fkbgxhjk': {
      'ko': '학생작품 평가표',
      'en': '',
    },
    'kvgyitbv': {
      'ko': ' ▶',
      'en': '',
    },
    'cwfb3e9t': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'foanmtid': {
      'ko': '출석부',
      'en': '',
    },
    'csbwvu4c': {
      'ko': ' ▶',
      'en': '',
    },
    'm7fbfb7j': {
      'ko': '등록되어있지  않습니다.',
      'en': '',
    },
    'es7r5p17': {
      'ko': '성적기록표',
      'en': '',
    },
    'r618qj1t': {
      'ko': ' ▶',
      'en': '',
    },
    '3i0uz4hw': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'eh600rg2': {
      'ko': '과목 진행 상황을 조회 할 수 있습니다.',
      'en': '',
    },
    'zwthyfti': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Dahsboard_Vice
  {
    '5jzjngxi': {
      'ko': '년도 선택',
      'en': '',
    },
    '8nauk116': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'zgs067dr': {
      'ko': '학기 선택',
      'en': '',
    },
    'vr7u007a': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'cmnvwukz': {
      'ko': '년',
      'en': '',
    },
    'pzabwugj': {
      'ko': '  ',
      'en': '',
    },
    'uunm3g79': {
      'ko': '1학년 담당과목',
      'en': '',
    },
    'pz0phfc5': {
      'ko': '2학년 담당과목',
      'en': '',
    },
    'u0szcixn': {
      'ko': '3학년 담당과목',
      'en': '',
    },
    'sfuiwnvo': {
      'ko': '4학년 담당과목',
      'en': '',
    },
    'xv4d230o': {
      'ko': '5학년 담당과목',
      'en': '',
    },
    'dbo3qjx0': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    '4k1q3p46': {
      'ko': ' 교수님',
      'en': '',
    },
    'u9d8l72o': {
      'ko': '바로가기',
      'en': '',
    },
    'q74q5i92': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'in8gs77k': {
      'ko': ' 교수님',
      'en': '',
    },
    '29yf7ze3': {
      'ko': '바로가기',
      'en': '',
    },
    'ndpdgr60': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'pae35jgr': {
      'ko': ' 교수님',
      'en': '',
    },
    '807hu4ov': {
      'ko': '바로가기',
      'en': '',
    },
    '9koigeu9': {
      'ko': '총 진행사항',
      'en': '',
    },
    'wha9i5x4': {
      'ko': '0%',
      'en': '',
    },
    'vr1u3g3d': {
      'ko': '100%',
      'en': '',
    },
    'boem1ns4': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'w2afxnnc': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'ibo6902s': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'jmuq45pc': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '96n3wuxt': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    'm5iz97tp': {
      'ko': '--',
      'en': '',
    },
    'yv2w69z2': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '36ftlnzr': {
      'ko': '수업계획서',
      'en': '',
    },
    'bm7dyfhx': {
      'ko': ' ▶',
      'en': '',
    },
    'ub75cqis': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '7m23d7q5': {
      'ko': '강의 자료실',
      'en': '',
    },
    'zkq8tq1r': {
      'ko': ' ▶',
      'en': '',
    },
    'q2npstxj': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'rqag96m2': {
      'ko': '학생 작품 평가표',
      'en': '',
    },
    'i8auhonn': {
      'ko': ' ▶',
      'en': '',
    },
    'hbr5t9cu': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '8bhrle1n': {
      'ko': '출석부',
      'en': '',
    },
    'wfwt4wyi': {
      'ko': ' ▶',
      'en': '',
    },
    'pvt02el0': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'yboe97bp': {
      'ko': '성적기록표',
      'en': '',
    },
    'bqnrmkpt': {
      'ko': ' ▶',
      'en': '',
    },
    '22sglu5j': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'bqk8nxny': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'utxta54n': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'lb49prlt': {
      'ko': ' ▶',
      'en': '',
    },
    '72ycvpra': {
      'ko': '미제출 조회',
      'en': '',
    },
    '3d1zk7dw': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    '30ajolow': {
      'ko': ' ▶',
      'en': '',
    },
    '8zbmvqpd': {
      'ko': '미제출 조회',
      'en': '',
    },
    'je7o06x1': {
      'ko': '년도 선택',
      'en': '',
    },
    'jtw626i3': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'f80e65ji': {
      'ko': '학기 선택',
      'en': '',
    },
    'es2q1ak7': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '8dj2h33y': {
      'ko': '년',
      'en': '',
    },
    'dqzwr3qo': {
      'ko': '  ',
      'en': '',
    },
    '5atgqq1x': {
      'ko': '1학년 담당과목',
      'en': '',
    },
    'lijpst23': {
      'ko': '2학년 담당과목',
      'en': '',
    },
    '7ghccm3v': {
      'ko': '3학년 담당과목',
      'en': '',
    },
    'cmtegg73': {
      'ko': '4학년 담당과목',
      'en': '',
    },
    '9kcpk5n4': {
      'ko': '5학년 담당과목',
      'en': '',
    },
    '7fwzxebh': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'v0cdf0bc': {
      'ko': ' 교수님',
      'en': '',
    },
    'fue0bulz': {
      'ko': '바로가기',
      'en': '',
    },
    'ynug9oh7': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'ylxqf39m': {
      'ko': ' 교수님',
      'en': '',
    },
    'd6nkosal': {
      'ko': '바로가기',
      'en': '',
    },
    'k6biophl': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'qxq08yfj': {
      'ko': ' 교수님',
      'en': '',
    },
    '6ff6h8qh': {
      'ko': '바로가기',
      'en': '',
    },
    'ahlgn39n': {
      'ko': '총 진행사항',
      'en': '',
    },
    'erxr3v80': {
      'ko': '0%',
      'en': '',
    },
    '32fjkx4u': {
      'ko': '100%',
      'en': '',
    },
    'f0mfpsvp': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '88u18zsu': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'j7jgg16o': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'snq6aqxp': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '37q5frr1': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    'fhom8cl5': {
      'ko': '--',
      'en': '',
    },
    'rbwat314': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'qk1g2kks': {
      'ko': '수업계획서',
      'en': '',
    },
    'zeiudwrq': {
      'ko': ' ▶',
      'en': '',
    },
    'yqgln2k1': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '8x4e2vhu': {
      'ko': '강의 자료실',
      'en': '',
    },
    'z9wntb7a': {
      'ko': ' ▶',
      'en': '',
    },
    '274gaj3c': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'h50mh691': {
      'ko': '학생 작품 평가표',
      'en': '',
    },
    'a4ywbbw0': {
      'ko': ' ▶',
      'en': '',
    },
    'bwhfga2u': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'q46iykah': {
      'ko': '출석부',
      'en': '',
    },
    'p3guzu78': {
      'ko': ' ▶',
      'en': '',
    },
    'wgwr13df': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '9hiepb6a': {
      'ko': '성적기록표',
      'en': '',
    },
    'cwkhxzem': {
      'ko': ' ▶',
      'en': '',
    },
    'pxz9eule': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'el90x0ex': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'jnxa9iyq': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'pz266oed': {
      'ko': '미제출 조회',
      'en': '',
    },
    'wapo7nx0': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    '5jbooc6h': {
      'ko': '미제출 조회',
      'en': '',
    },
    'ao46vj9q': {
      'ko': ' 교수님',
      'en': '',
    },
    'jpwhodch': {
      'ko': '과목 진행 상황을 조회 할 수 있습니다.',
      'en': '',
    },
    'w1jc45of': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Dahsboard
  {
    'cwhlkctc': {
      'ko': '년도 선택',
      'en': '',
    },
    'tf5jjvd3': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'l07d0v9h': {
      'ko': '학기 선택',
      'en': '',
    },
    '7a7tzl1m': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '5hv0jwqm': {
      'ko': '년',
      'en': '',
    },
    'fdeo5drc': {
      'ko': '전체 자료 다운로드',
      'en': '',
    },
    'm0lw6wty': {
      'ko': '1학년 담당과목',
      'en': '',
    },
    '22h386v2': {
      'ko': '2학년 담당과목',
      'en': '',
    },
    'vdtx93z8': {
      'ko': '3학년 담당과목',
      'en': '',
    },
    'eju3bwf6': {
      'ko': '4학년 담당과목',
      'en': '',
    },
    'geoejd22': {
      'ko': '5학년 담당과목',
      'en': '',
    },
    'vdrz3353': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'gcy9na91': {
      'ko': '1분반',
      'en': '',
    },
    'ayt3ftr4': {
      'ko': '바로가기',
      'en': '',
    },
    'rr3rx57j': {
      'ko': '2분반',
      'en': '',
    },
    '5fk6gw3j': {
      'ko': '바로가기',
      'en': '',
    },
    '6be9z02a': {
      'ko': '3분반',
      'en': '',
    },
    'v00n4hh0': {
      'ko': '바로가기',
      'en': '',
    },
    'uv86u4k7': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    '2dyjl96e': {
      'ko': '바로가기',
      'en': '',
    },
    'at3bsps2': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'lr2yp591': {
      'ko': '바로가기',
      'en': '',
    },
    '89yf7wud': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'k5v25vr0': {
      'ko': '바로가기',
      'en': '',
    },
    '8rbttqk6': {
      'ko': '과목 진행사항을 조회 할 수 있습니다',
      'en': '',
    },
    '039zcdui': {
      'ko': '총 진행사항',
      'en': '',
    },
    'i4hpyeyi': {
      'ko': '0%',
      'en': '',
    },
    '7tz9j7qq': {
      'ko': '100%',
      'en': '',
    },
    'fpqfyogv': {
      'ko': '1분반',
      'en': '',
    },
    '4134hbp6': {
      'ko': '김승 교수님',
      'en': '',
    },
    'll5u2oer': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'yc2tezrq': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'plc59xf4': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    '9qpk2nb0': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '9sc5gb82': {
      'ko': '학부생 등록 여부',
      'en': '',
    },
    'q3jmqhav': {
      'ko': ' ▶',
      'en': '',
    },
    '9dtxdj6b': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '78ump1vo': {
      'ko': '수업계획서',
      'en': '',
    },
    '31v2bd70': {
      'ko': ' ▶',
      'en': '',
    },
    'wmv0ycn5': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'nr0th9w8': {
      'ko': '강의 자료실',
      'en': '',
    },
    '4owj5uk5': {
      'ko': ' ▶',
      'en': '',
    },
    'px2mnmw8': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'kdzq0cs9': {
      'ko': '학생작품 평가표',
      'en': '',
    },
    'qp1d191a': {
      'ko': ' ▶',
      'en': '',
    },
    'ehzmcuiq': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'y85a4q2d': {
      'ko': '출석부',
      'en': '',
    },
    '50uon9k3': {
      'ko': ' ▶',
      'en': '',
    },
    'e7s3qeew': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'kcpukx46': {
      'ko': '성적기록표',
      'en': '',
    },
    'ehxlcob5': {
      'ko': ' ▶',
      'en': '',
    },
    'fkckkmnd': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'co5pkllj': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'un5nksc4': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'fufmw55a': {
      'ko': '미제출 조회',
      'en': '',
    },
    '47a4iqkf': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'hima4f8p': {
      'ko': '미제출 조회',
      'en': '',
    },
    '2xb3mtb9': {
      'ko': '2분반',
      'en': '',
    },
    '22nu9f9y': {
      'ko': '윤석현 교수님',
      'en': '',
    },
    'ldiiq3de': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'viy8iqhz': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'l6matdyx': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'qe71b6i7': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '95kc7p8o': {
      'ko': '학부생 등록 여부',
      'en': '',
    },
    'j3c5t0ja': {
      'ko': ' ▶',
      'en': '',
    },
    '6ekye2xl': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '5eebhe65': {
      'ko': '수업계획서',
      'en': '',
    },
    'j1ij0tr7': {
      'ko': ' ▶',
      'en': '',
    },
    'kiknjibt': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '0wjz98ct': {
      'ko': '강의 자료실',
      'en': '',
    },
    'yonr5dzg': {
      'ko': ' ▶',
      'en': '',
    },
    '2r1gv35m': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'twxcpqjy': {
      'ko': '학생작품 평가표',
      'en': '',
    },
    '8bxls8p8': {
      'ko': ' ▶',
      'en': '',
    },
    'g4h7q2e3': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'nxa6yvvi': {
      'ko': '출석부',
      'en': '',
    },
    'w9szyt3e': {
      'ko': ' ▶',
      'en': '',
    },
    'jsq0xuyh': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'omj68oer': {
      'ko': '성적기록표',
      'en': '',
    },
    'wrvd7vbp': {
      'ko': ' ▶',
      'en': '',
    },
    's71pc8fb': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'uww9h3s1': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    '4ius59k0': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    '3ls1zdzt': {
      'ko': '미제출 조회',
      'en': '',
    },
    'ujwyhtgh': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'h80od66m': {
      'ko': '미제출 조회',
      'en': '',
    },
    '494pp56s': {
      'ko': '3분반',
      'en': '',
    },
    'reciywmz': {
      'ko': '정미소 교수님',
      'en': '',
    },
    '1z3nhzj0': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'ch00p70i': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    '8aosteyi': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'xtyvcopa': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'vc52ttu8': {
      'ko': '학부생 등록 여부',
      'en': '',
    },
    'sonpuwj9': {
      'ko': ' ▶',
      'en': '',
    },
    'agc4zp91': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'tcpgruju': {
      'ko': '수업계획서',
      'en': '',
    },
    'xgclb77l': {
      'ko': ' ▶',
      'en': '',
    },
    '9rlk4fz4': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'td8v1rbk': {
      'ko': '강의 자료실',
      'en': '',
    },
    '1wmceqis': {
      'ko': ' ▶',
      'en': '',
    },
    'w6n6dn5i': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'mytj3be9': {
      'ko': '학생작품 평가표',
      'en': '',
    },
    'op55nw7p': {
      'ko': ' ▶',
      'en': '',
    },
    'lm8zzox1': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'wntvicwm': {
      'ko': '출석부',
      'en': '',
    },
    'f4xkks3m': {
      'ko': ' ▶',
      'en': '',
    },
    'rqpwu1ij': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'yh9fpcte': {
      'ko': '성적기록표',
      'en': '',
    },
    'gf7porfo': {
      'ko': ' ▶',
      'en': '',
    },
    'uyb54d88': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'sz6ya592': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'l1la33d1': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'xpduaqwg': {
      'ko': '미제출 조회',
      'en': '',
    },
    'mus7wg8d': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'qiy5bz2x': {
      'ko': '미제출 조회',
      'en': '',
    },
    'rtwrosvd': {
      'ko': '과목 진행사항을 조회 할 수 있습니다',
      'en': '',
    },
    'nbszenmn': {
      'ko': '총 진행사항',
      'en': '',
    },
    '9iiler5o': {
      'ko': '0%',
      'en': '',
    },
    'ae5ml8yp': {
      'ko': '100%',
      'en': '',
    },
    '18ywkhzb': {
      'ko': '전체 반',
      'en': '',
    },
    '4p5gk6s0': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'enrol7sp': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'puhbh3h7': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    '6d3lwjfk': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'ltddw2gp': {
      'ko': '학부생 등록 여부',
      'en': '',
    },
    'lhvas5p7': {
      'ko': ' ▶',
      'en': '',
    },
    'gvrczhgw': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'x64rmuc1': {
      'ko': '수업계획서',
      'en': '',
    },
    'kurqscya': {
      'ko': ' ▶',
      'en': '',
    },
    'd7uagk80': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'o743clgp': {
      'ko': '강의 자료실',
      'en': '',
    },
    '71mzzro7': {
      'ko': ' ▶',
      'en': '',
    },
    'r3s6cnr3': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'iuvdx0dj': {
      'ko': '학생작품 평가표',
      'en': '',
    },
    'o4x8vgfc': {
      'ko': ' ▶',
      'en': '',
    },
    'ejgnq7wc': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '42pj9zd6': {
      'ko': '출석부',
      'en': '',
    },
    'l6nm6gbu': {
      'ko': ' ▶',
      'en': '',
    },
    'o37a8zg5': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'l866yk3e': {
      'ko': '성적기록표',
      'en': '',
    },
    '390psnv3': {
      'ko': ' ▶',
      'en': '',
    },
    'vebrm36f': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '6mqtanoh': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    '0tgs4ibj': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'xvfemf7r': {
      'ko': '미제출 조회',
      'en': '',
    },
    'vxacirbj': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'yxowiym5': {
      'ko': '미제출 조회',
      'en': '',
    },
    '4jsxcdyu': {
      'ko': '과목 진행사항을 조회 할 수 있습니다',
      'en': '',
    },
    'k4xckume': {
      'ko': '총 진행사항',
      'en': '',
    },
    'qi4otex1': {
      'ko': '0%',
      'en': '',
    },
    '244o8hgi': {
      'ko': '100%',
      'en': '',
    },
    'e67zll89': {
      'ko': '전체 반',
      'en': '',
    },
    '9j6yje2k': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'nxh0rhns': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    '6wf0odw3': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    '2rjimcbr': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'bz72plg9': {
      'ko': '학부생 등록 여부',
      'en': '',
    },
    'xpwbtryk': {
      'ko': ' ▶',
      'en': '',
    },
    '38nebo0m': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'oeu9c8jv': {
      'ko': '수업계획서',
      'en': '',
    },
    'qini47qq': {
      'ko': ' ▶',
      'en': '',
    },
    '2e3ml94l': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'k22qs7ej': {
      'ko': '강의 자료실',
      'en': '',
    },
    'qmjch2j7': {
      'ko': ' ▶',
      'en': '',
    },
    'suxukwcz': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'phs0ttzf': {
      'ko': '학생작품 평가표',
      'en': '',
    },
    'j7p6o9bq': {
      'ko': ' ▶',
      'en': '',
    },
    'rlbyoemk': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    't5cqmzjz': {
      'ko': '출석부',
      'en': '',
    },
    'nsayaz8r': {
      'ko': ' ▶',
      'en': '',
    },
    'f2kp0fnd': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'hj14vtan': {
      'ko': '성적기록표',
      'en': '',
    },
    '44g1k7ms': {
      'ko': ' ▶',
      'en': '',
    },
    '97d716mn': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'y1n287g1': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'hogts2om': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    '90jicq1p': {
      'ko': '미제출 조회',
      'en': '',
    },
    'rtfw2s1o': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'hlppzzgl': {
      'ko': '미제출 조회',
      'en': '',
    },
    'voy568ae': {
      'ko': '과목 진행사항을 조회 할 수 있습니다',
      'en': '',
    },
    '5bjnqsrx': {
      'ko': '총 진행사항',
      'en': '',
    },
    'ih1ghvx2': {
      'ko': '0%',
      'en': '',
    },
    'jn2kegy7': {
      'ko': '100%',
      'en': '',
    },
    '4bnwvckl': {
      'ko': '전체 반',
      'en': '',
    },
    'gt528rse': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'jo857j05': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'nx1qloxd': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'm27va2n0': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'jpxi5dn0': {
      'ko': '학부생 등록 여부',
      'en': '',
    },
    '1oqe86g5': {
      'ko': ' ▶',
      'en': '',
    },
    '4r8agzmp': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'ytq1bvxg': {
      'ko': '수업계획서',
      'en': '',
    },
    'v5ov3357': {
      'ko': ' ▶',
      'en': '',
    },
    '7vnra11p': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'wiocehrj': {
      'ko': '강의 자료실',
      'en': '',
    },
    'slgxktmc': {
      'ko': ' ▶',
      'en': '',
    },
    'ike0s8n8': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'jhyvadb2': {
      'ko': '학생작품 평가표',
      'en': '',
    },
    'pj8bjt71': {
      'ko': ' ▶',
      'en': '',
    },
    'd0k3h6ca': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '3gwf2ggj': {
      'ko': '출석부',
      'en': '',
    },
    'xm5vbjnp': {
      'ko': ' ▶',
      'en': '',
    },
    'daop1ot1': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'jzag4zqa': {
      'ko': '성적기록표',
      'en': '',
    },
    'm9ilp1uv': {
      'ko': ' ▶',
      'en': '',
    },
    'ox0bnn42': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '9gzagvr5': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'uz6ezw0q': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'ata4vu2x': {
      'ko': '미제출 조회',
      'en': '',
    },
    'ulgosscr': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'jnz2b5mg': {
      'ko': '미제출 조회',
      'en': '',
    },
    'pwj26x2d': {
      'ko': 'Home',
      'en': '',
    },
  },
  // test
  {
    '8qzqvt69': {
      'ko': 'Page Title',
      'en': '',
    },
    '15u64qin': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Prof_AttendanceSheet
  {
    '4cnhhdkd': {
      'ko': '출석부',
      'en': '',
    },
    'z2ombhkr': {
      'ko': '다운로드[받기]',
      'en': '',
    },
    '6jxq3gpa': {
      'ko': '업로드',
      'en': '',
    },
    '6i2h57ed': {
      'ko': '삭제',
      'en': '',
    },
    '3fizwv87': {
      'ko': '미리 보기',
      'en': '',
    },
    'z9zqdal9': {
      'ko': '출석부',
      'en': '',
    },
    'qvugv7pu': {
      'ko': '다운로드[받기]',
      'en': '',
    },
    'vt0bhlgh': {
      'ko': '업로드',
      'en': '',
    },
    'f6w4ij34': {
      'ko': '삭제',
      'en': '',
    },
    'sj8whyl1': {
      'ko': '미리 보기',
      'en': '',
    },
    'txhofn17': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Prof_GradeSheet
  {
    'kkruzbiy': {
      'ko': '성적기록표',
      'en': '',
    },
    'cy4s8031': {
      'ko': '다운로드[받기]',
      'en': '',
    },
    'i0vzeke1': {
      'ko': '업로드',
      'en': '',
    },
    '6lbubyux': {
      'ko': '삭제',
      'en': '',
    },
    '8i3q8hem': {
      'ko': '미리 보기',
      'en': '',
    },
    'eo62d2xi': {
      'ko': '성적기록표',
      'en': '',
    },
    'zaruvjds': {
      'ko': '다운로드[받기]',
      'en': '',
    },
    'mv38mdpj': {
      'ko': '업로드',
      'en': '',
    },
    'dwvjl0xr': {
      'ko': '삭제',
      'en': '',
    },
    'z7v1u64e': {
      'ko': '미리 보기',
      'en': '',
    },
    'z1tkvy68': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Prof_LectureMaterials
  {
    'i2qnk69u': {
      'ko': '강의자료실',
      'en': '',
    },
    'wbeqsdf1': {
      'ko': '업로드',
      'en': '',
    },
    'dc0c2gry': {
      'ko': '삭제',
      'en': '',
    },
    'dyium1hw': {
      'ko': '미리 보기',
      'en': '',
    },
    '04eze4va': {
      'ko': '강의자료실',
      'en': '',
    },
    't0j7ersv': {
      'ko': '업로드',
      'en': '',
    },
    'q5x115b9': {
      'ko': '삭제',
      'en': '',
    },
    'v8tl6w12': {
      'ko': '미리 보기',
      'en': '',
    },
    'nxkcm3pe': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Prof_SubjectPortpolio
  {
    'xcujthmn': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'it6v31gf': {
      'ko': '다운로드',
      'en': '',
    },
    'p47o3d98': {
      'ko': '크리틱 내용',
      'en': '',
    },
    'hnnsauoe': {
      'ko': '수정',
      'en': '',
    },
    '4vzws7o6': {
      'ko':
          '(예시)\n- 대지의 경사를 더욱 활용하였으면 함. - 프로그램의 짜임새를 더욱 견고하게 만들 필요가 있음. - 요소를 줄여야 할 필요가 있음.',
      'en': '',
    },
    'hoivx3nz': {
      'ko': '',
      'en': '',
    },
    'rah490sl': {
      'ko': '미리 보기',
      'en': '',
    },
    'inqaws2v': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'akfryvl5': {
      'ko': '다운로드',
      'en': '',
    },
    '529gre6j': {
      'ko': '크리틱 내용',
      'en': '',
    },
    '0oqzslbq': {
      'ko': '수정',
      'en': '',
    },
    '48so4l7i': {
      'ko':
          '(예시)\n- 대지의 경사를 더욱 활용하였으면 함. - 프로그램의 짜임새를 더욱 견고하게 만들 필요가 있음. - 요소를 줄여야 할 필요가 있음.',
      'en': '',
    },
    'd4stt9a6': {
      'ko': '',
      'en': '',
    },
    '4k9x90sv': {
      'ko': '미리 보기',
      'en': '',
    },
    'n1rh456g': {
      'ko': 'Home',
      'en': '',
    },
  },
  // StudentWorkEvalForm
  {
    'zi5q2f8p': {
      'ko': '학생작품평가',
      'en': '',
    },
    '0wt3ed21': {
      'ko': '업로드',
      'en': '',
    },
    'dpm8cd04': {
      'ko': '삭제',
      'en': '',
    },
    'pmx6pyuv': {
      'ko': '학생작품평가',
      'en': '',
    },
    'bijq6ntg': {
      'ko': '업로드',
      'en': '',
    },
    'd26jlaa3': {
      'ko': '삭제',
      'en': '',
    },
    '1waph6ue': {
      'ko': 'Home',
      'en': '',
    },
  },
  // StudentRegistration
  {
    'scguf31g': {
      'ko': '학부생 관리',
      'en': '',
    },
    'zh01oh3z': {
      'ko': '수강 신청한 명단',
      'en': '',
    },
    'kchzo6ie': {
      'ko': 'Search here ...',
      'en': '',
    },
    'rbldhrte': {
      'ko': '이름',
      'en': '',
    },
    'vlzx2i98': {
      'ko': '학번',
      'en': '',
    },
    'i4fdg9eo': {
      'ko': '성별',
      'en': '',
    },
    'qz2ehhaz': {
      'ko': '재학',
      'en': '',
    },
    '47vlfv31': {
      'ko': '아직 수강 신청한 학생이 없습니다.',
      'en': '',
    },
    'lducfbyp': {
      'ko': '새로고침',
      'en': '',
    },
    'yn4zu9au': {
      'ko': '학생수',
      'en': '',
    },
    'j6tf7hix': {
      'ko': '0명',
      'en': '',
    },
    'b84slgld': {
      'ko': '문서 사용 관리',
      'en': '',
    },
    'yhzfcen0': {
      'ko': '순서',
      'en': '',
    },
    '3h07sjuj': {
      'ko': '메뉴명',
      'en': '',
    },
    '8mbqqsjr': {
      'ko': '사용',
      'en': '',
    },
    'swzeu7ju': {
      'ko': '관리자',
      'en': '',
    },
    'be8btvd6': {
      'ko': '파일 형식',
      'en': '',
    },
    'ugk0p28i': {
      'ko': '공유',
      'en': '',
    },
    'cjfb111b': {
      'ko': '+ 목록 추가',
      'en': '',
    },
    'qascsm3f': {
      'ko': '목력명을 입력해주세요',
      'en': '',
    },
    '04g6bgo4': {
      'ko': ' 목록 파일 형식',
      'en': '',
    },
    '78br1wje': {
      'ko': '리스트 형식',
      'en': '',
    },
    '0x833i5e': {
      'ko': '블로그 형식',
      'en': '',
    },
    'hge5dp5r': {
      'ko': '성과물 형식',
      'en': '',
    },
    'swqzx8o0': {
      'ko': '관리자 설정',
      'en': '',
    },
    '9dipjafs': {
      'ko': '교수님',
      'en': '',
    },
    '1jd7xc8d': {
      'ko': '학부생',
      'en': '',
    },
    'yej159fb': {
      'ko': '교수+학생',
      'en': '',
    },
    'ebmigl84': {
      'ko': '공개설정',
      'en': '',
    },
    'fvebqetd': {
      'ko': '학부생',
      'en': '',
    },
    'hn9ozxq6': {
      'ko': '교수+학생',
      'en': '',
    },
    'cyud1rqn': {
      'ko': '추가',
      'en': '',
    },
    'caflz2i1': {
      'ko': '취소',
      'en': '',
    },
    '6t7n4ksl': {
      'ko': '적용',
      'en': '',
    },
    '6jrh8afa': {
      'ko': '취소',
      'en': '',
    },
    'jvvs5xul': {
      'ko': 'Home',
      'en': '',
    },
  },
  // MyProfileCopy
  {
    'syl03frv': {
      'ko': 'upload',
      'en': '',
    },
    'w0gwoml0': {
      'ko': '성명',
      'en': '',
    },
    '6c0q2ar5': {
      'ko': '연락처',
      'en': '',
    },
    '9hkc70md': {
      'ko': '010-1234-5678',
      'en': '',
    },
    'm962c8yk': {
      'ko': '출생연도',
      'en': '',
    },
    '6a3wmds4': {
      'ko': '0000',
      'en': '',
    },
    'ij7vav4m': {
      'ko': '이메일',
      'en': '',
    },
    'ebv3nd62': {
      'ko': '소속기관',
      'en': '',
    },
    'f5q6vcl1': {
      'ko': '순천향대학교 건축학과',
      'en': '',
    },
    'i9slacsj': {
      'ko': '직책',
      'en': '',
    },
    'czhsbzas': {
      'ko': '000 건축사회 부장',
      'en': '',
    },
    '843iwzbj': {
      'ko': '교수/직급',
      'en': '',
    },
    'h9zldcn0': {
      'ko': '중복선택 불가',
      'en': '',
    },
    'xreyiwt9': {
      'ko': '교수',
      'en': '',
    },
    '99o8od91': {
      'ko': '겸임\n교수',
      'en': '',
    },
    'qxw8cv4k': {
      'ko': '부교수',
      'en': '',
    },
    'f69mty0y': {
      'ko': '외래\n강사',
      'en': '',
    },
    'smxxch1x': {
      'ko': '조교수',
      'en': '',
    },
    'rnlh1zo3': {
      'ko': '자격증여부',
      'en': '',
    },
    'dtli5q5w': {
      'ko': '중복선택 가능',
      'en': '',
    },
    'dzt1e6fa': {
      'ko': '건축사 X',
      'en': '',
    },
    '8u58zofl': {
      'ko': '건축사 (KR)',
      'en': '',
    },
    'jeub8arn': {
      'ko': '건축사 해외',
      'en': '',
    },
    'hjt0bwdl': {
      'ko': '건축사 취득국가',
      'en': '',
    },
    'yq032tyk': {
      'ko': '기술사 X',
      'en': '',
    },
    '6bf8sfyf': {
      'ko': '기술사(KR)',
      'en': '',
    },
    '1he0p1ny': {
      'ko': '기술사 해외',
      'en': '',
    },
    'szjzvcc6': {
      'ko': '기술사 취득국가',
      'en': '',
    },
    'qtb5ypgg': {
      'ko': '전문분야',
      'en': '',
    },
    'x1ia6st0': {
      'ko': '중복선택 가능',
      'en': '',
    },
    'r1ezyopo': {
      'ko': '설계분야',
      'en': '',
    },
    'baecsl8i': {
      'ko': '디지털분야',
      'en': '',
    },
    'uwcp41io': {
      'ko': '환경분야',
      'en': '',
    },
    'nqryuout': {
      'ko': '기타',
      'en': '',
    },
    'worbok3j': {
      'ko': '기타 전문분야',
      'en': '',
    },
    '2fxygvom': {
      'ko': '시공분야',
      'en': '',
    },
    'nwlhyvd3': {
      'ko': '구조분야',
      'en': '',
    },
    'lhnxjuw6': {
      'ko': '조경분야',
      'en': '',
    },
    'z2ukp1tq': {
      'ko': '[학력 설정]',
      'en': '',
    },
    'u52kc9ei': {
      'ko': '추가 +',
      'en': '',
    },
    '28t67ks9': {
      'ko': '삭제 -',
      'en': '',
    },
    '23mdxajr': {
      'ko': '[강사 경력]',
      'en': '',
    },
    '2nfo27a4': {
      'ko': '기간',
      'en': '',
    },
    'wtfcsn9z': {
      'ko': '0000.00~0000.00',
      'en': '',
    },
    '9mrsgwz8': {
      'ko': '학교/학과',
      'en': '',
    },
    'htzi3pn3': {
      'ko': '0000 대학교/000과',
      'en': '',
    },
    '749ardfd': {
      'ko': '과목',
      'en': '',
    },
    '6kr3cdnj': {
      'ko': '00000',
      'en': '',
    },
    'pluhe71c': {
      'ko': '학점/시간',
      'en': '',
    },
    'gs9twh0e': {
      'ko': '00/00',
      'en': '',
    },
    'szr24l5f': {
      'ko': '추가 +',
      'en': '',
    },
    'c685e6m6': {
      'ko': '[주요성과 및 프로젝트]',
      'en': '',
    },
    '44bqvfbt': {
      'ko': '논문, 참여 프로젝트 수상 작성 등',
      'en': '',
    },
    'ixpelm3y': {
      'ko': '적용',
      'en': '',
    },
    '641lonyz': {
      'ko': '취소',
      'en': '',
    },
    'rvl0r93n': {
      'ko': 'Home',
      'en': '',
    },
  },
  // testCopy
  {
    '9e7gbc77': {
      'ko': 'Home',
      'en': '',
    },
  },
  // StudentRegistrationCopy
  {
    'sxxa719k': {
      'ko': '학부생 관리',
      'en': '',
    },
    '74mmvhhk': {
      'ko': '수강 신청한 명단',
      'en': '',
    },
    'sua30mfb': {
      'ko': 'Search here ...',
      'en': '',
    },
    'te9zues7': {
      'ko': '아직 수강 신청한 학생이 없습니다.',
      'en': '',
    },
    'lh3zgbqm': {
      'ko': '새로고침',
      'en': '',
    },
    'e2v8ht8h': {
      'ko': '학생수\n',
      'en': '',
    },
    'od1z045g': {
      'ko': '0명',
      'en': '',
    },
    '3n7c7lf2': {
      'ko': '문서 사용 관리',
      'en': '',
    },
    'bnlzvx1l': {
      'ko': '순서',
      'en': '',
    },
    'irzov03g': {
      'ko': '메뉴명',
      'en': '',
    },
    'q3tr5105': {
      'ko': '사용',
      'en': '',
    },
    '1wls8jf5': {
      'ko': '관리자',
      'en': '',
    },
    '6cm8qjmn': {
      'ko': '파일 형식',
      'en': '',
    },
    'y9gc9nv8': {
      'ko': '공유',
      'en': '',
    },
    '5jjb8yyw': {
      'ko': '+ 목록 추가',
      'en': '',
    },
    'mswsghwg': {
      'ko': '목력명을 입력해주세요',
      'en': '',
    },
    'sk30iwgn': {
      'ko': ' 목록 파일 형식',
      'en': '',
    },
    'ryusn0hd': {
      'ko': '리스트 형식',
      'en': '',
    },
    'ah4tn7b1': {
      'ko': '블로그 형식',
      'en': '',
    },
    'ollmwmjd': {
      'ko': '성과물 형식',
      'en': '',
    },
    'tjz1l705': {
      'ko': '관리자 설정',
      'en': '',
    },
    'gqmdec68': {
      'ko': '교수님',
      'en': '',
    },
    'dm4odwp3': {
      'ko': '학부생',
      'en': '',
    },
    'ni4x8qwz': {
      'ko': '교수+학생',
      'en': '',
    },
    '84ysmzax': {
      'ko': '공개설정',
      'en': '',
    },
    '2b6kktw4': {
      'ko': '학부생',
      'en': '',
    },
    'jk34a4nv': {
      'ko': '교수+학생',
      'en': '',
    },
    'i3121fc5': {
      'ko': '추가',
      'en': '',
    },
    'r59bzbs6': {
      'ko': '취소',
      'en': '',
    },
    '2exy9khh': {
      'ko': '적용',
      'en': '',
    },
    'z7e71jmw': {
      'ko': '취소',
      'en': '',
    },
    '7shgt0jb': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Student_SubjectPortpolio
  {
    'm2zmszc4': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'bskn0hft': {
      'ko': '작성',
      'en': '',
    },
    'v7jsgl7n': {
      'ko': '업로드된 파일이 없습니다.',
      'en': '',
    },
    'n1klggsg': {
      'ko': '수정',
      'en': '',
    },
    'u1lgvn4c': {
      'ko': '삭제',
      'en': '',
    },
    'aotkj4e0': {
      'ko': '크리틱 내용',
      'en': '',
    },
    '3i1l0zu3': {
      'ko': '미리 보기',
      'en': '',
    },
    'qbeqber0': {
      'ko': '제출',
      'en': '',
    },
    'zglg400y': {
      'ko': '크리틱 작성',
      'en': '',
    },
    'j3lq8z1b': {
      'ko': '작성 완료',
      'en': '',
    },
    '87galvls': {
      'ko':
          '(예시)\n- 대지의 경사를 더욱 활용하였으면 함. - 프로그램의 짜임새를 더욱 견고하게 만들 필요가 있음. - 요소를 줄여야 할 필요가 있음.',
      'en': '',
    },
    'oxhooh1e': {
      'ko':
          '- 대지의 경사를 더욱 활용하였으면 함.\n- 프로그램의 짜임새를 더욱 견고하게 만들 필요가 있음.\n- 요소를 줄여야 할 필요가 있음.\n',
      'en': '',
    },
    '140zoj98': {
      'ko': '아직 제출한 파일이 없습니다.',
      'en': '',
    },
    'imqkc16y': {
      'ko': '파일 업로드',
      'en': '',
    },
    'e6jelmwo': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'uw31b71x': {
      'ko': '작성',
      'en': '',
    },
    'unjnegd2': {
      'ko': '업로드된 파일이 없습니다.',
      'en': '',
    },
    'esa1bv1g': {
      'ko': '수정',
      'en': '',
    },
    'g4zrznfl': {
      'ko': '삭제',
      'en': '',
    },
    'tf4jzlld': {
      'ko': '크리틱 내용',
      'en': '',
    },
    'pw21bgu6': {
      'ko': '미리 보기',
      'en': '',
    },
    'qtbtfuxv': {
      'ko': '제출',
      'en': '',
    },
    'm970g3px': {
      'ko': '크리틱 작성',
      'en': '',
    },
    'fi412gk3': {
      'ko': '작성 완료',
      'en': '',
    },
    'qek6g4lh': {
      'ko':
          '(예시)\n- 대지의 경사를 더욱 활용하였으면 함. - 프로그램의 짜임새를 더욱 견고하게 만들 필요가 있음. - 요소를 줄여야 할 필요가 있음.',
      'en': '',
    },
    '7da2nte3': {
      'ko':
          '- 대지의 경사를 더욱 활용하였으면 함.\n- 프로그램의 짜임새를 더욱 견고하게 만들 필요가 있음.\n- 요소를 줄여야 할 필요가 있음.\n',
      'en': '',
    },
    '6og0j7sv': {
      'ko': '아직 제출한 파일이 없습니다.',
      'en': '',
    },
    '2x5gdvkg': {
      'ko': '파일 업로드',
      'en': '',
    },
    'a2xolwzl': {
      'ko': 'Home',
      'en': '',
    },
  },
  // CalendarDetail
  {
    '43v8ce8t': {
      'ko': '일정 등록',
      'en': '',
    },
    't4xhsj76': {
      'ko': '0주차 과제물 제출',
      'en': '',
    },
    'oo0q8afp': {
      'ko': '0주차 과제물 제출',
      'en': '',
    },
    'lnuxlx7x': {
      'ko': '0주차 과제물 제출',
      'en': '',
    },
    'b5pug9ch': {
      'ko': '0주차 과제물 제출',
      'en': '',
    },
    '4o5iw0w1': {
      'ko': '공유 대상',
      'en': '',
    },
    '5xryljd4': {
      'ko': '000 건축사회 부장',
      'en': '',
    },
    '8uaksksk': {
      'ko': '장소',
      'en': '',
    },
    'op3uikki': {
      'ko': '000 건축사회 부장',
      'en': '',
    },
    '10lszu5o': {
      'ko': 'Home',
      'en': '',
    },
  },
  // AdminDashBackup
  {
    'cbmtopcl': {
      'ko': '년도 선택',
      'en': '',
    },
    '4heffbpg': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'evigsejt': {
      'ko': '학기 선택',
      'en': '',
    },
    'sbd9b4tu': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '7hb1i75a': {
      'ko': '년',
      'en': '',
    },
    '0dxq423w': {
      'ko': '  ',
      'en': '',
    },
    'ti5x7ito': {
      'ko': '1학년 담당과목',
      'en': '',
    },
    'x9pqdcmk': {
      'ko': '2학년 담당과목',
      'en': '',
    },
    'qt1640d4': {
      'ko': '3학년 담당과목',
      'en': '',
    },
    '3drc1ef6': {
      'ko': '4학년 담당과목',
      'en': '',
    },
    'hmva5agl': {
      'ko': '5학년 담당과목',
      'en': '',
    },
    'ijnla83y': {
      'ko': '',
      'en': '',
    },
    'lmkjbyqj': {
      'ko': '조회중인 전공과목 (분반)',
      'en': '',
    },
    'egc41xh6': {
      'ko': 'Search...',
      'en': '',
    },
    'kwlfth5o': {
      'ko': '건축설계I',
      'en': '',
    },
    '2bj05gii': {
      'ko': '건축설계III',
      'en': '',
    },
    '51ubo4xq': {
      'ko': '건축설계V',
      'en': '',
    },
    'zn7bmy6p': {
      'ko': '건축설계VII',
      'en': '',
    },
    'foqwb7h1': {
      'ko': '건축설계IX',
      'en': '',
    },
    'ecknnd1i': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'l4m0b4ts': {
      'ko': '1분반',
      'en': '',
    },
    'gpfd2ymo': {
      'ko': ' 교수님',
      'en': '',
    },
    'm414448w': {
      'ko': '바로가기',
      'en': '',
    },
    'z919nysc': {
      'ko': '2분반',
      'en': '',
    },
    '4oxukaqk': {
      'ko': ' 교수님',
      'en': '',
    },
    'o6uqc1sx': {
      'ko': '바로가기',
      'en': '',
    },
    'pp469n2c': {
      'ko': '3분반',
      'en': '',
    },
    't6ya6157': {
      'ko': ' 교수님',
      'en': '',
    },
    'bj0u6n9u': {
      'ko': '바로가기',
      'en': '',
    },
    'vriy09hx': {
      'ko': '총 진행사항',
      'en': '',
    },
    'ftyz47r2': {
      'ko': '0%',
      'en': '',
    },
    '9cpo94e3': {
      'ko': '100%',
      'en': '',
    },
    'pu8z09sz': {
      'ko': '1분반',
      'en': '',
    },
    '2eto4x8u': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'oihtk4eo': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    '7zb815yz': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'wiahe11n': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '9rdbiqem': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    '90um21cw': {
      'ko': '---',
      'en': '',
    },
    'wphbyf86': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '5k9863mg': {
      'ko': '수업계획서',
      'en': '',
    },
    '77pkl16u': {
      'ko': ' ▶',
      'en': '',
    },
    'y6dh0kyg': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'nyvy2aza': {
      'ko': '강의 자료실',
      'en': '',
    },
    'hlxbyjkp': {
      'ko': ' ▶',
      'en': '',
    },
    'syk49rzv': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'v9c5dhv8': {
      'ko': '학생 작품평가표',
      'en': '',
    },
    'gofgbfrc': {
      'ko': ' ▶',
      'en': '',
    },
    '30srqn96': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'lg7hdcry': {
      'ko': '출석부',
      'en': '',
    },
    '6ucl1aun': {
      'ko': ' ▶',
      'en': '',
    },
    'd6kimq6p': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'lwhyes1o': {
      'ko': '성적기록표',
      'en': '',
    },
    '9b400nbj': {
      'ko': ' ▶',
      'en': '',
    },
    'y5pqhi9x': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'xgmc9fqh': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'd7fi6tvz': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'p679x8uv': {
      'ko': ' ▶',
      'en': '',
    },
    'b79jt8bp': {
      'ko': '미제출 조회',
      'en': '',
    },
    'tyu607nz': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    '2g3p4ae1': {
      'ko': ' ▶',
      'en': '',
    },
    '4ei6pkat': {
      'ko': '미제출 조회',
      'en': '',
    },
    'k1070ruc': {
      'ko': '2분반',
      'en': '',
    },
    '0itxwkdq': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '8uhcq240': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'ojj1a3ty': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'v4rveyzo': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'daufh3i3': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    'rtgzlckd': {
      'ko': '---',
      'en': '',
    },
    'pajyqlbp': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'rfwjp92x': {
      'ko': '수업계획서',
      'en': '',
    },
    'sb26kw44': {
      'ko': ' ▶',
      'en': '',
    },
    'ebazejha': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'ya2qxjhr': {
      'ko': '강의 자료실',
      'en': '',
    },
    'ob60a289': {
      'ko': ' ▶',
      'en': '',
    },
    'nshn99th': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'bqmq34nf': {
      'ko': '학생 작품평가표',
      'en': '',
    },
    'iiru424w': {
      'ko': ' ▶',
      'en': '',
    },
    'u7bl6nco': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '91x3ve14': {
      'ko': '출석부',
      'en': '',
    },
    'uhk3sh1a': {
      'ko': ' ▶',
      'en': '',
    },
    't9wyxwdq': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'erc626lf': {
      'ko': '성적기록표',
      'en': '',
    },
    'a1x9xjav': {
      'ko': ' ▶',
      'en': '',
    },
    'b9fntnzy': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'b5ih2jul': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'amvvy245': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    '9way7epw': {
      'ko': ' ▶',
      'en': '',
    },
    'gzmj4xj2': {
      'ko': '미제출 조회',
      'en': '',
    },
    's5ut0mh4': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'kl83wgex': {
      'ko': ' ▶',
      'en': '',
    },
    'vt4cf15h': {
      'ko': '미제출 조회',
      'en': '',
    },
    'k4el2pjh': {
      'ko': '3분반',
      'en': '',
    },
    '2y4o3vuf': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '7ioie7vp': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'i8m82ysm': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'k4l0515d': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'qwuu2b8h': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    '40lfg1ng': {
      'ko': '---',
      'en': '',
    },
    'ezhpvgv1': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'bzpc6hu0': {
      'ko': '수업계획서',
      'en': '',
    },
    'i5mmfkpp': {
      'ko': ' ▶',
      'en': '',
    },
    '2uv6lpze': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '8u1mlo0p': {
      'ko': '강의 자료실',
      'en': '',
    },
    'ddlx8dey': {
      'ko': ' ▶',
      'en': '',
    },
    'ppival8p': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'd9nf229f': {
      'ko': '학생 작품평가표',
      'en': '',
    },
    'jsit35pl': {
      'ko': ' ▶',
      'en': '',
    },
    'paobj6xj': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'zswe3tr4': {
      'ko': '출석부',
      'en': '',
    },
    'swgnxrem': {
      'ko': ' ▶',
      'en': '',
    },
    'ffu3to4z': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'yxvrffig': {
      'ko': '성적기록표',
      'en': '',
    },
    'qqds2u0p': {
      'ko': ' ▶',
      'en': '',
    },
    'x3lz5lm0': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'uq81wt3n': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'xg9ajr28': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    '4mpsfn4c': {
      'ko': ' ▶',
      'en': '',
    },
    'ka99sq2v': {
      'ko': '미제출 조회',
      'en': '',
    },
    '41q34he1': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    '9kc55ply': {
      'ko': ' ▶',
      'en': '',
    },
    '5ia9kefz': {
      'ko': '미제출 조회',
      'en': '',
    },
    'iwzcfigx': {
      'ko': '년도 선택',
      'en': '',
    },
    'zud2qqx8': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '5l4zlggw': {
      'ko': '학기 선택',
      'en': '',
    },
    's5nt6bmi': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'zprmgj5v': {
      'ko': '년',
      'en': '',
    },
    'y3qumb95': {
      'ko': '  ',
      'en': '',
    },
    'x9flv93j': {
      'ko': '1학년 담당과목',
      'en': '',
    },
    'mkvzw9zg': {
      'ko': '2학년 담당과목',
      'en': '',
    },
    '0s3z3g20': {
      'ko': '3학년 담당과목',
      'en': '',
    },
    's6fge195': {
      'ko': '4학년 담당과목',
      'en': '',
    },
    'efaikt29': {
      'ko': '5학년 담당과목',
      'en': '',
    },
    'yzx265gu': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'in8f6ptv': {
      'ko': '1분반',
      'en': '',
    },
    '21mcz3ta': {
      'ko': ' 교수님',
      'en': '',
    },
    '49yuawfr': {
      'ko': '바로가기',
      'en': '',
    },
    '8nbqfu8i': {
      'ko': '2분반',
      'en': '',
    },
    'd9hmcpo7': {
      'ko': ' 교수님',
      'en': '',
    },
    '222tsupx': {
      'ko': '바로가기',
      'en': '',
    },
    'a5my4fo5': {
      'ko': '3분반',
      'en': '',
    },
    'tek70s11': {
      'ko': ' 교수님',
      'en': '',
    },
    'oggtsqmr': {
      'ko': '바로가기',
      'en': '',
    },
    '76p3fhpf': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'wc9bnu22': {
      'ko': '1분반',
      'en': '',
    },
    'vdbcg9ap': {
      'ko': ' 교수님',
      'en': '',
    },
    '9gz9zbi6': {
      'ko': '바로가기',
      'en': '',
    },
    'ig536ygn': {
      'ko': '2분반',
      'en': '',
    },
    '5uthkuj6': {
      'ko': ' 교수님',
      'en': '',
    },
    'imkk66oy': {
      'ko': '바로가기',
      'en': '',
    },
    'crcjgmsq': {
      'ko': '3분반',
      'en': '',
    },
    '78dxh82c': {
      'ko': ' 교수님',
      'en': '',
    },
    '9zq1oj38': {
      'ko': '바로가기',
      'en': '',
    },
    'tzt00m5l': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'a8hvvzoi': {
      'ko': '1분반',
      'en': '',
    },
    'ctgtym4n': {
      'ko': ' 교수님',
      'en': '',
    },
    'u43bvq7m': {
      'ko': '바로가기',
      'en': '',
    },
    'o1llgnjw': {
      'ko': '2분반',
      'en': '',
    },
    'zb710zyy': {
      'ko': ' 교수님',
      'en': '',
    },
    'icmibemp': {
      'ko': '바로가기',
      'en': '',
    },
    '2zxklpep': {
      'ko': '3분반',
      'en': '',
    },
    '052fkcyz': {
      'ko': ' 교수님',
      'en': '',
    },
    '9kc52aiz': {
      'ko': '바로가기',
      'en': '',
    },
    'mxwrqlex': {
      'ko': '총 진행사항',
      'en': '',
    },
    'x7lnmw7f': {
      'ko': '0%',
      'en': '',
    },
    '7attcwpd': {
      'ko': '100%',
      'en': '',
    },
    'vj3pz6dd': {
      'ko': '1분반',
      'en': '',
    },
    'xqw7uc44': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'eq6t7cc8': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'f3j6exiq': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    '9a03sfxw': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'lj34uslw': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    'o8vb80x5': {
      'ko': '---',
      'en': '',
    },
    '0ezlxdlw': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'vxsenvu4': {
      'ko': '수업계획서',
      'en': '',
    },
    'w43bm9r2': {
      'ko': ' ▶',
      'en': '',
    },
    'rgsfgm65': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '8at4uquf': {
      'ko': '강의 자료실',
      'en': '',
    },
    '6douw4g3': {
      'ko': ' ▶',
      'en': '',
    },
    'k9ic9fxh': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '81n1x995': {
      'ko': '학생 작품평가표',
      'en': '',
    },
    'pa5iecov': {
      'ko': ' ▶',
      'en': '',
    },
    'r34o9hhg': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'kcan775n': {
      'ko': '출석부',
      'en': '',
    },
    'mxjjwhgv': {
      'ko': ' ▶',
      'en': '',
    },
    'zfyvydrk': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'vpfu9ykf': {
      'ko': '성적기록표',
      'en': '',
    },
    'f9ktxbdg': {
      'ko': ' ▶',
      'en': '',
    },
    'gpapwad3': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'h6php9dt': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'kjqxphq5': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    '83i48nz5': {
      'ko': ' ▶',
      'en': '',
    },
    'wdfiz0o6': {
      'ko': '미제출 조회',
      'en': '',
    },
    '5idq741r': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'xubk103c': {
      'ko': ' ▶',
      'en': '',
    },
    'be1wdn00': {
      'ko': '미제출 조회',
      'en': '',
    },
    't9rcxixn': {
      'ko': '2분반',
      'en': '',
    },
    'czgffv0g': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'u79w62sl': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    '1a10uqpr': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'zgnr0lll': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'kwvofco1': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    'qkdtvjny': {
      'ko': '---',
      'en': '',
    },
    '0ns414v4': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '1h9vsnmo': {
      'ko': '수업계획서',
      'en': '',
    },
    'fvsn22bb': {
      'ko': ' ▶',
      'en': '',
    },
    'mydyxzp9': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '8xsw64g4': {
      'ko': '강의 자료실',
      'en': '',
    },
    'sou64w3m': {
      'ko': ' ▶',
      'en': '',
    },
    'y14qq0jn': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'lnk3lsnr': {
      'ko': '학생 작품평가표',
      'en': '',
    },
    '36lzicxc': {
      'ko': ' ▶',
      'en': '',
    },
    '2t0b4dq5': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'pmhok3hd': {
      'ko': '출석부',
      'en': '',
    },
    '7ugxo5a8': {
      'ko': ' ▶',
      'en': '',
    },
    'j7k0754z': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'bf6wqox3': {
      'ko': '성적기록표',
      'en': '',
    },
    'yepywu85': {
      'ko': ' ▶',
      'en': '',
    },
    'wqnafu0z': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'dxrt3hl8': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    '59q1zzbs': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'ng0b5k2u': {
      'ko': ' ▶',
      'en': '',
    },
    'z95prccg': {
      'ko': '미제출 조회',
      'en': '',
    },
    '8fhmtzb5': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'mo4f0wvj': {
      'ko': ' ▶',
      'en': '',
    },
    '3phgpzpk': {
      'ko': '미제출 조회',
      'en': '',
    },
    'a1emxq4g': {
      'ko': '3분반',
      'en': '',
    },
    '1duc49lp': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '2f47wcxu': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'e396i443': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'jnxbijcp': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '5jv9g2ey': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    '7e6g4zq1': {
      'ko': '---',
      'en': '',
    },
    'eud6y1jt': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'mgqqs2cj': {
      'ko': '수업계획서',
      'en': '',
    },
    'nbithhhd': {
      'ko': ' ▶',
      'en': '',
    },
    'h08jrdg2': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'qkzgltbi': {
      'ko': '강의 자료실',
      'en': '',
    },
    '5jgqiq8q': {
      'ko': ' ▶',
      'en': '',
    },
    'u1r6a6av': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'r2294til': {
      'ko': '학생 작품평가표',
      'en': '',
    },
    'j8clxbkx': {
      'ko': ' ▶',
      'en': '',
    },
    'hp4hcf73': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '9436ximu': {
      'ko': '출석부',
      'en': '',
    },
    'n8ksi5r6': {
      'ko': ' ▶',
      'en': '',
    },
    'kr9np5jv': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'rxxmv7c7': {
      'ko': '성적기록표',
      'en': '',
    },
    'k76biz1o': {
      'ko': ' ▶',
      'en': '',
    },
    '0jv6mp2n': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '0ygxdlfg': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'eap0hjcm': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'y2q5q5ie': {
      'ko': ' ▶',
      'en': '',
    },
    'acqcq6mb': {
      'ko': '미제출 조회',
      'en': '',
    },
    'dvbl9rx0': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'pi798sku': {
      'ko': ' ▶',
      'en': '',
    },
    '1xpsombb': {
      'ko': '미제출 조회',
      'en': '',
    },
    '4g8nhszn': {
      'ko': '과목 진행 상황을 조회 할 수 있습니다.',
      'en': '',
    },
    'a672h88n': {
      'ko': '과목 진행 상황을 조회 할 수 있습니다.',
      'en': '',
    },
    '0vov0dbk': {
      'ko': 'Home',
      'en': '',
    },
  },
  // AdminStudentSubmit
  {
    'extcxlqb': {
      'ko': '년도 선택',
      'en': '',
    },
    'nhpz5lqn': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'jis3mzxn': {
      'ko': '학기 선택',
      'en': '',
    },
    'chh5lnp6': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'ujkbroa8': {
      'ko': '년',
      'en': '',
    },
    '4h4lfw71': {
      'ko': '  ',
      'en': '',
    },
    'cb5smxo5': {
      'ko': '1학년',
      'en': '',
    },
    'z644kedp': {
      'ko': '2학년',
      'en': '',
    },
    't4w9h8jj': {
      'ko': '3학년',
      'en': '',
    },
    '2jtiwjxs': {
      'ko': '4학년',
      'en': '',
    },
    'jsfpnr5l': {
      'ko': '5학년',
      'en': '',
    },
    '6526ekgw': {
      'ko': '새로고침',
      'en': '',
    },
    '940u35fw': {
      'ko': '학생 명단 조회',
      'en': '',
    },
    'zo1vf76h': {
      'ko': '총 : ',
      'en': '',
    },
    'xptlusld': {
      'ko': '3',
      'en': '',
    },
    'r5ol40ao': {
      'ko': '명',
      'en': '',
    },
    '91w4n2lp': {
      'ko': '학생 명단 조회',
      'en': '',
    },
    '8kaodt8h': {
      'ko': '진행 중인 과목 조회',
      'en': '',
    },
    '0osgyold': {
      'ko': '설계 과목',
      'en': '',
    },
    'm6i2xdco': {
      'ko': '이론 과목',
      'en': '',
    },
    'h91tqbon': {
      'ko': '주차별 설계진행표 제출여부',
      'en': '',
    },
    '1t8sylk9': {
      'ko': '성과물 제출 여부',
      'en': '',
    },
    'mx1uml6h': {
      'ko': '1차 성과물',
      'en': '',
    },
    'aul6tqk2': {
      'ko': '2차 성과물',
      'en': '',
    },
    'd6w310w5': {
      'ko': '총 : ',
      'en': '',
    },
    'umizf6bc': {
      'ko': '4',
      'en': '',
    },
    'deikf977': {
      'ko': '개 과목',
      'en': '',
    },
    '4r3wsq3b': {
      'ko': '진행 중인 과목 조회',
      'en': '',
    },
    'hgq813vt': {
      'ko': '년도 선택',
      'en': '',
    },
    'jqkf9gwa': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'c12osi9j': {
      'ko': '학기 선택',
      'en': '',
    },
    '5yhi0hmv': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '43jaalaz': {
      'ko': '학생 자료 제출 관리',
      'en': '',
    },
    'gi80pb3w': {
      'ko': '1학년',
      'en': '',
    },
    'josjfadp': {
      'ko': '2학년',
      'en': '',
    },
    '1gitq9ve': {
      'ko': '3학년',
      'en': '',
    },
    'citzpo1t': {
      'ko': '4학년',
      'en': '',
    },
    'ndx8lg6w': {
      'ko': '5학년',
      'en': '',
    },
    'b4lpr6zr': {
      'ko': '학생명 ',
      'en': '',
    },
    'dhk419gi': {
      'ko': '학번 | ',
      'en': '',
    },
    't6wd0mem': {
      'ko': '진행 중인 과목 조회',
      'en': '',
    },
    'fhp6osub': {
      'ko': '설계 과목 조회 ▶',
      'en': '',
    },
    'nxf7c4ou': {
      'ko': '이론 과목 조회 ▶',
      'en': '',
    },
    'mw6lzz0u': {
      'ko': '과목 조회',
      'en': '',
    },
    '20nck5h0': {
      'ko': '과목명 ',
      'en': '',
    },
    'm8ij1btv': {
      'ko': '분반',
      'en': '',
    },
    'ogp71xa2': {
      'ko': '주차별 설계진행표 제출 여부',
      'en': '',
    },
    'm52bweqd': {
      'ko': '성과물 제출 여부',
      'en': '',
    },
    '79s6ybte': {
      'ko': '1차 성과물',
      'en': '',
    },
    'dvuu09ph': {
      'ko': '2차 성과물',
      'en': '',
    },
    'tkvhihmf': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Prof_CoursePlan
  {
    'p4tpsk6g': {
      'ko': '수업계획서',
      'en': '',
    },
    'p7pfuj5w': {
      'ko': '다운로드[받기]',
      'en': '',
    },
    'x8hy2mps': {
      'ko': '업로드',
      'en': '',
    },
    'tb3g9w7t': {
      'ko': '삭제',
      'en': '',
    },
    'bzgadvwz': {
      'ko': '미리 보기',
      'en': '',
    },
    'szx1ml88': {
      'ko': '수업계획서',
      'en': '',
    },
    'eo5snsmq': {
      'ko': '다운로드[받기]',
      'en': '',
    },
    'pjqhj7m9': {
      'ko': '업로드',
      'en': '',
    },
    'z8k6bvat': {
      'ko': '삭제',
      'en': '',
    },
    'e0nosak8': {
      'ko': '미리 보기',
      'en': '',
    },
    'mf9gasnr': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Prof_ResultsMidterm
  {
    'm7hs4xfu': {
      'ko': '중간 결과물',
      'en': '',
    },
    'n83ht5dk': {
      'ko': '아직 제출된 파일이 없습니다.',
      'en': '',
    },
    'sg16goxr': {
      'ko': '새로고침',
      'en': '',
    },
    'arha1910': {
      'ko': '미리 보기',
      'en': '',
    },
    '22up2u1i': {
      'ko': '선정한 중간 결과물',
      'en': '',
    },
    'iwad84ds': {
      'ko': '중간 결과물[상]',
      'en': '',
    },
    'w19epvok': {
      'ko': '중간 결과물[중]',
      'en': '',
    },
    'jtx7bbb8': {
      'ko': '중간 결과물[하]',
      'en': '',
    },
    '3g1kugbg': {
      'ko': '중간 결과물',
      'en': '',
    },
    '68wiarft': {
      'ko': '아직 제출된 파일이 없습니다.',
      'en': '',
    },
    'pcnq6upy': {
      'ko': '새로고침',
      'en': '',
    },
    '1zihs320': {
      'ko': '미리 보기',
      'en': '',
    },
    'ygiae8hc': {
      'ko': '선정한 중간 결과물',
      'en': '',
    },
    '7bvr0y7l': {
      'ko': '중간 결과물[상]',
      'en': '',
    },
    '0f9y7jz8': {
      'ko': '중간 결과물[중]',
      'en': '',
    },
    'rroaq8gq': {
      'ko': '중간 결과물[하]',
      'en': '',
    },
    'rj9g3dyw': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Prof_ResultsFinal
  {
    'd60f862m': {
      'ko': '기말 결과물',
      'en': '',
    },
    '61nwrfaf': {
      'ko': '아직 제출된 파일이 없습니다.',
      'en': '',
    },
    'jz55vset': {
      'ko': '새로고침',
      'en': '',
    },
    'uct3e7td': {
      'ko': '미리 보기',
      'en': '',
    },
    '4pdy91j3': {
      'ko': '선정한 기말 결과물',
      'en': '',
    },
    'ixpv6ojq': {
      'ko': '기말 결과물[상]',
      'en': '',
    },
    'g63kuj6g': {
      'ko': '기말 결과물[중]',
      'en': '',
    },
    '5wmnjw9x': {
      'ko': '기말 결과물[하]',
      'en': '',
    },
    'duirri0n': {
      'ko': '기말 결과물',
      'en': '',
    },
    'y6ob1ed0': {
      'ko': '아직 제출된 파일이 없습니다.',
      'en': '',
    },
    'k1u9jrqr': {
      'ko': '새로고침',
      'en': '',
    },
    'xvcv8r68': {
      'ko': '미리 보기',
      'en': '',
    },
    'ilxjlec8': {
      'ko': '선정한 기말 결과물',
      'en': '',
    },
    'ag9p9yq1': {
      'ko': '기말 결과물[상]',
      'en': '',
    },
    'ju0b6em7': {
      'ko': '기말 결과물[중]',
      'en': '',
    },
    'rbobfa64': {
      'ko': '기말 결과물[하]',
      'en': '',
    },
    'g1fbz03z': {
      'ko': 'Home',
      'en': '',
    },
  },
  // StudentCoursePlan
  {
    'km0tfc8x': {
      'ko': '수업계획서',
      'en': '',
    },
    'j8e9283b': {
      'ko': '다운로드',
      'en': '',
    },
    'u4favsit': {
      'ko': '미리 보기',
      'en': '',
    },
    'rdj50yca': {
      'ko': '수업계획서',
      'en': '',
    },
    'gpxozwca': {
      'ko': '다운로드',
      'en': '',
    },
    '01207ll1': {
      'ko': '미리 보기',
      'en': '',
    },
    'im5gnm3g': {
      'ko': 'Home',
      'en': '',
    },
  },
  // StudentLectureMaterial
  {
    '21qpripp': {
      'ko': '강의자료실',
      'en': '',
    },
    'o8ckvhbk': {
      'ko': '미리 보기',
      'en': '',
    },
    'k65l5g6a': {
      'ko': '강의자료실',
      'en': '',
    },
    '135shurb': {
      'ko': '미리 보기',
      'en': '',
    },
    'mydfsri1': {
      'ko': 'Home',
      'en': '',
    },
  },
  // StudentResults_Midterm
  {
    'fn2p0hyl': {
      'ko': '1차 결과물',
      'en': '',
    },
    'vy5dfs39': {
      'ko': '재업로드',
      'en': '',
    },
    'xdwnswnc': {
      'ko': '아직 제출된 파일이 없습니다.',
      'en': '',
    },
    '2jm51g8b': {
      'ko': '파일 업로드',
      'en': '',
    },
    '2xn2xbaj': {
      'ko': '미리 보기',
      'en': '',
    },
    'cjwmlwu1': {
      'ko': '1차 결과물',
      'en': '',
    },
    'eqjxr05u': {
      'ko': '업로드',
      'en': '',
    },
    '2gesxgzm': {
      'ko': '미리 보기',
      'en': '',
    },
    'plw5robz': {
      'ko': '아직 제출된 파일이 없습니다.',
      'en': '',
    },
    'sugdno8p': {
      'ko': '파일 업로드',
      'en': '',
    },
    'gkymlulz': {
      'ko': 'Home',
      'en': '',
    },
  },
  // StudentResults_Final
  {
    'h5qi2nbc': {
      'ko': '2차 결과물',
      'en': '',
    },
    'dmfhxgru': {
      'ko': '파일 업로드',
      'en': '',
    },
    '2kwg9txc': {
      'ko': '아직 제출된 파일이 없습니다.',
      'en': '',
    },
    'm3q64wte': {
      'ko': '파일 업로드',
      'en': '',
    },
    '5jtfjeyo': {
      'ko': '미리 보기',
      'en': '',
    },
    '7alzyq27': {
      'ko': '2차 결과물',
      'en': '',
    },
    'r0h94f6b': {
      'ko': '업로드',
      'en': '',
    },
    'el9gfft9': {
      'ko': '미리 보기',
      'en': '',
    },
    'g57lo9d4': {
      'ko': '아직 제출된 파일이 없습니다.',
      'en': '',
    },
    'zvket6op': {
      'ko': '파일 업로드',
      'en': '',
    },
    '8suwcy1b': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Calendar
  {
    '0whul8w7': {
      'ko': 'Home',
      'en': '',
    },
  },
  // StudentCalender
  {
    '4gs03539': {
      'ko': 'Home',
      'en': '',
    },
  },
  // AdminLogin
  {
    'lvjmig7u': {
      'ko': 'Admin ',
      'en': '',
    },
    '0tza8u8p': {
      'ko': 'Sign in your account',
      'en': '',
    },
    'i93z1liu': {
      'ko': 'Your ID',
      'en': '',
    },
    'imuc3vpi': {
      'ko': '아이디를 입력해주세요',
      'en': '',
    },
    'bzm0xuhh': {
      'ko': 'admin Id',
      'en': '',
    },
    'e05cfn3h': {
      'ko': 'Password',
      'en': '',
    },
    'aq7io3do': {
      'ko': '비밀번호를 입력해주세요',
      'en': '',
    },
    'chovo49j': {
      'ko': 'Password',
      'en': '',
    },
    'esyk2th8': {
      'ko': 'Login',
      'en': '',
    },
    'gau0lo1g': {
      'ko': '아이디를 입력해주세요.',
      'en': '',
    },
    'ese16db2': {
      'ko': 'Please choose an option from the dropdown',
      'en': '',
    },
    't37qbqzf': {
      'ko': '비밀번호를 입력해주세요',
      'en': '',
    },
    '6u7m4e8a': {
      'ko': 'Please choose an option from the dropdown',
      'en': '',
    },
    'h7dvu7zd': {
      'ko': 'Home',
      'en': '',
    },
  },
  // AdminDash
  {
    'mmi81a4v': {
      'ko': '년도 선택',
      'en': '',
    },
    '56th110z': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'g1xl8lax': {
      'ko': '학기 선택',
      'en': '',
    },
    'l4nf6jlc': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'wdcfd0pn': {
      'ko': '년',
      'en': '',
    },
    'ogeu7f7u': {
      'ko': '  ',
      'en': '',
    },
    'qb4j6zyl': {
      'ko': '1학년',
      'en': '',
    },
    '0awwxl6p': {
      'ko': '2학년',
      'en': '',
    },
    '0zeibr2h': {
      'ko': '3학년',
      'en': '',
    },
    '1amovrsl': {
      'ko': '4학년',
      'en': '',
    },
    'iogk6yhp': {
      'ko': '5학년',
      'en': '',
    },
    '7fjkcg4c': {
      'ko': '검색할 과목의 이름을 입력하세요',
      'en': '',
    },
    '0zg0zry7': {
      'ko': '과목 검색',
      'en': '',
    },
    'y5qs2dqs': {
      'ko': '설계 과목',
      'en': '',
    },
    'qpdgmgv3': {
      'ko': '이론 과목',
      'en': '',
    },
    '1u5i39bg': {
      'ko': '검색결과',
      'en': '',
    },
    'f1kiuf8y': {
      'ko': '교수님 업로드 현황',
      'en': '',
    },
    't0enfic7': {
      'ko': '전공 홈 바로가기 ▶',
      'en': '',
    },
    'niinzvb8': {
      'ko': '포트폴리오 크리틱 진행률',
      'en': '',
    },
    'q96f7cwh': {
      'ko': '학생 업로드 현황',
      'en': '',
    },
    'uhgsn50y': {
      'ko': '과목의 “진행사항 조회”를 누를 시 통계를 확인하실 수 있습니다. ',
      'en': '',
    },
    'wp4yw4bi': {
      'ko': '년도 선택',
      'en': '',
    },
    'de2cr4q8': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'wqq61wgn': {
      'ko': '학기 선택',
      'en': '',
    },
    '0dkqxnef': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'ii37oecg': {
      'ko': '통계/대시보드',
      'en': '',
    },
    '4lahxgrm': {
      'ko': '1학년',
      'en': '',
    },
    'duy1z83c': {
      'ko': '2학년',
      'en': '',
    },
    '78p3fwwc': {
      'ko': '3학년',
      'en': '',
    },
    'yr6sxgdu': {
      'ko': '4학년',
      'en': '',
    },
    'b02axov3': {
      'ko': '5학년',
      'en': '',
    },
    'xm1jee0h': {
      'ko': '설계 과목 조회 ▶',
      'en': '',
    },
    '1lp9mfnh': {
      'ko': '이론 과목 조회 ▶',
      'en': '',
    },
    'd32zdinj': {
      'ko': '과목 조회',
      'en': '',
    },
    '5opovg5u': {
      'ko': '과목 조회',
      'en': '',
    },
    'j0z4r9v9': {
      'ko': '교수님 업로드 현황',
      'en': '',
    },
    'ci09091w': {
      'ko': '전공 홈 바로가기 ▶',
      'en': '',
    },
    '9dj3rhll': {
      'ko': '포트폴리오 크리틱 진행률',
      'en': '',
    },
    '0jrijtu4': {
      'ko': 'Home',
      'en': '',
    },
  },
  // AdminClassChange
  {
    'iqxzzl5k': {
      'ko': '년도 선택',
      'en': '',
    },
    '8yicynjz': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'xauf4niz': {
      'ko': '학기 선택',
      'en': '',
    },
    'n2kiyfy1': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '8awzpyzx': {
      'ko': '년',
      'en': '',
    },
    'fj70sjv4': {
      'ko': '  ',
      'en': '',
    },
    'l0ehoc4p': {
      'ko': '학생전공 변경 및 승인',
      'en': '',
    },
    'o0o6kpk7': {
      'ko': '이 름',
      'en': '',
    },
    '1xkm0jlf': {
      'ko': 'Search...',
      'en': '',
    },
    'th3amuk0': {
      'ko': '이 름',
      'en': '',
    },
    'b4tyvmz8': {
      'ko': '학 번',
      'en': '',
    },
    '2kbezq67': {
      'ko': '학생 검색',
      'en': '',
    },
    'lx1g269b': {
      'ko': '이름',
      'en': '',
    },
    '6brgzyj2': {
      'ko': '학번',
      'en': '',
    },
    'nf4yayqv': {
      'ko': '분반',
      'en': '',
    },
    'arwwbyw3': {
      'ko': '요청 사항',
      'en': '',
    },
    '5dfzfgvq': {
      'ko': '승인요청',
      'en': '',
    },
    'wpmnt4i2': {
      'ko': '총:',
      'en': '',
    },
    'ibqzxhk8': {
      'ko': ' 10',
      'en': '',
    },
    'i2wwrk5k': {
      'ko': '명',
      'en': '',
    },
    'sxtltfjy': {
      'ko': '년도 선택',
      'en': '',
    },
    'qkb7xrva': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'hwvbp56a': {
      'ko': '학기 선택',
      'en': '',
    },
    'w968585a': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'vfurj0vk': {
      'ko': '학생전공 변경 및 승인',
      'en': '',
    },
    'lp41fjlu': {
      'ko': '이 름',
      'en': '',
    },
    'b4eyidq1': {
      'ko': 'Search...',
      'en': '',
    },
    '7p8258yi': {
      'ko': '이 름',
      'en': '',
    },
    'chjnxm85': {
      'ko': '학 번',
      'en': '',
    },
    'wcabyctn': {
      'ko': '학생 검색',
      'en': '',
    },
    'wbac1e18': {
      'ko': '이름',
      'en': '',
    },
    'xj5gxmgb': {
      'ko': '분반',
      'en': '',
    },
    '3ultwt7v': {
      'ko': '요청상태',
      'en': '',
    },
    'artph649': {
      'ko': '승인',
      'en': '',
    },
    'rrwaex0w': {
      'ko': '현재 요청사항이 없습니다.',
      'en': '',
    },
    'nqgbgc0t': {
      'ko': '총: ',
      'en': '',
    },
    'uznc4w7s': {
      'ko': '10',
      'en': '',
    },
    'maz1zeez': {
      'ko': '명',
      'en': '',
    },
    'ywzomqd3': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Home
  {
    '73u92s8o': {
      'ko': '주차별 설계 진행표 업로드여부',
      'en': '',
    },
    'urylfftr': {
      'ko': '명단',
      'en': '',
    },
    'eeczrh06': {
      'ko': '1주차',
      'en': '',
    },
    'd2r3igbv': {
      'ko': '2주차',
      'en': '',
    },
    '9qhprh1m': {
      'ko': '3주차',
      'en': '',
    },
    's95pto9w': {
      'ko': '4주차',
      'en': '',
    },
    '7e768w40': {
      'ko': '5주차',
      'en': '',
    },
    'b2fsewy9': {
      'ko': '6주차',
      'en': '',
    },
    '3ktsjz0s': {
      'ko': '7주차',
      'en': '',
    },
    'm3hqwbcc': {
      'ko': '8주차',
      'en': '',
    },
    'sbq33gts': {
      'ko': '9주차',
      'en': '',
    },
    '5dzproh2': {
      'ko': '10주차',
      'en': '',
    },
    'ewxery0r': {
      'ko': '11주차',
      'en': '',
    },
    'u391u86o': {
      'ko': '12주차',
      'en': '',
    },
    'zxrhyb05': {
      'ko': '13주차',
      'en': '',
    },
    'u730ae3j': {
      'ko': '14주차',
      'en': '',
    },
    'xuuy45r6': {
      'ko': '15주차',
      'en': '',
    },
    '7vnoqdn0': {
      'ko': '중간기말 결과물 업로드 여부',
      'en': '',
    },
    'd2if6pf4': {
      'ko': '중간\n결과물',
      'en': '',
    },
    '9s2ptk43': {
      'ko': '제출',
      'en': '',
    },
    'ysabo5e4': {
      'ko': '점수',
      'en': '',
    },
    'wikm77g6': {
      'ko': '-',
      'en': '',
    },
    '9gy10g5p': {
      'ko': '-',
      'en': '',
    },
    'edvuk86s': {
      'ko': '-',
      'en': '',
    },
    'u557ihjb': {
      'ko': '-',
      'en': '',
    },
    'mmzi6kya': {
      'ko': '-',
      'en': '',
    },
    '450d577m': {
      'ko': '-',
      'en': '',
    },
    '7i3n3dzh': {
      'ko': '-',
      'en': '',
    },
    'vv49k9c9': {
      'ko': '-',
      'en': '',
    },
    'npplcp5g': {
      'ko': '-',
      'en': '',
    },
    'l2a94c3h': {
      'ko': '-',
      'en': '',
    },
    '4qr6nr0b': {
      'ko': '-',
      'en': '',
    },
    'k3ik7v51': {
      'ko': '-',
      'en': '',
    },
    'd7e8l6jc': {
      'ko': '-',
      'en': '',
    },
    'k2tiat0t': {
      'ko': '-',
      'en': '',
    },
    'ju0vm8w5': {
      'ko': '-',
      'en': '',
    },
    'czc0cw0o': {
      'ko': '-',
      'en': '',
    },
    '1m3ye670': {
      'ko': '기말 \n결과물',
      'en': '',
    },
    'nhkhqr64': {
      'ko': '제출',
      'en': '',
    },
    'wd7oui7z': {
      'ko': '점수',
      'en': '',
    },
    'l1v5j8fz': {
      'ko': '-',
      'en': '',
    },
    'gzo56451': {
      'ko': '-',
      'en': '',
    },
    'ibh8kr5l': {
      'ko': '-',
      'en': '',
    },
    'uybkp40c': {
      'ko': '-',
      'en': '',
    },
    'msaodoqb': {
      'ko': '-',
      'en': '',
    },
    '0dz4j6gk': {
      'ko': '-',
      'en': '',
    },
    'wxlbl2mb': {
      'ko': '-',
      'en': '',
    },
    'tmluq8bg': {
      'ko': '-',
      'en': '',
    },
    'pqzf844k': {
      'ko': '-',
      'en': '',
    },
    'ol1k9tvc': {
      'ko': '-',
      'en': '',
    },
    'ekojf6dr': {
      'ko': '-',
      'en': '',
    },
    '7754xsj4': {
      'ko': '-',
      'en': '',
    },
    't5jp4ajz': {
      'ko': '-',
      'en': '',
    },
    'ozoybf0j': {
      'ko': '-',
      'en': '',
    },
    '8x1ygwoa': {
      'ko': '-',
      'en': '',
    },
    'x9lmo73w': {
      'ko': '-',
      'en': '',
    },
    'gb2mmy5c': {
      'ko': '미리 보기',
      'en': '',
    },
    '101w6tzk': {
      'ko': '업로드 최근 글',
      'en': '',
    },
    'c71s3swn': {
      'ko': '전체',
      'en': '',
    },
    'jfrw3pc7': {
      'ko': '[건축학인증 시스템 \'아키버스\' 오픈안내]',
      'en': '',
    },
    'jpugse31': {
      'ko': '2025-04-14 03:52',
      'en': '',
    },
    '6q4xe1zx': {
      'ko': '관리자',
      'en': '',
    },
    'gpn2x2ad': {
      'ko': '공지사항',
      'en': '',
    },
    'ssevp6ug': {
      'ko': '1주차_연희동 구조 시안',
      'en': '',
    },
    'aj8gguji': {
      'ko': '2024-05-12 12:22',
      'en': '',
    },
    'nofzxjxx': {
      'ko': '김건우 학생',
      'en': '',
    },
    'h62qab58': {
      'ko': '강의자료',
      'en': '',
    },
    '3d8oh6hx': {
      'ko': '일정 알림',
      'en': '',
    },
    'vv2jcemn': {
      'ko': '[건축학인증 시스템 \'아키버스\' 오픈안내]',
      'en': '',
    },
    'lxbktmld': {
      'ko': '2025-04-14 03:52',
      'en': '',
    },
    'pi4jd35i': {
      'ko': '관리자',
      'en': '',
    },
    'skgi0xuk': {
      'ko': '공지사항',
      'en': '',
    },
    'ys4cqpme': {
      'ko': '업로드알림',
      'en': '',
    },
    'lf8aa4je': {
      'ko': '2주차_천안아산시 컨셉 선정',
      'en': '',
    },
    'l7mt4i6q': {
      'ko': '2024-08-28 16:22',
      'en': '',
    },
    '1hlfjw6k': {
      'ko': '나영석 학생',
      'en': '',
    },
    'c3d3jeau': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'osvnczz1': {
      'ko': '3주차 과제 제출 등록',
      'en': '',
    },
    'm9k95qzs': {
      'ko': '2024-08-04 11:55',
      'en': '',
    },
    'hcfac1kz': {
      'ko': '김승 교수',
      'en': '',
    },
    'xhqf5fda': {
      'ko': '캘린더',
      'en': '',
    },
    'cryg7k1y': {
      'ko': '1주차_연희동 구조 시안',
      'en': '',
    },
    'zd5p9dj9': {
      'ko': '2024-05-12 12:22',
      'en': '',
    },
    'v5jpavzx': {
      'ko': '김건우 학생',
      'en': '',
    },
    'ht8rbp52': {
      'ko': '강의자료',
      'en': '',
    },
    '9zy4vv6a': {
      'ko': '주차별 설계진행표 업로드 여부',
      'en': '',
    },
    's15ih3xt': {
      'ko': '명단',
      'en': '',
    },
    'vm22jfhg': {
      'ko': '1주차',
      'en': '',
    },
    'ylwptjpr': {
      'ko': '2주차',
      'en': '',
    },
    'cvo0p2d0': {
      'ko': '3주차',
      'en': '',
    },
    'mv4l8lxn': {
      'ko': '4주차',
      'en': '',
    },
    'bpvebbcz': {
      'ko': '5주차',
      'en': '',
    },
    '3bapsbhi': {
      'ko': '6주차',
      'en': '',
    },
    'pb0nc64x': {
      'ko': '7주차',
      'en': '',
    },
    'e5s3qu03': {
      'ko': '8주차',
      'en': '',
    },
    'jccz0hvd': {
      'ko': '9주차',
      'en': '',
    },
    '4geys6t2': {
      'ko': '10주차',
      'en': '',
    },
    'sekec2y8': {
      'ko': '11주차',
      'en': '',
    },
    'ba4gsnay': {
      'ko': '12주차',
      'en': '',
    },
    'c4j3dkt6': {
      'ko': '13주차',
      'en': '',
    },
    'ynt3cb95': {
      'ko': '14주차',
      'en': '',
    },
    '0tg9xhdf': {
      'ko': '15주차',
      'en': '',
    },
    'q2deez27': {
      'ko': '중간기말 결과물 업로드 여부',
      'en': '',
    },
    'c2qfo6un': {
      'ko': '중간\n결과물',
      'en': '',
    },
    '1u8bglyj': {
      'ko': '제출',
      'en': '',
    },
    'oxgqdf9v': {
      'ko': '점수',
      'en': '',
    },
    'c9qb4ly1': {
      'ko': '-',
      'en': '',
    },
    'bbkjfdjf': {
      'ko': '-',
      'en': '',
    },
    'm0tifjzi': {
      'ko': '-',
      'en': '',
    },
    'j45qyry7': {
      'ko': '-',
      'en': '',
    },
    'a1j7af8t': {
      'ko': '-',
      'en': '',
    },
    '7crd1np3': {
      'ko': '-',
      'en': '',
    },
    'fpuk6hkz': {
      'ko': '-',
      'en': '',
    },
    'i5zwxsb0': {
      'ko': '-',
      'en': '',
    },
    'yei1t7wf': {
      'ko': '-',
      'en': '',
    },
    '13hq54t3': {
      'ko': '-',
      'en': '',
    },
    '5668h4ej': {
      'ko': '-',
      'en': '',
    },
    'tcnjbkiy': {
      'ko': '-',
      'en': '',
    },
    'b2qd7weq': {
      'ko': '-',
      'en': '',
    },
    '500x1qcv': {
      'ko': '-',
      'en': '',
    },
    'cp0j2jtw': {
      'ko': '-',
      'en': '',
    },
    '3schlwz4': {
      'ko': '-',
      'en': '',
    },
    'dv5jhwh7': {
      'ko': '기말 \n결과물',
      'en': '',
    },
    '5ixkkz3l': {
      'ko': '제출',
      'en': '',
    },
    'i2lamrd6': {
      'ko': '점수',
      'en': '',
    },
    '74exu0bj': {
      'ko': '-',
      'en': '',
    },
    'kwoiyaes': {
      'ko': '-',
      'en': '',
    },
    '3ns2ar8t': {
      'ko': '-',
      'en': '',
    },
    '7x017hwr': {
      'ko': '-',
      'en': '',
    },
    '5uwiyr2j': {
      'ko': '-',
      'en': '',
    },
    '242ahn4h': {
      'ko': '-',
      'en': '',
    },
    'wuag44mk': {
      'ko': '-',
      'en': '',
    },
    '0eoiqs3l': {
      'ko': '-',
      'en': '',
    },
    '8dntgg9m': {
      'ko': '-',
      'en': '',
    },
    'cwvvf7tu': {
      'ko': '-',
      'en': '',
    },
    '3d46zzkt': {
      'ko': '-',
      'en': '',
    },
    'cc6tub90': {
      'ko': '-',
      'en': '',
    },
    'eub78i1h': {
      'ko': '-',
      'en': '',
    },
    '5ttldwa1': {
      'ko': '-',
      'en': '',
    },
    'qpwanx7w': {
      'ko': '-',
      'en': '',
    },
    'y8trob95': {
      'ko': '-',
      'en': '',
    },
    '027hv5di': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Prof_Dashboard
  {
    'pvmqt2en': {
      'ko': '년도 선택',
      'en': '',
    },
    '2trvhjtc': {
      'ko': 'Search for an item...',
      'en': '',
    },
    't5io9bzc': {
      'ko': '학기 선택',
      'en': '',
    },
    'qbsq6yo8': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '0z7z9oui': {
      'ko': '년',
      'en': '',
    },
    '4cvgd00b': {
      'ko': '  ',
      'en': '',
    },
    'yqkmfi70': {
      'ko': '1학년 담당과목',
      'en': '',
    },
    'kkevdak4': {
      'ko': '2학년 담당과목',
      'en': '',
    },
    '15vxog8i': {
      'ko': '3학년 담당과목',
      'en': '',
    },
    'v2yt8ecf': {
      'ko': '4학년 담당과목',
      'en': '',
    },
    '39z5n0v9': {
      'ko': '5학년 담당과목',
      'en': '',
    },
    'lqkhd6wr': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    '5hpx1omg': {
      'ko': '1분반',
      'en': '',
    },
    'okr2f6fn': {
      'ko': ' 교수님',
      'en': '',
    },
    'rn734hpp': {
      'ko': '바로가기',
      'en': '',
    },
    'l70x7iy2': {
      'ko': '2분반',
      'en': '',
    },
    'm8z1co5d': {
      'ko': ' 교수님',
      'en': '',
    },
    'kvlilypo': {
      'ko': '바로가기',
      'en': '',
    },
    'j6fjr1ae': {
      'ko': '3분반',
      'en': '',
    },
    'youfos0i': {
      'ko': ' 교수님',
      'en': '',
    },
    'bcy4uivs': {
      'ko': '바로가기',
      'en': '',
    },
    '6zfg43cb': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'v2dl309l': {
      'ko': '1분반',
      'en': '',
    },
    'n9sr9su9': {
      'ko': '바로가기',
      'en': '',
    },
    '7dkhpqgb': {
      'ko': '2분반',
      'en': '',
    },
    'ir3d5es9': {
      'ko': '바로가기',
      'en': '',
    },
    '619s1ob5': {
      'ko': '3분반',
      'en': '',
    },
    'cb299j9s': {
      'ko': '바로가기',
      'en': '',
    },
    'dvhs42ot': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    '50gypwhj': {
      'ko': '1분반',
      'en': '',
    },
    '12caso6y': {
      'ko': '바로가기',
      'en': '',
    },
    'faeska0z': {
      'ko': '2분반',
      'en': '',
    },
    'rzlleua8': {
      'ko': '바로가기',
      'en': '',
    },
    'n364ukk9': {
      'ko': '3분반',
      'en': '',
    },
    'h1hxr32i': {
      'ko': '바로가기',
      'en': '',
    },
    'wpd1dqic': {
      'ko': '총 진행사항',
      'en': '',
    },
    'v682now1': {
      'ko': '0%',
      'en': '',
    },
    'w8zckwh3': {
      'ko': '100%',
      'en': '',
    },
    'it2m2q0z': {
      'ko': '1분반',
      'en': '',
    },
    'sfqcq4mz': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '5hfk6yq3': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    '29wglhr0': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'fbfivadd': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '49fvi167': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    'pr7dk72a': {
      'ko': '---',
      'en': '',
    },
    '34rvgfpy': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '9doz6gus': {
      'ko': '수업계획서',
      'en': '',
    },
    'vuq201mh': {
      'ko': ' ▶',
      'en': '',
    },
    'au0k277q': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'fw82l8lw': {
      'ko': '강의 자료실',
      'en': '',
    },
    'xltvt5k1': {
      'ko': ' ▶',
      'en': '',
    },
    '0qraawka': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'fru9cvmr': {
      'ko': '학생 작품평가표',
      'en': '',
    },
    '3b5l6dry': {
      'ko': ' ▶',
      'en': '',
    },
    'uf33jw9j': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'cyctr2y9': {
      'ko': '출석부',
      'en': '',
    },
    'c5tbdwaw': {
      'ko': ' ▶',
      'en': '',
    },
    '7fwq0uey': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'bhh6hgl2': {
      'ko': '성적기록표',
      'en': '',
    },
    'bnrj6n7a': {
      'ko': ' ▶',
      'en': '',
    },
    '1ylgv33u': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'fhhqkl10': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'g2bad9pm': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    '9b4gatmq': {
      'ko': ' ▶',
      'en': '',
    },
    '1uzvfs3y': {
      'ko': '미제출 조회',
      'en': '',
    },
    '6p6o2lc8': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'iey95wsy': {
      'ko': ' ▶',
      'en': '',
    },
    'tx9144y1': {
      'ko': '미제출 조회',
      'en': '',
    },
    '04lq6sj4': {
      'ko': '2분반',
      'en': '',
    },
    '47nvodbb': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'eh1no620': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'cdg6txwg': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'j1h2ej0w': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'am4ax70g': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    'qtbkc9ha': {
      'ko': '---',
      'en': '',
    },
    'j1djnwpz': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '31e61sly': {
      'ko': '수업계획서',
      'en': '',
    },
    'x2euo0m9': {
      'ko': ' ▶',
      'en': '',
    },
    'dzxw3tpm': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    's7dvkw0l': {
      'ko': '강의 자료실',
      'en': '',
    },
    'hbps7o4x': {
      'ko': ' ▶',
      'en': '',
    },
    '1un4oph9': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'lymcioli': {
      'ko': '학생 작품평가표',
      'en': '',
    },
    'yje36y73': {
      'ko': ' ▶',
      'en': '',
    },
    '0vn2lk3s': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'lp36mf47': {
      'ko': '출석부',
      'en': '',
    },
    'a3htaw3x': {
      'ko': ' ▶',
      'en': '',
    },
    'oc729t65': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'tieo1w9f': {
      'ko': '성적기록표',
      'en': '',
    },
    'ckww0ujx': {
      'ko': ' ▶',
      'en': '',
    },
    'hnvb6vp1': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '0ketjd94': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'o8j71vv3': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'ymzmx3ff': {
      'ko': ' ▶',
      'en': '',
    },
    'eo06wf8n': {
      'ko': '미제출 조회',
      'en': '',
    },
    'cr8kz0us': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'r3r48srb': {
      'ko': ' ▶',
      'en': '',
    },
    'fakudsw0': {
      'ko': '미제출 조회',
      'en': '',
    },
    'cat6rt3a': {
      'ko': '3분반',
      'en': '',
    },
    'xq23t5oe': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'zo7wt9gq': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'e03ehbmd': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'tcoz3we8': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'qg87rawn': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    'z7g21i33': {
      'ko': '---',
      'en': '',
    },
    '86ueders': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'b67vtsbx': {
      'ko': '수업계획서',
      'en': '',
    },
    '0be0uy8a': {
      'ko': ' ▶',
      'en': '',
    },
    'rf0pknf2': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'ec4ta30d': {
      'ko': '강의 자료실',
      'en': '',
    },
    'y03ez83x': {
      'ko': ' ▶',
      'en': '',
    },
    '83oegfj0': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'eivvotym': {
      'ko': '학생 작품평가표',
      'en': '',
    },
    'mbq05e4s': {
      'ko': ' ▶',
      'en': '',
    },
    'yd8nyxd1': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'ws91tpw0': {
      'ko': '출석부',
      'en': '',
    },
    '2ry3lnq2': {
      'ko': ' ▶',
      'en': '',
    },
    '2pxz384o': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'ynxrq4o8': {
      'ko': '성적기록표',
      'en': '',
    },
    'y7grfa1l': {
      'ko': ' ▶',
      'en': '',
    },
    '63j269vx': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '50kkbpuq': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'y9rci8um': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    '9wht0m5c': {
      'ko': ' ▶',
      'en': '',
    },
    'h48u2zgd': {
      'ko': '미제출 조회',
      'en': '',
    },
    'h69isu4y': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'ucry6h86': {
      'ko': ' ▶',
      'en': '',
    },
    'hg0d14oz': {
      'ko': '미제출 조회',
      'en': '',
    },
    '0lntxkg6': {
      'ko': '년도 선택',
      'en': '',
    },
    '3zjk143w': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'vjno4243': {
      'ko': '학기 선택',
      'en': '',
    },
    'byohwhn1': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'zov6wysd': {
      'ko': '년',
      'en': '',
    },
    'p20tuw6w': {
      'ko': '  ',
      'en': '',
    },
    'vh1ylh7t': {
      'ko': '1학년 담당과목',
      'en': '',
    },
    'r8glwyt8': {
      'ko': '2학년 담당과목',
      'en': '',
    },
    'l3z5skl4': {
      'ko': '3학년 담당과목',
      'en': '',
    },
    'aa1j0znd': {
      'ko': '4학년 담당과목',
      'en': '',
    },
    'sxq0acay': {
      'ko': '5학년 담당과목',
      'en': '',
    },
    '26jefmd2': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'g0soizd2': {
      'ko': '1분반',
      'en': '',
    },
    '0xejk4wo': {
      'ko': ' 교수님',
      'en': '',
    },
    'obbewxo6': {
      'ko': '바로가기',
      'en': '',
    },
    '3bmauq4j': {
      'ko': '2분반',
      'en': '',
    },
    'uadxopch': {
      'ko': ' 교수님',
      'en': '',
    },
    '0oi6y086': {
      'ko': '바로가기',
      'en': '',
    },
    'qbmo1pgz': {
      'ko': '3분반',
      'en': '',
    },
    'gxcseskx': {
      'ko': ' 교수님',
      'en': '',
    },
    'ejxfk772': {
      'ko': '바로가기',
      'en': '',
    },
    't9fy6ckv': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'lcj5sfn6': {
      'ko': '1분반',
      'en': '',
    },
    'gzlmn1kt': {
      'ko': ' 교수님',
      'en': '',
    },
    'mugmpmve': {
      'ko': '바로가기',
      'en': '',
    },
    'gpz1hwfj': {
      'ko': '2분반',
      'en': '',
    },
    'b0vzv4fv': {
      'ko': ' 교수님',
      'en': '',
    },
    't23d0igv': {
      'ko': '바로가기',
      'en': '',
    },
    '402r41tn': {
      'ko': '3분반',
      'en': '',
    },
    'fe5zskh0': {
      'ko': ' 교수님',
      'en': '',
    },
    'hy6bscc8': {
      'ko': '바로가기',
      'en': '',
    },
    'g2r8afp7': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'kj4cgrva': {
      'ko': '1분반',
      'en': '',
    },
    'o15xcjk4': {
      'ko': ' 교수님',
      'en': '',
    },
    '4kcue0u5': {
      'ko': '바로가기',
      'en': '',
    },
    'np6x0t6g': {
      'ko': '2분반',
      'en': '',
    },
    'gvg31szd': {
      'ko': ' 교수님',
      'en': '',
    },
    'd31rqzr3': {
      'ko': '바로가기',
      'en': '',
    },
    'qwiha1ek': {
      'ko': '3분반',
      'en': '',
    },
    '32f6i8kk': {
      'ko': ' 교수님',
      'en': '',
    },
    'qojd2h08': {
      'ko': '바로가기',
      'en': '',
    },
    '7btbj71q': {
      'ko': '총 진행사항',
      'en': '',
    },
    'guy2ojw4': {
      'ko': '0%',
      'en': '',
    },
    '0jogxkyb': {
      'ko': '100%',
      'en': '',
    },
    'i27we0jb': {
      'ko': '1분반',
      'en': '',
    },
    'zgzavz3a': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'z9dla3go': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'aerybsw4': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'e4vel54t': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'rc43tgc9': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    'twl2f8r5': {
      'ko': '---',
      'en': '',
    },
    '5luxl31x': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'jhqetdrc': {
      'ko': '수업계획서',
      'en': '',
    },
    '2raot0wk': {
      'ko': ' ▶',
      'en': '',
    },
    '5wn07hyk': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'ldyoipq5': {
      'ko': '강의 자료실',
      'en': '',
    },
    'jj2obzdn': {
      'ko': ' ▶',
      'en': '',
    },
    'd9ef51dy': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'a89o5jv8': {
      'ko': '학생 작품평가표',
      'en': '',
    },
    '34q3hqz8': {
      'ko': ' ▶',
      'en': '',
    },
    '4gqyiqmv': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'vceogn33': {
      'ko': '출석부',
      'en': '',
    },
    '9f2whh9k': {
      'ko': ' ▶',
      'en': '',
    },
    'cdigcry2': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'piqajycs': {
      'ko': '성적기록표',
      'en': '',
    },
    '72qny1di': {
      'ko': ' ▶',
      'en': '',
    },
    's4g572qf': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '73u8sn98': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'fgb087eq': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    '08zu6zem': {
      'ko': ' ▶',
      'en': '',
    },
    '8enhyst8': {
      'ko': '미제출 조회',
      'en': '',
    },
    '4y4xkln7': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    '29z55vbx': {
      'ko': ' ▶',
      'en': '',
    },
    'gxv8ek1n': {
      'ko': '미제출 조회',
      'en': '',
    },
    'fuzcoebx': {
      'ko': '2분반',
      'en': '',
    },
    'j0jtao9y': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'y6bxq58p': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'rmjsnlky': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    '3w29iae2': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'c313h7k7': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    '2mrc3xqa': {
      'ko': '---',
      'en': '',
    },
    'xdfv1dh1': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'bnlv7epl': {
      'ko': '수업계획서',
      'en': '',
    },
    'tds8arm0': {
      'ko': ' ▶',
      'en': '',
    },
    '2pddfebj': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '18v9u39r': {
      'ko': '강의 자료실',
      'en': '',
    },
    'm9gvb1qb': {
      'ko': ' ▶',
      'en': '',
    },
    '5z9fdo3s': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '5xi25ish': {
      'ko': '학생 작품평가표',
      'en': '',
    },
    'fhw85se9': {
      'ko': ' ▶',
      'en': '',
    },
    'h5n0nts3': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'dr6mg1ua': {
      'ko': '출석부',
      'en': '',
    },
    '1xzygx95': {
      'ko': ' ▶',
      'en': '',
    },
    'p0c2dq64': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    '5d27p7ys': {
      'ko': '성적기록표',
      'en': '',
    },
    'xiuj1qmf': {
      'ko': ' ▶',
      'en': '',
    },
    '2laaq02l': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'ccm9g79c': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    'ceh0t8hb': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'a7z6g9ne': {
      'ko': ' ▶',
      'en': '',
    },
    '3e3be9sm': {
      'ko': '미제출 조회',
      'en': '',
    },
    'a0mcj3h9': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    'izsk00kr': {
      'ko': ' ▶',
      'en': '',
    },
    '3ulzqw8n': {
      'ko': '미제출 조회',
      'en': '',
    },
    '66nah8v7': {
      'ko': '3분반',
      'en': '',
    },
    'goltxmnb': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '2ag6kouf': {
      'ko': '교수님 업로드현황 ',
      'en': '',
    },
    'kg4oe9d6': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'x465s89v': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '0eocdu0a': {
      'ko': '학부생 등록여부',
      'en': '',
    },
    'tjcvfpst': {
      'ko': '---',
      'en': '',
    },
    'ozj153zr': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'p255fxo3': {
      'ko': '수업계획서',
      'en': '',
    },
    'zbl3i1tr': {
      'ko': ' ▶',
      'en': '',
    },
    'j1zmsyus': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'ds63gn4y': {
      'ko': '강의 자료실',
      'en': '',
    },
    'me8sbgef': {
      'ko': ' ▶',
      'en': '',
    },
    '5o2e3g6x': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'axjjwqo6': {
      'ko': '학생 작품평가표',
      'en': '',
    },
    'wf9052hv': {
      'ko': ' ▶',
      'en': '',
    },
    '2s6v7kvh': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'wzmlytr3': {
      'ko': '출석부',
      'en': '',
    },
    '4b6rwt7b': {
      'ko': ' ▶',
      'en': '',
    },
    'dfwotpv0': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'cbifvvmn': {
      'ko': '성적기록표',
      'en': '',
    },
    'ffnkdb9k': {
      'ko': ' ▶',
      'en': '',
    },
    'r2b62u10': {
      'ko': '파일이 없습니다.',
      'en': '',
    },
    'z1g3s60i': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    '2n72ni6t': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    '50vhzevg': {
      'ko': ' ▶',
      'en': '',
    },
    'c5ktfvma': {
      'ko': '미제출 조회',
      'en': '',
    },
    '9mm91f25': {
      'ko': '1차-2차 성과물',
      'en': '',
    },
    '6hlp37k5': {
      'ko': ' ▶',
      'en': '',
    },
    'xuxptqwi': {
      'ko': '미제출 조회',
      'en': '',
    },
    'uhlova4d': {
      'ko': '과목 진행 상황을 조회 할 수 있습니다.',
      'en': '',
    },
    'mco224ep': {
      'ko': '과목 진행 상황을 조회 할 수 있습니다.',
      'en': '',
    },
    'pdm03vq2': {
      'ko': 'Home',
      'en': '',
    },
  },
  // StudentDashboard
  {
    'mnbfbhyy': {
      'ko': '년도 선택',
      'en': '',
    },
    'd0ul6e3j': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '0rmjomqi': {
      'ko': '학기 선택',
      'en': '',
    },
    'bnixvr28': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'hi8o8zd8': {
      'ko': '년',
      'en': '',
    },
    'pe1l1cxv': {
      'ko': '  ',
      'en': '',
    },
    '2yhgi0sl': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'gt3i88xe': {
      'ko': '전공 분반',
      'en': '',
    },
    '1jw5s8v4': {
      'ko': ' 교수님',
      'en': '',
    },
    'ny9gsb0x': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'lw9ckghr': {
      'ko': '전공',
      'en': '',
    },
    'h3b2nef2': {
      'ko': ' 교수님',
      'en': '',
    },
    'yd8qsie6': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'xte83dao': {
      'ko': '전공',
      'en': '',
    },
    'hojm0jol': {
      'ko': ' 교수님',
      'en': '',
    },
    'dazkqqq0': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'ec2zadz8': {
      'ko': '전공',
      'en': '',
    },
    '5yjex07g': {
      'ko': ' 교수님',
      'en': '',
    },
    'vyynsa79': {
      'ko': '해당하는 분반으로 설정해주세요.',
      'en': '',
    },
    'ambjhnl1': {
      'ko': ' 교수님',
      'en': '',
    },
    'vc77yoxr': {
      'ko': '선택',
      'en': '',
    },
    '3mwdesmj': {
      'ko': '2분반',
      'en': '',
    },
    '5libjtbo': {
      'ko': '천준호 교수님',
      'en': '',
    },
    'ea4tk3uz': {
      'ko': '선택',
      'en': '',
    },
    'borcba4x': {
      'ko': '3분반',
      'en': '',
    },
    'esmcpdn7': {
      'ko': '이태희 교수님',
      'en': '',
    },
    'jaxkyou0': {
      'ko': '선택',
      'en': '',
    },
    'kbj80p2m': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'bjihramx': {
      'ko': '총 진행사항',
      'en': '',
    },
    '0166zx33': {
      'ko': '0%',
      'en': '',
    },
    '7sn6v23w': {
      'ko': '100%',
      'en': '',
    },
    'm1z7bkx8': {
      'ko': '주차별 업로드현황',
      'en': '',
    },
    'zomengnv': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'h8jd3vmd': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'ycsf178k': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    '18vfv7uw': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'vm0qo306': {
      'ko': '0%',
      'en': '',
    },
    '41q6596v': {
      'ko': '100%',
      'en': '',
    },
    '2noo1pda': {
      'ko': '미제출 조회',
      'en': '',
    },
    't05o3qn1': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '50so0pkd': {
      'ko': '1차 성과물',
      'en': '',
    },
    'rp0vtwom': {
      'ko': '[제출됨]',
      'en': '',
    },
    'kgfnzqa1': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'pkk5wtya': {
      'ko': '2차 성과물',
      'en': '',
    },
    '28glt41u': {
      'ko': '[미제출]',
      'en': '',
    },
    'oxjxsfld': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'muom1jas': {
      'ko': '년도 선택',
      'en': '',
    },
    '14ot2nc0': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '9397mq2f': {
      'ko': '학기 선택',
      'en': '',
    },
    'vt2bwscb': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'akudq4tr': {
      'ko': '년',
      'en': '',
    },
    '5c83ynef': {
      'ko': '  ',
      'en': '',
    },
    'ohorkx5l': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    '8467ubrc': {
      'ko': '전공 분반',
      'en': '',
    },
    '8jdxic7o': {
      'ko': ' 교수님',
      'en': '',
    },
    'n336t2s2': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'kfh82n39': {
      'ko': '전공',
      'en': '',
    },
    '1chazzl0': {
      'ko': ' 교수님',
      'en': '',
    },
    'fm1i1e43': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'flme2km0': {
      'ko': '전공',
      'en': '',
    },
    'l80s6v5o': {
      'ko': ' 교수님',
      'en': '',
    },
    'zixoj29z': {
      'ko': '진행사항 조회하기',
      'en': '',
    },
    'uxbw6l68': {
      'ko': '전공',
      'en': '',
    },
    '2g3jpbhe': {
      'ko': ' 교수님',
      'en': '',
    },
    '1v5v0qmn': {
      'ko': '해당하는 분반으로 설정해주세요.',
      'en': '',
    },
    'b5j21z3c': {
      'ko': ' 교수님',
      'en': '',
    },
    'e4nmaax2': {
      'ko': '선택',
      'en': '',
    },
    '8e42knu5': {
      'ko': '2분반',
      'en': '',
    },
    '9ikr6d55': {
      'ko': ' 교수님',
      'en': '',
    },
    'qstciubw': {
      'ko': '선택',
      'en': '',
    },
    '6zdsarsz': {
      'ko': '3분반',
      'en': '',
    },
    'l1zvp7ga': {
      'ko': ' 교수님',
      'en': '',
    },
    'z58bn64g': {
      'ko': '선택',
      'en': '',
    },
    'lf1carfg': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'cleistme': {
      'ko': '총 진행사항',
      'en': '',
    },
    'it7y7cqr': {
      'ko': '0%',
      'en': '',
    },
    '13vwxyda': {
      'ko': '100%',
      'en': '',
    },
    'hk2xvnu1': {
      'ko': '주차별 업로드현황',
      'en': '',
    },
    '1gn8sqdi': {
      'ko': '포트폴리오 크리틱',
      'en': '',
    },
    'pqraoy0v': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '1gbf0405': {
      'ko': '학생 업로드현황 ',
      'en': '',
    },
    '5hz8eudi': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'vslmm33a': {
      'ko': '0%',
      'en': '',
    },
    'mg5khfjj': {
      'ko': '100%',
      'en': '',
    },
    '260yrrl1': {
      'ko': '미제출 조회',
      'en': '',
    },
    'hk2ixdzt': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    '8j802clm': {
      'ko': '1차 성과물',
      'en': '',
    },
    '0yh1k875': {
      'ko': '[제출됨]',
      'en': '',
    },
    'xevn9vjd': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'o3wlpukr': {
      'ko': '2차 성과물',
      'en': '',
    },
    'ht2009ck': {
      'ko': '[미제출]',
      'en': '',
    },
    'rb66ky0p': {
      'ko': '바로가기  ▶',
      'en': '',
    },
    'go3z1m0l': {
      'ko': '과목 진행 상황을 조회 할 수 있습니다.',
      'en': '',
    },
    's49bqkt2': {
      'ko': 'Home',
      'en': '',
    },
  },
  // StudentHome
  {
    '0bt2rzpv': {
      'ko': '과목 포트폴리오 업로드 여부',
      'en': '',
    },
    'dzbomooi': {
      'ko': '명단',
      'en': '',
    },
    '1coaa0ir': {
      'ko': '명단',
      'en': '',
    },
    'j4xr7db8': {
      'ko': '미리 보기',
      'en': '',
    },
    'blqtm4sm': {
      'ko': '업로드 최근 글',
      'en': '',
    },
    'uj6vwlpz': {
      'ko': '전체',
      'en': '',
    },
    'noq7i5or': {
      'ko': '[건축학인증 시스템 \'아키버스\' 오픈안내]',
      'en': '',
    },
    'tyybvcy2': {
      'ko': '2025-04-14 03:52',
      'en': '',
    },
    '9kqzavod': {
      'ko': '관리자',
      'en': '',
    },
    'zz1brr4q': {
      'ko': '공지사항',
      'en': '',
    },
    '2swjc332': {
      'ko': '1주차_연희동 구조 시안',
      'en': '',
    },
    'i546co3i': {
      'ko': '2024-05-12 12:22',
      'en': '',
    },
    'cnwjye31': {
      'ko': '김건우 학생',
      'en': '',
    },
    '8hlav7c1': {
      'ko': '강의자료',
      'en': '',
    },
    '54ftsf1q': {
      'ko': '2주차_천안아산시 컨셉 선정',
      'en': '',
    },
    'u1u2m2km': {
      'ko': '2024-08-28 16:22',
      'en': '',
    },
    'qqbxk9vh': {
      'ko': '나영석 학생',
      'en': '',
    },
    'q63nlkju': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    '9oq0u007': {
      'ko': '2주차_천안아산시 컨셉 선정',
      'en': '',
    },
    'ntg64569': {
      'ko': '2024-08-28 16:22',
      'en': '',
    },
    'yojfoboo': {
      'ko': '나영석 학생',
      'en': '',
    },
    'hnd5ka14': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'up26p4eq': {
      'ko': '2주차_천안아산시 컨셉 선정',
      'en': '',
    },
    'nslohyg3': {
      'ko': '2024-08-28 16:22',
      'en': '',
    },
    'yas2jx3v': {
      'ko': '나영석 학생',
      'en': '',
    },
    'cl73sg0b': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'g2zvmwkc': {
      'ko': '크리틱 알림',
      'en': '',
    },
    '5lejv3ye': {
      'ko': '3주차 과제 제출 등록',
      'en': '',
    },
    'gbl7vl3c': {
      'ko': '2024-08-04 11:55',
      'en': '',
    },
    'bajq6xmj': {
      'ko': '김승 교수',
      'en': '',
    },
    '9mqbtt9j': {
      'ko': '캘린더',
      'en': '',
    },
    '4dwiv9dt': {
      'ko': '3주차 과제 제출 등록',
      'en': '',
    },
    '40raka3f': {
      'ko': '2024-08-04 11:55',
      'en': '',
    },
    'w6qxwp8y': {
      'ko': '김승 교수',
      'en': '',
    },
    '6ml165oc': {
      'ko': '캘린더',
      'en': '',
    },
    'lh9qs50q': {
      'ko': '3주차 과제 제출 등록',
      'en': '',
    },
    'ayl9ofy9': {
      'ko': '2024-08-04 11:55',
      'en': '',
    },
    '4mrebbm2': {
      'ko': '김승 교수',
      'en': '',
    },
    'p0r1okfy': {
      'ko': '캘린더',
      'en': '',
    },
    'p9pza7o8': {
      'ko': '일정 알림',
      'en': '',
    },
    'ijmfkc9a': {
      'ko': '[건축학인증 시스템 \'아키버스\' 오픈안내]',
      'en': '',
    },
    'izjqdz9g': {
      'ko': '2025-04-14 03:52',
      'en': '',
    },
    '6dl37kny': {
      'ko': '관리자',
      'en': '',
    },
    'ee00k207': {
      'ko': '공지사항',
      'en': '',
    },
    '7x544rmi': {
      'ko': '3주차 과제 제출 등록',
      'en': '',
    },
    'vkpo8kn4': {
      'ko': '2024-08-04 11:55',
      'en': '',
    },
    'dd7xeiwc': {
      'ko': '김승 교수',
      'en': '',
    },
    'linnxjcg': {
      'ko': '캘린더',
      'en': '',
    },
    '9naacc4r': {
      'ko': '1주차_연희동 구조 시안',
      'en': '',
    },
    'kx5o221b': {
      'ko': '2024-05-12 12:22',
      'en': '',
    },
    '70xfynf1': {
      'ko': '김건우 학생',
      'en': '',
    },
    'hgjwl866': {
      'ko': '강의자료',
      'en': '',
    },
    '65454cn4': {
      'ko': '1주차_연희동 구조 시안',
      'en': '',
    },
    'zoxtxlsz': {
      'ko': '2024-05-12 12:22',
      'en': '',
    },
    'lveiwc55': {
      'ko': '김건우 학생',
      'en': '',
    },
    'hhqtnd9g': {
      'ko': '강의자료',
      'en': '',
    },
    'k327zwb7': {
      'ko': '1주차_연희동 구조 시안',
      'en': '',
    },
    'to5ga9l3': {
      'ko': '2024-05-12 12:22',
      'en': '',
    },
    'i17f1cte': {
      'ko': '김건우 학생',
      'en': '',
    },
    'chukl0pr': {
      'ko': '강의자료',
      'en': '',
    },
    '72sqb76g': {
      'ko': '파일 업로드 알림',
      'en': '',
    },
    'vspurnl8': {
      'ko': '과목 포트폴리오 업로드 여부',
      'en': '',
    },
    '35623la4': {
      'ko': '명단',
      'en': '',
    },
    'msqilqqc': {
      'ko': '명단',
      'en': '',
    },
    'l92dwfqj': {
      'ko': '미리 보기',
      'en': '',
    },
    'sc96jofd': {
      'ko': '업로드 최근 글',
      'en': '',
    },
    '0rb1ve3e': {
      'ko': '전체',
      'en': '',
    },
    'z4z8uaiq': {
      'ko': '[건축학인증 시스템 \'아키버스\' 오픈안내]',
      'en': '',
    },
    '150i1991': {
      'ko': '2025-04-14 03:52',
      'en': '',
    },
    'bedf738w': {
      'ko': '관리자',
      'en': '',
    },
    'tj373mtc': {
      'ko': '공지사항',
      'en': '',
    },
    '1bb4qr3r': {
      'ko': '1주차_연희동 구조 시안',
      'en': '',
    },
    'qq82ldef': {
      'ko': '2024-05-12 12:22',
      'en': '',
    },
    '0y6kzbqv': {
      'ko': '김건우 학생',
      'en': '',
    },
    'zvvof8hd': {
      'ko': '강의자료',
      'en': '',
    },
    'j5918b9e': {
      'ko': '2주차_천안아산시 컨셉 선정',
      'en': '',
    },
    'luuwxm1g': {
      'ko': '2024-08-28 16:22',
      'en': '',
    },
    '0wfpl0l2': {
      'ko': '나영석 학생',
      'en': '',
    },
    '1nguvkts': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'r2hlbfcf': {
      'ko': '2주차_천안아산시 컨셉 선정',
      'en': '',
    },
    'e4m3qz6k': {
      'ko': '2024-08-28 16:22',
      'en': '',
    },
    'szdcom27': {
      'ko': '나영석 학생',
      'en': '',
    },
    'g42be6n2': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    'zmvt5sys': {
      'ko': '2주차_천안아산시 컨셉 선정',
      'en': '',
    },
    '29328dbf': {
      'ko': '2024-08-28 16:22',
      'en': '',
    },
    '9qfpwsz2': {
      'ko': '나영석 학생',
      'en': '',
    },
    'ghznl1mp': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    '741p9797': {
      'ko': '크리틱 알림',
      'en': '',
    },
    '8u3wyn9o': {
      'ko': '3주차 과제 제출 등록',
      'en': '',
    },
    'hpwencrb': {
      'ko': '2024-08-04 11:55',
      'en': '',
    },
    '93mioxtg': {
      'ko': '김승 교수',
      'en': '',
    },
    'x23gpepp': {
      'ko': '캘린더',
      'en': '',
    },
    'x3hh296v': {
      'ko': '3주차 과제 제출 등록',
      'en': '',
    },
    '8t04cqqt': {
      'ko': '2024-08-04 11:55',
      'en': '',
    },
    'kblyjt3d': {
      'ko': '김승 교수',
      'en': '',
    },
    '277l7jim': {
      'ko': '캘린더',
      'en': '',
    },
    '9vnmbg7g': {
      'ko': '3주차 과제 제출 등록',
      'en': '',
    },
    'g8qzmk4o': {
      'ko': '2024-08-04 11:55',
      'en': '',
    },
    'wm4qom1h': {
      'ko': '김승 교수',
      'en': '',
    },
    'dqkvv8zh': {
      'ko': '캘린더',
      'en': '',
    },
    'f5byv4cd': {
      'ko': '일정 알림',
      'en': '',
    },
    '5odnl2ww': {
      'ko': '[건축학인증 시스템 \'아키버스\' 오픈안내]',
      'en': '',
    },
    '0bw4diah': {
      'ko': '2025-04-14 03:52',
      'en': '',
    },
    '2boj5x3m': {
      'ko': '관리자',
      'en': '',
    },
    'fa8x9yl4': {
      'ko': '공지사항',
      'en': '',
    },
    'edibxpzx': {
      'ko': '3주차 과제 제출 등록',
      'en': '',
    },
    'of8i2hf0': {
      'ko': '2024-08-04 11:55',
      'en': '',
    },
    'yth0oi0w': {
      'ko': '김승 교수',
      'en': '',
    },
    'mgy347kf': {
      'ko': '캘린더',
      'en': '',
    },
    'bkhv5yhr': {
      'ko': '1주차_연희동 구조 시안',
      'en': '',
    },
    'u0zcum4e': {
      'ko': '2024-05-12 12:22',
      'en': '',
    },
    'b0rlbkbu': {
      'ko': '김건우 학생',
      'en': '',
    },
    '2iq1u2li': {
      'ko': '강의자료',
      'en': '',
    },
    'bnqn5emr': {
      'ko': '1주차_연희동 구조 시안',
      'en': '',
    },
    'ojar421q': {
      'ko': '2024-05-12 12:22',
      'en': '',
    },
    'q2pu87zz': {
      'ko': '김건우 학생',
      'en': '',
    },
    'p176v5wa': {
      'ko': '강의자료',
      'en': '',
    },
    'qk1o6gs2': {
      'ko': '1주차_연희동 구조 시안',
      'en': '',
    },
    'tlz6t24s': {
      'ko': '2024-05-12 12:22',
      'en': '',
    },
    'o110sx83': {
      'ko': '김건우 학생',
      'en': '',
    },
    'jkew761x': {
      'ko': '강의자료',
      'en': '',
    },
    'iqfhnwwz': {
      'ko': '파일 업로드 알림',
      'en': '',
    },
    'eriq0qgy': {
      'ko': 'Home',
      'en': '',
    },
  },
  // StudentMyProfile
  {
    'x1n7bsm3': {
      'ko': '[기본 설정]',
      'en': '',
    },
    'jwlryybj': {
      'ko': '업로드',
      'en': '',
    },
    'k7iuvw1i': {
      'ko': '성명',
      'en': '',
    },
    'fezi358g': {
      'ko': '이름',
      'en': '',
    },
    'v8p1vyn4': {
      'ko': '연락처',
      'en': '',
    },
    'egyh4zma': {
      'ko': '010-1234-5678',
      'en': '',
    },
    'lwdsfxja': {
      'ko': '출생연도',
      'en': '',
    },
    'pln3kdzz': {
      'ko': '2002.02',
      'en': '',
    },
    'vfs4gr2p': {
      'ko': '이메일',
      'en': '',
    },
    't3hjm1cy': {
      'ko': '010-1234-5678',
      'en': '',
    },
    '057z5gjx': {
      'ko': '성별',
      'en': '',
    },
    'oimzepf5': {
      'ko': '남자',
      'en': '',
    },
    'jmcmweqn': {
      'ko': '여자',
      'en': '',
    },
    'vsq74p5r': {
      'ko': '입학',
      'en': '',
    },
    '6l4ia72s': {
      'ko': '신입학',
      'en': '',
    },
    '2reh6cef': {
      'ko': '신입학',
      'en': '',
    },
    'rlpkhayw': {
      'ko': '편입',
      'en': '',
    },
    'qrgompjg': {
      'ko': '전과',
      'en': '',
    },
    'rrqxz79d': {
      'ko': '재학 여부',
      'en': '',
    },
    'w294whdt': {
      'ko': '재학',
      'en': '',
    },
    'jze3pzr2': {
      'ko': '졸업',
      'en': '',
    },
    'izqiq8ts': {
      'ko': '휴학',
      'en': '',
    },
    '64tq1lz1': {
      'ko': '이탈',
      'en': '',
    },
    '11nnabn7': {
      'ko': '학년 설정',
      'en': '',
    },
    '8lebhwsm': {
      'ko': '학년 선택',
      'en': '',
    },
    'q17hi8ny': {
      'ko': 'Search...',
      'en': '',
    },
    'eyer5u0j': {
      'ko': '1학년',
      'en': '',
    },
    '6zllqd1v': {
      'ko': '2학년',
      'en': '',
    },
    'yeock9ud': {
      'ko': '3학년',
      'en': '',
    },
    'nwqdanux': {
      'ko': '4학년',
      'en': '',
    },
    'mt9is3wo': {
      'ko': '5학년',
      'en': '',
    },
    'th28qgbo': {
      'ko': '2025',
      'en': '',
    },
    '8v3g9zva': {
      'ko': '년도',
      'en': '',
    },
    'lsgim9k7': {
      'ko': 'Search...',
      'en': '',
    },
    'vjo9vbm3': {
      'ko': '2023',
      'en': '',
    },
    'sh3e1lcd': {
      'ko': '2024',
      'en': '',
    },
    'vklz9mqc': {
      'ko': '2025',
      'en': '',
    },
    'tnj1s4wq': {
      'ko': '1학기',
      'en': '',
    },
    'c2bnscqq': {
      'ko': '학기',
      'en': '',
    },
    'eg5xxtp8': {
      'ko': 'Search...',
      'en': '',
    },
    'pl5kca7c': {
      'ko': '1학기',
      'en': '',
    },
    '8jg81m9g': {
      'ko': '여름학기',
      'en': '',
    },
    'p2h108v6': {
      'ko': '2학기',
      'en': '',
    },
    'qr2qq51f': {
      'ko': '겨울학기',
      'en': '',
    },
    'd3qfa4f6': {
      'ko': '과목 설정',
      'en': '',
    },
    '5chebhgb': {
      'ko': '건축설계I ',
      'en': '',
    },
    'f12gwjkn': {
      'ko': '참여중인 전공과목 (분반)',
      'en': '',
    },
    '5shrlsan': {
      'ko': 'Search...',
      'en': '',
    },
    'ujubih57': {
      'ko': '건축설계I ',
      'en': '',
    },
    '2jb1ovjm': {
      'ko': '건축설계III ',
      'en': '',
    },
    '81y3ja2a': {
      'ko': '건축설계V ',
      'en': '',
    },
    '2c35mqle': {
      'ko': '건축설계VII ',
      'en': '',
    },
    'fuhtr4vu': {
      'ko': '건축설계IX ',
      'en': '',
    },
    'z7l1novg': {
      'ko': '분반 설정',
      'en': '',
    },
    '31e2fu2l': {
      'ko': '1분반',
      'en': '',
    },
    'b7adey80': {
      'ko': '1분반',
      'en': '',
    },
    'o5dxga1j': {
      'ko': '2분반',
      'en': '',
    },
    'uxbtp9wp': {
      'ko': '3분반',
      'en': '',
    },
    'k67nkmtx': {
      'ko': '취업 여부',
      'en': '',
    },
    '1i2j8twx': {
      'ko': '(중복 선택 불가)',
      'en': '',
    },
    '9q5fefxc': {
      'ko': '미취업',
      'en': '',
    },
    'wqx7gx68': {
      'ko': '미취업',
      'en': '',
    },
    'p0aj30xe': {
      'ko': '취업중',
      'en': '',
    },
    '2ets26u4': {
      'ko': '취업 확정',
      'en': '',
    },
    'dc8qnv53': {
      'ko': '취업 확정인 경우',
      'en': '',
    },
    'y27g5uiv': {
      'ko': '(0000 회사 / 충남 아산 / 2024.00)',
      'en': '',
    },
    'hlncvx6m': {
      'ko': '관심 분야',
      'en': '',
    },
    'zphgqj2u': {
      'ko': '(중복 선택 가능)',
      'en': '',
    },
    '4tj722uv': {
      'ko': '설계분야',
      'en': '',
    },
    'yx7vox3e': {
      'ko': '시공분야',
      'en': '',
    },
    'cjbq3lyc': {
      'ko': '환경분야',
      'en': '',
    },
    '44pfys6y': {
      'ko': '구조분야',
      'en': '',
    },
    'ft12evfg': {
      'ko': '조경분야',
      'en': '',
    },
    '30lactjm': {
      'ko': '실내분야',
      'en': '',
    },
    '2tr5fqya': {
      'ko': '기타',
      'en': '',
    },
    '8gzfsxgw': {
      'ko': '기타 선택한 경우',
      'en': '',
    },
    'd42s0mf8': {
      'ko': '(기입)',
      'en': '',
    },
    'rwcidvr8': {
      'ko': '[취득자격 (수료)]',
      'en': '',
    },
    '1klf4c5o': {
      'ko':
          '-건축기사2급 / 한국기술관리공단/ 2024.03\n-드론운영 4급 / OOO센터 / 2023.05\n-스케치업 2급 / 트림블(주) /2022.04\n-OOOOOOOO',
      'en': '',
    },
    'dcxvhxjo': {
      'ko': '[공모전 참여 및 수상] ',
      'en': '',
    },
    'szg0r0ps': {
      'ko': '-(참여)제4회 충남 건축문화제/ 2022.06\n-(수상)제5회 충남 건축문화제 대상/ 2023.06',
      'en': '',
    },
    'fcql1va7': {
      'ko': '[참여 네트워킹]',
      'en': '',
    },
    'np8x8wk2': {
      'ko': '-00 동아리 활동 2024.03~2024.07\n-00 모임 주최 2022.01~2022.10',
      'en': '',
    },
    'od1wuccq': {
      'ko': '[프로그램 활용 능력]',
      'en': '',
    },
    'nfqn275o': {
      'ko':
          '- GTQ 그래픽 활용 가능(Photoshop, Illustrator 등) 2년\n- 드론 운영 숙련 (촬영 및 측량 업무 등) 1년\n- 스케치업 모델링 및 렌더링 경험 1년 ',
      'en': '',
    },
    'j99zj6he': {
      'ko': '적용',
      'en': '',
    },
    '32c80wju': {
      'ko': '취소',
      'en': '',
    },
    'rdj7lbnk': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Prof_MyProfile
  {
    '3uadb3vu': {
      'ko': '[기본 설정]',
      'en': '',
    },
    'ew8xcbuw': {
      'ko': '업로드',
      'en': '',
    },
    'qau5753r': {
      'ko': '성명',
      'en': '',
    },
    '3rvsd60q': {
      'ko': '연락처',
      'en': '',
    },
    'px7s359a': {
      'ko': '010-1234-5678',
      'en': '',
    },
    'qipqm2kr': {
      'ko': '출생',
      'en': '',
    },
    '2ah9r4nv': {
      'ko': '0000.00',
      'en': '',
    },
    'y9f1cpiy': {
      'ko': '이메일',
      'en': '',
    },
    '1657gish': {
      'ko': '소속기관',
      'en': '',
    },
    'hgnmusij': {
      'ko': '순천향대학교 건축학과',
      'en': '',
    },
    '3dsb8u04': {
      'ko': '순천향대학교 건축학과',
      'en': '',
    },
    'hwepwafm': {
      'ko': '직책',
      'en': '',
    },
    'h3d8rjue': {
      'ko': '000 건축사회 부장',
      'en': '',
    },
    'yfbo7xjg': {
      'ko': '교수/직급',
      'en': '',
    },
    'mtw428iw': {
      'ko': '중복선택 불가',
      'en': '',
    },
    'n04ltll6': {
      'ko': '교수',
      'en': '',
    },
    'h98p06pq': {
      'ko': '겸임교수',
      'en': '',
    },
    'yoe20ttz': {
      'ko': '부교수',
      'en': '',
    },
    'gufm3ud4': {
      'ko': '외래강사',
      'en': '',
    },
    'wkqh2lzl': {
      'ko': '조교수',
      'en': '',
    },
    'tshmti4o': {
      'ko': '자격증여부',
      'en': '',
    },
    'enfc42ye': {
      'ko': '중복선택 가능',
      'en': '',
    },
    'dkdjih3h': {
      'ko': '건축사 X',
      'en': '',
    },
    'zsl7644y': {
      'ko': '건축사 (KR)',
      'en': '',
    },
    '81evr463': {
      'ko': '건축사 해외',
      'en': '',
    },
    'kr0pvnl1': {
      'ko': '건축사 취득국가',
      'en': '',
    },
    'lw1gmyfz': {
      'ko': '기술사 X',
      'en': '',
    },
    '3f77m4mk': {
      'ko': '기술사 (KR)',
      'en': '',
    },
    'dm3k8m83': {
      'ko': '기술사 해외',
      'en': '',
    },
    '4fhdm27x': {
      'ko': '기술사 취득국가',
      'en': '',
    },
    'fhitymps': {
      'ko': '전문분야',
      'en': '',
    },
    '3u1bw8mo': {
      'ko': '중복선택 가능',
      'en': '',
    },
    'ocskd7zn': {
      'ko': '설계분야',
      'en': '',
    },
    'y6w18cm5': {
      'ko': '디지털분야',
      'en': '',
    },
    '2krcaud0': {
      'ko': '환경분야',
      'en': '',
    },
    'kfw9fjyg': {
      'ko': '기타',
      'en': '',
    },
    'z6xljota': {
      'ko': '시공분야',
      'en': '',
    },
    'rgrtdouh': {
      'ko': '구조분야',
      'en': '',
    },
    '72bcm0kx': {
      'ko': '조경분야',
      'en': '',
    },
    '9v2hle1k': {
      'ko': '기타 전문분야',
      'en': '',
    },
    'ib59489c': {
      'ko': '[학력 설정]',
      'en': '',
    },
    'wbc1rycr': {
      'ko': '추가 +',
      'en': '',
    },
    'adyemods': {
      'ko': '삭제 -',
      'en': '',
    },
    'bagrzgyr': {
      'ko': '[강사 경력]',
      'en': '',
    },
    '0ci94j6j': {
      'ko': '추가 +',
      'en': '',
    },
    'd31dksav': {
      'ko': '삭제 -',
      'en': '',
    },
    'tshfg401': {
      'ko': '[주요성과 및 프로젝트]',
      'en': '',
    },
    'bbx9df2u': {
      'ko': '논문. 프로젝트 등 경력사항',
      'en': '',
    },
    'j7aomech': {
      'ko': '적용',
      'en': '',
    },
    '3flj97lu': {
      'ko': '초기화',
      'en': '',
    },
    'ietmoizm': {
      'ko': '마이 프로필  등록',
      'en': '',
    },
    'm6t6p3e8': {
      'ko': '프로필 작성을 진행하시겠습니까?',
      'en': '',
    },
    '14speupj': {
      'ko': '네',
      'en': '',
    },
    '6z1tem9w': {
      'ko': '아니오',
      'en': '',
    },
    'zlqwx84z': {
      'ko': 'Home',
      'en': '',
    },
  },
  // AdminPortfolio
  {
    '9wuf8zxs': {
      'ko': '년도 선택',
      'en': '',
    },
    'wtwf9g4p': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'drhaw2v6': {
      'ko': '학기 선택',
      'en': '',
    },
    'z9yfouqx': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'c7iqa6ee': {
      'ko': '년',
      'en': '',
    },
    'ayyij5kr': {
      'ko': '  ',
      'en': '',
    },
    '65ljgd1s': {
      'ko': '1학년',
      'en': '',
    },
    '0j4gj5tl': {
      'ko': '2학년',
      'en': '',
    },
    'sdcrmu5s': {
      'ko': '3학년',
      'en': '',
    },
    'ztn28yow': {
      'ko': '4학년',
      'en': '',
    },
    'vn7jr5la': {
      'ko': '5학년',
      'en': '',
    },
    '45jyud97': {
      'ko': '검색할 과목의 이름을 입력하세요',
      'en': '',
    },
    'idd34kfb': {
      'ko': '과목 검색',
      'en': '',
    },
    'm6bp3hq7': {
      'ko': '설계 과목',
      'en': '',
    },
    'fr7d5yrh': {
      'ko': '이론 과목',
      'en': '',
    },
    'pk4k3t54': {
      'ko': '검색결과',
      'en': '',
    },
    'aqrqtdr6': {
      'ko': '수업명',
      'en': '',
    },
    '53ze6m9i': {
      'ko': '파일 다운로드[받기]',
      'en': '',
    },
    'vktqk9jv': {
      'ko': '크리틱 내용',
      'en': '',
    },
    'rae734ob': {
      'ko': '수 정',
      'en': '',
    },
    'i78cne66': {
      'ko': 'TextField',
      'en': '',
    },
    'kehlinhf': {
      'ko': '업로드 / 선택 된 파일이 없습니다.',
      'en': '',
    },
    'rtel7ssw': {
      'ko': '년도 선택',
      'en': '',
    },
    'xf9er49t': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'a9dn1mdk': {
      'ko': '학기 선택',
      'en': '',
    },
    'lnjx2yu2': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '3q593klj': {
      'ko': '포트폴리오 평가/검수 지원',
      'en': '',
    },
    '1qecyua4': {
      'ko': '1학년',
      'en': '',
    },
    'e9qggtxq': {
      'ko': '2학년',
      'en': '',
    },
    '7pqeftm8': {
      'ko': '3학년',
      'en': '',
    },
    'hzy9tx6y': {
      'ko': '4학년',
      'en': '',
    },
    'ybhjzdsf': {
      'ko': '5학년',
      'en': '',
    },
    '1p071qgw': {
      'ko': '설계 과목 조회 ▶',
      'en': '',
    },
    'wq6m3u9b': {
      'ko': '이론 과목 조회 ▶',
      'en': '',
    },
    'u59cbe7q': {
      'ko': '과목 조회',
      'en': '',
    },
    'r8iqi2li': {
      'ko': ' ',
      'en': '',
    },
    'bhpvifub': {
      'ko': '과목 포트폴리오',
      'en': '',
    },
    '13wcouq2': {
      'ko': '1차 결과물',
      'en': '',
    },
    'k6v8v9hb': {
      'ko': '2차 결과물',
      'en': '',
    },
    'onw5yqpw': {
      'ko': ' ',
      'en': '',
    },
    'ixl4206z': {
      'ko': ' | ',
      'en': '',
    },
    'usboqu0j': {
      'ko': '주차별 선택',
      'en': '',
    },
    'c4tr873g': {
      'ko': 'Search...',
      'en': '',
    },
    'k7smz7zn': {
      'ko': '1주차',
      'en': '',
    },
    'pewmr3w2': {
      'ko': '2주차',
      'en': '',
    },
    '1z62ny3y': {
      'ko': '3주차',
      'en': '',
    },
    'gvsczayk': {
      'ko': '4주차',
      'en': '',
    },
    'tqfzod71': {
      'ko': '5주차',
      'en': '',
    },
    'u1f90mvj': {
      'ko': '6주차',
      'en': '',
    },
    '2v2zky6g': {
      'ko': '7주차',
      'en': '',
    },
    '1yvrwhrz': {
      'ko': '8주차',
      'en': '',
    },
    'u9efmf9q': {
      'ko': '9주차',
      'en': '',
    },
    'azhi3v3q': {
      'ko': '10주차',
      'en': '',
    },
    '9drftmrp': {
      'ko': '11주차',
      'en': '',
    },
    'tdp532w0': {
      'ko': '12주차',
      'en': '',
    },
    '1t4flgol': {
      'ko': '13주차',
      'en': '',
    },
    'ughqxzvg': {
      'ko': '14주차',
      'en': '',
    },
    'qz69g3ak': {
      'ko': '15주차',
      'en': '',
    },
    'nxsinzdk': {
      'ko': ' _ ',
      'en': '',
    },
    'uikcr2f1': {
      'ko': '크리틱 내용',
      'en': '',
    },
    'kexcbm81': {
      'ko': '수 정',
      'en': '',
    },
    'mmmmzgzc': {
      'ko': 'TextField',
      'en': '',
    },
    '5czldfz4': {
      'ko': ' ',
      'en': '',
    },
    'iioyra13': {
      'ko': ' | ',
      'en': '',
    },
    '6ft0tdib': {
      'ko': '이 름',
      'en': '',
    },
    'y5pfwljs': {
      'ko': '제출명',
      'en': '',
    },
    'zyyjgzon': {
      'ko': '하',
      'en': '',
    },
    'joa4vj8c': {
      'ko': '중',
      'en': '',
    },
    'znvycebk': {
      'ko': '상',
      'en': '',
    },
    'u7il8jfp': {
      'ko': '총 :',
      'en': '',
    },
    'xv01bboo': {
      'ko': '65',
      'en': '',
    },
    '97kfqkou': {
      'ko': '개',
      'en': '',
    },
    'dwaxgdqa': {
      'ko': '저 장',
      'en': '',
    },
    '3er7qakz': {
      'ko': 'Home',
      'en': '',
    },
  },
  // AdminAccountManage
  {
    'ht5pe10u': {
      'ko': '년도 선택',
      'en': '',
    },
    'sem95osd': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '8iueve7k': {
      'ko': '학기 선택',
      'en': '',
    },
    'n3ybkiib': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'jhixexuo': {
      'ko': '년',
      'en': '',
    },
    'x124n44w': {
      'ko': '  ',
      'en': '',
    },
    '1mzdgllw': {
      'ko': '관리자(Professor/조교) 계정 및 권한 관리',
      'en': '',
    },
    'puoc0cj9': {
      'ko': '이 름',
      'en': '',
    },
    '2henajlj': {
      'ko': 'Search...',
      'en': '',
    },
    'n15kxnyz': {
      'ko': '이 름',
      'en': '',
    },
    'dyvx85vc': {
      'ko': '학 번',
      'en': '',
    },
    'o13eae5a': {
      'ko': '학생 검색',
      'en': '',
    },
    'oig5fahf': {
      'ko': '이름',
      'en': '',
    },
    'eyyrloj9': {
      'ko': '교수/직급',
      'en': '',
    },
    't12i7su7': {
      'ko': '이메일',
      'en': '',
    },
    'xxu3zqom': {
      'ko': '연락처',
      'en': '',
    },
    'or2ecoli': {
      'ko': '권한 설정',
      'en': '',
    },
    'ndcle0l5': {
      'ko': '수정',
      'en': '',
    },
    'b96kkdm8': {
      'ko': '총:',
      'en': '',
    },
    '3kswy82q': {
      'ko': ' 10',
      'en': '',
    },
    '6u9eyyuo': {
      'ko': '명',
      'en': '',
    },
    'c81w60fa': {
      'ko': '년도 선택',
      'en': '',
    },
    'a4klg8ij': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '356jdk8e': {
      'ko': '학기 선택',
      'en': '',
    },
    'pm3mjrqc': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'mfqe38e8': {
      'ko': '관리자 계정 및 권한 관리',
      'en': '',
    },
    'byp1bfcg': {
      'ko': '교수 검색',
      'en': '',
    },
    'n0yu0ina': {
      'ko': '이름',
      'en': '',
    },
    'dp29jpoe': {
      'ko': '교수/직급',
      'en': '',
    },
    '9lweercy': {
      'ko': '권한 설정',
      'en': '',
    },
    'xjknsghj': {
      'ko': '승인',
      'en': '',
    },
    '2akl753m': {
      'ko': '총: ',
      'en': '',
    },
    'semk81sv': {
      'ko': '10',
      'en': '',
    },
    '664ep1ai': {
      'ko': '명',
      'en': '',
    },
    'lbumnk4a': {
      'ko': 'Home',
      'en': '',
    },
  },
  // testDrawers
  {
    '4hueg5o3': {
      'ko': 'Page Title',
      'en': '',
    },
    'i26cr76r': {
      'ko': 'Home',
      'en': '',
    },
  },
  // Divider
  {
    '2pp4br26': {
      'ko': 'or continue with',
      'en': '',
    },
  },
  // Menu
  {
    'gcgjidfr': {
      'ko': 'Active Agents',
      'en': '',
    },
    '57p6qar0': {
      'ko': 'Find to start conversation',
      'en': '',
    },
    'fxmwuxtg': {
      'ko': 'AI Agent!',
      'en': '',
    },
    'idahvjtz': {
      'ko':
          'Upgrade and get the AI agent, Buy your agent that works for you 24/7',
      'en': '',
    },
    'zrp3fn0n': {
      'ko': 'Logout',
      'en': '',
    },
  },
  // Header
  {
    'igfusr48': {
      'ko': '년',
      'en': '',
    },
    '3w5m7y2k': {
      'ko': '검색해주세요...',
      'en': '',
    },
    '961c5w7x': {
      'ko': '3',
      'en': '',
    },
  },
  // CreditCard
  {
    'ojhtn3xs': {
      'ko': 'Credit Card',
      'en': '',
    },
  },
  // NewCardModal2
  {
    '98l68s3p': {
      'ko': 'Add New Card',
      'en': '',
    },
    '1q8hlj0k': {
      'ko': 'Name Card',
      'en': '',
    },
    'ze7wb0e0': {
      'ko': 'Name Card',
      'en': '',
    },
    'ylilr1r7': {
      'ko': 'Card Number',
      'en': '',
    },
    'a2hxlj1x': {
      'ko': 'Card Number',
      'en': '',
    },
    'f5e107o7': {
      'ko': 'Expire Date',
      'en': '',
    },
    'xx8g2xky': {
      'ko': '-- --',
      'en': '',
    },
    '37uzll97': {
      'ko': 'CCV',
      'en': '',
    },
    'd6oh031a': {
      'ko': 'CCV',
      'en': '',
    },
    'ciduuaaf': {
      'ko': 'Save Card',
      'en': '',
    },
  },
  // notifications
  {
    'rfmjblyf': {
      'ko': 'Notifications',
      'en': '',
    },
    'a0sdkt3u': {
      'ko': 'Released Receipt',
      'en': '',
    },
    '25n2r68j': {
      'ko': 'Congratuliation! Your receipt has been released. ',
      'en': '',
    },
    'lugobuyg': {
      'ko': 'click here',
      'en': '',
    },
    '65hb8wc2': {
      'ko': '2 minutes a go',
      'en': '',
    },
    '0p511b8p': {
      'ko': 'Released Receipt',
      'en': '',
    },
    'g6r3e123': {
      'ko': 'Congratuliation! Your receipt has been released. ',
      'en': '',
    },
    'qeutebb0': {
      'ko': 'click here',
      'en': '',
    },
    'nhyfjqr0': {
      'ko': '2 minutes a go',
      'en': '',
    },
    'drrednjp': {
      'ko': 'Released Receipt',
      'en': '',
    },
    'm81vb5fl': {
      'ko': 'Congratuliation! Your receipt has been released. ',
      'en': '',
    },
    'xf1x7y6a': {
      'ko': 'click here',
      'en': '',
    },
    '5wfx0hoy': {
      'ko': '2 minutes a go',
      'en': '',
    },
  },
  // Navigator
  {
    '5bq8258a': {
      'ko': 'Pages',
      'en': '',
    },
    'oyhbo5nn': {
      'ko': 'Call',
      'en': '',
    },
    'cr0x1lbx': {
      'ko': 'Detail Building',
      'en': '',
    },
    '74eqyadf': {
      'ko': 'Edit Profile',
      'en': '',
    },
    'veucobyy': {
      'ko': 'Explore',
      'en': '',
    },
    'c51tj5s6': {
      'ko': 'Home',
      'en': '',
    },
    'q0ow7t34': {
      'ko': 'Login Page',
      'en': '',
    },
    '8wg6inlc': {
      'ko': 'Message',
      'en': '',
    },
    'wwxd7bnj': {
      'ko': 'My Order',
      'en': '',
    },
    '7h4mpnhd': {
      'ko': 'My Profile',
      'en': '',
    },
    'eyrr9y1p': {
      'ko': 'Order',
      'en': '',
    },
    'hvdsc85q': {
      'ko': 'Order History',
      'en': '',
    },
    '8ds58v8l': {
      'ko': 'Payment',
      'en': '',
    },
    'jmgqkkn9': {
      'ko': 'Register Page',
      'en': '',
    },
    'nwdypwdo': {
      'ko': 'Reset Password',
      'en': '',
    },
    'axf62xqn': {
      'ko': 'Setting',
      'en': '',
    },
    'v6rjp5yq': {
      'ko': 'Video Call',
      'en': '',
    },
    '1f7td5fn': {
      'ko': 'Virtual Tour',
      'en': '',
    },
    '7cx0szqb': {
      'ko': 'Modals',
      'en': '',
    },
    '2pw8jlxo': {
      'ko': 'New Card',
      'en': '',
    },
    'e6axn8qs': {
      'ko': 'About Template',
      'en': '',
    },
    'q9udemgw': {
      'ko': 'Builderking',
      'en': '',
    },
  },
  // MessageItem
  {
    'y4qzmmuw': {
      'ko': 'Im good 👍 and you ?\n',
      'en': '',
    },
    's4hhfuyk': {
      'ko': '11:15AM',
      'en': '',
    },
  },
  // SenderItem
  {
    'n2lvrsau': {
      'ko': '1',
      'en': '',
    },
  },
  // UserMenu
  {
    'w5x9s24p': {
      'ko': 'Profile',
      'en': '',
    },
    'xrdkxoie': {
      'ko': 'Settings',
      'en': '',
    },
    'bvec32cr': {
      'ko': 'Logout',
      'en': '',
    },
  },
  // SubmitSearched
  {
    'qo8huwkq': {
      'ko': '1주차_미제출학생 (총 0명)',
      'en': '',
    },
    'hf2cgysh': {
      'ko': '현재 미제출한 학생이 없습니다.',
      'en': '',
    },
  },
  // LeftWidget
  {
    'te1edd2u': {
      'ko': ' 교수님',
      'en': '',
    },
    'xr73vrnj': {
      'ko': '학년 ',
      'en': '',
    },
    '9wiz445n': {
      'ko': '순천향대학교 건축학과',
      'en': '',
    },
    'v48ojf0s': {
      'ko': '오늘의 일정',
      'en': '',
    },
    'q9czmqx2': {
      'ko': '-',
      'en': '',
    },
    'baespqcd': {
      'ko': '작성한 크리틱',
      'en': '',
    },
    'cmmeitxn': {
      'ko': '-',
      'en': '',
    },
    'xzh7t6s2': {
      'ko': '확인된 크리틱',
      'en': '',
    },
    '0hvfh7ub': {
      'ko': '-',
      'en': '',
    },
  },
  // LeftWidgetCopy
  {
    'pnkbmrdg': {
      'ko': '건축설계X',
      'en': '',
    },
    'fulvrog0': {
      'ko': '김승 교수님',
      'en': '',
    },
    'mvdp5fwr': {
      'ko': '5학년 1분반',
      'en': '',
    },
    '3oniyz00': {
      'ko': '순천향대학교 건축학과',
      'en': '',
    },
    '2a05casn': {
      'ko': '오늘의 일정',
      'en': '',
    },
    'snytwwp3': {
      'ko': '0',
      'en': '',
    },
    't5dre45a': {
      'ko': '작성한 크리틱',
      'en': '',
    },
    'lvxgwnfw': {
      'ko': '3',
      'en': '',
    },
    '8j6dimxo': {
      'ko': '확인된 크리틱',
      'en': '',
    },
    'zez2py7s': {
      'ko': '1',
      'en': '',
    },
  },
  // rightwidgetCopy
  {
    '2lmdzc4b': {
      'ko': '성적 기록표',
      'en': '',
    },
    'zqgjuca7': {
      'ko': '성적 기록표',
      'en': '',
    },
    'z3k2y9c0': {
      'ko': '성적 기록표',
      'en': '',
    },
    'jjlr6ya8': {
      'ko': '성적 기록표',
      'en': '',
    },
    'wn4lopyv': {
      'ko': '전체 파일 다운로드',
      'en': '',
    },
    '42np86qh': {
      'ko': '작성할 보고',
      'en': '',
    },
    '7s4t9jzp': {
      'ko': '작성할 보고가 없습니다.',
      'en': '',
    },
    'fr8hx55s': {
      'ko': '피드백 대화창',
      'en': '',
    },
    'sewaj841': {
      'ko': 'Write message down here ...',
      'en': '',
    },
  },
  // RightWidgetPopup
  {
    'k853ntwh': {
      'ko': 'Drop image here, or Browse',
      'en': '',
    },
    'nnhml0as': {
      'ko': 'Supports : JPG, JPEG2000, PNG, PDF',
      'en': '',
    },
    'ofqjckbf': {
      'ko': 'Picture-from-last.jpg',
      'en': '',
    },
    '48isb914': {
      'ko': 'imageㆍ 73MBㆍ JPG',
      'en': '',
    },
    'c1kf8029': {
      'ko': 'Upload',
      'en': '',
    },
  },
  // ChatWidget
  {
    'quemoeq2': {
      'ko': '피드백 대화창',
      'en': '',
    },
    '2wms4gp2': {
      'ko': 'Im good 👍 and you ?\n',
      'en': '',
    },
    'rz52blw6': {
      'ko': '메시지 작성',
      'en': '',
    },
  },
  // GradeDeletePopUp
  {
    'cwq2y78d': {
      'ko': '  첨부파일 삭제',
      'en': '',
    },
    'w7z5gy0u': {
      'ko': '첨부파일을 삭제하시겠습니까?',
      'en': '',
    },
    'y9i7uzy1': {
      'ko': '네',
      'en': '',
    },
    '4sid47bv': {
      'ko': '아니오',
      'en': '',
    },
  },
  // WorkEvalDeletePopUp
  {
    'frlulhi9': {
      'ko': '  첨부파일 삭제',
      'en': '',
    },
    'vyu20ya1': {
      'ko': '첨부파일을 삭제하시겠습니까?',
      'en': '',
    },
    'ska2kzek': {
      'ko': '네',
      'en': '',
    },
    'g4cthjds': {
      'ko': '아니오',
      'en': '',
    },
  },
  // LectureDeletePopUp
  {
    'bx83o82g': {
      'ko': '  첨부파일 삭제',
      'en': '',
    },
    'f1lp0o9r': {
      'ko': '첨부파일을 삭제하시겠습니까?',
      'en': '',
    },
    '5u15fsjt': {
      'ko': '네',
      'en': '',
    },
    'ju8b47ea': {
      'ko': '아니오',
      'en': '',
    },
  },
  // DeletePopUpCopy
  {
    'aa6cajia': {
      'ko': '  첨부파일 삭제',
      'en': '',
    },
    'aowr6xrc': {
      'ko': '첨부파일을 삭제하시겠습니까?',
      'en': '',
    },
    'j766ujpa': {
      'ko': '네',
      'en': '',
    },
    '1ufult6j': {
      'ko': '아니오',
      'en': '',
    },
  },
  // InfoPopUp
  {
    '8x2gdps1': {
      'ko': '확인',
      'en': '',
    },
  },
  // OpenPopUp
  {
    'myzi4dgx': {
      'ko': '서비스 오픈 안내',
      'en': '',
    },
    'cv8fra7m': {
      'ko': '다시 보지 않기',
      'en': '',
    },
    'bqibsdgs': {
      'ko': '확인',
      'en': '',
    },
  },
  // HomeSide
  {
    'd65tlq7g': {
      'ko': 'My Account',
      'en': '',
    },
    '66xismwn': {
      'ko': 'Pedroh Olliveira',
      'en': '',
    },
    'oluibdc6': {
      'ko': 'HomePage',
      'en': '',
    },
    'ilb3z0uw': {
      'ko': 'Clothes & Bags',
      'en': '',
    },
    'gmh94igw': {
      'ko': 'Films & Series',
      'en': '',
    },
    'gr4oh0xz': {
      'ko': 'Games & Consoles ',
      'en': '',
    },
    'lz7jqh57': {
      'ko': 'SmartPhones ',
      'en': '',
    },
    'uje3k55f': {
      'ko': 'Computing',
      'en': '',
    },
    'u0h4815f': {
      'ko': 'Books & Ebooks',
      'en': '',
    },
    'u6y51zeb': {
      'ko': 'Logout',
      'en': '',
    },
  },
  // NaviSidebar
  {
    'f634q456': {
      'ko': '순천향대학교',
      'en': '',
    },
    'x2haqn0l': {
      'ko': '건축학과',
      'en': '',
    },
    '4cndz8ve': {
      'ko': 'Log out',
      'en': '',
    },
  },
  // RightWidget
  {
    'v44fktum': {
      'ko': '성적 기록표',
      'en': '',
    },
    'yoqxbfnh': {
      'ko': '캘린더',
      'en': '',
    },
    'zszdc49x': {
      'ko': '출석부 등록',
      'en': '',
    },
    'b89tcn11': {
      'ko': '포트폴리오 ',
      'en': '',
    },
    'p4vp6yp9': {
      'ko': '전체 파일 다운로드',
      'en': '',
    },
    'pyixj1y9': {
      'ko': '작성할 보고',
      'en': '',
    },
    'oa7r17f4': {
      'ko': '작성할 보고가 없습니다.',
      'en': '',
    },
    'nc8qn4bo': {
      'ko': '피드백 대화창',
      'en': '',
    },
    '8otka16q': {
      'ko': '중앙 통로가 너무 넓습니다.',
      'en': '',
    },
    '3lmkgjou': {
      'ko': 'X ',
      'en': '',
    },
    'sw7hauli': {
      'ko': '21:15',
      'en': '',
    },
    'ihmx396o': {
      'ko': '메시지 작성',
      'en': '',
    },
  },
  // CoursePlanComponent
  {
    'y0dxdbdw': {
      'ko': '첨부 파일: 건축설계 IX ORIENTATION',
      'en': '',
    },
    'zedq30o9': {
      'ko': '2024.03.02',
      'en': '',
    },
    'qk6sic6f': {
      'ko': '다운로드[받기]',
      'en': '',
    },
  },
  // StudentNaviSidebar
  {
    'fb1ild5q': {
      'ko': '순천향대학교',
      'en': '',
    },
    'm6o1mk0k': {
      'ko': '건축학과',
      'en': '',
    },
    'dr6dbif1': {
      'ko': 'Log out',
      'en': '',
    },
  },
  // StudentHeader
  {
    'dfmgybrm': {
      'ko': '년',
      'en': '',
    },
    '32xoiiza': {
      'ko': '검색해주세요...',
      'en': '',
    },
    '4pmni21u': {
      'ko': '3',
      'en': '',
    },
    'edorpysc': {
      'ko': '년',
      'en': '',
    },
    '7io19jqa': {
      'ko': '검색해주세요...',
      'en': '',
    },
    'l8ruse4p': {
      'ko': '3',
      'en': '',
    },
  },
  // StudentRightWidget
  {
    '9q312hvo': {
      'ko': '포트폴리오',
      'en': '',
    },
    '3q9qw2ol': {
      'ko': '강의 자료실',
      'en': '',
    },
    'lmvh7588': {
      'ko': '정보 설정',
      'en': '',
    },
    'yzrz5fft': {
      'ko': ' 성과 업로드',
      'en': '',
    },
    'tdxizxju': {
      'ko': '전체 파일 다운로드',
      'en': '',
    },
    'av8hk6tr': {
      'ko': '작성할 보고',
      'en': '',
    },
    'murdwebl': {
      'ko': '작성할 보고가 없습니다.',
      'en': '',
    },
    'dn79cjn4': {
      'ko': '피드백 대화창',
      'en': '',
    },
    'v2sh7ktw': {
      'ko': '중앙 통로가 너무 넓습니다.',
      'en': '',
    },
    'pn3pkuuv': {
      'ko': 'X ',
      'en': '',
    },
    'boncifgq': {
      'ko': '21:15',
      'en': '',
    },
    'wb2yjsxi': {
      'ko': '메시지 작성',
      'en': '',
    },
  },
  // FileUploadPopUp
  {
    '90ylcmuf': {
      'ko': 'Drop image here, or Browse',
      'en': '',
    },
    'zhy7g6bw': {
      'ko': 'Supports : PDF',
      'en': '',
    },
    'tek3ppub': {
      'ko': '파일 제목을 입력해주세요',
      'en': '',
    },
    'wnc7jtqy': {
      'ko': 'TextField',
      'en': '',
    },
    'ag8xjy7s': {
      'ko': '확인',
      'en': '',
    },
    '105i8l9r': {
      'ko': '업로드',
      'en': '',
    },
  },
  // CoursePlanDeletePopUp
  {
    '12e63e0d': {
      'ko': '  첨부파일 삭제',
      'en': '',
    },
    'i32bqvp0': {
      'ko': '첨부파일을 삭제하시겠습니까?',
      'en': '',
    },
    'efgvu3ro': {
      'ko': '네',
      'en': '',
    },
    'ngy4t7bg': {
      'ko': '아니오',
      'en': '',
    },
  },
  // DownloadPopUp
  {
    'beprhtxe': {
      'ko': '파일 다운로드',
      'en': '',
    },
    'fmax8pdd': {
      'ko': '확인',
      'en': '',
    },
  },
  // AttendanceUploadPopUp
  {
    'drjblx0c': {
      'ko': '업로드 할 파일 놓기, 또는 파일 선택',
      'en': '',
    },
    'ft1d6fq4': {
      'ko': '업로드 가능한 파일 유형 : PDF',
      'en': '',
    },
    'w3qvprtr': {
      'ko': '파일 제목을 입력해주세요',
      'en': '',
    },
    'bg7tbeav': {
      'ko': 'TextField',
      'en': '',
    },
    'mkopdaxb': {
      'ko': '확인',
      'en': '',
    },
    'ap5f90kt': {
      'ko': '업로드',
      'en': '',
    },
  },
  // AttendanceDeletePopUp
  {
    '5im20jnm': {
      'ko': '  첨부파일 삭제',
      'en': '',
    },
    'whhpwuxk': {
      'ko': '첨부파일을 삭제하시겠습니까?',
      'en': '',
    },
    'dhdo2cg1': {
      'ko': '네',
      'en': '',
    },
    'yu0h0us1': {
      'ko': '아니오',
      'en': '',
    },
  },
  // GradeFileUploadPopUp
  {
    'lda6gszu': {
      'ko': 'Drop image here, or Browse',
      'en': '',
    },
    '3l0yvs7d': {
      'ko': 'Supports : PDF',
      'en': '',
    },
    'lkug1a9z': {
      'ko': '파일 제목을 입력해주세요',
      'en': '',
    },
    't9j5u89r': {
      'ko': 'TextField',
      'en': '',
    },
    '55z47rlg': {
      'ko': '확인',
      'en': '',
    },
    '0miosm1w': {
      'ko': '업로드',
      'en': '',
    },
  },
  // WorkEvalUploadPopUp
  {
    'pie5nljk': {
      'ko': 'Drop image here, or Browse',
      'en': '',
    },
    '1xsk80in': {
      'ko': 'Supports : PDF',
      'en': '',
    },
    'fypyhh0w': {
      'ko': '파일 제목을 입력해주세요',
      'en': '',
    },
    'a6pnc51b': {
      'ko': 'TextField',
      'en': '',
    },
    'b7rhcrak': {
      'ko': '확인',
      'en': '',
    },
    '3x3jni9i': {
      'ko': '업로드',
      'en': '',
    },
  },
  // LectureListRow
  {
    'cacgnogz': {
      'ko': '다운로드[받기]',
      'en': '',
    },
  },
  // LectureFileUploadPopUp
  {
    'llfoiauk': {
      'ko': 'Drop image here, or Browse',
      'en': '',
    },
    '5hk94x7y': {
      'ko': 'Supports : PDF',
      'en': '',
    },
    'szz42dyk': {
      'ko': '파일 제목을 입력해주세요',
      'en': '',
    },
    '97l45d7l': {
      'ko': 'TextField',
      'en': '',
    },
    '95xhkp4a': {
      'ko': '확인',
      'en': '',
    },
    'g9kt3k6o': {
      'ko': '업로드',
      'en': '',
    },
  },
  // ResultMidUploadPopUp
  {
    '4hm26lxi': {
      'ko': 'Drop image here, or Browse',
      'en': '',
    },
    'i7o57tir': {
      'ko': 'Supports : PDF',
      'en': '',
    },
    'cyrugs0a': {
      'ko': '파일 제목을 입력해주세요',
      'en': '',
    },
    'slrxi61i': {
      'ko': 'TextField',
      'en': '',
    },
    'v2p6bzmo': {
      'ko': '확인',
      'en': '',
    },
    'v8oa5pl1': {
      'ko': '업로드',
      'en': '',
    },
  },
  // ResultFinalUploadPopUp
  {
    'k8n60w3x': {
      'ko': 'Drop image here, or Browse',
      'en': '',
    },
    'ampigkm6': {
      'ko': 'Supports : PDF',
      'en': '',
    },
    'i2ztzqxh': {
      'ko': '파일 제목을 입력해주세요',
      'en': '',
    },
    'ox4ygt9c': {
      'ko': 'TextField',
      'en': '',
    },
    'egkj4qj7': {
      'ko': '확인',
      'en': '',
    },
    'h2vt7q5t': {
      'ko': '업로드',
      'en': '',
    },
  },
  // SubjectPortpolioUploadPopUp
  {
    '8l3kwzeg': {
      'ko': '클릭해서, 파일을 선택해주세요',
      'en': '',
    },
    '18k3cc9m': {
      'ko': 'Supports : PDF',
      'en': '',
    },
    'gfpvu398': {
      'ko': '파일 제목을 입력해주세요',
      'en': '',
    },
    'ej0o0n5c': {
      'ko': 'TextField',
      'en': '',
    },
    'h37gfnc8': {
      'ko': '확인',
      'en': '',
    },
    'ned8emke': {
      'ko': '업로드',
      'en': '',
    },
  },
  // StudentNaviSidebar_Mobile
  {
    'vx1jx7yw': {
      'ko': '순천향대학교',
      'en': '',
    },
    'vw81dmlt': {
      'ko': '건축학과',
      'en': '',
    },
    'ngavxn8d': {
      'ko': 'Log out',
      'en': '',
    },
  },
  // StudentNaviBackup
  {
    'dkj4mdo9': {
      'ko': '순천향대학교',
      'en': '',
    },
    '87jvxp2d': {
      'ko': '건축학과',
      'en': '',
    },
    'gypsxppc': {
      'ko': 'Log out',
      'en': '',
    },
  },
  // NaviSidebar_Mobile
  {
    'tvbqtvc7': {
      'ko': '순천향대학교',
      'en': '',
    },
    'sx7730p8': {
      'ko': '건축학과',
      'en': '',
    },
    'pgue1d0c': {
      'ko': 'Log out',
      'en': '',
    },
  },
  // ProgressContainer_S
  {
    't8rzh23o': {
      'ko': '0%',
      'en': '',
    },
    '58xgozic': {
      'ko': '100%',
      'en': '',
    },
  },
  // lectureMaterial
  {
    '6szig3c8': {
      'ko': 'Hello World',
      'en': '',
    },
  },
  // ProgressContainer_detail
  {
    'o8mb7176': {
      'ko': '0%',
      'en': '',
    },
    '9e3cjezh': {
      'ko': '100%',
      'en': '',
    },
  },
  // ProgressContainer_Weeks
  {
    '7j1xuimo': {
      'ko': '설계 과목 이수 주차',
      'en': '',
    },
    'vhb04ky9': {
      'ko': '0주',
      'en': '',
    },
    'xo9mdukn': {
      'ko': '15주',
      'en': '',
    },
  },
  // gradeSelectChip
  {
    'dqfwjziz': {
      'ko': '학년',
      'en': '',
    },
    '24gekkjw': {
      'ko': '5학년',
      'en': '',
    },
  },
  // dashboard_ClassContainerM
  {
    'r7cgd8ez': {
      'ko': ' 교수님',
      'en': '',
    },
    'uo3v6o9b': {
      'ko': '진행사항 조회 ▶',
      'en': '',
    },
  },
  // dashboard_ClassContainer
  {
    'w6c6y504': {
      'ko': ' 교수님',
      'en': '',
    },
    'kumz3s5t': {
      'ko': '진행사항 조회 ▶',
      'en': '',
    },
    'p8xv46d3': {
      'ko': 'PDF 다운로드',
      'en': '',
    },
  },
  // DegreeInput
  {
    'w1v333ct': {
      'ko': '취득일',
      'en': '',
    },
    '3kmc5wyg': {
      'ko': '250101',
      'en': '',
    },
    'mn4bzf0q': {
      'ko': '학교',
      'en': '',
    },
    '6h5zghhw': {
      'ko': '0000 대학교',
      'en': '',
    },
    'slibnb6d': {
      'ko': '전공',
      'en': '',
    },
    'zso1zf3e': {
      'ko': '세부전공',
      'en': '',
    },
    'xf0vvn5s': {
      'ko': '학위',
      'en': '',
    },
    '9rqtqg50': {
      'ko': '000사',
      'en': '',
    },
  },
  // TeachingHistory
  {
    'gvse4t8a': {
      'ko': '기간',
      'en': '',
    },
    'n4j2zdrk': {
      'ko': '학교/학과',
      'en': '',
    },
    '2m2sna8t': {
      'ko': '0000 대학교/000과',
      'en': '',
    },
    'jjosp5l3': {
      'ko': '과목',
      'en': '',
    },
    'y78phmds': {
      'ko': '00000',
      'en': '',
    },
    'gpulekqx': {
      'ko': '학점/시간',
      'en': '',
    },
    '2wqy79fj': {
      'ko': '00/00',
      'en': '',
    },
  },
  // StudentLeftWidget
  {
    'h79itc5w': {
      'ko': ' 학부생',
      'en': '',
    },
    'j0qgvqqe': {
      'ko': '학년 ',
      'en': '',
    },
    'a1p3ka2x': {
      'ko': '순천향대학교 건축학과',
      'en': '',
    },
    'obpezwyz': {
      'ko': '오늘의 일정',
      'en': '',
    },
    'wofjtvi5': {
      'ko': '-',
      'en': '',
    },
    't9jmulfr': {
      'ko': '등록된 크리틱',
      'en': '',
    },
    '1urtnl98': {
      'ko': '-',
      'en': '',
    },
  },
  // AdminNaviSidebar
  {
    'qqxaqtp4': {
      'ko': '순천향대학교',
      'en': '',
    },
    '54sngwm7': {
      'ko': '건축학과',
      'en': '',
    },
    '62hmobjm': {
      'ko': '관리자',
      'en': '',
    },
    '43a1mt1c': {
      'ko': 'Log out',
      'en': '',
    },
  },
  // portfolio_ClassContainer
  {
    'z2xru3df': {
      'ko': ' 교수님',
      'en': '',
    },
    'tbozmt6o': {
      'ko': '진행사항 조회 ▶',
      'en': '',
    },
  },
  // ClassChangeRow
  {
    '746w2qiz': {
      'ko': '[분반변경]',
      'en': '',
    },
    'mrui4dhx': {
      'ko': 'from',
      'en': '',
    },
    '5dw7cwue': {
      'ko': ' -> ',
      'en': '',
    },
    'yrll0odg': {
      'ko': 'to',
      'en': '',
    },
    '1ak077ow': {
      'ko': '승인',
      'en': '',
    },
  },
  // ClassChangeRow_Mobile
  {
    'svu01in4': {
      'ko': '승인',
      'en': '',
    },
  },
  // AccountManageRow
  {
    'yt5tcduf': {
      'ko': '직급 선택',
      'en': '',
    },
    'k63ty06u': {
      'ko': 'Search...',
      'en': '',
    },
    'knb7lib7': {
      'ko': 'PD교수',
      'en': '',
    },
    'w82m8xf4': {
      'ko': '정교수',
      'en': '',
    },
    'l14d8d4d': {
      'ko': '부교수',
      'en': '',
    },
    'bdppbwit': {
      'ko': '겸임교수',
      'en': '',
    },
    'fpcbi6f2': {
      'ko': '인증조교',
      'en': '',
    },
    'res31ula': {
      'ko': '권한선택',
      'en': '',
    },
    'pgskvanl': {
      'ko': 'Search...',
      'en': '',
    },
    '1pk19gyt': {
      'ko': '멤버',
      'en': '',
    },
    'cvxeomw7': {
      'ko': '마스터',
      'en': '',
    },
  },
  // AccountManageRow_Mobile
  {
    'z343ki7l': {
      'ko': '직급',
      'en': '',
    },
    'tydodi4c': {
      'ko': 'Search...',
      'en': '',
    },
    'mb3npfo1': {
      'ko': 'PD교수',
      'en': '',
    },
    '0vhldvlp': {
      'ko': '정교수',
      'en': '',
    },
    '3e1pixer': {
      'ko': '부교수',
      'en': '',
    },
    'm0j5ogkh': {
      'ko': '겸임교수',
      'en': '',
    },
    'dh76ex0t': {
      'ko': '인증조교',
      'en': '',
    },
    'b6a4fzbx': {
      'ko': '권한',
      'en': '',
    },
    '73i1j5c3': {
      'ko': 'Search...',
      'en': '',
    },
    'qndnhdqy': {
      'ko': '멤버',
      'en': '',
    },
    'alvyj0rj': {
      'ko': '마스터',
      'en': '',
    },
  },
  // ProgressContainer_studentSubmit
  {
    'yv9gddw4': {
      'ko': '0%',
      'en': '',
    },
    '12nfbrz4': {
      'ko': '100%',
      'en': '',
    },
  },
  // CheckSubmitted
  {
    'p0mn5wvb': {
      'ko': '1주차',
      'en': '',
    },
    'fkdh1l77': {
      'ko': '-',
      'en': '',
    },
    'dpcvxx0v': {
      'ko': '2주차',
      'en': '',
    },
    'os4qwhyh': {
      'ko': '-',
      'en': '',
    },
    'xi4dncge': {
      'ko': '3주차',
      'en': '',
    },
    'kqqw5d44': {
      'ko': '-',
      'en': '',
    },
    'b8vjhccb': {
      'ko': '4주차',
      'en': '',
    },
    '62cwrjsy': {
      'ko': '-',
      'en': '',
    },
    '4nch2lal': {
      'ko': '5주차',
      'en': '',
    },
    'vd36omnd': {
      'ko': '-',
      'en': '',
    },
    'lr5gh6y8': {
      'ko': '6주차',
      'en': '',
    },
    'n4w98k4a': {
      'ko': '7주차',
      'en': '',
    },
    'ja289x8z': {
      'ko': '8주차',
      'en': '',
    },
    'q2c3jcb5': {
      'ko': '9주차',
      'en': '',
    },
    'nja68znt': {
      'ko': '10주차',
      'en': '',
    },
    'zxsu6itv': {
      'ko': '11주차',
      'en': '',
    },
    'str3d7cp': {
      'ko': '12주차',
      'en': '',
    },
    '6i4yxnj1': {
      'ko': '13주차',
      'en': '',
    },
    'n12wiw9x': {
      'ko': '14주차',
      'en': '',
    },
    'k2s6jzf4': {
      'ko': '15주차',
      'en': '',
    },
  },
  // StudentSubmitButton_Mobile
  {
    'oq5dber7': {
      'ko': '진행 중인 과목 조회 ▶',
      'en': '',
    },
  },
  // CheckSubmitted_Mobile
  {
    'twhm8wme': {
      'ko': '1주차',
      'en': '',
    },
    '2c7t8nnt': {
      'ko': '-',
      'en': '',
    },
    '5h5rkk7c': {
      'ko': '2주차',
      'en': '',
    },
    'b77eu4un': {
      'ko': '-',
      'en': '',
    },
    'c57br56v': {
      'ko': '3주차',
      'en': '',
    },
    'svvsq09w': {
      'ko': '-',
      'en': '',
    },
    'oqricsqg': {
      'ko': '4주차',
      'en': '',
    },
    'nro7rso1': {
      'ko': '-',
      'en': '',
    },
    'ou1zr2z2': {
      'ko': '5주차',
      'en': '',
    },
    '2gte3cxo': {
      'ko': '-',
      'en': '',
    },
    'u4pkea79': {
      'ko': '6주차',
      'en': '',
    },
    'j6y5rj0s': {
      'ko': '7주차',
      'en': '',
    },
    '321ss1pw': {
      'ko': '8주차',
      'en': '',
    },
    'cqyplayx': {
      'ko': '9주차',
      'en': '',
    },
    'mce1f21f': {
      'ko': '10주차',
      'en': '',
    },
    'jxj6kocn': {
      'ko': '11주차',
      'en': '',
    },
    'em2we9q2': {
      'ko': '12주차',
      'en': '',
    },
    'r4ryl6ft': {
      'ko': '13주차',
      'en': '',
    },
    'bwarbacc': {
      'ko': '14주차',
      'en': '',
    },
    'elzesva3': {
      'ko': '15주차',
      'en': '',
    },
  },
  // Miscellaneous
  {
    'xlehd3wb': {
      'ko': 'Your Email',
      'en': '',
    },
    'iknll1e9': {
      'ko': 'Password',
      'en': '',
    },
    'ox287tb6': {
      'ko': 'Login',
      'en': '',
    },
    'zn8o66kq': {
      'ko': 'Continue with Google',
      'en': '',
    },
    '466gsylh': {
      'ko': 'Your Origin',
      'en': '',
    },
    'hh7kn5ke': {
      'ko': 'Search for an item...',
      'en': '',
    },
    'vvpaqm8y': {
      'ko': 'Rent a Building',
      'en': '',
    },
    'm0aujbu8': {
      'ko': 'Search for an item...',
      'en': '',
    },
    '9prqmijf': {
      'ko': 'Search',
      'en': '',
    },
    '65uo02no': {
      'ko': 'Search here ...',
      'en': '',
    },
    'w2o3md2p': {
      'ko': 'Transfer',
      'en': '',
    },
    '3igd71qf': {
      'ko': 'Input name user',
      'en': '',
    },
    '2st0myns': {
      'ko': '1학년 담당과목',
      'en': '',
    },
    'yzlg9hoa': {
      'ko': '진행사항 조회 ▶',
      'en': '',
    },
    '54ad3lnu': {
      'ko': '',
      'en': '',
    },
    '0nsdc2p0': {
      'ko': '',
      'en': '',
    },
    '38cec9x6': {
      'ko': '',
      'en': '',
    },
    '0excqjt5': {
      'ko': '',
      'en': '',
    },
    '5hxm9rvv': {
      'ko': '',
      'en': '',
    },
    'b5mv8s5e': {
      'ko': '',
      'en': '',
    },
    'vjtgln0l': {
      'ko': '',
      'en': '',
    },
    'nn46cgau': {
      'ko': '',
      'en': '',
    },
    'fk4haslx': {
      'ko': '',
      'en': '',
    },
    '17wteg58': {
      'ko': '',
      'en': '',
    },
    '6gaem07w': {
      'ko': '',
      'en': '',
    },
    'om6l6vlb': {
      'ko': '',
      'en': '',
    },
    'uz30vauv': {
      'ko': '',
      'en': '',
    },
    'eea11a72': {
      'ko': '',
      'en': '',
    },
    'cg6ulnaq': {
      'ko': '',
      'en': '',
    },
    '2ybbjjel': {
      'ko': '',
      'en': '',
    },
    'pbpkx3cr': {
      'ko': '',
      'en': '',
    },
    'if1gh15l': {
      'ko': '',
      'en': '',
    },
    'hyo062xn': {
      'ko': '',
      'en': '',
    },
    'we0yevom': {
      'ko': '',
      'en': '',
    },
    '6mqzx0zt': {
      'ko': '',
      'en': '',
    },
    'gpz80whi': {
      'ko': '',
      'en': '',
    },
    'i24q1dgv': {
      'ko': '',
      'en': '',
    },
    '5vscnsdn': {
      'ko': '',
      'en': '',
    },
    '85qwackb': {
      'ko': '',
      'en': '',
    },
    '5gcapx0u': {
      'ko': '',
      'en': '',
    },
    'aqy04znd': {
      'ko': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
