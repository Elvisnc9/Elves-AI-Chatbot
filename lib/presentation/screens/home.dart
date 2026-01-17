import 'package:elves_chatbot/presentation/screens/chatScreen.dart';
import 'package:elves_chatbot/presentation/widgets/HomeWidget/AI_sectorsWidget.dart';
import 'package:elves_chatbot/presentation/widgets/HomeWidget/chatModels.dart';
import 'package:elves_chatbot/presentation/widgets/Skeleton/skeletonbox.dart';
import 'package:elves_chatbot/shared/theme.dart';
import 'package:elves_chatbot/state/shellView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(homeStatusProvider);

    return AnimatedSwitcher(
      duration: 300.ms,
      child:   HomeContent(key: ValueKey('content')),
    );
  }
}


class HomeSkeleton extends StatelessWidget {
  const HomeSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SkeletonBox(height: 26, width: 220).shimmer(),
          const SizedBox(height: 20),
          const SkeletonBox(height: 50).shimmer(),
          const SizedBox(height: 30),
          Row(
            children: const [
              Expanded(child: SkeletonBox(height: 120)),
              SizedBox(width: 12),
              Expanded(child: SkeletonBox(height: 120)),
            ].map((e) => e.shimmer()).toList(),
          )
        ],
      ),
    );
  }
}



class HomeContent extends ConsumerStatefulWidget {
const  HomeContent({super.key});

  @override
  ConsumerState<HomeContent> createState() => _HomeContentState();
}
  class _HomeContentState extends ConsumerState<HomeContent> {
 


  final List<ChatModel> ChatList = [
  ChatModel(
    msg: 'What are Some common mistakes to avoid\n when coding a landing Page?'
  ),
  ChatModel(
    msg: 'What are Some common mistakes to avoid\n when coding a landing Page?'
  ),
  ChatModel(
    msg: 'What are Some common mistakes to avoid\n when coding a landing Page?'
  ),
  ChatModel(
    msg: 'What are Some common mistakes to avoid\n when coding a landing Page?'
  ),

];




  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return  Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Padding(
               padding:  EdgeInsets.all(1.h),
               child: Row(
                 children: [
                  HeroButton(icon: Icons.menu, onPressed: (){},).animate().fadeIn().slideX(begin: -0.2),
                   
                   Spacer(),
                   
                   Text(
                     'Elves AI',
                     style: textTheme.displayLarge?.copyWith(
                       fontWeight: FontWeight.bold,
                       fontSize: 16.sp,
                     ),
                   ).animate().fadeIn().slideY(begin: -0.2),
                   
                  const Spacer(),
                   
                   HeroButton(icon: Icons.person, onPressed: (){
                    ref.read(shellViewProvider.notifier).state = ShellView.settings;
                   },).animate().fadeIn().slideX(begin: 0.2),
                 ],
               ).animate().fadeIn(),
             ),
          
             SizedBox(
               height: 5.h,
             ),
          
             
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: Text(
                        'How May I help you \ntoday,  ADAMS?', 
                        style: textTheme.displayLarge?.copyWith(fontSize: 30.sp, )
                      ),
           ).animate().fadeIn().slideX(begin: 0.3),
          
              
          
          
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row (children: [
              Sectors(icon: Icons.chat,
              title: 'Chat\n With AI',
              onPressed: (){},
              height: 26.h,
              width: 47.w,
              color: Color(0xFFADFF2F),
              size: 35.sp,).animate().fadeIn().slideX(begin: 0.3),
          
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                     Sectors(icon: Icons.picture_as_pdf_outlined,
              title: 'Create AI Images',
              onPressed: (){},
              height: 13.h,
              width: 45.w,
              color: Color(0xFFB284BE),
              size: 16.sp,).animate().fadeIn().slideX(begin: 0.2),
                  SizedBox(height: 1.h),
          
                  Sectors(icon: Icons.video_call_rounded,
              title: 'Create AI Videos',
              onPressed: (){},
              height: 13.h,
              width: 45.w,
              color: Color(0xFFF1DDCF),
              size: 16.sp,).animate().fadeIn().slideY(begin: 0.3),
                 
                    ],
                  ),
                )
            ],),
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
            ),
          
          
          
            ],
          ),
        ),

        Positioned(
          bottom: 5,
          right: 10,
          left: 10,
          child:  GestureDetector(
                          onTap: () {
                            ref.read(shellViewProvider.notifier).state = ShellView.chat;
                          },
                           child: Container(
                                           padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 2.5.h),
                                           decoration: BoxDecoration(
                                             color: AppColors.light,
                                             borderRadius: BorderRadius.circular(40),
                                           ),
                                           child: Text(
                                             'Create New Chat',
                                             style: textTheme.labelMedium?.copyWith(
                            color: AppColors.dark,
                            fontWeight: FontWeight.bold,
                                             ),
                                           ),
                                         ),
                         ),)
      ],
    );

  }
}



class RowTitle extends StatelessWidget {
  const RowTitle({
    super.key,
    required this.textTheme, required this.title,
  });

  final TextTheme textTheme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title,
            style: textTheme.displayMedium?.copyWith(fontSize: 25.sp, color: Colors.white, )
          ),
          
          const Spacer(),
          Text(
            ' See All',
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.light.withOpacity(0.7),
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}












