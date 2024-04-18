extension DataValidator on String {

  bool get isValidEmail {
    final emailRegExp = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    return length >= 8;
  }

  bool get isValidFirstName {
    return length >= 4;
  }

  bool get isValidLastName {
    return length >= 4;
  }
}