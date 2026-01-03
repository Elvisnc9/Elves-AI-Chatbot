import 'package:elves_chatbot/state/shellView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatView extends ConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ref.read(shellViewProvider.notifier).state = ShellView.home;
          },
        ),
        const Expanded(
          child: Center(
            child: Text(
              'Chat Screen\n(Messages will live here)',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ).animate().fadeIn();
  }
}
