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
          return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: Icon(CupertinoIcons.option),
        trailing: _topRight(context),
        middle: Text('Dashboard'),
      ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DashboardScreen(),
                  ],
                ),
              ),
            ),
            // drawer: DrawerMenu(),
          );
        },
      ),
    );
  }

  Widget _topRight(BuildContext context) {
      return CupertinoButton(
        child: Icon(Icons.logout),
        onPressed: () {
          BlocProvider.of<HomeBloc>(context).add(SignOut_HomeEvent());
        },
      );
  }
}
