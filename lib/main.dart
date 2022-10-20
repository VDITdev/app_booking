import 'package:flutter/material.dart';
import 'utils/route/router.dart';

void main() async {
  runApp(MyApp(
    router: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter? router;
  const MyApp({
    Key? key,
    this.router,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "VDIT",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router!.generateRoute,
      initialRoute: "/",
    );
  }
}