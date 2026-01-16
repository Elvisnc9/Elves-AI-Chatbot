import 'package:elves_chatbot/shared/theme.dart';
import 'package:elves_chatbot/state/shellView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class ChatView extends ConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  HeroButton(
                    icon: Icons.arrow_back,
                    onPressed: () {
                      ref.read(shellViewProvider.notifier).state =
                          ShellView.home;
                    },
                  ),
                  Spacer(),

                  Text(
                    'ELVES  Chat  Bot',
                    style: textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                    ),
                  ),

                  Spacer(),

                  HeroButton(icon: Icons.more_horiz, onPressed: () {}),
                ],
              ),
            ],
          ).animate().fadeIn(),

          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              children: [
                Container(
                  width: 75.w,
                  padding: EdgeInsets.symmetric( 
                    horizontal: 4.w,
                    vertical: 2.5.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.light,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // File / Attach Icon
                      Icon(
                        Icons.attach_file,
                        color: Colors.grey.shade700,
                        size: 25.sp,
                      ),
                
                      const SizedBox(width: 8),

                      VerticalDivider(
                        color: Colors.grey.shade400,
                        thickness: 1,
                        width: 1,
                      )
                
                      // TextField takes remaining space
                      // Expanded(
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       hintText: "Type message...",
                      //       hintStyle: TextStyle(color: Colors.grey),
                      //       border: InputBorder.none, // VERY IMPORTANT
                      //       isDense: true,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.light,
                  child: IconButton(
                    icon: Icon(Icons.mic, color: AppColors.dark, size: 30,),
                    onPressed: () {},
                  ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeroButton extends StatelessWidget {
  const HeroButton({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: AppColors.accent.withOpacity(0.8),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
