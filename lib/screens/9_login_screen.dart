import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gorouter/layout/default_layout.dart';
import 'package:gorouter/route/router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                authState = !authState;
              });
            },
            child: Text(authState ? 'logout' : 'login'),
          ),
          ElevatedButton(
            onPressed: () {
              if(GoRouterState.of(context).location == '/login'){
                context.go('/login/private');
              }else{
                context.go('/login2/private');
              }
            },
            child: Text('Go to private'),
          )
        ],
      ),
    );
  }
}
