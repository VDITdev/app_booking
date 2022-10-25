import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:app_booking/src/home/home_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // @override
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
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("In Progress...", style: TextStyle(fontSize: 20)),
                SizedBox(height: 30),
                LinearProgressIndicator(),
              ],
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

      actions: [IconButton(icon: Icon(Icons.logout),onPressed: () {
        BlocProvider.of<HomeBloc>(context).add(SignOut_HomeEvent());
      })]
    );
  }
}
