import 'package:elves_chatbot/app/appshell.dart';
import 'package:elves_chatbot/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp( ProviderScope(child: TheResponsiveBuilder(
    builder: (context, orientation, screenType) {
      return MyApp();
    }
  )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Elves AI',
      theme: AppTheme.darkTheme,
      home: const AppShell()
    );
  }
}









//  @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final TextTheme textTheme = Theme.of(context).textTheme;
//     return Padding(
//       padding: const EdgeInsets.all(12),
//       child: Stack(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [

//                   IconButton(onPressed: (){
//                      ref.read(shellViewProvider.notifier).state =
//                           ShellView.home;
//                   }, icon:  Icon( Icons.menu),),

//                   SizedBox(width: 5.w),

//                   Container(
//                     padding: EdgeInsets.all(1.h),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade900,
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(color: AppColors.light, width: 0.9),
//                     ),
//                     child: Row(
//                       children: [
//                         Icon(Icons.star, color: Colors.yellow, size: 2.h),
//                         SizedBox(width: 1.w),
//                         Text(
//                           'Upgrade ',
//                           style: textTheme.displayLarge?.copyWith(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.yellow,
//                             fontSize: 12.sp,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   Spacer(),

//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.h),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade900,
//                       borderRadius: BorderRadius.circular(30),
//                       border: Border.all(color: AppColors.light, width: 0.9),
//                     ),
//                     child: Row(
//                       children: [
//                         Material(
//                           color: Colors.transparent,
//                           child: InkWell(
//                             onTap: (){
//                               ref.read(shellViewProvider.notifier).state =
//                           ShellView.settings;
//                             },
//                             child: Icon(
//                               Icons.person_2_outlined,
//                               color: AppColors.light,
//                               size: 2.7.h,
//                             ),
//                           ),
//                         ),
//                         SizedBox(width: 8.w),
//                         Icon(
//                           Icons.flash_on,
//                           color: AppColors.light,
//                           size: 2.7.h,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ).animate().fadeIn(),

//           Positioned(
//             bottom: 10,
//             left: 12,
//             right: 12,
//             child: Row(
//               children: [
//                 /// ➕ Add button
//                 Container(
//                   padding: EdgeInsets.all(1.h),
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade900,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: AppColors.light, width: 0.9),
//                   ),
//                   child: Icon(Icons.add, color: AppColors.light, size: 2.5.h),
//                 ),

//                 SizedBox(width: 2.w),

//                 /// 💬 TextField Container
//                 Expanded(
//                   child: Container(
//                     height: 6.h,
//                     padding: EdgeInsets.symmetric(horizontal: 3.w),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade900,
//                       borderRadius: BorderRadius.circular(30),
//                       border: Border.all(color: AppColors.light, width: 0.9),
//                     ),
//                     child: Row(
//                       children: [
//                         /// TEXTFIELD (THIS WAS THE MAIN ISSUE)
//                         Expanded(
//                           child: TextField(
//                             decoration: InputDecoration(
//                               hintText: 'Ask Elves Anything...',
//                               hintStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 1.5.h,
//                               ),
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ) ,

//                         SizedBox(width: 2.w),

//                         /// 🎤 Mic button
//                         CircleAvatar(
//                           radius: 18,
//                           backgroundColor: Colors.transparent,
//                           child: Icon(
//                             Icons.mic,
//                             color: Colors.white,
//                             size: 2.5.h,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ).animate().fadeIn().flipH(
//         duration: 400.ms,
//         curve: Curves.easeIn,
//       ),
//         ],
//       ),
//     );
//   }
// }