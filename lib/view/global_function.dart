class GlobalFunction
{
  static bool isValidEmail(String email) {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(email);
  }
  static bool isValidMobile(String mobile)
  {
    String p= r'^[6-9]\d{9}$';
    RegExp regExp=RegExp(p);
    return regExp.hasMatch(mobile);
  }
}