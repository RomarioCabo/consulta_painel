import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:painel_cunsulta/shared/controllers/universal_tab_controller.dart';
import 'package:painel_cunsulta/shared/models/dto/user_dto.dart';
import 'package:painel_cunsulta/shared/repositories/local_storage_shared_preferences/local_storage_shared_preferences.dart';
import 'package:painel_cunsulta/ui/login/login_page.dart';

import 'constants/colors.dart';
import 'constants/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var localStorageSharedPreferences = LocalStorageSharedPreferences();
  await localStorageSharedPreferences.initializationDone;

  GetIt.I.registerSingleton(localStorageSharedPreferences);
  GetIt.I.registerSingleton(UserDto());
  GetIt.I.registerSingleton(UniversalTabController());

  runApp(
    MaterialApp(
      title: project_name,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale("pt", "BR"),
      ],
      theme: theme(),
      home: LoginPage(),
    ),
  );
}
