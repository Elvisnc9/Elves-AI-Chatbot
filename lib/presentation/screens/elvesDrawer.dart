import 'package:elves_chatbot/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class ElvesDrawer extends StatelessWidget {
  const ElvesDrawer({
    super.key,
   
  });



  @override
  Widget build(BuildContext context) {
    final texttheme = Theme.of(context).textTheme;
    return Container(   
      color: Colors.transparent,
      padding: EdgeInsets.symmetric( vertical: 1.h),
      child:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            Leadings(text: 'New Chat', tap: (){}, icon: Icons.new_label),
            Leadings(text: 'Images', tap: (){}, icon: Icons.image),
            Leadings(text: 'Video Prompt', tap: (){}, icon: Icons.video_camera_back),
        
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 1.5.h),
              child: Column(
                children: [
                
                  SizedBox(height: 3.h),
                  SizedBox(
                    child: ListView.builder(
                  itemCount: 30,
                  scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (_, i) => 
        
                      Material(
        color: Colors.transparent,
        child: InkWell(
          
          onTap: (){},
          child: Padding(
            padding: EdgeInsets.only(top: 2.h, bottom: 2.h, left: 1.h),
            child: Text(
              'What are the importance of PhotoSynthesis ${i + 1}',
              maxLines: 1,
              style: texttheme.labelMedium?.copyWith(color: Colors.white, ) ,
            ),
          ),
        ),
            )
                    ),
                  ),
                ],
              ),
            ),
      
            SizedBox(height: 5.h,)
          ],
        ),
      ),
    );
  }
}




class Leadings extends StatelessWidget {
  const Leadings({super.key, required this.text, required this.tap, required this.icon});

  final String text;
  final VoidCallback tap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final Texttheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: tap,
        child: Padding(
          padding: EdgeInsets.only(top: 1.5.h, bottom: 1.5.h, left: 1.h),
          child: Row(
            children: [
              Icon(icon),
          
              SizedBox(width: 5.w,),
              Text(
                text,
                style: Texttheme.labelMedium?.copyWith(color: Colors.white) ,
              )
            ],
          ),
        ),
      ),
    );
  }
}