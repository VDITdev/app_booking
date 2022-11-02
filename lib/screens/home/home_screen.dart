import 'package:app_booking/screens/dashboard/component/task_group.dart';
import 'package:app_booking/screens/dashboard/dashboard_screen.dart';
import 'package:app_booking/screens/drawer/drawer_menu.dart';
import 'package:app_booking/src/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
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
            appBar: CupertinoNavigationBar(
              leading: _topLeft(),
              trailing: _topRight(),
              middle: Text('Dashboard'),
            ),
            body: const SingleChildScrollView(
              padding: EdgeInsets.all(10.0),
              child: DashboardScreen(),
            ),
            drawer: DrawerMenu(),
          );
        },
      ),
    );
  }

  Widget _topRight() {
    return Builder(builder: (context) {
      return CupertinoButton(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.zero,
        child: const Icon(
          Icons.logout,
          size: 30,
        ),
        onPressed: () {
          BlocProvider.of<HomeBloc>(context).add(SignOut_HomeEvent());
        },
      );
    });
  }

  Widget _topLeft() {
    return Builder(
      builder: (context) {
        return CupertinoButton(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.zero,
          child: Icon(
            Icons.menu,
            size: 30,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    );
  }
}
