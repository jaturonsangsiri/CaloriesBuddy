import 'package:flutter/material.dart';
import 'package:calories_buddy/models/meal/meals.dart';
import 'package:calories_buddy/widgets/icons_style.dart';

class MealBox extends StatelessWidget {
  final Meals meal;
  final VoidCallback? onAddFood;
  
  const MealBox({
    super.key, 
    required this.meal,
    this.onAddFood,
  });

  @override
  Widget build(BuildContext context) {
    final totalCalories = meal.foods!.fold(0, (sum, food) => sum + (food.calories ?? 0).toInt());
    
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Color.fromRGBO(45, 45, 48, 1), // สีเข้มกว่าเดิมสำหรับธีมดำ
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: Color.fromRGBO(42, 46, 48, 1), width: 0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ส่วนหัวของมื้ออาหาร
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                // ไอคอนที่สวยงามขึ้น
                CircleIcon(
                  icon: Icon(meal.icon, color: Colors.white, size: 20),
                  colorbg: Colors.grey.shade800, // สีเข้มขึ้นเล็กน้อย
                  padding: 10,
                  function: () {},
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(meal.name!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white, letterSpacing: 0.3)),
                      const SizedBox(height: 4),
                      // แสดงแคลอรี่ในรูปแบบที่สวยงามขึ้น
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: Color.fromRGBO(60, 60, 60, 0.6), borderRadius: BorderRadius.circular(8), border: Border.all(color: Color.fromRGBO(80, 80, 80, 1),  width: 0.5)),
                        child: Text('$totalCalories แคลอรี่', style: TextTheme.of(context).labelMedium!.copyWith(color: Colors.orange[300], fontWeight: FontWeight.w500))
                      ),
                    ],
                  ),
                ),
                // ปุ่มเพิ่มอาหารที่สวยงามขึ้น
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onAddFood,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[700],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // เพิ่มส่วนแสดงตัวอย่างรายการอาหาร (ถ้ามี)
          if (meal.foods!.isNotEmpty) ...[
            Divider(color: Colors.grey[700], height: 1, thickness: 0.5, indent: 16, endIndent: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Icon(Icons.restaurant, size: 14, color: Colors.grey[400]),
                  SizedBox(width: 6),
                  Text('${meal.foods!.length} รายการ', style: TextTheme.of(context).labelMedium!.copyWith(color: Colors.grey[400])),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4), minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    child: Text('ดูทั้งหมด', style: TextTheme.of(context).labelMedium!.copyWith(color: Colors.blue[300]))
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 16)
        ],
      ),
    );
  }
}