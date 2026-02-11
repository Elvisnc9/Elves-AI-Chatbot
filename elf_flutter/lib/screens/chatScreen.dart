import 'package:drawerbehavior/drawerbehavior.dart';
import 'package:elf_flutter/screens/elvesDrawer.dart';
import 'package:elf_flutter/shared/theme.dart';
import 'package:elf_flutter/state/shellView.dart';
import 'package:elf_flutter/widgets/ChatScreem/DrawerSearchBar.dart';

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
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<ChatMessage> _messages = [];
  final FocusNode _focusNode = FocusNode();

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

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final message = ChatMessage(
      text: text,
      isMe: true,
    );

    _messages.insert(0, message);

    _listKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 280),
    );
  }

  TextTheme get textTheme => Theme.of(context).textTheme;

  @override
  void initState() {
    super.initState();
    drawerController = DrawerScaffoldController();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final theme = Theme.of(context);
    return DrawerScaffold(
      controller: drawerController,
      drawers: [
        SideDrawer(
          color: theme.canvasColor,
          percentage: 0.85,
          degree: 15,
          drawerWidth: 250,
          slide: true,
          animation: true,
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
                          
                          type: MaterialType.transparency,
                          child: GestureDetector(
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();

                              ref.read(shellViewProvider.notifier).state =
                                  ShellView.home;
                            },
                            child: Container(
                              padding: EdgeInsets.all(1.h),
                              decoration: BoxDecoration(
                                color: theme.scaffoldBackgroundColor.withOpacity(0.4),
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
                                    
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Positioned.fill(
                  top: 60, // below header
                  child: _chatList(),
                ),

                Positioned(
                  bottom: 10,
                  left: 12,
                  right: 12,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(2.h),
                        decoration: BoxDecoration(
                          color: theme.canvasColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.add,
                          color: theme.secondaryHeaderColor,
                          size: 2.5.h,
                        ),
                      ),

                      SizedBox(width: 1.w),
                      Expanded(
                        child: AnimatedSize(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          child:
                              Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.h,
                                      vertical: 1.5.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: theme.canvasColor,
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        /// TEXT INPUT
                                        Expanded(
                                          child: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                              maxHeight:
                                                  100, // 🔥 limits growth
                                            ),
                                            child: SingleChildScrollView(
                                              controller: _scrollController,
                                              child: TextField(
                                                controller: _textController,
                                                focusNode: _focusNode,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                textInputAction: TextInputAction
                                                    .newline, // Enter = newline
                                                maxLines: null,
                                                minLines: 1,
                                                onChanged: (_) => _autoScroll(),
                                                style: textTheme.labelMedium,
                                                decoration: InputDecoration(
                                                  hintText:
                                                      'Ask Elves Anything...',
                                                  hintStyle: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: theme.cardColor,
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
                                          onTap: () {
                                            _sendMessage(_textController.text);
                                            _textController.clear();
                                            _focusNode.requestFocus();
                                          },
                                          child:
                                              Container(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    decoration:
                                                        BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: theme.cardColor,
                                                        ),
                                                    child:  Icon(
                                                      Icons.send,
                                                      size: 18,
                                                      color: theme.scaffoldBackgroundColor,
                                                    ),
                                                  )
                                                  .animate() // ✨ Flutter Animate
                                                  .scale(duration: 150.ms)
                                                  .fadeIn(),
                                        ),
                                      ],
                                    ),
                                  )
                                  .animate()
                                  .fadeIn(duration: 250.ms)
                                  .slideY(begin: 0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _chatList() {
    return AnimatedList(
      key: _listKey,
      reverse: true,
      padding: EdgeInsets.only(
        top: 80,
        bottom: MediaQuery.of(context).viewInsets.bottom + 90,
        left: 12,
        right: 12,
      ),
      initialItemCount: _messages.length,
      itemBuilder: (context, index, animation) {
        final message = _messages[index];

        return SlideTransition(
          position: animation.drive(
            Tween(
              begin: const Offset(0, 0.4), // 👈 from keyboard
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeOut)),
          ),
          child: FadeTransition(
            opacity: animation,
            child: _chatBubble(message),
          ),
        );
      },
    );
  }

  Widget _chatBubble(ChatMessage message) {
    final theme = Theme.of(context);
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(maxWidth: 75.w),
        decoration: BoxDecoration(
          color: message.isMe ? theme.canvasColor : AppColors.primary,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Text(
          message.text,
          style: textTheme.displayMedium?.copyWith(
            color: message.isMe ? theme.hintColor : theme.canvasColor,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}

class HeroButton extends StatelessWidget {
  const HeroButton({super.key, required this.onPressed, required this.child});
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(1.h),
        decoration: BoxDecoration(
          color: theme.cardColor.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: child,
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({
    required this.text,
    required this.isMe,
  });
}
