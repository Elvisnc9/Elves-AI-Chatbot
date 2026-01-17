import 'package:elves_chatbot/presentation/screens/chatScreen.dart';
import 'package:elves_chatbot/shared/theme.dart';
import 'package:elves_chatbot/state/shellView.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:the_responsive_builder/the_responsive_builder.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key, });

  @override
  ConsumerState<Settings> createState() => _SettingsContentState();
}

class _SettingsContentState extends ConsumerState<Settings> {
  final String? profileImage = null; 

//  String get displayName => widget.user?.displayName ?? 'genie';
//   String get email => widget.user?.email ?? 'genie@mail.com';
//   String? get profileImageUrl => widget.user?.photoURL;

  int appearanceIndex = 0;
  bool generateVideosForImages = false;
  bool autoplayVideosInFeed = false;
  bool hapticsOnButtons = false;
  bool hapticsOnResponse = false;

  // Example social icon list (empty by default)
  final List<String> socialIconAssetPaths = [];

  @override
  Widget build(BuildContext context) {
    final Texttheme = Theme.of(context).textTheme;
    return  ListView(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal:2.5.h),
        children: [

          Align(
            alignment: Alignment.topLeft,
            child: HeroButton(
                      icon: Icons.arrow_back,
                      onPressed: () {
                        ref.read(shellViewProvider.notifier).state =
                            ShellView.home;
                      },
                    ),
          ),

          SizedBox(height: 18),
          // --- Profile header (added) ---
          _buildProfileHeader(),

          SizedBox(height: 18),

          // Subscription header & tile (as in your screenshot)
          sectionHeader('Subscription'),
          SizedBox(height: 12),
          _subscriptionTile(),

          SizedBox(height: 4.h),

          // Appearance section
          sectionHeader('Appearance'),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              _appearanceChip(label: 'System', index: 0, icon: Icons.tune),
              _appearanceChip(label: 'Dark', index: 2, icon: Icons.nightlight_round),
              _appearanceChip(label: 'Light', index: 3, icon: Icons.wb_sunny_outlined),
            ],
          ),
          SizedBox(height: 6.h),

          // Haptics & Vibration
          sectionHeader('Haptics & Vibration'),
          SizedBox(height: 2.h),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('When pressing buttons',style: Texttheme.labelMedium?.copyWith(color: Colors.white),),
            value: hapticsOnButtons,
            onChanged: (v) => setState(() => hapticsOnButtons = v),
            secondary: Icon(Icons.touch_app_outlined, color: AppColors.light,),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  // Thumb (knob) color when ON
  activeColor: Colors.white,
  // Track color when ON
  activeTrackColor: AppColors.dark.withOpacity(0.68),
  // Thumb color when OFF
  inactiveThumbColor: Colors.grey.shade700,
  // Track color when OFF
  inactiveTrackColor: Colors.white,
          ),
          SwitchListTile(
  contentPadding: EdgeInsets.zero,
  title: Text(
    'When Genie is responding',
    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white),
  ),
  value: hapticsOnResponse,
  onChanged: (v) => setState(() => hapticsOnResponse = v),
  secondary: Icon(Icons.smart_toy_outlined, color: AppColors.light),
  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  // Thumb (knob) color when ON
  activeColor: Colors.white,
  // Track color when ON
  activeTrackColor: AppColors.dark.withOpacity(0.68),
  // Thumb color when OFF
  inactiveThumbColor: Colors.grey.shade700,
  // Track color when OFF
  inactiveTrackColor: Colors.white,
),

          SizedBox(height: 4.h),

          // Data & Information section
          sectionHeader('Data & Information'),
          SizedBox(height: 8),
          _navigationTile(icon: Icons.tune, text: 'Customize Genie', onTap: () {}),
          _navigationTile(icon: Icons.storage, text: 'Data Controls', onTap: () {}),
          _navigationTile(icon: Icons.privacy_tip_outlined, text: 'Privacy Policy', onTap: () {}),
          SizedBox(height: 4.h),

          

          // Other actions: Report Issue, Log out
          _navigationTile(icon: Icons.report_problem_outlined, text: 'Report Issue', onTap: () {}),
          SizedBox(height: 3.h),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.redAccent),
            title: Text('Log out', style: TextStyle(color: Colors.redAccent)),
            onTap: () {},
          ),

          SizedBox(height: 4.h),

          // Optional row of social icons (example - see notes below)
          // Footer
          Column(
            children: [
              SizedBox(height: 12),
              SizedBox(height: 8),
              Text(
                'Genie Android 1.0.78-release.01',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ],
      
    );
  }

  // ----- Profile header widget -----
  Widget _buildProfileHeader() {
    final Texttheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Center-aligned avatar, name and email
        Center(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: Colors.grey[850],
                    child: ClipOval(
                      child: SizedBox(
                        width: 104,
                        height: 104,
                        child: _buildProfileImage(),
                      ),
                    ),
                  ),

                  // Edit icon positioned bottom-right of avatar
                  Positioned(
                    right: -4,
                    bottom: -4,
                    child: GestureDetector(
                      onTap: () {
                        // open image picker or edit profile action
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Edit profile tapped')),
                        );
                      },
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.grey[850],
                        child: Icon(Icons.edit, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'displayName',
                style:  Texttheme.labelMedium,
              ),
              SizedBox(height: 6),
              Text(
                'email',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  letterSpacing: 1.0,
                  // use monospace look without requiring a special font:
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    // If you have an asset path set profileImage to that asset path
    // and use Image.asset(profileImage!)
    if (profileImage == null) {
      // Placeholder decorated circle (like your screenshot's dark avatar)
      return Container(
        color: Colors.transparent,
        child: Center(
          child: Icon(Icons.person, size: 48, color: Colors.grey[700]),
        ),
      );
    } else if (profileImage!.startsWith('http')) {
      return Image.network(profileImage!, fit: BoxFit.cover, errorBuilder: (_, __, ___) {
        return Center(child: Icon(Icons.person, size: 48, color: Colors.grey[700]));
      });
    } else {
      return Image.asset(profileImage!, fit: BoxFit.cover);
    }
  }

  Widget sectionHeader(String text) {
    final Texttheme = Theme.of(context).textTheme;
    return Text(
      text,
      style: Texttheme.labelLarge
    );
  }

  Widget _appearanceChip({required String label, required int index, IconData? icon}) {
    final bool selected = appearanceIndex == index;
    return ChoiceChip(
      avatar: icon != null ? Icon(icon, size: 18, color: selected ? Colors.black : Colors.white) : null,
      label: Text(label),
      selected: selected,
      onSelected: (_) => setState(() => appearanceIndex = index),
      selectedColor: Colors.white,
      backgroundColor: Colors.black,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      labelStyle: TextStyle(color: selected ? Colors.black : Colors.white , fontSize: 16.sp ),
      elevation: 0,
      side: selected ? BorderSide.none : BorderSide(color: Colors.black),
    );
  }

  Widget _navigationTile({required IconData icon, required String text, VoidCallback? onTap}) {
    final Texttheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0.2.h, vertical: 0.7.h),
      leading: Icon(icon, color: Colors.white,),
      title: Text(text, style: Texttheme.labelMedium?.copyWith(color: Colors.white),),
      trailing: Icon(Icons.chevron_right, color: Colors.white,),
      onTap: onTap,
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    final Texttheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.white,),
      title: Text(title,style: Texttheme.labelMedium?.copyWith(color: Colors.white),),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.white,
  // Track color when ON
  activeTrackColor: AppColors.dark.withOpacity(0.68),
  // Thumb color when OFF
  inactiveThumbColor: Colors.grey.shade700,
  // Track color when OFF
  inactiveTrackColor: Colors.white,
      ),
      onTap: () => onChanged(!value),
    );
  }

  Widget _subscriptionTile() {
    final Texttheme = Theme.of(context).textTheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.shield, color: Colors.yellow,),
      ),
      title: Text('Upgrade to SuperGenie', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      onTap: () {
        // open subscription flow
      },
    );
  }
}