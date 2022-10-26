import 'package:app_booking/screens/home/widget/task_group.dart';
import 'package:app_booking/src/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return _homeBuilder();
  }

  Widget _homeBuilder() {
    return BlocProvider(
      create: (context) => HomeBloc()..add(Init_HomeEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: _appBar(context),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildGrid(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
        title: Text("HOME"),
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),

        // actions: const [SignOutButton()],

        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(SignOut_HomeEvent());
              })
        ]);
  }

  // Widget _container() {
  //   return Container(
  //     height: 200,
  //     margin: const EdgeInsets.all(10.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(8.0),
  //       color: Colors.lightBlue[300],
  //     ),
  //   );
  // }

  Widget buildGrid() {
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
            taskGroup: "Frame1",
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
            taskGroup: "Frame2",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.4,
          child: TaskGroupContainer(
            color: Colors.green,
            icon: Icons.article,
            taskCount: 2,
            taskGroup: "Frame4",
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
            taskGroup: "Frame5",
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
