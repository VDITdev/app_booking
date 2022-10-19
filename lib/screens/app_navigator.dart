import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/auth/auth_bloc.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is Unknown_AuthState)
              const MaterialPage(child: CircularProgressIndicator()),
            if (state is Unauthen_AuthState)
              const MaterialPage(child: Text('Unauthenticated')),
            if (state is Authen_AuthState)
              const MaterialPage(child: Text('Authenticated')),
          ],
          onPopPage: ((route, result) => route.didPop(result)),
        );
      },
    );
  }
}
