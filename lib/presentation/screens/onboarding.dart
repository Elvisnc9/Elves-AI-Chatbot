import 'dart:async';

import 'package:elves_chatbot/shared/theme.dart';
import 'package:elves_chatbot/state/shellView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
   const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late PageController _pageController;
  int currentPage = 0;
  late Timer _autoScrollTimer;


@override
void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page?.round() ?? 0;
      });
    });
    _startAutoScroll();
  }

void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        int nextPage = (currentPage + 1) % 4; // 4 is the number of pages
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }
  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
  //  final textTheme = Theme.of(context).textTheme;
   final pages = [
    PageSlider(
      Title: ' Evolving Intelligence',
      Title2: 'Built Simply',
      Title3: 'Powered AI',
      Subtext: 'Fast, adaptive intelligence designed to\n work naturally for you.',
    ),
    PageSlider(
      Title: 'Brain AI',
      Title2: 'Get Answers',
      Title3: 'Smart Support',
      Subtext: 'Get intelligent help anytime you need it.',
    ),
    PageSlider(
      Title: 'Work Smarter',
      Title2: 'Less Effort',
      Title3: 'Better Effort',
      Subtext: 'Natural conversations\n powered by intelligent understanding.',
    ),
    PageSlider(
      Title: 'Create Faster',
      Title2: 'Think Bigger',
      Title3: 'AI Powered',
      Subtext: 'Let AI handle tasks\n while you focus on what matters.',
    ),
   ];

    return Column(
      children: [
        const Spacer(),

        /// IMAGE (Hero)
        Icon(Icons.four_g_plus_mobiledata, size: 200,)
            .animate()
            .fadeIn(duration: 800.ms)
            .scale(begin: const Offset(0.85, 0.85))
            .shimmer(delay: 1200.ms),

         SizedBox(height: 22.h),

        /// TEXT
        SizedBox(
height: 30.h,
child: PageView.builder(
            controller: _pageController,
            itemCount: pages.length,
            itemBuilder: (context, idx) => PageSlider(
              Title: pages[idx].Title,
              Title2: pages[idx].Title2,
              Title3: pages[idx].Title3,
              Subtext: pages[idx].Subtext,
            ),
          ),
        ),

        
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pages.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 0.5.w),
              width: currentPage == index ? 3.w : 2.w,
              height: 0.8.h,
              decoration: BoxDecoration(
                color: currentPage == index
                    ? AppColors.light
                    : Colors.grey.shade700,
                borderRadius: BorderRadius.circular(10),
              ),
            ).animate().fadeIn(),
          ),
        ),

       

        const Spacer(),
  
        
        AnimatedGoogleButton(
          onTap: () {
             ref.read(shellViewProvider.notifier).state = ShellView.home;
          },
        ),
        
        const SizedBox(height: 14),
        
        Text(
          "By logging in you accept our privacy policy",
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.5),
          ),
        ).animate().fadeIn(delay: 1400.ms),
        
        const SizedBox(height: 20),
      ],
    );
  }
}

class PageSlider extends StatelessWidget {
  const PageSlider({
    super.key, required this.Title, required this.Title2, required this.Title3, required this.Subtext,
  });

  final String Title;
  final String Title2;
  final String Title3;
  final String Subtext;


  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        AnimatedTextReveal(
          text: Title,
          size: 35.sp, color: AppColors.light,
          weight: FontWeight.w800,
        ),
        
        GlowShader(
          child: AnimatedTextReveal(
            text: Title2,
            delay: 300.ms, size: 50.sp, color:  AppColors.primary,
            weight: FontWeight.bold,
          ),
        ),
        
          AnimatedTextReveal(
          text: Title3,
          delay: 500.ms, size: 40.sp, color:  AppColors.light,
           weight: FontWeight.w800,
        ),

         const SizedBox(height: 16),

        Text(
          Subtext,
          textAlign: TextAlign.center,
          style: textTheme.labelMedium?.copyWith(
            height: 1.7, fontWeight: FontWeight.w100,
            fontSize: 12.sp,
             color: AppColors.light.withOpacity(0.5))
        )
            .animate()
            .fadeIn(delay: 1.seconds)
            .slideY(begin: 0.4),
      ],
    );
  }
}




class AnimatedGoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  const AnimatedGoogleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        margin: const EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF8E2DE2),
              Color(0xFF4A00E0),
            ],
          ),
        ),
        child: const Center(
          child: Text(
            "Login with Google",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      )
          .animate()
          .slideY(begin: 0.6, delay: 1200.ms)
          .fadeIn()
          .scaleXY(begin: 0.9, end: 1, curve: Curves.easeOutBack)
          .then()
          .shimmer(duration: 1500.ms),
    );
  }
}

class AnimatedTextReveal extends StatelessWidget {
  final String text;
  final Duration delay;
  final double size;
  final Color color;
  final FontWeight weight;

  const AnimatedTextReveal({
    super.key,
    required this.text,
    this.delay = Duration.zero, required this.size, required this.color,
    required this.weight
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(
        text.length,
        (index) => Text(
          text[index],
          
          style: textTheme.displayLarge?.copyWith(
            fontSize: size, color: color,height: 1.3, fontWeight: weight),
        )
            .animate()
            .fadeIn(
              delay: delay + (100.ms * index),
              duration: 300.ms,
            )
            .slideX(begin: 0.9),
      ),
    );
  }
}
class AnimatedGradientBackground extends StatelessWidget {
  const AnimatedGradientBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0B0818),
                  Color(0xFF1A0E2A),
                  Color(0xFF2A0F3D),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          )
              .animate(onPlay: (c) => c.repeat())
              .scale(
                duration: 20.seconds,
                begin: const Offset(1, 1),
                end: const Offset(1.2, 1.2),
              ),
        ),
        child,
      ],
    );
  }
}







class GlowShader extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final Duration duration;

  const GlowShader({
    super.key,
    required this.child,
    this.colors = const [AppColors.light, AppColors.primary, AppColors.accent,
      
      
      
    ],
    this.duration = const Duration(seconds: 4),
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcATop,
      child: child
          .animate(onPlay: (c) => c.repeat())
          .shimmer(duration: duration),
    );
  }
}
