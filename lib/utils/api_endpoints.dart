class ApiEndpoints{
  static final String baseUrl = 'http://localhost:5050/api/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}
class _AuthEndPoints{
  final String register = 'Auth/register';
  final String login = 'Auth/login';

}