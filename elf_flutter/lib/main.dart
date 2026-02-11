import 'package:elf_client/elf_client.dart';
import 'package:elf_flutter/app/appshell.dart';
import 'package:elf_flutter/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';
late final Client client;

late String serverUrl;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final serverUrl = await getServerUrl();

  client = Client(serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = FlutterAuthSessionManager();

  client.auth.initializeGoogleSignIn(
    // clientId: '1015868175289-u82c8a48gqndnkjr1j56tjd6bi86686d.apps.googleusercontent.com',
    serverClientId: '1015868175289-t9l5rfde2v6ucb32bftoe7oimb7hbdtb.apps.googleusercontent.com',
  );

 runApp(
    ProviderScope(
      child: TheResponsiveBuilder(builder: (context, orientation, screenType) {
        return const MyApp();
      }),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeControllerProvider);

    return AnimatedTheme(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      data: themeMode == ThemeMode.dark
          ? AppTheme.darkTheme
          : AppTheme.light,
      child: MaterialApp(
        title: 'ELF',
        theme: AppTheme.light,
        themeMode: themeMode,
        darkTheme: AppTheme.darkTheme,
        home: AppShell(),
      ),
    ) .animate(key: ValueKey(themeMode))
        .fadeIn(duration: const Duration(milliseconds: 500))
        .scale(begin: const Offset(0.98, 0.98), end: const Offset(1.0, 1.0));
  }
}

