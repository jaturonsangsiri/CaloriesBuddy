import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:CaloriesBuddy/bloc/theme/theme_bloc.dart';
import 'package:CaloriesBuddy/contants/contants.dart';
import 'package:CaloriesBuddy/widgets/profile/change_profile.dart';
import 'package:CaloriesBuddy/widgets/profile/input.dart';
import 'package:CaloriesBuddy/widgets/system_widget_custom.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();

    return Scaffold(
      appBar: systemwidgetcustom.appBarCustom(context, 'แก้ไขโปรไฟล์', null, null),
      body: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Header Section with Profile Image
                const ChangeProfile(),
                
                // Profile Form Section
                _buildProfileForm(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileForm() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColorDarkTheme,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        border: Border.all(color: const Color(0xFF2C2C2E), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Form title
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              children: [
                Icon(Icons.edit_outlined, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Text('แก้ไขข้อมูล', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white))
              ],
            ),
          ),
          
          // Profile form
          const ProfileForm(),
        ],
      ),
    );
  }
}