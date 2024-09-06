class InputValidator {
  bool validateName(String name) {
    return name.isNotEmpty && name.length > 3;
  }

  throwError(String message) {
    throw Exception(message);
  }
}
