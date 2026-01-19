import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:elves_chatbot/presentation/screens/elvesDrawer.dart';
import 'package:elves_chatbot/shared/theme.dart';
import 'package:elves_chatbot/state/shellView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
          color: Colors.grey.shade900,
          percentage: 0.95,
          degree: 15,
          drawerWidth: 250,
          slide: true,
          alignment: Alignment.topLeft,
          headerView: SearchBox(),
          footerView: DrawerFooter(),
          child: ElvesDrawer(),
        ),
      ],

      /// 🚀 THIS IS YOUR MAIN UI (UNCHANGED)
      builder: (context, id) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapDown: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
            drawerController.closeDrawer();
          },

          child: Padding(
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
                            FocusManager.instance.primaryFocus?.unfocus();
                            drawerController.openDrawer();
                          },
                          icon: const Icon(Icons.menu),
                        ),

                        SizedBox(width: 5.w),

                        Material(
                          child: GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                             
              ref.read(shellViewProvider.notifier).state = ShellView.home;
            
                            },
                            child: Container(
                              padding: EdgeInsets.all(1.h),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade900,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 2.h,
                                  ),
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
                          ),
                        ),

                        const Spacer(),
                      ],
                    ),
                  ],
                ),

                Positioned(
                  bottom: 10,
                  left: 12,
                  right: 12,
                  child: ChatInputField(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

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
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h, left: 1.h, right: 2.h),
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.light),

            SizedBox(width: 5.w),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                minLines: 1,
                style: textTheme.labelMedium,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.light,
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

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField>
    with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _autoScroll() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    // 🔥 Send logic here
    print(_controller.text);

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final texttheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.add, color: AppColors.light, size: 2.5.h),
        ),

        SizedBox(width: 1.w),
        Expanded(
          child: AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// TEXT INPUT
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 100, // 🔥 limits growth
                      ),
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.multiline,
                          textInputAction:
                              TextInputAction.newline, // Enter = newline
                          maxLines: null,
                          minLines: 1,
                          onChanged: (_) => _autoScroll(),
                          style: texttheme.labelMedium,
                          decoration: InputDecoration(
                            hintText: 'Ask Elves Anything...',
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.light.withOpacity(0.5),
                            ),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 2.w),

                  /// SEND BUTTON
                  GestureDetector(
                    onTap: _sendMessage,
                    child:
                        Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.send,
                                size: 18,
                                color: Colors.black,
                              ),
                            )
                            .animate() // ✨ Flutter Animate
                            .scale(duration: 150.ms)
                            .fadeIn(),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 250.ms).slideY(begin: 0.2),
          ),
        ),
      ],
    );
  }
}

class DrawerFooter extends ConsumerWidget {
  const DrawerFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final texttheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        enableFeedback: false,
        onTap: () {
          ref.read(shellViewProvider.notifier).state = ShellView.settings;
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
          child: Container(
            color: Colors.transparent,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.dark,
                  child: Icon(Icons.person_3_outlined),
                ),

                SizedBox(width: 3.h),

                Text('Ngwu Elvis', style: texttheme.labelMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
