import 'package:elves_chatbot/presentation/screens/chatScreen.dart';
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
    msg: 'Home can i ensure that my agency\'s \nbranding is consistent across all platforms?'
  ),
];

 String activePromptId = '';



  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
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
             
             HeroButton(icon: Icons.person, onPressed: (){},).animate().fadeIn().slideX(begin: 0.2),
           ],
         ).animate().fadeIn(),
       ),

       SizedBox(
         height: 5.h,
       ),
     Padding(
       padding: const EdgeInsets.all(20.0),
       child: Text(
                  'How May I help you \nToday  ADAMS?', 
                  style: textTheme.displayLarge?.copyWith(fontSize: 30.sp, )
                ),
     ).animate().fadeIn().slideX(begin: 0.3),
    
        
    
    
      
    
    
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row (children: [
        Container(
          height: 25.h,
          width: 42.w,
          decoration: BoxDecoration(
            color: Color(0xFF90EE90),
            borderRadius: BorderRadius.circular(25),
          ),),
          

          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
            height: 12.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: Color(0xFFC9A0DC),
              borderRadius: BorderRadius.circular(25),
            ),),
            SizedBox(height: 1.h),
            Container(
            height: 12.h,
            width: 50.w,
            decoration: BoxDecoration(
              color: Color(0xFFF1DDCF),
              borderRadius: BorderRadius.circular(25),
            ),),
              ],
            ),
          )
      ],),
    ),
    
        
    
   

        const SizedBox(height: 10),
     Padding(
       padding: const EdgeInsets.all(8),
       child: Column(
        
         children: [
           RowTitle(textTheme: textTheme, title: 'Recenthly Chats'),
            SizedBox(height: 2.5.h),

            SizedBox(
                    height: 21.h,
                    child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: ChatList.length,
              itemBuilder: (context, index) {
                  return RecentChats(model: ChatList[index]);
              },
                    ),
                  ),

                   GestureDetector(
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
                   ),
           
         ],
       ),
     ),
    


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
    return Row(
      children: [
        Text(
          title,
          style: textTheme.displayMedium?.copyWith(fontSize: 20.sp)
        ),
        
        const Spacer(),
        Text(
          ' See All',
          style: textTheme.labelMedium
        ),
      ],
    );
  }
}











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
    return Padding(
      padding:  EdgeInsets.only(bottom: 15),
      child: Container(
        height: 8.5.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.deepPurple.withOpacity(0.2),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            children: [
              Icon(
                Icons.chat_bubble_outline_rounded,
                color: AppColors.light.withOpacity(0.7),
                size: 25,
              ),
          
              SizedBox(width: 4.w),
          
              Text(
                model.msg,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.light.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.2);
  }
}