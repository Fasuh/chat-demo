import 'package:angel_framework/angel_framework.dart';
import 'package:angel_serialize/angel_serialize.dart';
import 'package:common/common.dart';

class CustomHttpException extends AngelHttpException {
  CustomHttpException(error) : super(error);

  static AngelHttpException badRequest({PomError message, @required List<PomError> errors}) {
    return AngelHttpException.badRequest(errors: errors.map((e) => e.toMessage).toList());
  }
}