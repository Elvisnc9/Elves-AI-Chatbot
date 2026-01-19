import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:elves_chatbot/presentation/screens/elvesDrawer.dart';
import 'package:elves_chatbot/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';


class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  late final DrawerScaffoldController drawerController;

  @override
  void initState() {
    super.initState();
    drawerController = DrawerScaffoldController();
  }
  @override
Widget build(BuildContext context) {
  final TextTheme textTheme = Theme.of(context).textTheme;

  return DrawerScaffold(
    controller: drawerController,
    backgroundColor: AppColors.dark,
    drawers: [
      SideDrawer(
        color: AppColors.accent,
      percentage: 0.85, 
      slide: true,
      alignment: Alignment.topLeft,
      headerView: SearchBox(),
      footerView: DrawerFooter(),
        child: ElvesDrawer(),
      ),
    ],
    
  
    /// 🚀 THIS IS YOUR MAIN UI (UNCHANGED)
    builder: (context, id) {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    /// ☰ MENU (OPENS DRAWER)
                    IconButton(
                      onPressed: () {
                        drawerController.openDrawer();
                      },
                      icon: const Icon(Icons.menu),
                    ),
  
                    SizedBox(width: 5.w),
  
                    Container(
                      padding: EdgeInsets.all(1.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.light, width: 0.9),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star,
                              color: Colors.yellow, size: 2.h),
                          SizedBox(width: 1.w),
                          Text(
                            'Upgrade',
                            style: textTheme.displayLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ), 
  
                    const Spacer(),
  
                  
                  ],
                ),
              ],
            ),
  
            /// INPUT BAR
            Positioned(
              bottom: 10,
              left: 12,
              right: 12,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add,
                        color: AppColors.light, size: 2.5.h),
                  ),
                  SizedBox(width: 2.w),
                  Expanded(
                    child: Container(
                      height: 6.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Ask Elves Anything...',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 1.5.h,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          Icon(Icons.mic,
                              color: Colors.white, size: 2.5.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}}



class HeroButton extends StatelessWidget {
  const HeroButton({super.key, required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.light, width: 0.9),
        ),
        child: Icon(icon, color: AppColors.light, size: 2.h),
      ),
    );
  }
}





class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h, left: 1.h, right: 6.h),
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(40),
         
        ),
        child: Row(
          children: [
             Icon(
              Icons.search,
              color: AppColors.light,
            ),
            
            SizedBox(width: 5.w,),
            Expanded(
              child: TextField(
                decoration:  InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: AppColors.light),
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


class DrawerFooter extends StatelessWidget {
  const DrawerFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final texttheme = Theme.of(context).textTheme;
    return  Padding(
      padding: EdgeInsets.all(1.5.h),
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(Icons.person_3_outlined),
            ),
                
            SizedBox(width: 3.h,),
        
            Text('Ngwu Elvis', style: texttheme.labelMedium,)
          ],
        ),
      ),
    );
  }
}