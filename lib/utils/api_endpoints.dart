class ApiEndpoints {
  static const String baseUrl = 'http://10.0.2.2:5050/api/';
  static final AuthEndpoints authEndpoints = AuthEndpoints();
  static final Calculator calculator = Calculator();
}

class AuthEndpoints {
  final String register = 'Auth/register';
  final String login = 'Auth/login';
}

class Calculator {
  final String calc = 'Calc/';
}
