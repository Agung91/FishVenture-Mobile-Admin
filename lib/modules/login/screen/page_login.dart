import 'package:flutter/material.dart';

import 'package:admin/common/widgets/button.dart';
import 'package:admin/common/widgets/text_input.dart';
import 'package:admin/config/text_style.dart';
import 'package:admin/modules/login/bloc/bloc_login.dart';
import 'package:admin/modules/login/repo/repo_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final blocLogin = LoginBLoc(LoginRepo());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Masuk',
                style: CustomTextStyle.heading4Medium,
              ),
            ),
          ),
          const SizedBox(height: 48),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextInput(
              sStream: blocLogin.email,
              keyboardType: TextInputType.emailAddress,
              label: 'Email',
              hint: 'Masukkan Email',
            ),
          ),
          const SizedBox(height: 26),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextInput(
              sStream: blocLogin.password,
              label: 'Password',
              hint: 'Masukkan Password',
              obscureText: true,
            ),
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: CustomButton(
              textButton: 'Login',
              onTap: () async {
                await blocLogin.login();
                const snackBar = SnackBar(
                  content: Text('Berhasil Login!!!'),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
            ),
          ),
        ],
      ),
    );
  }
}
