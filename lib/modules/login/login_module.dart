import 'package:app_filmes/application/modules/module.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:app_filmes/modules/login/login_page.dart';
import 'package:app_filmes/modules/login/login_bindings.dart';

class LoginModule implements Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      binding: LoginBindings(),
    ),
  ];
}
