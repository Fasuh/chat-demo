import 'package:common/helper/validate.dart';
import 'package:test/test.dart';

void main() {
  EmailValidator emailValidator;
  PasswordValidator passwordValidator;

  setUp(() {
    passwordValidator = PasswordValidator();
    emailValidator = EmailValidator();
  });

  group('password validator', () {
    test('with null data', () =>
      expect(passwordValidator.validate(null), false));

    test('with empty value', () =>
      expect(passwordValidator.validate(""), false));

    test('with no upper case', () =>
        expect(passwordValidator.validate("tester123"), false));

    test('with no lower case', () =>
        expect(passwordValidator.validate("TESTER123"), false));

    test('with no numbers', () =>
        expect(passwordValidator.validate("Testereko"), false));

    test('with too short value', () =>
        expect(passwordValidator.validate("Te1"), false));

    test('with too long value', () =>
        expect(passwordValidator.validate("Testeresteresteresteresteresteresterester1231"), false));

    test('with correct value', () =>
      expect(passwordValidator.validate("Tester123"), true));
  });

  group('Email validator', () {
    test('with null data', () =>
        expect(emailValidator.validate(null), false));

    test('with empty value', () =>
        expect(emailValidator.validate(""), false));

    test('with only "@" in value', () =>
        expect(emailValidator.validate("@"), false));

    test('with no "@" symbol', () =>
        expect(emailValidator.validate("Tester123gmail.com"), false));

    test('with no user name', () =>
        expect(emailValidator.validate("@gmail.com"), false));

    test('with no domain', () =>
        expect(emailValidator.validate("Tester123@"), false));

    test('with correct value', () =>
        expect(emailValidator.validate("Tester123@gmail.com"), true));
  });
}
