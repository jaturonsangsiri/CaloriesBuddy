import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_cal_track/bloc/food/food_bloc.dart';
import 'package:my_cal_track/models/tag.dart';
import 'package:my_cal_track/widgets/system_widget_custom.dart';

class ListFilter extends StatefulWidget {
  final List<Tag> tags;
  const ListFilter({super.key, required this.tags});

  @override
  State<ListFilter> createState() => _ListFilterState();
}

class _ListFilterState extends State<ListFilter> {
  Systemwidgetcustom systemwidgetcustom = Systemwidgetcustom();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, foodState) {
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for(Tag tg in widget.tags)
              systemwidgetcustom.tagCustom(tg, context, () {
              if (tg.title == 'ทั้งหมด') {
                tg.isPressed = true;
                for (var tg in widget.tags) {
                  if (tg.title != 'ทั้งหมด') {
                    tg.isPressed = false;
                  }
                }
              } else {
                widget.tags[0].isPressed = false;
                tg.isPressed = !tg.isPressed;
                context.read<FoodBloc>().add(FilterFood(
                  showList: tg.title == 'ทั้งหมด' ? foodState.foodList : foodState.foodList.where((food) => food.tags.any((tag) => tag.title == tg.title)).toList(),
                ));
              }
        
              setState(() {});
            })
          ]
        );
      },
    );
  }
}