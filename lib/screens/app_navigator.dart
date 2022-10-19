import 'package:app_booking/screens/auth/auth_screen.dart';
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
        return BlocProvider(create: (context) => AuthBloc(), child: Navigator(
            pages: [  
              if (state is Init_AuthState)
                // const MaterialPage(child: Text('Unknown')),
              MaterialPage(child: AuthScreen()),
              if (state is Unauthen_AuthState)
                const MaterialPage(child: Text('Unauthenticated')),
              if (state is Authen_AuthState)
                const MaterialPage(child: Text('Authenticated')),
            ],
            onPopPage: ((route, result) => route.didPop(result)),
          ),
        );
      },
    );
  }
}
