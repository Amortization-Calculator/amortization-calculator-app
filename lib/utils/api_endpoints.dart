class ApiEndpoints {
  static const String baseUrl = 'http://amortization.runasp.net/api/';
  static final AuthEndpoints authEndpoints = AuthEndpoints();
  static final Calculator calculator = Calculator();
  static final DashboardEndpoints dashboardEndpoints = DashboardEndpoints();
}

class AuthEndpoints {
  final String register = 'Auth/register';
  final String login = 'Auth/login';
}
class DashboardEndpoints{
  final String allUsers = 'User';
}

class Calculator {
  final String calc = 'Calc/';
}
