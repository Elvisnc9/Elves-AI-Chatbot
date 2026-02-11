
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
    final theme = Theme.of(context);
    return Padding(
      padding:  EdgeInsets.only(bottom: 15, left: 1.5.w, right: 1.5.w),
      child: Container(
        height: 8.5.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 14.0, bottom: 14.0),
          child: Row(
            children: [
              Icon(
                Icons.chat_bubble_outline_rounded,
                color: theme.cardColor,
                size: 25,
              ),
          
              SizedBox(width: 3.w),
          
              Text(
                model.msg,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }
}



