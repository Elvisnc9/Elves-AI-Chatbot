import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:elves_chatbot/shared/theme.dart';
import 'package:elves_chatbot/state/shellView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
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
    drawers: [
      SideDrawer(
        color: AppColors.dark,
        percentage: 0.8, // 👈 how much screen it pushes
        child: Container(   
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chats',
                style: textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                 height: MediaQuery.of(context).size.height * 0.7,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (_, i) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Text(
                      'Previous chat ${i + 1}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
  
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 1.2.h, vertical: 0.7.h),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade900,
                        borderRadius: BorderRadius.circular(30),
                        border:
                            Border.all(color: AppColors.light, width: 0.9),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person_3_outlined,
                              color: AppColors.light, size: 2.7.h),
                          SizedBox(width: 8.w),
                          Icon(Icons.flash_on,
                              color: AppColors.light, size: 2.7.h),
                        ],
                      ),
                    ),
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
                    padding: EdgeInsets.all(1.h),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.light, width: 0.9),
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
                        border:
                            Border.all(color: AppColors.light, width: 0.9),
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



class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 4.w),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 1.8.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ShellDrawer extends ConsumerWidget {
 ShellDrawer({super.key});
final drawerOpenProvider = StateProvider<bool>((ref) => false);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 70.w,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Elves',
              style: textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 4.h),

            _DrawerItem(
              icon: Icons.home,
              title: 'Home',
              onTap: () {
                ref.read(shellViewProvider.notifier).state = ShellView.home;
                ref.read(drawerOpenProvider.notifier).state = false;
              },
            ),

            _DrawerItem(
              icon: Icons.settings,
              title: 'Settings',
              onTap: () {
                ref.read(shellViewProvider.notifier).state = ShellView.settings;
                ref.read(drawerOpenProvider.notifier).state = false;
              },
            ),

            _DrawerItem(
              icon: Icons.star,
              title: 'Upgrade',
              onTap: () {},
            ),

            const Spacer(),

            _DrawerItem(
              icon: Icons.logout,
              title: 'Logout',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
