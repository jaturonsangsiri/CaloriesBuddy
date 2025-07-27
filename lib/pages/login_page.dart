import 'dart:math' as math;

import 'package:calories_buddy/configs/version.dart';
import 'package:calories_buddy/pages/register_page.dart';
import 'package:calories_buddy/widgets/login/input.dart';
import 'package:calories_buddy/widgets/utils/respone.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      // ส่วนหัว
                      Container(
                        height: Responsive.height * 0.30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.lightBlue.shade400,
                              Colors.lightBlue.shade600,
                            ], // เพิ่มสีที่ 2 ให้ gradient
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70, left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'เข้าสู่ระบบ', 
                                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'กรุณาเข้าสู่ระบบเพื่อดำเนินการต่อ', 
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // ฟอร์ม
                      Container(
                        padding: const EdgeInsets.all(25),
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        width: math.min(400, Responsive.width * 0.9),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromRGBO(181, 181, 181, 0.5), 
                              blurRadius: 4, 
                              offset: const Offset(4, 8)
                            ), 
                            BoxShadow(
                              color: const Color.fromRGBO(181, 181, 181, 0.5), 
                              blurRadius: 2, 
                              offset: const Offset(-4, 8)
                            )
                          ],
                        ),
                        child: const LoginForm(), // ตรวจสอบว่า LoginForm() มีอยู่จริง
                      ),

                      const Spacer(), // ดัน footer ไปด้านล่าง
                      
                      // ลิงก์ + เวอร์ชัน
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ยังไม่มีบัญชี?', 
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context, 
                                  MaterialPageRoute(builder: (_) => const RegisterPage())
                                ),
                                child: Text(
                                  ' สร้างบัญชี', 
                                  style: TextStyle(
                                    fontSize: 16, 
                                    color: Colors.grey.shade600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Version: ${Versions.version}', 
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}