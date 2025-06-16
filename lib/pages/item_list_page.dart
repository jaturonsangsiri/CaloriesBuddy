import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cal_track/bloc/food/food_bloc.dart';
import 'package:my_cal_track/models/tag.dart';
import 'package:my_cal_track/pages/food_detail_page.dart';
import 'package:my_cal_track/widgets/food/list_filter.dart';
import 'package:my_cal_track/widgets/system_widget_custom.dart';

class ItemListPage extends StatelessWidget {
  final String title;
  final List<Tag> tags;
  const ItemListPage({super.key, required this.title, required this.tags});

  @override
  Widget build(BuildContext context) {
    Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();

    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, foodState) {
        return Scaffold(
          appBar: systemwidgetcustom.appBarCustom(context, 'รายการ$title', null, null),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('รายการ$title', style: TextTheme.of(context).headlineSmall!.copyWith(color: Colors.white)),
                      const SizedBox(height: 10),
                      ListFilter(tags: tags),
                      const SizedBox(height: 10),
                      foodState.showList.isNotEmpty ? Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(height: 10),
                          padding: EdgeInsets.zero,
                          itemCount: foodState.showList.length,
                          itemBuilder: (context, index) {
                            return systemwidgetcustom.customListTile(
                              context,
                              foodState.showList[index],
                              () => Navigator.push(context, MaterialPageRoute(builder: (context) => FoodDetailPage(food: foodState.showList[index])))
                            );
                          },
                        ),
                      ) : Center(child: Text('ไม่มีข้อมูล')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}