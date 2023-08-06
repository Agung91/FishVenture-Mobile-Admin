import 'package:admin/core/auth/model/token.dart';
import 'package:admin/modules/login/model/input_login.dart';

abstract class LoginService {
  Future<AuthToken> login(LoginInput input);
}
