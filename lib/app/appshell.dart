import 'package:elves_chatbot/presentation/screens/chatScreen.dart';
import 'package:elves_chatbot/presentation/screens/home.dart';
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(238, 81, 55, 129), Color.fromARGB(255, 1, 0, 4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: 350.ms,
                child: view == ShellView.home
                    ? const HomeView(key: ValueKey('home'))
                    : const ChatView(key: ValueKey('chat')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
