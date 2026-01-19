import 'package:elves_chatbot/presentation/screens/chatScreen.dart';
import 'package:elves_chatbot/presentation/screens/home.dart';
import 'package:elves_chatbot/presentation/screens/settings.dart';
import 'package:elves_chatbot/shared/theme.dart';
import 'package:elves_chatbot/state/shellView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(shellViewProvider);

    return Scaffold(
      backgroundColor: AppColors.dark,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: 250.ms,
                child: view == ShellView.home
                    ? const HomeView(key: ValueKey('home'))
                    : view == ShellView.chat
                    ?  ChatView(key: ValueKey('chat'))
                    : const Settings(key: ValueKey('settings')),
              ),
            ],
          ),
        ),
      
    );
  }
}
