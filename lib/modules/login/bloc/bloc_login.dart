import 'package:flutter/foundation.dart';
import 'package:sstream/sstream.dart';

import 'package:admin/core/auth/bloc/bloc_auth.dart';
import 'package:admin/core/auth/bloc/event.dart';
import 'package:admin/modules/login/model/input_login.dart';
import 'package:admin/modules/login/repo/repo_login.dart';

class LoginBLoc {
  LoginBLoc(this._repo) {
    if (kDebugMode) {
      // email.add('saller@gmail.com');
      // password.add('password');
      email.add('dinasperikananprobolinggo@gmail.com');
      password.add('admindinasperikanan');
    }
  }

  final LoginRepo _repo;

  final email = "".stream;
  final password = "".stream;

  Future<void> login() async {
    try {
      final emailVal = email.value;
      if (emailVal == '') {
        throw 'error';
      }
      final passVal = password.value;
      if (passVal == '') {
        throw 'error';
      }
      final token = await _repo.login(
        LoginInput(
          email: emailVal,
          password: passVal,
          applicationType: 'admin',
        ),
      );
      AuthBloc().raise(EventAuthLogin(token));
    } catch (e) {
      rethrow;
    }
  }
}
