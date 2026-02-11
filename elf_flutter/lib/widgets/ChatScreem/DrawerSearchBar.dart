import 'package:flutter/material.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h, left: 1.h, right: 2.h),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: theme.cardColor.withOpacity(0.6)),

            SizedBox(width: 5.w),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                minLines: 1,
                style: textTheme.labelMedium?.copyWith(
                  color: theme.cardColor,),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.cardColor.withOpacity(0.6)
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

