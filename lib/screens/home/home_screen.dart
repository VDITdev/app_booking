import 'package:app_booking/screens/home/component/task_group.dart';
import 'package:app_booking/screens/home/widget/dashboard_builder.dart';
import 'package:app_booking/screens/home/widget/drawer_builder.dart';
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
                  DashboardBuilder(),
                ],
              ),
            ),
            drawer: DrawerBuilder(),
          );
        },
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(title: Text(" Dashboard "), actions: [
      IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          BlocProvider.of<HomeBloc>(context).add(SignOut_HomeEvent());
        },
      )
    ]);
  }
}
