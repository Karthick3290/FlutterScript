// Import the test package and Counter class
import 'package:loginapp/Domain/email.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Email test invalid email', () {
    final email = Email('email');

    expect(email.value.isLeft(), true);
    expect(email.value.isRight(), false);

  });
  test('Email test valid email', () {
    final email = Email('email@test.com');

    expect(email.value.isLeft(), false);
    expect(email.value.isRight(), true);

  });
}