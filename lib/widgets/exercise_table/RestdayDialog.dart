import 'package:flutter/material.dart';
import 'package:my_cal_track/contants/contants.dart';

class Restdaydialog {
  void showRestDayDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Colors.grey[900]!,Colors.black87]),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10))
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🌙 วันพักผ่อน', textAlign: TextAlign.center, style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white70, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text('ให้ร่างกายได้ฟื้นฟูตัว', textAlign: TextAlign.center, style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(height: 15),
                
                // Content with cards
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.grey[800]!.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey[700]!, width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('กิจกรรมแนะนำสำหรับวันนี้:', style: TextTheme.of(context).titleMedium!.copyWith(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 16),
                      
                      // Activity items
                      _buildActivityItem(context, '🚶‍♂️', 'เดินเล่นเบาๆ', 'ช่วยเพิ่มการไหลเวียนโลหิต'),
                      _buildActivityItem(context, '🧘‍♀️', 'ยืดเส้นยืดสาย', 'ลดความตึงเครียดของกล้ามเนื้อ'),
                      _buildActivityItem(context, '💆‍♂️', 'นวดกล้ามเนื้อ', 'ช่วยให้กล้ามเนื้อผ่อนคลาย'),
                      _buildActivityItem(context, '💧', 'ดื่มน้ำเพียงพอ', 'ช่วยในการฟื้นฟูร่างกาย')
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                
                // Action buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: buttonColor1, shadowColor: Colors.transparent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    child: Text('เข้าใจแล้ว', style: TextTheme.of(context).titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.bold))
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActivityItem(BuildContext context, String emoji, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.grey[700]!.withValues(alpha: 0.5), borderRadius: BorderRadius.circular(10)), child: Center(child: Text(emoji, style: TextTheme.of(context).titleLarge))),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextTheme.of(context).bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(description, style: TextTheme.of(context).labelLarge!.copyWith(color: Colors.grey[400]))
            ],
          ),
        ],
      ),
    );
  }
}