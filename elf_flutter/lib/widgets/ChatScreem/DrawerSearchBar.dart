import 'package:flutter/material.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h, left: 1.h, right: 4.h),
      child: Container(
        height: 50,
        
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
           

            SizedBox(width: 1.w),
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
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: theme.cardColor.withOpacity(0.9)
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),

             Spacer(),
            Icon(Icons.search, color: theme.cardColor.withOpacity(0.9), size: 25,),
          ],
        ),
      ),
    );
  }
}

