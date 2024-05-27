enum TypeTextField {
  general,
  email,
  password,
  name,
}

class Validator {
  // basic
  static String? rule(
    String? value,
    TypeTextField typeTextField, {
    bool required = true,
  }) {
    if (required &&
        value!.isEmpty &&
        typeTextField.name == TypeTextField.general.name) {
      // return "This field is required";
      return 'Harap Di Isi Untuk Melanjutkan';
    }

    if (required &&
        value!.isEmpty &&
        typeTextField.name == TypeTextField.password.name) {
      // return "This field is required";
      return 'Kata sandi harus diisi !';
    }

    if (required &&
        value!.isEmpty &&
        typeTextField.name == TypeTextField.email.name) {
      // return "This field is required";
      return 'Email harus diisi !';
    }

    if (required &&
        value!.isEmpty &&
        typeTextField.name == TypeTextField.name.name) {
      // return "This field is required";
      return 'Nama harus diisi !';
    }

    return null;
  }

  // check password & repassword is equals
  static bool isPasswordEquals(String password, String rePassword) {
    return (password == rePassword) ? true : false;
  }

  static String? emailValidator(String? value) {
    // if (value!.isEmpty) return "This field is required";
    // if (value!.isEmpty) return 'Harap Di Isi Untuk Melanjutkan';
    if (value!.isEmpty) return 'Email harus diisi !';

    final bool isValidEmail = RegExp(
            "^[a-zA-Z0-9.a-zA-Z0-9.!#\$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
        .hasMatch(value);

    if (!isValidEmail) {
      // return "This field is not in a valid email format";
      return 'Format Email Tidak Valid';
    }
    return null;
  }

  String? typeValidator(TypeTextField typeTextField, String? value) {
    String? result;

    if (typeTextField.name == TypeTextField.general.name) {
      result = Validator.rule(value, typeTextField);
    }

    if (typeTextField.name == TypeTextField.email.name) {
      result = Validator.emailValidator(value);
    }

    if (typeTextField.name == TypeTextField.password.name) {
      result = Validator.rule(value, typeTextField);
    }

    if (typeTextField.name == TypeTextField.name.name) {
      result = Validator.rule(value, typeTextField);
    }

    return result;
  }
}
