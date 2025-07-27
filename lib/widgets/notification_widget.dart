import 'package:calories_buddy/bloc/theme/theme_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calories_buddy/widgets/utils/respone.dart';

class NotificationWidget {
  // ฟังก์ชั่น Widget ของการแจ้งเตือน
  Widget buildNotificationWidget(BuildContext context, String title, String subtitle, String time, String date, Widget? icon) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        Color textColor = themeState.themeApp ? Colors.white : Colors.black87;
        return SizedBox(
          height: Responsive().isTablet ? 80 : 60,
          child: ListTile(
            leading: icon,
            title: Text(title, style: Responsive().isTablet ? TextTheme.of(context).titleLarge!.copyWith(color: textColor) : TextTheme.of(context).bodyMedium!.copyWith(color: textColor)),
            subtitle: Text(subtitle, style: Responsive().isTablet ? TextTheme.of(context).titleMedium!.copyWith(color: textColor) : TextTheme.of(context).bodySmall!.copyWith(color: textColor)),
            trailing: Column(children: [Text(time, style: Responsive().isTablet ? TextTheme.of(context).titleMedium!.copyWith(color: textColor) : TextTheme.of(context).bodySmall!.copyWith(color: textColor)), Text(date, style: Responsive().isTablet ? TextTheme.of(context).titleMedium!.copyWith(color: textColor) : TextTheme.of(context).bodySmall!.copyWith(color: textColor))])
          ),
        );
      },
    );
  }
}