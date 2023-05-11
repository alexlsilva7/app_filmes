// ignore_for_file: constant_identifier_names

import 'package:app_filmes/services/login/login_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static const NAVIGATOR_KEY = 1;
  static const INDEX_PAGE_EXIT = 2;

  final LoginService _loginService;

  HomeController({required LoginService loginService})
      : _loginService = loginService;

  final _pages = ['/movies', '/favorites', '/login'];

  final _pageIndex = 0.obs;

  int get pageIndex => _pageIndex.value;

  void goToPage(int index) {
    _pageIndex(index);
    if (index == INDEX_PAGE_EXIT) {
      _loginService.logout();
      Get.offAllNamed(_pages[index]);
    } else {
      Get.offNamed(_pages[index], id: NAVIGATOR_KEY);
    }
  }
}
