import 'package:final_project_app/controller/language_controller.dart';
import 'package:final_project_app/translations/codegen_loader.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'log_sidebar/sidebar_layout.dart';
import 'package:easy_localization/easy_localization.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => LanguageController(),
        )
      ],
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en'),
          Locale('de'),
          Locale('bg'),
          Locale('fr'),
          Locale('pt'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        assetLoader: const CodegenLoader(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, primaryColor: Colors.white),
      home: const SideBarLayout(),
    );
  }
}
