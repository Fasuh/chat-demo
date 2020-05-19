import "package:angel_framework/angel_framework.dart";
import 'package:hello/helper/authentication.dart';

@Expose("/test", middleware: [authenticationMiddleware])
class TestController extends Controller {
  @Expose("/test", method: "GET")
  login(RequestContext req, ResponseContext res) async => "hello world!";
}