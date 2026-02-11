
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:elf_flutter/screens/chatScreen.dart';
import 'package:elf_flutter/screens/home.dart';
import 'package:elf_flutter/screens/onboarding.dart';
import 'package:elf_flutter/screens/settings.dart';
import 'package:elf_flutter/state/shellView.dart';


class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  @override
  void initState() {
    super.initState();
    // Trigger an initial auth check after first frame
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(authNotifierProvider.notifier).checkAuth();
    // });
  }

  @override
  Widget build(BuildContext context) {
    // Register the listener during build (allowed by Riverpod)
    // ref.listen<AuthState>(authNotifierProvider, (previous, next) {
    //   final prevLoggedIn = previous?.isLoggedIn ?? false;
    //   final nextLoggedIn = next.isLoggedIn;

    //   if (prevLoggedIn == nextLoggedIn) return;

    //   // Do not override navigation if the user has already moved off onboarding/home.
    //   final currentView = ref.read(shellViewProvider);

    //   if (nextLoggedIn) {
    //     if (currentView != ShellView.home) {
    //       ref.read(shellViewProvider.notifier).state = ShellView.home;
    //     }
    //   } else {
    //     if (currentView != ShellView.onboarding) {
    //       ref.read(shellViewProvider.notifier).state = ShellView.home;
    //     }
    //   }
    // });

    final view = ref.watch(shellViewProvider);
    // final authState = ref.watch(authNotifierProvider);

    // if (authState.isLoading) {
    //   return const Scaffold(
    //     backgroundColor: AppColors.dark,
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }
    final theme = Theme.of(context);
    return GestureDetector(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: () {
              switch (view) {
                 case ShellView.chat:
                  return const ChatView(key: ValueKey('chat'));
                case ShellView.onboarding:
                  return OnboardingScreen(key: const ValueKey('onboarding'));
                case ShellView.home:
                  return const HomeView(key: ValueKey('home'));
                case ShellView.settings:
                  return const Settings(key: ValueKey('settings'));
              }
            }(),
          ),
        ),
      ),
    );
  }
}