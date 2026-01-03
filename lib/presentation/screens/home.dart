import 'package:elves_chatbot/presentation/widgets/Skeleton/skeletonbox.dart';
import 'package:elves_chatbot/state/shellView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(homeStatusProvider);

    return AnimatedSwitcher(
      duration: 300.ms,
      child:    const HomeContent(key: ValueKey('content')),
    );
  }
}


class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonBox(height: 26, width: 220).shimmer(),
          const SizedBox(height: 20),
          const SkeletonBox(height: 50).shimmer(),
          const SizedBox(height: 30),
          Row(
            children: const [
              Expanded(child: SkeletonBox(height: 120)),
              SizedBox(width: 12),
              Expanded(child: SkeletonBox(height: 120)),
            ].map((e) => e.shimmer()).toList(),
          )
        ],
      ),
    );
  }
}



class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Save Your Time\nWith AI Chat Bot',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ).animate().fadeIn(),

          const SizedBox(height: 20),

          GestureDetector(
            onTap: () {
              ref.read(shellViewProvider.notifier).state = ShellView.chat;
            },
            child: Container(
              height: 54,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Text('Search your prompt...'),
            ),
          ).animate().slideY(begin: 0.2).fadeIn(),
        ],
      ),
    );
  }
}
