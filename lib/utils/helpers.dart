class Helpers {
  static String validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    }
    RegExp regExp = new RegExp(
        r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'

        // r"[A-Za-z0-9._%+-]{3,}@[a-zA-Z0-9]{3,}([.]{1}[a-zA-Z]{2,}|[.]{1}[a-zA-Z]{2,}[.]{1}[a-zA-Z]{2,})",
        );

    if (!regExp.hasMatch(
      value,
    )) {
      return "Email is invalid";
    }
    return null;
  }

  static String validateEmpty(String value, String label) {
    if (value.isEmpty) {
      return '$label is required';
    }
    return null;
  }

  static String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8 || value.length > 20) {
      return 'Password should be between 8 to 20 characters';
    }
    return null;
  }

  static String validateConfirmPassword(String value, String password) {
    if (value.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String validateCurrentPassword(String value, String oldpassword) {
    if (value.isEmpty) {
      return 'New Password is required';
    }
    if (value == oldpassword) {
      return 'Password should not be same';
    }
    if (value.length < 8 || value.length > 20) {
      return 'Password should be between 8 to 20 characters';
    }
    return null;
  }

  static String validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    RegExp regExp = new RegExp(r"^[A-Za-z\s]{1,}[\.]{0,1}[A-Za-z\s]{0,}$");

    if (!regExp.hasMatch(
      value,
    )) {
      return "character is invalid";
    }
    return null;
  }
}
