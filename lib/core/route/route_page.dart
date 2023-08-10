import 'package:admin/modules/home/screen/page_home.dart';
import 'package:admin/modules/login/screen/page_login.dart';
import 'package:admin/modules/pond/model/model_pond.dart';
import 'package:admin/modules/pond/screen/page_pond.dart';
import 'package:flutter/material.dart';

abstract class RoutePage {
  final MaterialPage page;
  final bool isProtected;
  final String name;
  RoutePage(this.page, this.name, {this.isProtected = false});
}

class RouteLogin extends RoutePage {
  RouteLogin()
      : super(
          const MaterialPage(child: LoginPage()),
          'login',
        );
}

class RouteHome extends RoutePage {
  RouteHome()
      : super(
          const MaterialPage(child: HomePage()),
          'home',
        );
}

class RoutePond extends RoutePage {
  RoutePond(PondModel pondModel)
      : super(
          MaterialPage(
              child: PondPage(
            pondModel: pondModel,
          )),
          'pond',
        );
}
