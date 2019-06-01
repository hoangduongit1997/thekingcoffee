import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'title_placehold_home': 'All categories',
      'title_welcome': 'Welcome to',
      'title_new_poduct': 'New product',
      'title_coffee': 'Coffee',
      'title_tea': 'Tea',
      'title_drinking': 'Drinking',
      'title_food': 'Food',
      'title_see_all': 'See all',
      'title_splash_screen': 'Loading...',
      'bottomnavigation_home': 'Home',
      'bottomnavigation_favorite': 'Favorite',
      'bottomnavigation_setting': 'Setting',
      'lable_email': 'Email or phone number',
      'lable_skip': 'Skip',
      'lable_newaccount': 'New account? ',
      'lable_signup': 'Sign up',
      'lable_password': 'Password',
      'bottomnavigation_shopping_list': 'Shopping List',
      'button_login': 'Login',
      'button_showpass_enable': 'Show',
      'button_showpass_Disable': 'Hide',
      'title_forgetpass': 'Forget password?',
      'title_signincontinute': 'Sign in to continute',
    },
    'vi': {
      'title_new_poduct': 'Sản phẩm mới',
      'title_coffee': 'Cafe',
      'title_tea': 'Trà',
      'title_drinking': 'Đồ uống',
      'title_food': 'Thức ăn',
      'title_see_all': 'Tất cả',
      'title_placehold_home': 'Danh mục',
      'bottomnavigation_setting': 'Cài đặt',
      'bottomnavigation_home': 'Trang chủ',
      'title_splash_screen': 'Đang tải...',
      'bottomnavigation_favorite': 'Yêu thích',
      'bottomnavigation_shopping_list': 'Giỏ hàng',
      'lable_signup': 'Đăng ký',
      'lable_skip': 'Bỏ qua',
      'button_showpass_enable': 'Hiện',
      'button_showpass_disable': 'Ẩn',
      'button_login': 'Đăng nhập',
      'lable_newaccount': 'Tạo tài khoản? ',
      'title_welcome': 'Chào mừng tới',
      'title_forgetpass': 'Quên mật khẩu?',
      'lable_email': 'Email hoặc số điện thoại',
      'lable_password': 'Mật khẩu',
      'title_signincontinute': 'Đăng nhập để tiếp tục',
    },
  };
  String get bottomnavigation_home {
    return _localizedValues[locale.languageCode]['bottomnavigation_home'];
  }

  String get title_placeholder_home {
    return _localizedValues[locale.languageCode]['title_placehold_home'];
  }

  String get title_new_product {
    return _localizedValues[locale.languageCode]['title_new_poduct'];
  }

  String get title_see_all {
    return _localizedValues[locale.languageCode]['title_see_all'];
  }

  String get title_coffee {
    return _localizedValues[locale.languageCode]['title_coffee'];
  }

  String get title_tea {
    return _localizedValues[locale.languageCode]['title_tea'];
  }

  String get title_drinking {
    return _localizedValues[locale.languageCode]['title_drinking'];
  }

  String get title_food {
    return _localizedValues[locale.languageCode]['title_food'];
  }

  String get title_flash_screen {
    return _localizedValues[locale.languageCode]['title_splash_screen'];
  }

  String get bottomnavigation_setting {
    return _localizedValues[locale.languageCode]['bottomnavigation_setting'];
  }

  String get bottomnavigation_shopping_list {
    return _localizedValues[locale.languageCode]
        ['bottomnavigation_shopping_list'];
  }

  String get bottomnavigation_favorite {
    return _localizedValues[locale.languageCode]['bottomnavigation_favorite'];
  }

  String get btn_login {
    return _localizedValues[locale.languageCode]['button_login'];
  }

  String get btn_showpass {
    return _localizedValues[locale.languageCode]['button_showpass_enable'];
  }

  String get btn_hidepass {
    return _localizedValues[locale.languageCode]['button_showpass_disable'];
  }

  String get forget_pass {
    return _localizedValues[locale.languageCode]['title_forgetpass'];
  }

  String get lable_skip {
    return _localizedValues[locale.languageCode]['lable_skip'];
  }

  String get lable_signup {
    return _localizedValues[locale.languageCode]['lable_signup'];
  }

  String get lable_newaccount {
    return _localizedValues[locale.languageCode]['lable_newaccount'];
  }

  String get appNameShort {
    return _localizedValues[locale.languageCode]['appNameShort'];
  }

  String get title_welcome {
    return _localizedValues[locale.languageCode]['title_welcome'];
  }

  String get title_signincontinute {
    return _localizedValues[locale.languageCode]['title_signincontinute'];
  }

  String get desc {
    return _localizedValues[locale.languageCode]['desc'];
  }

  String get lable_email {
    return _localizedValues[locale.languageCode]['lable_email'];
  }

  String get lable_password {
    return _localizedValues[locale.languageCode]['lable_password'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'vi'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
