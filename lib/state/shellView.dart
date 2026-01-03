import 'package:flutter_riverpod/legacy.dart';

enum ShellView { home, chat }

final shellViewProvider =
    StateProvider<ShellView>((ref) => ShellView.home);


enum ViewStatus { skeleton, content }
final homeStatusProvider =
    StateProvider<ViewStatus>((ref) => ViewStatus.skeleton);
