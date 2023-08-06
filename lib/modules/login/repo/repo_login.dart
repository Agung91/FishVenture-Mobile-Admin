import 'package:admin/common/http/http.dart';
import 'package:admin/config/hosts.dart';
import 'package:admin/core/auth/model/token.dart';
import 'package:admin/core/auth/repo/token_data.dart';
import 'package:admin/modules/login/model/input_login.dart';
import 'package:admin/modules/login/model/service_login.dart';

class LoginRepo extends HttpService implements LoginService {
  @override
  Future<AuthToken> login(LoginInput input) async {
    try {
      final response = await post(
        '$host/login',
        body: input.toMap(),
      );
      return TokenData.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
