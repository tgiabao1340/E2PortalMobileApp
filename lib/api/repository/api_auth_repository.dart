import 'package:e2portal/api/provider/api_auth_provider.dart';
import 'package:e2portal/model/model.dart';

class ApiAuthRepository{
  final ApiAuthProvider _apiAuthProvider = ApiAuthProvider();

  Future<Token> postLoginUser(LoginBody loginBody) => _apiAuthProvider.loginUser(loginBody);

  Future<bool> hasToken() => _apiAuthProvider.hasToken();

  Future<bool> changePassword(String newPassword) => _apiAuthProvider.changePassword(newPassword);

  Future<void> persistToken(Token token) => _apiAuthProvider.persistToken(token);

  Future<void> removeToken() => _apiAuthProvider.removeToken();

}