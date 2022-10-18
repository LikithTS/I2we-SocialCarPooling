mixin InputValidationMixin {

  bool isPasswordValid(String password) => password.length < 4;
  bool isZipValid(String zipCode) => zipCode.length == 6;

  bool isEmailValid(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }

  bool isValidPhoneNumber(String? value) =>
      RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
          .hasMatch(value!);

  bool isNullString(String? value) {
    if (value == null || value.isEmpty || value == false) {
      return true;
    } else {
      return false;
    }
  }
  bool isNameString(String? value) =>RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s0-9-]').hasMatch(value!);

}
