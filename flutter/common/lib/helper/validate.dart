abstract class Validator {
  bool validate(String text);
}

class EmailValidator extends Validator {
  @override
  bool validate(String text) {
    RegExp exp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return exp.hasMatch(text??"");
  }
}

class PasswordValidator extends Validator {
  @override
  bool validate(String text) {
    RegExp exp = RegExp(r"^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,32}$");
    return exp.hasMatch(text??"");
  }
}