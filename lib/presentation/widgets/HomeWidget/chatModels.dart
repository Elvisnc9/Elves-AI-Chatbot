
import 'package:elves_chatbot/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class ChatModel {
  final String msg;


  ChatModel({
    required this.msg,
  });
}

class RecentChats extends StatelessWidget {
  const RecentChats({super.key, required this.model});

  final ChatModel model;
    

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 15),
      child: Container(
        height: 8.5.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.2),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              Icon(
                Icons.chat_bubble_outline_rounded,
                color: AppColors.light.withOpacity(0.7),
                size: 25,
              ),
          
              SizedBox(width: 4.w),
          
              Text(
                model.msg,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.light.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }
}



