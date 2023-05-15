import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FilmesUiConfig {
  FilmesUiConfig._();

  static String get title => 'Filmes App';

  static ThemeData get theme => ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: false,
        fontFamily: 'Metropolis',
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          color: Colors.white,
          iconTheme: const IconThemeData(color: Color(0xFF222222)),
          titleTextStyle: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ).titleLarge,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
      );
}
