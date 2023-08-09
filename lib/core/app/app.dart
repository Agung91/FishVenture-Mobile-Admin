import 'package:admin/modules/login/screen/page_login.dart';
import 'package:admin/modules/pond/bloc/bloc_pond.dart';
import 'package:admin/modules/pond/repo/repo_pond.dart';
import 'package:admin/modules/profile/bloc/bloc_profile.dart';
import 'package:admin/modules/profile/repo/repo_profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:provider/provider.dart';
import 'package:admin/core/auth/bloc/local_auth.dart';
import 'package:admin/core/route/bloc_route.dart';
import 'package:admin/core/route/route_page.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  Future<void> checkForUpdate() async {
    if (kDebugMode) {
      return;
    }
    InAppUpdate.checkForUpdate().then((info) {
      if (info.updateAvailability != 0) {
        InAppUpdate.performImmediateUpdate();
      }
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => LocalAuth(),
          lazy: false,
        ),
        Provider(
          create: (context) => ProfileBloc(ProfileHttpRepo()),
        ),
        Provider(
          create: (context) => (PondBloc(PondHttpRepo())),
        ),
      ],
      child: MaterialApp(
        title: 'Aplikasi Admin',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorObservers: [routeObserver],
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
        home: AppPage(navigatorKey: _navigatorKey),
      ),
    );
  }
}

class AppPage extends StatelessWidget {
  const AppPage({
    Key? key,
    required GlobalKey<NavigatorState> navigatorKey,
  })  : _navigatorKey = navigatorKey,
        super(key: key);

  final GlobalKey<NavigatorState> _navigatorKey;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return RouteBloc().pop();
      },
      child: StreamBuilder<List<RoutePage>>(
          stream: RouteBloc().pages.stream,
          initialData: RouteBloc().pages.value,
          builder: (context, snapshot) {
            final data = snapshot.data;
            if (data == null) {
              return Navigator(
                key: _navigatorKey,
                observers: [HeroController()],
                pages: const [
                  MaterialPage(child: LoginPage()),
                ],
                onPopPage: (route, result) {
                  return route.didPop(result);
                },
              );
            }
            return Navigator(
              key: _navigatorKey,
              observers: [HeroController()],
              pages: data.map((e) => e.page).toList(),
              onPopPage: (route, result) {
                return route.didPop(result);
              },
            );
          }),
    );
  }
}
