import 'package:app_booking/screens/home/component/task_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DashboardBuilder extends StatelessWidget {
  const DashboardBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: const [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.2,
          child: TaskGroupContainer(
            color: Colors.pink,
            icon: Icons.menu_book_rounded,
            taskCount: 10,
            taskGroup: "Upcoming",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: TaskGroupContainer(
            color: Colors.orange,
            isSmall: true,
            icon: Icons.star,
            taskCount: 5,
            taskGroup: "Reviews",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.4,
          child: TaskGroupContainer(
            color: Colors.green,
            icon: Icons.article,
            taskCount: 2,
            taskGroup: "Task",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.1,
          child: TaskGroupContainer(
            color: Colors.blue,
            isSmall: true,
            icon: Icons.single_bed_sharp,
            taskCount: 9,
            taskGroup: "Frame3",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.1,
          child: TaskGroupContainer(
            color: Colors.purple,
            isSmall: true,
            icon: Icons.people,
            taskCount: 9,
            taskGroup: "Clients",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: TaskGroupContainer(
            color: Colors.indigo,
            isSmall: true,
            icon: Icons.mobile_friendly,
            taskCount: 9,
            taskGroup: "Frame6",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: TaskGroupContainer(
            color: Colors.blueGrey,
            isSmall: true,
            icon: Icons.settings,
            taskCount: 9,
            taskGroup: "Frame7",
          ),
        ),
      ],
    );
  }
}
