import 'package:args/args.dart';

class AppArgs {
  static ArgResults _args;

  static ArgResults init(List<String> args) {
    _args = ArgParser().parse(args);
    return _args;
  }

  static ArgResults get() {
    if(_args != null) {
      return _args;
    } else {
      throw Exception('Args not initialized');
    }
  }
}