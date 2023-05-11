import 'package:app_filmes/application/ui/filmes_app_icons.dart';
import 'package:app_filmes/application/ui/theme_extension.dart';
import 'package:app_filmes/modules/favorites/favorites_page.dart';
import 'package:app_filmes/modules/home/home_controller.dart';
import 'package:app_filmes/modules/movies/movies_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Obx(
          () {
            return BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.movie),
                  label: 'Filmes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FilmesAppIcons.heartEmpty),
                  label: 'Favoritos',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.logout),
                  label: 'Sair',
                ),
              ],
              onTap: controller.goToPage,
              currentIndex: controller.pageIndex,
              selectedItemColor: context.colorRed,
              unselectedItemColor: context.colorGrey,
              landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            );
          },
        ),
        body: Navigator(
          key: Get.nestedKey(1),
          initialRoute: '/movies',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/movies':
                return GetPageRoute(
                  settings: settings,
                  page: () => const MoviesPage(),
                );
              case '/favorites':
                return GetPageRoute(
                  settings: settings,
                  page: () => const FavoritesPage(),
                );
            }
            return null;
          },
        ));
  }
}
