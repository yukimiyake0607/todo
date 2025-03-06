import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/presentation/core/theme/todo_card_color.dart';
import 'package:todo/presentation/pages/home_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // サポートするロケールを追加
      supportedLocales: const [
        Locale('ja', 'JP'), // 日本語
        Locale('en', 'US'), // 英語（必要に応じて）
      ],
      // デフォルトのロケールを設定（オプション）
      locale: const Locale('ja', 'JP'),
      home: const HomePage(),
      theme: ThemeData(
        primaryColor: todoMainColor,
        colorScheme: const ColorScheme.light(
          primary: todoMainColor,
          secondary: todoSubColor,
          surface: Colors.white,
        ),
      ),
    );
  }
}
