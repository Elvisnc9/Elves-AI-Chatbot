import 'package:elves_chatbot/presentation/widgets/Skeleton/skeletonbox.dart';
import 'package:elves_chatbot/shared/theme.dart';
import 'package:elves_chatbot/state/shellView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

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
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Row(
           children: [
             Text(
                'Save Your Time\nWith ELVES Chat Bot.', 
                style: textTheme.displayLarge
              ),

            const Spacer(),

              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.light, width: 2),
                ),
                child: Icon(
                  Icons.person,
                  color: AppColors.light,
                  size: 30,
                ),
              ).animate().fadeIn().slideX(begin: 0.2),
           ],
         ).animate().fadeIn(),



         SizedBox(height: 4.5.h),


          Text(
            ' Search Your Prompt',
            style: textTheme.displayMedium
          ),
          SizedBox(height: 1.4.h),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  ref.read(shellViewProvider.notifier).state = ShellView.chat;
                },
                child: Container(
                  width: 70.w,
                  height: 54,
                  alignment: Alignment.centerLeft,
                   padding:  EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text('Search here...', textAlign: TextAlign.start, style: TextStyle(
                    color: Colors.white24,
                    fontSize: 16
                  ),),
                ),
              ),

              SizedBox(width: 4.w),
              CircleAvatar(
                backgroundColor: AppColors.accent,
                radius: 30,
                child: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    ref.read(shellViewProvider.notifier).state = ShellView.chat;
                  },
                ),
              )
            ],
          ).animate().slideY(begin: 0.2).fadeIn(),




          SizedBox(height: 3.h),

          Row(
            children: [
              Text(
                ' Popular Prompt',
                style: textTheme.displayMedium
              ),

              const Spacer(),
              Text(
                ' See All',
                style: textTheme.labelMedium
              ),
            ],
          ),
          SizedBox(height: 2.h),

          PromptCards()


        ],
      ),
    );
  }
}





class PromptCards extends StatelessWidget {
  const PromptCards({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      height: 22.h,
      width: 50.w,
      decoration: BoxDecoration(
        color: AppColors.light,
        borderRadius: BorderRadius.circular(30),
      ),

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Midjourney\n Prompt\n Generator',
              style: textTheme.displayLarge?.copyWith(
                color: AppColors.dark, fontWeight: FontWeight.w500),
            )]),
      )
  

    );
  }
}