// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Help and Support`
  String get helpSupport {
    return Intl.message(
      'Help and Support',
      name: 'helpSupport',
      desc: '',
      args: [],
    );
  }

  /// `Privacy and Data`
  String get privacyData {
    return Intl.message(
      'Privacy and Data',
      name: 'privacyData',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcomeBack {
    return Intl.message(
      'Welcome Back',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Enter your details below`
  String get enterDetailsBelow {
    return Intl.message(
      'Enter your details below',
      name: 'enterDetailsBelow',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Get started`
  String get getStarted {
    return Intl.message(
      'Get started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain`
  String get passwordMustContain {
    return Intl.message(
      'Password must contain',
      name: 'passwordMustContain',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get yourName {
    return Intl.message(
      'Your Name',
      name: 'yourName',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get yourLastname {
    return Intl.message(
      'Your Name',
      name: 'yourLastname',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get plsEnterEmail {
    return Intl.message(
      'Please enter your email',
      name: 'plsEnterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get plsEnterValidEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'plsEnterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get plsEnterPassword {
    return Intl.message(
      'Please enter your password',
      name: 'plsEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid password`
  String get plsEnterValidPassword {
    return Intl.message(
      'Please enter a valid password',
      name: 'plsEnterValidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter valid email and password`
  String get plsEnterValidEmailAndPassword {
    return Intl.message(
      'Please enter valid email and password',
      name: 'plsEnterValidEmailAndPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your fist name`
  String get plsEnterFirstName {
    return Intl.message(
      'Please enter your fist name',
      name: 'plsEnterFirstName',
      desc: '',
      args: [],
    );
  }

  /// `First name must be at least 4 characters long`
  String get plsEnterValidFirstName {
    return Intl.message(
      'First name must be at least 4 characters long',
      name: 'plsEnterValidFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your last name`
  String get plsEnterLastName {
    return Intl.message(
      'Please enter your last name',
      name: 'plsEnterLastName',
      desc: '',
      args: [],
    );
  }

  /// `Last name must be at least 4 characters long.`
  String get plsEnterValidLastName {
    return Intl.message(
      'Last name must be at least 4 characters long.',
      name: 'plsEnterValidLastName',
      desc: '',
      args: [],
    );
  }

  /// `Check Your Email`
  String get checkYourEmail {
    return Intl.message(
      'Check Your Email',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `We sent a verification code to`
  String get weSentVerificationCode {
    return Intl.message(
      'We sent a verification code to',
      name: 'weSentVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive the email?`
  String get didntReceiveEmail {
    return Intl.message(
      'Didn\'t receive the email?',
      name: 'didntReceiveEmail',
      desc: '',
      args: [],
    );
  }

  /// `Click to resend`
  String get clickToResend {
    return Intl.message(
      'Click to resend',
      name: 'clickToResend',
      desc: '',
      args: [],
    );
  }

  /// `Successfully`
  String get successfully {
    return Intl.message(
      'Successfully',
      name: 'successfully',
      desc: '',
      args: [],
    );
  }

  /// `Your email address has been verified`
  String get emailAddressHasBeenVerified {
    return Intl.message(
      'Your email address has been verified',
      name: 'emailAddressHasBeenVerified',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_ {
    return Intl.message(
      'Continue',
      name: 'continue_',
      desc: '',
      args: [],
    );
  }

  /// `Back to log in`
  String get backToLogin {
    return Intl.message(
      'Back to log in',
      name: 'backToLogin',
      desc: '',
      args: [],
    );
  }

  /// `Max Speed`
  String get maxSpeed {
    return Intl.message(
      'Max Speed',
      name: 'maxSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Engine`
  String get engine {
    return Intl.message(
      'Engine',
      name: 'engine',
      desc: '',
      args: [],
    );
  }

  /// `Consumption`
  String get consumption {
    return Intl.message(
      'Consumption',
      name: 'consumption',
      desc: '',
      args: [],
    );
  }

  /// `{time} min reading time`
  String minReadTime(Object time) {
    return Intl.message(
      '$time min reading time',
      name: 'minReadTime',
      desc: '',
      args: [time],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
