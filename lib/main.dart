import 'package:elves_chatbot/app/appshell.dart';
import 'package:elves_chatbot/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp( ProviderScope(child: TheResponsiveBuilder(
    builder: (context, orientation, screenType) {
      return MyApp();
    }
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elves AI',
      theme: AppTheme.darkTheme,
      home: const AppShell()
    );
  }
}

