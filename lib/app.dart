import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:CaloriesBuddy/bloc/theme/theme_bloc.dart';
import 'package:CaloriesBuddy/contants/contants.dart';
import 'package:CaloriesBuddy/pages/home_page.dart';
import 'package:CaloriesBuddy/widgets/utils/respone.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // เรียกใช้เช็คขนาดหน้าจอเพื่อปรับ UI ตาม
    Responsive.init(context);
    
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp(
          // ไม่ให้แสดง banner debug สีแดง
          debugShowCheckedModeBanner: false,
          // ปรับให้แอปรองรับภาษาไทย
          locale: const Locale('th', 'TH'),
          // ปรับธีม
          themeMode: themeState.themeApp? ThemeMode.dark : ThemeMode.light, // ให้แอปใช้ธีม Dark Mode
          theme: ThemeData(
            // ธีม Light ที่คุณปรับแต่ง
            appBarTheme: AppBarTheme(backgroundColor: backgroundColorDarkTheme),
            scaffoldBackgroundColor: Colors.grey.shade700,
            canvasColor: Colors.white,
            textTheme: TextTheme(
              headlineLarge: TextStyle(color: Colors.white70),
              titleLarge: TextStyle(color: Colors.white70),
              titleMedium: TextStyle(color: Colors.white70),
              titleSmall: TextStyle(color: Colors.white70),
              labelLarge: TextStyle(color: Colors.white70),
              bodySmall: TextStyle(color: Colors.white70),
              bodyMedium: TextStyle(color: Colors.white70),
              bodyLarge: TextStyle(color: Colors.white70),
            ),
          ),
          darkTheme: ThemeData(
            // ธีม Dark ที่คุณปรับแต่ง
            appBarTheme: AppBarTheme(backgroundColor: Color(0xFF2C2C2E).withValues(alpha: 0.7)),
            // สี DropDown
            canvasColor: greyOne,
            scaffoldBackgroundColor: backgroundColorDarkTheme,
            textTheme: TextTheme(
              headlineLarge: TextStyle(color: Colors.white),
              headlineMedium: TextStyle(color: Colors.white),
              headlineSmall: TextStyle(color: Colors.white),
              titleLarge: TextStyle(color: Colors.white),
              titleMedium: TextStyle(color: Colors.white),
              titleSmall: TextStyle(color: Colors.white70),
              bodyLarge: TextStyle(color: Colors.white70),
              labelLarge: TextStyle(color: Colors.white70),
              bodySmall: TextStyle(color: Colors.white70),
              bodyMedium: TextStyle(color: Colors.white70),
            ),
            // ตั้งค่าความสวยงาม TextFormFild
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: progressColorDarkTheme),
              ),
            ),
          ),
          supportedLocales: const [Locale('th', 'TH'), Locale('en', 'EN')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // ปรับให้การเลือกเวลาเป็น format 24 ชม.
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!, 
            );
          },
          //initialRoute: '/foodDetail',
          //routes: custom_route.Routes.getAll(),
          home: HomePage(),
        );
      },
    );
  }
}