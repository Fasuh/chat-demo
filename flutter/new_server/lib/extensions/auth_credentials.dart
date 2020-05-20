import 'dart:async';

import 'package:angel_framework/angel_framework.dart';
import 'package:common/helper/validate.dart';
import 'package:common/model/model.dart';

extension AuthCredentialsExt on AuthCredentials {
  PasswordValidator get passwordValidator => PasswordValidator();
  EmailValidator get emailValidator => EmailValidator();

  Future<List<PomError>> checkCredentials() async  {
    List<PomError> errors = [];

    if(!emailValidator.validate(username)) {
      errors.add(PomError.InvalidUsername);
    }
    if(!passwordValidator.validate(password)) {
      errors.add(PomError.InvalidPassword);
    }
    return errors;
  }

  static FutureOr<bool> deserializeAuth(RequestContext req, ResponseContext res) async {
    await req.parseBody();
    req.params['credentials'] = AuthCredentialsDecoder().convert(req.bodyAsMap);;
    return true;
  }
}