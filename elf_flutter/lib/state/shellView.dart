

import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ShellView {onboarding, home, chat, settings,}

final shellViewProvider =
    StateProvider<ShellView>((ref) => ShellView.onboarding);


enum ViewStatus { skeleton, content }
final homeStatusProvider =
    StateProvider<ViewStatus>((ref) => ViewStatus.skeleton);
