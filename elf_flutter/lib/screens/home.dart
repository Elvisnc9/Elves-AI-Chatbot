import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

import 'package:elf_flutter/widgets/HomeWidget/AI_sectorsWidget.dart';
import 'package:elf_flutter/widgets/HomeWidget/chatModels.dart';
import 'package:elf_flutter/shared/theme.dart';
import 'package:elf_flutter/state/auth_state.dart';
import 'package:elf_flutter/state/shellView.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   // final status = ref.watch(homeStatusProvider);
    return AnimatedSwitcher(
      duration: 300.ms,
      child: HomeContent(key: ValueKey('content')),
    );
  }
}




// class HomeSkeleton extends StatelessWidget {
//   const HomeSkeleton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SkeletonBox(height: 26, width: 220).shimmer(),
//           const SizedBox(height: 20),
//           const SkeletonBox(height: 50).shimmer(),
//           const SizedBox(height: 30),
//           Row(
//             children:
//                 const [
//                   Expanded(child: SkeletonBox(height: 120)),
//                   SizedBox(width: 12),
//                   Expanded(child: SkeletonBox(height: 120)),
//                 ].map((e) => e.shimmer()).toList(),
//           ),
//         ],
//       ),
//     );
//   }
// }

class HomeContent extends ConsumerStatefulWidget {
  const HomeContent({super.key});

  @override
  ConsumerState<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<HomeContent> {

  final List<ChatModel> ChatList = [
    ChatModel(
      msg:
          'What are Some common mistakes to avoid\n when coding a landing Page?',
    ),
    ChatModel(
      msg:
          'What are Some common mistakes to avoid\n when coding a landing Page?',
    ),
    ChatModel(
      msg:
          'What are Some common mistakes to avoid\n when coding a landing Page?',
    ),
    ChatModel(
      msg:
          'What are Some common mistakes to avoid\n when coding a landing Page?',
    ),
    ChatModel(
      msg:
          'What are Some common mistakes to avoid\n when coding a landing Page?',
    ),
    ChatModel(
      msg:
          'What are Some common mistakes to avoid\n when coding a landing Page?',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final authState = ref.watch(authControllerProvider);
    final authNotifier = ref.read(authControllerProvider.notifier);


    ImageProvider avatar;
   
      avatar = const AssetImage('assets/google_Logo.png');
    
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(1.h),
                child:
                    Row(
                      children: [
                       
                      Spacer(),

                        Text(
                          'Elves AI',
                          style: textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ).animate().fadeIn().slideY(begin: -0.2),

                        const Spacer(),

                        
                        ProfileImageButton(
                          image: authState.userProfile?.imageUrl != null
                              ? NetworkImage(authState.userProfile!.imageUrl.toString())
                              : const AssetImage('assets/google_Logo.png'),
                          onPressed: () {
                            ref.read(shellViewProvider.notifier).state =
                                ShellView.settings;
                          },
                        ).animate().fadeIn().slideX(begin: 0.2),
                      ],
                    ).animate().fadeIn(),
              ),

              SizedBox(height: 6.h),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'How May I help you \ntoday,  ADAMS?',
                  style: textTheme.displayLarge?.copyWith(fontSize: 30.sp),
                ),
              ).animate().fadeIn().slideX(begin: 0.3),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Sectors(
                      icon: Icons.chat,
                      textColor: AppColors.dark,
                      title: 'Chat\n With AI',
                      onPressed: () {
                          ref.read(shellViewProvider.notifier).state = ShellView.chat;
                      },
                      height: 26.h,
                      width: 47.w,
                      color: Color(0xFFADFF2F),
                      
                      size: 35.sp,
                    ).animate().fadeIn().slideX(begin: -0.3 ,delay: 200.ms ),

                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Sectors(
                            icon: Icons.image,
                            title: 'Create AI Images',
                            onPressed: () {},
                            height: 13.h,
                            width: 45.w,
                             textColor: AppColors.light,
                            color: AppColors.primary,
                            size: 16.sp,
                          ).animate().fadeIn().slideY(begin: -0.3, delay: 200.ms),
                          SizedBox(height: 1.h),

                          Sectors(
                            icon: Icons.video_call_rounded,
                            title: 'Create AI Videos',
                            onPressed: () {},
                            height: 13.h,
                            width: 45.w,
                            color: Color(0xFFF1DDCF),
                            size: 16.sp,
                          ).animate().fadeIn().slideY(begin: 0.3, delay: 200.ms),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              const SizedBox(height: 10),
              RowTitle(textTheme: textTheme, title: 'Popular Prompts'),
              SizedBox(height: 2.5.h),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: ChatList.length,
                itemBuilder: (context, index) {
                  return RecentChats(model: ChatList[index]);
                },

                
              ),SizedBox(height: 8.h)
            ],
          ),
        ),

        Positioned(
          bottom: 5,
          right: 10,
          left: 10,
          child: GestureDetector(
            onTap: () {
              ref.read(shellViewProvider.notifier).state = ShellView.chat;
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 2.5.h),
              decoration: BoxDecoration(
                color: AppColors.light,
                borderRadius: BorderRadius.circular(40),
                 gradient: const LinearGradient(
            colors: [Colors.white, Colors.white12],
          ),
              ),
              child: Text(
                'Create New Chat',
                style: textTheme.labelMedium?.copyWith(
                  color: AppColors.dark,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}





class RowTitle extends StatelessWidget {
  const RowTitle({super.key, required this.textTheme, required this.title});

  final TextTheme textTheme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0.5.h),
      child: Row(
        children: [
          Text(
            title,
            style: textTheme.displayMedium?.copyWith(
              fontSize: 25.sp
            ),
          ),

          const Spacer(),
          Text(
            ' See All',
            style: textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}




class ProfileImageButton extends StatelessWidget {
  const ProfileImageButton({super.key, required this.onPressed, required this.image});
   final VoidCallback onPressed;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(1.5.h),
          decoration: BoxDecoration(
            color: theme.cardColor.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.light, width: 0.9),
          ),
          child: Image(image: image, width: 10, fit: BoxFit.contain,)
        ),
      ),
    ); 
  }
}